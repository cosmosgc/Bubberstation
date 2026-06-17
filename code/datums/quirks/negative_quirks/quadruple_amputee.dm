/datum/quirk/quadruple_amputee
	name = "Quadruple Amputee"
	desc = "Oops! Todos os Próteses! Devido a uma punição cósmica cruel, todos os seus membros foram substituídos por próteses excedentes."
	icon = "tg-prosthetic-full"
	value = -6
	medical_record_text = "Durante o exame físico, o paciente tinha todos os membros protéticos de baixo orçamento."
	hardcore_value = 6
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_CHANGES_APPEARANCE
	mail_goodies = list(/obj/item/weldingtool/mini, /obj/item/stack/cable_coil/five)

/datum/quirk/quadruple_amputee/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.del_and_replace_bodypart(new /obj/item/bodypart/arm/left/robot/surplus, special = TRUE)
	human_holder.del_and_replace_bodypart(new /obj/item/bodypart/arm/right/robot/surplus, special = TRUE)
	human_holder.del_and_replace_bodypart(new /obj/item/bodypart/leg/left/robot/surplus, special = TRUE)
	human_holder.del_and_replace_bodypart(new /obj/item/bodypart/leg/right/robot/surplus, special = TRUE)

/datum/quirk/quadruple_amputee/post_add()
	to_chat(quirk_holder, span_bolddanger("Todos os seus membros foram substituídos por próteses excedentes. Eles são frágeis e facilmente se separarão sob coação.\
Além disso, você precisa usar uma ferramenta de solda e cabos para repará-los, em vez de suturas e malha regenerativa."))

/datum/quirk/quadruple_amputee/remove()
	if(QDELING(quirk_holder))
		return

	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.reset_to_original_bodypart(BODY_ZONE_L_ARM)
	human_holder.reset_to_original_bodypart(BODY_ZONE_R_ARM)
	human_holder.reset_to_original_bodypart(BODY_ZONE_L_LEG)
	human_holder.reset_to_original_bodypart(BODY_ZONE_R_LEG)
