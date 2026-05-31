/obj/item/stack/circuit_stack
	name = "polycircuit aggregate"
	desc = "Um denso e overdesigned cluster de eletrônica que tentou funcionar como um circuito eletrônico multiuso. Circuitos podem ser removidos dele... se você não sangrar no processo."
	icon_state = "circuit_mess"
	inhand_icon_state = "rods"
	w_class = WEIGHT_CLASS_TINY
	max_amount = 8
	merge_type = /obj/item/stack/circuit_stack
	singular_name = "circuito agregado"
	var/circuit_type = /obj/item/electronics/airlock
	var/chosen_circuit = "airlock"

/obj/item/stack/circuit_stack/attack_self(mob/user)// Prevents the crafting menu, and tells you how to use it.
	to_chat(user, span_warning("Você não pode usar[src]Por si só, você terá que tentar remover um desses circuitos à mão... com cuidado."))

/obj/item/stack/circuit_stack/attack_hand(mob/user, list/modifiers)
	var/mob/living/carbon/human/H = user
	if(user.get_inactive_held_item() != src)
		return ..()
	else
		if(is_zero_amount(delete_if_zero = TRUE))
			return
		chosen_circuit = tgui_input_list(user, "Circuit to remove", "Circuit Removal", list("airlock","firelock","fire alarm","air alarm","APC"), chosen_circuit)
		if(isnull(chosen_circuit))
			to_chat(user, span_notice("Você sabiamente evitar colocar suas mãos em qualquer lugar perto[src]."))
			return
		if(is_zero_amount(delete_if_zero = TRUE))
			return
		if(loc != user)
			return
		switch(chosen_circuit)
			if("airlock")
				circuit_type = /obj/item/electronics/airlock
			if("firelock")
				circuit_type = /obj/item/electronics/firelock
			if("fire alarm")
				circuit_type = /obj/item/electronics/firealarm
			if("air alarm")
				circuit_type = /obj/item/electronics/airalarm
			if("APC")
				circuit_type = /obj/item/electronics/apc
		to_chat(user, span_notice("Você vê seu circuito, e cuidadosamente tenta removê-lo de[src]Fique parado!"))
		if(do_after(user, 3 SECONDS, target = user))
			if(!src || QDELETED(src))//Sanity Check.
				return
			var/returned_circuit = new circuit_type(src)
			user.put_in_hands(returned_circuit)
			use(1)
			if(!amount)
				to_chat(user, span_notice("Você navega as bordas afiadas dos circuitos e remove a última placa."))
			else
				to_chat(user, span_notice("Você navega nas bordas afiadas dos circuitos e remove uma única placa de[src]"))
		else
			H.apply_damage(15, BRUTE, pick(GLOB.arm_zones))
			to_chat(user, span_warning("Você se dá um corte maldoso[src]São muitos cantos e bordas afiadas!"))

/obj/item/stack/circuit_stack/full
	amount = 8
