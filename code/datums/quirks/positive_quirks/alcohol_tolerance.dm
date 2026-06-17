/datum/quirk/alcohol_tolerance
	name = "Alcohol Tolerance"
	desc = "Você fica bêbado mais lentamente e sofre menos desvantagens do álcool."
	icon = FA_ICON_BEER
	value = 4
	mob_trait = TRAIT_ALCOHOL_TOLERANCE
	gain_text = span_notice("Você sente como se pudesse beber um barril inteiro!")
	lose_text = span_danger("Você não se sente mais tão resistente ao álcool. De alguma forma.")
	medical_record_text = "O paciente demonstra alta tolerância ao álcool."
	mail_goodies = list(/obj/item/skillchip/wine_taster)
