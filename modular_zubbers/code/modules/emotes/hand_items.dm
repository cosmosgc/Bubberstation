/obj/item/hand_item/bonkinghand
	name = "bonking hand"
	desc = "Hora de bater alguém na cabeça de forma cômica."
	inhand_icon_state = "nothing"
	attack_verb_continuous = list("bonks")
	attack_verb_simple = list("bonk")
	hitsound = 'sound/effects/snap.ogg'

/obj/item/hand_item/bonkinghand/Initialize(mapload)
	. = ..()

/obj/item/hand_item/bonkinghand/attack(mob/living/bonked, mob/living/carbon/human/user)
	var/bonk_volume = 75
	var/obj/item/bodypart/bonkers_hand = user.get_bodypart("[(user.active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
	var/obj/item/bodypart/head/bonk_victims_head = bonked.get_bodypart(BODY_ZONE_HEAD)
	if(user.zone_selected != BODY_ZONE_HEAD)
		to_chat(user, span_warning("Você não pode acertar alguém na cabeça se não estiver mirando na cabeça deles!"))
		return

	if(issilicon(bonked))
		if(bonkers_hand?.receive_damage( 5, 0 )) // 5 brute damage
			user.update_damage_overlays()
		user.visible_message(
			span_danger("[user]Bonks.[bonked]na cabeça, deixando suas mãos vermelhas e inchadas!"),
			span_notice("Seu bonk.[bonked]na cabeça, mas machuque sua mão no metal da cabeça deles!"),
			span_hear("Você ouve um bonk metálico cômico."),
		)
		playsound(bonked, 'sound/items/weapons/smash.ogg', bonk_volume, TRUE, -1)

	else if(bonk_victims_head)
		if(bonk_victims_head.biological_state & BIO_METAL)
			if(bonkers_hand?.receive_damage( 5, 0 )) // 5 brute damage
				user.update_damage_overlays()
			user.visible_message(
				span_danger("[user]Bonks.[bonked]na cabeça, deixando suas mãos vermelhas e inchadas!"),
				span_notice("Seu bonk.[bonked]na cabeça, mas machuque sua mão no metal da cabeça deles!"),
				span_hear("Você ouve um bonk metálico cômico."),
			)
			playsound(bonked, 'sound/items/weapons/smash.ogg', bonk_volume, FALSE, -1)

		else
			user.visible_message(
				span_danger("[user]Bonks.[bonked]Na cabeça!"),
				span_notice("Seu bonk.[bonked]Na cabeça!"),
				span_hear("Você ouve um som cômico."),
			)
			playsound(bonked, 'modular_zubbers/code/modules/emotes/sound/effects/bonk.ogg', bonk_volume, FALSE, -1)
	else
		to_chat(user, span_warning("Você não pode bater em alguém na cabeça se eles não têm cabeça!"))
		return
	qdel(src)
// Successful takes will qdel our hand after
/obj/item/hand_item/bonkinghand/on_offer_taken(mob/living/carbon/offerer, mob/living/carbon/taker)
	. = ..()
	if(!.)
		return

	qdel(src)

