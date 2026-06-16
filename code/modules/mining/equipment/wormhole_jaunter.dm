/**********************Jaunter**********************/
/obj/item/wormhole_jaunter
	name = "wormhole jaunter"
	desc = "Um dispositivo de uso único que utiliza tecnologia de wormhole desatualizada, Nanotrasen tem virado seus olhos para o espaço azul para teletransporte mais preciso. Os buracos de minhoca que ele cria são desagradáveis para viajar, para dizer o mínimo.\nGraças às modificações fornecidas pelos Golems Livres, este jaunter pode ser usado no cinto para fornecer proteção contra abismos."
	icon = 'icons/obj/mining.dmi'
	icon_state = "Jaunter"
	inhand_icon_state = "electronic"
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 3
	throw_range = 5
	slot_flags = ITEM_SLOT_BELT

/obj/item/wormhole_jaunter/attack_self(mob/user)
	user.visible_message(span_notice("[user.name] Ativa.\the [src]!"))
	SSblackbox.record_feedback("tally", "jaunter", 1, "User") // user activated
	activate(user, TRUE)

/obj/item/wormhole_jaunter/proc/turf_check(mob/user)
	var/turf/device_turf = get_turf(src)
	if(!device_turf || is_centcom_level(device_turf.z) || is_reserved_level(device_turf.z))
		if(user)
			to_chat(user, span_notice("Você está tendo dificuldades em conseguir\the [src] Trabalho."))
		return FALSE
	return TRUE

/obj/item/wormhole_jaunter/proc/get_destinations()
	var/list/destinations = list()

	for(var/obj/item/beacon/B in GLOB.teleportbeacons)
		var/turf/T = get_turf(B)
		if(is_station_level(T.z))
			destinations += B

	return destinations

/obj/item/wormhole_jaunter/proc/can_jaunter_teleport()
	var/list/destinations = get_destinations()
	return destinations.len > 0

/obj/item/wormhole_jaunter/proc/activate(mob/user, adjacent, teleport)
	if(!turf_check(user))
		return FALSE

	if(!can_jaunter_teleport())
		if(user)
			to_chat(user, span_notice("\The [src] Não encontramos sinais no mundo para ancorar um buraco de minhoca."))
		else
			visible_message(span_notice("\The [src] Não encontrei nenhum farol no mundo para ancorar um buraco de minhoca!"))
		return FALSE

	var/list/destinations = get_destinations()
	var/chosen_beacon = pick(destinations)

	var/obj/effect/portal/jaunt_tunnel/tunnel = new (get_turf(src), 100, null, FALSE, get_turf(chosen_beacon))
	if(teleport)
		tunnel.teleport(user)
	else if(adjacent)
		try_move_adjacent(tunnel)

	qdel(src)
	return TRUE

/obj/item/wormhole_jaunter/emp_act(power)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return

	var/triggered = FALSE
	if(power == 1)
		triggered = TRUE
	else if(power == 2 && prob(50))
		triggered = TRUE

	var/mob/M = loc
	if(istype(M) && triggered)
		M.visible_message(span_userdanger("Sua [src.name] Sobrecarga e ativa!"))
		SSblackbox.record_feedback("tally", "jaunter", 1, "EMP") // EMP accidental activation
		activate(M, FALSE, TRUE)
	else if(triggered)
		visible_message(span_warning("\The [src] Sobrecarga e ativa!"))
		activate()

/obj/item/wormhole_jaunter/equipped(mob/user, slot, initial)
	. = ..()
	if (slot & ITEM_SLOT_BELT)
		RegisterSignal(user, COMSIG_MOVABLE_CHASM_DROPPED, PROC_REF(chasm_react))

/obj/item/wormhole_jaunter/dropped(mob/user, silent)
	. = ..()
	UnregisterSignal(user, COMSIG_MOVABLE_CHASM_DROPPED)

/obj/item/wormhole_jaunter/proc/chasm_react(mob/living/user, turf/chasm)
	SIGNAL_HANDLER

	if(!activate(user, FALSE, TRUE))
		return

	to_chat(user, span_userdanger("Sua [src] Ativa, salvando você de\the [chasm]!"))
	chasm.visible_message(span_boldwarning("[user] Cai em\the [chasm]!")) // To freak out any bystanders
	SSblackbox.record_feedback("tally", "jaunter", 1, "Chasm") // Chasm automatic activation
	return COMPONENT_NO_CHASM_DROP

//jaunter tunnel
/obj/effect/portal/jaunt_tunnel
	name = "jaunt tunnel"
	icon = 'icons/effects/anomalies.dmi'
	icon_state = "vortex"
	desc = "Um buraco estável no universo feito por um batedor de fendas. Turbulento nem sequer começa a descrever como é difícil passar por um desses, mas pelo menos ele sempre vai levá-lo a algum lugar perto de um farol."
	mech_sized = TRUE //save your ripley
	innate_accuracy_penalty = 6
	light_on = FALSE
	wibbles = FALSE

/obj/effect/portal/jaunt_tunnel/teleport(atom/movable/M, force = FALSE)
	. = ..()
	if(.)
		// KERPLUNK
		playsound(M,'sound/items/weapons/resonator_blast.ogg',50,TRUE)
		if(iscarbon(M))
			var/mob/living/carbon/L = M
			L.Paralyze(60)
			if(ishuman(L))
				shake_camera(L, 20, 1)
				addtimer(CALLBACK(L, TYPE_PROC_REF(/mob/living/carbon, vomit)), 2 SECONDS)
