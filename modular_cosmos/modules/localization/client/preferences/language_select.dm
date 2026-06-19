/client/var/language = "pt_br"

/datum/preference/choiced/language_select
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "language_select"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/choiced/language_select/init_possible_values()
	var/list/allowed_langs = list("en")

	var/list/raw_files = flist("localization/")

	for(var/folder in raw_files)
		if(findtext(folder, "/"))
			var/lang_folder = replacetext(folder, "/", "")

			if(lang_folder != "en")
				allowed_langs += lang_folder

	return allowed_langs

/datum/preference/choiced/language_select/create_default_value()
	return "pt_br"

/datum/preference/choiced/language_select/apply_to_client_updated(client/client, value)
	if(client)
		client.language = value
