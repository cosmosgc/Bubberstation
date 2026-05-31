/obj/item/toy/plush/attack_self(mob/user)
	. = ..()
	if(stuffed)
		if(HAS_TRAIT(user, TRAIT_MONOPHOBIA))
			to_chat(user, span_notice("Sente seu coração se aquecendo... Você não se sente tão sozinha."))

	else
		if(HAS_TRAIT(user, TRAIT_MONOPHOBIA))
			to_chat(user, span_warning("Lembra que mesmo companheiros costurados não podem parar a solidão se acumulando dentro do seu coração..."))
