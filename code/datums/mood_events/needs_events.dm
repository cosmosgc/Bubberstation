//nutrition
/datum/mood_event/fat
	description = "<B>Estou tão gordo...</B>" //muh fatshaming
	mood_change = -6

/datum/mood_event/too_wellfed
	description = "Acho que comi demais."
	mood_change = 0

/datum/mood_event/wellfed
	description = "Estou cheio!"
	mood_change = 8

/datum/mood_event/fed
	description = "Recentemente tive algum alimento."
	mood_change = 5

/datum/mood_event/hungry
	description = "Estou um pouco com fome."
	mood_change = -3

/datum/mood_event/hungry_very
	description = "Estou com fome!"
	mood_change = -6

/datum/mood_event/starving
	description = "Estou morrendo de fome!"
	mood_change = -10

//charge
/datum/mood_event/supercharged
	description = "Não consigo mais manter todo esse poder dentro de mim, preciso liberar um pouco rapidamente!"
	mood_change = -10

/datum/mood_event/overcharged
	description = "Sinto-me perigosamente carregado, talvez eu deveria liberar algum poder."
	mood_change = -4

/datum/mood_event/charged
	description = "Sinto o poder nas minhas veias!"
	mood_change = 6

/datum/mood_event/lowpower
	description = "Meu poder está baixo, devo ir carregar em algum lugar."
	mood_change = -6

/datum/mood_event/decharged
	description = "Preciso urgentemente de eletricidade!"
	mood_change = -10

//Disgust
/datum/mood_event/gross
	description = "Vi algo repugnante."
	mood_change = -4

/datum/mood_event/verygross
	description = "Acho que vou vomitar..."
	mood_change = -6

/datum/mood_event/disgusted
	description = "Deus, isso é desagradável..."
	mood_change = -8

/datum/mood_event/disgust/bad_smell
	description = "Percebo um cheiro horrivelmente putrefato dentro desse quarto."
	mood_change = -6

/datum/mood_event/disgust/nauseating_stench
	description = "O cheiro de carcaças podres é insofismável!"
	mood_change = -12

/datum/mood_event/disgust/dirty_food
	description = "Isso era tão sujo que não valia a pena comer..."
	mood_change = -6
	timeout = 4 MINUTES

/datum/mood_event/disgust/dirty_food/add_effects(...)
	if(HAS_PERSONALITY(owner, /datum/personality/ascetic))
		mood_change *= 0.25
		description = "A comida era suja, mas comestível."
	if(HAS_PERSONALITY(owner, /datum/personality/gourmand))
		mood_change *= 1.5
		description = "A comida era imunda, foi feita em uma lixeira?!"

//Generic needs events
/datum/mood_event/shower
	description = "Recentemente tive uma boa banho."
	mood_change = 4
	timeout = 5 MINUTES

/datum/mood_event/shower/add_effects(shower_reagent)
	if(istype(shower_reagent, /datum/reagent/blood))
		if(HAS_TRAIT(owner, TRAIT_MORBID) || HAS_TRAIT(owner, TRAIT_EVIL) || (owner.mob_biotypes & MOB_UNDEAD))
			description = "O sentimento de um banho sangrento foi agradável."
			mood_change = 6 // you sicko
		else
			description = "Recentemente tive um banho horrível com sangue caindo!"
			mood_change = -4
			timeout = 3 MINUTES
	else if(istype(shower_reagent, /datum/reagent/water))
		if(HAS_TRAIT(owner, TRAIT_WATER_HATER) && !HAS_TRAIT(owner, TRAIT_WATER_ADAPTATION))
			description = "Odio estar molhado!"
			mood_change = -2
			timeout = 3 MINUTES
		else
			return // just normal clean shower
	else // it's dirty ass water
		description = "Recentemente tive um banho sujo!"
		mood_change = -3
		timeout = 3 MINUTES

/datum/mood_event/hot_spring
	description = "É tão relaxante tomar banho em água vaporosa..."
	mood_change = 5

/datum/mood_event/hot_spring_hater
	description = "Não, não, não, não! Não quero tomar banho!,"
	mood_change = -2

/datum/mood_event/hot_spring_left
	description = "Foi um banho agradável."
	mood_change = 4
	timeout = 4 MINUTES

/datum/mood_event/hot_spring_hater_left
	description = "Odiar banhos! E odiar como ficam frios quando saio deles!"
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/fresh_laundry
	description = "Nada é tão bom quanto o sentimento de uma roupa limpa recém-lavada."
	mood_change = 2
	timeout = 10 MINUTES

/datum/mood_event/surrounded_by_silicon
	description = "Estou cercado por formas de vida perfeitas!!"
	mood_change = 8

/datum/mood_event/around_many_silicon
	description = "Tanto silício vivo perto de mim!"
	mood_change = 4

/datum/mood_event/around_silicon
	description = "As formas de silício próximas a mim são absolutamente perfeitas."
	mood_change = 2

/datum/mood_event/around_organic
	description = "Os organismos próximos a mim lembram-me da inferioridade do corpo orgânico."
	mood_change = -2

/datum/mood_event/around_many_organic
	description = "Tanto organismo repugnante!"
	mood_change = -4

/datum/mood_event/surrounded_by_organic
	description = "Estou cercado por organismos repugnantes!!"
	mood_change = -8

/datum/mood_event/completely_robotic
	description = "Abandonei meu fraco corpo orgânico, minha forma é perfeita!!"
	mood_change = 8

/datum/mood_event/very_robotic
	description = "Sou mais robô do que orgânico!"
	mood_change = 4

/datum/mood_event/balanced_robotic
	description = "Sou parte máquina, parte orgânica."
	mood_change = 0

/datum/mood_event/very_organic
	description = "Odiar este corpo fraco e frágil!"
	mood_change = -4

/datum/mood_event/completely_organic
	description = "Sou completamente orgânico, isso é miserável!!"
	mood_change = -8
