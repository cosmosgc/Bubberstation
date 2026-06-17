/// Handles all special considerations for "virtual entities" such as bitrunning ghost roles or digital anomaly antagonists.
/datum/component/virtual_entity
	/// The cooldown for balloon alerts, so the player isn't spammed while trying to enter a restricted area.
	COOLDOWN_DECLARE(OOB_cooldown)


/datum/component/virtual_entity/Initialize(obj/machinery/quantum_server)
	if(quantum_server.obj_flags & EMAGGED)
		jailbreak_mobs()
		return COMPONENT_REDUNDANT

	RegisterSignal(parent, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(on_parent_pre_move))
	RegisterSignal(quantum_server, COMSIG_ATOM_EMAG_ACT, PROC_REF(on_emagged))


/// Self-destructs the component, allowing free-roam by all entities with this restriction.
/datum/component/virtual_entity/proc/jailbreak_mobs()
	to_chat(parent, span_bolddanger("Você treme por um momento com uma sensação de clareza que nunca sentiu antes."))
	to_chat(parent, span_notice("Você poderia ir.<i>Em qualquer lugar</i>, faça<i>Qualquer coisa.</i>Pode deixar essa simulação agora, se quiser!"))
	to_chat(parent, span_danger("Mas esteja avisado, o emaranhamento quântico interferirá em qualquer vida anterior."))
	to_chat(parent, span_notice("Você terá apenas uma chance de ir Nova, e não há como voltar atrás."))


/// Remove any restrictions AFTER the mob has spawned
/datum/component/virtual_entity/proc/on_emagged(datum/source)
	SIGNAL_HANDLER

	jailbreak_mobs()
	qdel(src)


/// Prevents entry to a certain area if it has flags preventing virtual entities from entering.
/datum/component/virtual_entity/proc/on_parent_pre_move(atom/movable/source, atom/new_location)
	SIGNAL_HANDLER

	var/area/location_area = get_area(new_location)
	if(!location_area)
		stack_trace("Virtual entity entered a location with no area!")
		return

	if(location_area.area_flags_mapping & VIRTUAL_SAFE_AREA)
		source.balloon_alert(source, "Fora dos limites!")
		COOLDOWN_START(src, OOB_cooldown, 2 SECONDS)
		return COMPONENT_MOVABLE_BLOCK_PRE_MOVE

