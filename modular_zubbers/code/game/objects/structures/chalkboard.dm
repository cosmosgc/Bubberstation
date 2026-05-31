/obj/structure/chalkboard
	name = "Chalkboard"
	icon = 'modular_zubbers/icons/obj/structures/chalkboard.dmi'
	icon_state = "chalkboard"
	maptext_width = 64
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 20)
	//The text that is written on the chalkboard. Cleared when erased.
	var/written_text = ""
	//This is a Chalkboard.

/obj/structure/chalkboard/examine(mob/user)
	. = ..()
	. += "A board used by professors and old folk to lecture."
	if(written_text)
		. += "It reads:\n"
		. += "[written_text]\n"
		. += "Right-click with an open hand to erase."

//We want people to be able to write on it, so a left click interaction.
/obj/structure/chalkboard/attackby(obj/item/attacking_item, mob/user)
	. = ..()
	//We begin by allowing our player to write on the chalkboard using the white crayon.
	if(istype(attacking_item, /obj/item/toy/crayon/white))
		if(length_char(written_text) < MAX_MESSAGE_LEN) //Check to see if the written text is too long before continuing
			var/input_message = tgui_input_text(user, "What would you like to write on the chalkboard?", "Lecture time!", max_length = CHAT_MESSAGE_MAX_LENGTH, multiline = TRUE)
			if(do_after(user, 5 SECONDS, target = src))
				written_text += "[input_message]\n"
				say(input_message, sanitize = FALSE)
				if(length_char(written_text))
					icon_state = "chalkboard_filled"
					update_appearance()
		else
			to_chat(user, span_warning("Parece que não há mais espaço no quadro..."))
	else if(istype(attacking_item, /obj/item/toy/crayon/green)) //What are you, stupid?
		tgui_input_text(user, "What would you like to write on the chalkboard?", "Lecture time!", max_length = CHAT_MESSAGE_MAX_LENGTH, multiline = TRUE) //Fake them out.
		if(do_after(user, 5 SECONDS, target = src))
			to_chat(user, span_warning("Giz verde em um quadro verde não é uma boa ideia. Parece que precisa de lápis branco para escrever sobre isso. Idiota."))
			if(ishuman(user))
				var/mob/living/carbon/human/idiot = user
				idiot.add_mood_event("chalkboard", /datum/mood_event/green_idiot)
	else to_chat(user, span_warning("Parece que precisa de lápis branco para escrever sobre isso."))

/obj/structure/chalkboard/attack_hand_secondary(mob/user)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	to_chat(user, span_warning("Você pega a borracha e começa a limpar o tabuleiro."))
	if(!written_text)
		to_chat(user, span_warning("Você pega a borracha e dá ao conselho alguns papis, mas não tem nada para apagar."))
		if(ishuman(user))
			var/mob/living/carbon/human/papper = user
			papper.add_mood_event("chalkboard", /datum/mood_event/cathartic_eraser)
	else if(do_after(user, 5 SECONDS, target = src))
		written_text = ""
		icon_state = "chalkboard"
		update_appearance()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/chalkboard/wrench_act_secondary(mob/living/user, obj/item/tool)
	if(obj_flags & NO_DEBRIS_AFTER_DECONSTRUCTION)
		return FALSE
	to_chat(user, span_notice("Você começa a desconstruir[src]..."))
	if(tool.use_tool(src, user, 4 SECONDS, volume=50))
		playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)
		deconstruct()
	return ITEM_INTERACT_SUCCESS

/obj/structure/chalkboard/handle_deconstruct(disassembled = TRUE)
	. = ..()
	if(!(obj_flags & NO_DEBRIS_AFTER_DECONSTRUCTION))
		new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)
	qdel(src)

/datum/mood_event/cathartic_eraser
	description = "Dei ao quadro alguns papis com a borracha. Faz você se sentir um pouco melhor."
	mood_change = 1
	timeout = 1 MINUTES

/datum/mood_event/green_idiot
	description = "Tentei escrever no quadro, que é verde, com um lápis de cor verde. Me sinto idiota."
	mood_change = -1
	timeout = 1 MINUTES
