#define MAXIMUM_MARAUDERS 2

/datum/scripture/marauder
	name = "Summon Clockwork Marauder"
	desc = "Invoca uma Marauder Clockwork, um poderoso guerreiro que pode desviar ataques variados. Requer 100 de vitalidade."
	tip = "Use Clockwork Marauders as a powerful soldier to send into combat when the fighting gets rough."
	button_icon_state = "Clockwork Marauder"
	power_cost = 2000
	vitality_cost = 100
	invocation_time = 30 SECONDS
	invocation_text = list("Através dos fogos e chamas...", "Nada supera Eng'Ine!")
	category = SPELLTYPE_PRESERVATION
	cogs_required = 6
	invokers_required = 3
	// Ref to the selected observer
	var/mob/dead/observer/selected


/datum/scripture/marauder/Destroy(force, ...)
	selected = null
	return ..()


/datum/scripture/marauder/invoke()
	var/list/candidates = SSpolling.poll_ghost_candidates("Do you want to play as a Clockwork Marauder?", role = ROLE_PAI, check_jobban = FALSE, poll_time = 10 SECONDS, ignore_category = POLL_IGNORE_CONSTRUCT)
	if(length(candidates))
		selected = pick(candidates)

	if(!selected)
		to_chat(invoker, span_brass("<i>Não há fantasmas dispostos a ser um Marauder Clockwork!</i>"))
		invoke_fail()

		if(invocation_chant_timer)
			deltimer(invocation_chant_timer)
			invocation_chant_timer = null

		end_invoke()
		return
	return ..()


/datum/scripture/marauder/invoke_success()
	var/mob/living/basic/clockwork_marauder/new_mob = new (get_turf(invoker))
	new_mob.visible_message(span_notice("[new_mob] flashes into existance!"))
	new_mob.key = selected.key
	to_chat(new_mob, span_brass("You are a Clockwork Marauder! You have a [new_mob.shield_health]-hit shield that will protect you against any damage taken. Have a servant repair you with a welder, should you or your shield become too damaged."))
	selected = null


/datum/scripture/marauder/check_special_requirements(mob/user)
	. = ..()
	if(!.)
		return FALSE

	if(length(GLOB.clockwork_marauders) >= MAXIMUM_MARAUDERS)
		to_chat(user, span_brass("Your limited power prevents you from creating more than [MAXIMUM_MARAUDERS] Clockwork Marauders."))
		return FALSE

	return TRUE

#undef MAXIMUM_MARAUDERS
