//--- BOWIE'S KNIFE (bowie knife)---


/obj/item/knife/bowie
	name = "\improper Bowie knife"
	desc = "Clássico de um homem das fronteiras, mais perto de uma espada curta do que uma faca. Ele tem um corpo bronzeado, um protetor de bronze e pommel, um ponto afiado e uma lâmina grande e pesada, é quase tudo que você poderia querer em uma faca, além de portabilidade."
	icon = 'modular_skyrat/modules/knives/icons/bowie.dmi'
	icon_state = "bowiehand"
	inhand_icon_state = "bowiehand"
	lefthand_file = 'modular_skyrat/modules/knives/icons/bowie_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/knives/icons/bowie_righthand.dmi'
	worn_icon_state = "knife"
	force = 17 // why was this 20 what the fuck man
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 20
	wound_bonus = 10 //scalpel tier
	exposed_wound_bonus = 20 // Very-bigly

/obj/item/storage/belt/bowie_sheath
	name = "\improper Bowie knife sheath"
	desc = "Uma bainha de couro vestida com uma ponta de latão. Ele tem um grande clipe de bolso bem no centro, para facilidade de carregar uma faca de outra forma pesada."
	icon = 'modular_skyrat/modules/knives/icons/bowiepocket.dmi'
	icon_state = "bowiesheath"
	slot_flags = ITEM_SLOT_POCKETS
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FLAMMABLE
	interaction_flags_click = NEED_DEXTERITY

/obj/item/storage/belt/bowie_sheath/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 1
	atom_storage.max_total_storage = WEIGHT_CLASS_BULKY
	atom_storage.set_holdable(list(
		/obj/item/knife/bowie,
		))

/obj/item/storage/belt/bowie_sheath/click_alt(mob/user)
	if(length(contents))
		var/obj/item/knife = contents[1]
		user.visible_message(span_notice("[user] takes [knife] out of [src]."), span_notice("You take [knife] out of [src]."))
		user.put_in_hands(knife)
		update_appearance()
		return CLICK_ACTION_SUCCESS
	else
		to_chat(user, span_warning("[src] is empty!"))
		return CLICK_ACTION_BLOCKING

/obj/item/storage/belt/bowie_sheath/update_icon_state()
	icon_state = initial(icon_state)
	if(contents.len)
		icon_state += "e-knife"
	return ..()

/obj/item/storage/belt/bowie_sheath/PopulateContents()
	new /obj/item/knife/bowie(src)
	update_appearance()
