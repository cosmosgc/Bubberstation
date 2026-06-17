/datum/phystool_mode/remove_mode
	name = "Remove tool"
	desc = "Use LMB para apagar objetos do mundo."

/datum/phystool_mode/remove_mode/main_act(atom/target, mob/user)
	. = ..()
	if(isliving(target))
		var/mob/living/living_target = target
		if(living_target.client)
			user.balloon_alert(user, "Cliente dentro!")
			return FALSE
	//Is there is somthing inside target.
	if(target.contents.len)
		for(var/atom/movable/important_thing in target.contents)
			if(!istype(important_thing))
				continue
			important_thing.forceMove(get_turf(target))
	qdel(target)
	return TRUE
