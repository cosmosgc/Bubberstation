/datum/quirk/freerunning
	name = "Freerunning"
	desc = "Você é ótimo em movimentos rápidos! Você pode escalar mesas mais rápido e não sofrer danos de quedas curtas."
	icon = FA_ICON_RUNNING
	value = 8
	mob_trait = TRAIT_FREERUNNING
	gain_text = span_notice("Você sente lithe em seus pés!")
	lose_text = span_danger("Você se sente desajeitado de novo.")
	medical_record_text = "O paciente marcou muito em exames cardiológicos."
	mail_goodies = list(/obj/item/melee/skateboard, /obj/item/clothing/shoes/wheelys/rollerskates)
