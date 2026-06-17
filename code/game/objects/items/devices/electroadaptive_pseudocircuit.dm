#define MIN_ENERGY_COST (0.01 * STANDARD_CELL_CHARGE)
#define MAX_ENERGY_COST (0.5 * STANDARD_CELL_CHARGE)

//Used by engineering cyborgs in place of generic circuits.
/obj/item/electroadaptive_pseudocircuit
	name = "electroadaptive pseudocircuit"
	desc = "Um impressor de circuito único, designer, sintetizador, maquinista, criador e chef. Pode ser usado no lugar de qualquer placa de circuito genérico durante a construção."
	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	icon_state = "boris"
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3)
	var/recharging = FALSE
	var/circuits = 5 //How many circuits the pseudocircuit has left
	var/static/recycleable_circuits = typecacheof(list(
		/obj/item/electronics/firelock,
		/obj/item/electronics/airalarm,
		/obj/item/electronics/firealarm,
		/obj/item/electronics/apc,
	))//A typecache of circuits consumable for material

/obj/item/electroadaptive_pseudocircuit/Initialize(mapload)
	. = ..()
	maptext = MAPTEXT(circuits)

/obj/item/electroadaptive_pseudocircuit/examine(mob/user)
	. = ..()
	if(iscyborg(user))
		. += "[span_notice("It has material for <b>[circuits]</b> circuit[circuits == 1 ? "" : "s"]. Use the pseudocircuit on existing circuits to gain material.")]\n"+\
		"[span_notice("Serves as a substitute for <b>fire/air alarm</b>, <b>firelock</b>, and <b>APC</b> electronics.")]\n"+\
		span_notice("Também pode ser usado em um APC sem célula de energia para<b>Fabricar uma célula de baixa capacidade</b>com um alto custo de energia.")

/obj/item/electroadaptive_pseudocircuit/proc/adapt_circuit(mob/living/silicon/robot/R, circuit_cost = 0)
	if(QDELETED(R) || !istype(R))
		return
	if(!R.cell)
		to_chat(R, span_warning("Precisa de uma célula de energia instalada para isso."))
		return
	if(recharging)
		to_chat(R, span_warning("[src] needs some time to recharge first."))
		return
	if(!R.cell.use(circuit_cost))
		to_chat(R, span_warning("You don't have the energy for that (you need [display_energy(circuit_cost)].)"))
		return
	if(!circuits)
		to_chat(R, span_warning("You need more material. Use [src] on existing simple circuits to break them down."))
		return
	playsound(R, 'sound/items/tools/rped.ogg', 50, TRUE)
	recharging = TRUE
	circuits--
	maptext = MAPTEXT(circuits)
	icon_state = "[initial(icon_state)]_recharging"
	var/recharge_time = (circuit_cost - MIN_ENERGY_COST) / (MAX_ENERGY_COST - MIN_ENERGY_COST)
	recharge_time = clamp(recharge_time, 0, 1)
	recharge_time = (5 SECONDS) + (55 SECONDS) * recharge_time //anywhere between 5 seconds to 1 minute
	addtimer(CALLBACK(src, PROC_REF(recharge)), ROUND_UP(recharge_time))
	return TRUE //The actual circuit magic itself is done on a per-object basis

/obj/item/electroadaptive_pseudocircuit/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!is_type_in_typecache(interacting_with, recycleable_circuits))
		return NONE
	circuits++
	maptext = MAPTEXT(circuits)
	user.visible_message(
		span_notice("User breaks down [interacting_with] with [src]."),
		span_notice("You recycle [interacting_with] into [src]. It now has material for <b>[circuits]</b> circuits.")
	)
	playsound(user, 'sound/items/deconstruct.ogg', 50, TRUE)
	qdel(interacting_with)
	return ITEM_INTERACT_SUCCESS

/obj/item/electroadaptive_pseudocircuit/proc/recharge()
	playsound(src, 'sound/machines/chime.ogg', 25, TRUE)
	recharging = FALSE
	icon_state = initial(icon_state)

#undef MIN_ENERGY_COST
#undef MAX_ENERGY_COST
