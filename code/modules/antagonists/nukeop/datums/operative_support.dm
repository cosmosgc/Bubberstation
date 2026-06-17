/datum/antagonist/nukeop/support
	name = ROLE_OPERATIVE_OVERWATCH
	show_to_ghosts = TRUE
	send_to_spawnpoint = TRUE
	nukeop_outfit = /datum/outfit/syndicate/support

/datum/antagonist/nukeop/support/greet()
	owner.current.playsound_local(get_turf(owner.current), 'sound/machines/printer.ogg', 100, 0, use_reverb = FALSE)
	to_chat(owner, span_big("You are a [name]! You've been temporarily assigned to provide camera overwatch and manage communications for a nuclear operative team!"))
	to_chat(owner, span_red("Use suas ferramentas para configurar seu equipamento como quiser, mas não tente deixar seu posto avançado."))
	owner.announce_objectives()

/datum/antagonist/nukeop/support/on_gain()
	..()
	for(var/datum/mind/teammate_mind in nuke_team.members)
		var/mob/living/our_teammate = teammate_mind.current
		if(!istype(our_teammate)) // If an agent is purchased after the death of an agent -- when they no longer have a body, we skip that mind because they're invalid.
			continue

		our_teammate.AddComponent( \
			/datum/component/simple_bodycam, \
			camera_name = "operative bodycam", \
			c_tag = "[our_teammate.real_name]", \
			network = OPERATIVE_CAMERA_NET, \
			emp_proof = FALSE, \
		)
		our_teammate.playsound_local(get_turf(owner.current), 'sound/items/weapons/egloves.ogg', 100, 0)
		to_chat(our_teammate, span_notice("Um Agente de Inteligência de Overwatch foi designado para sua equipe. Sorria, você está na câmera!"))

	RegisterSignal(nuke_team, COMSIG_NUKE_TEAM_ADDITION, PROC_REF(late_bodycam))

	owner.current.grant_language(/datum/language/codespeak)

/datum/antagonist/nukeop/support/get_spawnpoint()
	return pick(GLOB.nukeop_base_overwatch_start)

/datum/antagonist/nukeop/support/forge_objectives()
	var/datum/objective/overwatch/objective = new
	objective.owner = owner
	objectives += objective

/datum/antagonist/nukeop/support/proc/late_bodycam(datum/source, mob/living/new_teammate)
	SIGNAL_HANDLER
	new_teammate.AddComponent( \
		/datum/component/simple_bodycam, \
		camera_name = "operative bodycam", \
		c_tag = "[new_teammate.real_name]", \
		network = OPERATIVE_CAMERA_NET, \
		emp_proof = FALSE, \
	)
	to_chat(new_teammate, span_notice("Você foi equipado com uma câmera, visível pelo seu agente de inteligência Overwatch. Certifique-se de mostrar-lhes uma boa performance!"))

/datum/objective/overwatch
	explanation_text = "Fornecer suporte e vigilância à sua equipe operacional!"

/datum/objective/overwatch/check_completion()
	return GLOB.station_was_nuked
