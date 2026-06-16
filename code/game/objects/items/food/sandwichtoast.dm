/obj/item/food/sandwich
	name = "sandwich"
	desc = "Uma grande criação de carne, queijo, pão e várias folhas de alface! Arthur Dent ficaria orgulhoso."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("meat" = 2, "cheese" = 1, "bread" = 2, "lettuce" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/sandwich/cheese
	name = "cheese sandwich"
	desc = "Um lanche leve para um dia quente. Mas e se você o grelhasse?"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 7,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("bread" = 1, "cheese" = 1)
	foodtypes = GRAIN | DAIRY
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = null

/obj/item/food/sandwich/cheese/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/sandwich/grilled_cheese, rand(30 SECONDS, 60 SECONDS), TRUE)

/obj/item/food/sandwich/grilled_cheese
	name = "grilled cheese sandwich"
	desc = "Um sanduíche quente e derretido que combina perfeitamente com sopa de tomate."
	icon_state = "toastedsandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/carbon = 4,
	)
	tastes = list("toast" = 2, "cheese" = 3, "butter" = 1)
	foodtypes = GRAIN | DAIRY
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = null

/obj/item/food/sandwich/jelly
	name = "jelly sandwich"
	desc = "Você queria um pouco de manteiga de amendoim para combinar com isso..."
	icon_state = "jellysandwich"
	bite_consumption = 3
	tastes = list("bread" = 1, "jelly" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = null

/obj/item/food/sandwich/jelly/slime
	food_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/toxin/slimejelly = 10, /datum/reagent/consumable/nutriment/vitamin = 4)
	foodtypes = GRAIN | TOXIC

/obj/item/food/sandwich/jelly/cherry
	food_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/cherryjelly = 8, /datum/reagent/consumable/nutriment/vitamin = 4)
	foodtypes = GRAIN | FRUIT | SUGAR

/obj/item/food/sandwich/notasandwich
	name = "not-a-sandwich"
	desc = "Algo parece estar errado com isso, não dá para imaginar o quê. Talvez seja o bigode dele."
	icon_state = "notasandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("nothing suspicious" = 1)
	foodtypes = GRAIN | GROSS
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = null

/obj/item/food/griddle_toast
	name = "griddle toast"
	desc = "Pão grosso cortado, grelhado à perfeição."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "griddle_toast"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("toast" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_MASK
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/butteredtoast
	name = "buttered toast"
	desc = "Manteiga levemente espalhada sobre um pedaço de torrada."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "butteredtoast"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("butter" = 1, "toast" = 1)
	foodtypes = GRAIN | BREAKFAST | DAIRY
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/jelliedtoast
	name = "jellied toast"
	desc = "Uma torrada coberta de geleia deliciosa."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "jellytoast"
	bite_consumption = 3
	tastes = list("toast" = 1, "jelly" = 1)
	foodtypes = GRAIN | BREAKFAST
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/jelliedtoast/cherry
	food_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/cherryjelly = 8, /datum/reagent/consumable/nutriment/vitamin = 4)
	foodtypes = GRAIN | FRUIT | SUGAR | BREAKFAST

/obj/item/food/jelliedtoast/slime
	food_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/toxin/slimejelly = 8, /datum/reagent/consumable/nutriment/vitamin = 4)
	foodtypes = GRAIN | TOXIC | BREAKFAST

/obj/item/food/twobread
	name = "two bread"
	desc = "Isso parece muito amargo."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "twobread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("bread" = 2)
	foodtypes = GRAIN
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/hotdog
	name = "hotdog"
	desc = "Um pé fresco pronto para descer."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "hotdog"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/ketchup = 3,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("bun" = 3, "meat" = 2)
	foodtypes = GRAIN | MEAT //Ketchup is not a vegetable
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_price = PAYCHECK_CREW * 0.7
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

// Used for unit tests, do not delete
/obj/item/food/hotdog/debug
	eat_time = 0

/obj/item/food/danish_hotdog
	name = "danish hotdog"
	desc = "Pão apetitoso, com uma salsicha no meio, coberta com molho, cebola frita e pickles anéis"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "danish_hotdog"
	bite_consumption = 4
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/ketchup = 3,
		/datum/reagent/consumable/nutriment/vitamin = 7,
	)
	tastes = list("bun" = 3, "meat" = 2, "fried onion" = 1, "pickles" = 1)
	foodtypes = GRAIN | MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_price = PAYCHECK_CREW
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/sandwich/blt
	name = "\improper BLT"
	desc = "Um clássico sanduíche de bacon, alface e tomate."
	icon_state = "blt"
	bite_consumption = 4
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 7,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("bacon" = 3, "lettuce" = 2, "tomato" = 2, "bread" = 2)
	foodtypes = GRAIN | MEAT | VEGETABLES | BREAKFAST
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/sandwich/peanut_butter_jelly
	name = "peanut butter and jelly sandwich"
	desc = "Um clássico sanduíche de PB&J, como sua mãe fazia."
	icon_state = "peanut_butter_jelly_sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("peanut butter" = 1, "jelly" = 1, "bread" = 2)
	foodtypes = GRAIN | FRUIT | NUTS
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = null

/obj/item/food/sandwich/peanut_butter_banana
	name = "peanut butter and banana sandwich"
	desc = "Um sanduíche de manteiga de amendoim com fatias de banana misturadas, um bom tratamento com proteína."
	icon_state = "peanut_butter_banana_sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/banana = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("peanut butter" = 1, "banana" = 1, "bread" = 2)
	foodtypes = GRAIN | FRUIT | NUTS
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = null

/obj/item/food/sandwich/philly_cheesesteak
	name = "philly cheesesteak"
	desc = "Um sanduíche popular feito de carne fatiada, cebolas, queijo derretido em um longo rolinho. Água na boca nem começa a descrevê-la."
	icon_state = "philly_cheesesteak"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("bread" = 1, "juicy meat" = 1, "melted cheese" = 1, "onions" = 1)
	foodtypes = GRAIN | MEAT | DAIRY | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/sandwich/toast_sandwich
	name = "toast sandwich"
	desc = "Uma torrada com manteiga entre duas fatias de pão. Por que você faria isso?"
	icon_state = "toast_sandwich"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("bread" = 2, "Britain" = 1, "butter" = 1, "toast" = 1)
	foodtypes = GRAIN|DAIRY
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = null

/obj/item/food/sandwich/death
	name = "death sandwich"
	desc = "Coma direito ou você morre!"
	icon_state = "death_sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 14,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("bread" = 1, "meat" = 1, "tomato sauce" = 1, "death" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN
	eat_time = 4 SECONDS // Makes it harder to force-feed this to people as a weapon, as funny as that is.
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)
	var/static/list/correct_clothing = list(/obj/item/clothing/under/rank/civilian/cookjorts, /obj/item/clothing/under/shorts/jeanshorts)

/obj/item/food/sandwich/death/Initialize(mapload)
	. = ..()
	obj_flags &= ~UNIQUE_RENAME // You shouldn't be able to disguise this on account of how it kills you

// Makes you feel disgusted if you look at it wrong.
/obj/item/food/sandwich/death/examine(mob/user)
	. = ..()
	// Only human mobs, not animals or silicons, can like/dislike by this.
	if(!ishuman(user))
		return
	if(check_liked(user) == FOOD_LIKED)
		return
	to_chat(user, span_warning("Você se imagina comendo [src] Você sente um gosto azedo na boca, e uma sensação horrível de que fez algo errado."))
	user.adjust_disgust(33)

// Override for after_eat and check_liked callbacks.
/obj/item/food/sandwich/death/make_edible()
	. = ..()
	AddComponentFrom(SOURCE_EDIBLE_INNATE, /datum/component/edible, after_eat = CALLBACK(src, PROC_REF(after_eat)), check_liked = CALLBACK(src, PROC_REF(check_liked)))

/**
* Callback to be used with the edible component.
* If you have the right clothes and hairstyle, you like it.
* If you don't, you don't like it.
*/
/obj/item/food/sandwich/death/proc/check_liked(mob/living/carbon/human/consumer)
	// Closest thing to a mullet we have
	if(consumer.hairstyle == "Gelled Back" && is_type_in_list(consumer.get_item_by_slot(ITEM_SLOT_ICLOTHING), correct_clothing))
		return FOOD_LIKED
	return FOOD_ALLERGIC

/**
* Callback to be used with the edible component.
* If you take a bite of the sandwich with the right clothes and hairstyle, you like it.
* If you don't, you contract a deadly disease.
*/
/obj/item/food/sandwich/death/proc/after_eat(mob/living/carbon/human/consumer)
	// If you like it, you're eating it right.
	if(check_liked(consumer) == FOOD_LIKED)
		return
	// I thought it didn't make sense for it to instantly kill you, so instead enjoy shitloads of toxin damage per bite.
	balloon_alert(consumer, "Comeu errado!")
	consumer.ForceContractDisease(new /datum/disease/death_sandwich_poisoning())

/obj/item/food/sandwich/death/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] Começa a empurrar [src] Para baixo.[user.p_their()] Garganta do jeito errado. Parece que...[user.p_theyre()] Tentando cometer suicídio!"))
	qdel(src)
	user.gib()
	return MANUAL_SUICIDE
