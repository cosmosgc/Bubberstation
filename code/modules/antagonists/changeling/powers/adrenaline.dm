/datum/action/changeling/adrenaline
	name = "Gene Stim"
	desc = "Concentramos nossos produtos químicos em um potente estimulante, tornando nossa forma estupendamente robusta contra ser incapacitada. Custa 25 produtos químicos."
	helptext = "Disregard any condition that has stunned us and suffuse our form with FOUR units of Changeling Adrenaline; our form recovers massive stamina and simply disregards any pain or fatigue during its effects."
	button_icon_state = "adrenaline"
	category = "combat"
	chemical_cost = 25 // similar cost to biodegrade, as they serve similar purposes
	dna_cost = 2
	req_human = FALSE
	req_stat = CONSCIOUS
	disabled_by_fire = TRUE

//Recover from stuns.
/datum/action/changeling/adrenaline/sting_action(mob/living/carbon/user)
	..()

	// Get us standing up.
	user.SetAllImmobility(0)
	user.set_stamina_loss(0)
	user.set_resting(FALSE, instant = TRUE)

	user.reagents.add_reagent(/datum/reagent/medicine/changelingadrenaline, 4) //Tank 5 consecutive baton hits

	to_chat(user, span_changeling("A incrível corrida de um estimulante aperfeiçoado precisamente para a nossa biologia é INVIGORANTE. Não seremos subjugados."))

	return TRUE
