/obj/machinery/oven/range_frontier
	name = "frontier range"
	desc = "Um forno combinado e fogão comumente visto na fronteira. Vem da fábrica embalada em um formato perfeitamente compacto que pode então ser implantado em um aparelho de tamanho quase completo. Parece, no entanto, que o designer esqueceu de incluir instruções sobre embalar essas coisas de volta."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/kitchen_stuff/range.dmi'
	icon_state = "range_off"
	base_icon_state = "range"
	pass_flags_self = PASSMACHINE|PASSTABLE|LETPASSTHROW
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 1.2
	circuit = null

/obj/machinery/oven/range_frontier/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)
	AddComponent(/datum/component/stove, container_x = -3, container_y = 14)

/obj/machinery/oven/range_frontier/examine(mob/user)
	. = ..()
	. += span_notice("Não pode ser reembalado, mas pode ser desconstruído normalmente.")

/obj/machinery/oven/range_frontier/unanchored
	anchored = FALSE

// Deployable item for cargo

/obj/item/flatpacked_machine/frontier_range
	name = "frontier range parts kit"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/kitchen_stuff/range.dmi'
	icon_state = "range_packed"
	w_class = WEIGHT_CLASS_NORMAL
	type_to_deploy = /obj/machinery/oven/range_frontier
	deploy_time = 2 SECONDS
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
