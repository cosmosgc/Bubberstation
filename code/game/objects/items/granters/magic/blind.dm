/obj/item/book/granter/action/spell/blind
	granted_action = /datum/action/cooldown/spell/pointed/blind
	action_name = "blind"
	icon_state = "bookblind"
	desc = "Este livro parece borrado, não importa como você olha para ele."
	remarks = list(
		"Well I can't learn anything if I can't read the damn thing!",
		"Why would you use a dark font on a dark background...",
		"Ah, I can't see an Oh, I'm fine...",
		"I can't see my hand...!",
		"I'm manually blinking, damn you book...",
		"I can't read this page, but somehow I feel like I learned something from it...",
		"Hey, who turned off the lights?",
	)

/obj/item/book/granter/action/spell/blind/recoil(mob/living/user)
	. = ..()
	to_chat(user, span_warning("Você fica cego!"))
	user.adjust_temp_blindness(20 SECONDS)

/obj/item/book/granter/action/spell/blind/wgw
	name = "Woody's Got Wood"
	pages_to_mastery = 69 // Andy's favorite number
	uses = 0 // it's spent
	desc = "Este livro parece perigoso. Só o sofrimento aguarda aqueles que lêem."
	remarks = list( // Death awaits
		"T-T-This is bad...",
		"This is REALLY bad...",
		"I think my eyes are starting to bleed...",
		"Please, make it stop...",
		"HELP ME SOMEONE, WHY AM I READING THIS...",
	)
