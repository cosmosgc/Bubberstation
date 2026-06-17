/// Handpicked list of various pizzas and "pizzas" to make sure it's both 'safe' (human-edible) and doesn't spawn the base type like the bomb pizza can.
#define EDIBLE_PIZZA_LIST list( \
	/obj/item/food/pizza/margherita, \
	/obj/item/food/pizza/meat, \
	/obj/item/food/pizza/mushroom, \
	/obj/item/food/pizza/vegetable, \
	/obj/item/food/pizza/donkpocket, \
	/obj/item/food/pizza/dank, \
	/obj/item/food/pizza/sassysage, \
	/obj/item/food/pizza/pineapple, \
	/obj/item/food/pizza/mothic_margherita, \
	/obj/item/food/pizza/mothic_firecracker, \
	/obj/item/food/pizza/mothic_five_cheese, \
	/obj/item/food/pizza/mothic_white_pie, \
	/obj/item/food/pizza/mothic_pesto, \
	/obj/item/food/pizza/mothic_garlic, \
	/obj/item/food/pizza/flatbread/rustic, \
	/obj/item/food/pizza/flatbread/italic, \
	/obj/item/food/pizza/flatbread/zmorgast, \
	/obj/item/food/pizza/flatbread/fish, \
	/obj/item/food/pizza/flatbread/mushroom, \
	/obj/item/food/pizza/flatbread/nutty, \
)

/obj/item/food/mre_course
	name = "undefined MRE course"
	desc = "Algo que você não deveria ver. Mas é comestível."
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/courses.dmi'
	icon_state = "main_course"
	food_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes = list("crayon powder" = 1)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/mre_course/main
	name = "MRE main course"
	desc = "Curso principal da antiga ração militar projetada para tropas terrestres. Este não é nada."
	tastes = list("strawberry" = 1, "vanilla" = 1, "chocolate" = 1)

/obj/item/food/mre_course/main/beans
	name = "MRE main course - Pork and Beans"
	desc = "Curso principal da antiga ração militar projetada para tropas terrestres. Este é porco e feijão coberto de molho de tomate."
	tastes = list("beans" = 1, "pork" = 1, "tomato sauce" = 1)
	foodtypes = MEAT | VEGETABLES

/obj/item/food/mre_course/main/macaroni
	name = "MRE main course - Macaroni and Cheese"
	desc = "Curso principal da antiga ração militar projetada para tropas terrestres. Este é macarrão pré-cozido coberto de queijo reserva federal."
	tastes = list("cold macaroni" = 1, "bland cheese" = 1)
	foodtypes = DAIRY | GRAIN

/obj/item/food/mre_course/main/rice
	name = "MRE main course - Rice and Beef"
	desc = "Curso principal da antiga ração militar projetada para tropas terrestres. Este é arroz com carne, coberto de molho."
	tastes = list("dense rice" = 1, "bits of beef" = 1, "gravy" = 1)
	foodtypes = GRAIN | MEAT

/obj/item/food/mre_course/side
	name = "MRE side course"
	desc = "Curso lateral da antiga ração militar projetada para tropas terrestres. Este não é nada."
	icon_state = "side_dish"

/obj/item/food/mre_course/side/bread
	name = "MRE side course - Cornbread"
	desc = "Curso lateral da antiga ração militar projetada para tropas terrestres. Este é pão de milho."
	tastes = list("cornbread" = 1)
	foodtypes = GRAIN

/obj/item/food/mre_course/side/pie
	name = "MRE side course - Meat Pie"
	desc = "Curso lateral da antiga ração militar projetada para tropas terrestres. Esta é uma torta de carne."
	tastes = list("pie dough" = 1, "ground meat" = 1, "Texas" = 1)
	foodtypes = MEAT | GRAIN

/obj/item/food/mre_course/side/chicken
	name = "MRE side course - Sweet 'n Sour Chicken"
	desc = "Curso lateral da antiga ração militar projetada para tropas terrestres. Esta é uma carne indefinida, coberta de molho barato avermelhado."
	tastes = list("bits of chicken meat" = 1, "sweet and sour sauce" = 1, "salt" = 1)
	foodtypes = MEAT | FRIED

/obj/item/food/mre_course/dessert
	name = "MRE dessert"
	desc = "Sobremesa da antiga ração militar projetada para tropas terrestres. Este não é nada."
	icon_state = "dessert"

/obj/item/food/mre_course/dessert/cookie
	name = "MRE dessert - Cookie"
	desc = "Sobremesa da antiga ração militar projetada para tropas terrestres. Este é um grande biscoito seco."
	tastes = list("dryness" = 1, "hard cookie" = 1, "chocolate chip" = 1)
	foodtypes = GRAIN | SUGAR

/obj/item/food/mre_course/dessert/cake
	name = "MRE dessert - Apple Pie"
	desc = "Sobremesa da antiga ração militar projetada para tropas terrestres. Esta é uma torta de maçã amorfa."
	tastes = list("apple" = 1, "moist cake" = 1, "sugar" = 1)
	foodtypes = GRAIN | SUGAR | FRUIT

/obj/item/food/mre_course/dessert/chocolate
	name = "MRE dessert - Dark Chocolate"
	desc = "Sobremesa da antiga ração militar projetada para tropas terrestres. Este é um chocolate escuro."
	tastes = list("vanilla" = 1, "artificial chocolate" = 1, "chemicals" = 1)
	foodtypes = JUNKFOOD | SUGAR

/obj/item/storage/box/hecu_rations
	name = "Meal, Ready-to-Eat"
	desc = "Uma caixa contendo algumas rações e chicletes, por manter um comedor de lápis de cera faminto."
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/mre_hecu.dmi'
	icon_state = "mre_package"
	illustration = null

/obj/item/storage/box/hecu_rations/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 5

/obj/item/storage/box/hecu_rations/PopulateContents()
	var/main_course = pick(/obj/item/food/mre_course/main/beans, /obj/item/food/mre_course/main/macaroni, /obj/item/food/mre_course/main/rice)
	var/side_dish = pick(/obj/item/food/mre_course/side/bread, /obj/item/food/mre_course/side/pie, /obj/item/food/mre_course/side/chicken)
	var/dessert = pick(/obj/item/food/mre_course/dessert/cookie, /obj/item/food/mre_course/dessert/cake, /obj/item/food/mre_course/dessert/chocolate)
	new main_course(src)
	new side_dish(src)
	new dessert(src)
	new /obj/item/storage/box/gum(src)
	new /obj/item/food/spacers_sidekick(src)

/obj/item/pizzabox/random
	boxtag = "Randy's Surprise"
	boxtag_set = TRUE

/obj/item/pizzabox/random/Initialize(mapload)
	. = ..()
	if(!pizza)
		var/random_pizza = pick(EDIBLE_PIZZA_LIST)
		pizza = new random_pizza(src)

#undef EDIBLE_PIZZA_LIST
