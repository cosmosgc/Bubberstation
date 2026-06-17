/datum/quirk/vegetarian
	name = "Vegetarian"
	desc = "Você acha a idéia de comer carne moralmente e fisicamente repulsiva."
	icon = FA_ICON_CARROT
	value = 0
	gain_text = span_notice("Sente repulsa com a ideia de comer carne.")
	lose_text = span_notice("Você sente que comer carne não é tão ruim.")
	medical_record_text = "O paciente relata uma dieta vegetariana."
	mail_goodies = list(/obj/effect/spawner/random/food_or_drink/salad)
	mob_trait = TRAIT_VEGETARIAN
