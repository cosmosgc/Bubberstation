//Overrides TG's version of the proc - only changes are the examine texts, and the extra DNR check
/mob/living/carbon/human/generate_death_examine_text()
	var/mob/dead/observer/ghost = get_ghost(TRUE, TRUE)
	var/t_He = p_They()
	var/t_is = p_are()
	//This checks to see if the body is revivable
	if(key || !get_organ_by_type(/obj/item/organ/brain) || ghost?.can_reenter_corpse)
		return span_deadsay("[t_He] [t_is]Não há sinais de vida.")
	else
		return span_deadsay("[t_He] [t_is]Não há sinais de vida e sua alma se foi...")
