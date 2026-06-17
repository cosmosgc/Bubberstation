/mob/living/Login()
	. = ..()
	if(ckey)
		if(is_banned_from(ckey, BAN_PACIFICATION))
			ADD_TRAIT(src, TRAIT_PACIFISM, ROUNDSTART_TRAIT)

/mob/dead/observer/Login()
	. = ..()
	if(ckey)
		if(is_banned_from(ckey, BAN_DONOTREVIVE))
			to_chat(src, span_notice("Como você está proibido de reavivamento, você não pode voltar ao seu corpo."))
			can_reenter_corpse = FALSE

/proc/process_eorg_bans()
	for(var/mob/iterating_player in GLOB.mob_list)
		if(iterating_player.ckey && is_banned_from(iterating_player.ckey, BAN_EORG))
			new /obj/effect/particle_effect/sparks/quantum (get_turf(iterating_player))
			iterating_player.visible_message(span_notice("[iterating_player] is teleported back home, hopefully to an everloving family!"), span_userdanger("Como você está banido, você será deletado."))
			qdel(iterating_player)

