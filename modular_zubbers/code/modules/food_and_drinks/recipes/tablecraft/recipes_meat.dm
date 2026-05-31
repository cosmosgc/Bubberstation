/obj/item/food/fried_chicken/burn()
	visible_message(span_notice("O calor entra na galinha! Jura ouvir alguém de camisa azul cantando..."))
	new /obj/item/food/lava_chicken(loc)
	qdel(src)
