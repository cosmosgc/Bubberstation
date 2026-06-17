/obj/item/disk/nifsoft_uploader/summoner/book
	name = "Grimoire Akasha"
	loaded_nifsoft = /datum/nifsoft/summoner/book

/datum/nifsoft/summoner/book
	name = "Grimoire Akasha"
	program_desc = "Grimoire Akasha é um garfo do Grimoire Caeruleam NIFSoft que é projetado em torno de dar ao usuário acesso a vários livros educacionais de luz dura.\
Devido à sua natureza educacional e tamanho minúsculo, Grimoire Akasha é normalmente fornecido gratuitamente no máximo mercados NIFSoft."
	summonable_items = list()
	purchase_price = 0 // This is a tool intended to help out newer players.
	max_summoned_items = 2
	buying_category = NIFSOFT_CATEGORY_INFORMATION
	ui_icon = "book"

/datum/nifsoft/summoner/book/New()
	. = ..()
	summonable_items += subtypesof(/obj/item/book/manual/wiki) //That's right! all of the manual books!

/datum/nifsoft/summoner/book/apply_custom_properties(obj/item/book/generated_book)
	if(!istype(generated_book))
		return FALSE

	generated_book.cannot_carve = TRUE
	return TRUE

// Need this code here so that we don't have people carving out the summoned books
/obj/item/book
	/// Is the parent book unable to be carved? TRUE prevents carving. By default this is unset
	var/cannot_carve

/obj/item/book/carving_act(mob/living/user, obj/item/tool)
	if(cannot_carve)
		balloon_alert(user, "incapaz de ser esculpido!")
		return ITEM_INTERACT_BLOCKING

	return ..()
