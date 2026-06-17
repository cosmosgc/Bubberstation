/obj/structure/destructible/clockwork/gear_base
	name = "gear base"
	desc = "Uma grande engrenagem deitada no chão ao nível dos pés."
	icon_state = "gear_base"
	clockwork_desc = "Uma grande engrenagem deitada no chão ao nível dos pés."
	anchored = FALSE
	break_message = span_warning("Quebrou.")
	/// What's appeneded to the structure when unanchored
	var/unwrenched_suffix = "_unwrenched"
	/// If this can be moved at all by unwrenching it
	var/can_unwrench = TRUE


/obj/structure/destructible/clockwork/gear_base/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/clockwork_structure_info)


/obj/structure/destructible/clockwork/gear_base/wrench_act(mob/living/user, obj/item/tool)
	if(!IS_CLOCK(user))
		return

	if(!can_unwrench)
		balloon_alert(user, "Não pode ser destroçado!")
		return

	balloon_alert(user, "[anchored ? "unwrenching" : "wrenching"]...")

	if(!tool.use_tool(src, user, 2 SECONDS, volume = 50))
		return

	visible_message(span_notice("[user] [anchored ? "unwrenches" : "wrenches down"] [src]."), span_notice("You [anchored ? "unwrench" : "wrench"] [src]."))

	anchored = !anchored
	update_icon_state()

	return TRUE


/obj/structure/destructible/clockwork/gear_base/update_icon_state()
	. = ..()
	icon_state = initial(icon_state)

	if(!anchored)
		icon_state += unwrenched_suffix
