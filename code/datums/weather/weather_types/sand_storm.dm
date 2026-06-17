//Darude sandstorm starts playing
/datum/weather/sand_storm
	name = "severe sandstorm"
	desc = "Uma forte tempestade de poeira que envolve uma área, causando danos intensos aos desprotegidos."

	telegraph_message = span_danger("Você vê uma nuvem de poeira subindo sobre o horizonte. Isso não pode ser bom...")
	telegraph_duration = 30 SECONDS
	telegraph_overlay = "dust_med"
	telegraph_sound = 'sound/effects/siren.ogg'

	weather_message = span_userdanger("<i>Areia quente e vento batem em você! Entre!</i>")
	weather_duration_lower = 1 MINUTES
	weather_duration_upper = 2 MINUTES
	weather_overlay = "dust_high"

	end_message = span_bolddanger("O vento gritante tira o resto da areia e cai em seu murmúrio habitual. Deve ser seguro sair agora.")
	end_duration = 30 SECONDS
	end_overlay = "dust_med"

	area_type = /area
	target_trait = ZTRAIT_SANDSTORM
	immunity_type = TRAIT_SANDSTORM_IMMUNE
	probability = 90

	weather_flags = (WEATHER_MOBS | WEATHER_BAROMETER)

/datum/weather/sand_storm/get_playlist_ref()
	return GLOB.sand_storm_sounds

/datum/weather/sand_storm/telegraph()
	GLOB.sand_storm_sounds.Cut()
	for(var/area/impacted_area as anything in impacted_areas)
		GLOB.sand_storm_sounds[impacted_area] = /datum/looping_sound/weak_outside_ashstorm
	return ..()

/datum/weather/sand_storm/start()
	GLOB.sand_storm_sounds.Cut()
	for(var/area/impacted_area as anything in impacted_areas)
		GLOB.sand_storm_sounds[impacted_area] = /datum/looping_sound/active_outside_ashstorm
	return ..()

/datum/weather/sand_storm/wind_down()
	GLOB.sand_storm_sounds.Cut()
	for(var/area/impacted_area as anything in impacted_areas)
		GLOB.sand_storm_sounds[impacted_area] = /datum/looping_sound/weak_outside_ashstorm
	return ..()

/datum/weather/sand_storm/weather_act_mob(mob/living/victim)
	victim.adjust_brute_loss(5, required_bodytype = BODYTYPE_ORGANIC)
	return ..()

/datum/weather/sand_storm/harmless
	name = "sandfall"
	desc = "Uma tempestade de areia passa pela área em areia."

	telegraph_message = span_danger("O vento começa a se intensificar, soprando areia do chão...")
	telegraph_overlay = "dust_low"
	telegraph_sound = null

	weather_message = span_notice("A areia suave desce ao seu redor como neve grotesca. A tempestade parece ter passado por você...")
	weather_overlay = "dust_med"

	end_message = span_notice("A queda de areia diminui, pára. Outra camada de areia na mesa sob seus pés.")
	end_overlay = "dust_low"

	probability = 10
	weather_flags = parent_type::weather_flags & ~WEATHER_MOBS
