/datum/quirk/touchy
	name = "Touchy"
	desc = "Você é muito sensível e tem que fisicamente ser capaz de tocar em algo para examiná-lo."
	icon = FA_ICON_HAND
	value = -2
	gain_text = span_danger("Você sente que não pode examinar as coisas à distância.")
	lose_text = span_notice("Você sente que pode examinar as coisas à distância.")
	medical_record_text = "O paciente é incapaz de distinguir objetos à distância."
	hardcore_value = 4

/datum/quirk/touchy/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_CLICK_SHIFT, PROC_REF(examinate_check))

/datum/quirk/touchy/remove()
	UnregisterSignal(quirk_holder, COMSIG_CLICK_SHIFT)

///Checks if the mob is besides the  thing being examined, if they aren't then we cancel their examinate.
/datum/quirk/touchy/proc/examinate_check(mob/examiner, atom/examined)
	SIGNAL_HANDLER

	if(!examined.Adjacent(examiner))
		return COMSIG_MOB_CANCEL_CLICKON
