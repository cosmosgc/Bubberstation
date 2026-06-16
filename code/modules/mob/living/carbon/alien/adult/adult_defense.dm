

/mob/living/carbon/alien/adult/attack_hulk(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	adjust_brute_loss(15)
	var/hitverb = "hit"
	if(mob_size < MOB_SIZE_LARGE)
		safe_throw_at(get_edge_target_turf(src, get_dir(user, src)), 2, 1, user)
		hitverb = "slam"
	playsound(loc, SFX_PUNCH, 25, TRUE, -1)
	visible_message(span_danger("[user] [hitverb] S [src]!"), 					span_userdanger("[user] [hitverb] É você!"), span_hear("Você ouve um som doentio de carne batendo em carne!"), COMBAT_MESSAGE_RANGE, user)
	to_chat(user, span_danger("Você.[hitverb] [src]!"))

/mob/living/carbon/alien/adult/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(.)
		return TRUE
	var/damage = rand(1, 9)
	if (prob(90))
		playsound(loc, SFX_PUNCH, 25, TRUE, -1)
		visible_message(span_danger("[user] socos [src]!"), 						span_userdanger("[user] Bate em você!"), span_hear("Você ouve um som doentio de carne batendo em carne!"), COMBAT_MESSAGE_RANGE, user)
		to_chat(user, span_danger("Você soca.[src]!"))
		if ((stat != DEAD) && (damage > 9 || prob(5)))//Regular humans have a very small chance of knocking an alien down.
			Unconscious(40)
			visible_message(span_danger("[user] Bate.[src] Abaixe-se!"), 							span_userdanger("[user] Derruba você!"), span_hear("Você ouve um som doentio de carne batendo em carne!"), null, user)
			to_chat(user, span_danger("Você bate.[src] Abaixe-se!"))
		var/obj/item/bodypart/affecting = get_bodypart(get_random_valid_zone(user.zone_selected))
		apply_damage(damage, BRUTE, affecting)
		log_combat(user, src, "attacked")
	else
		playsound(loc, 'sound/items/weapons/punchmiss.ogg', 25, TRUE, -1)
		visible_message(span_danger("[user] O soco erra.[src]!"), 						span_danger("Você evita [user] É ponche!"), span_hear("Você ouve um shoosh!"), COMBAT_MESSAGE_RANGE, user)
		to_chat(user, span_warning("Seu soco erra [src]!"))

/mob/living/carbon/alien/adult/do_attack_animation(atom/A, visual_effect_icon, obj/item/used_item, no_effect)
	if(!no_effect && !visual_effect_icon)
		visual_effect_icon = ATTACK_EFFECT_CLAW
	..()
