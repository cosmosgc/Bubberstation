/// Ignites matches swiped over it.
/datum/element/ignites_matches

/datum/element/ignites_matches/Attach(datum/target)
	. = ..()
	RegisterSignal(target, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(on_interact))

/datum/element/ignites_matches/Detach(datum/source)
	UnregisterSignal(source, COMSIG_ATOM_ITEM_INTERACTION)
	return ..()

/datum/element/ignites_matches/proc/on_interact(atom/source, mob/living/user, obj/item/match/match, ...)
	SIGNAL_HANDLER
	if(!istype(match) || match.lit || match.burnt || match.broken)
		return NONE
	if(SHOULD_SKIP_INTERACTION(source, match, user))
		return NONE
	var/over_what_tp = source.loc == user ? "[user.p_their()] [source.name]" : source
	var/over_what_fp = source.loc == user ? "your [source.name]" : source
	if(prob(10))
		user.visible_message(
			span_warning("[user] Slips [match] Câmbio.[over_what_tp] Mas nada acontece."),
			span_warning("Você rouba [match] Câmbio.[over_what_fp], mas ele falha em acender."),
		)
		return ITEM_INTERACT_SUCCESS
	if(prob((HAS_TRAIT(user, TRAIT_CLUMSY) || HAS_TRAIT(user, TRAIT_HULK)) ? 33 : 2))
		user.visible_message(
			span_warning("[user] Slips [match] Câmbio.[over_what_tp], acidentalmente estalando."),
			span_warning("Você rouba [match] Câmbio.[over_what_fp] Muito rápido, quebrando ao meio."),
		)
		match.snap()
		return ITEM_INTERACT_SUCCESS

	user.visible_message(
		span_rose("[user] Slips [match] Câmbio.[over_what_tp], acendendo."),
		span_rose("Você rouba [match] Câmbio.[over_what_fp], acendendo."),
	)
	match.matchignite()
	return ITEM_INTERACT_SUCCESS
