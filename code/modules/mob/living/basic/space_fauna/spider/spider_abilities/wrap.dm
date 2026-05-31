/datum/action/cooldown/mob_cooldown/wrap
	name = "Wrap"
	desc = "Embrulhe algo ou alguém em um casulo. Se for uma espécie humana ou similar, você também os consumirá. Consumir uma vítima embrulhada pode fortalecer suas habilidades de postura de ovos. Ative essa habilidade e clique em um alvo adjacente para começar a embrulhá-los."
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"
	button_icon = 'icons/mob/actions/actions_animal.dmi'
	button_icon_state = "wrap_0"
	click_to_activate = TRUE
	ranged_mousepointer = 'icons/effects/mouse_pointers/wrap_target.dmi'
	shared_cooldown = NONE
	/// The time it takes to wrap something.
	var/wrap_time = 5 SECONDS

/datum/action/cooldown/mob_cooldown/wrap/Grant(mob/grant_to)
	. = ..()
	if (!owner)
		return
	RegisterSignals(owner, list(COMSIG_DO_AFTER_BEGAN, COMSIG_DO_AFTER_ENDED), PROC_REF(update_status_on_signal))

/datum/action/cooldown/mob_cooldown/wrap/Remove(mob/removed_from)
	. = ..()
	UnregisterSignal(removed_from, list(COMSIG_DO_AFTER_BEGAN, COMSIG_DO_AFTER_ENDED))

/datum/action/cooldown/mob_cooldown/wrap/IsAvailable(feedback = FALSE)
	. = ..()
	if(!. || owner.incapacitated)
		return FALSE
	if(DOING_INTERACTION(owner, DOAFTER_SOURCE_SPIDER))
		if (feedback)
			owner.balloon_alert(owner, "Ocupado!")
		return FALSE
	return TRUE

/datum/action/cooldown/mob_cooldown/wrap/set_click_ability(mob/on_who)
	. = ..()
	if(!.)
		return

	on_who.balloon_alert(on_who, "preparado para embrulhar")
	button_icon_state = "wrap_1"
	build_all_button_icons()

/datum/action/cooldown/mob_cooldown/wrap/unset_click_ability(mob/on_who, refund_cooldown = TRUE)
	. = ..()
	if(!.)
		return

	if (refund_cooldown)
		on_who.balloon_alert(on_who, "wrap cancelado")
	button_icon_state = "wrap_0"
	build_all_button_icons()

/datum/action/cooldown/mob_cooldown/wrap/Activate(atom/to_wrap)
	if(!owner.Adjacent(to_wrap))
		owner.balloon_alert(owner, "Precisa estar mais perto!")
		return FALSE

	if(!ismovable(to_wrap) || to_wrap == owner)
		return FALSE
	if(isliving(to_wrap))
		var/mob/living/living_target = to_wrap
		if(living_target.mob_biotypes & MOB_SPECIAL)
			owner.balloon_alert(owner, "Não pode embrulhar, muito forte!")
			return FALSE
		if(living_target.mob_biotypes & MOB_SPIRIT)
			owner.balloon_alert(owner, "Não posso embrulhar fantasmas!")
			return FALSE
		if(isspider(living_target))
			owner.balloon_alert(owner, "Não posso embrulhar aranhas!")
			return FALSE
	var/atom/movable/target_movable = to_wrap
	if(target_movable.anchored)
		return FALSE

	StartCooldown(wrap_time)
	INVOKE_ASYNC(src, PROC_REF(cocoon), to_wrap)
	return TRUE

/datum/action/cooldown/mob_cooldown/wrap/proc/cocoon(atom/movable/to_wrap)
	if(isliving(to_wrap))
		to_chat(to_wrap, span_userdanger("[owner]Começa a segregar uma substância pegajosa ao seu redor."))
	owner.visible_message(
		span_notice("[owner]começa a secretar uma substância pegajosa ao redor[to_wrap]."),
		span_notice("Você começa a embrulhar[to_wrap]Em um casulo."),
	)
	if(do_after(owner, wrap_time, target = to_wrap, interaction_key = DOAFTER_SOURCE_SPIDER))
		wrap_target(to_wrap)
	else
		owner.balloon_alert(owner, "Interrompido!")

/datum/action/cooldown/mob_cooldown/wrap/proc/wrap_target(mob/living/to_wrap)
	var/obj/structure/spider/cocoon/casing = new(to_wrap.loc)
	if(isliving(to_wrap))
		var/mob/living/living_wrapped = to_wrap
		// You get a point every time you consume a living player, even if they've been consumed before.
		// You only get a point for any individual corpse once, so you can't keep breaking it out and eating it again.
		if(ishuman(living_wrapped) && (living_wrapped.stat != DEAD || !HAS_TRAIT(living_wrapped, TRAIT_SPIDER_CONSUMED)))
			var/datum/action/cooldown/mob_cooldown/lay_eggs/enriched/egg_power = locate() in owner.actions
			if(egg_power)
				egg_power.charges++
				egg_power.build_all_button_icons()
				owner.visible_message(
					span_danger("[owner]Enfia um proboscis em[living_wrapped]e suga uma substância viscosa para fora."),
					span_notice("Você suga o alimento de[living_wrapped], alimentando você o suficiente para colocar um grupo de ovos enriquecidos."),
				)
			ADD_TRAIT(living_wrapped, TRAIT_SPIDER_CONSUMED, TRAIT_GENERIC)
			living_wrapped.investigate_log("has been killed by being wrapped in a cocoon.", INVESTIGATE_DEATHS)
			living_wrapped.death() //you just ate them, they're dead.
			log_combat(owner, living_wrapped, "spider cocooned")
		else
			to_chat(owner, span_warning("[living_wrapped]Não é comestível!"))

	to_wrap.forceMove(casing)
	if(isliving(to_wrap)&& (to_wrap.mob_biotypes & MOB_HUMANOID))
		casing.icon_state = pick("cocoon_large1", "cocoon_large2", "cocoon_large3")
	else
		casing.icon_state = pick("cocoon1", "cocoon2", "cocoon3")
