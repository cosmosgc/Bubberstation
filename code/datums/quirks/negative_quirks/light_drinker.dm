/datum/quirk/light_drinker
	name = "Light Drinker"
	desc = "Você não aguenta suas bebidas e fica bêbado muito rápido."
	icon = FA_ICON_COCKTAIL
	value = -2
	mob_trait = TRAIT_LIGHT_DRINKER
	gain_text = span_notice("Só de pensar em beber álcool faz sua cabeça girar.")
	lose_text = span_danger("Você não é mais severamente afetado pelo álcool.")
	medical_record_text = "O paciente demonstra baixa tolerância ao álcool. (Wimp)"
	hardcore_value = 3
	mail_goodies = list(/obj/item/reagent_containers/cup/glass/waterbottle)
