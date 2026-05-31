/datum/disease/cold9
	name = "The Cold"
	max_stages = 3
	spread_text = "Contato com a pele"
	spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS
	cure_text = /datum/reagent/medicine/spaceacillin::name + "ou anticorpos frios comuns"
	cures = list(/datum/reagent/medicine/spaceacillin)
	agent = "ICE9-rhinovirus"
	viable_mobtypes = list(/mob/living/carbon/human)
	desc = "Uma adaptação do resfriado comum, um pouco mais perigoso na natureza. Se não for tratado, o sujeito vai diminuir, como se estivesse parcialmente congelado."
	severity = DISEASE_SEVERITY_HARMFUL
	required_organ = ORGAN_SLOT_LUNGS

/datum/disease/cold9/cure(add_resistance)
	// buy one, get one free
	if(add_resistance && affected_mob)
		LAZYOR(affected_mob.disease_resistances, "[/datum/disease/cold]")
	return ..()

/datum/disease/cold9/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2)
			affected_mob.adjust_bodytemperature(-5 * seconds_per_tick)
			if(SPT_PROB(0.5, seconds_per_tick))
				affected_mob.emote("sneeze")
			if(SPT_PROB(0.5, seconds_per_tick))
				affected_mob.emote("cough")
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("Sua garganta está doendo."))
			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("Você se sente duro."))
			if(SPT_PROB(0.05, seconds_per_tick))
				to_chat(affected_mob, span_notice("Você se sente melhor."))
				cure()
				return FALSE
		if(3)
			affected_mob.adjust_bodytemperature(-10 * seconds_per_tick)
			if(SPT_PROB(0.5, seconds_per_tick))
				affected_mob.emote("sneeze")
			if(SPT_PROB(0.5, seconds_per_tick))
				affected_mob.emote("cough")
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("Sua garganta está doendo."))
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_danger("Você se sente duro."))
