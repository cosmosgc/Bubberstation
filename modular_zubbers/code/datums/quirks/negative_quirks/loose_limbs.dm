/datum/quirk/loose_limbs
	name = "Loose Limbs"
	desc = "Seus membros não são tão resistentes quanto os outros! Quando você morre, é provável que caiam."
	icon = FA_ICON_USER_INJURED
	value = -2
	gain_text = span_danger("Suas articulações estão fracas.")
	lose_text = span_notice("Suas articulações se sentem reforçadas.")
	medical_record_text = "As articulações do paciente estão fracas e podem cair."
	hardcore_value = 2

/datum/quirk/loose_limbs/add(client/client_source)
	quirk_holder.AddComponent(/datum/component/omen/loose_limbs)
