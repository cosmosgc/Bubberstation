/obj/item/prescription_lenses
	name = "spare lens kit"
	desc = "Pequena caixa de ferramentas com algumas lentes de prescrição de reposição, com tudo que você precisa para trocar lentes velhas em óculos."
	icon = 'modular_zubbers/icons/obj/items_and_weapons.dmi'
	icon_state = "prescriptionkit"

/obj/item/prescription_lenses/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!istype(interacting_with, /obj/item/clothing/glasses))
		to_chat(user, span_warning("Não são copos!"))
		return ITEM_INTERACT_SKIP_TO_ATTACK

	var/obj/item/clothing/glasses = interacting_with
	if(TRAIT_NEARSIGHTED_CORRECTED in glasses.clothing_traits)
		to_chat(user, span_warning("Estas já têm lentes de prescrição!"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("You've changed out the lenses on \the [interacting_with]."))
	glasses.attach_clothing_traits(TRAIT_NEARSIGHTED_CORRECTED)
	glasses.name = "prescription [glasses.name]"
	glasses.desc += " These seem to have prescription lenses inserted in them."
	qdel(src)
	return ITEM_INTERACT_SUCCESS
