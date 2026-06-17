/**
 * This file contain the eight parts surrounding the main core, those are: fuel input, moderator input, waste output, interface and the corners
 * The file also contain the guicode of the machine
 */
/obj/machinery/atmospherics/components/unary/hypertorus
	icon = 'icons/obj/machines/atmospherics/hypertorus.dmi'
	icon_state = "core"
	base_icon_state = "core"

	name = "thermomachine"
	desc = "Aquece ou esfria gás em tubos conectados."
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	flags_1 = PREVENT_CONTENTS_EXPLOSION_1
	layer = OBJ_LAYER
	pipe_flags = PIPING_ONE_PER_TURF | PIPING_DEFAULT_LAYER_ONLY
	circuit = /obj/item/circuitboard/machine/thermomachine
	///Check if the machine has been activated
	var/active = FALSE
	///Check if fusion has started
	var/fusion_started = FALSE
	///Check if the machine is cracked open
	var/cracked = FALSE

/obj/machinery/atmospherics/components/unary/hypertorus/Initialize(mapload)
	. = ..()
	initialize_directions = dir

/obj/machinery/atmospherics/components/unary/hypertorus/examine(mob/user)
	. = ..()
	. += span_notice("[src] can be rotated by first opening the panel with a screwdriver and then using a wrench on it.")

/obj/machinery/atmospherics/components/unary/hypertorus/screwdriver_act(mob/living/user, obj/item/tool)
	return fusion_started ? NONE : default_deconstruction_screwdriver(user, tool)

/obj/machinery/atmospherics/components/unary/hypertorus/wrench_act(mob/living/user, obj/item/I)
	return default_change_direction_wrench(user, I)

/obj/machinery/atmospherics/components/unary/hypertorus/welder_act(mob/living/user, obj/item/tool)
	if(!cracked)
		return FALSE
	if(user.combat_mode)
		return FALSE
	balloon_alert(user, "repairing...")
	if(tool.use_tool(src, user, 10 SECONDS, volume=30))
		balloon_alert(user, "repaired")
		cracked = FALSE
		update_appearance(UPDATE_ICON)

/obj/machinery/atmospherics/components/unary/hypertorus/crowbar_act(mob/living/user, obj/item/tool)
	return crowbar_deconstruction_act(user, tool)

/obj/machinery/atmospherics/components/unary/hypertorus/update_icon_state()
	if(panel_open)
		icon_state = "[base_icon_state]_open"
		return ..()
	icon_state = base_icon_state
	return ..()

/obj/machinery/atmospherics/components/unary/hypertorus/update_overlays()
	. = ..()
	if(cracked)
		. += image(icon, "crack", dir = src.dir)
	if(active)
		. += "[base_icon_state]_active"
		. += emissive_appearance(icon, "[base_icon_state]_active", src, alpha = src.alpha)

/obj/machinery/atmospherics/components/unary/hypertorus/update_layer()
	return

/obj/machinery/atmospherics/components/unary/hypertorus/fuel_input
	name = "HFR fuel input port"
	desc = "Porta de entrada para o reator Hypertorus Fusion, projetado para absorver combustíveis com a mistura de combustível sendo 50/50."
	icon_state = "fuel_input"
	base_icon_state = "fuel_input"
	circuit = /obj/item/circuitboard/machine/HFR_fuel_input

/obj/machinery/atmospherics/components/unary/hypertorus/waste_output
	name = "HFR waste output port"
	desc = "Porta de lixo para o reator Hypertorus Fusion, projetado para produzir os gases de resíduos quentes vindos do núcleo da máquina."
	icon_state = "waste_output"
	base_icon_state = "waste_output"
	circuit = /obj/item/circuitboard/machine/HFR_waste_output

/obj/machinery/atmospherics/components/unary/hypertorus/moderator_input
	name = "HFR moderator input port"
	desc = "Porta de moderador para o reator de fusão Hypertorus, projetado para mover gases dentro da máquina para esfriar e controlar o fluxo da reação."
	icon_state = "moderator_input"
	base_icon_state = "moderator_input"
	circuit = /obj/item/circuitboard/machine/HFR_moderator_input

/*
* Interface and corners
*/
/obj/machinery/hypertorus
	name = "hypertorus_core"
	desc = "hypertorus_core"
	icon = 'icons/obj/machines/atmospherics/hypertorus.dmi'
	icon_state = "core"
	base_icon_state = "core"
	move_resist = INFINITY
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	flags_1 = PREVENT_CONTENTS_EXPLOSION_1
	power_channel = AREA_USAGE_ENVIRON
	var/active = FALSE
	var/fusion_started = FALSE

/obj/machinery/hypertorus/examine(mob/user)
	. = ..()
	. += span_notice("[src] can be rotated by first opening the panel with a screwdriver and then using a wrench on it.")

/obj/machinery/hypertorus/screwdriver_act(mob/living/user, obj/item/tool)
	return fusion_started ? NONE : default_deconstruction_screwdriver(user, tool)

/obj/machinery/hypertorus/wrench_act(mob/living/user, obj/item/tool)
	return default_change_direction_wrench(user, tool)

/obj/machinery/hypertorus/crowbar_act(mob/living/user, obj/item/tool)
	return default_deconstruction_crowbar(user, tool)

/obj/machinery/hypertorus/update_icon_state()
	if(panel_open)
		icon_state = "[base_icon_state]_open"
		return ..()
	icon_state = base_icon_state
	return ..()

/obj/machinery/hypertorus/update_overlays()
	. = ..()
	if(active)
		. += "[base_icon_state]_active"
		. += emissive_appearance(icon, "[base_icon_state]_active", src, alpha = src.alpha)

/obj/machinery/hypertorus/interface
	name = "HFR interface"
	desc = "Interface para o HFR controlar o fluxo da reação."
	icon_state = "interface"
	base_icon_state = "interface"
	circuit = /obj/item/circuitboard/machine/HFR_interface
	/// Have we been activated at least once?
	var/activated = FALSE
	/// Reference to the core of our machine
	var/obj/machinery/atmospherics/components/unary/hypertorus/core/connected_core

/obj/machinery/hypertorus/interface/Destroy()
	if(connected_core)
		connected_core = null
	return..()

/obj/machinery/hypertorus/interface/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	var/turf/T = get_step(src,REVERSE_DIR(dir))
	var/obj/machinery/atmospherics/components/unary/hypertorus/core/centre = locate() in T

	if(!centre || !centre.check_part_connectivity())
		to_chat(user, span_notice("Verifique todas as peças e tente novamente."))
		return TRUE

	connected_core = centre
	connected_core.activate(user)
	if(!activated)
		new /obj/item/paper/guides/jobs/atmos/hypertorus(loc)
		activated = TRUE

	return TRUE

/obj/machinery/hypertorus/interface/ui_interact(mob/user, datum/tgui/ui)
	if(active)
		ui = SStgui.try_update_ui(user, src, ui)
		if(!ui)
			ui = new(user, src, "Hypertorus", name)
			ui.open()
	else
		to_chat(user, span_notice("Ative a máquina primeiro usando uma multitool na interface."))
		ui.close()

/obj/machinery/hypertorus/interface/proc/gas_list_to_gasid_list(list/gas_list)
	var/list/gasid_list = list()
	for(var/gas_type in gas_list)
		var/datum/gas/gas = gas_type
		gasid_list += initial(gas.id)
	return gasid_list



/obj/machinery/hypertorus/interface/ui_static_data()
	var/data = list()
	data["base_max_temperature"] = FUSION_MAXIMUM_TEMPERATURE
	data["selectable_fuel"] = list(list("name" = "Nothing", "id" = null))
	for(var/path in GLOB.hfr_fuels_list)
		var/datum/hfr_fuel/recipe = GLOB.hfr_fuels_list[path]

		data["selectable_fuel"] += list(list(
			"name" = recipe.name,
			"id" = recipe.id,
			"requirements" = gas_list_to_gasid_list(recipe.requirements),
			"fusion_byproducts" = gas_list_to_gasid_list(recipe.primary_products),
			"product_gases" = gas_list_to_gasid_list(recipe.secondary_products),
			"recipe_cooling_multiplier" = recipe.negative_temperature_multiplier,
			"recipe_heating_multiplier" = recipe.positive_temperature_multiplier,
			"energy_loss_multiplier" = recipe.energy_concentration_multiplier,
			"fuel_consumption_multiplier" = recipe.fuel_consumption_multiplier,
			"gas_production_multiplier" = recipe.gas_production_multiplier,
			"temperature_multiplier" = recipe.temperature_change_multiplier,
		))
	return data

/obj/machinery/hypertorus/interface/ui_data()
	var/data = list()

	if(connected_core.selected_fuel)
		data["selected"] = connected_core.selected_fuel.id
	else
		data["selected"] = ""

	//Internal Fusion gases
	var/list/fusion_gasdata = list()
	if(connected_core.internal_fusion.total_moles())
		for(var/gas_type in connected_core.internal_fusion.gases)
			var/datum/gas/gas = gas_type
			fusion_gasdata.Add(list(list(
			"id"= initial(gas.id),
			"amount" = round(connected_core.internal_fusion.gases[gas][MOLES], 0.01),
			)))
	else
		for(var/gas_type in connected_core.internal_fusion.gases)
			var/datum/gas/gas = gas_type
			fusion_gasdata.Add(list(list(
				"id"= initial(gas.id),
				"amount" = 0,
				)))
	//Moderator gases
	var/list/moderator_gasdata = list()
	if(connected_core.moderator_internal.total_moles())
		for(var/gas_type in connected_core.moderator_internal.gases)
			var/datum/gas/gas = gas_type
			moderator_gasdata.Add(list(list(
			"id"= initial(gas.id),
			"amount" = round(connected_core.moderator_internal.gases[gas][MOLES], 0.01),
			)))
	else
		for(var/gas_type in connected_core.moderator_internal.gases)
			var/datum/gas/gas = gas_type
			moderator_gasdata.Add(list(list(
				"id"= initial(gas.id),
				"amount" = 0,
				)))

	data["fusion_gases"] = fusion_gasdata
	data["moderator_gases"] = moderator_gasdata

	data["energy_level"] = connected_core.energy
	data["heat_limiter_modifier"] = connected_core.heat_limiter_modifier
	data["heat_output_min"] = connected_core.heat_output_min
	data["heat_output_max"] = connected_core.heat_output_max
	data["heat_output"] = connected_core.heat_output
	data["instability"] = connected_core.instability

	data["heating_conductor"] = connected_core.heating_conductor
	data["magnetic_constrictor"] = connected_core.magnetic_constrictor
	data["fuel_injection_rate"] = connected_core.fuel_injection_rate
	data["moderator_injection_rate"] = connected_core.moderator_injection_rate
	data["current_damper"] = connected_core.current_damper

	data["power_level"] = connected_core.power_level
	data["apc_energy"] = connected_core.get_area_cell_percent()
	data["iron_content"] = connected_core.iron_content
	data["integrity"] = connected_core.get_integrity_percent()

	data["start_power"] = connected_core.start_power
	data["start_cooling"] = connected_core.start_cooling
	data["start_fuel"] = connected_core.start_fuel
	data["start_moderator"] = connected_core.start_moderator

	data["internal_fusion_temperature"] = connected_core.fusion_temperature
	data["moderator_internal_temperature"] = connected_core.moderator_temperature
	data["internal_output_temperature"] = connected_core.output_temperature
	data["internal_coolant_temperature"] = connected_core.coolant_temperature

	data["internal_fusion_temperature_archived"] = connected_core.fusion_temperature_archived
	data["moderator_internal_temperature_archived"] = connected_core.moderator_temperature_archived
	data["internal_output_temperature_archived"] = connected_core.output_temperature_archived
	data["internal_coolant_temperature_archived"] = connected_core.coolant_temperature_archived
	data["temperature_period"] = connected_core.temperature_period

	data["waste_remove"] = connected_core.waste_remove
	data["filter_types"] = list()
	for(var/path in GLOB.meta_gas_info)
		var/list/gas = GLOB.meta_gas_info[path]
		data["filter_types"] += list(list("gas_id" = gas[META_GAS_ID], "gas_name" = gas[META_GAS_NAME], "enabled" = (path in connected_core.moderator_scrubbing)))

	data["cooling_volume"] = connected_core.airs[1].volume
	data["mod_filtering_rate"] = connected_core.moderator_filtering_rate

	return data

/obj/machinery/hypertorus/interface/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("start_power")
			connected_core.start_power = !connected_core.start_power
			connected_core.update_use_power(connected_core.start_power ? ACTIVE_POWER_USE : IDLE_POWER_USE)
			. = TRUE
		if("start_cooling")
			connected_core.start_cooling = !connected_core.start_cooling
			. = TRUE
		if("start_fuel")
			connected_core.start_fuel = !connected_core.start_fuel
			. = TRUE
		if("start_moderator")
			connected_core.start_moderator = !connected_core.start_moderator
			. = TRUE
		if("heating_conductor")
			var/heating_conductor = text2num(params["heating_conductor"])
			if(heating_conductor != null)
				connected_core.heating_conductor = clamp(heating_conductor, 50, 500)
				. = TRUE
		if("magnetic_constrictor")
			var/magnetic_constrictor = text2num(params["magnetic_constrictor"])
			if(magnetic_constrictor != null)
				connected_core.magnetic_constrictor = clamp(magnetic_constrictor, 50, 1000)
				. = TRUE
		if("fuel_injection_rate")
			var/fuel_injection_rate = text2num(params["fuel_injection_rate"])
			if(fuel_injection_rate != null)
				connected_core.fuel_injection_rate = clamp(fuel_injection_rate, 0.5, 150)
				. = TRUE
		if("moderator_injection_rate")
			var/moderator_injection_rate = text2num(params["moderator_injection_rate"])
			if(moderator_injection_rate != null)
				connected_core.moderator_injection_rate = clamp(moderator_injection_rate, 0.5, 150)
				. = TRUE
		if("current_damper")
			var/current_damper = text2num(params["current_damper"])
			if(current_damper != null)
				connected_core.current_damper = clamp(current_damper, 0, 1000)
				. = TRUE
		if("waste_remove")
			connected_core.waste_remove = !connected_core.waste_remove
			. = TRUE
		if("filter")
			connected_core.moderator_scrubbing ^= gas_id2path(params["mode"])
			. = TRUE
		if("mod_filtering_rate")
			var/mod_filtering_rate = text2num(params["mod_filtering_rate"])
			if(mod_filtering_rate != null)
				connected_core.moderator_filtering_rate = clamp(mod_filtering_rate, 5, 200)
				. = TRUE
		if("fuel")
			connected_core.selected_fuel = null
			var/fuel_mix = "nothing"
			var/datum/hfr_fuel/fuel = null
			if(params["mode"] != "")
				fuel = GLOB.hfr_fuels_list[params["mode"]]
			if(fuel)
				connected_core.selected_fuel = fuel
				fuel_mix = fuel.name
			if(connected_core.internal_fusion.total_moles())
				connected_core.dump_gases()
			connected_core.update_parents() //prevent the machine from stopping because of the recipe change and the pipenet not updating
			connected_core.linked_input.update_parents()
			connected_core.linked_output.update_parents()
			connected_core.linked_moderator.update_parents()
			investigate_log("was set to recipe [fuel_mix ? fuel_mix : "null"] by [key_name(usr)]", INVESTIGATE_ATMOS)
			. = TRUE
		if("cooling_volume")
			var/cooling_volume = text2num(params["cooling_volume"])
			if(cooling_volume != null)
				connected_core.airs[1].volume = clamp(cooling_volume, 50, 2000)
				. = TRUE

/obj/machinery/hypertorus/corner
	name = "HFR corner"
	desc = "Um pedaço estrutural da máquina."
	icon_state = "corner"
	base_icon_state = "corner"
	circuit = /obj/item/circuitboard/machine/HFR_corner

/obj/item/paper/guides/jobs/atmos/hypertorus
	name = "paper- 'Quick guide to safe handling of the HFR'"
	default_raw_text = "<B>Como operar o Hypertorus</B><BR>\
-Construa a máquina como mostra no guia principal.<BR>\
- Faça um gás 50/50 de trítio e hidrogênio totalizando cerca de 2000 toupeiras.<BR>\
-Inicie a máquina, encha o laço de refrigeração com plasma/hipernoblium e use espaço ou freezers para esfriá-lo.<BR>\
- Conectar a mistura de combustível na porta do injetor de combustível, permitir apenas 1000 moles na máquina para facilitar o arranque da reação<BR>\
- Ajuste o condutor de calor para 500 quando iniciar a reação, resetá-lo para 100 quando o nível de potência é superior a 1<BR>\
- Em caso de fusão, ajuste o condutor de calor para o máximo e ajuste o amortecedor de corrente para o máximo. Coloque a injeção de combustível no min.\
Se a saída de calor não for negativa, tente mudar os custos magnéticos até que a saída de calor seja negativa.\
Faça o resfriamento mais forte, coloque gases de alta capacidade de calor dentro do moderador (hipernoblium ajudará a lidar com o problema)<BR><BR>\
	<B>Avisos:</B><BR>\
Você não pode desmontar a máquina se o nível de energia está acima de 0<BR>\
- Você não pode poder da máquina se o nível de potência é mais de 0<BR>\
- Você não pode se livrar de gases se o nível de energia é mais de 5<BR>\
- Você não pode remover gases da mistura de fusão se eles não são hélio e antinoblium<BR>\
-Hypernoblium vai diminuir muito o poder da mistura.<BR>\
- Antinoblium vai aumentar o poder da mistura por muito mais<BR>\
- Gases de alta capacidade de calor são mais difíceis de aquecer/frio<BR>\
- Gases de baixa capacidade de calor são mais fáceis de aquecer/frio<BR>\
- A máquina consome 50 KW por nível de potência, atingindo 350 KW no nível de potência 6 então prepare o SM de acordo.<BR>\
Em caso de falta de energia, a reação de fusão continuará, mas o resfriamento irá parar.<BR><BR>\
O escritor do guia rápido não será responsabilizado pelos abusos e colapso causados pelo uso do guia,\
Use guias mais avançados para entender como os vários gases agirão como moderadores."

/obj/item/hfr_box
	name = "HFR box"
	desc = "Se vir isso, chame a polícia."
	icon = 'icons/obj/machines/atmospherics/hypertorus.dmi'
	icon_state = "error"
	///What kind of box are we handling?
	var/box_type = "impossible"
	///What's the path of the machine we making
	var/part_path

/obj/item/hfr_box/corner
	name = "HFR box corner"
	desc = "Coloque isto como o canto do seu reator de fusão multibloco 3x3"
	icon_state = "box_corner"
	box_type = "corner"
	part_path = /obj/machinery/hypertorus/corner

/obj/item/hfr_box/body
	name = "HFR box body"
	desc = "Coloque isto nos lados da caixa do núcleo do seu reator de fusão multibloco 3x3"
	box_type = "body"
	icon_state = "box_body"

/obj/item/hfr_box/body/fuel_input
	name = "HFR box fuel input"
	icon_state = "box_fuel"
	part_path = /obj/machinery/atmospherics/components/unary/hypertorus/fuel_input

/obj/item/hfr_box/body/moderator_input
	name = "HFR box moderator input"
	icon_state = "box_moderator"
	part_path = /obj/machinery/atmospherics/components/unary/hypertorus/moderator_input

/obj/item/hfr_box/body/waste_output
	name = "HFR box waste output"
	icon_state = "box_waste"
	part_path = /obj/machinery/atmospherics/components/unary/hypertorus/waste_output

/obj/item/hfr_box/body/interface
	name = "HFR box interface"
	part_path = /obj/machinery/hypertorus/interface

/obj/item/hfr_box/core
	name = "HFR box core"
	desc = "Ative isso com uma multitool para implantar a máquina completa depois de configurar as outras caixas."
	icon_state = "box_core"
	box_type = "core"
	part_path = /obj/machinery/atmospherics/components/unary/hypertorus/core

/obj/item/hfr_box/core/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	var/list/parts = list()
	for(var/obj/item/hfr_box/box in orange(1,src))
		var/direction = get_dir(src, box)
		if(box.box_type == "corner")
			if(ISDIAGONALDIR(direction))
				switch(direction)
					if(NORTHEAST)
						direction = EAST
					if(SOUTHEAST)
						direction = SOUTH
					if(SOUTHWEST)
						direction = WEST
					if(NORTHWEST)
						direction = NORTH
				box.dir = direction
				parts |= box
			continue
		if(box.box_type == "body")
			if(direction in GLOB.cardinals)
				box.dir = direction
				parts |= box
			continue
	if(parts.len == 8)
		build_reactor(parts)
	return

/obj/item/hfr_box/core/proc/build_reactor(list/parts)
	for(var/obj/item/hfr_box/box in parts)
		if(box.box_type == "corner")
			var/obj/machinery/hypertorus/corner/corner = new box.part_path(box.loc)
			corner.dir = box.dir
			qdel(box)
			continue
		if(box.box_type == "body")
			var/location = get_turf(box)
			if(box.part_path != /obj/machinery/hypertorus/interface)
				var/obj/machinery/atmospherics/components/unary/hypertorus/part = new box.part_path(location, TRUE, box.dir)
				part.dir = box.dir
			else
				var/obj/machinery/hypertorus/interface/part = new box.part_path(location)
				part.dir = box.dir
			qdel(box)
			continue

	new/obj/machinery/atmospherics/components/unary/hypertorus/core(loc, TRUE)
	qdel(src)
