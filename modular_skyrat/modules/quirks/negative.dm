// SKYRAT NEGATIVE TRAITS

/datum/quirk/alexithymia
	name = "Alexithymia"
	desc = "Você não pode avaliar seus sentimentos com precisão."
	value = -4
	mob_trait = TRAIT_MOOD_NOEXAMINE
	medical_record_text = "O paciente é incapaz de comunicar suas emoções."
	icon = FA_ICON_QUESTION_CIRCLE

/datum/quirk/fragile
	name = "Fragility"
	desc = "Você se sente incrivelmente frágil. Queimaduras e hematomas machucam mais do que a pessoa normal!"
	value = -6
	medical_record_text = "O corpo do paciente se adaptou à baixa gravidade. Infelizmente, ambientes de baixa gravidade não levam ao forte desenvolvimento ósseo."
	icon = FA_ICON_TIRED

/datum/quirk_constant_data/fragile
	associated_typepath = /datum/quirk/fragile
	customization_options = list(
		/datum/preference/numeric/fragile_customization/brute,
		/datum/preference/numeric/fragile_customization/burn,
	)

/datum/preference/numeric/fragile_customization
	abstract_type = /datum/preference/numeric/fragile_customization
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER

	minimum = 1.25
	maximum = 5 // 5x damage, arbitrary

	step = 0.01

/datum/preference/numeric/fragile_customization/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/fragile_customization/create_default_value()
	return 1.25

/datum/preference/numeric/fragile_customization/brute
	savefile_key = "fragile_brute"

/datum/preference/numeric/fragile_customization/burn
	savefile_key = "fragile_burn"

/datum/quirk/fragile/post_add()
	. = ..()

	var/mob/living/carbon/human/user = quirk_holder
	var/datum/preferences/prefs = user.client.prefs
	var/brutemod = prefs.read_preference(/datum/preference/numeric/fragile_customization/brute)
	var/burnmod = prefs.read_preference(/datum/preference/numeric/fragile_customization/burn)

	user.physiology.brute_mod *= brutemod
	user.physiology.burn_mod *= burnmod

/datum/quirk/fragile/remove()
	. = ..()

	if(QDELETED(quirk_holder))
		return
	var/mob/living/carbon/human/user = quirk_holder
	var/datum/preferences/prefs = user.client.prefs
	var/brutemod = prefs.read_preference(/datum/preference/numeric/fragile_customization/brute)
	var/burnmod = prefs.read_preference(/datum/preference/numeric/fragile_customization/burn)
	// will cause issues if the user changes this value before removal
	user.physiology.brute_mod /= brutemod
	user.physiology.burn_mod /= burnmod

/datum/quirk/monophobia
	name = "Monophobia"
	desc = "Você ficará cada vez mais estressado quando não estiver em companhia de outros, desencadeando reações de pânico que vão desde doenças até ataques cardíacos."
	value = -6
	gain_text = span_danger("Você se sente muito só...")
	lose_text = span_notice("Você sente que pode estar segura sozinha.")
	medical_record_text = "O paciente se sente doente e angustiado quando não está perto de outras pessoas, levando a níveis potencialmente letais de estresse."
	icon = FA_ICON_PEOPLE_ARROWS_LEFT_RIGHT

/datum/quirk/monophobia/post_add()
	. = ..()
	var/mob/living/carbon/human/user = quirk_holder
	user.gain_trauma(/datum/brain_trauma/severe/monophobia, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/monophobia/remove()
	. = ..()
	var/mob/living/carbon/human/user = quirk_holder
	user?.cure_trauma_type(/datum/brain_trauma/severe/monophobia, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/no_guns
	name = "No Guns"
	desc = "Por alguma razão, você é incapaz de usar armas. O raciocínio pode variar, mas cabe a você decidir."
	gain_text = span_notice("Você sente que não poderá mais usar armas...")
	lose_text = span_notice("De repente você sente que pode usar armas de novo!")
	medical_record_text = "O paciente não pode usar armas de fogo. Raciocínio desconhecido."
	value = -6
	mob_trait = TRAIT_NOGUNS
	icon = FA_ICON_GUN
