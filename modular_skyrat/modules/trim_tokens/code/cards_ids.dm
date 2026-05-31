// Proc to use a trim token on an ID
/obj/item/card/id/proc/apply_token(obj/item/trim_token/token, mob/user)
	if(token.has_required_trim)
		if(!(src.trim in token.valid_trims))
			to_chat(user, span_warning("O corte da sua identidade não é válido para este símbolo."))
			return
	if(token.uses == 0)
		to_chat(user, span_warning("O[token.name]Se desintegra enquanto você pressiona contra sua identidade, provavelmente só tinha carga suficiente para manter sua forma!"))
		qdel(token)
		return

	// Just to make sure to give feedback if it requires a better card to grant the trim.
	if(SSid_access.apply_trim_to_card(src, token.token_trim, copy_access = token.force_access))
		playsound(src, token.usesound, 40)
		to_chat(user, span_notice("O[token.name]se funde com sua identidade, substituindo seu corte por um[token.assignment]Aparar!"))
		if(token.uses > 0)
			token.uses -= 1
		if(token.uses == 0)
			qdel(token)
			return
		to_chat(user, span_notice("O[token.name]reformas em um símbolo sólido diante de seus olhos, depois de ter substituído com sucesso o corte de sua identidade. Ótimo."))
		return
	else
		to_chat(user, span_warning("Sua identidade não é rara o suficiente para apoiar essa atualização!"))
