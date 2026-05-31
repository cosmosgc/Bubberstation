/datum/mood_event/brushed
	description = span_nicegreen("Alguém escovou meu cabelo recentemente, foi ótimo!\n")
	mood_change = 3
	timeout = 4 MINUTES

/datum/mood_event/brushed/add_effects(mob/brusher)
	description = span_nicegreen("[brusher? brusher.name : "I"]Escovou meu cabelo recentemente, foi ótimo!\n")

/datum/mood_event/brushed/self
	description = span_nicegreen("Escovei meu cabelo recentemente!\n")
	mood_change = 2		// You can't hit all the right spots yourself, or something

/datum/mood_event/brushed/pet/add_effects(mob/brushed_pet)
	description = span_nicegreen("Eu escovei[brushed_pet]Recentemente, eles são tão fofos!\n")
