/datum/quirk/cursed
	name = "Cursed"
	desc = "Você está amaldiçoado com má sorte. Você é muito mais propenso a sofrer acidentes e acidentes. Quando chove, chove."
	icon = FA_ICON_CLOUD_SHOWERS_HEAVY
	value = -8
	mob_trait = TRAIT_CURSED
	gain_text = span_danger("Você sente que vai ter um dia ruim.")
	lose_text = span_notice("Você sente que vai ter um bom dia.")
	medical_record_text = "O paciente está amaldiçoado com má sorte."
	hardcore_value = 8

/datum/quirk/cursed/add(client/client_source)
	quirk_holder.AddComponent(/datum/component/omen/quirk)
