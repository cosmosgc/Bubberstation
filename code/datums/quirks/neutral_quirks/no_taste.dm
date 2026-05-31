/datum/quirk/no_taste
	name = "Ageusia"
	desc = "Você não pode provar nada! Comida tóxica ainda vai te envenenar."
	icon = FA_ICON_MEH_BLANK
	value = 0
	mob_trait = TRAIT_AGEUSIA
	gain_text = span_notice("Você não pode provar nada!")
	lose_text = span_notice("Você pode provar de novo!")
	medical_record_text = "O paciente sofre de ageusia e é incapaz de provar comida ou reagentes."
	mail_goodies = list(/obj/effect/spawner/random/food_or_drink/condiment) // but can you taste the salt? CAN YOU?!
