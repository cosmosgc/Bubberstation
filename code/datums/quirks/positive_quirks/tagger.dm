/datum/quirk/item_quirk/tagger
	name = "Tagger"
	desc = "Você é um artista experiente. As pessoas ficarão impressionadas com o seu grafite, e você pode ter o dobro de usos para desenhar suprimentos na metade do tempo."
	icon = FA_ICON_SPRAY_CAN
	value = 4
	mob_trait = TRAIT_TAGGER
	gain_text = span_notice("Você sabe como marcar paredes de forma eficiente e rápida.")
	lose_text = span_danger("Você esquece como marcar paredes corretamente.")
	medical_record_text = "O paciente foi visto recentemente por possível incidente com tinta."
	mail_goodies = list(
		/obj/item/toy/crayon/spraycan,
		/obj/item/canvas/nineteen_nineteen,
		/obj/item/canvas/twentythree_nineteen,
		/obj/item/canvas/twentythree_twentythree
	)

/datum/quirk_constant_data/tagger
	associated_typepath = /datum/quirk/item_quirk/tagger
	customization_options = list(/datum/preference/color/paint_color)

/datum/quirk/item_quirk/tagger/add_unique(client/client_source)
	var/obj/item/toy/crayon/spraycan/can = new
	can.set_painting_tool_color(client_source?.prefs.read_preference(/datum/preference/color/paint_color))
	give_item_to_holder(can, list(LOCATION_BACKPACK, LOCATION_HANDS))
