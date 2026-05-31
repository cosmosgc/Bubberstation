/datum/scripture/create_structure/prosperity_prism
	name = "Prosperity Prism"
	desc = "Cria um prisma que removerá todas as formas de danos de servos próximos ao longo do tempo, juntamente com venenos de purga. Requer energia de um selo de transmissão."
	tip = "Create a prosperity prism to heal servants while defending your base."
	button_icon_state = "Prolonging Prism"
	power_cost = 300
	invocation_time = 8 SECONDS
	invocation_text = list("Sua luz curará as feridas sob minha pele.")
	summoned_structure = /obj/structure/destructible/clockwork/gear_base/powered/prosperity_prism
	cogs_required = 2
	category = SPELLTYPE_STRUCTURES


/datum/scripture/create_structure/prosperity_prism/check_special_requirements(mob/user)
	. = ..()
	if(!.)
		return FALSE

	if(locate(/obj/structure/destructible/clockwork/gear_base/powered/prosperity_prism) in range(3)) // No stacking heals for you
		user.balloon_alert(user, "muito perto de outro prisma!")
		return FALSE

	return TRUE
