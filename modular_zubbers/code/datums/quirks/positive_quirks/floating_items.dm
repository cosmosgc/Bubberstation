/datum/quirk/floating_items
	name = "Psionic Holding"
	desc = "Você acha os itens com as mãos tão inconvenientes, e usa seus poderes mentais para fazê-lo."
	value = 0
	icon = FA_ICON_METEOR
	medical_record_text = "A mente do sujeito é capaz de telecinese extremamente limitada."
	gain_text = "Sua mente parece que pode levantar pesos!"
	lose_text = "Sua mente parece que levou um dia de trapaça."
	mob_trait = TRAIT_FLOATING_HELD

/datum/quirk_constant_data/floating_items
	associated_typepath = /datum/quirk/floating_items
	customization_options = list(/datum/preference/color/floating_items)

/datum/preference/color/floating_items
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "floating_items"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/color/floating_items/apply_to_human(mob/living/carbon/human/target, value)
	target.held_hover_color = value

/datum/quirk/floating_items/add(client/client_source)
	. = ..()
	var/datum/action/innate/toggle_floating_items/toggle = new
	toggle.Grant(quirk_holder)

/datum/preference/color/floating_items/create_default_value()
	return "#FF99FF"

/datum/action/innate/toggle_floating_items
	name = "Toggle Psionic Holding"
	button_icon = 'modular_skyrat/master_files/icons/effects/tele_effects.dmi'
	button_icon_state = "telekinesishead"
	check_flags = AB_CHECK_INCAPACITATED|AB_CHECK_CONSCIOUS

/datum/action/innate/toggle_floating_items/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	if(owner)
		if(HAS_TRAIT(owner, TRAIT_FLOATING_HELD))
			REMOVE_TRAIT(owner, TRAIT_FLOATING_HELD, QUIRK_TRAIT)
			if(ishuman(owner))
				var/mob/living/carbon/human/owner_human = owner
				owner_human.update_held_items()
			to_chat(owner, span_notice("Pare de se concentrar em mover objetos com sua mente."))
		else
			ADD_TRAIT(owner, TRAIT_FLOATING_HELD, QUIRK_TRAIT)
			if(ishuman(owner))
				var/mob/living/carbon/human/owner_human = owner
				owner_human.update_held_items()
			to_chat(owner, span_notice("Você se sente pronto para mover objetos com sua mente."))
	return TRUE
