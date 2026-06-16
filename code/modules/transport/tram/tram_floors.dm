/turf/open/floor/noslip/tram
	name = "high-traction tram platform"
	icon = 'icons/turf/tram.dmi'
	icon_state = "noslip_tram"
	base_icon_state = "noslip_tram"
	floor_tile = /obj/item/stack/tile/noslip/tram

/turf/open/floor/tram
	name = "tram guideway"
	icon = 'icons/turf/tram.dmi'
	icon_state = "tram_platform"
	base_icon_state = "tram_platform"
	floor_tile = /obj/item/stack/tile/tram
	footstep = FOOTSTEP_CATWALK
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_turf = FALSE
	rcd_proof = TRUE

/turf/open/floor/tram/examine(mob/user)
	. += ..()
	. += span_notice("Os parafusos de reforço são[EXAMINE_HINT("wrenched")]Firmemente nenhum lugar. Use um.[EXAMINE_HINT("wrench")]Para remover uma placa.")

/turf/open/floor/tram/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/stack/thermoplastic))
		build_with_transport_tiles(tool, user)
		return ITEM_INTERACT_SUCCESS
	if(istype(tool, /obj/item/stack/sheet/mineral/titanium))
		build_with_titanium(tool, user)
		return ITEM_INTERACT_SUCCESS
	return NONE

/turf/open/floor/tram/make_plating(force = FALSE)
	if(force)
		return ..()
	return //unplateable

/turf/open/floor/tram/try_replace_tile(obj/item/stack/tile/replacement_tile, mob/user, list/modifiers)
	return

/turf/open/floor/tram/crowbar_act(mob/living/user, obj/item/item)
	return

/turf/open/floor/tram/wrench_act(mob/living/user, obj/item/item)
	..()
	to_chat(user, span_notice("Você começa a remover a placa..."))
	if(item.use_tool(src, user, 30, volume=80))
		if(!istype(src, /turf/open/floor/tram))
			return TRUE
		if(floor_tile)
			new floor_tile(src, 2)
		ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
	return TRUE

/turf/open/floor/tram/ex_act(severity, target)
	if(target == src)
		ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
		return TRUE
	if(is_explosion_shielded(severity))
		return FALSE

	switch(severity)
		if(EXPLODE_DEVASTATE)
			if(prob(80))
				if(!ispath(baseturf_at_depth(2), /turf/open/floor))
					attempt_lattice_replacement()
				else
					ScrapeAway(2, flags = CHANGETURF_INHERIT_AIR)
			else
				break_tile()
		if(EXPLODE_HEAVY)
			if(prob(30))
				if(!ispath(baseturf_at_depth(2), /turf/open/floor))
					attempt_lattice_replacement()
				else
					ScrapeAway(2, flags = CHANGETURF_INHERIT_AIR)
			else
				break_tile()
		if(EXPLODE_LIGHT)
			if(prob(50))
				break_tile()

	return TRUE

/turf/open/floor/tram/broken_states()
	return list("tram_platform-damaged1","tram_platform-damaged2")

/turf/open/floor/tram/tram_platform/burnt_states()
	return list("tram_platform-scorched1","tram_platform-scorched2")

/turf/open/floor/tram/plate
	name = "linear induction plate"
	desc = "A placa de indução linear que alimenta o bonde."
	icon = 'icons/turf/tram.dmi'
	icon_state = "tram_plate"
	base_icon_state = "tram_plate"
	flags_1 = NONE

/turf/open/floor/tram/plate/broken_states()
	return list("tram_plate-damaged1","tram_plate-damaged2")

/turf/open/floor/tram/plate/burnt_states()
	return list("tram_plate-scorched1","tram_plate-scorched2")

/turf/open/floor/tram/plate/energized
	desc = "A placa de indução linear que alimenta o bonde. Está energizado atualmente."
	/// Inbound station
	var/inbound
	/// Outbound station
	var/outbound
	/// Transport ID of the tram
	var/specific_transport_id = TRAMSTATION_LINE_1

/turf/open/floor/tram/plate/energized/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/energized, inbound, outbound, specific_transport_id)

/turf/open/floor/tram/plate/energized/examine(mob/user)
	. = ..()
	if(broken || burnt)
		. += span_danger("Parece danificado e os componentes elétricos expostos!")
		. += span_notice("A placa pode ser reparada usando um[EXAMINE_HINT("titanium sheet")].")

/turf/open/floor/tram/plate/energized/broken_states()
	return list("energized_plate_damaged")

/turf/open/floor/tram/plate/energized/burnt_states()
	return list("energized_plate_damaged")

/turf/open/floor/tram/plate/energized/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!broken && !burnt)
		return NONE
	if(!istype(tool, /obj/item/stack/sheet/mineral/titanium))
		return NONE
	if(!tool.use(1))
		return ITEM_INTERACT_BLOCKING
	broken = FALSE
	update_appearance()
	balloon_alert(user, "Placa substituída.")
	return ITEM_INTERACT_SUCCESS

/turf/open/floor/tram/plate/energized/broken
	broken = TRUE

// Resetting the tram contents to its original state needs the turf to be there
/turf/open/indestructible/tram
	name = "tram guideway"
	icon = 'icons/turf/tram.dmi'
	icon_state = "tram_platform"
	base_icon_state = "tram_platform"
	footstep = FOOTSTEP_CATWALK
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/indestructible/tram/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/stack/thermoplastic))
		build_with_transport_tiles(tool, user)
		return ITEM_INTERACT_SUCCESS
	if(istype(tool, /obj/item/stack/sheet/mineral/titanium))
		build_with_titanium(tool, user)
		return ITEM_INTERACT_SUCCESS
	return NONE

/turf/open/indestructible/tram/plate
	name = "linear induction plate"
	desc = "A placa de indução linear que alimenta o bonde."
	icon_state = "tram_plate"
	base_icon_state = "tram_plate"
	flags_1 = NONE

/turf/open/floor/glass/reinforced/tram/Initialize(mapload)
	. = ..()
	RemoveElement(/datum/element/atmos_sensitive, mapload)

/turf/open/floor/glass/reinforced/tram
	name = "tram bridge"
	desc = "Ele treme um pouco quando você pisa, mas deixa você cruzar os lados rapidamente!"

/obj/structure/thermoplastic
	name = "tram floor"
	desc = "Um piso termoplástico leve."
	icon = 'icons/turf/tram.dmi'
	icon_state = "tram_dark"
	base_icon_state = "tram_dark"
	density = FALSE
	anchored = TRUE
	max_integrity = 150
	integrity_failure = 0.75
	armor_type = /datum/armor/tram_floor
	layer = TRAM_FLOOR_LAYER
	plane = GAME_PLANE
	obj_flags = BLOCK_Z_OUT_DOWN | BLOCK_Z_OUT_UP
	appearance_flags = PIXEL_SCALE|KEEP_TOGETHER
	custom_materials = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT / 2)
	var/secured = TRUE
	var/floor_tile = /obj/item/stack/thermoplastic
	var/mutable_appearance/damage_overlay

/obj/structure/thermoplastic/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/force_move_pulled)

/datum/armor/tram_floor
	melee = 40
	bullet = 10
	laser = 10
	bomb = 45
	fire = 90
	acid = 100

/obj/structure/thermoplastic/light
	icon_state = "tram_light"
	base_icon_state = "tram_light"
	floor_tile = /obj/item/stack/thermoplastic/light

/obj/structure/thermoplastic/examine(mob/user)
	. = ..()

	if(secured)
		. += span_notice("Está seguro com um conjunto de[EXAMINE_HINT("screws.")]Para remover o azulejo use um[EXAMINE_HINT("screwdriver.")]")
	else
		. += span_notice("Você pode.[EXAMINE_HINT("crowbar")]Para remover o azulejo.")
		. += span_notice("Pode ser reassegurado usando um[EXAMINE_HINT("screwdriver.")]")

/obj/structure/thermoplastic/take_damage(damage_amount, damage_type = BRUTE, damage_flag = "", sound_effect = TRUE, attack_dir, armour_penetration = 0)
	. = ..()
	if(.) //received damage
		update_appearance()

/obj/structure/thermoplastic/update_icon_state()
	. = ..()
	var/ratio = atom_integrity / max_integrity
	ratio = ceil(ratio * 4) * 25
	if(ratio > 75)
		icon_state = base_icon_state
		return

	icon_state = "[base_icon_state]_damage[ratio]"

/obj/structure/thermoplastic/screwdriver_act_secondary(mob/living/user, obj/item/tool)
	. = ..()
	if(secured)
		user.visible_message(span_notice("[user] começa a desaparafusar o azulejo..."),
		span_notice("Você começa a desaparafusar o azulejo..."))
		if(tool.use_tool(src, user, 1 SECONDS, volume = 50))
			secured = FALSE
			to_chat(user, span_notice("Os parafusos saem, e uma lacuna se forma na borda do azulejo."))
	else
		user.visible_message(span_notice("[user] começa a apertar o azulejo..."),
		span_notice("Você começa a apertar o azulejo..."))
		if(tool.use_tool(src, user, 1 SECONDS, volume = 50))
			secured = TRUE
			to_chat(user, span_notice("O azulejo está firmemente ferrado no lugar."))

	return ITEM_INTERACT_SUCCESS

/obj/structure/thermoplastic/crowbar_act_secondary(mob/living/user, obj/item/tool)
	. = ..()
	if(secured)
		to_chat(user, span_warning("Os parafusos de segurança precisam ser removidos primeiro!"))
		return FALSE

	else
		user.visible_message(span_notice("[user] Cunhas.\the [tool] na abertura do azulejo na borda e começa a bisbilhotar..."),
		span_notice("Sua cunha.\the [tool] na abertura do painel do bonde no quadro e começar a bisbilhotar..."))
		if(tool.use_tool(src, user, 1 SECONDS, volume = 50))
			to_chat(user, span_notice("O painel sai da modura."))
			var/obj/item/stack/thermoplastic/pulled_tile = new floor_tile()
			pulled_tile.update_integrity(atom_integrity)
			user.put_in_hands(pulled_tile)
			qdel(src)

	return ITEM_INTERACT_SUCCESS

/obj/structure/thermoplastic/welder_act(mob/living/user, obj/item/tool)
	if(atom_integrity >= max_integrity)
		to_chat(user, span_warning("[src] Já está em boas condições!"))
		return ITEM_INTERACT_SUCCESS
	if(!tool.tool_start_check(user, amount = 0, heat_required = HIGH_TEMPERATURE_REQUIRED))
		return FALSE
	to_chat(user, span_notice("Você começa a reparar [src]..."))
	var/integrity_to_repair = max_integrity - atom_integrity
	if(tool.use_tool(src, user, integrity_to_repair * 0.5, volume = 50))
		atom_integrity = max_integrity
		to_chat(user, span_notice("Você conserta.[src]."))
		update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/item/stack/thermoplastic
	name = "thermoplastic tram tile"
	singular_name = "telha termoplástica de bonde"
	desc = "Um piso de alta atração. Brilha na luz."
	icon = 'icons/obj/tiles.dmi'
	lefthand_file = 'icons/mob/inhands/items/tiles_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/tiles_righthand.dmi'
	icon_state = "tile_tram_dark"
	inhand_icon_state = "tile-tram"
	color = COLOR_TRAM_BLUE
	w_class = WEIGHT_CLASS_NORMAL
	force = 1
	throwforce = 1
	throw_speed = 3
	throw_range = 7
	max_amount = 60
	novariants = TRUE
	merge_type = /obj/item/stack/thermoplastic
	mats_per_unit = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT / 2)
	var/tile_type = /obj/structure/thermoplastic

/obj/item/stack/thermoplastic/light
	icon_state = "tile_tram_light"
	color = COLOR_TRAM_LIGHT_BLUE
	merge_type = /obj/item/stack/thermoplastic/light
	tile_type = /obj/structure/thermoplastic/light

/obj/item/stack/thermoplastic/Initialize(mapload, new_amount, merge = TRUE, list/mat_override=null, mat_amt=1)
	. = ..()
	pixel_x = rand(-3, 3)
	pixel_y = rand(-3, 3) //randomize a little

/obj/item/stack/thermoplastic/examine(mob/user)
	. = ..()
	if(throwforce && !is_cyborg) //do not want to divide by zero or show the message to borgs who can't throw
		var/damage_value
		switch(ceil(MAX_LIVING_HEALTH / throwforce)) //throws to crit a human
			if(1 to 3)
				damage_value = "superb"
			if(4 to 6)
				damage_value = "great"
			if(7 to 9)
				damage_value = "good"
			if(10 to 12)
				damage_value = "fairly decent"
			if(13 to 15)
				damage_value = "mediocre"
		if(!damage_value)
			return
		. += span_notice("Isso pode funcionar como um [damage_value] Atirando arma.")
