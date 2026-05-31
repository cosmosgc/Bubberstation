/datum/action/cooldown/spell/caretaker
	name = "Caretaker’s Last Refuge"
	desc = "Muda você para o Refúgio do Zelador, tornando você translúcido e intangível. Enquanto no Refúgio seu movimento é irrestrito, mas você não pode usar suas mãos ou lançar feitiços. Você não pode entrar no Refúgio enquanto estiver perto de outros seres sencientes, e você pode ser removido dele em contato com artefatos antimágicos."
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	button_icon = 'icons/mob/actions/actions_ecult.dmi'
	button_icon_state = "caretaker"
	sound = 'sound/effects/curse/curse2.ogg'

	school = SCHOOL_FORBIDDEN
	cooldown_time = 1 MINUTES

	invocation_type = INVOCATION_NONE
	spell_requirements = NONE

/datum/action/cooldown/spell/caretaker/Remove(mob/living/remove_from)
	if(remove_from.has_status_effect(/datum/status_effect/caretaker_refuge))
		remove_from.remove_status_effect(/datum/status_effect/caretaker_refuge)
	return ..()

/datum/action/cooldown/spell/caretaker/is_valid_target(atom/cast_on)
	return isliving(cast_on)

/datum/action/cooldown/spell/caretaker/before_cast(mob/living/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return

	for(var/mob/living/alive in orange(5, owner))
		if(alive.stat != DEAD && alive.client && (owner in view(alive)))
			owner.balloon_alert(owner, "Outras mentes próximas!")
			return . | SPELL_CANCEL_CAST

	if(!cast_on.has_status_effect(/datum/status_effect/caretaker_refuge))
		return SPELL_NO_IMMEDIATE_COOLDOWN // cooldown only on exit

/datum/action/cooldown/spell/caretaker/cast(mob/living/cast_on)
	. = ..()

	var/mob/living/carbon/carbon_user = owner
	if(carbon_user.has_status_effect(/datum/status_effect/caretaker_refuge))
		carbon_user.remove_status_effect(/datum/status_effect/caretaker_refuge)
	else
		carbon_user.apply_status_effect(/datum/status_effect/caretaker_refuge)
	return TRUE
