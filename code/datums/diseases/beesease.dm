/datum/disease/beesease
	name = "Beesease"
	form = "Parasite"
	max_stages = 4
	spread_text = "Contato com a pele"
	spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS
	cure_text = /datum/reagent/consumable/sugar::name
	cures = list(/datum/reagent/consumable/sugar)
	agent = "Apidae Infection"
	viable_mobtypes = list(/mob/living/carbon/human)
	desc = "Uma doença estranha que leva à gestação de abelhas no estômago do sujeito, que muitas vezes são regurgitadas."
	severity = DISEASE_SEVERITY_MEDIUM
	infectable_biotypes = MOB_ORGANIC|MOB_UNDEAD //bees nesting in corpses


/datum/disease/beesease/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2) //also changes say, see say.dm
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_notice("Você prova mel na boca."))
		if(3)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_notice("Seu estômago treme."))
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("Seu estômago dói dolorosamente."))
				if(prob(20))
					affected_mob.adjust_tox_loss(2)
		if(4)
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.visible_message(span_danger("[affected_mob]Buzzes."), 												span_userdanger("Seu estômago vibra violentamente!"))
			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("Sente algo se movendo em sua garganta."))
			if(SPT_PROB(0.5, seconds_per_tick))
				affected_mob.visible_message(span_danger("[affected_mob]Tossiu um enxame de abelhas!"), 													span_userdanger("Você tossiu um enxame de abelhas!"))
				new /mob/living/basic/bee(affected_mob.loc)
