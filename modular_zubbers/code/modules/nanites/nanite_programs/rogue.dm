//Programs generated through degradation of other complex programs.
//They generally cause minor damage or annoyance.

//Last stop of the error train
/datum/nanite_program/glitch
	name = "Glitch"
	desc = "Uma pesada corrupção de software que faz os nanites gradualmente quebrarem."
	use_rate = 1.5
	unique = FALSE
	rogue_types = list()

//Generic body-affecting programs will decay into this
/datum/nanite_program/necrotic
	name = "Necrosis"
	desc = "Os nanites atacam tecidos internos indiscriminadamente, causando danos generalizados."
	use_rate = 0.75
	unique = FALSE
	rogue_types = list(/datum/nanite_program/glitch)

/datum/nanite_program/necrotic/active_effect()
	host_mob.adjust_brute_loss(0.75, TRUE)
	if(prob(1))
		to_chat(host_mob, span_warning("Você sente uma leve dor de algum lugar dentro de você."))

//Programs that don't directly interact with the body will decay into this
/datum/nanite_program/toxic
	name = "Toxin Buildup"
	desc = "Os nanites causam uma lenta mas constante acumulação de toxinas dentro do hospedeiro."
	use_rate = 0.25
	unique = FALSE
	rogue_types = list(/datum/nanite_program/glitch)

/datum/nanite_program/toxic/active_effect()
	host_mob.adjust_tox_loss(0.5)
	if(prob(1))
		to_chat(host_mob, span_warning("Você se sente um pouco doente."))

//Generic blood-affecting programs will decay into this
/datum/nanite_program/suffocating
	name = "Hypoxemia"
	desc = "Os nanites impedem que o sangue do hospedeiro absorva oxigênio eficientemente."
	use_rate = 0.75
	unique = FALSE
	rogue_types = list(/datum/nanite_program/glitch)

/datum/nanite_program/suffocating/active_effect()
	host_mob.adjust_oxy_loss(3, 0)
	if(prob(1))
		to_chat(host_mob, span_warning("Sente falta de ar."))

//Generic brain-affecting programs will decay into this
/datum/nanite_program/brain_decay
	name = "Neuro-Necrosis"
	desc = "Os nanites procuram e atacam células cerebrais, causando danos neurais ao hospedeiro."
	use_rate = 0.75
	unique = FALSE
	rogue_types = list(/datum/nanite_program/necrotic)

/datum/nanite_program/brain_decay/active_effect()
	if(prob(4))
		host_mob.set_hallucinations_if_lower(15)
	host_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 1)

//Generic brain-affecting programs can also decay into this
/datum/nanite_program/brain_misfire
	name = "Brain Misfire"
	desc = "Os nanites interferem nas vias neurais, causando pequenos distúrbios psicológicos."
	use_rate = 0.50
	unique = FALSE
	rogue_types = list(/datum/nanite_program/brain_decay)

/datum/nanite_program/brain_misfire/active_effect()
	if(prob(10))
		switch(rand(1,4))
			if(1)
				host_mob.adjust_hallucinations(15)
			if(2)
				host_mob.adjust_confusion(10)
			if(3)
				host_mob.adjust_drowsiness(10)
			if(4)
				host_mob.adjust_slurring(10)

//Generic skin-affecting programs will decay into this
/datum/nanite_program/skin_decay
	name = "Dermalysis"
	desc = "Os nanites atacam as células da pele, causando irritação, erupções cutâneas e pequenos danos."
	use_rate = 0.25
	unique = FALSE
	rogue_types = list(/datum/nanite_program/necrotic)

/datum/nanite_program/skin_decay/active_effect()
	host_mob.adjust_brute_loss(0.25)
	if(prob(5)) //itching
		var/picked_bodypart = pick(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)
		var/obj/item/bodypart/bodypart = host_mob.get_bodypart(picked_bodypart)
		var/can_scratch = !host_mob.incapacitated && host_mob.is_location_accessible(picked_bodypart)

		host_mob.visible_message("[can_scratch ? span_warning("[host_mob] scratches [host_mob.p_their()] [bodypart.name].") : ""]",\
		span_warning("Your [bodypart.name] itches. [can_scratch ? " You scratch it." : ""]"))

//Generic nerve-affecting programs will decay into this
/datum/nanite_program/nerve_decay
	name = "Nerve Decay"
	desc = "Os nanites atacam os nervos do hospedeiro, causando falta de coordenação e curtos surtos de paralisia."
	use_rate = 1
	unique = FALSE
	rogue_types = list(/datum/nanite_program/necrotic)

/datum/nanite_program/nerve_decay/active_effect()
	if(prob(5))
		to_chat(host_mob, span_warning("Você se sente desequilibrado!"))
		host_mob.adjust_confusion(10)
	else if(prob(4))
		to_chat(host_mob, span_warning("Você não sente suas mãos!"))
		host_mob.drop_all_held_items()
	else if(prob(4))
		to_chat(host_mob, span_warning("Não sente as pernas!"))
		host_mob.Paralyze(30)
