/datum/heretic_knowledge_tree_column/flesh
	route = PATH_FLESH
	ui_bgr = "node_flesh"
	complexity = "Varies"
	complexity_color = COLOR_ORANGE
	icon = list(
		"icon" = 'icons/obj/weapons/khopesh.dmi',
		"state" = "flesh_blade",
		"frame" = 1,
		"dir" = SOUTH,
		"moving" = FALSE,
	)
	description = list(
		"The Path of Flesh revolves around summoning ghouls and monstrosities to do your bidding.",
		"Pick this path if you enjoy the fantasy of being a necromancer commanding legions of allies.",
	)
	pros = list(
		"Can turn dead humanoids into fragile but loyal ghouls.",
		"Access to a versatile list of summoned minions.",
		"Your summons are very versatie and can quicky overwhelm the crew should you coordinate your attacks",
		"Eating organs or being fat grants various boons (depending on the level of your passive).",
	)
	cons = list(
		"A high degree of your progression is obtaining additional summoned monsters.",
		"You have very little utility beyond your summoned monsters.",
		"You gain no inherent access to defensive, offensive or mobility spells.",
		"You are mostly focused around supporting your minions.",
	)
	tips = list(
		"Your Mansus Grasp allows you to turn dead humanoids into ghouls (even mindshielded humanoids like security officers and the captain). It also Leaves a mark that causes heavy bleeding when triggered by your bloody blade.",
		"As a Flesh Heretic, organs and dead bodies are your best friends! You can use them for rituals, to heal or to gain buffs.",
		"Your Flesh Surgery spell can heal your summons. Your robes grant you an aura that also heals nearby summons (but not yourself).",
		"Your Flesh Surgery spell also lets you steal organs from humanoids. Useful if you need a spare liver.",
		"Raw Prophets can link you and other summons in a telepathic network, allowing for long distance co-ordination.",
		"Flesh Stalkers are decent combatants with the ability to disguise themselves as small creatures, like beepskies and corgis. They can also utilize an EMP spell, but this can potentially harm them if they transformed into a robot!",
		"Your success with this path is reliant on how knowledgable or robust your minions are. However, there is always power in numbers; the more minions, the higher your chances of success.",
		"Your minions are more expendable than you are. Do not be afraid to tell them to go to their deaths. You can just recover them later... maybe.",
	)

	start = /datum/heretic_knowledge/limited_amount/starting/base_flesh
	knowledge_tier1 = /datum/heretic_knowledge/limited_amount/flesh_ghoul
	guaranteed_side_tier1 = /datum/heretic_knowledge/limited_amount/risen_corpse
	knowledge_tier2 = /datum/heretic_knowledge/spell/flesh_surgery
	guaranteed_side_tier2 = /datum/heretic_knowledge/crucible
	robes = /datum/heretic_knowledge/armor/flesh
	knowledge_tier3 = /datum/heretic_knowledge/summon/raw_prophet
	guaranteed_side_tier3 = /datum/heretic_knowledge/spell/crimson_cleave
	blade = /datum/heretic_knowledge/blade_upgrade/flesh
	knowledge_tier4 = /datum/heretic_knowledge/summon/stalker
	ascension = /datum/heretic_knowledge/ultimate/flesh_final

/datum/heretic_knowledge/limited_amount/starting/base_flesh
	name = "Principle of Hunger"
	desc = "Abre o Caminho da Carne para você.\
Permite que transmute uma faca e uma poça de sangue em uma Lâmina Sangrenta.\
Você pode criar até vinte de cada vez." //SKYRAT EDIT three to twenty
	gain_text = "Centenas de nós morreram de fome, mas eu não... Encontrei força na minha ganância."
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/effect/decal/cleanable/blood = 1,
	)
	result_atoms = list(/obj/item/melee/sickly_blade/flesh)
	limit = 3 // Bumped up so they can arm up their ghouls too.
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "flesh_blade"
	mark_type = /datum/status_effect/eldritch/flesh
	eldritch_passive = /datum/status_effect/heretic_passive/flesh

/datum/heretic_knowledge/limited_amount/starting/base_flesh/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	var/datum/objective/heretic_summon/summon_objective = new()
	summon_objective.owner = our_heretic.owner
	our_heretic.objectives += summon_objective

	to_chat(user, span_hierophant("Comprometendo o Caminho da Carne, você tem outro objetivo."))
	our_heretic.owner.announce_objectives()

/datum/heretic_knowledge/limited_amount/starting/base_flesh/on_mansus_grasp(mob/living/source, mob/living/target)
	. = ..()

	if(target.stat != DEAD)
		return

	if(LAZYLEN(created_items) >= limit)
		target.balloon_alert(source, "no limite de Ghoul!")
		return COMPONENT_BLOCK_HAND_USE

	if(HAS_TRAIT(target, TRAIT_HUSK))
		target.balloon_alert(source, "Descascado!")
		return COMPONENT_BLOCK_HAND_USE

	if(!IS_VALID_GHOUL_MOB(target))
		target.balloon_alert(source, "Corpo inválido!")
		return COMPONENT_BLOCK_HAND_USE

	target.grab_ghost()

	// The grab failed, so they're mindless or playerless. We can't continue
	if(!target.mind || !target.client)
		target.balloon_alert(source, "Nenhuma alma!")
		return COMPONENT_BLOCK_HAND_USE

	make_ghoul(source, target)

/// The max amount of health a ghoul has.
#define GHOUL_MAX_HEALTH 25

/// Makes [victim] into a ghoul.
/datum/heretic_knowledge/limited_amount/starting/base_flesh/proc/make_ghoul(mob/living/user, mob/living/carbon/human/victim)
	user.log_message("created a ghoul, controlled by [key_name(victim)].", LOG_GAME)
	message_admins("[ADMIN_LOOKUPFLW(user)] created a ghoul, [ADMIN_LOOKUPFLW(victim)].")

	victim.apply_status_effect(
		/datum/status_effect/ghoul,
		GHOUL_MAX_HEALTH,
		user.mind,
		CALLBACK(src, PROC_REF(apply_to_ghoul)),
		CALLBACK(src, PROC_REF(remove_from_ghoul)),
	)

/// Callback for the ghoul status effect - Tracking all of our ghouls
/datum/heretic_knowledge/limited_amount/starting/base_flesh/proc/apply_to_ghoul(mob/living/ghoul)
	LAZYADD(created_items, WEAKREF(ghoul))

/// Callback for the ghoul status effect - Tracking all of our ghouls
/datum/heretic_knowledge/limited_amount/starting/base_flesh/proc/remove_from_ghoul(mob/living/ghoul)
	LAZYREMOVE(created_items, WEAKREF(ghoul))

/datum/heretic_knowledge/limited_amount/flesh_ghoul
	name = "Imperfect Ritual"
	// BUBBER CHANGE BELOW - GHOUL MAXHP
	desc = "Permite que transmute um cadáver e uma papoula para criar um morto sem voz.\
O cadáver não precisa ter alma.\
Mortos sem voz são fantasmas mudos e têm 100 de saúde, mas podem usar Lâminas Sangrentas de forma eficaz.\
Você só pode criar dois de cada vez."
	gain_text = "Achei notas de um ritual obscuro, inacabado... mas ainda assim, eu avancei."
	required_atoms = list(
		/mob/living/carbon/human = 1,
		/obj/item/food/grown/poppy = 1,
	)
	limit = 2
	cost = 2
	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "ghoul_voiceless"

/datum/heretic_knowledge/limited_amount/flesh_ghoul/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/body in atoms)
		if(body.stat != DEAD)
			continue
		if(!IS_VALID_GHOUL_MOB(body) || HAS_TRAIT(body, TRAIT_HUSK))
			to_chat(user, span_hierophant_warning("[body] is not in a valid state to be made into a ghoul."))
			continue

		// We'll select any valid bodies here. If they're clientless, we'll give them a new one.
		selected_atoms += body
		return TRUE

	loc.balloon_alert(user, "ritual falhou, nenhum corpo válido!")
	return FALSE

/datum/heretic_knowledge/limited_amount/flesh_ghoul/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/mob/living/carbon/human/soon_to_be_ghoul = locate() in selected_atoms
	if(QDELETED(soon_to_be_ghoul)) // No body? No ritual
		stack_trace("[type] reached on_finished_recipe without a human in selected_atoms to make a ghoul out of.")
		loc.balloon_alert(user, "ritual falhou, nenhum corpo válido!")
		return FALSE

	soon_to_be_ghoul.grab_ghost()

	if(!soon_to_be_ghoul.mind || !soon_to_be_ghoul.client)
		message_admins("[ADMIN_LOOKUPFLW(user)] is creating a voiceless dead of a body with no player.")
		var/mob/chosen_one = SSpolling.poll_ghosts_for_target("Do you want to play as [span_danger(soon_to_be_ghoul.real_name)], a [span_notice("voiceless dead")]?", check_jobban = ROLE_HERETIC, role = ROLE_HERETIC, poll_time = 5 SECONDS, checked_target = soon_to_be_ghoul, alert_pic = mutable_appearance('icons/mob/human/human.dmi', "husk"), jump_target = soon_to_be_ghoul, role_name_text = "Morto sem voz")
		if(isnull(chosen_one))
			loc.balloon_alert(user, "O ritual falhou, sem fantasmas!")
			return FALSE
		message_admins("[key_name_admin(chosen_one)] has taken control of ([key_name_admin(soon_to_be_ghoul)]) to replace an AFK player.")
		soon_to_be_ghoul.ghostize(FALSE)
		soon_to_be_ghoul.PossessByPlayer(chosen_one.key)

	selected_atoms -= soon_to_be_ghoul
	make_ghoul(user, soon_to_be_ghoul)
	return TRUE

/// The max amount of health a voiceless dead has.
#define MUTE_MAX_HEALTH 50

/// Makes [victim] into a ghoul.
/datum/heretic_knowledge/limited_amount/flesh_ghoul/proc/make_ghoul(mob/living/user, mob/living/carbon/human/victim)
	user.log_message("created a voiceless dead, controlled by [key_name(victim)].", LOG_GAME)
	message_admins("[ADMIN_LOOKUPFLW(user)] created a voiceless dead, [ADMIN_LOOKUPFLW(victim)].")

	victim.apply_status_effect(
		/datum/status_effect/ghoul,
		MUTE_MAX_HEALTH,
		user.mind,
		CALLBACK(src, PROC_REF(apply_to_ghoul)),
		CALLBACK(src, PROC_REF(remove_from_ghoul)),
	)

/// Callback for the ghoul status effect - Tracks all of our ghouls and applies effects
/datum/heretic_knowledge/limited_amount/flesh_ghoul/proc/apply_to_ghoul(mob/living/ghoul)
	LAZYADD(created_items, WEAKREF(ghoul))
	ADD_TRAIT(ghoul, TRAIT_MUTE, MAGIC_TRAIT)

/// Callback for the ghoul status effect - Tracks all of our ghouls and applies effects
/datum/heretic_knowledge/limited_amount/flesh_ghoul/proc/remove_from_ghoul(mob/living/ghoul)
	LAZYREMOVE(created_items, WEAKREF(ghoul))
	REMOVE_TRAIT(ghoul, TRAIT_MUTE, MAGIC_TRAIT)

/datum/heretic_knowledge/spell/flesh_surgery
	name = "Knitting of Flesh"
	desc = "Concede-lhe o feitiço Tricô Carne. Este feitiço permite remover órgãos das vítimas.\
sem precisar de uma longa cirurgia. Este processo é muito mais longo se o alvo não estiver morto.\
Este feitiço também permite que você cure seus servos e convoque, ou restaure órgãos que falharam para um status aceitável."
	gain_text = "Mas não ficaram fora do meu alcance por muito tempo. A cada passo, os gritos cresciam, até que finalmente\
Aprendi que eles poderiam ser silenciados."
	action_to_add = /datum/action/cooldown/spell/touch/flesh_surgery
	cost = 2
	drafting_tier = 5

/datum/heretic_knowledge/armor/flesh
	desc = "Permite transmutar uma mesa (ou um terno), uma máscara e uma poça de sangue para criar um abraço retorcido.\
Dá-lhe a capacidade de detectar a condição de saúde de outros vivos (e não vivos) e uma aura que lentamente cura sua convocação.\
Atua como foco enquanto encapuza."
	gain_text = "Eu puxei essas miseráveis coisas sobre mim, como um cobertor quente.\
Com olhos não meus, eles vão testemunhar. Com dentes não meus, eles vão apertar. Com membros, não meus, eles vão quebrar."
	result_atoms = list(/obj/item/clothing/suit/hooded/cultrobes/eldritch/flesh)
	research_tree_icon_state = "flesh_armor"
	required_atoms = list(
		list(/obj/structure/table, /obj/item/clothing/suit) = 1,
		/obj/item/clothing/mask = 1,
		/obj/effect/decal/cleanable/blood = 1,
	)

/datum/heretic_knowledge/summon/raw_prophet
	name = "Raw Ritual"
	desc = "Permite transmutar um par de olhos, um braço esquerdo, e uma poça de sangue para criar um Profeta Raw.\
Profetas crus têm um alcance de visão muito maior e visão de raio-x, bem como uma longa gama de viagens e\
a capacidade de ligar mentes para se comunicar com facilidade, mas são muito frágeis e fracas em combate."
	gain_text = "Eu não podia continuar sozinha. Fui capaz de convocar o Homem Incrível para me ajudar a ver mais.\
Os gritos... uma vez constantes, agora silenciados por sua aparência miserável. Nada estava fora de alcance."
	required_atoms = list(
		/obj/item/organ/eyes = 1,
		/obj/effect/decal/cleanable/blood = 1,
		/obj/item/bodypart/arm/left = 1,
	)
	mob_to_summon = /mob/living/basic/heretic_summon/raw_prophet
	cost = 2
	poll_ignore_define = POLL_IGNORE_RAW_PROPHET


/datum/heretic_knowledge/blade_upgrade/flesh
	name = "Bleeding Steel"
	desc = "Seu maldito. Blade agora faz inimigos sangrarem muito no ataque."
	gain_text = "O homem estranho não estava sozinho. Eles me levaram ao Marechal.\
Finalmente comecei a entender. E então, o sangue chovia dos céus."
	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "blade_upgrade_flesh"
	///What type of wound do we apply on hit
	var/wound_type = /datum/wound/slash/flesh/severe

/datum/heretic_knowledge/blade_upgrade/flesh/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	if(!iscarbon(target) || source == target)
		return

	var/mob/living/carbon/carbon_target = target
	var/obj/item/bodypart/bodypart = pick(carbon_target.get_bodyparts())
	var/datum/wound/crit_wound = new wound_type()
	crit_wound.apply_wound(bodypart, attack_direction = get_dir(source, target))

/datum/heretic_knowledge/summon/stalker
	name = "Lonely Ritual"
	desc = "Permite transmutar uma cauda de qualquer tipo, um estômago, uma língua, uma caneta e um pedaço de papel para criar um Stalker.\
Perseguidores podem correr, liberar PEMs, transformar em animais ou autômatos, e são fortes em combate."
	gain_text = "Eu fui capaz de combinar minha ganância e desejos de invocar uma besta eldritch que eu nunca tinha visto antes.\
Uma massa de carne que mudava de forma, conhecia bem meus objetivos. O delegado aprovou."

	required_atoms = list(
		/obj/item/organ/tail = 1,
		/obj/item/organ/stomach = 1,
		/obj/item/organ/tongue = 1,
		/obj/item/pen = 1,
		/obj/item/paper = 1,
	)
	mob_to_summon = /mob/living/basic/heretic_summon/stalker
	cost = 2

	poll_ignore_define = POLL_IGNORE_STALKER
	is_final_knowledge = TRUE

/datum/heretic_knowledge/ultimate/flesh_final
	name = "Priest's Final Hymn"
	desc = "O ritual de ascensão do Caminho da Carne.\
Traga 4 corpos para uma runa de transmutação para completar o ritual.\
Quando concluído, você ganha a habilidade de perder sua forma humana.\
e tornar-se o Senhor da Noite, uma criatura extremamente poderosa.\
Apenas o ato de transformar causa aos pagãos próximos grande medo e trauma.\
Enquanto na forma do Senhor da Noite, você pode consumir braços para curar e recuperar segmentos.\
Além disso, você pode convocar três vezes mais Ghouls e Voz Sem Morto,\
e pode criar lâminas ilimitadas para armar todos eles."
	gain_text = "Com o conhecimento do marechal, meu poder atingiu o pico. O trono estava aberto para reivindicar.\
Homens deste mundo, ouçam-me, pois chegou a hora! O marechal guia meu exército!\
A realidade se curvará ao Senhor da noite ou será desvendada! Testemunhe minha ascensão!"
	required_atoms = list(/mob/living/carbon/human = 4)
	ascension_achievement = /datum/award/achievement/misc/flesh_ascension
	announcement_text = "Sempre enrolando vórtice. Realidade desdobrada. O Senhor da noite subiu! Medo da mão sempre torcendo! SPOOKY"
	announcement_sound = 'sound/music/antag/heretic/ascend_flesh.ogg'

/datum/heretic_knowledge/ultimate/flesh_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	var/datum/action/cooldown/spell/shapeshift/shed_human_form/worm_spell = new(user.mind)
	worm_spell.Grant(user)

	var/datum/antagonist/heretic/heretic_datum = GET_HERETIC(user)
	var/datum/heretic_knowledge/limited_amount/starting/base_flesh/grasp_ghoul = heretic_datum.get_knowledge(/datum/heretic_knowledge/limited_amount/starting/base_flesh)
	grasp_ghoul.limit *= 3
	var/datum/heretic_knowledge/limited_amount/flesh_ghoul/ritual_ghoul = heretic_datum.get_knowledge(/datum/heretic_knowledge/limited_amount/flesh_ghoul)
	ritual_ghoul.limit *= 3
	var/datum/heretic_knowledge/limited_amount/starting/base_flesh/blade_ritual = heretic_datum.get_knowledge(/datum/heretic_knowledge/limited_amount/starting/base_flesh)
	blade_ritual.limit = 999

#undef GHOUL_MAX_HEALTH
#undef MUTE_MAX_HEALTH
