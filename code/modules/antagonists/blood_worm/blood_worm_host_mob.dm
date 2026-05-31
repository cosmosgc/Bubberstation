/mob/living/blood_worm_host
	name = "Host"
	desc = "Como está examinando isso? Essa coisa nem está embodida."

	var/datum/action/changeling_expel_worm/expel_worm_action

/mob/living/blood_worm_host/Login()
	. = ..()
	if (!.)
		return

	if (IS_CHANGELING(src))
		to_chat(src, span_good("O verme de sangue em seu corpo é vulnerável à sua proeza genética!"))

		if (!expel_worm_action)
			expel_worm_action = new(src)
			expel_worm_action.Grant(src)
