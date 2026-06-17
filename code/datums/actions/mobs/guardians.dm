/datum/action/cooldown/guardian
	button_icon = 'icons/hud/guardian.dmi'

/datum/action/cooldown/guardian/IsAvailable(feedback)
	. = ..()
	if(!.)
		return .
	return !!isguardian(owner)

/datum/action/cooldown/guardian/check_type
	name = "Check Type"
	desc = "Um lembrete sobre suas habilidades."
	//this is based off of the antag ui icon, if that changes then change this too please.
	button_icon_state = /datum/action/antag_info::button_icon_state
	default_button_position = SCRN_OBJ_INSERT_FIRST

/datum/action/cooldown/guardian/check_type/Activate(atom/target)
	. = ..()
	to_chat(owner, astype(owner, /mob/living/basic/guardian)?.playstyle_string)

/datum/action/cooldown/guardian/communicate
	name = "Communicate"
	desc = "Comunique-se telepaticamente com seu usuário."
	button_icon_state = "communicate"
	default_button_position = ui_guardian_communication

/datum/action/cooldown/guardian/communicate/Activate()
	astype(owner, /mob/living/basic/guardian)?.communicate()

/datum/action/cooldown/guardian/manifest
	name = "Manifest"
	desc = "Ir para a batalha!"
	button_icon_state = "manifest"
	default_button_position = ui_guardian_manifest

/datum/action/cooldown/guardian/manifest/Activate()
	astype(owner, /mob/living/basic/guardian)?.manifest()

/datum/action/cooldown/guardian/recall
	name = "Recall"
	desc = "Volte para seu usuário."
	button_icon_state = "recall"
	default_button_position = ui_guardian_recall

/datum/action/cooldown/guardian/recall/Activate()
	astype(owner, /mob/living/basic/guardian)?.recall()

/datum/action/cooldown/guardian/toggle_light
	name = "Toggle Light"
	desc = "Brilha como pó de estrela."
	button_icon_state = "light"

/datum/action/cooldown/guardian/toggle_light/Activate()
	astype(owner, /mob/living/basic/guardian)?.toggle_light()

/datum/action/cooldown/guardian/toggle_mode
	name = "Toggle Mode"
	desc = "Troque entre modos de habilidade."
	button_icon_state = "toggle"
	default_button_position = ui_guardian_special

/datum/action/cooldown/guardian/toggle_mode/Activate()
	astype(owner, /mob/living/basic/guardian)?.toggle_modes()

/datum/action/cooldown/guardian/toggle_mode/assassin
	name = "Toggle Stealth"
	desc = "Entre ou saia furtivamente."
	button_icon_state = "stealth"
	transparent_when_unavailable = TRUE

/datum/action/cooldown/guardian/toggle_mode/assassin/is_action_active(atom/movable/screen/movable/action_button/current_button)
	return owner.has_status_effect(/datum/status_effect/guardian_stealth)

/datum/action/cooldown/guardian/toggle_mode/gases
	name = "Toggle Gas"
	desc = "Troque entre possíveis gases."
	button_icon_state = "gases"
