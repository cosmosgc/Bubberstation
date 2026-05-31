//Pastry is a food that is made from dough which is made from wheat or rye flour.
//This file contains pastries that don't fit any existing categories.
////////////////////////////////////////////MUFFINS////////////////////////////////////////////

/obj/item/food/muffin
	name = "muffin"
	desc = "Um bolo delicioso e esponjoso."
	icon_state = "muffin"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("muffin" = 1)
	foodtypes = GRAIN|DAIRY|SUGAR|BREAKFAST
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/muffin/berry
	name = "berry muffin"
	icon_state = "berrymuffin"
	desc = "Um bolo delicioso e esponjoso, com bagas."
	tastes = list("muffin" = 3, "berry" = 1)
	foodtypes = GRAIN|DAIRY|SUGAR|BREAKFAST|FRUIT
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/muffin/booberry
	name = "booberry muffin"
	icon_state = "berrymuffin"
	alpha = 125
	desc = "Meu estômago é um cemitério! Nenhum ser vivo pode matar minha sede de sangue!"
	tastes = list("muffin" = 3, "spookiness" = 1)
	foodtypes = GRAIN|DAIRY|SUGAR|BREAKFAST|FRUIT
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/muffin/booberry/Initialize(mapload, starting_reagent_purity, no_base_reagents)
	. = ..()
	AddComponent(/datum/component/ghost_edible, bite_consumption = bite_consumption)

/obj/item/food/muffin/moffin
	name = "moffin"
	icon_state = "moffin_1"
	base_icon_state = "moffin"
	desc = "Um bolo delicioso e esponjoso."
	tastes = list("muffin" = 3, "dust" = 1, "lint" = 1)
	foodtypes = CLOTH|DAIRY|GRAIN|SUGAR|BREAKFAST
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/muffin/moffin/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state]_[rand(1, 3)]"

/obj/item/food/muffin/moffin/examine(mob/user)
	. = ..()
	if(!isliving(user))
		return
	var/mob/living/moffin_observer = user
	if(moffin_observer.get_liked_foodtypes() & CLOTH)
		. += span_nicegreen("Ooh! Tem até pedaços de roupas nele! Delicioso!")
	else
		. += span_warning("Não tem certeza do que está por cima.")

////////////////////////////////////////////WAFFLES////////////////////////////////////////////

/obj/item/food/waffles
	name = "waffles"
	desc = "Waffles."
	icon_state = "waffles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("waffles" = 1)
	foodtypes = GRAIN|DAIRY|BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/waffles/make_edible()
	. = ..()
	AddComponent(/datum/component/ice_cream_holder, max_scoops = 1, x_offset = -2)

/obj/item/food/soylentgreen
	name = "\improper Soylent Green"
	desc = "Não feito de pessoas. Sério." //Totally people.
	icon_state = "soylent_green"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("waffles" = 7, "people" = 1)
	foodtypes = MEAT|GRAIN|DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/soylenviridians
	name = "\improper Soylent Virdians"
	desc = "Não feito de pessoas. Sério." //Actually honest for once.
	icon_state = "soylent_yellow"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("waffles" = 7, "the colour green" = 1)
	foodtypes = VEGETABLES|GRAIN|DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/rofflewaffles
	name = "roffle waffles"
	desc = "Waffles de Roffle. Co."
	icon_state = "rofflewaffles"
	bite_consumption = 4
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/drug/mushroomhallucinogen = 2,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("waffles" = 1, "mushrooms" = 1)
	foodtypes = GRAIN|DAIRY|VEGETABLES|BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/rofflewaffles/make_edible()
	. = ..()
	AddComponent(/datum/component/ice_cream_holder, max_scoops = 1, x_offset = -2)

////////////////////////////////////////////OTHER////////////////////////////////////////////

/obj/item/food/cookie
	name = "cookie"
	desc = "COOKIE!!"
	icon_state = "COOKIE!!!"
	bite_consumption = 1
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("cookie" = 1)
	foodtypes = GRAIN | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cookie/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/food/cookie/sleepy
	food_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/toxin/chloralhydrate = 10)

/obj/item/food/fortunecookie
	name = "fortune cookie"
	desc = "Uma verdadeira profecia em cada biscoito!"
	icon_state = "fortune_cookie"
	trash_type = /obj/item/paper/paperslip/fortune
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("cookie" = 1)
	foodtypes = GRAIN|SUGAR|DAIRY
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/fortunecookie/proc/get_fortune()
	var/atom/drop_location = drop_location()

	var/obj/item/paper/fortune = locate(/obj/item/paper) in src
	// If a fortune exists, use that.
	if (fortune)
		fortune.forceMove(drop_location)
		return fortune

	// Otherwise, use a generic one
	var/obj/item/paper/paperslip/fortune/fortune_slip = new trash_type(drop_location)
	// if someone adds lottery tickets in the future, be sure to add random numbers to this
	return fortune_slip

/obj/item/food/fortunecookie/make_leave_trash()
	if(trash_type)
		AddElement(/datum/element/food_trash, trash_type, food_flags, TYPE_PROC_REF(/obj/item/food/fortunecookie, get_fortune))

/obj/item/food/cookie/sugar
	name = "sugar cookie"
	desc = "Como sua irmãzinha fazia."
	icon_state = "sugarcookie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sugar = 6,
	)
	tastes = list("sweetness" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cookie/sugar/Initialize(mapload, seasonal_changes = TRUE)
	. = ..()
	if(seasonal_changes && check_holidays(FESTIVE_SEASON))
		var/shape = pick("tree", "bear", "santa", "stocking", "present", "cane")
		desc = "Um biscoito de açúcar na forma de um[shape]Espero que o Papai Noel goste!"
		icon_state = "sugarcookie_[shape]"

/obj/item/food/chococornet
	name = "chocolate cornet"
	desc = "Que lado é a cabeça, a ponta gorda ou a ponta fina?"
	icon_state = "chococornet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("biscuit" = 3, "chocolate" = 1)
	foodtypes = JUNKFOOD|GRAIN|DAIRY|SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/oatmeal
	name = "oatmeal cookie"
	desc = "O melhor de biscoito e aveia."
	icon_state = "oatmealcookie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("cookie" = 2, "oat" = 1)
	foodtypes = GRAIN|DAIRY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/raisin
	name = "raisin cookie"
	desc = "Por que colocaria passas em um biscoito?"
	icon_state = "raisincookie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("cookie" = 1, "raisins" = 1)
	foodtypes = GRAIN|FRUIT|DAIRY|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/poppypretzel
	name = "poppy pretzel"
	desc = "Está tudo torcido!"
	icon_state = "poppypretzel"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("pretzel" = 1)
	foodtypes = GRAIN|DAIRY|SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/plumphelmetbiscuit
	name = "plump helmet biscuit"
	desc = "Este é um biscoito de capacete bem preparado. Os ingredientes são capacete excepcionalmente picado e farinha de trigo bem picada."
	icon_state = "phelmbiscuit"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("mushroom" = 1, "biscuit" = 1)
	foodtypes = VEGETABLES|GRAIN|DAIRY
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/plumphelmetbiscuit/Initialize(mapload)
	var/fey = prob(10)
	if(fey)
		name = "exceptional plump helmet biscuit"
		desc = "Microondas são tomadas por um humor fey! Cozinhou um excepcional biscoito de capacete gordo!"
		food_reagents = list(
			/datum/reagent/medicine/omnizine = 5,
			/datum/reagent/consumable/nutriment = 1,
			/datum/reagent/consumable/nutriment/vitamin = 1,
		)
	. = ..()
	if(fey)
		reagents.add_reagent(/datum/reagent/medicine/omnizine, 5)

/obj/item/food/cracker
	name = "cracker"
	desc = "É um biscoito salgado."
	icon_state = "cracker"
	bite_consumption = 1
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("cracker" = 1)
	foodtypes = GRAIN
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/khachapuri
	name = "khachapuri"
	desc = "Pão com ovo e queijo?"
	icon_state = "khachapuri"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("bread" = 1, "egg" = 1, "cheese" = 1)
	foodtypes = GRAIN | MEAT | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cherrycupcake
	name = "cherry cupcake"
	desc = "Um doce cupcake com pedaços de cereja."
	icon_state = "cherrycupcake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("cake" = 3, "cherry" = 1)
	foodtypes = GRAIN|DAIRY|FRUIT|SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cherrycupcake/blue
	name = "blue cherry cupcake"
	desc = "Cerejas azuis dentro de um delicioso cupcake."
	icon_state = "bluecherrycupcake"
	tastes = list("cake" = 3, "blue cherry" = 1)
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/jupitercupcake
	name = "jupiter-cup-cake"
	desc = "Uma sobremesa estática."
	icon_state = "jupitercupcake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/caramel = 3,
		/datum/reagent/consumable/liquidelectricity/enriched = 3,
	)
	tastes = list("cake" = 3, "caramel" = 2, "zap" = 1)
	foodtypes = GRAIN|DAIRY|VEGETABLES|SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	crafted_food_buff = /datum/status_effect/food/trait/shockimmune

/obj/item/food/honeybun
	name = "honey bun"
	desc = "Um pão de pastel grudento com mel."
	icon_state = "honeybun"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/honey = 6,
	)
	tastes = list("pastry" = 1, "sweetness" = 1)
	foodtypes = GRAIN|DAIRY|SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cannoli
	name = "cannoli"
	desc = "Um tratamento siciliano que faz de você um espertinho."
	icon_state = "cannoli"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("pastry" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	w_class = WEIGHT_CLASS_TINY
	venue_value = FOOD_PRICE_CHEAP // Pastry base, 3u of sugar and a single. fucking. unit. of. milk. really?
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/icecream
	name = "waffle cone"
	desc = "Cone delicioso de waffle, mas sem sorvete."
	icon = 'icons/obj/service/kitchen.dmi'
	icon_state = "icecream_cone_waffle"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("cream" = 2, "waffle" = 1)
	bite_consumption = 4
	foodtypes = DAIRY | SUGAR | GRAIN
	food_flags = FOOD_FINGER_FOOD
	crafting_complexity = FOOD_COMPLEXITY_2
	max_volume = 10 //The max volumes scales up with the number of scoops of ice cream served.
	/// These two variables are used by the ice cream vat. Latter is the one that shows on the UI.
	var/list/ingredients = list(
		/datum/reagent/consumable/flour,
		/datum/reagent/consumable/sugar,
	)
	var/ingredients_text
	/*
	 * Assoc list var used to prefill the cone with ice cream.
	 * Key is the flavour's name (use text defines; see __DEFINES/food.dm or ice_cream_holder.dm),
	 * assoc is the list of args that is going to be used in [flavour/add_flavour()]. Can as well be null for simple flavours.
	 */
	var/list/prefill_flavours

/obj/item/food/icecream/Initialize(mapload, list/prefill_flavours)
	if(ingredients)
		ingredients_text = "Requer:[reagent_paths_list_to_text(ingredients)]"
	src.prefill_flavours = prefill_flavours
	return ..()

/obj/item/food/icecream/make_edible()
	. = ..()
	var/max_scoops = check_holidays(ICE_CREAM_DAY) ? DEFAULT_MAX_ICE_CREAM_SCOOPS * 4 : DEFAULT_MAX_ICE_CREAM_SCOOPS
	AddComponent(/datum/component/ice_cream_holder, max_scoops, filled_name = "ice cream", change_desc = TRUE, prefill_flavours = prefill_flavours)

/obj/item/food/icecream/chocolate
	name = "chocolate cone"
	desc = "Cone de chocolate delicioso, mas sem sorvete."
	icon_state = "icecream_cone_chocolate"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/coco = 1,
	)
	ingredients = list(
		/datum/reagent/consumable/flour,
		/datum/reagent/consumable/sugar,
		/datum/reagent/consumable/coco,
	)

/obj/item/food/icecream/korta
	name = "korta cone"
	desc = "Cone delicioso, mas sem sorvete."
	foodtypes = NUTS | SUGAR
	ingredients = list(
		/datum/reagent/consumable/korta_flour,
		/datum/reagent/consumable/sugar,
	)

/obj/item/food/cookie/peanut_butter
	name = "peanut butter cookie"
	desc = "Um delicioso biscoito de manteiga de amendoim."
	icon_state = "peanut_butter_cookie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/peanut_butter = 5,
	)
	tastes = list("peanut butter" = 2, "cookie" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|NUTS
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/raw_brownie_batter
	name = "raw brownie batter"
	desc = "Uma mistura pegajosa de massa crua de brownie, cozinhe no forno!"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "raw_brownie_batter"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("raw brownie batter" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR|BREAKFAST
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/raw_brownie_batter/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/brownie_sheet, rand(20 SECONDS, 30 SECONDS), TRUE, TRUE)

/obj/item/food/brownie_sheet
	name = "brownie sheet"
	desc = "Uma folha não cortada de brownie cozido, use uma faca para cortá-lo!."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "brownie_sheet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/sugar = 12,
	)
	tastes = list("brownie" = 1, "chocolatey goodness" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR|BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/brownie_sheet/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/brownie, 4, 3 SECONDS, table_required = TRUE,  screentip_verb = "Slice", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/brownie
	name = "brownie"
	desc = "Uma fatia quadrada de delicioso, mastigado brownie. Muitas vezes o alvo dos maconheiros."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "brownie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/sugar = 3,
	)
	tastes = list("brownie" = 1, "chocolatey goodness" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR|BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/peanut_butter_brownie_batter
	name = "raw peanut butter brownie batter"
	desc = "Uma mistura pegajosa de massa de brownie de manteiga de amendoim crua, cozinhe no forno!"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "peanut_butter_brownie_batter"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/peanut_butter = 4,
	)
	tastes = list("raw brownie batter" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR|BREAKFAST|NUTS
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/peanut_butter_brownie_batter/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/peanut_butter_brownie_sheet, rand(20 SECONDS, 30 SECONDS), TRUE, TRUE)

/obj/item/food/peanut_butter_brownie_sheet
	name = "peanut butter brownie sheet"
	desc = "Uma folha não cortada de brownie de manteiga de amendoim cozido, use uma faca para cortá-lo!"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "peanut_butter_brownie_sheet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 24,
		/datum/reagent/consumable/sugar = 16,
		/datum/reagent/consumable/peanut_butter = 20,
	)
	tastes = list("brownie" = 1, "chocolatey goodness" = 1, "peanut butter" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR|BREAKFAST|NUTS
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/peanut_butter_brownie_sheet/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/peanut_butter_brownie, 4, 3 SECONDS, table_required = TRUE,  screentip_verb = "Slice", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/peanut_butter_brownie
	name = "peanut butter brownie"
	desc = "Uma fatia quadrada de brownie de manteiga de amendoim delicioso. Muitas vezes o alvo dos maconheiros."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "peanut_butter_brownie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/consumable/peanut_butter = 5,
	)
	tastes = list("brownie" = 1, "chocolatey goodness" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR|BREAKFAST|NUTS
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/crunchy_peanut_butter_tart
	name = "crunchy peanut butter tart"
	desc = "Uma torta em miniatura com um recheio de manteiga de amendoim, cobertura cremosa de nozes picadas."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "crunchy_peanut_butter_tart"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/peanut_butter = 5,
	)
	tastes = list("peanut butter" = 1, "peanuts" = 1, "cream" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR|NUTS
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/chocolate_chip_cookie
	name = "chocolate chip cookie"
	desc = "Um delicioso biscoito de chocolate. Onde está o leite?"
	icon_state = "COOKIE!!!"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("soft cookie" = 2, "chocolate" = 3)
	foodtypes = GRAIN | SUGAR | DAIRY
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/snickerdoodle
	name = "snickerdoodle"
	desc = "Um biscoito macio feito de baunilha e canela."
	icon_state = "snickerdoodle"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("soft cookie" = 2, "vanilla" = 3)
	foodtypes = GRAIN | SUGAR | DAIRY
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/macaron
	name = "macaron"
	desc = "Um doce tipo sanduíche com uma casca de biscoito macio e um centro de merengue cremoso."
	food_reagents = list(/datum/reagent/consumable/nutriment = 6)
	icon_state = "macaron_1"
	base_icon_state = "macaron"
	tastes = list("wafer" = 2, "creamy meringue" = 3)
	foodtypes = GRAIN | SUGAR | DAIRY
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/macaron/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state]_[rand(1, 4)]"

/obj/item/food/cookie/thumbprint_cookie
	name = "thumbprint cookie"
	desc = "Um biscoito com um dedo no meio feito para recheio. Este está cheio de geléia de cereja."
	icon_state = "thumbprint_cookie"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6)
	tastes = list("cookie" = 2, "cherry jelly" = 3)
	foodtypes = GRAIN|DAIRY|SUGAR|FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
