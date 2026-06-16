///Energy used to say an error message.
#define ENERGY_TO_SPEAK (0.001 * STANDARD_CELL_CHARGE)

/**
 * # N-spect scanner
 *
 * Determines if an item or its contents are contraband.
 */
/obj/item/inspector
	name = "\improper N-spect scanner"
	desc = "Sistema de inspeção do Comando Central. Usado para varreduras de precisão para determinar se um item contém, ou é, contrabando."
	icon = 'icons/obj/devices/scanner.dmi'
	icon_state = "inspector"
	worn_icon_state = "salestagger"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	interaction_flags_click = NEED_DEXTERITY
	throw_range = 1
	throw_speed = 1
	sound_vary = TRUE
	pickup_sound = SFX_GENERIC_DEVICE_PICKUP
	drop_sound = SFX_GENERIC_DEVICE_DROP
	///Power cell used to power the scanner. Paths g
	var/obj/item/stock_parts/power_store/cell = /obj/item/stock_parts/power_store/cell/crap
	///Cell cover status
	var/cell_cover_open = FALSE
	///Does this item scan for contraband correctly? If not, will provide a flipped response.
	var/scans_correctly = TRUE

/obj/item/inspector/Initialize(mapload)
	. = ..()
	if(ispath(cell))
		cell = new cell(src)
	register_context()
	register_item_context()

// Clean up the cell on destroy
/obj/item/inspector/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == cell)
		cell = null

// support for items that interact with the cell
/obj/item/inspector/get_cell()
	return cell

/obj/item/inspector/crowbar_act(mob/living/user, obj/item/tool)
	cell_cover_open = !cell_cover_open
	balloon_alert(user, "[cell_cover_open ? "opened" : "closed"]Cobertura celular")
	return ITEM_INTERACT_SUCCESS

/obj/item/inspector/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(cell_cover_open && istype(tool, /obj/item/stock_parts/power_store/cell))
		if(cell)
			to_chat(user, span_warning("[src] Já tem um celular instalado."))
			return ITEM_INTERACT_BLOCKING
		if(user.transferItemToLoc(tool, src))
			cell = tool
			to_chat(user, span_notice("Você instalou com sucesso.\the [cell] Em [src]."))
			return ITEM_INTERACT_SUCCESS
		return ITEM_INTERACT_BLOCKING
	return NONE

/obj/item/inspector/item_ctrl_click(mob/user)
	if(!cell_cover_open || !cell)
		return CLICK_ACTION_BLOCKING
	user.visible_message(span_notice("[user] Remover\the [cell] De [src]!"), 		span_notice("Você tira.[cell]."))
	cell.add_fingerprint(user)
	user.put_in_hands(cell)
	cell = null
	return CLICK_ACTION_SUCCESS

/obj/item/inspector/examine(mob/user)
	. = ..()
	. += span_info("Use na mão para verificar a área local, criando uma inspeção de segurança criptografada.")
	. += span_info("Use em um item para verificar se ele contém, ou é, contrabando.")
	if(!cell_cover_open)
		. += span_notice("A cobertura da cela está fechada. Parece que pode ser.<strong>Invadido</strong>fora, mas fazer isso exigiria uma ferramenta apropriada.")
		return
	. += span_notice("Sua cobertura celular está aberta, expondo o espaço celular. Parece que pode ser.<strong>Invadido</strong>Mas fazer isso exigiria uma ferramenta apropriada.")
	if(!cell)
		. += span_notice("O espaço para uma cela está vazio.")
	else
		. += span_notice("\The [cell] está firmemente no lugar. Ctrl-clique com uma mão vazia para removê-la.")

/obj/item/inspector/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!user.Adjacent(interacting_with))
		return ITEM_INTERACT_BLOCKING
	if(cell_cover_open)
		balloon_alert(user, "Decorra primeiro!")
		return ITEM_INTERACT_BLOCKING
	if(!cell || !cell.use(0.001 * STANDARD_CELL_CHARGE))
		balloon_alert(user, "Cheque o celular!")
		return ITEM_INTERACT_BLOCKING

	if(iscarbon(interacting_with)) // Prevents scanning people
		return ITEM_INTERACT_BLOCKING

	if(contraband_scan(interacting_with, user))
		playsound(src, 'sound/machines/uplink/uplinkerror.ogg', 40)
		balloon_alert(user, "Contrabando detetado!")
		return ITEM_INTERACT_SUCCESS

	playsound(src, 'sound/machines/ping.ogg', 20)
	balloon_alert(user, "clear")
	return ITEM_INTERACT_SUCCESS

/obj/item/inspector/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	var/update_context = FALSE
	if(cell_cover_open && cell)
		context[SCREENTIP_CONTEXT_CTRL_LMB] = "Remove cell"
		update_context = TRUE

	if(cell_cover_open && !cell && istype(held_item, /obj/item/stock_parts/power_store/cell))
		context[SCREENTIP_CONTEXT_LMB] = "Install cell"
		update_context = TRUE

	if(held_item?.tool_behaviour == TOOL_CROWBAR)
		context[SCREENTIP_CONTEXT_LMB] = "[cell_cover_open ? "close" : "open"] battery panel"
		update_context = TRUE

	if(update_context)
		return CONTEXTUAL_SCREENTIP_SET
	return NONE

/obj/item/inspector/add_item_context(obj/item/source, list/context, atom/target, mob/living/user)
	if(cell_cover_open || !cell)
		return NONE
	if(isitem(target))
		context[SCREENTIP_CONTEXT_LMB] = "Contraband Scan"
		return CONTEXTUAL_SCREENTIP_SET
	return NONE

/**
 * Scans the carbon or item for contraband.
 *
 * Arguments:
 * - scanned - what or who is scanned?
 * - user - who is performing the scanning?
 */
/obj/item/inspector/proc/contraband_scan(scanned, user)
	if(iscarbon(scanned))
		var/mob/living/carbon/scanned_carbon = scanned
		for(var/obj/item/content in scanned_carbon.get_all_contents_skipping_traits(TRAIT_CONTRABAND_BLOCKER))
			var/contraband_content = content.is_contraband()
			if((contraband_content && scans_correctly) || (!contraband_content && !scans_correctly))
				return TRUE

	if(isitem(scanned))
		var/obj/item/contraband_item = scanned
		var/contraband_status = contraband_item.is_contraband()
		if((contraband_status && scans_correctly) || (!contraband_status && !scans_correctly))
			return TRUE

	return FALSE

#undef ENERGY_TO_SPEAK
