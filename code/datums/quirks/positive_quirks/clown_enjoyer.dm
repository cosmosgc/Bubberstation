/datum/quirk/item_quirk/clown_enjoyer
	name = "Clown Enjoyer"
	desc = "Você gosta de palhaçadas e ganha um impulso de humor usando seu broche de palhaço."
	icon = FA_ICON_MAP_PIN
	value = 2
	mob_trait = TRAIT_CLOWN_ENJOYER
	gain_text = span_notice("Você gosta muito de palhaços.")
	lose_text = span_danger("O palhaço não parece tão bom.")
	medical_record_text = "O paciente diz que gosta de palhaços."
	mail_goodies = list(
		/obj/item/bikehorn,
		/obj/item/stamp/clown,
		/obj/item/megaphone/clown,
		/obj/item/clothing/shoes/clown_shoes,
		/obj/item/bedsheet/clown,
		/obj/item/clothing/mask/gas/clown_hat,
		/obj/item/storage/backpack/clown,
		/obj/item/storage/backpack/duffelbag/clown,
		/obj/item/toy/crayon/rainbow,
		/obj/item/toy/figure/clown,
		/obj/item/tank/internals/emergency_oxygen/engi/clown/n2o,
		/obj/item/tank/internals/emergency_oxygen/engi/clown/bz,
		/obj/item/tank/internals/emergency_oxygen/engi/clown/helium,
	)

/datum/quirk/item_quirk/clown_enjoyer/add_unique(client/client_source)
	give_item_to_holder(/obj/item/clothing/accessory/clown_enjoyer_pin, list(LOCATION_BACKPACK, LOCATION_HANDS))
