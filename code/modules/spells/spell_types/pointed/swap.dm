/datum/action/cooldown/spell/pointed/swap
	name = "Swap"
	desc = "Este feitiço permite trocar de lugar com qualquer ser vivo. Marque um alvo secundário de troca. Este alvo secundário será descartado assim que você trocar, ou então você pode clicar em si mesmo com o RMB para descartar seu alvo secundário."
	button_icon_state = "swap"
	ranged_mousepointer = 'icons/effects/mouse_pointers/swap_target.dmi'
	active_overlay_icon_state = "bg_spell_border_active_blue"

	school = SCHOOL_TRANSLOCATION
	cooldown_time = 25 SECONDS
	cooldown_reduction_per_rank = 10 SECONDS
	spell_max_level = 3
	cast_range = 9
	invocation_type = INVOCATION_NONE
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC|SPELL_REQUIRES_STATION
	active_msg = "You prepare to swap locations with a target..."

	smoke_type = /datum/effect_system/fluid_spread/smoke
	smoke_amt = 0

	/// A variable for holding the second selected target with right click.
	var/mob/living/second_target

/datum/action/cooldown/spell/pointed/swap/Destroy()
	second_target = null
	return ..()

/datum/action/cooldown/spell/pointed/swap/is_valid_target(atom/cast_on)
	. = ..()
	if(!.)
		return FALSE
	if(!isliving(cast_on))
		to_chat(owner, span_warning("Você só pode trocar lugares com seres vivos!"))
		return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/swap/InterceptClickOn(mob/living/clicker, params, atom/target)
	if(!LAZYACCESS(params2list(params), RIGHT_CLICK))
		return ..()

	if(!IsAvailable(feedback = TRUE))
		return FALSE
	if(!target)
		return FALSE
	if(!isliving(target) || isturf(target))
		// Find any living being in the list. We aren't picky, it's aim assist after all
		target = locate(/mob/living) in target
		if(!target)
			to_chat(owner, span_warning("Você só pode selecionar seres vivos como alvo secundário!"))
			return FALSE
	if(target == owner)
		if(!isnull(second_target))
			to_chat(owner, span_notice("Cancele seu alvo de troca secundária!"))
			second_target = null
		else
			to_chat(owner, span_warning("Você não tem meta de troca secundária!"))
		return FALSE
	second_target = target
	to_chat(owner, span_notice("Você seleciona [target.name] Como um alvo secundário de troca!"))
	return FALSE

/datum/action/cooldown/spell/pointed/swap/cast(mob/living/carbon/cast_on)
	. = ..()
	if(cast_on.can_block_magic(antimagic_flags))
		to_chat(owner, span_warning("O feitiço não teve efeito!"))
		to_chat(cast_on, span_warning("Você sente o espaço dobrando, mas rapidamente se dissipa."))
		return FALSE

	to_chat(cast_on, span_userdanger("Você sente o espaço dobrando."))
	if(ispath(smoke_type, /datum/effect_system/fluid_spread/smoke))
		do_smoke(smoke_amt, owner, get_turf(owner), smoke_type = smoke_type)

	var/turf/target_location = get_turf(cast_on)
	if(!isnull(second_target) && get_dist(owner, second_target) <= cast_range && !(cast_on == second_target))
		to_chat(second_target, span_userdanger("Você sente o espaço dobrando."))
		if(ispath(smoke_type, /datum/effect_system/fluid_spread/smoke))
			do_smoke(smoke_amt, owner, get_turf(second_target))
		var/turf/second_location = get_turf(second_target)
		do_teleport(second_target, owner.loc, no_effects = TRUE, channel = TELEPORT_CHANNEL_MAGIC)
		do_teleport(cast_on, second_location, no_effects = TRUE, channel = TELEPORT_CHANNEL_MAGIC)
		do_teleport(owner, target_location, no_effects = TRUE, channel = TELEPORT_CHANNEL_MAGIC)
		second_target.playsound_local(get_turf(second_target), 'sound/effects/magic/swap.ogg', 50, 1)
		cast_on.playsound_local(get_turf(cast_on), 'sound/effects/magic/swap.ogg', 50, 1)
		owner.playsound_local(get_turf(owner), 'sound/effects/magic/swap.ogg', 50, 1)
	else
		do_teleport(cast_on, owner.loc, no_effects = TRUE, channel = TELEPORT_CHANNEL_MAGIC)
		do_teleport(owner, target_location, no_effects = TRUE, channel = TELEPORT_CHANNEL_MAGIC)
		cast_on.playsound_local(get_turf(cast_on), 'sound/effects/magic/swap.ogg', 50, 1)
		owner.playsound_local(get_turf(owner), 'sound/effects/magic/swap.ogg', 50, 1)
	second_target = null
