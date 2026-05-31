/datum/disease/cryptococcus
	name = "Cryptococcal meningitis"
	max_stages = 4
	stage_prob = 1.75
	spread_text = "Airborne"
	spreading_modifier = 0.75
	cure_text = "Haloperidol"
	cures = list(/datum/reagent/medicine/haloperidol)
	agent = "Cryptococcus gattii fungus"
	viable_mobtypes = list(/mob/living/carbon/human)
	cure_chance = 25
	desc = "Infecção fúngica que ataca os músculos e o cérebro do paciente na tentativa de sequestrá-los. Causa febre, dores de cabeça, espasmos musculares e fadiga."
	severity = DISEASE_SEVERITY_BIOHAZARD

/datum/disease/cryptococcus/stage_act(seconds_per_tick, times_fired)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(1)
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_danger("Seu cérebro está confuso. Isso não está certo."))
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_danger("Sua cabeça dói. As telhas do teto estavam sempre se movendo assim?"))
		if(2)
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.emote("twitch")
				to_chat(affected_mob, span_danger("Você se contorce involuntariamente. Isso não está certo."))
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_danger("Você cheira, cheira lodo verde. Verde tem cheiro?"))
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_danger("Sua cabeça dói. As telhas do teto estavam sempre se movendo assim?"))
		if(3)
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("Você vê quatro de tudo!"))
				affected_mob.set_dizzy_if_lower(10 SECONDS)
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("Você de repente se sente exausto. Seus movimentos estão começando a se sentir rígidos. Algo sério não está certo..."))
				affected_mob.adjust_stamina_loss(30, FALSE)
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("Você se sente quente. Muito quente. Seus músculos se sentem bem por um momento, mas a dor retorna."))
				affected_mob.adjust_bodytemperature(20)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("Sente que o ar escapa dos pulmões dolorosamente. Você não pretendia exalar, eles parecem estar se apoderando sozinhos."))
				affected_mob.adjust_oxy_loss(25, FALSE)
				affected_mob.emote("gasp")
		if(4)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("[pick("Your muscles seize!", "You collapse!")]"))
				affected_mob.adjust_stamina_loss(50, FALSE)
				affected_mob.Paralyze(40, FALSE)
				affected_mob.adjust_brute_loss(5) //It's damaging the muscles
			if(SPT_PROB(2, seconds_per_tick))
				affected_mob.adjust_stamina_loss(100, FALSE)
				affected_mob.visible_message(span_warning("[affected_mob]Desmaios!"), span_userdanger("Você se entrega e se sente em paz..."))
				affected_mob.AdjustSleeping(100)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("Sente sua mente relaxada e seus pensamentos à deriva!"))
				affected_mob.adjust_confusion(10 SECONDS)
				affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 10)
			if(SPT_PROB(10, seconds_per_tick))
				to_chat(affected_mob, span_danger("[pick("You feel uncomfortably hot...", "You feel like unzipping your jumpsuit", "You feel like taking off some clothes...")]"))
				affected_mob.adjust_bodytemperature(30)
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.vomit(vomit_flags = VOMIT_CATEGORY_DEFAULT, lost_nutrition = 20)

/datum/reagent/cryptococcus_spores
	name = "Cryptococcus gattii microbes"
	description = "Esporos de fungos ativos."
	color = "#92D17D"
	chemical_flags = NONE
	taste_description = "slime"
	penetrates_skin = NONE

/datum/reagent/cryptococcus_spores/expose_mob(mob/living/exposed_mob, methods = TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if((methods & (PATCH|INGEST|INJECT)) || ((methods & VAPOR) && prob(min(reac_volume,100)*(1 - touch_protection))))
		exposed_mob.ForceContractDisease(new /datum/disease/cryptococcus(), FALSE, TRUE)
