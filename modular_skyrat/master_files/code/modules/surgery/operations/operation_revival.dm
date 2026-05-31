// DNR TRAIT - need this so that people don't just keep spamming the revival surgery; it runs success just bc the surgery steps are done
/datum/surgery_operation/basic/revival/on_failure(mob/living/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	if(HAS_TRAIT(patient, TRAIT_DNR))
		patient.visible_message(span_warning("...[patient.p_they()]Mentira.[patient.p_s()]Mesmo assim, não afetado. Outras tentativas são fúteis, paciente."))
		patient.adjust_organ_loss(ORGAN_SLOT_BRAIN, 50, 199) // MAD SCIENCE
	else
		return ..()
