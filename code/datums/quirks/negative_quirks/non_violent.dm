/datum/quirk/nonviolent
	name = "Pacifist"
	desc = "Pensar em violência te deixa doente. Tanto que não pode machucar ninguém."
	icon = FA_ICON_PEACE
	value = -8
	mob_trait = TRAIT_PACIFISM
	gain_text = span_danger("Você se sente repelido pelo pensamento de violência!")
	lose_text = span_notice("Acha que pode se defender de novo.")
	medical_record_text = "O paciente é anormalmente pacifista e não pode causar danos físicos."
	hardcore_value = 6
	mail_goodies = list(/obj/effect/spawner/random/decoration/flower, /obj/effect/spawner/random/contraband/cannabis) // flower power
