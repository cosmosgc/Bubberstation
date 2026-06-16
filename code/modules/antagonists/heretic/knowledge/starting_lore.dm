// Heretic starting knowledge.

/// Global list of all heretic knowledge that have is_starting_knowledge = TRUE. List of PATHS.
GLOBAL_LIST_INIT(heretic_start_knowledge, initialize_starting_knowledge())

/**
 * Returns a list of all heretic knowledge TYPEPATHS
 * that have route set to PATH_START.
 */
/proc/initialize_starting_knowledge()
	. = list()
	for(var/datum/heretic_knowledge/knowledge as anything in subtypesof(/datum/heretic_knowledge))
		if(initial(knowledge.is_starting_knowledge) == TRUE)
			. += knowledge

/*
 * The base heretic knowledge. Grants the Mansus Grasp spell.
 */
/datum/heretic_knowledge/spell/basic
	name = "Break of Dawn"
	desc = "Começa sua jornada para o Mansus. Concede-lhe o Mansus Grasp, um poderoso e upgradável feitiço incapacitante que pode ser lançado independentemente de ter um foco."
	action_to_add = /datum/action/cooldown/spell/touch/mansus_grasp
	cost = 0
	is_starting_knowledge = TRUE

// Heretics can enhance their fishing rods to fish better - fishing content.
// Lasts until successfully fishing something up.
/datum/heretic_knowledge/spell/basic/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	..()
	RegisterSignal(user, COMSIG_TOUCH_HANDLESS_CAST, PROC_REF(on_grasp_cast))

/datum/heretic_knowledge/spell/basic/proc/on_grasp_cast(mob/living/carbon/cast_on, datum/action/cooldown/spell/touch/touch_spell)
	SIGNAL_HANDLER

	// Not a grasp, we dont want this to activate with say star or mending touch.
	if(!istype(touch_spell, action_to_add))
		return NONE

	var/obj/item/fishing_rod/held_rod = cast_on.get_active_held_item()
	if(!istype(held_rod, /obj/item/fishing_rod) || HAS_TRAIT(held_rod, TRAIT_ROD_MANSUS_INFUSED))
		return NONE

	INVOKE_ASYNC(cast_on, TYPE_PROC_REF(/atom/movable, say), message = "R'CH T'H F'SH!", forced = "fishing rod infusion invocation")
	playsound(cast_on, /datum/action/cooldown/spell/touch/mansus_grasp::sound, 15)
	cast_on.visible_message(span_notice("[cast_on] Snaps [cast_on.p_their()] Dedos ao lado de [held_rod], cobrindo-o em uma explosão de chamas roxas!"))

	ADD_TRAIT(held_rod, TRAIT_ROD_MANSUS_INFUSED, REF(held_rod))
	held_rod.difficulty_modifier -= 20
	RegisterSignal(held_rod, COMSIG_FISHING_ROD_CAUGHT_FISH, PROC_REF(unfuse))
	held_rod.add_filter("mansus_infusion", 2, list("type" = "outline", "color" = COLOR_VOID_PURPLE, "size" = 1))
	return COMPONENT_CAST_HANDLESS

/datum/heretic_knowledge/spell/basic/proc/unfuse(obj/item/fishing_rod/item, reward, mob/user)
	if(reward == FISHING_INFLUENCE || prob(35))
		item.remove_filter("mansus_infusion")
		REMOVE_TRAIT(item, TRAIT_ROD_MANSUS_INFUSED, REF(item))
		item.difficulty_modifier += 20

/**
 * The Living Heart heretic knowledge.
 *
 * Gives the heretic a living heart.
 * Also includes a ritual to turn their heart into a living heart.
 */
/datum/heretic_knowledge/living_heart
	name = "The Living Heart"
	desc = "Concede-lhe um Coração Vivo, permitindo que rastreie alvos de sacrifício. Se você perder seu coração, você pode transmutar uma papoula e uma poça de sangue para despertar seu coração em um Coração Vivo. Se seu coração é cibernético, você será incapaz de acordá-lo."
	required_atoms = list(
		/obj/effect/decal/cleanable/blood = 1,
		/obj/item/food/grown/poppy = 1,
	)
	cost = 0
	priority = MAX_KNOWLEDGE_PRIORITY - 1 // Knowing how to remake your heart is important
	is_starting_knowledge = TRUE
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "living_heart"
	research_tree_icon_frame = 1

/datum/heretic_knowledge/living_heart/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()

	var/obj/item/organ/where_to_put_our_heart = user.get_organ_slot(our_heretic.living_heart_organ_slot)
	// Our heart slot is not valid to put a heart
	if(!is_valid_heart(where_to_put_our_heart))
		where_to_put_our_heart = null

	// If a heretic is made from a species without a heart, we need to find a backup.
	if(!where_to_put_our_heart)
		var/static/list/backup_organs = list(
			ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
			ORGAN_SLOT_LIVER = /obj/item/organ/liver,
			ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		)

		for(var/backup_slot in backup_organs)
			var/obj/item/organ/look_for_backup = user.get_organ_slot(backup_slot)
			// This backup slot is not a valid slot to put a heart
			if(!is_valid_heart(look_for_backup))
				continue

			// We found a replacement place to put our heart
			where_to_put_our_heart = look_for_backup
			our_heretic.living_heart_organ_slot = backup_slot
			to_chat(user, span_boldnotice("Como sua espécie não tem coração, seu coração vivo está localizado em seu [look_for_backup.name]."))
			break

	if(where_to_put_our_heart)
		where_to_put_our_heart.AddComponent(/datum/component/living_heart)
		desc = "Concede-lhe um coração vivo, amarrado ao seu [where_to_put_our_heart.name], permitindo que você rastreie alvos de sacrifício. Se você perder seu [where_to_put_our_heart.name], você pode transmutar uma papoula e uma poça de sangue para acordar seu [where_to_put_our_heart.name] em um Coração Vivo. Cybernetic [where_to_put_our_heart.name] Bloqueará o ritual!"

	else
		to_chat(user, span_boldnotice("Você não tem coração, nem órgãos do peito. Você não ganhou um Coração Vivo por causa disso."))

/datum/heretic_knowledge/living_heart/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	var/obj/item/organ/our_living_heart = user.get_organ_slot(our_heretic.living_heart_organ_slot)
	if(our_living_heart)
		qdel(our_living_heart.GetComponent(/datum/component/living_heart))

// Don't bother letting them invoke this ritual if they have a Living Heart already in their chest
/datum/heretic_knowledge/living_heart/can_be_invoked(datum/antagonist/heretic/invoker)
	if(invoker.has_living_heart() == HERETIC_HAS_LIVING_HEART)
		return FALSE
	return TRUE

/datum/heretic_knowledge/living_heart/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	var/datum/antagonist/heretic/our_heretic = GET_HERETIC(user)
	var/obj/item/organ/our_living_heart = user.get_organ_slot(our_heretic.living_heart_organ_slot)
	// No heart, nothing to give living heart to
	if(QDELETED(our_living_heart))
		loc.balloon_alert(user, "O ritual falhou, não.[our_heretic.living_heart_organ_slot]!")
		return FALSE

	// For sanity's sake, check if they've got a living heart -
	// even though it's not invokable if you already have one,
	// they may have gained one unexpectantly in between now and then
	if(HAS_TRAIT(our_living_heart, TRAIT_LIVING_HEART))
		loc.balloon_alert(user, "O ritual falhou, já tem um coração vivo!")
		return FALSE

	// By this point they are making a new heart
	// If their current heart is organic / not synthetic, we can continue the ritual as normal
	if(is_valid_heart(our_living_heart))
		return TRUE

	loc.balloon_alert(user, "O ritual falhou,[our_heretic.living_heart_organ_slot] Não pode ser acordado!") // "coração não pode ser despertado!"
	return FALSE

/datum/heretic_knowledge/living_heart/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/datum/antagonist/heretic/our_heretic = GET_HERETIC(user)
	var/obj/item/organ/our_new_heart = user.get_organ_slot(our_heretic.living_heart_organ_slot)
	// Don't delete our shiny new heart
	selected_atoms -= our_new_heart
	// Make it the living heart
	our_new_heart.AddComponent(/datum/component/living_heart)
	to_chat(user, span_warning("Você sente o seu [our_new_heart.name] Comece o pulso mais rápido e rápido quando ele acordar!"))
	playsound(user, 'sound/effects/magic/demon_consume.ogg', 50, TRUE)
	return TRUE

/// Checks if the passed heart is a valid heart to become a living heart
/datum/heretic_knowledge/living_heart/proc/is_valid_heart(obj/item/organ/new_heart)
	if(QDELETED(new_heart))
		return FALSE
	if(new_heart.organ_flags & (ORGAN_UNUSABLE|ORGAN_ROBOTIC|ORGAN_FAILING))
		return FALSE

	return TRUE

/**
 * Allows the heretic to craft a spell focus.
 * They require a focus to cast advanced spells.
 */
/datum/heretic_knowledge/amber_focus
	name = "Amber Focus"
	desc = "Permite que transmute uma folha de vidro e um par de olhos para criar um Amber Focus. Um foco deve ser usado para lançar feitiços mais avançados."
	required_atoms = list(
		/obj/item/organ/eyes = 1,
		/obj/item/stack/sheet/glass = 1,
	)
	result_atoms = list(/obj/item/clothing/neck/heretic_focus)
	cost = 0
	priority = MAX_KNOWLEDGE_PRIORITY - 2 // Not as important as making a heart or sacrificing, but important enough.
	is_starting_knowledge = TRUE
	research_tree_icon_path = 'icons/obj/clothing/neck.dmi'
	research_tree_icon_state = "eldritch_necklace"

/datum/heretic_knowledge/spell/cloak_of_shadows
	name = "Cloak of Shadow"
	desc = "Concede-lhe o feitiço Cloak of Shadow. Este feitiço esconderá completamente sua identidade em uma fumaça roxa por três minutos, ajudando você a manter segredo. Requer um foco para lançar."
	action_to_add = /datum/action/cooldown/spell/shadow_cloak
	cost = 0
	is_starting_knowledge = TRUE

/**
 * Codex Cicatrixi is available at the start:
 * This allows heretics to choose if they want to rush all the influences and take them stealthily, or
 * Construct a codex and take what's left with more points.
 * Another downside to having the book is strip searches, which means that it's not just a free nab, at least until you get exposed - and when you do, you'll probably need the faster drawing speed.
 * Overall, it's a tradeoff between speed and stealth or power.
 */
/datum/heretic_knowledge/codex_cicatrix
	name = "Codex Cicatrix"
	desc = "Permite transmutar um livro, qualquer caneta, e sua picareta de qualquer carcaça (animal ou humana), couro, ou se esconder para criar um Códice Cicatrix. O Codex Cicatrix pode ser usado quando drena influências para obter mais conhecimento, mas corre maior risco de ser notado. Ele também pode ser usado para desenhar e remover runas de transmutação mais fácil, e como um foco de feitiço em uma pitada."
	gain_text = "O oculto deixa fragmentos de conhecimento e poder em qualquer lugar e em todo lugar. O Códice Cicatrix é um exemplo. Dentro dos rostos de couro e páginas antigas, um caminho para o Mansus é revelado."
	required_atoms = list(
		list(/obj/item/toy/eldritch_book, /obj/item/book) = 1,
		/obj/item/pen = 1,
		list(/mob/living, /obj/item/stack/sheet/leather, /obj/item/stack/sheet/animalhide, /obj/item/food/deadmouse) = 1,
	)
	result_atoms = list(/obj/item/codex_cicatrix)
	cost = 1
	is_starting_knowledge = TRUE
	priority = MAX_KNOWLEDGE_PRIORITY - 4 // Least priority out of the starting knowledges, as it's an optional boon.
	var/static/list/non_mob_bindings = typecacheof(list(/obj/item/stack/sheet/leather, /obj/item/stack/sheet/animalhide, /obj/item/food/deadmouse))
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "book"

/datum/heretic_knowledge/codex_cicatrix/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	if(!.)
		return FALSE

	for(var/thingy in atoms)
		if(is_type_in_typecache(thingy, non_mob_bindings))
			selected_atoms += thingy
			return TRUE
		else if(isliving(thingy))
			var/mob/living/body = thingy
			if(body.stat != DEAD)
				continue
			selected_atoms += body
			return TRUE
	return FALSE

/datum/heretic_knowledge/codex_cicatrix/cleanup_atoms(list/selected_atoms)
	var/mob/living/body = locate() in selected_atoms
	if(!body)
		return ..()
	// A golem or an android doesn't have skin!
	var/exterior_text = "skin"
	// If carbon, it's the limb. If not, it's the body.
	var/atom/movable/ripped_thing = body

	// We will check if it's a carbon's body.
	// If it is, we will damage a random bodypart, and check that bodypart for its body type, to select between 'skin' or 'exterior'.
	if(iscarbon(body))
		var/mob/living/carbon/carbody = body
		var/obj/item/bodypart/bodypart = pick(carbody.get_bodyparts())
		ripped_thing = bodypart

		carbody.apply_damage(25, BRUTE, bodypart, sharpness = SHARP_EDGED)
		if(!(bodypart.bodytype & BODYTYPE_ORGANIC))
			exterior_text = "exterior"
	else
		body.apply_damage(25, BRUTE, sharpness = SHARP_EDGED)
		// If it is not a carbon mob, we will just check biotypes and damage it directly.
		if(body.mob_biotypes & (MOB_MINERAL|MOB_ROBOTIC))
			exterior_text = "exterior"

	// Procure book for flavor text. This is why we call parent at the end.
	var/obj/item/book/le_book = locate() in selected_atoms
	if(!le_book)
		stack_trace("Somehow, no book in codex cicatrix selected atoms! [english_list(selected_atoms)]")
	playsound(body, 'sound/items/poster/poster_ripped.ogg', 100, TRUE)
	body.do_jitter_animation()
	body.visible_message(span_danger("Um som terrível é ouvido como [ripped_thing]'s [exterior_text] é arrancado para fora, enrolando ao redor[le_book || "the book"], transformando-se em um tom azul eldritch!"))
	return ..()

/datum/heretic_knowledge/feast_of_owls
	name = "Feast of Owls"
	desc = "Permite que você passe por um ritual que lhe dá 5 pontos de conhecimento, mas te bloqueia da ascensão. Isso só pode ser feito uma vez e não pode ser revertido."
	gain_text = "Sob o suave brilho da irracionalidade há uma besta que persegue a noite. Vou trazê-lo e deixá-lo entrar em minha presença. Ele se banqueteará com minhas amibições e deixará o conhecimento em seu rastro."
	is_starting_knowledge = TRUE
	required_atoms = list()
	research_tree_icon_path = 'icons/mob/actions/actions_animal.dmi'
	research_tree_icon_state = "god_transmit"
	/// amount of research points granted
	var/reward = 5

/datum/heretic_knowledge/feast_of_owls/can_be_invoked(datum/antagonist/heretic/invoker)
	return !invoker.feast_of_owls

/datum/heretic_knowledge/feast_of_owls/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/alert = tgui_alert(user,"Você realmente quer abandonar sua ascensão? Esta ação não pode ser revertida.", "Feast of Owls", list("Yes I'm sure", "No"), 30 SECONDS)
	if(alert != "Yes I'm sure" || QDELETED(user) || QDELETED(src) || get_dist(user, loc) > 2)
		return FALSE
	var/datum/antagonist/heretic/heretic_datum = GET_HERETIC(user)
	if(QDELETED(heretic_datum) || heretic_datum.feast_of_owls)
		return FALSE

	. = TRUE

	heretic_datum.feast_of_owls = TRUE
	heretic_datum.update_heretic_aura()
	user.set_temp_blindness(reward * 1 SECONDS)
	user.AdjustParalyzed(reward * 1 SECONDS)
	user.playsound_local(get_turf(user), 'sound/music/antag/heretic/heretic_gain_intense.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)
	for(var/i in 1 to reward)
		user.emote("scream")
		playsound(loc, 'sound/items/eatfood.ogg', 100, TRUE)
		heretic_datum.adjust_knowledge_points(1)

		to_chat(user, span_danger("Você sente algo invisível rasgando sua essência!"))
		user.do_jitter_animation()
		sleep(1 SECONDS)
		if(QDELETED(user) || QDELETED(heretic_datum))
			return FALSE

	to_chat(user, span_danger(span_big("Sua ambição está devastada, mas algo poderoso permanece em seu rastro...")))
	var/drain_message = pick_list(HERETIC_INFLUENCE_FILE, "drain_message")
	to_chat(user, span_hypnophrase(span_big("[drain_message]")))
	return .

/**
 * Warren King's Welcome
 * Ritual available at the start. So that heretics can easily gain access to maintenance airlocks without having to rely on a HoP or having to off some poor assistant.
 * Gives access to solars since those doors are especially useful to get in or out of space.
 */
/datum/heretic_knowledge/bookworm
	name = "Warren King's Welcome"
	desc = "Permite que transmute 5 cabos e um pedaço de papel para infundir qualquer identificação com maintenace e acesso externo à câmara de ar."
	gain_text = "Torcido em ossos dedos manchados de víveres, meu triste convite tira minha mente enjoada e turva em direção à porta pesada. Lentamente, a luz dança entre uma escuridão rastejante, cobrindo o passeio fétido com infinitas maquinações. Mas o Rei em breve levará seu quilo de carne. Mesmo aqui, o fiscal pega a parte deles. Pois há milhares de bocas para alimentar."
	required_atoms = list(
		/obj/item/stack/cable_coil = 5,
		/obj/item/paper = 1,
	)
	cost = 1
	is_starting_knowledge = TRUE
	priority = MAX_KNOWLEDGE_PRIORITY - 3
	research_tree_icon_path = 'icons/obj/card.dmi'
	research_tree_icon_state = "eldritch"

/datum/heretic_knowledge/bookworm/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	for(var/obj/item/card/id/used_id in atoms)
		if((ACCESS_MAINT_TUNNELS in used_id.access) && (ACCESS_EXTERNAL_AIRLOCKS in used_id.access)) // If we can't give any access we aren't elligible
			continue
		selected_atoms += used_id
		return TRUE

	user.balloon_alert(user, "O ritual falhou, sem identificação sem acesso!")
	return FALSE

/datum/heretic_knowledge/bookworm/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	var/obj/item/card/id/improved_id = locate() in selected_atoms
	improved_id.add_access(list(ACCESS_MAINT_TUNNELS, ACCESS_EXTERNAL_AIRLOCKS), mode = FORCE_ADD_ALL)
	selected_atoms -= improved_id
	return TRUE
