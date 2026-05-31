/datum/action/cooldown/spell/pointed/mindread/cast(mob/living/cast_on)
	if(HAS_TRAIT(cast_on, TRAIT_PSIONIC_DAMPENER))
		to_chat(owner, span_warning("Enquanto você alcança[cast_on]Você é parado por um bloqueio mental."))
		return
	return ..()
