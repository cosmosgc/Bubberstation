/datum/mutation/adaptation
	name = "Adaptation"
	desc = "Uma mutação estranha que torna o hospedeiro imune a danos de temperaturas extremas. Não protege do vácuo."
	quality = POSITIVE
	difficulty = 16
	text_gain_indication = span_notice("Your body feels normal!")
	instability = NEGATIVE_STABILITY_MAJOR
	locked = TRUE // fake parent
	conflicts = list(/datum/mutation/adaptation)
	mutation_traits = list(TRAIT_WADDLING)
	/// Icon used for the adaptation overlay
	var/adapt_icon = "meow"

/datum/mutation/adaptation/New(datum/mutation/copymut)
	..()
	conflicts = typesof(/datum/mutation/adaptation)
	if(!(type in visual_indicators))
		visual_indicators[type] = list(mutable_appearance('icons/mob/effects/genetics.dmi', adapt_icon, -MUTATIONS_LAYER))

/datum/mutation/adaptation/get_visual_indicator()
	return visual_indicators[type][1]

/datum/mutation/adaptation/cold
	name = "Cold Adaptation"
	desc = "Uma mutação estranha que torna o hospedeiro imune a danos de ambientes de baixa temperatura. Também impede que o hospedeiro escorregue no gelo."
	text_gain_indication = span_notice("Your body feels refreshingly cold.")
	instability = POSITIVE_INSTABILITY_MODERATE
	mutation_traits = list(TRAIT_RESISTCOLD, TRAIT_NO_SLIP_ICE)
	adapt_icon = "cold"
	locked = FALSE

/datum/mutation/adaptation/heat
	name = "Heat Adaptation"
	desc = "Uma mutação estranha que torna o hospedeiro imune a danos causados pela alta temperatura, incluindo ser incendiado, embora a própria chama ainda queime roupas. Também parece fazer o hospedeiro resistir às tempestades de cinzas."
	text_gain_indication = span_notice("Your body feels invigoratingly warm.")
	instability = POSITIVE_INSTABILITY_MODERATE
	mutation_traits = list(TRAIT_RESISTHEAT, TRAIT_ASHSTORM_IMMUNE)
	adapt_icon = "fire"
	locked = FALSE

/datum/mutation/adaptation/thermal
	name = "Thermal Adaptation"
	desc = "Uma mutação estranha que torna o hospedeiro imune a danos de ambientes de baixa e alta temperatura. Não protege de ambientes de alta ou baixa pressão."
	difficulty = 32
	text_gain_indication = span_notice("Your body feels pleasantly room temperature.")
	instability = POSITIVE_INSTABILITY_MAJOR
	mutation_traits = list(TRAIT_RESISTHEAT, TRAIT_RESISTCOLD)
	adapt_icon = "thermal"
	locked = TRUE // recipe

/datum/mutation/adaptation/pressure
	name = "Pressure Adaptation"
	desc = "Uma mutação estranha que torna o hospedeiro imune a danos de ambientes de baixa e alta pressão. Não protege da temperatura, incluindo o frio do espaço."
	text_gain_indication = span_notice("Your body feels impressively pressurized.")
	instability = POSITIVE_INSTABILITY_MODERATE
	adapt_icon = "pressure"
	mutation_traits = list(TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTHIGHPRESSURE)
	locked = FALSE
