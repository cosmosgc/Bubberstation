/* /mob/living/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/status_indicator)
 */

/// Toggle admin frozen
/mob/living/proc/toggle_admin_freeze(client/admin)
	admin_frozen = !admin_frozen

	if(admin_frozen)
		SetStun(INFINITY, ignore_canstun = TRUE)
	else
		SetStun(0, ignore_canstun = TRUE)

	if(client && admin)
		to_chat(src, span_userdanger("Um administrador tem[!admin_frozen ? "un" : ""]Congelou você."))
		log_admin("[key_name(admin)] toggled admin-freeze on [key_name(src)].")
		message_admins("[key_name_admin(admin)] toggled admin-freeze on [key_name_admin(src)].")

/// Toggle admin sleeping
/mob/living/proc/toggle_admin_sleep(client/admin)
	admin_sleeping = !admin_sleeping

	if(admin_sleeping)
		SetSleeping(INFINITY)
	else
		SetSleeping(0)

	if(client && admin)
		to_chat(src, span_userdanger("Um administrador tem[!admin_sleeping ? "un": ""]Eu dormi com você."))
		log_admin("[key_name(admin)] toggled admin-sleep on [key_name(src)].")
		message_admins("[key_name_admin(admin)] toggled admin-sleep on [key_name_admin(src)].")
