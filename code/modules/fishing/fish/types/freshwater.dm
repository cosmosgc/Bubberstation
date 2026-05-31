/obj/item/fish/goldfish
	name = "goldfish"
	fish_id = "goldfish"
	desc = "Apesar da crença comum, peixes dourados não têm memórias de três segundos. Eles podem se lembrar de coisas que aconteceram até três meses atrás."
	icon_state = "goldfish"
	dedicated_in_aquarium_icon_state = "fish_greyscale"
	aquarium_vc_color = "#D8540D"
	sprite_width = 5
	sprite_height = 3
	stable_population = 9
	average_size = 20
	average_weight = 200
	weight_size_deviation = 0.35
	favorite_bait = list(/obj/item/food/bait/worm)
	required_temperature_min = MIN_AQUARIUM_TEMP+18
	required_temperature_max = MIN_AQUARIUM_TEMP+26
	evolution_types = list(/datum/fish_evolution/three_eyes, /datum/fish_evolution/chainsawfish)
	compatible_types = list(/obj/item/fish/goldfish/gill, /obj/item/fish/goldfish/three_eyes, /obj/item/fish/goldfish/three_eyes/gill)

/obj/item/fish/goldfish/Initialize(mapload, apply_qualities = TRUE)
	. = ..()
	add_traits(list(TRAIT_FISHING_BAIT, TRAIT_GOOD_QUALITY_BAIT), INNATE_TRAIT)

/obj/item/fish/goldfish/gill
	name = "McGill"
	desc = "Uma grande ferramenta de pato de borracha para advogados que não conseguem entender o caso."
	fish_id_redirect_path = /obj/item/fish/goldfish
	stable_population = 1
	random_case_rarity = FISH_RARITY_NOPE
	fish_flags = parent_type::fish_flags & ~FISH_FLAG_SHOW_IN_CATALOG
	beauty = FISH_BEAUTY_GOOD
	compatible_types = list(/obj/item/fish/goldfish, /obj/item/fish/goldfish/three_eyes)
	fish_traits = list(/datum/fish_trait/recessive)

/obj/item/fish/goldfish/gill/get_fish_taste()
	return list("raw fish" = 2.5, "objection" = 1)

/obj/item/fish/goldfish/three_eyes
	name = "three-eyed goldfish"
	fish_id = "three_eyes"
	desc = "Um peixe dourado com mais meio par de olhos. Você se pergunta com o que tem se alimentado ultimamente..."
	icon_state = "three_eyes"
	stable_population = 4
	fish_traits = list(/datum/fish_trait/recessive, /datum/fish_trait/shiny_lover)
	compatible_types = list(/obj/item/fish/goldfish, /obj/item/fish/goldfish/gill, /obj/item/fish/goldfish/three_eyes/gill)
	beauty = FISH_BEAUTY_GOOD
	fishing_difficulty_modifier = 10
	random_case_rarity = FISH_RARITY_VERY_RARE
	food = /datum/reagent/toxin/mutagen
	favorite_bait = list(
		list(
			"Type" = "Reagent",
			"Value" = /datum/reagent/toxin/mutagen,
			"Amount" = 3,
		),
	)

/obj/item/fish/goldfish/three_eyes/get_fish_taste()
	return list("raw fish" = 2.5, "chemical waste" = 0.5)

/obj/item/fish/goldfish/three_eyes/gill
	name = "McGill"
	desc = "Uma grande ferramenta de pato de borracha para advogados que não conseguem entender o caso. Parece meio diferente hoje..."
	fish_id_redirect_path = /obj/item/fish/goldfish/three_eyes
	compatible_types = list(/obj/item/fish/goldfish, /obj/item/fish/goldfish/three_eyes)
	beauty = FISH_BEAUTY_GREAT
	fish_flags = parent_type::fish_flags & ~FISH_FLAG_SHOW_IN_CATALOG
	stable_population = 1
	random_case_rarity = FISH_RARITY_NOPE

/obj/item/fish/goldfish/three_eyes/gill/get_fish_taste()
	return list("raw fish" = 2.5, "objection" = 1)

/obj/item/fish/angelfish
	name = "angelfish"
	fish_id = "angelfish"
	desc = "Os jovens Angelfish vivem em grupos, enquanto os adultos preferem a vida solitária. Tornam-se territoriais e agressivos com outros peixes quando atingem a idade adulta."
	icon_state = "angelfish"
	sprite_width = 4
	sprite_height = 7
	average_size = 30
	average_weight = 500
	stable_population = 3
	fish_traits = list(/datum/fish_trait/territorial)
	required_temperature_min = MIN_AQUARIUM_TEMP+22
	required_temperature_max = MIN_AQUARIUM_TEMP+30

/obj/item/fish/guppy
	name = "guppy"
	fish_id = "guppy"
	desc = "Guppy também é conhecido como peixe arco-íris por causa do corpo brilhantemente colorido e barbatanas."
	icon_state = "guppy"
	sprite_width = 5
	sprite_height = 2
	sprite_width = 8
	sprite_height = 5
	average_size = 30
	average_weight = 500
	stable_population = 6
	required_temperature_min = MIN_AQUARIUM_TEMP+20
	required_temperature_max = MIN_AQUARIUM_TEMP+28

/obj/item/fish/plasmatetra
	name = "plasma tetra"
	fish_id = "plasmatetra"
	desc = "Devido ao seu tamanho pequeno, tetras são presas de muitos predadores em seu mundo aquoso, incluindo enguias, crustáceos e invertebrados."
	icon_state = "plastetra"
	sprite_width = 4
	sprite_height = 2
	average_size = 20
	average_weight = 180
	stable_population = 3
	required_temperature_min = MIN_AQUARIUM_TEMP+20
	required_temperature_max = MIN_AQUARIUM_TEMP+28

/obj/item/fish/plasmatetra/Initialize(mapload, apply_qualities = TRUE)
	. = ..()
	add_traits(list(TRAIT_FISHING_BAIT, TRAIT_GOOD_QUALITY_BAIT), INNATE_TRAIT)

/obj/item/fish/catfish
	name = "catfish"
	fish_id = "catfish"
	desc = "Um bagre tem cerca de 100.000 papilas gustativas, e seus corpos estão cobertos com elas para ajudar a detectar substâncias químicas presentes na água e também para responder ao toque."
	icon_state = "catfish"
	sprite_width = 8
	sprite_height = 4
	average_size = 80
	average_weight = 1600
	weight_size_deviation = 0.35
	stable_population = 3
	favorite_bait = list(
		list(
			FISH_BAIT_TYPE = FISH_BAIT_FOODTYPE,
			FISH_BAIT_VALUE = JUNKFOOD
		)
	)
	required_temperature_min = MIN_AQUARIUM_TEMP+12
	required_temperature_max = MIN_AQUARIUM_TEMP+30
	beauty = FISH_BEAUTY_GOOD

/obj/item/fish/zipzap
	name = "anxious zipzap"
	fish_id = "zipzap"
	desc = "Um peixe transbordando de ansiedade incapacitante e potencial elétrico. Preocupado com as paredes de seu tanque se fechando constantemente. Literalmente e como um desconforto metafórico geral sobre a direção da vida."
	icon_state = "zipzap"
	icon_state_dead = "zipzap_dead"
	sprite_width = 6
	sprite_height = 3
	stable_population = 3
	average_size = 30
	average_weight = 500
	random_case_rarity = FISH_RARITY_VERY_RARE
	favorite_bait = list(/obj/item/stock_parts/power_store/cell/lead)
	required_temperature_min = MIN_AQUARIUM_TEMP+18
	required_temperature_max = MIN_AQUARIUM_TEMP+26
	fish_traits = list(
		/datum/fish_trait/no_mating,
		/datum/fish_trait/wary,
		/datum/fish_trait/anxiety,
		/datum/fish_trait/electrogenesis,
	)
	//anxiety naturally limits the amount of zipzaps per tank, so they are stronger alone
	electrogenesis_power = 6.7 MEGA JOULES
	beauty = FISH_BEAUTY_GOOD
	suicide_slap_text = "ZAP!"

/obj/item/fish/zipzap/get_fish_taste()
	return list("raw fish" = 2, "anxiety" = 1)

/obj/item/fish/zipzap/suicide_act(mob/living/user)
	if(!electrocute_mob(user, power_source = get_area(src), source = src, siemens_coeff = 1, dist_check = FALSE))
		user.visible_message(span_suicide("[user]Tenta Bater[user.p_them()]ego com[src]Mas eles são imunes à eletricidade!"))
		return SHAME
	return ..()

// real suicide handled by og fish proc
/obj/item/fish/zipzap/slapperoni(mob/living/user, iteration)
	electrocute_mob(user, power_source = get_area(src), source = src, siemens_coeff = 1, dist_check = FALSE) // how do i make this use electrogenesis_power
	return ..()

/obj/item/fish/tadpole
	name = "tadpole"
	fish_id = "tadpole"
	desc = "A cria larval de um anfíbio. Uma criatura muito minúscula e redonda com uma cauda longa que usa para nadar."
	icon_state = "tadpole"
	average_size = 3
	average_weight = 10
	sprite_width = 3
	sprite_height = 1
	max_integrity = 100
	feeding_frequency = 1.5 MINUTES
	required_temperature_min = MIN_AQUARIUM_TEMP+15
	required_temperature_max = MIN_AQUARIUM_TEMP+20
	fillet_type = null
	fish_traits = list(/datum/fish_trait/no_mating) //They grow into frogs and that's it.
	beauty = FISH_BEAUTY_NULL
	random_case_rarity = FISH_RARITY_NOPE //Why would you want generic frog tadpoles you get from ponds inside fish cases?
	/// Once dead, tadpoles disappear after a dozen seconds, since you can get infinite tadpoles.
	var/del_timerid

/obj/item/fish/tadpole/Initialize(mapload, apply_qualities = TRUE)
	. = ..()
	var/output_path = prob(99) ? /mob/living/basic/frog : /mob/living/basic/frog/rare
	AddComponent(/datum/component/fish_growth, output_path, rand(2 MINUTES, 3 MINUTES))
	RegisterSignal(src, COMSIG_FISH_BEFORE_GROWING, PROC_REF(growth_checks))
	RegisterSignal(src, COMSIG_FISH_FINISH_GROWING, PROC_REF(on_growth))

/obj/item/fish/tadpole/make_edible()
	return

/obj/item/fish/tadpole/set_status(new_status, silent = FALSE)
	. = ..()
	if(status == FISH_DEAD)
		if(!istype(loc, /obj/structure/fish_mount))
			del_timerid = QDEL_IN_STOPPABLE(src, 12 SECONDS)
	else
		deltimer(del_timerid)

/obj/item/fish/tadpole/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(QDELETED(src) || status != FISH_DEAD || !istype(old_loc, /obj/structure/fish_mount))
		return
	qdel(src)

/obj/item/fish/tadpole/proc/growth_checks(datum/source, seconds_per_tick, growth, result_path)
	SIGNAL_HANDLER
	var/hunger = get_hunger()
	if(hunger >= 0.7) //too hungry to grow
		return COMPONENT_DONT_GROW
	if(HAS_TRAIT(loc, TRAIT_STOP_FISH_REPRODUCTION_AND_GROWTH)) //the aquarium has breeding disabled
		return COMPONENT_DONT_GROW

/obj/item/fish/tadpole/proc/on_growth(datum/source, mob/living/basic/frog/result)
	SIGNAL_HANDLER
	playsound(result, result.attack_sound, 50, TRUE) // reeeeeeeeeeeeeee...

/obj/item/fish/tadpole/get_export_price(price, elasticity_percent)
	return 2 //two credits. Tadpoles aren't really that valueable.

/obj/item/fish/tadpole/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]Andorinhas[src]Inteiro!"))
	src.forceMove(user)
	if(status == FISH_DEAD)
		user.emote("gasp")
		user.visible_message(span_suicide("[user]Corram!"))
		return OXYLOSS

	// the frogg grows
	addtimer(CALLBACK(src, PROC_REF(gestation), user), 5 SECONDS)
	return MANUAL_SUICIDE

/obj/item/fish/tadpole/proc/gestation(mob/living/user)
	if(QDELETED(user) || QDELETED(src))
		return
	user.visible_message(span_suicide("Um sapo vivo explode[user]!"))
	new /obj/effect/spawner/random/frog(user.drop_location())

	var/obj/item/bodypart/chest = user.get_bodypart(BODY_ZONE_CHEST)

	if (chest)
		chest.dismember()
		user.death()
	else
		user.gib(DROP_ALL_REMAINS)

	qdel(src)

/obj/item/fish/perch
	name = "perch"
	fish_id = "perch"
	desc = "Um panfish popular, peixes de caça e presas infelizes para outros predadores maiores."
	icon_state = "perch"
	dedicated_in_aquarium_icon_state = "fish_greyscale"
	aquarium_vc_color = "#9D8C64"
	sprite_width = 5
	sprite_height = 3
	stable_population = 7
	average_size = 25
	average_weight = 400
	required_temperature_min = MIN_AQUARIUM_TEMP+5
	required_temperature_max = MIN_AQUARIUM_TEMP+26
	favorite_bait = list(
		list(
			FISH_BAIT_TYPE = FISH_BAIT_FOODTYPE,
			FISH_BAIT_VALUE = BUGS,
		),
	/obj/item/fish,
	/obj/item/fishing_lure, //they love lures in general.
	)

///Memetic fish from a paleontologically inaccurate, goofy replica of a specimen. Sells decently for its size.
/obj/item/fish/sacabambaspis
	name = "sacabambaspis"
	fish_id = "sacabambaspis"
	desc = "Um peixe sem mandíbula deve ser extinto até o final do período Ordoviciano. Alguns especulam que a intervenção alienígena pode ter sido por trás de sua sobrevivência e evolução inevitável como um morador de fontes termais."
	icon_state = "sacabambaspis"
	sprite_width = 5
	sprite_height = 3
	stable_population = 7
	average_size = 27
	average_weight = 500
	required_temperature_min = MIN_AQUARIUM_TEMP+20
	required_temperature_max = MIN_AQUARIUM_TEMP+45
	random_case_rarity = FISH_RARITY_GOOD_LUCK_FINDING_THIS
	beauty = FISH_BEAUTY_GOOD
	fish_traits = list(/datum/fish_trait/necrophage, /datum/fish_trait/wary)

/obj/item/fish/sacabambaspis/get_export_price(price, percent)
	return ..() * 4.5
