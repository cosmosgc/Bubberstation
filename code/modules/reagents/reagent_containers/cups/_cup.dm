/obj/item/reagent_containers/cup
	name = "open container"
	abstract_type = /obj/item/reagent_containers/cup
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5, 10, 15, 20, 25, 30, 50)
	volume = 50
	initial_reagent_flags = OPENCONTAINER | DUNKABLE
	resistance_flags = ACID_PROOF
	icon_state = "bottle"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	reagent_container_liquid_sound = SFX_DEFAULT_LIQUID_SLOSH

	/// Like Edible's food type, what kind of drink is this?
	var/drink_type = NONE
	/// The last time we have checked for taste.
	var/last_check_time
	/// How much we drink at once, shot glasses drink more.
	var/gulp_size = 5
	/// Whether the 'bottle' is made of glass or not so that milk cartons dont shatter when someone gets hit by it.
	var/isGlass = FALSE
	/// What kind of chem transfer method does this cup use. Defaults to INGEST
	var/reagent_consumption_method = INGEST
	/// What sound does our consumption play on consuming from the container?
	var/consumption_sound = 'sound/items/drink.ogg'
	/// Whether to allow heating up the contents with a source of flame.
	var/heatable = TRUE
	/// Can we put a lid on this container?
	var/can_lid = FALSE
	/// Does this container have a lid on right now?
	var/has_lid = FALSE
	/// Assembly attached to our lid
	var/obj/item/assembly_holder/lid_assembly = null
	/// Power cell duct-taped to the side of the beaker
	var/obj/item/stock_parts/power_store/cell/attached_cell = null
	/// Have we added wiring to the cell?
	var/cell_wired = FALSE
	/// Visual y-offset for the assembly on our lid
	var/assembly_pixel_y = 0
	/// If TRUE, after we finish drinking, we try to drink again after do_after
	var/loop_drink = FALSE

/obj/item/reagent_containers/cup/Initialize(mapload, vol)
	. = ..()
	if(heatable)
		AddElement(/datum/element/reagents_item_heatable)

/obj/item/reagent_containers/cup/Destroy(force)
	QDEL_NULL(lid_assembly)
	QDEL_NULL(attached_cell)
	return ..()

/obj/item/reagent_containers/cup/examine(mob/user)
	. = ..()
	if(drink_type)
		var/list/types = bitfield_to_list(drink_type, FOOD_FLAGS)
		. += span_notice("O rótulo diz que contém[LOWER_TEXT(english_list(types))]Ingredientes.")
	if(can_lid)
		if(has_lid)
			. += span_notice("Está selado com uma tampa de borracha laranja brilhante[!isnull(lid_assembly) ? "with an assembly attached ontop of it" : ""].")
		else
			. += span_notice("Pode ser selado com uma tampa usando[EXAMINE_HINT("Alt-Click")].")

/**
 * Checks if the mob actually liked drinking this cup.
 *
 * This is a bunch of copypaste from the edible component, consider reworking this to use it!
 */
/obj/item/reagent_containers/cup/proc/checkLiked(fraction, mob/eater)
	if(last_check_time + 5 SECONDS > world.time)
		return FALSE
	if(!ishuman(eater))
		return FALSE
	var/mob/living/carbon/human/gourmand = eater
	//Bruh this breakfast thing is cringe and shouldve been handled separately from food-types, remove this in the future (Actually, just kill foodtypes in general)
	if((drink_type & BREAKFAST) && world.time - SSticker.round_start_time < STOP_SERVING_BREAKFAST)
		gourmand.add_mood_event("breakfast", /datum/mood_event/breakfast)
	last_check_time = world.time

	var/food_taste_reaction = gourmand.get_food_taste_reaction(src, drink_type)
	switch(food_taste_reaction)
		if(FOOD_TOXIC)
			to_chat(gourmand,span_warning("O que é isso?"))
			gourmand.adjust_disgust(25 + 30 * fraction)
			gourmand.add_mood_event("toxic_food", /datum/mood_event/disgusting_food)
		if(FOOD_DISLIKED)
			to_chat(gourmand,span_notice("Não foi muito bom..."))
			gourmand.adjust_disgust(11 + 15 * fraction)
			gourmand.add_mood_event("gross_food", /datum/mood_event/gross_food)
		if(FOOD_LIKED)
			to_chat(gourmand,span_notice("Adoro esse gosto!"))
			gourmand.adjust_disgust(-5 + -2.5 * fraction)
			gourmand.add_mood_event("fav_food", /datum/mood_event/favorite_food)

/obj/item/reagent_containers/cup/proc/try_drink(mob/living/target_mob, mob/living/user)
	if(!canconsume(target_mob, user))
		return ITEM_INTERACT_BLOCKING

	user.changeNext_move(CLICK_CD_MELEE)
	if(target_mob != user)
		if(DOING_INTERACTION_WITH_TARGET(user, target_mob))
			return ITEM_INTERACT_BLOCKING
		target_mob.visible_message(
			span_danger("[user]Tentativas de se alimentar[target_mob]Algo de[src]."),
			span_userdanger("[user]Tenta te alimentar de algo.[src]."),
		)
		if(!do_after(user, 3 SECONDS, target_mob))
			return ITEM_INTERACT_BLOCKING
		if(!reagents || !reagents.total_volume)
			return ITEM_INTERACT_BLOCKING // The drink might be empty after the delay, such as by spam-feeding
		target_mob.visible_message(
			span_danger("[user]ração[target_mob]Algo de[src]."),
			span_userdanger("[user]Te comida de algo[src]."),
		)
		if(target_mob.is_blind())
			to_chat(target_mob, span_notice("Você sente que alguém te dá algo."))
		log_combat(user, target_mob, "fed", reagents.get_reagent_log_string())

	else
		if(loop_drink)
			if(DOING_INTERACTION_WITH_TARGET(user, user))
				return ITEM_INTERACT_BLOCKING
			user.visible_message(
				span_danger("[user]Tentando beber de[src]."),
				span_userdanger("[user]Tentando beber de[src]."),
			)
			if(!do_after(user, 1.25 SECONDS, user))
				return ITEM_INTERACT_BLOCKING
			if(!reagents || !reagents.total_volume)
				return ITEM_INTERACT_BLOCKING
			user.visible_message(
				span_danger("[user]bebidas de[src]."),
				span_userdanger("[user]bebidas de[src]."),
				ignored_mobs = list(user),
			)
		to_chat(user, span_notice("Você engoliu um gole de[src]."))

	SEND_SIGNAL(src, COMSIG_GLASS_DRANK, target_mob, user)
	SEND_SIGNAL(target_mob, COMSIG_GLASS_DRANK, src, user) // SKYRAT EDIT ADDITION - Hemophages can't casually drink what's not going to regenerate their blood
	var/fraction = min(gulp_size / reagents.total_volume, 1)
	reagents.trans_to(target_mob, gulp_size, transferred_by = user, methods = reagent_consumption_method)
	var/atom/movable/screen/hunger/hunger_bar = user.hud_used?.screen_objects[HUD_MOB_HUNGER]
	if (istype(hunger_bar))
		hunger_bar.update_hunger_bar()
	checkLiked(fraction, target_mob)
	playsound(target_mob, consumption_sound, rand(10, 50), TRUE)
	var/list/datum/disease/diseases_to_add
	for(var/datum/disease/malady as anything in target_mob.get_static_viruses())
		if(malady.spread_flags & DISEASE_SPREAD_CONTACT_FLUIDS)
			LAZYADD(diseases_to_add, malady)
	if(LAZYLEN(diseases_to_add))
		AddComponent(/datum/component/infective, diseases_to_add)
	if(loop_drink)
		return try_drink(target_mob, user) | ITEM_INTERACT_SUCCESS

	return ITEM_INTERACT_SUCCESS

/obj/item/reagent_containers/cup/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(!is_open_container())
		return NONE

	if(target.is_refillable()) //Something like a glass. Player probably wants to transfer TO it.
		return try_refill(target, user)

	if(target.is_drainable()) //A dispenser. Transfer FROM it TO us.
		return try_drain(target, user)

	if(isliving(target))
		return try_drink(target, user)

	return NONE

/obj/item/reagent_containers/cup/interact_with_atom_secondary(atom/target, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(!is_open_container())
		return NONE

	if(target.is_drainable()) //A dispenser. Transfer FROM it TO us.
		return try_drain(target, user)

	return NONE

/obj/item/reagent_containers/cup/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(has_lid && istype(tool, /obj/item/assembly_holder))
		if (lid_assembly)
			to_chat(user, span_warning("[src]A tampa já tem uma montagem ligada a ela!"))
			return ITEM_INTERACT_BLOCKING

		if (attach_assembly(tool, user))
			playsound(src, 'sound/machines/click.ogg', 50, TRUE)
			return ITEM_INTERACT_SUCCESS
		return ITEM_INTERACT_BLOCKING

	if (lid_assembly && istype(tool, /obj/item/stock_parts/power_store/cell))
		if (attached_cell)
			to_chat(user, span_warning("[src]Já tem.\a [attached_cell]Apegado a ele!"))
			return ITEM_INTERACT_BLOCKING

		if (isnull(locate(/obj/item/assembly/igniter) in lid_assembly))
			to_chat(user, span_warning("[lid_assembly]não tem uma ignição para conectar[src]Pará!"))
			return ITEM_INTERACT_BLOCKING

		if (!user.transferItemToLoc(tool, src))
			to_chat(user, span_warning("[tool]está preso em sua mão!"))
			return ITEM_INTERACT_BLOCKING

		to_chat(user, span_notice("Você anexa[tool]Por baixo.[src]Um tampa."))
		add_fingerprint(user)
		log_bomber(user, "attached [tool.name] to", src)
		attached_cell = tool
		attached_cell.pixel_y = 0
		attached_cell.pixel_z = -4
		update_appearance()
		playsound(src, 'sound/machines/click.ogg', 50, TRUE)
		return ITEM_INTERACT_SUCCESS

	if (attached_cell && istype(tool, /obj/item/stack/cable_coil))
		if (cell_wired)
			to_chat(user, span_warning("[attached_cell]Já está ligado a[lid_assembly]!"))
			return ITEM_INTERACT_BLOCKING

		var/obj/item/stack/cable_coil/cable = tool
		if (!cable.use(5))
			to_chat(user, span_warning("Você precisa de pelo menos 5 cabos de arame.[attached_cell]!"))
			return ITEM_INTERACT_BLOCKING

		to_chat(user, span_notice("Você liga.[attached_cell]Para[lid_assembly]."))
		add_fingerprint(user)
		cell_wired = TRUE
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	if(!is_open_container())
		return NONE

	if(istype(tool, /obj/item/food/egg)) //breaking eggs
		if(reagents.holder_full())
			to_chat(user, span_notice("[src]Está cheio."))
			return ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("Você quebra[tool]Em[src]."))
		tool.reagents.trans_to(src, tool.reagents.total_volume, transferred_by = user)
		qdel(tool)
		return ITEM_INTERACT_SUCCESS

	return NONE

/*
 * On accidental consumption, make sure the container is partially glass, and continue to the reagent_container proc
 */
/obj/item/reagent_containers/cup/on_accidental_consumption(mob/living/carbon/M, mob/living/carbon/user, obj/item/source_item, discover_after = TRUE)
	if(isGlass && !custom_materials)
		set_custom_materials(list(SSmaterials.get_material(/datum/material/glass) = 5))//sets it to glass so, later on, it gets picked up by the glass catch (hope it doesn't 'break' things lol)
	return ..()

/// Callback for [datum/component/takes_reagent_appearance] to inherent style footypes
/obj/item/reagent_containers/cup/proc/on_cup_change(datum/glass_style/has_foodtype/style)
	if(!istype(style))
		return
	drink_type = style.drink_type

/// Callback for [datum/component/takes_reagent_appearance] to reset to no foodtypes
/obj/item/reagent_containers/cup/proc/on_cup_reset()
	drink_type = NONE

/obj/item/reagent_containers/cup/update_overlays()
	. = ..()
	if (has_lid)
		. += mutable_appearance(icon, "[icon_state]_lid")
	if (lid_assembly)
		. += lid_assembly
	if (attached_cell)
		. += attached_cell
		if (cell_wired)
			. += mutable_appearance('icons/obj/machines/cell_charger.dmi', "ccharger-[attached_cell.connector_type]-on")

// For player convinience, assume that the lids are rubber and can be pierced with a syringe
/obj/item/reagent_containers/cup/is_refillable()
	return ..() && !has_lid

/obj/item/reagent_containers/cup/is_drainable()
	return ..() && !has_lid

/obj/item/reagent_containers/cup/is_dunkable()
	return ..() && !has_lid

/obj/item/reagent_containers/cup/attack_self(mob/user)
	if (!lid_assembly)
		return ..()
	lid_assembly.attack_self(user)
	return TRUE

/obj/item/reagent_containers/cup/click_alt(mob/user)
	if (!can_lid)
		return NONE

	if (cell_wired)
		balloon_alert(user, "Corte a fiação primeiro!")
		return CLICK_ACTION_BLOCKING

	if (attached_cell)
		var/obj/item/our_cell = attached_cell
		// Exited() automatically clears it
		our_cell.forceMove(drop_location())
		user.put_in_hands(our_cell)
		balloon_alert(user, "Célula separada.")
		update_appearance()
		return CLICK_ACTION_SUCCESS

	if (lid_assembly)
		var/obj/item/our_assembly = lid_assembly
		our_assembly.forceMove(drop_location())
		user.put_in_hands(our_assembly)
		balloon_alert(user, "montagem separada")
		update_appearance()
		return CLICK_ACTION_SUCCESS

	has_lid = !has_lid
	update_appearance()
	balloon_alert(user, "Tampa.[has_lid ? "sealed" : "unsealed"]")
	if (has_lid)
		add_container_flags(SEALED_CONTAINER)
	else
		reset_container_flags()
	return CLICK_ACTION_SUCCESS

/obj/item/reagent_containers/cup/wirecutter_act(mob/living/user, obj/item/tool)
	if (user.combat_mode || !cell_wired)
		return NONE

	new /obj/item/stack/cable_coil(drop_location(), 5)
	cell_wired = FALSE
	update_appearance()
	balloon_alert(user, "Fiação cortada")
	tool.play_tool_sound(src, 50)
	return ITEM_INTERACT_SUCCESS

/obj/item/reagent_containers/cup/proc/attach_assembly(obj/item/assembly_holder/assembly, mob/living/user)
	if (!user.transferItemToLoc(assembly, src))
		to_chat(user, span_warning("[assembly]está preso em sua mão!"))
		return FALSE

	to_chat(user, span_notice("Você anexa[assembly]Para[src]Um tampa."))
	add_fingerprint(user)
	lid_assembly = assembly
	lid_assembly.master = src
	lid_assembly.pixel_y = 0
	lid_assembly.pixel_z = assembly_pixel_y
	lid_assembly.on_attach()
	RegisterSignal(src, COMSIG_IGNITER_ACTIVATE, PROC_REF(on_igniter_activate))
	log_bomber(user, "attached [lid_assembly.name] to", src)
	update_appearance()
	return TRUE

/obj/item/reagent_containers/cup/Exited(atom/movable/gone, direction)
	. = ..()
	if (gone == lid_assembly)
		lid_assembly = null
		UnregisterSignal(src, COMSIG_IGNITER_ACTIVATE)
		update_appearance()
	else if (gone == attached_cell)
		attached_cell = null
		cell_wired = FALSE
		update_appearance()

/obj/item/reagent_containers/cup/proc/on_igniter_activate(datum/source, obj/item/assembly/igniter/igniter)
	SIGNAL_HANDLER
	// We've got an attached cell wired up, so we'll try to spend all of its current first
	if (attached_cell && cell_wired)
		var/power_spent = attached_cell.use(attached_cell.charge())
		// Power cell was rigged
		if (QDELETED(src))
			return

		// We'll be nerfing plasma and welding fuel as they're very easy to get and make for boring bombs
		if (power_spent > 0 && (reagents.spark_act(power_spent, SPARK_ACT_ENCLOSED | SPARK_ACT_WEAKEN_COMMON) & SPARK_ACT_DESTRUCTIVE))
			qdel(src)
			return

	// Igniters heat, condensers chill
	var/igniter_temp = igniter.get_temperature()
	if (igniter_temp > 0)
		reagents.expose_temperature(igniter_temp)

/obj/item/reagent_containers/cup/beaker
	name = "beaker"
	desc = "Um copo. Pode aguentar até 50 unidades."
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "beaker"
	inhand_icon_state = "beaker"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	worn_icon_state = "beaker"
	custom_materials = list(/datum/material/glass=SMALL_MATERIAL_AMOUNT*5)
	fill_icon_thresholds = list(0, 1, 20, 40, 60, 80, 100)
	pickup_sound = 'sound/items/handling/beaker_pickup.ogg'
	drop_sound = 'sound/items/handling/beaker_place.ogg'
	sound_vary = TRUE
	can_lid = TRUE
	assembly_pixel_y = 4

/obj/item/reagent_containers/cup/beaker/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/reagent_containers/cup/beaker/get_part_rating()
	return reagents.maximum_volume

/obj/item/reagent_containers/cup/beaker/jar
	name = "honey jar"
	desc = "Um pote de mel. Pode conter até 50 unidades de doce prazer."
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "vapour"
	can_lid = FALSE

/obj/item/reagent_containers/cup/beaker/large
	name = "large beaker"
	desc = "Um copo grande. Pode aguentar até 100 unidades."
	icon_state = "beakerlarge"
	custom_materials = list(/datum/material/glass= SHEET_MATERIAL_AMOUNT*1.25)
	volume = 100
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,50,100)
	fill_icon_thresholds = list(0, 1, 20, 40, 60, 80, 100)
	assembly_pixel_y = 8

/obj/item/reagent_containers/cup/beaker/plastic
	name = "x-large beaker"
	desc = "Um copo extra-grande. Pode aguentar até 120 unidades."
	icon_state = "beakerwhite"
	inhand_icon_state = "beaker_white"
	custom_materials = list(/datum/material/glass=SHEET_MATERIAL_AMOUNT*1.25, /datum/material/plastic=SHEET_MATERIAL_AMOUNT * 1.5)
	volume = 120
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,60,120)
	fill_icon_thresholds = list(0, 1, 10, 20, 40, 60, 80, 100)
	assembly_pixel_y = 8

/obj/item/reagent_containers/cup/beaker/meta
	name = "metamaterial beaker"
	desc = "Um copo grande. Pode aguentar até 180 unidades."
	icon_state = "beakergold"
	inhand_icon_state = "beaker_gold"
	custom_materials = list(/datum/material/glass=SHEET_MATERIAL_AMOUNT*1.25, /datum/material/plastic=SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/gold=HALF_SHEET_MATERIAL_AMOUNT, /datum/material/titanium=HALF_SHEET_MATERIAL_AMOUNT)
	volume = 180
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,60,120,180)
	fill_icon_thresholds = list(0, 1, 10, 25, 35, 50, 60, 80, 100)
	assembly_pixel_y = 10

/obj/item/reagent_containers/cup/beaker/noreact
	name = "cryostasis beaker"
	desc = "Um copo de criostase que permite armazenamento químico sem reações. Pode aguentar até 50 unidades."
	icon_state = "beakernoreact"
	inhand_icon_state = "beaker_cryo"
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT * 1.5)
	initial_reagent_flags = OPENCONTAINER | NO_REACT
	volume = 50
	amount_per_transfer_from_this = 10
	can_lid = FALSE

/obj/item/reagent_containers/cup/beaker/bluespace
	name = "bluespace beaker"
	desc = "Um copo do espaço azul, alimentado por tecnologia experimental do espaço azul e Element Cuban combinado com o Pete Composto. Pode aguentar até 300 unidades."
	icon_state = "beakerbluespace"
	inhand_icon_state = "beaker_bluespace"
	custom_materials = list(/datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/plasma =SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/diamond =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace =HALF_SHEET_MATERIAL_AMOUNT)
	volume = 300
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10,15,20,25,30,50,100,300)
	can_lid = FALSE

/obj/item/reagent_containers/cup/beaker/meta/omnizine
	list_reagents = list(/datum/reagent/medicine/omnizine = 180)

/obj/item/reagent_containers/cup/beaker/meta/sal_acid
	list_reagents = list(/datum/reagent/medicine/sal_acid = 180)

/obj/item/reagent_containers/cup/beaker/meta/oxandrolone
	list_reagents = list(/datum/reagent/medicine/oxandrolone = 180)

/obj/item/reagent_containers/cup/beaker/meta/pen_acid
	list_reagents = list(/datum/reagent/medicine/pen_acid = 180)

/obj/item/reagent_containers/cup/beaker/meta/atropine
	list_reagents = list(/datum/reagent/medicine/atropine = 180)

/obj/item/reagent_containers/cup/beaker/meta/salbutamol
	list_reagents = list(/datum/reagent/medicine/salbutamol = 180)

/obj/item/reagent_containers/cup/beaker/meta/rezadone
	list_reagents = list(/datum/reagent/medicine/rezadone = 180)

/obj/item/reagent_containers/cup/beaker/cryoxadone
	list_reagents = list(/datum/reagent/medicine/cryoxadone = 30)

/obj/item/reagent_containers/cup/beaker/sulfuric
	list_reagents = list(/datum/reagent/toxin/acid = 50)

/obj/item/reagent_containers/cup/beaker/slime
	list_reagents = list(/datum/reagent/toxin/slimejelly = 50)

/obj/item/reagent_containers/cup/beaker/large/libital
	name = "libital reserve tank (diluted)"
	list_reagents = list(/datum/reagent/medicine/c2/libital = 10,/datum/reagent/medicine/granibitaluri = 40)

/obj/item/reagent_containers/cup/beaker/large/aiuri
	name = "aiuri reserve tank (diluted)"
	list_reagents = list(/datum/reagent/medicine/c2/aiuri = 10, /datum/reagent/medicine/granibitaluri = 40)

/obj/item/reagent_containers/cup/beaker/large/multiver
	name = "multiver reserve tank (diluted)"
	list_reagents = list(/datum/reagent/medicine/c2/multiver = 10, /datum/reagent/medicine/granibitaluri = 40)

/obj/item/reagent_containers/cup/beaker/large/epinephrine
	name = "epinephrine reserve tank (diluted)"
	list_reagents = list(/datum/reagent/medicine/epinephrine = 50)

/obj/item/reagent_containers/cup/beaker/synthflesh
	list_reagents = list(/datum/reagent/medicine/c2/synthflesh = 50)

/obj/item/reagent_containers/cup/beaker/synthflesh/named
	name = "synthflesh beaker"

/obj/item/reagent_containers/cup/bucket
	name = "bucket"
	desc = "É um balde. Você pode espremer o conteúdo de um esfregão usando o botão direito." //SKYRAT EDIT CHANGE - ORIGINAL: desc = "É um balde."
	icon = 'icons/obj/service/janitor.dmi'
	worn_icon = 'icons/mob/clothing/head/utility.dmi'
	icon_state = "bucket"
	inhand_icon_state = "bucket"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	fill_icon_state = "bucket"
	fill_icon_thresholds = list(50, 90)
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2)
	w_class = WEIGHT_CLASS_NORMAL
	amount_per_transfer_from_this = 20
	possible_transfer_amounts = list(5,10,15,20,25,30,50,100) //SKYRAT EDIT CHANGE
	volume = 100 //SKYRAT EDIT CHANGE
	flags_inv = HIDEHAIR
	slot_flags = ITEM_SLOT_HEAD
	resistance_flags = NONE
	armor_type = /datum/armor/cup_bucket
	slot_equipment_priority = list( 		ITEM_SLOT_BACK, ITEM_SLOT_ID,		ITEM_SLOT_ICLOTHING, ITEM_SLOT_OCLOTHING,		ITEM_SLOT_MASK, ITEM_SLOT_HEAD, ITEM_SLOT_NECK,		ITEM_SLOT_FEET, ITEM_SLOT_GLOVES,		ITEM_SLOT_EARS, ITEM_SLOT_EYES,		ITEM_SLOT_BELT, ITEM_SLOT_SUITSTORE,		ITEM_SLOT_LPOCKET, ITEM_SLOT_RPOCKET,		ITEM_SLOT_DEX_STORAGE
	)

/obj/item/reagent_containers/cup/bucket/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/cuffable_item)

/datum/armor/cup_bucket
	melee = 10
	fire = 75
	acid = 50

/obj/item/reagent_containers/cup/bucket/wooden
	name = "wooden bucket"
	icon_state = "woodbucket"
	inhand_icon_state = "woodbucket"
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 3)
	resistance_flags = FLAMMABLE
	armor_type = /datum/armor/bucket_wooden

/datum/armor/bucket_wooden
	melee = 10
	acid = 50

/obj/item/reagent_containers/cup/bucket/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/mop))
		if(reagents.total_volume < 1)
			user.balloon_alert(user, "Vazio!")
			return ITEM_INTERACT_BLOCKING
		reagents.trans_to(tool, 5, transferred_by = user)
		user.balloon_alert(user, "encharcado[tool]")
		playsound(src, 'sound/effects/slosh.ogg', 25, TRUE)
		return ITEM_INTERACT_SUCCESS
	if(isprox(tool)) //This works with wooden buckets for now. Somewhat unintended, but maybe someone will add sprites for it soon(TM)
		to_chat(user, span_notice("Você acrescenta[tool]Para[src]."))
		qdel(tool)
		var/obj/item/bot_assembly/cleanbot/new_cleanbot_ass = new(null, src)
		user.put_in_hands(new_cleanbot_ass)
		return ITEM_INTERACT_SUCCESS

	return ..()

// BUBBER EDIT ADDITION BEGIN - LIQUIDS
/obj/item/reagent_containers/cup/bucket/item_interaction_secondary(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/mop))
		if(tool.reagents.total_volume == 0)
			user.balloon_alert(user, "O esfregão está seco!")
			return ITEM_INTERACT_BLOCKING
		if(reagents.total_volume == reagents.maximum_volume)
			user.balloon_alert(user, "O recipiente está cheio!")
			return ITEM_INTERACT_BLOCKING
		tool.reagents.remove_all(tool.reagents.total_volume * SQUEEZING_DISPERSAL_RATIO)
		tool.reagents.trans_to(src, tool.reagents.total_volume, transferred_by = user)
		user.balloon_alert(user, "esfregão espremido")
		return ITEM_INTERACT_SUCCESS

	. = ..()
// BUBBER EDIT ADDITION END - LIQUIDS

/obj/item/reagent_containers/cup/bucket/equipped(mob/user, slot)
	. = ..()
	if (slot & ITEM_SLOT_HEAD)
		if(reagents.total_volume)
			to_chat(user, span_userdanger("[src]O conteúdo está espalhando em você!"))
			reagents.expose(user, TOUCH)
			reagents.clear_reagents()
		update_container_flags(NONE)

/obj/item/reagent_containers/cup/bucket/dropped(mob/user)
	. = ..()
	reset_container_flags()

/obj/item/reagent_containers/cup/bucket/equip_to_best_slot(mob/M)
	if(reagents.total_volume) //If there is water in a bucket, don't quick equip it to the head
		var/index = slot_equipment_priority.Find(ITEM_SLOT_HEAD)
		slot_equipment_priority.Remove(ITEM_SLOT_HEAD)
		. = ..()
		slot_equipment_priority.Insert(index, ITEM_SLOT_HEAD)
		return
	return ..()

/obj/item/pestle
	name = "pestle"
	desc = "Uma ferramenta antiga e simples usada em conjunto com um argamassa para moer ou itens de suco."
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "pestle"
	force = 7
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)

/obj/item/reagent_containers/cup/mortar
	name = "mortar"
	desc = "Uma tigela especialmente formada de design antigo. É possível esmagar ou espremer itens colocados nele usando um pilão; no entanto, o processo, ao contrário dos métodos modernos, é lento e fisicamente exaustivo."
	desc_controls = "Alt click to eject the item."
	icon_state = "mortar"
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5, 10, 15, 20, 25, 30, 50, 100)
	volume = 100
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 3)
	resistance_flags = FLAMMABLE
	initial_reagent_flags = OPENCONTAINER
	var/obj/item/grinded

/obj/item/reagent_containers/cup/mortar/click_alt(mob/user)
	if(!grinded)
		return CLICK_ACTION_BLOCKING
	grinded.forceMove(drop_location())
	grinded = null
	balloon_alert(user, "ejected")
	return CLICK_ACTION_SUCCESS

/obj/item/reagent_containers/cup/mortar/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(istype(tool, /obj/item/pestle))
		if(!grinded)
			to_chat(user, span_warning("Não há nada para moer!"))
			return ITEM_INTERACT_BLOCKING
		if(user.get_stamina_loss() > 50)
			to_chat(user, span_warning("Você está muito cansado para trabalhar!"))
			return ITEM_INTERACT_BLOCKING
		var/list/choose_options = list(
			"Grind" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_grind"),
			"Juice" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_juice")
		)
		var/picked_option = show_radial_menu(user, src, choose_options, radius = 38, require_near = TRUE)
		if(!grinded || !in_range(src, user) || !user.is_holding(tool) || !picked_option)
			return ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("Você começa a moer..."))
		if(!do_after(user, 2.5 SECONDS, target = src))
			return ITEM_INTERACT_BLOCKING
		user.adjust_stamina_loss(40)
		switch(picked_option)
			if("Juice")
				return juice_item(grinded, user) ? ITEM_INTERACT_BLOCKING : ITEM_INTERACT_SUCCESS
			if("Grind")
				return grind_item(grinded, user) ? ITEM_INTERACT_SUCCESS : ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("Você tenta moer o próprio morteiro em vez de[grinded]Você falhou."))
		return ITEM_INTERACT_BLOCKING
	if(grinded)
		to_chat(user, span_warning("Já tem algo lá dentro!"))
		return ITEM_INTERACT_BLOCKING
	if(!tool.blend_requirements(src, user))
		return ITEM_INTERACT_BLOCKING
	if((length(tool.grind_results()) || tool.reagents?.total_volume) && user.transferItemToLoc(tool, src))
		grinded = tool
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/item/reagent_containers/cup/mortar/blended(obj/item/blended_item, grinded)
	src.grinded = null

	return ..()

/obj/item/reagent_containers/cup/mortar/proc/grind_item(obj/item/item, mob/living/carbon/human/user)
	if(item.flags_1 & HOLOGRAM_1)
		to_chat(user, span_notice("Você tenta moer[item], mas Desapareça!"))
		qdel(item)
		return

	if(!item.grind(reagents, user))
		if(isstack(item))
			to_chat(user, span_notice("[src]Tenta moer tantas peças de[item]o mais possível."))
		else
			to_chat(user, span_danger("Você falha em moer[item]."))
		return

	to_chat(user, span_notice("Você moe[item]em um bom pó."))

/obj/item/reagent_containers/cup/mortar/proc/juice_item(obj/item/item, mob/living/carbon/human/user)
	if(item.flags_1 & HOLOGRAM_1)
		to_chat(user, span_notice("Você tenta suco[item], mas Desapareça!"))
		qdel(item)
		return

	if(!item.juice(reagents, user))
		to_chat(user, span_notice("Você não tem suco.[item]."))
		return

	to_chat(user, span_notice("Seu suco.[item]em um líquido fino."))

//Coffeepots: for reference, a standard cup is 30u, to allow 20u for sugar/sweetener/milk/creamer
/obj/item/reagent_containers/cup/coffeepot
	name = "coffeepot"
	desc = "Um grande pote para dispensar aquela ambrosia da vida corporativa conhecida pelos mortais apenas como café. Contém 4 copos padrão."
	volume = 120
	icon_state = "coffeepot"
	fill_icon_state = "coffeepot"
	fill_icon_thresholds = list(0, 1, 30, 60, 100)

/obj/item/reagent_containers/cup/coffeepot/bluespace
	name = "bluespace coffeepot"
	desc = "O pote de café mais avançado que os cabeças de ovo poderiam cozinhar: design elegante; linhas graduadas; conexão com uma dimensão de bolso para contenção de café; sim, ele tem tudo. Contém 8 copos padrão."
	volume = 240
	icon_state = "coffeepot_bluespace"
	fill_icon_thresholds = null

///Test tubes created by chem master and pandemic and placed in racks
/obj/item/reagent_containers/cup/tube
	name = "tube"
	desc = "Um pequeno tubo de ensaio."
	icon_state = "test_tube"
	fill_icon_state = "tube"
	inhand_icon_state = "atoxinbottle"
	worn_icon_state = "beaker"
	possible_transfer_amounts = list(5, 10, 15, 30)
	volume = 30
	fill_icon_thresholds = list(0, 1, 20, 40, 60, 80, 100)
	can_lid = TRUE

/obj/item/reagent_containers/cup/tube/attach_assembly(obj/item/assembly_holder/assembly, mob/living/user)
	to_chat(user, span_warning("[src]A tampa é muito pequena para caber.[assembly]!"))
	return FALSE
