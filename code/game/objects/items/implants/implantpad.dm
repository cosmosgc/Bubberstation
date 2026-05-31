/obj/item/implantpad//SKYRAT EDIT - ICON OVERRIDDEN BY AESTHETICS - SEE MODULE
	name = "implant pad"
	desc = "Usado para modificar implantes."
	icon = 'icons/obj/devices/tool.dmi'
	icon_state = "implantpad-0"
	base_icon_state = "implantpad"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	interaction_flags_click = FORBID_TELEKINESIS_REACH|ALLOW_RESTING

	///The implant case currently inserted into the pad.
	var/obj/item/implantcase/inserted_case

	/// The deathrattle group currently saved to the implantpad.
	var/datum/deathrattle_group/saved_deathrattle_group

/obj/item/implantpad/update_icon_state()
	icon_state = "[base_icon_state]-[!isnull(inserted_case)]"
	return ..()

/obj/item/implantpad/examine(mob/user)
	. = ..()
	if(!inserted_case)
		. += span_info("Está atualmente vazio.")
		return

	if(Adjacent(user))
		. += span_info("Ele contém\a [inserted_case].")
	else
		. += span_warning("Parece haver algo dentro, mas não dá para saber o que daqui...")
	. += span_info("Alt-click para remover[inserted_case].")

/obj/item/implantpad/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == inserted_case)
		inserted_case = null
		update_appearance(UPDATE_ICON)

/obj/item/implantpad/attackby(obj/item/implantcase/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	if(inserted_case || !istype(attacking_item))
		return ..()
	if(!user.transferItemToLoc(attacking_item, src))
		return
	user.balloon_alert(user, "Caso inserido")
	inserted_case = attacking_item
	update_static_data_for_all_viewers()
	update_appearance(UPDATE_ICON)

/obj/item/implantpad/click_alt(mob/user)
	remove_implant(user)
	return CLICK_ACTION_SUCCESS

/obj/item/implantpad/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "ImplantPad", name)
		ui.open()

/obj/item/implantpad/ui_data(mob/user)
	var/list/data = list()
	data["saved_deathrattle_group"] = saved_deathrattle_group ? saved_deathrattle_group.name : null
	data["current_deathrattle_group"] = null
	data["has_case"] = !!inserted_case
	if(!inserted_case)
		return data
	data["has_implant"] = !!inserted_case.imp
	if(inserted_case.imp)
		data["case_information"] = inserted_case.imp.get_data()
		data["case_lore"] = inserted_case.imp.get_lore()
		if(istype(inserted_case.imp, /obj/item/implant/deathrattle))
			var/obj/item/implant/deathrattle/inserted_deathrattle = inserted_case.imp
			if(inserted_deathrattle.current_group)
				data["current_deathrattle_group"] = inserted_deathrattle.current_group
	return data

/obj/item/implantpad/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	var/mob/user = usr
	if(action == "eject_implant")
		remove_implant(user)
		return
	if(action == "save_deathrattle_group")
		save_deathrattle_group(user)
	if(action == "set_deathrattle_group")
		set_deathrattle_group(user)
	if(action == "init_deathrattle_group")
		init_deathrattle_group(user)

///Removes the implant from the pad and puts it in the user's hands if possible.
/obj/item/implantpad/proc/remove_implant(mob/user)
	if(!inserted_case)
		user.balloon_alert(user, "Nenum caso dentro!")
		return FALSE
	add_fingerprint(user)
	inserted_case.add_fingerprint(user)
	user.put_in_hands(inserted_case)
	user.balloon_alert(user, "Caso removido")
	update_appearance(UPDATE_ICON)
	update_static_data_for_all_viewers()
	return TRUE

/// Saves the currently inserted implant's deathrattle group.
/obj/item/implantpad/proc/save_deathrattle_group(mob/user)
	if(!inserted_case)
		user.balloon_alert(user, "Nenum caso dentro!")
		return FALSE
	if(!istype(inserted_case.imp, /obj/item/implant/deathrattle))
		user.balloon_alert(user, "Implante incompatível!")
		return FALSE
	var/obj/item/implant/deathrattle/inserted_implant = inserted_case.imp
	var/datum/deathrattle_group/current_group = inserted_implant.current_group
	if(!current_group)
		user.balloon_alert(user, "Sem grupo ativo!")
		return FALSE
	saved_deathrattle_group = current_group
	user.balloon_alert(user, "Grupo Salvo[current_group.name]")
	update_static_data_for_all_viewers()
	return TRUE

/// Sets the currently inserted implant's deathrattle group to saved.
/obj/item/implantpad/proc/set_deathrattle_group(mob/user)
	if(!inserted_case)
		user.balloon_alert(user, "Nenum caso dentro!")
		return FALSE
	if(!saved_deathrattle_group)
		user.balloon_alert(user, "Nenhum grupo de batalha salva!")
		return FALSE
	if(!istype(inserted_case.imp, /obj/item/implant/deathrattle))
		user.balloon_alert(user, "Implante incompatível!")
		return FALSE
	var/obj/item/implant/deathrattle/inserted_implant = inserted_case.imp
	if(!istype(saved_deathrattle_group, inserted_implant.deathrattle_group_type))
		user.balloon_alert(user, "Grupo Deathrattle incompatível!")
		return FALSE
	saved_deathrattle_group.register(inserted_implant)
	user.balloon_alert(user, "Cadastrado no grupo.[saved_deathrattle_group.name]")
	inserted_case.name = "[initial(inserted_case.name)] - [saved_deathrattle_group.name]"
	update_static_data_for_all_viewers()
	return TRUE

/// Initializes and saves a new deathrattle group, then registers the current implant to it.
/obj/item/implantpad/proc/init_deathrattle_group(mob/user)
	if(!inserted_case)
		user.balloon_alert(user, "Nenum caso dentro!")
		return FALSE
	if(!istype(inserted_case.imp, /obj/item/implant/deathrattle))
		user.balloon_alert(user, "Implante incompatível!")
		return FALSE
	var/obj/item/implant/deathrattle/inserted_implant = inserted_case.imp
	if(inserted_implant.current_group)
		user.balloon_alert(user, "O grupo já está pronto!")
		return FALSE
	// init and save new group
	saved_deathrattle_group = new inserted_implant.deathrattle_group_type
	// register current implant
	saved_deathrattle_group.register(inserted_implant)
	user.balloon_alert(user, "Cadastrado em um novo grupo.[saved_deathrattle_group.name]")
	inserted_case.name += " - [saved_deathrattle_group.name]"
	update_static_data_for_all_viewers()
	return TRUE
