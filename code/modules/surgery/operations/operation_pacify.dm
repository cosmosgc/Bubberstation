/datum/surgery_operation/organ/pacify
	name = "pacification"
	rnd_name = "Paxopsy (Pacification)"
	desc = "Remova tendências agressivas do cérebro de um paciente."
	rnd_desc = "Um procedimento cirúrgico que inibe permanentemente o centro de agressão do cérebro, fazendo o paciente não querer causar dano direto."
	operation_flags = OPERATION_MORBID | OPERATION_LOCKED | OPERATION_NOTABLE | OPERATION_NO_PATIENT_REQUIRED
	implements = list(
		TOOL_HEMOSTAT = 1,
		TOOL_SCREWDRIVER = 2.85,
		/obj/item/pen = 6.67,
	)
	time = 4 SECONDS
	preop_sound = 'sound/items/handling/surgery/hemostat1.ogg'
	success_sound = 'sound/items/handling/surgery/hemostat1.ogg'
	failure_sound = 'sound/items/handling/surgery/organ2.ogg'
	required_organ_flag = ORGAN_TYPE_FLAGS & ~ORGAN_ROBOTIC
	target_type = /obj/item/organ/brain
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_BONE_SAWED
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED

/datum/surgery_operation/organ/pacify/get_default_radial_image()
	return image(/atom/movable/screen/alert/status_effect/high::overlay_icon, /atom/movable/screen/alert/status_effect/high::overlay_state)

/datum/surgery_operation/organ/pacify/on_preop(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você começa a pacificar [FORMAT_ORGAN_OWNER(organ)]..."),
		span_notice("[surgeon] Começa a consertar.[FORMAT_ORGAN_OWNER(organ)] É o cérebro."),
		span_notice("[surgeon] Começa a operar em [FORMAT_ORGAN_OWNER(organ)] É o cérebro."),
	)
	display_pain(organ.owner, "Your head pounds with unimaginable pain!")

/datum/surgery_operation/organ/pacify/on_success(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você consegue pacificar.[FORMAT_ORGAN_OWNER(organ)]."),
		span_notice("[surgeon] Conserta com sucesso.[FORMAT_ORGAN_OWNER(organ)]!"),
		span_notice("[surgeon] completa a cirurgia em [FORMAT_ORGAN_OWNER(organ)] É o cérebro."),
	)
	display_pain(organ.owner, "Your head pounds... the concept of violence flashes in your head, and nearly makes you hurl!")
	organ.gain_trauma(/datum/brain_trauma/severe/pacifism, TRAUMA_RESILIENCE_LOBOTOMY)

/datum/surgery_operation/organ/pacify/on_failure(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você estraga tudo, religando [FORMAT_ORGAN_OWNER(organ)] O cérebro está errado..."),
		span_warning("[surgeon] Estraga tudo, causando danos cerebrais!"),
		span_notice("[surgeon] completa a cirurgia em [FORMAT_ORGAN_OWNER(organ)] É o cérebro."),
	)
	display_pain(organ.owner, "Your head pounds, and it feels like it's getting worse!")
	organ.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)

/datum/surgery_operation/organ/pacify/mechanic
	name = "delete aggression programming"
	rnd_name = "Aggression Suppression Programming (Pacification)"
	rnd_desc = "Instale malware que inibe permanentemente a programação de agressão da rede neural do paciente, fazendo o paciente não querer causar danos diretos."
	implements = list(
		TOOL_MULTITOOL = 1,
		TOOL_HEMOSTAT = 2.85,
		TOOL_SCREWDRIVER = 2.85,
		/obj/item/pen = 6.67,
	)
	preop_sound = 'sound/items/taperecorder/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder/taperecorder_close.ogg'
	failure_sound = null
	required_organ_flag = ORGAN_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
