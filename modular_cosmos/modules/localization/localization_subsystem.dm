SUBSYSTEM_DEF(localization)
	name = "SSLocalization"

	var/list/languages = list()

	var/default_language = "pt_br"

/datum/controller/subsystem/localization/Initialize()
	if(!load_language(default_language))
		CRASH("Failed to load default language.")

	return SS_INIT_SUCCESS

/datum/controller/subsystem/localization/proc/load_language(language)

    if(languages[language])
        return TRUE

    var/list/cache = list()
    var/path = "localization/[language]"

    var/list/files = flist("[path]/")

    if(!length(files))
        world.log << "\[SSLocalization\] AVISO: Nenhum arquivo encontrado no diretório: [path]/"
        return FALSE

    for(var/file_name in files)
        if(!findtext(file_name, ".json"))
            continue

        var/full_path = "[path]/[file_name]"
        var/json_text = file2text(full_path)

        if(!json_text)
            world.log << "\[SSLocalization\] AVISO: Falha ao ler ou arquivo vazio: [full_path]"
            continue

        var/list/data = json_decode(json_text)

        if(!islist(data))
            world.log << "\[SSLocalization\] ERRO: JSON inválido em: [full_path]"
            continue

        var/category = replacetext(file_name, ".json", "")
        var/loaded_strings = 0

        for(var/key in data)
            var/value = data[key]
            if(istext(value))
                cache["[category].[key]"] = value
                loaded_strings++
            else if(islist(value))
                // Flatten nested objects into dot-notation keys
                var/list/sub_data = value
                for(var/sub_key in sub_data)
                    cache["[category].[key].[sub_key]"] = sub_data[sub_key]
                    loaded_strings++

        world.log << "\[SSLocalization\] Sucesso: Carregadas [loaded_strings] strings de [full_path]"

    languages[language] = cache
    return TRUE

/datum/controller/subsystem/localization/proc/get_string(language, key)
	if(language == "en")
		return null

	var/list/cache = languages[language]

	if(!cache)
		if(!load_language(language))
			cache = languages[default_language]
		else
			cache = languages[language]

	if(!cache)
		return null

	return cache[key]
