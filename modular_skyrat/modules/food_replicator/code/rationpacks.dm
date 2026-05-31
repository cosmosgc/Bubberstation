/obj/item/food/colonial_course
	name = "undefined colonial course"
	desc = "Algo que você não deveria ver. Mas é comestível."
	icon = 'modular_skyrat/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "borgir"
	base_icon_state = "borgir"
	food_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes = list("crayon powder" = 1)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	preserved_food = TRUE

/obj/item/food/colonial_course/attack_self(mob/user, modifiers)
	if(preserved_food)
		preserved_food = FALSE
		icon_state = "[base_icon_state]_unwrapped"
		to_chat(user, span_notice("Você desembala.\the [src]."))
		playsound(user.loc, 'sound/items/foodcanopen.ogg', 50)

/obj/item/food/colonial_course/attack(mob/living/target, mob/user, def_zone)
	if(preserved_food)
		to_chat(user, span_warning("[src]Ainda está empacotado!"))
		return FALSE

	return ..()

/obj/item/food/colonial_course/pljeskavica
	name = "pljeskavica"
	desc = "Hambúrguer quente recém-impresso, que consiste em pães imitadores de artesanato produzidos por biogerador, com carne picada entre vegetais e molhos.<br>Parece Bom.<i>Chega.</i>para algo tão replicado como isso. Sua embalagem está coberta de muitas informações sobre seus fatos nutricionais, conteúdo e a data de validade. Infelizmente, está tudo escrito em Pan-Slavic."
	trash_type = /obj/item/trash/pljeskavica
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 9,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("bun" = 2, "spiced meat" = 10, "death of veganism" = 3)
	foodtypes = VEGETABLES | GRAIN | MEAT

/obj/item/food/colonial_course/nachos
	name = "plain nachos tray"
	desc = "Um pacote selado a vácuo com o que parece ser uma generosa porção de chips de milho triangular, com três seções reservadas para molhos de salsa, queijo e guacamole.<br>Provavelmente a comida mais bonita que você pode encontrar nestas rações, talvez devido à sua simplicidade."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	trash_type = /obj/item/trash/nachos
	icon_state = "nacho"
	base_icon_state = "nacho"
	tastes = list("corn chips" = 5, "'artificial' organic sauces" = 5)
	foodtypes = GRAIN | FRIED | DAIRY

/obj/item/food/colonial_course/blins
	name = "condensed milk crepes"
	desc = "Um pacote de quatro crepes recheados com uma quantidade mínima de marcas. Não há mais nada nisso, para ser franco.<br>Surpreendentemente saboroso para sua aparência, contanto que você não seja intolerante à lactose, em dieta, ou vegan. A parte de trás da embalagem está coberta com uma massa de informações detalhando o produto."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/caramel = 3,
		/datum/reagent/consumable/milk = 4,
	)
	trash_type = /obj/item/trash/blins
	icon_state = "blin"
	base_icon_state = "blin"
	tastes = list("insane amount of sweetness" = 10, "crepes" = 3)
	foodtypes = SUGAR | GRAIN | DAIRY | BREAKFAST

/obj/item/reagent_containers/cup/glass/coffee/colonial
	name = "colonial thermocup"
	desc = "Tecnicamente, costumava beber bebidas quentes. Mas já que era o único projeto que estava disponível, você tem que fazer. Tem uma instrução escrita ao seu lado.<br>Este em particular vem com uma única porção de pó de café."
	special_desc = "Uma pequena instrução ao lado diz:<i>\"Para uso em replicadores de alimentos, misturar água e soluções em pó em proporções únicas.<br>Para cacau, misture leite e solução em pó em proporção única.\"</i>"
	icon = 'modular_skyrat/modules/food_replicator/icons/rationpack.dmi'
	list_reagents = list(/datum/reagent/consumable/powdered_coffee = 25)

/obj/item/reagent_containers/cup/glass/coffee/colonial/empty
	desc = "Tecnicamente, costumava beber bebidas quentes. Mas já que era o único projeto que estava disponível, você tem que fazer. Tem uma instrução escrita ao seu lado."
	list_reagents = null

/obj/item/trash/pljeskavica
	name = "pljeskavica wrapping paper"
	desc = "Coberto de molho e pedaços menores do prato por dentro, amassado em uma bola. É melhor se livrar dele."
	icon = 'modular_skyrat/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "borgir_trash"

/obj/item/trash/nachos
	name = "empty nachos tray"
	desc = "Coberto de molhos e pedaços menores do prato no interior, uma bandeja de plástico com pouco uso mais. É melhor se livrar dele ou reciclá-lo."
	icon = 'modular_skyrat/modules/food_replicator/icons/rationpack.dmi'
	custom_materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
	)
	icon_state = "nacho_trash"

/obj/item/trash/blins
	name = "empty crepes wrapper"
	desc = "Embrulho vazio rasgado que costumava segurar algo ridiculamente doce. É melhor reciclá-lo."
	icon = 'modular_skyrat/modules/food_replicator/icons/rationpack.dmi'
	custom_materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT * 0.5,
	)
	icon_state = "blin_trash"

/obj/item/storage/box/gum/colonial
	name = "mixed bubblegum packet"
	desc = "A embalagem está inteiramente escrita em Pan-Slavic, com um pequeno borrão de Sol Common. Você precisaria dar uma olhada melhor para lê-lo, embora, como está escrito muito pequeno."
	special_desc = "Examine o pequeno texto revela o seguinte:<i>\"Ração de colonização estrangeira, modelo J: origem mista, adulto. Pacote de chiclete, medicinal, recreativo.<br>Não exagere. Algumas tiras contêm nicotina.\"</i>"
	icon = 'modular_skyrat/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "bubblegum"

/obj/item/storage/box/gum/colonial/PopulateContents()
	new /obj/item/food/bubblegum(src)
	new /obj/item/food/bubblegum(src)
	new /obj/item/food/bubblegum/nicotine(src)
	new /obj/item/food/bubblegum/nicotine(src)

/obj/item/storage/box/utensils
	name = "utensils package"
	desc = "Um pequeno pacote contendo vários utensílios necessários para<i>humano</i>consumo de vários alimentos. Em uma situação normal contém um garfo de plástico, uma colher de plástico, e dois guardanapos."
	icon = 'modular_skyrat/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "utensil_box"
	w_class = WEIGHT_CLASS_TINY
	illustration = null
	foldable_result = null

/obj/item/storage/box/utensils/Initialize(mapload)
	. = ..()
	atom_storage.set_holdable(list(
		/obj/item/kitchen/spoon/plastic,
		/obj/item/kitchen/fork/plastic,
		/obj/item/serviette,
	))
	atom_storage.max_slots = 4

/obj/item/storage/box/utensils/PopulateContents()
	new /obj/item/kitchen/spoon/plastic(src)
	new /obj/item/kitchen/fork/plastic(src)
	new /obj/item/serviette/colonial(src)
	new /obj/item/serviette/colonial(src)

/obj/item/serviette/colonial
	name = "colonial napkin"
	desc = "Para limpar toda a bagunça. Vem com um costume<i>combinado</i>Design de vermelho e azul."
	icon_state = "napkin_unused"
	icon = 'modular_skyrat/modules/food_replicator/icons/rationpack.dmi'
	used_serviette = /obj/item/serviette_used/colonial

/obj/item/serviette_used/colonial
	name = "dirty colonial napkin"
	desc = "Não mais útil, super sujo, ou encharcado, ou de outra forma irreconhecível."
	icon_state = "napkin_used"
	icon = 'modular_skyrat/modules/food_replicator/icons/rationpack.dmi'

/obj/item/storage/box/colonial_rations
	name = "foreign colonization ration"
	desc = "Um recém-impresso MRE civil, ou mais especificamente um pacote de comida para o almoço, para uso nos primeiros tempos de colonização pelos primeiros colonos do que é agora conhecido como NRI.<br>A falta de datas impressas, bem como sua origem,<i>O replicador de alimentos.</i>, provavelmente deve dar-lhe uma boa dica em seu curto, se razoável, prazo de validade."
	icon = 'modular_skyrat/modules/food_replicator/icons/rationpack.dmi'
	icon_state = "mre_package"
	foldable_result = null
	illustration = null

/obj/item/storage/box/colonial_rations/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 6
	atom_storage.locked = TRUE

/obj/item/storage/box/colonial_rations/attack_self(mob/user, modifiers)
	if(user)
		if(atom_storage.locked == TRUE)
			atom_storage.locked = FALSE
			icon_state = "mre_package_open"
			balloon_alert(user, "Destrancada!")
			return ..()
		else
			atom_storage.locked = TRUE
			atom_storage.close_all()
			icon_state = "mre_package"
			balloon_alert(user, "Selado novamente!")
			return

/obj/item/storage/box/colonial_rations/PopulateContents()
	new /obj/item/food/colonial_course/pljeskavica(src)
	new /obj/item/food/colonial_course/nachos(src)
	new /obj/item/food/colonial_course/blins(src)
	new /obj/item/reagent_containers/cup/glass/coffee/colonial(src)
	new /obj/item/storage/box/gum/colonial(src)
	new /obj/item/storage/box/utensils(src)
