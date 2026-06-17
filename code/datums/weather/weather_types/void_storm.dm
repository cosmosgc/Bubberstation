/datum/weather/void_storm
	name = "void storm"
	desc = "Um evento raro e altamente anômalo muitas vezes acompanhado por entidades desconhecidas destruindo o espaço-tempo continouum. Aconselhamos que comece a correr."

	telegraph_duration = 2 SECONDS
	telegraph_overlay = "light_snow"

	weather_message = span_hypnophrase("Você sente o ar ao seu redor ficando mais frio... e o doce abraço do vazio...")
	weather_overlay = "light_snow"
	weather_color = COLOR_BLACK
	weather_duration_lower = 1 MINUTES
	weather_duration_upper = 2 MINUTES

	use_glow = FALSE

	end_duration = 10 SECONDS

	area_type = /area
	target_trait = ZTRAIT_VOIDSTORM

	weather_flags = (WEATHER_INDOORS | WEATHER_BAROMETER | WEATHER_ENDLESS)
