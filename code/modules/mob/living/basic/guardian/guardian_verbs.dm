/// Pop out into the realm of the living.
/mob/living/basic/guardian/proc/manifest(forced)
	if (is_deployed() || isnull(summoner) || isnull(summoner.loc) || istype(summoner.loc, /obj/effect) || (!COOLDOWN_FINISHED(src, manifest_cooldown) && !forced) || locked)
		return FALSE
	forceMove(summoner.loc)
	new /obj/effect/temp_visual/guardian/phase(loc)
	COOLDOWN_START(src, manifest_cooldown, 1 SECONDS)
	reset_perspective()
	manifest_effects()
	return TRUE

/// Go and hide inside your boss.
/mob/living/basic/guardian/proc/recall(forced)
	if (!is_deployed() || isnull(summoner) || (!COOLDOWN_FINISHED(src, manifest_cooldown) && !forced) || locked)
		return FALSE
	new /obj/effect/temp_visual/guardian/phase/out(loc)
	recall_effects()
	forceMove(summoner)
	COOLDOWN_START(src, manifest_cooldown, 1 SECONDS)
	return TRUE

/// Do something when we appear.
/mob/living/basic/guardian/proc/manifest_effects()
	SHOULD_CALL_PARENT(TRUE)
	SEND_SIGNAL(src, COMSIG_GUARDIAN_MANIFESTED)

/// Do something when we vanish.
/mob/living/basic/guardian/proc/recall_effects()
	SHOULD_CALL_PARENT(TRUE)
	SEND_SIGNAL(src, COMSIG_GUARDIAN_RECALLED)

/// Swap to a different mode... if we have one
/mob/living/basic/guardian/proc/toggle_modes()
	to_chat(src, span_bolddanger("Você não tem outro modo!"))


/// Turn an internal light on or off.
/mob/living/basic/guardian/proc/toggle_light()
	if (!light_on)
		to_chat(src, span_notice("Você ativa sua luz."))
		set_light_on(TRUE)
	else
		to_chat(src, span_notice("Você desativa sua luz."))
		set_light_on(FALSE)

/// Speak with our boss at a distance
/mob/living/basic/guardian/proc/communicate()
	if (isnull(summoner))
		return
	var/sender_key = key
	var/input = tgui_input_text(src, "Enter a message to tell your summoner", "Guardian", max_length = MAX_MESSAGE_LEN)
	if (sender_key != key || !input) //guardian got reset, or did not enter anything
		return

	var/preliminary_message = span_boldholoparasite("[input]") //apply basic color/bolding
	var/my_message = "<font color=\"[guardian_colour]\">[span_bolditalic(src.name)]:</font> [preliminary_message]" //add source, color source with the guardian's color

	to_chat(summoner, "[my_message]")
	var/list/guardians = summoner.get_all_linked_holoparasites()
	for(var/guardian in guardians)
		to_chat(guardian, "[my_message]")
	for(var/dead_mob in GLOB.dead_mob_list)
		var/link = FOLLOW_LINK(dead_mob, src)
		to_chat(dead_mob, "[link] [my_message]")

	src.log_talk(input, LOG_SAY, tag="guardian")


/// Speak with your guardian(s) at a distance.
/datum/action/cooldown/mob_cooldown/guardian_comms
	name = "Guardian Communication"
	desc = "Comunique-se telepaticamente com seu tutor."
	button_icon = 'icons/hud/guardian.dmi'
	button_icon_state = "communicate"
	background_icon = 'icons/hud/guardian.dmi'
	background_icon_state = "base"
	check_flags = NONE
	click_to_activate = FALSE
	cooldown_time = 0 SECONDS
	melee_cooldown_time = 0
	shared_cooldown = NONE

/datum/action/cooldown/mob_cooldown/guardian_comms/Activate(atom/target)
	StartCooldown(360 SECONDS)
	var/input = tgui_input_text(owner, "Enter a message to tell your guardian", "Message", max_length = MAX_MESSAGE_LEN)
	StartCooldown()
	if (!input)
		return FALSE

	var/preliminary_message = span_boldholoparasite("[input]") //apply basic color/bolding
	var/my_message = span_boldholoparasite("<i>[owner]:</i> [preliminary_message]") //add source, color source with default grey...

	to_chat(owner, "[my_message]")
	var/mob/living/living_owner = owner
	var/list/guardians = living_owner.get_all_linked_holoparasites()
	for(var/mob/living/basic/guardian/guardian as anything in guardians)
		to_chat(guardian, "<font color=\"[guardian.guardian_colour]\">[span_bolditalic(owner.real_name)]:</font> [preliminary_message]" )
	for(var/dead_mob in GLOB.dead_mob_list)
		var/link = FOLLOW_LINK(dead_mob, owner)
		to_chat(dead_mob, "[link] [my_message]")
	owner.log_talk(input, LOG_SAY, tag="guardian")

	return TRUE


/// Tell your slacking or distracted guardian to come home.
/datum/action/cooldown/mob_cooldown/recall_guardian
	name = "Recall Guardian"
	desc = "Lembre-se de seu guardião."
	button_icon = 'icons/hud/guardian.dmi'
	button_icon_state = "recall"
	background_icon = 'icons/hud/guardian.dmi'
	background_icon_state = "base"
	check_flags = NONE
	click_to_activate = FALSE
	cooldown_time = 0 SECONDS
	melee_cooldown_time = 0
	shared_cooldown = NONE

/datum/action/cooldown/mob_cooldown/recall_guardian/Activate(atom/target)
	var/mob/living/living_owner = owner
	var/list/guardians = living_owner.get_all_linked_holoparasites()
	for(var/mob/living/basic/guardian/guardian in guardians)
		guardian.recall()
	StartCooldown()
	return TRUE

/// Replace an annoying griefer you were paired up to with a different but probably no less annoying player.
/datum/action/cooldown/mob_cooldown/replace_guardian
	name = "Reset Guardian Consciousness"
	desc = "Substitui a mente de seu guardião pela de um fantasma diferente."
	button_icon = 'icons/mob/simple/mob.dmi'
	button_icon_state = "ghost"
	background_icon = 'icons/hud/guardian.dmi'
	background_icon_state = "base"
	check_flags = NONE
	click_to_activate = FALSE
	cooldown_time = 5 SECONDS
	melee_cooldown_time = 0
	shared_cooldown = NONE

/datum/action/cooldown/mob_cooldown/replace_guardian/Activate(atom/target)
	StartCooldown(5 MINUTES)

	var/mob/living/living_owner = owner
	var/list/guardians = living_owner.get_all_linked_holoparasites()
	for(var/mob/living/basic/guardian/resetting_guardian as anything in guardians)
		if (!COOLDOWN_FINISHED(resetting_guardian, resetting_cooldown))
			guardians -= resetting_guardian //clear out guardians that are already reset

	if (!length(guardians))
		to_chat(owner, span_holoparasite("Você não pode reiniciar.[length(guardians) > 1 ? "any of your guardians":"your guardian"]Ainda."))
		StartCooldown()
		return FALSE

	var/mob/living/basic/guardian/chosen_guardian = tgui_input_list(owner, "Pick the guardian you wish to reset", "Guardian Reset", sort_names(guardians))
	if (isnull(chosen_guardian))
		to_chat(owner, span_holoparasite("Você decide não reiniciar.[length(guardians) > 1 ? "any of your guardians":"your guardian"]."))
		StartCooldown()
		return FALSE

	to_chat(owner, span_holoparasite("Você tenta reiniciar.<font color=\"[chosen_guardian.guardian_colour]\">[span_bold(chosen_guardian.real_name)]</font>Uma personalidade..."))
	var/mob/chosen_one = SSpolling.poll_ghost_candidates("Você quer jogar como[span_danger("[owner.real_name]'s")] [span_notice(chosen_guardian.theme.name)]?", check_jobban = ROLE_PAI, poll_time = 10 SECONDS, alert_pic = chosen_guardian, jump_target = owner, role_name_text = chosen_guardian.theme.name, amount_to_pick = 1)
	if(isnull(chosen_one))
		to_chat(owner, span_holoparasite("Sua tentativa de redefinir a personalidade de<font color=\"[chosen_guardian.guardian_colour]\">[span_bold(chosen_guardian.real_name)]</font>Parece ter falhado... Parece que você está preso com isso por enquanto."))
		StartCooldown()
		return FALSE
	to_chat(chosen_guardian, span_holoparasite("Seu usuário redefiniu você, e seu corpo foi tomado por um fantasma. Parece que eles não estavam felizes com sua performance."))
	to_chat(owner, span_boldholoparasite("A personalidade de<font color=\"[chosen_guardian.guardian_colour]\">[chosen_guardian.theme.name]</font>foi reiniciado com sucesso."))
	message_admins("[key_name_admin(chosen_one)] has taken control of ([ADMIN_LOOKUPFLW(chosen_guardian)])")
	chosen_guardian.ghostize(FALSE)
	chosen_guardian.PossessByPlayer(chosen_one.key)
	COOLDOWN_START(chosen_guardian, resetting_cooldown, 5 MINUTES)
	chosen_guardian.guardian_rename() //give it a new color and name, to show it's a new person
	chosen_guardian.guardian_recolour()
	StartCooldown()
	return TRUE
