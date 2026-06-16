///spaghetti prototype used by all subtypes
/obj/item/food/spaghetti
	icon = 'icons/obj/food/spaghetti.dmi'
	abstract_type = /obj/item/food/spaghetti
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	foodtypes = GRAIN
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2

// Why are you putting cooked spaghetti in your pockets?
/obj/item/food/spaghetti/make_microwaveable()
	var/list/display_message = list(
		span_notice("Algo molhado cai do bolso e bate no chão. Isso é...[name]?"),
		span_warning("Merda! Todo o seu bolso [name] Caiu!"))
	AddComponent(/datum/component/spill, display_message, 'sound/effects/splat.ogg', /datum/memory/lost_spaghetti)

	return ..()

/obj/item/food/spaghetti/raw
	name = "spaghetti"
	desc = "Isso é que é macarrão!"
	icon_state = "spaghetti"
	tastes = list("pasta" = 1)
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/spaghetti/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/spaghetti/boiledspaghetti, rand(15 SECONDS, 20 SECONDS), TRUE, TRUE)

/obj/item/food/spaghetti/raw/make_microwaveable()
	AddElement(/datum/element/microwavable, /obj/item/food/spaghetti/boiledspaghetti)

/obj/item/food/spaghetti/boiledspaghetti
	name = "boiled spaghetti"
	desc = "Um prato simples de macarrão, isso precisa de mais ingredientes."
	icon_state = "spaghettiboiled"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/spaghetti/boiledspaghetti/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, null, CUSTOM_INGREDIENT_ICON_SCATTER, max_ingredients = 6)

/obj/item/food/spaghetti/pastatomato
	name = "spaghetti"
	desc = "Espaguete e tomates esmagados. Assim como seu pai abusivo costumava fazer!"
	icon_state = "pastatomato"
	bite_consumption = 4
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/tomatojuice = 10,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("pasta" = 1, "tomato" = 1)
	foodtypes = GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spaghetti/pastatomato/soulful
	name = "soul food"
	desc = "Exatamente como mamãe costumava fazer."
	food_reagents = list(
		// same as normal pasghetti
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/tomatojuice = 10,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		// where the soul comes from
		/datum/reagent/pax = 5,
		/datum/reagent/medicine/psicodine = 10,
		/datum/reagent/medicine/morphine = 5,
	)
	tastes = list("nostalgia" = 1, "happiness" = 1)

/obj/item/food/spaghetti/copypasta
	name = "copypasta"
	desc = "Você provavelmente não deveria tentar isso, você sempre ouve as pessoas falando sobre como é ruim..."
	icon_state = "copypasta"
	bite_consumption = 4
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/tomatojuice = 20,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("pasta" = 1, "tomato" = 1)
	foodtypes = GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spaghetti/meatballspaghetti
	name = "spaghetti and meatballs"
	desc = "Isso sim é uma almôndega!"
	icon_state = "meatballspaghetti"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("pasta" = 1, "meat" = 1)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/spaghetti/spesslaw
	name = "spesslaw"
	desc = "Um favorito dos advogados."
	icon_state = "spesslaw"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 20,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("pasta" = 1, "meat" = 1)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 4)

/obj/item/food/spaghetti/chowmein
	name = "chow mein"
	desc = "Uma bela mistura de macarrão e legumes fritos."
	icon_state = "chowmein"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("noodle" = 1, "meat" = 1, "fried vegetables" = 1)
	foodtypes = GRAIN | MEAT | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/spaghetti/beefnoodle
	name = "beef noodle"
	desc = "Nutritivo, fofinho e barulhento."
	icon_state = "beefnoodle"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/liquidgibs = 3,
	)
	tastes = list("noodles" = 1, "meat" = 1)
	foodtypes = GRAIN | MEAT | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/spaghetti/butternoodles
	name = "butter noodles"
	desc = "Macarrão coberto de manteiga salgada. Simples e escorregadio, mas delicioso."
	icon_state = "butternoodles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 9,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("noodles" = 1, "butter" = 1)
	foodtypes = GRAIN | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spaghetti/mac_n_cheese
	name = "mac n' cheese"
	desc = "Feito do jeito certo com apenas o melhor queijo e migalhas de pão. Ainda assim, não pode coçar a mesma coceira que Ready-Donk."
	icon_state = "mac_n_cheese"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 9,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("cheese" = 1, "breadcrumbs" = 1, "pasta" = 1)
	foodtypes = GRAIN | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/spaghetti/shoyu_tonkotsu_ramen
	name = "shoyu tonkotsu ramen"
	desc = "Um simples ramen feito de carne, ovo, cebola e uma folha de algas."
	icon_state = "shoyu_tonkotsu_ramen"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("noodles" = 5, "meat" = 3, "egg" = 4, "dried seaweed" = 2)
	foodtypes = GRAIN | MEAT | VEGETABLES | EGG
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/spaghetti/kitakata_ramen
	name = "kitakata ramen"
	desc = "Um saudável ramen composto de carne, cogumelos, cebola e alho. Muitas vezes dado aos doentes para confortá-los"
	icon_state = "kitakata_ramen"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
	)
	tastes = list("noodles" = 5, "meat" = 4, "mushrooms" = 3, "onion" = 2)
	foodtypes = GRAIN | MEAT | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/spaghetti/kitsune_udon
	name = "kitsune udon"
	desc = "Um udon vegetariano feito de tofu frito e cebola, feito doce e salgado com açúcar e molho de soja. O nome vem de um conto antigo sobre uma raposa desfrutando tofu frito."
	icon_state = "kitsune_udon"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("noodles" = 5, "tofu" = 4, "sugar" = 3, "soy sauce" = 2)
	foodtypes = GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/spaghetti/nikujaga
	name = "nikujaga"
	desc = "Um delicioso guisado japonês de macarrão, cebolas, batatas e carne com vegetais misturados."
	icon_state = "nikujaga"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 16,
		/datum/reagent/consumable/nutriment/vitamin = 12,
		/datum/reagent/consumable/nutriment/protein = 8,
	)
	tastes = list("noodles" = 5, "meat" = 4, "potato" = 3, "onion" = 2, "mixed veggies" = 2)
	foodtypes = GRAIN | VEGETABLES | MEAT
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/spaghetti/pho
	name = "pho"
	desc = "Um prato vietnamita feito de macarrão, vegetais, ervas e carne. É uma comida de rua muito popular."
	icon_state = "pho"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment/protein = 8,
	)
	tastes = list("noodles" = 5, "meat" = 4, "cabbage" = 3, "onion" = 2, "herbs" = 2)
	foodtypes = GRAIN | VEGETABLES | MEAT
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/spaghetti/pad_thai
	name = "pad thai"
	desc = "Um prato de macarrão frito popular na Tailândia feito de amendoim, tofu, limão e cebola."
	icon_state = "pad_thai"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("noodles" = 5, "fried tofu" = 4, "lime" = 2, "peanut" = 3, "onion" = 2)
	foodtypes = GRAIN | VEGETABLES | NUTS | FRUIT
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/spaghetti/carbonara
	name = "spaghetti carbonara"
	desc = "Ovos sedosos, porco crocante, felicidade brega. Mamãe mia!"
	icon_state = "carbonara"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("spaghetti" = 1, "parmigiano reggiano" = 1,  "guanciale" = 1)
	foodtypes = GRAIN | MEAT | DAIRY | EGG
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/spaghetti/carbonara/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/love_food_buff, /datum/status_effect/food/speech/italian)
