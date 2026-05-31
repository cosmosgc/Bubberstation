/obj/item/clothing/head/domina_cap
	name = "dominant cap"
	desc = "Para tipos especiais de inspeções."
	icon_state = "dominacap"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_hats.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_hats.dmi'
	supports_variations_flags = NONE

//message when equipping that thing
/obj/item/clothing/head/domina_cap/equipped(mob/living/carbon/user, slot)
	. = ..()
	if(src == user.head)
		to_chat(user, span_purple("Você se sente muito mais determinada."))

//message when unequipping that thing
/obj/item/clothing/head/domina_cap/dropped(mob/living/carbon/user)
	. = ..()
	if(src == user.head)
		to_chat(user, span_purple("Sessão BDSM terminou, hein?"))
