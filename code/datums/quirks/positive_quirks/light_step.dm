/datum/quirk/light_step
	name = "Light Step"
	desc = "Você anda com um passo suave, passos e pisar em objetos afiados é mais silencioso e menos doloroso. Além disso, suas mãos e roupas não vão ficar bagunçadas em caso de pisar em sangue."
	icon = FA_ICON_SHOE_PRINTS
	value = 4
	mob_trait = TRAIT_LIGHT_STEP
	gain_text = span_notice("Você anda com um pouco mais de lithness.")
	lose_text = span_danger("Você começa a andar como um bárbaro.")
	medical_record_text = "A destreza do paciente desmente uma forte capacidade de furtividade."
	mail_goodies = list(/obj/item/clothing/shoes/sandal)
