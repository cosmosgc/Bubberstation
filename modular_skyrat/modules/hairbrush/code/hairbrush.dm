// Hairbrushes

/obj/item/hairbrush
	name = "hairbrush"
	desc = "Um pequeno pincel circular com uma aderência ergonômica para uma aplicação eficiente."
	icon = 'modular_skyrat/modules/hairbrush/icons/hairbrush.dmi'
	icon_state = "brush"
	inhand_icon_state = "inhand"
	lefthand_file = 'modular_skyrat/modules/hairbrush/icons/inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/hairbrush/icons/inhand_right.dmi'
	w_class = WEIGHT_CLASS_TINY
	var/brush_speed = 3 SECONDS

/obj/item/hairbrush/attack(mob/target, mob/user)
	if(target.stat == DEAD)
		to_chat(usr, span_warning("Não tem muito sentido escovar alguém que não pode apreciar!"))
		return
	brush(target, user)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/// Brushes someone, giving them a small mood boost
/obj/item/hairbrush/proc/brush(mob/living/target, mob/user)
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		var/obj/item/bodypart/head = human_target.get_bodypart(BODY_ZONE_HEAD)

		// Don't brush if you can't reach their head or cancel the action
		if(!head)
			to_chat(user, span_warning("[human_target]Não tem cabeça!"))
			return
		if(human_target.is_mouth_covered(ITEM_SLOT_HEAD))
			to_chat(user, span_warning("Você não pode escovar[human_target]O cabelo enquanto[human_target.p_their()]A cabeça está coberta!"))
			return
		if(!do_after(user, brush_speed, human_target))
			return

		// Do 1 brute to their head if they're bald. Should've been more careful.
		if(human_target.hairstyle == "Bald" || human_target.hairstyle == "Skinhead" && is_species(human_target, /datum/species/human)) //It can be assumed most anthros have hair on them!
			human_target.visible_message(span_warning("[usr]Arranha as cerdas desconfortavelmente[human_target]É o couro cabeludo."), span_warning("Você raspa as cerdas desconfortavelmente[human_target]É o couro cabeludo."))
			head.receive_damage(1)
			return

		// Brush their hair
		if(human_target == user)
			human_target.visible_message(span_notice("[usr]Pincéis[usr.p_their()]Cabelo!"), span_notice("Você escova o cabelo."))
			human_target.add_mood_event("brushed", /datum/mood_event/brushed/self)
		else
			user.visible_message(span_notice("[usr]Pincéis[human_target]O cabelo!"), span_notice("Você escova.[human_target]É o cabelo."), ignored_mobs=list(human_target))
			human_target.show_message(span_notice("[usr]Escova o cabelo!"), MSG_VISUAL)
			human_target.add_mood_event("brushed", /datum/mood_event/brushed, user)

	else if(istype(target, /mob/living/basic/pet))
		if(!do_after(usr, brush_speed, target))
			return
		to_chat(user, span_notice("[target]Fecha.[target.p_their()]olhos enquanto você escova[target.p_them()]!"))
		var/mob/living/living_user = user
		if(istype(living_user))
			living_user.add_mood_event("brushed", /datum/mood_event/brushed/pet, target)
