/obj/item/cortical_cage
	name = "cortical borer cage"
	desc = "Uma gaiola inofensiva destinada a capturar furos corticais."
	icon = 'modular_skyrat/modules/cortical_borer/icons/items.dmi'
	icon_state = "cage"

	///If true, the trap is "open" and can trigger.
	var/opened = FALSE
	///The radio that is inserted into the trap.
	var/obj/item/radio/internal_radio
	///The borer that is inside the trap
	var/mob/living/basic/cortical_borer/trapped_borer

/obj/item/cortical_cage/Initialize(mapload)
	. = ..()
	update_appearance()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(spring_trap),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/item/cortical_cage/update_overlays()
	. = ..()
	if(trapped_borer)
		. += "borer"
	if(internal_radio)
		. += "radio"
	if(opened)
		. += "doors_open"
	else
		. += "doors_closed"

/obj/item/cortical_cage/attack_self(mob/user, modifiers)
	opened = !opened
	if(opened)
		user.visible_message("[user]Abre.[src].", "Você abre.[src].", "Você ouve uma batida metálica.")
	else
		user.visible_message("[user]Fecha.[src].", "Você fecha.[src].", "Você ouve uma batida metálica.")
	playsound(src, 'sound/machines/airlock/boltsup.ogg', 30, TRUE)
	update_appearance()

/obj/item/cortical_cage/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/radio))
		internal_radio = attacking_item
		internal_radio.forceMove(src)
		visible_message("[internal_radio]se liga a[src]com um clique.", "Você anexa[internal_radio]para o[src].", "Você ouve um clique.")
		update_appearance()
		return
	return ..()

/obj/item/cortical_cage/crowbar_act(mob/living/user, obj/item/tool)
	. = ..()
	if(internal_radio)
		internal_radio.forceMove(get_turf(src))
		user.visible_message("[internal_radio]Sai.[src].", "Você vai embora.[internal_radio]De[src].", "Você ouve um estalido e um som metálico alto.")
		internal_radio = null
		update_appearance()
		return

/obj/item/cortical_cage/proc/spring_trap(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	//it will only trigger on a cortical borer, and it has to be opened
	if(!iscorticalborer(AM) || !opened)
		return
	trapped_borer = AM
	trapped_borer.visible_message("[trapped_borer]é sugado para dentro[src]!", "Você é sugado[src]!", "Você ouve um som de aspirador.")
	trapped_borer.forceMove(src)
	opened = FALSE
	if(internal_radio)
		var/area/src_area = get_area(src)
		internal_radio.talk_into(src, "A cortical borer has been trapped in [src_area].", RADIO_CHANNEL_COMMON)
	playsound(src, 'sound/machines/airlock/boltsup.ogg', 30, TRUE)
	update_appearance()

/obj/item/cortical_cage/relaymove(mob/living/user, direction)
	if(!iscorticalborer(user))
		user.forceMove(get_turf(src))
		update_appearance()
		return
	if(opened)
		loc.visible_message(span_notice("[user]Subindo para fora[src]!"), 		span_warning("[user]pula para fora[src]!"))
		opened = FALSE
		trapped_borer.forceMove(get_turf(src))
		trapped_borer = null
		update_appearance()
		return
	else if(user.client)
		container_resist_act(user)

/obj/item/cortical_cage/container_resist_act(mob/living/user)
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	to_chat(user, span_notice("Você começa a apertar através das barras na tentativa de escapar! Isso vai levar tempo."))
	to_chat(loc, span_warning("Viu?[user]Comece a tentar passar pelas barras!"))
	if(!do_after(user, rand(30 SECONDS, 40 SECONDS), target = user) || opened || !(user in contents))
		return
	loc.visible_message(span_warning("[user]se espreme através[src]As alças!"), null, null, null, user)
	to_chat(user, span_boldannounce("Bingo, você passa!"))
	opened = FALSE
	trapped_borer.forceMove(get_turf(src))
	trapped_borer = null
	update_appearance()
