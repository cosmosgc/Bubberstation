// Numbing effects

/datum/reagent/consumable/ethanol/drunken_espatier
	metabolized_traits = list(TRAIT_ANALGESIA)

//Changeling balancing
/datum/reagent/medicine/rezadone/expose_mob(mob/living/carbon/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!istype(exposed_mob))
		return
	if(HAS_TRAIT_FROM(exposed_mob, TRAIT_HUSK, CHANGELING_DRAIN) && (exposed_mob.reagents.get_reagent_amount(/datum/reagent/medicine/rezadone) + reac_volume >= 20))//Costs a little more than a normal husk
		exposed_mob.cure_husk(CHANGELING_DRAIN)
		exposed_mob.visible_message("<span class='nicegreen'>Um casaco líquido de borracha[exposed_mob]São lenços.[exposed_mob]Parece muito mais saudável!")

/datum/reagent/medicine/regen_jelly/expose_mob(mob/living/carbon/human/exposed_mob, reac_volume)
	. = ..()
	if(!istype(exposed_mob) || (reac_volume < 0.5))
		return

	exposed_mob.update_body_parts()
