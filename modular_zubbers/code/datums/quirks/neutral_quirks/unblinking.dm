/datum/quirk/unblinking
	name = "Unblinking"
	desc = "Por alguma razão, você não precisa piscar para manter seus olhos (ou aparelho visual equivalente) funcional."
	icon = FA_ICON_FACE_FLUSHED
	value = 0
	gain_text = span_danger("Você não sente mais a necessidade de piscar.")
	lose_text = span_notice("Você sente a necessidade de piscar novamente.")
	medical_record_text = "O paciente é incapaz de piscar."
	mob_trait = TRAIT_NO_EYELIDS //Also prevents eye shutting in knockout state and death.

/datum/quirk/unblinking/add(client/client_source)
	. = ..()
	var/obj/item/organ/eyes/eyes = quirk_holder.get_organ_slot(ORGAN_SLOT_EYES)
	if(!eyes)
		return

	eyes.blink_animation = FALSE

	// interrupt the animations
	if(eyes.eyelid_left)
		animate(eyes.eyelid_left, alpha = 0, time = 0)
	if(eyes.eyelid_right)
		animate(eyes.eyelid_right, alpha = 0, time = 0)

/datum/quirk/unblinking/remove()
	. = ..()
	var/obj/item/organ/eyes/eyes = quirk_holder.get_organ_slot(ORGAN_SLOT_EYES)
	if(!eyes)
		return

	eyes.blink_animation = TRUE
	quirk_holder.update_body()
