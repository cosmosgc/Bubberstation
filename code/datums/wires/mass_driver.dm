/datum/wires/mass_driver
	holder_type = /obj/machinery/mass_driver
	proper_name = "Mass Driver"

/datum/wires/mass_driver/New(atom/holder)
	wires = list(WIRE_LAUNCH, WIRE_SAFETIES)
	..()

/datum/wires/mass_driver/on_pulse(wire)
	var/obj/machinery/mass_driver/the_mass_driver = holder
	switch(wire)
		if(WIRE_LAUNCH)
			the_mass_driver.drive()
			holder.visible_message(span_notice("O mecanismo de acionamento se ativa."))
		if(WIRE_SAFETIES)
			the_mass_driver.power = 3
			holder.visible_message(span_notice("Você ouve um barulho preocupante que emite do motorista de massa."))

/datum/wires/mass_driver/on_cut(wire, mend, source)
	var/obj/machinery/mass_driver/the_mass_driver = holder
	switch(wire)
		if(WIRE_SAFETIES)
			if(the_mass_driver.power > 1) 
				the_mass_driver.power = 1
				holder.visible_message(span_notice("O barulho que emite do condutor para."))
