/obj/item/organ/vocal_cords //organs that are activated through speech with the :x/MODE_KEY_VOCALCORDS channel
	name = "vocal cords"
	icon_state = "appendix"
	zone = BODY_ZONE_PRECISE_MOUTH
	slot = ORGAN_SLOT_VOICE
	gender = PLURAL
	decay_factor = 0 //we don't want decaying vocal cords to somehow matter or appear on scanners since they don't do anything damaged
	healing_factor = 0
	var/list/spans = null

/obj/item/organ/vocal_cords/proc/can_speak_with() //if there is any limitation to speaking with these cords
	return TRUE

/obj/item/organ/vocal_cords/proc/speak_with(message) //do what the organ does
	return

/obj/item/organ/vocal_cords/proc/handle_speech(message) //actually say the message
	owner.say(message, spans = spans, sanitize = FALSE)

/obj/item/organ/adamantine_resonator
	name = "adamantine resonator"
	desc = "Fragmentos de adamantina existem em todos os golems, decorrentes de suas origens como construções puramente mágicas. Estes estão acostumados a\"Ouvir\"Mensagens de seus líderes."
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_ADAMANTINE_RESONATOR
	icon_state = "adamantine_resonator"

/obj/item/organ/vocal_cords/adamantine
	name = "adamantine vocal cords"
	desc = "Quando a adamantina ressoa, faz com que todas as peças próximas de adamantina ressoem também. Golems contendo estas formações usam isso para transmitir mensagens para os golems próximos."
	actions_types = list(/datum/action/item_action/organ_action/use/adamantine_vocal_cords)
	icon_state = "adamantine_cords"

/datum/action/item_action/organ_action/use/adamantine_vocal_cords/do_effect(trigger_flags)
	var/message = tgui_input_text(owner, "Resonate a message to all nearby golems", "Resonate", max_length = MAX_MESSAGE_LEN)
	if(!message)
		return FALSE
	if(QDELETED(src) || QDELETED(owner))
		return FALSE
	owner.say(".x[message]")
	return TRUE

/obj/item/organ/vocal_cords/adamantine/handle_speech(message)
	var/msg = span_resonate("[span_name("[owner.real_name]")]Ressoa,\"[message]\"")
	for(var/player in GLOB.player_list)
		if(iscarbon(player))
			var/mob/living/carbon/speaker = player
			if(speaker.get_organ_slot(ORGAN_SLOT_ADAMANTINE_RESONATOR))
				to_chat(speaker, msg, type = MESSAGE_TYPE_RADIO, avoid_highlighting = speaker == owner)
		else if(isobserver(player))
			var/link = FOLLOW_LINK(player, owner)
			to_chat(player, "[link] [msg]", type = MESSAGE_TYPE_RADIO)
