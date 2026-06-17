/obj/machinery/computer/shuttle/labor
	name = "labor shuttle console"
	desc = "Costumava ligar e mandar a nave de trabalho."
	circuit = /obj/item/circuitboard/computer/labor_shuttle
	shuttleId = "laborcamp"
	possible_destinations = "laborcamp_home;laborcamp_away"
	req_access = list(ACCESS_BRIG)

/obj/machinery/computer/shuttle/labor/one_way
	name = "prisoner shuttle console"
	desc = "Um console de transporte só de ida, usado para chamar a nave para o campo de trabalho."
	possible_destinations = "laborcamp_away"
	circuit = /obj/item/circuitboard/computer/labor_shuttle/one_way
	req_access = list( )

/obj/machinery/computer/shuttle/labor/one_way/launch_check(mob/user)
	. = ..()
	if(!.)
		return FALSE
	var/obj/docking_port/mobile/M = SSshuttle.getShuttle("laborcamp")
	if(!M)
		to_chat(user, span_warning("Não consigo localizar a nave auxiliar!"))
		return FALSE
	var/obj/docking_port/stationary/S = M.get_docked()
	if(S?.name == "laborcamp_away")
		to_chat(user, span_warning("O ônibus já está no posto avançado!"))
		return FALSE
	return TRUE

/obj/docking_port/stationary/laborcamp_home
	name = "SS13: Labor Shuttle Dock"
	shuttle_id = "laborcamp_home"
	roundstart_template = /datum/map_template/shuttle/labour/delta
	width = 9
	dwidth = 2
	height = 5

/obj/docking_port/stationary/laborcamp_home/kilo
	roundstart_template = /datum/map_template/shuttle/labour/kilo

/obj/docking_port/stationary/laborcamp_home/nebula
	roundstart_template = /datum/map_template/shuttle/labour/nebula
