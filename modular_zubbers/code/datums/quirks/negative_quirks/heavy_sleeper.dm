// re-adds heavy sleeper
/datum/quirk/heavy_sleeper
	name = "Heavy Sleeper"
	desc = "Você dorme como uma pedra! Sempre que dorme ou fica inconsciente, demora um pouco mais para acordar."
	icon = FA_ICON_FACE_TIRED
	value = -2
	mob_trait = TRAIT_HEAVY_SLEEPER
	gain_text = span_danger("Você está com sono.")
	lose_text = span_notice("Você se sente acordado novamente.")
	medical_record_text = "O paciente tem resultados anormais do estudo do sono e é difícil acordar."
	hardcore_value = 2
	mail_goodies = list(
		/obj/item/clothing/glasses/blindfold,
		/obj/effect/spawner/random/bedsheet/any,
		/obj/item/clothing/under/misc/pj/red,
		/obj/item/clothing/head/costume/nightcap/red,
		/obj/item/clothing/under/misc/pj/blue,
		/obj/item/clothing/head/costume/nightcap/blue,
		/obj/item/pillow/random,
	)
