/// SKYRAT MODULE SKYRAT_XENO_REDO

/mob/living/carbon/human/attack_alien(mob/living/carbon/alien/adult/user, list/modifiers)
	. = ..()
	if(!.)
		return

	if(LAZYACCESS(modifiers, RIGHT_CLICK)) //Always drop item in hand, if no item, get stun instead.
		var/obj/item/mob_held_item = get_active_held_item()
		var/disarm_damage = rand(user.melee_damage_lower * 1.5, user.melee_damage_upper * 1.5)

		if(mob_held_item)

			if(check_block(user, damage = 0, attack_text = "[user.name]"))
				playsound(loc, 'sound/items/weapons/parry.ogg', 25, TRUE, -1) //Audio feedback to the fact you just got blocked
				apply_damage(disarm_damage / 2, STAMINA)
				visible_message(span_danger("[user]Tentando tocar[src]!"), 					span_danger("[user]Tenta tocar em você!"), span_hear("Você ouve um shoosh!"), null, user)
				to_chat(user, span_warning("Você tenta tocar[src]!"))
				return FALSE

			playsound(loc, 'sound/items/weapons/thudswoosh.ogg', 25, TRUE, -1) //The sounds of these are changed so the xenos can actually hear they are being non-lethal
			Knockdown(3 SECONDS)
			apply_damage(disarm_damage, STAMINA)
			visible_message(span_danger("[user]Bate.[src]Abaixe-se!"), 				span_userdanger("[user]Derruba você!"), span_hear("Você ouve um barulho agressivo!"), null, user)
			to_chat(user, span_danger("Você bate.[src]Abaixe-se!"))
			return TRUE

		else
			playsound(loc, 'sound/effects/hit_kick.ogg', 25, TRUE, -1)
			apply_damage(disarm_damage, STAMINA)
			log_combat(user, src, "tackled")
			visible_message(span_danger("[user]Tackles[src]Abaixe-se!"), 							span_userdanger("[user]Derruba você!"), span_hear("Você ouve baralhar agressivo!"), null, user)
			to_chat(user, span_danger("Você joga[src]Abaixe-se!"))

		return TRUE

	if(user.combat_mode)
		if(w_uniform)
			w_uniform.add_fingerprint(user)

		var/damage = rand(user.melee_damage_lower, user.melee_damage_upper)
		var/obj/item/bodypart/affecting = get_bodypart(ran_zone(user.zone_selected))

		if(!affecting)
			affecting = get_bodypart(BODY_ZONE_CHEST)

		var/armor_block = run_armor_check(affecting, MELEE,"","",10)

		playsound(loc, 'sound/items/weapons/slice.ogg', 25, TRUE, -1)
		visible_message(span_danger("[user]Cortes em[src]!"), 						span_userdanger("[user]Corta em você!"), span_hear("Você ouve um som doentio de uma fatia!"), null, user)
		to_chat(user, span_danger("Você corta em[src]!"))
		log_combat(user, src, "attacked")

		if(!dismembering_strike(user, user.zone_selected)) //Dismemberment successful
			return TRUE

		apply_damage(damage, BRUTE, affecting, armor_block)
