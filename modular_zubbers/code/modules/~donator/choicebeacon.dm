/obj/item/sbeacondrop/carrot
	name = "carrot phone"
	icon = 'icons/obj/antags/syndicate_tools.dmi'
	icon_state = "suspiciousphone"
	desc = "Um celular com uma ligação de alguém chamado \"Lady Jab\". Um pequeno adesivo nas notas de trás que qualquer ligação para senhores franceses vai incorrer em uma taxa de serviço de crédito 5."
	w_class = WEIGHT_CLASS_SMALL
	droptype = /obj/item/storage/backpack/satchel/bunnysatchel

/obj/item/sbeacondrop/carrot/attack_self(mob/user)
	if(user)
		to_chat(user, span_notice("Obrigado por escolher o Jab TM para sua compra de roupas!"))
		new droptype( user.loc )
		playsound(src, 'sound/mobs/non-humanoids/mouse/mousesqueek.ogg', 100, TRUE, TRUE)
		qdel(src)
	return
