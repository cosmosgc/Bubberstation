/obj/item/card/id/faction_guest
	name = "guest card"
	access = list(ACCESS_FACTION_PUBLIC)

/obj/item/card/id/faction_crew
	name = "crew card"
	access = list(ACCESS_FACTION_PUBLIC, ACCESS_FACTION_CREW)

/obj/item/card/id/faction_command
	name = "command card"
	access = list(ACCESS_FACTION_PUBLIC, ACCESS_FACTION_CREW, ACCESS_FACTION_COMMAND)
	icon_state = "card_silver"
	inhand_icon_state = "silver_id"

/obj/item/card/faction_access
	name = "faction access card"
	desc = "Um cartão pequeno, que quando usado em qualquer identificação, adicionará acesso à facção. Este está vazio."
	icon_state = "data_1"
	var/list/extra_access

/obj/item/card/faction_access/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/obj/item/card/id/id = interacting_with
	if(!istype(id))
		return NONE
	if(extra_access)
		for(var/acs in extra_access)
			id.access |= acs
	to_chat(user, span_notice("You upgrade [id] with extra access."))
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/card/faction_access/guest
	name = "faction guest access card"
	desc = "Um pequeno cartão, que quando usado em qualquer identificação, adicionará acesso aos hóspedes, que permite entrar em salas, áreas de estar, cozinhas e bares."
	extra_access = list(ACCESS_FACTION_PUBLIC)

/obj/item/card/faction_access/crew
	name = "faction crew access card"
	desc = "Um cartão pequeno, que quando usado em qualquer identificação, adicionará acesso à tripulação, que permite entrar na maioria das áreas, impedindo o comando."
	extra_access = list(ACCESS_FACTION_PUBLIC, ACCESS_FACTION_CREW)
	color = "#BA7"

/obj/item/card/faction_access/command
	name = "faction command access card"
	desc = "Um cartão pequeno, que quando usado em qualquer identificação, adicionará acesso a todas as facções."
	extra_access = list(ACCESS_FACTION_PUBLIC, ACCESS_FACTION_CREW, ACCESS_FACTION_COMMAND)
	color = "#DDF"

/obj/item/storage/box/faction_access_cards
	name = "box of access chips"
	desc = "Caso queira recrutar pessoas. Mantenha isso seguro."

/obj/item/storage/box/faction_access_cards/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/card/faction_access/guest(src)
	for(var/i in 1 to 3)
		new /obj/item/card/faction_access/crew(src)
	new /obj/item/card/faction_access/command(src)
	for(var/i in 1 to 4)
		new /obj/item/encryptionkey/headset_faction(src)
