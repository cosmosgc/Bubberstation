/datum/mood_event/drunk
	mood_change = 3
	description = "Tudo parece melhor depois de uma ou duas bebidas."
	/// The blush overlay to display when the owner is drunk
	var/datum/bodypart_overlay/simple/emote/blush_overlay
/datum/mood_event/drunk/add_effects(drunkness)
	update_change(drunkness)
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/human_owner = owner
	blush_overlay = human_owner.give_emote_overlay(/datum/bodypart_overlay/simple/emote/blush)
/// Updates the description and value of the moodlet according to the passed drunkness value
/// (Does not add to or remove from the current level - it will sets it directly to the new value)
/datum/mood_event/drunk/proc/update_change(drunkness = 0)
	var/old_mood = mood_change
	switch(drunkness)
		if(0 to 30)
			mood_change = 3
			description = "Tudo parece melhor depois de uma ou duas bebidas."
		if(30 to 45)
			mood_change = 4
			description = "Está ficando mais quente, ou é só eu? Preciso de outra bebida para refrescar."
		if(45 to 60)
			mood_change = 5
			description = "Quem está mexendo no chão? Vou falar com eles... depois desta bebida."
		if(60 to 90)
			mood_change = 6
			description = "Eu não estou bêbado, você está! Na verdade... preciso de outra bebida!"
		if(90 to INFINITY)
			mood_change = 3 // crash out
			description = "Você é meu MELHOR amigo... Você e eu contra o mundo, cara. Vamos pegar outra bebida."
	if(HAS_PERSONALITY(owner, /datum/personality/teetotal))
		mood_change *= -1.5
		description = "Eu não gosto de beber... Faz-me sentir horrível."
	if(HAS_PERSONALITY(owner, /datum/personality/bibulous))
		mood_change *= 1.5
	if(old_mood != mood_change)
		owner.mob_mood.update_mood()
/datum/mood_event/drunk/remove_effects()
	QDEL_NULL(blush_overlay)
/datum/mood_event/drunk_after
	mood_change = 2
	description = "O efeito pode ter passado, mas ainda me sinto bem."
	timeout = 5 MINUTES
/datum/mood_event/wrong_brandy
	description = "Eu odeio esse tipo de bebida."
	mood_change = -2
	timeout = 6 MINUTES
/datum/mood_event/quality_revolting
	description = "Essa bebida foi a pior coisa que já bebi."
	mood_change = -8
	timeout = 7 MINUTES
/datum/mood_event/quality_nice
	description = "Essa bebida não era ruim de jeito nenhum."
	mood_change = 2
	timeout = 7 MINUTES
/datum/mood_event/quality_good
	description = "Essa bebida estava bastante boa."
	mood_change = 4
	timeout = 7 MINUTES
/datum/mood_event/quality_verygood
	description = "Essa bebida foi incrível!"
	mood_change = 6
	timeout = 7 MINUTES
/datum/mood_event/quality_fantastic
	description = "Essa bebida foi maravilhosa!"
	mood_change = 8
	timeout = 7 MINUTES
/datum/mood_event/amazingtaste
	description = "Sabor incrível!"
	mood_change = 50
	timeout = 10 MINUTES
/datum/mood_event/wellcheers
	description = "Que lata de Wellcheers deliciosa! O sabor de uva salgado é um ótimo revigorante."
	mood_change = 3
	timeout = 7 MINUTES
/datum/mood_event/sweetcoffee
	description = "O sabor amargo e doce do café não foi tão ruim."
	mood_change = 2
	timeout = 5 MINUTES
/datum/mood_event/sweettea
	description = "Deixe suas preocupações dissolverem como açúcar no chá."
	mood_change = 4
	timeout = 2.5 MINUTES
