/obj/item/stack/sheet/mineral/stone
	name = "stone"
	desc = "tijolo de pedra."
	singular_name = "Bloco de pedra"
	icon = 'modular_skyrat/modules/stone/icons/ore.dmi'
	icon_state = "sheet-stone"
	inhand_icon_state = "sheet-metal"
	mats_per_unit = list(/datum/material/stone=SHEET_MATERIAL_AMOUNT)
	force = 10
	throwforce = 15
	resistance_flags = FIRE_PROOF
	merge_type = /obj/item/stack/sheet/mineral/stone
	material_type = /datum/material/stone
	matter_amount = 0
	source = null
	walltype = /turf/closed/wall/mineral/stone
	stairs_type = /obj/structure/stairs/stone

GLOBAL_LIST_INIT(stone_recipes, list ( \
	new/datum/stack_recipe("stone brick wall", /turf/closed/wall/mineral/stone, 5, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND | CRAFT_TRANSFERS_REAGENT_COMPONENTS, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("stone brick tile", /obj/item/stack/tile/mineral/stone, 1, 4, 20, category = CAT_TILES),
	new/datum/stack_recipe("millstone", /obj/structure/millstone, 6, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("stone cauldron", /obj/machinery/cauldron, 5, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("stone stove", /obj/machinery/primitive_stove, 5, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("stone oven", /obj/machinery/oven/stone, 5, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	new/datum/stack_recipe("stone griddle", /obj/machinery/griddle/stone, 5, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE),
	))

/obj/item/stack/sheet/mineral/stone/get_main_recipes()
	. = ..()
	. += GLOB.stone_recipes

/datum/material/stone
	name = "stone"
	desc = "É pedra."
	mat_flags = MATERIAL_CLASS_RIGID | MATERIAL_BASIC_RECIPES
	sheet_type = /obj/item/stack/sheet/mineral/stone
	color = "#59595a"
	greyscale_color = "#59595a"
	value_per_unit = 0.0025
	mat_properties = list(
		MATERIAL_BEAUTY = 0.3,
	)
	turf_sound_override = FOOTSTEP_PLATING

/obj/item/stack/stone
	name = "rough stone"
	desc = "Grandes pedaços de pedra não cortada, duro o suficiente para construir com segurança... se você pudesse cortá-los em algo utilizável."
	icon = 'modular_skyrat/modules/stone/icons/ore.dmi'
	icon_state = "stone_ore"
	singular_name = "Pedra bruta."
	mats_per_unit = list(/datum/material/stone = SHEET_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/stone
	force = 10
	throwforce = 15

/obj/item/stack/stone/examine()
	. = ..()
	. += span_notice("Com um<b>Cinzel</b>ou mesmo um<b>Pickaxe</b>de algum tipo, você poderia cortar isso em<b>Blocos</b>.")

/obj/item/stack/stone/attackby(obj/item/attacking_item, mob/user, params)
	if((attacking_item.tool_behaviour != TOOL_MINING) && !(istype(attacking_item, /obj/item/chisel)))
		return ..()
	playsound(src, 'sound/effects/pickaxe/picaxe1.ogg', 50, TRUE)
	balloon_alert_to_viewers("cutting...")
	if(!do_after(user, 5 SECONDS, target = src))
		balloon_alert_to_viewers("stopped cutting")
		return FALSE
	new /obj/item/stack/sheet/mineral/stone(get_turf(src), amount)
	qdel(src)

/obj/item/stack/tile/mineral/stone
	name = "stone tile"
	singular_name = "piso de pedra"
	desc = "Um azulejo feito de tijolos de pedra, para aquele olhar de fortaleza."
	icon_state = "tile_herringbone"
	inhand_icon_state = "tile"
	turf_type = /turf/open/floor/stone
	mineralType = "stone"
	mats_per_unit = list(/datum/material/stone = HALF_SHEET_MATERIAL_AMOUNT / 2)
	merge_type = /obj/item/stack/tile/mineral/stone

/turf/open/floor/stone
	desc = "Blocos de pedra dispostos em um padrão de azulejo, estranho, realmente, como parece pedra real também, porque é!" //A play on the original description for stone tiles
	slowdown = -0.3

/turf/closed/wall/mineral/stone
	name = "stone wall"
	desc = "Uma parede feita de tijolos de pedra sólida."
	icon = 'modular_skyrat/modules/stone/icons/wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	sheet_type = /obj/item/stack/sheet/mineral/stone
	explosive_resistance = 2 // Rock and stone to the bone, or at least a bit longer than walls made of metal sheets!
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_STONE_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_STONE_WALLS + SMOOTH_GROUP_WALLS
	custom_materials = list(
		/datum/material/stone = SHEET_MATERIAL_AMOUNT  * 2,
	)

/turf/closed/wall/mineral/stone/try_decon(obj/item/item_used, mob/user) // Lets you break down stone walls with stone breaking tools
	if(item_used.tool_behaviour != TOOL_MINING)
		return ..()

	if(!item_used.tool_start_check(user, amount = 0))
		return FALSE

	balloon_alert_to_viewers("breaking down...")

	if(!item_used.use_tool(src, user, 5 SECONDS))
		return FALSE
	dismantle_wall()
	return TRUE

/turf/closed/indestructible/stone
	name = "stone wall"
	desc = "Uma parede feita de tijolos de pedra invulgarmente sólidos."
	icon = 'modular_skyrat/modules/stone/icons/wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_STONE_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_STONE_WALLS + SMOOTH_GROUP_WALLS
	custom_materials = list(
		/datum/material/stone = SHEET_MATERIAL_AMOUNT  * 2,
	)

/obj/structure/falsewall/stone
	name = "stone wall"
	desc = "Uma parede feita de tijolos de pedra sólida."
	icon = 'modular_skyrat/modules/stone/icons/wall.dmi'
	icon_state = "wall-open"
	base_icon_state = "wall"
	fake_icon = 'modular_skyrat/modules/stone/icons/wall.dmi'
	mineral = /obj/item/stack/sheet/mineral/stone
	walltype = /turf/closed/wall/mineral/stone
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_STONE_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_AIRLOCK + SMOOTH_GROUP_WINDOW_FULLTILE + SMOOTH_GROUP_STONE_WALLS + SMOOTH_GROUP_WALLS

/turf/closed/mineral/gets_drilled(mob/user, give_exp = FALSE)
	if(prob(5))
		new /obj/item/stack/stone(src)

	return ..()
