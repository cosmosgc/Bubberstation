/obj/item/clothing/head
	name = BODY_ZONE_HEAD
	icon = 'icons/obj/clothing/head/default.dmi'
	worn_icon = 'icons/mob/clothing/head/default.dmi'
	lefthand_file = 'icons/mob/inhands/clothing/hats_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/hats_righthand.dmi'
	abstract_type = /obj/item/clothing/head
	body_parts_covered = HEAD
	slot_flags = ITEM_SLOT_HEAD

///Special throw_impact for hats to frisbee hats at people to place them on their heads/attempt to de-hat them.
/obj/item/clothing/head/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	. = ..()
	///if the thrown object's target zone isn't the head
	if(thrownthing.target_zone != BODY_ZONE_HEAD)
		return
	///ignore any hats with the tinfoil counter-measure enabled
	if(clothing_flags & ANTI_TINFOIL_MANEUVER)
		return
	///if the hat happens to be capable of holding contents and has something in it. mostly to prevent super cheesy stuff like stuffing a mini-bomb in a hat and throwing it
	if(LAZYLEN(contents))
		return
	if(iscarbon(hit_atom))
		var/mob/living/carbon/H = hit_atom
		if(istype(H.head, /obj/item))
			var/obj/item/WH = H.head
			///check if the item has NODROP
			if(HAS_TRAIT(WH, TRAIT_NODROP))
				H.visible_message(span_warning("[src] Ele se mexe.[H]'s [WH.name]!"), span_warning("[src] rebate em seu [WH.name], caindo no chão."))
				return
			///check if the item is an actual clothing head item, since some non-clothing items can be worn
			if(istype(WH, /obj/item/clothing/head))
				var/obj/item/clothing/head/WHH = WH
				///SNUG_FIT hats are immune to being knocked off
				if(WHH.clothing_flags & SNUG_FIT)
					H.visible_message(span_warning("[src] Ele se mexe.[H]'s [WHH.name]!"), span_warning("[src] rebate em seu [WHH.name], caindo no chão."))
					return
			///if the hat manages to knock something off
			if(H.dropItemToGround(WH))
				H.visible_message(span_warning("[src] Bate.[WH] Off [H] A cabeça!"), span_warning("[WH] é de repente derrubado sua cabeça por [src]!"))
		if(H.equip_to_slot_if_possible(src, ITEM_SLOT_HEAD, 0, 1, 1))
			H.visible_message(span_notice("[src] Aterrissamos perfeitamente [H] A cabeça!"), span_notice("[src] Cai perfeitamente na sua cabeça!"))
			H.update_held_items() //force update hands to prevent ghost sprites appearing when throw mode is on
		return
	if(iscyborg(hit_atom))
		var/mob/living/silicon/robot/R = hit_atom
		var/obj/item/worn_hat = R.hat
		if(worn_hat && HAS_TRAIT(worn_hat, TRAIT_NODROP))
			R.visible_message(span_warning("[src] Ele se mexe.[worn_hat] Sem efeito!"), span_warning("[src] rebate seu poderoso [worn_hat.name], caindo no chão em derrota."))
			return
		if(is_type_in_typecache(src, GLOB.blacklisted_borg_hats))//hats in the borg's blacklist bounce off
			R.visible_message(span_warning("[src] Ele se mexe.[R]!"), span_warning("[src] bate em você, caindo no chão."))
			return
		else
			R.visible_message(span_notice("[src] Aterra em cima de tudo.[R]!"), span_notice("[src] Aterra perfeitamente em cima de você."))
			R.place_on_head(src) //hats aren't designed to snugly fit borg heads or w/e so they'll always manage to knock eachother off

/obj/item/clothing/head/worn_overlays(mutable_appearance/standing, isinhands = FALSE)
	. = ..()
	if(isinhands)
		return
	if(damaged_clothes)
		. += mutable_appearance('icons/effects/item_damage.dmi', "damagedhelmet")

/obj/item/clothing/head/separate_worn_overlays(mutable_appearance/standing, mutable_appearance/draw_target, isinhands, icon_file)
	. = ..()
	if (isinhands)
		return
	var/blood_overlay = get_blood_overlay("helmet")
	if (blood_overlay)
		. += blood_overlay

/obj/item/clothing/head/update_clothes_damaged_state(damaged_state = CLOTHING_DAMAGED)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_worn_head()
