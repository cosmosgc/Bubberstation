/obj/item/clothing/accessory/badge
	name = "detective's badge"
	desc = "Segurança. O distintivo do detetive, feito de ouro."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'
	icon_state = "badge"
	slot_flags = ITEM_SLOT_NECK
	attachment_slot = CHEST

	var/stored_name
	var/badge_string = "Corporate Security"

	drop_sound = 'modular_skyrat/master_files/sound/items/drop/ring.ogg'
	pickup_sound = 'modular_skyrat/master_files/sound/items/pickup/ring.ogg'

/obj/item/clothing/accessory/badge/old
	name = "faded badge"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'
	desc = "Um distintivo desbotado, apoiado com couro. Tem o emblema da Divisão Forense."
	icon_state = "goldbadge"

/obj/item/clothing/accessory/badge/proc/set_name(new_name)
	stored_name = new_name
	name = "[initial(name)] ([stored_name])"

/obj/item/clothing/accessory/badge/proc/set_desc(mob/living/carbon/human/H)

/obj/item/clothing/accessory/badge/attack_self(mob/user as mob)

	if(!stored_name)
		to_chat(user, "Você poli seu antigo distintivo com carinho, brilhando a superfície.")
		set_name(user.real_name)
		return

	if(isliving(user))
		if(stored_name)
			user.visible_message(span_notice("[user]Mostre o seu.[src.name].\nDiz:[stored_name], [badge_string]."),span_notice("Você mostra o seu[src.name].\nDiz:[stored_name], [badge_string]."))
		else
			user.visible_message(span_notice("[user]Mostre o seu.[src.name].\nDiz:[badge_string]."),span_notice("Você mostra o seu[src.name]Diz:[badge_string]."))

/obj/item/clothing/accessory/badge/attack(mob/living/carbon/human/M, mob/living/user)
	if(isliving(user))
		user.visible_message(span_danger("[user]Invadir[M]Espaço pessoal, empurrando[src]em seu rosto insistente."),span_danger("Você invade.[M]Espaço pessoal, empurrando[src]em seu rosto insistente."))
		user.do_attack_animation(M)

// Sheriff Badge (toy)
/obj/item/clothing/accessory/badge/sheriff
	name = "sheriff badge"
	desc = "Esta cidade não é grande o suficiente para nós dois, parceiro."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'
	icon_state = "sheriff"

/obj/item/clothing/accessory/badge/sheriff/attack_self(mob/user as mob)
	user.visible_message("[user]mostra seu distintivo de xerife. Há um novo xerife na cidade!",		"Mostre o distintivo de xerife para todos ao seu redor!")

/obj/item/clothing/accessory/badge/sheriff/attack(mob/living/carbon/human/M, mob/living/user)
	if(isliving(user))
		user.visible_message(span_danger("[user]Invadir[M]É espaço pessoal, o distintivo do xerife na cara deles!"),span_danger("Você invade.[M]É o espaço pessoal, colocando o distintivo de xerife em seu rosto insistentemente."))
		user.do_attack_animation(M)

//.Holobadges.
/obj/item/clothing/accessory/badge/holo
	name = "holobadge"
	desc = "Este distintivo azul brilhante marca o título como A LEI."
	icon_state = "holobadge_lopland"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'

/obj/item/clothing/accessory/badge/holo/cord
	icon_state = "holobadge-cord"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'

/obj/item/clothing/accessory/badge/holo/attack_self(mob/user as mob)
	if(!stored_name)
		to_chat(user, "Acenar em torno de um holobadge antes de tirar uma identidade seria inútil.")
		return
	return ..()

/obj/item/clothing/accessory/badge/holo/emag_act(remaining_charges, mob/user)
	if(obj_flags & EMAGGED)
		balloon_alert(user, "Já está rachado.")
		return FALSE

	obj_flags |= EMAGGED
	balloon_alert(user, "Cheques de segurança quebrados!")
	to_chat(user, span_danger("Você quebra os cheques de segurança do holobadge."))
	return TRUE

/obj/item/clothing/accessory/badge/holo/attackby(obj/item/object as obj, mob/user as mob)
	if(istype(object, /obj/item/card/id))

		var/obj/item/card/id/id_card = null

		if(istype(object, /obj/item/card/id))
			id_card = object

		if((ACCESS_SECURITY in id_card.access) || (obj_flags & EMAGGED))
			to_chat(user, "Você imprime seus dados de identificação no distintivo.")
			set_name(user.real_name)
			badge_string = id_card.assignment
		else
			to_chat(user, "[src]Rejeita seus direitos de acesso insuficientes.")
		return
	..()

/obj/item/storage/box/holobadge
	name = "holobadge box"
	desc = "Uma caixa superando holobações."

/obj/item/storage/box/holobadge/PopulateContents()
	. = ..()
	new /obj/item/clothing/accessory/badge/holo(src)
	new /obj/item/clothing/accessory/badge/holo(src)
	new /obj/item/clothing/accessory/badge/holo(src)
	new /obj/item/clothing/accessory/badge/holo(src)
	new /obj/item/clothing/accessory/badge/holo/cord(src)
	new /obj/item/clothing/accessory/badge/holo/cord(src)
	return

/obj/item/clothing/accessory/badge/holo/warden
	name = "warden's holobadge"
	desc = "Um crachá de segurança da empresa prata. Estampado com as palavras 'Direito'."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'
	icon_state = "silverbadge"
	slot_flags = ITEM_SLOT_NECK

/obj/item/clothing/accessory/badge/holo/hos
	name = "head of security's holobadge"
	desc = "Um imaculadamente polido distintivo de segurança de ouro. Rotulado \"Chefe de Segurança\"."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'
	icon_state = "goldbadge"
	slot_flags = ITEM_SLOT_NECK

/obj/item/clothing/accessory/badge/holo/detective
	name = "detective's holobadge"
	desc = "Um imaculamente polido em ouro em coro.\"Detetive\"."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'
	icon_state = "marshalbadge"
	slot_flags = ITEM_SLOT_NECK

/obj/item/storage/box/holobadge/hos
	name = "holobadge box"
	desc = "Uma caixa superando holobações."

/obj/item/storage/box/holobadge/hos/PopulateContents()
	. = ..()
	new /obj/item/clothing/accessory/badge/holo(src)
	new /obj/item/clothing/accessory/badge/holo(src)
	new /obj/item/clothing/accessory/badge/holo/warden(src)
	new /obj/item/clothing/accessory/badge/holo/detective(src)
	new /obj/item/clothing/accessory/badge/holo/detective(src)
	new /obj/item/clothing/accessory/badge/holo/hos(src)
	new /obj/item/clothing/accessory/badge/holo/cord(src)
	return

