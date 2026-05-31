/mob/living/silicon/Topic(href, href_list)
	. = ..()
	if(href_list["open_door"])
		var/obj/machinery/door/airlock/door = locate(href_list["open_door"]) in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door/airlock)
		var/mob/living/requester = locate(href_list["user"]) in GLOB.mob_list

		if(!requester)
			return
		if(!door)
			return
		fulfill_door_request(requester, door, href_list["action"])

/// Allows the AI to interact somewhat with a door if the requester can be tracked by cameras and the AI can normally access it.
/mob/living/silicon/proc/fulfill_door_request(mob/living/requester, obj/machinery/door/airlock/door, action)
	if(!istype(requester))
		return
	if(!istype(door))
		return

	if(!COOLDOWN_FINISHED(door, answer_cd))
		to_chat(src, span_warning("Seu processador ainda está esfriando."))
		return

	if(!requester.can_track(src))
		to_chat(src, span_notice("Incapaz de rastrear o solicitante."))
		return
	if(door.aiControlDisabled != AI_WIRE_NORMAL)
		to_chat(src, span_notice("Incapaz de acessar a câmara de ar."))
		return

	COOLDOWN_START(door, answer_cd, 10 SECONDS)

	switch(action)
		if("open")
			if(door.locked)
				door.unbolt()
			door.open()
			playsound(door, 'sound/machines/ping.ogg', 50, FALSE, SILENCED_SOUND_EXTRARANGE, ignore_walls = FALSE)
			to_chat(src, "<span class='notice'>Você abre o[door]para[requester].</span>")
		if("bolt")
			if(!door.locked)
				door.bolt()
				door.visible_message(span_danger("Uau, você está muito chateado.[src]Eles trancaram a porta na sua cara!"), vision_distance = COMBAT_MESSAGE_RANGE)
		if("shock")
			door.set_electrified(MACHINE_DEFAULT_ELECTRIFY_TIME)
			playsound(door, 'sound/machines/buzz/buzz-sigh.ogg', 25, FALSE, SILENCED_SOUND_EXTRARANGE, ignore_walls = FALSE)
			door.visible_message(span_notice("A porta toca,[src]Negou seu pedido."), vision_distance = COMBAT_MESSAGE_RANGE)
		if("deny")
			playsound(door, 'sound/machines/buzz/buzz-sigh.ogg', 25, FALSE, SILENCED_SOUND_EXTRARANGE, ignore_walls = FALSE)
			door.visible_message(span_notice("A porta toca,[src]Negou seu pedido."), vision_distance = COMBAT_MESSAGE_RANGE)
			to_chat(src, "Você nega.[requester]O pedido.")
