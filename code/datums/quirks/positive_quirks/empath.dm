/datum/quirk/empath
	name = "Empath"
	desc = "Se é um sexto sentido ou um estudo cuidadoso da linguagem corporal, só leva um rápido olhar para alguém para entender como se sente."
	icon = FA_ICON_SMILE_BEAM
	value = 6 // SKYRAT EDIT CHANGE - Quirk Rebalance - Original: value = 8
	gain_text = span_notice("Você se sente em sintonia com aqueles ao seu redor.")
	lose_text = span_danger("Você se sente isolado dos outros.")
	medical_record_text = "O paciente é muito perceptivo e sensível a pistas sociais, ou pode ter ESP. Mais testes necessários."
	mail_goodies = list(/obj/item/toy/foamfinger)

/datum/quirk/empath/add(client/client_source)
	quirk_holder.AddComponentFrom(REF(src), /datum/component/empathy)

/datum/quirk/empath/remove(client/client_source)
	quirk_holder.RemoveComponentSource(REF(src), /datum/component/empathy)
