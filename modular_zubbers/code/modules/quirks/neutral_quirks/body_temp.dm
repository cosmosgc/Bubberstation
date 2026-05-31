/datum/quirk/bodytemp
	name = "Abnormal body temperature"
	desc = "Sua temperatura corporal é estranha comparada com sua espécie de base, sendo compensada uma certa quantidade acima ou abaixo. Isso não é recomendado com espécies de sangue frio. A peculiaridade varia de -40 a +70, devido à forma como você é entregue na estação levando isso em quantidades extremas pode resultar em pequenas queimaduras."
	value = 0
	gain_text = span_danger("Sua temperatura corporal está ruim.")
	lose_text = span_notice("Sua temperatura corporal está certa.")
	species_blacklist = list(SPECIES_SKRELL) //Skrell already have a insane +70 to their body temp
	medical_record_text = "O corpo do paciente tem uma temperatura anormal para sua espécie."
	icon = FA_ICON_THERMOMETER_HALF
	var/bodytemp = 0
	var/species_normal = 0
	var/species_heat = 0
	var/species_cold = 0

/datum/quirk_constant_data/bodytemp
	associated_typepath = /datum/quirk/bodytemp
	customization_options = list(
		/datum/preference/numeric/bodytemp_customization/bodytemp,
	)

/datum/preference/numeric/bodytemp_customization
	abstract_type = /datum/preference/numeric/bodytemp_customization
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_identifier = PREFERENCE_CHARACTER
	minimum = -40 //Plasmamen
	maximum = 70 //Skrell

/datum/preference/numeric/bodytemp_customization/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/bodytemp_customization/create_default_value()
	return 20

/datum/preference/numeric/bodytemp_customization/bodytemp
	savefile_key = "bodytemp"


/datum/quirk/bodytemp/add(client/client_source)
	. = ..()

	var/mob/living/carbon/human/user = quirk_holder
	species_normal = user.dna.species.bodytemp_normal
	species_heat = user.dna.species.bodytemp_heat_damage_limit //Storing the species's default body temps incase the quirk is removed.
	species_cold = user.dna.species.bodytemp_cold_damage_limit
	user.dna.species.bodytemp_normal += bodytemp
	user.dna.species.bodytemp_heat_damage_limit += bodytemp
	user.dna.species.bodytemp_cold_damage_limit += bodytemp

/datum/quirk/bodytemp/post_add()
	. = ..()

	var/mob/living/carbon/human/user = quirk_holder
	var/datum/preferences/prefs = user.client.prefs
	bodytemp = prefs.read_preference(/datum/preference/numeric/bodytemp_customization/bodytemp)
	user.dna.species.bodytemp_normal += bodytemp
	user.dna.species.bodytemp_heat_damage_limit += bodytemp
	user.dna.species.bodytemp_cold_damage_limit += bodytemp

/datum/quirk/bodytemp/remove()
	. = ..()

	if(QDELETED(quirk_holder))
		return
	var/mob/living/carbon/human/user = quirk_holder
	user.dna.species.bodytemp_normal = species_normal
	user.dna.species.bodytemp_heat_damage_limit = species_heat
	user.dna.species.bodytemp_cold_damage_limit = species_cold


