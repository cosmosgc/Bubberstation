/obj/item/reagent_containers/dropper
	name = "dropper"
	desc = "Um conta-gotas. Tem até 5 unidades."
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "dropper0"
	inhand_icon_state = "dropper"
	worn_icon_state = "pen"
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list(1, 2, 3, 4, 5)
	volume = 5
	initial_reagent_flags = TRANSPARENT
	custom_price = PAYCHECK_CREW
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT)

/obj/item/reagent_containers/dropper/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	if(!target.reagents)
		return NONE

	if(reagents.total_volume > 0)
		if(target.reagents.holder_full())
			to_chat(user, span_notice("[target] Está cheio."))
			return ITEM_INTERACT_BLOCKING

		if(!target.is_injectable(user))
			to_chat(user, span_warning("Você não pode transferir reagentes para [target]!"))
			return ITEM_INTERACT_BLOCKING

		var/trans = 0
		var/fraction = min(amount_per_transfer_from_this / reagents.total_volume, 1)

		if(ismob(target))
			user.changeNext_move(CLICK_CD_MELEE)
			if(ishuman(target))
				var/mob/living/carbon/human/victim = target
				var/obj/item/safe_thing = victim.is_eyes_covered()

				if(safe_thing)
					if(!safe_thing.reagents)
						safe_thing.create_reagents(100)

					trans = round(reagents.trans_to(safe_thing, amount_per_transfer_from_this, transferred_by = user, methods = TOUCH), CHEMICAL_VOLUME_ROUNDING)

					target.visible_message(span_danger("[user] Tenta esguichar algo em [target] Os olhos, mas falha!"), 											span_userdanger("[user] Tenta esguichar algo em seus olhos, mas falha!"))
					if(trans)
						to_chat(user, span_notice("Você se transferiu.[trans] Unidade da solução."))
					update_appearance()
					return ITEM_INTERACT_BLOCKING

			else if(isalien(target)) //hiss-hiss has no eyes!
				to_chat(target, span_danger("[target] Não parece ter olhos!"))
				return ITEM_INTERACT_BLOCKING

			target.visible_message(
				span_danger("[user] Esguicha algo em [target] Os olhos!"),
				span_userdanger("[user] esguicha algo em seus olhos!"),
			)
			SEND_SIGNAL(target, COMSIG_MOB_REAGENTS_DROPPED_INTO_EYES, user, src, reagents, fraction)
			reagents.expose(target, TOUCH, fraction)
			var/mob/M = target
			log_combat(user, M, "squirted", reagents.get_reagent_log_string())

		trans = round(reagents.trans_to(target, amount_per_transfer_from_this, transferred_by = user), CHEMICAL_VOLUME_ROUNDING)
		if(trans)
			to_chat(user, span_notice("Você se transferiu.[trans] Unidade da solução."))
		update_appearance()
		target.update_appearance()
		return ITEM_INTERACT_SUCCESS

	if(!target.is_drawable(user, FALSE)) //No drawing from mobs here
		to_chat(user, span_warning("Você não pode remover diretamente reagentes de [target]!"))
		return ITEM_INTERACT_BLOCKING

	if(!target.reagents.total_volume)
		to_chat(user, span_warning("[target] Está vazio!"))
		return ITEM_INTERACT_BLOCKING

	var/trans = round(target.reagents.trans_to(src, amount_per_transfer_from_this, transferred_by = user), CHEMICAL_VOLUME_ROUNDING)
	if(trans)
		to_chat(user, span_notice("Você enche.[src] com [trans] Unidade da solução."))

	update_appearance()
	target.update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/item/reagent_containers/dropper/update_overlays()
	. = ..()
	if(!reagents.total_volume)
		return
	var/mutable_appearance/filling = mutable_appearance('icons/obj/medical/reagent_fillings.dmi', "dropper")
	filling.color = mix_color_from_reagents(reagents.reagent_list)
	. += filling
