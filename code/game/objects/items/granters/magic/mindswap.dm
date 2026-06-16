/obj/item/book/granter/action/spell/mindswap
	granted_action = /datum/action/cooldown/spell/pointed/mind_transfer
	action_name = "mindswap"
	icon_state ="bookmindswap"
	desc = "A capa deste livro é intocada, embora suas páginas pareçam rasgadas."
	remarks = list(
		"If you mindswap from a mouse, they will be helpless when you recover...",
		"Wait, where am I...?",
		"This book is giving me a horrible headache...",
		"This page is blank, but I feel words popping into my head...",
		"GYNU... GYRO... Ugh...",
		"The voices in my head need to stop, I'm trying to read here...",
		"I don't think anyone will be happy when I cast this spell...",
	)
	/// Mob used in book recoils to store an identity for mindswaps
	var/datum/weakref/stored_swap_ref

/obj/item/book/granter/action/spell/mindswap/on_reading_finished()
	. = ..()
	visible_message(span_notice("[src] Começa a tremer e mudar."))
	action_name = pick(
		"fireball",
		"smoke",
		"blind",
		"forcewall",
		"knock",
		"barnyard",
		"charge",
	)
	icon_state = "book[action_name]"
	name = "spellbook of [action_name]"

/obj/item/book/granter/action/spell/mindswap/recoil(mob/living/user)
	. = ..()
	var/mob/living/real_stored_swap = stored_swap_ref?.resolve()
	if(QDELETED(real_stored_swap))
		stored_swap_ref = WEAKREF(user)
		to_chat(user, span_warning("Por um momento você sente que nem sabe mais quem você é."))
		return
	if(real_stored_swap.stat == DEAD)
		stored_swap_ref = null
		return
	if(real_stored_swap == user)
		to_chat(user, span_notice("Você olha mais para o livro, mas não parece haver mais nada para aprender..."))
		return

	var/datum/action/cooldown/spell/pointed/mind_transfer/swapper = new(src)

	if(swapper.swap_minds(user, real_stored_swap))
		to_chat(user, span_warning("De repente você está em outro lugar... e em outro?"))
		to_chat(real_stored_swap, span_warning("De repente você está olhando [src] De novo... Onde você está, quem é você?"))

	else
		// if the mind_transfer failed to transfer mobs (likely due to the target being catatonic).
		user.visible_message(span_warning("[src] Falhe ligeiramente enquanto pára de brilhar!"))

	stored_swap_ref = null
