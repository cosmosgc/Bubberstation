/datum/element/reagent_scoopable_atom
	element_flags = ELEMENT_BESPOKE|ELEMENT_DETACH_ON_HOST_DESTROY
	argument_hash_start_idx = 2
	var/datum/reagent/reagent_to_extract

/datum/element/reagent_scoopable_atom/Attach(datum/target, reagent_to_extract)
	. = ..()
	if(!isatom(target))
		return ELEMENT_INCOMPATIBLE
	if(!reagent_to_extract)
		CRASH("[type] added to [target] without any reagent specified.")
	src.reagent_to_extract = reagent_to_extract
	RegisterSignal(target, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(target, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(on_item_interaction))

/datum/element/reagent_scoopable_atom/Detach(datum/source, ...)
	UnregisterSignal(source, list(COMSIG_ATOM_EXAMINE, COMSIG_ATOM_ITEM_INTERACTION))
	return ..()

/datum/element/reagent_scoopable_atom/proc/on_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += span_info("Alguns<b>[reagent_to_extract::name]</b>Poderia provavelmente ser pego com um<b>Contêiner</b>.")

/datum/element/reagent_scoopable_atom/proc/on_item_interaction(atom/source, mob/living/user, obj/item/tool, list/modifiers)
	SIGNAL_HANDLER

	if(tool.is_open_container())
		return extract_reagents(source, tool, user)

/datum/element/reagent_scoopable_atom/proc/extract_reagents(atom/source, obj/item/container, mob/living/user)
	if(!reagent_to_extract)
		return ITEM_INTERACT_BLOCKING
	if(!container.reagents.add_reagent(reagent_to_extract, rand(5, 10)))
		to_chat(user, span_warning("[container] Está cheio."))
	user.visible_message(span_notice("[user] colheres [LOWER_TEXT(reagent_to_extract::name)] De [source] com [container]."), span_notice("Você vai embora.[LOWER_TEXT(reagent_to_extract::name)] De [source] usando [container]."))
	return ITEM_INTERACT_SUCCESS
