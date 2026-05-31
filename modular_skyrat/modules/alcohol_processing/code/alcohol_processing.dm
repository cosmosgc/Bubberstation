#define BAC_STAGE_1_ACTIVE 0.01
#define BAC_STAGE_2_WARN 0.05
#define BAC_STAGE_2_ACTIVE 0.07
#define BAC_STAGE_3_WARN 0.11
#define BAC_STAGE_3_ACTIVE 0.13
#define BAC_STAGE_4_WARN 0.17
#define BAC_STAGE_4_ACTIVE 0.19
#define BAC_STAGE_5_WARN 0.23

/datum/reagent/consumable/ethanol
	metabolization_rate = 0.3 * REAGENTS_METABOLISM

/atom/movable/screen/alert/status_effect/drunk
	desc = "O álcool que tem bebido está prejudicando sua fala, habilidades motoras e cognição mental. Certifique-se de agir como tal. Verifique seu nível de embriaguez atual usando seu estado de humor."

/// Adds a moodlet entry based on if the mob currently has alcohol processing in their system.
/datum/mood/proc/get_alcohol_processing(mob/user)
	if(user.reagents.reagent_list.len)
		for(var/datum/reagent/consumable/ethanol/booze in user.reagents.reagent_list)
			return TRUE

/// Adds a moodlet entry based on the current blood alcohol content of the mob.
/datum/mood/proc/get_drunk_mood(mob/user)
	var/mob/living/target = user
	var/blood_alcohol_content = target.get_blood_alcohol_content()
	switch(blood_alcohol_content)
		if(BAC_STAGE_1_ACTIVE to BAC_STAGE_2_WARN)
			return span_info("Tomamos uma bebida, hora de relaxar!")
		if(BAC_STAGE_2_WARN to BAC_STAGE_2_ACTIVE)
			return span_nicegreen("Estou começando a sentir aquela bebida.")
		if(BAC_STAGE_2_ACTIVE to BAC_STAGE_3_WARN)
			return span_nicegreen("Um pouco bêbado, isso é bom!")
		if(BAC_STAGE_3_WARN to BAC_STAGE_3_ACTIVE)
			return span_nicegreen("Essas bebidas estão começando a bater!")
		if(BAC_STAGE_3_ACTIVE to BAC_STAGE_4_WARN)
			return span_nicegreen("Não me lembro de quantas bebi, mas me sinto ótima!")
		if(BAC_STAGE_4_WARN to BAC_STAGE_4_ACTIVE)
			return span_warning("Acho que bebi demais... Eu deveria parar... beber um pouco de água...")
		if(BAC_STAGE_4_ACTIVE to BAC_STAGE_5_WARN)
			return span_bolddanger("Não estou me sentindo tão quente...")
		if(BAC_STAGE_5_WARN to INFINITY)
			return span_bolddanger("Tem algum médico por aqui? Eu realmente não me sinto bem...")

#undef BAC_STAGE_1_ACTIVE
#undef BAC_STAGE_2_WARN
#undef BAC_STAGE_2_ACTIVE
#undef BAC_STAGE_3_WARN
#undef BAC_STAGE_3_ACTIVE
#undef BAC_STAGE_4_WARN
#undef BAC_STAGE_4_ACTIVE
#undef BAC_STAGE_5_WARN
