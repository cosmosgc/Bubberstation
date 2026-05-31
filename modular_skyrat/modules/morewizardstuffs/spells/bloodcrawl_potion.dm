/obj/item/bloodcrawl_bottle
	name = "bloodlust in a bottle"
	desc = "Beber isso te dará poderes inimagináveis... e levemente te enojará por causa do gosto metálico."
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "vial"

/obj/item/bloodcrawl_bottle/attack_self(mob/user)
	to_chat(user, span_notice("Você bebe o conteúdo de[src]."))
	var/datum/action/cooldown/spell/jaunt/bloodcrawl/new_spell =  new(user)
	new_spell.Grant(user)
	user.log_message("learned the spell bloodcrawl ([new_spell])", LOG_ATTACK, color="orange")
	qdel(src)
