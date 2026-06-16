

/mob/living/carbon/alien/larva/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(.)
		return TRUE
	var/damage = rand(1, 9)
	if (prob(90))
		playsound(loc, SFX_PUNCH, 25, TRUE, -1)
		visible_message(span_danger("[user] Chutes [src]!"), 						span_userdanger("[user] Chuta você!"), span_hear("Você ouve um som doentio de carne batendo em carne!"), COMBAT_MESSAGE_RANGE, user)
		to_chat(user, span_danger("Você chuta.[src]!"))
		if ((stat != DEAD) && (damage > 4.9))
			Unconscious(rand(100,200))

		var/obj/item/bodypart/affecting = get_bodypart(get_random_valid_zone(user.zone_selected))
		apply_damage(damage, BRUTE, affecting)
		log_combat(user, src, "attacked")
	else
		playsound(loc, 'sound/items/weapons/punchmiss.ogg', 25, TRUE, -1)
		visible_message(span_danger("[user] O chute erra [src]!"), 						span_danger("Você evita [user] Chute!"), span_hear("Você ouve um shoosh!"), COMBAT_MESSAGE_RANGE, user)
		to_chat(user, span_warning("Seu chute erra [src]!"))
		log_combat(user, src, "attacked and missed")

/mob/living/carbon/alien/larva/attack_hulk(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	user.AddComponent(/datum/component/force_move, get_step_away(user,src, 30))

/mob/living/carbon/alien/larva/do_attack_animation(atom/A, visual_effect_icon, obj/item/used_item, no_effect)
	if(!no_effect && !visual_effect_icon)
		visual_effect_icon = ATTACK_EFFECT_BITE
	..()
