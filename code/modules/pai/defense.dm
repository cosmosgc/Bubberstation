
/mob/living/silicon/pai/blob_act(obj/structure/blob/B)
	return FALSE

/mob/living/silicon/pai/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	take_holo_damage(50 / severity)
	Stun(400 / severity)
	if(holoform)
		fold_in(force = TRUE)
	//Need more effects that aren't instadeath or permanent law corruption.
	//Ask and you shall receive
	switch(rand(1, 3))
		if(1)
			adjust_stutter(1 MINUTES / severity)
			to_chat(src, span_danger("Aviso: loop de feedback detectado no módulo de fala."))
		if(2)
			adjust_slurring(INFINITY)
			to_chat(src, span_danger("Aviso: CPU sintetizadora de áudio presa."))
		if(3)
			set_derpspeech(INFINITY)
			to_chat(src, span_danger("Aviso: banco de dados de vocabulário corrompido."))
	if(prob(40))
		set_active_language(get_random_spoken_language())

/mob/living/silicon/pai/ex_act(severity, target)
	take_holo_damage(50 * severity)
	switch(severity)
		if(EXPLODE_DEVASTATE) //RIP
			qdel(card)
			qdel(src)
		if(EXPLODE_HEAVY)
			fold_in(force = 1)
			Paralyze(400)
		if(EXPLODE_LIGHT)
			fold_in(force = 1)
			Paralyze(200)

	return TRUE

/mob/living/silicon/pai/attack_hand(mob/living/carbon/human/user, list/modifiers)
	if(!user.combat_mode)
		visible_message(span_notice("[user]Bata levemente[src]na cabeça, provocando um zumbido fora de seu campo holográfico."))
		return
	user.do_attack_animation(src)
	if(user.name != master_name)
		visible_message(span_danger("[user]Pimbas em[src]!."))
		take_holo_damage(2)
		return
	visible_message(span_notice("Respondendo ao toque de seu mestre,[src]Desliga seu emissor holocássis, perdendo rapidamente a coerência."))
	if(!do_after(user, 1 SECONDS, src))
		return
	fold_in()
	if(user.put_in_hands(card))
		user.visible_message(span_notice("[user]Recolhe rapidamente[user.p_their()]Cartão do P.A.I."))

/mob/living/silicon/pai/bullet_act(obj/projectile/hitting_projectile, def_zone, piercing_hit = FALSE)
	. = ..()
	if(. == BULLET_ACT_HIT && (hitting_projectile.stun || hitting_projectile.paralyze))
		fold_in(force = TRUE)
		visible_message(span_warning("O projétil carregado eletronicamente interrompe.[src]É holomatrix, forçando[p_them()]Dobrar!"))

/mob/living/silicon/pai/ignite_mob(silent)
	return FALSE

/mob/living/silicon/pai/proc/take_holo_damage(amount)
	holochassis_health = clamp((holochassis_health - amount), -50, HOLOCHASSIS_MAX_HEALTH)
	if(holochassis_health < 0)
		fold_in(force = TRUE)
	if(amount > 0)
		to_chat(src, span_userdanger("O impacto degrada seu holochassis!"))
	return amount

/// Called when we take burn or brute damage, pass it to the shell instead
/mob/living/silicon/pai/proc/on_shell_damaged(datum/hurt, type, amount, forced)
	SIGNAL_HANDLER
	take_holo_damage(amount)
	return COMPONENT_IGNORE_CHANGE

/// Called when we take stamina damage, pass it to the shell instead
/mob/living/silicon/pai/proc/on_shell_weakened(datum/hurt, type, amount, forced)
	SIGNAL_HANDLER
	take_holo_damage(amount * ((forced) ? 1 : 0.25))
	return COMPONENT_IGNORE_CHANGE

/mob/living/silicon/pai/get_brute_loss()
	return HOLOCHASSIS_MAX_HEALTH - holochassis_health

/mob/living/silicon/pai/get_fire_loss()
	return HOLOCHASSIS_MAX_HEALTH - holochassis_health
