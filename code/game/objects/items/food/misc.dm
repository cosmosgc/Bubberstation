
////////////////////////////////////////////OTHER////////////////////////////////////////////
/obj/item/food/watermelonslice
	name = "watermelon slice"
	desc = "Uma fatia de água boa."
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "watermelonslice"
	food_reagents = list(
		/datum/reagent/water = 1,
		/datum/reagent/consumable/nutriment/vitamin = 0.2,
		/datum/reagent/consumable/nutriment = 1,
	)
	tastes = list("watermelon" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/watermelonslice/juice_typepath()
	return /datum/reagent/consumable/watermelonjuice

/obj/item/food/watermelonmush
	name = "watermelon mush"
	desc = "Um monte de bondade aquosa."
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "watermelonpulp"
	food_reagents = list(
		/datum/reagent/water = 2,
		/datum/reagent/consumable/nutriment/vitamin = 0.1,
		/datum/reagent/consumable/nutriment = 0.5,
	)
	tastes = list("watermelon" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/watermelonmush/juice_typepath()
	return /datum/reagent/consumable/watermelonjuice

/obj/item/food/holymelonslice
	name = "holymelon slice"
	desc = "Uma Fatia de Bondade Sagrada."
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "holymelonslice"
	food_reagents = list(
		/datum/reagent/water/holywater = 0.5,
		/datum/reagent/consumable/nutriment/vitamin = 0.2,
		/datum/reagent/consumable/nutriment = 1,
	)
	tastes = list("holymelon" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/holymelonslice/juice_typepath()
	return /datum/reagent/water/holywater

/obj/item/food/holymelonmush
	name = "holymelon mush"
	desc = "Um monte de Bondade Santa."
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "holymelonpulp"
	food_reagents = list(
		/datum/reagent/water/holywater = 1,
		/datum/reagent/consumable/nutriment/vitamin = 0.1,
		/datum/reagent/consumable/nutriment = 0.5,
	)
	tastes = list("holymelon" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/holymelonmush/juice_typepath()
	return /datum/reagent/water/holywater

/obj/item/food/barrelmelonslice
	name = "barrelmelon slice"
	desc = "Uma fatia de cerveja."
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "barrelmelonslice"
	food_reagents = list(
		/datum/reagent/consumable/ethanol/beer = 1,
		/datum/reagent/consumable/nutriment/vitamin = 0.2,
		/datum/reagent/consumable/nutriment = 1,
	)
	tastes = list("beer" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/barrelmelonslice/juice_typepath()
	return /datum/reagent/consumable/ethanol/beer

/obj/item/food/barrelmelonmush
	name = "barrelmelon mush"
	desc = "Um monte de bondade de cerveja."
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "barrelmelonpulp"
	food_reagents = list(
		/datum/reagent/consumable/ethanol/beer = 2,
		/datum/reagent/consumable/nutriment/vitamin = 0.1,
		/datum/reagent/consumable/nutriment = 0.5,
	)
	tastes = list("beer" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/barrelmelonmush/juice_typepath()
	return /datum/reagent/consumable/ethanol/beer

/obj/item/food/appleslice
	name = "apple slice"
	desc = "O Lanche Perfeito Depois das Aulas."
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "appleslice"
	food_reagents = list(
		/datum/reagent/consumable/applejuice = 1,
		/datum/reagent/consumable/nutriment/vitamin = 0.2,
		/datum/reagent/consumable/nutriment = 1,
	)
	tastes = list("apple" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/appleslice/juice_typepath()
	return /datum/reagent/consumable/applejuice

/obj/item/food/hugemushroomslice
	name = "huge mushroom slice"
	desc = "Uma fatia de um cogumelo enorme."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "hugemushroomslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("mushroom" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/hugemushroomslice/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_WALKING_MUSHROOM, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)

/obj/item/food/popcorn
	name = "popcorn"
	desc = "Agora vamos encontrar um pouco de cinema."
	icon_state = "popcorn"
	trash_type = /obj/item/trash/popcorn
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	bite_consumption = 0.1 //this snack is supposed to be eating during looooong time. And this it not dinner food! --rastaf0
	tastes = list("popcorn" = 3, "butter" = 1)
	foodtypes = JUNKFOOD
	eatverbs = list("bite", "nibble", "gnaw", "gobble", "chomp")
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/popcorn/salty
	name = "salty popcorn"
	icon_state = "salty_popcorn"
	desc = "Pipoca salgada, um clássico para sempre."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("salt" = 2, "popcorn" = 1)
	trash_type = /obj/item/trash/popcorn/salty
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/popcorn/caramel
	name = "caramel popcorn"
	icon_state = "caramel_popcorn"
	desc = "Pipoca coberta de caramelo. Ótimo!"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/caramel = 4,
	)
	tastes = list("caramel" = 2, "popcorn" = 1)
	foodtypes = JUNKFOOD | SUGAR
	trash_type = /obj/item/trash/popcorn
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/soydope
	name = "soy dope"
	desc = "Droga de uma soja."
	icon_state = "soydope"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/protein = 1,
	)
	tastes = list("soy" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/badrecipe
	name = "burned mess"
	desc = "Alguém deveria ser rebaixado do cozinheiro para isso."
	icon_state = "badrecipe"
	food_reagents = list(/datum/reagent/toxin/bad_food = 30)
	foodtypes = GROSS
	w_class = WEIGHT_CLASS_SMALL
	preserved_food = TRUE //Can't decompose any more than this
	/// Variable that holds the reference to the stink lines we get when we're moldy, yucky yuck
	var/stink_particles

/obj/item/food/badrecipe/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_GRILL_PROCESS, PROC_REF(OnGrill))
	RegisterSignals(src, list(COMSIG_ITEM_GRILLED_RESULT, COMSIG_ITEM_BAKED_RESULT, COMSIG_ITEM_MICROWAVE_COOKED, COMSIG_OBJ_DECOMPOSITION_RESULT), PROC_REF(convert_to_bad_food))
	if(stink_particles)
		add_shared_particles(stink_particles)

///Prevents grilling burnt shit from well, burning.
/obj/item/food/badrecipe/proc/OnGrill()
	SIGNAL_HANDLER
	return COMPONENT_HANDLED_GRILLING

/**
 * The bad food reagent is cleared when cooked rather than just spawned and the reagents of the item this is from are transferred to this instead,
 * So we want to convert most of the consumable reagents into bad food, which is what makes the burned mess a bad thing to eat, taste aside.
 */
/obj/item/food/badrecipe/proc/convert_to_bad_food(atom/source)
	SIGNAL_HANDLER
	var/bad_food_amount = 0
	for(var/datum/reagent/consumable/food_reagent in reagents.reagent_list)
		var/amount_to_remove = food_reagent.volume * rand(6, 8) * 0.1 //around 60% to 80% of the volume is to be converted.
		food_reagent.volume -= amount_to_remove
		bad_food_amount += amount_to_remove
	reagents.update_total()
	reagents.add_reagent(/datum/reagent/toxin/bad_food, bad_food_amount, reagtemp = reagents.chem_temp)

/obj/item/food/badrecipe/Destroy(force)
	if (stink_particles)
		remove_shared_particles(stink_particles)
	return ..()

// We override the parent procs here to prevent burned messes from cooking into burned messes.
/obj/item/food/badrecipe/make_grillable()
	return
/obj/item/food/badrecipe/make_bakeable()
	return

/obj/item/food/badrecipe/moldy
	name = "moldy mess"
	desc = "Uma cultura nojenta de mofo e formigas. Em algum lugar lá embaixo, em<i>Algum ponto,</i>Havia comida."
	food_reagents = list(/datum/reagent/consumable/mold = 30)
	preserved_food = FALSE
	ant_attracting = TRUE
	decomp_type = null
	decomposition_time = 30 SECONDS
	stink_particles = /particles/stink

/obj/item/food/badrecipe/moldy/bacteria
	name = "bacteria rich moldy mess"
	desc = "Não só este pedaço rançoso de bile nojenta rastejando com vida de insetos, mas também está repleto de várias culturas microscópicas.<i>Ele se move quando você não está olhando.</i>"

/obj/item/food/badrecipe/moldy/bacteria/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_MOLD, CELL_VIRUS_TABLE_GENERIC, rand(2, 4), 25)

/obj/item/food/spidereggs
	name = "spider eggs"
	desc = "Um grupo de suculentos ovos de aranha. Um grande prato lateral para quando você não se importa com sua saúde."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "spidereggs"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/toxin = 2,
	)
	tastes = list("cobwebs" = 1)
	foodtypes = MEAT | TOXIC | BUGS | EGG
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/spidereggs/processed
	name = "processed spider eggs"
	desc = "Um grupo de suculentos ovos de aranha. Entra na boca sem te deixar doente."
	icon_state = "spidereggs"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 4)
	tastes = list("cobwebs" = 1)
	foodtypes = MEAT | BUGS
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/spiderling
	name = "spiderling"
	desc = "Está um pouco tremendo na sua mão. Eca..."
	icon = 'icons/mob/simple/arachnoid.dmi'
	icon_state = "spiderling_dead"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/toxin = 4,
	)
	tastes = list("cobwebs" = 1, "guts" = 2)
	foodtypes = MEAT | TOXIC | BUGS
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/melonfruitbowl
	name = "melon fruit bowl"
	desc = "Para pessoas que querem experimentar uma explosão de sabor."
	icon_state = "melonfruitbowl"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("melon" = 1)
	foodtypes = VEGETABLES|FRUIT|ORANGES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/melonkeg
	name = "melon keg"
	desc = "Quem diria que vodka era fruta?"
	icon_state = "melonkeg"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 9,
		/datum/reagent/consumable/ethanol/vodka = 15,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	max_volume = 80
	bite_consumption = 5
	tastes = list("grain alcohol" = 1, "fruit" = 1)
	foodtypes = FRUIT | ALCOHOL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/honeybar
	name = "honey nut bar"
	desc = "Aveia e nozes comprimidas juntas em uma barra, mantidas juntas com um esmalte de mel."
	icon_state = "honeybar"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/honey = 5,
	)
	tastes = list("oats" = 3, "nuts" = 2, "honey" = 1)
	foodtypes = GRAIN | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/powercrepe
	name = "powercrepe"
	desc = "Com grande poder, vem grandes crepes. Parece uma panqueca cheia de geléia, mas tem um soco e tanto."
	icon_state = "powercrepe"
	inhand_icon_state = "powercrepe"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/cherryjelly = 5,
	)
	force = 30
	throwforce = 15
	block_chance = 55
	armour_penetration = 80
	block_sound = 'sound/items/weapons/parry.ogg'
	wound_bonus = -50
	attack_verb_continuous = list("slaps", "slathers")
	attack_verb_simple = list("slap", "slather")
	w_class = WEIGHT_CLASS_BULKY
	tastes = list("cherry" = 1, "crepe" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR
	food_flags = FOOD_FINGER_FOOD
	crafting_complexity = FOOD_COMPLEXITY_5
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3)

/obj/item/food/branrequests
	name = "bran requests cereal"
	desc = "Um cereal seco que sacia seus pedidos de farelo. Tem gosto único de passas e sal."
	icon_state = "bran_requests"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/salt = 8,
	)
	tastes = list("bran" = 4, "raisins" = 3, "salt" = 1)
	foodtypes = SUGAR|GRAIN|FRUIT|BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/butter
	name = "stick of butter"
	desc = "Um pedaço de delicioso, dourado, gorduroso."
	icon_state = "butter"
	food_reagents = list(/datum/reagent/consumable/nutriment/fat = 6)
	tastes = list("butter" = 1)
	foodtypes = DAIRY
	w_class = WEIGHT_CLASS_SMALL
	dog_fashion = /datum/dog_fashion/head/butter
	var/can_stick = TRUE

/obj/item/food/butter/examine(mob/user)
	. = ..()
	if (can_stick)
		. += span_notice("Se você tivesse uma vara você poderia fazer<b>Manteiga em um pau</b>.")

/obj/item/food/butter/attackby(obj/item/item, mob/user, list/modifiers, list/attack_modifiers)
	if(!istype(item, /obj/item/stack/rods) || !can_stick)
		return ..()
	var/obj/item/stack/rods/rods = item
	if(!rods.use(1))//borgs can still fail this if they have no metal
		to_chat(user, span_warning("Você não tem ferro suficiente para colocar.[src]Em um pau!"))
		return ..()
	to_chat(user, span_notice("Você enfia a vara no pedaço de manteiga."))
	user.temporarilyRemoveItemFromInventory(src)
	var/obj/item/food/butter/on_a_stick/new_item = new(drop_location())
	if (new_item.IsReachableBy(user))
		user.put_in_hands(new_item)
	qdel(src)
	return TRUE

/obj/item/food/butter/on_a_stick //there's something so special about putting it on a stick.
	name = "butter on a stick"
	desc = "Delicioso, dourado, gorduroso em um pau."
	icon_state = "butteronastick"
	trash_type = /obj/item/stack/rods
	food_flags = FOOD_FINGER_FOOD
	venue_value = FOOD_PRICE_CHEAP
	can_stick = FALSE

/obj/item/food/butter/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/butterslice, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "Slice", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/butterslice
	name = "butter slice"
	desc = "Uma fatia de manteiga, para suas necessidades de manteiga."
	icon_state = "butterslice"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("butter" = 1)
	foodtypes = DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/onionrings
	name = "onion rings"
	desc = "Cortes de Cebola Revidas de Massa."
	icon_state = "onionrings"
	food_reagents = list(/datum/reagent/consumable/nutriment = 3)
	gender = PLURAL
	tastes = list("batter" = 3, "onion" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/pineappleslice
	name = "pineapple slice"
	desc = "Um pedaço fatiado de abacaxi suculento."
	icon_state = "pineapple_slice"
	tastes = list("pineapple" = 1)
	foodtypes = FRUIT | PINEAPPLE
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/pineappleslice/juice_typepath()
	return /datum/reagent/consumable/pineapplejuice

/obj/item/food/crab_rangoon
	name = "crab rangoon"
	desc = "Tem muitos nomes, como bolinhos de caranguejo, queijo won'tons, bolinhos de caranguejo? Como quer que os chame, eles são uma explosão fabulosa de caranguejo brega."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "crabrangoon"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("cream cheese" = 4, "crab" = 3, "crispiness" = 2)
	foodtypes = MEAT | DAIRY | GRAIN
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/pesto
	name = "pesto"
	desc = "Uma combinação de queijo firme, sal, ervas, alho, óleo e pinho. Geralmente usado como molho para macarrão ou pizza, ou comido em pão."
	icon_state = "pesto"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("pesto" = 1)
	foodtypes = VEGETABLES | DAIRY | NUTS
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/tomato_sauce
	name = "tomato sauce"
	desc = "Molho de tomate, perfeito para pizza ou macarrão. Mamãe mia!"
	icon_state = "tomato_sauce"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("tomato" = 1, "herbs" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/bechamel_sauce
	name = "béchamel sauce"
	desc = "Um clássico molho branco comum a várias culturas europeias."
	icon_state = "bechamel_sauce"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("cream" = 1)
	foodtypes = DAIRY | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/roasted_bell_pepper
	name = "roasted bell pepper"
	desc = "Um pimentão enegrecido. Ótimo para fazer molhos."
	icon_state = "roasted_bell_pepper"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("bell pepper" = 1, "char" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/pierogi
	name = "pierogi"
	desc = "Um bolinho feito embalando massa ázima em torno de um recheio salgado ou doce e cozinhando em água fervente. Este está cheio de batata e cebola."
	icon_state = "pierogi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("potato" = 1, "onions" = 1)
	foodtypes = GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/stuffed_cabbage
	name = "stuffed cabbage"
	desc = "Uma mistura saborosa de carne moída e arroz embrulhado em folhas de repolho cozido e coberto com um molho de tomate. Para morrer."
	icon_state = "stuffed_cabbage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("juicy meat" = 1, "rice" = 1, "cabbage" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/seaweedsheet
	name = "seaweed sheet"
	desc = "Uma folha seca de algas usadas para fazer sushi. Use um ingrediente para começar a fazer sushi personalizado!"
	icon_state = "seaweedsheet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("seaweed" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/seaweedsheet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, /obj/item/food/sushi/empty, CUSTOM_INGREDIENT_ICON_FILL, max_ingredients = 6)

/obj/item/food/seaweedsheet/saltcane
	name = "dried saltcane sheathe"
	desc = "Uma folha seca de molho de cana de sal usada para fazer sushi. Use um ingrediente para começar a fazer sushi personalizado!"
	icon_state = "seaweedsheet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("seaweed" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/granola_bar
	name = "granola bar"
	desc = "Uma mistura seca de aveia, nozes, frutas e chocolate condensado em uma barra mastigada. Faz um ótimo lanche enquanto viaja no espaço."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "granola_bar"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("granola" = 1, "nuts" = 1, "chocolate" = 1, "raisin" = 1)
	foodtypes = GRAIN|NUTS|FRUIT|SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/onigiri
	name = "onigiri"
	desc = "Uma bola de arroz cozido em torno de um recheio formado em uma forma triangular e embrulhado em algas. Podem ser adicionados recheios!"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "onigiri"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("rice" = 1, "dried seaweed" = 1)
	foodtypes = VEGETABLES|GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/onigiri/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, /obj/item/food/onigiri/empty, CUSTOM_INGREDIENT_ICON_NOCHANGE, max_ingredients = 4)

// empty onigiri for custom onigiri
/obj/item/food/onigiri/empty
	name = "onigiri"
	desc = "Uma bola de arroz cozido em torno de um recheio formado em uma forma triangular e embrulhado em algas."
	icon_state = "onigiri"
	foodtypes = VEGETABLES|GRAIN
	tastes = list()

/obj/item/food/pacoca
	name = "paçoca"
	desc = "Um tratamento tradicional brasileiro feito de amendoim moído, açúcar e sal comprimido em um cilindro."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "pacoca"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("peanuts" = 1, "sweetness" = 1)
	foodtypes = NUTS | SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/pickle
	name = "pickle"
	desc = "Pepino ligamente encolhido. Cheirando algo azedo, mas incrivelmente convidativo."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "pickle"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/pickle = 1,
		/datum/reagent/medicine/antihol = 2,
	)
	tastes = list("pickle" = 1, "spices" = 1, "salt water" = 2)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/pickle/juice_typepath()
	return /datum/reagent/consumable/pickle

/obj/item/food/pickle/make_edible()
	. = ..()
	AddComponentFrom(SOURCE_EDIBLE_INNATE, /datum/component/edible, check_liked = CALLBACK(src, PROC_REF(check_liked)))

/obj/item/food/pickle/proc/check_liked(mob/living/carbon/human/consumer)
	var/obj/item/organ/liver/liver = consumer.get_organ_slot(ORGAN_SLOT_LIVER)
	if(!HAS_TRAIT(consumer, TRAIT_AGEUSIA) && liver && HAS_TRAIT(liver, TRAIT_CORONER_METABOLISM))
		return FOOD_LIKED

/obj/item/food/springroll
	name = "spring roll"
	desc = "Um prato de embalagens de arroz translúcido cheio de vegetais frescos, servido com molho de pimenta doce. Ou os ama ou os odeia."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "springroll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("rice wrappers" = 1, "spice" = 1, "crunchy veggies" = 1)
	foodtypes = GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cheese_pierogi
	name = "cheese pierogi"
	desc = "Um bolinho feito embalando massa ázima em torno de um recheio salgado ou doce e cozinhando em água fervente. Este está cheio de uma mistura de batata e queijo."
	icon_state = "cheese_pierogi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("potato" = 1, "cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/meat_pierogi
	name = "meat pierogi"
	desc = "Um bolinho feito embalando massa ázima em torno de um recheio salgado ou doce e cozinhando em água fervente. Este está cheio de batata e carne."
	icon_state = "meat_pierogi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("potato" = 1, "cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/stuffed_eggplant
	name = "stuffed eggplant"
	desc = "Metade de uma berinjela cozida, com as entranhas escavadas e misturadas com carne, queijo e vegetais."
	icon_state = "stuffed_eggplant"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("cooked eggplant" = 5, "cheese" = 4, "ground meat" = 3, "veggies" = 2)
	foodtypes = VEGETABLES | MEAT | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/moussaka
	name = "moussaka"
	desc = "Um prato mediterrânico em camadas feito de berinjelas, vegetais misturados, e carne com uma cobertura de molho bechamel. Picável."
	icon_state = "moussaka"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 30,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/nutriment/protein = 20,
	)
	tastes = list("cooked eggplant" = 5, "potato" = 1, "baked veggies" = 2, "meat" = 4, "bechamel sauce" = 3)
	foodtypes = MEAT|VEGETABLES|GRAIN|DAIRY
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/moussaka/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE,  /obj/item/food/moussaka_slice, 4, 3 SECONDS, table_required = TRUE,  screentip_verb = "Cut")

/obj/item/food/moussaka_slice
	name = "moussaka slice"
	desc = "Um prato mediterrânico em camadas feito de berinjelas, vegetais misturados, e carne com uma cobertura de molho bechamel. Delicioso!"
	icon_state = "moussaka_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
	)
	tastes = list("cooked eggplant" = 5, "potato" = 1, "baked veggies" = 2, "meat" = 4, "bechamel sauce" = 3)
	foodtypes = MEAT|VEGETABLES|GRAIN|DAIRY
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT / 4)

/obj/item/food/candied_pineapple
	name = "candied pineapple"
	desc = "Um pedaço de abacaxi revestido de açúcar e seco em um doce mastigado."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	icon_state = "candied_pineapple_1"
	base_icon_state = "candied_pineapple"
	tastes = list("sugar" = 2, "chewy pineapple" = 4)
	foodtypes = SUGAR|FRUIT|PINEAPPLE
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/candied_pineapple/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state]_[rand(1, 3)]"

/obj/item/food/raw_pita_bread
	name = "raw pita bread"
	desc = "Um disco pegajoso de pão pita cru."
	icon = 'icons/obj/food/food_ingredients.dmi'
	icon_state = "raw_pita_bread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("dough" = 2)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/raw_pita_bread/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/pita_bread, rand(15 SECONDS, 30 SECONDS), TRUE, TRUE)

/obj/item/food/raw_pita_bread/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pita_bread, rand(15 SECONDS, 30 SECONDS), TRUE, TRUE)

/obj/item/food/pita_bread
	name = "pita bread"
	desc = "Um pão doce de origem mediterrânea."
	icon = 'icons/obj/food/food_ingredients.dmi'
	icon_state = "pita_bread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("pita bread" = 2)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/tzatziki_sauce
	name = "tzatziki sauce"
	desc = "Um molho à base de alho ou molho amplamente usado na cozinha mediterrânea e do Oriente Médio. Delicioso por conta própria quando mergulhado com pão ou legumes."
	icon_state = "tzatziki_sauce"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("garlic" = 4, "cucumber" = 2, "olive oil" = 2)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/tzatziki_and_pita_bread
	name = "tzatziki and pita bread"
	desc = "Molho Tzatziki, agora com pão pita para mergulhar. Muito saudável e delicioso tudo em um."
	icon_state = "tzatziki_and_pita_bread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("pita bread" = 4, "tzatziki sauce" = 2, "olive oil" = 2)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/grilled_beef_gyro
	name = "grilled beef gyro"
	desc = "Um prato grego tradicional de carne embrulhada em pão de pita com tomate, repolho, cebola e molho tzatziki."
	icon_state = "grilled_beef_gyro"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("pita bread" = 4, "tender meat" = 2, "tzatziki sauce" = 2, "mixed veggies" = 2)
	foodtypes = VEGETABLES | GRAIN | MEAT
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/vegetarian_gyro
	name = "vegetarian gyro"
	desc = "Um tradicional giroscópio grego com pepinos substituídos por carne. Ainda cheio de sabor intenso e muito nutritivo."
	icon_state = "vegetarian_gyro"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 12,
	)
	tastes = list("pita bread" = 4, "cucumber" = 2, "tzatziki sauce" = 2, "mixed veggies" = 2)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_4

///Extracted from squids, or any fish with the ink fish trait.
/obj/item/food/ink_sac
	name = "ink sac"
	desc = "O saco de tinta de algum tipo de peixe ou molusco. Pode ser enlatado com um processador."
	icon_state = "ink_sac"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/salt = 5)
	tastes = list("seafood" = 3)
	foodtypes = SEAFOOD|RAW

/obj/item/food/ink_sac/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/splat, 		memory_type = /datum/memory/witnessed_inking, 		smudge_type = /obj/effect/decal/cleanable/food/squid_ink, 		moodlet_type = /datum/mood_event/inked, 		splat_color = COLOR_NEARLY_ALL_BLACK, 		hit_callback = CALLBACK(src, PROC_REF(blind_em)), 	)

/obj/item/food/ink_sac/proc/blind_em(mob/living/victim, can_splat_on)
	if(can_splat_on)
		victim.adjust_temp_blindness_up_to(2.5 SECONDS, 3 SECONDS)
		victim.adjust_confusion_up_to(2.5 SECONDS, 3 SECONDS)
	victim.visible_message(span_warning("[victim]é pintado por[src]!"), span_userdanger("Você foi pintado por[src]!"))
	playsound(victim, SFX_DESECRATION, 50, TRUE)
