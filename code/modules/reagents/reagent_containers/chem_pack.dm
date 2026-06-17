/obj/item/reagent_containers/chem_pack
	name = "intravenous medicine bag"
	desc = "Um saco de pressão plástico, ou \"pacote químico\", para administração intravenosa de drogas. Está equipado com uma faixa termosselante."
	icon = 'icons/obj/medical/bloodpack.dmi'
	icon_state = "chempack"
	volume = 100
	initial_reagent_flags = OPENCONTAINER
	obj_flags = UNIQUE_RENAME
	resistance_flags = ACID_PROOF
	fill_icon_thresholds = list(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
	has_variable_transfer_amount = FALSE
	interaction_flags_click = NEED_DEXTERITY

/obj/item/reagent_containers/chem_pack/click_alt(mob/living/user)
	if(reagents.flags & SEALED_CONTAINER)
		balloon_alert(user, "Já selada!")
		return CLICK_ACTION_BLOCKING

	if(iscarbon(user) && (HAS_TRAIT(user, TRAIT_CLUMSY) && prob(50)))
		to_chat(user, span_warning("Uh... whoops! Você acidentalmente derramou o conteúdo do saco em si mesmo."))
		splash_reagents(user, user, allow_closed_splash = TRUE)
		return CLICK_ACTION_BLOCKING

	update_container_flags(SEALED_CONTAINER | DRAWABLE | INJECTABLE)
	balloon_alert(user, "sealed")
	return CLICK_ACTION_SUCCESS

/obj/item/reagent_containers/chem_pack/examine()
	. = ..()
	if(reagents.flags & SEALED_CONTAINER)
		. += span_notice("A bolsa está fechada.")
	else
		. += span_notice("Alt-click para selar.")
