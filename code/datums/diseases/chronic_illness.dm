/datum/disease/chronic_illness
	name = "Hereditary Manifold Sickness"
	max_stages = 5
	spread_text = "None"
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	disease_flags = CHRONIC
	infectable_biotypes = MOB_ORGANIC | MOB_MINERAL | MOB_ROBOTIC
	process_dead = TRUE
	stage_prob = 0.25
	cure_text = "Abatida por" + /datum/reagent/medicine/sansufentanyl::name
	cures = list(/datum/reagent/medicine/sansufentanyl)
	infectivity = 0
	agent = "Quantum Entanglement"
	viable_mobtypes = list(/mob/living/carbon/human)
	desc = "Uma doença descoberta em um laboratório Interdyne causada pela sujeição à tecnologia de correção de fluxo temporal. É completamente incurável, embora possa ser tratado para reverter sua progressão e não contágio. Se não for tratado, o sujeito sofrerá de vários sintomas, incluindo, mas não limitado a tontura, náuseas, palpitações cardíacas, e nos estágios finais, morte."
	bypasses_immunity = TRUE // BUBBER EDIT ADD
	severity = DISEASE_SEVERITY_UNCURABLE
	bypasses_immunity = TRUE
	var/being_stealthy = TRUE // BUBBER EDIT ADD

/datum/disease/chronic_illness/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(1)
			carrier = FALSE // Go fuck yourself
			being_stealthy = TRUE // BUBBER EDIT ADD
		if(2)
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_warning("Você se sente tonta."))
				affected_mob.adjust_confusion(6 SECONDS)
				being_stealthy = FALSE // BUBBER EDIT ADD
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_notice("Olhe para sua mão. Sua visão está embaçada."))
				affected_mob.set_eye_blur_if_lower(10 SECONDS)
				being_stealthy = FALSE // BUBBER EDIT ADD
		if(3)
			var/need_mob_update = FALSE
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("Você sente uma dor muito aguda no peito!"))
				being_stealthy = FALSE // BUBBER EDIT ADD
				if(prob(45))
					affected_mob.vomit(VOMIT_CATEGORY_BLOOD, lost_nutrition = 20)
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("[pick("You feel your heart slowing...", "You relax and slow your heartbeat.")]"))
				need_mob_update += affected_mob.adjust_stamina_loss(70, updating_stamina = FALSE)
				being_stealthy = FALSE // BUBBER EDIT ADD
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("Você sente um zumbido no seu cérebro."))
				SEND_SOUND(affected_mob, sound('sound/items/weapons/flash_ring.ogg'))
				being_stealthy = FALSE // BUBBER EDIT ADD
			if(SPT_PROB(0.5, seconds_per_tick))
				need_mob_update += affected_mob.adjust_brute_loss(1, updating_health = FALSE)
			if(need_mob_update)
				affected_mob.updatehealth()
		if(4)
			var/need_mob_update = FALSE
			if(prob(30))
				affected_mob.playsound_local(affected_mob, 'sound/effects/singlebeat.ogg', 100, FALSE, use_reverb = FALSE)
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("Você sente uma dor horrível no peito!"))
				if(prob(75))
					affected_mob.vomit(VOMIT_CATEGORY_BLOOD, lost_nutrition = 45)
			if(SPT_PROB(1, seconds_per_tick))
				need_mob_update += affected_mob.adjust_stamina_loss(100, updating_stamina = FALSE)
				affected_mob.visible_message(span_warning("[affected_mob] Colapsos!"))
				if(prob(30))
					to_chat(affected_mob, span_danger("Sua visão escurece enquanto desmaia!"))
					affected_mob.AdjustSleeping(1 SECONDS)
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("[pick("You feel as though your atoms are accelerating in place.", "You feel like you're being torn apart!")]"))
				affected_mob.emote("scream")
				need_mob_update += affected_mob.adjust_brute_loss(10, updating_health = FALSE)
			if(need_mob_update)
				affected_mob.updatehealth()
		if(5)
			switch(rand(1,2))
				if(1)
					to_chat(affected_mob, span_notice("Você sente que seus átomos começam a realinhar. Você está segura. Por enquanto."))
					update_stage(1)
				if(2)
					to_chat(affected_mob, span_boldwarning("Não há lugar para você nesta linha do tempo."))
					affected_mob.adjust_stamina_loss(100, forced = TRUE)
					playsound(affected_mob.loc, 'sound/effects/magic/repulse.ogg', 100, FALSE)
					affected_mob.emote("scream")
					for(var/mob/living/viewers in viewers(3, affected_mob.loc))
						viewers.flash_act()
					new /obj/effect/decal/cleanable/plasma(affected_mob.loc)
					new /obj/effect/decal/cleanable/ash(affected_mob.loc)
					affected_mob.visible_message(span_warning("[affected_mob] é apagado da linha do tempo!"), span_userdanger("Você está arrancado da linha do tempo!"))
					affected_mob.investigate_log("has been dusted / deleted by [name].", INVESTIGATE_DEATHS)
					affected_mob.ghostize(can_reenter_corpse = FALSE)
					qdel(affected_mob)

//BUBBER EDIT BEGIN - Costly warning if it sneaks through to stage four.
/datum/disease/chronic_illness/update_stage(new_stage)
	. = ..()
	if(new_stage == 4 && being_stealthy)
		to_chat(affected_mob, span_danger("[pick("You feel as though your atoms are accelerating in place.", "You feel like you're being torn apart!")]"))
		affected_mob.emote("scream")
		affected_mob.adjust_brute_loss(10)
		being_stealthy = FALSE
// BUBBER EDIT END
