/datum/quirk/waddle
	name = "Waddle"
	desc = "Seus movimentos sempre tiveram um pouco mais de movimento para eles."
	medical_record_text = "O sujeito parece ser terrível dançando."
	value = 0
	icon = FA_ICON_WIND
	gain_text = span_notice("Você sente vontade de andar bobo")
	lose_text = span_notice("Você não sente mais vontade de andar bobo")
	quirk_flags = QUIRK_HUMAN_ONLY
	mail_goodies = list(/obj/item/food/grown/banana)


/datum/quirk/waddle/add(client/client_source)
	. = ..()
	quirk_holder.AddElementTrait(TRAIT_WADDLING, QUIRK_TRAIT, /datum/element/waddling)

/datum/quirk/waddle/remove()
	. = ..()
	quirk_holder.RemoveElement(/datum/element/waddling)
