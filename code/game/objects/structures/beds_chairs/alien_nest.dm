//Alium nests. Essentially beds with an unbuckle delay that only aliums can buckle mobs to.

/obj/structure/bed/nest
	name = "alien nest"
	desc = "É uma pilha horrível de resina grossa e pegajosa em forma de ninho."
	icon = 'icons/obj/smooth_structures/alien/nest.dmi'
	icon_state = "nest-0"
	base_icon_state = "nest"
	max_integrity = 120
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_ALIEN_NEST
	canSmoothWith = SMOOTH_GROUP_ALIEN_NEST
	build_stack_type = null
	elevation = 0
	can_deconstruct = FALSE
	var/static/mutable_appearance/nest_overlay = mutable_appearance('icons/mob/nonhuman-player/alien.dmi', "nestoverlay", LYING_MOB_LAYER)

/obj/structure/bed/nest/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_DANGEROUS_BUCKLE, INNATE_TRAIT)

/obj/structure/bed/nest/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	if(held_item?.tool_behaviour == TOOL_WRENCH)
		return NONE

	return ..()

/obj/structure/bed/nest/buckle_feedback(mob/living/being_buckled, mob/buckler)
	if(being_buckled == buckler)
		being_buckled.visible_message(
			span_notice("[buckler]Deite-se em[src], embrulhando[buckler.p_them()]Ego em uma resina grossa e pegajosa."),
			span_notice("Você se deita[src], embrulhando-se em uma resina grossa e pegajosa."),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)
	else
		being_buckled.visible_message(
			span_notice("[buckler]Deitados.[being_buckled]Para baixo.[src], embrulhando[being_buckled.p_them()]Em uma resina grossa e pegajosa."),
			span_notice("[buckler]Deita você em cima[src], embrulhando você em uma resina grossa e pegajosa."),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)

/obj/structure/bed/nest/unbuckle_feedback(mob/living/being_unbuckled, mob/unbuckler)
	if(being_unbuckled == unbuckler)
		being_unbuckled.visible_message(
			span_notice("[unbuckler]Puxa.[unbuckler.p_them()]Livre-se do ninho pegajoso!"),
			span_notice("Você se liberta do ninho pegajoso!"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)
	else
		being_unbuckled.visible_message(
			span_notice("[unbuckler]Puxa.[being_unbuckled]Livre do ninho pegajoso!"),
			span_notice("[unbuckler]Tira você do ninho pegajoso!"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)

/obj/structure/bed/nest/user_unbuckle_mob(mob/living/captive, mob/living/hero)
	if(!length(buckled_mobs))
		return

	if(hero.get_organ_by_type(/obj/item/organ/alien/plasmavessel))
		unbuckle_mob(captive)
		add_fingerprint(hero)
		return

	if(captive != hero)
		captive.visible_message(span_notice("[hero.name]Puxa.[captive.name]Livre do ninho pegajoso!"),
			span_notice("[hero.name]Tira você da resina gelatinosa."),
			span_hear("Você ouve o barulho..."))
		unbuckle_mob(captive)
		add_fingerprint(hero)
		return

	captive.visible_message(span_warning("[captive.name]Luta para se libertar da resina gelatinosa!"),
		span_notice("Você luta para se libertar da resina gelatinosa..."),
		span_hear("Você ouve o barulho..."))

	if(!do_after(captive, 100 SECONDS, target = src, hidden = TRUE))
		if(captive.buckled)
			to_chat(captive, span_warning("Você não consegue se soltar!"))
		return

	captive.visible_message(span_warning("[captive.name]Se liberta da resina gelatina!"),
		span_notice("Você se liberta da resina gelatinosa!"),
		span_hear("Você ouve o barulho..."))

	unbuckle_mob(captive)
	add_fingerprint(hero)

/obj/structure/bed/nest/user_buckle_mob(mob/living/M, mob/user, check_loc = TRUE)
	if ( !ismob(M) || (get_dist(src, user) > 1) || (M.loc != src.loc) || user.incapacitated || M.buckled )
		return

	if(M.get_organ_by_type(/obj/item/organ/alien/plasmavessel))
		return
	if(!user.get_organ_by_type(/obj/item/organ/alien/plasmavessel))
		return

	if(has_buckled_mobs())
		unbuckle_all_mobs()

	if(buckle_mob(M))
		M.visible_message(span_notice("[user.name]Segreda uma gosma vil grossa, protegendo[M.name]Em[src]!"),			span_danger("[user.name]Te ensopado em uma resina federal, te prendendo.[src]!"),			span_hear("Você ouve o barulho..."))

/obj/structure/bed/nest/post_buckle_mob(mob/living/M)
	ADD_TRAIT(M, TRAIT_HANDS_BLOCKED, type)
	M.add_offsets(type, x_add = 2)
	M.layer = BELOW_MOB_LAYER
	add_overlay(nest_overlay)

	if(ishuman(M))
		var/mob/living/carbon/human/victim = M
		if(((victim.wear_mask && istype(victim.wear_mask, /obj/item/clothing/mask/facehugger)) || HAS_TRAIT(victim, TRAIT_XENO_HOST)) && victim.stat != DEAD) //If they're a host or have a facehugger currently infecting them. Must be alive.
			victim.apply_status_effect(/datum/status_effect/nest_sustenance)

/obj/structure/bed/nest/post_unbuckle_mob(mob/living/M)
	REMOVE_TRAIT(M, TRAIT_HANDS_BLOCKED, type)
	M.remove_offsets(type)
	M.layer = initial(M.layer)
	cut_overlay(nest_overlay)
	M.remove_status_effect(/datum/status_effect/nest_sustenance)

/obj/structure/bed/nest/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			playsound(loc, 'sound/effects/blob/attackblob.ogg', 100, TRUE)
		if(BURN)
			playsound(loc, 'sound/items/tools/welder.ogg', 100, TRUE)

/obj/structure/bed/nest/attack_alien(mob/living/carbon/alien/user, list/modifiers)
	if(!user.combat_mode)
		return attack_hand(user, modifiers)
	else
		return ..()
