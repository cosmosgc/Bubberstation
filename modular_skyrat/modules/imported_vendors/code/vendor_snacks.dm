// Snacks and drinks for the 'snacks' tab of vendors

/obj/item/food/vendor_snacks
	name = "\improper God's Strongest Snacks"
	desc = "Espero que não seja um pecador. (Você nunca deve ver este item por favor relate-o)"
	icon = 'modular_skyrat/modules/imported_vendors/icons/imported_quick_foods.dmi'
	icon_state = "foodpack_generic"
	trash_type = /obj/item/trash/vendor_trash
	bite_consumption = 10
	food_reagents = list(/datum/reagent/consumable/nutriment = INFINITY)
	junkiness = 10
	custom_price = PAYCHECK_LOWER * INFINITY
	tastes = list("the unmatched power of the sun" = 10)
	foodtypes = JUNKFOOD | CLOTH | GORE | NUTS | FRIED | FRUIT //You don't want to know what's in the broken debug snacks
	w_class = WEIGHT_CLASS_SMALL

/obj/item/trash/vendor_trash
	name = "\improper God's Weakest Snacks"
	desc = "As sobras do que provavelmente foi um ótimo lanche no passado."
	icon = 'modular_skyrat/modules/imported_vendors/icons/imported_quick_foods.dmi'
	icon_state = "foodpack_generic_trash"
	custom_materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
	)

/*
*	Yangyu Snacks
*/

/obj/item/reagent_containers/cup/glass/dry_ramen/prepared
	name = "cup ramen"
	desc = "Este vem com água, incrível!"
	list_reagents = list(/datum/reagent/consumable/hot_ramen = 15, /datum/reagent/consumable/salt = 3)

/obj/item/reagent_containers/cup/glass/dry_ramen/prepared/hell
	name = "spicy cup ramen"
	desc = "Este vem com água, e um posto de segurança vale capsaicina!"
	list_reagents = list(/datum/reagent/consumable/hell_ramen = 15, /datum/reagent/consumable/salt = 3)

/obj/item/food/vendor_snacks/rice_crackers
	name = "rice crackers"
	desc = "Apesar da maioria do pacote ser claro, você nunca vai realmente saber que sabor estes são até que você comê-los."
	icon_state = "rice_cracka"
	trash_type = /obj/item/trash/vendor_trash/rice_crackers
	food_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/rice = 2)
	tastes = list("incomprehensible flavoring" = 1, "rice cracker" = 2)
	foodtypes = JUNKFOOD | GRAIN
	custom_price = PAYCHECK_LOWER * 0.8

/obj/item/food/vendor_snacks/rice_crackers/make_leave_trash()
	AddElement(/datum/element/food_trash, trash_type, FOOD_TRASH_POPABLE)

/obj/item/trash/vendor_trash/rice_crackers
	name = "empty rice crackers bag"
	desc = "Você nunca descobriu que sabor deveria ser, não é?"
	icon_state = "rice_cracka_trash"

/obj/item/food/vendor_snacks/mochi_ice_cream
	name = "mochi ice cream balls - vanilla"
	desc = "Um seis pacotes de sorvete mochi, ou seja, sorvete de baunilha cercado por mochi. Vem com pequeno espeto de plástico para consumo."
	icon_state = "mochi_ice"
	trash_type = /obj/item/trash/vendor_trash/mochi_ice_cream
	food_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/ice = 3)
	tastes = list("rice cake" = 2, "vanilla" = 2)
	foodtypes = JUNKFOOD | DAIRY | GRAIN
	custom_price = PAYCHECK_LOWER

/obj/item/food/vendor_snacks/mochi_ice_cream/matcha
	name = "mochi ice cream balls - matcha"
	desc = "Seis pacotes de sorvete mochi ou, mais especificamente, sorvete de fósforo cercado por mochi. Vem com pequeno espeto de plástico para consumo."
	icon_state = "mochi_ice_green"
	food_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/ice = 1, /datum/reagent/consumable/tea = 2)
	tastes = list("rice cake" = 1, "bitter matcha" = 2)
	custom_price = PAYCHECK_LOWER * 1.2

/obj/item/food/vendor_snacks/mochi_ice_cream/matcha/examine_more(mob/user)
	. = ..()
	. += span_notice("Uma pequena etiqueta no recipiente especifica que este sorvete é feito usando apenas fósforos de qualidade culinária cultivados fora do sistema Sol.")
	return .

/obj/item/trash/vendor_trash/mochi_ice_cream
	name = "empty mochi ice cream tray"
	desc = "De alguma forma, o espeto de plástico que veio desapareceu."
	icon_state = "mochi_ice_trash"

/obj/item/reagent_containers/cup/glass/waterbottle/tea
	name = "bottle of tea"
	desc = "Uma garrafa de chá trouxe para você em uma conveniente garrafa de plástico."
	icon = 'modular_skyrat/modules/imported_vendors/icons/imported_quick_foods.dmi'
	icon_state = "tea_bottle"
	list_reagents = list(/datum/reagent/consumable/tea = 40)
	cap_icon_state = "bottle_cap_tea"
	flip_chance = 5 //I fucking dare you
	custom_price = PAYCHECK_LOWER * 1.2
	fill_icon_state = null

/obj/item/reagent_containers/cup/glass/waterbottle/tea/astra
	name = "bottle of tea astra"
	desc = "Uma garrafa de chá astra, conhecida pelos gostos bastante incomuns que a folha é conhecida por dar quando fabricada."
	icon_state = "tea_bottle_blue"
	list_reagents = list(
		/datum/reagent/consumable/tea = 25,
		/datum/reagent/medicine/salglu_solution = 10, // I know this looks strange but this is what tea astra grinds into, tea in the year 25whatever baby
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	custom_price = PAYCHECK_LOWER * 2

/obj/item/reagent_containers/cup/glass/waterbottle/tea/strawberry
	name = "bottle of strawberry tea"
	desc = "Uma garrafa de chá com sabor de morango, não contém nenhum morango de verdade."
	icon_state = "tea_bottle_pink"
	list_reagents = list(/datum/reagent/consumable/pinktea = 40)
	custom_price = PAYCHECK_LOWER * 2

/obj/item/reagent_containers/cup/glass/waterbottle/tea/nip
	name = "bottle of catnip tea"
	desc = "Uma garrafa de chá de gato, necessária para estar em ou sob uma concentração de 50% pelo SFDA para fins de segurança."
	icon_state = "tea_bottle_pink"
	list_reagents = list(
		/datum/reagent/consumable/catnip_tea = 20,
		/datum/reagent/consumable/pinkmilk = 20, // I can't believe they would cut my catnip
	)
	custom_price = PAYCHECK_LOWER * 2.5

/*
*	Mothic Snacks
*/

/obj/item/food/vendor_snacks/mothmallow
	name = "mothmallow"
	desc = "Um saco selado a vácuo contendo uma mariposa bem esmagada, alguém o salve!"
	icon_state = "mothmallow"
	trash_type = /obj/item/trash/vendor_trash/mothmallow
	food_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/sugar = 4)
	tastes = list("vanilla" = 1, "cotton" = 1, "chocolate" = 1)
	foodtypes = VEGETABLES | SUGAR
	custom_price = PAYCHECK_LOWER

/obj/item/food/vendor_snacks/mothmallow/make_leave_trash()
	AddElement(/datum/element/food_trash, trash_type, FOOD_TRASH_POPABLE)

/obj/item/trash/vendor_trash/mothmallow
	name = "empty mothmallow bag"
	desc = "Finalmente ele está livre."
	icon_state = "mothmallow_trash"

/obj/item/food/vendor_snacks/moth_bag
	name = "engine fodder"
	desc = "Um saco selado a vácuo contendo uma pequena porção de ração colorida."
	icon_state = "fodder"
	trash_type = /obj/item/trash/vendor_trash/moth_bag
	food_reagents = list(/datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/salt = 2)
	tastes = list("seeds" = 1, "nuts" = 1, "chocolate" = 1, "salt" = 1, "popcorn" = 1, "potato" = 1)
	foodtypes = GRAIN | NUTS | VEGETABLES | SUGAR
	custom_price = PAYCHECK_LOWER * 1.2

/obj/item/food/vendor_snacks/moth_bag/fuel_jack
	name = "fueljack's snack"
	desc = "Um saco selado a vácuo contendo um tijolo menor do que o normal do almoço do fueljack, em última análise, rebaixando-o para o lanche de um fueljack."
	icon_state = "fuel_jack_snack"
	food_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/protein = 1)
	tastes = list("cabbage" = 1, "potato" = 1, "onion" = 1, "chili" = 1, "cheese" = 1)
	foodtypes = DAIRY | VEGETABLES
	custom_price = PAYCHECK_LOWER * 1.2

/obj/item/food/vendor_snacks/moth_bag/cheesecake
	name = "chocolate cheesecake cube"
	desc = "Um saco selado a vácuo contendo um pequeno cubo de um cheesecake estilo mariposa, este está coberto de chocolate."
	icon_state = "choco_cheese_cake"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2, /datum/reagent/consumable/sugar = 4)
	tastes = list("cheesecake" = 1, "chocolate" = 1)
	foodtypes = SUGAR | FRIED | DAIRY | GRAIN
	custom_price = PAYCHECK_LOWER * 1.4

/obj/item/food/vendor_snacks/moth_bag/cheesecake/honey
	name = "honey cheesecake cube"
	desc = "Um saco selado a vácuo contendo um pequeno cubo de um cheesecake estilo mariposa, este está coberto de mel."
	icon_state = "honey_cheese_cake"
	tastes = list("cheesecake" = 1, "honey" = 1)
	foodtypes = SUGAR | FRIED | DAIRY | GRAIN

/obj/item/trash/vendor_trash/moth_bag
	name = "empty mothic snack bag"
	desc = "O plástico límpido revela que isso não contém mais doces saborosos para seus amigos alados."
	icon_state = "moth_bag_trash"

/obj/item/reagent_containers/cup/soda_cans/skyrat/lemonade
	name = "\improper Gyárhajó 1023: Lemonade"
	desc = "Uma lata de limonada, para quem gosta desse tipo de coisa, ou não tem escolha."
	icon_state = "lemonade"
	list_reagents = list(/datum/reagent/consumable/lemonade = 30)
	drink_type = FRUIT

/obj/item/reagent_containers/cup/soda_cans/skyrat/lemonade/examine_more(mob/user)
	. = ..()
	. += span_notice("Marcas na lata indicam que esta foi feita em<i>Nave-fábrica 1023</i>da frota Grand Nomad.")
	return .

/obj/item/reagent_containers/cup/soda_cans/skyrat/navy_rum
	name = "\improper Gyárhajó 1506: Navy Rum"
	desc = "Uma lata de rum da marinha produzida e importada de um destacamento da frota nômade."
	icon_state = "navy_rum"
	list_reagents = list(/datum/reagent/consumable/ethanol/navy_rum = 30)
	drink_type = ALCOHOL

/obj/item/reagent_containers/cup/soda_cans/skyrat/navy_rum/examine_more(mob/user)
	. = ..()
	. += span_notice("Marcas na lata indicam que esta foi feita em<i>Nave-fábrica 1506</i>da frota Grand Nomad.")
	return .

/obj/item/reagent_containers/cup/soda_cans/skyrat/soda_water_moth
	name = "\improper Gyárhajó 1023: Soda Water"
	desc = "Uma lata de água com gás. Por que não fazer um rum com soda? Agora que pensa nisso, talvez não."
	icon_state = "soda_water"
	list_reagents = list(/datum/reagent/consumable/sodawater = 30)
	drink_type = SUGAR

/obj/item/reagent_containers/cup/soda_cans/skyrat/soda_water_moth/examine_more(mob/user)
	. = ..()
	. += span_notice("Marcas na lata indicam que esta foi feita em<i>Nave-fábrica 1023</i>da frota Grand Nomad.")
	return .

/obj/item/reagent_containers/cup/soda_cans/skyrat/ginger_beer
	name = "\improper Gyárhajó 1023: Ginger Beer"
	desc = "Uma lata de cerveja de gengibre, não deixe a parte da cerveja te enganar, isso é totalmente sem álcool."
	icon_state = "gingie_beer"
	list_reagents = list(/datum/reagent/consumable/sol_dry = 30)
	drink_type = SUGAR

/obj/item/reagent_containers/cup/soda_cans/skyrat/ginger_beer/examine_more(mob/user)
	. = ..()
	. += span_notice("Marcas na lata indicam que esta foi feita em<i>Nave-fábrica 1023</i>da frota Grand Nomad.")
	return .

/*
*	Tiziran Snacks
*/

/obj/item/food/vendor_snacks/lizard_bag
	name = "candied mushroom"
	desc = "Um deleite estranho do império lagarto, um cogumelo mergulhado em caramelo, infelizmente, parece ter sido ensacado antes do caramelo totalmente endurecido."
	icon_state = "candied_shroom"
	trash_type = /obj/item/trash/vendor_trash/lizard_bag
	food_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/caramel = 2)
	tastes = list("savouriness" = 1, "sweetness" = 1)
	foodtypes = SUGAR | VEGETABLES
	custom_price = PAYCHECK_LOWER * 1.4 //Tiziran imports are a bit more expensive overall

/obj/item/food/vendor_snacks/lizard_bag/make_leave_trash()
	AddElement(/datum/element/food_trash, trash_type, FOOD_TRASH_POPABLE)

/obj/item/food/vendor_snacks/lizard_bag/moon_jerky
	name = "moonfish jerky"
	desc = "Um peixe seco, feito do que você só pode esperar é moonfish. Também parece ter gosto sutil de churrasco."
	icon_state = "moon_jerky"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2, /datum/reagent/consumable/bbqsauce = 2)
	tastes = list("fish" = 1, "smokey sauce" = 1)
	foodtypes = MEAT
	custom_price = PAYCHECK_LOWER * 1.6

/obj/item/trash/vendor_trash/lizard_bag
	name = "empty tiziran snack bag"
	desc = "Todo aquele dinheiro importando lanches Tiziran só para terminar com isso?"
	icon_state = "tizira_bag_trash"

/obj/item/food/vendor_snacks/lizard_box
	name = "tiziran dumplings"
	desc = "Três bolinhos estilo tiziran, não recheados com nada."
	icon_state = "dumpling"
	trash_type = /obj/item/trash/vendor_trash/lizard_box
	food_reagents = list(/datum/reagent/consumable/nutriment = 3)
	tastes = list("potato" = 1, "earthy heat" = 1)
	foodtypes = VEGETABLES | NUTS
	custom_price = PAYCHECK_LOWER * 1.6

/obj/item/food/vendor_snacks/lizard_box/sweet_roll
	name = "honey roll"
	desc = "Definitivamente não deixe os guardas descobrirem que alguém roubou seu último."
	icon_state = "sweet_roll"
	food_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/honey = 2)
	tastes = list("bread" = 1, "honey" = 1, "fruit" = 1)
	foodtypes = VEGETABLES | NUTS | FRUIT
	custom_price = PAYCHECK_LOWER *1.8

/obj/item/trash/vendor_trash/lizard_box
	name = "empty tiziran snack box"
	desc = "Tizira, contribuindo para a crise espacial de plástico desde 2530."
	icon_state = "tizira_box_trash"

/obj/item/reagent_containers/cup/glass/waterbottle/tea/mushroom
	name = "bottle of mushroom tea"
	desc = "Uma garrafa de chá de cogumelos um pouco amargo, um favorito do império Tiziran."
	icon_state = "tea_bottle_grey"
	list_reagents = list(/datum/reagent/consumable/mushroom_tea = 40)
	custom_price = PAYCHECK_LOWER * 2

/obj/item/reagent_containers/cup/soda_cans/skyrat/kortara
	name = "kortara"
	desc = "Uma lata de kortara, álcool produzido a partir de sementes de korta, o que lhe dá um sabor peculiar de especiarias picantes."
	icon_state = "kortara"
	list_reagents = list(/datum/reagent/consumable/ethanol/kortara = 30)
	drink_type = ALCOHOL
