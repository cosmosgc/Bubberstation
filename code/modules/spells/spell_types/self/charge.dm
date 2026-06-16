/datum/action/cooldown/spell/charge
	name = "Charge"
	desc = "Este feitiço pode ser usado para recarregar várias coisas em suas mãos, de artefatos mágicos a componentes elétricos. Um mago criativo pode até usá-lo para dar poder mágico a outro usuário mágico."
	button_icon_state = "charge"

	sound = 'sound/effects/magic/charge.ogg'
	school = SCHOOL_TRANSMUTATION
	cooldown_time = 60 SECONDS
	cooldown_reduction_per_rank = 5 SECONDS

	invocation = "Diri Cel!"
	invocation_type = INVOCATION_WHISPER
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC

/datum/action/cooldown/spell/charge/is_valid_target(atom/cast_on)
	return isliving(cast_on)

/datum/action/cooldown/spell/charge/cast(mob/living/cast_on)
	. = ..()

	// Charge people we're pulling first and foremost
	if(isliving(cast_on.pulling))
		var/mob/living/pulled_living = cast_on.pulling
		var/pulled_has_spells = FALSE

		for(var/datum/action/cooldown/spell/spell in pulled_living.actions)
			spell.reset_spell_cooldown()
			pulled_has_spells = TRUE

		if(pulled_has_spells)
			to_chat(pulled_living, span_notice("Você sente magia crua fluindo através de você. Isso é bom!"))
			to_chat(cast_on, span_notice("[pulled_living] de repente parece muito quente!"))
			return

		to_chat(pulled_living, span_notice("Você se sente muito estranho por um momento, mas depois passa."))

	// Then charge their main hand item, then charge their offhand item
	var/obj/item/to_charge = cast_on.get_active_held_item() || cast_on.get_inactive_held_item()
	if(!to_charge)
		to_chat(cast_on, span_notice("Você sente o poder mágico subindo através de suas mãos, mas o sentimento rapidamente desaparece."))
		return

	var/charge_return = SEND_SIGNAL(to_charge, COMSIG_ITEM_MAGICALLY_CHARGED, src, cast_on)

	if(QDELETED(to_charge))
		to_chat(cast_on, span_warning("[src] Parece reagir adversamente com [to_charge]!"))
		return

	if(charge_return & COMPONENT_ITEM_BURNT_OUT)
		to_chat(cast_on, span_warning("[to_charge] Parece reagir negativamente a [src], ficando desconfortavelmente quente!"))

	else if(charge_return & COMPONENT_ITEM_CHARGED)
		to_chat(cast_on, span_notice("[to_charge] de repente parece muito quente!"))

	else
		to_chat(cast_on, span_notice("[to_charge] Não parece estar reagindo a [src]."))
