/datum/quirk/gifted
	name = "Gifted"
	desc = "Você nasceu um pouco sortudo, inteligente, ou algo no meio. Você pode fazer um pouco mais."
	icon = FA_ICON_DOVE
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_HIDE_FROM_SCAN
	value = -6
	mob_trait = TRAIT_GIFTED
	gain_text = span_danger("Você se sente um pouco mais flexível.")
	lose_text = span_notice("Você se sente menos flexível.")
	medical_record_text = "O paciente tem um histórico de fortuna estranha."
	hardcore_value = 0
