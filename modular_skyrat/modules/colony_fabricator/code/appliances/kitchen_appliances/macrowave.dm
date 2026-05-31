/obj/machinery/microwave/frontier_printed
	desc = "Um forno de microondas de painéis plásticos, capaz de fazer qualquer coisa que um micro-ondas padrão pudesse fazer. Este é especial projetado para ser firmemente embalado em uma forma que pode ser facilmente montado mais tarde da fábrica. Parece que não há instruções para dobrá-lo de volta."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/kitchen_stuff/microwave.dmi'
	circuit = null
	max_n_of_items = 5
	efficiency = 2
	vampire_charging_capable = TRUE

/obj/machinery/microwave/frontier_printed/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

/obj/machinery/microwave/frontier_printed/RefreshParts()
	. = ..()
	max_n_of_items = 5
	efficiency = 2
	vampire_charging_capable = TRUE

/obj/machinery/microwave/frontier_printed/examine(mob/user)
	. = ..()
	. += span_notice("Não pode ser reembalado, mas pode ser desconstruído normalmente.")

/obj/machinery/microwave/frontier_printed/unanchored
	anchored = FALSE

// Deployable item for cargo

/obj/item/flatpacked_machine/macrowave
	name = "microwave oven parts kit"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/kitchen_stuff/microwave.dmi'
	icon_state = "packed_microwave"
	w_class = WEIGHT_CLASS_NORMAL
	type_to_deploy = /obj/machinery/microwave/frontier_printed
	deploy_time = 2 SECONDS
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
