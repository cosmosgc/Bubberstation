// Modular DRINK REAGENTS, see the following file for the mixes: modular_skyrat\modules\customization\modules\food_and_drinks\recipes\drinks_recipes.dm

/datum/reagent/consumable/pinkmilk
	name = "Strawberry Milk"
	description = "Uma bebida de uma era passada de leite e adoçante artificial em uma rocha."
	color = "#f76aeb"//rgb(247, 106, 235)
	quality = DRINK_VERYGOOD
	taste_description = "morango doce e creme de leite"

/datum/glass_style/drinking_glass/pinkmilk
	required_drink_type = /datum/reagent/consumable/pinkmilk
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "pinkmilk"
	name = "tall glass of strawberry milk"
	desc = "Delicioso sabor de xarope de morango misturado com leite."

/datum/reagent/consumable/pinkmilk/on_mob_life(mob/living/carbon/M)
	if(prob(15))
		to_chat(M, span_notice("[pick("You cant help to smile.","You feel nostalgia all of sudden.","You remember to relax.")]"))
	..()
	. = 1

/datum/reagent/consumable/pinktea //Tiny Tim song
	name = "Strawberry Tea"
	description = "Um clássico atemporal!"
	color = "#f76aeb"//rgb(247, 106, 235)
	quality = DRINK_VERYGOOD
	taste_description = "Chá doce com um toque de morango"

/datum/glass_style/drinking_glass/pinktea
	required_drink_type = /datum/reagent/consumable/pinktea
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "pinktea"
	name = "mug of strawberry tea"
	desc = "Delicioso chá tradicional com sabor de morango."

/datum/reagent/consumable/pinktea/on_mob_life(mob/living/carbon/M)
	if(prob(10))
		to_chat(M, span_notice("[pick("Diamond skies where white deer fly.","Sipping strawberry tea.","Silver raindrops drift through timeless, Neverending June.","Crystal ... pearls free, with love!","Beaming love into me.")]"))
	..()
	. = TRUE

/datum/reagent/consumable/catnip_tea
	name = "Catnip Tea"
	description = "Um chá de gato sonolento e saboroso!"
	color = "#101000" // rgb: 16, 16, 0
	taste_description = "açúcar e erva de gato."

/datum/glass_style/drinking_glass/catnip_tea
	required_drink_type = /datum/reagent/consumable/catnip_tea
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "catnip_tea"
	name = "glass of catnip tea"
	desc = "Uma bebida ronronada para um gato."

/datum/reagent/consumable/catnip_tea/on_mob_life(mob/living/carbon/M)
	M.adjust_stamina_loss(min(50 - M.get_stamina_loss(), 3))
	if(isfeline(M))
		if(prob(20))
			M.emote("nya")
		if(prob(20))
			to_chat(M, span_notice("[pick("Headpats feel nice.", "Backrubs would be nice.", "Mew")]"))
	else
		to_chat(M, span_notice("[pick("I feel oddly calm.", "I feel relaxed.", "Mew?")]"))
	..()

/datum/reagent/consumable/ethanol/beerbatter
	name = "Beer Batter"
	description = "Provavelmente não é a melhor ideia para beber."
	color = "#f5f4e9"
	nutriment_factor = 2 * REAGENTS_METABOLISM
	taste_description = "Farinha e bebida barata."
	boozepwr = 8 // beer diluted at about a 1:3 ratio
	ph = 6

/datum/glass_style/drinking_glass/beerbatter
	required_drink_type = /datum/reagent/consumable/ethanol/beerbatter
	icon = 'icons/obj/drinks/shakes.dmi'
	icon_state = "chocolatepudding"
	name = "glass of beer batter"
	desc = "Usado em cozinha, colesterol puro, pessoas escocesas comem."

/datum/reagent/consumable/liz_fizz
	name = "Liz Fizz"
	description = "Tripla camada de citrinos com sorvete e sorvete."
	color = "#D8FF59"
	quality = DRINK_NICE
	taste_description = "Cérebro congelando azedo"
