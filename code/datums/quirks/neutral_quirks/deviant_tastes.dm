/datum/quirk/deviant_tastes
	name = "Deviant Tastes"
	desc = "Você não gosta de comida que a maioria das pessoas gostam, e acha delicioso o que elas não gostam."
	icon = FA_ICON_GRIN_TONGUE_SQUINT
	value = 0
	gain_text = span_notice("Você começa a desejar algo estranho.")
	lose_text = span_notice("Você sente vontade de comer comida normal novamente.")
	medical_record_text = "O paciente demonstra preferências nutricionais irregulares."
	mail_goodies = list(/obj/item/food/urinalcake, /obj/item/food/badrecipe) // Mhhhmmm yummy

/datum/quirk/deviant_tastes/add(client/client_source)
	var/obj/item/organ/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	var/liked_foodtypes = tongue.liked_foodtypes
	tongue.liked_foodtypes = tongue.disliked_foodtypes
	tongue.disliked_foodtypes = liked_foodtypes

/datum/quirk/deviant_tastes/remove()
	var/obj/item/organ/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.liked_foodtypes = initial(tongue.liked_foodtypes)
	tongue.disliked_foodtypes = initial(tongue.disliked_foodtypes)
