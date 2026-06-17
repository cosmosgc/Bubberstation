/obj/structure/flora/tree/pine/xmas/millionaire //not really a tree but the code is close enough
	icon = 'modular_zubbers/icons/obj/fluff/bonus.dmi'
	icon_state = "bonusnt"
	pixel_x = 0
	name = "bonus bag pile"
	desc = "Uma pilha de sacos de bônus. Tente encontrar um com seu nome nele!"
	var/gift_type = /obj/item/storage/box/papersack/millionaire_bonus
	var/unlimited = FALSE
	var/static/list/took_bonus

/obj/structure/flora/tree/pine/xmas/millionaire/Initialize(mapload)
	. = ..()
	if(!took_bonus)
		took_bonus = list()

/obj/structure/flora/tree/pine/xmas/millionaire/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!user.ckey)
		return

	if(took_bonus[user.ckey] && !unlimited)
		to_chat(user, span_warning("Você já reclamou seu bônus!"))
		return
	to_chat(user, span_warning("Depois de um pouco de busca, você localiza um saco bônus com seu nome nele!"))

	if(!unlimited)
		took_bonus[user.ckey] = TRUE

	var/obj/item/G = new gift_type(src)
	user.put_in_hands(G)
