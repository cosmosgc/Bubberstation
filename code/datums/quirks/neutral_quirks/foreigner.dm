/datum/quirk/foreigner
	name = "Foreigner"
	desc = "Você não é daqui. Você não sabe Galactic Common!"
	icon = FA_ICON_LANGUAGE
	value = 0
	gain_text = span_notice("As palavras ditas ao seu redor não fazem sentido.")
	lose_text = span_notice("Você desenvolveu fluência em Galactic Common.")
	medical_record_text = "O paciente não fala Galáctico Comum e pode precisar de um intérprete."
	mail_goodies = list(/obj/item/taperecorder) // for translation

/datum/quirk/foreigner/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.add_blocked_language(/datum/language/common)
	if(ishumanbasic(human_holder))
		human_holder.grant_language(/datum/language/uncommon, source = LANGUAGE_QUIRK)

/datum/quirk/foreigner/remove()
	if(QDELETED(quirk_holder))
		return
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.remove_blocked_language(/datum/language/common)
	if(ishumanbasic(human_holder))
		human_holder.remove_language(/datum/language/uncommon)
