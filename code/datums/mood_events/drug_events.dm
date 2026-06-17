/datum/mood_event/high
	mood_change = 6
	description = "Woooow duudeeeeee... Estou viajando baaalls..."

/datum/mood_event/stoned
	mood_change = 6
	description = "Eu estou tão ooooooooooooooooo..."

/datum/mood_event/maintenance_high
	mood_change = 6
	description = "Estou no topo do mundo, baby! Maré mundial!"
	timeout = 2 MINUTES

/datum/mood_event/maintenance_high/add_effects(param)
	var/value = rand(-1, 6) // chance for it to suck
	mood_change = value
	if(value < 0)
		description = "Não! Não! Minhas luvas! Auuuurgh!"
	else
		description = initial(description)

/datum/mood_event/hang_over
	mood_change = -4
	description = "Tenho um assassino de ressaca!"
	timeout = 1 MINUTES

/datum/mood_event/smoked
	description = "Eu fumei recentemente."
	mood_change = 2
	timeout = 6 MINUTES

/datum/mood_event/wrong_brand
	description = "Odeio essa marca de cigarros."
	mood_change = -2
	timeout = 6 MINUTES

/datum/mood_event/overdose
	mood_change = -8
	timeout = 5 MINUTES

/datum/mood_event/overdose/add_effects(drug_name)
	description = "I think I took a bit too much of that [drug_name]!"

/datum/mood_event/withdrawal_light
	mood_change = -2

/datum/mood_event/withdrawal_light/add_effects(drug_name)
	description = "I could use some [drug_name]..."

/datum/mood_event/withdrawal_medium
	mood_change = -5

/datum/mood_event/withdrawal_medium/add_effects(drug_name)
	description = "I really need [drug_name]."

/datum/mood_event/withdrawal_severe
	mood_change = -8

/datum/mood_event/withdrawal_severe/add_effects(drug_name)
	description = "Oh god, I need some of that [drug_name]!"

/datum/mood_event/happiness_drug
	description = "Não consigo sentir nada..."
	mood_change = 50

/datum/mood_event/happiness_drug_good_od
	description = "Sim! Sim! SIM!!"
	mood_change = 100
	timeout = 30 SECONDS
	special_screen_obj = "mood_happiness_good"

/datum/mood_event/happiness_drug_bad_od
	description = "Não!"
	mood_change = -100
	timeout = 30 SECONDS
	special_screen_obj = "mood_happiness_bad"

/datum/mood_event/narcotic_medium
	description = "Sinto-me confortavelmente dormente."
	mood_change = 4
	timeout = 3 MINUTES

/datum/mood_event/narcotic_heavy
	description = "Sinto-me embrulhado em algodão!"
	mood_change = 9
	timeout = 3 MINUTES

/datum/mood_event/antinarcotic_medium
	description = "Queria estar dormente de novo!"
	mood_change = -4
	timeout = 3 MINUTES

/datum/mood_event/antinarcotic_heavy
	description = "Não! Faça o algodão voltar!"
	mood_change = -9
	timeout = 3 MINUTES

/datum/mood_event/stimulant_medium
	description = "Eu tenho tanta energia! Sinto que posso fazer qualquer coisa!"
	mood_change = 4
	timeout = 3 MINUTES

/datum/mood_event/stimulant_heavy
	description = "Eh ah AAAH! Ha ha ha ha ha! Uuuh."
	mood_change = 6
	timeout = 3 MINUTES

#define EIGENTRIP_MOOD_RANGE 10

/datum/mood_event/eigentrip
	description = "Troquei de lugar com uma versão de realidade alternativa de mim mesmo!"
	mood_change = 0
	timeout = 10 MINUTES

/datum/mood_event/eigentrip/add_effects(param)
	var/value = rand(-EIGENTRIP_MOOD_RANGE,EIGENTRIP_MOOD_RANGE)
	mood_change = value
	if(value < 0)
		description = "Troquei de lugar com uma versão de realidade alternativa de mim mesmo! Quero ir para casa!"
	else
		description = "Troquei de lugar com uma versão de realidade alternativa de mim mesmo! Embora este lugar seja muito melhor do que a minha antiga vida."

#undef EIGENTRIP_MOOD_RANGE

/datum/mood_event/nicotine_withdrawal_moderate
	description = "Faz tempo que não fumo. Sentindo-se um pouco nervoso..."
	mood_change = -5

/datum/mood_event/nicotine_withdrawal_severe
	description = "Cabeça batendo. Suor frio. Sentindo ansiedade. Preciso de um cigarro para se acalmar!"
	mood_change = -8

/datum/mood_event/hauntium_spirits
	description = "Sinto minha alma degradante!"
	mood_change = -8
	timeout = 8 MINUTES

/datum/mood_event/sadness_inverse
	description = "Estou tão triste..."
	mood_change = -150
	special_screen_obj = "mood_happiness_bad"
