/obj/machinery/posialert
	name = "automated positronic alert console"
	desc = "Um console que tocará quando uma personalidade positrônica estiver disponível para download."
	icon = 'modular_skyrat/modules/positronic_alert_console/icons/terminals.dmi'
	icon_state = "posialert"
	// to create a cooldown so if roboticists are tired of ghosts
	COOLDOWN_DECLARE(robotics_cooldown)
	/// the reason that the console is muted (player decided)
	var/mute_reason
	// to create a cooldown so ghosts cannot spam it
	COOLDOWN_DECLARE(ghost_cooldown)
	/// The encryption key typepath that will be used by the console.
	var/radio_key = /obj/item/encryptionkey/headset_sci
	/// The radio used to send messages over the science channel.
	var/obj/item/radio/radio

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/posialert, 28)

/obj/machinery/posialert/examine(mob/user)
	. = ..()
	if(!COOLDOWN_FINISHED(src, robotics_cooldown))
		. += span_notice("O tempo restante em silêncio é[COOLDOWN_TIMELEFT(src, robotics_cooldown) * 0.1]segundos.")
		. += span_notice("Razão Muda:[mute_reason]")
	. += span_notice("Pressione a tela para silenciar ou soltar o console.")

/obj/machinery/posialert/Initialize(mapload)
	. = ..()
	radio = new(src)
	radio.keyslot = new radio_key
	radio.set_listening(FALSE)
	radio.recalculateChannels()

/obj/machinery/posialert/Destroy()
	QDEL_NULL(radio)
	. = ..()

/obj/machinery/posialert/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!COOLDOWN_FINISHED(src, robotics_cooldown))
		COOLDOWN_RESET(src, robotics_cooldown)
		to_chat(user, span_notice("Você removeu o mudo.[src]."))
		return
	mute_reason = null
	mute_reason = stripped_input(user, "What would the reason for the mute be? (max characters is 20)", "Mute Reason", "", 20)
	if(!mute_reason)
		to_chat(user, span_warning("[src]requer uma razão para se calar!"))
		return
	COOLDOWN_START(src, robotics_cooldown, 5 MINUTES)
	to_chat(user, span_notice("Você se calou.[src]Por cinco minutos."))

/obj/machinery/posialert/attack_ghost(mob/user)
	. = ..()
	if(!COOLDOWN_FINISHED(src, robotics_cooldown))
		to_chat(user, span_warning("[src]Foi silenciado! O tempo restante em silêncio é[COOLDOWN_TIMELEFT(src, robotics_cooldown) * 0.1]segundos."))
		to_chat(user, span_warning("[src]A razão muda:[mute_reason]"))
		return
	if(!COOLDOWN_FINISHED(src, ghost_cooldown))
		to_chat(user, span_warning("[src]No momento, ainda está em repouso! O tempo restante na refrigeração é[COOLDOWN_TIMELEFT(src, ghost_cooldown) * 0.1]segundos."))
		return
	COOLDOWN_START(src, ghost_cooldown, 30 SECONDS)
	flick("posialertflash",src)
	say("There are positronic personalities available.")
	radio.talk_into(src, "There are positronic personalities available.", RADIO_CHANNEL_SCIENCE)
	playsound(loc, 'sound/machines/ping.ogg', 50)
