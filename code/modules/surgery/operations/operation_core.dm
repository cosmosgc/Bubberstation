/datum/surgery_operation/basic/core_removal
	name = "extract core"
	rnd_name = "Corectomy (Extract Core)" // source: i made it up
	desc = "Remova o núcleo de um lodo."
	implements = list(
		TOOL_HEMOSTAT = 1,
		TOOL_CROWBAR = 1,
	)
	time = 1.6 SECONDS
	operation_flags = OPERATION_IGNORE_CLOTHES | OPERATION_STANDING_ALLOWED
	any_surgery_states_required = ALL_SURGERY_SKIN_STATES
	required_biotype = NONE

/datum/surgery_operation/basic/core_removal/get_default_radial_image()
	return image(/mob/living/basic/slime)

/datum/surgery_operation/basic/core_removal/all_required_strings()
	return list("operate on a deceased slime") + ..()

/datum/surgery_operation/basic/core_removal/state_check(mob/living/patient)
	return isslime(patient) && patient.stat == DEAD

/datum/surgery_operation/basic/core_removal/on_preop(mob/living/basic/slime/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		patient,
		span_notice("Você começa a extrair [patient] O núcleo..."),
		span_notice("[surgeon] começa a extrair [patient] É o núcleo."),
		span_notice("[surgeon] começa a extrair [patient] É o núcleo."),
	)

/datum/surgery_operation/basic/core_removal/on_success(mob/living/basic/slime/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/core_count = patient.cores
	if(core_count && patient.try_extract_cores(count = core_count))
		display_results(
			surgeon,
			patient,
			span_notice("Você extrai com sucesso [core_count] O núcleo de [patient]."),
			span_notice("[surgeon] Com sucesso extrai [core_count] O núcleo de [patient]!"),
			span_notice("[surgeon] Com sucesso extrai [core_count] O núcleo de [patient]!"),
		)
	else
		to_chat(surgeon, span_warning("Não há mais núcleos.[patient]!"))
