/datum/quirk/chip_connector
	name = "Chip Connector"
	desc = "Você tinha um dispositivo instalado que permite adicionar e remover manualmente chips de habilidade! Tente não chegar perto de pulsos eletromagnéticos."
	icon = FA_ICON_PLUG
	value = 4
	gain_text = span_notice("Você se sente conectado.")
	lose_text = span_danger("Você não se sente mais tão conectado.")
	medical_record_text = "O paciente tem um implante cibernético na nuca que os deixa instalar e remover os chips à vontade. Nojento."
	mail_goodies = list()
	var/obj/item/organ/cyberimp/brain/connector/connector

/datum/quirk/chip_connector/New()
	. = ..()
	mail_goodies = assoc_to_keys(GLOB.quirk_chipped_choice) + /datum/quirk/chipped::mail_goodies

/datum/quirk/chip_connector/add_unique(client/client_source)
	. = ..()
	var/mob/living/carbon/carbon_holder = quirk_holder
	if(!iscarbon(quirk_holder))
		return
	connector = new()
	connector.Insert(carbon_holder, special = TRUE)

/datum/quirk/chip_connector/post_add()
	to_chat(quirk_holder, span_bolddanger(desc)) // efficiency is clever laziness

/datum/quirk/chip_connector/remove()
	qdel(connector)
