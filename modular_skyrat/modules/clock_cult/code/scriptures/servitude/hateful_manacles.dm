/datum/scripture/slab/hateful_manacles
	name = "Hateful Manacles"
	desc = "Forma algemas replicantes em torno dos pulsos de um alvo que funcionam como algemas, restringindo o alvo."
	tip = "Handcuff a target at close range to subdue them for vitality extraction."
	button_icon_state = "Hateful Manacles"
	power_cost = 50
	invocation_time = 2 SECONDS // 2 to invoke, 3 to cuff
	invocation_text = list("Balance o herege...", "Quebre-os em corpo e espírito!")
	slab_overlay = "hateful_manacles"
	use_time = 20 SECONDS
	cogs_required = 1
	category = SPELLTYPE_SERVITUDE


/datum/scripture/slab/hateful_manacles/apply_effects(mob/living/carbon/target_carbon)
	. = ..()
	if(!istype(target_carbon) || IS_CLOCK(target_carbon))
		return FALSE

	if(target_carbon.handcuffed)
		target_carbon.balloon_alert(invoker, "Já está preso!")
		return FALSE

	playsound(target_carbon, 'sound/items/weapons/handcuffs.ogg', 30, TRUE, -2)
	target_carbon.visible_message(span_danger("[invoker] forms a well of energy around [target_carbon], brass appearing at their wrists!"),\
						span_userdanger("[invoker] is trying to restrain you!"))

	if(!do_after(invoker, 3 SECONDS, target = target_carbon))
		return FALSE

	if(target_carbon.handcuffed)
		return FALSE

	target_carbon.handcuffed = new /obj/item/restraints/handcuffs/clockwork(target_carbon)
	target_carbon.update_handcuffed()
	log_combat(invoker, target_carbon, "handcuffed")

	return TRUE


/obj/item/restraints/handcuffs/clockwork
	name = "replicant manacles"
	desc = "Algemas pesadas feitas de metal gelado. Parece latão, mas parece muito mais sólido."
	icon_state = "brass_manacles"
	item_flags = DROPDEL
