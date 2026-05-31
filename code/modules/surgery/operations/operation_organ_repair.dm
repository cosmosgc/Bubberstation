/// Repairing specific organs
/datum/surgery_operation/organ/repair
	abstract_type = /datum/surgery_operation/organ/repair
	name = "repair organ"
	desc = "Conserte o órgão danificado de um paciente."
	required_organ_flag = ORGAN_TYPE_FLAGS & ~ORGAN_ROBOTIC
	operation_flags = OPERATION_AFFECTS_MOOD | OPERATION_NOTABLE | OPERATION_NO_PATIENT_REQUIRED
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_ORGANS_CUT|SURGERY_BONE_SAWED
	/// What % damage do we heal the organ to on success
	/// Note that 0% damage = 100% health
	var/heal_to_percent = 0.6
	/// What % damage do we apply to the organ on failure
	var/failure_damage_percent = 0.2
	/// If TRUE, an organ can be repaired multiple times
	var/repeatable = FALSE

/datum/surgery_operation/organ/repair/New()
	. = ..()
	if(operation_flags & OPERATION_LOOPING)
		repeatable = TRUE // if it's looping it would necessitate being repeatable
	if(!repeatable)
		desc += " This procedure can only be performed once per organ."

/datum/surgery_operation/organ/repair/state_check(obj/item/organ/organ)
	if(organ.damage < (organ.maxHealth * heal_to_percent) || (!repeatable && HAS_TRAIT(organ, TRAIT_ORGAN_OPERATED_ON)))
		return FALSE // conditionally available so we don't spam the radial with useless options, alas
	return TRUE

/datum/surgery_operation/organ/repair/all_required_strings()
	. = ..()
	if(!repeatable)
		. += "the organ must be moderately damaged"

/datum/surgery_operation/organ/repair/all_blocked_strings()
	. = ..()
	if(!repeatable)
		. += "the organ must not have been surgically repaired prior"

/datum/surgery_operation/organ/repair/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	organ.set_organ_damage(organ.maxHealth * heal_to_percent)
	organ.organ_flags &= ~ORGAN_EMP
	ADD_TRAIT(organ, TRAIT_ORGAN_OPERATED_ON, TRAIT_GENERIC)

/datum/surgery_operation/organ/repair/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	organ.apply_organ_damage(organ.maxHealth * failure_damage_percent)

/datum/surgery_operation/organ/repair/lobectomy
	name = "excise damaged lung lobe"
	rnd_name = "Lobectomy (Lung Surgery)"
	desc = "Faça reparos no pulmão danificado de um paciente, excisando o lobo mais danificado."
	implements = list(
		TOOL_SCALPEL = 1.05,
		/obj/item/melee/energy/sword = 1.5,
		/obj/item/knife = 2.25,
		/obj/item/shard = 2.85,
	)
	time = 4.2 SECONDS
	preop_sound = 'sound/items/handling/surgery/scalpel1.ogg'
	success_sound = 'sound/items/handling/surgery/organ1.ogg'
	failure_sound = 'sound/items/handling/surgery/organ2.ogg'
	target_type = /obj/item/organ/lungs
	failure_damage_percent = 0.1

/datum/surgery_operation/organ/repair/lobectomy/on_preop(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você começa a fazer uma incisão em[FORMAT_ORGAN_OWNER(organ)]Os pulmões..."),
		span_notice("[surgeon]começa a fazer uma incisão em[FORMAT_ORGAN_OWNER(organ)]."),
		span_notice("[surgeon]começa a fazer uma incisão em[FORMAT_ORGAN_OWNER(organ)]."),
	)
	display_pain(organ.owner, "You feel a stabbing pain in your chest!")

/datum/surgery_operation/organ/repair/lobectomy/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você excisou com sucesso.[FORMAT_ORGAN_OWNER(organ)]É o lobo mais danificado."),
		span_notice("[surgeon]Com sucesso excisos[FORMAT_ORGAN_OWNER(organ)]É o lobo mais danificado."),
		span_notice("[surgeon]Com sucesso excisos[FORMAT_ORGAN_OWNER(organ)]É o lobo mais danificado."),
	)

/datum/surgery_operation/organ/repair/lobectomy/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	organ.owner?.losebreath += 4
	display_results(
		surgeon,
		organ.owner,
		span_warning("Você estraga tudo, falha em extirpar[FORMAT_ORGAN_OWNER(organ)]lóbulo danificado!"),
		span_warning("[surgeon]Estraga tudo!"),
		span_warning("[surgeon]Estraga tudo!"),
	)
	display_pain(organ.owner, "You feel a sharp stab in your chest; the wind is knocked out of you and it hurts to catch your breath!")

/datum/surgery_operation/organ/repair/lobectomy/mechanic
	name = "perform maintenance"
	rnd_name = "Air Filtration Diagnostic (Lung Surgery)"
	implements = list(
		TOOL_WRENCH = 1.05,
		TOOL_SCALPEL = 1.05,
		/obj/item/melee/energy/sword = 1.5,
		/obj/item/knife = 2.25,
		/obj/item/shard = 2.85,
	)
	preop_sound = 'sound/items/tools/ratchet.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'
	required_organ_flag = ORGAN_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/organ/repair/hepatectomy
	name = "remove damaged liver section"
	rnd_name = "Hepatectomy (Liver Surgery)"
	desc = "Faça reparos no fígado danificado de um paciente removendo a seção mais danificada."
	implements = list(
		TOOL_SCALPEL = 1.05,
		/obj/item/melee/energy/sword = 1.5,
		/obj/item/knife = 2.25,
		/obj/item/shard = 2.85,
	)
	time = 5.2 SECONDS
	preop_sound = 'sound/items/handling/surgery/scalpel1.ogg'
	success_sound = 'sound/items/handling/surgery/organ1.ogg'
	failure_sound = 'sound/items/handling/surgery/organ2.ogg'
	target_type = /obj/item/organ/liver
	heal_to_percent = 0.1
	failure_damage_percent = 0.15

/datum/surgery_operation/organ/repair/hepatectomy/on_preop(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você começa a cortar um pedaço danificado de[FORMAT_ORGAN_OWNER(organ)]Fígado..."),
		span_notice("[surgeon]começa a fazer uma incisão em[FORMAT_ORGAN_OWNER(organ)]."),
		span_notice("[surgeon]começa a fazer uma incisão em[FORMAT_ORGAN_OWNER(organ)]."),
	)
	display_pain(organ.owner, "Your abdomen burns in horrific stabbing pain!")

/datum/surgery_operation/organ/repair/hepatectomy/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você removeu com sucesso a parte danificada de[FORMAT_ORGAN_OWNER(organ)]Fígado."),
		span_notice("[surgeon]Com sucesso, remova uma parte danificada de[FORMAT_ORGAN_OWNER(organ)]Fígado."),
		span_notice("[surgeon]Com sucesso, remova uma parte danificada de[FORMAT_ORGAN_OWNER(organ)]Fígado."),
	)
	display_pain(organ.owner, "The pain receeds slightly!")

/datum/surgery_operation/organ/repair/hepatectomy/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_warning("Você cortou a parte errada de[FORMAT_ORGAN_OWNER(organ)]Fígado!"),
		span_warning("[surgeon]Corta a parte errada de[FORMAT_ORGAN_OWNER(organ)]Fígado!"),
		span_warning("[surgeon]Corta a parte errada de[FORMAT_ORGAN_OWNER(organ)]Fígado!"),
	)
	display_pain(organ.owner, "The pain in your abdomen intensifies!")

/datum/surgery_operation/organ/repair/hepatectomy/mechanic
	name = "perform maintenance"
	rnd_name = "Impurity Management System Diagnostic (Liver Surgery)"
	implements = list(
		TOOL_WRENCH = 1.05,
		TOOL_SCALPEL = 1.05,
		/obj/item/melee/energy/sword = 1.5,
		/obj/item/knife = 2.25,
		/obj/item/shard = 2.85,
	)
	preop_sound = 'sound/items/tools/ratchet.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'
	required_organ_flag = ORGAN_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/organ/repair/coronary_bypass
	name = "graft coronary bypass"
	rnd_name = "Coronary Artery Bypass Graft (Heart Surgery)"
	desc = "Enxerte um bypass no coração de um paciente danificado para restaurar o fluxo sanguíneo."
	implements = list(
		TOOL_HEMOSTAT = 1.05,
		TOOL_WIRECUTTER = 2.85,
		/obj/item/stack/package_wrap = 6.67,
		/obj/item/stack/cable_coil = 2,
	)
	time = 9 SECONDS
	preop_sound = 'sound/items/handling/surgery/hemostat1.ogg'
	success_sound = 'sound/items/handling/surgery/hemostat1.ogg'
	failure_sound = 'sound/items/handling/surgery/organ2.ogg'
	target_type = /obj/item/organ/heart

/datum/surgery_operation/organ/repair/coronary_bypass/on_preop(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você começa a enxertar um bypass[FORMAT_ORGAN_OWNER(organ)]O coração..."),
		span_notice("[surgeon]Começa a enxertar um bypass em[FORMAT_ORGAN_OWNER(organ)]O coração."),
		span_notice("[surgeon]Começa a enxertar um bypass em[FORMAT_ORGAN_OWNER(organ)]O coração."),
	)
	display_pain(organ.owner, "The pain in your chest is unbearable! You can barely take it anymore!")

/datum/surgery_operation/organ/repair/coronary_bypass/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você enxertou com sucesso um bypass em[FORMAT_ORGAN_OWNER(organ)]O coração."),
		span_notice("[surgeon]Com sucesso enxerta um bypass em[FORMAT_ORGAN_OWNER(organ)]O coração."),
		span_notice("[surgeon]Com sucesso enxerta um bypass em[FORMAT_ORGAN_OWNER(organ)]O coração."),
	)
	display_pain(organ.owner, "The pain in your chest throbs, but your heart feels better than ever!")

/datum/surgery_operation/organ/repair/coronary_bypass/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	organ.bodypart_owner?.adjustBleedStacks(30)
	var/blood_name = LOWER_TEXT(organ.owner?.get_bloodtype()?.get_blood_name()) || "blood"
	display_results(
		surgeon,
		organ.owner,
		span_warning("Você estraga a fixação do enxerto, e ele arranca, rasgando parte do coração!"),
		span_warning("[surgeon]Estraga tudo, causando[blood_name]Para sair de[FORMAT_ORGAN_OWNER(organ)]É peito profusamente!"),
		span_warning("[surgeon]Estraga tudo, causando[blood_name]Para sair de[FORMAT_ORGAN_OWNER(organ)]É peito profusamente!"),
	)
	display_pain(organ.owner, "Your chest burns; you feel like you're going insane!")

/datum/surgery_operation/organ/repair/coronary_bypass/mechanic
	name = "access engine internals"
	rnd_name = "Engine Diagnostic (Heart Surgery)"
	implements = list(
		TOOL_CROWBAR = 1.05,
		TOOL_SCALPEL = 1.05,
		/obj/item/melee/energy/sword = 1.5,
		/obj/item/knife = 2.25,
		/obj/item/shard = 2.85,
	)
	preop_sound = 'sound/items/tools/ratchet.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'
	required_organ_flag = ORGAN_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/organ/repair/gastrectomy
	name = "remove damaged stomach section"
	rnd_name = "Gastrectomy (Stomach Surgery)"
	desc = "Faça reparos no estômago de um paciente removendo uma seção danificada."
	implements = list(
		TOOL_SCALPEL = 1.05,
		/obj/item/melee/energy/sword = 1.5,
		/obj/item/knife = 2.25,
		/obj/item/shard = 2.85,
		/obj/item = 4,
	)
	time = 5.2 SECONDS
	preop_sound = 'sound/items/handling/surgery/scalpel1.ogg'
	success_sound = 'sound/items/handling/surgery/organ1.ogg'
	failure_sound = 'sound/items/handling/surgery/organ2.ogg'
	target_type = /obj/item/organ/stomach
	heal_to_percent = 0.2
	failure_damage_percent = 0.15

/datum/surgery_operation/organ/repair/gastrectomy/get_any_tool()
	return "Any sharp edged item"

/datum/surgery_operation/organ/repair/gastrectomy/tool_check(obj/item/tool)
	// Require edged sharpness OR a tool behavior match
	return ((tool.get_sharpness() & SHARP_EDGED) || implements[tool.tool_behaviour])

/datum/surgery_operation/organ/repair/gastrectomy/on_preop(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você começa a cortar um pedaço danificado de[FORMAT_ORGAN_OWNER(organ)]O estômago..."),
		span_notice("[surgeon]começa a fazer uma incisão em[FORMAT_ORGAN_OWNER(organ)]."),
		span_notice("[surgeon]começa a fazer uma incisão em[FORMAT_ORGAN_OWNER(organ)]."),
	)
	display_pain(organ.owner, "You feel a horrible stab in your gut!")

/datum/surgery_operation/organ/repair/gastrectomy/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você removeu com sucesso a parte danificada de[FORMAT_ORGAN_OWNER(organ)]Estômago."),
		span_notice("[surgeon]Com sucesso, remova uma parte danificada de[FORMAT_ORGAN_OWNER(organ)]Estômago."),
		span_notice("[surgeon]Com sucesso, remova uma parte danificada de[FORMAT_ORGAN_OWNER(organ)]Estômago."),
	)
	display_pain(organ.owner, "The pain in your gut receeds slightly!")

/datum/surgery_operation/organ/repair/gastrectomy/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_warning("Você cortou a parte errada de[FORMAT_ORGAN_OWNER(organ)]O estômago!"),
		span_warning("[surgeon]Corta a parte errada de[FORMAT_ORGAN_OWNER(organ)]O estômago!"),
		span_warning("[surgeon]Corta a parte errada de[FORMAT_ORGAN_OWNER(organ)]O estômago!"),
	)
	display_pain(organ.owner, "The pain in your gut intensifies!")

/datum/surgery_operation/organ/repair/gastrectomy/mechanic
	name = "perform maintenance"
	rnd_name = "Nutrient Processing System Diagnostic (Stomach Surgery)"
	implements = list(
		TOOL_WRENCH = 1.05,
		TOOL_SCALPEL = 1.05,
		/obj/item/melee/energy/sword = 1.5,
		/obj/item/knife = 2.25,
		/obj/item/shard = 2.85,
		/obj/item = 4,
	)
	preop_sound = 'sound/items/tools/ratchet.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'
	required_organ_flag = ORGAN_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/organ/repair/ears
	name = "ear surgery"
	rnd_name = "Ototomy (Ear surgery)" // source: i made it up
	desc = "Reparar as orelhas danificadas do paciente para restaurar a audição."
	operation_flags = parent_type::operation_flags & ~OPERATION_AFFECTS_MOOD
	implements = list(
		TOOL_HEMOSTAT = 1.05,
		TOOL_SCREWDRIVER = 2.25,
		/obj/item/pen = 4,
	)
	target_type = /obj/item/organ/ears
	time = 6.4 SECONDS
	heal_to_percent = 0
	repeatable = TRUE
	all_surgery_states_required = SURGERY_SKIN_OPEN
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED

/datum/surgery_operation/organ/repair/ears/all_blocked_strings()
	return ..() + list("if the limb has bones, they must be intact")

/datum/surgery_operation/organ/repair/ears/state_check(obj/item/organ/ears/organ)
	// If bones are sawed, prevent the operation (unless we're operating on a limb with no bones)
	if(LIMB_HAS_ANY_SURGERY_STATE(organ.bodypart_owner, SURGERY_BONE_SAWED|SURGERY_BONE_DRILLED) && LIMB_HAS_BONES(organ.bodypart_owner))
		return FALSE
	return TRUE // always available so you can intentionally fail it

/datum/surgery_operation/organ/repair/ears/on_preop(obj/item/organ/ears/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você começa a consertar[FORMAT_ORGAN_OWNER(organ)]Como Orelhas..."),
		span_notice("[surgeon]Começa a consertar.[FORMAT_ORGAN_OWNER(organ)]Orelhas."),
		span_notice("[surgeon]Começa a operar em[FORMAT_ORGAN_OWNER(organ)]Orelhas."),
	)
	display_pain(organ.owner, "You feel a dizzying pain in your head!")

/datum/surgery_operation/organ/repair/ears/on_success(obj/item/organ/ears/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	var/deaf_change = 40 SECONDS - organ.temporary_deafness
	organ.adjust_temporary_deafness(deaf_change)
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você conseguiu consertar.[FORMAT_ORGAN_OWNER(organ)]Orelhas."),
		span_notice("[surgeon]Conserta com sucesso.[FORMAT_ORGAN_OWNER(organ)]Orelhas."),
		span_notice("[surgeon]Conserta com sucesso.[FORMAT_ORGAN_OWNER(organ)]Orelhas."),
	)
	display_pain(organ.owner, "Your head swims, but it seems like you can feel your hearing coming back!")

/datum/surgery_operation/organ/repair/ears/on_failure(obj/item/organ/ears/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/obj/item/organ/brain/brain = locate() in organ.bodypart_owner
	if(isnull(brain))
		display_results(
			surgeon,
			organ.owner,
			span_warning("Você acidentalmente esfaqueou.[FORMAT_ORGAN_OWNER(organ)]bem no cérebro! Ou teria, se[FORMAT_ORGAN_OWNER(organ)]Tinha um cérebro."),
			span_warning("[surgeon]Apunhala acidentalmente.[FORMAT_ORGAN_OWNER(organ)]bem no cérebro! Ou teria, se[FORMAT_ORGAN_OWNER(organ)]Tinha um cérebro."),
			span_warning("[surgeon]Apunhala acidentalmente.[FORMAT_ORGAN_OWNER(organ)]bem no cérebro!"),
		)
		return

	display_results(
		surgeon,
		organ.owner,
		span_warning("Você acidentalmente esfaqueou.[FORMAT_ORGAN_OWNER(organ)]bem no cérebro!"),
		span_warning("[surgeon]Apunhala acidentalmente.[FORMAT_ORGAN_OWNER(organ)]bem no cérebro!"),
		span_warning("[surgeon]Apunhala acidentalmente.[FORMAT_ORGAN_OWNER(organ)]bem no cérebro!"),
	)
	display_pain(organ.owner, "You feel a visceral stabbing pain right through your head, into your brain!")
	organ.apply_organ_damage(70)

/datum/surgery_operation/organ/repair/eyes
	name = "eye surgery"
	rnd_name = "Vitrectomy (Eye Surgery)"
	desc = "Reparar os olhos danificados de um paciente para restaurar a visão."
	operation_flags = parent_type::operation_flags & ~OPERATION_AFFECTS_MOOD
	implements = list(
		TOOL_HEMOSTAT = 1.05,
		TOOL_SCREWDRIVER = 2.25,
		/obj/item/pen = 4,
	)
	time = 6.4 SECONDS
	target_type = /obj/item/organ/eyes
	heal_to_percent = 0
	repeatable = TRUE
	all_surgery_states_required = SURGERY_SKIN_OPEN
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED

/datum/surgery_operation/organ/repair/eyes/all_blocked_strings()
	return ..() + list("if the limb has bones, they must be intact")

/datum/surgery_operation/organ/repair/eyes/state_check(obj/item/organ/organ)
	// If bones are sawed, prevent the operation (unless we're operating on a limb with no bones)
	if(LIMB_HAS_ANY_SURGERY_STATE(organ.bodypart_owner, SURGERY_BONE_SAWED|SURGERY_BONE_DRILLED) && LIMB_HAS_BONES(organ.bodypart_owner))
		return FALSE
	return TRUE // always available so you can intentionally fail it

/datum/surgery_operation/organ/repair/eyes/get_default_radial_image()
	return image(icon = 'icons/obj/medical/surgery_ui.dmi', icon_state = "surgery_eyes")

/datum/surgery_operation/organ/repair/eyes/on_preop(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você começa a consertar[FORMAT_ORGAN_OWNER(organ)]Os olhos..."),
		span_notice("[surgeon]Começa a consertar.[FORMAT_ORGAN_OWNER(organ)]Os olhos."),
		span_notice("[surgeon]Começa a operar em[FORMAT_ORGAN_OWNER(organ)]Os olhos."),
	)
	display_pain(organ.owner, "You feel a stabbing pain in your eyes!")

/datum/surgery_operation/organ/repair/eyes/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	organ.owner?.remove_status_effect(/datum/status_effect/temporary_blindness)
	organ.owner?.set_eye_blur_if_lower(70 SECONDS) //this will fix itself slowly.
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você conseguiu consertar.[FORMAT_ORGAN_OWNER(organ)]Os olhos."),
		span_notice("[surgeon]Conserta com sucesso.[FORMAT_ORGAN_OWNER(organ)]Os olhos."),
		span_notice("[surgeon]Conserta com sucesso.[FORMAT_ORGAN_OWNER(organ)]Os olhos."),
	)
	display_pain(organ.owner, "Your vision blurs, but it seems like you can see a little better now!")

/datum/surgery_operation/organ/repair/eyes/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/obj/item/organ/brain/brain = locate() in organ.bodypart_owner
	if(isnull(brain))
		display_results(
			surgeon,
			organ.owner,
			span_warning("Você acidentalmente esfaqueou.[FORMAT_ORGAN_OWNER(organ)]bem no cérebro! Ou teria, se[FORMAT_ORGAN_OWNER(organ)]Tinha um cérebro."),
			span_warning("[surgeon]Apunhala acidentalmente.[FORMAT_ORGAN_OWNER(organ)]bem no cérebro! Ou teria, se[FORMAT_ORGAN_OWNER(organ)]Tinha um cérebro."),
			span_warning("[surgeon]Apunhala acidentalmente.[FORMAT_ORGAN_OWNER(organ)]bem no cérebro!"),
		)
		return

	display_results(
		surgeon,
		organ.owner,
		span_warning("Você acidentalmente esfaqueou.[FORMAT_ORGAN_OWNER(organ)]bem no cérebro!"),
		span_warning("[surgeon]Apunhala acidentalmente.[FORMAT_ORGAN_OWNER(organ)]bem no cérebro!"),
		span_warning("[surgeon]Apunhala acidentalmente.[FORMAT_ORGAN_OWNER(organ)]bem no cérebro!"),
	)
	display_pain(organ.owner, "You feel a visceral stabbing pain right through your head, into your brain!")
	organ.apply_organ_damage(70)

/datum/surgery_operation/organ/repair/brain
	name = "brain surgery"
	rnd_name = "Neurosurgery (Brain Surgery)"
	desc = "Reparar o tecido cerebral danificado de um paciente para restaurar a função cognitiva."
	implements = list(
		TOOL_HEMOSTAT = 1.05,
		TOOL_SCREWDRIVER = 2.85,
		/obj/item/pen = 6.67,
	)
	time = 10 SECONDS
	preop_sound = 'sound/items/handling/surgery/hemostat1.ogg'
	success_sound = 'sound/items/handling/surgery/hemostat1.ogg'
	failure_sound = 'sound/items/handling/surgery/organ2.ogg'
	operation_flags = parent_type::operation_flags | OPERATION_LOOPING
	target_type = /obj/item/organ/brain
	heal_to_percent = 0.25
	failure_damage_percent = 0.3
	repeatable = TRUE
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_BONE_SAWED
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED

/datum/surgery_operation/organ/repair/brain/state_check(obj/item/organ/brain/organ)
	return TRUE // always available so you can intentionally fail it

/datum/surgery_operation/organ/repair/brain/on_preop(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você começa a consertar[FORMAT_ORGAN_OWNER(organ)]O cérebro..."),
		span_notice("[surgeon]Começa a consertar.[FORMAT_ORGAN_OWNER(organ)]É o cérebro."),
		span_notice("[surgeon]Começa a operar em[FORMAT_ORGAN_OWNER(organ)]É o cérebro."),
	)
	display_pain(organ.owner, "Your head pounds with unimaginable pain!")

/datum/surgery_operation/organ/repair/brain/on_success(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	organ.apply_organ_damage(-organ.maxHealth * heal_to_percent) // no parent call, special healing for this one
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você consegue consertar.[FORMAT_ORGAN_OWNER(organ)]É o cérebro."),
		span_notice("[surgeon]Conserta com sucesso.[FORMAT_ORGAN_OWNER(organ)]Cérebro!"),
		span_notice("[surgeon]Completa a cirurgia em[FORMAT_ORGAN_OWNER(organ)]É o cérebro."),
	)
	display_pain(organ.owner, "The pain in your head receeds, thinking becomes a bit easier!")
	if (organ.owner)
		organ.owner.mind?.remove_antag_datum(/datum/antagonist/brainwashed)
	else if (organ.brainmob)
		organ.brainmob.mind?.remove_antag_datum(/datum/antagonist/brainwashed)
	organ.cure_all_traumas(TRAUMA_RESILIENCE_SURGERY)
	if(organ.damage > organ.maxHealth * 0.1)
		to_chat(surgeon, "[FORMAT_ORGAN_OWNER(organ)]O cérebro parece que pode ser consertado.")

/datum/surgery_operation/organ/repair/brain/on_failure(obj/item/organ/brain/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_warning("Você estraga tudo, causando mais danos!"),
		span_warning("[surgeon]Estraga tudo, causando danos cerebrais!"),
		span_notice("[surgeon]Completa a cirurgia em[FORMAT_ORGAN_OWNER(organ)]É o cérebro."),
	)
	display_pain(organ.owner, "Your head throbs with horrible pain; thinking hurts!")
	organ.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)

/datum/surgery_operation/organ/repair/brain/mechanic
	name = "perform neural debugging"
	rnd_name = "Wetware OS Diagnostics (Brain Surgery)"
	implements = list(
		TOOL_MULTITOOL = 1.15,
		TOOL_HEMOSTAT = 1.05,
		TOOL_SCREWDRIVER = 2.85,
		/obj/item/pen = 6.67,
	)
	preop_sound = 'sound/items/taperecorder/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder/taperecorder_close.ogg'
	required_organ_flag = ORGAN_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
