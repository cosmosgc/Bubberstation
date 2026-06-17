/datum/disease/adrenal_crisis
	form = "Condition"
	name = "Adrenal Crisis"
	max_stages = 2
	cure_text = "Trauma (Adrenalina)\"" + /datum/reagent/determination::name + "\")"
	cures = list(/datum/reagent/determination)
	cure_chance = 10
	agent = "Kronkaine Abuse"
	viable_mobtypes = list(/mob/living/carbon/human)
	spreading_modifier = 1
	desc = "Uma condição rara causada pelo abuso contínuo de Kronkaine.\
Se não for tratado o sujeito sofrerá letargia, tontura e perda periódica de consciência."
	severity = DISEASE_SEVERITY_MEDIUM
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	spread_text = "None"
	visibility_flags = HIDDEN_PANDEMIC
	bypasses_immunity = TRUE

/datum/disease/adrenal_crisis/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(1)
			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(affected_mob, span_warning(pick("Você se sente tonto.", "Você se sente letárgico.")))
		if(2)
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.Unconscious(40)

			if(SPT_PROB(10, seconds_per_tick))
				affected_mob.adjust_slurring(14 SECONDS)

			if(SPT_PROB(7, seconds_per_tick))
				affected_mob.set_dizzy_if_lower(20 SECONDS)

			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(affected_mob, span_warning(pick("Você sente dor derrubando suas pernas!", "Você sente que vai desmaiar a qualquer momento.", "Você está muito tonta.")))
