GLOBAL_VAR_INIT(permit_pin_unrestricted, FALSE)
// Firing pin that can be used off station freely, and requires a permit to use on-station
/obj/item/firing_pin/permit_pin
	name = "permit-locked firing pin"
	desc = "Um alfinete para uma estação que não pode confiar em sua tripulação. Só permite disparar a arma fora do posto ou com permissão de armas."
	icon_state = "firing_pin_explorer"
	fail_message = "As armas de fogo falharam!</span>"

// This checks that the user isn't on the station Z-level.
/obj/item/firing_pin/permit_pin/pin_auth(mob/living/user)
	var/turf/station_check = get_turf(user)

	if(obj_flags & EMAGGED)
		return TRUE

	if(GLOB.permit_pin_unrestricted)
		return TRUE

	var/obj/item/card/id/the_id = user.get_idcard()

	if(!the_id && is_station_level(station_check.z))
		return FALSE

	if(!is_station_level(station_check.z) || (ACCESS_WEAPONS in the_id.GetAccess()))
		return TRUE


/obj/item/firing_pin
	var/can_remove = TRUE

/obj/item/firing_pin/emag_act(mob/user)
	. = ..()
	if(obj_flags & EMAGGED)
		return FALSE
	balloon_alert(user, "Alfinete destrancado!")
	obj_flags |= EMAGGED
	can_remove = TRUE
	return TRUE
