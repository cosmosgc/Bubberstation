/**
 * # NTNet Transmitter List Literal Component
 *
 * Create a list literal and send a data package through NTNet
 *
 * This file is based off of ntnet_send.dm
 * Any changes made to those files should be copied over with discretion
 */
/obj/item/circuit_component/list_literal/ntnet_send
	display_name = "Lista de Transmissores NTNet Literais"
	desc = "Cria uma lista de dados literal e envia através da NTNet. Se a Chave de Criptografia estiver definida, os dados transmitidos só serão captados por receptores com a mesma Chave de Criptografia."
	category = "NTNet"

	/// Encryption key
	var/datum/port/input/enc_key

/obj/item/circuit_component/list_literal/ntnet_send/populate_ports()
	. = ..()
	enc_key = add_input_port("Encryption Key", PORT_TYPE_STRING)

/obj/item/circuit_component/list_literal/ntnet_send/should_receive_input(datum/port/input/port)
	. = ..()
	if(!.)
		return FALSE
	/// If the server is down, don't use power or attempt to send data
	return find_functional_ntnet_relay()

/obj/item/circuit_component/list_literal/ntnet_send/input_received(datum/port/input/port)
	. = ..()
	send_ntnet_data(list_output, enc_key.value)
