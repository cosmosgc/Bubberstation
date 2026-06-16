/datum/action/cooldown/spell/pointed/barnyardcurse
	name = "Curse of the Barnyard"
	desc = "Este feitiço condena uma alma azarada a possuir a fala e atributos faciais de um animal de celeiro."
	button_icon_state = "barn"
	ranged_mousepointer = 'icons/effects/mouse_pointers/barn_target.dmi'

	school = SCHOOL_TRANSMUTATION
	cooldown_time = 15 SECONDS
	cooldown_reduction_per_rank = 3 SECONDS

	invocation = "KN'A FTAGHU, PUCK 'BTHNK!"
	invocation_type = INVOCATION_SHOUT
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC

	active_msg = "You prepare to curse a target..."
	deactive_msg = "You dispel the curse."

/datum/action/cooldown/spell/pointed/barnyardcurse/is_valid_target(atom/cast_on)
	. = ..()
	if(!.)
		return FALSE
	if(!ishuman(cast_on))
		return FALSE

	var/mob/living/carbon/human/human_target = cast_on
	if(!human_target.wear_mask)
		return TRUE

	return !(human_target.wear_mask.type in GLOB.cursed_animal_masks)

/datum/action/cooldown/spell/pointed/barnyardcurse/cast(mob/living/carbon/human/cast_on)
	. = ..()
	if(cast_on.can_block_magic(antimagic_flags))
		cast_on.visible_message(
			span_danger("[cast_on] O rosto explode em chamas, que instantaneamente explode para fora, deixando [cast_on.p_them()] ileso!"),
			span_danger("Seu rosto começa a arder, mas as chamas são repelidas pela sua proteção anti-mágica!"),
		)
		to_chat(owner, span_warning("O feitiço não teve efeito!"))
		return FALSE

	var/chosen_type = pick(GLOB.cursed_animal_masks)
	var/obj/item/clothing/mask/animal/cursed_mask = new chosen_type(get_turf(target))

	cast_on.visible_message(
		span_danger("[target] O rosto explode em chamas, e a cabeça de um animal de celeiro toma seu lugar!"),
		span_userdanger("Seu rosto arde, e logo após o fogo você percebe que tem o rosto de um [cursed_mask.animal_type]!"),
	)

	// Can't drop? Nuke it
	if(!cast_on.dropItemToGround(cast_on.wear_mask))
		qdel(cast_on.wear_mask)

	cast_on.equip_to_slot_if_possible(cursed_mask, ITEM_SLOT_MASK, TRUE, TRUE)
	cast_on.flash_act()
	return TRUE
