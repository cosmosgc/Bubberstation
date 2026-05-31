/**
 * Players can revive simplemobs with this.
 *
 * In-game item that can be used to revive a simplemob once. This makes the mob friendly.
 * Becomes useless after use.
 * Becomes malfunctioning when EMP'd.
 * If a hostile mob is revived with a malfunctioning injector, it will be hostile to everyone except whoever revived it and gets robust searching enabled.
 */
/obj/item/lazarus_injector
	name = "lazarus injector"
	desc = "Um injetor com um coquetel de nanomáquinas e produtos químicos, este dispositivo pode aparentemente criar animais dos mortos, tornando-os amigáveis ao usuário. Infelizmente, o processo é inútil em formas de vida mais elevadas e incrivelmente caros, então estes foram escondidos no armazenamento até que um executivo pensou que seria uma grande motivação para alguns de seus funcionários."
	icon = 'icons/obj/medical/syringe.dmi'
	icon_state = "lazarus_hypo"
	inhand_icon_state = "hypo"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 3
	throw_range = 5
	///Can this still be used?
	var/loaded = TRUE
	///Injector malf?
	var/malfunctioning = FALSE
	///So you can't revive boss monsters or robots with it
	var/revive_type = SENTIENCE_ORGANIC

/obj/item/lazarus_injector/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	if(!loaded)
		return NONE
	if(SEND_SIGNAL(target, COMSIG_ATOM_ON_LAZARUS_INJECTOR, src, user) & LAZARUS_INJECTOR_USED)
		return ITEM_INTERACT_SUCCESS
	if(!isliving(target))
		return NONE

	var/mob/living/target_animal = target
	if(!target_animal.compare_sentience_type(revive_type)) // Will also return false if not a basic or simple mob, which are the only two we want anyway
		balloon_alert(user, "criatura inválida!")
		return ITEM_INTERACT_BLOCKING
	if(target_animal.stat != DEAD)
		balloon_alert(user, "Não está morto!")
		return ITEM_INTERACT_BLOCKING

	target_animal.lazarus_revive(user, malfunctioning)
	expend(target_animal, user)
	return ITEM_INTERACT_SUCCESS

/obj/item/lazarus_injector/proc/expend(atom/revived_target, mob/user)
	user.visible_message(span_notice("[user]Injeções[revived_target]com[src]Revivendo."))
	SSblackbox.record_feedback("tally", "lazarus_injector", 1, revived_target.type)
	loaded = FALSE
	playsound(src,'sound/effects/refill.ogg',50,TRUE)
	icon_state = "lazarus_empty"

/obj/item/lazarus_injector/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(!malfunctioning)
		malfunctioning = TRUE

/obj/item/lazarus_injector/examine(mob/user)
	. = ..()
	if(!loaded)
		. += span_info("[src]Está vazio.")
	if(malfunctioning)
		. += span_info("A exibição em[src]Parece estar piscando.")
