/datum/action/changeling/sting//parent path, not meant for users afaik
	name = "Tiny Prick" //cellularemporium uses `nameToIconState` to button icon state must match this, on top of matching the hud below.
	desc = "Esfaqueado."
	category = "stings"
	button_icon_state = "sting_null" //This must be equal to the icon state for `/atom/movable/screen/ling/sting`

/datum/action/changeling/sting/Trigger(mob/clicker, trigger_flags)
	SHOULD_CALL_PARENT(FALSE) //We are snowflaked from parent
	var/mob/user = owner
	if(!user || !user.mind)
		return
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(user)
	if(!changeling)
		return
	if(!changeling.chosen_sting)
		set_sting(user)
	else
		unset_sting(user)
	return

/datum/action/changeling/sting/proc/set_sting(mob/user)
	to_chat(user, span_notice("Preparamos nossa picada. Alt+clique ou clique no botão do meio do mouse em um alvo para picar."))
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(user)
	changeling.chosen_sting = src

	var/atom/movable/screen/ling/sting/sting = user.hud_used?.screen_objects[HUD_CHANGELING_STING]
	if (sting)
		sting.icon_state = button_icon_state
		sting.SetInvisibility(0, id=type)

/datum/action/changeling/sting/proc/unset_sting(mob/user)
	to_chat(user, span_warning("Retiramos nossa picada, não podemos picar ninguém por enquanto."))
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(user)
	changeling.chosen_sting = null

	var/atom/movable/screen/ling/sting/sting = user.hud_used?.screen_objects[HUD_CHANGELING_STING]
	if (sting)
		sting.icon_state = null
		sting.RemoveInvisibility(type)

/mob/living/carbon/proc/unset_sting()
	if(mind)
		var/datum/antagonist/changeling/changeling = mind.has_antag_datum(/datum/antagonist/changeling)
		if(changeling?.chosen_sting)
			changeling.chosen_sting.unset_sting(src)

/datum/action/changeling/sting/can_sting(mob/user, mob/target)
	if(!..())
		return
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(user)
	if(!changeling.chosen_sting)
		to_chat(user, "Ainda não preparamos nossa picada!")
	if(!iscarbon(target))
		return
	if(!isturf(user.loc))
		return
	var/mob/living/carbon/human/to_check = target // SKYRAT EDIT START - STINGS DO NOT AFFECT ROBOTIC ENTITIES
	if(to_check.mob_biotypes & MOB_ROBOTIC)
		to_chat(user, "<span class='warning'>Nossa picada não teria efeito em entidades robóticas.</span>")
		return // SKYRAT EDIT END
	if(!length(get_path_to(user, target, max_distance = changeling.sting_range, simulated_only = FALSE)))
		return // no path within the sting's range is found. what a weird place to use the pathfinding system
	if(IS_CHANGELING(target))
		sting_feedback(user, target)
		changeling.chem_charges -= chemical_cost
	return 1

/datum/action/changeling/sting/sting_feedback(mob/user, mob/target)
	if(!target)
		return
	to_chat(user, span_notice("Nós furtivamente ardemos [target.name]."))
	if(IS_CHANGELING(target))
		to_chat(target, span_warning("Você sente uma picadinha."))
	return 1

/datum/action/changeling/sting/transformation
	name = "Transformation Sting"
	desc = "Nós silenciosamente picamos um organismo, injetando um retrovírus que os força a se transformar."
	helptext = "The victim will transform much like a changeling would. 		For complex humanoids, the transformation is temporarily, but the duration is paused while the victim is dead or in stasis. 		For more simple humanoids, such as monkeys, the transformation is permanent. 		Does not provide a warning to others. Mutations will not be transferred."
	button_icon_state = "transformation_sting"
	chemical_cost = 33 // Low enough that you can sting only two people in quick succession
	dna_cost = 2
	/// A reference to our active profile, which we grab DNA from
	VAR_FINAL/datum/changeling_profile/selected_dna
	/// Duration of the sting
	var/sting_duration = 8 MINUTES
	/// Set this to false via VV to allow golem, plasmaman, or monkey changelings to turn other people into golems, plasmamen, or monkeys
	var/verify_valid_species = TRUE

/datum/action/changeling/sting/transformation/Grant(mob/grant_to)
	. = ..()
	build_all_button_icons(UPDATE_BUTTON_NAME)

/datum/action/changeling/sting/transformation/update_button_name(atom/movable/screen/movable/action_button/button, force)
	. = ..()
	button.desc += " Lasts [DisplayTimeText(sting_duration)] for humans, but duration is paused while dead or in stasis."
	button.desc += " Costs [chemical_cost] chemicals."

/datum/action/changeling/sting/transformation/Destroy()
	selected_dna = null
	return ..()

/datum/action/changeling/sting/transformation/set_sting(mob/user)
	selected_dna = null
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(user)
	var/datum/changeling_profile/new_selected_dna = changeling.select_dna()
	if(QDELETED(src) || QDELETED(changeling) || QDELETED(user))
		return
	if(!new_selected_dna || changeling.chosen_sting || selected_dna) // selected other sting or other DNA while sleeping
		return
	if(verify_valid_species && (TRAIT_NO_DNA_COPY in new_selected_dna.dna.species.inherent_traits))
		user.balloon_alert(user, "DNA incompatível!")
		return
	selected_dna = new_selected_dna
	return ..()

/datum/action/changeling/sting/transformation/can_sting(mob/user, mob/living/carbon/target)
	. = ..()
	if(!.)
		return
	// Similar checks here are ran to that of changeling can_absorb_dna -
	// Logic being that if their DNA is incompatible with us, it's also bad for transforming
	if(!iscarbon(target) 		|| !target.has_dna() 		|| HAS_TRAIT(target, TRAIT_HUSK) 		|| HAS_TRAIT(target, TRAIT_BADDNA) 		|| (HAS_TRAIT(target, TRAIT_NO_DNA_COPY) && !ismonkey(target))) // sure, go ahead, make a monk-clone
		user.balloon_alert(user, "DNA incompatível!")
		return FALSE
	if(target.has_status_effect(/datum/status_effect/temporary_transformation/trans_sting))
		user.balloon_alert(user, "Já se transformou!")
		return FALSE
	return TRUE

/datum/action/changeling/sting/transformation/sting_action(mob/living/user, mob/living/target)
	var/final_duration = sting_duration
	var/final_message = span_notice("Nós nos transformamos [target] em [selected_dna.dna.real_name].")
	if(ismonkey(target))
		final_duration = INFINITY
		final_message = span_warning("Nossos genes gritam enquanto transformamos a forma menor de [target] em [selected_dna.dna.real_name] permanentemente!")

	if(target.apply_status_effect(/datum/status_effect/temporary_transformation/trans_sting, final_duration, selected_dna.dna))
		..()
		log_combat(user, target, "stung", "transformation sting", " new identity is '[selected_dna.dna.real_name]'")
		to_chat(user, final_message)
		return TRUE
	return FALSE

/datum/action/changeling/sting/false_armblade
	name = "False Armblade Sting"
	desc = "Nós silenciosamente picamos um humano, injetando um retrovírus que muta seu braço para aparecer temporariamente como uma lâmina de braço. Custa 20 produtos químicos."
	helptext = "The victim will form an armblade much like a changeling would, except the armblade is dull and useless."
	button_icon_state = "false_armblade_sting"
	chemical_cost = 20
	dna_cost = 1

/obj/item/melee/arm_blade/false
	desc = "Uma massa grotesca de carne que costumava ser seu braço. Embora pareça perigoso no início, pode-se ver que na verdade é bem chato e inútil."
	force = 5 //Basically as strong as a punch
	fake = TRUE

/datum/action/changeling/sting/false_armblade/can_sting(mob/user, mob/target)
	if(!..())
		return
	if(isliving(target))
		var/mob/living/L = target
		if((HAS_TRAIT(L, TRAIT_HUSK)) || !L.has_dna())
			user.balloon_alert(user, "DNA incompatível!")
			return FALSE
	return TRUE

/datum/action/changeling/sting/false_armblade/sting_action(mob/user, mob/target)

	var/obj/item/held = target.get_active_held_item()
	if(held && !target.dropItemToGround(held))
		to_chat(user, span_warning("[held] está preso a [target.p_their()] Mão, não podemos deixar crescer uma falsa lâmina sobre ela!"))
		return

	..()
	log_combat(user, target, "stung", object = "false armblade sting")
	if(ismonkey(target))
		to_chat(user, span_notice("Nossos genes gritam enquanto ardemos [target.name]!"))

	var/obj/item/melee/arm_blade/false/blade = new(target,1)
	target.put_in_hands(blade)
	target.visible_message(span_warning("Uma lâmina grotesca se forma ao redor.[target.name]\'Braço!"), span_userdanger("Seu braço se torce e se transforma em uma monstruosidade horrível!"), span_hear("Você ouve matéria orgânica rasgando e rasgando!"))
	playsound(target, 'sound/effects/blob/blobattack.ogg', 30, TRUE)

	addtimer(CALLBACK(src, PROC_REF(remove_fake), target, blade), 1 MINUTES)
	return TRUE

/datum/action/changeling/sting/false_armblade/proc/remove_fake(mob/target, obj/item/melee/arm_blade/false/blade)
	playsound(target, 'sound/effects/blob/blobattack.ogg', 30, TRUE)
	target.visible_message(span_warning("Com uma crise doentia,[target] Reformas [target.p_their()] [blade.name] Em um braço!"),
	span_warning("[blade] reformas de volta ao normal."), span_italics("Você ouve matéria orgânica rasgando e rasgando!"))

	qdel(blade)
	target.update_held_items()

/datum/action/changeling/sting/extract_dna
	name = "Extract DNA Sting"
	desc = "Nós furtivamente picamos um alvo e extraímos o DNA deles. Custa 25 produtos químicos."
	helptext = "Will give us the DNA of our target, allowing us to transform into them. This will render us unable to absorb their body fully later."
	button_icon_state = "extract_dna_sting"
	chemical_cost = 25
	dna_cost = 0

/datum/action/changeling/sting/extract_dna/can_sting(mob/user, mob/target)
	if(..())
		var/datum/antagonist/changeling/changeling = IS_CHANGELING(user)
		return changeling.can_absorb_dna(target)

/datum/action/changeling/sting/extract_dna/sting_action(mob/user, mob/living/carbon/human/target)
	..()
	log_combat(user, target, "stung", "extraction sting")
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(user)
	if(!changeling.has_profile_with_dna(target.dna))
		changeling.add_new_profile(target)
	return TRUE

/datum/action/changeling/sting/mute
	name = "Mute Sting"
	desc = "Nós silenciosamente picamos um humano, silenciando-os por pouco tempo. Custa 20 produtos químicos."
	helptext = "Does not provide a warning to the victim that they have been stung, until they try to speak and cannot."
	button_icon_state = "mute_sting"
	chemical_cost = 20
	dna_cost = 2

/datum/action/changeling/sting/mute/sting_action(mob/user, mob/living/carbon/target)
	..()
	log_combat(user, target, "stung", "mute sting")
	target.adjust_silence(1 MINUTES)
	return TRUE

/datum/action/changeling/sting/blind
	name = "Blind Sting"
	desc = "Cegamos temporariamente nossa vítima. Custa 25 produtos químicos."
	helptext = "This sting completely blinds a target for a short time, and leaves them with blurred vision for a long time. Does not work if target has robotic or missing eyes."
	button_icon_state = "blind_sting"
	chemical_cost = 25
	dna_cost = 1

/datum/action/changeling/sting/blind/sting_action(mob/user, mob/living/carbon/target)
	var/obj/item/organ/eyes/eyes = target.get_organ_slot(ORGAN_SLOT_EYES)
	if(!eyes)
		user.balloon_alert(user, "Sem olhos!")
		return FALSE

	if(IS_ROBOTIC_ORGAN(eyes))
		user.balloon_alert(user, "Olhos robóticos!")
		return FALSE

	..()
	log_combat(user, target, "stung", "blind sting")
	to_chat(target, span_danger("Seus olhos ardem horrivelmente!"))
	eyes.apply_organ_damage(eyes.maxHealth * 0.8)
	target.adjust_temp_blindness(40 SECONDS)
	target.set_eye_blur_if_lower(80 SECONDS)
	return TRUE

/datum/action/changeling/sting/lsd
	name = "Hallucination Sting"
	desc = "Causamos terror em massa à nossa vítima. Custa 10 produtos químicos."
	helptext = "We evolve the ability to sting a target with a powerful hallucinogenic chemical. 			The target does not notice they have been stung, and the effect occurs after 30 to 60 seconds."
	button_icon_state = "hallucination_sting"
	chemical_cost = 10
	dna_cost = 1

/datum/action/changeling/sting/lsd/sting_action(mob/user, mob/living/carbon/target)
	..()
	log_combat(user, target, "stung", "LSD sting")
	addtimer(CALLBACK(src, PROC_REF(hallucination_time), target), rand(30 SECONDS, 60 SECONDS))
	return TRUE

/datum/action/changeling/sting/lsd/proc/hallucination_time(mob/living/carbon/target)
	if(QDELETED(src) || QDELETED(target))
		return
	target.adjust_hallucinations(180 SECONDS)

/datum/action/changeling/sting/cryo
	name = "Cryogenic Sting"
	desc = "Nós silenciosamente picamos nossa vítima com um coquetel de produtos químicos que os congela de dentro. Custa 15 produtos químicos."
	helptext = "Does not provide a warning to the victim, though they will likely realize they are suddenly freezing."
	button_icon_state = "cryogenic_sting"
	chemical_cost = 15
	dna_cost = 2

/datum/action/changeling/sting/cryo/sting_action(mob/user, mob/target)
	..()
	log_combat(user, target, "stung", "cryo sting")
	if(target.reagents)
		target.reagents.add_reagent(/datum/reagent/consumable/frostoil, 30)
	return TRUE
