/obj/item/book/granter/action/spell/charge
	granted_action = /datum/action/cooldown/spell/charge
	action_name = "charge"
	icon_state ="bookcharge"
	desc = "Este livro é feito de um mago 100% pós-consumo."
	remarks = list(
		"I feel ALIVE!",
		"I CAN TASTE THE MANA!",
		"What a RUSH!",
		"I'm FLYING through these pages!",
		"THIS GENIUS IS MAKING IT!",
		"This book is ACTION PAcKED!",
		"HE'S DONE IT",
		"LETS GOOOOOOOOOOOO",
	)

/obj/item/book/granter/action/spell/charge/recoil(mob/living/user)
	. = ..()
	to_chat(user,span_warning("[src] de repente parece muito quente!"))
	empulse(src, 1, 1, emp_source = src)

