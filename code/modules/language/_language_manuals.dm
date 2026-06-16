/obj/item/language_manual
	icon = 'icons/obj/service/library.dmi'
	icon_state = "book2"
	/// Number of charges the book has, limits the number of times it can be used.
	var/charges = 1
	/// Path to a language datum that the book teaches.
	var/datum/language/language = /datum/language/common
	/// Flavour text to display when the language is successfully learned.
	var/flavour_text = "suddenly your mind is filled with codewords and responses"

/obj/item/language_manual/attack_self(mob/living/user)
	if(!isliving(user))
		return

	if(user.has_language(language))
		to_chat(user, span_boldwarning("Você começa a passar [src] Mas você já sabe [initial(language.name)]."))
		return

	to_chat(user, span_bolddanger("Você começa a passar [src], e [flavour_text]."))

	user.grant_language(language)
	user.remove_blocked_language(language, source=LANGUAGE_ALL)
	ADD_TRAIT(user.mind, TRAIT_TOWER_OF_BABEL, MAGIC_TRAIT) // this makes you immune to babel effects

	use_charge(user)

/obj/item/language_manual/attack(mob/living/M, mob/living/user)
	if(!istype(M) || !istype(user))
		return
	if(M == user)
		attack_self(user)
		return

	playsound(loc, SFX_PUNCH, 25, TRUE, -1)

	if(M.stat == DEAD)
		M.visible_message(span_danger("[user] Strocks.[M] O cadáver sem vida com [src]."), span_userdanger("[user] Bate no seu cadáver sem vida com [src]."), span_hear("Você ouve batidas."))
	else if(M.has_language(language))
		M.visible_message(span_danger("[user] Batidas.[M] sobre a cabeça com [src]!"), span_userdanger("[user] Bate na sua cabeça com [src]!"), span_hear("Você ouve batidas."))
	else
		M.visible_message(span_notice("[user] Ensina.[M] Batendo.[M.p_them()] sobre a cabeça com [src]!"), span_boldnotice("Como [user] Bate em você com [src], [flavour_text]."), span_hear("Você ouve batidas."))
		M.grant_language(language, source = LANGUAGE_MIND)
		use_charge(user)

/obj/item/language_manual/proc/use_charge(mob/user)
	charges--
	if(!charges)
		user.visible_message(span_notice("A capa de [user] O livro começa a mudar e mudar! Ele cai de [user.p_their()] Mãos!"),
							span_warning("A capa e o conteúdo de [src] Comece a mudar e mudar! Ele escapa de suas mãos!"))
		new /obj/item/book/manual/random(get_turf(src))
		qdel(src)

/obj/item/language_manual/codespeak_manual
	name = "codespeak manual"
	desc = "A capa do livro diz:\"Proteja sua comunicação com metáforas tão elaboradas, que parecem geradas aleatoriamente!\""
	language = /datum/language/codespeak
	flavour_text = "De repente sua mente está cheia de palavras de código e respostas."

/obj/item/language_manual/codespeak_manual/unlimited
	name = "deluxe codespeak manual"
	charges = INFINITY

/obj/item/language_manual/roundstart_species

/obj/item/language_manual/roundstart_species/Initialize(mapload)
	. = ..()
	var/list/available_languages = length(GLOB.uncommon_roundstart_languages) ? GLOB.uncommon_roundstart_languages : list(/datum/language/common)
	language = pick(available_languages)
	name = "[initial(language.name)] manual"
	desc = "A capa do livro diz:\"[initial(language.name)] Para Xenos, aprender línguas galácticas comuns em segundos.\""
	flavour_text = "Você se sente empoderado com um domínio sobre[initial(language.name)]"

/obj/item/language_manual/roundstart_species/unlimited
	charges = INFINITY

/obj/item/language_manual/roundstart_species/unlimited/Initialize(mapload)
	. = ..()
	name = "deluxe [initial(language.name)] manual"

/obj/item/language_manual/roundstart_species/five
	charges = 5

/obj/item/language_manual/roundstart_species/five/Initialize(mapload)
	. = ..()
	name = "extended [initial(language.name)] manual"

/obj/item/language_manual/piratespeak
	name = "\improper Captain Pete's Guide to Pirate Lingo"
	icon_state = "book_pirate"
	desc = "Um livro contendo todo o conhecimento, jargão e palavrões para falar como um verdadeiro velho sal."
	language = /datum/language/piratespeak
	flavour_text = "Caramba! Eu sinto muito, agora."
	charges = 5

// So drones can teach borgs and AI dronespeak. For best effect, combine with mother drone lawset.
/obj/item/language_manual/dronespeak_manual
	name = "dronespeak manual"
	desc = "A capa do livro diz:\"Entendendo Dronespeak, um exercício de futilidade.\"O livro é escrito inteiramente em binário, não-silicons provavelmente não vai entender."
	language = /datum/language/drone
	flavour_text = "De arrependimento o barulho do drone faz sentido."
	charges = INFINITY

/obj/item/language_manual/dronespeak_manual/attack(mob/living/M, mob/living/user)
	// If they are not drone or silicon, we don't want them to learn this language.
	if(!(isdrone(M) || issilicon(M)))
		M.visible_message(span_danger("[user] Batidas.[M] sobre a cabeça com [src]!"), span_userdanger("[user] Bate na sua cabeça com [src]!"), span_hear("Você ouve batidas."))
		return

	return ..()

/obj/item/language_manual/dronespeak_manual/attack_self(mob/living/user)
	if(!(isdrone(user) || issilicon(user)))
		to_chat(user, span_danger("Você se bate na cabeça com [src]!"))
		return

	return ..()
