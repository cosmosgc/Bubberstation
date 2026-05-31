/obj/item/skillchip/musical
	name = "\improper Old Copy of \"Space Station 13: The Musical\""
	desc = "Uma velha cópia de\"Estação Espacial 13: O Musical\", correu no 100o aniversário da estação ... Ou talvez fosse o 200o?"
	skill_name = "Memory of a Musical"
	skill_description = "Permite que você atinja aquela nota alta, como aqueles que vieram um século antes de nós."
	skill_icon = FA_ICON_MUSIC
	activate_message = span_notice("Você sente como se pudesse cantar um somooong! \u266B")
	deactivate_message = span_notice("O musical desaparece da sua mente, deixando você com uma sensação de nostalgia.")
	custom_premium_price = PAYCHECK_CREW * 4

/obj/item/skillchip/musical/Initialize(mapload, is_removable)
	. = ..()
	name = replacetext(name, "Old", round(CURRENT_STATION_YEAR - pick(50, 100, 150, 200, 250), 5))

/obj/item/skillchip/musical/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	RegisterSignal(user, COMSIG_MOB_SAY, PROC_REF(make_music))

/obj/item/skillchip/musical/on_deactivate(mob/living/carbon/user, silent)
	. = ..()
	UnregisterSignal(user, COMSIG_MOB_SAY)

/obj/item/skillchip/musical/proc/make_music(mob/living/carbon/source, list/say_args)
	SIGNAL_HANDLER

	var/raw_message = say_args[SPEECH_MESSAGE]
	var/list/words = splittext(raw_message, " ")
	if(length(words) <= 1)
		say_args[SPEECH_MODS][MODE_SING] = TRUE
		return
	var/last_word = words[length(words)]
	var/num_chars = length_char(last_word)
	var/last_vowel = ""
	// find the last vowel present in the word
	for(var/i in 1 to num_chars)
		var/char = copytext_char(last_word, i, i + 1)
		if(char in VOWELS)
			last_vowel = char

	// now we'll reshape the final word to make it sound like they're singing it
	var/final_word = ""
	var/has_ellipsis = copytext(last_word, -3) == "..."
	for(var/i in 1 to num_chars)
		var/char = copytext_char(last_word, i, i + 1)
		// replacing any final periods with exclamation marks (so long as it's not an ellipsis)
		if(char == "." && i == num_chars && !has_ellipsis)
			final_word += "!"
		// or if it's the vowel we found, we're gonna repeat it a few times (holding the note)
		else if(char == last_vowel)
			for(var/j in 1 to 4)
				final_word += char
			// if we dragged out the last character of the word, just period it
			if(i == num_chars)
				final_word += "."
		// no special handing otherwise
		else
			final_word += char

	if(!has_ellipsis)
		// adding an extra exclamation mark at the end if there's no period
		var/last_char = copytext_char(final_word, -1)
		if(last_char != ".")
			final_word += "!"

	words[length(words)] = final_word
	// now we siiiiiiing
	say_args[SPEECH_MESSAGE] = jointext(words, " ")
	say_args[SPEECH_MODS][MODE_SING] = TRUE

/obj/item/skillchip/musical/examine(mob/user)
	. = ..()
	. += span_tinynoticeital("Parece que caberia em um adaptador.")

/obj/item/skillchip/musical/examine_more(mob/user)
	. = ..()
	var/list/songs = list()
	songs += "&bull; \"The Ballad of Space Station 13\""
	songs += "&bull; \"The Captain's Call\""
	songs += "&bull; \"A Mime's Lament\""
	songs += "&bull; \"Banned from Cargo\""
	songs += "&bull; \"Botany Blues\""
	songs += "&bull; \"Clown Song\""
	songs += "&bull; \"Elegy to an Engineer\""
	songs += "&bull; \"Medical Malpractitioner\""
	songs += "&bull; \"Security Strike\""
	songs += "&bull; \"Send for the Shuttle\""
	songs += "&bull;  And one song scratched out..."

	. += span_notice("<i>Na parte de trás do chip, você vê uma lista de músicas:</i>")
	. += span_smallnotice("<i>[jointext(songs, "<br>")]</i>")
