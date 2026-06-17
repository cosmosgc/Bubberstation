/datum/quirk/unstable
	name = "Unstable"
	desc = "Devido a problemas passados, você é incapaz de recuperar sua sanidade se você perdê-lo. Tenha muito cuidado com seu humor!"
	icon = FA_ICON_ANGRY
	value = -10
	mob_trait = TRAIT_UNSTABLE
	gain_text = span_danger("Tem muita coisa na sua cabeça agora.")
	lose_text = span_notice("Sua mente finalmente está calma.")
	medical_record_text = "A mente do paciente está vulnerável, e não pode se recuperar de eventos traumáticos."
	medical_symptom_text = "Expõe grave instabilidade de humor e incapacidade de se recuperar de estressores psicológicos."
	hardcore_value = 9
	mail_goodies = list(/obj/effect/spawner/random/entertainment/plushie)
	quirk_flags = QUIRK_TRAUMALIKE
