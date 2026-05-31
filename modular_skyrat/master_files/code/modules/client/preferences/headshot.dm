// Hey listen! Imgur doesn't actually work, it's been tested.

/datum/preference/text/headshot
	category = PREFERENCE_CATEGORY_CHARACTER_BASICS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "headshot"
	maximum_value_length = MAX_MESSAGE_LEN
	/// Assoc list of ckeys and their link, used to cut down on chat spam
	var/list/stored_link = list()
	var/static/link_regex = regex(@"i\.gyazo.com|.\.l3n\.co|static\.f-list\.net/images/|images2\.imgbox\.com|thumbs2\.imgbox\.com|files\.catbox\.moe") // Catbox, Imgbox, Gyazo, Lensdump, or F-List
	var/static/list/valid_extensions = list("jpg", "png", "jpeg") // Regex works fine, if you know how it works

/datum/preference/text/headshot/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["headshot"] = value

/datum/preference/text/headshot/is_valid(value)
	if(!length(value)) // Just to get blank ones out of the way
		return TRUE

	var/find_index = findtext(value, "https://")
	if(find_index != 1)
		to_chat(usr, span_warning("Seu link deve ser https!"))
		return

	if(!findtext(value, "."))
		to_chat(usr, span_warning("Link inválido!"))
		return
	var/list/value_split = splittext(value, ".")

	// extension will always be the last entry
	var/extension = value_split[length(value_split)]
	if(!(extension in valid_extensions))
		to_chat(usr, span_warning("A imagem deve ser uma das seguintes extensões:[english_list(valid_extensions)]'"))
		return

	find_index = findtext(value, link_regex)
	if(find_index != 9)
		to_chat(usr, span_warning("A imagem deve ser hospedada em um dos seguintes sites: \"Catbox, Imgbox, Gyazo, Lensdump, F-List\""))
		return

	apply_headshot(value)
	return TRUE

/datum/preference/text/headshot/proc/apply_headshot(value)
	if(stored_link[usr.ckey] != value)
		to_chat(usr, span_notice("Please use a relatively SFW image of the head and shoulder area to maintain immersion level. Think of it as a headshot for your ID. Lastly, [span_bold("do not use a real life photo or use any image that is less than serious.")]"))
		to_chat(usr, span_notice("Se a foto não aparecer corretamente no jogo, certifique-se de que é um link de imagem direta que abre corretamente em um navegador."))
		to_chat(usr, span_notice("Tenha em mente que a foto será reduzida para 250x250 pixels, então quanto mais quadrada a foto, melhor ela ficará."))
		log_game("[usr] has set their Headshot image to '[value]'.")
	stored_link[usr.ckey] = value
	return TRUE
