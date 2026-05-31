/// Repairing specific Synth Organs

/*
*
*   Hydraulic Pump Surgery - Heart
*
*/

/// Hydraulic Pump Surgery - Heart
/datum/surgery_operation/organ/repair/coronary_bypass/mechanic/synth
	name = "access hydraulic pump internals"
	rnd_name = "Hydraulic Pump Maintenance"
	desc = "Um procedimento cirúrgico mecânico projetado para reparar uma bomba hidráulica interna dos andróides."
	implements = list(
		TOOL_CROWBAR = 0.8,
		TOOL_SCALPEL = 1.5,
		/obj/item/melee/energy/sword = 2,
		/obj/item/knife = 3.25,
		/obj/item/shard = 3.85,
	)
	preop_sound = 'sound/items/tools/ratchet.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'
	required_organ_flag = ORGAN_ROBOTIC & ORGAN_SYNTHETIC_FROM_SPECIES
	blocked_organ_flag = NONE
	heal_to_percent = 0
	failure_damage_percent = 0.2
	repeatable = TRUE
	target_type = /obj/item/organ/heart/synth
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
	requires_organ_damage = 10

// flavor text - preop
/datum/surgery_operation/organ/repair/coronary_bypass/mechanic/synth/on_preop(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você começa a apertar as pinças ao redor[FORMAT_ORGAN_OWNER(organ)]Bomba hidráulica..."),
		span_notice("[surgeon]começa a reparar[FORMAT_ORGAN_OWNER(organ)]Bomba hidráulica com[tool]!"),
		span_notice("[surgeon]começa a reparar[FORMAT_ORGAN_OWNER(organ)]Bomba hidráulica!"),
	)
	display_pain(organ.owner, "The pain in your chest is unbearable! You can barely take it anymore!")

// flavor text - success
/datum/surgery_operation/organ/repair/coronary_bypass/mechanic/synth/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você enxertou com sucesso um canal de desvio em[FORMAT_ORGAN_OWNER(organ)]Bomba hidráulica"),
		span_notice("[surgeon]Termina a fixação dos tubos ao redor.[FORMAT_ORGAN_OWNER(organ)]Bomba hidráulica com[tool]."),
		span_notice("[surgeon]Termina a fixação dos tubos ao redor.[FORMAT_ORGAN_OWNER(organ)]Bomba hidráulica"),
	)
	display_pain(organ.owner, "The pain in your chest throbs, but your heart feels better than ever!")

// flavor text - on_failure
/datum/surgery_operation/organ/repair/coronary_bypass/mechanic/synth/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	var/blood_name = LOWER_TEXT(organ.owner?.get_bloodtype()?.get_blood_name()) || "blood"
	display_results(
		surgeon,
		organ.owner,
		span_warning("Você estraga tudo e desliza o seu[tool]em sua bomba, rasgando tubos da bomba!"),
		span_warning("[surgeon]Estraga tudo, causando alta pressão.[blood_name]para sair de[FORMAT_ORGAN_OWNER(organ)]É peito profusamente!"),
		span_warning("[surgeon]completa a cirurgia, mas é que[blood_name]Deveria estar esguichando para fora[FORMAT_ORGAN_OWNER(organ)]O peito é assim?"),
	)
	display_pain(organ.owner, "Your chest burns; you feel like you're going insane!")

/*
*
*   Reagent Processor Surgery - Liver
*
*/

/// Reagent Processor Repair surgery start
/datum/surgery_operation/organ/repair/hepatectomy/mechanic/synth
	name = "perform reagent processor maintenance"
	rnd_name = "Reagent Processor Maintenance (Reagent Processor Repair)"
	desc = "Uma cirurgia mecânica projetada para reparar o processador reagente de um andróide."
	implements = list(
		TOOL_WRENCH = 0.8,
		TOOL_SCALPEL = 1.5,
		/obj/item/melee/energy/sword = 2,
		/obj/item/knife = 3.25,
		/obj/item/shard = 3.85,
	)
	preop_sound = 'sound/items/tools/screwdriver_operating.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'
	required_organ_flag = ORGAN_ROBOTIC & ORGAN_SYNTHETIC_FROM_SPECIES
	blocked_organ_flag = NONE
	heal_to_percent = 0
	failure_damage_percent = 0.2
	repeatable = TRUE
	target_type = /obj/item/organ/liver/synth
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
	requires_organ_damage = 10

// flavor text - preop
/datum/surgery_operation/organ/repair/hepatectomy/mechanic/synth/on_preop(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você começa a descamar minerais construídos em[FORMAT_ORGAN_OWNER(organ)]O processador de reagente..."),
		span_notice("[surgeon]começa a fazer uma incisão em[FORMAT_ORGAN_OWNER(organ)]É o processador de reagente com[tool]."),
		span_notice("[surgeon]começa a fazer uma incisão em[FORMAT_ORGAN_OWNER(organ)]É o processador de reagente."),
	)
	display_pain(organ.owner, "Your systems disconnect from your reagent processor, avoiding unnecessary errors.")

// flavor text - success
/datum/surgery_operation/organ/repair/hepatectomy/mechanic/synth/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você descalça com sucesso.[FORMAT_ORGAN_OWNER(organ)]O processador reagente, restaurando as configurações da fábrica e removendo minerais construídos."),
		span_notice("[surgeon]Com sucesso descala[FORMAT_ORGAN_OWNER(organ)]O processador reagente, restaurando as configurações da fábrica e removendo minerais construídos."),
		span_notice("[surgeon]com sucesso reiniciado[FORMAT_ORGAN_OWNER(organ)]É o processador de reagente."),
	)
	display_pain(organ.owner, "Flow rate restored.")

// flavor text - failure
/datum/surgery_operation/organ/repair/hepatectomy/mechanic/synth/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_warning("Você cortou a parte errada de[FORMAT_ORGAN_OWNER(organ)]O processador de reagente está fora de controle!"),
		span_warning("[surgeon]segue o diagrama errado para[FORMAT_ORGAN_OWNER(organ)]O processador de reagente!"),
		span_warning("[surgeon]Termina de se ajustar[FORMAT_ORGAN_OWNER(organ)]O processador de reagente... espere que não está certo..."),
	)
	display_pain(organ.owner, "You see errors flow across your vision!")

/*
*
*   Heatsink Repair Surgery - Lung
*
*/

/// Heatsink Repair Surgery start
/datum/surgery_operation/organ/repair/lobectomy/mechanic/synth
	name = "heatsink maintenance"
	rnd_name = "Heatsink Diagnostic (Heatsink Repair)"
	desc = "Um procedimento cirúrgico mecânico projetado para reparar o dissipador interno de um andróide."
	implements = list(
		TOOL_WRENCH = 1.05,
		TOOL_RETRACTOR = 1.5,
	)
	preop_sound = 'sound/items/tools/ratchet_fast.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'
	required_organ_flag = ORGAN_ROBOTIC & ORGAN_SYNTHETIC_FROM_SPECIES
	blocked_organ_flag = NONE
	heal_to_percent = 0
	failure_damage_percent = 0.2
	repeatable = TRUE
	target_type = /obj/item/organ/lungs/synth
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
	requires_organ_damage = 10

// flavor text - preop
/datum/surgery_operation/organ/repair/lobectomy/mechanic/synth/on_preop(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você começa a apertar os parafusos[FORMAT_ORGAN_OWNER(organ)]É o dissipador de calor..."),
		span_notice("[surgeon]Começa a apertar os parafusos.[FORMAT_ORGAN_OWNER(organ)]É o dissipador de calor usando[tool]."),
		span_notice("[surgeon]Começa a apertar os parafusos.[FORMAT_ORGAN_OWNER(organ)]É o dissipador de calor."),
	)
	display_pain(organ.owner, "You feel a metal clank inside your chest as [surgeon] starts to work.")

// flavor text - success
/datum/surgery_operation/organ/repair/lobectomy/mechanic/synth/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você aperta com sucesso.[FORMAT_ORGAN_OWNER(organ)]São parafusos no dissipador de calor."),
		span_notice("[surgeon]Com sucesso apertado[FORMAT_ORGAN_OWNER(organ)]É o dissipador de calor usando[tool]."),
		span_notice("[surgeon]Termina o aperto.[FORMAT_ORGAN_OWNER(organ)]É o dissipador de calor."),
	)
	display_pain(organ.owner, "Your internal errors clear for your temperature regulation.")

// flavor text - failure
/datum/surgery_operation/organ/repair/lobectomy/mechanic/synth/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_warning("Você escorrega e mal pega o[tool]antes de cair, falhando em apertar[FORMAT_ORGAN_OWNER(organ)]O calor está caindo!"),
		span_warning("[surgeon]Os dedos de manteiga mal pegam[tool]antes que caia em[FORMAT_ORGAN_OWNER(organ)]O peito!"),
		span_warning("[surgeon]Estraga tudo, quase derrubando o[tool]em[FORMAT_ORGAN_OWNER(organ)]O peito!"),
	)
	display_pain(organ.owner, "You feel a dull thud in your chest; it feels like a [tool] fell into your chest cavity!")

/*
*
*   Fuel Cell Maintenance - Stomach
*
*/

/// Fuel Cell Maintenance - Start
/datum/surgery_operation/organ/repair/gastrectomy/mechanic/synth
	name = "fuel cell maintenance"
	rnd_name = "Fuel Cell Diagnostic (Fuel Cell Repair)"
	desc = "Um procedimento mecânico para reparar a célula de combustível interna de um andróide."
	implements = list(
		TOOL_SCREWDRIVER = 1.05,
		TOOL_SCALPEL = 1.5,
		/obj/item/melee/energy/sword = 2,
		/obj/item/knife = 3.25,
		/obj/item/shard = 3.85,
		/obj/item = 6,
	)
	preop_sound = 'sound/effects/bodyfall/bodyfall1.ogg'
	success_sound = 'sound/machines/airlock/doorclick.ogg'
	required_organ_flag = ORGAN_ROBOTIC & ORGAN_SYNTHETIC_FROM_SPECIES
	blocked_organ_flag = NONE
	heal_to_percent = 0
	failure_damage_percent = 0.2
	repeatable = TRUE
	target_type = /obj/item/organ/stomach/synth
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
	requires_organ_damage = 10

// flavor text - preop
/datum/surgery_operation/organ/repair/gastrectomy/mechanic/synth/on_preop(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você começa a remendar a seção danificada de[FORMAT_ORGAN_OWNER(organ)]A célula de combustível..."),
		span_notice("[surgeon]Começa a delicadamente reparar[FORMAT_ORGAN_OWNER(organ)]Célula de combustível usando[tool]."),
		span_notice("[surgeon]Começa a delicadamente reparar[FORMAT_ORGAN_OWNER(organ)]A célula de combustível."),
	)
	display_pain(organ.owner, "You feel a horrible stab in your gut!")

// flavor text - success
/datum/surgery_operation/organ/repair/gastrectomy/mechanic/synth/on_success(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você removeu com sucesso a parte danificada de[FORMAT_ORGAN_OWNER(organ)]A célula de combustível."),
		span_notice("[surgeon]Conserta com sucesso a parte danificada de[FORMAT_ORGAN_OWNER(organ)]Célula de combustível usando[tool]."),
		span_notice("[surgeon]Conserta com sucesso a parte danificada de[FORMAT_ORGAN_OWNER(organ)]A célula de combustível."),
	)
	display_pain(organ.owner, "The errors clear from your fuel cell.")

// flavor text - failure
/datum/surgery_operation/organ/repair/gastrectomy/mechanic/synth/on_failure(obj/item/organ/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		organ.owner,
		span_warning("Você escorrega e perfura[FORMAT_ORGAN_OWNER(organ)]Célula de combustível!"),
		span_warning("[surgeon]Escorregas e furos[FORMAT_ORGAN_OWNER(organ)]É a célula de combustível com o[tool]!"),
		span_warning("[surgeon]Escorregas e furos[FORMAT_ORGAN_OWNER(organ)]Célula de combustível!"),
	)
	display_pain(organ.owner, "Your midsection throws additional errors; that's not right!")

/*
*
*   Reset Logic Core - Brain
*
*/

/// Reset Logic Core - Start
/datum/surgery_operation/organ/repair/brain/mechanic/synth
	name = "perform neural debugging"
	rnd_name = "Reset Logic Core (Posi Repair)"
	desc = "Um procedimento cirúrgico que restaura a lógica de comportamento padrão e a matriz de personalidade da rede neural de um humanóide sintético."
	implements = list(
		TOOL_MULTITOOL = 1.05,
		TOOL_SCREWDRIVER = 4.85,
		/obj/item/pen = 6.67,
	)
	preop_sound = 'sound/items/taperecorder/tape_flip.ogg'
	success_sound = 'sound/items/taperecorder/taperecorder_close.ogg'
	required_organ_flag = ORGAN_ROBOTIC & ORGAN_SYNTHETIC_FROM_SPECIES
	blocked_organ_flag = NONE
	heal_to_percent = 0
	failure_damage_percent = 0.2
	repeatable = TRUE
	time = 12 SECONDS //long and complicated
	target_type = /obj/item/organ/brain/synth
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
	requires_organ_damage = 10

// flavor text - preop
/datum/surgery_operation/organ/repair/brain/mechanic/synth/on_preop(obj/item/organ/brain/synth/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/brain_type = "posibrain"
	var/obj/item/organ/brain/synth/synth_brain = organ.owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	brain_type = synth_brain.name
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você começa a limpar a corrupção do sistema de[FORMAT_ORGAN_OWNER(organ)]'s[brain_type]..."),
		span_notice("[surgeon]Começa a consertar.[FORMAT_ORGAN_OWNER(organ)]'s[brain_type]"),
		span_notice("[surgeon]Começa a operar em[FORMAT_ORGAN_OWNER(organ)]'s[brain_type]."),
	)
	display_pain(organ.owner, "You start to have fragmented thoughts!")

// flavor text - success
/datum/surgery_operation/organ/repair/brain/mechanic/synth/on_success(obj/item/organ/brain/synth/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	organ.apply_organ_damage(-organ.maxHealth * heal_to_percent) // no parent call, special healing for this one
	var/brain_type = "posibrain"
	var/obj/item/organ/brain/synth/synth_brain = organ.owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(synth_brain)
		brain_type = synth_brain.name
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você consegue limpar a corrupção do sistema.[FORMAT_ORGAN_OWNER(organ)]'s[brain_type]."),
		span_notice("[surgeon]Conserta com sucesso.[FORMAT_ORGAN_OWNER(organ)]'s[brain_type]."),
		span_notice("[surgeon]completa a cirurgia em[FORMAT_ORGAN_OWNER(organ)]'s[brain_type]."),
	)
	display_pain(organ.owner, "The fragmentation errors start clearing.")
	if (organ.owner)
		organ.owner.mind?.remove_antag_datum(/datum/antagonist/brainwashed)
	else if (organ.brainmob)
		organ.brainmob.mind?.remove_antag_datum(/datum/antagonist/brainwashed)
	organ.cure_all_traumas(TRAUMA_RESILIENCE_SURGERY)
	if(organ.damage > organ.maxHealth * 0.1)
		to_chat(surgeon, "[FORMAT_ORGAN_OWNER(organ)]'s[brain_type]Ainda tem algum dano no sistema que pode ser limpo.")

// flavor text - failure
/datum/surgery_operation/organ/repair/brain/mechanic/synth/on_failure(obj/item/organ/brain/synth/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	var/brain_type = "posibrain"
	var/obj/item/organ/brain/synth/synth_brain = organ.owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(synth_brain)
		brain_type = synth_brain.name
	display_results(
		surgeon,
		organ.owner,
		span_warning("Você estraga tudo, fragmentando os dados deles!"),
		span_warning("[surgeon]Estraga tudo, causando danos nos circuitos!"),
		span_notice("[surgeon]completa a cirurgia em[FORMAT_ORGAN_OWNER(organ)]'s[brain_type]Ou foi o que eles pensaram."),
	)
	display_pain(organ.owner, "Your vision floods with errors; something is wrong!")
	organ.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)

/*
*
*   Repair auditory microphones - Ear
*
*/

/// Repair Auditory Microphones - Start
/datum/surgery_operation/organ/repair/ears/synth
	name = "ear repair"
	rnd_name = "Repair Auditory Microphones (Hearing Repair)" // source: i made it up
	desc = "Reparar as orelhas danificadas do paciente para restaurar a audição."
	implements = list(
		TOOL_MULTITOOL = 1.15,
		TOOL_SCREWDRIVER = 4.85,
		/obj/item/pen = 6.67,
	)
	target_type = /obj/item/organ/ears/synth
	time = 6.4 SECONDS
	heal_to_percent = 0
	repeatable = TRUE
	all_surgery_states_required = SURGERY_SKIN_OPEN
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED
	required_organ_flag = ORGAN_ROBOTIC & ORGAN_SYNTHETIC_FROM_SPECIES
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
	requires_organ_damage = 1

/datum/surgery_operation/organ/repair/ears/synth/all_blocked_strings()
	return ..() + list("if the limb has bones, they must be intact")

/datum/surgery_operation/organ/repair/ears/synth/state_check(obj/item/organ/ears/organ)
	// If bones are sawed, prevent the operation (unless we're operating on a limb with no bones)
	if(LIMB_HAS_ANY_SURGERY_STATE(organ.bodypart_owner, SURGERY_BONE_SAWED|SURGERY_BONE_DRILLED) && LIMB_HAS_BONES(organ.bodypart_owner))
		return FALSE
	return TRUE // always available so you can intentionally fail it

/datum/surgery_operation/organ/repair/ears/synth/on_preop(obj/item/organ/ears/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você começa a reparar[FORMAT_ORGAN_OWNER(organ)]Os microfones..."),
		span_notice("[surgeon]Começa a consertar.[FORMAT_ORGAN_OWNER(organ)]Os microfones."),
		span_notice("[surgeon]começa a realizar manutenção em[FORMAT_ORGAN_OWNER(organ)]Os microfones."),
	)
	display_pain(organ.owner, "Your auditory input starts to crackle loudly!")

/datum/surgery_operation/organ/repair/ears/synth/on_success(obj/item/organ/ears/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	. = ..()
	var/deaf_change = 40 SECONDS - organ.temporary_deafness
	organ.adjust_temporary_deafness(deaf_change)
	display_results(
		surgeon,
		organ.owner,
		span_notice("Você reparou com sucesso.[FORMAT_ORGAN_OWNER(organ)]Os microfones."),
		span_notice("[surgeon]Consertar com sucesso[FORMAT_ORGAN_OWNER(organ)]Os microfones."),
		span_notice("[surgeon]Consertar com sucesso[FORMAT_ORGAN_OWNER(organ)]Os microfones."),
	)
	display_pain(organ.owner, "Your sensors call out in protest, but it seems like your microphones are coming back online!")

/datum/surgery_operation/organ/repair/ears/synth/on_failure(obj/item/organ/ears/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	var/obj/item/organ/brain/brain = locate() in organ.bodypart_owner
	if(isnull(brain))
		display_results(
			surgeon,
			organ.owner,
			span_warning("Você acidentalmente esfaqueou.[FORMAT_ORGAN_OWNER(organ)]bem no vasocérebro! Ou teria, se[FORMAT_ORGAN_OWNER(organ)]tinha um vasocérebro."),
			span_warning("[surgeon]Apunhala acidentalmente.[FORMAT_ORGAN_OWNER(organ)]bem no vasocérebro! Ou teria, se[FORMAT_ORGAN_OWNER(organ)]tinha um vasocérebro."),
			span_warning("[surgeon]Apunhala acidentalmente.[FORMAT_ORGAN_OWNER(organ)]bem no vasocérebro!"),
		)
		return

	display_results(
		surgeon,
		organ.owner,
		span_warning("Você acidentalmente esfaqueou.[FORMAT_ORGAN_OWNER(organ)]bem no vasocérebro!"),
		span_warning("[surgeon]Apunhala acidentalmente.[FORMAT_ORGAN_OWNER(organ)]bem no vasocérebro!"),
		span_warning("[surgeon]Apunhala acidentalmente.[FORMAT_ORGAN_OWNER(organ)]bem no vasocérebro!"),
	)
	display_pain(organ.owner, "You sudden are jolted by something shorting your insides!")
