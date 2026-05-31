// Used by mapmerge2 to denote the existence of a merge conflict (or when it has to complete a "best intent" merge where it dumps the movable contents of an old key and a new key on the same tile).
// We define it explicitly here to ensure that it shows up on the highest possible plane (while giving off a verbose icon) to aide mappers in resolving these conflicts.
// DO NOT USE THIS IN NORMAL MAPPING!!! Linters WILL fail.

/obj/merge_conflict_marker
	name = "Merge Conflict Marker - DO NOT USE"
	icon = 'icons/effects/mapping_helpers.dmi'
	icon_state = "merge_conflict_marker"
	desc = "Se você está vendo isso no jogo: alguém realmente, realmente, realmente fodido. Eles mapearam fisicamente a porra de um marcador de conflitos de fusão. Que merda."
	plane = POINT_PLANE

///We REALLY do not want un-addressed merge conflicts in maps for an inexhaustible list of reasons. This should help ensure that this will not be missed in case linters fail to catch it for any reason what-so-ever.
/obj/merge_conflict_marker/Initialize(mapload)
	. = ..()
	var/msg = "HEY, LISTEN!!! Merge Conflict Marker detected at [AREACOORD(src)]! Please manually address all potential merge conflicts!!!"
	log_mapping(msg)
	to_chat(world, span_boldannounce("[msg]"))
	warning(msg)
