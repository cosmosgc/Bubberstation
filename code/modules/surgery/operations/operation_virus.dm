/datum/surgery_operation/basic/viral_bonding
	name = "viral bonding"
	rnd_name = "Viroplasty (Viral Bonding)"
	desc = "Forçar uma relação simbiótica entre um paciente e um vírus que está infectado."
	rnd_desc = "Um procedimento cirúrgico que força uma relação simbiótica entre um vírus e seu hospedeiro. O paciente será imune aos efeitos do vírus, mas o carregará e espalhará para outros."
	implements = list(
		TOOL_CAUTERY = 1,
		TOOL_WELDER = 2,
		/obj/item = 3.33,
	)
	time = 10 SECONDS
	preop_sound = 'sound/items/handling/surgery/cautery1.ogg'
	success_sound = 'sound/items/handling/surgery/cautery2.ogg'
	operation_flags = OPERATION_MORBID | OPERATION_LOCKED | OPERATION_NOTABLE
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_ORGANS_CUT
	var/list/required_chems = list(
		/datum/reagent/medicine/spaceacillin,
		/datum/reagent/consumable/virus_food,
		/datum/reagent/toxin/formaldehyde,
	)

/datum/surgery_operation/basic/viral_bonding/get_any_tool()
	return "Any heat source"

/datum/surgery_operation/basic/viral_bonding/all_required_strings()
	. = ..()
	. += "the patient must have a virus to bond"
	for(var/datum/reagent/chem as anything in required_chems)
		. += "the patient must be dosed with >=1u [chem::name]"

/datum/surgery_operation/basic/viral_bonding/get_default_radial_image()
	return image(/obj/item/clothing/mask/surgical)

/datum/surgery_operation/basic/viral_bonding/state_check(mob/living/patient)
	for(var/chem in required_chems)
		if(patient.reagents?.get_reagent_amount(chem) < 1)
			return FALSE
	for(var/datum/disease/infected_disease as anything in patient.diseases)
		if(infected_disease.severity != DISEASE_SEVERITY_UNCURABLE)
			return TRUE
	return FALSE

/datum/surgery_operation/basic/viral_bonding/tool_check(obj/item/tool)
	return tool.get_temperature() >= FIRE_MINIMUM_TEMPERATURE_TO_EXIST

/datum/surgery_operation/basic/viral_bonding/on_preop(mob/living/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		patient,
		span_notice("Você começa a aquecer.[patient]É medula óssea com[tool]..."),
		span_notice("[surgeon]Começa o aquecimento.[patient]É medula óssea com[tool]..."),
		span_notice("[surgeon]Começa a aquecer alguma coisa.[patient]'s peito com[tool]..."),
	)
	display_pain(patient, "You feel a searing heat spread through your chest!")

/datum/surgery_operation/basic/viral_bonding/on_success(mob/living/patient, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		patient,
		span_notice("[patient]A medula óssea começa a pulsar lentamente. A ligação viral está completa."),
		span_notice("[patient]A medula óssea começa a pulsar lentamente."),
		span_notice("[surgeon]Termina a operação."),
	)
	display_pain(patient, "You feel a faint throbbing in your chest.")
	for(var/datum/disease/infected_disease as anything in patient.diseases)
		if(infected_disease.severity != DISEASE_SEVERITY_UNCURABLE) //no curing quirks, sweaty
			infected_disease.carrier = TRUE
	return TRUE
