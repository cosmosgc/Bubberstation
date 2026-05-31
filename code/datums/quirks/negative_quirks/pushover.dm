/datum/quirk/pushover
	name = "Pushover"
	desc = "Seu primeiro instinto é sempre deixar as pessoas te pressionarem. Resistir às garras é mais difícil."
	icon = FA_ICON_HANDSHAKE
	value = -8
	mob_trait = TRAIT_GRABWEAKNESS
	gain_text = span_danger("Você se sente como um molenga.")
	lose_text = span_notice("Você tem vontade de se defender.")
	medical_record_text = "O paciente apresenta uma personalidade não assertiva e é fácil de manipular."
	hardcore_value = 4
	mail_goodies = list(/obj/item/clothing/gloves/cargo_gauntlet)
