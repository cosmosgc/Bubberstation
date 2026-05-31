/datum/quirk/drunkhealing
	name = "Drunken Resilience"
	desc = "Nada como uma boa bebida para se sentir no topo do mundo. Quando está bêbado, se recupera lentamente dos ferimentos."
	icon = FA_ICON_WINE_BOTTLE
	value = 8
	gain_text = span_notice("Você acha que uma bebida lhe faria bem.")
	lose_text = span_danger("Não sente mais que beber aliviaria sua dor.")
	medical_record_text = "O paciente tem metabolismo hepático incomum e pode regenerar feridas lentamente bebendo bebidas alcoólicas."
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_PROCESSES
	mail_goodies = list(/obj/effect/spawner/random/food_or_drink/booze)

/datum/quirk/drunkhealing/process(seconds_per_tick)
	var/need_mob_update = FALSE
	switch(quirk_holder.get_drunk_amount())
		if (6 to 40)
			need_mob_update += quirk_holder.adjust_brute_loss(-0.1 * seconds_per_tick, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC)
			need_mob_update += quirk_holder.adjust_fire_loss(-0.05 * seconds_per_tick, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC)
		if (41 to 60)
			need_mob_update += quirk_holder.adjust_brute_loss(-0.4 * seconds_per_tick, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC)
			need_mob_update += quirk_holder.adjust_fire_loss(-0.2 * seconds_per_tick, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC)
		if (61 to INFINITY)
			need_mob_update += quirk_holder.adjust_brute_loss(-0.8 * seconds_per_tick, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC)
			need_mob_update += quirk_holder.adjust_fire_loss(-0.4 * seconds_per_tick, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC)
	if(need_mob_update)
		quirk_holder.updatehealth()
