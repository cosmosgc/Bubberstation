////////////////////////////////////////////SNACKS FROM VENDING MACHINES////////////////////////////////////////////
//in other words: junk food
//don't even bother looking for recipes for these

/obj/item/food/candy
	name = "candy"
	desc = "É nougat, ame ou odeie."
	icon_state = "candy"
	trash_type = /obj/item/trash/candy
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/sugar = 3,
	)
	junkiness = 25
	tastes = list("candy" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/candy/bronx
	name = "\improper South Bronx Paradise bar"
	desc = "Perder peso, garantido! Caramel Mocha Flavor. Algo sobre consumo de produtos..."
	icon_state = "bronx"
	inhand_icon_state = "candy"
	trash_type = /obj/item/trash/candy
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/yuck = 1,
	)
	junkiness = 10
	bite_consumption = 10
	tastes = list("candy" = 5, "weight loss" = 4, "insect larva" = 1)
	foodtypes = JUNKFOOD | RAW | BUGS
	custom_price = 80
	w_class = WEIGHT_CLASS_TINY
	var/revelation = FALSE

/obj/item/food/candy/bronx/make_edible()
	. = ..()
	AddComponentFrom(SOURCE_EDIBLE_INNATE, /datum/component/edible, on_consume = CALLBACK(src, PROC_REF(on_consume)))

/obj/item/food/candy/bronx/proc/on_consume(mob/living/eater)
	if(ishuman(eater))
		var/mob/living/carbon/human/carl = eater
		var/datum/disease/disease = new /datum/disease/parasite()
		carl.ForceContractDisease(disease, make_copy = FALSE, del_on_fail = TRUE)

/obj/item/food/candy/bronx/examine(mob/user)
	. = ..()
	if(!revelation && !isobserver(user))
		. += span_notice("Nossa, precisa examinar seus olhos. Deveria olhar de novo...")

		name = "\improper South Bronx Parasite bar"
		desc = "Perder peso, garantido! Caramel Mocha Flavor! Aviso: produto não está pronto para consumo humano. Contém diamantes vivos."
		revelation = TRUE

/obj/item/food/sosjerky
	name = "\improper Scaredy's Private Reserve Beef Jerky"
	icon_state = "sosjerky"
	desc = "Carne seca feita das melhores vagas espaciais."
	trash_type = /obj/item/trash/sosjerky
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/salt = 2,
	)
	junkiness = 25
	tastes = list("dried meat" = 1)
	w_class = WEIGHT_CLASS_SMALL
	foodtypes = JUNKFOOD | MEAT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_1
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/sosjerky/healthy
	name = "homemade beef jerky"
	desc = "Carne caseira feita das melhores vagas espaciais."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	junkiness = 0

/obj/item/food/chips
	name = "chips"
	desc = "Comandante Riker's What-The-Crisps."
	icon_state = "chips"
	trash_type = /obj/item/trash/chips
	bite_consumption = 1
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/salt = 1,
	)
	junkiness = 20
	tastes = list("salt" = 1, "crisps" = 1)
	foodtypes = VEGETABLES|JUNKFOOD|FRIED
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/chips/make_leave_trash()
	if(trash_type)
		AddElement(/datum/element/food_trash, trash_type, FOOD_TRASH_POPABLE)

/obj/item/food/chips/shrimp
	name = "shrimp chips"
	desc = "Batatas fritas com sabor de camarão. Um junkfood favorito entre apreciadores de frutos do mar!"
	icon_state = "shrimp_chips"
	trash_type = /obj/item/trash/shrimp_chips
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/fat/oil = 3,
		/datum/reagent/consumable/salt = 1,
	)
	tastes = list("salt" = 1, "shrimp" = 1)
	foodtypes = JUNKFOOD | FRIED | SEAFOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/no_raisin
	name = "\improper 4no raisins"
	icon_state = "4no_raisins"
	desc = "As melhores passas do universo. Não sei por quê."
	trash_type = /obj/item/trash/raisins
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/sugar = 4,
	)
	junkiness = 25
	tastes = list("dried raisins" = 1)
	foodtypes = JUNKFOOD | FRUIT | SUGAR
	food_flags = FOOD_FINGER_FOOD
	custom_price = PAYCHECK_CREW * 0.7
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/no_raisin/healthy
	name = "homemade raisins"
	desc = "Passas caseiras, um melhor em todas as pessoas."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	junkiness = 0
	foodtypes = FRUIT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/spacetwinkie
	name = "\improper Space Twinkie"
	icon_state = "space_twinkie"
	desc = "Garantido para sobreviver mais do que você."
	food_reagents = list(/datum/reagent/consumable/sugar = 4)
	junkiness = 25
	foodtypes = JUNKFOOD | GRAIN | SUGAR
	food_flags = FOOD_FINGER_FOOD
	custom_price = PAYCHECK_LOWER
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/candy_trash
	name = "candy cigarette butt"
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "candybum"
	desc = "Como sobras de um charuto fumado. Pode ser comido!"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/ash = 3,
	)
	junkiness = 10 //powergame trash food by buying candy cigs in bulk and eating them when they extinguish
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/candy_trash/nicotine
	desc = "Como sobras de um charuto fumado. Cheira a Nicotina?"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/ash = 3,
		/datum/reagent/drug/nicotine = 1,
	)

/obj/item/food/cheesiehonkers
	name = "\improper Cheesie Honkers"
	desc = "Lanchinhos de queijo de tamanho grande que vão buzinar na sua boca."
	icon_state = "cheesie_honkers"
	trash_type = /obj/item/trash/cheesie
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/sugar = 3,
	)
	junkiness = 25
	tastes = list("cheese" = 5, "crisps" = 2)
	foodtypes = JUNKFOOD | DAIRY | SUGAR
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/syndicake
	name = "\improper Syndi-Cakes"
	icon_state = "syndi_cakes"
	desc = "Um bolo de lanche extremamente úmido, que tem gosto igual depois de ser detonado."
	trash_type = /obj/item/trash/syndi_cakes
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/doctor_delight = 5,
	)
	tastes = list("sweetness" = 3, "cake" = 1)
	foodtypes = GRAIN | FRUIT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/energybar
	name = "\improper High-power energy bars"
	icon_state = "energybar"
	desc = "Uma barra de energia com muito ponche, você provavelmente não deveria comer isso se você não é um Ethereal."
	trash_type = /obj/item/trash/energybar
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/liquidelectricity/enriched = 3,
	)
	tastes = list("pure electricity" = 3, "fitness" = 2)
	foodtypes = TOXIC
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/peanuts
	name = "\improper Gallery's peanuts"
	desc = "Um favorito entre os terminalmente zangados."
	icon_state = "peanuts"
	trash_type = /obj/item/trash/peanuts
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("peanuts" = 4, "anger" = 1)
	foodtypes = JUNKFOOD | NUTS
	custom_price = PAYCHECK_CREW * 0.8 //nuts are expensive in real life, and this is the best food in the vendor.
	junkiness = 10 //less junky than other options, since peanuts are a decently healthy snack option
	w_class = WEIGHT_CLASS_SMALL
	var/safe_for_consumption = TRUE

/obj/item/food/peanuts/grind_results()
	return list(/datum/reagent/consumable/peanut_butter = 5, /datum/reagent/consumable/nutriment/fat/oil = 2)

/obj/item/food/peanuts/salted
	name = "\improper Gallery's salt reserves peanuts"
	desc = "Tem gosto salgado."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/salt = 1,
	)
	tastes = list("peanuts" = 3, "salt" = 1, "high blood pressure" = 1)

/obj/item/food/peanuts/wasabi
	name = "\improper Gallery's raging wasabi peanuts"
	desc = "O mais irritado de todos os sabores de emendaim."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("peanuts" = 3, "wasabi" = 1, "rage" = 1)

/obj/item/food/peanuts/honey_roasted
	name = "\improper Gallery's delete sweet peanuts"
	desc = "Estranhamente amargo para um doce."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/sugar = 1,
	)
	tastes = list("peanuts" = 3, "honey" = 1, "bitterness" = 1)

/obj/item/food/peanuts/barbecue
	name = "\improper Gallery's IDEDBBQ peanuts"
	desc = "Onde há fumaça, não há necessariamente fogo. Às vezes é só molho de churrasco."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/bbqsauce = 1,
	)
	tastes = list("peanuts" = 3, "bbq sauce" = 1, "arguments" = 1)

/obj/item/food/peanuts/ban_appeal
	name = "\improper Gallery's peanuts Ban Appel mix"
	desc = "Uma tentativa malfadada de mistura de trilhas, proibida em 6 setores. O lobby anual para virar é negado não porque as maçãs são tóxicas, mas porque elas continuam evitando a proibição."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/toxin/cyanide = 1,
	) //uses dried poison apples
	tastes = list("peanuts" = 3, "apples" = 1, "regret" = 1)
	safe_for_consumption = FALSE

/obj/item/food/peanuts/random
	name = "\improper Gallery's every-flavour peanuts"
	desc = "Que sabor você vai ter?"
	icon_state = "peanuts"
	safe_for_consumption = FALSE

GLOBAL_LIST_INIT(safe_peanut_types, populate_safe_peanut_types())

/proc/populate_safe_peanut_types()
	. = list()
	for(var/obj/item/food/peanuts/peanut_type as anything in subtypesof(/obj/item/food/peanuts))
		if(!initial(peanut_type.safe_for_consumption))
			continue
		. += peanut_type

/obj/item/food/peanuts/random/Initialize(mapload)
	// Generate a sample p
	var/peanut_type = pick(GLOB.safe_peanut_types)
	var/obj/item/food/sample = new peanut_type(loc)

	name = sample.name
	desc = sample.desc
	food_reagents = sample.food_reagents
	tastes = sample.tastes

	qdel(sample)

	. = ..()

/obj/item/food/cnds
	name = "\improper C&Ds"
	desc = "Legalmente, não podemos dizer que isso não vai derreter em suas mãos."
	icon_state = "cnds"
	trash_type = /obj/item/trash/cnds
	food_reagents = list(
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/coco = 1,
	)
	tastes = list("chocolate candy" = 3)
	junkiness = 25
	foodtypes = JUNKFOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/cnds/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]está deixando[src]Derreter em[user.p_their()]Mão! Parece que...[user.p_theyre()]Tentando cometer suicídio!"))
	return TOXLOSS

/obj/item/food/cnds/caramel
	name = "caramel C&Ds"
	desc = "Cheio de caramelo doce e açucarado, fazendo deles o pior pesadelo do diabético."
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/caramel = 1,
	)
	tastes = list("chocolate candy" = 2, "caramel" = 1)

/obj/item/food/cnds/pretzel
	name = "pretzel C&Ds"
	desc = "Eine köstliche Begleitung zu Ihrem Lieblingsbier."
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
	)
	tastes = list("chocolate candy" = 2, "pretzel" = 1)
	foodtypes = JUNKFOOD | GRAIN

/obj/item/food/cnds/peanut_butter
	name = "peanut butter C&Ds"
	desc = "Amado por crianças e alienígenas."
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/peanut_butter = 1,
	)
	tastes = list("chocolate candy" = 2, "peanut butter" = 1)

/obj/item/food/cnds/banana_honk
	name = "banana honk C&Ds"
	desc = "Os doces oficiais de palhaços em toda parte. Buzina!"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/banana = 1,
	)
	tastes = list("chocolate candy" = 2, "banana" = 1)

/obj/item/food/cnds/random
	name = "mystery filled C&Ds"
	desc = "Cheio de um dos quatro sabores deliciosos!"

/obj/item/food/cnds/random/Initialize(mapload)
	var/random_flavour = pick(subtypesof(/obj/item/food/cnds) - /obj/item/food/cnds/random)
	var/obj/item/food/sample = new random_flavour(loc)
	name = sample.name
	desc = sample.desc
	food_reagents = sample.food_reagents
	tastes = sample.tastes

	qdel(sample)

	. = ..()

/obj/item/food/pistachios
	name = "\improper Sweetie's Pistachios"
	desc = "Um Pacote de Pistacios Premium da Marca Sweetie."
	icon_state = "pistachio"
	trash_type = /obj/item/trash/pistachios
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	) //a healthy but expensive snack
	tastes = list("pistachios" = 4, "subtle sweetness" = 1)
	foodtypes = JUNKFOOD | NUTS
	custom_price = PAYCHECK_CREW//pistachios are even more expensive.
	junkiness = 10 //on par with peanuts
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/pistachios/grind_results()
	return list(/datum/reagent/consumable/peanut_butter = 5, /datum/reagent/consumable/nutriment/fat/oil = 2)

/obj/item/food/semki
	name = "\improper Semki Sunflower Seeds"
	desc = "Um patote de sêmens de girassol assadas. Amado por Russos Espaciais e Babushka."
	icon_state = "semki"
	trash_type = /obj/item/trash/semki
	food_reagents = list(
		/datum/reagent/consumable/nutriment/fat/oil = 1,
		/datum/reagent/consumable/salt = 6,
	) //1 cornoil is equal to 1.33 nutriment
	tastes = list("sunflowers" = 5)
	foodtypes = JUNKFOOD | NUTS
	custom_price = PAYCHECK_LOWER * 0.4 //sunflowers are cheap in real life.
	bite_consumption = 1
	junkiness = 25
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/semki/healthy
	name = "roasted sunflower seeds"
	desc = "Sementes de girassol torradas caseiras em um copo de papel. Um lanche saudável e de enchimento para mordiscar enquanto você vê as pessoas passarem."
	icon_state = "sunseeds"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/iron = 2,
	)
	junkiness = 5 //Homemade or not, sunflower seets are always kinda junky
	foodtypes = JUNKFOOD | NUTS
	trash_type = /obj/item/trash/semki/healthy
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/cornchips
	name = "\improper Boritos corn chips"
	desc = "Milho triangular. Eles parecem um pouco brandos, mas provavelmente ficção bem com algo tipo de movimento de mergulho."
	icon_state = "boritos"
	trash_type = /obj/item/trash/boritos
	bite_consumption = 2
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
		/datum/reagent/consumable/salt = 3,
	)
	junkiness = 20
	custom_price = PAYCHECK_LOWER * 0.8  //we are filled to the brim with flavor
	tastes = list("fried corn" = 1)
	foodtypes = JUNKFOOD | FRIED
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/cornchips/make_leave_trash()
	AddElement(/datum/element/food_trash, trash_type, FOOD_TRASH_POPABLE)

/obj/item/food/cornchips/blue
	name = "\improper Coolest Ranch Boritos corn chips"
	desc = "O que aconteceu primeiro, rancho ou rancho legal?"
	icon_state = "boritos"
	trash_type = /obj/item/trash/boritos
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
		/datum/reagent/consumable/salt = 3,
		/datum/reagent/consumable/yoghurt = 1,
		/datum/reagent/consumable/garlic = 1,
	)
	tastes = list("fried corn" = 1, "coolest ranch" = 3)

/obj/item/food/cornchips/green
	name = "\improper Spess Salsa Boritos corn chips"
	desc = "Tem salsa assada, então não precisa de molho."
	icon_state = "boritosgreen"
	trash_type = /obj/item/trash/boritos/green
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
		/datum/reagent/consumable/salt = 3,
		/datum/reagent/consumable/astrotame = 1,
		/datum/reagent/consumable/blackpepper = 1,
	)
	tastes = list("fried corn" = 1, "spess salsa" = 3)

/obj/item/food/cornchips/red
	name = "\improper Nacho Cheese Boritos corn chips"
	desc = "Notorious por ajudar a cobrir tudo que você toca em pó de queijo laranja."
	icon_state = "boritosred"
	trash_type = /obj/item/trash/boritos/red
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
		/datum/reagent/consumable/salt = 3,
		/datum/reagent/consumable/astrotame = 1,
		/datum/reagent/consumable/cornmeal = 1,
	)
	tastes = list("fried corn" = 1, "nacho cheese" = 3)

/obj/item/food/cornchips/purple
	name = "\improper Spicy Sweet Chili Boritos corn chips"
	desc = "O único sabor que realmente tem sabor picante como nachos adequados."
	icon_state = "boritospurple"
	trash_type = /obj/item/trash/boritos/purple
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
		/datum/reagent/consumable/salt = 3,
		/datum/reagent/consumable/capsaicin = 1,
		/datum/reagent/consumable/sugar = 1,
	)
	tastes = list("fried corn" = 1, "spicy & sweet chili" = 3)

/obj/item/food/cornchips/random
	name = "\improper Boritos cornchips"
	desc = "Cheio de um dos quatro sabores deliciosos!"

/obj/item/food/cornchips/random/Initialize(mapload)
	var/random_flavour = pick(subtypesof(/obj/item/food/cornchips) - /obj/item/food/cornchips/random)

	var/obj/item/food/sample = new random_flavour(loc)

	name = sample.name
	desc = sample.desc
	food_reagents = sample.food_reagents
	icon_state = sample.icon_state
	trash_type = sample.trash_type
	tastes = sample.tastes

	qdel(sample)

	. = ..()

/obj/item/food/hot_shots
	name = "\improper Hot Shots"
	desc = "O melhor lanche de beisebol. Uma vez que você começa, é difícil parar!"
	icon_state = "hot_shots"
	trash_type = /obj/item/trash/hot_shots
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("popcorn" = 1, "caramel" = 1, "peanuts" = 1)
	foodtypes = JUNKFOOD | SUGAR | NUTS
	junkiness = 25
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/hot_shots/grind_results()
	return list(/datum/reagent/consumable/nutriment/fat/oil = 3, /datum/reagent/consumable/caramel = 2)

/obj/item/food/sticko
	name = "\improper Sticko Classic"
	desc = "Um deleite clássico para todas as idades, é Sticko, o bastão de chocolate original! Este é o sabor original (e como alguns diriam, melhor): biscoito e chocolate de leite."
	icon_state = "sticko_classic"
	trash_type = /obj/item/trash/sticko
	food_reagents = list(
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/coco = 1,
	)
	tastes = list("biscuit" = 1, "chocolate" = 1)
	junkiness = 25
	foodtypes = JUNKFOOD | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/sticko/matcha
	name = "\improper Sticko Matcha"
	desc = "Um deleite clássico para todas as idades, é Sticko, o bastão de chocolate original! Este tem chocolate branco com sabor de fósforo como revestimento, para evocar sentimentos de tradição."
	icon_state = "sticko_matcha"
	trash_type = /obj/item/trash/sticko/matcha
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/caramel = 1,
	)
	tastes = list("biscuit" = 1, "matcha" = 1)

/obj/item/food/sticko/nutty
	name = "\improper Sticko Nutty"
	desc = "Um deleite clássico para todas as idades, é Sticko, o bastão de chocolate original! Este tem chocolate com manteiga de amendoim como revestimento, para uma torção maluca."
	icon_state = "sticko_nutty"
	trash_type = /obj/item/trash/sticko/nutty
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
	)
	tastes = list("biscuit" = 1, "peanut butter" = 1)
	foodtypes = JUNKFOOD | GRAIN | NUTS

/obj/item/food/sticko/pineapple
	name = "\improper Sticko Pineapple"
	desc = "Um deleite clássico para todas as idades, é Sticko, o bastão de chocolate original! Este tem chocolate branco com sabor de abacaxi como revestimento, para aqueles fãs de ananas."
	icon_state = "sticko_pineapple"
	trash_type = /obj/item/trash/sticko/pineapple
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/peanut_butter = 1,
	)
	tastes = list("biscuit" = 1, "pineapple" = 1)
	foodtypes = JUNKFOOD | GRAIN | PINEAPPLE

/obj/item/food/sticko/yuyake
	name = "\improper Sticko Yūyake"
	desc = "Um deleite clássico para todas as idades, é Sticko, o bastão de chocolate original! Este tem chocolate branco com sabor Yūyake como revestimento, para um sabor refrescante de melônia."
	icon_state = "sticko_yuyake"
	trash_type = /obj/item/trash/sticko/yuyake
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/banana = 1,
	)
	tastes = list("biscuit" = 1, "melon" = 1)

/obj/item/food/sticko/random
	name = "\improper Sticko Mystery"
	desc = "Um deleite clássico para todas as idades, é Sticko, o bastão de chocolate original! Este tem uma bainha de papel obscura, para esconder o verdadeiro sabor..."

/obj/item/food/sticko/random/Initialize(mapload)
	var/random_flavour = pick(subtypesof(/obj/item/food/sticko) - /obj/item/food/sticko/random)
	var/obj/item/food/sample = new random_flavour(loc)
	name = sample.name
	desc = sample.desc
	food_reagents = sample.food_reagents
	tastes = sample.tastes

	qdel(sample)

	. = ..()

/obj/item/food/shok_roks
	name = "\improper Shok-Roks - Stormcloud Candy flavour"
	desc = "Você já ouviu falar de Snap-Roks, agora prepare-se para Shok-Roks: o doce popping para Ethereals! Disponível em 5 sabores emocionantes, dos quais este saco contém Stormcloud Candy, como algodão doce, mas elétrico!"
	icon_state = "shok_roks_candy"
	trash_type = /obj/item/trash/shok_roks
	food_reagents = list(
		/datum/reagent/consumable/liquidelectricity/enriched = 2,
		/datum/reagent/consumable/sugar = 3
	)
	tastes = list("sugar" = 1, "lightning" = 1)

/obj/item/food/shok_roks/citrus
	name = "\improper Shok-Roks - Cirrus Citrus flavour"
	desc = "Você já ouviu falar de Snap-Roks, agora prepare-se para Shok-Roks: o doce popping para Ethereals! Disponível em 5 sabores emocionantes, dos quais este saco contém Cirrus Citrus- todo o sabor citrinos, nenhum do verdadeiro extrato cítrico."
	icon_state = "shok_roks_citrus"
	trash_type = /obj/item/trash/shok_roks/citrus
	tastes = list("citrus" = 1, "lightning" = 1)

/obj/item/food/shok_roks/berry
	name = "\improper Shok-Roks - Berry Storm flavour"
	desc = "Você já ouviu falar de Snap-Roks, agora prepare-se para Shok-Roks: o doce popping para Ethereals! Disponível em 5 sabores emocionantes, dos quais este saco contém Berry Tempestade, cheio de sabor de bagas azedo não descrito!"
	icon_state = "shok_roks_berry"
	trash_type = /obj/item/trash/shok_roks/berry
	tastes = list("sour berry" = 1, "lightning" = 1)

/obj/item/food/shok_roks/tropical
	name = "\improper Shok-Roks - Tropical Thunder flavour"
	desc = "Você já ouviu falar de Snap-Roks, agora prepare-se para Shok-Roks: o doce popping para Ethereals! Disponível em 5 sabores emocionantes, dos quais este saco contém Tropical Thunder- todas as frutas tropicais! Todos eles!"
	icon_state = "shok_roks_tropical"
	trash_type = /obj/item/trash/shok_roks/tropical
	tastes = list("tropical fruits" = 1, "lightning" = 1)

/obj/item/food/shok_roks/lanternfruit
	name = "\improper Shok-Roks - Lightning Lanternfruit flavour"
	desc = "Você já ouviu falar de Snap-Roks, agora prepare-se para Shok-Roks: o doce popping para Ethereals! Disponível em 5 sabores emocionantes, dos quais este saco contém Lightning Lanternfruit - a única fruta nativa Sprout em qualquer sabor Shok-Rok."
	icon_state = "shok_roks_lanternfruit"
	trash_type = /obj/item/trash/shok_roks/lanternfruit
	tastes = list("sour pear" = 1, "lightning" = 1)

/obj/item/food/shok_roks/random
	name = "\improper Shok-Roks - Hidden Hurricane flavour"
	desc = "Você já ouviu falar de Snap-Roks, agora prepare-se para Shok-Roks: o doce popping para Ethereals! Disponível em 5 sabores emocionantes, qualquer um dos quais poderia estar nesta bolsa!"

/obj/item/food/shok_roks/random/Initialize(mapload)
	var/random_flavour = pick(subtypesof(/obj/item/food/shok_roks) - /obj/item/food/shok_roks/random)
	var/obj/item/food/sample = new random_flavour(loc)
	name = sample.name
	desc = sample.desc
	food_reagents = sample.food_reagents
	tastes = sample.tastes

	qdel(sample)

	. = ..()
