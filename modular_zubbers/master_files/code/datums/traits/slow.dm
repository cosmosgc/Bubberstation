/datum/quirk/overweight
	name = "Overweight"
	desc = "Você pesa mais do que uma pessoa normal do seu tamanho. Ser gordo por comida ainda te incomoda."
	gain_text = span_notice("Seu corpo está pesado.")
	lose_text = span_notice("Você de repente se sente mais leve!")
	value = -4
	icon = FA_ICON_BOWL_RICE
	medical_record_text = "O paciente pesa mais que a média."
	mob_trait = null

/datum/quirk/obese
	name = "Obese"
	desc = "Você pesa muito mais do que a pessoa normal do seu tamanho, e sempre é gorda, não importa o que aconteça. Ser gorda por comida não te incomoda mais."
	gain_text = span_notice("Seu corpo sente<b>Muito.</b>Pesado.")
	lose_text = span_notice("Você de repente se sente muito mais leve!")
	value = -6
	icon = FA_ICON_HAMBURGER
	medical_record_text = "O paciente é considerado obeso por 101% dos livros médicos, com uma margem de erro de 1%."
	mob_trait = TRAIT_FAT
