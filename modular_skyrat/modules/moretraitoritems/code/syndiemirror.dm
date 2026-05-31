/obj/item/hhmirror/syndie
	name = "handheld mirror"
	desc = "Um espelho portátil que permite mudar sua aparência. Lembra dos velhos tempos por alguma razão..."
	icon = 'modular_skyrat/master_files/icons/obj/hhmirror.dmi'
	icon_state = "hhmirror"
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "Um espelho fabricado pelo Sindicato contendo nanites de barbeiro que pode alterar seu cabelo. Mire na cabeça e use-a em si mesmo para ativar os nanites."
	w_class = WEIGHT_CLASS_TINY
	// How long does it take to change someone's hairstyle?
	var/haircut_duration = 1 SECONDS
	// How long does it take to change someone's facial hair style?
	var/facial_haircut_duration = 1 SECONDS


/obj/item/hhmirror/syndie/attack(mob/living/attacked_mob, mob/living/user, params)
	if(!ishuman(attacked_mob))
		return

	var/mob/living/carbon/human/target_human = attacked_mob

	var/location = user.zone_selected
	if(!(location in list(BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_HEAD)) && !user.combat_mode)
		balloon_alert(user, "Só funciona na sua cabeça!")
		return

	if(user.zone_selected != BODY_ZONE_HEAD)
		return ..()

	var/selected_part = tgui_alert(user, "Por favor, selecione qual parte de[target_human]Você gostaria de esculpir!", "It's sculpting time!", list("Hair", "Facial Hair", "Cancel"))

	if(!selected_part || selected_part == "Cancel")
		return

	if(selected_part == "Hair")

		var/hair_id = tgui_input_list(user, "Please select what hairstyle you'd like to sculpt!", "Select masterpiece", SSaccessories.hairstyles_list)
		if(!hair_id)
			return

		if(hair_id == "Bald")
			to_chat(target_human, span_danger("Nanitas parecem estar desintegrando todo seu cabelo!"))

		to_chat(user, span_notice("Nanitas começam a se reformar.[target_human]O cabelo!"))


		if(do_after(user, haircut_duration, target_human))
			target_human.set_hairstyle(hair_id, update = TRUE)
			user.visible_message(span_notice("[target_human]O cabelo muda!"), span_notice("Os nanites alteram com sucesso.[target_human]O cabelo!"))
	else
		var/facial_hair_id = tgui_input_list(user, "Please select what facial hairstyle you'd like to sculpt!", "Select masterpiece", SSaccessories.facial_hairstyles_list)
		if(!facial_hair_id)
			return

		if(facial_hair_id == "Shaved")
			to_chat(target_human, span_danger("Nanitas parecem estar desintegrando seus cabelos faciais!"))

		to_chat(user, "Nanitas começam a se reformar.[target_human]O cabelo facial!")

		if(do_after(user, facial_haircut_duration, target_human))
			target_human.set_facial_hairstyle(facial_hair_id, update = TRUE)
			user.visible_message(span_notice("[target_human]O cabelo facial muda!"), span_notice("Os nanites alteram com sucesso.[target_human]O cabelo facial!"))

/obj/item/storage/box/syndie_kit/chameleon/PopulateContents()
	. = ..()
	new /obj/item/hhmirror/syndie(src)
	new /obj/item/dyespray(src)

