/obj/item/scissors
	name = "barber's scissors"
	desc = "Alguns dizem que um barbeiro melhor ferramenta é sua navalha elétrica, que não é o caso. São usados para cortar cabelo de forma profissional!"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "scissors"
	w_class = WEIGHT_CLASS_TINY
	sharpness = SHARP_EDGED
	// How long does it take to change someone's hairstyle?
	var/haircut_duration = 1 MINUTES
	// How long does it take to change someone's facial hair style?
	var/facial_haircut_duration = 20 SECONDS

/obj/item/scissors/attack(mob/living/attacked_mob, mob/living/user, params)
	if(!ishuman(attacked_mob))
		return

	var/mob/living/carbon/human/target_human = attacked_mob

	var/location = user.zone_selected
	if(!(location in list(BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_HEAD)) && !user.combat_mode)
		to_chat(user, span_warning("Pare, olhe para o que está segurando e pense em si mesmo.\"Deve ser usado no cabelo ou no cabelo facial.\""))
		return

	if(target_human.hairstyle == "Bald" && target_human.facial_hairstyle == "Shaved")
		balloon_alert(user, "Que cabelo? Eles não têm nenhum!")
		return

	if(user.zone_selected != BODY_ZONE_HEAD)
		return ..()

	var/selected_part = tgui_alert(user, "Por favor, selecione qual parte de[target_human]Você gostaria de esculpir!", "It's sculpting time!", list("Hair", "Facial Hair", "Cancel"))

	if(!selected_part || selected_part == "Cancel")
		return

	if(selected_part == "Hair")
		if(!target_human.hairstyle == "Bald" && target_human.head)
			balloon_alert(user, "Eles não têm cabelo para cortar!")
			return

		var/hair_id = tgui_input_list(user, "Please select what hairstyle you'd like to sculpt!", "Select masterpiece", SSaccessories.hairstyles_list)
		if(!hair_id)
			return

		if(hair_id == "Bald")
			to_chat(target_human, span_danger("[user]Parece estar cortando todo o seu cabelo!"))

		to_chat(user, span_notice("Você começa a esculpir magistralmente[target_human]O cabelo!"))

		playsound(target_human, 'modular_skyrat/modules/salon/sound/haircut.ogg', 100)

		if(do_after(user, haircut_duration, target_human))
			target_human.set_hairstyle(hair_id, update = TRUE)
			user.visible_message(span_notice("[user]Cortes bem sucedidos[target_human]O cabelo!"), span_notice("Você cortou com sucesso.[target_human]O cabelo!"))
			new /obj/effect/decal/cleanable/hair(get_turf(src))
	else
		if(!target_human.facial_hairstyle == "Shaved" && target_human.wear_mask)
			balloon_alert(user, "Eles não têm pelos faciais para cortar!")
			return

		var/facial_hair_id = tgui_input_list(user, "Please select what facial hairstyle you'd like to sculpt!", "Select masterpiece", SSaccessories.facial_hairstyles_list)
		if(!facial_hair_id)
			return

		if(facial_hair_id == "Shaved")
			to_chat(target_human, span_danger("[user]Parece estar cortando todo o seu cabelo facial!"))

		to_chat(user, "Você começa a esculpir magistralmente[target_human]O cabelo facial!")

		playsound(target_human, 'modular_skyrat/modules/salon/sound/haircut.ogg', 100)

		if(do_after(user, facial_haircut_duration, target_human))
			target_human.set_facial_hairstyle(facial_hair_id, update = TRUE)
			user.visible_message(span_notice("[user]Cortes bem sucedidos[target_human]O cabelo facial!"), span_notice("Você cortou com sucesso.[target_human]O cabelo facial!"))
			new /obj/effect/decal/cleanable/hair(get_turf(src))
