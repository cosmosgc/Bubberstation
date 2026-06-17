/datum/antagonist/cult/shade
	name = "\improper Cult Shade"
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	antagpanel_category = ANTAG_GROUP_HORRORS
	///The time this player was most recently released from a soulstone.
	var/release_time
	///The time needed after release time to enable rune invocation.
	var/invoke_delay = (1 MINUTES)

/datum/antagonist/cult/shade/check_invoke_validity()
	if(isnull(release_time))
		to_chat(owner.current, span_alert("Você não pode invocar runas de dentro de uma pedra de alma!"))
		return FALSE

	if(release_time + invoke_delay > world.time)
		to_chat(owner.current, span_alert("Você não reuniu poder suficiente para invocar runas ainda. Você precisa ficar fora da sua pedra da alma por mais um tempo!"))
		return FALSE
	return TRUE
