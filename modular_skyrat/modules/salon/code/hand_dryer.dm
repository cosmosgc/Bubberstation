/obj/machinery/dryer
	name = "hand dryer"
	desc = "O Breath of Lizards-3000, um secador experimental."
	icon = 'modular_skyrat/modules/salon/icons/dryer.dmi'
	icon_state = "dryer"
	density = FALSE
	anchored = TRUE
	var/busy = FALSE

/obj/machinery/dryer/attack_hand(mob/user)
	if(iscyborg(user) || isAI(user))
		return

	if(!can_interact(user))
		return

	if(busy)
		to_chat(user, span_warning("Alguém já está secando aqui."))
		return

	to_chat(user, span_notice("Começa a secar as mãos."))
	playsound(src, 'modular_skyrat/modules/salon/sound/drying.ogg', 50)
	add_fingerprint(user)
	busy = TRUE
	if(do_after(user, 4 SECONDS, src))
		busy = FALSE
		user.visible_message("[user] dried their hands using \the [src].")
	else
		busy = FALSE
