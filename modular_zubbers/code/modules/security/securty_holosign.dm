
/obj/item/holosign_creator/security
	desc = "Um projetor holográfico que cria barreiras de segurança holográficas e restrições. Você pode abrir barreiras remotamente com ele.\
Restrições são aplicadas com o próprio criador, mas as projeções podem desestabilizar quando expostas ao PEM, ou quando o prisioneiro sai, tem alcance de 9 metros."

/obj/item/holosign_creator/security/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!iscarbon(interacting_with))
		return ..()
	var/mob/living/carbon/human = interacting_with
	if(human.handcuffed) // is our target already handcuffed?
		user.balloon_alert(user, "Já algemado.")
		return ITEM_INTERACT_BLOCKING
	if(!human.canBeHandcuffed()) // does he actually have arms?
		user.balloon_alert(user, "Precisa de duas mãos.")
		return ITEM_INTERACT_BLOCKING
	if(DOING_INTERACTION_WITH_TARGET(user, human))
		return ITEM_INTERACT_BLOCKING
	log_combat(user, human, "attempted to handcuff")
	playsound(src, 'sound/items/weapons/cablecuff.ogg', 30, TRUE, -2)
	human.visible_message(span_danger("[user] begins restraining [human] with [src]!"), \
	span_userdanger("[user] begins shaping a holographic field around your hands!"))
	if(!do_after(user, 4.5 SECONDS, human, extra_checks = CALLBACK(src, PROC_REF(can_handcuff), user))) // he is up for grabs, so lets handcuff them
		return ITEM_INTERACT_BLOCKING
	human.set_handcuffed(new /obj/item/restraints/handcuffs/holographic/used(human))
	human.update_handcuffed()
	for(var/obj/item/restraints/handcuffs/holographic/used/ourcuffs in human.contents)
		ourcuffs.our_projector = src
		ourcuffs.our_guy = human
		human.apply_status_effect(/datum/status_effect/holocuff_distance)
	to_chat(user, span_notice("You restrain [human]."))
	log_combat(user, human, "handcuffed")
	return ITEM_INTERACT_SUCCESS

/obj/item/holosign_creator/security/proc/can_handcuff(mob/living/carbon/victim)
	if(QDELETED(victim))
		return FALSE
	if(victim.handcuffed || victim.num_hands < 2)
		return FALSE
	return TRUE

/*
 * Handcuffs used for the security holobarrier projector
 * the handcuffs themselfes should be un-obtainable, /used version is applied on our actual target
 * as strong zipties, take 50% longer to handcuff someone with
 */

/obj/item/restraints/handcuffs/holographic
	name = "holographic energy field"
	desc = "Como conseguiu isso? Este item lhe dá permissão para gritar com programadores."
	icon = 'modular_zubbers/icons/obj/holocuffs.dmi'
	icon_state = "holocuffs"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	breakouttime = 45 SECONDS
	flags_1 = NONE
	var/our_projector
	var/our_guy


/obj/item/restraints/handcuffs/holographic/used
	desc = "Uma projeção holográfica de algemas, surpreendentemente difícil de escapar"
	item_flags = DROPDEL

/obj/item/restraints/handcuffs/holographic/proc/check_distance()
	SIGNAL_HANDLER

	if(!our_projector)
		return
	if(!our_guy)
		return
	var/dist = get_dist(get_turf(our_guy), get_turf(our_projector))
	if(dist > 5)
		on_uncuffed()

/obj/item/restraints/handcuffs/holographic/on_uncuffed(datum/source, mob/living/wearer)
	. = ..()
	wearer.visible_message(span_danger("[wearer]'s [name] breaks in a discharge of energy!"), span_userdanger("[wearer]'s [name] breaks in a discharge of energy!"))
	do_sparks(2, TRUE, src)
	wearer.remove_status_effect(/datum/status_effect/holocuff_distance)
	qdel(src)

/obj/item/restraints/handcuffs/holographic/emp_act(severity)
	. = ..()
	if(severity <= EMP_HEAVY)
		if(prob(50))
			do_sparks(2, TRUE, our_guy)
			qdel(src)


/datum/status_effect/holocuff_distance
	id = "holocuffEffect"
	status_type = STATUS_EFFECT_UNIQUE
	tick_interval = STATUS_EFFECT_AUTO_TICK
	alert_type = /atom/movable/screen/alert/status_effect/holocuff_distance

/atom/movable/screen/alert/status_effect/holocuff_distance
	name = "Holocuff Range"
	desc = "Se eu pudesse sair do alcance do projetor, perderia o controle!"
	icon = 'modular_zubbers/icons/obj/holocuffs.dmi'
	icon_state = "holocuffs"


/datum/status_effect/holocuff_distance/tick(seconds_between_ticks)
	. = ..()
	for(var/obj/item/restraints/handcuffs/holographic/used/ourcuffs in owner.contents)
		var/dist = get_dist(get_turf(ourcuffs.our_guy), get_turf(ourcuffs.our_projector))
		if(dist > 9)
			do_sparks(2, TRUE, owner)
			owner.dropItemToGround(ourcuffs, TRUE)
			owner.visible_message(span_danger("[owner]'s holographic energy field breaks in a discharge of energy!"), span_userdanger("[owner]'s holographic energy field breaks in a discharge of energy!"))
			Destroy()

