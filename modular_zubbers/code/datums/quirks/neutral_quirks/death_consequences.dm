/datum/quirk/death_consequences
	name = DEATH_CONSEQUENCES_QUIRK_NAME
	desc = "Toda vez que você morre, seu corpo sofre danos a longo prazo que não podem ser facilmente reparados."
	medical_record_text = DEATH_CONSEQUENCES_QUIRK_DESC
	icon = FA_ICON_DNA
	value = 0 // due to its high customization, you can make it really inconsequential

/datum/quirk_constant_data/death_consequences
	associated_typepath = /datum/quirk/death_consequences

/datum/quirk_constant_data/death_consequences/New()
	customization_options = (subtypesof(/datum/preference/numeric/death_consequences) + subtypesof(/datum/preference/toggle/death_consequences))

	return ..()

/datum/quirk/death_consequences/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.gain_trauma(/datum/brain_trauma/severe/death_consequences, TRAUMA_RESILIENCE_ABSOLUTE)
	var/datum/brain_trauma/severe/death_consequences/added_trauma = human_holder.get_death_consequences_trauma()
	if (!isnull(added_trauma))
		added_trauma.update_variables(client_source)

	to_chat(human_holder, span_danger("Você sofre de[src]Por padrão, você degradará cada vez que morrer, e se recuperará lentamente enquanto estiver vivo. Isso pode ser acelerado por descansar, dormir, ser amarrado a algo aconchegante, ou usar Rezadone.\nÀ medida que sua degradação aumenta, também os efeitos negativos, como danos na resistência ou um limiar de hematócrito pior.\nVocê pode alterar sua degradação na mosca através do verbo Ajustar a degradação da morte, e mudar suas configurações através do verbo Atualizar as variáveis da consequência da morte."))

/datum/quirk/death_consequences/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.cure_trauma_type(/datum/brain_trauma/severe/death_consequences, TRAUMA_RESILIENCE_ABSOLUTE)

/// Adjusts the mob's linked death consequences trauma (see get_death_consequences_trauma())'s degradation by increment.
/mob/verb/adjust_degradation(increment as num)
	set name = "Adjust death degradation"
	set category = "IC"
	set instant = TRUE

	if (isnull(mind))
		to_chat(usr, span_warning("Você não tem mente!"))
		return

	var/datum/brain_trauma/severe/death_consequences/linked_trauma = get_death_consequences_trauma()
	var/mob/living/carbon/trauma_holder = linked_trauma?.owner
	if (isnull(linked_trauma) || isnull(trauma_holder) || trauma_holder != mind.current) // sanity
		to_chat(usr, span_warning("Você não tem um corpo com consequências de morte!"))
		return

	if (!isnum(increment))
		to_chat(usr, span_warning("Você pode mudar artificialmente o nível atual da sua degradação com este verbo. Você pode usar isso para causar degradação de maneiras que a personalização não pode.<b>Você precisa digitar um número para usar esse verbo.</b>"))
		return

	if (linked_trauma.permakill_if_at_max_degradation && ((linked_trauma.current_degradation + increment) >= linked_trauma.max_degradation))
		if (tgui_alert(usr, "Isso vai colocá-lo sobre / em seu limite máximo de degradação e sempre matá-lo!! Tem certeza que quer fazer isso?", "WARNING", list("Yes", "No"), timeout = 7 SECONDS) != "Yes")
			return

	linked_trauma.adjust_degradation(increment)
	to_chat(usr, span_notice("Degradação ajustada com sucesso!"))

/// Calls update_variables() on this mob's linked death consequences trauma. See that proc for further info.
/mob/verb/refresh_death_consequences()
	set name = "Refresh death consequence variables"
	set category = "IC"
	set instant = TRUE

	if (isnull(mind))
		to_chat(usr, span_warning("Você não tem mente!"))
		return

	var/datum/brain_trauma/severe/death_consequences/linked_trauma = get_death_consequences_trauma()
	var/mob/living/carbon/trauma_holder = linked_trauma?.owner
	if (isnull(linked_trauma) || isnull(trauma_holder) || trauma_holder != mind.current) // sanity
		to_chat(usr, span_warning("Você não tem um corpo com consequências de morte!"))
		return

	linked_trauma.update_variables(client)
	to_chat(usr, span_notice("Variáveis atualizadas com sucesso!"))

/// Searches mind.current for a death_consequences trauma. Allows this proc to be used on both ghosts and living beings to find their linked trauma.
/mob/proc/get_death_consequences_trauma()
	RETURN_TYPE(/datum/brain_trauma/severe/death_consequences)

	if (isnull(mind))
		return

	if (iscarbon(mind.current))
		var/mob/living/carbon/carbon_body = mind.current
		for (var/datum/brain_trauma/trauma as anything in carbon_body.get_traumas())
			if (istype(trauma, /datum/brain_trauma/severe/death_consequences))
				return trauma
	// else, return null
