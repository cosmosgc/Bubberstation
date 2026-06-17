/datum/quirk/hypersensitive
	name = "Hypersensitive"
	desc = "Para melhor ou pior, tudo parece afetar seu humor mais do que deveria."
	icon = FA_ICON_FLUSHED
	value = -2
	gain_text = span_danger("Você parece fazer um grande negócio com tudo.")
	lose_text = span_notice("Você não parece mais fazer um grande negócio com tudo.")
	medical_record_text = "O paciente demonstra um alto nível de volatilidade emocional."
	medical_symptom_text = "Expõe respostas emocionais aumentadas aos estímulos,\
levando a um grande aumento de sensibilidade e reatividade em situações sociais."
	hardcore_value = 3
	mail_goodies = list(/obj/effect/spawner/random/entertainment/plushie_delux)
	quirk_flags = QUIRK_TRAUMALIKE

/datum/quirk/hypersensitive/add(client/client_source)
	if (quirk_holder.mob_mood)
		quirk_holder.mob_mood.mood_modifier += 0.5

/datum/quirk/hypersensitive/remove()
	if (quirk_holder.mob_mood)
		quirk_holder.mob_mood.mood_modifier -= 0.5
