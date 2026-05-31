/obj/item/straight_razor
	name = "straight razor"
	desc = "Uma lâmina muito afiada, usada principalmente para barbear rostos..."
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "straight_razor"
	force = 12
	throw_speed = 3
	throw_range = 9
	w_class = WEIGHT_CLASS_TINY
	attack_verb_simple = list("cut", "stabbed", "chebbed")
	sharpness = SHARP_EDGED
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	wound_bonus = 10
	exposed_wound_bonus = 15
	tool_behaviour = TOOL_KNIFE
	// How long do we take to shave someone's facial hair?
	var/shaving_time = 10 SECONDS

/obj/item/straight_razor/proc/shave(mob/living/carbon/human/target_human)
	target_human.facial_hairstyle = "Shaved"
	target_human.update_body_parts()
	playsound(loc, 'sound/items/unsheath.ogg', 20, TRUE)

/obj/item/straight_razor/attack(mob/attacked_mob, mob/living/user)
	if(ishuman(attacked_mob))
		var/mob/living/carbon/human/target_human = attacked_mob
		var/location = user.zone_selected
		if(!(location in list(BODY_ZONE_PRECISE_MOUTH)) && !user.combat_mode)
			to_chat(user, span_warning("Pare, olhe para o que está segurando e pense em si mesmo.\"Deve ser usado no cabelo facial.\""))
			return
		if(location == BODY_ZONE_PRECISE_MOUTH && !target_human.get_bodypart(BODY_ZONE_HEAD))
			to_chat(user, span_warning("[target_human]Não tem cabeça!"))
			return
		if(location == BODY_ZONE_PRECISE_MOUTH)
			var/obj/item/bodypart/head/noggin = target_human.get_bodypart(BODY_ZONE_HEAD)
			if(!(noggin.head_flags & HEAD_FACIAL_HAIR))
				to_chat(user, span_warning("Não há pêlos faciais para barbear!"))
				return
			var/covering = target_human.is_mouth_covered()
			if(covering)
				to_chat(user, span_warning("[covering]Está no caminho!"))
				return
			if(target_human.facial_hairstyle == "Shaved")
				to_chat(user, span_warning("Já barbeado!"))
				return

			var/self_shaving = target_human == user // Shaving yourself?
			user.visible_message(span_notice("[user]Começa a se barbear.[self_shaving ? user.p_their() : "[target_human]'s"]Cabelo facial com[src]."), 				span_notice("Tire um momento para se barbear.[self_shaving ? "your" : "[target_human]'s" ]Cabelo facial com[src]..."))
			if(do_after(user, shaving_time, target = target_human))
				user.visible_message(span_notice("[user]Barba.[self_shaving ? user.p_their() : "[target_human]'s"]Cabelo facial limpo com[src]."), 					span_notice("Você termina de fazer a barba.[self_shaving ? "" : " [target_human]'s facial hair"]com[src]Rápido e limpo!"))
				shave(target_human)

		else
			..()
	else
		..()
