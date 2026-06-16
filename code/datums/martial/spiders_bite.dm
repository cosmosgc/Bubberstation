/datum/martial_art/spiders_bite
	name = "Spider's Bite"
	id = MARTIALART_SPIDERSBITE
	help_verb = /mob/living/proc/spiders_bite_help
	grab_damage_modifier = 10
	grab_escape_chance_modifier = -20
	/// REF() to the last mob we kicked
	var/last_hit_ref
	/// Counts the number of sequential kicks the user has landed on a target
	var/last_hit_count = 0
	/// Reference to the tackling component applied
	var/datum/component/tackler/tackle_comp

/datum/martial_art/spiders_bite/activate_style(mob/living/new_holder)
	. = ..()
	RegisterSignal(new_holder, COMSIG_HUMAN_PUNCHED, PROC_REF(kick_disarm))
	tackle_comp = new_holder.AddComponent(/datum/component/tackler, 		stamina_cost = 20, 		base_knockdown = 0.2 SECONDS, 		range = 5, 		speed = 1.5, 		skill_mod = 6, 		min_distance = 1, 		silent_gain = TRUE, 	)

/datum/martial_art/spiders_bite/deactivate_style(mob/living/old_holder)
	. = ..()
	UnregisterSignal(old_holder, COMSIG_HUMAN_PUNCHED)
	QDEL_NULL(tackle_comp)

/datum/martial_art/spiders_bite/proc/kick_disarm(mob/living/source, mob/living/target, damage, attack_type, obj/item/bodypart/affecting, final_armor_block, kicking, limb_sharpness)
	SIGNAL_HANDLER

	if(!kicking)
		last_hit_ref = null
		return
	var/new_hit_ref = REF(target)
	if(last_hit_ref == new_hit_ref)
		last_hit_count++
	else
		last_hit_count = 1
		last_hit_ref = new_hit_ref

	if(!prob(33 * last_hit_count))
		return

	var/obj/item/weapon = target.get_active_held_item()
	if(isnull(weapon) || !target.dropItemToGround(weapon))
		return
	source.visible_message(
		span_warning("[source] Bate.[target]'s [weapon.name] Fora [target.p_their()] mãos com um chute!"),
		span_notice("Você canaliza o fluxo da gravidade e bate [target]'s [weapon.name] Fora [target.p_their()] mãos com um chute!"),
		span_hear("Você ouve um barulho, seguido por um barulho."),
	)

/datum/martial_art/spiders_bite/get_prefered_attacking_limb(mob/living/martial_artist, mob/living/target)
	if(!target.has_status_effect(/datum/status_effect/staggered))
		return null

	return IS_LEFT_INDEX(martial_artist.active_hand_index) ? BODY_ZONE_L_LEG : BODY_ZONE_R_LEG

/mob/living/proc/spiders_bite_help()
	set name = "Recall Teachings"
	set desc = "Remember the Spider Bite technique used by the Spider Clan."
	set category = "Spider's Bite"

	to_chat(usr, span_info("<b><i>Você recua para dentro e se lembra das técnicas do Clã Aranha...</i></b>\nLembre-se,<b>Muitas Aranhas Pernas</b>Ataques desarmados contra oponentes cambaleantes serão sempre chutes, garantindo maior precisão e dano.\nLembre-se,<b>Pule e suba.</b>Clicar com o botão direito no modo de lançamento fará um tackle que é muito menos provável que falhe.\nLembre-se,<b>Fluxo de gravidade</b>Os oponentes terão a chance de derrubar suas armas. A chance aumenta para cada chute sequencial.\nLembre-se,<b>Enrolar na Web</b>Sua captura será mais difícil de escapar."))
