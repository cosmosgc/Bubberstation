/datum/disease/rhumba_beat
	name = "The Rhumba Beat"
	desc = "Eles me chamam de Pete Cubano, eu sou o rei da Rumba Beat, quando eu toco maracas, eu faço pintinho, pintinho, pintinho."
	max_stages = 5
	spread_text = "Contato com a pele"
	spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS
	cure_text = "Chicky Chicky Boom!"
	cures = list(/datum/reagent/toxin/plasma)
	agent = "Unknown"
	viable_mobtypes = list(/mob/living/carbon/human)
	spreading_modifier = 1
	severity = DISEASE_SEVERITY_BIOHAZARD
	bypasses_immunity = TRUE
	visibility_flags = HIDDEN_BOOK

/datum/disease/rhumba_beat/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2)
			if(SPT_PROB(26, seconds_per_tick))
				affected_mob.adjust_fire_loss(5)
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("Você se sente estranho..."))
		if(3)
			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("Você sente vontade de dançar..."))
			else if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.emote("gasp")
			else if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_danger("Você sente a necessidade de pintinho..."))
		if(4)
			if(SPT_PROB(10, seconds_per_tick))
				if(prob(50))
					affected_mob.adjust_fire_stacks(2)
					affected_mob.ignite_mob()
				else
					affected_mob.emote("gasp")
					to_chat(affected_mob, span_danger("Você sente uma batida ardente por dentro..."))
		if(5)
			to_chat(affected_mob, span_danger("Seu corpo é incapaz de conter a batida de Rhumba..."))
			if(SPT_PROB(29, seconds_per_tick))
				explosion(affected_mob, devastation_range = -1, light_impact_range = 2, flame_range = 2, flash_range = 3, adminlog = FALSE, explosion_cause = src) // This is equivalent to a lvl 1 fireball
