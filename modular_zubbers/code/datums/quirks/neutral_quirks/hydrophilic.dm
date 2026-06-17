/datum/quirk/hydrophilic
	name = "Hydrophilic"
	desc = "(Somente caligrafia) Suas moléculas são altamente hidrofílicas - ou, em termos leigos, dissolvem-se muito bem na água. Você deveria ficar longe disso..."
	icon = FA_ICON_BUG // I can't be asked to make an icon for this, my spritework sucks.
	value = 0
	quirk_flags = QUIRK_HUMAN_ONLY
	gain_text = span_danger("Você sente que deve ficar longe da água...")
	lose_text = span_notice("De alguma forma, você sente como se a água não fosse mais perigosa.")
	medical_record_text = "Os exames indicam extrema hidrofilia."
	hardcore_value = 0
	mob_trait = TRAIT_HYDROPHILIC
	species_whitelist = list(SPECIES_SLIMESTART)
