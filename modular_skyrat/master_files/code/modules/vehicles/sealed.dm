/obj/vehicle/sealed/mob_try_enter(mob/rider)
	if(!istype(rider))
		return FALSE
	if(HAS_TRAIT(rider, TRAIT_OVERSIZED))
		to_chat(rider, span_warning("Você é muito grande para isso!"))
		return FALSE

	return ..()
