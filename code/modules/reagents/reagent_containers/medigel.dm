// Gel skins
/datum/atom_skin/med_gel
	abstract_type = /datum/atom_skin/med_gel

/datum/atom_skin/med_gel/blue
	preview_name = "Blue"
	new_icon_state = "medigel_blue"

/datum/atom_skin/med_gel/cyan
	preview_name = "Cyan"
	new_icon_state = "medigel_cyan"

/datum/atom_skin/med_gel/green
	preview_name = "Green"
	new_icon_state = "medigel_green"

/datum/atom_skin/med_gel/red
	preview_name = "Red"
	new_icon_state = "medigel_red"

/datum/atom_skin/med_gel/orange
	preview_name = "Orange"
	new_icon_state = "medigel_orange"

/datum/atom_skin/med_gel/purple
	preview_name = "Purple"
	new_icon_state = "medigel_purple"

/obj/item/reagent_containers/medigel
	name = "medical gel"
	desc = "Um frasco aplicador de gel médico, projetado para aplicação de precisão, com uma tampa inescrevível."
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "medigel"
	inhand_icon_state = "spraycan"
	worn_icon_state = "spraycan"
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	item_flags = NOBLUDGEON
	obj_flags = UNIQUE_RENAME
	initial_reagent_flags = OPENCONTAINER | NO_SPLASH
	slot_flags = ITEM_SLOT_BELT
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 3
	throw_range = 7
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(5,10)
	volume = 60
	var/can_fill_from_container = TRUE
	var/apply_type = PATCH
	var/apply_method = "spray" //the thick gel is sprayed and then dries into patch like film.
	var/self_delay = 30
	custom_price = PAYCHECK_CREW * 2

/obj/item/reagent_containers/medigel/setup_reskins()
	if(icon_state == "medigel") // oh yeah baby raw icon state check to make sure we can't reskin preset gels
		AddComponent(/datum/component/reskinable_item, /datum/atom_skin/med_gel)

/obj/item/reagent_containers/medigel/mode_change_message(mob/user)
	var/squirt_mode = amount_per_transfer_from_this == initial(amount_per_transfer_from_this)
	to_chat(user, span_notice("Agora você vai aplicar o conteúdo do Medigel em[squirt_mode ? "extended sprays":"short bursts"]Agora você vai usar[amount_per_transfer_from_this]Unidades por uso."))

/obj/item/reagent_containers/medigel/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return NONE
	if(!reagents || !reagents.total_volume)
		to_chat(user, span_warning("[src]Está vazio!"))
		return ITEM_INTERACT_BLOCKING

	user.changeNext_move(CLICK_CD_MELEE)
	if(interacting_with == user)
		interacting_with.visible_message(span_notice("[user]Tentando[apply_method] [src]Vamos.[user.p_them()]Eu."))
		if(self_delay)
			if(!do_after(user, self_delay, interacting_with))
				return ITEM_INTERACT_BLOCKING
			if(!reagents || !reagents.total_volume)
				return ITEM_INTERACT_BLOCKING
		to_chat(interacting_with, span_notice("Você.[apply_method]você mesmo com[src]."))

	else
		log_combat(user, interacting_with, "attempted to apply", src, reagents.get_reagent_log_string())
		interacting_with.visible_message(
			span_danger("[user]Tentando[apply_method] [src]Vamos.[interacting_with]."),
			span_userdanger("[user]Tentando[apply_method] [src]Você."),
		)
		if(!do_after(user, CHEM_INTERACT_DELAY(3 SECONDS, user), interacting_with))
			return ITEM_INTERACT_BLOCKING
		if(!reagents || !reagents.total_volume)
			return ITEM_INTERACT_BLOCKING
		interacting_with.visible_message(
			span_danger("[user] [apply_method]S[interacting_with]Abaixo com[src]."),
			span_userdanger("[user] [apply_method]Você está com[src]."),
		)

	log_combat(user, interacting_with, "applied", src, reagents.get_reagent_log_string())
	playsound(src, 'sound/effects/spray.ogg', 30, TRUE, -6)
	reagents.trans_to(interacting_with, amount_per_transfer_from_this, transferred_by = user, methods = apply_type)
	return ITEM_INTERACT_SUCCESS

/obj/item/reagent_containers/medigel/libital
	name = "medical gel (libital)"
	desc = "Um frasco aplicador de gel médico, projetado para aplicação de precisão, com uma tampa inescrevível. Este contém libital, para tratar cortes e hematomas. Libital causa pequenos danos no fígado. Diluída com granibitaluri."
	icon_state = "brutegel"
	list_reagents = list(/datum/reagent/medicine/c2/libital = 24, /datum/reagent/medicine/granibitaluri = 36)

/obj/item/reagent_containers/medigel/aiuri
	name = "medical gel (aiuri)"
	desc = "Um frasco aplicador de gel médico, projetado para aplicação de precisão, com uma tampa inescrevível. Este contém aiuri, útil para tratar queimaduras. Aiuri causa danos oculares menores. Diluída com granibitaluri."
	icon_state = "burngel"
	list_reagents = list(/datum/reagent/medicine/c2/aiuri = 24, /datum/reagent/medicine/granibitaluri = 36)

/obj/item/reagent_containers/medigel/synthflesh
	name = "medical gel (synthflesh)"
	desc = "Um frasco aplicador de gel médico, projetado para aplicação de precisão, com uma tampa inescrevível. Este contém carne sintética, um medicamento ligeiramente tóxico capaz de curar hematomas, queimaduras e cascas."
	icon_state = "synthgel"
	list_reagents = list(/datum/reagent/medicine/c2/synthflesh = 60)
	list_reagents_purity = 1
	amount_per_transfer_from_this = 60
	possible_transfer_amounts = list(5, 10, 60)
	custom_price = PAYCHECK_CREW * 5

/obj/item/reagent_containers/medigel/synthflesh/examine(mob/user)
	. = ..()
	if(reagents.total_volume >= 60)
		. += span_info("Uma garrafa cheia pode restaurar um cadáver descascado por queimaduras.")

/obj/item/reagent_containers/medigel/synthflesh/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(iscarbon(interacting_with) && reagents?.total_volume)
		var/mob/living/carbon/carbies = interacting_with
		if(HAS_TRAIT_FROM(carbies, TRAIT_HUSK, BURN) && carbies.get_fire_loss() > UNHUSK_DAMAGE_THRESHOLD * 2.5)
			// give them a warning if the mob is a husk but synthflesh won't unhusk yet
			carbies.visible_message(span_boldwarning("[carbies]As queimaduras precisam ser reparadas antes que o Synthflesh desperte!"))

	return ..()

/obj/item/reagent_containers/medigel/sterilizine
	name = "sterilizer gel"
	desc = "Garrafa de gel carregada com esterilizador não tóxico. Útil em preparação para cirurgia."
	icon_state = "medigel_blue"
	list_reagents = list(/datum/reagent/space_cleaner/sterilizine = 60)
	custom_price = PAYCHECK_CREW * 2
