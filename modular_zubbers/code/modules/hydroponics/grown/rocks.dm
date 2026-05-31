/obj/item/seeds/rockfruit
	name = "pack of rockfruit seedlings"
	desc = "Pequenas mudas da planta de frutas-rocha do Golem. Há um rótulo de aviso em sua embalagem:\n	\"Legalmente falando, rock é mais legal do que apedrejamento.\nNão somos responsáveis por nenhuma lesão, morte ou evaporação completa do corpo causada pelo uso ou cultivo destas plantas.\""
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-rockfruit"
	species = "rock"
	plantname = "Rockfruits"
	product = /obj/item/grown/rockfruit
	mutatelist = list(/obj/item/seeds/sandfruit)

	lifespan = 20
	endurance = 45

	potency = 15
	maturation = 8
	production = 4
	yield = 2
	instability = 0 // Rocks are very stable


	growthstages = 2
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'

	genes = list(/datum/plant_gene/trait/plant_type/weed_hardy,
				/datum/plant_gene/trait/fire_resistance,
				/datum/plant_gene/trait/stable_stats, // It's a rock
				/datum/plant_gene/trait/preserved)

	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.01,
						/datum/reagent/consumable/nutriment = 0.01,
						)


/obj/item/grown/rockfruit
	seed = /obj/item/seeds/rockfruit

	name = "Rockfruit"
	desc = "Pedaço de fruta de rocha, geralmente apreciado pelo povo golem. O interior parece ser frutado, com o exterior sendo uma casca rochosa."
	force = 5 // Comparatively shit considering a nettle is 15
	throwforce = 10 // Less shit but hey, it is a rock

	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "rockfruit"

	var/product = /obj/item/food/grown/rockfruit

/obj/item/grown/rockfruit/attack_self(mob/user, modifiers)
	user.show_message(span_notice("Você começa a descascar o exterior rochoso..."))
	if(!(do_after(user, 2 SECONDS)))
		return
	user.show_message(span_notice("Você descasca a casca rochosa da fruta de rocha, revelando a bondade frutífera por dentro!"))
	balloon_alert(user, "peeled")

	// The fruit inside
	var/obj/item/food/grown/peel_prod
	peel_prod = new product(user.loc, new_seed = seed) // I stole this from seed code and am physically crying and shaking

	// The rocky shell
	new /obj/item/food/golem_food/rocks(user.loc)

	qdel(src)
	user.put_in_hands(peel_prod)

/obj/item/food/grown/rockfruit
	seed = /obj/item/seeds/rockfruit

	name = "Rockfruit core"
	desc = "O interior frutado de uma fruta de rocha! Não muito açucarado, mas ainda saboroso. O povo de Golem usa isso para complementar sua comida rock. Curiosamente, eles não gostam de comer isso por conta própria."

	foodtypes = FRUIT

	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "rockfruit-peeled"

	tastes = list("mountains" = 1)

/obj/item/food/golem_food/rocks
	name = "Peeled rockfruit shell"
	desc = "A casca descascada de uma fruta de rocha, ou como você pode chamá-la,\"Montes de pedras literais\"Provavelmente não comestível, mas um golem tentará provar o contrário."

	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "rockfruit-trash"

	foodtypes = STONE
	food_reagents = list(/datum/reagent/consumable/nutriment/mineral = 5)

	tastes = list("rocks and stones" = 1)

/datum/reagent/consumable/nutriment/mineral
	taste_description = "pedras e pedras"


//Rockfruits evolutions? OREFRUITS!//
//Sand - Base tier breaks into 4 trees ('energy', Precious, Metal, Miscmats)
/obj/item/seeds/sandfruit
	name = "sandfruit seed pack"
	desc = "Estas sementes crescem para produzir frutos de areia."
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-sandfruit"
	species = "ore"
	plantname = "Sandfruits"
	product = /obj/item/food/grown/material_sand
	mutatelist = list(/obj/item/seeds/uraniberry,
					/obj/item/seeds/agbergine,
					/obj/item/seeds/ferrotuber,
					/obj/item/seeds/adamapple)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/silicon = 0.1)
	growthstages = 2
	rarity = 20
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_sand
	seed = /obj/item/seeds/sandfruit
	name = "sandfruit"
	desc = "Uma variante mutante de frutos de rocha, áspero, curso e agora disponível em toda parte. Só descascar para um núcleo."
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/sandfruitcore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/silicon

/obj/item/stack/sheet/mineral/sandfruitcore
	name = "sandfruit core"
	desc = "Um núcleo de frutos de areia muito frágil, literalmente composto de dezenas de partículas de areia... não armazena em bolsos."
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	singular_name = "Fruto de areia"
	icon_state = "sandfruit"
	merge_type = /obj/item/stack/sheet/mineral/sandfruitcore
	max_amount = 10
	mats_per_unit = list(/datum/material/glass=SHEET_MATERIAL_AMOUNT*0.2)

//Uranium - First on 'energy' line

/obj/item/seeds/uraniberry
	name = "uraniberry seed pack"
	desc = "Essas sementes crescem para produzir 'bagas' que Deus acha que provavelmente não deveria existir."
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-uraniberry"
	species = "ore"
	plantname = "Uraniberry"
	product = /obj/item/food/grown/material_uraniberry
	mutatelist = list(/obj/item/seeds/plasmaplum)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/uranium = 0.1)
	growthstages = 2
	rarity = 20
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_uraniberry
	seed = /obj/item/seeds/uraniberry
	name = "uraniberry"
	desc = "Uma variante mutante de frutos de rocha, talvez não queira segurá-la por muito tempo... também não é uma fruta! Só descascar para um núcleo."
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/uraniberrycore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/uranium

/obj/item/stack/sheet/mineral/uraniberrycore
	name = "uraniberry core"
	singular_name = "Núcleo de uraniberry"
	desc = "Um núcleo de uraniberry muito denso, não guarde em bolsos, a menos que queira membros extras."
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "uraniberry"
	merge_type = /obj/item/stack/sheet/mineral/uraniberrycore
	max_amount = 10
	mats_per_unit =list(/datum/material/uranium=SHEET_MATERIAL_AMOUNT*0.2)

//Plasma - Second stage of 'energy' line.

/obj/item/seeds/plasmaplum
	name = "plasmaplum seed pack"
	desc = "Estas sementes crescem para produzir plums extremamente voláteis."
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-plasmaplum"
	species = "ore"
	plantname = "Plasmaplum"
	product = /obj/item/food/grown/material_plasmaplum
	mutatelist = list(/obj/item/seeds/bluegemdrupe)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/toxin/plasma = 0.1)
	growthstages = 2
	rarity = 40
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_plasmaplum
	seed = /obj/item/seeds/plasmaplum
	name = "plasmaplum"
	desc = "Uma variante mutante de frutos de rocha, incrivelmente volátil, também não é uma ameixa! Só descascar para um núcleo."
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/plasmaplumcore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/toxin/plasma

/obj/item/stack/sheet/mineral/plasmaplumcore
	name = "plasmaplum core"
	singular_name = "núcleo de plasmaplum"
	desc = "Um núcleo de plasmaplum muito denso, armazena em um lugar frio, fogo e faísca livre."
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "plasmaplum"
	merge_type = /obj/item/stack/sheet/mineral/plasmaplumcore
	max_amount = 10
	mats_per_unit = list(/datum/material/plasma=SHEET_MATERIAL_AMOUNT*0.2)

//Bluespace - ending of 'energy' line.

/obj/item/seeds/bluegemdrupe
	name = "bluegem drupe seed pack"
	desc = "Estas sementes crescem para produzir 'drupes' extremamente voláteis."
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-bluegemdrupe"
	species = "ore"
	plantname = "Bluegem drupe"
	product = /obj/item/food/grown/material_bluegemdrupe
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/bluespace = 0.1)
	growthstages = 2
	rarity = 60
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_bluegemdrupe
	seed = /obj/item/seeds/bluegemdrupe
	name = "bluegem drupe"
	desc = "Uma variante mutante de frutos de rocha, incrivelmente frágil... também não é uma drupe! Só descascar para um núcleo."
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/bluegemdrupecore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/bluespace

/obj/item/stack/sheet/mineral/bluegemdrupecore
	name = "bluegem drupe core"
	singular_name = "Bluegem drupe core"
	desc = "Um núcleo drupe muito denso, caindo pode ocorrer teletransporte em casos raros."
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "bluegemdrupe"
	merge_type = /obj/item/stack/sheet/mineral/bluegemdrupecore
	max_amount = 10
	mats_per_unit = list(/datum/material/bluespace=SHEET_MATERIAL_AMOUNT*0.2)

//Silver - Agbergine (Get it? AG, silver?!) - First on 'precious' line

/obj/item/seeds/agbergine
	name = "ag-bergine seed pack"
	desc = "Estas sementes crescem para produzir frutos, com núcleos de prata sólida."
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-agbergine"
	species = "ore"
	plantname = "agbergine"
	product = /obj/item/food/grown/material_agbergine
	mutatelist = list(/obj/item/seeds/aubergine)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/silver = 0.1)
	growthstages = 2
	rarity = 20
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_agbergine
	seed = /obj/item/seeds/agbergine
	name = "ag-bergine"
	desc = "Ag-bergine, entendeu? É hilário e valioso! Só descascar para um núcleo."
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/agberginecore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/silver

/obj/item/stack/sheet/mineral/agberginecore
	name = "ag-bergine core"
	singular_name = "Ag-bergine núcleo"
	desc = "Um denso núcleo de beringela de prata sólida."
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "agbergine"
	merge_type = /obj/item/stack/sheet/mineral/agberginecore
	max_amount = 10
	mats_per_unit = list(/datum/material/silver=SHEET_MATERIAL_AMOUNT*0.2)

//Gold - Au-bergine (Pretty sure you can work this one out) - Second stage of 'precious' line.

/obj/item/seeds/aubergine
	name = "au-bergine seed pack"
	desc = "Estas sementes crescem em frutos dourados."
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-aubergine"
	species = "ore"
	plantname = "aubergine"
	product = /obj/item/food/grown/material_aubergine
	mutatelist = list(/obj/item/seeds/dimantis)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/gold = 0.1)
	growthstages = 2
	rarity = 40
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_aubergine
	seed = /obj/item/seeds/aubergine
	name = "aubergine"
	desc = "Uma beringela; UA? Entendeu? Meus talentos são desperdiçados aqui! Só descascar para um núcleo."
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/auberginecore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/gold

/obj/item/stack/sheet/mineral/auberginecore
	name = "au-bergine core"
	singular_name = "Núcleo de beringela"
	desc = "Um núcleo au-beringe muito denso, sólido 24 quilates de bondade."
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "aubergine"
	merge_type = /obj/item/stack/sheet/mineral/auberginecore
	max_amount = 10
	mats_per_unit = list(/datum/material/gold=SHEET_MATERIAL_AMOUNT*0.2)

//Dimantis - ending of 'precious' line.

/obj/item/seeds/dimantis
	name = "dimantis seed pack"
	desc = "Estas sementes crescem para produzir frutos extremamente valiosos."
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-dimantis"
	species = "ore"
	plantname = "Dimantis"
	product = /obj/item/food/grown/material_dimantis
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/carbon = 0.1)
	growthstages = 2
	rarity = 60
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_dimantis
	seed = /obj/item/seeds/dimantis
	name = "dimantis drupe"
	desc = "Um fruto carnudo com um núcleo de diamante, apenas descascar para um núcleo."
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/dimantiscore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/carbon

/obj/item/stack/sheet/mineral/dimantiscore
	name = "dimantis core"
	singular_name = "Dimantis core"
	desc = "Um núcleo de dimantis muito denso, o caminho para o coração de uma mulher, provavelmente poderia passar através de sua caixa torácica ..."
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "dimantis"
	merge_type = /obj/item/stack/sheet/mineral/dimantiscore
	max_amount = 10
	mats_per_unit = list(/datum/material/diamond=SHEET_MATERIAL_AMOUNT*0.2)

//Iron - Ferrotubers - First on 'metal' line

/obj/item/seeds/ferrotuber
	name = "ferrotuber seed pack"
	desc = "Estas sementes crescem para produzir tubérculos, com núcleos de ferro."
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-ferrotuber"
	species = "ore"
	plantname = "ferrotuber"
	product = /obj/item/food/grown/material_ferrotuber
	mutatelist = list(/obj/item/seeds/titanituber)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/iron = 0.1)
	growthstages = 2
	rarity = 20
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_ferrotuber
	seed = /obj/item/seeds/ferrotuber
	name = "ferrotuber"
	desc = "Ferrotuberes, conchas carnudas com recheios de ferro! Só descascar para um núcleo."
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/ferrotubercore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/iron

/obj/item/stack/sheet/mineral/ferrotubercore
	name = "ferrotuber core"
	singular_name = "núcleo de ferrotuber"
	desc = "Um denso núcleo de ferrotúber de ferro sólido, ligeiramente magnético."
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "ferrotuber"
	merge_type = /obj/item/stack/sheet/mineral/ferrotubercore
	max_amount = 10
	mats_per_unit = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*0.2)

//Titanium - titanituber - Second stage of 'metal' line.

/obj/item/seeds/titanituber
	name = "titanituber seed pack"
	desc = "Estas sementes crescem em tubérculos de titânio."
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-titanituber"
	species = "ore"
	plantname = "titanituber"
	product = /obj/item/food/grown/material_titanituber
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1)
	growthstages = 2
	rarity = 40
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_titanituber
	seed = /obj/item/seeds/titanituber
	name = "titanituber"
	desc = "Frutos macios com núcleos incrivelmente resistentes, cuidado com os dentes! Só descascar para um núcleo."
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/titanitubercore
	foodtypes = FRUIT

/obj/item/stack/sheet/mineral/titanitubercore
	name = "titanituber core"
	singular_name = "Titanituber core"
	desc = "Um núcleo de titanituber muito denso, vamos esperar que você não morda!"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "titanituber"
	merge_type = /obj/item/stack/sheet/mineral/titanitubercore
	max_amount = 10
	mats_per_unit = list(/datum/material/titanium=SHEET_MATERIAL_AMOUNT*0.2)

//Adamantine - First on 'misc' line

/obj/item/seeds/adamapple
	name = "adam's apple seed pack"
	desc = "Estas sementes crescem para produzir frutos, com núcleos de adamantina."
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-adamapple"
	species = "ore"
	plantname = "adamapple"
	product = /obj/item/food/grown/material_adamapple
	mutatelist = list(/obj/item/seeds/runescooper)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1)
	growthstages = 2
	rarity = 60
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_adamapple
	seed = /obj/item/seeds/adamapple
	name = "Adam's apple"
	desc = "As maçãs de Adão, a recompensa do Jardim Éden! Só descascar para um núcleo."
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/adamapplecore
	foodtypes = FRUIT

/obj/item/stack/sheet/mineral/adamapplecore
	name = "adam's apple core"
	singular_name = "O núcleo de maçã de Adam."
	desc = "Um denso núcleo de maçã de Adão de adamantina sólida."
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "adamapple"
	merge_type = /obj/item/stack/sheet/mineral/adamapplecore
	max_amount = 10
	mats_per_unit = list(/datum/material/adamantine=SHEET_MATERIAL_AMOUNT*0.2)

//Runite - Second stage of 'misc' line.

/obj/item/seeds/runescooper
	name = "runescooper seed pack"
	desc = "Estas sementes crescem em frutos raros e selvagens."
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-runescooper"
	species = "ore"
	plantname = "runescooper"
	product = /obj/item/food/grown/material_runescooper
	mutatelist = list(/obj/item/seeds/bananiumberry)
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1)
	growthstages = 2
	rarity = 60
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_runescooper
	seed = /obj/item/seeds/runescooper
	name = "runescooper"
	desc = "Uma fruta, geralmente cultivada em lugares selvagens onde os homens se matariam para ganhar."
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/runescoopercore
	foodtypes = FRUIT

/obj/item/stack/sheet/mineral/runescoopercore
	name = "runescooper core"
	singular_name = "Núcleo Runescooper"
	desc = "Um núcleo runite muito denso, mais alguns destes e você pode ser capaz de fazer uma cimitarra para derrotar seus inimigos..."
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "runescooper"
	merge_type = /obj/item/stack/sheet/mineral/runescoopercore
	max_amount = 10
	mats_per_unit = list(/datum/material/runite=SHEET_MATERIAL_AMOUNT*0.2)

//bananiumberry - ending of 'misc' line.

/obj/item/seeds/bananiumberry
	name = "bananium berry seed pack"
	desc = "Estas sementes crescem para produzir abominações profanas."
	icon = 'modular_zubbers/icons/obj/seeds.dmi'
	icon_state = "seed-bananiumberry"
	species = "ore"
	plantname = "bananiumberry"
	product = /obj/item/food/grown/material_bananiumberry
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1,
						/datum/reagent/consumable/nutriment/soup/clown_tears = 0.1)
	growthstages = 2
	rarity = 60
	growing_icon = 'modular_zubbers/icons/obj/growing_fruits.dmi'
	genes = list(/datum/plant_gene/trait/chem_cooling)

/obj/item/food/grown/material_bananiumberry
	seed = /obj/item/seeds/bananiumberry
	name = "bananiumberry"
	desc = "Puta que pariu... Esta fruta tem um núcleo de banânio, apenas descascar!"
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "orefruit"
	trash_type = /obj/item/stack/sheet/mineral/bananiumberrycore
	foodtypes = FRUIT
	distill_reagent = /datum/reagent/consumable/nutriment/soup/clown_tears

/obj/item/stack/sheet/mineral/bananiumberrycore
	name = "bananiumberry core"
	singular_name = "Bananiumberry core"
	desc = "Um núcleo de banânio muito denso, o caminho para o coração de um palhaço, provavelmente poderia passar através de suas costelas..."
	icon = 'modular_zubbers/icons/obj/harvest.dmi'
	icon_state = "bananiumberry"
	merge_type = /obj/item/stack/sheet/mineral/bananiumberrycore
	max_amount = 10
	mats_per_unit = list(/datum/material/bananium=SHEET_MATERIAL_AMOUNT*0.2)
