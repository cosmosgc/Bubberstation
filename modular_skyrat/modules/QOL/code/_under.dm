/obj/item/clothing/under/item_ctrl_click(mob/user)
	. = ..()
	if(has_sensor == HAS_SENSORS)
		sensor_mode = SENSOR_COORDS
		to_chat(usr, span_notice("Seu traje irá relatar seus sinais vitais e sua posição de coordenadas."))
