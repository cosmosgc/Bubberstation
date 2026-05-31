#define TURRET_ASSEMBLY_START "start"
#define TURRET_ASSEMBLY_RECEIVER "receiver"
#define TURRET_ASSEMBLY_SEC_1 "secured_receiver"
#define TURRET_ASSEMBLY_SERVO "servo"
#define TURRET_ASSEMBLY_SEC_2 "secured_servo"
#define TURRET_ASSEMBLY_SENSOR "sensor"
#define TURRET_ASSEMBLY_SEC_3 "secured_sensor"
#define TURRET_ASSEMBLY_WRAPUP "finished_assembly"

/obj/item/turret_assembly
	name = "turret plate assembly"
	icon = 'modular_skyrat/modules/magfed_turret/icons/assembly.dmi'
	icon_state = "turret_assembly"
	desc = "Um conjunto de peças de montagem para uma torre alimentada por revista, requerendo um receptor, servo e sensor junto com a construção. Este parece ser para uma torre de defesa do posto avançado."
	/// modular receiver
	var/obj/item/receiver
	/// proximity sensor
	var/obj/item/sensor
	/// any stockpart servo
	var/obj/item/servo
	/// The turret being produced. Why so elaborate while everything else simple? iunno.
	var/obj/item/storage/toolbox/emergency/turret/mag_fed/design = /obj/item/storage/toolbox/emergency/turret/mag_fed/outpost
	/// step tracking
	var/step = TURRET_ASSEMBLY_START

/obj/item/turret_assembly/examine(mob/user)
	. = ..()
	var/display_text
	switch(step)
		if(TURRET_ASSEMBLY_START)
			display_text = "Falta a cabeça da torre.<b>Receptor modular</b>..."
		if(TURRET_ASSEMBLY_RECEIVER)
			display_text = "Os parafusos de ligação da cabeça da torre são<b>Soltar</b>..."
		if(TURRET_ASSEMBLY_SEC_1)
			display_text = "Parece que está faltando um<b>servo</b>..."
		if(TURRET_ASSEMBLY_SERVO)
			display_text = "Parece que seu chassi principal é<b>Não está seguro.</b>..."
		if(TURRET_ASSEMBLY_SEC_2)
			display_text = "Parece que está faltando um<b>Sensor de proximidade</b>..."
		if(TURRET_ASSEMBLY_SENSOR)
			display_text = "O sensor parece<b>Não está seguro.</b>..."
		if(TURRET_ASSEMBLY_SEC_3)
			display_text = "Os parafusos dos suportes pares<b>Soltar</b>..."
		if(TURRET_ASSEMBLY_WRAPUP)
			display_text = "A CPU do circuito precisa ser<b>Ativado</b>..."
	. += span_notice(display_text)

/obj/item/turret_assembly/attackby(obj/item/part, mob/user, params)
	. = ..()
	switch(step)
		if(TURRET_ASSEMBLY_START)
			if(!istype(part, /obj/item/weaponcrafting/receiver))
				return
			if(!user.transferItemToLoc(part, src))
				balloon_alert(user, "Núcleo preso em sua mão!")
				return
			playsound(src, 'sound/machines/click.ogg', 30, TRUE)
			balloon_alert(user, "receptor inserido")
			receiver = part
			step = TURRET_ASSEMBLY_RECEIVER

		if(TURRET_ASSEMBLY_SEC_1)
			if(istype(part, /obj/item/stock_parts/servo)) //Construct
				if(!user.transferItemToLoc(part, src))
					balloon_alert(user, "servo preso em sua mão!")
					return
				playsound(src, 'sound/machines/click.ogg', 30, TRUE)
				balloon_alert(user, "servo adicionado.")
				servo = part
				step = TURRET_ASSEMBLY_SERVO

		if(TURRET_ASSEMBLY_SEC_2)
			if(istype(part, /obj/item/assembly/prox_sensor)) //Construct
				if(!user.transferItemToLoc(part, src))
					balloon_alert(user, "Sensor preso em sua mão!")
					return
				playsound(src, 'sound/machines/click.ogg', 30, TRUE)
				balloon_alert(user, "sensor adicionado")
				sensor = part
				step = TURRET_ASSEMBLY_SENSOR

/obj/item/turret_assembly/multitool_act(mob/living/user, obj/item/tool)
	if(step == TURRET_ASSEMBLY_WRAPUP)
		if(tool.use_tool(src, user, 0, volume=30))
			playsound(src, 'sound/machines/click.ogg', 30, TRUE)
			var/obj/item/turretling = new design(drop_location())
			qdel(src)
			user.put_in_hands(turretling)
			turretling.balloon_alert(user, "Terno terminado.")

/obj/item/turret_assembly/wrench_act(mob/living/user, obj/item/tool)
	switch(step)
		if(TURRET_ASSEMBLY_SEC_3)
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "Montagem segura")
				step = TURRET_ASSEMBLY_WRAPUP
				return // Last step leads to the next step
		if(TURRET_ASSEMBLY_WRAPUP)
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "Montagem sem segurança")
				step = TURRET_ASSEMBLY_SEC_3
				return

/obj/item/turret_assembly/screwdriver_act(mob/living/user, obj/item/tool)
	switch(step)
		if(TURRET_ASSEMBLY_RECEIVER) //Construct
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "Receptor seguro.")
				step = TURRET_ASSEMBLY_SEC_1
				return //same as wrench
		if(TURRET_ASSEMBLY_SEC_1) //Deconstruct
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "Receptor não seguro.")
				step = TURRET_ASSEMBLY_RECEIVER
				return
		if(TURRET_ASSEMBLY_SERVO) //Construct
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "servo seguro.")
				step = TURRET_ASSEMBLY_SEC_2
				return
		if(TURRET_ASSEMBLY_SEC_2) //Deconstruct
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "Sensor não seguro.")
				step = TURRET_ASSEMBLY_SERVO
				return
		if(TURRET_ASSEMBLY_SENSOR)//Construct
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "Sensor Seguro.")
				step = TURRET_ASSEMBLY_SEC_3
				return
		if(TURRET_ASSEMBLY_SEC_3) //Deconstruct
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "Sensor não seguro.")
				step = TURRET_ASSEMBLY_SENSOR
				return

/obj/item/turret_assembly/crowbar_act(mob/living/user, obj/item/tool)
	switch(step)
		if(TURRET_ASSEMBLY_RECEIVER)
			if(tool.use_tool(src, user, 0, volume=30))
				receiver.forceMove(drop_location())
				balloon_alert(user, "Receptor aposentado.")
				receiver = null
				step = TURRET_ASSEMBLY_START
				return
		if(TURRET_ASSEMBLY_SERVO)
			if(tool.use_tool(src, user, 0, volume=30))
				servo.forceMove(drop_location())
				balloon_alert(user, "servo removido.")
				servo = null
				step = TURRET_ASSEMBLY_SEC_1
				return
		if(TURRET_ASSEMBLY_SENSOR)
			if(tool.use_tool(src, user, 0, volume=30))
				sensor.forceMove(drop_location())
				balloon_alert(user, "sensor removido.")
				sensor = null
				step = TURRET_ASSEMBLY_SEC_2
				return

/obj/item/turret_assembly/Destroy()
	QDEL_NULL(receiver)
	QDEL_NULL(servo)
	QDEL_NULL(sensor)
	return ..()

/obj/item/turret_assembly/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == receiver)
		receiver = null
	if(gone == servo)
		servo = null
	if(gone == sensor)
		sensor = null

/obj/item/turret_assembly/twin_fang
	name = "twin_fang plate assembly"
	icon = 'modular_skyrat/modules/magfed_turret/icons/assembly.dmi'
	icon_state = "twinfang_assembly"
	desc = "Um conjunto de peças de montagem para uma torre alimentada por revista, requerendo um receptor, servo e sensor junto com a construção. Este é para um\"Twin-Fang\"Modelo do\"Aranha.\"Tipo Torre."
	design = /obj/item/storage/toolbox/emergency/turret/mag_fed/spider/twin_fang

/obj/item/turret_assembly/duster
	name = "duster plate assembly"
	icon = 'modular_skyrat/modules/magfed_turret/icons/assembly.dmi'
	icon_state = "duster_assembly"
	desc = "Um conjunto de peças de montagem para uma torre alimentada por revista, requerendo um receptor, servo e sensor junto com a construção. Este é para um\"Duster.\"Modelo do\"Emergente.\"Tipo Torre."
	design = /obj/item/storage/toolbox/emergency/turret/mag_fed/duster

#undef TURRET_ASSEMBLY_START
#undef TURRET_ASSEMBLY_RECEIVER
#undef TURRET_ASSEMBLY_SEC_1
#undef TURRET_ASSEMBLY_SERVO
#undef TURRET_ASSEMBLY_SEC_2
#undef TURRET_ASSEMBLY_SENSOR
#undef TURRET_ASSEMBLY_SEC_3
#undef TURRET_ASSEMBLY_WRAPUP
