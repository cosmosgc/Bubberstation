/obj/machinery/computer/arcade/amputation
	name = "Mediborg's Amputation Adventure"
	desc = "Uma foto de um cyborg médico encharcado de sangue pisca na tela. O mediborg tem uma bolha de discurso que diz,\"Coloque sua mão na máquina se você não é um<b>Covarde!</b>\""
	icon_state = "arcade"
	circuit = /obj/item/circuitboard/computer/arcade/amputation
	interaction_flags_machine = NONE //borgs can't play, but the illiterate can.

/obj/machinery/computer/arcade/amputation/attack_tk(mob/user)
	return //that's a pretty damn big guillotine

/obj/machinery/computer/arcade/amputation/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!iscarbon(user))
		return
	to_chat(user, span_warning("Você move sua mão para a máquina, e começa a hesitar como uma guilhotina ensanguentada emerge de dentro dela..."))
	user.played_game()
	var/obj/item/bodypart/chopchop = user.get_active_hand()
	if(do_after(user, 5 SECONDS, target = src, extra_checks = CALLBACK(src, PROC_REF(do_they_still_have_that_hand), user, chopchop)))
		playsound(src, 'sound/items/weapons/slice.ogg', 25, TRUE, -1)
		to_chat(user, span_userdanger("A guilhotina cai em seu braço, e a máquina suga!"))
		chopchop.dismember()
		qdel(chopchop)
		user.mind?.adjust_experience(/datum/skill/gaming, 100)
		user.won_game()
		victory_tickets(rand(6,10))
		return
	if(!do_they_still_have_that_hand(user, chopchop))
		to_chat(user, span_warning("A guilhotina cai, mas sua mão já se foi!"))
		playsound(src, 'sound/items/weapons/slice.ogg', 25, TRUE, -1)
	else
		to_chat(user, span_notice("Você (sábia) decide contra colocar sua mão na máquina."))
	user.lost_game()

///Makes sure the user still has their starting hand, preventing the user from pulling the arm out and still getting prizes.
/obj/machinery/computer/arcade/amputation/proc/do_they_still_have_that_hand(mob/user, obj/item/bodypart/chopchop)
	if(QDELETED(chopchop) || chopchop.owner != user)
		return FALSE
	return TRUE

///Dispenses wrapped gifts instead of arcade prizes, also known as the ancap christmas tree
/obj/machinery/computer/arcade/amputation/festive
	name = "Mediborg's Festive Amputation Adventure"
	desc = "Uma foto de um ciborgue médico encharcado de sangue usando um chapéu de Papai Noel pisca na tela. O mediborg tem uma bolha de discurso que diz,\"Coloque sua mão na máquina se você não é um<b>Covarde!</b>\""
	prize_override = list(/obj/item/gift/anything = 1)
