/obj/effect/immovablerod/Bump(atom/clong)
	var/should_self_destroy = FALSE
	if(istype(clong, /obj/machinery/rodstopper))
		should_self_destroy = TRUE
	. = ..()
	if(should_self_destroy)
		visible_message(span_boldwarning("A vara rasga o topo com um guincho que quebra a realidade!"))
		playsound(src.loc,'sound/effects/supermatter.ogg', 200, TRUE)
		visible_message(span_boldwarning("Você tem cinco segundos para se afastar antes do colapso da realidade."))
		new/obj/reality_tear(src.loc)
		qdel(src)
