/obj/structure/sign/clock
	name = "wall clock"
	desc = "É o relógio da parede que mostra o tempo padrão local de Nanotrasen e o tempo coordenado do tratado galáctico. Perfeito para olhar em vez de trabalhar."
	icon_state = "clock"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/clock, 32)

/obj/structure/sign/clock/examine(mob/user)
	. = ..()
	. += span_info("The current NST (local) time is: [server_timestamp(ic_time = TRUE, twelve_hour_clock = user.client?.prefs.read_preference(/datum/preference/toggle/twelve_hour))].")
	if(user.is_literate())
		. += span_info("That means it is currently [round_timestamp()] into the shift.")

/obj/structure/sign/calendar
	name = "wall calendar"
	desc = "É um calendário antigo. Claro, pode ser obsoleto com a tecnologia moderna, mas ainda é difícil imaginar um escritório sem um."
	icon_state = "calendar"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/calendar, 32)

/obj/structure/sign/calendar/examine(mob/user)
	. = ..()
	. += span_info("The current date is: [time2text(world.realtime, "DDD, MMM DD", world.timezone)], [CURRENT_STATION_YEAR].")
	if(length(GLOB.holidays))
		. += span_info("Events:")
		for(var/holidayname in GLOB.holidays)
			. += span_info("[holidayname]")
