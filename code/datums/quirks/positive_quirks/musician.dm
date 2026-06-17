/datum/quirk/item_quirk/musician
	name = "Musician"
	desc = "Você pode sintonizar instrumentos musicais portáteis para tocar melodias que esclarecem certos efeitos negativos e acalmam a alma."
	icon = FA_ICON_GUITAR
	value = 2
	mob_trait = TRAIT_MUSICIAN
	gain_text = span_notice("Você sabe tudo sobre instrumentos musicais.")
	lose_text = span_danger("Você esquece como os instrumentos musicais funcionam.")
	medical_record_text = "Exames cerebrais mostram uma via auditiva altamente desenvolvida."
	mail_goodies = list(/obj/effect/spawner/random/entertainment/musical_instrument, /obj/item/instrument/piano_synth/headphones)

/datum/quirk/item_quirk/musician/add_unique(client/client_source)
	give_item_to_holder(/obj/item/choice_beacon/music, list(LOCATION_BACKPACK, LOCATION_HANDS))
