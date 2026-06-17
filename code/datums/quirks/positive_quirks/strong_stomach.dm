/datum/quirk/strong_stomach
	name = "Strong Stomach"
	desc = "Você pode comer comida descartada no chão sem ficar doente, e vomitar te afeta menos."
	icon = FA_ICON_FACE_GRIN_BEAM_SWEAT
	value = 4
	mob_trait = TRAIT_STRONG_STOMACH
	gain_text = span_notice("Você sente como se pudesse comer qualquer coisa!")
	lose_text = span_danger("Olhar comida no chão faz você se sentir um pouco enjoada.")
	medical_record_text = "O paciente tem um sistema imunológico mais forte que a média... para intoxicação alimentar, pelo menos."
	mail_goodies = list(
		/obj/item/reagent_containers/applicator/pill/ondansetron,
	)
