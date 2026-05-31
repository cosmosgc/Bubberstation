/obj/item/organ/eyes/shadekin
	name = "shadekin eyes"
	desc = "Esses olhos são enormes, e se sentem quentes ao toque. O shadekin que está faltando estes provavelmente está se sentindo muito enjoado."
	eye_icon = 'modular_zubbers/icons/mob/human/human_face.dmi'
	eye_icon_state = "shadekin_eyes"
	icon_state = "eyes_moth"	//i'm too lazy to give them their own sprite
	flash_protect = FLASH_PROTECTION_SENSITIVE
	blink_animation = FALSE
	iris_overlay = null
	lighting_cutoff = LIGHTING_CUTOFF_MEDIUM

/obj/item/organ/eyes/vulpkanin
	name = "vulpkanin eyes"
	desc = "Esses olhos parecem hábeis em ver em ambientes de baixa luz, não que a vulpkanina que os falta possa ver qualquer coisa agora."

	flash_protect = FLASH_PROTECTION_SENSITIVE
	blink_animation = FALSE
	iris_overlay = null
	lighting_cutoff = LIGHTING_CUTOFF_LOW

/obj/item/organ/eyes/robotic/multitool_act(mob/living/user, obj/item/tool)
	. = ..()
	// Choose left and right eye color
	to_chat(user, span_notice("Mudando de cor dos olhos: pressionando 'Cancelar' ou fechando a janela retornará a cor atual do olho."))
	eye_color_left = tgui_color_picker(user, "Pick a new color", "Left Eye Color", eye_color_left)
	eye_color_right = tgui_color_picker(user, "Pick a new color", "Right Eye Color", eye_color_right)

/obj/item/organ/eyes/moth
	eye_icon_state = "motheyes_white"
/obj/item/organ/eyes/robotic/moth
	eye_icon_state = "motheyes_white"
/obj/item/organ/eyes/robotic/glow/moth
	eye_icon_state = "motheyes_white"
