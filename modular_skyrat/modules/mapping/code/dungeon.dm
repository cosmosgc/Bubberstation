/*
*	WALLS
*/

/turf/closed/indestructible/dungeon
	name = "stone wall"
	desc = "Paredes de pedra frias. É como uma masmorra."
	icon = 'modular_skyrat/modules/mapping/icons/unique/dungeon.dmi'
	icon_state = "wall"
	base_icon_state = "wall"
	explosive_resistance = INFINITY

/turf/closed/indestructible/dungeon/corner
	icon_state = "wall-corner"
	base_icon_state = "wall-corner"

/*
*	TURFS
*/

/turf/open/floor/plating/cobblestone
	gender = PLURAL
	name = "cobblestone"
	desc = "Pedra empedrada que faz um caminho permanente. Um pouco antiquado."
	icon = 'modular_skyrat/modules/mapping/icons/unique/dungeon.dmi'
	icon_state = "cobble"
	planetary_atmos = FALSE

/turf/open/floor/plating/cobblestone/planet
	baseturfs = /turf/open/misc/dirt/planet
	planetary_atmos = TRUE

/turf/open/floor/plating/cobblestone/dungeon
	icon_state = "cobble-dungeon"
	baseturfs = /turf/open/floor/plating/cobblestone/dungeon
	planetary_atmos = FALSE

// This one has a rocky texture to it.
/turf/open/floor/plating/cobblestone/sparse
	icon_state = "cobble_sparse"
	baseturfs = /turf/open/floor/plating/cobblestone/sparse

/turf/open/floor/plating/cobblestone/sparse/planet
	icon_state = "cobble_sparse"
	baseturfs = /turf/open/floor/plating/cobblestone/sparse/planet
	planetary_atmos = TRUE

/*
*	FAKE WALLS
*/

/obj/structure/dungeon
	name = "stone wall with a hole in it!"
	desc = "Um buraco na parede! É pequeno."
	icon = 'modular_skyrat/modules/mapping/icons/unique/dungeon.dmi'
	icon_state = "wall-hole"
	layer = ABOVE_MOB_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/structure/dungeon/doorway
	name = "doorway"
	desc = "Uma porta feita em uma parede de pedra. É um ajuste apertado."
	icon = 'modular_skyrat/modules/mapping/icons/unique/dungeon.dmi'
	icon_state = "wall-doorway"
	layer = ABOVE_MOB_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/structure/railing/stone/Initialize(mapload)
	.=..()
	if(dir == 2)
		layer = ABOVE_MOB_LAYER
	else
		return

/obj/structure/railing/stone
	name = "stone wall"
	desc = "Parede de pedra empedrada. Isso é bem forte."
	icon = 'modular_skyrat/modules/mapping/icons/unique/dungeon.dmi'
	icon_state = "cobble-wall"
	max_integrity = 100
	density = TRUE
	anchored = TRUE
	climbable = TRUE

/obj/structure/railing/stone/attackby(obj/item/wrench, mob/living/user, params)
	to_chat(user, span_notice("Você franziu a cara ao perceber que esta parede é feita de pedra, e não pode ser arrancada do chão e arrastada junto com uma simples chave inglesa."))
	return

/obj/structure/railing/stone/left
	icon_state = "cobble-wall-left"
	density = FALSE
	climbable = FALSE

/obj/structure/railing/stone/right
	icon_state = "cobble-wall-right"
	density = FALSE
	climbable = FALSE

/obj/structure/mineral_door/dungeon
	name = "wooden door"
	desc = "Uma pequena porta de madeira. Provavelmente ainda abre, mas é meio pequeno."
	icon = 'modular_skyrat/modules/mapping/icons/unique/dungeon.dmi'
	icon_state = "wall-door"
	openSound = 'sound/effects/doorcreaky.ogg'
	closeSound = 'sound/effects/doorcreaky.ogg'
	sheetType = /obj/item/stack/sheet/mineral/wood
	max_integrity = 100

/obj/machinery/button/dungeon
	name = "stone brick"
	desc = "Um tijolo que está preso na parede. Huh."
	icon = 'modular_skyrat/modules/mapping/icons/unique/dungeon.dmi'
	base_icon_state = "doorctrl"
	icon_state = "doorctrl"
	power_channel = AREA_USAGE_ENVIRON
	use_power = NO_POWER_USE
	idle_power_usage = 0
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/button/dungeon/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_SCREWDRIVER)
		to_chat(user, span_notice("Você mexe na borda dos tijolos e tenta entupir. Parece que não está saindo por aqui."))
		return
// Let's not open the maintenance panel of a stone brick.
