//Ash storms happen frequently on lavaland. They heavily obscure vision, and cause high fire damage to anyone caught outside.
/datum/weather/ash_storm
	name = "ash storm"
	desc = "Uma intensa tempestade atmosférica levanta cinzas da superfície do planeta e a espalha pela área, causando intensos danos ao fogo aos desprotegidos."

	telegraph_message = span_boldwarning("Um gemido assustador sobe no vento. Folhas de cinzas queimando escurecem o horizonte. Procurem abrigo.")
	telegraph_duration = 30 SECONDS
	telegraph_overlay = "light_ash"

	weather_message = span_userdanger("<i>Nuvens fumegantes de cinzas escaldantes em volta de você! Entre!</i>")
	weather_duration_lower = 1 MINUTES
	weather_duration_upper = 2 MINUTES
	weather_overlay = "ash_storm"

	end_message = span_bolddanger("O vento gritante tira o último das cinzas e cai em seu murmúrio habitual. Deve ser seguro sair agora.")
	end_duration = 30 SECONDS
	end_overlay = "light_ash"

	area_type = /area
	target_trait = ZTRAIT_ASHSTORM
	immunity_type = TRAIT_ASHSTORM_IMMUNE
	probability = 90
	turf_thunder_chance = THUNDER_CHANCE_VERY_RARE
	thunder_color = "#7a0000"

	weather_flags = (WEATHER_MOBS | WEATHER_BAROMETER | WEATHER_THUNDER)

	var/list/weak_sounds = list()
	var/list/strong_sounds = list()

/datum/weather/ash_storm/get_playlist_ref()
	return GLOB.ash_storm_sounds

/datum/weather/ash_storm/telegraph()
	for(var/area/impacted_area as anything in impacted_areas)
		//BUBBER ADDITION BEGIN - This is a HORRIBLE HACK to stop the weather from triggering for these locations
		if(impacted_area.ignore_weather_sfx)
			continue
		//BUBBER ADDITION END
		if(impacted_area.outdoors)
			weak_sounds[impacted_area] = /datum/looping_sound/weak_outside_ashstorm
			strong_sounds[impacted_area] = /datum/looping_sound/active_outside_ashstorm
		else
			weak_sounds[impacted_area] = /datum/looping_sound/weak_inside_ashstorm
			strong_sounds[impacted_area] = /datum/looping_sound/active_inside_ashstorm

	//We modify this list instead of setting it to weak/stron sounds in order to preserve things that hold a reference to it
	//It's essentially a playlist for a bunch of components that chose what sound to loop based on the area a player is in
	GLOB.ash_storm_sounds += weak_sounds
	return ..()

/datum/weather/ash_storm/start()
	GLOB.ash_storm_sounds -= weak_sounds
	GLOB.ash_storm_sounds += strong_sounds
	return ..()

/datum/weather/ash_storm/wind_down()
	GLOB.ash_storm_sounds -= strong_sounds
	GLOB.ash_storm_sounds += weak_sounds
	return ..()

/datum/weather/ash_storm/recursive_weather_protection_check(atom/to_check)
	. = ..()
	if(. || !ishuman(to_check))
		return
	var/mob/living/carbon/human/human_to_check = to_check
	if(human_to_check.get_thermal_protection() >= FIRE_IMMUNITY_MAX_TEMP_PROTECT)
		return TRUE

/datum/weather/ash_storm/weather_act_mob(mob/living/victim)
	victim.adjust_fire_loss(4, required_bodytype = BODYTYPE_ORGANIC)
	return ..()

/datum/weather/ash_storm/end()
	GLOB.ash_storm_sounds -= weak_sounds
	for(var/turf/open/misc/asteroid/basalt/basalt as anything in GLOB.dug_up_basalt)
		if(!(basalt.loc in impacted_areas) || !(basalt.z in impacted_z_levels))
			continue
		basalt.refill_dug()
	return ..()

//Emberfalls are the result of an ash storm passing by close to the playable area of lavaland. They have a 10% chance to trigger in place of an ash storm.
/datum/weather/ash_storm/emberfall
	name = "emberfall"
	desc = "Uma tempestade de cinzas que passa cobre a área em brasas inofensivas."

	weather_message = span_notice("As brasas suaves descem ao seu redor como neve grotesca. A tempestade parece ter passado por você...")
	weather_overlay = "light_ash"

	end_message = span_notice("A queda de brasa diminui, pára. Outra camada de fuligem endurecida para o basalto sob seus pés.")
	end_sound = null

	weather_flags = parent_type::weather_flags & ~(WEATHER_MOBS|WEATHER_THUNDER)

	probability = 10
