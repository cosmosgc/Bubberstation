/*
Slimecrossing Armor
	Armor added by the slimecrossing system.
	Collected here for clarity.
*/

//Rebreather mask - Chilling Blue
/obj/item/clothing/mask/nobreath
	name = "rebreather mask"
	desc = "Uma máscara transparente, parecida com uma máscara de respiração convencional, mas feita de lodo azulado. Parece que não há nenhum tubo de ar."
	icon_state = "slime"
	inhand_icon_state = "b_mask"
	body_parts_covered = NONE
	w_class = WEIGHT_CLASS_SMALL
	clothing_traits = list(TRAIT_NOBREATH)
	armor_type = /datum/armor/mask_nobreath
	flags_cover = MASKCOVERSMOUTH
	resistance_flags = NONE
	interaction_flags_mouse_drop = NEED_HANDS

/datum/armor/mask_nobreath
	bio = 50

/obj/item/clothing/mask/nobreath/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot & ITEM_SLOT_MASK)
		user.failed_last_breath = FALSE
		user.clear_alert(ALERT_NOT_ENOUGH_OXYGEN)
		user.apply_status_effect(/datum/status_effect/rebreathing)

/obj/item/clothing/mask/nobreath/dropped(mob/living/carbon/human/user)
	..()
	user.remove_status_effect(/datum/status_effect/rebreathing)

/obj/item/clothing/glasses/prism_glasses
	name = "prism glasses"
	desc = "As lentes parecem brilhar ligeiramente, e refletem luz em cores deslumbrantes."
	icon = 'icons/obj/science/slimecrossing.dmi'
	icon_state = "prismglasses"
	actions_types = list(/datum/action/item_action/change_prism_colour, /datum/action/item_action/place_light_prism)

	forced_glass_color = TRUE
	var/glasses_color = COLOR_WHITE

/obj/item/clothing/glasses/prism_glasses/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/wearable_client_colour, /datum/client_colour/glass_colour, ITEM_SLOT_EYES, GLASSES_TRAIT, glasses_color, forced_glass_color)

/obj/structure/light_prism
	name = "light prism"
	desc = "Um cristal brilhante de luz semi-sólida. Parece frágil."
	icon = 'icons/obj/science/slimecrossing.dmi'
	icon_state = "lightprism"
	density = FALSE
	anchored = TRUE
	max_integrity = 10

/obj/structure/light_prism/Initialize(mapload, newcolor)
	. = ..()
	if(newcolor)
		color = newcolor
		set_light_color(newcolor)
	set_light(5)

/obj/structure/light_prism/attack_hand(mob/user, list/modifiers)
	to_chat(user, span_notice("You dispel [src]."))
	qdel(src)

/datum/action/item_action/change_prism_colour
	name = "Adjust Prismatic Lens"
	button_icon = 'icons/obj/science/slimecrossing.dmi'
	button_icon_state = "prismcolor"

/datum/action/item_action/change_prism_colour/do_effect(trigger_flags)
	var/obj/item/clothing/glasses/prism_glasses/glasses = target
	var/new_color = tgui_color_picker(owner, "Choose the lens color:", "Color change",glasses.glasses_color)
	if(!new_color)
		return
	RemoveElement(/datum/element/wearable_client_colour, /datum/client_colour/glass_colour, ITEM_SLOT_EYES, GLASSES_TRAIT, glasses.glasses_color, glasses.forced_glass_color)
	glasses.glasses_color = new_color
	AddElement(/datum/element/wearable_client_colour, /datum/client_colour/glass_colour, ITEM_SLOT_EYES, GLASSES_TRAIT, new_color, glasses.forced_glass_color)

/datum/action/item_action/place_light_prism
	name = "Fabricate Light Prism"
	button_icon = 'icons/obj/science/slimecrossing.dmi'
	button_icon_state = "lightprism"

/datum/action/item_action/place_light_prism/do_effect(trigger_flags)
	var/obj/item/clothing/glasses/prism_glasses/glasses = target
	if(locate(/obj/structure/light_prism) in get_turf(owner))
		to_chat(owner, span_warning("Não há energia ambiente suficiente para fabricar outro prisma de luz aqui."))
		return
	if(istype(glasses))
		if(!glasses.glasses_color)
			to_chat(owner, span_warning("A lente é estranhamente opaca..."))
			return
		to_chat(owner, span_notice("Você canaliza a luz próxima para um brilhante prisma etéreo."))
		new /obj/structure/light_prism(get_turf(owner), glasses.glasses_color)

/obj/item/clothing/head/peaceflower
	name = "heroine bud"
	desc = "Uma flor extremamente viciante, cheia de magia de paz."
	icon = 'icons/obj/science/slimecrossing.dmi'
	worn_icon = 'icons/mob/clothing/head/costume.dmi'
	icon_state = "peaceflower"
	inhand_icon_state = null
	slot_flags = ITEM_SLOT_HEAD
	clothing_traits = list(TRAIT_PACIFISM)
	body_parts_covered = NONE
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 1
	throw_range = 3

/obj/item/clothing/head/peaceflower/can_mob_unequip(mob/user)
	if(user.get_item_by_slot(slot_flags) == src)
		to_chat(user, span_warning("Você se sente em paz.<b style='color:pink'>Por que você quer outra coisa?</b>"))
		return FALSE
	return ..()

/obj/item/clothing/suit/armor/heavy/adamantine
	name = "adamantine armor"
	desc = "Uma armadura completa de adamantina. Impressionantemente resistente a danos, mas pesa tanto quanto você."
	icon_state = "adamsuit"
	icon = 'icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'icons/mob/clothing/suits/armor.dmi'
	inhand_icon_state = null
	flags_inv = NONE
	item_flags = IMMUTABLE_SLOW
	slowdown = 4
	var/hit_reflect_chance = 40

/obj/item/clothing/suit/armor/heavy/adamantine/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, SFX_PLATE_ARMOR_RUSTLE, 8)

/obj/item/clothing/suit/armor/heavy/adamantine/IsReflect(def_zone)
	if((def_zone in list(BODY_ZONE_CHEST, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)) && prob(hit_reflect_chance))
		return TRUE
	else
		return FALSE
