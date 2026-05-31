/obj/structure/sign/clock
	name = "wall clock"
	desc = "É o relógio de parede normal mostrando o horário padrão da Coalizão local e o tempo coordenado do Tratado galáctico. Perfeito para olhar em vez de trabalhar."
	icon_state = "clock"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/clock, 32)

/obj/structure/sign/clock/examine(mob/user)
	. = ..()
	. += span_info("A hora atual do CST (local) é:[station_time_timestamp()].")
	. += span_info("O tempo atual do TCT (galáctico) é:[time2text(world.realtime, "hh:mm:ss", 0)].")

/obj/structure/sign/calendar
	name = "wall calendar"
	desc = "É um calendário antigo. Claro, pode ser obsoleto com a tecnologia moderna, mas ainda é difícil imaginar um escritório sem um."
	icon_state = "calendar"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/calendar, 32)

/obj/structure/sign/calendar/examine(mob/user)
	. = ..()
	. += span_info("A data atual é:[time2text(world.realtime, "DDD, MMM DD", world.timezone)], [CURRENT_STATION_YEAR].")
	if(length(GLOB.holidays))
		. += span_info("Events:")
		for(var/holidayname in GLOB.holidays)
			. += span_info("[holidayname]")
