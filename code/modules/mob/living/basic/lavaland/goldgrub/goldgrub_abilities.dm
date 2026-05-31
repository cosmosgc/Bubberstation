/datum/action/cooldown/mob_cooldown/spit_ore
	name = "Spit Ore"
	desc = "Vomite todos os seus minérios consumidos."
	click_to_activate = FALSE
	cooldown_time = 5 SECONDS

/datum/action/cooldown/mob_cooldown/spit_ore/IsAvailable(feedback)
	if(is_jaunting(owner))
		if(feedback)
			owner.balloon_alert(owner, "No momento subterrâneo!")
		return FALSE

	if(!length(owner.contents))
		if(feedback)
			owner.balloon_alert(owner, "Sem minérios para cuspir!")
		return FALSE
	return TRUE

/datum/action/cooldown/mob_cooldown/spit_ore/Activate()
	var/mob/living/basic/mining/goldgrub/grub_owner = owner
	grub_owner.barf_contents()
	StartCooldown()
	return TRUE

/datum/action/cooldown/mob_cooldown/burrow
	name = "Burrow"
	desc = "Burrow sob solo macio, evitando predadores e aumentando sua velocidade."
	cooldown_time = 7 SECONDS
	click_to_activate = FALSE

/datum/action/cooldown/mob_cooldown/burrow/IsAvailable(feedback)
	. = ..()
	if (!.)
		return FALSE
	var/turf/location = get_turf(owner)

	if(!isasteroidturf(location) && !ismineralturf(location))
		if(feedback)
			owner.balloon_alert(owner, "disponível apenas no chão ou parede de mineração!")
		return FALSE

	return TRUE

/datum/action/cooldown/mob_cooldown/burrow/Activate()
	var/obj/effect/dummy/phased_mob/grub_burrow/holder = null
	var/turf/current_loc = get_turf(owner)

	if(!do_after(owner, 3 SECONDS, target = current_loc))
		owner.balloon_alert(owner, "Preciso ficar parado!")
		return

	if(get_turf(owner) != current_loc)
		to_chat(owner, span_warning("Ação cancelada, como você se moveu enquanto reapareceva."))
		return

	if(!is_jaunting(owner))
		owner.visible_message(span_danger("[owner]Enterra no chão, desaparecendo da vista!"))
		playsound(get_turf(owner), 'sound/effects/break_stone.ogg', 50, TRUE, -1)
		holder = new /obj/effect/dummy/phased_mob/grub_burrow(current_loc, owner)
		return TRUE

	holder = owner.loc
	holder.eject_jaunter()
	holder = null
	owner.visible_message(span_danger("[owner]Sai do chão!"))

	if(ismineralturf(current_loc))
		var/turf/closed/mineral/mineral_turf = current_loc
		mineral_turf.gets_drilled(owner)

	playsound(current_loc, 'sound/effects/break_stone.ogg', 50, TRUE, -1)
	StartCooldown()
	return TRUE

/obj/effect/dummy/phased_mob/grub_burrow

/obj/effect/dummy/phased_mob/grub_burrow/phased_check(mob/living/user, direction)
	. = ..()

	if(!.)
		return

	if(!ismineralturf(.) && !isasteroidturf(.))
		to_chat(user, span_warning("Você não pode cavar através deste chão!"))
		return null
