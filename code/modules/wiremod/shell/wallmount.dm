/obj/structure/wallmount_circuit
	name = "circuit box"
	desc = "Uma caixa montada em parede adequada para instalação de circuitos integrados."
	icon = 'icons/obj/science/circuits.dmi'
	icon_state = "wallmount"
	layer = BELOW_OBJ_LAYER
	anchored = TRUE

	resistance_flags = LAVA_PROOF | FIRE_PROOF

/obj/structure/wallmount_circuit/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/shell, null, SHELL_CAPACITY_LARGE, SHELL_FLAG_REQUIRE_ANCHOR|SHELL_FLAG_USB_PORT)

/obj/structure/wallmount_circuit/wrench_act(mob/living/user, obj/item/tool)
	var/datum/component/shell/shell_comp = GetComponent(/datum/component/shell)
	if(shell_comp.locked)
		balloon_alert(user, "Trancado!")
		return ITEM_INTERACT_FAILURE
	to_chat(user, span_notice("Você começa a insegurar a caixa de circuito..."))
	if(tool.use_tool(src, user, 40, volume=50))
		to_chat(user, span_notice("Você não protege a caixa de circuito."))
		playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)
		deconstruct(TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/item/wallframe/circuit
	name = "circuit box frame"
	desc = "Uma caixa que pode ser montada em uma parede e ter circuitos instalados."
	icon = 'icons/obj/science/circuits.dmi'
	icon_state = "wallmount_assembly"
	result_path = /obj/structure/wallmount_circuit
	pixel_shift = 32
