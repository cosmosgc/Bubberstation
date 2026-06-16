/datum/reagent/consumable/orangejuice
	name = "Orange Juice"
	description = "Ambos deliciosos e ricos em vitamina C, o que mais você precisa?"
	color = "#E78108" // rgb: 231, 129, 8
	taste_description = "oranges"
	ph = 3.3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/juice/orangejuice

/datum/reagent/consumable/orangejuice/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.get_oxy_loss() && SPT_PROB(16, seconds_per_tick))
		if(affected_mob.adjust_oxy_loss(-0.5 * metabolization_ratio, FALSE, updating_health = FALSE, required_biotype = affected_biotype, required_respiration_type = affected_respiration_type))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/tomatojuice
	name = "Tomato Juice"
	description = "Tomates feitos em suco. Que desperdício de tomates, hein?"
	color = "#731008" // rgb: 115, 16, 8
	taste_description = "tomatoes"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/juice/tomatojuice

/datum/reagent/consumable/tomatojuice/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.get_fire_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.heal_bodypart_damage(brute = 0, burn = 0.5 * metabolization_ratio, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/limejuice
	name = "Lime Juice"
	description = "O suco de limão."
	color = "#a6f19a" // rgb: 166, 241, 154
	taste_description = "Azedo insuportável"
	ph = 2.2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/juice/limejuice

/datum/reagent/consumable/limejuice/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.get_tox_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.adjust_tox_loss(-0.5 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/carrotjuice
	name = "Carrot Juice"
	description = "É como uma cenoura, mas sem mastigar."
	color = "#973800" // rgb: 151, 56, 0
	taste_description = "carrots"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/carrotjuice/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_eye_blur(-1 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_temp_blindness(-1 SECONDS * metabolization_ratio * seconds_per_tick)
	var/need_mob_update
	switch(current_cycle)
		if(21 to 110)
			if(SPT_PROB(100 * (1 - (sqrt(110 - current_cycle) / 10)), seconds_per_tick))
				need_mob_update = affected_mob.adjust_organ_loss(ORGAN_SLOT_EYES, -1 * metabolization_ratio)
		if(110 to INFINITY)
			need_mob_update = affected_mob.adjust_organ_loss(ORGAN_SLOT_EYES, -1 * metabolization_ratio * seconds_per_tick)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/berryjuice
	name = "Berry Juice"
	description = "Uma deliciosa mistura de vários tipos diferentes de frutas."
	color = "#863333" // rgb: 134, 51, 51
	taste_description = "berries"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/applejuice
	name = "Apple Juice"
	description = "O suco doce de uma maçã, adequado para todas as idades."
	color = "#fff06b" // rgb: 255, 240, 107
	taste_description = "apples"
	ph = 3.2 // ~ 2.7 -> 3.7

/datum/reagent/consumable/poisonberryjuice
	name = "Poison Berry Juice"
	description = "Um delicioso suco misturado de vários tipos de bagas muito mortais e tóxicas."
	color = "#792b49" // rgb: 121, 43, 73
	taste_description = "berries"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/poisonberryjuice/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.adjust_tox_loss(0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/watermelonjuice
	name = "Watermelon Juice"
	description = "Suco delicioso feito de melancia."
	color = "#af5e5e" // rgb: 175, 94, 94
	taste_description = "Melancia suculenta"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/lemonjuice
	name = "Lemon Juice"
	description = "Este suco está muito azedo."
	color = "#ebeb9e" // rgb: 235, 235, 158
	taste_description = "sourness"
	ph = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/juice/lemonjuice

/datum/reagent/consumable/banana
	name = "Banana Juice"
	description = "A essência crua de uma banana. HONK"
	color = "#FFFCB9" // rgb: 255, 252, 185
	taste_description = "banana"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/banana/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/obj/item/organ/liver/liver = affected_mob.get_organ_slot(ORGAN_SLOT_LIVER)
	if((liver && HAS_TRAIT(liver, TRAIT_COMEDY_METABOLISM)) || is_simian(affected_mob))
		if(affected_mob.heal_bodypart_damage(brute = 0.5 * metabolization_ratio * seconds_per_tick, burn = 0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/nothing
	name = "Nothing"
	description = "Absolutamente nada."
	taste_description = "nothing"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/glass_style/shot_glass/nothing
	required_drink_type = /datum/reagent/consumable/nothing
	icon_state = "shotglass"

/datum/reagent/consumable/nothing/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(ishuman(drinker) && HAS_MIND_TRAIT(drinker, TRAIT_MIMING))
		drinker.set_silence_if_lower(MIMEDRINK_SILENCE_DURATION)
		if(drinker.heal_bodypart_damage(brute = 0.5 * metabolization_ratio * seconds_per_tick, burn = 0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/laughter
	name = "Laughter"
	description = "Alguns dizem que este é o melhor remédio, mas estudos recentes provaram que não é verdade."
	metabolization_rate = INFINITY
	color = "#FF4DD2"
	taste_description = "laughter"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/laughter/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tic, metabolization_ratio)
	. = ..()
	affected_mob.emote("laugh")
	affected_mob.add_mood_event("chemical_laughter", /datum/mood_event/chemical_laughter)

/datum/reagent/consumable/superlaughter
	name = "Super Laughter"
	description = "Engraçado até ser você quem está rindo."
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	color = "#FF4DD2"
	taste_description = "laughter"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/superlaughter/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(16, seconds_per_tick))
		affected_mob.visible_message(span_danger("[affected_mob] Estourou em um ataque de risadas incontroláveis!"), span_userdanger("Você explodiu em um ataque de risadas incontroláveis!"))
		affected_mob.Stun(5)
		affected_mob.add_mood_event("chemical_laughter", /datum/mood_event/chemical_superlaughter)

/datum/reagent/consumable/potato_juice
	name = "Potato Juice"
	description = "Suco de batata. Bleh."
	nutriment_factor = 2
	color = "#E8A856" // rgb: 234, 157, 58
	taste_description = "Tristeza irlandesa."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/pickle
	name = "Pickle Juice"
	description = "Mais precisamente, esta é a salmoura em que o picles estava flutuando"
	nutriment_factor = 2
	color = "#cde65e" // rgb: 205, 230, 94
	taste_description = "salmoura de vinagre"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/pickle/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/obj/item/organ/liver/liver = affected_mob.get_organ_slot(ORGAN_SLOT_LIVER)
	if((liver && HAS_TRAIT(liver, TRAIT_CORONER_METABOLISM)))
		if(affected_mob.adjust_tox_loss(-0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/grapejuice
	name = "Grape Juice"
	description = "O suco de um cacho de uvas. Garantido sem álcool."
	color = "#290029" // dark purple
	taste_description = "Soda de uva"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/plumjuice
	name = "Plum Juice"
	description = "Bebidas refrescantes e ligeiramente ácidas."
	color = "#b6062c"
	taste_description = "plums"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/milk
	name = "Milk"
	description = "Um líquido branco opaco produzido pelas glândulas mamárias dos mamíferos."
	color = "#DFDFDF" // rgb: 223, 223, 223
	taste_description = "milk"
	ph = 6.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/milk

// Milk is good for humans, but bad for plants.
// The sugars cannot be used by plants, and the milk fat harms growth. Except shrooms.
/datum/reagent/consumable/milk/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_waterlevel(round(volume * 0.3))
	var/obj/item/seeds/myseed = mytray.myseed
	if(isnull(myseed) || myseed.get_gene(/datum/plant_gene/trait/plant_type/fungal_metabolism))
		return
	myseed.adjust_potency(-round(volume * 0.5))

/datum/reagent/consumable/milk/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	if(affected_mob.get_brute_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.heal_bodypart_damage(brute = 0.5 * metabolization_ratio, burn = 0, updating_health = FALSE))
			. = UPDATE_MOB_HEALTH
	if(holder.has_reagent(/datum/reagent/consumable/capsaicin))
		holder.remove_reagent(/datum/reagent/consumable/capsaicin, seconds_per_tick)
	return ..() || .

/datum/reagent/consumable/milk/used_on_fish(obj/item/fish/fish)
	if(HAS_TRAIT(fish, TRAIT_FISH_MADE_OF_BONE))
		fish.repair_damage(fish.max_integrity * max(fish.get_hunger() * 0.5, 0.12))
		fish.sate_hunger()
		return TRUE

/datum/reagent/consumable/soymilk
	name = "Soy Milk"
	description = "Um líquido branco opaco feito de soja."
	color = "#DFDFC7" // rgb: 223, 223, 199
	taste_description = "Leite de soja"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/soymilk

/datum/reagent/consumable/soymilk/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.get_brute_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.heal_bodypart_damage(1, 0))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/cream
	name = "Cream"
	description = "O gordo, ainda líquido parte do leite. Por que não mistura isso com sum scotch?"
	color = "#DFD7AF" // rgb: 223, 215, 175
	taste_description = "Leite cremoso."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/juice/cream

/datum/reagent/consumable/cream/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(10, seconds_per_tick) && affected_mob.heal_bodypart_damage(1, 0))
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/coffee
	name = "Coffee"
	description = "O café é uma bebida preparada a partir de sementes assadas, comumente chamadas grãos de café, da planta de café."
	color = "#482000" // rgb: 72, 32, 0
	nutriment_factor = 0
	overdose_threshold = 80
	taste_description = "bitterness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/coffee/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/coffee/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	//310.15 is the normal bodytemp.
	affected_mob.adjust_bodytemperature(12.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, affected_mob.get_body_temp_normal())
	if(holder.has_reagent(/datum/reagent/consumable/frostoil))
		holder.remove_reagent(/datum/reagent/consumable/frostoil, 2.5 * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/tea
	name = "Tea"
	description = "Chá preto saboroso, tem antioxidantes, é bom para você!"
	color = "#101000" // rgb: 16, 16, 0
	nutriment_factor = 0
	taste_description = "Chá preto de torta"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK
	default_container = /obj/item/reagent_containers/cup/glass/mug/tea
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/tea/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-1 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_jitter(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-1 SECONDS * metabolization_ratio * seconds_per_tick)
	if(affected_mob.get_tox_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.adjust_tox_loss(-0.5 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			. = UPDATE_MOB_HEALTH
	affected_mob.adjust_bodytemperature(10 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, affected_mob.get_body_temp_normal())

	var/to_chatted = FALSE
	for(var/datum/wound/iter_wound as anything in affected_mob.all_wounds)
		if(SPT_PROB(10, seconds_per_tick))
			var/helped = iter_wound.tea_life_process()
			if(!to_chatted && helped)
				to_chat(affected_mob, span_notice("Uma sensação calma e relaxada te sufoca. Suas feridas parecem mais saudáveis."))
			to_chatted = TRUE

// Different handling, different name.
// Returns FALSE by default so broken bones and 'loss' wounds don't give a false message
/datum/wound/proc/tea_life_process()
	return FALSE

// Slowly increase (gauzed) clot rate
/datum/wound/pierce/bleed/tea_life_process()
	gauzed_clot_rate += 0.1
	return TRUE

// Slowly increase clot rate
/datum/wound/slash/flesh/tea_life_process()
	clot_rate += 0.2
	return TRUE

// There's a designated burn process, but I felt this would be better for consistency with the rest of the reagent's procs
/datum/wound/burn/flesh/tea_life_process()
	// Sanitizes and heals, but with a limit
	flesh_healing = (flesh_healing > 0.1) ? flesh_healing : flesh_healing + 0.02
	infection_rate = max(infection_rate - 0.005, 0)
	return TRUE

/datum/reagent/consumable/lemonade
	name = "Lemonade"
	description = "Limonada doce e picante. Bom para a alma."
	color = "#FFE978"
	quality = DRINK_NICE
	taste_description = "Sol e verão"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/tea/arnold_palmer
	name = "Arnold Palmer"
	description = "Encoraja o paciente a jogar golfe."
	color = "#FFB766"
	quality = DRINK_NICE
	nutriment_factor = 10
	taste_description = "Chá amargo."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/tea/arnold_palmer/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(2.5, seconds_per_tick))
		to_chat(affected_mob, span_notice("[pick("You remember to square your shoulders.","You remember to keep your head down.","You can't decide between squaring your shoulders and keeping your head down.","You remember to relax.","You think about how someday you'll get two strokes off your golf game.")]"))

/datum/reagent/consumable/icecoffee
	name = "Iced Coffee"
	description = "Café e gelo, refrescante e fresco."
	color = "#462b15" // rgb: 70, 43, 21
	nutriment_factor = 0
	overdose_threshold = 80
	taste_description = "Frieza amarga"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/icecoffee/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/icecoffee/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/hot_ice_coffee
	name = "Hot Ice Coffee"
	description = "Café com pedaços de gelo pulsantes"
	color = "#462b15" // rgb: 70, 43, 21
	nutriment_factor = 0
	overdose_threshold = 80
	taste_description = "Frieza amarga e uma pitada de fumaça"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/hot_ice_coffee/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/hot_ice_coffee/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-3.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())
	if(affected_mob.adjust_tox_loss(0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/icetea
	name = "Iced Tea"
	description = "Nenhuma relação com um artista/ator de rap."
	color = "#104038" // rgb: 16, 64, 56
	nutriment_factor = 0
	taste_description = "Chá doce"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/icetea/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-1 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	if(affected_mob.get_tox_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.adjust_tox_loss(-0.5 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			. = UPDATE_MOB_HEALTH
	affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/space_cola
	name = "Cola"
	description = "Uma bebida refrescante."
	color = "#100800" // rgb: 16, 8, 0
	taste_description = "cola"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/space_cola/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_drowsiness(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/roy_rogers
	name = "Roy Rogers"
	description = "Uma bebida com gás."
	color = "#53090B"
	quality = DRINK_GOOD
	taste_description = "Cola frutado super doce"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/roy_rogers/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	affected_mob.set_jitter_if_lower(6 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())
	return ..()

/datum/reagent/consumable/nuka_cola
	name = "Nuka Cola"
	description = "Cola, cola nunca muda."
	color = "#100800" // rgb: 16, 8, 0
	quality = DRINK_VERYGOOD
	taste_description = "O futuro"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/nuka_cola/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.add_movespeed_modifier(/datum/movespeed_modifier/reagent/nuka_cola)

/datum/reagent/consumable/nuka_cola/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/nuka_cola)

/datum/reagent/consumable/nuka_cola/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(20 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.set_drugginess(30 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_dizzy(1.5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.remove_status_effect(/datum/status_effect/drowsiness)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, affected_mob.get_body_temp_normal())
	if (SSradiation.can_irradiate_basic(affected_mob))
		affected_mob.AddComponent(/datum/component/irradiated)

/datum/reagent/consumable/rootbeer
	name = "Root Beer"
	description = "Uma deliciosa cerveja espumante, cheia de tanto açúcar que pode acelerar o dedo gatilho do usuário."
	color = "#181008" // rgb: 24, 16, 8
	quality = DRINK_VERYGOOD
	nutriment_factor = 10
	metabolization_rate = 2 * REAGENTS_METABOLISM
	taste_description = "Uma monstruosa corrida de açúcar."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	/// If we activated the effect
	var/effect_enabled = FALSE

/datum/reagent/consumable/rootbeer/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	REMOVE_TRAIT(affected_mob, TRAIT_DOUBLE_TAP, type)
	if(current_cycle > 10)
		to_chat(affected_mob, span_warning("Você se sente um pouco cansado com o efeito do açúcar..."))
		affected_mob.adjust_stamina_loss(min(80, current_cycle * 3), required_biotype = affected_biotype)
		affected_mob.adjust_drowsiness((current_cycle-1) * 2 SECONDS)

/datum/reagent/consumable/rootbeer/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(current_cycle > 3 && !effect_enabled) // takes a few seconds for the bonus to kick in to prevent microdosing
		to_chat(affected_mob, span_notice("Sente o dedo do gatilho coçando..."))
		ADD_TRAIT(affected_mob, TRAIT_DOUBLE_TAP, type)
		effect_enabled = TRUE

	affected_mob.set_jitter_if_lower(1 SECONDS * metabolization_ratio * seconds_per_tick)
	if(prob(50))
		affected_mob.adjust_dizzy(0.5 SECONDS * metabolization_ratio * seconds_per_tick)
	if(current_cycle > 10)
		affected_mob.adjust_dizzy(0.75 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/grey_bull
	name = "Grey Bull"
	description = "Grey Bull, te dá luvas!"
	color = "#EEFF00" // rgb: 238, 255, 0
	quality = DRINK_VERYGOOD
	taste_description = "Óleo carbonatado"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_SHOCKIMMUNE)

/datum/reagent/consumable/grey_bull/on_mob_metabolize(mob/living/carbon/affected_atom)
	. = ..()
	var/obj/item/organ/liver/liver = affected_atom.get_organ_slot(ORGAN_SLOT_LIVER)
	if(HAS_TRAIT(liver, TRAIT_MAINTENANCE_METABOLISM))
		affected_atom.add_mood_event("maintenance_fun", /datum/mood_event/maintenance_high)
		metabolization_rate *= 0.8

/datum/reagent/consumable/grey_bull/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(20 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_dizzy(1 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.remove_status_effect(/datum/status_effect/drowsiness)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/spacemountainwind
	name = "SM Wind"
	description = "Sopra através de você como um vento espacial."
	color = "#102000" // rgb: 16, 32, 0
	taste_description = "doce refrigerante cítrico"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/spacemountainwind/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_drowsiness(-7 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-1 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())
	affected_mob.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/dr_gibb
	name = "Dr. Gibb"
	description = "Uma deliciosa mistura de 42 sabores diferentes."
	color = "#102000" // rgb: 16, 32, 0
	taste_description = "refrigerante de cereja" // FALSE ADVERTISING
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/dr_gibb/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_drowsiness(-6 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/space_up
	name = "Space-Up"
	description = "Tem gosto de quebra de casco na boca."
	color = COLOR_VIBRANT_LIME // rgb: 0, 255, 0
	taste_description = "refrigerante de cereja"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/space_up/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(-4 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/lemon_lime
	name = "Lemon Lime"
	description = "Uma substância picante feita de 0,5% de citrinos naturais!"
	color = "#8CFF00" // rgb: 135, 255, 0
	taste_description = "limão e limão soda"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/lemon_lime/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(-4 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/pwr_game
	name = "Pwr Game"
	description = "A única bebida que os verdadeiros jogadores desejam."
	color = "#9385bf" // rgb: 58, 52, 75
	taste_description = "Doce e salgado"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/pwr_game/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(exposed_mob?.mind?.get_skill_level(/datum/skill/gaming) >= SKILL_LEVEL_LEGENDARY && (methods & INGEST) && !HAS_TRAIT(exposed_mob, TRAIT_GAMERGOD))
		ADD_TRAIT(exposed_mob, TRAIT_GAMERGOD, "pwr_game")
		to_chat(exposed_mob, span_nicegreen("Enquanto você bebe o jogo Pwr, seu terceiro olho de jogador abre... Você sente como se um grande segredo do universo tivesse sido dado a você..."))

/datum/reagent/consumable/pwr_game/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(-4 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())
	if(SPT_PROB(5, seconds_per_tick))
		affected_mob.mind?.adjust_experience(/datum/skill/gaming, 5)

/datum/reagent/consumable/shamblers
	name = "Shambler's Juice"
	description = "Agite-me um pouco daquele suco de Shambler!"
	color = "#f00060" // rgb: 94, 0, 38
	taste_description = "refrigerante metálico carbonatado."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/shamblers/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(-4 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/sodawater
	name = "Soda Water"
	description = "Uma lata de refrigerante. Por que não fazer um uísque com soda?"
	color = "#619494" // rgb: 97, 148, 148
	taste_description = "Água carbonatada."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

// A variety of nutrients are dissolved in club soda, without sugar.
// These nutrients include carbon, oxygen, hydrogen, phosphorous, potassium, sulfur and sodium, all of which are needed for healthy plant growth.
/datum/reagent/consumable/sodawater/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_waterlevel(round(volume))
	mytray.adjust_plant_health(round(volume * 0.1))

/datum/reagent/consumable/sodawater/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/tonic
	name = "Tonic Water"
	description = "Tem um gosto estranho, mas pelo menos o quinino mantém a Malária Espacial longe."
	color = "#0064C8" // rgb: 0, 100, 200
	taste_description = "Tart e fresco"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/tonic/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/wellcheers
	name = "Wellcheers"
	description = "Uma bebida roxa estranha, cheirando a água salgada. Em algum lugar distante, você ouve gaivotas."
	color = "#762399" // rgb: 118, 35, 153
	taste_description = "uvas e o mar aberto fresco"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/wellcheers/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_drowsiness(1.5 SECONDS * metabolization_ratio * seconds_per_tick)
	var/need_mob_update
	switch(affected_mob.mob_mood.sanity_level)
		if (SANITY_LEVEL_GREAT to SANITY_LEVEL_NEUTRAL)
			need_mob_update = affected_mob.adjust_brute_loss(-0.75 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		if (SANITY_LEVEL_DISTURBED to SANITY_LEVEL_UNSTABLE)
			affected_mob.add_mood_event("wellcheers", /datum/mood_event/wellcheers)
		if (SANITY_LEVEL_CRAZY to SANITY_LEVEL_INSANE)
			need_mob_update = affected_mob.adjust_stamina_loss(1.5 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/monkey_energy
	name = "Monkey Energy"
	description = "A única bebida que fará você soltar o macaco."
	color = "#f39b03" // rgb: 243, 155, 3
	overdose_threshold = 60
	taste_description = "churrasco e nostalgia"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/monkey_energy/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(40 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_dizzy(1 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.remove_status_effect(/datum/status_effect/drowsiness)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/monkey_energy/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	if(is_simian(affected_mob))
		affected_mob.add_movespeed_modifier(/datum/movespeed_modifier/reagent/monkey_energy)

/datum/reagent/consumable/monkey_energy/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/monkey_energy)

/datum/reagent/consumable/monkey_energy/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(7.5, seconds_per_tick))
		affected_mob.say(pick_list_replacements(BOOMER_FILE, "boomer"), forced = /datum/reagent/consumable/monkey_energy)

/datum/reagent/consumable/ice
	name = "Ice"
	description = "Água congelada, seu dentista não gostaria que mastigasse isso."
	color = "#619494" // rgb: 97, 148, 148
	taste_description = "ice"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/ice

/datum/reagent/consumable/ice/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, FALSE, affected_mob.get_body_temp_normal()))
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/soy_latte
	name = "Soy Latte"
	description = "Uma bebida saborosa enquanto lê seus livros hippies."
	color = "#cc6404" // rgb: 204,100,4
	overdose_threshold = 80
	quality = DRINK_NICE
	taste_description = "Café cremoso."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/soy_latte/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/soy_latte/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	var/need_mob_update
	need_mob_update = affected_mob.SetSleeping(0)
	affected_mob.adjust_bodytemperature(2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, 0, affected_mob.get_body_temp_normal())
	if(affected_mob.get_brute_loss() && SPT_PROB(10, seconds_per_tick))
		need_mob_update += affected_mob.heal_bodypart_damage(brute = 0.5 * metabolization_ratio, burn = 0, updating_health = FALSE)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/cafe_latte
	name = "Cafe Latte"
	description = "Uma bebida agradável, forte e saborosa enquanto você está lendo."
	color = "#cc6404" // rgb: 204,100,4
	overdose_threshold = 80
	quality = DRINK_NICE
	taste_description = "Creme amargo"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/cafe_latte/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/cafe_latte/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-6 SECONDS * metabolization_ratio * seconds_per_tick)
	var/need_mob_update
	need_mob_update = affected_mob.SetSleeping(0)
	affected_mob.adjust_bodytemperature(2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, affected_mob.get_body_temp_normal())
	if(affected_mob.get_brute_loss() && SPT_PROB(10, seconds_per_tick))
		need_mob_update += affected_mob.heal_bodypart_damage(brute = 0.5 * metabolization_ratio, burn = 0, updating_health = FALSE)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/doctor_delight
	name = "The Doctor's Delight"
	description = "Um gole por dia mantém o Medibot longe! Uma mistura de sucos que cura a maioria dos tipos de danos rapidamente ao custo da fome."
	color = "#FF8CFF" // rgb: 255, 140, 255
	quality = DRINK_VERYGOOD
	taste_description = "Fruta caseira"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/doctor_delight/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	need_mob_update = affected_mob.adjust_brute_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += affected_mob.adjust_fire_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += affected_mob.adjust_tox_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
	need_mob_update += affected_mob.adjust_oxy_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype, required_respiration_type = affected_respiration_type)
	if(affected_mob.nutrition && (affected_mob.nutrition - 2 > 0))
		var/obj/item/organ/liver/liver = affected_mob.get_organ_slot(ORGAN_SLOT_LIVER)
		if(!(HAS_TRAIT(liver, TRAIT_MEDICAL_METABOLISM)))
			// Drains the nutrition of the holder. Not medical doctors though, since it's the Doctor's Delight!
			affected_mob.adjust_nutrition(-1 * metabolization_ratio * seconds_per_tick)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/cinderella
	name = "Cinderella"
	description = "Definitivamente um coquetel de álcool frutado para ter enquanto festeja com seus amigos."
	color = "#FF6A50"
	quality = DRINK_VERYGOOD
	taste_description = "doce fruta picante"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/cinderella/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_disgust(-2.5 * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/cherryshake
	name = "Cherry Shake"
	description = "Um milkshake com sabor de cereja."
	color = "#FFB6C1"
	quality = DRINK_VERYGOOD
	nutriment_factor = 8
	taste_description = "Cereja de torta cremosa"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/bluecherryshake
	name = "Blue Cherry Shake"
	description = "Um milkshake exótico."
	color = "#00F1FF"
	quality = DRINK_VERYGOOD
	nutriment_factor = 8
	taste_description = "Cereja azul cremosa"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/vanillashake
	name = "Vanilla Shake"
	description = "Um milk-shake com sabor de baunilha. O básico ainda está bom."
	color = "#E9D2B2"
	quality = DRINK_VERYGOOD
	nutriment_factor = 8
	taste_description = "Doce baunilha cremosa"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/caramelshake
	name = "Caramel Shake"
	description = "Um milk-shake com sabor de caramelo. Seus dentes doem olhando para ele."
	color = "#E17C00"
	quality = DRINK_GOOD
	nutriment_factor = 10
	taste_description = "doce rico caramelo cremoso"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/choccyshake
	name = "Chocolate Shake"
	description = "Um milkshake de chocolate gelado."
	color = "#541B00"
	quality = DRINK_VERYGOOD
	nutriment_factor = 8
	taste_description = "doce chocolate cremoso"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/strawberryshake
	name = "Strawberry Shake"
	description = "Um milkshake de morango."
	color = "#ff7b7b"
	quality = DRINK_VERYGOOD
	nutriment_factor = 8
	taste_description = "morangos doces e leite"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/bananashake
	name = "Banana Shake"
	description = "Um milkshake de banana. Coisas que os palhaços bebem nas festas."
	color = "#f2d554"
	quality = DRINK_VERYGOOD
	nutriment_factor = 8
	taste_description = "Banana grossa."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/pumpkin_latte
	name = "Pumpkin Latte"
	description = "Uma mistura de suco de abóbora e café."
	color = "#F4A460"
	overdose_threshold = 80
	quality = DRINK_VERYGOOD
	nutriment_factor = 3
	taste_description = "Abóbora cremosa"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/pumpkin_latte/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/pumpkin_latte/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	var/need_mob_update
	need_mob_update = affected_mob.SetSleeping(0)
	affected_mob.adjust_bodytemperature(2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, affected_mob.get_body_temp_normal())
	if(affected_mob.get_brute_loss() && SPT_PROB(10, seconds_per_tick))
		need_mob_update += affected_mob.heal_bodypart_damage(brute = 0.5 * metabolization_ratio, burn = 0, updating_health = FALSE)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/gibbfloats
	name = "Gibb Floats"
	description = "Sorvete em cima de um copo do Dr. Gibb."
	color = "#B22222"
	quality = DRINK_NICE
	nutriment_factor = 3
	taste_description = "Cereja cremosa"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/pumpkinjuice
	name = "Pumpkin Juice"
	description = "Sugado de abóbora de verdade."
	color = "#FFA500"
	taste_description = "pumpkin"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/blumpkinjuice
	name = "Blumpkin Juice"
	description = "Sugado de carne de verdade."
	color = "#00BFFF"
	taste_description = "Uma boca cheia de água da piscina."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/triple_citrus
	name = "Triple Citrus"
	description = "Uma solução."
	color = "#EEFF00"
	quality = DRINK_NICE
	taste_description = "extrema amargura"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/grape_soda
	name = "Grape Soda"
	description = "Amado por crianças e abstêmios."
	color = "#E6CDFF"
	taste_description = "Soda de uva"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/grape_soda/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(-2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/milk/chocolate_milk
	name = "Chocolate Milk"
	description = "Leite para crianças legais."
	color = "#7D4E29"
	quality = DRINK_NICE
	taste_description = "Leite de chocolate"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/hot_coco
	name = "Hot Coco"
	description = "Feito com amor! E feijão de coco."
	nutriment_factor = 4
	color = "#3b240e" // rgb: 59, 36, 14
	taste_description = "Chocolate cremoso"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/hot_coco/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	affected_mob.adjust_bodytemperature(2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, affected_mob.get_body_temp_normal())
	if(affected_mob.get_brute_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.heal_bodypart_damage(brute = 0.5 * metabolization_ratio, burn = 0, updating_health = FALSE))
			. = UPDATE_MOB_HEALTH
	if(holder.has_reagent(/datum/reagent/consumable/capsaicin))
		holder.remove_reagent(/datum/reagent/consumable/capsaicin, 1 * metabolization_ratio * seconds_per_tick)
	return ..() || .

/datum/reagent/consumable/italian_coco
	name = "Italian Hot Chocolate"
	description = "Feito com amor! Pode imaginar uma Nonna feliz pelo cheiro."
	nutriment_factor = 8
	color = "#57372A"
	quality = DRINK_VERYGOOD
	taste_description = "chocolate cremoso espesso"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/italian_coco/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, 0, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/menthol
	name = "Menthol"
	description = "Alivia sintomas de tosse que alguém pode ter."
	color = "#80AF9C"
	taste_description = "mint"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/juice/menthol

/datum/reagent/consumable/menthol/on_mob_life(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.apply_status_effect(/datum/status_effect/throat_soothed)

/datum/reagent/consumable/grenadine
	name = "Grenadine"
	description = "Não tem sabor de cereja!"
	color = "#EA1D26"
	taste_description = "Romãs doces"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/grenadine/on_mob_metabolize(mob/living/drinker)
	. = ..()
	if(IS_REVOLUTIONARY(drinker))
		to_chat(drinker, span_warning("Antioxidantes estão enfraquecendo seu espírito radical!"))

/datum/reagent/consumable/grenadine/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(IS_REVOLUTIONARY(drinker))
		drinker.set_dizzy_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)
		if(drinker.get_stamina_loss() < 80)
			drinker.adjust_stamina_loss(12, required_biotype = affected_biotype) //The pomegranate stops free radicals! Har har.

/datum/reagent/consumable/parsnipjuice
	name = "Parsnip Juice"
	description = "Why..."
	color = "#FFA500"
	taste_description = "parsnip"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/pineapplejuice
	name = "Pineapple Juice"
	description = "Tart, tropical, e intensamente debatido."
	color = "#F7D435"
	taste_description = "pineapple"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/juice/pineapplejuice

/datum/reagent/consumable/peachjuice //Intended to be extremely rare due to being the limiting ingredients in the blazaam drink
	name = "Peach Juice"
	description = "Muito bem."
	color = "#E78108"
	taste_description = "peaches"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/cream_soda
	name = "Cream Soda"
	description = "Um clássico refrigerante com sabor de baunilha."
	color = "#dcb137"
	quality = DRINK_VERYGOOD
	taste_description = "Baunilha com gás"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/cream_soda/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(-2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/sol_dry
	name = "Sol Dry"
	description = "Uma bebida calmante e suave feita de gengibre."
	color = "#f7d26a"
	quality = DRINK_NICE
	taste_description = "Tempero doce de gengibre"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/sol_dry/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_disgust(-2.5 * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/shirley_temple
	name = "Shirley Temple"
	description = "Aqui está, garotinha, agora pode beber como os adultos."
	color = "#F43724"
	quality = DRINK_GOOD
	taste_description = "Xarope de cereja doce e especiarias de gengibre"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/shirley_temple/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	affected_mob.adjust_disgust(-1.5 * metabolization_ratio * seconds_per_tick)
	return ..()

/datum/reagent/consumable/red_queen
	name = "Red Queen"
	description = "Beba-me."
	color = "#e6ddc3"
	quality = DRINK_GOOD
	taste_description = "wonder"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/current_size = RESIZE_DEFAULT_SIZE

/datum/reagent/consumable/red_queen/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(50, seconds_per_tick))
		return

	var/newsize = pick(0.5, 0.75, 1, 1.50, 2)
	newsize *= RESIZE_DEFAULT_SIZE
	affected_mob.update_transform(newsize/current_size)
	current_size = newsize
	if(SPT_PROB(23, seconds_per_tick))
		affected_mob.emote("sneeze")

/datum/reagent/consumable/red_queen/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.update_transform(RESIZE_DEFAULT_SIZE/current_size)
	current_size = RESIZE_DEFAULT_SIZE

/datum/reagent/consumable/bungojuice
	name = "Bungo Juice"
	color = "#F9E43D"
	description = "Exótico! Parece que já está de férias."
	taste_description = "Bungo suculento"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/prunomix
	name = "Pruno Mixture"
	color = "#E78108"
	description = "Frutas, açúcar, fermento e água juntos em uma pasta pungente."
	taste_description = "garbage"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/aloejuice
	name = "Aloe Juice"
	color = "#b3c5a7" // rgb: 179, 197, 167
	description = "Um suco saudável e refrescante."
	taste_description = "vegetable"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/aloejuice/on_mob_life(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.get_tox_loss() && SPT_PROB(16, seconds_per_tick))
		if(affected_mob.adjust_tox_loss(-0.5 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/agua_fresca
	name = "Agua Fresca"
	description = "Uma melancia refrescante agua fresca. Perfeito em um dia no holodeck."
	color = "#D25B66"
	quality = DRINK_VERYGOOD
	taste_description = "Melancia refrescante."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/agua_fresca/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(-4 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())
	if(affected_mob.get_tox_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.adjust_tox_loss(-0.25 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/mushroom_tea
	name = "Mushroom Tea"
	description = "Um copo salgado de chá feito de aparas de cogumelos poliporos, originalmente nativo de Tizira."
	color = "#674945" // rgb: 16, 16, 0
	nutriment_factor = 0
	taste_description = "mushrooms"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/mushroom_tea/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(islizard(affected_mob))
		if(affected_mob.adjust_oxy_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype, required_respiration_type = affected_respiration_type))
			return UPDATE_MOB_HEALTH

//Moth Stuff
/datum/reagent/consumable/toechtauese_juice
	name = "Töchtaüse Juice"
	description = "Um suco desagradável feito de bagas. Melhor fazer um xarope, a menos que goste de dor."
	color = "#554862" // rgb: 85, 72, 98
	nutriment_factor = 0
	taste_description = "dor ardente coceira"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/toechtauese_syrup
	name = "Töchtaüse Syrup"
	description = "Um xarope picante e amargo, feito de bagas. Útil como ingrediente, para comida e coquetéis."
	color = "#554862" // rgb: 85, 72, 98
	nutriment_factor = 0
	taste_description = "açúcar, especiarias, e nada agradável."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/strawberry_banana
	name = "Strawberry Banana Smoothie"
	description = "Um smoothie clássico feito de morangos e bananas."
	color = "#FF9999"
	nutriment_factor = 0
	taste_description = "morango e banana"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/berry_blast
	name = "Berry Blast Smoothie"
	description = "Um smoothie clássico feito de bagas mistas."
	color = "#A76DC5"
	nutriment_factor = 0
	taste_description = "Bagas mistas"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/funky_monkey
	name = "Funky Monkey Smoothie"
	description = "Um smoothie clássico feito de chocolate e bananas."
	color = COLOR_BROWNER_BROWN
	nutriment_factor = 0
	taste_description = "chocolate e banana"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/green_giant
	name = "Green Giant Smoothie"
	description = "Um smoothie vegetal verde, feito sem vegetais."
	color = COLOR_VERY_DARK_LIME_GREEN
	nutriment_factor = 0
	taste_description = "Verde, apenas verde"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/melon_baller
	name = "Melon Baller Smoothie"
	description = "Um clássico smoothie feito de melões."
	color = "#D22F55"
	nutriment_factor = 0
	taste_description = "Melão fresco"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/vanilla_dream
	name = "Vanilla Dream Smoothie"
	description = "Uma vitamina clássica feita de baunilha e creme fresco."
	color = "#FFF3DD"
	nutriment_factor = 0
	taste_description = "Baunilha cremosa"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/cucumberjuice
	name = "Cucumber Juice"
	description = "Suco comum de pepino, nada do mundo da fantasia."
	color = "#B1D861" // rgb: 177, 216, 97
	taste_description = "Pepino leve"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/cucumberlemonade
	name = "Cucumber Lemonade"
	description = "Suco de pepino, açúcar e refrigerante. O que mais preciso?"
	color = "#cbe248" // rgb: 203, 226, 72
	quality = DRINK_GOOD
	taste_description = "Soda cítrica com pepino"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_HIGH

/datum/reagent/consumable/cucumberlemonade/on_mob_life(mob/living/carbon/doll, seconds_per_tick, metabolization_ratio)
	. = ..()
	doll.adjust_bodytemperature(-4 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, doll.get_body_temp_normal())
	if(doll.get_tox_loss() && SPT_PROB(10, seconds_per_tick))
		if(doll.adjust_tox_loss(-0.25 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/mississippi_queen
	name = "Mississippi Queen"
	description = "Se acha que é tão gostosa, que tal uma bebida da vitória?"
	color = "#d4422f" // rgb: 212,66,47
	taste_description = "lodo escorrendo pela sua garganta."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/mississippi_queen/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	switch(current_cycle)
		if(11 to 21)
			drinker.adjust_dizzy(2 SECONDS * metabolization_ratio * seconds_per_tick)
		if(21 to 31)
			if(SPT_PROB(15, seconds_per_tick))
				drinker.adjust_confusion(2 SECONDS * metabolization_ratio)
		if(31 to 201)
			drinker.adjust_hallucinations(30 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/t_letter
	name = "T"
	description = "Você esperava encontrar isso em uma sopa, mas isso também está bom."
	color = "#583d09" // rgb: 88, 61, 9
	taste_description = "Uma de suas 26 cartas favoritas."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/t_letter/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(!HAS_MIND_TRAIT(affected_mob, TRAIT_MIMING))
		return
	affected_mob.set_silence_if_lower(MIMEDRINK_SILENCE_DURATION)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	if(affected_mob.get_tox_loss() && SPT_PROB(25, seconds_per_tick))
		if(affected_mob.adjust_tox_loss(-1 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/hakka_mate
	name = "Hakka-Mate"
	description = "Um refrigerante de erva-mate feito por marciano, arrastado direto para fora dos poços de uma convenção de hackers."
	color = "#c4b000"
	taste_description = "Bubbly yerba mate"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/coconut_milk
	name = "Coconut Milk"
	description = "Um substituto de leite versátil que é perfeito para tudo, desde cozinhar até fazer coquetéis."
	color = "#DFDFDF"
	taste_description = "Coco leitoso"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/melon_soda
	name = "Melon Soda"
	description = "Um ataque de nostalgia verde neon."
	color = "#6FEB48"
	taste_description = "Melancia felpuda"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/volt_energy
	name = "24-Volt Energy"
	description = "Uma bebida de energia elétrica de cor artificial e sabor, com sabor de lamparina. Feito para etéreos, por etéreos."
	color = "#99E550"
	taste_description = "Pêra azeda"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/volt_energy/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(exposed_mob))
		return

	var/mob/living/carbon/exposed_carbon = exposed_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 20 * ETHEREAL_DISCHARGE_RATE)

/datum/reagent/consumable/fruit_punch
	name = "fruit punch"
	description = "Impossível ponche de fruta doce. Ninguém sabe quais frutas foram usadas para fazer isso, nem mesmo os criadores... É uma receita única cura e rejuvenesce o bebedor, mas não é seguro consumir sem o apoio de um refrigerador de água próximo."
	color = "#f7b2e3"
	taste_description = "Fruta perigosamente doce"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	quality = DRINK_VERYGOOD

/datum/reagent/consumable/fruit_punch/on_mob_life(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	var/found_valid_cooler = FALSE
	for(var/obj/structure/reagent_dispensers/water_cooler/found_cooler in range(4, affected_mob))
		if(found_cooler.anchored)
			found_valid_cooler = TRUE
			var/obj/effect/temp_visual/heal/heal_effect = new /obj/effect/temp_visual/heal(get_turf(found_cooler))
			heal_effect.color = "#f7b2e3"
			break

	if(found_valid_cooler)
		affected_mob.clear_alert("punch_bad")
		affected_mob.throw_alert("punch_good", /atom/movable/screen/alert/fruit_punch_good)
		need_mob_update = affected_mob.adjust_tox_loss(-0.3 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		need_mob_update = affected_mob.adjust_brute_loss(-0.3 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		need_mob_update = affected_mob.adjust_fire_loss(-0.3 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		affected_mob.remove_movespeed_modifier(/datum/movespeed_modifier/punch_punishment)
	else
		affected_mob.clear_alert("punch_good")
		affected_mob.throw_alert("punch_bad", /atom/movable/screen/alert/fruit_punch_bad)
		need_mob_update = affected_mob.apply_damage(0.75 * metabolization_ratio * seconds_per_tick, TOX)
		affected_mob.add_movespeed_modifier(/datum/movespeed_modifier/punch_punishment)
		if(SPT_PROB(10, seconds_per_tick))
			affected_mob.Knockdown(3 SECONDS, 6 SECONDS) //Gives daze effect. Using the cooler is a commitment and if you get jumped during it or have to run away to fight something, you should be vulnerable.
			to_chat(affected_mob, span_warning("A doçura esmagadora do ponche de frutas desorienta e confunde você!"))
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/movespeed_modifier/punch_punishment
	multiplicative_slowdown = 0.30

/datum/reagent/consumable/fruit_punch/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.clear_alert("punch_bad")
	affected_mob.clear_alert("punch_good")
	affected_mob.remove_movespeed_modifier(/datum/movespeed_modifier/punch_punishment)

/atom/movable/screen/alert/fruit_punch_good
	name = "Fruit Punch Blessing"
	desc = "A doçura do ponche de frutas e a companhia amigável do líquido refrigerador estão lentamente restaurando sua saúde..."
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "punch_blessing"

/atom/movable/screen/alert/fruit_punch_bad
	name = "Fruit Punishment"
	desc = "A doçura insuportável do ponche de frutas é demais para suportar sem a aura calmante de um líquido refrigerador! Seu corpo está entrando em choque!"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "punch_punishment"

/datum/reagent/consumable/ethanol/bitters_soda
	name = "Bitters and Soda"
	description = "Uma simples bebida de água com sabor aromático. Acalma o estômago."
	boozepwr = 0
	color = "#f1c1b3"
	quality = DRINK_NICE
	taste_description = "Aromas suaves"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bitters_soda/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_disgust(-2.5 * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/lean
	name = "Lean"
	description = "A bebida que faz você ficar tonto."
	color = "#DE55ED"
	quality = DRINK_GOOD
	taste_description = "roxo e uma pitada de opioide."
	addiction_types = list(/datum/addiction/opioids = 200)
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolization_rate = 0.5 * REAGENTS_METABOLISM

/datum/reagent/consumable/lean/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_jitter(2.5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_stutter(2.25 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drugginess(2 SECONDS * metabolization_ratio * seconds_per_tick)
	if(SPT_PROB(15, seconds_per_tick))
		affected_mob.emote(pick("taunt","twitch","shiver","laugh","moan","blush","stare"))
	if(current_cycle > 16 && SPT_PROB(3.5, seconds_per_tick))
		affected_mob.adjust_dizzy(15 SECONDS * metabolization_ratio)
		affected_mob.adjust_drowsiness(6.5 SECONDS * metabolization_ratio)
		affected_mob.emote("drool")
