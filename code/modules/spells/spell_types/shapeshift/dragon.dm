
/datum/action/cooldown/spell/shapeshift/dragon
	name = "Dragon Form"
	desc = "Assuma a forma de um menor bolo de cinzas."
	invocation = span_danger("<b>%CASTER</b> lets out a mighty roar!")
	invocation_self_message = span_danger("Você deixou sair um grande rugido!")
	invocation_type = INVOCATION_EMOTE
	spell_requirements = NONE

	possible_shapes = list(/mob/living/simple_animal/hostile/megafauna/dragon/lesser)
