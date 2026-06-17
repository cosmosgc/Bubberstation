/datum/quirk/pseudo_respiration
	name = "Pseudo-Respiration"
	desc = "(Somente hemofago) Apesar de sua condição você por qualquer razão que ainda precise respirar."
	icon = FA_ICON_MASK_VENTILATOR
	value = -2
	quirk_flags = QUIRK_HUMAN_ONLY
	gain_text = span_danger("Sente vontade de respirar...")
	lose_text = span_notice("Você não sente mais a necessidade de respirar.")
	medical_record_text = "O paciente relata a necessidade de respirar apesar do vírus hemofágico."
	hardcore_value = 2
	species_whitelist = list(SPECIES_HEMOPHAGE)

/datum/quirk/pseudo_respiration/add()
	var/mob/living/carbon/human/breather = quirk_holder
	if(!istype(breather))
		return
	REMOVE_TRAIT(breather, TRAIT_NOBREATH, SPECIES_TRAIT)
	var/obj/item/organ/lungs/lungs_added = new()
	lungs_added.Insert(breather, special = TRUE, movement_flags = DELETE_IF_REPLACED)
	breather.dna.species.mutantlungs = lungs_added.type

/datum/quirk/pseudo_respiration/remove()
	var/mob/living/carbon/human/no_breather = quirk_holder
	if(!istype(no_breather))
		return
	ADD_TRAIT(no_breather, TRAIT_NOBREATH, SPECIES_TRAIT)
	var/obj/item/organ/lungs/lungs_added = new()
	lungs_added.Remove(no_breather, special = TRUE, movement_flags = DELETE_IF_REPLACED)

