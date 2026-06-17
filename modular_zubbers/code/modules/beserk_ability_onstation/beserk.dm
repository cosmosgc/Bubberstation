/datum/action/item_action/berserk_mode/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return FALSE
	if(!lavaland_equipment_pressure_check(get_turf(owner)))
		if(feedback)
			to_chat(owner, span_warning("Você não pode usar isso em um ambiente pressurizado!"))
		return FALSE
	return TRUE
