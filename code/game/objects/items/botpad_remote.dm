/obj/item/botpad_remote
	name = "Bot pad controller"
	desc = "Use este dispositivo para controlar o bloco de robôs conectado."
	desc_controls = "Left-click for launch, right-click for recall."
	icon = 'icons/obj/devices/remote.dmi'
	icon_state = "botpad_controller"
	w_class = WEIGHT_CLASS_SMALL
	// ID of the remote, used for linking up
	var/id = "botlauncher"
	var/obj/machinery/botpad/connected_botpad

/obj/item/botpad_remote/Destroy()
	if(connected_botpad)
		connected_botpad.connected_remote = null
		connected_botpad = null
	return ..()

/obj/item/botpad_remote/attack_self(mob/living/user)
	playsound(src, SFX_TERMINAL_TYPE, 25, FALSE)
	try_launch(user)
	return

/obj/item/botpad_remote/attack_self_secondary(mob/living/user)
	playsound(src, SFX_TERMINAL_TYPE, 25, FALSE)
	if(connected_botpad)
		connected_botpad.recall(user)
		return
	user?.balloon_alert(user, "Nenhuma almofada conectada!")
	return

/obj/item/botpad_remote/multitool_act(mob/living/user, obj/item/multitool/multitool)
	. = NONE
	if(!istype(multitool.buffer, /obj/machinery/botpad))
		return

	var/obj/machinery/botpad/buffered_remote = multitool.buffer
	if(buffered_remote == connected_botpad)
		to_chat(user, span_warning("Controlador não pode se conectar ao seu próprio botpad!"))
		return ITEM_INTERACT_BLOCKING

	if(!connected_botpad && istype(buffered_remote, /obj/machinery/botpad))
		connected_botpad = buffered_remote
		connected_botpad.connected_remote = src
		connected_botpad.id = id
		multitool.set_buffer(null)
		to_chat(user, span_notice("Você conecta o controlador ao bloco com dados de\the [multitool] É um amortecedor."))
		return ITEM_INTERACT_SUCCESS

/obj/item/botpad_remote/proc/try_launch(mob/living/user)
	if(!connected_botpad)
		user?.balloon_alert(user, "Nenhuma almofada conectada!")
		return
	if(connected_botpad.panel_open)
		user?.balloon_alert(user, "Feche o painel!")
		return
	if(!(locate(/mob/living) in get_turf(connected_botpad)))
		user?.balloon_alert(user, "Nenhum robô detectado na almofada!")
		return
	connected_botpad.launch(user)
