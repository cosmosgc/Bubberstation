GLOBAL_LIST_INIT(guardian_radial_images, setup_guardian_radial())

/proc/setup_guardian_radial()
	. = list()
	for(var/mob/living/basic/guardian/guardian_path as anything in subtypesof(/mob/living/basic/guardian))
		var/datum/radial_menu_choice/option = new()
		option.name = initial(guardian_path.creator_name)
		option.image = image(icon = 'icons/hud/guardian.dmi', icon_state = initial(guardian_path.creator_icon))
		option.info = span_boldnotice(initial(guardian_path.creator_desc))
		.[guardian_path] = option

/// An item which grants you your very own soul buddy
/obj/item/guardian_creator
	name = "enchanted deck of tarot cards"
	desc = "Um baralho encantado de cartas de tarô, rumores de ser uma fonte de poder inimaginável."
	icon = 'icons/obj/toys/playing_cards.dmi'
	icon_state = "deck_tarot_full"
	/// Are we used or in the process of being used? If yes, then we can't be used.
	var/used = FALSE
	/// The visuals we give to the guardian we spawn.
	var/theme = GUARDIAN_THEME_MAGIC
	/// The name of the guardian, for UI/message stuff.
	var/mob_name = "Guardian Spirit"
	/// Message sent when you use it.
	var/use_message = span_holoparasite("Você embaralha o baralho...")
	/// Message sent when it's already used.
	var/used_message = span_holoparasite("Todas as cartas parecem estar em branco agora.")
	/// Examine description if the creator is unused
	var/unused_description = span_holoparasite("Você se sente acenado para desenhar um...")
	/// Examine description if the creator is used.
	var/used_description = span_holoparasite("Parecem desinteressantes.")
	/// Failure message if no ghost picks the holopara.
	var/failure_message = span_boldholoparasite("E tire uma carta! Está em branco? Talvez devesse tentar de novo mais tarde.")
	/// Failure message if we don't allow lings.
	var/ling_failure = span_boldholoparasite("O convés se recusa a responder a uma criatura sem alma como você.")
	/// Message sent if we successfully get a guardian.
	var/success_message = span_holoparasite("<b>GUARDIÃO</b>Foi convocado!")
	/// If true, you are given a random guardian rather than picking from a selection.
	var/random = FALSE
	/// If true, you can have multiple guardians at the same time.
	var/allow_multiple = FALSE
	/// If true, lings can get guardians from this.
	var/allow_changeling = TRUE
	/// If true, a dextrous guardian can get their own guardian, infinite chain!
	var/allow_guardian = FALSE
	/// List of all the guardians this type can spawn.
	var/list/possible_guardians = list( //default, has everything but dextrous
		/mob/living/basic/guardian/assassin,
		/mob/living/basic/guardian/charger,
		/mob/living/basic/guardian/explosive,
		/mob/living/basic/guardian/gaseous,
		/mob/living/basic/guardian/gravitokinetic,
		/mob/living/basic/guardian/lightning,
		/mob/living/basic/guardian/protector,
		/mob/living/basic/guardian/ranged,
		/mob/living/basic/guardian/standard,
		/mob/living/basic/guardian/support,
	)
	/// Have we been refunded? Used to prevent guardians from being created after we've been refunded
	/// while avoiding scamming people if they use and then destroy us
	var/was_refunded = FALSE

/obj/item/guardian_creator/Initialize(mapload)
	. = ..()
	var/datum/guardian_fluff/using_theme = GLOB.guardian_themes[theme]
	mob_name = using_theme.name
	RegisterSignal(src, COMSIG_ITEM_TC_REIMBURSED, PROC_REF(on_reimbursed))

/obj/item/guardian_creator/attack_self(mob/living/user)
	if(isguardian(user) && !allow_guardian)
		balloon_alert(user, "Não posso fazer isso!")
		return
	var/list/guardians = user.get_all_linked_holoparasites()
	if(length(guardians) && !allow_multiple)
		balloon_alert(user, "Já tenho um!")
		return
	if(IS_CHANGELING(user) && !allow_changeling)
		to_chat(user, ling_failure)
		return
	if(used)
		to_chat(user, used_message)
		return
	var/list/radial_options = GLOB.guardian_radial_images.Copy()
	for(var/possible_guardian in radial_options)
		if(possible_guardian in possible_guardians)
			continue
		radial_options -= possible_guardian
	var/mob/living/basic/guardian/guardian_path
	if(random)
		guardian_path = pick(possible_guardians)
	else
		guardian_path = show_radial_menu(user, src, radial_options, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 42, require_near = TRUE)
		if(isnull(guardian_path))
			return
	used = TRUE
	to_chat(user, use_message)
	var/guardian_type_name = random ? "Random" : capitalize(initial(guardian_path.creator_name))
	var/mob/chosen_one = SSpolling.poll_ghost_candidates(
		"Do you want to play as [span_danger("[user.real_name]'s")] [span_notice("[guardian_type_name] [mob_name]")]?",
		check_jobban = ROLE_PAI,
		poll_time = 10 SECONDS,
		ignore_category = POLL_IGNORE_HOLOPARASITE,
		alert_pic = guardian_path,
		jump_target = src,
		role_name_text = guardian_type_name,
		amount_to_pick = 1,
	)

	if(was_refunded)
		return

	if(chosen_one)
		spawn_guardian(user, chosen_one, guardian_path)
		used = TRUE
		SEND_SIGNAL(src, COMSIG_TRAITOR_ITEM_USED(type))
	else
		to_chat(user, failure_message)
		used = FALSE

/obj/item/guardian_creator/examine(mob/user)
	. = ..()
	if(used)
		. += span_holoparasite(used_description)
	else
		. += span_holoparasite(unused_description)

/obj/item/guardian_creator/proc/on_reimbursed(datum/source)
	SIGNAL_HANDLER
	was_refunded = TRUE

/// Actually create our guy
/obj/item/guardian_creator/proc/spawn_guardian(mob/living/user, mob/dead/candidate, guardian_path)
	if(QDELETED(user) || user.stat == DEAD)
		return
	var/list/guardians = user.get_all_linked_holoparasites()
	if(length(guardians) && !allow_multiple)
		balloon_alert(user, "Já tenho um!")
		used = FALSE
		return
	var/datum/guardian_fluff/guardian_theme = GLOB.guardian_themes[theme]
	var/mob/living/basic/guardian/summoned_guardian = new guardian_path(user, guardian_theme)
	summoned_guardian.set_summoner(user, different_person = TRUE)
	summoned_guardian.PossessByPlayer(candidate.key)
	user.log_message("has summoned [key_name(summoned_guardian)], a [summoned_guardian.creator_name] holoparasite.", LOG_GAME)
	summoned_guardian.log_message("was summoned as a [summoned_guardian.creator_name] holoparasite.", LOG_GAME)
	to_chat(user, guardian_theme.get_fluff_string(summoned_guardian.guardian_type))
	to_chat(user, replacetext(success_message, "GUARDIÃO", mob_name))
	summoned_guardian.client?.init_verbs()
	summoned_guardian.updatehealth() // Set the initial health hud
	return summoned_guardian

/// Checks to ensure we're still capable of using the radial selector
/obj/item/guardian_creator/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated || !user.is_holding(src) || used)
		return FALSE
	return TRUE

/// Guardian creator available in the wizard spellbook. All but support are available.
/obj/item/guardian_creator/wizard
	allow_multiple = TRUE
	possible_guardians = list(
		/mob/living/basic/guardian/assassin,
		/mob/living/basic/guardian/charger,
		/mob/living/basic/guardian/dextrous,
		/mob/living/basic/guardian/explosive,
		/mob/living/basic/guardian/gaseous,
		/mob/living/basic/guardian/gravitokinetic,
		/mob/living/basic/guardian/lightning,
		/mob/living/basic/guardian/protector,
		/mob/living/basic/guardian/ranged,
		/mob/living/basic/guardian/standard,
	)

/obj/item/guardian_creator/wizard/spawn_guardian(mob/living/user, mob/dead/candidate)
	var/mob/guardian = ..()
	if(isnull(guardian))
		return null
	// Add the wizard team datum
	var/datum/antagonist/wizard/antag_datum = user.mind.has_antag_datum(/datum/antagonist/wizard)
	if(isnull(antag_datum))
		return guardian
	if(!antag_datum.wiz_team)
		antag_datum.create_wiz_team()
	guardian.mind.add_antag_datum(/datum/antagonist/wizard_minion, antag_datum.wiz_team)
	return guardian

/// Guardian creator available in the traitor uplink. All but dextrous are available, you can pick which you want, and changelings cannot use it.
/obj/item/guardian_creator/tech
	name = "holoparasite injector"
	desc = "Contém um nanoesquecimento alienígena de origem desconhecida. Apesar de ser capaz de fazer coisas mágicas através do uso de hologramas de luz dura e nanomáquinas, requer um hospedeiro orgânico como uma base doméstica e fonte de combustível."
	icon = 'icons/obj/medical/syringe.dmi'
	icon_state = "combat_hypo"
	theme = GUARDIAN_THEME_TECH
	allow_changeling = FALSE
	use_message = span_holoparasite("Você começa a ligar o injetor...")
	used_message = span_holoparasite("O injetor já foi usado.")
	unused_description = span_holoparasite("Seu frasco está cheio de uma violenta tempestade de cor.")
	used_description = span_holoparasite("Nada parece estar carregado no injetor.")
	failure_message = span_boldholoparasite("...erro. Ai falhou em intigalizar. Por favor, contate o apoio ou tente novamente mais tarde.")
	ling_failure = span_boldholoparasite("The holoparasites recoil in horror. They want nothing to do with a creature like you.")
	success_message = span_holoparasite("<b>GUARDIÃO</b>Agora está online!")

/// Guardian creator only spawned by admins, which creates a holographic fish. You can have several of them.
/obj/item/guardian_creator/carp
	name = "holocarp fishsticks"
	desc = "Usando o poder de Carp'sie, você pode pegar uma carpa do véu de Carpthulu, e amarrá-lo à sua carne carnuda."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "fishfingers"
	theme = GUARDIAN_THEME_CARP
	use_message = span_holoparasite("Você coloca os espetinhos na boca...")
	used_message = span_holoparasite("Alguém já mordeu esses espetos de peixe! Eca.")
	unused_description = span_holoparasite("Eles parecem quentes e prontos para comer!")
	used_description = span_holoparasite("Parecem encharcados e velhos...")
	failure_message = span_boldholoparasite("Você não poderia pegar nenhum espírito carpa dos mares de Lake Carp. Talvez não haja nenhum, talvez você tenha fodido tudo.")
	ling_failure = span_boldholoparasite("Carp'sie seems to not have taken you as the chosen one. Maybe it's because of your horrifying origin.")
	success_message = span_holoparasite("<b>GUARDIÃO</b>Foi pego!")
	allow_multiple = TRUE

/// Guardian creator available to miners from chests, very limited selection and randomly assigned.
/obj/item/guardian_creator/miner
	name = "dusty shard"
	desc = "Parece ser uma rocha muito antiga, pode ter se originado de um meteoro estranho."
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "dustyshard"
	theme = GUARDIAN_THEME_MINER
	use_message = span_holoparasite("Você perfura sua pele com o caco...")
	used_message = span_holoparasite("Este caco parece ter perdido todo o seu poder...")
	unused_description = span_holoparasite("Ele brilha com um outro poder...")
	used_description = span_holoparasite("Parece chato, com sangue seco na ponta.")
	failure_message = span_boldholoparasite("O caco não reagiu. Talvez tente de novo mais tarde...")
	ling_failure = span_boldholoparasite("The power of the shard seems to not react with your horrifying, mutated body.")
	success_message = span_holoparasite("<b>GUARDIÃO</b>Apareceu!")
	random = TRUE
	//limited to ones which are plausibly useful on lavaland
	possible_guardians = list(
		/mob/living/basic/guardian/charger, // A flying mount which can cross chasms
		/mob/living/basic/guardian/protector, // Bodyblocks projectiles for you
		/mob/living/basic/guardian/ranged, // Shoots the bad guys
		/mob/living/basic/guardian/standard, // Can mine walls
		/mob/living/basic/guardian/support, // Heals and teleports you
	)

/obj/item/guardian_creator/miner/spawn_guardian(mob/living/user, mob/dead/candidate, guardian_path)
	var/mob/living/basic/guardian/guardian = ..()
	if (!guardian)
		return
	// Immune to planetary weather effects
	ADD_TRAIT(guardian, TRAIT_ASHSTORM_IMMUNE, INNATE_TRAIT)
	ADD_TRAIT(guardian, TRAIT_SNOWSTORM_IMMUNE, INNATE_TRAIT)
	return guardian
