#define RSD_ATTEMPT_COOLDOWN 2 MINUTES

/obj/item/handheld_soulcatcher
	name = "\improper Evoker-type RSD"
	desc = "O Dispositivo de Simulação de Ressonância do Tipo Evoker é uma espécie de instrumento de captura de almas que foi designado para uso manual. Esses DSRs foram projetados com o campo médico em mente, uma ferramenta destinada a oferecer conforto aos temporariamente separados enquanto seus corpos estão sendo reparados, curados ou produzidos. O Evoker é essencialmente um NIF portátil muito especializado, ainda usando a mesma nanomáquina para o software e hardware. Este instrumento cuidadoso é capaz de hospedar um espaço virtual para um grande número de Engrams por uma quantidade essencialmente indefinida de tempo em uma variedade ilimitada de simulações, mesmo capaz de transferi-los de e para um NIF. No entanto, é a melhor prática médica para não lollygag."
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/devices.dmi'
	icon_state = "soulcatcher-device"
	inhand_icon_state = "electronic"
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	obj_flags = UNIQUE_RENAME
	/// What soulcatcher datum is associated with this item?
	var/datum/component/carrier/soulcatcher/linked_soulcatcher
	/// The cooldown for the RSD on scanning a body if the ghost refuses. This is here to prevent spamming.
	COOLDOWN_DECLARE(rsd_scan_cooldown)

/obj/item/handheld_soulcatcher/Initialize(mapload)
	. = ..()
	name += " #[rand(0, 999)]" // If it works for monkeys, it surely works for soulcatchers.
	SSpoints_of_interest.make_point_of_interest(src)

/obj/item/handheld_soulcatcher/attack_self(mob/user, modifiers)
	linked_soulcatcher.ui_interact(user)

/obj/item/handheld_soulcatcher/New(loc, ...)
	. = ..()
	linked_soulcatcher = AddComponent(/datum/component/carrier/soulcatcher)
	linked_soulcatcher.name = name

/obj/item/handheld_soulcatcher/Destroy(force)
	if(linked_soulcatcher)
		qdel(linked_soulcatcher)

	return ..()

/obj/item/handheld_soulcatcher/attack(mob/living/target_mob, mob/living/user, params)
	if(!target_mob)
		return ..()

	if(target_mob.GetComponent(/datum/component/previous_body))
		linked_soulcatcher.scan_body(target_mob, user)
		return TRUE

	if(!target_mob.mind)
		to_chat(user, span_warning("Você é incapaz de remover uma mente de um corpo vazio."))
		return FALSE

	if(!COOLDOWN_FINISHED(src, rsd_scan_cooldown))
		var/time_left = round((COOLDOWN_TIMELEFT(src, rsd_scan_cooldown)) / (1 MINUTES), 0.01)
		to_chat(user, span_warning("Você está atualmente incapaz de agarrar a alma de[target_mob]Por favor, espere.[time_left]minutos antes de tentar novamente."))
		return FALSE

	if(target_mob.stat == DEAD) //We can temporarily store souls of dead mobs.
		target_mob.ghostize(TRUE) //Incase they are staying in the body.
		var/mob/dead/observer/target_ghost = target_mob.get_ghost(TRUE, TRUE)
		if(!target_ghost)
			to_chat(user, span_warning("Você é incapaz de obter a alma de[target_mob]!"))
			return FALSE

		var/datum/carrier_room/soulcatcher/target_room = tgui_input_list(user, "Choose a room to send [target_mob]'s soul to.", name, linked_soulcatcher.carrier_rooms, timeout = 30 SECONDS)
		if(!target_room)
			return FALSE

		SEND_SOUND(target_ghost, 'sound/announcer/notice/notice2.ogg')
		window_flash(target_ghost.client)

		if(tgui_alert(target_ghost, "[user]Quer transferir-lo para[target_room]dentro de um caça-almas, você aceita?", name, list("Yes", "No"), 30 SECONDS, autofocus = FALSE) != "Yes")
			to_chat(user, span_warning("[target_mob]Não parece querer entrar."))
			COOLDOWN_START(src, rsd_scan_cooldown, RSD_ATTEMPT_COOLDOWN)
			return FALSE

		if(!target_room.add_soul_from_ghost(target_ghost))
			return FALSE

		if(!target_mob.GetComponent(/datum/component/previous_body))
			return FALSE

		var/turf/source_turf = get_turf(user)
		log_admin("[key_name(user)] used [src] to put [key_name(target_mob)]'s mind into a soulcatcher at [AREACOORD(source_turf)]")
		linked_soulcatcher.scan_body(target_mob, user)
		return TRUE

	var/datum/carrier_room/target_room = tgui_input_list(user, "Choose a room to send [target_mob]'s soul to.", name, linked_soulcatcher.carrier_rooms, timeout = 30 SECONDS)
	if(!target_room)
		return FALSE

	SEND_SOUND(target_mob, 'sound/announcer/notice/notice2.ogg')
	window_flash(target_mob.client)

	if((tgui_alert(target_mob, "Quer entrar?[target_room]? Isso irá removê-lo de seu corpo até que você saia.", name, list("Yes", "No"), 30 SECONDS, FALSE) != "Yes") || (tgui_alert(target_mob, "Tem certeza disso?", name, list("Yes", "No"), 30 SECONDS, FALSE) != "Yes"))
		COOLDOWN_START(src, rsd_scan_cooldown, RSD_ATTEMPT_COOLDOWN)
		to_chat(user, span_warning("[target_mob]Não parece querer entrar."))
		return FALSE

	if(!target_mob.mind)
		return FALSE

	target_room.add_soul_from_mind(target_mob.mind, FALSE)
	playsound(src, 'modular_skyrat/modules/modular_implants/sounds/default_good.ogg', 50, FALSE, ignore_walls = FALSE)
	visible_message(span_notice("[src]BIPS:[target_mob]A transferência mental está completa."))

	if(!target_mob.GetComponent(/datum/component/previous_body))
		return FALSE

	linked_soulcatcher.scan_body(target_mob, user)

	var/turf/source_turf = get_turf(user)
	log_admin("[key_name(user)] used [src] to put [key_name(target_mob)]'s mind into a soulcatcher while they were still alive at [AREACOORD(source_turf)]")

	return TRUE

/obj/item/handheld_soulcatcher/attack_secondary(mob/living/carbon/human/target_mob, mob/living/user, params)
	if(!istype(target_mob))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	var/obj/item/organ/brain/target_brain = target_mob.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!istype(target_brain))
		to_chat(user, span_warning("[target_mob]Falta um cérebro!"))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(!HAS_TRAIT(target_brain, TRAIT_RSD_COMPATIBLE))
		to_chat(user, span_warning("[target_mob]O cérebro não é compatível."))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(target_mob.mind || target_mob.ckey || GetComponent(/datum/component/previous_body))
		to_chat(user, span_warning("[target_mob]não é capaz de receber uma alma"))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	var/list/soul_list = list()
	for(var/datum/carrier_room/room as anything in linked_soulcatcher.carrier_rooms)
		for(var/mob/living/soulcatcher_soul/soul as anything in room.current_mobs)
			if(!istype(soul) || !soul.round_participant || soul.body_scan_needed)
				continue

			soul_list += soul

	if(!length(soul_list))
		to_chat(user, span_warning("Nenhuma alma pode ser transferida para[target_mob]."))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	var/mob/living/soulcatcher_soul/chosen_soul = tgui_input_list(user, "Choose a soul to transfer into the body", name, soul_list)
	if(!chosen_soul)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(chosen_soul.previous_body)
		var/mob/living/old_body = chosen_soul.previous_body.resolve()
		if(!old_body)
			return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

		SEND_SIGNAL(old_body, COMSIG_SOULCATCHER_CHECK_SOUL, FALSE)

	chosen_soul.mind.transfer_to(target_mob, TRUE)
	playsound(src, 'modular_skyrat/modules/modular_implants/sounds/default_good.ogg', 50, FALSE, ignore_walls = FALSE)
	visible_message(span_notice("[src]Transferência corporal completa."))
	log_admin("[src] was used by [user] to transfer [chosen_soul]'s soulcatcher soul to [target_mob].")

	qdel(chosen_soul)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

#undef RSD_ATTEMPT_COOLDOWN
