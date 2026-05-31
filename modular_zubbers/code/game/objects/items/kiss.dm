/obj/item/hand_item/kisser/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!HAS_TRAIT(user, TRAIT_HYPNO_KISS) || !iscarbon(interacting_with) || (user.zone_selected != BODY_ZONE_PRECISE_MOUTH))
		return ranged_interact_with_atom(interacting_with, user, modifiers)

	visible_message("[user]Se inclina para um beijo nos lábios.")
	if(!do_after(user, 2 SECONDS, interacting_with))
		visible_message("[user]não consegue trancar os lábios com ninguém.")
		return ITEM_INTERACT_BLOCKING

	var/mob/living/carbon/victim = interacting_with

	if(user)
		log_combat(user, victim, "[user] hypno kissed [victim]", src)
		user.visible_message(span_danger("[user]Beijos[victim]Nos lábios![victim]Parece corado!"), span_danger("Você beija.[victim]Nos lábios!"))

	if(!victim.hypnosis_vulnerable())
		to_chat(victim, span_hypnophrase("Aquele beijo fez você se sentir estranhamente relaxado..."))
		victim.adjust_confusion_up_to(10 SECONDS, 20 SECONDS)
		victim.adjust_dizzy_up_to(20 SECONDS, 40 SECONDS)
		victim.adjust_drowsiness_up_to(20 SECONDS, 40 SECONDS)
		victim.adjust_pacifism(10 SECONDS)
	else
		victim.apply_status_effect(/datum/status_effect/trance, 20 SECONDS, TRUE)

