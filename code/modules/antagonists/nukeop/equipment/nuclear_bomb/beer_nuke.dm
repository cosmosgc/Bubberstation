/// A fake nuke that actually contains beer.
/obj/machinery/nuclearbomb/beer
	name = "\improper Nanotrasen-brand nuclear fission explosive"
	desc = "Uma das conquistas mais bem sucedidas da Divisão de Guerra Corporativa Nanotrasen, seus explosivos de fissão nuclear são conhecidos por serem baratos para produzir e devastadoresmente eficazes. Sinais explicam que apesar deste dispositivo ter sido desativado, cada estação Nanotrasen está equipada com um equivalente, só por precaução. Todos os capitães guardam cuidadosamente o disco necessário para detoná-los - pelo menos, a placa diz que sim. Parece haver uma torneira na parte de trás."
	proper_bomb = FALSE
	/// The keg located within the beer nuke.
	var/obj/structure/reagent_dispensers/beerkeg/keg
	/// Reagent that is produced once the nuke detonates.
	var/flood_reagent = /datum/reagent/consumable/ethanol/beer
	/// Round event control we might as well keep track of instead of locating every time
	var/datum/round_event_control/scrubber_overflow/every_vent/overflow_control

/obj/machinery/nuclearbomb/beer/Initialize(mapload)
	. = ..()
	keg = new(src)
	QDEL_NULL(core)
	overflow_control = locate(/datum/round_event_control/scrubber_overflow/every_vent) in SSevents.control

/obj/machinery/nuclearbomb/beer/Destroy()
	UnregisterSignal(overflow_control, COMSIG_CREATED_ROUND_EVENT)
	. = ..()

/obj/machinery/nuclearbomb/beer/examine(mob/user)
	. = ..()
	if(keg.reagents.total_volume)
		. += span_notice("Tem.[keg.reagents.total_volume] Unidade esquerda.")
	else
		. += span_danger("Está vazio.")

/obj/machinery/nuclearbomb/beer/attackby(obj/item/weapon, mob/user, list/modifiers, list/attack_modifiers)
	if(weapon.is_refillable())
		weapon.interact_with_atom(keg, user) // redirect refillable containers to the keg, allowing them to be filled
		return TRUE // pretend we handled the attack, too.

	return ..()

/obj/machinery/nuclearbomb/beer/actually_explode()
	if(core)
		return ..()
	//Unblock roundend, we're not actually exploding.
	SSticker.roundend_check_paused = FALSE
	var/turf/bomb_location = get_turf(src)
	if(!bomb_location)
		disarm_nuke()
		return
	if(is_station_level(bomb_location.z))
		addtimer(CALLBACK(src, PROC_REF(really_actually_explode)), 11 SECONDS)
	else
		visible_message(span_notice("[src] Tem um som sinistro."))
		addtimer(CALLBACK(src, PROC_REF(local_foam)), 11 SECONDS)

/obj/machinery/nuclearbomb/beer/disarm_nuke(mob/disarmer)
	exploding = FALSE
	exploded = TRUE
	return ..()

/obj/machinery/nuclearbomb/beer/proc/local_foam()
	do_foam(200, src, get_turf(src), flood_reagent, 100)
	disarm_nuke()

/obj/machinery/nuclearbomb/beer/really_actually_explode(detonation_status)
	if(core)
		return ..()
	//if it's always hooked in it'll override admin choices
	RegisterSignal(overflow_control, COMSIG_CREATED_ROUND_EVENT, PROC_REF(on_created_round_event))
	disarm_nuke()
	overflow_control.run_event(event_cause = "a beer nuke")

/// signal sent from overflow control when it fires an event
/obj/machinery/nuclearbomb/beer/proc/on_created_round_event(datum/round_event_control/source_event_control, datum/round_event/scrubber_overflow/every_vent/created_event)
	SIGNAL_HANDLER
	UnregisterSignal(overflow_control, COMSIG_CREATED_ROUND_EVENT)
	created_event.forced_reagent_type = flood_reagent
