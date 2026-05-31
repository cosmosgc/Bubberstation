/datum/quirk/item_quirk/immunodeficiency
	name = "Immunodeficiency"
	desc = "Seja por doença crônica ou por coincidência genética, seu corpo é uma pensão 24/7 para bactérias, vírus e parasitas de todos os tipos. Mesmo com sua imunidade prescrita, você vai se sentir pior que a maioria."
	icon = FA_ICON_MASK_FACE
	value = -10
	mob_trait = TRAIT_IMMUNODEFICIENCY
	gain_text = span_danger("Só de pensar em doença, fica febril.")
	lose_text = span_notice("Seu sistema imunológico milagrosamente reafirma-se.")
	medical_record_text = "Paciente com imunodeficiência crônica."
	mail_goodies = list(
		/obj/item/reagent_containers/syringe/antiviral,
		/obj/item/healthanalyzer/simple/disease
	)

/datum/quirk/item_quirk/immunodeficiency/add_unique(client/client_source)
	give_item_to_holder(
		/obj/item/clothing/mask/surgical,
		list(
			LOCATION_MASK,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
		)
	)
	give_item_to_holder(
		/obj/item/storage/pill_bottle/immunodeficiency,
		list(
			LOCATION_LPOCKET,
			LOCATION_RPOCKET,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
		)
	)
