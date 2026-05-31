/obj/item/keyboard_shell
	name = "Keyboard Shell"
	icon = 'icons/obj/science/circuits.dmi'
	icon_state = "setup_small_keyboard"
	inhand_icon_state = "electronic"
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	light_system = OVERLAY_LIGHT_DIRECTIONAL
	light_on = FALSE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/keyboard_shell/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/shell, list(
		new /obj/item/circuit_component/keyboard_shell()
	), SHELL_CAPACITY_SMALL)

/obj/item/circuit_component/keyboard_shell
	display_name = "Shell de teclado"
	desc = "Uma shell portátil que permite ao usuário inserir uma string. Use o escudo na mão para abrir o painel de entrada."

	/// Called when the input window is closed
	var/datum/port/output/signal
	/// Entity who used the shell
	var/datum/port/output/entity
	/// The string, entity typed and submitted
	var/datum/port/output/output

/obj/item/circuit_component/keyboard_shell/populate_ports()
	entity = add_output_port("User", PORT_TYPE_USER)
	output = add_output_port("Message", PORT_TYPE_STRING)
	signal = add_output_port("Signal", PORT_TYPE_SIGNAL)

/obj/item/circuit_component/keyboard_shell/register_shell(atom/movable/shell)
	. = ..()
	RegisterSignal(shell, COMSIG_ITEM_ATTACK_SELF, PROC_REF(send_trigger))

/obj/item/circuit_component/keyboard_shell/unregister_shell(atom/movable/shell)
	UnregisterSignal(shell, COMSIG_ITEM_ATTACK_SELF)
	return ..()

/obj/item/circuit_component/keyboard_shell/proc/send_trigger(atom/source, mob/user)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(use_keyboard), user)

/obj/item/circuit_component/keyboard_shell/proc/use_keyboard(mob/user)
	if(HAS_TRAIT(user, TRAIT_ILLITERATE))
		to_chat(user, span_warning("Você começa a esmagar chaves ao acaso!"))
		return

	var/message = tgui_input_text(user, "Input your text", "Keyboard", max_length = MAX_MESSAGE_LEN)
	entity.set_output(user)
	output.set_output(message)
	signal.set_output(COMPONENT_SIGNAL)

