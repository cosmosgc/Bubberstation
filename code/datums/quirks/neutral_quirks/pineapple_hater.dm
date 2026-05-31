/datum/quirk/pineapple_hater
	name = "Ananas Aversion"
	desc = "Você se acha muito detestável frutos do gênero Ananas. Sério, como alguém pode dizer que essas coisas são boas? E que tipo de louco se atreveria a colocar em uma pizza?"
	icon = FA_ICON_THUMBS_DOWN
	value = 0
	gain_text = span_notice("Você se vê pensando que tipo de idiota realmente gosta de abacaxis...")
	lose_text = span_notice("Seus sentimentos pelos abacaxis parecem voltar a um estado morno.")
	medical_record_text = "O paciente está certo em pensar que o abacaxi é nojento."
	mail_goodies = list( // basic pizza slices
		/obj/item/food/pizzaslice/margherita,
		/obj/item/food/pizzaslice/meat,
		/obj/item/food/pizzaslice/mushroom,
		/obj/item/food/pizzaslice/vegetable,
		/obj/item/food/pizzaslice/sassysage,
	)

/datum/quirk/pineapple_hater/add(client/client_source)
	var/obj/item/organ/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.disliked_foodtypes |= PINEAPPLE

/datum/quirk/pineapple_hater/remove()
	var/obj/item/organ/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.disliked_foodtypes = initial(tongue.disliked_foodtypes)
