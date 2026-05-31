/obj/item/disk/bitrunning/prefs
	name = "DeForest biological simulation disk"
	desc = "Um disco contendo os dados de simulação biológica necessários para carregar caracteres personalizados em domínios de bits."

	w_class = WEIGHT_CLASS_SMALL

	var/datum/preferences/loaded_preference

	var/include_loadout = FALSE

/obj/item/disk/bitrunning/prefs/examine(mob/user)
	. = ..()
	if(!isnull(loaded_preference))
		var/name = loaded_preference.read_preference(/datum/preference/name/real_name)
		. += "It currently has the character [name] loaded, with loadouts [(include_loadout ? "enabled" : "disabled")]"
		. += span_notice("Ctrl-Clique para alterar carga de carga")

/obj/item/disk/bitrunning/prefs/item_ctrl_click(mob/user)
	include_loadout = !include_loadout // We just switch this around. Elegant!
	balloon_alert(user, include_loadout ? "Carregamento ativado" : "Carregamento desativado")

/obj/item/disk/bitrunning/prefs/attack_self(mob/user, modifiers)
	. = ..()

	var/list/prefdata_names = user.client.prefs?.create_character_profiles()
	if(isnull(prefdata_names))
		return

	var/response = tgui_alert(user, message = "Mudar prefs selecionados?", title = "Prefchange", buttons = list("Yes", "No"))
	if(isnull(response) || response == "No")
		return
	var/choice = tgui_input_list(user, message = "Select a character",  title = "Character selection", items = prefdata_names)
	if(isnull(choice) || !user.is_holding(src))
		return

	loaded_preference = new(user.client)
	loaded_preference.load_character(prefdata_names.Find(choice))

	balloon_alert(user, "conjunto de caracteres")
	to_chat(user, span_notice("Caracter definido para[choice]Com sucesso!"))

/datum/outfit/job/bitrunner
	r_pocket = /obj/item/disk/bitrunning/prefs

/datum/orderable_item/bitrunning_tech/pref_item
	cost_per_order = 500
	purchase_path = /obj/item/disk/bitrunning/prefs
	desc = "Este disco contém um programa que permite carregar em caracteres personalizados."
