
/obj/vehicle/ridden/secway
	name = "secway"
	desc = "Um bravo cyborg de segurança deu sua vida para ajudá-lo a parecer uma ferramenta completa."
	icon_state = "secway"
	max_integrity = 60
	armor_type = /datum/armor/ridden_secway
	key_type = /obj/item/key/security
	integrity_failure = 0.5

	///This stores a banana that, when used on the secway, prevents the vehicle from moving until it is removed.
	var/obj/item/food/grown/banana/eddie_murphy

/datum/armor/ridden_secway
	melee = 10
	laser = 10
	fire = 60
	acid = 60

/obj/vehicle/ridden/secway/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ridable, /datum/component/riding/vehicle/secway)

/obj/vehicle/ridden/secway/atom_break()
	START_PROCESSING(SSobj, src)
	return ..()

/obj/vehicle/ridden/secway/process(seconds_per_tick)
	if(atom_integrity >= integrity_failure * max_integrity)
		return PROCESS_KILL
	if(SPT_PROB(10, seconds_per_tick))
		return
	do_smoke(0, src, src)

/obj/vehicle/ridden/secway/welder_act(mob/living/user, obj/item/tool)
	if(user.combat_mode)
		return NONE

	if(DOING_INTERACTION(user, src))
		balloon_alert(user, "você já está consertando isso!")
		return ITEM_INTERACT_BLOCKING

	if(atom_integrity >= max_integrity)
		balloon_alert(user, "não está danificado!")
		return ITEM_INTERACT_BLOCKING

	if(!tool.tool_start_check(user, amount=1, heat_required = HIGH_TEMPERATURE_REQUIRED))
		return ITEM_INTERACT_BLOCKING

	user.balloon_alert_to_viewers("started welding [src]", "started repairing [src]")
	audible_message(span_hear("Você ouve solda."))
	var/did_the_thing
	while(atom_integrity < max_integrity)
		if(tool.use_tool(src, user, 2.5 SECONDS, volume=50))
			did_the_thing = TRUE
			atom_integrity += min(10, (max_integrity - atom_integrity))
			audible_message(span_hear("Você ouve solda."))
		else
			break

	if(did_the_thing)
		user.balloon_alert_to_viewers("[(atom_integrity >= max_integrity) ? "fully" : "partially"] repaired [src]")
		return ITEM_INTERACT_SUCCESS

	user.balloon_alert_to_viewers("stopped welding [src]", "interrupted the repair!")
	return ITEM_INTERACT_BLOCKING

/obj/vehicle/ridden/secway/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(.)
		return
	if(!istype(tool, /obj/item/food/grown/banana))
		return NONE
	// ignore the occupants because they're presumably too distracted to notice the guy stuffing fruit into their vehicle's exhaust. do segways have exhausts? they do now!
	user.visible_message(span_warning("[user] Começa o recheio [tool] Em [src] O tubo de fuga."), span_warning("Você começa a encher [tool] Em [src] O tubo de fuga..."), ignored_mobs = occupants)
	if(!do_after(user, 3 SECONDS, src))
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING
	user.visible_message(span_warning("[user] Coisas.[tool] Em [src] O tubo de fuga."), span_warning("Sua coisa.[tool] Em [src] O tubo de fuga."), ignored_mobs = occupants)
	eddie_murphy = tool
	return ITEM_INTERACT_SUCCESS

/obj/vehicle/ridden/secway/attack_hand(mob/living/user, list/modifiers)
	if(!eddie_murphy)
		return ..()
	user.visible_message(span_warning("[user] começa a limpar.[eddie_murphy] Fora [src]."), span_warning("Você começa a limpar.[eddie_murphy] Fora [src]..."))
	if(!do_after(user, 6 SECONDS, target = src))
		return ..()
	user.visible_message(span_warning("[user] Limpa.[eddie_murphy] Fora [src]."), span_warning("Você consegue [eddie_murphy] Fora [src]."))
	eddie_murphy.forceMove(drop_location())
	eddie_murphy = null

/obj/vehicle/ridden/secway/examine(mob/user)
	. = ..()
	if(eddie_murphy)
		. += span_warning("Algo parece estar preso em seu escape...")

/obj/vehicle/ridden/secway/atom_destruction()
	explosion(src, devastation_range = -1, light_impact_range = 2, flame_range = 3, flash_range = 4)
	return ..()

/obj/vehicle/ridden/secway/Destroy()
	STOP_PROCESSING(SSobj,src)
	return ..()

//bullets will have a 60% chance to hit any riders
/obj/vehicle/ridden/secway/projectile_hit(obj/projectile/hitting_projectile, def_zone, piercing_hit, blocked)
	if(!buckled_mobs || prob(40))
		return ..()
	for(var/mob/rider as anything in buckled_mobs)
		return rider.projectile_hit(hitting_projectile)
	return ..()
