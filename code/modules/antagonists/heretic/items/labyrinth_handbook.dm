/obj/effect/forcefield/wizard/heretic
	name = "labyrinth pages"
	desc = "Um campo de papéis voando no ar, repelindo pagãos com força impossível."
	icon_state = "lintel"
	initial_duration = 15 SECONDS

/obj/effect/forcefield/wizard/heretic/CanAllowThrough(atom/movable/mover, border_dir)
	if(istype(mover.throwing?.get_thrower(), /obj/effect/forcefield/wizard/heretic))
		return TRUE
	return ..()

/obj/effect/forcefield/wizard/heretic/Bumped(mob/living/bumpee)
	. = ..()
	if(!istype(bumpee) || IS_HERETIC_OR_MONSTER(bumpee))
		return
	var/throwtarget = get_edge_target_turf(loc, get_dir(loc, get_step_away(bumpee, loc)))
	bumpee.safe_throw_at(throwtarget, 10, 10, src, force = MOVE_FORCE_EXTREMELY_STRONG)
	visible_message(span_danger("[src]repulsa[bumpee]Em uma tempestade de papel!"))

///A heretic item that spawns a barrier at the clicked turf, 3 uses
/obj/item/heretic_labyrinth_handbook
	name = "labyrinth handbook"
	desc = "Um livro contendo as leis e regulamentos do Labirinto Fechado, escrito sobre uma substância desconhecida. Suas páginas se contorcem e se contorcem, procurando atacar e escapar."
	icon = 'icons/obj/service/library.dmi'
	icon_state = "heretichandbook"
	force = 10
	damtype = BURN
	worn_icon_state = "book"
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("bashes", "curses")
	attack_verb_simple = list("bash", "curse")
	resistance_flags = FLAMMABLE
	drop_sound = 'sound/items/handling/book_drop.ogg'
	pickup_sound = 'sound/items/handling/book_pickup.ogg'
	///what type of barrier do we spawn when used
	var/barrier_type = /obj/effect/forcefield/wizard/heretic
	/// Current charges remaining
	var/charges = 5
	/// Max possible amount of charges
	var/max_charges = 5
	/// List that contains each timer for the charge
	var/list/charge_timers = list()
	/// How long before a charge is restored
	var/charge_time = 15 SECONDS

/obj/item/heretic_labyrinth_handbook/examine(mob/user)
	. = ..()
	if(!IS_HERETIC_OR_MONSTER(user))
		return
	. += span_hypnophrase("Materializa uma barreira sobre qualquer azulejo à vista, que só você pode passar. Dura 8 segundos.")
	. += span_notice("Tem.<b>[charges]</b>carga restante.")

/obj/item/heretic_labyrinth_handbook/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(HAS_TRAIT(interacting_with, TRAIT_COMBAT_MODE_SKIP_INTERACTION))
		return NONE
	return ranged_interact_with_atom(interacting_with, user, modifiers)

/obj/item/heretic_labyrinth_handbook/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!IS_HERETIC(user))
		if(ishuman(user))
			var/mob/living/carbon/human/human_user = user
			to_chat(human_user, span_userdanger("Sua mente queima enquanto você olha para o livro, uma dor de cabeça se pondo como se seu cérebro estivesse em chamas!"))
			human_user.adjust_organ_loss(ORGAN_SLOT_BRAIN, 30, 190)
			human_user.add_mood_event("gates_of_mansus", /datum/mood_event/gates_of_mansus)
			human_user.dropItemToGround(src)
		return ITEM_INTERACT_BLOCKING

	if(charges <= 0)
		balloon_alert(user, "Sem cargas!")
		return ITEM_INTERACT_BLOCKING

	var/turf/turf_target = get_turf(interacting_with)
	if(locate(barrier_type) in turf_target)
		user.balloon_alert(user, "Já ocupado!")
		return ITEM_INTERACT_BLOCKING
	turf_target.visible_message(span_warning("Uma tempestade de papel se materializa!"))
	new /obj/effect/temp_visual/paper_scatter(turf_target)
	playsound(turf_target, 'sound/effects/magic/smoke.ogg', 30)
	new barrier_type(turf_target, user)
	charges--
	charge_timers.Add(addtimer(CALLBACK(src, PROC_REF(recharge)), charge_time, TIMER_STOPPABLE))
	return ITEM_INTERACT_SUCCESS

/obj/item/heretic_labyrinth_handbook/proc/recharge()
	charges = min(charges+1, max_charges)
