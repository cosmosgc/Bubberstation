/*
Reproductive extracts:
	When fed three monkey cubes, produces between
	1 and 4 normal slime extracts of the same colour.
*/


/obj/item/slimecross/reproductive
	name = "reproductive extract"
	desc = "Ele pulsa com uma estranha fome."
	icon_state = "reproductive"
	effect = "reproductive"
	effect_desc = "Quando se alimentam cubos de macaco, produz mais extratos. Bolsa biológica compatível também."
	var/extract_type = /obj/item/slime_extract/
	var/cooldown = 3 SECONDS
	var/feedAmount = 3
	var/last_produce = 0

/obj/item/slimecross/reproductive/examine()
	. = ..()
	. += span_danger("Parece ter comido.[length(contents)]Cubo de Macaco[p_s()]")

/obj/item/slimecross/reproductive/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/extract_inventory)

/obj/item/slimecross/reproductive/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	var/datum/storage/extract_inventory/slime_storage = atom_storage
	if(!istype(slime_storage)) // what
		return NONE

	if((last_produce + cooldown) > world.time)
		to_chat(user, span_warning("[src]Ainda está digerindo!"))
		return ITEM_INTERACT_BLOCKING

	if(length(contents) >= feedAmount) //if for some reason the contents are full, but it didnt digest, attempt to digest again
		to_chat(user, span_warning("[src]Parece estar cheio, mas não está digerindo! Talvez cutucá-lo o estimulou a digerir."))
		slime_storage?.processCubes(user)
		return ITEM_INTERACT_BLOCKING

	if(istype(tool, /obj/item/storage/bag/xeno))
		var/list/inserted = list()
		tool.atom_storage.remove_type(/obj/item/food/monkeycube, src, feedAmount - length(contents), TRUE, FALSE, user, inserted)
		if(!inserted.len)
			to_chat(user, span_warning("Não há cubos de macaco na bolsa biológica!"))
			return ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("Você se alimenta.[length(inserted)]Cubo de macaco[length(inserted) > 1 ? "s" : ""]Para[src]E pulsa suavemente."))
		playsound(src, 'sound/items/eatfood.ogg', 20, TRUE)
		slime_storage?.processCubes(user)
		return ITEM_INTERACT_SUCCESS

	if(!istype(tool, /obj/item/food/monkeycube))
		return NONE

	if(!atom_storage?.attempt_insert(tool, user, override = TRUE, force = STORAGE_FULLY_LOCKED))
		to_chat(user, span_notice("O[src]Rejeita.[tool]!")) //in case it fails to insert for whatever reason you get feedback
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("Você se alimenta.[tool]Para[src]E pulsa suavemente."))
	slime_storage?.processCubes(user)
	playsound(src, 'sound/items/eatfood.ogg', 20, TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/item/slimecross/reproductive/grey
	extract_type = /obj/item/slime_extract/grey
	colour = SLIME_TYPE_GREY

/obj/item/slimecross/reproductive/orange
	extract_type = /obj/item/slime_extract/orange
	colour = SLIME_TYPE_ORANGE

/obj/item/slimecross/reproductive/purple
	extract_type = /obj/item/slime_extract/purple
	colour = SLIME_TYPE_PURPLE

/obj/item/slimecross/reproductive/blue
	extract_type = /obj/item/slime_extract/blue
	colour = SLIME_TYPE_BLUE

/obj/item/slimecross/reproductive/metal
	extract_type = /obj/item/slime_extract/metal
	colour = SLIME_TYPE_METAL

/obj/item/slimecross/reproductive/yellow
	extract_type = /obj/item/slime_extract/yellow
	colour = SLIME_TYPE_YELLOW

/obj/item/slimecross/reproductive/darkpurple
	extract_type = /obj/item/slime_extract/darkpurple
	colour = SLIME_TYPE_DARK_PURPLE

/obj/item/slimecross/reproductive/darkblue
	extract_type = /obj/item/slime_extract/darkblue
	colour = SLIME_TYPE_DARK_BLUE

/obj/item/slimecross/reproductive/silver
	extract_type = /obj/item/slime_extract/silver
	colour = SLIME_TYPE_SILVER

/obj/item/slimecross/reproductive/bluespace
	extract_type = /obj/item/slime_extract/bluespace
	colour = SLIME_TYPE_BLUESPACE

/obj/item/slimecross/reproductive/sepia
	extract_type = /obj/item/slime_extract/sepia
	colour = SLIME_TYPE_SEPIA

/obj/item/slimecross/reproductive/cerulean
	extract_type = /obj/item/slime_extract/cerulean
	colour = SLIME_TYPE_CERULEAN

/obj/item/slimecross/reproductive/pyrite
	extract_type = /obj/item/slime_extract/pyrite
	colour = SLIME_TYPE_PYRITE

/obj/item/slimecross/reproductive/red
	extract_type = /obj/item/slime_extract/red
	colour = SLIME_TYPE_RED

/obj/item/slimecross/reproductive/green
	extract_type = /obj/item/slime_extract/green
	colour = SLIME_TYPE_GREEN

/obj/item/slimecross/reproductive/pink
	extract_type = /obj/item/slime_extract/pink
	colour = SLIME_TYPE_PINK

/obj/item/slimecross/reproductive/gold
	extract_type = /obj/item/slime_extract/gold
	colour = SLIME_TYPE_GOLD

/obj/item/slimecross/reproductive/oil
	extract_type = /obj/item/slime_extract/oil
	colour = SLIME_TYPE_OIL

/obj/item/slimecross/reproductive/black
	extract_type = /obj/item/slime_extract/black
	colour = SLIME_TYPE_BLACK

/obj/item/slimecross/reproductive/lightpink
	extract_type = /obj/item/slime_extract/lightpink
	colour = SLIME_TYPE_LIGHT_PINK

/obj/item/slimecross/reproductive/adamantine
	extract_type = /obj/item/slime_extract/adamantine
	colour = SLIME_TYPE_ADAMANTINE

/obj/item/slimecross/reproductive/rainbow
	extract_type = /obj/item/slime_extract/rainbow
	colour = SLIME_TYPE_RAINBOW
