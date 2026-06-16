ADMIN_VERB(admin_change_map, R_SERVER, "Change Map", "Set the next map.", ADMIN_CATEGORY_SERVER)
	var/list/maprotatechoices = list()
	for (var/map in config.maplist)
		var/datum/map_config/virtual_map = config.maplist[map]
		var/mapname = virtual_map.map_name
		if (virtual_map == config.defaultmap)
			mapname += " (Default)"

		if (virtual_map.config_min_users > 0 || virtual_map.config_max_users > 0)
			mapname += " \["
			if (virtual_map.config_min_users > 0)
				mapname += "[virtual_map.config_min_users]"
			else
				mapname += "0"
			mapname += "-"
			if (virtual_map.config_max_users > 0)
				mapname += "[virtual_map.config_max_users]"
			else
				mapname += "inf"
			mapname += "\]"

		maprotatechoices[mapname] = virtual_map
	var/chosenmap = tgui_input_list(user, "Choose a map to change to", "Change Map", sort_list(maprotatechoices)|"Custom")
	if (isnull(chosenmap))
		return

	if(chosenmap == "Custom")
		message_admins("[key_name_admin(user)] is changing the map to a custom map")
		log_admin("[key_name(user)] is changing the map to a custom map")
		var/datum/map_config/virtual_map = new

		var/map_file = input(user, "Escolha o arquivo:", "Arquivo do mapa") as null|file
		if(isnull(map_file))
			return

		if(copytext("[map_file]", -4) != ".dmm")//4 == length(".dmm")
			to_chat(user, span_warning("O nome do arquiteto deve terminar em '.dmm':[map_file]"))
			return

		if(fexists("_maps/custom/[map_file]"))
			fdel("_maps/custom/[map_file]")
		if(!fcopy(map_file, "_maps/custom/[map_file]"))
			return
		// This is to make sure the map works so the server does not start without a map.
		var/datum/parsed_map/M = new (map_file)
		if(!M)
			to_chat(user, span_warning("Mapa.[map_file] Falharam em analiso Corretamente."))
			return

		if(!M.bounds)
			to_chat(user, span_warning("Mapa.[map_file]' tem limites não-existantes."))
			qdel(M)
			return

		qdel(M)
		var/config_file = null
		var/list/json_value = list()
		var/config = tgui_alert(user,"Gostaria de carregar uma configuração adicional para este mapa?", "Map Config", list("Yes", "No"))
		if(config == "Yes")
			config_file = input(user, "Pick file:", "Config JSON File") as null|file
			if(isnull(config_file))
				return
			if(copytext("[config_file]", -5) != ".json")
				to_chat(src, span_warning("O nome do arquivo deve terminar em 'Json':[config_file]"))
				return
			if(fexists("data/custom_map_json/[config_file]"))
				fdel("data/custom_map_json/[config_file]")
			if(!fcopy(config_file, "data/custom_map_json/[config_file]"))
				return

			json_value = virtual_map.LoadConfig("data/custom_map_json/[config_file]", TRUE)

			if(!json_value)
				to_chat(src, span_warning("Falha ao carregar a configuração:[config_file] Verifique se os campos estão preenchidos corretamente.\"caminho do mapa\": \"personalizado\"E\"arquivo map\": \"Seu nome mapa.\""))
				return
		else
			virtual_map = load_map_config()
			virtual_map.map_name = input(user, "Escolha o nome do mapa.", "Nome do mapa") as null|text
			if(isnull(virtual_map.map_name))
				virtual_map.map_name = "Custom"

			var/shuttles = tgui_alert(user,"Quer modificar como naves?", "Map Shuttles", list("Yes", "No"))
			if(shuttles == "Yes")
				for(var/s in virtual_map.shuttles)
					var/shuttle = input(user, s, "Naves de mapa") as null|text
					if(!shuttle)
						continue
					if(!SSmapping.shuttle_templates[shuttle])
						to_chat(user, span_warning("Nenhuma nave auxiliar como [shuttle]' existe, usando o padrão."))
						continue
					virtual_map.shuttles[s] = shuttle

			json_value = list(
				"version" = MAP_CURRENT_VERSION,
				"map_name" = virtual_map.map_name,
				"map_path" = CUSTOM_MAP_PATH,
				"map_file" = "[map_file]",
				"shuttles" = virtual_map.shuttles,
			)

		// If the file isn't removed text2file will just append.
		if(fexists(PATH_TO_NEXT_MAP_JSON))
			fdel(PATH_TO_NEXT_MAP_JSON)
		text2file(json_encode(json_value), PATH_TO_NEXT_MAP_JSON)

		if(SSmap_vote.set_next_map(virtual_map))
			message_admins("[key_name_admin(user)] has changed the map to [virtual_map.map_name]")
			SSmap_vote.admin_override = TRUE
		fdel("data/custom_map_json/[config_file]")
	else
		var/datum/map_config/virtual_map = maprotatechoices[chosenmap]
		message_admins("[key_name_admin(user)] is changing the map to [virtual_map.map_name]")
		log_admin("[key_name(user)] is changing the map to [virtual_map.map_name]")
		if (SSmap_vote.set_next_map(virtual_map))
			message_admins("[key_name_admin(user)] has changed the map to [virtual_map.map_name]")
			SSmap_vote.admin_override = TRUE

ADMIN_VERB(admin_revert_map, R_SERVER, "Revert Map Vote", "Revert the map vote, allowing a new vote.", ADMIN_CATEGORY_SERVER)
	SSmap_vote.revert_next_map(user)
