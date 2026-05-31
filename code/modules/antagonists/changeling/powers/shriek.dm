/datum/action/changeling/resonant_shriek
	name = "Resonant Shriek"
	desc = "Nossos pulmões e cordas vocais mudam, permitindo-nos emitir um ruído que ensurdece e confunde não-mudantes, fazendo com que percam algum controle sobre seus movimentos. Melhor usado para impedir a presa de escapar. Não funciona bem no vácuo. Custa 20 produtos químicos."
	helptext = "Emits a high-frequency sound that confuses and deafens humans to hamper their movement, blows out nearby lights and overloads cyborg sensors."
	button_icon_state = "resonant_shriek"
	category = "combat"
	chemical_cost = 20
	dna_cost = 1
	req_human = TRUE
	disabled_by_fire = FALSE

//A flashy ability, good for crowd control and sowing chaos.
/datum/action/changeling/resonant_shriek/sting_action(mob/user)
	..()
	if(user.movement_type & VENTCRAWLING)
		user.balloon_alert(user, "Não posso gritar em canos!")
		return FALSE
	playsound(user, 'sound/effects/screech.ogg', 100)
	for(var/mob/living/living in get_hearers_in_view(4, user))
		if(IS_CHANGELING(living) || !living.soundbang_act(SOUNDBANG_MASSIVE, stun_pwr = 0, damage_pwr = 0, deafen_pwr = 1 MINUTES, ignore_deafness = TRUE, send_sound = FALSE))
			continue
		if(issilicon(living))
			living.Paralyze(rand(10 SECONDS, 20 SECONDS))
			continue
		living.adjust_confusion(25 SECONDS)
		living.set_jitter_if_lower(100 SECONDS)

	for(var/obj/machinery/light/light in range(4, user))
		light.on = TRUE
		light.break_light_tube()
		stoplag()
	return TRUE

/datum/action/changeling/dissonant_shriek
	name = "Technophagic Shriek"
	desc = "Mudamos nossas cordas vocais para liberar um som de alta frequência que sobrecarrega os eletrônicos próximos. Quebra fones de ouvido e câmeras, e às vezes pode quebrar armas a laser, portas e modsuits. Custa 20 produtos químicos."
	button_icon_state = "technophagic_shriek"
	category = "combat"
	chemical_cost = 20
	dna_cost = 1
	disabled_by_fire = FALSE
	COOLDOWN_DECLARE(dissonant_shriek_cooldown) //BUBBER EDIT: DECLARES A COOLDOWN

/datum/action/changeling/dissonant_shriek/sting_action(mob/user)
	..()
	if(user.movement_type & VENTCRAWLING)
		user.balloon_alert(user, "Não posso gritar em canos!")
		return FALSE
	//BUBBER EDIT: NO PULSE IF YOU'RE ON COOLDOWN
	if(!COOLDOWN_FINISHED(src, dissonant_shriek_cooldown))
		user.balloon_alert(user, "A garganta está doendo!")
		return FALSE
	//BUBBER EDIT: NO PULSE IF YOU'RE ON COOLDOWN
	empulse(get_turf(user), 2, 5, 1, emp_source = src)
	for(var/obj/machinery/light/L in range(5, usr))
		L.on = TRUE
		L.break_light_tube()
		stoplag()
		COOLDOWN_START(src, dissonant_shriek_cooldown, 10 SECONDS) //BUBBER EDIT: ADDS A COOLDOWN TO DISSONANT SHRIEK

	return TRUE
