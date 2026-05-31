/// Caused by dirty food. Makes you vomit stars.
/datum/disease/nebula_nausea
	name = "Nebula Nausea"
	desc = "Você não pode conter a beleza colorida do cosmos dentro."
	form = "Condition"
	agent = "Stars"
	cure_text = /datum/reagent/space_cleaner::name
	spread_text = "None"
	cures = list(/datum/reagent/space_cleaner)
	viable_mobtypes = list(/mob/living/carbon/human)
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	severity = DISEASE_SEVERITY_MEDIUM
	required_organ = ORGAN_SLOT_STOMACH
	max_stages = 5

/datum/disease/advance/nebula_nausea/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2)
			if(SPT_PROB(1, seconds_per_tick) && affected_mob.stat == CONSCIOUS)
				to_chat(affected_mob, span_warning("A beleza colorida do cosmos parece ter tido um impacto no seu equilíbrio."))
		if(3)
			if(SPT_PROB(1, seconds_per_tick) && affected_mob.stat == CONSCIOUS)
				to_chat(affected_mob, span_warning("Seu estômago gira com cores invisíveis pelos olhos humanos."))
		if(4)
			if(SPT_PROB(1, seconds_per_tick) && affected_mob.stat == CONSCIOUS)
				to_chat(affected_mob, span_warning("Parece que você está flutuando através de um mastro de cores celestes."))
		if(5)
			if(SPT_PROB(1, seconds_per_tick) && affected_mob.stat == CONSCIOUS)
				to_chat(affected_mob, span_warning("Seu estômago tornou-se uma nebulosa turbulenta, girando com padrões caleidoscópicos."))
			else
				affected_mob.vomit(vomit_flags = (MOB_VOMIT_MESSAGE | MOB_VOMIT_HARM), vomit_type = /obj/effect/decal/cleanable/vomit/nebula, lost_nutrition = 10, distance = 2)
