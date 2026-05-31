/obj/structure/sink/attackby(obj/item/attacking_item, mob/living/user, params)
	if(busy)
		to_chat(user, span_warning("Alguém já está se lavando aqui!"))
		return

	if(istype(attacking_item, /obj/item/towel))
		if(reagents.total_volume <= 0)
			to_chat(user, span_notice("\The [src]está seco."))
			return FALSE

		busy = TRUE
		user.visible_message(span_notice("[user]Começa a lavar.[attacking_item]em[src]."), span_notice("Você começa a lavar.[attacking_item]em[src]."))

		if(!do_after(user, 2 SECONDS, src))
			busy = FALSE
			to_chat(user, span_warning("Você pega.[attacking_item]longe de[src]Antes que termine de lavar."))
			return FALSE

		var/obj/item/towel/washed_towel = attacking_item

		washed_towel.reagents.remove_all(washed_towel.reagents.total_volume)
		washed_towel.transfer_reagents_to_towel(reagents, washed_towel.reagents.maximum_volume, user)

		washed_towel.set_wet(TRUE)
		washed_towel.make_used(user, silent = TRUE)

		user.visible_message(span_notice("[user]termina de lavar.[attacking_item]em[src]."), span_notice("Você termina de lavar.[washed_towel]em[src], deixando-o bastante molhado."))
		playsound(loc, 'sound/effects/slosh.ogg', 25, TRUE)

		busy = FALSE

	else
		return ..()

