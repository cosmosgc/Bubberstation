/datum/quirk/bilingual
	name = "Bilingual"
	desc = "Ao longo dos anos você aprendeu uma língua extra!"
	icon = FA_ICON_GLOBE
	value = 4
	mob_trait = TRAIT_BILINGUAL //BUBBER EDIT ADDITION: Marks down that you're bilingual
	gain_text = span_notice("Algumas das palavras das pessoas ao seu redor certamente não são comuns. Ainda bem que estudou para isso.")
	lose_text = span_notice("Parece que esqueceu sua segunda língua.")
	medical_record_text = "O paciente fala várias línguas."
	mail_goodies = list(/obj/item/taperecorder, /obj/item/clothing/head/beret/frenchberet, /obj/item/clothing/mask/fakemoustache/italian)

/* //BUBBER EDIT REMOVAL: MAKING THIS DO THE SAME THING AS LINGUIST
/datum/quirk_constant_data/bilingual
	associated_typepath = /datum/quirk/bilingual
	customization_options = list(
		/datum/preference/choiced/language,
		/datum/preference/toggle/language_speakable,
		/datum/preference/choiced/language_skill,
	)

/datum/quirk/bilingual/add(client/client_source)
	var/wanted_language = client_source?.prefs.read_preference(/datum/preference/choiced/language)
	var/datum/language/language_type
	if(wanted_language == "Random")
		language_type = pick(GLOB.uncommon_roundstart_languages)
	else if(wanted_language)
		language_type = GLOB.language_types_by_name[wanted_language]
	if(!language_type || quirk_holder.has_language(language_type))
		language_type = /datum/language/uncommon
		if(quirk_holder.has_language(language_type))
			to_chat(quirk_holder, span_boldnotice("Você já está familiarizado com a peculiaridade em suas preferências, então você não aprendeu uma."))
			return
		to_chat(quirk_holder, span_boldnotice("Você já está familiarizado com a peculiaridade em suas preferências, então você aprendeu Galáctica incomum em vez disso."))

	var/speakable = client_source?.prefs.read_preference(/datum/preference/toggle/language_speakable)
	var/language_skill = client_source?.prefs.read_preference(/datum/preference/choiced/language_skill) || "100%"
	if(isnull(speakable) || speakable)
		quirk_holder.grant_language(language_type, SPOKEN_LANGUAGE|UNDERSTOOD_LANGUAGE, source = LANGUAGE_QUIRK)
	else if(language_skill == "100%")
		quirk_holder.grant_language(language_type, UNDERSTOOD_LANGUAGE, source = LANGUAGE_QUIRK)
	else
		quirk_holder.grant_partial_language(language_type, text2num(language_skill), source = LANGUAGE_QUIRK)

/datum/quirk/bilingual/remove()
	if(QDELING(quirk_holder))
		return
	quirk_holder.remove_all_languages(source = LANGUAGE_QUIRK)
	quirk_holder.remove_all_partial_languages(source = LANGUAGE_QUIRK)
*/ //BUBBER EDIT REMOVAL: MAKING THIS DO THE SAME THING AS LINGUIST
