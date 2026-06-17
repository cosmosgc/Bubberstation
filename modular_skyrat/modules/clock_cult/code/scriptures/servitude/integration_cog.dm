/datum/scripture/integration_cog
	name = "Integration Cog"
	desc = "Fabrica uma engrenagem de integração, que pode ser inserida em APCs para extrair poder e desbloquear escrituras."
	tip = "Install integration cogs into APCs to increase your energy stores and unlock new scriptures."
	button_icon_state = "Integration Cog"
	invocation_time = 1 SECONDS
	invocation_text = list("Tique-taque Eng'Ine...")
	category = SPELLTYPE_SERVITUDE

/datum/scripture/integration_cog/invoke_success()
	if(invoker.put_in_hands(new /obj/item/clockwork/integration_cog))
		to_chat(invoker, span_brass("Você convoca uma engrenagem de integração em suas mãos."))
		playsound(src, 'sound/machines/click.ogg', 50)
		return TRUE

	else
		to_chat(invoker, span_brass("Você convoca uma engrenagem de integração no chão."))
		playsound(src, 'sound/machines/click.ogg', 50)
		return FALSE
