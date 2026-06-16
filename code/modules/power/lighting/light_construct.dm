/obj/structure/light_construct
	name = "light fixture frame"
	desc = "Uma luminária em construção."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "tube-construct-stage1"
	anchored = TRUE
	layer = WALL_OBJ_LAYER
	max_integrity = 200
	armor_type = /datum/armor/structure_light_construct

	///Light construction stage (LIGHT_CONSTRUCT_EMPTY, LIGHT_CONSTRUCT_WIRED, LIGHT_CONSTRUCT_CLOSED)
	var/stage = LIGHT_CONSTRUCT_EMPTY
	///Type of fixture for icon state
	var/fixture_type = "tube"
	///Amount of sheets gained on deconstruction
	var/sheets_refunded = 2
	///Reference for light object
	var/obj/machinery/light/new_light = null
	///Reference for the internal cell
	var/obj/item/stock_parts/power_store/cell
	///Can we support a cell?
	var/cell_connectors = TRUE

/datum/armor/structure_light_construct
	melee = 50
	bullet = 10
	laser = 10
	fire = 80
	acid = 50

/obj/structure/light_construct/Initialize(mapload)
	. = ..()
	if(mapload && !find_and_mount_on_atom(mark_for_late_init = TRUE))
		return INITIALIZE_HINT_LATELOAD

/obj/structure/light_construct/LateInitialize()
	find_and_mount_on_atom(late_init = TRUE)

/obj/structure/light_construct/Destroy()
	QDEL_NULL(cell)
	return ..()

/obj/structure/light_construct/get_turfs_to_mount_on()
	return list(get_step(src, dir))

/obj/structure/light_construct/get_cell()
	return cell

/obj/structure/light_construct/examine(mob/user)
	. = ..()
	switch(stage)
		if(LIGHT_CONSTRUCT_EMPTY)
			. += span_notice("É uma moldura vazia sem fios.")
		if(LIGHT_CONSTRUCT_WIRED)
			. += span_notice("Está ligado, mas os parafusos não estão presos.")
		if(LIGHT_CONSTRUCT_CLOSED)
			. += span_notice("A cápsula está fechada.")
	if(cell_connectors)
		if(cell)
			. += span_notice("Viu?[cell] dentro da cápsula.")
		else
			. += span_notice("O invólucro não tem célula de energia para reserva.")
	else
		. += span_danger("Este invólucro não suporta células de energia para energia de reserva.")

/obj/structure/light_construct/attack_hand(mob/user, list/modifiers)
	if(!cell)
		return
	user.visible_message(span_notice("[user] Remover [cell] De [src]!"), span_notice("Você tira.[cell]."))
	user.put_in_hands(cell)
	cell = null
	add_fingerprint(user)

/obj/structure/light_construct/attack_tk(mob/user)
	if(!cell)
		return
	to_chat(user, span_notice("Você remove telecinicamente.[cell]."))
	var/obj/item/stock_parts/power_store/cell_reference = cell
	cell = null
	cell_reference.forceMove(drop_location())
	return cell_reference.attack_tk(user)

/obj/structure/light_construct/attackby(obj/item/tool, mob/user, list/modifiers, list/attack_modifiers)
	add_fingerprint(user)
	if(istype(tool, /obj/item/stock_parts/power_store/cell))
		if(!cell_connectors)
			to_chat(user, span_warning("Isto.[name] Não posso suportar uma célula de energia!"))
			return
		if(HAS_TRAIT(tool, TRAIT_NODROP))
			to_chat(user, span_warning("[tool] está preso em sua mão!"))
			return
		if(cell)
			to_chat(user, span_warning("Já tem uma célula de energia instalada!"))
			return
		if(user.temporarilyRemoveItemFromInventory(tool))
			user.visible_message(span_notice("[user] Ele se liga.[tool] Para [src]."), 			span_notice("Você acrescenta [tool] Para [src]."))
			playsound(src, 'sound/machines/click.ogg', 50, TRUE)
			tool.forceMove(src)
			cell = tool
			add_fingerprint(user)
			return
	if(istype(tool, /obj/item/light))
		to_chat(user, span_warning("Isto.[name] Ainda não acabou de ser armado!"))
		return

	switch(stage)
		if(LIGHT_CONSTRUCT_EMPTY)
			if(tool.tool_behaviour == TOOL_WRENCH)
				if(cell)
					to_chat(user, span_warning("Você tem que remover a cela primeiro!"))
					return
				to_chat(user, span_notice("Você começa a desconstruir [src]..."))
				if (tool.use_tool(src, user, 30, volume=50))
					user.visible_message(span_notice("[user.name] Desconstruir [src]."), 						span_notice("Você desconstrui.[src]."), span_hear("Você ouve uma catraca."))
					playsound(src, 'sound/items/deconstruct.ogg', 75, TRUE)
					deconstruct()
				return

			if(istype(tool, /obj/item/stack/cable_coil))
				var/obj/item/stack/cable_coil/coil = tool
				if(coil.use(1))
					icon_state = "[fixture_type]-construct-stage2"
					stage = LIGHT_CONSTRUCT_WIRED
					user.visible_message(span_notice("[user.name] Adicionona fios a [src]."), 						span_notice("Você adiciona fios para [src]."))
				else
					to_chat(user, span_warning("Você precisa de um fio de cabo.[src]!"))
				return
		if(LIGHT_CONSTRUCT_WIRED)
			if(tool.tool_behaviour == TOOL_WRENCH)
				to_chat(usr, span_warning("Você tem que remover os fios primeiro!"))
				return

			if(tool.tool_behaviour == TOOL_WIRECUTTER)
				stage = LIGHT_CONSTRUCT_EMPTY
				icon_state = "[fixture_type]-construct-stage1"
				new /obj/item/stack/cable_coil(drop_location(), 1, "red")
				user.visible_message(span_notice("[user.name] remove a fiação de [src]."), 					span_notice("Você remove a fiação de [src]."), span_hear("Você ouve o clique."))
				tool.play_tool_sound(src, 100)
				return

			if(tool.tool_behaviour == TOOL_SCREWDRIVER)
				user.visible_message(span_notice("[user.name] Fecha.[src] É a cápsula."), 					span_notice("Você fecha.[src] É a cápsula."), span_hear("Você ouve transando."))
				tool.play_tool_sound(src, 75)
				switch(fixture_type)
					if("tube")
						new_light = new /obj/machinery/light/empty(loc)
					if("bulb")
						new_light = new /obj/machinery/light/small/empty(loc)
					if("floor")
						new_light = new /obj/machinery/light/floor/empty(loc)
				new_light.setDir(dir)
				new_light.find_and_mount_on_atom()
				transfer_fingerprints_to(new_light)
				if(!QDELETED(cell))
					new_light.cell = cell
					cell.forceMove(new_light)
					cell = null
				qdel(src)
				return
	return ..()

/obj/structure/light_construct/blob_act(obj/structure/blob/attacking_blob)
	if(attacking_blob && attacking_blob.loc == loc)
		deconstruct(FALSE)

/obj/structure/light_construct/atom_deconstruct(disassembled)
	new /obj/item/stack/sheet/iron(loc, sheets_refunded)
	if(stage == LIGHT_CONSTRUCT_WIRED)
		new /obj/item/stack/cable_coil(drop_location(), 1, "red")

/obj/structure/light_construct/small
	name = "small light fixture frame"
	icon_state = "bulb-construct-stage1"
	fixture_type = "bulb"
	sheets_refunded = 1

/obj/structure/light_construct/floor
	name = "floor light fixture frame"
	icon_state = "floor-construct-stage1"
	fixture_type = "floor"
	sheets_refunded = 1

/obj/structure/light_construct/floor/get_turfs_to_mount_on()
	return list(get_turf(src))

/obj/structure/light_construct/floor/is_mountable_turf(turf/target)
	return !isgroundlessturf(target)
