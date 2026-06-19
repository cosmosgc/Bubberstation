/proc/localize(language, key)
	return SSlocalization.get_string(language, key)

/proc/typepath_to_locale_key(typepath)
    var/key = replacetext("[typepath]", "/", ".")

    if(key[1] == ".")
        key = copytext(key, 2)
    return key

/obj/item/Initialize(mapload)
	. = ..()




/obj/item/get_examine_name(mob/user)
	var/lang = get_player_language(user)
	var/old_name = name
	var/old_desc = desc

	name = get_localized_name(lang) || name
	desc = get_localized_desc(lang) || desc
	. = ..()

	name = old_name
	desc = old_desc


/obj/item/examine(mob/user)
	var/lang = get_player_language(user)
	var/old_name = name
	var/old_desc = desc
	name = get_localized_name(lang) || name
	desc = get_localized_desc(lang) || desc

	. = ..()
	name = old_name
	desc = old_desc

/obj/proc/get_localized_name(language)
	var/key = "items.[typepath_to_locale_key(type)].name"
	return localize(language, key)

/obj/proc/get_localized_desc(language)
	var/key = "items.[typepath_to_locale_key(type)].desc"
	return localize(language, key)

/atom/proc/get_player_language(mob/user)
	if(user && user.client && user.client.language)
		return user.client.language
	return SSlocalization.default_language
