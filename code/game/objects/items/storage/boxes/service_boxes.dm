// This file contains all boxes used by the Service department and its purpose on the station.
// Because we want to avoid some sort of "miscellaneous" file, let's put all the bureaucracy (pens and stuff) and the HoP's stuff here as well.

/obj/item/storage/box/drinkingglasses
	name = "box of drinking glasses"
	desc = "Tem uma foto de copos de bebida."
	illustration = "drinkglass"

/obj/item/storage/box/drinkingglasses/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/reagent_containers/cup/glass/drinkingglass(src)
/obj/item/storage/box/cups
	name = "box of paper cups"
	desc = "Tem fotos de copos de papel na frente."
	illustration = "cup"

/obj/item/storage/box/cups/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/cup/glass/sillycup(src)

//Some spare PDAs in a box
/obj/item/storage/box/pdas
	name = "spare PDAs"
	desc = "Uma caixa de microcomputadores de PDA."
	illustration = "pda"

/obj/item/storage/box/pdas/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/modular_computer/pda(src)

/obj/item/storage/box/ids
	name = "box of spare IDs"
	desc = "Tem tantas identidades vazias."
	illustration = "id"

/obj/item/storage/box/ids/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/card/id/advanced(src)
/obj/item/storage/box/silver_ids
	name = "box of spare silver IDs"
	desc = "Identidades brilhantes para pessoas importantes."
	illustration = "id"

/obj/item/storage/box/silver_ids/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/card/id/advanced/silver(src)

/obj/item/storage/box/mousetraps
	name = "box of Pest-B-Gon mousetraps"
	desc = span_alert("Mantenha fora do alcance das crianças.")
	illustration = "mousetrap"

/obj/item/storage/box/mousetraps/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/assembly/mousetrap(src)

/obj/item/storage/box/snappops
	name = "snap pop box"
	desc = "Oito embalagens de diversão! 8 anos e mais. Não é adequado para crianças."
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "spbox"
	illustration = ""
	storage_type = /datum/storage/box/snappops

/obj/item/storage/box/snappops/PopulateContents()
	for(var/i in 1 to 8)
		new /obj/item/toy/snappop(src)

/obj/item/storage/box/matches
	name = "matchbox"
	desc = "Uma pequena caixa de quase mas não bastante Plasma Premium Fósforos."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "matchbox"
	inhand_icon_state = "zippo"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	worn_icon_state = "lighter"
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_BELT
	drop_sound = 'sound/items/handling/matchbox_drop.ogg'
	pickup_sound = 'sound/items/handling/matchbox_pickup.ogg'
	custom_price = PAYCHECK_CREW * 0.4
	base_icon_state = "matchbox"
	illustration = null
	storage_type = /datum/storage/box/match

/obj/item/storage/box/matches/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ignites_matches)

/obj/item/storage/box/matches/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/match(src)

/obj/item/storage/box/matches/update_icon_state()
	. = ..()
	switch(length(contents))
		if(10)
			icon_state = base_icon_state
		if(5 to 9)
			icon_state = "[base_icon_state]_almostfull"
		if(1 to 4)
			icon_state = "[base_icon_state]_almostempty"
		if(0)
			icon_state = "[base_icon_state]_e"

/obj/item/storage/box/lights
	name = "box of replacement bulbs"
	desc = "Esta caixa é moldada por dentro para que apenas tubos de luz e lâmpadas se encaixem."
	inhand_icon_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	foldable_result = /obj/item/stack/sheet/cardboard //BubbleWrap
	illustration = "light"
	storage_type = /datum/storage/box/lights

/obj/item/storage/box/lights/bulbs/PopulateContents()
	for(var/i in 1 to 21)
		new /obj/item/light/bulb(src)

/obj/item/storage/box/lights/tubes
	name = "box of replacement tubes"
	illustration = "lighttube"

/obj/item/storage/box/lights/tubes/PopulateContents()
	for(var/i in 1 to 21)
		new /obj/item/light/tube(src)

/obj/item/storage/box/lights/mixed
	name = "box of replacement lights"
	illustration = "lightmixed"

/obj/item/storage/box/lights/mixed/PopulateContents()
	for(var/i in 1 to 14)
		new /obj/item/light/tube(src)
	for(var/i in 1 to 7)
		new /obj/item/light/bulb(src)

/obj/item/storage/box/fountainpens
	name = "box of fountain pens"
	illustration = "fpen"

/obj/item/storage/box/fountainpens/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/pen/fountain(src)

/obj/item/storage/box/dishdrive
	name = "DIY Dish Drive Kit"
	desc = "Contém tudo que você precisa para construir seu próprio Dish Drive!"
	custom_premium_price = PAYCHECK_CREW * 3

/obj/item/storage/box/dishdrive/PopulateContents()
	var/list/items_inside = list(
		/obj/item/circuitboard/machine/dish_drive = 1,
		/obj/item/screwdriver = 1,
		/obj/item/stack/cable_coil/five = 1,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/sheet/iron/five = 1,
		/obj/item/stock_parts/servo = 1,
		/obj/item/stock_parts/matter_bin = 2,
		/obj/item/wrench = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/actionfigure
	name = "box of action figures"
	desc = "O último conjunto de figuras de ação colecionáveis."
	icon_state = "box"

/obj/item/storage/box/actionfigure/PopulateContents()
	for(var/i in 1 to 4)
		var/random_figure = pick(subtypesof(/obj/item/toy/figure))
		new random_figure(src)

/obj/item/storage/box/tail_pin
	name = "pin the tail on the corgi supplies"
	desc = "Por 10 anos e para cima. Por que isso está em uma estação espacial? Você não é um pouco velho para jogos babby?" //Intentional typo.
	custom_price = PAYCHECK_COMMAND * 1.25

/obj/item/storage/box/tail_pin/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/poster/tail_board(src)
		new /obj/item/tail_pin(src)

/obj/item/storage/box/party_poppers
	name = "box of party poppers"
	desc = "Transforme qualquer evento em uma celebração e garanta que o zelador fique ocupado."

/obj/item/storage/box/party_poppers/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/spray/chemsprayer/party(src)

/obj/item/storage/box/balloons
	name = "box of long balloons"
	desc = "Uma caixa completamente aleatória e maluca de balões longos, colhida diretamente de fazendas de balões no planeta palhaço."
	illustration = "balloon"
	storage_type = /datum/storage/box/balloon

/obj/item/storage/box/balloons/PopulateContents()
	for(var/i in 1 to 24)
		new /obj/item/toy/balloon/long(src)

/obj/item/storage/box/stickers
	name = "sticker pack"
	desc = "Um pacote de adesivos removíveis. Removível? Que roubo!<br>Lá atrás,<b>Não dê ao palhaço!</b>é impresso em letras grandes."
	icon = 'icons/obj/toys/stickers.dmi'
	icon_state = "stickerpack"
	illustration = null
	w_class = WEIGHT_CLASS_TINY
	storage_type = /datum/storage/box/stickers

	var/static/list/pack_labels = list(
		"smile",
		"frown",
		"heart",
		"silentman",
		"tider",
		"star",
	)

/obj/item/storage/box/stickers/Initialize(mapload)
	. = ..()
	if(isnull(illustration))
		illustration = pick(pack_labels)
		update_appearance()

/obj/item/storage/box/stickers/proc/generate_non_contraband_stickers_list()
	var/list/allowed_stickers = list()

	for(var/obj/item/sticker/sticker_type as anything in subtypesof(/obj/item/sticker))
		if(!sticker_type::exclude_from_random)
			allowed_stickers += sticker_type

	return allowed_stickers

/obj/item/storage/box/stickers/PopulateContents()
	var/static/list/non_contraband

	if(isnull(non_contraband))
		non_contraband = generate_non_contraband_stickers_list()

	for(var/i in 1 to rand(4, 8))
		var/type = pick(non_contraband)
		new type(src)

/obj/item/storage/box/stickers/googly
	name = "googly eye sticker pack"
	desc = "Transformar tudo em algo vago vivo!"
	illustration = "googly-alt"

/obj/item/storage/box/stickers/googly/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/sticker/googly(src)

/// A box containing a skub, for easier carry because skub is a bulky item.
/obj/item/storage/box/stickers/skub
	name = "skub fan pack"
	desc = "Uma bolsa de vinil para guardar sua camisa de skub. Um rótulo no verso diz:\"Skubtide, Estação\"."
	icon_state = "skubpack"
	illustration = "label_skub"
	w_class = WEIGHT_CLASS_SMALL
	storage_type = /datum/storage/box/skub

/obj/item/storage/box/stickers/skub/PopulateContents()
	new /obj/item/skub(src)
	new /obj/item/sticker/skub(src)
	new /obj/item/sticker/skub(src)

/obj/item/storage/box/stickers/anti_skub
	name = "anti-skub stickers pack"
	desc = "O inimigo pode ter sido dado um pau e uma camisa, mas eu tenho mais adesivos! Além disso, o pacote pode segurar minha camisa anti-skub."
	icon_state = "skubpack"
	illustration = "label_anti_skub"
	storage_type = /datum/storage/box/anti_skub

/obj/item/storage/box/stickers/anti_skub/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/sticker/anti_skub(src)

/obj/item/storage/box/pinpointer_pairs
	name = "pinpointer pair box"

/obj/item/storage/box/pinpointer_pairs/PopulateContents()
	var/obj/item/pinpointer/pair/A = new(src)
	var/obj/item/pinpointer/pair/B = new(src)

	A.other_pair = B
	B.other_pair = A

/obj/item/storage/box/heretic_box
	name = "box of pierced realities"
	desc = "Uma caixa com brinquedos parecidos com realidades perfuradas."

/obj/item/storage/box/heretic_box/PopulateContents()
	for(var/i in 1 to rand(1,4))
		new /obj/item/toy/reality_pierce(src)


/obj/item/storage/box/purity_seal_box
	name = "box of purity seals"
	desc = "Uma caixa contendo vários selos de pureza abençoados."

/obj/item/storage/box/purity_seal_box/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/sticker/purity_seal(src)
		new /obj/item/sticker/purity_seal/purity_seal_2(src)

/obj/item/storage/box/stamps
	name = "box of stamps"
	desc = "Selos para todos os tipos de documentos."
	illustration = "stamp"
	custom_price = PAYCHECK_CREW

/obj/item/storage/box/stamps/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stamp/granted = 1,
		/obj/item/stamp/denied = 1,
		/obj/item/stamp/void = 1,
	)
	generate_items_inside(items_inside,src)
