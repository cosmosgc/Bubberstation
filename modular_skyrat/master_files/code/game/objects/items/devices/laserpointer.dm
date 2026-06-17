/obj/item/laser_pointer
	//Whether the laser pointer is capable of receiving upgrades
	var/upgradable = TRUE

/obj/item/laser_pointer/limited
	//limited laser pointers cannot receive upgrades, mostly used in loadout
	upgradable = FALSE

/obj/item/laser_pointer/limited/red
	pointer_icon_state = "red_laser"

/obj/item/laser_pointer/limited/green
	pointer_icon_state = "green_laser"

/obj/item/laser_pointer/limited/blue
	pointer_icon_state = "blue_laser"

/obj/item/laser_pointer/limited/purple
	pointer_icon_state = "purple_laser"

/obj/item/laser_pointer/screwdriver_act(mob/living/user, obj/item/tool)
	if(!upgradable)
		balloon_alert(user, "Não consigo remover o diodo integrado!")
		return
	return ..()

/obj/item/laser_pointer/attackby(obj/item/attack_item, mob/user, params)
	if(istype(attack_item, /obj/item/stock_parts/micro_laser) || istype(attack_item, /obj/item/stack/ore/bluespace_crystal))
		if(!upgradable)
			balloon_alert(user, "Não pode atualizar peças integradas!")
			return
	return ..()

/obj/item/laser_pointer/examine(mob/user)
	. = ..()
	if(!upgradable)
		. += span_notice("O díodo e a lente são componentes baratos e integrados. Este ponteiro não pode ser atualizado.")
