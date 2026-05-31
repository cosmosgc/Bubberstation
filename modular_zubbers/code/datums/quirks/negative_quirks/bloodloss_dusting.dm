/datum/quirk/bloodloss_dusting
	name = "Dusting Sickness"
	desc = "Se ficar sem sangue ao ponto de uma pessoa normal morrer, você vira pó."
	value = -8
	gain_text = span_danger("Você começa a se preocupar ainda mais em ficar sem sangue.")
	lose_text = span_notice("Você acha que ficar sem sangue não é assustador.")
	medical_record_text = "O corpo do paciente tem uma reação extrema à perda de sangue ao ponto de desmoronar em pó. Mantendo os níveis sanguíneos estáveis recomendados."
	icon = FA_ICON_DROPLET_SLASH

/datum/quirk/bloodloss_dusting/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_HUMAN_ON_HANDLE_BLOOD, PROC_REF(on_change_blood))

/datum/quirk/bloodloss_dusting/proc/on_change_blood(mob/living/carbon/human/source, seconds_per_tick, times_fired)
	SIGNAL_HANDLER
	if(!istype(source))
		return
	if(source.blood_volume < BLOOD_VOLUME_SURVIVE)
		to_chat(quirk_holder, span_danger("Você ficou sem sangue!"))
		quirk_holder.investigate_log("has been dusted by a lack of blood. Caused by [src.name] quirk", INVESTIGATE_DEATHS)
		quirk_holder.dust()

/datum/quirk/bloodloss_dusting/remove()
	UnregisterSignal(quirk_holder, COMSIG_HUMAN_ON_HANDLE_BLOOD)
