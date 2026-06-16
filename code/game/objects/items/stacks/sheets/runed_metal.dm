// Note, the order these in are deliberate, as it affects
// the order they are shown via radial.
GLOBAL_LIST_INIT(runed_metal_recipes, list( 	new /datum/stack_recipe/radial( 		title = "pylon", 		result_type = /obj/structure/destructible/cult/pylon, 		req_amount = 4, 		time = 4 SECONDS, 		crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, 		desc = span_cult_bold("Cura e regenera o sangue de cultistas de sangue próximos e constrói, e também converte azulejos de chão próximos em pisos gravados, o que permite que cultistas de sangue escriba runas mais rápido."), 		required_noun = "Folha de metal em runa", 		category = CAT_CULT, 	), 	new /datum/stack_recipe/radial( 		title = "altar", 		result_type = /obj/structure/destructible/cult/item_dispenser/altar, 		req_amount = 3, 		time = 4 SECONDS, 		crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, 		desc = span_cult_bold("Pode fazer Eldritch Whetstones, Construct Shells, e Flasks of Unholy Water."), 		required_noun = "Folha de metal em runa", 		category = CAT_CULT, 	), 	new /datum/stack_recipe/radial( 		title = "archives", 		result_type = /obj/structure/destructible/cult/item_dispenser/archives, 		req_amount = 3, 		time = 4 SECONDS, 		crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, 		desc = span_cult_bold("Arquivos: podem fazer as vendas de Zelot, a maldição do ônibus espacial Orbs, e equipamentos Veil Walker. Emits Light."), 		required_noun = "Folha de metal em runa", 		category = CAT_CULT, 	), 	new /datum/stack_recipe/radial( 		title = "Daemon Forge", 		result_type = /obj/structure/destructible/cult/item_dispenser/forge, 		req_amount = 3, 		time = 4 SECONDS, 		crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, 		desc = span_cult_bold("Daemon Forge: pode fazer Nar'Sien Hardened Armor, Flagellant's Robes, e Eldritch Longswords. Emits Light."), 		required_noun = "Folha de metal em runa", 		category = CAT_CULT, 	), 	new /datum/stack_recipe/radial( 		title = "Correndo porta", 		result_type = /obj/machinery/door/airlock/cult, 		time = 5 SECONDS, 		crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, 		desc = span_cult_bold("Uma porta fraca que atordoa cultistas não sanguinários que a tocam."), 		required_noun = "Folha de metal em runa", 		category = CAT_CULT, 	), 	new /datum/stack_recipe/radial( 		title = "Cinta de Correr", 		result_type = /obj/structure/girder/cult, 		time = 5 SECONDS, 		crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, 		desc = span_cult_bold("Uma viga fraca que pode ser instantaneamente destruída por punhais rituais. Não é um uso recomendado de metal fundido."), 		required_noun = "Folha de metal em runa", 		category = CAT_CULT, 	), 
	new /datum/stack_recipe("runed stone platform", /obj/structure/platform/cult, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), ))

/obj/item/stack/sheet/runed_metal
	name = "runed metal"
	desc = "Folhas de metal frio com inscrições trocadas escritas sobre eles."
	singular_name = "Folha de metal em runa"
	icon_state = "sheet-runed"
	inhand_icon_state = "sheet-runed"
	icon = 'icons/obj/stack_objects.dmi'
	mats_per_unit = list(/datum/material/runedmetal = SHEET_MATERIAL_AMOUNT)
	construction_path_type = "runed"
	merge_type = /obj/item/stack/sheet/runed_metal
	material_type = /datum/material/runedmetal
	has_unique_girder = TRUE
	use_radial = TRUE

/obj/item/stack/sheet/runed_metal/grind_results()
	return list(/datum/reagent/iron = 5, /datum/reagent/blood = 15)

/obj/item/stack/sheet/runed_metal/interact(mob/user)
	if(!IS_CULTIST(user))
		to_chat(user, span_warning("Só um com conhecimento proibido poderia esperar trabalhar este metal..."))
		return FALSE

	var/turf/user_turf = get_turf(user)
	var/area/user_area = get_area(user)

	var/is_valid_turf = user_turf && (is_station_level(user_turf.z) || is_mining_level(user_turf.z))
	var/is_valid_area = user_area && (user_area.area_flags & CULT_PERMITTED)

	if(!is_valid_turf || !is_valid_area)
		to_chat(user, span_warning("O véu não é suficientemente fraco aqui."))
		return FALSE

	return ..()

/obj/item/stack/sheet/runed_metal/radial_check(mob/builder)
	return ..() && IS_CULTIST(builder)

/obj/item/stack/sheet/runed_metal/get_main_recipes()
	. = ..()
	. += GLOB.runed_metal_recipes

/obj/item/stack/sheet/runed_metal/fifty
	amount = 50

/obj/item/stack/sheet/runed_metal/ten
	amount = 10

/obj/item/stack/sheet/runed_metal/five
	amount = 5
