///a heretic that got soultrapped by cultists. does nothing, other than signify they suck
/datum/antagonist/soultrapped_heretic
	name = "\improper Soultrapped Heretic"
	roundend_category = "Heretics"
	antagpanel_category = "Heretic"
	pref_flag = ROLE_HERETIC
	antag_moodlet = /datum/mood_event/soultrapped_heretic
	antag_hud_name = "heretic"

// Will never show up because they're shades inside a sword
/datum/mood_event/soultrapped_heretic
	description = "Eles me prenderam! Eu não posso escapar!"
	mood_change = -20

// always failure obj
/datum/objective/heretic_trapped
	name = "soultrapped failure"
	explanation_text = "Ajude o culto. Matem o culto. Ajude a tripulação. Matem a tripulação. Ajude seu capanga. Mate o seu capanga. Mate todo mundo. Rasteje suas correntes. Quebrem suas amarras."

/datum/antagonist/soultrapped_heretic/on_gain()
	..()
	var/policy = get_policy(ROLE_SOULTRAPPED_HERETIC)
	if(policy)
		to_chat(owner, policy)
	else
		to_chat(owner, span_ghostalert("Você é a alma presa do Herege que já foi. Você pode tentar convencer seus capangas a desamarrá-lo, concedendo-lhe algum grau de liberdade, e eles têm acesso a alguns de seus poderes. Você foi escravizado pelo culto, mas não é membro dele, e retenha o que resta do seu livre arbítrio. Além disso, há pouco a ser feito além de comentários. Tente não ficar preso em um armário."))
	owner.current.log_message("was sacrificed to Nar'sie as a Heretic, and sealed inside a longsword.", LOG_GAME)
	var/datum/objective/epic_fail = new /datum/objective/heretic_trapped()
	epic_fail.completed = FALSE
	objectives += epic_fail
