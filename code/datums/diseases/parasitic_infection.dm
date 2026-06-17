/datum/disease/parasite
	form = "Parasite"
	name = "Parasitic Infection"
	max_stages = 4
	cure_text = "Remoção cirúrgica do fígado"
	agent = "Food-bourne Parasite"
	spread_text = "None"
	viable_mobtypes = list(/mob/living/carbon/human)
	spreading_modifier = 1
	desc = "Um parasita desconhecido, provavelmente entrando no corpo através de alimentos mal preparados, infectou o fígado do sujeito.\
Se não for tratada, o sujeito perderá nutrientes, e eventualmente perderá o fígado."
	severity = DISEASE_SEVERITY_HARMFUL
	disease_flags = CAN_CARRY|CAN_RESIST
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	required_organ = ORGAN_SLOT_LIVER
	bypasses_immunity = TRUE

/datum/disease/parasite/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(1)
			if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.emote("cough")
		if(2)
			if(SPT_PROB(5, seconds_per_tick))
				if(prob(50))
					to_chat(affected_mob, span_notice("Você já sente a perda de peso!"))
				affected_mob.adjust_nutrition(-3)
		if(3)
			if(SPT_PROB(10, seconds_per_tick))
				if(prob(20))
					to_chat(affected_mob, span_notice("Está começando a sentir a perda de peso."))
				affected_mob.adjust_nutrition(-6)
		if(4)
			if(SPT_PROB(16, seconds_per_tick))
				if(affected_mob.nutrition >= 100)
					if(prob(10))
						to_chat(affected_mob, span_warning("Parece que seu corpo está perdendo peso rapidamente!"))
					affected_mob.adjust_nutrition(-12)
				else
					to_chat(affected_mob, span_warning("Você se sente muito, muito mais leve!"))
					affected_mob.vomit(VOMIT_CATEGORY_BLOOD, lost_nutrition = 20)
					// disease code already checks if the liver exists otherwise it is cured
					var/obj/item/organ/liver/affected_liver = affected_mob.get_organ_slot(ORGAN_SLOT_LIVER)
					affected_liver.Remove(affected_mob)
					affected_liver.forceMove(get_turf(affected_mob))
					cure()
					return FALSE
