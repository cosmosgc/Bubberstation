
/// Abstract parent object for bread items. Should not be made obtainable in game.
/obj/item/food/bread
	name = "bread?"
	desc = "Não deveria ver isso, ligue para os codificadores."
	icon = 'icons/obj/food/burgerbread.dmi'
	abstract_type = /obj/item/food/bread
	max_volume = 80
	tastes = list("bread" = 10)
	foodtypes = GRAIN
	eat_time = 3 SECONDS
	crafting_complexity = FOOD_COMPLEXITY_2
	/// type is spawned 5 at a time and replaces this bread loaf when processed by cutting tool
	var/obj/item/food/breadslice/slice_type
	/// so that the yield can change if it isnt 5
	var/yield = 5

/obj/item/food/bread/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dunkable, 10)
	AddComponent(/datum/component/food_storage)

/obj/item/food/bread/make_processable()
	if (slice_type)
		AddElement(/datum/element/processable, TOOL_KNIFE, slice_type, yield, 3 SECONDS, table_required = TRUE, screentip_verb = "Slice", sound_to_play = SFX_KNIFE_SLICE)
		AddElement(/datum/element/processable, TOOL_SAW, slice_type, yield, 4 SECONDS, table_required = TRUE, screentip_verb = "Slice")

// Abstract parent object for sliced bread items. Should not be made obtainable in game.
/obj/item/food/breadslice
	name = "breadslice?"
	desc = "Não deveria ver isso, ligue para os codificadores."
	icon = 'icons/obj/food/burgerbread.dmi'
	abstract_type = /obj/item/food/breadslice
	foodtypes = GRAIN
	food_flags = FOOD_FINGER_FOOD
	eat_time = 0.5 SECONDS
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/breadslice/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/food/bread/plain
	name = "bread"
	desc = "Um pão de barro."
	icon_state = "bread"
	food_reagents = list(/datum/reagent/consumable/nutriment = 10)
	tastes = list("bread" = 10)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/breadslice/plain
	crafting_complexity = FOOD_COMPLEXITY_1
/obj/item/food/bread/plain/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, /obj/item/food/bread/empty, CUSTOM_INGREDIENT_ICON_FILL, max_ingredients = 8)

/obj/item/food/breadslice/plain
	name = "bread slice"
	desc = "Uma fatia de casa."
	icon_state = "breadslice"
	foodtypes = GRAIN
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	venue_value = FOOD_PRICE_TRASH
	decomp_type = /obj/item/food/breadslice/moldy
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/breadslice/plain/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, null, CUSTOM_INGREDIENT_ICON_STACK)

/obj/item/food/breadslice/plain/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/griddle_toast, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/breadslice/moldy
	name = "moldy 'bread' slice"
	desc = "Estações inteiras foram destruídas discutindo se isso ainda é bom para comer."
	icon_state = "moldybreadslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/mold = 10,
	)
	tastes = list("decaying fungus" = 1)
	foodtypes = GROSS
	preserved_food = TRUE
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/breadslice/moldy/bacteria
	name = "bacteria-rich moldy 'bread' slice"
	desc = "Algo (possivelmente necróileo) fez este pão subir em um estado macabro de vida. Ele fica confuso quando está sozinho. Talvez queira localizar um padre se vir isso. Ou talvez um lança-chamas."

/obj/item/food/breadslice/moldy/bacteria/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_MOLD, CELL_VIRUS_TABLE_GENERIC, rand(2, 4), 25)

/obj/item/food/bread/meat
	name = "meatbread loaf"
	desc = "A base culinária de todos os eloqüentes eloquentes."
	icon_state = "meatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/nutriment/protein = 12,
	)
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)
	tastes = list("bread" = 10, "meat" = 10)
	foodtypes = GRAIN | MEAT | DAIRY
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/breadslice/meat
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/breadslice/meat
	name = "meatbread slice"
	desc = "Uma fatia de delicioso pão de carne."
	icon_state = "meatbreadslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 2.4,
	)
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT / 5)
	tastes = list("bread" = 1, "meat" = 1)
	foodtypes = GRAIN | MEAT | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/bread/sausage
	name = "sausagebread loaf"
	desc = "Não pense muito nisso."
	icon_state = "sausagebread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/nutriment/protein = 12,
	)
	tastes = list("bread" = 10, "meat" = 10)
	foodtypes = GRAIN | MEAT
	slice_type = /obj/item/food/breadslice/sausage
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/breadslice/sausage
	name = "sausagebread slice"
	desc = "Uma fatia de delicioso pão de salsicha."
	icon_state = "sausagebreadslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 2.4,
	)
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT / 2.5)
	tastes = list("bread" = 10, "meat" = 10)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/bread/xenomeat
	name = "xenomeatbread loaf"
	desc = "A base culinária de todos os eloqüentes eloquentes. Extra herético."
	icon_state = "xenomeatbread"
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/nutriment/protein = 15,
	)
	tastes = list("bread" = 10, "acid" = 10)
	foodtypes = GRAIN | MEAT | DAIRY
	slice_type = /obj/item/food/breadslice/xenomeat
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/breadslice/xenomeat
	name = "xenomeatbread slice"
	desc = "Uma fatia de delicioso pão de carne. Extra herético."
	icon_state = "xenobreadslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 3,
	)
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT / 5)
	tastes = list("bread" = 10, "acid" = 10)
	foodtypes = GRAIN | MEAT | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/bread/spidermeat
	name = "spider meat loaf"
	desc = "Um rolo de carne verde feito de carne de aranha."
	icon_state = "spidermeatbread"
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/toxin = 15,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/nutriment/protein = 12,
	)
	tastes = list("bread" = 10, "cobwebs" = 5)
	foodtypes = GRAIN|MEAT|DAIRY|TOXIC
	slice_type = /obj/item/food/breadslice/spidermeat
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/breadslice/spidermeat
	name = "spider meat bread slice"
	desc = "Um pedaço de bolo de carne feito de um animal que provavelmente ainda quer você morto."
	icon_state = "spidermeatslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/toxin = 3,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT / 5)
	tastes = list("bread" = 10, "cobwebs" = 5)
	foodtypes = GRAIN|MEAT|DAIRY|TOXIC
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/bread/banana
	name = "banana-nut bread"
	desc = "Um presente celestial e de enchimento."
	icon_state = "bananabread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/banana = 20,
	)
	tastes = list("bread" = 10) // bananjuice will also flavour
	foodtypes = GRAIN | FRUIT | MEAT
	slice_type = /obj/item/food/breadslice/banana
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/breadslice/banana
	name = "banana-nut bread slice"
	desc = "Uma fatia de pão de banana delicioso."
	icon_state = "bananabreadslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/banana = 4,
	)
	tastes = list("bread" = 10)
	foodtypes = GRAIN | FRUIT | MEAT
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/bread/tofu
	name = "tofubread"
	desc = "Como pão de carne, mas para vegetarianos. Não é garantido dar superpoderes."
	icon_state = "tofubread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/nutriment/protein = 10,
	)
	tastes = list("bread" = 10, "tofu" = 10)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	venue_value = FOOD_PRICE_TRASH
	slice_type = /obj/item/food/breadslice/tofu
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/breadslice/tofu
	name = "tofubread slice"
	desc = "Uma fatia de delicioso tofubread."
	icon_state = "tofubreadslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("bread" = 10, "tofu" = 10)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/bread/creamcheese
	name = "cream cheese bread"
	desc = "Yum Yum Yum!"
	icon_state = "creamcheesebread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("bread" = 10, "cheese" = 10)
	foodtypes = GRAIN | DAIRY
	slice_type = /obj/item/food/breadslice/creamcheese

/obj/item/food/breadslice/creamcheese
	name = "cream cheese bread slice"
	desc = "Uma fatia de yum!"
	icon_state = "creamcheesebreadslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("bread" = 10, "cheese" = 10)
	foodtypes = GRAIN | DAIRY

/obj/item/food/bread/mimana
	name = "mimana bread"
	desc = "Melhor comida em silêncio."
	icon_state = "mimanabread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/toxin/mutetoxin = 5,
		/datum/reagent/consumable/nothing = 5,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("bread" = 10, "silence" = 10)
	foodtypes = GRAIN | FRUIT | VEGETABLES
	slice_type = /obj/item/food/breadslice/mimana
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/breadslice/mimana
	name = "mimana bread slice"
	desc = "Um pedaço de silêncio!"
	icon_state = "mimanabreadslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/toxin/mutetoxin = 1,
		/datum/reagent/consumable/nothing = 1,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("bread" = 10, "silence" = 10)
	foodtypes = GRAIN | FRUIT | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/bread/empty
	name = "bread"
	icon_state = "tofubread"
	desc = "É pão, personalizado para seus sonhos mais selvagens."
	slice_type = /obj/item/food/breadslice/empty

// What you get from cutting a custom bread. Different from custom sliced bread.
/obj/item/food/breadslice/empty
	name = "bread slice"
	icon_state = "tofubreadslice"
	foodtypes = GRAIN
	desc = "É uma fatia de pão, personalizado para seus sonhos mais selvagens."

/obj/item/food/breadslice/empty/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, null, CUSTOM_INGREDIENT_ICON_FILL, max_ingredients = 8)

/obj/item/food/baguette
	name = "baguette"
	desc = "Bom apetite!"
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "baguette"
	inhand_icon_state = null
	worn_icon_state = "baguette"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	bite_consumption = 3
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	attack_verb_continuous = list("touche's")
	attack_verb_simple = list("touche")
	tastes = list("bread" = 1)
	foodtypes = GRAIN
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2
	/// whether this is in fake swordplay mode or not
	var/fake_swordplay = FALSE

/obj/item/food/baguette/Initialize(mapload)
	. = ..()
	register_context()

/obj/item/food/baguette/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(HAS_MIND_TRAIT(user, TRAIT_MIMING) && held_item == src)
		context[SCREENTIP_CONTEXT_LMB] = "Toggle Swordplay"
		return CONTEXTUAL_SCREENTIP_SET

/obj/item/food/baguette/examine(mob/user)
	. = ..()
	if(HAS_MIND_TRAIT(user, TRAIT_MIMING))
		. += span_notice("Você pode usar isso como uma espada usando-a em sua mão.")

/obj/item/food/baguette/attack_self(mob/user, modifiers)
	. = ..()
	if(!HAS_MIND_TRAIT(user, TRAIT_MIMING))
		return
	if(fake_swordplay)
		end_swordplay(user)
	else
		begin_swordplay(user)

/obj/item/food/baguette/proc/begin_swordplay(mob/user)
	visible_message(
		span_notice("[user] começa a empunhar [src] Como uma espada!"),
		span_notice("Você começa a empunhar [src] como uma espada, com um aperto firme no fundo como uma alça imaginária.")
	)
	ADD_TRAIT(src, TRAIT_CUSTOM_TAP_SOUND, SWORDPLAY_TRAIT)
	attack_verb_continuous = list("slashes", "cuts")
	attack_verb_simple = list("slash", "cut")
	hitsound = 'sound/items/weapons/rapierhit.ogg'
	fake_swordplay = TRUE

	RegisterSignal(src, COMSIG_ITEM_EQUIPPED, PROC_REF(on_sword_equipped))
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(on_sword_dropped))

/obj/item/food/baguette/proc/end_swordplay(mob/user)
	UnregisterSignal(src, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_DROPPED))

	REMOVE_TRAIT(src, TRAIT_CUSTOM_TAP_SOUND, SWORDPLAY_TRAIT)
	attack_verb_continuous = initial(attack_verb_continuous)
	attack_verb_simple = initial(attack_verb_simple)
	hitsound = initial(hitsound)
	fake_swordplay = FALSE

	if(user)
		visible_message(
			span_notice("[user] Não mais segura [src] Como uma espada!"),
			span_notice("Você volta a segurar [src] Normalmente.")
		)

/obj/item/food/baguette/proc/on_sword_dropped(datum/source, mob/user)
	SIGNAL_HANDLER

	end_swordplay()

/obj/item/food/baguette/proc/on_sword_equipped(datum/source, mob/equipper, slot)
	SIGNAL_HANDLER

	if(!(slot & ITEM_SLOT_HANDS))
		end_swordplay()

/// Deadly bread used by a mime
/obj/item/food/baguette/combat
	block_sound = 'sound/items/weapons/parry.ogg'
	sharpness = SHARP_EDGED
	icon_angle = -45
	/// Force when wielded as a sword by a mime
	var/active_force = 20
	/// Block chance when wielded as a sword by a mime
	var/active_block = 50

/obj/item/food/baguette/combat/begin_swordplay(mob/user)
	. = ..()
	force = active_force
	block_chance = active_block

/obj/item/food/baguette/combat/end_swordplay(mob/user)
	. = ..()
	force = initial(force)
	block_chance = initial(block_chance)

/obj/item/food/garlicbread
	name = "garlic bread"
	desc = "Infelizmente, é limitado."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "garlicbread"
	inhand_icon_state = null
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/garlic = 2,
	)
	bite_consumption = 3
	tastes = list("bread" = 1, "garlic" = 1, "butter" = 1)
	foodtypes = VEGETABLES|GRAIN|DAIRY
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/butterbiscuit
	name = "butter biscuit"
	desc = "Bem, manteiga meu biscoito!"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "butterbiscuit"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("butter" = 1, "biscuit" = 1)
	foodtypes = GRAIN | BREAKFAST | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/butterdog
	name = "butterdog"
	desc = "Feito de manteigas exóticas."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "butterdog"
	bite_consumption = 1
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("butter" = 1, "exotic butter" = 1)
	foodtypes = GRAIN | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_price = PAYCHECK_CREW

/obj/item/food/butterdog/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/slippery, 8 SECONDS)

/obj/item/food/raw_frenchtoast
	name = "raw french toast"
	desc = "Uma fatia de pão embebida numa mistura de ovos batidos. Coloque em uma grelha para começar a cozinhar!"
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "raw_frenchtoast"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("raw egg" = 2, "soaked bread" = 1)
	foodtypes = GRAIN | RAW | BREAKFAST | MEAT | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/raw_frenchtoast/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/frenchtoast, rand(20 SECONDS, 30 SECONDS), TRUE)

/obj/item/food/frenchtoast
	name = "french toast"
	desc = "Uma fatia de pão embebido em uma mistura de ovos e grelhado até marrom dourado. Drizzle com xarope!"
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "frenchtoast"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("french toast" = 1, "syrup" = 1, "golden deliciousness" = 1)
	foodtypes = GRAIN | BREAKFAST | MEAT | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/raw_breadstick
	name = "raw breadstick"
	desc = "Uma faixa crua de massa na forma de um palito de pão."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "raw_breadstick"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("raw dough" = 1)
	foodtypes = GRAIN | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/raw_breadstick/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/breadstick, rand(15 SECONDS, 20 SECONDS), TRUE, TRUE)

/obj/item/food/breadstick
	name = "breadstick"
	desc = "Uma deliciosa, manteiga de pão. Altamente viciante, mas valeu a pena."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "breadstick"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("fluffy bread" = 1, "butter" = 2)
	foodtypes = GRAIN | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/raw_croissant
	name = "raw croissant"
	desc = "Massa dobrada pronta para fazer um croissant."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "raw_croissant"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("raw dough" = 1)
	foodtypes = GRAIN | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/raw_croissant/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/croissant, rand(15 SECONDS, 20 SECONDS), TRUE, TRUE)

/obj/item/food/croissant
	name = "croissant"
	desc = "Um delicioso croissant amanteigado. O começo perfeito do dia."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "croissant"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("fluffy bread" = 1, "butter" = 2)
	foodtypes = GRAIN | DAIRY | BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

// Enhanced weaponised bread
/obj/item/food/croissant/throwing
	throwforce = 20
	tastes = list("fluffy bread" = 1, "butter" = 2, "metal" = 1)
	food_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/iron = 1)

/obj/item/food/croissant/throwing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/boomerang, throw_range, TRUE)
