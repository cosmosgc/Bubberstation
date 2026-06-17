/datum/quirk/voracious
	name = "Voracious"
	desc = "Nada fica entre você e sua comida. Você come mais rápido e pode comer porcaria! Ser gordo combina com você."
	icon = FA_ICON_DRUMSTICK_BITE
	value = 4
	mob_trait = TRAIT_VORACIOUS
	gain_text = span_notice("Você se sente feliz.")
	lose_text = span_danger("Você não se sente mais Hongry.")
	medical_record_text = "O paciente aprecia comida e bebida acima da média."
	mail_goodies = list(/obj/effect/spawner/random/food_or_drink/dinner)
