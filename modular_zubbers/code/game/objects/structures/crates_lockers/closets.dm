/obj/structure/closet/examine(mob/user)
	. = ..()
	if(isobserver(user))
		. += span_info("Contém:[english_list(contents)].")
