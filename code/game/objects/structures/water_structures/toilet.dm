/obj/structure/toilet
	name = "toilet"
	desc = "O HT-451, uma unidade de descarte de lixo baseado em torque. Este parece muito limpo."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "toilet00" //The first number represents if the toilet lid is up, the second is if the cistern is open.
	base_icon_state = "toilet"
	density = FALSE
	anchored = TRUE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)

	/// Boolean if whether the toilet is currently flushing.
	var/flushing = FALSE
	/// Boolean if the toilet seat is up.
	var/cover_open = FALSE
	/// Boolean if the cistern is up, allowing items to be put in/out.
	var/cistern_open = FALSE
	/// The combined weight of all items in the cistern put together.
	var/w_items = 0
	/// Reference to the mob being given a swirlie.
	var/mob/living/swirlie
	/// Lazylist of items in the cistern.
	var/list/cistern_items
	/// Lazylist of fish in the toilet, not to be mixed with the items in the cistern. Max of 3
	var/list/fishes
	/// Does the toilet have a water recycler to recollect its water supply?
	var/has_water_reclaimer = TRUE
	/// Units of water to reclaim per second
	var/reclaim_rate = 0.5
	/// What reagent does the toilet flush with
	var/reagent_id = /datum/reagent/water
	/// How much reagent can the cistern contain
	var/reagent_capacity = 200
	/// Item stuck in the basin of the toilet
	var/obj/item/stuck_item = null

/obj/structure/toilet/Initialize(mapload, has_water_reclaimer = null)
	. = ..()
	cover_open = round(rand(0, 1))
	if(!isnull(has_water_reclaimer))
		src.has_water_reclaimer = has_water_reclaimer
	update_appearance(UPDATE_ICON)
	if(mapload && SSmapping.level_trait(z, ZTRAIT_STATION))
		AddComponent(/datum/component/fishing_spot, GLOB.preset_fish_sources[/datum/fish_source/toilet])
	AddElement(/datum/element/fish_safe_storage)
	register_context()
	create_reagents(reagent_capacity)
	if(src.has_water_reclaimer)
		reagents.add_reagent(reagent_id, reagent_capacity)
	AddComponent(/datum/component/plumbing/simple_demand/extended)

/obj/structure/toilet/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(user.pulling && isliving(user.pulling))
		context[SCREENTIP_CONTEXT_LMB] = "Give Swirlie"
	if(cover_open)
		if(isnull(held_item))
			if(LAZYLEN(fishes))
				context[SCREENTIP_CONTEXT_LMB] = "Grab Fish"
		else if(istype(held_item, /obj/item/fish))
			context[SCREENTIP_CONTEXT_LMB] = "Insert Fish"
		else if(istype(held_item, /obj/item/plunger))
			context[SCREENTIP_CONTEXT_LMB] = "Unclog"
		else if(held_item.w_class <= WEIGHT_CLASS_SMALL)
			context[SCREENTIP_CONTEXT_LMB] = "Insert Item"
	else if(cistern_open)
		if(isnull(held_item))
			context[SCREENTIP_CONTEXT_LMB] = "Check Cistern"
		else if(held_item.tool_behaviour == TOOL_SCREWDRIVER && has_water_reclaimer)
			context[SCREENTIP_CONTEXT_LMB] = "Remove Reclaimer"
		else if(istype(held_item, /obj/item/stock_parts/water_recycler) && !has_water_reclaimer)
			context[SCREENTIP_CONTEXT_LMB] = "Install Reclaimer"
		else
			context[SCREENTIP_CONTEXT_LMB] = "Insert Item"
	context[SCREENTIP_CONTEXT_RMB] = "Flush"
	context[SCREENTIP_CONTEXT_ALT_LMB] = "[cover_open ? "Close" : "Open"] Lid"
	return CONTEXTUAL_SCREENTIP_SET

/obj/structure/toilet/examine(mob/user)
	. = ..()
	if(cover_open)
		if(LAZYLEN(fishes))
			. += span_notice("Você pode ver peixe no banheiro, você pode provavelmente tirar um.")
		if(stuck_item)
			. += span_notice("Parece haver algo pequeno em [src] A tigela...")
	if(cistern_open && has_water_reclaimer)
		. += span_notice("Um reciclador de água está instalado. Está preso por um par de parafusos.")
		. += span_notice("Sua exibição diz:[reagents.total_volume]/[reagents.maximum_volume] Líquidos restantes.")

/obj/structure/toilet/examine_more(mob/user)
	. = ..()
	if(cistern_open && LAZYLEN(cistern_items))
		. += span_notice("Você pode ver [cistern_items.len] itens dentro da cisterna.")

/obj/structure/toilet/Destroy(force)
	. = ..()
	QDEL_LAZYLIST(fishes)
	QDEL_LAZYLIST(cistern_items)
	QDEL_NULL(stuck_item)

/obj/structure/toilet/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone in cistern_items)
		LAZYREMOVE(cistern_items, gone)
		if (isitem(gone))
			var/obj/item/removed_item = gone
			w_items -= removed_item.w_class
		return
	if(gone in fishes)
		LAZYREMOVE(fishes, gone)
	else if(gone == stuck_item)
		stuck_item = null

/obj/structure/toilet/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return

	if(swirlie)
		user.changeNext_move(CLICK_CD_MELEE)
		playsound(src.loc, SFX_SWING_HIT, 25, TRUE)
		swirlie.visible_message(span_danger("[user] Bate o assento do vaso sanitário em [swirlie] A cabeça!"), span_userdanger("[user] Bate o assento do banheiro na sua cabeça!"), span_hear("Você ouve porcelana reverberante."))
		log_combat(user, swirlie, "swirlied (brute)")
		swirlie.adjust_brute_loss(5)
		return

	if(user.pulling && isliving(user.pulling))
		user.changeNext_move(CLICK_CD_MELEE)
		var/mob/living/grabbed_mob = user.pulling
		if(user.grab_state < GRAB_AGGRESSIVE)
			to_chat(user, span_warning("Você precisa de um aperto mais apertado!"))
			return
		if(grabbed_mob.loc != get_turf(src))
			to_chat(user, span_warning("[grabbed_mob] Precisa estar ligado.[src]!"))
			return
		if(swirlie)
			return
		if(cover_open)
			if(!reagents.total_volume)
				to_chat(user, span_notice("\The [src] Está seco!"))
				return
			grabbed_mob.visible_message(span_danger("[user] começa a dar [grabbed_mob] Um redemoinho!"), span_userdanger("[user] Começa a dar-lhe um giro..."))
			swirlie = grabbed_mob
			var/was_alive = (swirlie.stat != DEAD)
			if(!do_after(user, 3 SECONDS, target = src, timed_action_flags = IGNORE_HELD_ITEM))
				swirlie = null
				return
			if(!reagents.total_volume)
				to_chat(user, span_notice("\The [src] Está seco!"))
				return
			grabbed_mob.visible_message(span_danger("[user] dá [grabbed_mob] Um redemoinho!"), span_userdanger("[user] te dá um redemoinho!"), span_hear("Você ouve uma descarga."))
			if(iscarbon(grabbed_mob))
				var/mob/living/carbon/carbon_grabbed = grabbed_mob
				if(!carbon_grabbed.internal)
					log_combat(user, carbon_grabbed, "swirlied (oxy)")
					carbon_grabbed.adjust_oxy_loss(5)
			else
				log_combat(user, grabbed_mob, "swirlied (oxy)")
				grabbed_mob.adjust_oxy_loss(5)
			if(was_alive && swirlie.stat == DEAD && swirlie.client)
				swirlie.client.give_award(/datum/award/achievement/misc/swirlie, swirlie) // just like space high school all over again!
			swirlie = null
		else
			playsound(src.loc, 'sound/effects/bang.ogg', 25, TRUE)
			grabbed_mob.visible_message(span_danger("[user] Slams [grabbed_mob.name] em [src]!"), span_userdanger("[user] Bate em você [src]!"))
			log_combat(user, grabbed_mob, "toilet slammed")
			grabbed_mob.adjust_brute_loss(5)
		return

	if(cistern_open && !cover_open && IsReachableBy(user))
		if(!LAZYLEN(cistern_items))
			to_chat(user, span_notice("A cisterna está vazia."))
			return
		var/obj/item/random_cistern_item = pick(cistern_items)
		if(ishuman(user))
			user.put_in_hands(random_cistern_item)
		else
			random_cistern_item.forceMove(drop_location())
		to_chat(user, span_notice("Você encontra [random_cistern_item] na cisterna."))
		return

	if(!flushing && LAZYLEN(fishes) && cover_open)
		var/obj/item/random_fish = pick(fishes)
		if(ishuman(user))
			user.put_in_hands(random_fish)
		else
			random_fish.forceMove(drop_location())
		to_chat(user, span_notice("Você pega.[random_fish] Fora do banheiro, coitadinha."))

/obj/structure/toilet/click_alt(mob/living/user)
	if(flushing)
		return CLICK_ACTION_BLOCKING
	cover_open = !cover_open
	update_appearance(UPDATE_ICON)
	return CLICK_ACTION_SUCCESS

/obj/structure/toilet/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(flushing)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(reagents.total_volume <= 50)
		to_chat(user, span_notice("Você aperta a alavanca, mas nada acontece."))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	flushing = TRUE
	var/something_stuck = !isnull(stuck_item)
	if(!something_stuck && LAZYLEN(fishes))
		for(var/obj/item/fish/fish as anything in fishes)
			if(fish.w_class >= WEIGHT_CLASS_NORMAL)
				something_stuck = TRUE
				break

	if(something_stuck)
		reagents.create_foam(/datum/effect_system/fluid_spread/foam, 10, notification = span_danger("[src] transborda, derramando o conteúdo da cisterna por toda parte!"), log = TRUE)
	else
		reagents.remove_all(50)

	begin_reclamation()
	playsound(src, 'sound/machines/toilet_flush.ogg', cover_open ? 40 : 20, TRUE)
	if(cover_open && (dir & SOUTH))
		update_appearance(UPDATE_OVERLAYS)
		flick_overlay_view(mutable_appearance(icon, "[base_icon_state]-water-flick"), 3 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(end_flushing)), 4 SECONDS)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/toilet/update_icon_state()
	icon_state = "[base_icon_state][cover_open][cistern_open]"
	return ..()

/obj/structure/toilet/update_overlays()
	. = ..()
	if(!flushing && cover_open)
		. += "[base_icon_state]-water"

/obj/structure/toilet/dump_contents()
	for(var/obj/toilet_item in (cistern_items + fishes))
		toilet_item.forceMove(drop_location())
	stuck_item?.forceMove(drop_location())

/obj/structure/toilet/atom_deconstruct(dissambled = TRUE)
	dump_contents()
	drop_custom_materials()
	if(has_water_reclaimer)
		new /obj/item/stock_parts/water_recycler(drop_location())

/obj/structure/toilet/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(user.combat_mode)
		return NONE

	add_fingerprint(user)
	if(cover_open && istype(tool, /obj/item/fish))
		if(LAZYLEN(fishes) >= 3)
			to_chat(user, span_warning("Há muitos peixes, descarregue-os primeiro."))
			return ITEM_INTERACT_BLOCKING
		if(!user.transferItemToLoc(tool, src))
			to_chat(user, span_warning("\The [tool] está preso em sua mão!"))
			return ITEM_INTERACT_BLOCKING
		var/obj/item/fish/the_fish = tool
		if(the_fish.status == FISH_DEAD)
			to_chat(user, span_warning("Seu lugar.[tool] em [src] Que descanse em paz."))
		else
			to_chat(user, span_notice("Seu lugar.[tool] em [src] Espero que ninguém sinta falta!"))
		LAZYADD(fishes, tool)
		return ITEM_INTERACT_SUCCESS

	if(cistern_open)
		if(istype(tool, /obj/item/stock_parts/water_recycler))
			if(has_water_reclaimer)
				to_chat(user, span_warning("[src] Já tem um reciclador de água instalado."))
				return ITEM_INTERACT_BLOCKING

			playsound(src, 'sound/machines/click.ogg', 20, TRUE)
			qdel(tool)
			has_water_reclaimer = TRUE
			begin_reclamation()
			return ITEM_INTERACT_SUCCESS

		if(tool.w_class > WEIGHT_CLASS_NORMAL)
			to_chat(user, span_warning("[tool] Não cabe!"))
			return ITEM_INTERACT_BLOCKING
		if(w_items + tool.w_class > WEIGHT_CLASS_HUGE)
			to_chat(user, span_warning("A cisterna está cheia!"))
			return ITEM_INTERACT_BLOCKING
		if(!user.transferItemToLoc(tool, src))
			to_chat(user, span_warning("\The [tool] está preso em sua mão, você não pode colocá-lo na cisterna!"))
			return ITEM_INTERACT_BLOCKING
		add_cistern_item(tool)
		to_chat(user, span_notice("Você cuidadosamente colocar [tool] na cisterna."))
		return ITEM_INTERACT_SUCCESS

	if(!cover_open)
		return NONE

	if(!is_reagent_container(tool))
		if(tool.w_class > WEIGHT_CLASS_SMALL)
			return NONE

		if(stuck_item)
			to_chat(user, span_warning("Já tem algo bloqueando.[src] É o cano de drenagem!"))
			return ITEM_INTERACT_BLOCKING

		if(!user.transferItemToLoc(tool, src))
			to_chat(user, span_warning("\The [tool] está preso em sua mão!"))
			return ITEM_INTERACT_BLOCKING

		stuck_item = tool
		to_chat(user, span_notice("Você caiu.[tool] em [src] É a tigela."))
		return ITEM_INTERACT_SUCCESS

	if(reagents.total_volume <= 0)
		to_chat(user, span_notice("\The [src] está seco."))
		return ITEM_INTERACT_BLOCKING

	if(istype(tool, /obj/item/food/monkeycube))
		var/obj/item/food/monkeycube/cube = tool
		cube.Expand()
		return ITEM_INTERACT_SUCCESS

	var/obj/item/reagent_containers/container = tool
	if(!container.is_refillable())
		return NONE

	if(container.reagents.holder_full())
		to_chat(user, span_notice("\The [container] Está cheio."))
		return ITEM_INTERACT_BLOCKING

	reagents.trans_to(container, container.amount_per_transfer_from_this, transferred_by = user)
	begin_reclamation()
	to_chat(user, span_notice("Você enche.[container] De [src] Nojento."))
	return ITEM_INTERACT_SUCCESS

/// Hides an item inside the toilet for later retrievalk
/obj/structure/toilet/proc/add_cistern_item(obj/item/thing)
	if (isitem(thing))
		w_items += thing.w_class
	LAZYADD(cistern_items, thing)

/obj/structure/toilet/crowbar_act(mob/living/user, obj/item/tool)
	to_chat(user, span_notice("Você começa a[cistern_open ? "replace the lid on" : "lift the lid off"]A cisterna..."))
	playsound(loc, 'sound/effects/stonedoor_openclose.ogg', 50, TRUE)
	if(tool.use_tool(src, user, 30))
		user.visible_message(
			span_notice("[user] [cistern_open ? "replaces the lid on" : "lifts the lid off"]A cisterna!"),
			span_notice("Você.[cistern_open ? "replace the lid on" : "lift the lid off"]A cisterna!"),
			span_hear("Você ouve porcelana."))
		cistern_open = !cistern_open
		update_appearance(UPDATE_ICON_STATE)
	return ITEM_INTERACT_SUCCESS

/obj/structure/toilet/screwdriver_act(mob/living/user, obj/item/tool)
	if(!cistern_open)
		to_chat(user, span_warning("Você precisa abrir.[src] Primeiro a cisterna!"))
		return ITEM_INTERACT_BLOCKING

	if(!has_water_reclaimer)
		to_chat(user, span_warning("\the [src] Não tem um recuperador de água instalado."))
		return ITEM_INTERACT_BLOCKING

	tool.play_tool_sound(src)
	has_water_reclaimer = FALSE
	new /obj/item/stock_parts/water_recycler(drop_location())
	to_chat(user, span_notice("Você remove o recuperador de água de\the [src]."))
	return ITEM_INTERACT_SUCCESS

/obj/structure/toilet/wrench_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	deconstruct()
	return ITEM_INTERACT_SUCCESS

/obj/structure/toilet/plunger_act(obj/item/plunger/attacking_plunger, mob/living/user, reinforced)
	user.balloon_alert_to_viewers("furiously plunging...")
	if(!do_after(user, 3 SECONDS, target = src))
		return TRUE
	user.balloon_alert_to_viewers("finished plunging")
	reagents.expose(get_turf(src), TOUCH) //splash on the floor
	reagents.clear_reagents()
	begin_reclamation()
	if(stuck_item)
		stuck_item.forceMove(drop_location())
		stuck_item = null
	return TRUE

///Ends the flushing animation and updates overlays if necessary
/obj/structure/toilet/proc/end_flushing()
	flushing = FALSE
	if(cover_open && (dir & SOUTH))
		update_appearance(UPDATE_OVERLAYS)
	QDEL_LAZYLIST(fishes)

/obj/structure/toilet/proc/begin_reclamation()
	START_PROCESSING(SSobj, src)

/obj/structure/toilet/process(seconds_per_tick)
	// Water reclamation complete?
	if(!has_water_reclaimer || reagents.total_volume >= reagents.maximum_volume)
		return PROCESS_KILL
	reagents.add_reagent(reagent_id, reclaim_rate * seconds_per_tick)

/obj/structure/toilet/greyscale
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	custom_materials = null
	has_water_reclaimer = FALSE

/obj/structure/toilet/secret
	var/secret_type = null

/obj/structure/toilet/secret/Initialize(mapload)
	. = ..()
	if(!secret_type)
		return
	var/obj/item/secret = new secret_type(src)
	secret.desc += " It's a secret!"
	add_cistern_item(secret)

///A toilet made of meat that only drops remains when deconstructed, often unleashed unto this cursed plane of existence by hopeless people off'ing themselves with experi-scanners.
/obj/structure/toilet/greyscale/flesh
	desc = "Uma massa horrível de carne fundida parecida com um banheiro padrão modelo HT-451. Como consegue funcionar como alguém está além de você. Este parece ser feito da carne de um empregado dedicado do departamento de Rnd."

/obj/structure/toilet/greyscale/flesh/Initialize(mapload, mob/living/carbon/suicide)
	. = ..()
	///The suicide victim's brain that will be placed inside the toilet's cistern
	var/obj/item/organ/brain/toilet_brain
	if(suicide)
		toilet_brain = suicide.get_organ_slot(ORGAN_SLOT_BRAIN)
		for(var/obj/item/thing in suicide)
			if (suicide.transferItemToLoc(thing, newloc = src, silent = TRUE))
				add_cistern_item(thing)
		suicide.gib(DROP_BRAIN) //we delete everything but the brain, as it's going to be moved to the cistern
		set_custom_materials(list(SSmaterials.get_material(/datum/material/meat/mob_meat, suicide) = SHEET_MATERIAL_AMOUNT))
	else
		toilet_brain = new(drop_location())
		set_custom_materials(list(/datum/material/meat = SHEET_MATERIAL_AMOUNT))

	toilet_brain.forceMove(src)
	add_cistern_item(toilet_brain)

//this also prevents the toilet from dropping meat sheets. if you want to cheese the meat exepriments, sacrifice more people
/obj/structure/toilet/greyscale/flesh/atom_deconstruct(dissambled = TRUE)
	for(var/obj/toilet_item in cistern_items)
		toilet_item.forceMove(drop_location())
	new /obj/effect/decal/remains/human(loc)
