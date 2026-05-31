/datum/quirk/item_quirk/deafness
	name = "Deaf"
	desc = "Você é incurávelmente surdo."
	icon = FA_ICON_DEAF
	value = -8
	mob_trait = TRAIT_DEAF
	gain_text = span_danger("Você não pode ouvir nada.")
	lose_text = span_notice("Você é capaz de ouvir novamente!")
	medical_record_text = "O nervo coclear do paciente está incuravelmente danificado."
	hardcore_value = 12
	mail_goodies = list(/obj/item/clothing/mask/whistle)

/datum/quirk/item_quirk/deafness/add_unique(client/client_source)
	give_item_to_holder(/obj/item/clothing/accessory/deaf_pin, list(LOCATION_BACKPACK, LOCATION_HANDS))
