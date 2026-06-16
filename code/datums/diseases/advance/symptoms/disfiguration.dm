/**Disfiguration
 * Increases stealth
 * No change to resistance
 * Increases stage speed
 * Slightly increases transmissibility
 * Critical level
 * Bonus: Adds disfiguration trait making the mob appear as "Unknown" to others.
 */
/datum/symptom/disfiguration
	name = "Disfiguration"
	desc = "O vírus liquefa os músculos faciais, desfigurando o hospedeiro."
	illness = "Broken Face"
	stealth = 2
	resistance = 0
	stage_speed = 3
	transmittable = 1
	level = 5
	severity = 1
	symptom_delay_min = 25
	symptom_delay_max = 75
	symptom_cure = /datum/reagent/consumable/milk

/datum/symptom/disfiguration/Activate(datum/disease/advance/disease)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/victim = disease.affected_mob
	var/obj/item/bodypart/head = victim.get_bodypart(BODY_ZONE_HEAD)
	if(!head || HAS_TRAIT_FROM(head, TRAIT_DISFIGURED, DISEASE_TRAIT))
		return

	switch(disease.stage)
		if(5)
			ADD_TRAIT(head, TRAIT_DISFIGURED, DISEASE_TRAIT)
			victim.visible_message(span_warning("[victim] O rosto parece ceder!"), span_notice("Você sente seu rosto amassado e cair!"))
		else
			victim.visible_message(span_warning("[victim] O rosto começa a contorcer..."), span_notice("Seu rosto está molhado e maleável..."))


/datum/symptom/disfiguration/End(datum/disease/advance/disease)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/victim = disease.affected_mob
	var/obj/item/bodypart/head = victim?.get_bodypart(BODY_ZONE_HEAD)
	if(head)
		REMOVE_TRAIT(head, TRAIT_DISFIGURED, DISEASE_TRAIT)
