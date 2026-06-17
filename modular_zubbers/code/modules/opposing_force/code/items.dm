/obj/item/codeword_granter
	name = "codeword manual"
	desc = "Um manual preto com um vermelho escrito na capa por apenas as melhores prensas de uma fábrica."
	icon = 'modular_zubbers/code/modules/opposing_force/icons/items.dmi'
	icon_state = "codeword_book"
	/// Number of charges the book has, limits the number of times it can be used.
	charges = 1


/obj/item/codeword_granter/attack_self(mob/living/user)
	if(!isliving(user))
		return

	to_chat(user, span_boldannounce("You start skimming through [src], and feel suddenly imparted with the knowledge of the following code words:"))

	user.AddComponent(/datum/component/codeword_hearing, GLOB.syndicate_code_phrase_regex, "blue", src)
	user.AddComponent(/datum/component/codeword_hearing, GLOB.syndicate_code_response_regex, "red", src)
	to_chat(user, "<b>Code Phrases</b>: [jointext(GLOB.syndicate_code_phrase, ", ")]")
	to_chat(user, "<b>Code Responses</b>: [span_red("[jointext(GLOB.syndicate_code_response, ", ")]")]")

	use_charge(user)


/obj/item/codeword_granter/attack(mob/living/attacked_mob, mob/living/user)
	if(!istype(attacked_mob) || !istype(user))
		return

	if(attacked_mob == user)
		attack_self(user)
		return

	playsound(loc, SFX_PUNCH, 25, TRUE, -1)

	if(attacked_mob.stat == DEAD)
		attacked_mob.visible_message(span_danger("[user] smacks [attacked_mob]'s lifeless corpse with [src]."), span_userdanger("[user] smacks your lifeless corpse with [src]."), span_hear("Você ouve batidas."))
	else
		attacked_mob.visible_message(span_notice("[user] teaches [attacked_mob] by beating [attacked_mob.p_them()] over the head with [src]!"), span_boldnotice("As [user] hits you with [src], you feel suddenly imparted with the knowledge of some [span_red("specific words")]."), span_hear("Você ouve batidas."))
		attacked_mob.AddComponent(/datum/component/codeword_hearing, GLOB.syndicate_code_phrase_regex, "blue", src)
		attacked_mob.AddComponent(/datum/component/codeword_hearing, GLOB.syndicate_code_response_regex, "red", src)
		to_chat(attacked_mob, span_boldnotice("Você se sente de repente transmitido com o conhecimento das seguintes palavras de código:"))
		to_chat(attacked_mob, "<b>Code Phrases</b>: [span_blue("[jointext(GLOB.syndicate_code_phrase, ", ")]")]")
		to_chat(attacked_mob, "<b>Code Responses</b>: [span_red("[jointext(GLOB.syndicate_code_response, ", ")]")]")
		use_charge(user)


/obj/item/codeword_granter/use_charge(mob/user)
	charges--

	if(!charges)
		var/turf/src_turf = get_turf(src)
		src_turf.visible_message(span_warning("The cover and contents of [src] start shifting and changing! It slips out of your hands!"))
		new /obj/item/book/manual/random(src_turf)
		qdel(src)


/obj/item/antag_granter/changeling
	name = "viral injector"
	desc = "Um injetor azul cheio de substância viscosa e vermelha. Não tem marcas além de uma faixa de aviso laranja perto da agulha grande."
	icon_state = "changeling_injector"
	antag_datum = /datum/antagonist/changeling
	user_message = "Como você injeta a substância em si mesmo, você começa a sentir...<span class='red'><b>Melhor.</b></span>."


/obj/item/antag_granter/heretic
	name = "strange book"
	desc = "Um livro roxo com um olho verde na capa. Você jura que está olhando para você..."
	icon_state = "heretic_granter"
	antag_datum = /datum/antagonist/heretic
	user_message = "Ao abrir o livro, você vê um grande flash como<span class='hypnophrase'>O mundo se torna mais claro para você.</span>."

/obj/item/antag_granter/clock_cultist
	name = "brass contraption"
	desc = "Um dispositivo em forma de engrenagem de latão, com uma lente de vidro flutuando, suspenso no centro."
	icon = 'modular_skyrat/modules/clock_cult/icons/clockwork_objects.dmi'
	icon_state = "vanguard_cogwheel"
	antag_datum = /datum/antagonist/clock_cultist/solo
	user_message = "Um zumbido enche seus ouvidos como<span class='brass'>O conhecimento de Sua Eminência enche sua mente.</span>."

/obj/item/antag_granter/clock_cultist/attack_self(mob/user, modifiers)
	. = ..()
	if(!.)
		return FALSE

	var/obj/item/clockwork/clockwork_slab/slab = new
	user.put_in_hands(slab, FALSE)
