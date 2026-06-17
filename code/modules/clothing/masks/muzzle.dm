/obj/item/clothing/mask/muzzle
	name = "muzzle"
	desc = "Para parar com esse barulho horrível."
	icon_state = "muzzle"
	inhand_icon_state = "blindfold"
	lefthand_file = 'icons/mob/inhands/clothing/glasses_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/glasses_righthand.dmi'
	flags_cover = MASKCOVERSMOUTH
	w_class = WEIGHT_CLASS_SMALL
	equip_delay_other = 2 SECONDS

/obj/item/clothing/mask/muzzle/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/muffles_speech)

/obj/item/clothing/mask/muzzle/attack_paw(mob/user, list/modifiers)
	if(iscarbon(user))
		var/mob/living/carbon/carbon_user = user
		if(src == carbon_user.wear_mask)
			to_chat(user, span_warning("Você precisa de ajuda para tirar isso!"))
			return
	return ..()

/obj/item/clothing/mask/muzzle/tape
	name = "tape piece"
	desc = "Um pedaço de fita que pode ser colocado na boca de alguém."
	worn_icon_state = "tape_piece_worn"
	inhand_icon_state = null
	w_class = WEIGHT_CLASS_TINY
	clothing_flags = INEDIBLE_CLOTHING
	equip_delay_other = 4 SECONDS
	strip_delay = 4 SECONDS
	icon = 'icons/map_icons/clothing/mask.dmi'
	icon_state = "/obj/item/clothing/mask/muzzle/tape"
	post_init_icon_state = "tape_piece"
	greyscale_config = /datum/greyscale_config/tape_piece
	greyscale_config_worn = /datum/greyscale_config/tape_piece/worn
	greyscale_colors = "#B2B2B2"
	///Dertermines whether the tape piece does damage when ripped off of someone.
	var/harmful_strip = FALSE
	///The ammount of damage dealt when the tape piece is ripped off of someone.
	var/stripping_damage = 0

/obj/item/clothing/mask/muzzle/tape/examine(mob/user)
	. = ..()
	. += "[span_notice("Use it on someone while not in combat mode to tape their mouth closed!")]"

/obj/item/clothing/mask/muzzle/tape/dropped(mob/living/user)
	. = ..()
	if(user.get_item_by_slot(ITEM_SLOT_MASK) != src)
		return
	playsound(user, 'sound/items/duct_tape/duct_tape_rip.ogg', 50, TRUE)
	if(harmful_strip)
		user.apply_damage(stripping_damage, BRUTE, BODY_ZONE_HEAD)
		INVOKE_ASYNC(user, TYPE_PROC_REF(/mob, emote), "scream")
		to_chat(user, span_userdanger("Você sente uma grande dor quando centenas de pequenos espinhos se soltam do seu rosto!"))

/obj/item/clothing/mask/muzzle/tape/attack(mob/living/carbon/victim, mob/living/carbon/attacker, list/modifiers, list/attack_modifiers)
	if(attacker.combat_mode)
		return ..()
	if(victim.is_mouth_covered(ITEM_SLOT_HEAD))
		to_chat(attacker, span_notice("[victim]'s mouth is covered."))
		return
	if(!mob_can_equip(victim, ITEM_SLOT_MASK))
		to_chat(attacker, span_notice("[victim] is already wearing somthing on their face."))
		return
	balloon_alert(attacker, "Boca tatuada...")
	to_chat(victim, span_userdanger("[attacker] is attempting to tape your mouth closed!"))
	if(!do_after(attacker, equip_delay_other, target = victim))
		return
	victim.equip_to_slot_if_possible(src, ITEM_SLOT_MASK)
	update_appearance()

/obj/item/clothing/mask/muzzle/tape/super
	name = "super tape piece"
	desc = "Um pedaço de fita que pode ser colocado na boca de alguém. Este tem força extra."
	icon_state = "/obj/item/clothing/mask/muzzle/tape/super"
	greyscale_colors = "#4D4D4D"
	strip_delay = 8 SECONDS

/obj/item/clothing/mask/muzzle/tape/surgical
	name = "surgical tape piece"
	desc = "Um pedaço de fita que pode ser colocado na boca de alguém. Desde que aplique isso ao seu paciente, não ouvirá seus gritos de dor!"
	icon_state = "/obj/item/clothing/mask/muzzle/tape/surgical"
	greyscale_colors = "#70BAE7"
	equip_delay_other = 3 SECONDS
	strip_delay = 3 SECONDS

/obj/item/clothing/mask/muzzle/tape/pointy
	name = "pointy tape piece"
	desc = "Um pedaço de fita que pode ser colocado na boca de alguém. Parece que vai doer se isto for arrancado."
	worn_icon_state = "tape_piece_spikes_worn"
	icon = 'icons/map_icons/clothing/mask.dmi'
	icon_state = "/obj/item/clothing/mask/muzzle/tape/pointy"
	post_init_icon_state = "tape_piece_spikes"
	greyscale_config = /datum/greyscale_config/tape_piece/spikes
	greyscale_config_worn = /datum/greyscale_config/tape_piece/worn/spikes
	greyscale_colors = "#E64539#AD2F45"
	harmful_strip = TRUE
	stripping_damage = 10

/obj/item/clothing/mask/muzzle/tape/pointy/super
	name = "super pointy tape piece"
	desc = "Um pedaço de fita que pode ser colocado na boca de alguém. Essa coisa pode rasgar seu rosto em milhares de pedaços."
	icon_state = "/obj/item/clothing/mask/muzzle/tape/pointy/super"
	greyscale_colors = "#8C0A00#300008"
	strip_delay = 6 SECONDS
	stripping_damage = 20
