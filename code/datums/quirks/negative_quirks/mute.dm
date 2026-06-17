/datum/quirk/mute
	name = "Mute"
	desc = "Por alguma razão você é completamente incapaz de falar."
	icon = FA_ICON_VOLUME_XMARK
	value = -4
	mob_trait = TRAIT_MUTE
	gain_text = span_danger("Você não consegue falar!")
	lose_text = span_notice("Você sente uma força crescente em suas cordas vocais.")
	medical_record_text = "O paciente é incapaz de usar sua voz em qualquer capacidade."
	hardcore_value = 4
