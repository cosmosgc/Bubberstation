/// Left behind when a legion infects you, for medical enrichment
/obj/item/organ/legion_tumour
	name = "legion tumour"
	desc = "Uma massa de carne pulsante e tentáculos escuros, contendo o poder de regenerar a carne a um custo terrível."
	failing_desc = "pulsos e contorce com vida horrível, alcançando você com seus tentáculos!"
	icon = 'icons/obj/medical/organs/mining_organs.dmi'
	icon_state = "legion_remains"
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_PARASITE_EGG
	organ_flags = parent_type::organ_flags | ORGAN_HAZARDOUS
	decay_factor = STANDARD_ORGAN_DECAY * 3 // About 5 minutes outside of a host
	/// What stage of growth the corruption has reached.
	var/stage = 0
	/// We apply this status effect periodically or when used on someone
	var/applied_status = /datum/status_effect/regenerative_core
	/// How long have we been in this stage?
	var/elapsed_time = 0 SECONDS
	/// How long does it take to advance one stage?
	var/growth_time = 80 SECONDS // Long enough that if you go back to lavaland without realising it you're not totally fucked
	/// What kind of mob will we transform into?
	var/spawn_type = /mob/living/basic/mining/legion
	/// Spooky sounds to play as you start to turn
	var/static/list/spooky_sounds = list(
		'sound/mobs/non-humanoids/hiss/lowHiss1.ogg',
		'sound/mobs/non-humanoids/hiss/lowHiss2.ogg',
		'sound/mobs/non-humanoids/hiss/lowHiss3.ogg',
		'sound/mobs/non-humanoids/hiss/lowHiss4.ogg',
	)

/obj/item/organ/legion_tumour/Initialize(mapload)
	. = ..()
	animate_pulse()

/obj/item/organ/legion_tumour/on_begin_failure()
	animate_pulse()

/obj/item/organ/legion_tumour/on_failure_recovery()
	animate_pulse()

/// Do a heartbeat animation depending on if we're failing or not
/obj/item/organ/legion_tumour/proc/animate_pulse()
	animate(src, transform = matrix()) // Stop any current animation

	var/speed_divider = organ_flags & ORGAN_FAILING ? 2 : 1

	animate(src, transform = matrix().Scale(1.1), time = 0.5 SECONDS / speed_divider, easing = SINE_EASING | EASE_OUT, loop = -1, flags = ANIMATION_PARALLEL)
	animate(transform = matrix(), time = 0.5 SECONDS / speed_divider, easing = SINE_EASING | EASE_IN)
	animate(transform = matrix(), time = 2 SECONDS / speed_divider)

/obj/item/organ/legion_tumour/Remove(mob/living/carbon/egg_owner, special, movement_flags)
	. = ..()
	stage = 0
	elapsed_time = 0

/obj/item/organ/legion_tumour/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	owner.log_message("has received [src] which will eventually turn them into a Legion.", LOG_VICTIM)

/obj/item/organ/legion_tumour/attack(mob/living/target, mob/living/user, list/modifiers, list/attack_modifiers)
	if (try_apply(target, user))
		qdel(src)
		return
	return ..()

/// Smear it on someone like a regen core, why not. Make sure they're alive though.
/obj/item/organ/legion_tumour/proc/try_apply(mob/living/target, mob/user)
	if(!user.Adjacent(target) || !isliving(target))
		return FALSE

	if (target.stat <= SOFT_CRIT && !(organ_flags & ORGAN_FAILING))
		target.add_mood_event("legion_core", /datum/mood_event/healsbadman)
		target.apply_status_effect(applied_status)

		if (target != user)
			target.visible_message(span_notice("[user] Splatters.[target] Com [src] Os tentáculos nojentos puxam.[target.p_their()] Feridas fechadas!"))
		else
			to_chat(user, span_notice("Você mancha [src] Você mesmo. Tendões nojentos fecham suas feridas."))
		return TRUE

	if (!ishuman(target))
		return FALSE

	log_combat(user, target, "used a Legion Tumour on", src, "as they are in crit, this will turn them into a Legion.")
	target.visible_message(span_boldwarning("[user] Splatters.[target] Com [src]... e ela brota em uma vida horrível!"))
	var/mob/living/basic/mining/legion_brood/skull = new(target.loc)
	skull.melee_attack(target)
	return TRUE

/obj/item/organ/legion_tumour/on_life(seconds_per_tick)
	. = ..()
	if (QDELETED(src) || QDELETED(owner))
		return

	if (stage >= 2)
		if(SPT_PROB(stage / 5, seconds_per_tick))
			to_chat(owner, span_notice("Você se sente um pouco melhor."))
			owner.apply_status_effect(applied_status) // It's not all bad!
		if(SPT_PROB(1, seconds_per_tick))
			owner.emote("twitch")

	switch(stage)
		if(2, 3)
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(owner, span_danger("Seus espasmos não peito!"))
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(owner, span_danger("Você se sente fraco."))
			if(SPT_PROB(1, seconds_per_tick))
				SEND_SOUND(owner, sound(pick(spooky_sounds)))
			if(SPT_PROB(2, seconds_per_tick))
				owner.vomit()
		if(4, 5)
			if(SPT_PROB(2, seconds_per_tick))
				to_chat(owner, span_danger("Algo flexiona soluça sua pele."))
			if(SPT_PROB(2, seconds_per_tick))
				if (prob(40))
					SEND_SOUND(owner, sound('sound/music/antag/bloodcult/ghost_whisper.ogg'))
				else
					SEND_SOUND(owner, sound(pick(spooky_sounds)))
			if(SPT_PROB(3, seconds_per_tick))
				owner.vomit(vomit_type = /obj/effect/decal/cleanable/vomit/old/black_bile)
				if (prob(50))
					var/turf/check_turf = get_step(owner.loc, owner.dir)
					var/atom/land_turf = (check_turf.is_blocked_turf()) ? owner.loc : check_turf
					var/mob/living/basic/mining/legion_brood/child = new(land_turf)
					child.assign_creator(owner, copy_full_faction = FALSE)

			if(SPT_PROB(3, seconds_per_tick))
				to_chat(owner, span_danger("Seus músculos doem."))
				owner.take_bodypart_damage(3)

	if (stage == 5)
		if (SPT_PROB(10, seconds_per_tick))
			infest()
		return

	elapsed_time += seconds_per_tick SECONDS * ((organ_flags & ORGAN_FAILING) ? 3 : 1) // Let's call it "matured" rather than failed
	if (elapsed_time < growth_time)
		return
	stage++
	elapsed_time = 0
	if (stage == 5)
		to_chat(owner, span_bolddanger("Algo está se movendo sob sua pele!"))

/// Consume our host
/obj/item/organ/legion_tumour/proc/infest()
	if (QDELETED(src) || QDELETED(owner))
		return
	owner.log_message("has been turned into a Legion by their tumour.", LOG_VICTIM)
	owner.visible_message(span_boldwarning("Os tentáculos negros explodem de [owner] É carne, cobrindo-os em carne amorfa!"))
	var/mob/living/basic/mining/legion/new_legion = new spawn_type(owner.loc)
	new_legion.consume(owner)
	qdel(src)

/obj/item/organ/legion_tumour/on_find(mob/living/finder)
	. = ..()
	to_chat(finder, span_warning("Há um tumor enorme em [owner]'s [zone]!"))
	if(stage < 4)
		to_chat(finder, span_notice("Seus tentáculos parecem se contorcer em direção à luz."))
		return
	to_chat(finder, span_notice("Seus tentáculos pulsantes atingem todo o corpo."))
	if(prob(stage * 2))
		infest()

/obj/item/organ/legion_tumour/feel_for_damage(self_aware)
	// keep stealthy for now, revisit later
	return ""
