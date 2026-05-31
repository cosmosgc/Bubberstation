/obj/structure/urinal
	name = "urinal"
	desc = "O HU-452, um mictório experimental. Vem completa com bolo de urina experimental."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "urinal"
	density = FALSE
	anchored = TRUE
	/// Can you currently put an item inside
	var/exposed = FALSE
	/// What's in the urinal
	var/obj/item/hidden_item

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/urinal, 32)

/obj/structure/urinal/Initialize(mapload)
	. = ..()
	if(mapload)
		hidden_item = new /obj/item/food/urinalcake(src)
		find_and_mount_on_atom()

/obj/structure/urinal/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == hidden_item)
		hidden_item = null

/obj/structure/urinal/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return

	if(user.pulling && isliving(user.pulling))
		var/mob/living/grabbed_mob = user.pulling
		if(user.grab_state >= GRAB_AGGRESSIVE)
			if(grabbed_mob.loc != get_turf(src))
				to_chat(user, span_notice("[grabbed_mob.name]Precisa está ligada.[src]."))
				return
			user.changeNext_move(CLICK_CD_MELEE)
			user.visible_message(span_danger("[user]Slams[grabbed_mob]Em[src]!"), span_danger("Você bate[grabbed_mob]Em[src]!"))
			grabbed_mob.emote("scream")
			grabbed_mob.adjust_brute_loss(8)
		else
			to_chat(user, span_warning("Você precisa de um aperto mais apertado!"))
		return

	if(exposed)
		if(hidden_item)
			to_chat(user, span_notice("Você pesca.[hidden_item]fora do compartimento de drenagem."))
			user.put_in_hands(hidden_item)
		else
			to_chat(user, span_warning("Não há nada no suporte do dreno!"))
		return
	return ..()

/obj/structure/urinal/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	if(exposed)
		if(hidden_item)
			to_chat(user, span_warning("Já há algo no compartimento de drenagem!"))
			return
		if(attacking_item.w_class > WEIGHT_CLASS_TINY)
			to_chat(user, span_warning("[attacking_item]É muito grande para o compartimento de drenagem."))
			return
		if(!user.transferItemToLoc(attacking_item, src))
			to_chat(user, span_warning("[attacking_item]está preso em sua mão, você não pode colocá-lo no compartimento de drenagem!"))
			return
		hidden_item = attacking_item
		to_chat(user, span_notice("Seu lugar.[attacking_item]Não compartimento de drenagem."))
		return
	return ..()

/obj/structure/urinal/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	to_chat(user, span_notice("Você começa a[exposed ? "screw the cap back into place" : "unscrew the cap to the drain protector"]..."))
	playsound(loc, 'sound/effects/stonedoor_openclose.ogg', 50, TRUE)
	if(I.use_tool(src, user, 20))
		user.visible_message(span_notice("[user] [exposed ? "screws the cap back into place" : "unscrew the cap to the drain protector"]!"),
			span_notice("Você.[exposed ? "screw the cap back into place" : "unscrew the cap on the drain"]!"),
			span_hear("Você ouve metal e faz barulho."))
		exposed = !exposed
	return TRUE

/obj/structure/urinal/wrench_act_secondary(mob/living/user, obj/item/tool)
	tool.play_tool_sound(user)
	deconstruct(TRUE)
	balloon_alert(user, "Urino removido")
	return ITEM_INTERACT_SUCCESS

/obj/structure/urinal/atom_deconstruct(disassembled = TRUE)
	new /obj/item/wallframe/urinal(loc)
	hidden_item?.forceMove(drop_location())

/obj/item/wallframe/urinal
	name = "urinal frame"
	desc = "Um mictório desmontado. Coloque em uma parede para usar."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "urinal"
	result_path = /obj/structure/urinal
	pixel_shift = 32

/obj/item/food/urinalcake
	name = "urinal cake"
	desc = "O bolo nobre, protegendo os canos da estação do xixi da estação. Não coma."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "urinalcake"
	w_class = WEIGHT_CLASS_TINY
	food_reagents = list(
		/datum/reagent/chlorine = 3,
		/datum/reagent/ammonia = 1,
	)
	foodtypes = TOXIC | GROSS
	preserved_food = TRUE

/obj/item/food/urinalcake/attack_self(mob/living/user)
	user.visible_message(span_notice("[user]Esmaga.[src]!"), span_notice("Você aperta.[src]."), "<i>Você ouve um squish.</i>")
	icon_state = "urinalcake_squish"
	addtimer(VARSET_CALLBACK(src, icon_state, "urinalcake"), 0.8 SECONDS)
