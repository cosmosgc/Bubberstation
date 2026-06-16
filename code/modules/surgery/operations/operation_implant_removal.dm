/datum/surgery_operation/basic/implant_removal
	name = "implant removal"
	desc = "Tente encontrar e remover um implante de um paciente. Qualquer implante encontrado será destruído a menos que uma caixa de implante seja mantida ou próxima."
	operation_flags = OPERATION_NOTABLE
	implements = list(
		TOOL_HEMOSTAT = 1,
		TOOL_CROWBAR = 1.5,
		/obj/item/kitchen/fork = 2.85,
	)
	time = 6.4 SECONDS
	success_sound = 'sound/items/handling/surgery/hemostat1.ogg'
	all_surgery_states_required = SURGERY_SKIN_OPEN
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED

/datum/surgery_operation/basic/implant_removal/get_default_radial_image()
	return image('icons/obj/medical/syringe.dmi', "implantcase-b")

/datum/surgery_operation/basic/implant_removal/any_optional_strings()
	return ..() + list("have an implant case below or inhand to store removed implants")

/datum/surgery_operation/basic/implant_removal/on_preop(mob/living/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		patient,
		span_notice("Você procura por implantes em [patient]..."),
		span_notice("[surgeon] Procura por implantes em [patient]."),
		span_notice("[surgeon] Procura por algo em [patient]."),
	)
	if(LAZYLEN(patient.implants))
		display_pain(patient, "You feel a serious pain as [surgeon] digs around inside you!")

/datum/surgery_operation/basic/implant_removal/on_success(mob/living/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/obj/item/implant/implant = LAZYACCESS(patient.implants, 1)
	if(isnull(implant))
		display_results(
			surgeon,
			patient,
			span_warning("Você não encontra nenhum implante para remover [patient]."),
			span_warning("[surgeon] não encontra nenhum implante para remover de [patient]."),
			span_warning("[surgeon] não encontra nada para remover [patient]."),
		)
		return

	display_results(
		surgeon,
		patient,
		span_notice("Você remove com sucesso.[implant] De [patient]."),
		span_notice("[surgeon] com sucesso remove [implant] De [patient]!"),
		span_notice("[surgeon] com sucesso remove algo de [patient]!"),
	)
	display_pain(patient, "You can feel your [implant.name] pulled out of you!")
	implant.removed(patient)

	if(QDELETED(implant))
		return

	var/obj/item/implantcase/case = get_case(surgeon, patient)
	if(isnull(case))
		return

	case.imp = implant
	implant.forceMove(case)
	case.update_appearance()
	display_results(
		surgeon,
		patient,
		span_notice("Seu lugar.[implant] em [case]."),
		span_notice("[surgeon] Lugares [implant] em [case]."),
		span_notice("[surgeon] Coloca algo em [case]."),
	)

/datum/surgery_operation/basic/implant_removal/proc/get_case(mob/living/surgeon, mob/living/target)
	var/list/locations = list(
		surgeon.is_holding_item_of_type(/obj/item/implantcase),
		locate(/obj/item/implantcase) in surgeon.loc,
		locate(/obj/item/implantcase) in target.loc,
	)

	for(var/obj/item/implantcase/case in locations)
		if(!case.imp)
			return case

	return null
