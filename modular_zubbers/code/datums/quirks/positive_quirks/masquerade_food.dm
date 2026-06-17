/datum/quirk/masquerade_food
	name = "Masquerade"
	desc = "Um hemofago que se adaptou para consumir comida e bebida normais. Tal ato é meramente para o prazer, pois não derivam nenhum benefício nutricional de tal."
	icon = FA_ICON_PIZZA_SLICE
	value = 2
	mob_trait = TRAIT_MASQUERADE_FOOD
	gain_text = span_notice("Você sente que seu corpo se adaptou ao consumo de comida e bebida normais sem se misturar com sangue.")
	lose_text = span_danger("Você sente que seu corpo não é mais capaz de consumir comida ou bebida normais sem se misturar com sangue.")
	medical_record_text = "O paciente é capaz de consumir comida ou bebida sem ter que se misturar com sangue, embora não obtenham nenhum benefício nutricional."
	species_whitelist = list(SPECIES_HEMOPHAGE)
