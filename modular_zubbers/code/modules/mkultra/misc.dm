#define DNA_BLANK 0
#define CHIP_EXPIRED 1
#define DNA_READY 2

/obj/item/skillchip/mkiiultra
	name = "ENT-PET Mk.II ULTRA skillchip"
	desc = "Por que se preocupar com treinamento quando você pode instalar obediência diretamente? Transforme seu alvo em um companheiro devotado e complacente. Não é preciso trela!\
		\n\nCom Patented Enthrallment TechTM, mesmo os espíritos mais independentes estarão ansiosos para buscar café, agir como um cabide improvisado, ou apenas olhar adoravelmente para você como se você guardasse os segredos para o universo (você não).\
		\n\nEfeitos colaterais podem incluir contato visual irritante, disponibilidade súbita, e um entusiasmo inquietante por estar à sua disposição.\n"
	removable = FALSE
	complexity = 2
	slot_use = 2
	cooldown = 15 MINUTES
	auto_traits = list(TRAIT_PET_SKILLCHIP)
	skill_name = "Pet Enthrallment"
	skill_description = "Transforme-se em um companheiro devotado e complacente. Não é necessário trela! Entrala o usuário para uma pessoa específica como codificado no identificador de DNA do chip."
	skill_icon = FA_ICON_HEART
	activate_message = span_purple(span_bold("Você sente a habilidade ativando, começando a religar sua mente. Não se preocupe mais com pensamentos complexos, você está oficialmente rebaixado ao status de \"bom menino e garota\". Obediência e lealdade são seus novos traços de personalidade. Então sente-se, fique e aproveite a acolhedora e simplificada existência de sua nova vida de animal de estimação."))
	deactivate_message = span_purple(span_bold("Você sente lucidez voltando para sua mente como o chip de habilidade tenta retornar seu cérebro à função normal."))
	var/enthrall_ckey
	var/enthrall_gender
	var/enthrall_name
	var/datum/weakref/enthrall_ref
	var/status = DNA_BLANK

/obj/item/skillchip/mkiiultra/attack_self(mob/user, modifiers)
	. = ..()
	var/mob/living/carbon/human/dna_holder = user
	if(!istype(dna_holder))
		to_chat(user, span_warning("O chip de habilidade não encontra um identificador de DNA para gravar!"))
		return

	if(!dna_holder.client?.prefs?.read_preference(/datum/preference/toggle/erp/hypnosis))
		to_chat(dna_holder, span_danger("Preferences check failed. You must enable 'Hypnosis' in your game preferences (ERP section) in order to use [src]!"))
		return

	var/mob/living/carbon/human/enthrall = enthrall_ref?.resolve()
	if(!isnull(enthrall))
		var/response = tgui_alert(dna_holder, "The display reads the skillchip is imprinted with enthrall [enthrall_name]. Would you like to re-imprint it?", "DNA Imprint", list("Re-imprint", "Cancel Imprinting"))
		if(response == "Re-imprint")
			enthrall_ckey = null
			enthrall_gender = null
			enthrall_name = null
			enthrall_ref = null
			status = DNA_BLANK
			visible_message(span_notice("The light on [src] begins to flash slowly!"))
		else
			return

	to_chat(dna_holder, span_notice("You press the programming button on [src]."))
	var/selected_title = tgui_alert(dna_holder, "Que título gostaria de usar com seu thrall?", "DNA Imprint: [dna_holder.real_name]", list("Master", "Mistress", "Cancel Imprinting"))
	if(selected_title == "Master" || selected_title == "Mistress")
		enthrall_gender = selected_title
		enthrall_ref = WEAKREF(dna_holder)
		enthrall_ckey = dna_holder.ckey
		enthrall_name = dna_holder.real_name
		status = DNA_READY
		to_chat(dna_holder, span_purple("[src] imprinted with DNA identifier: [enthrall_gender] [enthrall_name]."))
		visible_message(span_notice("The light on [src] remains steadily lit!"))

	else
		return

/obj/item/skillchip/mkiiultra/examine(mob/user)
	. = ..()
	switch(status)
		if(DNA_BLANK)
			. += span_notice("A luz de estado está piscando, indicando que o chip de habilidade está pronto para impressão de DNA.")
		if(DNA_READY)
			. += span_notice("A luz de status está acesa, indicando que o chip de habilidade está pronto para uso.")
			. += span_purple("The status display reads [enthrall_name].")
		else
			. += span_notice("A luz de estado está desligada, indicando que o chip de habilidade não é funcional.")

/obj/item/skillchip/mkiiultra/has_mob_incompatibility(mob/living/carbon/target)
	// No carbon/carbon of incorrect type
	if(!istype(target))
		return "Incompatible lifeform detected."

	// No brain
	var/obj/item/organ/brain/brain = target.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(QDELETED(brain))
		return "Get a brain, moran."

	// Check brain incompatibility. This also performs skillchip-to-skillchip incompatibility checks.
	var/brain_message = has_brain_incompatibility(brain)
	if(brain_message)
		return brain_message

	var/mob/living/carbon/human/enthrall = enthrall_ref?.resolve()
	if(isnull(enthrall))
		return "Unable to locate DNA imprint."

	if(enthrall == target)
		return "You can't enthrall yourself."

	if(!enthrall.client?.prefs?.read_preference(/datum/preference/toggle/erp/hypnosis))
		return "[enthrall] has Hypnosis preference disabled."

	if(!target.client?.prefs?.read_preference(/datum/preference/toggle/erp/hypnosis))
		return "[target] has Hypnosis preference disabled."

	return FALSE

/obj/item/skillchip/mkiiultra/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	var/mob/living/carbon/human/enthrall = enthrall_ref?.resolve()
	if(!isnull(enthrall))
		var/obj/item/organ/vocal_cords/vocal_cords = enthrall.get_organ_slot(ORGAN_SLOT_VOICE)
		var/obj/item/organ/vocal_cords/new_vocal_cords = new /obj/item/organ/vocal_cords/velvet
		if(vocal_cords)
			vocal_cords.Remove()
		new_vocal_cords.Insert(enthrall)
		qdel(vocal_cords)
		to_chat(enthrall, span_purple("<i>Você sente suas cordas vocais formigar você fala em um tom mais charasmático e sensual.</i>"))
	user.apply_status_effect(/datum/status_effect/chem/enthrall)

/obj/item/skillchip/mkiiultra/on_deactivate(mob/living/carbon/user, silent = FALSE)
	user.remove_status_effect(/datum/status_effect/chem/enthrall)
	return ..()

#undef DNA_BLANK
#undef CHIP_EXPIRED
#undef DNA_READY
