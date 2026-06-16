/obj/item/bear_armor
	name = "pile of bear armor"
	desc = "Uma pilha de várias peças de armadura em forma de urso, uma fita adesiva e uma lima de unha. Instruções brutas estão escritas na parte de trás de uma das placas em russo. Parece uma péssima ideia."
	icon = 'icons/obj/tools.dmi'
	icon_state = "bear_armor_upgrade"

/obj/item/bear_armor/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!istype(interacting_with, /mob/living/basic/bear))
		return NONE
	var/mob/living/basic/bear/bear = interacting_with
	if(bear.armored)
		to_chat(user, span_warning("[bear] Já foi armado!"))
		return ITEM_INTERACT_BLOCKING
	bear.armored = TRUE
	bear.maxHealth += 60
	bear.health += 60
	bear.armour_penetration += 20
	bear.melee_damage_lower += 3
	bear.melee_damage_upper += 5
	bear.wound_bonus += 5
	bear.update_icons()
	to_chat(user, span_info("Você amarra a armadura para [bear] e afiar [bear.p_their()] Garras com a lima de unhas. Foi uma ótima ideia."))
	qdel(src)
	return ITEM_INTERACT_SUCCESS
