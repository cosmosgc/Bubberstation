/datum/quirk/item_quirk/chronic_illness
	name = "Eradicative Chronic Illness"
	desc = "Você tem uma doença crônica anômala que requer medicação constante para manter sob controle, ou então causa correção temporal."
	icon = FA_ICON_DISEASE
	value = -12
	gain_text = span_danger("Você sente que está desaparecendo...")
	lose_text = span_notice("De repente você se sente mais substancial.")
	medical_record_text = "O paciente tem uma doença crônica anômala que requer medicação constante para manter sob controle."
	hardcore_value = 12
	mail_goodies = list(/obj/item/storage/pill_bottle/sansufentanyl)

/datum/quirk/item_quirk/chronic_illness/add(client/client_source)
	var/datum/disease/chronic_illness/hms = new /datum/disease/chronic_illness()
	quirk_holder.ForceContractDisease(hms)

/datum/quirk/item_quirk/chronic_illness/add_unique(client/client_source)
	give_item_to_holder(/obj/item/storage/pill_bottle/sansufentanyl, list(LOCATION_BACKPACK), flavour_text = "You've been provided with medication to help manage your condition. Take it regularly to avoid complications.", notify_player = TRUE)
	give_item_to_holder(/obj/item/healthanalyzer/simple/disease, list(LOCATION_BACKPACK))
