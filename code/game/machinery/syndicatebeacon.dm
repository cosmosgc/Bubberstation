////////////////////////////////////////
//Singularity beacon
////////////////////////////////////////
/obj/machinery/power/singularity_beacon
	name = "ominous beacon"
	desc = "Isso parece suspeito..."
	icon = 'icons/obj/machines/engine/singularity.dmi'
	icon_state = "beacon0"

	anchored = FALSE
	density = TRUE
	layer = BELOW_MOB_LAYER //so people can't hide it and it's REALLY OBVIOUS
	verb_say = "states"
	/// Cooldown each time singularity is pulled in our direction
	COOLDOWN_DECLARE(singularity_beacon_cd)

	var/active = FALSE
	var/icontype = "beacon"
	var/energy_used = 1.5 KILO JOULES


/obj/machinery/power/singularity_beacon/proc/Activate(mob/user = null)
	if(surplus() < 1500)
		if(user)
			to_chat(user, span_notice("O fio conectado não tem corrente suficiente."))
		return
	icon_state = "[icontype]1"
	active = TRUE
	if(user)
		to_chat(user, span_notice("Você ativa o farol."))


/obj/machinery/power/singularity_beacon/proc/Deactivate(mob/user = null)
	for(var/datum/component/singularity/singulo as anything in GLOB.singularities)
		if(singulo.target == src)
			singulo.target = null
	icon_state = "[icontype]0"
	active = FALSE
	if(user)
		to_chat(user, span_notice("Você desativa o farol."))

/obj/machinery/power/singularity_beacon/attack_ai(mob/user)
	return

/obj/machinery/power/singularity_beacon/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(anchored)
		return active ? Deactivate(user) : Activate(user)
	else
		to_chat(user, span_warning("Você precisa transar.\the [src] Para o chão primeiro!"))

/obj/machinery/power/singularity_beacon/wrench_act(mob/living/user, obj/item/tool)
	. = TRUE
	if(active)
		to_chat(user, span_warning("Você precisa desativar.\the [src] Primero!"))
		return

	if(anchored)
		tool.play_tool_sound(src, 50)
		set_anchored(FALSE)
		to_chat(user, span_notice("Você destranca.\the [src] do chão e separe-o do cabo."))
		disconnect_from_network()
		return
	else
		if(!connect_to_network())
			to_chat(user, span_warning("\The [src] Deve ser colocado sobre um nó de cabo exposto e alimentado!"))
			return
		tool.play_tool_sound(src, 50)
		set_anchored(TRUE)
		to_chat(user, span_notice("Você vai embora.\the [src] para o chão e prenda-o ao cabo."))
		return

/obj/machinery/power/singularity_beacon/screwdriver_act(mob/living/user, obj/item/tool)
	user.visible_message( 			"[user] Mexe com\the [src] Por um tempo.", 			span_notice("Você não pode colocar a chave de fenda\the [src] São parafusos! Tente usar uma chave inglesa."))
	return TRUE

/obj/machinery/power/singularity_beacon/Destroy()
	if(active)
		Deactivate()
	return ..()

//stealth direct power usage
/obj/machinery/power/singularity_beacon/process()
	if(!active)
		return

	if(surplus() >= energy_used)
		add_load(energy_used)
		if(COOLDOWN_FINISHED(src, singularity_beacon_cd))
			COOLDOWN_START(src, singularity_beacon_cd, 8 SECONDS)
			for(var/datum/component/singularity/singulo_component as anything in GLOB.singularities)
				var/atom/singulo = singulo_component.parent
				if(singulo.z == z)
					singulo_component.target = src
					say("[singulo] is now [get_dist(src,singulo)] standard lengths away to the [dir2text(get_dir(src,singulo))]")
	else
		Deactivate()
		say("Insufficient charge detected - powering down")

// Used for the No Escape final objective that attracts a singularity to the escape shuttle
// needs to be charged with an inducer to work
/obj/machinery/power/singularity_beacon/syndicate/no_escape
	name = "ominous beacon"
	desc = "Isso parece muito suspeito..."
	processing_flags = START_PROCESSING_MANUALLY
	/// The cell we spawn with
	var/obj/item/stock_parts/power_store/cell/cell = /obj/item/stock_parts/power_store/cell/super/empty
	/// The black hole shuttle event that is triggered
	var/datum/shuttle_event/simple_spawner/black_hole/no_escape/no_escape_event

/obj/machinery/power/singularity_beacon/syndicate/no_escape/Initialize(mapload)
	. = ..()
	cell = new cell(src)

/obj/machinery/power/singularity_beacon/syndicate/no_escape/Destroy()
	if(active)
		Deactivate()
	QDEL_NULL(cell)
	// destroying the beacon doesn't automatically stop the event
	no_escape_event = null
	return ..()

/obj/machinery/power/singularity_beacon/syndicate/no_escape/examine(mob/user)
	. = ..()
	. += "\The [src] is [active ? "on" : "off"]."
	if(cell)
		. += "The charge meter reads [cell ? round(cell.percent(), 1) : 0]%."

/obj/machinery/power/singularity_beacon/syndicate/no_escape/get_cell()
	return cell

/obj/machinery/power/singularity_beacon/syndicate/no_escape/attack_hand(mob/user, list/modifiers)
	return active ? Deactivate(user) : Activate(user)

/obj/machinery/power/singularity_beacon/syndicate/no_escape/Activate(mob/user = null)
	if(!cell.charge())
		say("Insufficient charge detected")
		return

	icon_state = "[icontype]1"
	active = TRUE
	begin_processing()
	if(user)
		to_chat(user, span_notice("Você ativa o farol."))

/obj/machinery/power/singularity_beacon/syndicate/no_escape/Deactivate(mob/user = null)
	icon_state = "[icontype]0"
	active = FALSE
	end_processing()
	if(user)
		to_chat(user, span_notice("Você desativa o farol."))

/obj/machinery/power/singularity_beacon/syndicate/no_escape/wrench_act(mob/living/user, obj/item/tool)
	. = TRUE

	tool.play_tool_sound(src, 50)
	if(anchored)
		set_anchored(FALSE)
		to_chat(user, span_notice("Você destranca.\the [src] Do chão."))
		return
	else
		set_anchored(TRUE)
		to_chat(user, span_notice("Você vai embora.\the [src] Para o chão."))
		return

/obj/machinery/power/singularity_beacon/syndicate/no_escape/screwdriver_act(mob/living/user, obj/item/tool)
	return

/obj/machinery/power/singularity_beacon/syndicate/no_escape/emp_act(severity)
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN) || . & EMP_PROTECT_CONTENTS)
		return
	cell?.emp_act(severity)

/obj/machinery/power/singularity_beacon/syndicate/no_escape/process()
	if(cell.charge())
		cell.use(energy_used, force = TRUE)

		if(!no_escape_event)
			var/area/escape_shuttle_area = get_area(src)
			// beacon must be on the traveling escape shuttle (not a pod)
			if(istype(escape_shuttle_area, /area/shuttle/escape) && (SSshuttle.emergency.mode == SHUTTLE_ESCAPE) && SSshuttle.emergency.is_in_shuttle_bounds(src))
				var/obj/docking_port/mobile/port = SSshuttle.emergency
				no_escape_event = port.add_shuttle_event(/datum/shuttle_event/simple_spawner/black_hole/no_escape)
				no_escape_event.beacon = src
	else
		Deactivate()
		say("Insufficient charge detected - powering down")

/obj/machinery/power/singularity_beacon/syndicate
	icontype = "beaconsynd"
	icon_state = "beaconsynd0"

// SINGULO BEACON SPAWNER
/obj/item/sbeacondrop
	name = "suspicious beacon"
	icon = 'icons/obj/devices/tracker.dmi'
	icon_state = "beacon"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	desc = "Um rótulo nele diz:<i>Aviso: ativar este dispositivo enviará um sinal especial para sua localização.</i>."
	w_class = WEIGHT_CLASS_SMALL
	var/droptype = /obj/machinery/power/singularity_beacon/syndicate


/obj/item/sbeacondrop/attack_self(mob/user)
	if(user)
		to_chat(user, span_notice("Fechado."))
		new droptype( user.loc )
		playsound(src, 'sound/effects/pop.ogg', 100, TRUE, TRUE)
		qdel(src)
	return

/obj/item/sbeacondrop/no_escape
	name = "very suspicious beacon"
	droptype = /obj/machinery/power/singularity_beacon/syndicate/no_escape

/obj/item/sbeacondrop/bomb
	desc = "Um rótulo nele diz:<i>Aviso: ativar este dispositivo enviará um explosivo de alta ordem para sua localização.</i>."
	droptype = /obj/machinery/syndicatebomb

/obj/item/sbeacondrop/emp
	desc = "Um rótulo nele diz:<i>Aviso: ativar este dispositivo enviará um dispositivo eletromagnético de alta potência para sua localização.</i>."
	droptype = /obj/machinery/syndicatebomb/emp

/obj/item/sbeacondrop/powersink
	desc = "Um rótulo nele diz:<i>Aviso: ativar este dispositivo enviará um dispositivo de drenagem de energia para sua localização.</i>."
	droptype = /obj/item/powersink

/obj/item/sbeacondrop/clownbomb
	desc = "Um rótulo nele diz:<i>Aviso: ativar este dispositivo enviará um explosivo bobo para sua localização.</i>."
	droptype = /obj/machinery/syndicatebomb/badmin/clown

/obj/item/sbeacondrop/horse
	desc = "Um rótulo nele diz:<i>Aviso: ativar este dispositivo enviará um cavalo vivo para sua localização.</i>"
	droptype = /mob/living/basic/pony/syndicate
