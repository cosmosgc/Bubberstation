// Plastic panel walls, how colony of you

/turf/closed/wall/prefab_plastic
	name = "prefabricated wall"
	desc = "Um quadro de metal construído conservadoramente com painéis de plástico cobrindo uma fina camada de selo de ar.\
É um pouco irritante, mas é melhor do que nada."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/prefab_wall.dmi'
	icon_state = "prefab-0"
	base_icon_state = "prefab"
	can_engrave = FALSE
	girder_type = null
	hardness = 70
	slicing_duration = 5 SECONDS
	sheet_type = /obj/item/stack/sheet/plastic_wall_panel
	sheet_amount = 1

GLOBAL_LIST_INIT(plastic_wall_panel_recipes, list(
	new/datum/stack_recipe("prefabricated wall", /turf/closed/wall/prefab_plastic, time = 3 SECONDS,  crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("prefabricated window", /obj/structure/window/fulltile/colony_fabricator, time = 1 SECONDS,  crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND | CRAFT_CHECK_DIRECTION | CRAFT_IS_FULLTILE, category = CAT_WINDOWS), \
	))

/obj/item/stack/sheet/plastic_wall_panel
	name = "plastic panels"
	singular_name = "Painel de plástico"
	desc = "Que melhor material para fazer as paredes do seu logo estar em casa do que folhas de plástico frágil?\
Metal? Do que está falando, paredes de metal, nesta economia? Também pode ser usado para fazer outras estruturas.\
Que paredes."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tiles_item.dmi'
	icon_state = "sheet-plastic"
	inhand_icon_state = "sheet-plastic"
	mats_per_unit = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	has_unique_girder = TRUE
	material_type = /datum/material/plastic
	merge_type = /obj/item/stack/sheet/plastic_wall_panel
	walltype = /turf/closed/wall/prefab_plastic

/obj/item/stack/sheet/plastic_wall_panel/examine(mob/user)
	. = ..()
	. += span_notice("Você pode construir uma parede pré-fabricada clicando direito em um chão vazio.")

/obj/item/stack/sheet/plastic_wall_panel/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isopenturf(interacting_with))
		return NONE
	var/turf/open/build_on = interacting_with
	if(isgroundlessturf(build_on))
		user.balloon_alert(user, "Não posso colocá-lo aqui!")
		return ITEM_INTERACT_BLOCKING
	if(build_on.is_blocked_turf())
		user.balloon_alert(user, "Algo está bloqueando o azulejo!")
		return ITEM_INTERACT_BLOCKING
	if(get_amount() < 1)
		user.balloon_alert(user, "Não há material suficiente!")
		return ITEM_INTERACT_BLOCKING
	if(!do_after(user, 3 SECONDS, build_on))
		return ITEM_INTERACT_BLOCKING
	if(build_on.is_blocked_turf())
		user.balloon_alert(user, "Algo está bloqueando o azulejo!")
		return ITEM_INTERACT_BLOCKING
	if(!use(1))
		user.balloon_alert(user, "Não há material suficiente!")
		return ITEM_INTERACT_BLOCKING
	build_on.place_on_top(walltype, flags = CHANGETURF_INHERIT_AIR)
	return ITEM_INTERACT_SUCCESS

/obj/item/stack/sheet/plastic_wall_panel/get_main_recipes()
	. = ..()
	. += GLOB.plastic_wall_panel_recipes

/obj/item/stack/sheet/plastic_wall_panel/ten
	amount = 10

/obj/item/stack/sheet/plastic_wall_panel/fifty
	amount = 50

// Stacks of floor tiles

/obj/item/stack/tile/catwalk_tile/colony_lathe
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tiles_item.dmi'
	icon_state = "prefab_catwalk"
	mats_per_unit = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT)
	turf_type = /turf/open/floor/catwalk_floor/colony_fabricator
	merge_type = /obj/item/stack/tile/catwalk_tile/colony_lathe
	tile_reskin_types = null

/obj/item/stack/tile/iron/colony
	name = "prefab floor tiles"
	singular_name = "Pisos pré-fabricados"
	desc = "Uma pilha de grandes azulejos que são uma visão comum em colônias fronteiriças e prédios pré-fabricados."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tiles_item.dmi'
	icon_state = "colony_grey"
	turf_type = /turf/open/floor/iron/colony
	merge_type = /obj/item/stack/tile/iron/colony
	tile_reskin_types = list(
		/obj/item/stack/tile/iron/colony,
		/obj/item/stack/tile/iron/colony/texture,
		/obj/item/stack/tile/iron/colony/bolts,
		/obj/item/stack/tile/iron/colony/white,
		/obj/item/stack/tile/iron/colony/white/texture,
		/obj/item/stack/tile/iron/colony/white/bolts,
	)

// Grated floor tile, for seeing wires under

/turf/open/floor/catwalk_floor/colony_fabricator
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tiles.dmi'
	icon_state = "prefab_above"
	catwalk_type = "prefab"
	baseturfs = /turf/open/floor/plating
	floor_tile = /obj/item/stack/tile/catwalk_tile/colony_lathe

// "Normal" floor tiles

/obj/item/stack/tile/iron/colony/texture
	icon_state = "colony_grey_texture"
	turf_type = /turf/open/floor/iron/colony/texture

/obj/item/stack/tile/iron/colony/bolts
	icon_state = "colony_grey_bolts"
	turf_type = /turf/open/floor/iron/colony/bolts

/turf/open/floor/iron/colony
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tiles.dmi'
	icon_state = "colony_grey"
	base_icon_state = "colony_grey"
	floor_tile = /obj/item/stack/tile/iron/colony
	tiled_turf = FALSE

/turf/open/floor/iron/colony/texture
	icon_state = "colony_grey_texture"
	base_icon_state = "colony_grey_texture"
	floor_tile = /obj/item/stack/tile/iron/colony/texture

/turf/open/floor/iron/colony/bolts
	icon_state = "colony_grey_bolts"
	base_icon_state = "colony_grey_bolts"
	floor_tile = /obj/item/stack/tile/iron/colony/bolts

// White variants of the above tiles

/obj/item/stack/tile/iron/colony/white
	icon_state = "colony_white"
	turf_type = /turf/open/floor/iron/colony/white

/obj/item/stack/tile/iron/colony/white/texture
	icon_state = "colony_white_texture"
	turf_type = /turf/open/floor/iron/colony/white/texture

/obj/item/stack/tile/iron/colony/white/bolts
	icon_state = "colony_white_bolts"
	turf_type = /turf/open/floor/iron/colony/white/bolts

/turf/open/floor/iron/colony/white
	icon_state = "colony_white"
	base_icon_state = "colony_white"
	floor_tile = /obj/item/stack/tile/iron/colony/white

/turf/open/floor/iron/colony/white/texture
	icon_state = "colony_white_texture"
	base_icon_state = "colony_white_texture"
	floor_tile = /obj/item/stack/tile/iron/colony/white/texture

/turf/open/floor/iron/colony/white/bolts
	icon_state = "colony_white_bolts"
	base_icon_state = "colony_white_bolts"
	floor_tile = /obj/item/stack/tile/iron/colony/white/bolts
