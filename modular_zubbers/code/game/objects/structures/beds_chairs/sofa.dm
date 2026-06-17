/// Looking through pillows on sofas when rightclicked
/obj/structure/chair/sofa/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(!ishuman(user) || !user.ckey)
		return
	balloon_alert(user, "Procurando debaixo dos travesseiros...")
	to_chat(user, span_alert("Você começa a vasculhar os travesseiros do sofá..."))
	if(do_after(user, 10 SECONDS, src))
		if(prob(10))
			balloon_alert(user, "Encontrei algo.")
			if(prob(1))
				do_sparks(5, TRUE, loc, spark_type = /datum/effect_system/basic/spark_spread/quantum)
				new /obj/item/disk/nuclear/fake(loc)
			else
				// New epic way of making money. Totally
				new /obj/item/coin/iron(loc)
		else
			balloon_alert(user, "nothing")
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
