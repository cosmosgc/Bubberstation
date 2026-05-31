/datum/action/cooldown/spell/pointed/projectile/finger_guns
	name = "Finger Guns"
	desc = "Atire em três balas mímicas de seus dedos que danificam e silenciam seus alvos. Não pode ser usado se tiver algo em suas mãos."
	background_icon_state = "bg_mime"
	overlay_icon_state = "bg_mime_border"
	button_icon = 'icons/mob/actions/actions_mime.dmi'
	button_icon_state = "finger_guns"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_HANDS_BLOCKED|AB_CHECK_INCAPACITATED
	sound = null

	school = SCHOOL_MIME
	cooldown_time = 30 SECONDS

	invocation = span_notice("<b>%CASTER</b> fires %PRONOUN_their finger gun!")
	invocation_self_message = span_danger("Dispare sua arma!")
	invocation_type = INVOCATION_EMOTE

	spell_requirements = SPELL_REQUIRES_HUMAN|SPELL_REQUIRES_MIME_VOW
	antimagic_flags = NONE
	spell_max_level = 1

	active_msg = "You draw your fingers!"
	deactive_msg = "You put your fingers at ease. Another time."
	cast_range = 20
	projectile_type = /obj/projectile/bullet/mime
	projectile_amount = 3

/datum/action/cooldown/spell/pointed/projectile/finger_guns/try_invoke(mob/living/invoker, feedback = TRUE)
	if(invocation_type == INVOCATION_EMOTE)
		if(!ishuman(invoker))
			return FALSE

		var/mob/living/carbon/human/human_invoker = invoker
		if(human_invoker.incapacitated)
			if(feedback)
				to_chat(human_invoker, span_warning("Não pode apontar os dedos enquanto está incapacitado."))
			return FALSE
		if(human_invoker.get_active_held_item())
			if(feedback)
				to_chat(human_invoker, span_warning("Você não pode disparar suas armas com algo na mão."))
			return FALSE

	return ..()
