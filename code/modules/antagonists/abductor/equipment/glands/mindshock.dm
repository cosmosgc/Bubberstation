/obj/item/organ/heart/gland/mindshock
	abductor_hint = "neural crosstalk uninhibitor. The abductee emits a disrupting psychic wave every so often. This will either stun, cause hallucinations or deal random brain damage to people nearby."
	cooldown_low = 40 SECONDS
	cooldown_high = 70 SECONDS
	uses = -1
	icon_state = "mindshock"
	mind_control_uses = 2
	mind_control_duration = 120 SECONDS
	var/list/mob/living/carbon/human/broadcasted_mobs = list()

/obj/item/organ/heart/gland/mindshock/activate()
	to_chat(owner, span_notice("Você fica com dor de cabeça."))

	var/turf/owner_turf = get_turf(owner)
	for(var/mob/living/carbon/target in orange(4,owner_turf))
		if(target == owner)
			continue
		if(HAS_MIND_TRAIT(target, TRAIT_MINDSHIELD))
			to_chat(target, span_notice("Você ouve um zumbido fraco encher seus ouvidos, que rapidamente morre."))
			continue

		switch(pick(1,3))
			if(1)
				to_chat(target, span_userdanger("Você ouve um zumbido alto em sua cabeça, silenciando seus pensamentos!"))
				target.Stun(50)
			if(2)
				to_chat(target, span_warning("Você ouve um zumbido irritante na sua cabeça."))
				target.adjust_confusion(15 SECONDS)
				target.adjust_organ_loss(ORGAN_SLOT_BRAIN, 10, 160)
			if(3)
				target.adjust_hallucinations(150 SECONDS)

/obj/item/organ/heart/gland/mindshock/mind_control(command, mob/living/user)
	if(!ownerCheck() || !mind_control_uses || active_mind_control)
		return FALSE
	mind_control_uses--
	for(var/mob/target_mob in oview(7, owner))
		if(!ishuman(target_mob))
			continue
		var/mob/living/carbon/human/target_human = target_mob
		if(target_human.stat)
			continue

		if(HAS_MIND_TRAIT(target_human, TRAIT_UNCONVERTABLE))
			to_chat(target_human, span_notice("Você ouve um drone baixo como algo estrangeiro tenta entrar em sua mente, mas o barulho desaparece após alguns momentos."))
			continue

		broadcasted_mobs += target_human
		to_chat(target_human, span_userdanger("Você de repente sente uma compulsão irresistível para seguir uma ordem..."))
		to_chat(target_human, span_mind_control("[command]"))

		message_admins("[key_name(user)] broadcasted an abductor mind control message from [key_name(owner)] to [key_name(target_human)]: [command]")
		user.log_message("broadcasted an abductor mind control message from [key_name(owner)] to [key_name(target_human)]: [command]", LOG_GAME)

		var/atom/movable/screen/alert/mind_control/mind_alert = target_human.throw_alert(ALERT_MIND_CONTROL, /atom/movable/screen/alert/mind_control)
		mind_alert.command = command

	if(LAZYLEN(broadcasted_mobs))
		active_mind_control = TRUE
		addtimer(CALLBACK(src, PROC_REF(clear_mind_control)), mind_control_duration)

	update_gland_hud()
	return TRUE

/obj/item/organ/heart/gland/mindshock/clear_mind_control()
	if(!active_mind_control || !LAZYLEN(broadcasted_mobs))
		return FALSE
	for(var/target_mob in broadcasted_mobs)
		var/mob/living/carbon/human/target_human = target_mob
		to_chat(target_human, span_userdanger("Você sente a compulsão desaparecer, e você<i>Esquecer completamente</i>sobre suas ordens anteriores."))
		target_human.clear_alert(ALERT_MIND_CONTROL)
	active_mind_control = FALSE
	return TRUE
