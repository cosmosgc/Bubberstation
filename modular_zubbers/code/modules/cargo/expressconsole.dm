/obj/item/circuitboard/computer/cargo/express/interdyne
	name = "Interdyne Express Supply Console"
	build_path = /obj/machinery/computer/cargo/express/interdyne
	contraband = TRUE

/obj/machinery/computer/cargo/express/interdyne
	name = "interdyne express supply console"
	desc = "Um console padrão NT Express, hackeado pelas Indústrias Gorlex para usar seu próprio experimental\"Canhão de trem de 1100mm\", feito para ser mais robusto para evitar ser emagrecido pelos cadetes do SSV Dauntless."
	circuit = /obj/item/circuitboard/computer/cargo/express/interdyne
	req_access = list(ACCESS_SYNDICATE)
	cargo_account = ACCOUNT_INT
	contraband = TRUE
	pod_type = /obj/structure/closet/supplypod/bluespacepod
	console_flags = CARGO_CONSOLE_INTERDYNE
	landingzone = /area/ruin/space/has_grav/bubbers/persistance/cargo

/obj/machinery/computer/cargo/express/interdyne/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(user)
		to_chat(user, span_notice("Você tenta mudar os protocolos de roteamento, no entanto, a máquina exibe um erro de execução e reinicia."))
	return FALSE//never let this console be emagged

//Tarkons console
/obj/item/circuitboard/computer/cargo/express/interdyne/tarkon
	name = "Tarkon Express Supply Console"
	build_path = /obj/machinery/computer/cargo/express/interdyne/tarkon
	contraband = TRUE

/obj/machinery/computer/cargo/express/interdyne/tarkon
	name = "tarkon express supply console"
	landingzone = /area/ruin/space/has_grav/port_tarkon/cargo
	desc = "Um console padrão expresso Tarkon."
	circuit = /obj/item/circuitboard/computer/cargo/express/interdyne/tarkon
	req_access = list(ACCESS_TARKON)
	cargo_account = ACCOUNT_TAR
	console_flags = NONE
