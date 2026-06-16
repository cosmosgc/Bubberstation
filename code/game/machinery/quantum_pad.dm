/obj/machinery/quantumpad
	name = "quantum pad"
	desc = "Um telepad ligado quântico do espaço azul usado para teletransportar objetos para outras plataformas quânticas."
	icon = 'icons/obj/machines/telepad.dmi'
	icon_state = "qpad-idle"
	base_icon_state = "qpad"
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 10
	obj_flags = CAN_BE_HIT | UNIQUE_RENAME
	circuit = /obj/item/circuitboard/machine/quantumpad
	var/teleport_cooldown = 400 //30 seconds base due to base parts
	var/teleport_speed = 50
	var/last_teleport //to handle the cooldown
	var/teleporting = FALSE //if it's in the process of teleporting
	var/power_efficiency = 1
	var/obj/machinery/quantumpad/linked_pad

	//mapping
	var/static/list/mapped_quantum_pads = list()
	var/map_pad_id = "" as text //what's my name
	var/map_pad_link_id = "" as text //who's my friend

/obj/machinery/quantumpad/Initialize(mapload)
	. = ..()
	if(map_pad_id)
		mapped_quantum_pads[map_pad_id] = src

	AddComponent(/datum/component/usb_port, typecacheof(list(/obj/item/circuit_component/quantumpad), only_root_path = TRUE))

/obj/machinery/quantumpad/Destroy()
	mapped_quantum_pads -= map_pad_id
	return ..()

/obj/machinery/quantumpad/examine(mob/user)
	. = ..()
	. += span_notice("É sim.[ linked_pad ? "currently" : "not"]Ligado a outro bloco.")
	if(!panel_open)
		. += span_notice("O painel é<i>Está ferrado.</i>Entrando, obstruindo o dispositivo de ligação.")
	else
		. += span_notice("O<i>Ligando</i>dispositivo agora é capaz de ser<i>Escaneado.<i>com uma multitool.")

/obj/machinery/quantumpad/RefreshParts()
	. = ..()
	var/E = 0
	for(var/datum/stock_part/capacitor/capacitor in component_parts)
		E += capacitor.tier
	power_efficiency = E
	E = 0
	for(var/datum/stock_part/servo/servo in component_parts)
		E += servo.tier
	teleport_speed = initial(teleport_speed)
	teleport_speed -= (E*10)
	teleport_cooldown = initial(teleport_cooldown)
	teleport_cooldown -= (E * 100)

/obj/machinery/quantumpad/multitool_act(mob/living/user, obj/item/multitool/multi_tool)
	if(panel_open)
		multi_tool.set_buffer(src)
		balloon_alert(user, "Salvo nenhum buffer da multitool")
		to_chat(user, span_notice("Você guarda os dados em [multi_tool] Tampão. Agora pode ser guardado em almofadas com painéis fechados."))
		return ITEM_INTERACT_SUCCESS

	if(istype(multi_tool.buffer, /obj/machinery/quantumpad))
		if(multi_tool.buffer == src)
			balloon_alert(user, "Não pode se ligar a si mesmo!")
			return ITEM_INTERACT_BLOCKING
		linked_pad = multi_tool.buffer
		balloon_alert(user, "Dados carregados fazem buffer")
		return ITEM_INTERACT_SUCCESS

	balloon_alert(user, "Nenhum dado quântico encontrado!")
	return NONE

/obj/machinery/quantumpad/screwdriver_act(mob/living/user, obj/item/tool)
	return default_deconstruction_screwdriver(user, tool)

/obj/machinery/quantumpad/crowbar_act(mob/living/user, obj/item/tool)
	return default_deconstruction_crowbar(user, tool)

/obj/machinery/quantumpad/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/quantum_keycard))
		var/obj/item/quantum_keycard/card = tool
		if(card.qpad)
			to_chat(user, span_notice("Você insere [card] Em [src] Está ativando."))
			interact(user, card.qpad)
			return ITEM_INTERACT_SUCCESS
		to_chat(user, span_notice("Você insere [card] Em [src] O cartão de acesso, iniciando o procedimento de ligação."))
		if(!do_after(user, 4 SECONDS, target = src))
			return ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("Você completa a ligação entre [card] E [src]."))
		card.set_pad(src)
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/machinery/quantumpad/update_icon_state()
	. = ..()
	icon_state = panel_open ? "[base_icon_state]-idle-open" : "[base_icon_state]-idle"

/obj/machinery/quantumpad/interact(mob/user, obj/machinery/quantumpad/target_pad = linked_pad)
	if(QDELETED(target_pad))
		if(map_pad_link_id && initMappedLink())
			target_pad = linked_pad
		else
			to_chat(user, span_warning("Alvo não encontrado!"))
			return
	//SKYRAT EDIT ADDITION
	var/turf/my_turf = get_turf(src)
	if(is_away_level(my_turf.z))
		to_chat(user, "<span class='warning'>[src] Não pode ser usado aqui!</span>")
		return
	//SKYRAT EDIT END

	if(world.time < last_teleport + teleport_cooldown)
		to_chat(user, span_warning("[src] está recarregando o poder. Por favor, espere.[DisplayTimeText(last_teleport + teleport_cooldown - world.time)]."))
		return

	if(teleporting)
		to_chat(user, span_warning("[src] Está carregando. Por favor, espere."))
		return

	if(target_pad.teleporting)
		to_chat(user, span_warning("O alvo está ocupado. Por favor, espere."))
		return

	if(target_pad.machine_stat & NOPOWER)
		to_chat(user, span_warning("O alvo não está respondendo ao sinal."))
		return
	add_fingerprint(user)
	doteleport(user, target_pad)

/obj/machinery/quantumpad/proc/sparks()
	do_sparks(5, TRUE, src, spark_type = /datum/effect_system/basic/spark_spread/quantum)

/obj/machinery/quantumpad/attack_ghost(mob/dead/observer/ghost)
	. = ..()
	if(.)
		return
	if(!linked_pad && map_pad_link_id)
		initMappedLink()
	if(linked_pad)
		ghost.forceMove(get_turf(linked_pad))

/obj/machinery/quantumpad/proc/doteleport(mob/user = null, obj/machinery/quantumpad/target_pad = linked_pad)
	if(!target_pad)
		return
	playsound(get_turf(src), 'sound/items/weapons/flash.ogg', 25, TRUE)
	teleporting = TRUE

	addtimer(CALLBACK(src, PROC_REF(teleport_contents), user, target_pad), teleport_speed)

/obj/machinery/quantumpad/proc/teleport_contents(mob/user, obj/machinery/quantumpad/target_pad)
	teleporting = FALSE
	if(machine_stat & NOPOWER)
		if(user)
			to_chat(user, span_warning("[src] está sem energia!"))
		return
	if(QDELETED(target_pad) || target_pad.machine_stat & NOPOWER)
		if(user)
			to_chat(user, span_warning("A plataforma ligada não está respondendo ao sinal. Teletransporte abortado."))
		return

	last_teleport = world.time

	// use a lot of power
	use_energy(active_power_usage / power_efficiency)
	sparks()
	target_pad.sparks()

	flick("[base_icon_state]-beam", src)
	playsound(get_turf(src), 'sound/items/weapons/emitter2.ogg', 25, TRUE)
	flick("[target_pad.base_icon_state]-beam", target_pad)
	playsound(get_turf(target_pad), 'sound/items/weapons/emitter2.ogg', 25, TRUE)
	for(var/atom/movable/ROI in get_turf(src))
		if(QDELETED(ROI))
			continue //sleeps in CHECK_TICK

		// if is anchored, don't let through
		if(ROI.anchored)
			continue

		if(isliving(ROI))
			var/mob/living/living_subject = ROI
			//only TP living mobs buckled to non anchored items
			if(living_subject.buckled && living_subject.buckled.anchored)
				continue

		do_teleport(ROI, get_turf(target_pad), no_effects = TRUE, channel = TELEPORT_CHANNEL_QUANTUM)
		CHECK_TICK

/obj/machinery/quantumpad/proc/initMappedLink()
	. = FALSE
	var/obj/machinery/quantumpad/link = mapped_quantum_pads[map_pad_link_id]
	if(link)
		linked_pad = link
		. = TRUE

/obj/item/paper/guides/quantumpad
	name = "Quantum Pad For Dummies"
	default_raw_text = "<center><b>Manequins guiam para almofadas quânticas</b></center><br><br><center>Você odeia o conceito de ter que usar suas pernas, muito menos<i>Ande.</i>Para lugares? Bem, com o Bloco Quântico (Tm), nunca mais o medo de cardio vai te impedir de ir a lugares!<br><br><c><b>Como montar sua almofada quântica</b></center><br><br>1. Desenrole o Bloco Quântico que deseja ligar.<br>2. Use sua multi-ferramenta para armazenar o buffer do Quantum Pad (tm) que deseja ligar.<br>3. Aplique a multi-ferramenta na Pad (tm) Quantum secundária que deseja ligar à primeira Pad (tm) Quantum.<br><br><center>Se você seguiu estas instruções cuidadosamente, seu Quantum Pad (tm) agora deve ser devidamente ligado juntos para movimento quase instantânea através da estação! Lembre-se que este é tecnicamente um teletransporte só de ida, então você precisará fazer o mesmo processo com o bloco secundário para o primeiro se quiser viajar entre ambos.</center>"

/obj/item/circuit_component/quantumpad
	display_name = "Pad Quântico"
	desc = "Um telepad ligado quântico do espaço azul usado para teletransportar objetos para outras plataformas quânticas."
	circuit_flags = CIRCUIT_FLAG_INPUT_SIGNAL

	var/datum/port/input/target_pad
	var/datum/port/output/failed

	var/obj/machinery/quantumpad/attached_pad

/obj/item/circuit_component/quantumpad/populate_ports()
	target_pad = add_input_port("Target Pad", PORT_TYPE_ATOM)
	failed = add_output_port("On Fail", PORT_TYPE_SIGNAL)

/obj/item/circuit_component/quantumpad/register_usb_parent(atom/movable/shell)
	. = ..()
	if(istype(shell, /obj/machinery/quantumpad))
		attached_pad = shell

/obj/item/circuit_component/quantumpad/unregister_usb_parent(atom/movable/shell)
	attached_pad = null
	return ..()

/obj/item/circuit_component/quantumpad/input_received(datum/port/input/port)
	if(!attached_pad)
		return

	var/obj/machinery/quantumpad/targeted_pad = target_pad.value

	if((!attached_pad.linked_pad || QDELETED(attached_pad.linked_pad)) && !(targeted_pad && istype(targeted_pad)))
		failed.set_output(COMPONENT_SIGNAL)
		return

	if(world.time < attached_pad.last_teleport + attached_pad.teleport_cooldown)
		failed.set_output(COMPONENT_SIGNAL)
		return

	if(targeted_pad && istype(targeted_pad))
		if(attached_pad.teleporting || targeted_pad.teleporting)
			failed.set_output(COMPONENT_SIGNAL)
			return

		if(targeted_pad.machine_stat & NOPOWER)
			failed.set_output(COMPONENT_SIGNAL)
			return
		attached_pad.doteleport(target_pad = targeted_pad)
	else
		if(attached_pad.teleporting || attached_pad.linked_pad.teleporting)
			failed.set_output(COMPONENT_SIGNAL)
			return

		if(attached_pad.linked_pad.machine_stat & NOPOWER)
			failed.set_output(COMPONENT_SIGNAL)
			return
		attached_pad.doteleport(target_pad = attached_pad.linked_pad)
