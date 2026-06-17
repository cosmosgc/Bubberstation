/datum/language/drone
	name = "Drone"
	desc = "Um fluxo de coordenação de controle de danos fortemente codificado, com bandeiras especiais para chapéus."
	spans = list(SPAN_ROBOT)
	key = "d"
	flags = NO_STUTTER
	syllables = list(".", "|")
	// ...|..||.||||.|.||.|.|.|||.|||
	space_chance = 0
	sentence_chance = 0
	between_word_sentence_chance = 0
	between_word_space_chance = 0
	additional_syllable_low = 0
	additional_syllable_high = 0
	default_priority = 20

	icon_state = "drone"
	always_use_default_namelist = TRUE // Nonsense language
