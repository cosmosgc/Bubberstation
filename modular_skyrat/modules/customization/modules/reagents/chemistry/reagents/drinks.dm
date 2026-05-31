/obj/item/reagent_containers/cup/soda_cans/skyrat/lubricola
	name = "LubriCola"
	desc = "O lubrificante perfeito para suas engrenagens cansadas."
	icon_state = "lubricola"
	list_reagents = list(/datum/reagent/fuel/oil = 30)
	custom_price = PAYCHECK_LOWER * 1.2

/obj/item/reagent_containers/cup/soda_cans/skyrat/welding_fizz
	name = "Welding Fizz"
	desc = "Mais energia do que em um explosivo! Agora carbonatado. ATENÇÃO: contém combustíveis tóxicos e inflamáveis."
	icon_state = "welding_fizz"
	list_reagents = list(/datum/reagent/fuel = 25, /datum/reagent/carbondioxide = 5)
	custom_price = PAYCHECK_LOWER * 1.2

/obj/item/reagent_containers/cup/soda_cans/skyrat/synthanolcan
	name = "Silly Cone's Synthanol"
	desc = "Uma lata de recompilação de sintanol."
	icon_state = "synthanolcan"
	list_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 30)
	custom_price = PAYCHECK_CREW

//CODING SIN BYOND HERE

/obj/item/trash/can/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/janitor.dmi'
	icon_state = "lemonade"

/*
*	SKYRAT SODA CANS
*/

/// How much fizziness is added to the can of soda by throwing it, in percentage points
#define SODA_FIZZINESS_THROWN 15
/// How much fizziness is added to the can of soda by shaking it, in percentage points
#define SODA_FIZZINESS_SHAKE 5

/obj/item/reagent_containers/cup/soda_cans/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = null

/obj/item/reagent_containers/cup/soda_cans/skyrat/attack(mob/M, mob/living/user)
	if(istype(M, /mob/living/carbon) && !reagents.total_volume && user.combat_mode && user.zone_selected == BODY_ZONE_HEAD)
		if(M == user)
			user.visible_message(span_warning("[user]Esmaga a lata de[src]Vamos.[user.p_their()]testa!"), span_notice("Você esmaga a lata de[src]Na sua testa."))
		else
			user.visible_message(span_warning("[user]Esmaga a lata de[src]Vamos.[M]A testa!"), span_notice("Você esmaga a lata de[src]Vamos.[M]Na testa."))
		playsound(M,'sound/items/weapons/pierce.ogg', rand(10,50), TRUE)
		var/obj/item/trash/can/skyrat/crushed_can = new /obj/item/trash/can/skyrat(M.loc)
		crushed_can.icon_state = icon_state
		qdel(src)
		return TRUE
	. = ..()

/obj/item/reagent_containers/cup/soda_cans/skyrat/bullet_act(obj/projectile/hitting_projectile, def_zone, piercing_hit = FALSE)
	. = ..()

	if(. != BULLET_ACT_HIT)
		return

	if(hitting_projectile.damage > 0 && hitting_projectile.damage_type == BRUTE && !QDELETED(src))
		var/obj/item/trash/can/skyrat/crushed_can = new /obj/item/trash/can/skyrat(src.loc)
		crushed_can.icon_state = icon_state
		var/atom/throw_target = get_edge_target_turf(crushed_can, pick(GLOB.alldirs))
		crushed_can.throw_at(throw_target, rand(1,2), 7)
		qdel(src)
		return

/**
 * Burst the soda open on someone. Fun! Opens and empties the soda can, but does not crush it.
 *
 * Arguments:
 * * target - Who's getting covered in soda
 * * hide_message - Stops the generic fizzing message, so you can do your own
 */

/obj/item/reagent_containers/cup/soda_cans/skyrat/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(. || !reagents.total_volume) // if it was caught, already opened, or has nothing in it
		return

	fizziness += SODA_FIZZINESS_THROWN
	if(!prob(fizziness))
		return

	burst_soda(hit_atom, hide_message = TRUE)
	visible_message(span_danger("[src]O impacto com[hit_atom]causa a ruptura, derramando em todo lugar!"))
	var/obj/item/trash/can/skyrat/crushed_can = new /obj/item/trash/can/skyrat(src.loc)
	crushed_can.icon_state = icon_state
	moveToNullspace()
	QDEL_IN(src, 1 SECONDS) // give it a second so it can still be logged for the throw impact

#undef SODA_FIZZINESS_THROWN
#undef SODA_FIZZINESS_SHAKE
