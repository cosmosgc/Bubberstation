/obj/item/book/granter/crafting_recipe/death_sandwich
	name = "\improper SANDWICH OF DEATH SECRET RECIPE"
	desc = "Um antigo caderno de composição com as instruções para um antigo e último sanduíche rabiscado em suas páginas de folhas soltas. O título foi escrito com marcador permanente."
	crafting_recipe_types = list(
		/datum/crafting_recipe/food/death_sandwich
	)
	icon_state = "cooking_learning_sandwich"
	remarks = list(
		"A meatball sub, but what makes it so special?",
		"I just need to grease back my hair...?",
		"What kind of ancient civilization wore jorts?",
		"So it DOES matter what angle you fold the salami in...",
	)

/obj/item/book/granter/crafting_recipe/death_sandwich/recoil(mob/living/user)
	to_chat(user, span_warning("O livro explode em suas mãos, sem deixar rastros."))
	qdel(src)
