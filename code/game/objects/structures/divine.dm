/obj/structure/sacrificealtar
	name = "sacrificial altar"
	desc = "Um altar projetado para fazer sacrifício de sangue por uma divindade. Alt-clique para sacrificar uma criatura fivela."
	icon = 'icons/obj/service/hand_of_god_structures.dmi'
	icon_state = "sacrificealtar"
	anchored = TRUE
	density = FALSE
	can_buckle = 1

/obj/structure/sacrificealtar/click_alt(mob/living/user)
	if(!has_buckled_mobs())
		return CLICK_ACTION_BLOCKING
	var/mob/living/buckled_mob = locate() in buckled_mobs
	if(!buckled_mob)
		return CLICK_ACTION_BLOCKING
	to_chat(user, span_notice("Invocando o ritual sagrado, você sacrifica[buckled_mob]."))
	buckled_mob.investigate_log("has been sacrificially gibbed on an altar.", INVESTIGATE_DEATHS)
	buckled_mob.gib(DROP_ALL_REMAINS)
	message_admins("[ADMIN_LOOKUPFLW(user)] has sacrificed [key_name_admin(buckled_mob)] on the sacrificial altar at [AREACOORD(src)].")
	return CLICK_ACTION_SUCCESS

/obj/structure/healingfountain
	name = "healing fountain"
	desc = "Uma fonte contendo as águas da vida."
	icon = 'icons/obj/service/hand_of_god_structures.dmi'
	icon_state = "fountain"
	anchored = TRUE
	density = TRUE
	var/time_between_uses = 1800
	var/last_process = 0

/obj/structure/healingfountain/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(last_process + time_between_uses > world.time)
		to_chat(user, span_notice("A fonte parece estar vazia."))
		return
	last_process = world.time
	to_chat(user, span_notice("A água parece quente e calmante ao tocá-la. A fonte seca imediatamente pouco depois."))
	user.reagents.add_reagent(/datum/reagent/medicine/omnizine/godblood,20)
	update_appearance()
	addtimer(CALLBACK(src, TYPE_PROC_REF(/atom/, update_appearance)), time_between_uses)


/obj/structure/healingfountain/update_icon_state()
	if(last_process + time_between_uses > world.time)
		icon_state = "fountain"
	else
		icon_state = "fountain-red"
	return ..()
