#define ALCOHOL_THRESHOLD_MODIFIER 1 //Greater numbers mean that less alcohol has greater intoxication potential
#define ALCOHOL_EXPONENT 1.6 //The exponent applied to boozepwr to make higher volume alcohol at least a little bit damaging to the liver

/datum/reagent/consumable/ethanol
	name = "Ethanol"
	description = "Um conhecido álcool com várias aplicações."
	color = "#404030" // rgb: 64, 64, 48
	nutriment_factor = 0
	taste_description = "alcohol"
	metabolization_rate = 0.3 * REAGENTS_METABOLISM // BUBBER EDIT CHANGE - Original: 0.5 * REAGENTS_METABOLISM
	creation_purity = 1 // impure base reagents are a big no-no
	ph = 7.33
	burning_temperature = 2193//ethanol burns at 1970C (at its peak)
	burning_volume = 0.1
	default_container = /obj/item/reagent_containers/cup/glass/bottle/beer
	fallback_icon = 'icons/obj/drinks/bottles.dmi'
	fallback_icon_state = "beer"
	/**
	 * Boozepwr Chart
	 *
	 * Higher numbers equal higher hardness, higher hardness equals more intense alcohol poisoning
	 *
	 * Note that all higher effects of alcohol poisoning will inherit effects for smaller amounts
	 * (i.e. light poisoning inherts from slight poisoning)
	 * In addition, severe effects won't always trigger unless the drink is poisonously strong
	 * All effects don't start immediately, but rather get worse over time; the rate is affected by the imbiber's alcohol tolerance
	 * (see [/datum/status_effect/inebriated])
	 *
	 * * 0: Non-alcoholic
	 * * 1-10: Barely classifiable as alcohol - occassional slurring
	 * * 11-20: Slight alcohol content - slurring
	 * * 21-30: Below average - imbiber begins to look slightly drunk
	 * * 31-40: Just below average - no unique effects
	 * * 41-50: Average - mild disorientation, imbiber begins to look drunk
	 * * 51-60: Just above average - disorientation, vomiting, imbiber begins to look heavily drunk
	 * * 61-70: Above average - small chance of blurry vision, imbiber begins to look smashed
	 * * 71-80: High alcohol content - blurry vision, imbiber completely shitfaced
	 * * 81-90: Extremely high alcohol content - heavy toxin damage, passing out
	 * * 91-100: Dangerously toxic - swift death
	 */
	var/boozepwr = 65

/datum/reagent/consumable/ethanol/New(list/data)
	if(LAZYLEN(data))
		if(!isnull(data["quality"]))
			quality = data["quality"]
			name = "Natural " + name
		if(data["boozepwr"])
			boozepwr = data["boozepwr"]
	if(boozepwr > 0)
		// the stronger the drink, the less total of the drink is needed to reach addiction
		LAZYSET(addiction_types, /datum/addiction/alcohol, max(50, round(150 - boozepwr, 5)))
	return ..()

/datum/reagent/consumable/ethanol/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.get_drunk_amount() < volume * boozepwr * ALCOHOL_THRESHOLD_MODIFIER || boozepwr < 0)
		var/booze_power = boozepwr
		if(HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE)) // we're an accomplished drinker
			booze_power *= 0.7
		if(HAS_TRAIT(drinker, TRAIT_LIGHT_DRINKER))
			booze_power *= 1.33 // SKYRAT EDIT CHANGE - ALCOHOL_PROCESSING - ORIGINAL: booze_power *= 2

		// water will dilute alcohol effects
		var/total_water_volume = 0
		var/total_alcohol_volume = 0
		for(var/datum/reagent/water/sobriety in drinker.reagents.reagent_list)
			total_water_volume += sobriety.volume

		for(var/datum/reagent/consumable/ethanol/alcohol in drinker.reagents.reagent_list)
			total_alcohol_volume += alcohol.volume

		var/combined_dilute_volume = total_alcohol_volume + total_water_volume
		if(combined_dilute_volume) // safety check to prevent division by zero
			booze_power *= (total_alcohol_volume / combined_dilute_volume)

		for(var/mob/living/enemy as anything in drinker.ai_controller?.blackboard[BB_MONKEY_ENEMIES])
			drinker.ai_controller.add_blackboard_key_assoc(BB_MONKEY_ENEMIES, enemy, MONKEY_ANGERED_HATRED_AMOUNT * (boozepwr / 100) * metabolization_ratio * seconds_per_tick)

		// Volume, power, and server alcohol rate effect how quickly one gets drunk
		drinker.adjust_drunk_effect(1 * sqrt(volume) * booze_power * ALCOHOL_RATE * metabolization_ratio * seconds_per_tick)
		if(boozepwr > 0)
			var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
			var/heavy_drinker_multiplier = (HAS_TRAIT(drinker, TRAIT_HEAVY_DRINKER) ? 0.5 : 1)
			if (istype(liver))
				if(liver.apply_organ_damage(((max(sqrt(volume) * (boozepwr ** ALCOHOL_EXPONENT) * liver.alcohol_tolerance * heavy_drinker_multiplier * seconds_per_tick, 0))/300))) // SKYRAT EDIT CHANGE - ALCOHOL_PROCESSING - ORIGINAL: if((((max(sqrt(volume) * (boozepwr ** ALCOHOL_EXPONENT) * liver.alcohol_tolerance * heavy_drinker_multiplier * seconds_per_tick, 0))/150)))
					return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/expose_obj(obj/exposed_obj, reac_volume, methods=TOUCH, show_message=TRUE)
	if(istype(exposed_obj, /obj/item/paper))
		var/obj/item/paper/paperaffected = exposed_obj
		paperaffected.clear_paper()
		to_chat(usr, span_notice("[paperaffected] A tinta lava."))
	if(istype(exposed_obj, /obj/item/book))
		if(reac_volume >= 5)
			var/obj/item/book/affectedbook = exposed_obj
			affectedbook.book_data.set_content("")
			exposed_obj.visible_message(span_notice("[exposed_obj] A escrita é lavada por [name]!"))
		else
			exposed_obj.visible_message(span_warning("[exposed_obj] A tinta é manchada por [name] Mas não se lava!"))
	return ..()

/datum/reagent/consumable/ethanol/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)//Splashing people with ethanol isn't quite as good as fuel.
	. = ..()
	if(methods & INGEST)
		exposed_mob.check_allergic_reaction(ALCOHOL, chance = reac_volume * 5, histamine_add = min(10, reac_volume))

	if(methods & (TOUCH|VAPOR|PATCH))
		exposed_mob.adjust_fire_stacks(reac_volume / 15)
		exposed_mob.add_surgery_speed_mod("alcohol", round(1 - (boozepwr / 650), 0.05), min(reac_volume * 1 MINUTES, 5 MINUTES)) // Weak alcohol has less sterilizing power

/datum/reagent/consumable/ethanol/beer
	name = "Beer"
	description = "Uma bebida alcoólica produzida desde os tempos antigos na Terra Velha. Ainda é popular hoje."
	color = "#D7BC31" // rgb: 215, 188, 49
	nutriment_factor = 1
	boozepwr = 25
	taste_description = "Malte leve carbonatado"
	ph = 4
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

// Beer is a chemical composition of alcohol and various other things. It's a garbage nutrient but hey, it's still one. Also alcohol is bad, mmmkay?
/datum/reagent/consumable/ethanol/beer/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_plant_health(-round(volume * 0.05))
	mytray.adjust_waterlevel(round(volume * 0.7))

/datum/reagent/consumable/ethanol/beer/light
	name = "Light Beer"
	description = "Uma bebida alcoólica produzida desde os tempos antigos na Terra Velha. Esta variedade reduziu o teor de calorias e álcool."
	boozepwr = 5 //Space Europeans hate it
	taste_description = "água do prato"
	ph = 5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/beer/maltliquor
	name = "Malt Liquor"
	description = "Uma bebida alcoólica produzida desde os tempos antigos na Terra Velha. Esta variedade é mais forte que o normal, super barato, e super terrível."
	boozepwr = 35
	taste_description = "Cerveja de milho doce e a vida do capô"
	ph = 4.8
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/beer/green
	name = "Green Beer"
	description = "Uma bebida alcoólica produzida desde os tempos antigos na Terra Velha. Esta variedade é tingida de verde festivo."
	color = COLOR_CRAYON_GREEN
	overdose_threshold = 55 //More than a glass
	taste_description = "Água de mijo verde"
	ph = 6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/beer/green/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.color != color)
		drinker.add_atom_colour(color, TEMPORARY_COLOUR_PRIORITY)

/datum/reagent/consumable/ethanol/beer/green/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	drinker.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY, color)

/datum/reagent/consumable/ethanol/beer/green/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	metabolization_rate = REAGENTS_METABOLISM

	if(!ishuman(affected_mob))
		return

	var/mob/living/carbon/human/affected_human = affected_mob
	if(HAS_TRAIT(affected_human, TRAIT_USES_SKINTONES))
		affected_human.skin_tone = "green"
	else if(HAS_TRAIT(affected_human, TRAIT_MUTANT_COLORS) && !HAS_TRAIT(affected_human, TRAIT_FIXED_MUTANT_COLORS)) //Code stolen from spraytan overdose
		affected_human.dna.features[FEATURE_MUTANT_COLOR] = "#a8e61d"
	affected_human.update_body(is_creating = TRUE)

/datum/reagent/consumable/ethanol/kahlua
	name = "Kahlua"
	description = "Um licor mexicano com sabor a café. Em produção desde 1936!"
	color = "#8e8368" // rgb: 142,131,104
	boozepwr = 45
	ph = 6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/ethanol/kahlua/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_dizzy_if_lower(10 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.adjust_drowsiness(-6 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.AdjustSleeping(-4 SECONDS * metabolization_ratio * seconds_per_tick)
	if(!HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE))
		drinker.set_jitter_if_lower(10 SECONDS)

/datum/reagent/consumable/ethanol/whiskey
	name = "Whiskey"
	description = "Um uísque de malte soberbo e bem envelhecido. Droga."
	color = "#b4a287" // rgb: 180,162,135
	boozepwr = 75
	taste_description = "molasses"
	ph = 4.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/whiskey/kong
	name = "Kong"
	description = "Faz você virar macaco!"
	color = "#332100" // rgb: 51, 33, 0
	taste_description = "o aperto de um macaco gigante"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/whiskey/candycorn
	name = "Candy Corn Liquor"
	description = "Como se tivessem bebido em dois episódios."
	color = "#ccb800" // rgb: 204, 184, 0
	taste_description = "Xarope de panqueca"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/whiskey/candycorn/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(5, seconds_per_tick))
		drinker.adjust_hallucinations(4 SECONDS * metabolization_ratio)

/datum/reagent/consumable/ethanol/thirteenloko
	name = "Thirteen Loko"
	description = "Uma mistura potente de cafeína e álcool."
	color = "#102000" // rgb: 16, 32, 0
	nutriment_factor = 1
	boozepwr = 80
	quality = DRINK_GOOD
	overdose_threshold = 60
	taste_description = "Arrepios e morte"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/ethanol/thirteenloko/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_drowsiness(-14 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.AdjustSleeping(-4 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.adjust_bodytemperature(-5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, drinker.get_body_temp_normal())
	if(!HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE))
		drinker.set_jitter_if_lower(10 SECONDS)

/datum/reagent/consumable/ethanol/thirteenloko/overdose_start(mob/living/drinker, metabolization_ratio)
	. = ..()
	to_chat(drinker, span_userdanger("Todo o seu corpo treme violentamente quando começa a ficar enjoado. Você realmente não deveria ter bebido tudo isso.[name]!"))
	drinker.set_jitter_if_lower(40 SECONDS)
	drinker.Stun(1.5 SECONDS)

/datum/reagent/consumable/ethanol/thirteenloko/overdose_process(mob/living/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(3.5, seconds_per_tick) && iscarbon(drinker))
		var/obj/item/held_item = drinker.get_active_held_item()
		if(held_item)
			drinker.dropItemToGround(held_item)
			to_chat(drinker, span_notice("Suas mãos tremem e você larga o que estava segurando!"))
			drinker.set_jitter_if_lower(20 SECONDS)

	if(SPT_PROB(3.5, seconds_per_tick))
		to_chat(drinker, span_notice("[pick("You have a really bad headache.", "Your eyes hurt.", "You find it hard to stay still.", "You feel your heart practically beating out of your chest.")]"))

	if(SPT_PROB(2.5, seconds_per_tick) && iscarbon(drinker))
		var/obj/item/organ/eyes/eyes = drinker.get_organ_slot(ORGAN_SLOT_EYES)
		if(eyes && IS_ORGANIC_ORGAN(eyes)) // doesn't affect robotic eyes
			if(drinker.is_blind())
				eyes.Remove(drinker)
				eyes.forceMove(get_turf(drinker))
				to_chat(drinker, span_userdanger("Você dobra a dor enquanto sente seus olhos se liquidificando em sua cabeça!"))
				drinker.emote("scream")
				if(drinker.adjust_brute_loss(15 * metabolization_ratio, updating_health = FALSE, required_bodytype = affected_bodytype))
					. = UPDATE_MOB_HEALTH
			else
				to_chat(drinker, span_userdanger("Você grita de terror enquanto fica cego!"))
				if(eyes.apply_organ_damage(eyes.maxHealth))
					. = UPDATE_MOB_HEALTH
				drinker.emote("scream")

	if(SPT_PROB(1.5, seconds_per_tick) && iscarbon(drinker))
		drinker.visible_message(span_danger("[drinker] Começa a ter uma convulsão!"), span_userdanger("Você tem uma convulsão!"))
		if(drinker.Unconscious(10 SECONDS))
			. = UPDATE_MOB_HEALTH
		drinker.set_jitter_if_lower(700 SECONDS)

	if(SPT_PROB(0.5, seconds_per_tick) && iscarbon(drinker))
		drinker.apply_status_effect(/datum/status_effect/heart_attack)
		to_chat(drinker, span_userdanger("Tem certeza que sentiu seu coração parar por um segundo?"))
		drinker.playsound_local(drinker, 'sound/effects/singlebeat.ogg', 100, 0)

/datum/reagent/consumable/ethanol/vodka
	name = "Vodka"
	description = "A bebida número um e a escolha para os russos em todo o mundo."
	color = "#0064C8" // rgb: 0, 100, 200
	boozepwr = 65
	taste_description = "Álcool de grão"
	ph = 8.1
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_CLEANS //Very high proof
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/vodka

/datum/reagent/consumable/ethanol/bilk
	name = "Bilk"
	description = "Parece ser cerveja misturada com leite. Nojento."
	color = "#895C4C" // rgb: 137, 92, 76
	nutriment_factor = 2
	boozepwr = 15
	taste_description = "Desespero e lactato"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bilk/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.get_brute_loss() && SPT_PROB(5, seconds_per_tick))
		if(drinker.heal_bodypart_damage(brute = 1 * metabolization_ratio, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/threemileisland
	name = "Three Mile Island Iced Tea"
	description = "Feito para uma mulher, forte o suficiente para um homem."
	color = "#666340" // rgb: 102, 99, 64
	boozepwr = 10
	quality = DRINK_FANTASTIC
	taste_description = "dryness"
	ph = 3.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/threemileisland/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_drugginess(100 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/ethanol/gin
	name = "Gin"
	description = "É gin. No espaço. Eu digo, bom senhor."
	color = "#d8e8f0" // rgb: 216,232,240
	boozepwr = 45
	taste_description = "Uma árvore de Natal alcoólica."
	ph = 6.9
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/rum
	name = "Rum"
	description = "Yohoho e tudo mais."
	color = "#c9c07e" // rgb: 201,192,126
	boozepwr = 60
	taste_description = "Manteiga crocante."
	ph = 6.5
	default_container = /obj/item/reagent_containers/cup/glass/bottle/rum
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/rum/aged
	name = "Aged Rum"
	description = "Afundem-me! Isso é um rum chique para dividir com buchos."
	color = "#c0b675" // rgb: 192,183,117
	boozepwr = 70
	taste_description = "Biscoito extra-espigado"
	default_container = /obj/item/reagent_containers/cup/glass/bottle/rum/aged
	quality = DRINK_FANTASTIC
	metabolized_traits = list(TRAIT_STRONG_STOMACH)

/datum/reagent/consumable/ethanol/rum/aged/on_mob_metabolize(mob/living/drinker)
	. = ..()
	drinker.add_blocked_language(subtypesof(/datum/language) - /datum/language/piratespeak, source = LANGUAGE_DRINK)
	drinker.grant_language(/datum/language/piratespeak, source = LANGUAGE_DRINK)

/datum/reagent/consumable/ethanol/rum/aged/on_mob_end_metabolize(mob/living/drinker)
	if(!QDELING(drinker))
		drinker.remove_blocked_language(subtypesof(/datum/language), source = LANGUAGE_DRINK)
		drinker.remove_language(/datum/language/piratespeak, source = LANGUAGE_DRINK)
	return ..()

/datum/reagent/consumable/ethanol/tequila
	name = "Tequila"
	description = "Um forte e levemente aromatizado espírito mexicano produzido. Está com sede, hombre?"
	color = "#FFFF91" // rgb: 255, 255, 145
	boozepwr = 70
	taste_description = "stripper de pintura"
	ph = 4
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/vermouth
	name = "Vermouth"
	description = "Você de repente sente um desejo de um martini..."
	color = "#91FF91" // rgb: 145, 255, 145
	boozepwr = 45
	taste_description = "Álcool seco"
	ph = 3.25
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/wine
	name = "Wine"
	description = "Uma bebida alcoólica premium feita de suco de uva destilada."
	color = "#7E4043" // rgb: 126, 64, 67
	boozepwr = 35
	taste_description = "Doce amargo."
	ph = 3.45
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK
	default_container = /obj/item/reagent_containers/cup/glass/bottle/wine

/datum/reagent/consumable/ethanol/wine/on_merge(list/mix_data, amount)
	. = ..()
	if(data && mix_data && data["vintage"] != mix_data["vintage"])
		data["vintage"] = "mixed wine"

/datum/reagent/consumable/ethanol/wine/get_taste_description(mob/living/taster)
	if(HAS_TRAIT(taster,TRAIT_WINE_TASTER))
		if(data && data["vintage"])
			return list("[data["vintage"]]" = 1)
		else
			return list("synthetic wine"=1)
	return ..()

/datum/reagent/consumable/ethanol/lizardwine
	name = "Lizard Wine"
	description = "Uma bebida alcoólica da China Espacial, feita por infundir caudas de lagarto em etanol."
	color = "#7E4043" // rgb: 126, 64, 67
	boozepwr = 45
	quality = DRINK_FANTASTIC
	taste_description = "Doçura escamosa"
	ph = 3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/grappa
	name = "Grappa"
	description = "Um bom conhaque italiano, para quando vinho normal não é alcoólico o suficiente para você."
	color = "#F8EBF1"
	boozepwr = 60
	taste_description = "Doce amargo elegante"
	ph = 3.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/amaretto
	name = "Amaretto"
	description = "Uma bebida suave que carrega um aroma doce."
	color = "#E17600"
	boozepwr = 25
	taste_description = "Doce frutado e noz"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/cognac
	name = "Cognac"
	description = "Uma bebida doce e fortemente alcoólica, feita após inúmeras destilações e anos de maturação. Com classe como fornicação."
	color = "#AB3C05" // rgb: 171, 60, 5
	boozepwr = 75
	taste_description = "Suave e francês."
	ph = 3.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/absinthe
	name = "Absinthe"
	description = "Uma bebida alcoólica poderosa. Rumores de causar alucinações, mas não."
	color = rgb(10, 206, 0)
	boozepwr = 80 //Very strong even by default
	taste_description = "Morte e alcaçuz"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/absinthe/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(5, seconds_per_tick) && !HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE))
		drinker.adjust_hallucinations(8 SECONDS * metabolization_ratio)

/datum/reagent/consumable/ethanol/hooch
	name = "Hooch"
	description = "Ou o fracasso de alguém em fazer coquetel ou tentar produzir álcool. De qualquer forma, você realmente quer beber isso?"
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 100
	taste_description = "Demissão pura."
	addiction_types = list(/datum/addiction/maintenance_drugs = 600)
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/ale
	name = "Ale"
	description = "Uma bebida alcoólica escura feita com cevada malteada e levedura."
	color = "#976063" // rgb: 151,96,99
	boozepwr = 65
	taste_description = "cerveja de cevada"
	ph = 4.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/goldschlager
	name = "Goldschlager"
	description = "100 bebidas à prova de canela, feitas para adolescentes alcoólatras nas férias de primavera."
	color = "#FFFF91" // rgb: 255, 255, 145
	boozepwr = 25
	quality = DRINK_NICE
	taste_description = "Canela queimando"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

	// This drink is really popular with a certain demographic.
	var/teenage_girl_quality = DRINK_VERYGOOD

/datum/reagent/consumable/ethanol/goldschlager/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	// Reset quality each time, since the bottle can be shared
	quality = initial(quality)

	if(ishuman(exposed_mob))
		var/mob/living/carbon/human/human = exposed_mob
		// tgstation13 does not endorse underage drinking. laws may vary by your jurisdiction.
		if(human.age >= 13 && human.age <= 19 && human.gender == FEMALE)
			quality = teenage_girl_quality

	return ..()

/datum/reagent/consumable/ethanol/goldschlager/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return

	var/convert_amount = reac_volume * min(GOLDSCHLAGER_GOLD_RATIO, 1)
	var/datum/reagents/mob_reagents = exposed_mob.reagents

	mob_reagents.remove_reagent(/datum/reagent/consumable/ethanol/goldschlager, convert_amount)
	mob_reagents.add_reagent(/datum/reagent/gold, convert_amount)

/datum/reagent/consumable/ethanol/patron
	name = "Patron"
	description = "Tequila com prata, uma favorita de mulheres alcoólatras na cena do clube."
	color = "#585840" // rgb: 88, 88, 64
	boozepwr = 60
	quality = DRINK_VERYGOOD
	taste_description = "metálico e caro."
	ph = 4.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_HIGH

/datum/reagent/consumable/ethanol/gintonic
	name = "Gin and Tonic"
	description = "Um clássico de todos os tempos, coquetel suave."
	color = "#cae7ec" // rgb: 202,231,236
	boozepwr = 25
	quality = DRINK_NICE
	taste_description = "suave e torta."
	ph = 3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/rum_coke
	name = "Rum and Coke"
	description = "Rum, misturado com cola."
	taste_description = "cola"
	boozepwr = 40
	quality = DRINK_NICE
	color = "#3E1B00"
	ph = 4
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/cuba_libre
	name = "Cuba Libre"
	description = "Viva a Revolução! Viva Cuba Libre!"
	color = "#3E1B00" // rgb: 62, 27, 0
	boozepwr = 50
	quality = DRINK_GOOD
	taste_description = "Um casamento refrescante de citrinos e rum."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/cuba_libre/on_mob_life(mob/living/carbon/cubano, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	if(cubano.mind && cubano.mind.has_antag_datum(/datum/antagonist/rev)) //Cuba Libre, the traditional drink of revolutions! Heals revolutionaries.
		need_mob_update = cubano.adjust_brute_loss(-1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += cubano.adjust_fire_loss(-1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += cubano.adjust_tox_loss(-1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += cubano.adjust_oxy_loss(-5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype, required_respiration_type = affected_respiration_type)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/whiskey_cola
	name = "Whiskey Cola"
	description = "Uísque, misturado com cola. Surpreendentemente refrescante."
	color = "#3E1B00" // rgb: 62, 27, 0
	boozepwr = 70
	quality = DRINK_NICE
	taste_description = "cola"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/martini
	name = "Classic Martini"
	description = "Vermute com Gin. Não exatamente como 007 gostou, mas ainda delicioso."
	color = "#cddbac" // rgb: 205,219,172
	boozepwr = 60
	quality = DRINK_NICE
	taste_description = "Classe seca"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/vodkamartini
	name = "Vodka Martini"
	description = "Vodka com Gin. Não exatamente como 007 gostou, mas ainda delicioso."
	color = "#cddcad" // rgb: 205,220,173
	boozepwr = 65
	quality = DRINK_NICE
	taste_description = "sacudido, não agitado"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS


/datum/reagent/consumable/ethanol/white_russian
	name = "White Russian"
	description = "Essa é a sua opinião, cara..."
	color = "#A68340" // rgb: 166, 131, 64
	boozepwr = 50
	quality = DRINK_GOOD
	taste_description = "Creme amargo"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/screwdrivercocktail
	name = "Screwdriver"
	description = "Vodka, misturada com suco de laranja. O resultado é surpreendentemente delicioso."
	color = "#A68310" // rgb: 166, 131, 16
	boozepwr = 55
	quality = DRINK_NICE
	taste_description = "oranges"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/screwdrivercocktail/on_new(data)
	. = ..()
	// We want to turn only base drinking glasses with screwdriver(cocktail) into screwdrivers(tool),
	// but we can't check style so we have to check type, and we don't want it match subtypes like istype does
	if(holder?.my_atom && holder.my_atom.type == /obj/item/reagent_containers/cup/glass/drinkingglass/)
		RegisterSignal(holder, COMSIG_REAGENTS_HOLDER_UPDATED, PROC_REF(on_reagent_change))
		if(src == holder.get_master_reagent())
			var/obj/item/reagent_containers/cup/glass/drinkingglass/drink = holder.my_atom
			drink.tool_behaviour = TOOL_SCREWDRIVER
			drink.usesound = list('sound/items/tools/screwdriver.ogg', 'sound/items/tools/screwdriver2.ogg')

/datum/reagent/consumable/ethanol/screwdrivercocktail/Destroy()
	var/obj/item/reagent_containers/cup/glass/drinkingglass/drink = holder.my_atom
	if(istype(drink))
		if(drink.tool_behaviour == TOOL_SCREWDRIVER)
			drink.tool_behaviour = initial(drink.tool_behaviour)
			drink.usesound = initial(drink.usesound)
		UnregisterSignal(holder, COMSIG_REAGENTS_HOLDER_UPDATED)
	return ..()

/datum/reagent/consumable/ethanol/screwdrivercocktail/proc/on_reagent_change(datum/reagents/reagents)
	SIGNAL_HANDLER
	var/obj/item/reagent_containers/cup/glass/drinkingglass/drink = reagents.my_atom
	if(reagents.get_master_reagent() == src)
		drink.tool_behaviour = TOOL_SCREWDRIVER
		drink.usesound = list('sound/items/tools/screwdriver.ogg', 'sound/items/tools/screwdriver2.ogg')
	else
		drink.tool_behaviour = initial(drink.tool_behaviour)
		drink.usesound = initial(drink.usesound)

/datum/reagent/consumable/ethanol/screwdrivercocktail/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	if(HAS_TRAIT(liver, TRAIT_ENGINEER_METABOLISM))
		ADD_TRAIT(drinker, TRAIT_HALT_RADIATION_EFFECTS, "[type]")
		if (HAS_TRAIT(drinker, TRAIT_IRRADIATED))
			if(drinker.adjust_tox_loss(-2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
				return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/screwdrivercocktail/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	REMOVE_TRAIT(drinker, TRAIT_HALT_RADIATION_EFFECTS, "[type]")

/datum/reagent/consumable/ethanol/booger
	name = "Booger"
	description = "Ewww..."
	color = "#8CFF8C" // rgb: 140, 255, 140
	boozepwr = 45
	taste_description = "Doce e cremoso"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bloody_mary
	name = "Bloody Mary"
	description = "Uma estranha, mas agradável mistura feita de vodka, tomate e suco de limão. Ou pelo menos você acha que a coisa vermelha é suco de tomate."
	color = "#bf707c" // rgb: 191,112,124
	boozepwr = 55
	quality = DRINK_GOOD
	taste_description = "tomates com um toque de limão e assassinato líquido"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bloody_mary/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_blood_volume((0.25 + round(2 * drinker.get_drunk_amount() / 40, 0.1)) * metabolization_ratio * seconds_per_tick, maximum = BLOOD_VOLUME_NORMAL) // Bloody Mary restores blood loss based on how drunk you are

/datum/reagent/consumable/ethanol/brave_bull
	name = "Brave Bull"
	description = "É tão eficaz quanto a Coragem Holandesa!"
	color = "#a79f98" // rgb: 167,159,152
	boozepwr = 60
	quality = DRINK_NICE
	taste_description = "bravura alcoólica."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY
	metabolized_traits = list(TRAIT_FEARLESS, TRAIT_ANALGESIA)
	var/tough_text

/datum/reagent/consumable/ethanol/brave_bull/on_mob_metabolize(mob/living/drinker)
	. = ..()
	tough_text = pick("brawny", "tenacious", "tough", "hardy", "sturdy") //Tuff stuff
	to_chat(drinker, span_notice("Você sente [tough_text]!"))
	drinker.maxHealth += 10 //Brave Bull makes you sturdier, and thus capable of withstanding a tiny bit more punishment.
	drinker.health += 10

/datum/reagent/consumable/ethanol/brave_bull/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	to_chat(drinker, span_notice("Você não sente mais [tough_text]."))
	drinker.maxHealth -= 10
	drinker.health = min(drinker.health - 10, drinker.maxHealth) //This can indeed crit you if you're alive solely based on alchol ingestion

/datum/reagent/consumable/ethanol/tequila_sunrise
	name = "Tequila Sunrise"
	description = "Tequila, Grenadine e Suco de Laranja."
	color = "#FFE48C" // rgb: 255, 228, 140
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "laranjas com uma pitada de romã"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM
	var/obj/effect/light_holder

/datum/reagent/consumable/ethanol/tequila_sunrise/on_mob_metabolize(mob/living/drinker)
	. = ..()
	to_chat(drinker, span_notice("Você sente um calor suave espalhado pelo seu corpo!"))
	light_holder = new(drinker)
	light_holder.set_light(3, 0.7, COLOR_TANGERINE_YELLOW) //Tequila Sunrise makes you radiate dim light, like a sunrise!

/datum/reagent/consumable/ethanol/tequila_sunrise/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	if(QDELETED(light_holder))
		holder.del_reagent(type) //If we lost our light object somehow, remove the reagent
	else if(light_holder.loc != drinker)
		light_holder.forceMove(drinker)
	return ..()

/datum/reagent/consumable/ethanol/tequila_sunrise/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	to_chat(drinker, span_notice("O calor em seu corpo desaparece."))
	QDEL_NULL(light_holder)

/datum/reagent/consumable/ethanol/toxins_special
	name = "Toxins Special"
	description = "Essa coisa está em fogo! Chame a maldita cabana!"
	color = "#8880a8" // rgb: 136,128,168
	boozepwr = 25
	quality = DRINK_VERYGOOD
	taste_description = "Toxinas picantes."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/toxins_special/on_mob_life(mob/living/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_bodytemperature(15 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, drinker.get_body_temp_normal() + 20) //310.15 is the normal bodytemp.

/datum/reagent/consumable/ethanol/beepsky_smash
	name = "Beepsky Smash"
	description = "Beba isso e prepare-se para a lei."
	color = COLOR_OLIVE // rgb: 128,128,0
	boozepwr = 60 //THE FIST OF THE LAW IS STRONG AND HARD
	quality = DRINK_GOOD
	metabolization_rate = 1.25 * REAGENTS_METABOLISM
	taste_description = "JUSTICE"
	overdose_threshold = 40
	ph = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/datum/brain_trauma/special/beepsky/beepsky_hallucination

/datum/reagent/consumable/ethanol/beepsky_smash/on_mob_metabolize(mob/living/carbon/drinker)
	. = ..()
	if(HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE))
		metabolization_rate = 4 * REAGENTS_METABOLISM
	// if you don't have a liver, or your liver isn't an officer's liver
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	if(!liver || !HAS_TRAIT(liver, TRAIT_LAW_ENFORCEMENT_METABOLISM))
		beepsky_hallucination = new()
		drinker.gain_trauma(beepsky_hallucination, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/reagent/consumable/ethanol/beepsky_smash/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_jitter_if_lower(4 SECONDS)
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	// if you have a liver and that liver is an officer's liver
	if(liver && HAS_TRAIT(liver, TRAIT_LAW_ENFORCEMENT_METABOLISM))
		if(drinker.adjust_stamina_loss(-4 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype))
			. = UPDATE_MOB_HEALTH
		if(SPT_PROB(10, seconds_per_tick))
			drinker.cause_hallucination(get_random_valid_hallucination_subtype(/datum/hallucination/nearby_fake_item), name)
		if(SPT_PROB(5, seconds_per_tick))
			drinker.cause_hallucination(/datum/hallucination/stray_bullet, name)

/datum/reagent/consumable/ethanol/beepsky_smash/on_mob_end_metabolize(mob/living/carbon/drinker)
	. = ..()
	if(beepsky_hallucination)
		QDEL_NULL(beepsky_hallucination)

/datum/reagent/consumable/ethanol/beepsky_smash/overdose_start(mob/living/carbon/drinker, metabolization_ratio)
	. = ..()
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	// if you don't have a liver, or your liver isn't an officer's liver
	if(!liver || !HAS_TRAIT(liver, TRAIT_LAW_ENFORCEMENT_METABOLISM))
		drinker.gain_trauma(/datum/brain_trauma/mild/phobia/security, TRAUMA_RESILIENCE_BASIC)

/datum/reagent/consumable/ethanol/irish_cream
	name = "Irish Cream"
	description = "Creme de uísque, o que mais você esperaria dos irlandeses?"
	color = "#e3d0b2" // rgb: 227,208,178
	boozepwr = 50
	quality = DRINK_NICE
	taste_description = "Álcool cremoso."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/manly_dorf
	name = "The Manly Dorf"
	description = "Cerveja e Ale, juntos em uma deliciosa mistura. Destinado apenas para homens de verdade."
	color = "#815336" // rgb: 129,83,54
	boozepwr = 100 //For the manly only
	quality = DRINK_NICE
	taste_description = "cabelo no peito e queixo"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/dorf_mode = FALSE

/datum/reagent/consumable/ethanol/manly_dorf/on_mob_metabolize(mob/living/drinker)
	. = ..()
	if(ishuman(drinker))
		var/mob/living/carbon/human/potential_dwarf = drinker
		if(HAS_TRAIT(potential_dwarf, TRAIT_DWARF))
			to_chat(potential_dwarf, span_notice("Agora isso é masculino!"))
			boozepwr = 50 // will still smash but not as much.
			dorf_mode = TRUE

/datum/reagent/consumable/ethanol/manly_dorf/on_mob_life(mob/living/carbon/dwarf, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(dorf_mode)
		var/need_mob_update
		need_mob_update = dwarf.adjust_brute_loss(-2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += dwarf.adjust_fire_loss(-2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		if(need_mob_update)
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/longislandicedtea
	name = "Long Island Iced Tea"
	description = "O armário de bebidas, reunido em uma deliciosa mistura. Destinado apenas para mulheres alcoólatras de meia-idade."
	color = "#ff6633" // rgb: 255,102,51
	boozepwr = 35
	quality = DRINK_VERYGOOD
	taste_description = "Uma mistura de cola e álcool."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/moonshine
	name = "Moonshine"
	description = "Você realmente atingiu o fundo do poço agora... seu fígado fez as malas e saiu ontem à noite."
	color = "#AAAAAA77" // rgb: 170, 170, 170, 77 (alpha) (like water)
	boozepwr = 95
	taste_description = "bitterness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/b52
	name = "B-52"
	description = "Café, creme irlandês e conhaque. Você vai ser bombardeado."
	color = "#8f1733" // rgb: 143,23,51
	boozepwr = 85
	quality = DRINK_GOOD
	taste_description = "Irritada e irlandesa."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/b52/on_mob_metabolize(mob/living/drinker)
	. = ..()
	playsound(drinker, 'sound/effects/explosion/explosion_distant.ogg', 100, FALSE)

/datum/reagent/consumable/ethanol/irishcoffee
	name = "Irish Coffee"
	description = "Café e álcool. Mais divertido do que uma Mimosa para beber de manhã."
	color = "#874010" // rgb: 135,64,16
	boozepwr = 35
	quality = DRINK_NICE
	taste_description = "Desistir do dia"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/ethanol/margarita
	name = "Margarita"
	description = "Nas pedras com sal na borda. Arriba!"
	color = "#8CFF8C" // rgb: 140, 255, 140
	boozepwr = 35
	quality = DRINK_NICE
	taste_description = "seco e salgado"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/black_russian
	name = "Black Russian"
	description = "Para o intolerante à lactose. Ainda com classe como um russo branco."
	color = "#360000" // rgb: 54, 0, 0
	boozepwr = 70
	quality = DRINK_NICE
	taste_description = "bitterness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/manhattan
	name = "Manhattan"
	description = "A bebida secreta do detetive. Ele nunca conseguiu gin estomacal..."
	color = "#ff3300" // rgb: 255,51,0
	boozepwr = 30
	quality = DRINK_NICE
	taste_description = "Secura suave"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/manhattan_proj
	name = "Manhattan Project"
	description = "Uma bebida de escolha de um cientista, por ponderar maneiras de explodir a estação."
	color = COLOR_MOSTLY_PURE_RED
	boozepwr = 45
	quality = DRINK_VERYGOOD
	taste_description = "A morte, o destruidor de mundos"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/manhattan_proj/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_drugginess(1 MINUTES * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/ethanol/whiskeysoda
	name = "Whiskey Soda"
	description = "Para o griffon mais refinado."
	color = "#ffcc33" // rgb: 255,204,51
	boozepwr = 70
	quality = DRINK_NICE
	taste_description = "soda"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/antifreeze
	name = "Anti-freeze"
	description = "O melhor refresco. Não é o que parece."
	color = "#30f0f8" // rgb: 48,240,248
	boozepwr = 35
	quality = DRINK_NICE
	taste_description = "Mijo de Jack Frost"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/antifreeze/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_bodytemperature(20 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, drinker.get_body_temp_normal() + 20) //310.15 is the normal bodytemp.

/datum/reagent/consumable/ethanol/barefoot
	name = "Barefoot"
	description = "Descalço e grávida."
	color = "#fc5acc" // rgb: 252,90,204
	boozepwr = 45
	quality = DRINK_VERYGOOD
	taste_description = "Bagas cremosas"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/barefoot/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(ishuman(drinker)) //Barefoot causes the imbiber to quickly regenerate brute trauma if they're not wearing shoes.
		var/mob/living/carbon/human/unshoed = drinker
		if(!unshoed.shoes)
			if(unshoed.adjust_brute_loss(-3 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype))
				return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/snowwhite
	name = "Snow White"
	description = "Um refresco frio."
	color = COLOR_WHITE // rgb: 255, 255, 255
	boozepwr = 35
	quality = DRINK_NICE
	taste_description = "frio refrescante"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/demonsblood
	name = "Demon's Blood"
	description = "AHHHH!!!"
	color = "#820000" // rgb: 130, 0, 0
	boozepwr = 75
	quality = DRINK_VERYGOOD
	taste_description = "Doce degustação de ferro"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/ethanol/demonsblood/on_mob_metabolize(mob/living/metabolizer)
	. = ..()
	RegisterSignal(metabolizer, COMSIG_LIVING_BLOOD_CRAWL_PRE_CONSUMED, PROC_REF(pre_bloodcrawl_consumed))

/datum/reagent/consumable/ethanol/demonsblood/on_mob_end_metabolize(mob/living/metabolizer)
	. = ..()
	UnregisterSignal(metabolizer, COMSIG_LIVING_BLOOD_CRAWL_PRE_CONSUMED)

/// Prevents the imbiber from being dragged into a pool of blood by a slaughter demon.
/datum/reagent/consumable/ethanol/demonsblood/proc/pre_bloodcrawl_consumed(
	mob/living/source,
	datum/action/cooldown/spell/jaunt/bloodcrawl/crawl,
	mob/living/jaunter,
	obj/effect/decal/cleanable/blood,
)

	SIGNAL_HANDLER

	var/turf/jaunt_turf = get_turf(jaunter)
	jaunt_turf.visible_message(
		span_warning("Algo impede [source] De entrar [blood]!"),
		blind_message = span_notice("Você ouve um barulho e um barulho.")
	)
	to_chat(jaunter, span_warning("Uma força estranha está bloqueando [source] De entrar!"))

	return COMPONENT_STOP_CONSUMPTION

/datum/reagent/consumable/ethanol/devilskiss
	name = "Devil's Kiss"
	description = "Tempo assustador!"
	color = "#A68310" // rgb: 166, 131, 16
	boozepwr = 70
	quality = DRINK_VERYGOOD
	taste_description = "Ferro amargo."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/devilskiss/on_mob_metabolize(mob/living/metabolizer)
	. = ..()
	RegisterSignal(metabolizer, COMSIG_LIVING_BLOOD_CRAWL_CONSUMED, PROC_REF(on_bloodcrawl_consumed))

/datum/reagent/consumable/ethanol/devilskiss/on_mob_end_metabolize(mob/living/metabolizer)
	. = ..()
	UnregisterSignal(metabolizer, COMSIG_LIVING_BLOOD_CRAWL_CONSUMED)

/// If eaten by a slaughter demon, the demon will regret it.
/datum/reagent/consumable/ethanol/devilskiss/proc/on_bloodcrawl_consumed(
	mob/living/source,
	datum/action/cooldown/spell/jaunt/bloodcrawl/crawl,
	mob/living/jaunter,
)

	SIGNAL_HANDLER

	. = COMPONENT_STOP_CONSUMPTION

	to_chat(jaunter, span_boldwarning("AAH! A carne deles! Ele explode!"))
	jaunter.apply_damage(25, BRUTE, wound_bonus = CANT_WOUND)

	for(var/obj/effect/decal/cleanable/nearby_blood in range(1, get_turf(source)))
		if(!nearby_blood.can_bloodcrawl_in())
			continue
		source.forceMove(get_turf(nearby_blood))
		source.visible_message(span_warning("[nearby_blood] violentamente expulsa [source]!"))
		crawl.exit_blood_effect(source)
		return

	// Fuck it, just eject them, thanks to some split second cleaning
	source.forceMove(get_turf(source))
	source.visible_message(span_warning("[source] aparece do nada, coberto de sangue!"))
	crawl.exit_blood_effect(source)

/datum/reagent/consumable/ethanol/vodkatonic
	name = "Vodka and Tonic"
	description = "Para quando um gin tônico não é russo o suficiente."
	color = "#0064C8" // rgb: 0, 100, 200
	boozepwr = 70
	quality = DRINK_NICE
	taste_description = "Azedo amargo"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/ginfizz
	name = "Gin Fizz"
	description = "Limonada refrescante, deliciosamente seca."
	color = "#ffffcc" // rgb: 255,255,204
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "Limões secos e azedos."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bahama_mama
	name = "Bahama Mama"
	description = "Um coquetel tropical com uma mistura complexa de sabores."
	color = "#FF7F3B" // rgb: 255, 127, 59
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "abacaxi, coco, e uma pitada de café"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/singulo
	name = "Singulo"
	description = "Uma bebida do espaço azul!"
	color = "#2E6671" // rgb: 46, 102, 113
	boozepwr = 35
	quality = DRINK_VERYGOOD
	taste_description = "matéria concentrada"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_MADNESS_IMMUNE)
	var/static/list/ray_filter = list(type = "rays", size = 40, density = 15, color = SUPERMATTER_SINGULARITY_RAYS_COLOUR, factor = 15)

/datum/reagent/consumable/ethanol/singulo/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	drinker.remove_filter("singulo_rays")

/datum/reagent/consumable/ethanol/singulo/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(2.5, seconds_per_tick))
		// 20u = 1x1, 45u = 2x2, 80u = 3x3
		var/volume_to_radius = FLOOR(sqrt(volume/3), 1) - 1 // BUBBER EDIT CHANGE - Original: volume/5
		var/suck_range = clamp(volume_to_radius, 0, 3)

		if(!suck_range)
			return ..()

		var/turf/gravity_well_turf = get_turf(drinker)
		goonchem_vortex(gravity_well_turf, 0, suck_range)
		playsound(get_turf(drinker), 'sound/effects/supermatter.ogg', 150, TRUE)
		drinker.add_filter("singulo_rays", 1, ray_filter)
		animate(drinker.get_filter("singulo_rays"), offset = 10, time = 1.5 SECONDS, loop = -1)
		addtimer(CALLBACK(drinker, TYPE_PROC_REF(/datum, remove_filter), "singulo_rays"), 1.5 SECONDS)
		drinker.emote("burp")

/datum/reagent/consumable/ethanol/sbiten
	name = "Sbiten"
	description = "Uma vodca picante! Pode ser um pouco quente para os meninos!"
	color = "#d8d5ae" // rgb: 216,213,174
	boozepwr = 70
	quality = DRINK_GOOD
	taste_description = "Quente e picante."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/sbiten/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_bodytemperature(50 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, BODYTEMP_HEAT_DAMAGE_LIMIT) //310.15 is the normal bodytemp.

/datum/reagent/consumable/ethanol/red_mead
	name = "Red Mead"
	description = "A verdadeira bebida Viking! Mesmo que tenha uma cor vermelha estranha."
	color = "#C73C00" // rgb: 199, 60, 0
	boozepwr = 31 //Red drinks are stronger
	quality = DRINK_GOOD
	taste_description = "Álcool doce e salgado"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/mead
	name = "Mead"
	description = "Uma bebida Viking, embora barata."
	color = "#e0c058" // rgb: 224,192,88
	nutriment_factor = 1
	boozepwr = 30
	quality = DRINK_NICE
	taste_description = "Doce, doce álcool"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/iced_beer
	name = "Iced Beer"
	description = "Uma cerveja que é tão fria que o ar ao redor congela."
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 15
	taste_description = "refrescantemente frio"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/iced_beer/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_bodytemperature(-20 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, T0C) //310.15 is the normal bodytemp.

/datum/reagent/consumable/ethanol/grog
	name = "Grog"
	description = "Rum regado, Nanotrasen aprova!"
	color = "#e0e058" // rgb: 224,224,88
	boozepwr = 1 //Basically nothing
	taste_description = "Uma desculpa pobre para o álcool."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/aloe
	name = "Aloe"
	description = "Muito, muito, muito bom."
	color = "#f8f800" // rgb: 248,248,0
	boozepwr = 35
	quality = DRINK_VERYGOOD
	taste_description = "Doce e cremoso"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	//somewhat annoying mix
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/andalusia
	name = "Andalusia"
	description = "Uma bebida bonita, estranhamente chamada."
	color = "#c8f860" // rgb: 200,248,96
	boozepwr = 40
	quality = DRINK_GOOD
	taste_description = "lemons"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/alliescocktail
	name = "Allies Cocktail"
	description = "Uma bebida feita de seus aliados. Não tão doces como os feitos de seus inimigos."
	color = "#60f8f8" // rgb: 96,248,248
	boozepwr = 45
	quality = DRINK_NICE
	taste_description = "amargo mas livre"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/acid_spit
	name = "Acid Spit"
	description = "Uma bebida para a ousadia, pode ser mortal se incorretamente preparada!"
	color = "#365000" // rgb: 54, 80, 0
	boozepwr = 70
	quality = DRINK_VERYGOOD
	taste_description = "ácido estomacal"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/amasec
	name = "Amasec"
	description = "Bebida oficial do Clube de Armas Nanotrasen!"
	color = "#e0e058" // rgb: 224,224,88
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "escuro e metálico"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/changelingsting
	name = "Changeling Sting"
	description = "Você toma um pequeno gole e sente uma sensação de queimação..."
	color = "#2E6671" // rgb: 46, 102, 113
	boozepwr = 50
	quality = DRINK_GOOD
	taste_description = "Seu cérebro saindo do nariz."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/changelingsting/on_mob_life(mob/living/carbon/target, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(target)
	changeling?.adjust_chemicals(metabolization_rate * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/ethanol/irishcarbomb
	name = "Irish Car Bomb"
	description = "Mmm, tem gosto de estado livre irlandês."
	color = "#2E6671" // rgb: 46, 102, 113
	boozepwr = 25
	quality = DRINK_GOOD
	taste_description = "O espírito da Irlanda"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/syndicatebomb
	name = "Syndicate Bomb"
	description = "Tem gosto de terrorismo!"
	color = "#2E6671" // rgb: 46, 102, 113
	boozepwr = 90
	quality = DRINK_GOOD
	taste_description = "Antagonismo purificado"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/syndicatebomb/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(2.5, seconds_per_tick))
		playsound(get_turf(drinker), 'sound/effects/explosion/explosionfar.ogg', 100, TRUE)

/datum/reagent/consumable/ethanol/hiveminderaser
	name = "Hivemind Eraser"
	description = "Um recipiente de sabor puro."
	color = "#FF80FC" // rgb: 255, 128, 252
	boozepwr = 40
	quality = DRINK_GOOD
	taste_description = "ligações psíquicas"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/erikasurprise
	name = "Erika Surprise"
	description = "A surpresa é que é verde!"
	color = "#2E6671" // rgb: 46, 102, 113
	boozepwr = 35
	quality = DRINK_VERYGOOD
	taste_description = "Tartness e bananas"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/driestmartini
	name = "Driest Martini"
	description = "Só para os experientes. Acha que vê areia flutuando no vidro."
	nutriment_factor = 1
	color = "#2E6671" // rgb: 46, 102, 113
	boozepwr = 65
	quality = DRINK_GOOD
	taste_description = "Uma praia"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bananahonk
	name = "Banana Honk"
	description = "Uma bebida do Céu dos Palhaços."
	nutriment_factor = 1
	color = "#FFFF91" // rgb: 255, 255, 140
	boozepwr = 60
	quality = DRINK_GOOD
	taste_description = "Uma piada ruim."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bananahonk/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	if((liver && HAS_TRAIT(liver, TRAIT_COMEDY_METABOLISM)) || is_simian(drinker))
		var/heal = 1 * metabolization_ratio * seconds_per_tick
		if(drinker.heal_bodypart_damage(brute = heal, burn = heal, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/silencer
	name = "Silencer"
	description = "Uma bebida do paraíso Mime."
	nutriment_factor = 2
	color = "#a8a8a8" // rgb: 168,168,168
	boozepwr = 59 //Proof that clowns are better than mimes right here
	quality = DRINK_GOOD
	taste_description = "Uma borracha de lápis"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/silencer/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(ishuman(drinker) && HAS_MIND_TRAIT(drinker, TRAIT_MIMING))
		drinker.set_silence_if_lower(MIMEDRINK_SILENCE_DURATION)
		var/heal = 1 * metabolization_ratio * seconds_per_tick
		if(drinker.heal_bodypart_damage(brute = heal, burn = heal, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/drunkenblumpkin
	name = "Drunken Blumpkin"
	description = "Uma mistura estranha de uísque e suco de abóbora."
	color = "#1EA0FF" // rgb: 30,160,255
	boozepwr = 50
	quality = DRINK_VERYGOOD
	taste_description = "Melaço e uma boca cheia de água da piscina"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/whiskey_sour //Requested since we had whiskey cola and soda but not sour.
	name = "Whiskey Sour"
	description = "Suco de limão, uísque e açúcar. Teor alcoólico moderado."
	color = rgb(255, 201, 49)
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "Limões azedos"

/datum/reagent/consumable/ethanol/hcider
	name = "Hard Cider"
	description = "Suco de maçã, para adultos."
	color = "#CD6839"
	nutriment_factor = 1
	boozepwr = 25
	taste_description = "a estação que<i>Quedas</i>entre verão e inverno"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/fetching_fizz //A reference to one of my favorite games of all time. Pulls nearby ores to the imbiber!
	name = "Fetching Fizz"
	description = "Mistura de uísque azedo/ferro/urânio resultando em uma pasta altamente magnética. Teor alcoólico leve." //Requires no alcohol to make but has alcohol anyway because ~magic~
	color = rgb(255, 91, 15)
	boozepwr = 10
	quality = DRINK_VERYGOOD
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	taste_description = "Metal carregado" // the same as teslium, honk honk.
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/fetching_fizz/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/turf/drinker_turf = get_turf(drinker)
	for(var/obj/item/stack/ore/ore in orange(3, drinker))
		step_towards(ore, drinker_turf)

//Another reference. Heals those in critical condition extremely quickly.
/datum/reagent/consumable/ethanol/hearty_punch
	name = "Hearty Punch"
	description = "Bravo touro/sindicato bomba/absinado mistura resultando em uma bebida energizante. Teor alcoólico leve."
	color = rgb(140, 0, 0)
	boozepwr = 90
	quality = DRINK_VERYGOOD
	metabolization_rate = 0.4 * REAGENTS_METABOLISM
	taste_description = "Bravo diante do desastre."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/hearty_punch/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.health <= 0)
		var/need_mob_update
		need_mob_update = drinker.adjust_brute_loss(-3.75 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += drinker.adjust_fire_loss(-3.75 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += drinker.adjust_oxy_loss(-5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype, required_respiration_type = affected_respiration_type)
		need_mob_update += drinker.adjust_tox_loss(-3.75 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		if(need_mob_update)
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/bacchus_blessing //An EXTREMELY powerful drink. Smashed in seconds, dead in minutes.
	name = "Bacchus' Blessing"
	description = "Mistura não identificável. Inacreditavelmente alto teor de álcool."
	color = rgb(51, 19, 3) //Sickly brown
	boozepwr = 300 //I warned you
	taste_description = "Uma parede de tijolos"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/atomicbomb
	name = "Atomic Bomb"
	description = "Proliferação nuclear nunca foi tão bom."
	color = "#666300" // rgb: 102, 99, 0
	boozepwr = 0 //custom drunk effect
	quality = DRINK_FANTASTIC
	taste_description = "Da bomba"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_HIGH

/datum/reagent/consumable/ethanol/atomicbomb/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_drugginess(100 SECONDS * metabolization_ratio * seconds_per_tick)
	if(!HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE))
		drinker.adjust_confusion(2 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.set_dizzy_if_lower(20 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.adjust_slurring(6 SECONDS * metabolization_ratio * seconds_per_tick)
	switch(current_cycle)
		if(52 to 201)
			drinker.Sleeping(100 * metabolization_ratio * seconds_per_tick)
		if(202 to INFINITY)
			drinker.AdjustSleeping(4 SECONDS * metabolization_ratio * seconds_per_tick)
			if(drinker.adjust_tox_loss(2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
				return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/gargle_blaster
	name = "Pan-Galactic Gargle Blaster"
	description = "Nossa, essa coisa parece volátil!"
	color = "#9cc8b4" // rgb: 156,200,180
	boozepwr = 0 //custom drunk effect
	quality = DRINK_GOOD
	taste_description = "seu cérebro esmagado por um limão enrolado em torno de um tijolo de ouro"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/gargle_blaster/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_dizzy(3 SECONDS * metabolization_ratio * seconds_per_tick)
	switch(current_cycle)
		if(16 to 46)
			drinker.adjust_slurring(3 SECONDS * metabolization_ratio * seconds_per_tick)
		if(46 to 56)
			if(SPT_PROB(30, seconds_per_tick))
				drinker.adjust_confusion(3 SECONDS * metabolization_ratio)
		if(56 to 201)
			drinker.set_drugginess(110 SECONDS * metabolization_ratio * seconds_per_tick)
		if(201 to INFINITY)
			if(drinker.adjust_tox_loss(2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
				return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/neurotoxin
	name = "Neurotoxin"
	description = "Uma forte neurotoxina que coloca o paciente num estado de morte."
	color = "#2E2E61" // rgb: 46, 46, 97
	boozepwr = 50
	quality = DRINK_VERYGOOD
	taste_description = "uma sensação de dormência"
	metabolization_rate = REAGENTS_METABOLISM
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/neurotoxin/proc/pick_paralyzed_limb()
	return (pick(TRAIT_PARALYSIS_L_ARM,TRAIT_PARALYSIS_R_ARM,TRAIT_PARALYSIS_R_LEG,TRAIT_PARALYSIS_L_LEG))

/datum/reagent/consumable/ethanol/neurotoxin/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_drugginess(50 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.adjust_dizzy(2 SECONDS * metabolization_ratio * seconds_per_tick)
	var/need_mob_update
	need_mob_update = drinker.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.5 * metabolization_ratio * seconds_per_tick, 150, required_organ_flag = affected_organ_flags)
	if(SPT_PROB(10, seconds_per_tick))
		need_mob_update += drinker.adjust_stamina_loss(5 * metabolization_ratio, updating_stamina = FALSE, required_biotype = affected_biotype)
		drinker.drop_all_held_items()
		to_chat(drinker, span_notice("Você não pode sentir suas mãos!"))
	if(current_cycle > 6)
		if(SPT_PROB(10, seconds_per_tick))
			var/paralyzed_limb = pick_paralyzed_limb()
			ADD_TRAIT(drinker, paralyzed_limb, type)
			need_mob_update += drinker.adjust_stamina_loss(5 * metabolization_ratio, updating_stamina = FALSE, required_biotype = affected_biotype)
		if(current_cycle > 31)
			need_mob_update += drinker.adjust_organ_loss(ORGAN_SLOT_BRAIN, 1 * metabolization_ratio * seconds_per_tick, required_organ_flag = affected_organ_flags)
			if(current_cycle > 51 && SPT_PROB(7.5, seconds_per_tick))
				if(!drinker.undergoing_cardiac_arrest() && drinker.can_heartattack())
					drinker.set_heartattack(TRUE)
					if(drinker.stat == CONSCIOUS)
						drinker.visible_message(span_userdanger("[drinker] Embreagens em [drinker.p_their()] peito como se [drinker.p_their()] O coração parou!"))
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/neurotoxin/on_mob_end_metabolize(mob/living/carbon/drinker)
	. = ..()
	REMOVE_TRAIT(drinker, TRAIT_PARALYSIS_L_ARM, type)
	REMOVE_TRAIT(drinker, TRAIT_PARALYSIS_R_ARM, type)
	REMOVE_TRAIT(drinker, TRAIT_PARALYSIS_R_LEG, type)
	REMOVE_TRAIT(drinker, TRAIT_PARALYSIS_L_LEG, type)
	drinker.adjust_stamina_loss(10, required_biotype = affected_biotype)

/datum/reagent/consumable/ethanol/hippies_delight
	name = "Hippie's Delight"
	description = "Você não entende, Maaaan."
	color = "#b16e8b" // rgb: 177,110,139
	nutriment_factor = 0
	boozepwr = 0 //custom drunk effect
	quality = DRINK_FANTASTIC
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	taste_description = "Dando uma chance à paz"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/hippies_delight/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_slurring_if_lower(2.5 SECONDS * metabolization_ratio * seconds_per_tick)

	switch(current_cycle)
		if(2 to 6)
			drinker.set_dizzy_if_lower(50 SECONDS * metabolization_ratio * seconds_per_tick)
			drinker.set_drugginess(150 SECONDS * metabolization_ratio * seconds_per_tick)
			if(SPT_PROB(5, seconds_per_tick))
				drinker.emote(pick("twitch","giggle"))
		if(6 to 11)
			drinker.set_jitter_if_lower(100 SECONDS * metabolization_ratio * seconds_per_tick)
			drinker.set_dizzy_if_lower(100 SECONDS * metabolization_ratio * seconds_per_tick)
			drinker.set_drugginess(225 SECONDS * metabolization_ratio * seconds_per_tick)
			if(SPT_PROB(10, seconds_per_tick))
				drinker.emote(pick("twitch","giggle"))
		if (11 to 201)
			drinker.set_jitter_if_lower(200 SECONDS * metabolization_ratio * seconds_per_tick)
			drinker.set_dizzy_if_lower(200 SECONDS * metabolization_ratio * seconds_per_tick)
			drinker.set_drugginess(5 MINUTES * metabolization_ratio * seconds_per_tick)
			if(SPT_PROB(16, seconds_per_tick))
				drinker.emote(pick("twitch","giggle"))
		if(201 to INFINITY)
			drinker.set_jitter_if_lower(300 SECONDS * metabolization_ratio * seconds_per_tick)
			drinker.set_dizzy_if_lower(300 SECONDS * metabolization_ratio * seconds_per_tick)
			drinker.set_drugginess(6.25 MINUTES * metabolization_ratio * seconds_per_tick)
			if(SPT_PROB(23, seconds_per_tick))
				drinker.emote(pick("twitch","giggle"))
			if(SPT_PROB(16, seconds_per_tick))
				if(drinker.adjust_tox_loss(5 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
					return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/eggnog
	name = "Eggnog"
	description = "Por aproveitar a época mais maravilhosa do ano."
	color = "#ffe2ad" // rgb: 255, 226, 173
	nutriment_factor = 2
	boozepwr = 1
	quality = DRINK_VERYGOOD
	taste_description = "Creme e álcool."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/dreadnog
	name = "Dreadnog"
	description = "Por sofrer durante um período de alegria."
	color = "#f7ffad" // rgb: 247, 255, 173
	nutriment_factor = 3 * REAGENTS_METABOLISM
	boozepwr = 1
	quality = DRINK_REVOLTING
	taste_description = "Creme e álcool."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/narsour
	name = "Nar'Sour"
	description = "Os efeitos colaterais incluem auto-mutilação e armazenamento de placas."
	color = RUNE_COLOR_DARKRED
	boozepwr = 10
	quality = DRINK_FANTASTIC
	taste_description = "bloody"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/narsour/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_timed_status_effect(6 SECONDS * metabolization_ratio * seconds_per_tick, /datum/status_effect/speech/slurring/cult, max_duration = 6 SECONDS)
	drinker.adjust_stutter_up_to(6 SECONDS * metabolization_ratio * seconds_per_tick, 6 SECONDS)

/datum/reagent/consumable/ethanol/triple_sec
	name = "Triple Sec"
	description = "Um licor de laranja doce e vibrante."
	color = COLOR_ICECREAM_PEACH
	boozepwr = 30
	taste_description = "um sabor de laranja florido que lembra o ar do oceano e o vento de verão do caribe"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/creme_de_menthe
	name = "Creme de Menthe"
	description = "Um licor de menta excelente para bebidas refrescantes e legais."
	color = "#467446" //rgb: 70, 116, 70
	boozepwr = 20
	taste_description = "uma menta, fresco, e revigorante salpico de água fria do rio"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/creme_de_cacao
	name = "Creme de Cacao"
	description = "Um licor de chocolate excelente para adicionar notas de sobremesa para bebidas e suborno de irmandades."
	color = "#350900" // rgb: 53, 9, 0
	boozepwr = 20
	taste_description = "Um toque liso e aromático de chocolates girando em uma mordida de álcool"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/creme_de_coconut
	name = "Creme de Coconut"
	description = "Um licor de coco para bebidas suaves, cremosas, tropicais."
	color = "#F7F0D0"
	boozepwr = 20
	taste_description = "Um doce sabor leitoso com notas de açúcar torrado"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/quadruple_sec
	name = "Quadruple Sec"
	description = "Chuta tão forte quanto lamber a célula de energia em um bastão, mas mais gostoso."
	color = "#cc0000"
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "um revigorante frescor amargo que sufuga seu ser; nenhum inimigo da estação vai ficar sem violência hoje."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/quadruple_sec/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	//Securidrink in line with the Screwdriver for engineers or Nothing for mimes
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	if(liver && HAS_TRAIT(liver, TRAIT_LAW_ENFORCEMENT_METABOLISM))
		var/heal = 1 * metabolization_ratio * seconds_per_tick
		if(drinker.heal_bodypart_damage(brute = heal, burn = heal, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/quintuple_sec
	name = "Quintuple Sec"
	description = "Lei, Ordem, Álcool e Brutalidade policial destilados em um único elixir da Justiça."
	color = "#ff3300"
	boozepwr = 55
	quality = DRINK_FANTASTIC
	taste_description = "A LEI"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/quintuple_sec/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	//Securidrink in line with the Screwdriver for engineers or Nothing for mimes but STRONG..
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	if(liver && HAS_TRAIT(liver, TRAIT_LAW_ENFORCEMENT_METABOLISM))
		var/need_mob_update
		need_mob_update = drinker.heal_bodypart_damage(2 * metabolization_ratio * seconds_per_tick, 1 * metabolization_ratio *  seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += drinker.adjust_stamina_loss(-5 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype)
		if(need_mob_update)
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/grasshopper
	name = "Grasshopper"
	description = "Um atirador de sobremesa fresco e doce. Difícil parecer viril enquanto bebe isso."
	color = "#00ff00"
	boozepwr = 25
	quality = DRINK_GOOD
	taste_description = "chocolate e hortelã dançando ao redor de sua boca"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/stinger
	name = "Stinger"
	description = "Uma maneira rápida de terminar o dia."
	color = "#ccff99"
	boozepwr = 25
	quality = DRINK_NICE
	taste_description = "Um tapa na cara da melhor maneira possível."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bastion_bourbon
	name = "Bastion Bourbon"
	description = "Macarrão quente com propriedades restaurativas. Dica de sabores de citrinos e bagas."
	color = COLOR_CYAN
	boozepwr = 30
	quality = DRINK_FANTASTIC
	taste_description = "Bebida quente de ervas com uma pitada de fruta"
	metabolization_rate = 2 * REAGENTS_METABOLISM //0.4u per second
	ph = 4
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_HIGH

/datum/reagent/consumable/ethanol/bastion_bourbon/on_mob_metabolize(mob/living/drinker)
	. = ..()
	var/heal_points = 10
	if(drinker.health <= 0)
		heal_points = 20 //heal more if we're in softcrit
	var/need_mob_update
	var/heal_amt = min(volume, heal_points) //only heals 1 point of damage per unit on add, for balance reasons
	need_mob_update = drinker.adjust_brute_loss(-heal_amt, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += drinker.adjust_fire_loss(-heal_amt, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += drinker.adjust_tox_loss(-heal_amt, updating_health = FALSE, required_biotype = affected_biotype)
	need_mob_update += drinker.adjust_oxy_loss(-heal_amt, updating_health = FALSE, required_biotype = affected_biotype, required_respiration_type = affected_respiration_type)
	// heal stamina loss on first metabolization, but only to a max of 20
	need_mob_update += drinker.adjust_stamina_loss(max(-heal_amt * 5, -20), updating_stamina = FALSE, required_biotype = affected_biotype)
	if(need_mob_update)
		drinker.updatehealth()
	drinker.visible_message(span_warning("[drinker] Arrepios com vigor renovado!"), span_notice("Um pouco de [LOWER_TEXT(name)] Enche você de energia!"))
	if(!drinker.stat && heal_points == 20) //brought us out of softcrit
		drinker.visible_message(span_danger("[drinker] Desamparar [drinker.p_their()] Pés!"), span_boldnotice("Levante-se, garoto."))

/datum/reagent/consumable/ethanol/bastion_bourbon/on_mob_life(mob/living/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.health > 0)
		var/need_mob_update
		need_mob_update = drinker.adjust_brute_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += drinker.adjust_fire_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += drinker.adjust_tox_loss(-0.125 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += drinker.adjust_oxy_loss(-0.75 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype, required_respiration_type = affected_respiration_type)
		need_mob_update += drinker.adjust_stamina_loss(-1.25 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype)
		if(need_mob_update)
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/squirt_cider
	name = "Squirt Cider"
	description = "Extrato de esguicho fermentado com um nariz de pão velho e água do oceano. Seja lá o que for."
	color = COLOR_RED
	boozepwr = 40
	taste_description = "Pão velho com um sabor velho"
	nutriment_factor = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/squirt_cider/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.satiety += 5 * metabolization_ratio * seconds_per_tick //for context, vitamins give 15 satiety per second

/datum/reagent/consumable/ethanol/fringe_weaver
	name = "Fringe Weaver"
	description = "Bubbly, elegante, e sem dúvida forte - um clássico da Cidade das Trevas."
	color = "#FFEAC4"
	boozepwr = 90 //classy hooch, essentially, but lower pwr to make up for slightly easier access
	quality = DRINK_GOOD
	taste_description = "Álcool etílico com um toque de açúcar."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/sugar_rush
	name = "Sugar Rush"
	description = "Doce, leve e frutado, o mais feminino possível."
	color = "#FF226C"
	boozepwr = 10
	quality = DRINK_GOOD
	taste_description = "Suas artérias entupindo com açúcar."
	nutriment_factor = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/sugar_rush/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.satiety -= 10 * metabolization_ratio * seconds_per_tick //junky as hell! a whole glass will keep you from being able to eat junk food

/datum/reagent/consumable/ethanol/crevice_spike
	name = "Crevice Spike"
	description = "Azedo, amargo, e esmagadoramente sóbrio."
	color = "#5BD231"
	boozepwr = -10 //sobers you up - ideally, one would drink to get hit with brute damage now to avoid alcohol problems later
	quality = DRINK_VERYGOOD
	taste_description = "um espigão amargo com um sabor amargo"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/crevice_spike/on_mob_metabolize(mob/living/drinker) //damage only applies when drink first enters system and won't again until drink metabolizes out
	. = ..()
	drinker.adjust_brute_loss(3 * min(5,volume), required_bodytype = affected_bodytype) //minimum 3 brute damage on ingestion to limit non-drink means of injury - a full 5 unit gulp of the drink trucks you for the full 15

/datum/reagent/consumable/ethanol/sake
	name = "Sake"
	description = "Um doce vinho de arroz de legalidade questionável e extrema potência."
	color = "#DDDDDD"
	boozepwr = 70
	taste_description = "Vinho de arroz doce"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/peppermint_patty
	name = "Peppermint Patty"
	description = "Esta bebida alcoólica combina os benefícios do mentol e do cacau."
	color = "#45ca7a"
	taste_description = "Menta e chocolate"
	boozepwr = 25
	quality = DRINK_GOOD
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/peppermint_patty/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.apply_status_effect(/datum/status_effect/throat_soothed)
	drinker.adjust_bodytemperature(5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, 0, drinker.get_body_temp_normal())

/datum/reagent/consumable/ethanol/alexander
	name = "Alexander"
	description = "Com o nome de um herói grego, esta mistura encoraja o escudo de um usuário como se estivesse em uma falange."
	color = "#F5E9D3"
	boozepwr = 50
	quality = DRINK_GOOD
	taste_description = "Cacau amargo e cremoso."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/datum/weakref/mighty_shield

/datum/reagent/consumable/ethanol/alexander/on_mob_metabolize(mob/living/drinker)
	. = ..()
	if(ishuman(drinker))
		var/mob/living/carbon/human/the_human = drinker
		for(var/obj/item/shield/the_shield in the_human.contents)
			mighty_shield = WEAKREF(the_shield)
			the_shield.block_chance += 10
			to_chat(the_human, span_notice("[the_shield] Parece polido, embora não se lembre de polir."))
			break

/datum/reagent/consumable/ethanol/alexander/on_mob_life(mob/living/drinker, seconds_per_tick, metabolization_ratio)
	var/obj/item/shield/the_shield = mighty_shield?.resolve()
	if(the_shield && !(the_shield in drinker.contents)) //If you had a shield and lose it, you lose the reagent as well. Otherwise this is just a normal drink.
		holder.remove_reagent(type, volume)
		return
	return ..()

/datum/reagent/consumable/ethanol/alexander/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	var/obj/item/shield/the_shield = mighty_shield?.resolve()
	if(the_shield)
		the_shield.block_chance -= 10
		to_chat(drinker,span_notice("Você percebe [the_shield] Parece desgastado novamente. Estranho."))
		mighty_shield = null

/datum/reagent/consumable/ethanol/amaretto_alexander
	name = "Amaretto Alexander"
	description = "Uma versão mais fraca do Alexander, o que lhe falta em força compensa em sabor."
	color = "#DBD5AE"
	boozepwr = 35
	quality = DRINK_VERYGOOD
	taste_description = "Doce, cremoso cacau"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/sidecar
	name = "Sidecar"
	description = "O único passeio pelo qual vai desistir da roda."
	color = "#FFC55B"
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "Deliciosa liberdade"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/between_the_sheets
	name = "Between the Sheets"
	description = "Um clássico provocador. Engraçado, médicos recomendam beber antes de tirar uma soneca enquanto sob lençóis."
	color = "#F4C35A"
	boozepwr = 55
	quality = DRINK_GOOD
	taste_description = "seduction"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/between_the_sheets/on_mob_life(mob/living/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/is_between_the_sheets = FALSE
	for(var/obj/item/bedsheet/bedsheet in range(drinker.loc, 0))
		if(bedsheet.loc != drinker.loc) // bedsheets in your backpack/neck don't count
			continue
		is_between_the_sheets = TRUE
		break

	if(!drinker.IsSleeping() || !is_between_the_sheets)
		return

	var/need_mob_update
	if(drinker.get_brute_loss() && drinker.get_fire_loss()) //If you are damaged by both types, slightly increased healing but it only heals one. The more the merrier wink wink.
		if(prob(50))
			need_mob_update = drinker.adjust_brute_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE,  required_bodytype = affected_bodytype)
		else
			need_mob_update = drinker.adjust_fire_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE,  required_bodytype = affected_bodytype)
	else if(drinker.get_brute_loss()) //If you have only one, it still heals but not as well.
		need_mob_update = drinker.adjust_brute_loss(-0.2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE,  required_bodytype = affected_bodytype)
	else if(drinker.get_fire_loss())
		need_mob_update = drinker.adjust_fire_loss(-0.2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/kamikaze
	name = "Kamikaze"
	description = "Divino vento."
	color = "#EEF191"
	boozepwr = 60
	quality = DRINK_GOOD
	taste_description = "Vento divino"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/mojito
	name = "Mojito"
	description = "Uma bebida que parece refrescante como o gosto."
	color = "#DFFAD9"
	boozepwr = 30
	quality = DRINK_GOOD
	taste_description = "menta refrescante"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/moscow_mule
	name = "Moscow Mule"
	description = "Uma bebida fria que lembra o Derelict."
	color = "#EEF1AA"
	boozepwr = 30
	quality = DRINK_GOOD
	taste_description = "espicidez refrescante"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/fernet
	name = "Fernet"
	description = "Um licor de ervas incrivelmente amargo usado como digestivo."
	color = "#1B2E24" // rgb: 27, 46, 36
	boozepwr = 80
	taste_description = "amargura absoluta"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/fernet/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.nutrition <= NUTRITION_LEVEL_STARVING)
		if(drinker.adjust_tox_loss(1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
			. = UPDATE_MOB_HEALTH
	drinker.adjust_nutrition(-5 * metabolization_ratio * seconds_per_tick)
	drinker.overeatduration = 0

/datum/reagent/consumable/ethanol/fernet_cola
	name = "Fernet Cola"
	description = "Uma digestão muito popular e agridoce, ideal após uma refeição pesada. Melhor servido em uma garrafa de cola serrada como tradição."
	color = "#390600" // rgb: 57, 6,
	boozepwr = 25
	quality = DRINK_NICE
	taste_description = "doce alívio"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/fernet_cola/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.nutrition <= NUTRITION_LEVEL_STARVING)
		if(drinker.adjust_tox_loss(0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
			. = UPDATE_MOB_HEALTH
	drinker.adjust_nutrition(-3 * metabolization_ratio * seconds_per_tick)
	drinker.overeatduration = 0

/datum/reagent/consumable/ethanol/fanciulli
	name = "Fanciulli"
	description = "E se o coquetel de Manhattan realmente usou um licor amargo de ervas? Ajuda a ficar sóbrio." //also causes a bit of stamina damage to symbolize the afterdrink lazyness
	color = "#CA933F" // rgb: 202, 147, 63
	boozepwr = -10
	quality = DRINK_NICE
	taste_description = "Uma doce mistura sóbria"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_HIGH

/datum/reagent/consumable/ethanol/fanciulli/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_nutrition(-5 * metabolization_ratio * seconds_per_tick)
	drinker.overeatduration = 0

/datum/reagent/consumable/ethanol/fanciulli/on_mob_metabolize(mob/living/drinker)
	. = ..()
	if(drinker.health > 0)
		drinker.adjust_stamina_loss(20, required_biotype = affected_biotype)

/datum/reagent/consumable/ethanol/branca_menta
	name = "Branca Menta"
	description = "Uma mistura refrescante de fernet amargo com licor de creme de menta."
	color = "#4B5746" // rgb: 75, 87, 70
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "uma frescura amarga"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/branca_menta/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_bodytemperature(-20 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, T0C)

/datum/reagent/consumable/ethanol/branca_menta/on_mob_metabolize(mob/living/drinker)
	. = ..()
	if(drinker.health > 0)
		drinker.adjust_stamina_loss(35, required_biotype = affected_biotype)

/datum/reagent/consumable/ethanol/blank_paper
	name = "Blank Paper"
	description = "Um copo borbulhante de papel em branco. Só de olhar faz você se sentir fresco."
	nutriment_factor = 1
	color = "#DCDCDC" // rgb: 220, 220, 220
	boozepwr = 20
	quality = DRINK_GOOD
	taste_description = "É uma possibilidade borbulhante."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/blank_paper/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(ishuman(drinker) && HAS_MIND_TRAIT(drinker, TRAIT_MIMING))
		drinker.set_silence_if_lower(MIMEDRINK_SILENCE_DURATION)
		var/heal = 1 * metabolization_ratio * seconds_per_tick
		if(drinker.heal_bodypart_damage(brute = heal, burn = heal, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/fruit_wine
	name = "Fruit Wine"
	description = "Um vinho feito de plantas cultivadas."
	color = COLOR_WHITE
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "Codificação ruim"
	ph = 4
	var/list/names = list("null fruit" = 1) //Names of the fruits used. Associative list where name is key, value is the percentage of that fruit.
	var/list/tastes = list("bad coding" = 1) //List of tastes. See above.

/datum/reagent/consumable/ethanol/fruit_wine/on_new(list/data)
	if(!data)
		return

	src.data = data
	names = data["names"]
	tastes = data["tastes"]
	boozepwr = data["boozepwr"]
	color = data["color"]
	generate_data_info(data)

/datum/reagent/consumable/ethanol/fruit_wine/on_merge(list/mix_data, amount)
	. = ..()
	var/diff = (amount/volume)
	if(diff < 1)
		color = BlendRGB(color, mix_data["color"], diff/2) //The percentage difference over two, so that they take average if equal.
	else
		color = BlendRGB(color, mix_data["color"], (1/diff)/2) //Adjust so it's always blending properly.
	var/oldvolume = volume-amount

	var/list/cachednames = mix_data["names"]
	for(var/name in names | cachednames)
		names[name] = ((names[name] * oldvolume) + (cachednames[name] * amount)) / volume

	var/list/cachedtastes = mix_data["tastes"]
	for(var/taste in tastes | cachedtastes)
		tastes[taste] = ((tastes[taste] * oldvolume) + (cachedtastes[taste] * amount)) / volume

	boozepwr *= oldvolume
	var/newzepwr = mix_data["boozepwr"] * amount
	boozepwr += newzepwr
	boozepwr /= volume //Blending boozepwr to volume.
	generate_data_info(data)

/datum/reagent/consumable/ethanol/fruit_wine/proc/generate_data_info(list/data)
	// BYOND's compiler fails to catch non-consts in a ranged switch case, and it causes incorrect behavior. So this needs to explicitly be a constant.
	var/const/minimum_percent = 0.15 //Percentages measured between 0 and 1.
	var/list/primary_tastes = list()
	var/list/secondary_tastes = list()
	for(var/taste in tastes)
		switch(tastes[taste])
			if(minimum_percent*2 to INFINITY)
				primary_tastes += taste
			if(minimum_percent to minimum_percent*2)
				secondary_tastes += taste

	var/minimum_name_percent = 0.35
	name = ""
	var/list/names_in_order = sortTim(names, GLOBAL_PROC_REF(cmp_numeric_dsc), TRUE)
	var/named = FALSE
	for(var/fruit_name in names)
		if(names[fruit_name] >= minimum_name_percent)
			name += "[fruit_name] "
			named = TRUE
	if(named)
		name += "Wine"
	else
		name = "Mixed [names_in_order [1]] Wine"

	var/alcohol_description
	switch(boozepwr)
		if(120 to INFINITY)
			alcohol_description = "suicidamente forte."
		if(90 to 120)
			alcohol_description = "bastante forte."
		if(70 to 90)
			alcohol_description = "strong"
		if(40 to 70)
			alcohol_description = "rich"
		if(20 to 40)
			alcohol_description = "mild"
		if(0 to 20)
			alcohol_description = "sweet"
		else
			alcohol_description = "watery" //How the hell did you get negative boozepwr?

	var/list/fruits = list()
	if(names_in_order.len <= 3)
		fruits = names_in_order
	else
		for(var/i in 1 to 3)
			fruits += names_in_order[i]
		fruits += "other plants"
	var/fruit_list = english_list(fruits)
	description = "A[alcohol_description]Vinho feito de[fruit_list]."

	var/flavor = ""
	if(!primary_tastes.len)
		primary_tastes = list("[alcohol_description] alcohol")
	flavor += english_list(primary_tastes)
	if(secondary_tastes.len)
		flavor += ", with a hint of "
		flavor += english_list(secondary_tastes)
	taste_description = flavor

/datum/reagent/consumable/ethanol/champagne //How the hell did we not have champagne already!?
	name = "Champagne"
	description = "Um vinho espumante conhecido por sua capacidade de atacar rápido e duro."
	color = "#ffffc1"
	boozepwr = 40
	taste_description = "ocasiões auspiciosas e más decisões"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/wizz_fizz
	name = "Wizz Fizz"
	description = "Uma poção mágica, efervescente e selvagem! No entanto, o sabor, você vai encontrar, é bastante suave."
	color = "#4235d0" //Just pretend that the triple-sec was blue curacao.
	boozepwr = 50
	quality = DRINK_GOOD
	taste_description = "Amizade! É mágica, afinal"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/wizz_fizz/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	//A healing drink similar to Quadruple Sec, Ling Stings, and Screwdrivers for the Wizznerds; the check is consistent with the changeling sting
	if(drinker?.mind?.has_antag_datum(/datum/antagonist/wizard))
		var/need_mob_update
		need_mob_update = drinker.heal_bodypart_damage(1 * metabolization_ratio * seconds_per_tick, 1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		need_mob_update += drinker.adjust_oxy_loss(-1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype, required_respiration_type = affected_respiration_type)
		need_mob_update += drinker.adjust_tox_loss(-1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += drinker.adjust_stamina_loss(-5 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype)
		if(need_mob_update)
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/bug_spray
	name = "Bug Spray"
	description = "Uma bebida dura, amarga, para aqueles que precisam de algo para se prepararem."
	color = "#33ff33"
	boozepwr = 50
	quality = DRINK_GOOD
	taste_description = "a dor de dez mil mosquitos mortos."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	affected_biotype = MOB_BUG

/datum/reagent/consumable/ethanol/bug_spray/on_new(data)
	. = ..()
	AddElement(/datum/element/bugkiller_reagent)

/datum/reagent/consumable/ethanol/bug_spray/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	// Does some damage to bug biotypes
	if(drinker.adjust_tox_loss(1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
		. = UPDATE_MOB_HEALTH
		// Random chance of causing a screm if we did some damage
		if(SPT_PROB(2, seconds_per_tick))
			drinker.emote("scream")

/datum/reagent/consumable/ethanol/applejack
	name = "Applejack"
	description = "A bebida perfeita para quando sentir necessidade de andar de cavalo."
	color = "#ff6633"
	boozepwr = 20
	taste_description = "Um dia de trabalho honesto no pomar."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/jack_rose
	name = "Jack Rose"
	description = "Um coquetel leve perfeito para beber com uma fatia de torta."
	color = "#ff6633"
	boozepwr = 15
	quality = DRINK_NICE
	taste_description = "Uma doce e azeda fatia de maçã."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/turbo
	name = "Turbo"
	description = "Um coquetel turbulento associado à corrida de hoverbike fora da lei. Não para os fracos de coração."
	color = "#e94c3a"
	boozepwr = 85
	quality = DRINK_VERYGOOD
	taste_description = "O espírito fora da lei"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/turbo/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(2, seconds_per_tick))
		to_chat(drinker, span_notice("[pick("You feel disregard for the rule of law.", "You feel pumped!", "Your head is pounding.", "Your thoughts are racing..")]"))
	if(drinker.adjust_stamina_loss(-0.5 * drinker.get_drunk_amount() * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype))
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/old_timer
	name = "Old Timer"
	description = "Uma poção arcaica desfrutada por velhos de todas as idades."
	color = "#996835"
	boozepwr = 35
	quality = DRINK_NICE
	taste_description = "Tempos mais simples"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/old_timer/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(10, seconds_per_tick) && ishuman(drinker))
		var/mob/living/carbon/human/metabolizer = drinker
		metabolizer.age += 1
		if(metabolizer.age > 70)
			metabolizer.set_facial_haircolor("#cccccc", update = FALSE)
			metabolizer.set_haircolor("#cccccc", update = TRUE)
			if(metabolizer.age > 100)
				metabolizer.become_nearsighted(type)
				if(metabolizer.gender == MALE)
					metabolizer.set_facial_hairstyle("Beard (Very Long)", update = TRUE)

				if(metabolizer.age > 969) //Best not let people get older than this or i might incur G-ds wrath
					metabolizer.visible_message(span_notice("[metabolizer] Torna-se mais velho do que qualquer homem deveria ser e desmorona-se em pó!"))
					metabolizer.dust(just_ash = FALSE, drop_items = TRUE, force = FALSE)

/datum/reagent/consumable/ethanol/rubberneck
	name = "Rubberneck"
	description = "Um pescoço de borracha de qualidade não deve conter nenhum ingrediente natural bruto."
	color = "#ffe65b"
	boozepwr = 60
	quality = DRINK_GOOD
	taste_description = "Frutificação artificial"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_SHOCKIMMUNE)

/datum/reagent/consumable/ethanol/duplex
	name = "Duplex"
	description = "Uma combinação inseparável de duas bebidas frutadas."
	color = "#50e5cf"
	boozepwr = 25
	quality = DRINK_NICE
	taste_description = "maçãs verdes e framboesas azuis"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/trappist
	name = "Trappist Beer"
	description = "Uma cerveja escura forte feita por macacos espaciais."
	color = "#390c00"
	boozepwr = 40
	quality = DRINK_VERYGOOD
	taste_description = "ameixas secas e malte"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/trappist/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.mind?.holy_role)
		if(drinker.adjust_fire_loss(-2.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype))
			. = UPDATE_MOB_HEALTH
		drinker.adjust_jitter(-2 SECONDS * metabolization_ratio * seconds_per_tick)
		drinker.adjust_stutter(-2 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/ethanol/blazaam
	name = "Blazaam"
	description = "Uma bebida estranha que poucas pessoas parecem lembrar de existir. Duplos como removedores de Berenstain."
	boozepwr = 70
	quality = DRINK_FANTASTIC
	taste_description = "Realidades alternativas"
	var/stored_teleports = 0

/datum/reagent/consumable/ethanol/blazaam/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.get_drunk_amount() > 40)
		if(stored_teleports)
			do_teleport(drinker, get_turf(drinker), rand(1,3), channel = TELEPORT_CHANNEL_WORMHOLE)
			stored_teleports--

		if(SPT_PROB(5, seconds_per_tick))
			stored_teleports += rand(2, 6)
			if(prob(70))
				drinker.vomit(vomit_flags = VOMIT_CATEGORY_DEFAULT, vomit_type = /obj/effect/decal/cleanable/vomit/purple)

/datum/reagent/consumable/ethanol/planet_cracker
	name = "Planet Cracker"
	description = "Esta bebida jubilante celebra o triunfo da humanidade sobre a ameaça alienígena. Pode ser ofensivo para tripulantes não humanos."
	boozepwr = 50
	quality = DRINK_FANTASTIC
	taste_description = "Triunfo com um toque de amargura"

/datum/reagent/consumable/ethanol/mauna_loa
	name = "Mauna Loa"
	description = "Extremamente quente, não para os fracos de coração!"
	boozepwr = 40
	color = "#fe8308" // 254, 131, 8
	quality = DRINK_FANTASTIC
	taste_description = "fogo, com um sabor de carne queimada"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/mauna_loa/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	// Heats the user up while the reagent is in the body. Occasionally makes you burst into flames.
	drinker.adjust_bodytemperature(25 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick)
	if (SPT_PROB(2.5, seconds_per_tick))
		drinker.adjust_fire_stacks(1 * metabolization_ratio)
		drinker.ignite_mob()

/datum/reagent/consumable/ethanol/painkiller
	name = "Painkiller"
	description = "Engole sua dor. Sua dor emocional."
	boozepwr = 20
	color = "#EAD677"
	quality = DRINK_NICE
	taste_description = "Torta açucarada"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_ANALGESIA)

/datum/reagent/consumable/ethanol/pina_colada
	name = "Pina Colada"
	description = "Uma bebida fresca de abacaxi com rum de coco. Yum."
	boozepwr = 40
	color = "#FFF1B2"
	quality = DRINK_FANTASTIC
	taste_description = "abacaxi, coco e uma pitada do oceano."

/datum/reagent/consumable/ethanol/pina_olivada
	name = "Piña Olivada"
	description = "Uma mistura estranha de azeite e suco de abacaxi."
	boozepwr = 20 // the oil coats your gastrointestinal tract, meaning you can't absorb as much alcohol. horrifying
	color = "#493c00"
	quality = DRINK_NICE
	taste_description = "Uma horrível emulsão de abacaxi e azeite."

/datum/reagent/consumable/ethanol/pina_olivada/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(8, seconds_per_tick))
		drinker.manual_emote(pick("coughs up some oil", "swallows the lump in [drinker.p_their()] throat", "gags", "chokes up a bit"))
	if(SPT_PROB(3, seconds_per_tick))
		var/static/list/messages = list(
			"A horrible aftertaste coats your mouth.",
			"You feel like you're going to choke on the oil in your throat.",
			"You start to feel some heartburn coming on.",
			"You want to throw up, but you know that nothing can come out due to the clog in your esophagus.",
			"Your throat feels horrible.",
		)
		to_chat(drinker, span_notice(pick(messages)))

/datum/reagent/consumable/ethanol/pruno // pruno mix is in drink_reagents
	name = "Pruno"
	color = "#E78108"
	description = "Vinho fermentado feito de fruta, açúcar e desespero. A segurança adora confiscar isso, que é a única coisa que a segurança já fez."
	boozepwr = 85
	taste_description = "Seu gosto é ser esfaqueado individualmente."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/pruno/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_disgust(5 * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/ethanol/ginger_amaretto
	name = "Ginger Amaretto"
	description = "Um coquetel deliciosamente simples que agrada os sentidos."
	boozepwr = 30
	color = "#EFB42A"
	quality = DRINK_GOOD
	taste_description = "Doçura seguida por um suave azedo e calor"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/godfather
	name = "Godfather"
	description = "Um coquetel áspero com conexões ilegais."
	boozepwr = 50
	color = "#E68F00"
	quality = DRINK_GOOD
	taste_description = "um delicioso ponche amaciado."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/godmother
	name = "Godmother"
	description = "Uma reviravolta em um clássico, gostava mais de mulheres maduras."
	boozepwr = 50
	color = "#E68F00"
	quality = DRINK_GOOD
	taste_description = "Doçura e uma reviravolta"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/kortara
	name = "Kortara"
	description = "Uma bebida doce à base de nozes saboreada em Tizira. Frequentemente misturado com sucos de frutas e cacau para um refresco extra."
	boozepwr = 25
	color = "#EEC39A"
	quality = DRINK_GOOD
	taste_description = "néctar doce"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/kortara/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.get_brute_loss() && SPT_PROB(10, seconds_per_tick))
		if(drinker.heal_bodypart_damage(brute = 1 * metabolization_ratio, burn = 0, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/sea_breeze
	name = "Sea Breeze"
	description = "Leve e refrescante com uma hortelã e chocolate... como sorvete de chocolate de menta que você pode beber!"
	boozepwr = 15
	color = "#CFFFE5"
	quality = DRINK_VERYGOOD
	taste_description = "Batata de chocolate de hortelã"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/sea_breeze/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.apply_status_effect(/datum/status_effect/throat_soothed)

/datum/reagent/consumable/ethanol/white_tiziran
	name = "White Tiziran"
	description = "Uma mistura de vodka e kortara. Os lagartos bebem."
	boozepwr = 65
	color = "#A68340"
	quality = DRINK_GOOD
	taste_description = "greves e calhas"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/drunken_espatier
	name = "Drunken Espatier"
	description = "Olha, se você tivesse que entrar em um tiroteio no vácuo frio do espaço, você gostaria de estar bêbado também."
	boozepwr = 65
	color = "#A68340"
	quality = DRINK_GOOD
	taste_description = "sorrow"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/drunken_espatier/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.add_mood_event("numb", /datum/mood_event/narcotic_medium, name) //comfortably numb

/datum/reagent/consumable/ethanol/drunken_espatier/on_mob_metabolize(mob/living/drinker)
	. = ..()
	drinker.apply_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)

/datum/reagent/consumable/ethanol/drunken_espatier/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	drinker.remove_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)

/datum/reagent/consumable/ethanol/protein_blend
	name = "Protein Blend"
	description = "Uma mistura vil de proteína, álcool puro, farinha de korta e sangue. Útil para aumentar o volume, se puder falar baixo."
	boozepwr = 65
	color = "#FF5B69"
	quality = DRINK_NICE
	taste_description = "regret"
	nutriment_factor = 3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/protein_blend/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. =	..()
	drinker.adjust_nutrition(2 * metabolization_ratio * seconds_per_tick)
	if(!islizard(drinker))
		drinker.adjust_disgust(5 * metabolization_ratio * seconds_per_tick)
	else
		drinker.adjust_disgust(2 * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/ethanol/mushi_kombucha
	name = "Mushi Kombucha"
	description = "Uma bebida de verão popular em Tizira, feita de chá de cogumelos adoçados."
	boozepwr = 10
	color = "#C46400"
	quality = DRINK_VERYGOOD
	taste_description = "Doces cogumelos"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/triumphal_arch
	name = "Triumphal Arch"
	description = "Uma bebida celebrando o Império Lagarto e suas vitórias militares. É popular em bares no Dia da Unificação."
	boozepwr = 60
	color = COLOR_GOLD
	quality = DRINK_FANTASTIC
	taste_description = "victory"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/triumphal_arch/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(islizard(drinker))
		drinker.add_mood_event("triumph", /datum/mood_event/memories_of_home, name)

/datum/reagent/consumable/ethanol/the_juice
	name = "The Juice"
	description = "Cara, isso parece familiar para você, cara."
	color = "#4c14be"
	boozepwr = 50
	quality = DRINK_GOOD
	taste_description = "O futuro, cara."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/datum/brain_trauma/special/bluespace_prophet/prophet_trauma

/datum/reagent/consumable/ethanol/the_juice/on_mob_metabolize(mob/living/carbon/drinker)
	. = ..()
	prophet_trauma = new()
	drinker.gain_trauma(prophet_trauma, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/reagent/consumable/ethanol/the_juice/on_mob_end_metabolize(mob/living/carbon/drinker)
	. = ..()
	if(prophet_trauma)
		QDEL_NULL(prophet_trauma)

//a jacked up absinthe that causes hallucinations to the game master controller basically, used in smuggling objectives
/datum/reagent/consumable/ethanol/ritual_wine
	name = "Ritual Wine"
	description = "O perigoso, potente, componente alcoólico do vinho ritual."
	color = rgb(35, 231, 25)
	boozepwr = 90 //enjoy near death intoxication
	taste_mult = 6
	taste_description = "Ervas concentradas"

/datum/reagent/consumable/ethanol/ritual_wine/on_mob_metabolize(mob/living/psychonaut)
	. = ..()
	if(!psychonaut.hud_used)
		return
	var/atom/movable/plane_master_controller/game_plane_master_controller = psychonaut.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
	game_plane_master_controller.add_filter("ritual_wine", 1, list("type" = "wave", "size" = 1, "x" = 5, "y" = 0, "flags" = WAVE_SIDEWAYS))

/datum/reagent/consumable/ethanol/ritual_wine/on_mob_end_metabolize(mob/living/psychonaut)
	. = ..()
	if(!psychonaut.hud_used)
		return
	var/atom/movable/plane_master_controller/game_plane_master_controller = psychonaut.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
	game_plane_master_controller.remove_filter("ritual_wine")

//Moth Drinks
/datum/reagent/consumable/ethanol/curacao
	name = "Curaçao"
	description = "Feito com laranjas Laraha, para um acabamento aromático."
	boozepwr = 30
	color = "#1a5fa1"
	quality = DRINK_NICE
	taste_description = "Laranja azul"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/navy_rum //IN THE NAVY
	name = "Navy Rum"
	description = "Rum como os melhores marinheiros bebem."
	boozepwr = 90 //the finest sailors are often drunk
	color = "#d8e8f0"
	quality = DRINK_NICE
	taste_description = "uma vida nas ondas"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bitters //why do they call them bitters, anyway? they're more spicy than anything else
	name = "Andromeda Bitters"
	description = "O melhor amigo de um barman, costumava dar um tempero delicado a qualquer bebida. Produzido em New Trinidad, agora e para sempre."
	boozepwr = 70
	color = "#1c0000"
	quality = DRINK_NICE
	taste_description = "Álcool temperado"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/admiralty //navy rum, vermouth, fernet
	name = "Admiralty"
	description = "Uma bebida refinada e amarga feita com rum, vermute e fernet."
	boozepwr = 100
	color = "#1F0001"
	quality = DRINK_VERYGOOD
	taste_description = "soberba arrogância"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/long_haul //Rum, Curacao, Sugar, dash of bitters, lengthened with soda water
	name = "Long Haul"
	description = "Um favorito entre pilotos de cargueiro, contrabandistas sem escrúpulos, e pastores Nerf."
	boozepwr = 35
	color = "#003153"
	quality = DRINK_VERYGOOD
	taste_description = "companionship"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/long_john_silver //navy rum, bitters, lemonade
	name = "Long John Silver"
	description = "Uma longa bebida de rum marinho, amargos e limonada. Particularmente popular a bordo da frota Mothic como é leve em créditos de ração e pesado em sabor."
	boozepwr = 50
	color = "#c4b35c"
	quality = DRINK_VERYGOOD
	taste_description = "Rum e especiarias"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/tropical_storm //dark rum, pineapple juice, triple citrus, curacao
	name = "Tropical Storm"
	description = "Um gosto do Caribe em um copo."
	boozepwr = 40
	color = "#00bfa3"
	quality = DRINK_VERYGOOD
	taste_description = "Os trópicos"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/dark_and_stormy //rum and ginger beer- simple and classic
	name = "Dark and Stormy"
	description = "Uma bebida clássica chegando aos aplausos trovões." //thank you, thank you, I'll be here forever
	boozepwr = 50
	color = "#8c5046"
	quality = DRINK_GOOD
	taste_description = "Gengibre e rum"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/salt_and_swell //navy rum, tochtause syrup, egg whites, dash of saline-glucose solution
	name = "Salt and Swell"
	description = "Um azedo forte com um sabor salgado interessante."
	boozepwr = 60
	color = "#b4abd0"
	quality = DRINK_FANTASTIC
	taste_description = "sal e especiarias"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/tiltaellen //yoghurt, salt, vinegar
	name = "Tiltällen"
	description = "Uma bebida levemente fermentada de iogurte com sal e uma leve pitada de vinagre. Tem um sabor azedo e azedo."
	boozepwr = 10
	color = "#F4EFE2"
	quality = DRINK_NICE
	taste_description = "Iogurte de queijo azedo"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/tich_toch
	name = "Tich Toch"
	description = "Uma mistura de Tiltällen, Xarope Töchtaüse e vodka. Não é exatamente para o gosto de todos."
	boozepwr = 75
	color = "#b4abd0"
	quality = DRINK_VERYGOOD
	taste_description = "Iogurte picante e azedo"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/helianthus
	name = "Helianthus"
	description = "Uma mistura escura e radiante de absinto e alucinógenos. A escolha de todos os verdadeiros artistas."
	boozepwr = 75
	color = "#fba914"
	quality = DRINK_VERYGOOD
	taste_description = "memórias douradas"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/hal_amt = 4
	var/hal_cap = 24

/datum/reagent/consumable/ethanol/helianthus/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(5, seconds_per_tick))
		drinker.adjust_hallucinations_up_to(4 SECONDS * metabolization_ratio, 48 SECONDS)

/datum/reagent/consumable/ethanol/plumwine
	name = "Plum wine"
	description = "Ameixas viraram vinho."
	color = "#8a0421"
	nutriment_factor = 1
	boozepwr = 20
	taste_description = "O amor e a ruína de um poeta"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/the_hat
	name = "The Hat"
	description = "Uma bebida chique, geralmente servida no chapéu de um homem."
	color = "#b90a5c"
	boozepwr = 80
	quality = DRINK_NICE
	taste_description = "Algo perfumado."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/gin_garden
	name = "Gin Garden"
	description = "Excelente bebida alcoólica gelada com gosto não tão comum."
	boozepwr = 20
	color = "#6cd87a"
	quality = DRINK_VERYGOOD
	taste_description = "Gin leve com doce gengibre e pepino"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/gin_garden/on_mob_life(mob/living/carbon/doll, seconds_per_tick, metabolization_ratio)
	. = ..()
	doll.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, doll.get_body_temp_normal())

/datum/reagent/consumable/ethanol/wine_voltaic
	name = "Voltaic Yellow Wine"
	description = "Vinho carregado eletronicamente. Recarrega etéreas, mas também não tóxicas."
	boozepwr = 30
	color = "#FFAA00"
	taste_description = "Estático com um toque de doçura"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/wine_voltaic/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume) //can't be on life because of the way blood works.
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(exposed_mob))
		return

	var/mob/living/carbon/exposed_carbon = exposed_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 10 * ETHEREAL_DISCHARGE_RATE)

/datum/reagent/consumable/ethanol/telepole
	name = "Telepole"
	description = "Uma haste de aterramento em forma de bebida. Recarrega etéreas, e dá resistência temporária ao choque."
	boozepwr = 50
	color = "#b300ff"
	quality = DRINK_NICE
	taste_description = "A tempestade uivante"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_SHOCKIMMUNE)

/datum/reagent/consumable/ethanol/telepole/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume) //can't be on life because of the way blood works.
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(exposed_mob))
		return

	var/mob/living/carbon/exposed_carbon = exposed_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 20 * ETHEREAL_DISCHARGE_RATE)

/datum/reagent/consumable/ethanol/pod_tesla
	name = "Pod Tesla"
	description = "Cavalgue o relâmpago! Recarrega etéreas, suprime fobias, e dá forte resistência temporária ao choque."
	boozepwr = 80
	color = "#00fbff"
	quality = DRINK_FANTASTIC
	taste_description = "Vitória, com um toque de insanidade"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/pod_tesla/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.add_traits(list(TRAIT_SHOCKIMMUNE,TRAIT_TESLA_SHOCKIMMUNE,TRAIT_FEARLESS), type)

/datum/reagent/consumable/ethanol/pod_tesla/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.remove_traits(list(TRAIT_SHOCKIMMUNE,TRAIT_TESLA_SHOCKIMMUNE,TRAIT_FEARLESS), type)

/datum/reagent/consumable/ethanol/pod_tesla/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume) //can't be on life because of the way blood works.
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(exposed_mob))
		return

	var/mob/living/carbon/exposed_carbon = exposed_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 30 * ETHEREAL_DISCHARGE_RATE)

// Welcome to the Blue Room Bar and Grill, home to Mars' finest cocktails
/datum/reagent/consumable/ethanol/rice_beer
	name = "Rice Beer"
	description = "Uma cerveja leve à base de arroz popular em Marte. Considerado um crime de ódio contra bávaros sob a Lei Reinheitsgebot de 1516."
	boozepwr = 5
	color = "#664300"
	quality = DRINK_NICE
	taste_description = "Malte leve carbonatado"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/shochu
	name = "Shochu"
	description = "Também conhecido como soju ou baijiu, esta bebida é feita de arroz fermentado, como saquê, mas em uma prova geralmente superior tornando-o mais semelhante a um espírito verdadeiro."
	boozepwr = 45
	color = "#DDDDDD"
	quality = DRINK_NICE
	taste_description = "Vinho de arroz duro"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/yuyake
	name = "Yūyake"
	description = "Um doce licor de melão do Japão. Considerada uma relíquia dos anos 80 pela maioria, tem algum nicho de uso na fabricação de coquetel, em parte devido à sua cor vermelha brilhante."
	boozepwr = 40
	color = "#F54040"
	quality = DRINK_NICE
	taste_description = "Melão doce"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/coconut_rum
	name = "Coconut Rum"
	description = "A essência destilada da praia. Tem gosto de cabelo loiro e creme de sol."
	boozepwr = 21
	color = "#e4f2f5"
	quality = DRINK_NICE
	taste_description = "Rum de coco"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

// Mixed Martian Drinks
/datum/reagent/consumable/ethanol/yuyakita
	name = "Yūyakita"
	description = "Um inferno lançado sobre o mundo por um patrono desconhecido."
	boozepwr = 40
	color = "#e43414"
	quality = DRINK_NICE
	taste_description = "death"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/saibasan
	name = "Saibāsan"
	description = "Uma bebida glorificando o negócio duradouro da Cybersun."
	boozepwr = 20
	color = "#f25100"
	quality = DRINK_FANTASTIC
	taste_description = "betrayal"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/banzai_ti
	name = "Banzai-Tī"
	description = "Uma variação no Long Island Ice Tea, feito com yuyake para um sabor alternativo que é difícil de colocar."
	boozepwr = 40
	color = "#fd3b00"
	quality = DRINK_VERYGOOD
	taste_description = "Uma reviravolta asiática no armário de bebidas."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/sanraizusoda
	name = "Sanraizusōda"
	description = "É um refrigerante com creme de melão, exceto com álcool. O que não é para amar? Bem... possivelmente as ressacas."
	boozepwr = 6
	color = "#f37d7b"
	quality = DRINK_GOOD
	taste_description = "Soda de melão cremoso"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/kumicho
	name = "Kumichō"
	description = "Uma nova opinião sobre um coquetel clássico, o Kumicho pega a fórmula do Padrinho e adiciona shochu para uma reviravolta asiática."
	boozepwr = 62
	color = "#b87456"
	quality = DRINK_VERYGOOD
	taste_description = "arroz e centeio"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/red_planet
	name = "Red Planet"
	description = "Feita em celebração da Concessão Marciana, o Planeta Vermelho é baseado no clássico El Presidente, e é tão patriótico quanto é brilhante carmesim."
	boozepwr = 45
	color = "#ac4948"
	quality = DRINK_VERYGOOD
	taste_description = "O espírito da liberdade"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/amaterasu
	name = "Amaterasu"
	description = "Nomeado para Amaterasu, a Deusa Xintoísta do Sol, este coquetel encarna brilho ou algo assim, de qualquer forma."
	boozepwr = 54 //1 part bitters is a lot
	color = "#e43414"
	quality = DRINK_VERYGOOD
	taste_description = "Doce néctar dos deuses"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/nekomimosa
	name = "Nekomimosa"
	description = "Um coquetel doce demais, feito com licor de melão, suco de melão e champanhe (que não contém melão, infelizmente)."
	boozepwr = 17
	color = "#FF0C8D"
	quality = DRINK_GOOD
	taste_description = "MELON"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/sentai_quencha //melon soda, triple citrus, shochu, blue curacao
	name = "Sentai Quencha"
	description = "Baseado na famosa galáxia\"Kyūkyoku no Ninja Pawā Sentai\"O Sentai Quencha é favorito em convenções de anime e bares de salsichas."
	boozepwr = 28
	color = "#00ffa6"
	quality = DRINK_GOOD
	taste_description = "poder ninja final"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bosozoku
	name = "Bōsōzoku"
	description = "Uma simples bebida de verão de Marte, feita com uma mistura de cerveja de arroz e limonada."
	boozepwr = 6
	color = "#d7d84f"
	quality = DRINK_GOOD
	taste_description = "Agridoce limão"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/ersatzche
	name = "Ersatzche"
	description = "Doce, amargo, picante. É uma ótima combinação."
	boozepwr = 6
	color = "#bc6a2b"
	quality = DRINK_VERYGOOD
	taste_description = "Cerveja de abacaxi picante."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/red_city_am
	name = "Red City AM"
	description = "Uma bebida do café da manhã de New Osaka, para quando você realmente precisa ficar bêbado às 9:30 da manhã de forma mais socialmente aceitável do que beber bagwine no trem bala. Não que deva beber isso no trem bala também."
	boozepwr = 5 //this thing is fucking disgusting and both less tasty and less alcoholic than a bloody mary. it is against god and nature
	color = "#ef0903"
	quality = DRINK_NICE
	taste_description = "Café da manhã em um copo"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/kings_ransom
	name = "King's Ransom"
	description = "Uma bebida dura e amarga com um nome estranho e receita mais estranha."
	boozepwr = 26
	color = "#bd2e20"
	quality = DRINK_VERYGOOD
	taste_description = "Framboesa amarga"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/four_bit
	name = "Four Bit"
	description = "Uma bebida para alimentar suas mãos digitadas."
	boozepwr = 26
	color = "#c4b000"
	quality = DRINK_GOOD
	taste_description = "cyberspace"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/white_hawaiian //coconut milk, coconut rum, coffee liqueur
	name = "White Hawaiian"
	description = "Uma visão do clássico russo branco, substituindo os clássicos por alguns sabores tropicais."
	boozepwr = 16
	color = "#ffffeb"
	quality = DRINK_GOOD
	taste_description = "COCONUT"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/maui_sunrise //coconut rum, pineapple juice, yuyake, triple citrus, lemon-lime soda
	name = "Maui Sunrise"
	description = "Atrás desta bebida, a fachada vermelha esconde um sabor afiado e complexo."
	boozepwr = 15
	color = "#f1922b"
	quality = DRINK_VERYGOOD
	taste_description = "O amanhecer sobre o pacífico"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/imperial_mai_tai //navy rum, rum, lime, triple sec, korta nectar
	name = "Imperial Mai Tai"
	description = "Pois quando a orgia está em falta, faça o que os espaçadores fazem e consertem."
	boozepwr = 52
	color = "#cf7d61"
	quality = DRINK_VERYGOOD
	taste_description = "Rum picante de nozes"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/konococo_rumtini //todo: add espresso | coffee, coffee liqueur, coconut rum, sugar
	name = "Konococo Rumtini"
	description = "Rum de coco, licor de café e café expresso. Uma combinação estranha, com certeza, mas bem-vinda."
	boozepwr = 20
	color = "#421711"
	quality = DRINK_VERYGOOD
	taste_description = "Café de coco"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/ethanol/blue_hawaiian //pineapple juice, lemon juice, coconut rum, blue curacao
	name = "Blue Hawaiian"
	description = "Doce, afiado e coqueiro."
	boozepwr = 30
	color = "#295875"
	quality = DRINK_VERYGOOD
	taste_description = "O estado de Aloha."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/boston_sour
	name = "Boston Sour"
	description = "Uísque azedo texturalmente elevado por uma clara de ovo."
	boozepwr = 35
	color = "#ddc28b"
	quality = DRINK_VERYGOOD
	taste_description = "Espumosa limonada azeda"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/star
	name = "Star"
	description = "Uma mistura de Applejack e vermute acentuado com amargos."
	boozepwr = 40
	color = "#e5a654"
	quality = DRINK_GOOD
	taste_description = "Maçãs vinosas"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/old_fashioned
	name = "Old Fashioned"
	description = "Por algumas medidas, o primeiro coquetel, feito por aromatizar um espírito duro com açúcar e amargos, com o espírito em questão mais frequentemente sendo uísque nos tempos modernos."
	boozepwr = 60
	color = "#b4a287"
	quality = DRINK_GOOD
	taste_description = "Uísque arredondado."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/sazerac
	name = "Sazerac"
	description = "Uísque feito aromático por absinto e crioulo amargos."
	boozepwr = 65
	color = "#f43f69"
	quality = DRINK_GOOD
	taste_description = "Uísque perfumado de anis"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/amaretto_sour
	name = "Amaretto Sour"
	description = "Um azedo feito com doce amaretto."
	boozepwr = 15
	color = "#ddc28b"
	quality = DRINK_VERYGOOD
	taste_description = "Doce limão espumante"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/ramos_gin_fizz
	name = "Ramos Gin Fizz"
	description = "Uma reviravolta complexa no conceito de um gim Fizz, adicionando creme e ovo branco ao longo do suco de limão lateral para uma experiência textural incomparável. Nesta versão, o uso da bebida de água de flor de laranjeira é substituído por uma gota de licor de laranja."
	boozepwr = 35
	color = "#f9e7c2"
	quality = DRINK_FANTASTIC
	taste_description = "Gin cítrico cremoso e fofo"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/french_75
	name = "French 75"
	description = "Um coquetel sofisticado feito fortalecendo champanhe com gim, depois saboreando suco de limão e açúcar."
	boozepwr = 30
	color = "#ffffc1"
	quality = DRINK_GOOD
	taste_description = "Glória e artilharia"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/sangria
	name = "Sangria"
	description = "Um ponche de vinho vermelho-sangue fortalecido com licor e adoçado com o máximo de frutas picadas que se pode pegar."
	boozepwr = 20
	color = "#c4383b"
	quality = DRINK_GOOD
	taste_description = "vinho frutado refrescante"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/suffering_bastard
	name = "Suffering Bastard"
	description = "Uma cura de ressaca estilo tiki feita de cerveja de gengibre, espíritos e amargos."
	boozepwr = 20
	color = "#e8ca78"
	quality = DRINK_VERYGOOD
	taste_description = "Recuperação com sabor de gengibre"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/suffering_bastard/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.apply_status_effect(/datum/status_effect/headache_soothed) //prevents headaches
	affected_mob.adjust_disgust(-5 * metabolization_ratio * seconds_per_tick) //removes disgust, same with sol dry
	if(affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, -0.5 * metabolization_ratio * seconds_per_tick * normalise_creation_purity(), required_organ_flag = affected_organ_flags)) //heals brain damage very slowly, about 12 damage per 5u
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/blue_blazer
	name = "Blue Blazer"
	description = "A bebida de um barman lendário do século 19. Embora lembrado de como ele inovou a arte de bartending, no final do dia esta bebida é realmente apenas quente e adoçado uísque."
	boozepwr = 25
	color = "#b5949b"
	quality = DRINK_NICE
	taste_description = "Whisky doce queimado"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/blue_blazer/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(25 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, 0, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/ethanol/hot_toddy
	name = "Hot Toddy"
	description = "Uma mistura aquecida de espíritos, açúcar e especiarias. Enquanto o conceito é antigo, esta preparação com conhaque e açúcar refinado é um pouco mais moderna."
	boozepwr = 25
	color = "#f2d2b4"
	quality = DRINK_GOOD
	taste_description = "o calor de uma lareira confortável"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/hot_toddy/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(25 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, 0, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/ethanol/tizirian_sour
	name = "Tizirian Sour"
	description = "Uma torção em uma trinidad azeda, usando néctar korta no lugar de orgia. Apesar do nome, foi inventado por um barman marciano."
	boozepwr = 35
	color = "#9b4b3a"
	quality = DRINK_VERYGOOD
	taste_description = "Adocicada e temperada amargura"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/daiquiri
	name = "Daiquiri"
	description = "De certa forma, o último coquetel tropical, muito poucas bebidas de rum não são de alguma forma descendentes deste clássico."
	boozepwr = 35
	color = "#b6d3a6"
	quality = DRINK_NICE
	taste_description = "Limão crocante"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/flip_cocktail
	name = "Flip Cocktail"
	description = "Uma adaptação simplificada e modernizada de uma bebida muito mais antiga que precede o Cocktail. Enquanto a versão mais antiga usava cerveja e era aquecida antes de ficar bêbada, esta versão está fria. A principal semelhança é o uso de um ovo inteiro."
	boozepwr = 30
	color = "#dddfca"
	quality = DRINK_GOOD
	taste_description = "Conhaque cremoso e noz-moscada"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/flip_cocktail/on_mob_metabolize(mob/living/drinker)
	. = ..()
	if(prob(10))
		drinker.emote("flip")

/datum/reagent/consumable/ethanol/aperitivo
	name = "Aperitivo Liqueur"
	description = "Um licor agressivamente agridoce com sabor de casca de cinchona e outros botânicos. Perfeito para estimular o apetite ou combater a malária."
	boozepwr = 40
	color = "#bf1038"
	taste_description = "intensa amargura citrinos"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/aperitivo/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, times_fired) //This and some of the cocktails it gets mixed into stimulate the apetite, as an aperitivo should
	. = ..()
	drinker.adjust_nutrition(-5 * REM * seconds_per_tick)
	drinker.overeatduration = 0

/datum/reagent/consumable/ethanol/herbal_liqueur
	name = "Herbal Liqueur"
	description = "Um licor feito com uma grande variedade de ervas e especiarias, infundido em espírito através de destilação e maceração. Tantos, na verdade, que tentar escolhê-los pelo cheiro e sabor parece quase impossível..."
	boozepwr = 75
	color = "#95be7d"
	quality = DRINK_NICE
	taste_description = "Confundindo herbáceas"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/maraschino
	name = "Maraschino Liqueur"
	description = "Um licor doce clássico feito de frutas, folhas e até ramos de cerejas azedas. Surpreendentemente, não tem muito gosto de cereja."
	boozepwr = 50
	color = "#DDDDDD"
	taste_description = "Doçura maluca."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bartenders_handshake
	name = "Bartender's Handshake"
	description = "Uma tradição de providências um pouco inconsistentes, possivelmente ligada a um obscuro esquema de marketing baseado em moedas de desafio, esta bebida é uma maneira para os bartenders cumprimentarem e testarem a coragem um do outro através de uma bebida que só um colega barman poderia apreciar. Embora haja quase tantas versões desta bebida quanto há bares, esta versão testa o paladar combinando dois dos ingredientes mais amargos que você pode encontrar em um bar."
	boozepwr = 50
	color = "#270101"
	quality = DRINK_VERYGOOD
	taste_description = "A amargura pretensiosa"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bartenders_handshake/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, times_fired) //Heals bartenders brute and burn, disgusts otherwise
	. = ..()
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	if(HAS_TRAIT(liver, TRAIT_BARTENDER_METABOLISM))
		if(drinker.heal_bodypart_damage(brute = 1 * REM * seconds_per_tick, burn = 1 * REM * seconds_per_tick, updating_health = FALSE))
			. = UPDATE_MOB_HEALTH
	else
		drinker.adjust_disgust(2 * REM * seconds_per_tick)

/datum/reagent/consumable/ethanol/brandy_crusta
	name = "Brandy Crusta"
	description = "O antepassado do Sidecar, este coquetel fortemente enfeitado é o avô de muitas bebidas essenciais servidas hoje."
	boozepwr = 30
	color = "#f8c51c"
	quality = DRINK_VERYGOOD
	taste_description = "Querida orange"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/casino
	name = "Casino"
	description = "Um clássico de gin-pesado. Juniper é temperado por pequenas quantidades de citrinos e adoçado com licor."
	boozepwr = 50
	color = "#fdee65"
	quality = DRINK_GOOD
	taste_description = "Doce zimbro"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/garibaldi //Makes revs resitant to wounds and fearless.
	name = "Garibaldi"
	description = "Nomeado para o general italiano do século 19, o esquema de cor laranja vermelha desta bebida imita as camisas daqueles que o seguiram em batalhas por todo o mundo."
	boozepwr = 15
	color = "#f77e2e"
	quality = DRINK_GOOD
	taste_description = "Laranjas amargas"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/garibaldi/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(IS_REVOLUTIONARY(drinker))
		//status effect has a duration of 5 seconds which gets refreshed by this, falls off on it's own in case of running out of drink or deconversion
		drinker.apply_status_effect(/datum/status_effect/rev_resilience)

/datum/reagent/consumable/ethanol/improved_whiskey
	name = "Improved Whiskey Cocktail"
	description = "O coquetel clássico de uísque melhorou com a adição de absinto e marasquino, além de trocar o típico enfeite de casca de laranja por limão."
	boozepwr = 65
	color = "#b8a385"
	quality = DRINK_VERYGOOD
	taste_description = "Uísque com cheiro de anis"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/jungle_bird
	name = "Jungle Bird"
	description = "Esta mistura final de tiki alavanca a combinação brilhante de licor amargo e suco de abacaxi para fazer um coquetel notavelmente bem equilibrado."
	boozepwr = 25
	color = "#da8370"
	quality = DRINK_VERYGOOD
	taste_description = "abacaxi e quinina"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_SUPERMATTER_SOOTHER) //If you have this in your system, you calm down the SM by being near it.

/datum/reagent/consumable/ethanol/last_word
	name = "Last Word"
	description = "Apesar de ter sido inventado na virada do século XX, esta bebida caiu na obscuridade até o renascimento do coquetel do início do século XXI, onde então passou a dominar bares e inspirar inúmeras reviravoltas em sua fórmula."
	boozepwr = 50
	color = "#dddfcaff"
	quality = DRINK_VERYGOOD
	taste_description = "Finalidade de ervas."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/last_word/expose_mob(mob/living/drinker, methods, reac_volume, show_message, touch_protection)
	. = ..()
	//Mutes people for 5 seconds on their first sip every 5 minutes. Requires ingest, you can't savor something that's injected into your eyes or whatever.
	if(!(methods & INGEST) || !iscarbon(drinker) || HAS_TRAIT(drinker, TRAIT_HAD_LAST_WORD))
		return

	ADD_TRAIT(drinker, TRAIT_HAD_LAST_WORD, type)
	to_chat(drinker, span_notice("Tire um momento para saborear sua bebida silenciosamente..."))
	drinker.set_silence_if_lower(5 SECONDS)
	addtimer(TRAIT_CALLBACK_REMOVE(drinker, TRAIT_HAD_LAST_WORD, type), 300 SECONDS)

/datum/reagent/consumable/ethanol/mary_pickford
	name = "Mary Pickford"
	description = "Nomeado em homenagem a uma estrela de cinema do início do século XX, este coquetel pega um perfil de sabor de rum e abacaxi e o apresenta de uma forma mais elegante e elegante do que normalmente se esperaria."
	boozepwr = 35
	color = "#f7b7a7ff"
	quality = DRINK_GOOD
	taste_description = "Abacaxi elegante"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/negroni //Aperitif that increases hunger
	name = "Negroni"
	description = "Um aperitivo italiano icônico, sua intensidade simples o coroa como talvez o último coquetel amargo. Supostamente recebeu o nome de um italiano que queria uma versão mais forte de um spritz e pediu ao bartender para substituir refrigerante por gim."
	boozepwr = 50
	color = "#cf0e00ff"
	quality = DRINK_GOOD
	taste_description = "Vermute agridoce"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/negroni/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, times_fired)
	. = ..()
	drinker.adjust_nutrition(-3 * REM * seconds_per_tick)
	drinker.overeatduration = 0

/datum/reagent/consumable/ethanol/nuclear_daiquiri
	name = "Nuclear daiquiri"
	description = "Overproof, funky, pote ainda rum e licor de ervas pega a elegância simples de um daiquiri cubano e vira-o em sua cabeça."
	boozepwr = 65
	color = "#22cc22"
	quality = DRINK_GOOD
	taste_description = "Hogo e ervas"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/nuclear_daiquiri_thermo
	name = "Thermonuclear Daiquiri"
	description = "Uma bebida para aqueles que gostam das coisas mais nojentas da vida, como rum de alta-éster e Cobalt 60."
	boozepwr = 80
	color = "#00dd00"
	quality = DRINK_FANTASTIC
	taste_description = "aproximadamente 3.6 Roentgen"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/nuclear_daiquiri_thermo/on_mob_add(mob/living/living_mob)
	. = ..()
	living_mob.apply_status_effect(/datum/status_effect/cherenkov_radiation) //makes the drinker glow blue, and rarely emit high-energy nuclear particles.

/datum/reagent/consumable/ethanol/nuclear_daiquiri_thermo/on_mob_delete(mob/living/living_mob)
	. = ..()
	living_mob.remove_status_effect(/datum/status_effect/cherenkov_radiation)

/datum/reagent/consumable/ethanol/nuclear_daiquiri_thermo/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_drugginess(100 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.set_jitter_if_lower(20 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.set_dizzy_if_lower(10 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/ethanol/poets_dream
	name = "Poet's Dream"
	description = "Este coquetel pega uma base clássica de martini e o transforma em um delicioso modo doce e herbal. As regras de Nanotrasen dizem para não beber antes de dormir, ou arriscar \"invasão onírica\", o que quer que isso signifique."
	boozepwr = 50
	color = "#d4b14f"
	quality = DRINK_GOOD
	taste_description = "Gin de ervas doce"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_HERETICAL_DREAMS) //Enables non-heretics to have heretical dreams

/datum/reagent/consumable/ethanol/pousse_cafe
	name = "Pousse Cafe"
	description = "Um coquetel esteticamente bonito feito com camadas cuidadosas e meticulosas de vários licores. Extremamente irritante de se fazer."
	boozepwr = 50
	color = "#93cf33"
	quality = DRINK_FANTASTIC
	taste_description = "uma cascata de licores variados"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	glass_price = DRINK_PRICE_HIGH

/datum/reagent/consumable/ethanol/spritz //Aperitif that increases hunger
	name = "Spritz" // If someone wants to add an elderflower spritz or something else like that, just rename this to spritz al bitter or whatever
	description = "Este aperitivo agridoce e refrescante traz à mente o belo pôr-do-sol de verão de Veneza."
	boozepwr = 20
	color = "#ee714b"
	quality = DRINK_GOOD
	taste_description = "Agridoce refresco"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/spritz/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, times_fired)
	. = ..()
	drinker.adjust_nutrition(-5 * REM * seconds_per_tick)
	drinker.overeatduration = 0

/datum/reagent/consumable/ethanol/vieux_carre
	name = "Vieux Carré"
	description = "Um dos melhores de muitos grandes coquetéis para sair de Nova Orleans, esta bebida honra o Bairro Francês da cidade tanto em nome como em gosto."
	boozepwr = 60
	color = "#b43110"
	quality = DRINK_VERYGOOD
	taste_description = "A hospitalidade crioula"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

#undef ALCOHOL_EXPONENT
#undef ALCOHOL_THRESHOLD_MODIFIER
