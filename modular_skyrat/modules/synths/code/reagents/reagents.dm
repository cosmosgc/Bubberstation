#define NANITE_SLURRY_ORGANIC_PURGE_RATE 4
#define NANITE_SLURRY_ORGANIC_VOMIT_CHANCE 25

/datum/reagent/medicine/syndicate_nanites //Used exclusively by Syndicate medical cyborgs
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC //Let's not cripple synth ops

/datum/reagent/medicine/stimulants
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC //Syndicate developed 'accelerants' for synths?

/datum/reagent/medicine/leporazine
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/flightpotion
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

// REAGENTS FOR SYNTHS

/datum/reagent/medicine/system_cleaner
	name = "System Cleaner"
	description = "Neutraliza compostos químicos nocivos dentro de sistemas sintéticos e atualiza o software do sistema."
	color = "#F1C40F"
	taste_description = "ethanol"
	metabolization_rate = 2 * REAGENTS_METABOLISM
	process_flags = REAGENT_SYNTHETIC

/datum/reagent/medicine/system_cleaner/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	affected_mob.adjust_tox_loss(-2 * REM * seconds_per_tick, 0)
	affected_mob.adjust_disgust(-5 * REM * seconds_per_tick)
	affected_mob.adjust_drunk_effect(-10 * REM * seconds_per_tick)
	var/remove_amount = 1 * REM * seconds_per_tick;
	for(var/thing in affected_mob.reagents.reagent_list)
		var/datum/reagent/reagent = thing
		if(reagent != src)
			affected_mob.reagents.remove_reagent(reagent.type, remove_amount)
	..()
	return TRUE

/datum/reagent/medicine/liquid_solder
	name = "Liquid Solder"
	description = "Repara danos de órgãos em sintéticos."
	color = "#727272"
	taste_description = "metal"
	process_flags = REAGENT_SYNTHETIC

/datum/reagent/medicine/liquid_solder/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick)
	for(var/obj/item/organ/organ in affected_mob.organs)
		affected_mob.adjust_organ_loss(organ.slot, -3 * REM * seconds_per_tick)
	if(prob(10))
		affected_mob.cure_trauma_type(resilience = TRAUMA_RESILIENCE_BASIC)
	return ..()

/datum/reagent/medicine/nanite_slurry
	name = "Nanite Slurry"
	description = "Um enxame localizado de nanomáquinas especializadas em reparar peças mecânicas. Quantidades concentradas em um hospedeiro sintético repararão rapidamente danos nos órgãos, danificando seu exterior e superaquecendo-os. Caso contrário, eles vão remover com segurança de um hospedeiro orgânico."
	color = "#cccccc"
	overdose_threshold = 15
	metabolization_rate = 1.25 * REAGENTS_METABOLISM
	process_flags = REAGENT_SYNTHETIC | REAGENT_ORGANIC
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	/// How much brute and burn individually is healed per tick
	var/healing = 3
	/// How much body temperature is increased by per overdose cycle on robotic bodyparts.
	var/temperature_change = 50


/datum/reagent/medicine/nanite_slurry/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick)
	var/heal_amount = healing * REM * seconds_per_tick
	affected_mob.heal_bodypart_damage(heal_amount, heal_amount, required_bodytype = BODYTYPE_ROBOTIC)
	return ..()

/datum/reagent/medicine/nanite_slurry/overdose_start(mob/living/affected_mob)
	if(affected_mob.mob_biotypes & MOB_ROBOTIC)
		to_chat(affected_mob, span_danger("Seus sistemas interiores estão superaquecendo enquanto estão sendo reparados!"))
	else
		to_chat(affected_mob, span_danger("Seu estômago dói quando concentrações de nanites começam a se eliminar."))

/datum/reagent/medicine/nanite_slurry/overdose_process(mob/living/carbon/affected_mob, seconds_per_tick, times_fired) // Mostly to treat a synthetic being EMP'd
	if(affected_mob.mob_biotypes & MOB_ROBOTIC)
		affected_mob.adjust_bodytemperature(temperature_change * REM * seconds_per_tick) // Overheats
		affected_mob.adjust_organ_loss(pick(ORGAN_SLOT_EYES,ORGAN_SLOT_EARS,ORGAN_SLOT_HEART,ORGAN_SLOT_LUNGS,ORGAN_SLOT_STOMACH,ORGAN_SLOT_LIVER),(-5 * REM * seconds_per_tick) * 1.5) // 30 units do ~ 70 brute and 20 burn and heal 240 organ damage (mostly used after being EMP'd)
		affected_mob.take_bodypart_damage(brute = (healing * REM * seconds_per_tick) * 1.5) // Damages at half healing rate
		return ..()
	affected_mob.reagents.remove_reagent(type, NANITE_SLURRY_ORGANIC_PURGE_RATE) //gets removed from organics very fast
	if(prob(NANITE_SLURRY_ORGANIC_VOMIT_CHANCE))
		affected_mob.vomit(vomit_flags = (MOB_VOMIT_MESSAGE | MOB_VOMIT_HARM), vomit_type = /obj/effect/decal/cleanable/vomit/nanites)
	return TRUE

#undef NANITE_SLURRY_ORGANIC_PURGE_RATE
#undef NANITE_SLURRY_ORGANIC_VOMIT_CHANCE


/datum/reagent/medicine/taste_suppressor
	name = "Taste Suppressor"
	description = "Uma medicina incolor tinha como objetivo entorpecer o paladar daqueles que a consumiam, desde que estivesse em seu sistema."
	color = "#AAAAAA77"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING // It has REAGENT_BLOOD_REGENERATING only because it makes it so Hemophages can safely drink it, which makes complete sense considering this is meant to suppress their tumor's reactiveness to anything that doesn't regenerate blood.


/datum/reagent/medicine/taste_suppressor/on_mob_metabolize(mob/living/affected_mob)
	. = ..()

	ADD_TRAIT(affected_mob, TRAIT_AGEUSIA, TRAIT_REAGENT)


/datum/reagent/medicine/taste_suppressor/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()

	REMOVE_TRAIT(affected_mob, TRAIT_AGEUSIA, TRAIT_REAGENT)
