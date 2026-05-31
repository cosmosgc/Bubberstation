/obj/item/pai_cable
	desc = "Um cabo flexível revestido com um macaco universal em uma extremidade."
	name = "data cable"
	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "wire1"
	item_flags = NOBLUDGEON
	///The current machine being hacked by the pAI cable.
	var/obj/machinery/hacking_machine

/obj/item/pai_cable/Destroy()
	hacking_machine = null
	return ..()

/obj/item/pai_cable/proc/plugin(obj/machinery/M, mob/living/user)
	if(!user.transferItemToLoc(src, M))
		return
	user.visible_message(span_notice("[user]Inserções[src]em uma porta de dados em[M]."), span_notice("Você insere[src]em uma porta de dados em[M]."), span_hear("Você ouve o clique satisfatório de um cabo se fixando no lugar."))
	hacking_machine = M
