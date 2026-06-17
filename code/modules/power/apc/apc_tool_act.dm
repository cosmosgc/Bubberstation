//attack with an item - open/close cover, insert cell, or (un)lock interface

/obj/machinery/power/apc/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = NONE
	if(HAS_TRAIT(tool, TRAIT_APC_SHOCKING))
		. = fork_outlet_act(user, tool)
		if(.)
			return .

	if(tool.GetID())
		togglelock(user)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/stock_parts/power_store))
		. = cell_act(user, tool)
	else if(istype(tool, /obj/item/stack/cable_coil))
		. = cable_act(user, tool, LAZYACCESS(modifiers, RIGHT_CLICK))
	else if(istype(tool, /obj/item/electronics/apc))
		. = electronics_act(user, tool)
	else if(istype(tool, /obj/item/electroadaptive_pseudocircuit))
		. = pseudocircuit_act(user, tool)
	else if(istype(tool, /obj/item/wallframe/apc))
		. = wallframe_act(user, tool)
	if(.)
		return .

	if(panel_open && !opened && is_wire_tool(tool))
		wires.interact(user)
		return ITEM_INTERACT_SUCCESS

	return .

/// Called when we interact with the APC with an item with which we can get shocked when we stuff it into an APC
/obj/machinery/power/apc/proc/fork_outlet_act(mob/living/user, obj/item/tool)
	var/metal = 0
	var/shock_source = null
	metal += LAZYACCESS(tool.custom_materials, SSmaterials.get_material(/datum/material/iron))//This prevents wooden rolling pins from shocking the user

	if(cell || terminal) //The mob gets shocked by whichever powersource has the most electricity
		if(cell && terminal)
			shock_source = cell.charge > terminal.powernet.avail ? cell : terminal.powernet
		else
			shock_source = terminal?.powernet || cell

	if(shock_source && metal && (panel_open || opened)) //Now you're cooking with electricity
		if(!electrocute_mob(user, shock_source, src, siemens_coeff = 1, dist_check = TRUE))//People with insulated gloves just attack the APC normally. They're just short of magical anyway
			return NONE
		do_sparks(5, TRUE, src)
		user.visible_message(span_notice("[user.name] shoves [tool] into the internal components of [src], erupting into a cascade of sparks!"))
		if(shock_source == cell)//If the shock is coming from the cell just fully discharge it, because it's funny
			cell.use(cell.charge)
		return ITEM_INTERACT_SUCCESS

/// Called when we interact with the APC with a cell, attempts to insert it
/obj/machinery/power/apc/proc/cell_act(mob/living/user, obj/item/stock_parts/power_store/new_cell)
	if(!opened)
		return NONE

	if(cell)
		balloon_alert(user, "O celular já está instalado!")
		return ITEM_INTERACT_BLOCKING
	if(machine_stat & MAINT)
		balloon_alert(user, "Sem conector para uma célula!")
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(new_cell, src))
		return ITEM_INTERACT_BLOCKING
	cell = new_cell
	user.visible_message(span_notice("[user.name] inserts the power cell to [src.name]!"))
	balloon_alert(user, "célula inserida")
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/// Checks if we can place a terminal on the APC
/obj/machinery/power/apc/proc/can_place_terminal(mob/living/user, obj/item/stack/cable_coil/installing_cable, silent = TRUE)
	if(!opened)
		return FALSE
	var/turf/host_turf = get_turf(src)
	if(host_turf.underfloor_accessibility < UNDERFLOOR_INTERACTABLE)
		if(!silent && user)
			balloon_alert(user, "Remova o revestimento do chão!")
		return FALSE
	if(!isnull(terminal))
		if(!silent && user)
			balloon_alert(user, "Já está ligado!")
		return FALSE
	if(!has_electronics)
		if(!silent && user)
			balloon_alert(user, "Sem placa para grampear!")
		return FALSE
	if(panel_open)
		if(!silent && user)
			balloon_alert(user, "Os fios impedem a colocação de um terminal!")
		return FALSE
	if(installing_cable.get_amount() < 10)
		if(!silent && user)
			balloon_alert(user, "Preciso de dez comprimentos de cabo!")
		return FALSE
	return TRUE

/// Called when we interact with the APC with a cable, attempts to wire the APC and create a terminal
/obj/machinery/power/apc/proc/cable_act(mob/living/user, obj/item/stack/cable_coil/installing_cable, is_right_clicking)
	if(!opened)
		return NONE
	if(!can_place_terminal(user, installing_cable, silent = FALSE))
		return ITEM_INTERACT_BLOCKING

	var/terminal_cable_layer = cable_layer // Default to machine's cable layer
	if(is_right_clicking)
		var/choice = tgui_input_list(user, "Select Power Input Cable Layer", "Select Cable Layer", GLOB.cable_name_to_layer)
		if(isnull(choice) \
			|| !user.is_holding(installing_cable) \
			|| !user.Adjacent(src) \
			|| user.incapacitated \
			|| !can_place_terminal(user, installing_cable, silent = TRUE) \
		)
			return ITEM_INTERACT_BLOCKING
		terminal_cable_layer = GLOB.cable_name_to_layer[choice]

	user.visible_message(span_notice("[user.name] starts addding cables to the APC frame."))
	balloon_alert(user, "Adicionando cabos...")
	playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)

	if(!do_after(user, 2 SECONDS, target = src))
		return ITEM_INTERACT_BLOCKING
	if(!can_place_terminal(user, installing_cable, silent = TRUE))
		return ITEM_INTERACT_BLOCKING
	var/turf/our_turf = get_turf(src)
	var/obj/structure/cable/cable_node = our_turf.get_cable_node(terminal_cable_layer)
	if(prob(50) && electrocute_mob(usr, cable_node, cable_node, 1, TRUE))
		do_sparks(5, TRUE, src)
		return ITEM_INTERACT_BLOCKING
	installing_cable.use(10)
	user.visible_message(span_notice("[user.name] adds cables to the APC frame."))
	balloon_alert(user, "Cabos adicionados")
	make_terminal(terminal_cable_layer)
	terminal.connect_to_network()
	return ITEM_INTERACT_SUCCESS

/// Called when we interact with the APC with APC electronics, attempts to install the board
/obj/machinery/power/apc/proc/electronics_act(mob/living/user, obj/item/electronics/apc/installing_board)
	if(!opened)
		return NONE

	if(has_electronics)
		balloon_alert(user, "Já tem um tabuleiro!")
		return ITEM_INTERACT_BLOCKING

	if(machine_stat & BROKEN)
		balloon_alert(user, "O quadro está danificado!")
		return ITEM_INTERACT_BLOCKING

	user.visible_message(span_notice("[user.name] inserts the power control board into [src]."))
	balloon_alert(user, "Inserindo o tabuleiro...")
	playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)

	if(!do_after(user, 1 SECONDS, target = src) || has_electronics)
		return ITEM_INTERACT_BLOCKING

	has_electronics = APC_ELECTRONICS_INSTALLED
	locked = FALSE
	balloon_alert(user, "Placa instalada")
	qdel(installing_board)
	return ITEM_INTERACT_SUCCESS

/// Called when we interact with the APC with an electroadaptive pseudocircuit, used by cyborgs to install a board or weak cell
/obj/machinery/power/apc/proc/pseudocircuit_act(mob/living/user, obj/item/electroadaptive_pseudocircuit/pseudocircuit)
	if(!has_electronics)
		if(machine_stat & BROKEN)
			balloon_alert(user, "O quadro está muito danificado!")
			return ITEM_INTERACT_BLOCKING
		if(!pseudocircuit.adapt_circuit(user, circuit_cost = 0.05 * STANDARD_CELL_CHARGE))
			return ITEM_INTERACT_BLOCKING
		user.visible_message(
			span_notice("[user] fabricates a circuit and places it into [src]."),
			span_notice("You adapt a power control board and click it into place in [src]'s guts."),
		)
		has_electronics = APC_ELECTRONICS_INSTALLED
		locked = FALSE
		return ITEM_INTERACT_SUCCESS

	if(!cell)
		if(machine_stat & MAINT)
			balloon_alert(user, "Sem tábua para uma cela!")
			return ITEM_INTERACT_BLOCKING
		if(!pseudocircuit.adapt_circuit(user, circuit_cost = 0.5 * STANDARD_CELL_CHARGE))
			return ITEM_INTERACT_BLOCKING
		var/obj/item/stock_parts/power_store/battery/crap/empty/bad_cell = new(src)
		bad_cell.forceMove(src)
		cell = bad_cell
		user.visible_message(
			span_notice("[user] fabricates a weak power cell and places it into [src]."),
			span_warning("Your [pseudocircuit.name] whirrs with strain as you create a weak power cell and place it into [src]!"),
		)
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	balloon_alert(user, "Tem placa e celular!")
	return ITEM_INTERACT_BLOCKING

/// Called when we interact with the APC with and APC frame, used for replacing a damaged cover/frame
/obj/machinery/power/apc/proc/wallframe_act(mob/living/user, obj/item/wallframe/apc/wallframe)
	if(!opened)
		return NONE

	if(!(machine_stat & BROKEN || opened == APC_COVER_REMOVED || atom_integrity < max_integrity)) // There is nothing to repair
		balloon_alert(user, "Não há motivo para reparos!")
		return ITEM_INTERACT_BLOCKING
	if((machine_stat & BROKEN) && opened == APC_COVER_REMOVED && has_electronics && terminal) // Cover is the only thing broken, we do not need to remove elctronicks to replace cover
		user.visible_message(span_notice("[user.name] replaces missing APC's cover."))
		balloon_alert(user, "Substituindo o disfarce da APC...")
		if(!do_after(user, 2 SECONDS, target = src)) // replacing cover is quicker than replacing whole frame
			return ITEM_INTERACT_BLOCKING
		balloon_alert(user, "Capa substituída.")
		qdel(wallframe)
		update_integrity(30) //needs to be welded to fully repair but can work without
		set_machine_stat(machine_stat & ~(BROKEN|MAINT))
		opened = APC_COVER_OPENED
		update_appearance()
		return ITEM_INTERACT_SUCCESS
	if(has_electronics)
		balloon_alert(user, "Remova o tabuleiro para dentro!")
		return ITEM_INTERACT_BLOCKING
	user.visible_message(span_notice("[user.name] replaces the damaged APC frame with a new one."))
	balloon_alert(user, "Substituindo o quadro danificado...")
	if(!do_after(user, 5 SECONDS, target = src))
		return ITEM_INTERACT_BLOCKING
	balloon_alert(user, "Quadro substituído.")
	qdel(wallframe)
	set_machine_stat(machine_stat & ~BROKEN)
	atom_integrity = max_integrity
	if(opened == APC_COVER_REMOVED)
		opened = APC_COVER_OPENED
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/machinery/power/apc/crowbar_act(mob/user, obj/item/crowbar)
	. = TRUE

	//Prying off broken cover
	if((opened == APC_COVER_CLOSED || opened == APC_COVER_OPENED) && (machine_stat & BROKEN))
		crowbar.play_tool_sound(src)
		balloon_alert(user, "prying...")
		if(!crowbar.use_tool(src, user, 5 SECONDS))
			return
		opened = APC_COVER_REMOVED
		balloon_alert(user, "Capa removida.")
		update_appearance()
		return

	//Opening and closing cover
	if((!opened && opened != APC_COVER_REMOVED) && !(machine_stat & BROKEN))
		if(coverlocked && !(machine_stat & MAINT)) // locked...
			balloon_alert(user, "A cobertura está trancada!")
			return
		else if(panel_open)
			balloon_alert(user, "Os fios impedem a abertura!")
			return
		else
			opened = APC_COVER_OPENED
			update_appearance()
			return

	if((opened && has_electronics == APC_ELECTRONICS_SECURED) && !(machine_stat & BROKEN))
		opened = APC_COVER_CLOSED
		coverlocked = TRUE //closing cover relocks it
		balloon_alert(user, "Trancando a tampa.")
		update_appearance()
		return

	//Taking out the electronics
	if(!opened || has_electronics != APC_ELECTRONICS_INSTALLED)
		return
	if(terminal)
		balloon_alert(user, "Desligue os fios primeiro!")
		return
	crowbar.play_tool_sound(src)
	if(!crowbar.use_tool(src, user, 50))
		return
	if(has_electronics != APC_ELECTRONICS_INSTALLED)
		return
	has_electronics = APC_ELECTRONICS_MISSING
	if(machine_stat & BROKEN)
		user.visible_message(span_notice("[user.name] breaks the power control board inside [name]!"), \
			span_hear("Você ouve uma batida."))
		balloon_alert(user, "Quebras de tábua carbonizadas")
		return
	else if(obj_flags & EMAGGED)
		obj_flags &= ~EMAGGED
		user.visible_message(span_notice("[user.name] discards an emagged power control board from [name]!"))
		balloon_alert(user, "Descartado.")
		return
	else if(malfhack)
		user.visible_message(span_notice("[user.name] discards a strangely programmed power control board from [name]!"))
		balloon_alert(user, "Placa reprogramada descartada.")
		malfai = null
		malfhack = 0
		return
	user.visible_message(span_notice("[user.name] removes the power control board from [name]!"))
	balloon_alert(user, "Removeu o tabuleiro.")
	new /obj/item/electronics/apc(loc)
	return

/obj/machinery/power/apc/screwdriver_act(mob/living/user, obj/item/W)
	if(..())
		return TRUE
	. = TRUE

	if(!opened)
		if(obj_flags & EMAGGED)
			balloon_alert(user, "A interface está quebrada!")
			return
		toggle_panel_open()
		balloon_alert(user, "wires [panel_open ? "exposed" : "unexposed"]")
		W.play_tool_sound(src)
		update_appearance()
		return

	if(cell)
		user.visible_message(span_notice("[user] removes \the [cell] from [src]!"))
		balloon_alert(user, "célula removida")
		var/turf/user_turf = get_turf(user)
		cell.forceMove(user_turf)
		cell = null
		charging = APC_NOT_CHARGING
		update_appearance()
		return

	switch (has_electronics)
		if(APC_ELECTRONICS_INSTALLED)
			has_electronics = APC_ELECTRONICS_SECURED
			set_machine_stat(machine_stat & ~MAINT)
			W.play_tool_sound(src)
			balloon_alert(user, "Tábua presa")
		if(APC_ELECTRONICS_SECURED)
			has_electronics = APC_ELECTRONICS_INSTALLED
			set_machine_stat(machine_stat | MAINT)
			W.play_tool_sound(src)
			balloon_alert(user, "Tábua solta.")
		else
			balloon_alert(user, "Sem tábua para apertar!")
			return
	update_appearance()

/obj/machinery/power/apc/wirecutter_act(mob/living/user, obj/item/W)
	. = ..()
	if(terminal && opened)
		terminal.dismantle(user, W)
		return TRUE

/obj/machinery/power/apc/welder_act(mob/living/user, obj/item/welder)
	. = ..()

	//repairing the cover
	if((atom_integrity < max_integrity) && has_electronics)
		if(opened == APC_COVER_REMOVED)
			balloon_alert(user, "Sem cobertura para consertar!")
			return
		if (machine_stat & BROKEN)
			balloon_alert(user, "Muito danificado para reparar!")
			return
		if(!welder.tool_start_check(user, amount=1))
			return
		balloon_alert(user, "repairing...")
		if(welder.use_tool(src, user, 4 SECONDS, volume = 50))
			update_integrity(min(atom_integrity += 50,max_integrity))
			balloon_alert(user, "repaired")
		return ITEM_INTERACT_SUCCESS

	//disassembling the frame
	if(!opened || has_electronics || terminal)
		return
	if(!welder.tool_start_check(user, amount=1))
		return
	user.visible_message(span_notice("[user.name] welds [src]."), \
						span_hear("Você ouve solda."))
	balloon_alert(user, "soldando o quadro APC")
	if(!welder.use_tool(src, user, 50, volume=50))
		return
	if((machine_stat & BROKEN) || opened == APC_COVER_REMOVED)
		new /obj/item/stack/sheet/iron(loc)
		user.visible_message(span_notice("[user.name] cuts [src] apart with [welder]."))
		user.balloon_alert(user, "Desmontou a moldura quebrada.")
	else
		new /obj/item/wallframe/apc(loc)
		user.visible_message(span_notice("[user.name] cuts [src] from the wall with [welder]."))
		user.balloon_alert(user, "Corte a moldura da parede.")
	qdel(src)
	return TRUE

/obj/machinery/power/apc/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	if(!(the_rcd.construction_upgrades & RCD_UPGRADE_SIMPLE_CIRCUITS))
		return FALSE

	if(!has_electronics)
		if(machine_stat & BROKEN)
			balloon_alert(user, "O quadro está muito danificado!")
			return FALSE
		return list("delay" = 2 SECONDS, "cost" = 1)

	if(!cell)
		if(machine_stat & MAINT)
			balloon_alert(user, "Sem tábua para uma cela!")
			return FALSE
		return list("delay" = 5 SECONDS, "cost" = 10)

	balloon_alert(user, "Tem placa e celular!")
	return FALSE

/obj/machinery/power/apc/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, list/rcd_data)
	if(!(the_rcd.construction_upgrades & RCD_UPGRADE_SIMPLE_CIRCUITS) || rcd_data[RCD_DESIGN_MODE] != RCD_WALLFRAME)
		return FALSE

	if(!has_electronics)
		if(machine_stat & BROKEN)
			balloon_alert(user, "O quadro está muito danificado!")
			return
		balloon_alert(user, "Placa de controle colocada.")
		has_electronics = TRUE
		locked = TRUE
		return TRUE

	if(!cell)
		if(machine_stat & MAINT)
			balloon_alert(user, "Sem tábua para uma cela!")
			return FALSE
		var/obj/item/stock_parts/power_store/battery/crap/empty/C = new(src)
		C.forceMove(src)
		cell = C
		balloon_alert(user, "Célula de energia instalada.")
		update_appearance()
		return TRUE

	balloon_alert(user, "Tem placa e celular!")
	return FALSE

/obj/machinery/power/apc/emag_act(mob/user, obj/item/card/emag/emag_card)
	if((obj_flags & EMAGGED) || malfhack)
		return FALSE

	if(opened)
		balloon_alert(user, "Feche a tampa primeiro!")
		return FALSE
	else if(panel_open)
		balloon_alert(user, "Feche o painel primeiro!")
		return FALSE
	else if(machine_stat & (BROKEN|MAINT))
		balloon_alert(user, "Nada acontece!")
		return FALSE
	else
		flick("apc-spark", src)
		playsound(src, SFX_SPARKS, 75, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		obj_flags |= EMAGGED
		locked = FALSE
		balloon_alert(user, "interface danificada.")
		update_appearance()
		flicker_hacked_icon()
		return TRUE

// damage and destruction acts
/obj/machinery/power/apc/emp_act(severity)
	. = ..()
	if(!(. & EMP_PROTECT_CONTENTS))
		if(cell)
			cell.emp_act(severity)
		if(occupier)
			occupier.emp_act(severity)
	if(. & EMP_PROTECT_SELF)
		return
	lighting = APC_CHANNEL_OFF
	equipment = APC_CHANNEL_OFF
	environ = APC_CHANNEL_OFF
	update_appearance()
	update()
	addtimer(CALLBACK(src, PROC_REF(reset), APC_RESET_EMP), 60 SECONDS)

/obj/machinery/power/apc/proc/togglelock(mob/living/user)
	if(obj_flags & EMAGGED)
		balloon_alert(user, "A interface está quebrada!")
	else if(opened)
		balloon_alert(user, "Feche a tampa primeiro!")
	else if(panel_open)
		balloon_alert(user, "Feche o painel primeiro!")
	else if(machine_stat & (BROKEN|MAINT))
		balloon_alert(user, "Nada acontece!")
	else
		if(allowed(usr) && !wires.is_cut(WIRE_IDSCAN) && ((!malfhack && !remote_control_user) || (malfhack && (malfai == user || (user in malfai.connected_robots)))))
			locked = !locked
			balloon_alert(user, locked ? "locked" : "unlocked")
			update_appearance()
		else
			balloon_alert(user, "Acesso negado!")
