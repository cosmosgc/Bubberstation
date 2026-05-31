/obj/item/taster
	name = "taster"
	desc = "Prove as coisas, então não precisa!"
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "tongue"

	w_class = WEIGHT_CLASS_TINY

	var/taste_sensitivity = 15

/obj/item/taster/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!interacting_with.reagents)
		to_chat(user, span_notice("[src]Não consigo provar.[interacting_with], desde[interacting_with.p_they()] [interacting_with.p_have()]Não tem reagentes."))
	else if(interacting_with.reagents.total_volume == 0)
		to_chat(user, span_notice("[src]Não consigo provar.[interacting_with], desde[interacting_with.p_they()] [interacting_with.p_are()]Vazio."))
	else
		var/message = interacting_with.reagents.generate_taste_message(user, taste_sensitivity)
		to_chat(user, span_notice("[src]Gostos<i>[message]</i>em[interacting_with]."))
	return user.combat_mode ? NONE : ITEM_INTERACT_SUCCESS
