/datum/quirk/throwingarm
	name = "Throwing Arm"
	desc = "Seus braços têm muito peso para eles! Objetos que você joga sempre parecem voar mais longe do que os outros, e você nunca perde um lance."
	icon = FA_ICON_BASEBALL
	value = 7
	mob_trait = TRAIT_THROWINGARM
	gain_text = span_notice("Seus braços estão cheios de energia!")
	lose_text = span_danger("Seus braços doem um pouco.")
	medical_record_text = "O paciente tem domínio sobre atirar bolas."
	mail_goodies = list(/obj/item/toy/beach_ball/baseball, /obj/item/toy/basketball, /obj/item/toy/dodgeball)
