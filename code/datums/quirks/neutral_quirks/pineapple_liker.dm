/datum/quirk/pineapple_liker
	name = "Ananas Affinity"
	desc = "Você está gostando muito das frutas do gênero Ananas. Você nunca se cansa de sua doce bondade!"
	icon = FA_ICON_THUMBS_UP
	value = 0
	gain_text = span_notice("Você sente um intenso desejo por abacaxi.")
	lose_text = span_notice("Seus sentimentos pelos abacaxis parecem voltar a um estado morno.")
	medical_record_text = "O paciente demonstra um amor patológico pelo abacaxi."
	mail_goodies = list(/obj/item/food/pizzaslice/pineapple)

/datum/quirk/pineapple_liker/add(client/client_source)
	var/obj/item/organ/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.liked_foodtypes |= PINEAPPLE

/datum/quirk/pineapple_liker/remove()
	var/obj/item/organ/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.liked_foodtypes = initial(tongue.liked_foodtypes)
