/obj/item/food/burger
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "hburger"
	inhand_icon_state = "burger"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("bun" = 2, "beef patty" = 4)
	foodtypes = GRAIN | MEAT //lettuce doesn't make burger a vegetable.
	eat_time = 15 //Quick snack
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/burger/plain
	name = "plain burger"
	desc = "A pedra angular de cada café da manhã nutritivo."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	foodtypes = GRAIN | MEAT
	custom_price = PAYCHECK_CREW * 0.8
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/plain/Initialize(mapload)
	. = ..()
	if(!prob(1))
		return
	new/obj/effect/particle_effect/fluid/smoke(get_turf(src))
	playsound(src, 'sound/effects/smoke.ogg', 50, TRUE)
	visible_message(span_warning("Oh, Deuses![src]Está arruinado! Mas e se...?"))
	name = "steamed ham"
	desc = pick("Chefe de Pessoal, bem-vindo. Espero que esteja preparado para um almoço inesquecível!",
		"And you call these steamed hams despite the fact that they are obviously microwaved?",
		"Aurora Station 13? At this time of shift, in this time of year, in this sector of space, localized entirely within your freezer?",
		"You know, these hamburgers taste quite similar to the ones they have at the Maltese Falcon.")

/obj/item/food/burger/human
	name = "human burger"
	desc = "Um maldito hambúrguer."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("bun" = 2, "long pig" = 4)
	foodtypes = MEAT | GRAIN
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/human/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	. = ..()
	for(var/datum/material/meat/mob_meat/mob_meat_material in custom_materials)
		if(mob_meat_material.subjectname)
			name = "[mob_meat_material.subjectname] burger"
		else if(mob_meat_material.subjectjob)
			name = "[mob_meat_material.subjectjob] burger"

/obj/item/food/burger/corgi
	name = "corgi burger"
	desc = "Seu monstro."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("bun" = 4, "corgi meat" = 2)
	foodtypes = GRAIN | MEAT
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/appendix
	name = "appendix burger"
	desc = "Tem vai de apendicite."
	icon_state = "appendixburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("bun" = 4, "grass" = 2)
	foodtypes = GRAIN | MEAT | GORE
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/burger/fish
	name = "fillet -o- carp sandwich"
	desc = "Quase como uma carpa gritando em algum lugar... Devolva-me o filé de carpa."
	icon_state = "fishburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("bun" = 4, "fish" = 4)
	foodtypes = GRAIN | SEAFOOD | DAIRY
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/burger/tofu
	name = "tofu burger"
	desc = "O que... isso é carne?"
	icon_state = "tofuburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("bun" = 4, "tofu" = 4)
	foodtypes = GRAIN | VEGETABLES
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/burger/roburger
	name = "roburger"
	desc = "A alface é o único componente orgânico. Beep."
	icon_state = "roburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/cyborg_mutation_nanomachines = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("bun" = 4, "lettuce" = 2, "sludge" = 1)
	foodtypes = GRAIN | TOXIC
	venue_value = FOOD_PRICE_EXOTIC

/obj/item/food/burger/roburger/big
	desc = "Esta é Patty parece veneno. Beep."
	max_volume = 120
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/cyborg_mutation_nanomachines = 80,
		/datum/reagent/consumable/nutriment/vitamin = 15,
	)

/obj/item/food/burger/xeno
	name = "xenoburger"
	desc = "Cheira cáustico. Tem gosto de heresia."
	icon_state = "xburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("bun" = 4, "acid" = 4)
	foodtypes = GRAIN | MEAT
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/bearger
	name = "bearger"
	desc = "\"Melhor servido cru\"."
	icon_state = "bearger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("bun" = 2, "meat" = 2, "salmon" = 2)
	foodtypes = GRAIN | MEAT
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/clown
	name = "clown burger"
	desc = "Isso tem um gosto engraçado..."
	icon_state = "clownburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("bun" = 2, "a bad joke" = 4)
	foodtypes = GRAIN
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/burger/mime
	name = "mime burger"
	desc = "Seu gosto é uma linguagem."
	icon_state = "mimeburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 9,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nothing = 6,
	)
	foodtypes = GRAIN
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/burger/brain
	name = "brainburger"
	desc = "Um estranho hambúrguer. Parece quase senciente."
	icon_state = "brainburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/medicine/mannitol = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("bun" = 4, "brains" = 2)
	foodtypes = GRAIN | MEAT | GORE
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/burger/ghost
	name = "ghost burger"
	desc = "Muito assustador!"
	icon_state = "ghostburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 12,
		/datum/reagent/consumable/salt = 5,
	)
	tastes = list("bun" = 2, "ectoplasm" = 4)
	foodtypes = GRAIN
	alpha = 170
	verb_say = "moans"
	verb_yell = "wails"
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_3
	preserved_food = TRUE // It's made of ghosts

/obj/item/food/burger/ghost/Initialize(mapload, starting_reagent_purity, no_base_reagents)
	. = ..()
	START_PROCESSING(SSobj, src)
	AddComponent(/datum/component/ghost_edible, bite_consumption = bite_consumption)

/obj/item/food/burger/ghost/make_germ_sensitive()
	return // This burger moves itself so it shouldn't pick up germs from walking onto the floor

/obj/item/food/burger/ghost/process()
	if(!isturf(loc)) //no floating out of bags
		return
	var/paranormal_activity = rand(100)
	switch(paranormal_activity)
		if(97 to 100)
			audible_message("[src] rattles a length of chain.")
			playsound(loc, 'sound/misc/chain_rattling.ogg', 300, TRUE)
		if(91 to 96)
			say(pick("OoOoOoo.", "OoooOOooOoo!!"))
		if(84 to 90)
			dir = pick(NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST)
			step(src, dir)
		if(71 to 83)
			step(src, dir)
		if(65 to 70)
			var/obj/machinery/light/light = locate(/obj/machinery/light) in view(4, src)
			light?.flicker()
		if(62 to 64)
			playsound(loc, SFX_HALLUCINATION_I_SEE_YOU, 50, TRUE, ignore_walls = FALSE)
		if(61)
			visible_message("[src]Despeja uma vez de ectoplasma!")
			new /obj/effect/decal/cleanable/greenglow/ecto(loc)
			playsound(loc, 'sound/effects/splat.ogg', 200, TRUE)

/obj/item/food/burger/ghost/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/food/burger/red
	name = "red burger"
	desc = "Perfeito para esconder que está queimado."
	icon_state = "cburger"
	color = COLOR_RED
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/colorful_reagent/powder/red = 10,
	)
	tastes = list("bun" = 2, "red" = 2)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/orange
	name = "orange burger"
	desc = "Contém 0% de suco."
	icon_state = "cburger"
	color = COLOR_ORANGE
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/colorful_reagent/powder/orange = 10,
	)
	tastes = list("bun" = 2, "orange" = 2)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/yellow
	name = "yellow burger"
	desc = "Brilhante até a última mordida."
	icon_state = "cburger"
	color = COLOR_YELLOW
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/colorful_reagent/powder/yellow = 10,
	)
	tastes = list("bun" = 2, "yellow" = 2)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/green
	name = "green burger"
	desc = "Não é carne contaminada, é carne pintada!"
	icon_state = "cburger"
	color = COLOR_GREEN
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/colorful_reagent/powder/green = 10,
	)
	tastes = list("bun" = 2, "green" = 2)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/blue
	name = "blue burger"
	desc = "Isso é azul raro?"
	icon_state = "cburger"
	color = COLOR_BLUE
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/colorful_reagent/powder/blue = 10,
	)
	tastes = list("bun" = 2, "blue" = 2)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/purple
	name = "purple burger"
	desc = "Regal e classe baixa ao mesmo tempo."
	icon_state = "cburger"
	color = COLOR_PURPLE
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/colorful_reagent/powder/purple = 10,
	)
	tastes = list("bun" = 2, "purple" = 2)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/black
	name = "black burger"
	desc = "Isso é demais."
	icon_state = "cburger"
	color = COLOR_ALMOST_BLACK
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/colorful_reagent/powder/black = 10,
	)
	tastes = list("bun" = 2, "black" = 2)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/white
	name = "white burger"
	desc = "Titânio delicioso!"
	icon_state = "cburger"
	color = COLOR_WHITE
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/colorful_reagent/powder/white = 10,
	)
	tastes = list("bun" = 2, "white" = 2)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/spell
	name = "spell burger"
	desc = "Esta é absolutamente Ei Nath."
	icon_state = "spellburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("bun" = 4, "magic" = 2)
	foodtypes = GRAIN
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/burger/bigbite
	name = "big bite burger"
	desc = "Esqueça o Big Mac."
	icon_state = "bigbiteburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("bun" = 2, "meat" = 10)
	w_class = WEIGHT_CLASS_NORMAL
	foodtypes = GRAIN | MEAT | DAIRY
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/burger/jelly
	name = "jelly burger"
	desc = "Deliciosa culinária...?"
	icon_state = "jellyburger"
	tastes = list("bun" = 4, "jelly" = 2)
	foodtypes = GRAIN | MEAT
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/burger/jelly/slime
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/toxin/slimejelly = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	foodtypes = GRAIN | TOXIC

/obj/item/food/burger/jelly/cherry
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/cherryjelly = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	foodtypes = GRAIN | FRUIT

/obj/item/food/burger/superbite
	name = "super bite burger"
	desc = "Isto é uma montanha de hambúrgueres. Comida!"
	icon_state = "superbiteburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 26,
		/datum/reagent/consumable/nutriment/protein = 40,
		/datum/reagent/consumable/nutriment/vitamin = 13,
	)
	w_class = WEIGHT_CLASS_NORMAL
	bite_consumption = 7
	max_volume = 100
	tastes = list("bun" = 4, "type two diabetes" = 10)
	foodtypes = GRAIN | MEAT | DAIRY | VEGETABLES | EGG
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_5
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/burger/superbite/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]Começa a comer.[src]em uma mordida, parece que[user.p_theyre()]Tentando cometer suicídio!"))
	var/datum/component/edible/component = GetComponent(/datum/component/edible)
	component?.TakeBite(user, user)
	return OXYLOSS

/obj/item/food/burger/fivealarm
	name = "five alarm burger"
	desc = "Quente! Quente!"
	icon_state = "fivealarmburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/capsaicin = 5,
		/datum/reagent/consumable/condensedcapsaicin = 5,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("extreme heat" = 4, "bun" = 2)
	foodtypes = GRAIN | MEAT | VEGETABLES
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/rat
	name = "rat burger"
	desc = "Basicamente o que você esperaria..."
	icon_state = "ratburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("dead rat" = 4, "bun" = 2)
	foodtypes = GRAIN | MEAT | GORE | RAW
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/burger/baseball
	name = "home run baseball burger"
	desc = "Ainda está quente. O vapor saindo dele parece baseball."
	icon_state = "baseball"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("bun" = 2, "a home run" = 4)
	foodtypes = GRAIN | GROSS
	custom_price = PAYCHECK_CREW * 0.8
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = /obj/item/melee/baseball_bat::custom_materials

/obj/item/food/burger/baconburger
	name = "bacon burger"
	desc = "A combinação perfeita de todas as coisas americanas."
	icon_state = "baconburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("bacon" = 4, "bun" = 2)
	foodtypes = GRAIN | MEAT
	custom_premium_price = PAYCHECK_CREW * 1.6
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/burger/empoweredburger
	name = "empowered burger"
	desc = "É chocantemente bom, se você viver de eletricidade."
	icon_state = "empoweredburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/liquidelectricity/enriched = 6,
	)
	tastes = list("bun" = 2, "pure electricity" = 4)
	foodtypes = GRAIN | TOXIC
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/burger/catburger
	name = "catburger"
	desc = "Finalmente aqueles gatos e gatos valem alguma coisa!"
	icon_state = "catburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("bun" = 4, "meat" = 2, "cat" = 2)
	foodtypes = GRAIN | MEAT | GORE
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/crab
	name = "crab burger"
	desc = "Uma deliciosa patty do tipo rabugento, tapado entre um pão."
	icon_state = "crabburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("bun" = 2, "crab meat" = 4)
	foodtypes = GRAIN | SEAFOOD
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/burger/soylent
	name = "soylent burger"
	desc = "Um hambúrguer ecológico feito usando biomassa de baixo valor."
	icon_state = "soylentburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("bun" = 2, "assistant" = 4)
	foodtypes = GRAIN | MEAT | DAIRY
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/burger/rib
	name = "mcrib"
	desc = "Um hambúrguer em forma de costela com disponibilidade limitada pela galáxia. Não tão bom quanto se lembra."
	icon_state = "mcrib"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/bbqsauce = 1,
		)
	tastes = list("bun" = 2, "pork patty" = 4)
	foodtypes = GRAIN | MEAT | SUGAR | VEGETABLES
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/burger/mcguffin
	name = "mcguffin"
	desc = "Uma imitação barata e gordurosa de um ovo benedict."
	icon_state = "mcguffin"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/eggyolk = 3,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("muffin" = 2, "bacon" = 3)
	foodtypes = GRAIN | MEAT | BREAKFAST | FRIED | EGG
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/burger/chicken
	name = "chicken sandwich"
	//Apparently the proud people of Americlapstan object to this thing being called a burger.
	//Apparently McDonald's just calls it a burger in Europe as to not scare and confuse us.
	desc = "Um delicioso sanduíche de frango, diz-se que o lucro deste tratamento ajuda a criminalizar desarmar pessoas na fronteira espacial."
	icon_state = "chickenburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/mayonnaise = 3,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
	)
	tastes = list("bun" = 2, "chicken" = 4, "God's covenant" = 1)
	foodtypes = GRAIN | MEAT
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/cheese
	name = "cheese burger"
	desc = "Este nobre hambúrguer está orgulhosamente revestido de queijo dourado."
	icon_state = "cheeseburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("bun" = 2, "beef patty" = 4, "cheese" = 3)
	foodtypes = GRAIN | MEAT | DAIRY
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/cheese/Initialize(mapload)
	. = ..()
	if(prob(33))
		icon_state = "cheeseburgeralt"

/obj/item/food/burger/crazy
	name = "crazy hamburger"
	desc = "Isso parece o tipo de comida que um palhaço demente com uma capa de trincheira faria."
	icon_state = "crazyburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/capsaicin = 3,
		/datum/reagent/consumable/condensedcapsaicin = 3,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("bun" = 2, "beef patty" = 4, "cheese" = 2, "beef soaked in chili" = 3, "a smoking flare" = 2)
	foodtypes = GRAIN | MEAT | DAIRY | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(
		/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2,
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5,
		/datum/material/plasma = SMALL_MATERIAL_AMOUNT * 0.5,
		/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 0.5,
	)

/obj/item/food/burger/crazy/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/food/burger/crazy/process(seconds_per_tick) // DIT EES HORRIBLE
	if(SPT_PROB(2.5, seconds_per_tick))
		do_smoke(0, src, loc, smoke_type = /datum/effect_system/fluid_spread/smoke/bad/green)

// empty burger you can customize
/obj/item/food/burger/empty
	name = "burger"
	desc = "Um hambúrguer feito por um cozinheiro louco."
	icon_state = "custburg"
	tastes = list("bun")
	foodtypes = GRAIN

/obj/item/food/burger/sloppy_moe
	name = "sloppy moe"
	desc = "Carne moída misturada com cebolas e molho de churrasco, desleixada em um pão de hambúrguer. Delicioso, mas garantido para sujar suas mãos."
	icon_state = "sloppy_moe"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("juicy meat" = 4, "BBQ sauce" = 3, "onions" = 2, "bun" = 2)
	foodtypes = MEAT|VEGETABLES|GRAIN
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)
