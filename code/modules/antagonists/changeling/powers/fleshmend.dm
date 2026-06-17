/datum/action/changeling/fleshmend
	name = "Fleshmend"
	desc = "Nossa carne regenera-se rapidamente, curando nossas queimaduras, contusões, e falta de ar, bem como escondendo todas as nossas cicatrizes. Custa 20 produtos químicos."
	helptext = "If we are on fire, the healing effect will not function. Does not regrow limbs or restore lost blood. Functions while unconscious."
	button_icon_state = "fleshmend"
	category = "combat"
	chemical_cost = 20
	dna_cost = 2
	req_stat = HARD_CRIT

//Starts healing you every second for 10 seconds.
//Can be used whilst unconscious.
/datum/action/changeling/fleshmend/sting_action(mob/living/user)
	if(user.has_status_effect(/datum/status_effect/fleshmend))
		user.balloon_alert(user, "Já está emendando a carne!")
		return
	..()
	to_chat(user, span_notice("Começamos a nos curar rapidamente."))
	user.apply_status_effect(/datum/status_effect/fleshmend)
	return TRUE

//Check buffs.dm for the fleshmend status effect code
