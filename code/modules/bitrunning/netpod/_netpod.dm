#define BASE_DISCONNECT_DAMAGE 40
#define SCANNING_TOGGLE_COOLDOWN 5

/obj/machinery/netpod
	name = "netpod"

	base_icon_state = "netpod"
	circuit = /obj/item/circuitboard/machine/netpod
	desc = "Um link para o Netverse. Tem uma variedade de cabos para se conectar a um domínio virtual."
	icon = 'icons/obj/machines/bitrunning.dmi'
	icon_state = "netpod"
	max_integrity = 300
	obj_flags = BLOCKS_CONSTRUCTION
	state_open = TRUE
	interaction_flags_mouse_drop = NEED_HANDS | NEED_DEXTERITY

	/// Whether we have an ongoing connection
	var/connected = FALSE
	/// A player selected outfit by clicking the netpod
	var/datum/outfit/netsuit = /datum/outfit/job/bitrunner
	/// Holds this to see if it needs to generate a new one
	var/datum/weakref/avatar_ref
	/// The linked quantum server
	var/datum/weakref/server_ref
	/// The amount of brain damage done from force disconnects
	var/disconnect_damage
	/// Static list of outfits to select from
	var/list/cached_outfits = list()
	/// Whether bit avatars become visually similar to their bitrunner on first creation
	var/copy_body = FALSE
	/// The next time copy_body can be toggled
	var/scanning_can_toggle = 0


/obj/machinery/netpod/post_machine_initialize()
	. = ..()

	disconnect_damage = BASE_DISCONNECT_DAMAGE
	find_server()

	RegisterSignal(src, COMSIG_ATOM_TAKE_DAMAGE, PROC_REF(on_damage_taken))
	RegisterSignal(src, COMSIG_MACHINERY_POWER_LOST, PROC_REF(on_power_loss))
	RegisterSignals(src, list(COMSIG_QDELETING,	COMSIG_MACHINERY_BROKEN),PROC_REF(on_broken))

	register_context()
	update_appearance()


/obj/machinery/netpod/Destroy()
	. = ..()

	QDEL_LIST(cached_outfits)


/obj/machinery/netpod/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	if(isnull(held_item))
		context[SCREENTIP_CONTEXT_LMB] = "Select Outfit"
	else
		if(held_item.tool_behaviour == TOOL_SCREWDRIVER && !occupant && !state_open)
			context[SCREENTIP_CONTEXT_LMB] = "[panel_open ? "Close" : "Open"] Panel"

		if(held_item.tool_behaviour == TOOL_CROWBAR)
			if(isnull(occupant))
				if(panel_open)
					context[SCREENTIP_CONTEXT_LMB] = "Deconstruct"
				else
					context[SCREENTIP_CONTEXT_LMB] = "[state_open ? "Close" : "Open"] Cover"
			else
				context[SCREENTIP_CONTEXT_LMB] = "Break out"

	context[SCREENTIP_CONTEXT_ALT_LMB] = "[copy_body ? "Disable" : "Enable"] Scan"
	return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/netpod/examine(mob/user)
	. = ..()

	. += span_notice("Its maintenance panel can be [EXAMINE_HINT("screwed")] [panel_open ? "close" : "open"].")
	if(isnull(occupant))
		if(panel_open)
			. += span_notice("It can be [EXAMINE_HINT("pried")] apart.")
		else
			. += span_notice("Its hatch can be [EXAMINE_HINT("pried")] [state_open ? "closed" : "open"].")

	if(isnull(server_ref?.resolve()))
		. += span_infoplain("Não está ligado a nada.")
		. += span_infoplain("Netpods devem ser construídos dentro de 4 peças de um servidor.")
		return

	if(!isobserver(user))
		. += span_infoplain("Arraste-se para a cápsula para ligar o link.")
		. += span_infoplain("Tem capacidade de ressuscitação limitada. Permanecer na cápsula pode curar alguns ferimentos.")
		. += span_infoplain("Tem um sistema de segurança que alertará o ocupante se for adulterado.")
		if(copy_body)
			. += span_infoplain("A varredura de ocupantes está ativada, o que fará com que os avatares pareçam com o ocupante quando criado.")
		. += span_infoplain("Alt-click to [copy_body ? "disable" : "enable"] occupant scanning.")

	if(isnull(occupant))
		. += span_infoplain("Está desocupado.")
		return

	. += span_infoplain("It's currently occupied by [occupant].")

	if(isobserver(user))
		. += span_notice("Como observador, você pode clicar neste netpod para saltar para o seu avatar.")
		return

	. += span_notice("Pode ser aberto com um pé de cabra, mas seus mecanismos de segurança alertarão o ocupante.")


/obj/machinery/netpod/update_icon_state()
	if(!is_operational)
		icon_state = base_icon_state
		return ..()

	if(state_open)
		icon_state = base_icon_state + "_open_active"
		return ..()

	if(panel_open)
		icon_state = base_icon_state + "_panel"
		return ..()

	icon_state = base_icon_state + "_closed"
	if(occupant)
		icon_state += "_active"

	return ..()


/obj/machinery/netpod/mouse_drop_receive(mob/target, mob/user, params)
	var/mob/living/carbon/player = user

	if(!iscarbon(player) || !is_operational || !state_open || player.buckled)
		return

	close_machine(target)


/obj/machinery/netpod/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!state_open && user == occupant)
		container_resist_act(user)


/obj/machinery/netpod/attack_ghost(mob/dead/observer/our_observer)
	var/our_target = avatar_ref?.resolve()
	if(isnull(our_target) || !our_observer.orbit(our_target))
		return ..()


/// When the server is upgraded, drops brain damage a little
/obj/machinery/netpod/proc/on_server_upgraded(obj/machinery/quantum_server/source)
	SIGNAL_HANDLER

	disconnect_damage = BASE_DISCONNECT_DAMAGE * (1 - source.servo_bonus)

/obj/machinery/netpod/click_alt(mob/user)
	if(world.time < scanning_can_toggle)
		return CLICK_ACTION_BLOCKING
	copy_body = !copy_body
	scanning_can_toggle = world.time + SCANNING_TOGGLE_COOLDOWN
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	user.balloon_alert_to_viewers(user, "scanning [copy_body ? "enabled" : "disabled"]")
	return CLICK_ACTION_SUCCESS

#undef BASE_DISCONNECT_DAMAGE
#undef SCANNING_TOGGLE_COOLDOWN
