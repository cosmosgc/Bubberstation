/*Eternal Youth
 * Greatly increases stealth
 * Tremendous increase to resistance
 * Tremendous increase to stage speed
 * Tremendous reduction to transmissibility
 * Critical level
 * Bonus: Can be used to buff your virus
*/

/datum/symptom/youth
	name = "Eternal Youth"
	desc = "O vírus torna-se simbioticamente conectado às células do corpo do hospedeiro, prevenindo e invertendo o envelhecimento.\
O vírus, por sua vez, torna-se mais resistente, espalha-se mais rápido, e é mais difícil de detectar, embora não prospere tão bem sem um hospedeiro."
	stealth = 3
	resistance = 4
	stage_speed = 4
	transmittable = -4
	level = 5
	base_message_chance = 100
	symptom_delay_min = 25
	symptom_delay_max = 50
	symptom_cure = null

/datum/symptom/youth/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	var/mob/living/M = A.affected_mob
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		switch(A.stage)
			if(1)
				if(H.age > 41)
					H.age = 41
					to_chat(H, span_notice("Você não tem tanta energia há anos!"))
			if(2)
				if(H.age > 36)
					H.age = 36
					to_chat(H, span_notice("Você de repente está de bom humor."))
			if(3)
				if(H.age > 31)
					H.age = 31
					to_chat(H, span_notice("Você começa a sentir mais lithe."))
			if(4)
				if(H.age > 26)
					H.age = 26
					to_chat(H, span_notice("Você se sente revigorada."))
			if(5)
				if(H.age > 21)
					H.age = 21
					to_chat(H, span_notice("Você sente que pode enfrentar o mundo!"))
