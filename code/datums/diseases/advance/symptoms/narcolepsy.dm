/*Narcolepsy
 * Slight reduction to stealth
 * Reduces resistance
 * Greatly reduces stage speed
 * No change to transmissibility
 * Fatal level
 * Bonus: Causes drowsiness and sleep.
*/
/datum/symptom/narcolepsy
	name = "Narcolepsy"
	desc = "O vírus causa um desequilíbrio hormonal, deixando o hospedeiro sonolento e narcoléptico."
	illness = "Aurora Snorealis"
	stealth = -1
	resistance = -2
	stage_speed = -2
	transmittable = 0
	level = 6
	symptom_delay_min = 30
	symptom_delay_max = 85
	severity = 4
	symptom_cure = /datum/reagent/medicine/ondansetron
	cure_color = "yellow"
	var/yawning = FALSE
	threshold_descs = list(
		"Transmission 4" = "Causes the host to periodically emit a yawn that tries to infect bystanders within 6 meters of the host.",
		"Stage Speed 10" = "Causes narcolepsy more often, increasing the chance of the host falling asleep.",
	)

/datum/symptom/narcolepsy/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalTransmittable() >= 4) //yawning (mostly just some copy+pasted code from sneezing, with a few tweaks)
		yawning = TRUE
	if(A.totalStageSpeed() >= 10) //act more often
		symptom_delay_min = 20
		symptom_delay_max = 45

/datum/symptom/narcolepsy/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return

	var/mob/living/M = A.affected_mob
	switch(A.stage)
		if(1)
			if(prob(50))
				to_chat(M, span_warning("Você se sente cansado."))
		if(2)
			if(prob(50))
				to_chat(M, span_warning("Você se sente muito cansado."))
		if(3)
			if(prob(50))
				to_chat(M, span_warning("Tente se concentrar em ficar acordado."))

			M.adjust_drowsiness_up_to(10 SECONDS, 140 SECONDS)

		if(4)
			if(prob(50))
				if(yawning)
					to_chat(M, span_warning("Você tenta não suprimir um bocejo."))
				else
					to_chat(M, span_warning("Você cochilou por um momento.")) //you can't really yawn while nodding off, can you?

			M.adjust_drowsiness_up_to(20 SECONDS, 140 SECONDS)

			if(yawning)
				M.emote("yawn")
				A.airborne_spread(6)

		if(5)
			if(prob(50))
				to_chat(M, span_warning("[pick("So tired...","You feel very sleepy.","You have a hard time keeping your eyes open.","You try to stay awake.")]"))

			M.adjust_drowsiness_up_to(80 SECONDS, 140 SECONDS)

			if(yawning)
				M.emote("yawn")
				A.airborne_spread(6)
