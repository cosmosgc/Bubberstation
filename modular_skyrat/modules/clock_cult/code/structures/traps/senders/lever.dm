/obj/item/wallframe/clocktrap/lever
	name = "switch"
	desc = "Um pequeno interruptor ligado à parede."
	icon_state = "lever"
	result_path = /obj/structure/destructible/clockwork/trap/lever
	clockwork_desc = "Um dispositivo que pode ser ligado às paredes para permitir que você envie um sinal para armadilhas ligadas."


/obj/structure/destructible/clockwork/trap/lever
	name = "switch"
	desc = "Um pequeno interruptor ligado à parede."
	icon_state = "lever"
	unwrench_path = /obj/item/wallframe/clocktrap/lever
	component_datum = /datum/component/clockwork_trap/lever
	max_integrity = 75
	clockwork_desc = "Um dispositivo permite enviar um sinal para armadilhas ligadas."


/datum/component/clockwork_trap/lever
	sends_input = TRUE


/datum/component/clockwork_trap/lever/attack_hand(mob/user)
	trigger_connected()
	to_chat(user, span_notice("Você ativa o interruptor."))
	playsound(user, 'sound/machines/click.ogg', 50)
