/datum/mood_event/drankblood
	description = "<span class='nicegreen'>Alimentei-me avidamente daquilo que me alimenta.</span>\n"
	mood_change = 10
	timeout = 8 MINUTES

/datum/mood_event/drankblood_bad
	description = "<span class='boldwarning'>Eu bebi o sangue de uma criatura menor. Nojento.</span>\n"
	mood_change = -4
	timeout = 3 MINUTES

/datum/mood_event/drankblood_dead
	description = "<span class='boldwarning'>Eu bebia sangue morto. Eu sou melhor que isso.</span>\n"
	mood_change = -7
	timeout = 8 MINUTES

/datum/mood_event/drankblood_synth
	description = "<span class='boldwarning'>Bebi sangue sintético. Qual é o meu problema?</span>\n"
	mood_change = -7
	timeout = 8 MINUTES

/datum/mood_event/drankkilled
	description = "<span class='boldwarning'>Eu me alimentei de uma pessoa morta. Eu me sinto... menos humano.</span>\n"
	mood_change = -15
	timeout = 10 MINUTES

/datum/mood_event/madevamp
	description = "<span class='boldwarning'>Um mortal chegou a uma apoteose... sem morte... por minha própria mão.</span>\n"
	mood_change = 15
	timeout = 20 MINUTES

/datum/mood_event/coffinsleep
	description = "<span class='nicegreen'>Dormi num caixão durante o dia. Me sinto inteiro de novo.</span>\n"
	mood_change = 10
	timeout = 6 MINUTES

/datum/mood_event/coffinsleep/quirk
	mood_change = 4

/datum/mood_event/daylight_bad_sleep
	description = "<span class='boldwarning'>Dormi mal num caixão improvisado durante o dia.</span>\n"
	mood_change = -3
	timeout = 6 MINUTES

/datum/mood_event/daylight_sun_scorched
	description = "<span class='boldwarning'>Eu fui queimado pelos raios impiedosos do sol.</span>\n"
	mood_change = -6
	timeout = 6 MINUTES

///Candelabrum's mood event to non Bloodsucker/Ghouls
/datum/mood_event/vampcandle
	description = "<span class='boldwarning'>Algo está deixando sua mente... solta.</span>\n"
	mood_change = -15
	timeout = 5 MINUTES

/datum/mood_event/nosferatu_examined
	mood_change = -10
	timeout = 5 MINUTES

/datum/mood_event/nosferatu_examined/add_effects(target, level = 0)
	description = span_danger("You feel a deep sense of revulsion at the sight of [target].")
	mood_change = level * -5
