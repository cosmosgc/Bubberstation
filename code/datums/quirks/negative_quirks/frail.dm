/datum/quirk/frail
	name = "Frail"
	desc = "Você tem pele de papel e ossos de vidro! Você sofre feridas muito mais facilmente do que a maioria."
	icon = FA_ICON_SKULL
	value = -6
	mob_trait = TRAIT_EASILY_WOUNDED
	gain_text = span_danger("Você se sente frágil.")
	lose_text = span_notice("Você se sente resistente de novo.")
	medical_record_text = "O paciente é absurdamente fácil de ferir. Por favor, faça toda a diligência para evitar possíveis processos por negligência."
	hardcore_value = 4
	mail_goodies = list(/obj/effect/spawner/random/medical/minor_healing)
