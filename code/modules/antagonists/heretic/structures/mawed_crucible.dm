// The mawed crucible, a heretic structure that can create potions from bodyparts and organs.
/obj/structure/destructible/eldritch_crucible
	name = "mawed crucible"
	desc = "Uma bacia profunda feita de ferro fundido, imortalizada por dentes de aço segurando-o no lugar. Olhar para o extrato vil dentro enche sua mente de idéias terríveis."
	icon = 'icons/obj/antags/eldritch.dmi'
	icon_state = "crucible"
	base_icon_state = "crucible"
	break_sound = 'sound/effects/hallucinations/wail.ogg'
	light_power = 1
	anchored = TRUE
	density = TRUE
	///How much mass this currently holds
	var/current_mass = 3
	///Maximum amount of mass
	var/max_mass = 3
	///Check to see if it is currently being used.
	var/in_use = FALSE
	///Cooldown for the crucible to create mass from the eldritch
	COOLDOWN_DECLARE(refill_cooldown)

/obj/structure/destructible/eldritch_crucible/Initialize(mapload)
	. = ..()
	break_message = span_warning("[src] Caiu aos pedaços com uma batida!")
	START_PROCESSING(SSobj, src)

/obj/structure/destructible/eldritch_crucible/process(seconds_per_tick)
	if(COOLDOWN_TIMELEFT(src, refill_cooldown))
		return
	if(current_mass >= max_mass)
		return
	COOLDOWN_START(src, refill_cooldown, 30 SECONDS)
	current_mass++
	playsound(src, 'sound/items/eatfood.ogg', 100, TRUE)
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/destructible/eldritch_crucible/atom_deconstruct(disassembled = TRUE)
	// Create a spillage if we were destroyed with leftover mass
	if(current_mass)
		break_message = span_warning("[src] Se desfaz com uma batida, derramando extrato brilhante por toda parte!")
		var/turf/our_turf = get_turf(src)

		new /obj/effect/decal/cleanable/greenglow(our_turf)
		for(var/turf/nearby_turf as anything in get_adjacent_open_turfs(our_turf))
			if(prob(10 * current_mass))
				new /obj/effect/decal/cleanable/greenglow(nearby_turf)
		playsound(our_turf, 'sound/effects/bubbles/bubbles2.ogg', 50, TRUE)

	return ..()

/obj/structure/destructible/eldritch_crucible/examine(mob/user)
	. = ..()
	if(!IS_HERETIC_OR_MONSTER(user) && !isobserver(user))
		return

	if(current_mass > 0)
		. += span_notice("Você pode encher um frasco de eldritch com isso.")

	if(current_mass < max_mass)
		var/to_fill = max_mass - current_mass
		. += span_notice("[src] Requer<b>[to_fill]</b>Mais órgão.[to_fill == 1 ? "":"s"]U parte do corpo[to_fill == 1 ? "":"s"].")
	else
		. += span_boldnotice("[src] está borbulhando até a borda com líquido viscoso, e está pronto para usar.")

	. += span_notice("Você pode.<b>[anchored ? "unanchor and move":"anchor in place"]</b> [src] Comum<b>Códice Cicatrix</b>UO<b>Mansus Grasp</b>.")
	. += span_info("As seguintes poções podem ser feitas:")
	for(var/obj/item/eldritch_potion/potion as anything in subtypesof(/obj/item/eldritch_potion))
		var/potion_string = span_info("\tO" + initial(potion.name) + " - " + initial(potion.crucible_tip))
		. += potion_string

/obj/structure/destructible/eldritch_crucible/examine_status(mob/user)
	if(IS_HERETIC_OR_MONSTER(user) || isobserver(user))
		return span_notice("Está em<b>[round(atom_integrity * 100 / max_integrity)]%</b>Estabilidade.")
	return ..()

// no breaky herety thingy
/obj/structure/destructible/eldritch_crucible/rust_heretic_act()
	return

/obj/structure/destructible/eldritch_crucible/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/codex_cicatrix) || istype(tool, /obj/item/melee/touch_attack/mansus_fist))
		playsound(src, 'sound/items/deconstruct.ogg', 30, TRUE, ignore_walls = FALSE)
		set_anchored(!anchored)
		balloon_alert(user, "[anchored ? "":"un"]Ancorado")
		return ITEM_INTERACT_SUCCESS
	if(istype(tool, /obj/item/reagent_containers/cup/beaker/eldritch))
		if(current_mass < max_mass)
			balloon_alert(user, "Não está cheio o suficiente!")
			return ITEM_INTERACT_SUCCESS
		var/obj/item/reagent_containers/cup/beaker/eldritch/to_fill = tool
		if(to_fill.reagents.total_volume >= to_fill.reagents.maximum_volume)
			balloon_alert(user, "O frasco está cheio!")
			return ITEM_INTERACT_SUCCESS
		to_fill.reagents.add_reagent(/datum/reagent/eldritch, 50)
		do_item_attack_animation(src, used_item = tool, animation_type = ATTACK_ANIMATION_BLUNT)
		current_mass--
		balloon_alert(user, "Frasco recheado")
		return ITEM_INTERACT_SUCCESS

	if(isbodypart(tool))
		var/obj/item/bodypart/consumed = tool
		if(!IS_ORGANIC_LIMB(consumed))
			balloon_alert(user, "Não orgânico!")
			return ITEM_INTERACT_BLOCKING
		if(!IS_HERETIC_OR_MONSTER(user))
			if(user.combat_mode)
				return ITEM_INTERACT_SKIP_TO_ATTACK
			bite_the_hand(user)
			return ITEM_INTERACT_SUCCESS
		consume_fuel(user, consumed)
		return ITEM_INTERACT_SUCCESS

	if(isorgan(tool))
		var/obj/item/organ/consumed = tool
		if(!IS_ORGANIC_ORGAN(consumed))
			balloon_alert(user, "Não orgânico!")
			return ITEM_INTERACT_BLOCKING
		if(consumed.organ_flags & ORGAN_VITAL) // Basically, don't eat organs like brains
			balloon_alert(user, "Órgão inválido!")
			return ITEM_INTERACT_BLOCKING
		if(!IS_HERETIC_OR_MONSTER(user))
			if(user.combat_mode)
				return ITEM_INTERACT_SKIP_TO_ATTACK
			bite_the_hand(user)
			return ITEM_INTERACT_SUCCESS
		consume_fuel(user, consumed)
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/structure/destructible/eldritch_crucible/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return

	if(!isliving(user))
		return

	if(!IS_HERETIC_OR_MONSTER(user))
		if(iscarbon(user))
			bite_the_hand(user)
		return TRUE

	if(in_use)
		balloon_alert(user, "Em uso!")
		return TRUE

	if(current_mass < max_mass)
		balloon_alert(user, "Não está cheio o suficiente!")
		return TRUE

	INVOKE_ASYNC(src, PROC_REF(show_radial), user)
	return TRUE

/*
 * Wrapper for show_radial() to ensure in_use is enabled and disabled correctly.
 */
/obj/structure/destructible/eldritch_crucible/proc/show_radial(mob/living/user)
	in_use = TRUE
	create_potion(user)
	in_use = FALSE

/*
 * Shows the user of radial of possible potions,
 * and create the potion they chose.
 */
/obj/structure/destructible/eldritch_crucible/proc/create_potion(mob/living/user)

	// Assoc list of [name] to [image] for the radial
	var/static/list/choices = list()
	// Assoc list of [name] to [path] for after the radial, to spawn it
	var/static/list/names_to_path = list()
	if(!choices.len || !names_to_path.len)
		for(var/obj/item/eldritch_potion/potion as anything in subtypesof(/obj/item/eldritch_potion))
			names_to_path[initial(potion.name)] = potion
			choices[initial(potion.name)] = image(icon = initial(potion.icon), icon_state = initial(potion.icon_state))

	var/picked_choice = show_radial_menu(
		user,
		src,
		choices,
		require_near = TRUE,
		tooltips = TRUE,
		)

	if(isnull(picked_choice))
		return

	var/spawned_type = names_to_path[picked_choice]
	if(!ispath(spawned_type, /obj/item/eldritch_potion))
		CRASH("[type] attempted to create a potion that wasn't an eldritch potion! (got: [spawned_type])")

	var/obj/item/spawned_pot = new spawned_type(drop_location())

	playsound(src, 'sound/effects/desecration/desecration-02.ogg', 75, TRUE)
	visible_message(span_notice("[src] É líquido brilhante drena em um frasco, criando um [spawned_pot.name]!"))
	balloon_alert(user, "Poção criada")

	current_mass = 0
	update_appearance(UPDATE_ICON_STATE)

/*
 * "Bites the hand that feeds it", except more literally.
 * Called when a non-heretic interacts with the crucible,
 * causing them to lose their active hand to it.
 */
/obj/structure/destructible/eldritch_crucible/proc/bite_the_hand(mob/living/carbon/user)
	if(HAS_TRAIT(user, TRAIT_NODISMEMBER))
		return

	var/obj/item/bodypart/arm = user.get_active_hand()
	if(QDELETED(arm))
		return

	to_chat(user, span_userdanger("[src] Pega o seu [arm.plaintext_zone]!"))
	arm.dismember()
	consume_fuel(consumed = arm)

/*
 * Consumes an organ or bodypart and increases the mass of the crucible.
 * If feeder is supplied, gives some feedback.
 */
/obj/structure/destructible/eldritch_crucible/proc/consume_fuel(mob/living/feeder, obj/item/consumed)
	if(current_mass >= max_mass)
		if(feeder)
			balloon_alert(feeder, "Cadinho cheio!")
		return

	current_mass++
	playsound(src, 'sound/items/eatfood.ogg', 100, TRUE)
	visible_message(span_notice("[src] Devora [consumed] e se enche com um pouco de líquido!"))

	if(feeder)
		balloon_alert(feeder, "ração crubile ([current_mass] / [max_mass])")

	qdel(consumed)
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/destructible/eldritch_crucible/update_icon_state()
	icon_state = "[base_icon_state][(current_mass == max_mass) ? null : "_empty"]"
	return ..()

// Potions created by the mawed crucible.
/obj/item/eldritch_potion
	name = "brew of day and night"
	desc = "Você nunca deveria ver isso."
	icon = 'icons/obj/antags/eldritch.dmi'
	w_class = WEIGHT_CLASS_SMALL
	pickup_sound = 'sound/items/handling/materials/glass_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/glass_drop.ogg'
	/// When a heretic examines a mawed crucible, shows a list of possible potions by name + includes this tip to explain what it does.
	var/crucible_tip = "Doesn't do anything."
	/// Typepath to the status effect this applies
	var/status_effect
	/// If you can drink the same potion while the effect is active
	var/can_refresh = TRUE

/obj/item/eldritch_potion/examine(mob/user)
	. = ..()
	if(!IS_HERETIC_OR_MONSTER(user) && !isobserver(user))
		return

	. += span_notice(crucible_tip)

/obj/item/eldritch_potion/attack_self(mob/user)
	. = ..()
	if(.)
		return

	if(!iscarbon(user))
		return

	if(!can_refresh && user.has_status_effect(status_effect))
		return

	playsound(src, 'sound/effects/bubbles/bubbles.ogg', 50, TRUE)

	if(!IS_HERETIC_OR_MONSTER(user))
		to_chat(user, span_danger("Você tomou um pouco do líquido de [src] O sabor faz com que você retch, e o copo desaparece."))
		user.reagents?.add_reagent(/datum/reagent/eldritch, 10)
		user.adjust_disgust(50)
		qdel(src)
		return TRUE

	to_chat(user, span_notice("Você bebe o líquido viscoso de [src], causando a desmaterialização do vidro."))
	potion_effect(user)
	qdel(src)
	return TRUE

/**
 * The effect of the potion, if it has any special one.
 * In general try not to override this
 * and utilize the status_effect var to make custom effects.
 */
/obj/item/eldritch_potion/proc/potion_effect(mob/user)
	var/mob/living/carbon/carbon_user = user
	carbon_user.apply_status_effect(status_effect)

/obj/item/eldritch_potion/crucible_soul
	name = "brew of the crucible soul"
	desc = "Uma garrafa de vidro contendo um líquido brilhante laranja, translúcido."
	icon_state = "crucible_soul"
	status_effect = /datum/status_effect/crucible_soul
	crucible_tip = "Allows you to walk through walls. After expiring, you are teleported to your original location. Lasts 40 seconds."
	can_refresh = FALSE

/obj/item/eldritch_potion/crucible_soul/attack_self(mob/user)
	if(user.has_status_effect(/datum/status_effect/crucible_soul_cooldown))
		balloon_alert(user, "Em recarga!")
		return TRUE
	return ..()

/obj/item/eldritch_potion/duskndawn
	name = "brew of dusk and dawn"
	desc = "Uma garrafa de vidro contendo um líquido amarelo. Parece desaparecer com regularidade."
	icon_state = "clarity"
	status_effect = /datum/status_effect/duskndawn
	crucible_tip = "Allows you to see through walls and objects. Lasts 90 seconds."

/obj/item/eldritch_potion/wounded
	name = "brew of the wounded soldier"
	desc = "Uma garrafa de vidro contendo um líquido escuro incolor."
	icon_state = "marshal"
	status_effect = /datum/status_effect/marshal
	crucible_tip = "Causes all wounds you are experiencing to begin to heal you. Fractures, sprains, cuts, and punctures will heal bruises, 		and flesh damage will heal burns. The more severe the wounds, the stronger the healing. Additionally, prevents slowdown from damage. 		Lasts 60 seconds. "
