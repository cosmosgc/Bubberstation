/datum/surgery_operation/limb/bioware
	abstract_type = /datum/surgery_operation/limb/bioware
	implements = list(
		IMPLEMENT_HAND = 1,
	)
	operation_flags = OPERATION_AFFECTS_MOOD | OPERATION_NOTABLE | OPERATION_MORBID | OPERATION_LOCKED
	required_bodytype = (~BODYTYPE_ROBOTIC & ~BODYTYPE_SYNTHETIC) // NOVA EDIT CHANGE - SYNTH FLAGS  -Original: required_bodytype = ~BODYTYPE_ROBOTIC
	time = 12.5 SECONDS
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_BONE_SAWED|SURGERY_ORGANS_CUT
	/// What status effect is gained when the surgery is successful?
	/// Used to check against other bioware types to prevent stacking.
	var/datum/status_effect/status_effect_gained = /datum/status_effect/bioware
	/// Zone to operate on for this bioware
	var/required_zone = BODY_ZONE_CHEST

/datum/surgery_operation/limb/bioware/get_default_radial_image()
	return image('icons/hud/implants.dmi', "lighting_bolt")

/datum/surgery_operation/limb/bioware/all_required_strings()
	return list("operate on [parse_zone(required_zone)] (target [parse_zone(required_zone)])") + ..()

/datum/surgery_operation/limb/bioware/all_blocked_strings()
	var/list/incompatible_surgeries = list()
	for(var/datum/surgery_operation/limb/bioware/other_bioware as anything in subtypesof(/datum/surgery_operation/limb/bioware))
		if(other_bioware::status_effect_gained::id != status_effect_gained::id)
			continue
		if(other_bioware::required_bodytype != required_bodytype)
			continue
		incompatible_surgeries += (other_bioware.rnd_name || other_bioware.name)

	return ..() + list("the patient must not have undergone [english_list(incompatible_surgeries, and_text = " OR ")] prior")

/datum/surgery_operation/limb/bioware/state_check(obj/item/bodypart/limb)
	if(limb.body_zone != required_zone)
		return FALSE
	if(limb.owner.has_status_effect(status_effect_gained))
		return FALSE
	return TRUE

/datum/surgery_operation/limb/bioware/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	limb.owner.apply_status_effect(status_effect_gained)
	if(limb.owner.ckey)
		SSblackbox.record_feedback("tally", "bioware", 1, status_effect_gained)

/datum/surgery_operation/limb/bioware/vein_threading
	name = "thread veins"
	rnd_name = "Symvasculodesis (Vein Threading)" // "together vessel fusion"
	desc = "Coloque as veias de um paciente em uma rede reforçada, reduzindo a perda de sangue."
	status_effect_gained = /datum/status_effect/bioware/heart/threaded_veins

/datum/surgery_operation/limb/bioware/vein_threading/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("Você começa a tecer[limb.owner]Os vasos sanguíneos."),
		span_notice("[surgeon]Começa a tecer.[limb.owner]Os vasos sanguíneos."),
		span_notice("[surgeon]Começa a manipular[limb.owner]Os vasos sanguíneos."),
	)
	display_pain(limb.owner, "Your entire body burns in agony!")

/datum/surgery_operation/limb/bioware/vein_threading/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("Você tece[limb.owner]Os vasos sanguíneos em uma malha resistente!"),
		span_notice("[surgeon]tece[limb.owner]Os vasos sanguíneos em uma malha resistente!"),
		span_notice("[surgeon]termina de manipular[limb.owner]Os vasos sanguíneos."),
	)
	display_pain(limb.owner, "You can feel your blood pumping through reinforced veins!")

/datum/surgery_operation/limb/bioware/vein_threading/mechanic
	rnd_name = "Hydraulics Routing Optimization (Threaded Veins)"
	desc = "Otimize o roteamento do sistema hidráulico de um paciente robótico, reduzindo a perda de fluidos."
	required_bodytype = BODYTYPE_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/limb/bioware/muscled_veins
	name = "muscled veins"
	rnd_name = "Myovasculoplasty (Muscled Veins)" // "muscle vessel reshaping"
	desc = "Adicione uma membrana muscular nas veias de um paciente, permitindo bombear sangue sem coração."
	status_effect_gained = /datum/status_effect/bioware/heart/muscled_veins

/datum/surgery_operation/limb/bioware/muscled_veins/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("Você começa a enrolar os músculos[limb.owner]Os vasos sanguíneos."),
		span_notice("[surgeon]Começa a envolver os músculos.[limb.owner]Os vasos sanguíneos."),
		span_notice("[surgeon]Começa a manipular[limb.owner]Os vasos sanguíneos."),
	)
	display_pain(limb.owner, "Your entire body burns in agony!")

/datum/surgery_operation/limb/bioware/muscled_veins/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("Você reformula[limb.owner]Os vasos sanguíneos, adicionando uma membrana muscular!"),
		span_notice("[surgeon]Refazer[limb.owner]Os vasos sanguíneos, adicionando uma membrana muscular!"),
		span_notice("[surgeon]termina de manipular[limb.owner]Os vasos sanguíneos."),
	)
	display_pain(limb.owner, "You can feel your heartbeat's powerful pulses ripple through your body!")

/datum/surgery_operation/limb/bioware/muscled_veins/mechanic
	rnd_name = "Hydraulics Redundancy Subroutine (Muscled Veins)"
	desc = "Adicione redundâncias ao sistema hidráulico de um paciente robótico, permitindo bombear fluidos sem motor ou bomba."
	required_bodytype = BODYTYPE_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/limb/bioware/nerve_splicing
	name = "splice nerves"
	rnd_name = "Symneurodesis (Spliced Nerves)" // "together nerve fusion"
	desc = "Junte os nervos de um paciente para torná-los mais resistentes ao choque."
	time = 15.5 SECONDS
	status_effect_gained = /datum/status_effect/bioware/nerves/spliced

/datum/surgery_operation/limb/bioware/nerve_splicing/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("Vocês começam a se juntar[limb.owner]Os nervos."),
		span_notice("[surgeon]Começa a se juntar[limb.owner]Os nervos."),
		span_notice("[surgeon]Começa a manipular[limb.owner]É o sistema nervoso."),
	)
	display_pain(limb.owner, "Your entire body goes numb!")

/datum/surgery_operation/limb/bioware/nerve_splicing/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("Você se uniu com sucesso.[limb.owner]É o sistema nervoso!"),
		span_notice("[surgeon]Com sucesso se encaixa.[limb.owner]É o sistema nervoso!"),
		span_notice("[surgeon]termina de manipular[limb.owner]É o sistema nervoso."),
	)
	display_pain(limb.owner, "You regain feeling in your body; It feels like everything's happening around you in slow motion!")

/datum/surgery_operation/limb/bioware/nerve_splicing/mechanic
	rnd_name = "System Automatic Reset Subroutine (Spliced Nerves)"
	desc = "Atualize os sistemas automáticos de um paciente robótico, permitindo que ele resista melhor aos choques."
	required_bodytype = BODYTYPE_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/limb/bioware/nerve_grounding
	name = "ground nerves"
	rnd_name = "Xanthoneuroplasty (Grounded Nerves)" // "yellow nerve reshaping". see: yellow gloves
	desc = "Redirecionar os nervos de um paciente para agir como hastes de aterramento, protegendo-os de choques elétricos."
	time = 15.5 SECONDS
	status_effect_gained = /datum/status_effect/bioware/nerves/grounded

/datum/surgery_operation/limb/bioware/nerve_grounding/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("Você começa a reencaminhar[limb.owner]Os nervos."),
		span_notice("[surgeon]Começa a reencaminhar.[limb.owner]Os nervos."),
		span_notice("[surgeon]Começa a manipular[limb.owner]É o sistema nervoso."),
	)
	display_pain(limb.owner, "Your entire body goes numb!")

/datum/surgery_operation/limb/bioware/nerve_grounding/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("Você reencaminha com sucesso.[limb.owner]É o sistema nervoso!"),
		span_notice("[surgeon]com sucesso redireciona[limb.owner]É o sistema nervoso!"),
		span_notice("[surgeon]termina de manipular[limb.owner]É o sistema nervoso."),
	)
	display_pain(limb.owner, "You regain feeling in your body! You feel energized!")

/datum/surgery_operation/limb/bioware/nerve_grounding/mechanic
	rnd_name = "System Shock Dampening (Grounded Nerves)"
	desc = "Instalar hastes de aterramento no sistema nervoso de um paciente robótico, protegendo-o de choques elétricos."
	required_bodytype = BODYTYPE_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/limb/bioware/ligament_hook
	name = "reshape ligaments"
	rnd_name = "Arthroplasty (Ligament Hooks)" // "joint reshaping"
	desc = "Reorganizar os ligamentos de um paciente para permitir que os membros sejam recolocados manualmente, se cortados, ao custo de facilitar a separação."
	status_effect_gained = /datum/status_effect/bioware/ligaments/hooked

/datum/surgery_operation/limb/bioware/ligament_hook/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("Você começa a remodelar[limb.owner]Os ligamentos estão em forma de gancho."),
		span_notice("[surgeon]Começa a remodelar.[limb.owner]Os ligamentos estão em forma de gancho."),
		span_notice("[surgeon]Começa a manipular[limb.owner]Os ligamentos."),
	)
	display_pain(limb.owner, "Your limbs burn with severe pain!")

/datum/surgery_operation/limb/bioware/ligament_hook/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("Você reformula[limb.owner]Ligamentos em um gancho conjuntivo!"),
		span_notice("[surgeon]Refazer[limb.owner]Ligamentos em um gancho conjuntivo!"),
		span_notice("[surgeon]termina de manipular[limb.owner]Os ligamentos."),
	)
	display_pain(limb.owner, "Your limbs feel... strangely loose.")

/datum/surgery_operation/limb/bioware/ligament_hook/mechanic
	rnd_name = "Anchor Point Snaplocks (Ligament Hooks)"
	desc = "Refaça as articulações dos membros de um paciente robótico para permitir o desapego rápido, permitindo que os membros sejam reimplantados manualmente, se cortados, ao custo de torná-los mais fáceis de soltar também."
	required_bodytype = BODYTYPE_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/limb/bioware/ligament_reinforcement
	name = "strengthen ligaments"
	rnd_name = "Arthrorrhaphy (Ligament Reinforcement)" // "joint strengthening" / "joint stitching"
	desc = "Fortaleça os ligamentos do paciente para dificultar o desmembramento, ao custo de facilitar as conexões nervosas."
	status_effect_gained = /datum/status_effect/bioware/ligaments/reinforced

/datum/surgery_operation/limb/bioware/ligament_reinforcement/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("Você começa a reforçar[limb.owner]Os ligamentos."),
		span_notice("[surgeon]Começa a reforçar.[limb.owner]Os ligamentos."),
		span_notice("[surgeon]Começa a manipular[limb.owner]Os ligamentos."),
	)
	display_pain(limb.owner, "Your limbs burn with severe pain!")

/datum/surgery_operation/limb/bioware/ligament_reinforcement/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("Você reforça[limb.owner]Os ligamentos!"),
		span_notice("[surgeon]Reforça[limb.owner]Os ligamentos!"),
		span_notice("[surgeon]termina de manipular[limb.owner]Os ligamentos."),
	)
	display_pain(limb.owner, "Your limbs feel more secure, but also more frail.")

/datum/surgery_operation/limb/bioware/ligament_reinforcement/mechanic
	rnd_name = "Anchor Point Reinforcement (Ligament Reinforcement)"
	desc = "Reforce as articulações dos membros de um paciente robótico para evitar o desmembramento, ao custo de facilitar as conexões nervosas."
	required_bodytype = BODYTYPE_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/limb/bioware/cortex_folding
	name = "cortex folding"
	rnd_name = "Encephalofractoplasty (Cortex Folding)" // it's a stretch - "brain fractal reshaping"
	desc = "Uma atualização biológica que dobra o córtex cerebral de um paciente em um padrão fractal, aumentando a densidade neural e flexibilidade."
	operation_flags = OPERATION_AFFECTS_MOOD | OPERATION_NOTABLE | OPERATION_MORBID | OPERATION_LOCKED | OPERATION_NO_PATIENT_REQUIRED
	status_effect_gained = /datum/status_effect/bioware/cortex // Not actually applied, simply for compatibility checks
	required_zone = BODY_ZONE_HEAD

/datum/surgery_operation/limb/bioware/cortex_folding/state_check(obj/item/bodypart/limb)
	. = ..()
	if (!.)
		return
	var/obj/item/organ/brain/brain = locate() in limb
	if(isnull(brain))
		return FALSE
	return !HAS_TRAIT_FROM(brain, TRAIT_SPECIAL_TRAUMA_BOOST, BIOWARE_TRAIT)

/datum/surgery_operation/limb/bioware/cortex_folding/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	var/obj/item/organ/brain/brain = locate() in limb
	if(!isnull(brain))
		ADD_TRAIT(brain, TRAIT_SPECIAL_TRAUMA_BOOST, BIOWARE_TRAIT)

/datum/surgery_operation/limb/bioware/cortex_folding/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("Você começa a dobrar[limb.owner]É o córtex cerebral."),
		span_notice("[surgeon]Começa a dobrar[limb.owner]É o córtex cerebral."),
		span_notice("[surgeon]Começa a cirurgia em[limb.owner]É o cérebro."),
	)
	display_pain(limb.owner, "Your head throbs with gruesome pain, it's nearly too much to handle!")

/datum/surgery_operation/limb/bioware/cortex_folding/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("Você dobra[limb.owner]O córtex cerebral está em um padrão fractal!"),
		span_notice("[surgeon]dobras[limb.owner]O córtex cerebral está em um padrão fractal!"),
		span_notice("[surgeon]completa a cirurgia em[limb.owner]É o cérebro."),
	)
	display_pain(limb.owner, "Your brain feels stronger... and more flexible!")

/datum/surgery_operation/limb/bioware/cortex_folding/on_failure(obj/item/bodypart/limb, mob/living/surgeon, tool)
	var/obj/item/organ/brain/brain = locate() in limb
	if(isnull(brain))
		return ..()
	display_results(
		surgeon,
		limb.owner,
		span_warning("Você estraga tudo, prejudica o cérebro!"),
		span_warning("[surgeon]Estraga tudo, prejudica o cérebro!"),
		span_notice("[surgeon]completa a cirurgia em[limb.owner]É o cérebro."),
	)
	display_pain(limb.owner, "Your head throbs with excruciating pain!")
	brain.apply_organ_damage(60)
	brain.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)

/datum/surgery_operation/limb/bioware/cortex_folding/mechanic
	rnd_name = "Wetware OS Labyrinthian Programming (Cortex Folding)"
	desc = "Reprogramar a rede neural de um paciente robótico em uma linguagem de programação de eldritch, dando espaço para padrões neurais não padrão."
	required_bodytype = BODYTYPE_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC

/datum/surgery_operation/limb/bioware/cortex_imprint
	name = "cortex imprinting"
	rnd_name = "Encephalopremoplasty (Cortex Imprinting)" // it's a stretch - "brain print reshaping"
	desc = "Uma atualização biológica que esculpe o córtex cerebral de um paciente em um padrão de autoimpressão, aumentando a densidade neural e resiliência."
	status_effect_gained = /datum/status_effect/bioware/cortex/imprinted
	required_zone = BODY_ZONE_HEAD

/datum/surgery_operation/limb/bioware/cortex_imprint/on_preop(obj/item/bodypart/limb, mob/living/surgeon, tool)
	display_results(
		surgeon,
		limb.owner,
		span_notice("Você começa a esculpir[limb.owner]O córtex cerebral externo em um padrão de autoimpressão."),
		span_notice("[surgeon]Começa a esculpir[limb.owner]O córtex cerebral externo em um padrão de autoimpressão."),
		span_notice("[surgeon]Começa a cirurgia em[limb.owner]É o cérebro."),
	)
	display_pain(limb.owner, "Your head throbs with gruesome pain, it's nearly too much to handle!")

/datum/surgery_operation/limb/bioware/cortex_imprint/on_success(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	display_results(
		surgeon,
		limb.owner,
		span_notice("Você reformula[limb.owner]O córtex cerebral externo em um padrão de autoimpressão!"),
		span_notice("[surgeon]Refazer[limb.owner]O córtex cerebral externo em um padrão de autoimpressão!"),
		span_notice("[surgeon]completa a cirurgia em[limb.owner]É o cérebro."),
	)
	display_pain(limb.owner, "Your brain feels stronger... and more resilient!")

/datum/surgery_operation/limb/bioware/cortex_imprint/on_failure(obj/item/bodypart/limb, mob/living/surgeon, tool)
	if(!limb.owner.get_organ_slot(ORGAN_SLOT_BRAIN))
		return ..()
	display_results(
		surgeon,
		limb.owner,
		span_warning("Você estraga tudo, prejudica o cérebro!"),
		span_warning("[surgeon]Estraga tudo, prejudica o cérebro!"),
		span_notice("[surgeon]completa a cirurgia em[limb.owner]É o cérebro."),
	)
	display_pain(limb.owner, "Your brain throbs with intense pain; Thinking hurts!")
	limb.owner.adjust_organ_loss(ORGAN_SLOT_BRAIN, 60)
	limb.owner.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)

/datum/surgery_operation/limb/bioware/cortex_imprint/mechanic
	rnd_name = "Wetware OS Ver 2.0 (Cortex Imprinting)"
	desc = "Atualizar o sistema operacional de um paciente robótico para\"Versão mais recente\", melhorando o desempenho geral e resiliência. Vergonha por todo o adware."
	required_bodytype = BODYTYPE_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
