//Ingredients and Simple Dishes
/obj/item/food/kimchi
	name = "kimchi"
	desc = "Um prato coreano clássico no estilo marciano: repolho picado com pimenta, konbu, bonito, e uma mistura de especiarias."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kimchi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("spicy cabbage" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/inferno_kimchi
	name = "inferno kimchi"
	desc = "Para quando kimchi comum simplesmente não pode coçar sua coceira para o calor insano, inferno kimchi pega a folga."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "inferno_kimchi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/capsaicin = 3,
	)
	tastes = list("very spicy cabbage" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/garlic_kimchi
	name = "garlic kimchi"
	desc = "Uma nova reviravolta em uma fórmula clássica, kimchi e alho, finalmente juntos em perfeita harmonia."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "garlic_kimchi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/capsaicin = 1,
		/datum/reagent/consumable/garlic = 2,
	)
	tastes = list("spicy cabbage" = 1, "garlic" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/surimi
	name = "surimi"
	desc = "Uma porção de surimi de peixe não curado."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "surimi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("fish" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/surimi/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dryable, /obj/item/food/kamaboko)

/obj/item/food/kamaboko
	name = "kamaboko"
	desc = "Um bolo de peixe curado japonês usado em lanches e ramen."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kamaboko_sunrise"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("fish" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/kamaboko/Initialize(mapload)
	. = ..()
	var/design = pick("smiling", "spiral", "star", "sunrise")
	name = "[design] kamaboko"
	icon_state = "kamaboko_[design]"

/obj/item/food/kamaboko/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/kamaboko_slice, 4, 3 SECONDS, table_required = TRUE, screentip_verb = "Cut")

/obj/item/food/kamaboko_slice
	name = "kamaboko slice"
	desc = "Uma fatia de bolo de peixe. Vai bem em ramen."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kamaboko_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("fish" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/sambal
	name = "sambal"
	desc = "Uma pasta de especiarias da Indonésia, usada amplamente em cozinhar em todo o Sudeste Asiático."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "sambal"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/capsaicin = 2
	)
	tastes = list("chilli heat" = 1, "umami" = 1)
	foodtypes = VEGETABLES|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/katsu_fillet
	name = "katsu fillet"
	desc = "Carne em pão e frita, usada para uma variedade de pratos."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "katsu_fillet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment = 2
	)
	tastes = list("meat" = 1, "breadcrumbs" = 1)
	foodtypes = MEAT|FRIED|GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/rice_dough
	name = "rice dough"
	desc = "Um pedaço de massa feita com partes iguais farinha de arroz e farinha de trigo, para um sabor único."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "rice_dough"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6
	)
	tastes = list("rice" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/rice_dough/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/bread/reispan, rand(30 SECONDS, 45 SECONDS), TRUE, TRUE)

/obj/item/food/rice_dough/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/spaghetti/rawnoodles, 6, 3 SECONDS, table_required = TRUE)

/obj/item/food/spaghetti/rawnoodles
	name = "fresh noodles"
	desc = "Macarrão de arroz, feito fresco. Lembre-se, não há ingrediente secreto."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "raw_noodles"

	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3
	)
	tastes = list("rice" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spaghetti/boilednoodles
	name = "cooked noodles"
	desc = "Cozinhado fresco para o pedido."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "cooked_noodles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3
	)
	tastes = list("rice" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/bread/reispan
	name = "reispan"
	desc = "Embora o conceito de pão de arroz tenha sido comum na Ásia por séculos, o Reispan como o conhecemos hoje é mais comumente associado a Marte, onde terras aráveis limitadas forçaram a engenhosidade."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "reispan"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15
	)
	tastes = list("bread" = 10)
	foodtypes = GRAIN
	venue_value = FOOD_PRICE_TRASH
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/bread/reispan/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/breadslice/reispan, 5, 3 SECONDS, table_required = TRUE)

/obj/item/food/breadslice/reispan
	name = "reispan slice"
	desc = "Uma fatia de Reispan, para usar em sanduíches marcianos."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "reispan_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3
	)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_3

// Fried Rice

/obj/item/food/salad/hurricane_rice
	name = "hurricane fried rice"
	desc = "Inspirado por nasi goreng, este prato de arroz picante vem direto de Prospect, em Marte, e seus mercados noturnos. Ele é nomeado por seu estilo de cozinha distinto, onde o arroz fritando é dado muito tempo de ar ao ser virado, principalmente porque parece muito legal para os clientes."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "hurricane_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("rice" = 1, "meat" = 1, "pineapple" = 1, "veggies" = 1)
	foodtypes = MEAT | GRAIN | PINEAPPLE | FRUIT | VEGETABLES | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/ikareis
	name = "ikareis"
	desc = "Um prato de arroz picante feito com tinta de lula, pimentas, cebolas, salsicha, e chillis saborosa."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "ikareis"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/capsaicin = 4
	)
	tastes = list("rice" = 1, "squid ink" = 1, "veggies" = 1, "sausage" = 1, "chilli heat" = 1)
	foodtypes = MEAT | GRAIN | SEAFOOD | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/salad/hawaiian_fried_rice
	name = "\improper Hawaiian fried rice"
	desc = "Não é um prato tradicional havaiano, o arroz frito havaiano em vez de usa um pastiche de ingredientes havaianos, incluindo Chap picado e, polemicamente, abacaxi. Os puristas estão divididos se o abacaxi pertence ao arroz."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "hawaiian_fried_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("rice" = 1, "pork" = 1, "pineapple" = 1, "soy sauce" = 1, "veggies" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES | FRUIT | PINEAPPLE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/ketchup_fried_rice
	name = "ketchup fried rice"
	desc = "Uma comida clássica japonesa de conforto, feita com salsicha, vegetais, molho Worchestershire, arroz... e, claro, ketchup."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "ketchup_fried_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/ketchup = 2,
	)
	tastes = list("rice" = 1, "sausage" = 1, "ketchup" = 1, "veggies" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/salad/mediterranean_fried_rice
	name = "mediterranean fried rice"
	desc = "Uma estranha opinião sobre a fórmula do arroz frito: ervas, queijo, azeitonas, e claro, almôndegas. Como um híbrido de risoto e arroz frito."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "mediterranean_fried_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("rice" = 1, "cheese" = 1, "meatball" = 1, "olives" = 1, "herbs" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES | DAIRY | FRUIT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/egg_fried_rice
	name = "egg fried rice"
	desc = "Tão simples quanto arroz frito fica: arroz, ovo, molho de soja. Simples, elegante e infinitamente personalizável."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "egg_fried_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("rice" = 1, "egg" = 1, "soy sauce" = 1)
	foodtypes = MEAT | GRAIN | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/salad/egg_fried_rice/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, null, CUSTOM_INGREDIENT_ICON_STACK)

/obj/item/food/salad/bibimbap
	name = "bibimbap"
	desc = "Um prato coreano composto de arroz e várias coberturas, servido em uma tigela de pedra quente."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "bibimbap"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("rice" = 1, "spicy cabbage" = 1, "chilli heat" = 1, "egg" = 1, "meat" = 1)
	foodtypes = MEAT | VEGETABLES | GRAIN | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/bibimbap/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, null, CUSTOM_INGREDIENT_ICON_STACK)

// Noodles
/obj/item/food/salad/bulgogi_noodles
	name = "bulgogi noodles"
	desc = "Carne de churrasco coreana servida com macarrão! Feito com gochujang, para um sabor extra picante."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "bulgogi_noodles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("barbecue meat" = 1, "noodles" = 1, "chilli heat" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES | FRUIT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/yakisoba_katsu
	name = "yakisoba katsu"
	desc = "Carne frita e empanada numa cama de macarrão frito. Delicioso, se não convencional."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "yakisoba_katsu"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment = 8,
	)
	tastes = list("fried noodles" = 1, "meat" = 1, "breadcrumbs" = 1, "veggies" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/martian_fried_noodles
	name = "\improper Martian fried noodles"
	desc = "Macarrão frito do planeta vermelho. Cozinha marciana atrai de muitas culturas, e estes macarrão não são exceção. Há elementos da cozinha malaia, tailandesa, chinesa, coreana e japonesa aqui."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "martian_fried_noodles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment = 8,
	)
	tastes = list("noodles" = 1, "meat" = 1, "nuts" = 1, "onion" = 1, "egg" = 1)
	foodtypes = GRAIN | NUTS | MEAT | VEGETABLES | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/simple_fried_noodles
	name = "simple fried noodles"
	desc = "Um simples, mas delicioso prato de macarrão frito, perfeito para o chef criativo para fazer qualquer macarrão frito que eles querem."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "simple_fried_noodles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment = 6,
	)
	tastes = list("noodles" = 1, "soy sauce" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/salad/simple_fried_noodles/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, null, CUSTOM_INGREDIENT_ICON_STACK)

// Curry
/obj/item/food/salad/setagaya_curry //let me explain...
	name = "\improper Setagaya curry"
	desc = "Tornada famosa por um café em Setagaya, a extensa receita deste curry passou a ser um segredo bem guardado entre os donos de cafés através do espaço humano. O gosto é dito para reabastecer a alma do restaurante, o que quer que isso signifique."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "setagaya_curry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/medicine/omnizine = 5,
	)
	tastes = list("masterful curry" = 1, "rice" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|FRUIT|SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_5 //Extensive and secretly guarded. Was previously 2 and I thought it was pathetic.
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

// Burgers and Sandwiches
/obj/item/food/burger/big_blue
	name = "\improper Big Blue burger"
	desc = "O original e melhor Big Blue, direto da lanchonete favorita de Marte. Pegue a onda, irmão!"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "big_blue_burger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("bun" = 1, "burger" = 2, "teriyaki onions" = 1, "cheese" = 1, "bacon" = 1, "pineapple" = 1)
	foodtypes = MEAT | GRAIN | DAIRY | VEGETABLES | FRUIT | PINEAPPLE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4 //It's THE big blue, Baby!
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/burger/chappy
	name = "\improper Chappy patty"
	desc = "Originalmente nascido de uma noite de bebida na cozinha de um Big Blue Burger, o Chappy Patty tornou-se um grampo do menu de Big Blue e havaiano (ou, pelo menos, faux-Hawaiian) cozinha galáxia em toda a galáxia. Dado que Big Kahuna opera a maioria de suas lojas em Marte, talvez não seja de admirar que este prato seja popular lá."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "chappy_patty"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("bun" = 1, "fried pork" = 2, "egg" = 1, "cheese" = 1, "ketchup" = 1)
	foodtypes =  MEAT|GRAIN|DAIRY|FRIED|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/king_katsu_sandwich
	name = "\improper King Katsu sandwich"
	desc = "Um grande sanduíche com katsu frito crocante, bacon, salada de kimchi e salada, tudo em pão Reispan. Verdadeiramente o rei da carne entre o pão."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "king_katsu_sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("meat" = 1, "bacon" = 1, "kimchi" = 1, "salad" = 1, "rice bread" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/marte_cubano_sandwich
	name = "\improper Marte Cubano sandwich"
	desc = "Um alimento de fusão de Marte, o Marte-Cubano é baseado no cubano clássico, mas atualizado para disponibilidade de ingredientes e mudanças de gosto."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "marte_cubano_sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("bacon" = 1, "pickles" = 1, "cheese" = 1, "rice bread" = 1)
	foodtypes = MEAT | DAIRY | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/little_shiro_sandwich
	name = "\improper Little Shiro sandwich"
	desc = "Um clássico sanduíche marciano, nomeado pelo primeiro presidente de Terragov vindo de Marte. Apresenta ovos fritos, carne bungogi, uma salada de kimchi, e uma cobertura saudável de queijo mozzarella."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "marte_cubano_sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("egg" = 1, "meat" = 1, "kimchi" = 1, "mozzarella" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|DAIRY|FRIED|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/croque_martienne
	name = "croque-martienne"
	desc = "O sanduíche de café da manhã marciano. Ovo, barriga de porco, abacaxi, queijo. Simples. Clássico. Disponível em todos os cafés de New Osaka."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "croque_martienne"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("egg" = 1, "toast" = 1, "pork" = 1, "pineapple" = 1, "cheese" = 1)
	foodtypes = MEAT|GRAIN|FRUIT|DAIRY|FRIED|PINEAPPLE|BREAKFAST|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/prospect_sunrise
	name = "\improper Prospect Sunrise"
	desc = "O segundo sanduíche de café da manhã marciano. A combinação mais bonita de omelete, bacon, picles e queijo. Disponível em todos os cafés em Prospect."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "prospect_sunrise"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("egg" = 1, "toast" = 1, "bacon" = 1, "pickles" = 1, "cheese" = 1)
	foodtypes = MEAT | DAIRY | VEGETABLES | GRAIN | BREAKFAST | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

// Snacks
/obj/item/food/takoyaki
	name = "takoyaki"
	desc = "Uma comida de rua japonesa clássica, takoyaki (ou bolas de polvo) são feitos de polvo e cebola dentro de uma massa frita, coberto com um molho salgado."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "takoyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
	)
	tastes = list("octopus" = 1, "batter" = 1, "onion" = 1, "worcestershire sauce" = 1)
	foodtypes = SEAFOOD | GRAIN | FRIED | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/takoyaki/russian
	name = "russian takoyaki"
	desc = "Uma reviravolta perigosa em um prato clássico, que faz para o disfarce perfeito para fugir da polícia."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "russian_takoyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/capsaicin = 10,
	)
	tastes = list("octopus" = 1, "batter" = 1, "onion" = 1, "chilli heat" = 1)
	foodtypes = SEAFOOD | GRAIN | FRIED | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/takoyaki/taco
	name = "tacoyaki"
	desc = "Direto das barracas de comida de rua mais inovadoras de Marte, é o polvo de troca de taco de carne e milho, e molho Worcestershire para queso. Tan sabroso!"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "tacoyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
	)
	tastes = list("taco meat" = 1, "batter" = 1, "corn" = 1, "cheese" = 1)
	foodtypes = MEAT|GRAIN|FRIED|VEGETABLES|DAIRY|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4 //Batter AND Cargo ingredients.
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/okonomiyaki
	name = "okonomiyaki"
	desc = "Um clássico de Kansai, okonomiyaki consiste em uma panqueca saborosa cheia de... bem, o que você quiser- embora repolho, nagaimo e dashi são muito necessários, como é o molho de okonomiyaki epônimo."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "okonomiyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("batter" = 1, "cabbage" = 1, "onion" = 1, "worcestershire sauce" = 1)
	foodtypes = GRAIN|FRIED|VEGETABLES|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4 //Cargo stuff and batter.

//hey, the name literally means "grilled how you like it", it'd be crazy to not make it customisable
/obj/item/food/okonomiyaki/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, null, CUSTOM_INGREDIENT_ICON_STACK)

/obj/item/food/brat_kimchi
	name = "brat-kimchi"
	desc = "Kimchi frito, misturado com açúcar e coberto com salsicha. Um prato popular em izakayas em Marte."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "brat_kimchi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/sugar = 2,
	)
	tastes = list("spicy cabbage" = 1, "sausage" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/tonkatsuwurst
	name = "tonkatsuwurst"
	desc = "Uma fusão cultural entre cozinha alemã e japonesa, Tonkatsuwurst mistura o currywurst e molho Tonkatsu em algo familiar, mas novo."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "tonkatsuwurst"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/worcestershire = 2,
	)
	tastes = list("sausage" = 1, "spicy sauce" = 1, "fries" = 1)
	foodtypes = MEAT|VEGETABLES|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4 //Cargo ingredients and a few steps.
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/kebab/ti_hoeh_koe
	name = "ti hoeh koe skewer"
	desc = "Sangue de porco, misturado com arroz, frito, e coberto com amendoim e coentro. É um gosto adquirido com certeza, mas é popular nos mercados noturnos de Prospect, trazidos por colonos taiwaneses."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "ti_hoeh_koe"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/peanut_butter = 1,
	)
	tastes = list("blood" = 1, "nuts" = 1, "herbs" = 1)
	foodtypes = MEAT|FRIED|NUTS|GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/kitzushi
	name = "kitzushi"
	desc = "Uma variante em inarizushi popular em Marte entre vulpinídeos (e a comunidade animalide mais ampla), kitzushi integra um queijo picante e mistura de pimenta dentro do bolso para obter sabor extra."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kitzushi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("rice" = 1, "tofu" = 1, "chilli cheese" = 1)
	foodtypes = GRAIN | FRIED | VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/epok_epok
	name = "epok-epok"
	desc = "Um lanche frito da Malásia, que migrou via Cingapura para a dieta marciana. Cheio de frango e batatas, ao lado de uma fatia de ovo cozido, é uma comida popular no Planeta Vermelho."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "epok_epok"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("curry" = 1, "egg" = 1, "pastry" = 1)
	foodtypes = GRAIN | MEAT | VEGETABLES | FRIED | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/roti_john
	name = "roti john"
	desc = "Um clássico lanche malaio, o roti john consiste em pão frito em uma mistura de carne, ovo e cebola, produzindo um resultado que está em algum lugar entre torrada francesa e uma omelete."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "roti_john"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment = 10,
	)
	tastes = list("bread" = 1, "egg" = 1, "meat" = 1, "onion" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|BREAKFAST|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/izakaya_fries
	name = "izakaya fries"
	desc = "As batatas fritas favoritas de Nova Osaka, 2 séculos seguidos... e tudo graças ao casamento de Red Bay, Furikake e maionese."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "izakaya_fries"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("fries" = 1, "mars" = 1)
	foodtypes = VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3 //Extra complexity due to cargo ingredient.

/obj/item/food/kurry_ok_subsando
	name = "kurry-ok subsando"
	desc = "O coelhinho conhece a engenhosidade marciana na forma do subsando kurry-ok, com batatas fritas e caril katsu em perfeita harmonia."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kurry_ok_subsando"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("bread" = 1, "spicy fries" = 1, "mayonnaise" = 1, "curry" = 1, "meat" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/loco_moco
	name = "loco moco"
	desc = "Um clássico simples do Havaí. Faz para uma refeição recheada, saborosa e barata."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "loco_moco"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
	)
	tastes = list("rice" = 1, "burger" = 1, "gravy" = 1, "egg" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|FRIED|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/wild_duck_fries
	name = "wild duck fries"
	desc = "Batatas fritas com pato picado, ketchup, maionese e Red Bay. Uma comida de rua clássica em Marte, embora eles são mais frequentemente associados com Kwik-Kwak, favorito de Marte (e, de fato, apenas) esquivar cadeia de fast food temáticos."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "wild_duck_fries"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("fries" = 1, "duck" = 1, "ketchup" = 1, "mayo" = 1, "spicy seasoning" = 1)
	foodtypes = MEAT | VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4 //Requires a complex 3 as an ingredient.
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/little_hawaii_hotdog
	name = "\improper Little Hawaii hotdog"
	desc = "Dos vendedores amigáveis da Avenida Honolulu vem o Pequeno Hawaii cão tropical e engorda, tudo ao mesmo tempo!"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "little_hawaii_hotdog"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("sausage" = 1, "pineapple" = 1, "onion" = 1, "teriyaki" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|FRUIT|PINEAPPLE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_price = PAYCHECK_CREW * 1.2
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/salt_chilli_fries
	name = "salt n' chilli fries"
	desc = "O nome simples deste prato não conta a história completa de sua deliciosa-certa, sal e pimenta são grandes componentes, mas a cebola, gengibre e alho são os verdadeiros heróis do sabor aqui."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "salt_chilli_fries"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("fries" = 1, "garlic" = 1, "ginger" = 1, "numbing heat" = 1, "salt" = 1)
	foodtypes = VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/grilled_octopus
	name = "grilled octopus tentacle"
	desc = "Um prato de frutos do mar simples, típico de qualquer lugar que o polvo é comido. Marcianos gostam com Red Bay."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "grilled_octopus"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/char = 2)
	tastes = list("octopus" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/steak_croquette
	name = "steak croquette"
	desc = "Cara, enfiando pedaços de bife em um croquete. Deve ser o caminho do campo."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "steak_croquette"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("steak" = 1, "potato" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|DAIRY|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/chapsilog
	name = "chapsilog"
	desc = "Um silog tradicional filipino composto por sinangag, um ovo frito, e fatias de cap. É um café da manhã simples, mas cheio."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "chapsilog"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/garlic = 1,
	)
	tastes = list("ham" = 1, "garlic rice" = 1, "egg" = 1)
	foodtypes = MEAT|GRAIN|FRIED|BREAKFAST|VEGETABLES|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/chap_hash
	name = "chap hash"
	desc = "O que você ganha quando você combina o cara, cebola, pimenta e batatas? O haxixe, é claro! Adicione um pouco de Red Bay, e você tem um delicioso café da manhã."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "chap_hash"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment = 3,
	)
	tastes = list("ham" = 1, "onion" = 1, "pepper" = 1, "potato" = 1)
	foodtypes = MEAT | VEGETABLES | BREAKFAST | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/agedashi_tofu
	name = "agedashi tofu"
	desc = "Tofu frito crocante, servido em um saboroso caldo de umami. Serviu freqüentemente em izakayas."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "agedashi_tofu"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("umami broth" = 1, "tofu" = 1)
	foodtypes = SEAFOOD | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

// Curries and Stews
/obj/item/food/salad/po_kok_gai
	name = "po kok gai"
	desc = "Also known as galinha à portuguesa, or Portuguese chicken, this dish is a Macanese classic born of Portuguese colonialism, though the dish itself is not a Portuguese dish. It consists of chicken in \"Molho Português\"Um caril à base de coco."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "po_kok_gai"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("chicken" = 1, "coconut" = 1, "curry" = 1)
	foodtypes = MEAT|GRAIN|FRUIT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/salad/huoxing_tofu
	name = "\improper Huoxing tofu"
	desc = "Uma adaptação do mapa tofu fez famoso em Prospect, a meca foodie de Marte. Até parece Marte, se você realmente olhar."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "huoxing_tofu"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/capsaicin = 2
	)
	tastes = list("meat" = 1, "chilli heat" = 1, "tofu" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/feizhou_ji
	name = "fēizhōu jī"
	desc = "Considered a Macanese variant on piri-piri, fēizhōu jī, or galinha à africana, or African chicken (if you're feeling like speaking Common), is a popular dish in the TID, and subsequently also on Mars due to its influx of Macanese settlers."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "feizhou_ji"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("chicken" = 1, "chilli heat" = 1, "vinegar" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/salad/galinha_de_cabidela
	name = "galinha de cabidela"
	desc = "Originalmente um prato português, cabidela arroz é tradicionalmente feito com frango em Portugal, e pato em Macau- em última análise, a versão de frango ganhou em Marte devido à influência europeia."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "galinha_de_cabidela"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 12,
	)
	tastes = list("chicken" = 1, "iron" = 1, "vinegar" = 1, "rice" = 1)
	foodtypes = MEAT | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/salad/katsu_curry
	name = "katsu curry"
	desc = "Carne empanada e frita, coberta de molho de caril e servida em uma cama de arroz."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "katsu_curry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
	)
	tastes = list("curry" = 1, "meat" = 1, "breadcrumbs" = 1, "rice" = 1)
	foodtypes = MEAT|GRAIN|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/beef_bowl
	name = "beef bowl"
	desc = "Uma deliciosa mistura de carne ensopada, cebola e dashi, servidos sobre arroz. As coberturas típicas incluem gengibre em conserva, pimenta em pó e ovos fritos."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "beef_bowl"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("beef" = 25, "onion" = 25, "chili heat" = 15, "rice" = 34, "soul" = 1) //I pour my soul into this bowl
	foodtypes = MEAT|VEGETABLES|GRAIN|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/salt_chilli_bowl
	name = "salt n' chilli octopus bowl"
	desc = "Inspirado pela tradição japonesa donburi, esta tomada picante de dez dons é uma sensação de sabor que varreu a nação marciana."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "salt_chilli_bowl"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("seafood" = 1, "rice" = 1, "garlic" = 1, "ginger" = 1, "numbing heat" = 1, "salt" = 1)
	foodtypes = VEGETABLES|GRAIN|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4 //A few Cargo ingredients

/obj/item/food/salad/kansai_bowl
	name = "\improper Kansai bowl"
	desc = "Também conhecido como konohadon, este donburi é típico da região de Kansai, e consiste em bolo de peixe kamaboko, ovo e cebola servido sobre arroz."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kansai_bowl"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("seafood" = 1, "rice" = 1, "egg" = 1, "onion" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|SEAFOOD|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/eigamudo_curry //curry is meant to be really spicy or kinda mild, this just stinks!
	name = "\improper Eigamudo curry"
	desc = "Um prato de caril inexplicável feito de uma cacofonia de ingredientes. Provavelmente gosto bom para alguém, em algum lugar, embora boa sorte em encontrá-los."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "eigamudo_curry"
	food_reagents = list(
		/datum/reagent/consumable/nutraslop = 8,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/toxin/slimejelly = 4,
	)
	tastes = list("grit" = 1, "slime" = 1, "gristle" = 1, "rice" = 1, "Mystery Food X" = 1)
	foodtypes = VEGETABLES|GRAIN|FRUIT|SEAFOOD|GROSS|TOXIC
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

// Entrees
/obj/item/food/cilbir
	name = "çilbir"
	desc = "Ovos, servidos em uma base de iogurte salgado com uma cobertura de óleo picante. Originalmente um prato turco, veio para Marte com colonos alemães-turcos e tornou-se uma base de café da manhã desde então."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "cilbir"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/garlic = 1,
	)
	tastes = list("yoghurt" = 1, "garlic" = 1, "lemon" = 1, "egg" = 1, "chilli heat" = 1)
	foodtypes = MEAT|VEGETABLES|DAIRY|FRIED|BREAKFAST|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/peking_duck_crepes
	name = "\improper Peking duck crepes a l'orange"
	desc = "Este prato leva o melhor da cozinha de Pequim e Paris para fazer uma deliciosa e picante refeição."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "peking_duck_crepes"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/orangejuice = 4,
	)
	tastes = list("meat" = 1, "crepes" = 1, "orange" = 1)
	foodtypes = MEAT|GRAIN|FRUIT|SUGAR|ORANGES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

// Desserts
/obj/item/food/cake/spekkoek
	name = "vulgaris spekkoek"
	desc = "Trazido a Marte por colonos holandeses e indonésios, Spekkoek é um bolo de férias comum no Planeta Vermelho, sendo muitas vezes servido como parte de um tradicional rijsttafel. O uso de ambrósia vulgar como aromatizante é uma necessidade no espaço profundo, já que a folha de pandan é rara tão longe da Terra."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "spekkoek"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 30,
		/datum/reagent/consumable/nutriment/vitamin = 15
	)
	tastes = list("winter spices" = 2, "ambrosia vulgaris" = 2, "cake" = 5)
	foodtypes = VEGETABLES|GRAIN|DAIRY|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/spekkoek/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/cakeslice/spekkoek, 5, 3 SECONDS, table_required = TRUE)

/obj/item/food/cakeslice/spekkoek
	name = "vulgaris spekkoek slice"
	desc = "Uma fatia de vulgaris spekkoek. Se você é marciano, isso pode lembrá-lo de casa."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "spekkoek_slice"
	tastes = list("winter spices" = 2, "ambrosia vulgaris" = 2, "cake" = 5)
	foodtypes = VEGETABLES|GRAIN|DAIRY|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/pineapple_foster
	name = "pineapple foster"
	desc = "Uma clássica adaptação marciana de outra sobremesa clássica, Abacaxi Foster é um doce tostado que apresenta apenas um risco de fogo leve a moderado."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "pineapple_foster"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/caramel = 4,
		/datum/reagent/consumable/pineapplejuice = 2,
		/datum/reagent/consumable/milk = 4
	)
	tastes = list("pineapple" = 1, "vanilla" = 1, "caramel" = 1, "ice cream" = 1)
	foodtypes = GRAIN|FRUIT|DAIRY|SUGAR|PINEAPPLE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pastel_de_nata
	name = "pastel de nata"
	desc = "Originally created by Portuguese monks, pastéis de nata went worldwide under the Portuguese colonial empire- including Macau, from which it came to Mars with settlers from the TID of Hong Kong and Macau."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "pastel_de_nata"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sugar = 4,
	)
	tastes = list("custard" = 1, "vanilla" = 1, "sweet pastry" = 1)
	foodtypes = GRAIN|FRUIT|DAIRY|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/boh_loh_yah
	name = "boh loh yah"
	desc = "Confusivamente referido como um\"Pão de abacaxi\", este tratamento Hong Konger não contém abacaxi real- em vez disso, é um biscoito de açúcar como pão com um recheio de manteiga."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "boh_loh_yah"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/sugar = 4,
	)
	tastes = list("cookie" = 1, "butter" = 1)
	foodtypes = DAIRY | GRAIN | PINEAPPLE //it's funny
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/banana_fritter
	name = "banana fritter"
	desc = "Um doce lanche onipresente de grande parte do sudeste marítimo da Ásia, o bolinho de banana tem muitos nomes, mas todos compartilham um estilo semelhante, banana, revestida de massa, e frito."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "banana_fritter"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/sugar = 1,
	)
	tastes = list("banana" = 1, "batter" = 1)
	foodtypes = GRAIN|FRUIT|FRIED|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3 //Fried goodness, oil scawy.

/obj/item/food/pineapple_fritter
	name = "pineapple fritter"
	desc = "Como seu primo, o bolinho de banana, o bolinho de abacaxi é um lanche popular, embora um pouco decepcionado pelo infame abacaxi\"Ame ou odeie\"sabor."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "pineapple_fritter"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/sugar = 1,
	)
	tastes = list("pineapple" = 1, "batter" = 1)
	foodtypes = GRAIN|FRUIT|FRIED|PINEAPPLE|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/kebab/kasei_dango
	name = "kasei dango"
	desc = "Bolas de dango de estilo japonês, com sabor de grenadine e laranja, dando um resultado final que parece Marte e tem gosto de sobremesa, servido três a um pau."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kasei_dango"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/orangejuice = 3,
		/datum/reagent/consumable/grenadine = 3
	)
	tastes = list("pomegranate" = 1, "orange" = 1)
	foodtypes = FRUIT | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

// Frozen
/obj/item/food/pb_ice_cream_mochi
	name = "peanut butter ice cream mochi"
	desc = "Uma sobremesa clássica no Arabia Street Night Market em Prospect, sorvete de manteiga de amendoim mochi é feito com um sorvete sabor manteiga de amendoim como o recheio principal, e revestido em amendoim esmagado na tradição taiwanesa."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "pb_ice_cream_mochi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/peanut_butter = 4,
		/datum/reagent/consumable/milk = 2,
	)
	tastes = list("peanut butter" = 1, "mochi" = 1)
	foodtypes = NUTS | GRAIN | DAIRY | SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/popsicle/pineapple_pop
	name = "frozen pineapple pop"
	desc = "Poucas culturas amam abacaxi tanto quanto os marcianos, e esta sobremesa prova que... Abacaxi congelado, em um pau, com apenas um pouco de chocolate escuro."
	overlay_state = "pineapple_pop"
	food_reagents = list(
		/datum/reagent/consumable/pineapplejuice = 4,
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("cold pineapple" = 1, "chocolate" = 1)
	foodtypes = SUGAR|FRUIT|PINEAPPLE
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/popsicle/sea_salt
	name = "sea salt ice-cream bar"
	desc = "Este bar de sorvete azul-céu é aromatizado apenas com o melhor sal do mar importado. Salgado... não, doce!"
	overlay_state = "sea_salt_pop"
	food_reagents = list(
		/datum/reagent/consumable/salt = 1,
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/cream = 2,
		/datum/reagent/consumable/vanilla = 2,
		/datum/reagent/consumable/sugar = 4,
	)
	tastes = list("salt" = 1, "sweet" = 1)
	foodtypes = SUGAR | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_3

// topsicles, also known as tofu popsicles
/obj/item/food/popsicle/topsicle
	name = "berry topsicle"
	desc = "Um doce congelado feito de tofu e suco de baga misturado suave, então congelado. Supostamente um favorito de ursos, mas isso não faz sentido..."
	overlay_state = "topsicle_berry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/berryjuice = 4
	)
	tastes = list("berry" = 1, "tofu" = 1)
	foodtypes = FRUIT|SUGAR|VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/popsicle/topsicle/banana
	name = "banana topsicle"
	desc = "Um doce congelado feito de tofu e suco de banana misturado suave, depois congelado. Popular no Japão rural no verão."
	overlay_state = "topsicle_banana"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/banana = 4
	)
	tastes = list("banana" = 1, "tofu" = 1)

/obj/item/food/popsicle/topsicle/pineapple
	name = "pineapple topsicle"
	desc = "Um doce congelado feito de tofu e suco de abacaxi misturado suave, depois congelado. Como visto na TV."
	overlay_state = "topsicle_pineapple"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/pineapplejuice = 4
	)
	foodtypes = FRUIT|SUGAR|VEGETABLES|PINEAPPLE
	tastes = list("pineapple" = 1, "tofu" = 1)

// Ballpark Food
/obj/item/food/plasma_dog_supreme
	name = "\improper Plasma Dog Supreme"
	desc = "O lanchinho do Cybersun Park, lar dos pica-paus de Nova Osaka: um cachorro-quente com sambal, cebola grelhada e salsa de abacaxi. Sabe, o tipo de sabores arrojados que eles gostam em Marte."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "plasma_dog_supreme"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment = 6
	)
	tastes = list("sausage" = 1, "relish" = 1, "onion" = 1, "fruity salsa" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|FRUIT|PINEAPPLE|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4 //Uses Sambal
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)
	custom_price = PAYCHECK_CREW * 2

/obj/item/food/frickles
	name = "frickles"
	desc = "Lanças de picles picantes? Uma combinação tão ousada só pode vir de um lugar... Parques de marcianos? Bem, não realmente, mas eles são um lanche popular lá."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "frickles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("frickles" = 1)
	foodtypes = VEGETABLES|GRAIN|FRIED|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3 //batter and cargo stuff.

/obj/item/food/raw_ballpark_pretzel
	name = "raw pretzel"
	desc = "Um nó de massa, pronto para ser cozido, ou possivelmente grelhado?"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "raw_ballpark_pretzel"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/salt = 1,
	)
	tastes = list("bread" = 1, "salt" = 1)
	foodtypes = GRAIN | RAW
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/raw_ballpark_pretzel/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/ballpark_pretzel, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/raw_ballpark_pretzel/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/ballpark_pretzel, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/ballpark_pretzel
	name = "ballpark pretzel"
	desc = "Um pão clássico alemão, transformado pela mão do imperialismo americano em um lanche de dia de jogo, e então levado para o Planeta Vermelho nas costas dos colonizadores japoneses. Que multicultural."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "ballpark_pretzel"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/salt = 1,
	)
	tastes = list("bread" = 1, "salt" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/kebab/raw_ballpark_tsukune
	name = "raw tsukune"
	desc = "Almôndegas cruas de frango em um espeto, prontas para serem grelhadas em algo delicioso."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "raw_ballpark_tsukune"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment = 2,
	)
	tastes = list("raw chicken" = 7, "salmonella" = 1)
	foodtypes = MEAT | RAW
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/kebab/raw_ballpark_tsukune/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/kebab/ballpark_tsukune, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/kebab/ballpark_tsukune
	name = "ballpark tsukune"
	desc = "Esfolei almôndegas de frango em um molho yakitori doce e salgado. Uma visão comum no estádio marciano."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "ballpark_tsukune"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment = 4,
	)
	tastes = list("chicken" = 1, "umami sauce" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

// Ethereal-suitable cross-culture food
/*	Ethereals are, as part of the uplifting process, considered as citizens of the Terran Federation.
	For this reason, a lot of ethereals have chosen to move throughout human space, settling on various planets to a mixed reception.
	Mars is no exception to this rule, where the ethereal population has been more welcomed than most, due to Mars' more cosmopolitan past.
	Here, the ethereals have developed a distinct culture, neither that of their homeland nor that of Mars, and with that a distinct cuisine.
*/

// Pickled Voltvine
/obj/item/food/pickled_voltvine
	name = "pickled voltvine"
	desc = "Um prato tradicional de Sprout (onde é conhecido como hinu'sashuruhk), Voltvine em conserva assumiu uma nova identidade entre os mestres de picles de Marte, ganhando um assento no santo panteão de picles ao lado de gengibre em conserva e kimchi (uma vez adequadamente descarregado, pelo menos)."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "pickled_voltvine"
	food_reagents = list(
		/datum/reagent/consumable/liquidelectricity/enriched = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("sour radish" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2 //If it comes straight from cargo, should be worth paying for.

// 24-Volt Energy
/obj/item/food/volt_fish
	name = "24-volt fish"
	desc = "Alguns podem questionar os peixes de 24 volts. Afinal, peixe escalfado em bebida energética super-azul elétrica parece horrível. E, de fato, tem um gosto horrível. Então por que os etéreos marcianos gostam?" //beats the hell out of me
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "volt_fish"
	food_reagents = list(
		/datum/reagent/consumable/liquidelectricity/enriched = 6,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("fish" = 1, "sour pear" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

// Sprout Bowl
/obj/item/food/salad/sprout_bowl
	name = "\improper Sprout bowl"
	desc = "Nomeada para o mundo natal Ethereal, esta tigela à base de arroz baseia-se na tradição donburi, mas rejeita coberturas típicas de donburi, em vez de usar peixe de grau sashimi e voltvine em conserva."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "sprout_bowl"
	food_reagents = list(
		/datum/reagent/consumable/liquidelectricity/enriched = 8,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("fish" = 1, "sour radish" = 1, "rice" = 1)
	foodtypes = SEAFOOD | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
