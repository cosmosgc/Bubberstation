/obj/machinery/cell_charger/click_alt(mob/user)
	. = ..()
	if(. || !charging)
		return
	to_chat(user, span_notice("Você ativa a liberação rápida quando a célula sair!"))
	removecell(charging.forceMove(drop_location()))
	return CLICK_ACTION_SUCCESS

/obj/machinery/cell_charger/examine(mob/user)
	. = ..()
	. += span_notice("Alt clique para ligar a alavanca de ejeção!")
