//Bot Construction

/obj/item/bot_assembly
	icon = 'icons/mob/silicon/aibots.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	force = 3
	throw_speed = 2
	throw_range = 5
	obj_flags = UNIQUE_RENAME | RENAME_NO_DESC
	var/created_name
	var/build_step = ASSEMBLY_FIRST_STEP
	var/robot_arm = /obj/item/bodypart/arm/right/robot

/obj/item/bot_assembly/nameformat(input, user)
	created_name = input
	return input

/obj/item/bot_assembly/rename_reset()
	created_name = initial(created_name)

/**
 * Checks if the user can finish constructing a bot with a given item.
 *
 * Arguments:
 * * tool - Item to be used
 * * user - Mob doing the construction
 * * drop_item - Whether or no the item should be dropped; defaults to 1. Should be set to 0 if the item is a tool, stack, or otherwise doesn't need to be dropped. If not set to 0, item must be deleted afterwards.
 */
/obj/item/bot_assembly/proc/can_finish_build(obj/item/tool, mob/user, drop_item = 1)
	if(istype(loc, /obj/item/storage/backpack))
		to_chat(user, span_warning("Você deve tomar[src]Fora[loc]Primero!"))
		return FALSE
	if(!tool || !user || (drop_item && !user.temporarilyRemoveItemFromInventory(tool)))
		return FALSE
	return TRUE

// Cleanbot assembly
/obj/item/bot_assembly/cleanbot
	desc = "É um balde com um sensor ligado."
	name = "incomplete cleanbot assembly"
	icon_state = "cleanbot_assembly"
	throwforce = 5
	created_name = "Cleanbot"
	var/obj/item/reagent_containers/cup/bucket/bucket_obj

/obj/item/bot_assembly/cleanbot/Initialize(mapload, obj/item/reagent_containers/cup/bucket/new_bucket)
	if(!new_bucket)
		new_bucket = new()
	new_bucket.forceMove(src)
	return ..()

/obj/item/bot_assembly/cleanbot/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	if(istype(arrived, /obj/item/reagent_containers/cup/bucket))
		if(bucket_obj && bucket_obj != arrived)
			qdel(bucket_obj)
		bucket_obj = arrived
	return ..()

/obj/item/bot_assembly/cleanbot/Exited(atom/movable/gone, direction)
	if(gone == bucket_obj)
		bucket_obj = null
	return ..()


/obj/item/bot_assembly/cleanbot/Destroy(force)
	QDEL_NULL(bucket_obj)
	return ..()


/obj/item/bot_assembly/cleanbot/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/bodypart/arm/left/robot) && !istype(tool, /obj/item/bodypart/arm/right/robot))
		return NONE

	if(!can_finish_build(tool, user))
		return ITEM_INTERACT_BLOCKING

	var/mob/living/basic/bot/cleanbot/bot = new(drop_location())
	bucket_obj.forceMove(bot)
	bot.name = created_name
	bot.robot_arm = tool.type
	to_chat(user, span_notice("Você acrescenta[tool]Para[src]Beep boop!"))
	qdel(tool)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

// Edbot Assembly
/obj/item/bot_assembly/ed209
	name = "incomplete ED-209 assembly"
	desc = "Algum tipo de reunião bizarra."
	icon_state = "ed209_frame"
	inhand_icon_state = null
	created_name = "ED-209 Security Robot" //To preserve the name if it's a unique securitron I guess
	var/lasercolor = ""
	var/vest_type = /obj/item/clothing/suit/armor/vest

/obj/item/bot_assembly/ed209/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP, ASSEMBLY_SECOND_STEP)
			if(!istype(tool, /obj/item/bodypart/leg/left/robot) && !istype(tool, /obj/item/bodypart/leg/right/robot))
				return NONE
			if(!user.temporarilyRemoveItemFromInventory(tool))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("Você acrescenta[tool]Para[src]."))
			qdel(tool)
			name = "legs/frame assembly"
			if(build_step == ASSEMBLY_FIRST_STEP)
				inhand_icon_state = "ed209_leg"
				icon_state = "ed209_leg"
			else
				inhand_icon_state = "ed209_legs"
				icon_state = "ed209_legs"
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_THIRD_STEP)
			if(!istype(tool, /obj/item/clothing/suit/armor/vest))
				return NONE
			if(!user.temporarilyRemoveItemFromInventory(tool))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("Você acrescenta[tool]Para[src]."))
			qdel(tool)
			name = "vest/legs/frame assembly"
			inhand_icon_state = "ed209_shell"
			icon_state = "ed209_shell"
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_FOURTH_STEP)
			if(tool.tool_behaviour != TOOL_WELDER)
				return NONE
			if(!tool.use_tool(src, user, 0, volume=40))
				return ITEM_INTERACT_BLOCKING
			name = "shielded frame assembly"
			to_chat(user, span_notice("Você solda o colete para[src]."))
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_FIFTH_STEP)
			if(!istype(tool, /obj/item/clothing/head/helmet/sec))
				return NONE
			if(!user.temporarilyRemoveItemFromInventory(tool))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("Você acrescenta[tool]Para[src]."))
			qdel(tool)
			name = "covered and shielded frame assembly"
			inhand_icon_state = "ed209_hat"
			icon_state = "ed209_hat"
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_SIXTH_STEP)
			if(!isprox(tool))
				return NONE
			if(!user.temporarilyRemoveItemFromInventory(tool))
				return ITEM_INTERACT_BLOCKING
			build_step++
			to_chat(user, span_notice("Você acrescenta[tool]Para[src]."))
			qdel(tool)
			name = "covered, shielded and sensored frame assembly"
			inhand_icon_state = "ed209_prox"
			icon_state = "ed209_prox"
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_SEVENTH_STEP)
			if(!istype(tool, /obj/item/stack/cable_coil))
				return NONE
			var/obj/item/stack/cable_coil/coil = tool
			if(coil.get_amount() < 1)
				to_chat(user, span_warning("Precisa de um cabo para ligar o ED-209!"))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("Você começa a ligar[src]..."))
			if(!do_after(user, 4 SECONDS, target = src))
				return ITEM_INTERACT_BLOCKING
			if(coil.get_amount() < 1 || build_step != ASSEMBLY_SEVENTH_STEP)
				return ITEM_INTERACT_BLOCKING
			coil.use(1)
			to_chat(user, span_notice("Você liga.[src]."))
			name = "wired ED-209 assembly"
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_EIGHTH_STEP)
			if(!istype(tool, /obj/item/gun/energy/disabler))
				return NONE
			if(!user.temporarilyRemoveItemFromInventory(tool))
				return ITEM_INTERACT_BLOCKING
			name = "[tool.name] ED-209 assembly"
			to_chat(user, span_notice("Você acrescenta[tool]Para[src]."))
			inhand_icon_state = "ed209_taser"
			icon_state = "ed209_taser"
			qdel(tool)
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_NINTH_STEP)
			if(tool.tool_behaviour != TOOL_SCREWDRIVER)
				return NONE
			to_chat(user, span_notice("Você começa a colocar a arma na moldura..."))
			if(!tool.use_tool(src, user, 40, volume=100))
				return ITEM_INTERACT_BLOCKING
			var/mob/living/simple_animal/bot/secbot/ed209/B = new(drop_location())
			B.name = created_name
			to_chat(user, span_notice("Você completa o ED-209."))
			qdel(src)
			return ITEM_INTERACT_SUCCESS

// Repairbot assemblies
/obj/item/bot_assembly/repairbot
	name = "Repairbot Chasis"
	desc = "É uma caixa de ferramentas com azulejos no topo."
	icon_state = "repairbot_box"
	throwforce = 10
	created_name = "Repairbot"
	///the toolbox our repairbot is made of
	var/toolbox = /obj/item/storage/toolbox/mechanical
	///the color of our toolbox
	var/toolbox_color = ""

/obj/item/bot_assembly/repairbot/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/bot_assembly/repairbot/proc/set_color(new_color)
	add_atom_colour(new_color, FIXED_COLOUR_PRIORITY)
	toolbox_color = new_color

/obj/item/bot_assembly/repairbot/update_desc()
	. = ..()
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			desc = "É uma caixa de ferramentas com um monitor gigante saindo!"
		else
			desc = initial(desc)

/obj/item/bot_assembly/repairbot/update_overlays()
	. = ..()
	if(build_step >= ASSEMBLY_FIRST_STEP)
		. += mutable_appearance(icon, "repairbot_base_sensor", appearance_flags = RESET_COLOR|KEEP_APART)
	if(build_step >= ASSEMBLY_SECOND_STEP)
		. += mutable_appearance(icon, "repairbot_base_arms", appearance_flags = RESET_COLOR|KEEP_APART)

/obj/item/bot_assembly/repairbot/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(!istype(tool, /obj/item/bodypart/arm/left/robot) && !istype(tool, /obj/item/bodypart/arm/right/robot))
				return NONE
			if(!can_finish_build(tool, user))
				return ITEM_INTERACT_BLOCKING
			build_step++
			to_chat(user, span_notice("Você acrescenta[tool]Para[src]Boop bip!"))
			qdel(tool)
			update_appearance()
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_SECOND_STEP)
			if(!istype(tool, /obj/item/stack/conveyor))
				return NONE
			if(!can_finish_build(tool, user))
				return ITEM_INTERACT_BLOCKING
			var/mob/living/basic/bot/repairbot/repair = new(drop_location())
			repair.name = created_name
			repair.toolbox = toolbox
			repair.set_color(toolbox_color)
			to_chat(user, span_notice("Você acrescenta[tool]Para[src]Boop bip!"))
			var/obj/item/stack/crafting_stack = tool
			crafting_stack.use(1)
			qdel(src)
			return ITEM_INTERACT_SUCCESS

// Medbot Assembly
/obj/item/bot_assembly/medbot
	name = "incomplete medibot assembly"
	desc = "Um kit de primeiros socorros com um braço robô permanentemente enxertado nele."
	icon_state = "medbot_assembly_generic"
	base_icon_state = "medbot_assembly"
	created_name = "Medibot" //To preserve the name if it's a unique medbot I guess
	var/skin = null //Same as medbot, set to tox or ointment for the respective kits.
	var/healthanalyzer = /obj/item/healthanalyzer
	var/medkit_type = /obj/item/storage/medkit

/obj/item/bot_assembly/medbot/proc/set_skin(skin)
	src.skin = skin
	if(skin)
		icon_state = "[base_icon_state]_[skin]"

/obj/item/bot_assembly/medbot/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(!istype(tool, /obj/item/healthanalyzer))
				var/obj/item/healthanalyzer/analyzer = tool // SKYRAT EDIT ADDITION BEGIN -- EXTRA ROBOTICS HEALTH ANALYZERS
				if (!analyzer.can_be_used_in_medibot())
					user?.balloon_alert(user, "Não há portas de ligação!")
					return // SKYRAT EDIT ADDITION END
				return NONE
			if(!user.temporarilyRemoveItemFromInventory(tool))
				return ITEM_INTERACT_BLOCKING
			healthanalyzer = tool.type
			to_chat(user, span_notice("Você acrescenta[tool]Para[src]."))
			qdel(tool)
			name = "first aid/robot arm/health analyzer assembly"
			add_overlay("[base_icon_state]_analyzer")
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_SECOND_STEP)
			if(!isprox(tool))
				return NONE
			if(!can_finish_build(tool, user))
				return ITEM_INTERACT_BLOCKING
			qdel(tool)
			var/mob/living/basic/bot/medbot/medbot = new(drop_location(), skin)
			to_chat(user, span_notice("Você completa o Medbot. Beep boop!"))
			medbot.name = created_name
			medbot.medkit_type = medkit_type
			medbot.robot_arm = robot_arm
			medbot.health_analyzer = healthanalyzer
			var/obj/item/storage/medkit/medkit = medkit_type
			medbot.damage_type_healer = initial(medkit.damagetype_healed) ? initial(medkit.damagetype_healed) : BRUTE
			qdel(src)
			return ITEM_INTERACT_SUCCESS


// Honkbot Assembly
/obj/item/bot_assembly/honkbot
	name = "incomplete honkbot assembly"
	desc = "O palhaço está aprontando mais uma vez."
	icon_state = "honkbot_arm"
	created_name = "Honkbot"

/obj/item/bot_assembly/honkbot/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(!isprox(tool))
				return NONE
			if(!user.temporarilyRemoveItemFromInventory(tool))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("Você adiciona o[tool]Para[src]!"))
			icon_state = "honkbot_proxy"
			name = "incomplete Honkbot assembly"
			qdel(tool)
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_SECOND_STEP)
			if(!istype(tool, /obj/item/bikehorn))
				return NONE
			if(!can_finish_build(tool, user))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("Você adiciona o[tool]Para[src]Honk!"))
			var/mob/living/basic/bot/honkbot/new_honkbot = new(drop_location())
			new_honkbot.name = created_name
			playsound(new_honkbot, 'sound/machines/ping.ogg', 50, TRUE, -1)
			qdel(tool)
			qdel(src)
			return ITEM_INTERACT_SUCCESS

// Secbot Assembly
/obj/item/bot_assembly/secbot
	name = "incomplete securitron assembly"
	desc = "Algum tipo de montagem bizarra feita de um sensor de proximidade, capacidade e sinalizador."
	icon_state = "helmet_signaler"
	inhand_icon_state = "helmet"
	lefthand_file = 'icons/mob/inhands/clothing/hats_righthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/hats_lefthand.dmi'
	created_name = "Securitron" // To preserve the name if it's a unique securitron I guess
	/// If you're converting it into a grievousbot, how many swords have you attached
	var/swordamt = 0
	/// Honk
	var/toyswordamt = 0

/obj/item/bot_assembly/secbot/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	var/atom/drop_loc = drop_location()
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(tool.tool_behaviour == TOOL_WELDER)
				if(!tool.use_tool(src, user, 0, volume=40))
					return ITEM_INTERACT_BLOCKING
				add_overlay("hs_hole")
				to_chat(user, span_notice("Você solda um buraco[src]!"))
				build_step++
				return ITEM_INTERACT_SUCCESS

			if(tool.tool_behaviour != TOOL_SCREWDRIVER) //deconstruct
				return NONE

			new /obj/item/assembly/signaler(drop_loc)
			new /obj/item/clothing/head/helmet/sec(drop_loc)
			to_chat(user, span_notice("Você desconecta o sinalizador do capacete."))
			qdel(src)
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_SECOND_STEP)
			if(isprox(tool))
				if(!user.temporarilyRemoveItemFromInventory(tool))
					return ITEM_INTERACT_BLOCKING
				to_chat(user, span_notice("Você acrescenta[tool]Para[src]!"))
				add_overlay("hs_eye")
				name = "helmet/signaler/prox sensor assembly"
				qdel(tool)
				build_step++
				return ITEM_INTERACT_SUCCESS

			if(tool.tool_behaviour != TOOL_WELDER) //deconstruct
				return NONE

			if(!tool.use_tool(src, user, 0, volume=40))
				return ITEM_INTERACT_BLOCKING

			cut_overlay("hs_hole")
			to_chat(user, span_notice("Você solda o buraco[src]Cale-se!"))
			build_step--
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_THIRD_STEP)
			if((istype(tool, /obj/item/bodypart/arm/left/robot)) || (istype(tool, /obj/item/bodypart/arm/right/robot)))
				if(!user.temporarilyRemoveItemFromInventory(tool))
					return ITEM_INTERACT_BLOCKING
				to_chat(user, span_notice("Você acrescenta[tool]Para[src]!"))
				name = "helmet/signaler/prox sensor/robot arm assembly"
				add_overlay("hs_arm")
				robot_arm = tool.type
				qdel(tool)
				build_step++
				return ITEM_INTERACT_SUCCESS

			if(tool.tool_behaviour != TOOL_SCREWDRIVER) //deconstruct
				return NONE

			cut_overlay("hs_eye")
			new /obj/item/assembly/prox_sensor(drop_loc)
			to_chat(user, span_notice("Você desliga o sensor de proximidade de[src]."))
			build_step--
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_FOURTH_STEP)
			if(istype(tool, /obj/item/melee/baton/security))
				if(!can_finish_build(tool, user))
					return ITEM_INTERACT_BLOCKING
				to_chat(user, span_notice("Você completa o Securitron! Beep boop."))
				var/mob/living/simple_animal/bot/secbot/S = new(drop_loc)
				S.name = created_name
				S.baton_type = tool.type
				S.robot_arm = robot_arm
				qdel(tool)
				qdel(src)
				return ITEM_INTERACT_SUCCESS

			if(tool.tool_behaviour == TOOL_WRENCH)
				to_chat(user, span_notice("Você se ajusta.[src]Braços para montar armas extras."))
				build_step++
				return ITEM_INTERACT_SUCCESS

			if(tool.tool_behaviour == TOOL_SCREWDRIVER) //deconstruct
				cut_overlay("hs_arm")
				var/obj/item/bodypart/dropped_arm = new robot_arm(drop_loc)
				robot_arm = null
				to_chat(user, span_notice("Você tira.[dropped_arm]De[src]."))
				build_step--
				if(toyswordamt > 0 || toyswordamt)
					toyswordamt = 0
					icon_state = initial(icon_state)
					to_chat(user, span_notice("A ligação supercola[src]São espadas de brinquedo para seu chassis estala!"))
					for(var/IS in 1 to toyswordamt)
						new /obj/item/toy/sword(drop_loc)
				return ITEM_INTERACT_SUCCESS

			if(!istype(tool, /obj/item/toy/sword))
				return NONE

			if(toyswordamt < 3 && swordamt <= 0)
				if(!user.temporarilyRemoveItemFromInventory(tool))
					return ITEM_INTERACT_BLOCKING
				created_name = "General Beepsky"
				name = "helmet/signaler/prox sensor/robot arm/toy sword assembly"
				icon_state = "grievous_assembly"
				to_chat(user, span_notice("Você supercola[tool]Em um dos[src]É o braço de fenda."))
				qdel(tool)
				toyswordamt++
				return ITEM_INTERACT_SUCCESS

			if(!can_finish_build(tool, user))
				return ITEM_INTERACT_BLOCKING

			to_chat(user, span_notice("Você completa o Securitron! Algo parece um pouco errado com ele...?"))
			var/mob/living/simple_animal/bot/secbot/grievous/toy/S = new(drop_loc)
			S.name = created_name
			S.robot_arm = robot_arm
			qdel(tool)
			qdel(src)
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_FIFTH_STEP)
			if(tool.tool_behaviour == TOOL_SCREWDRIVER) //deconstruct
				build_step--
				swordamt = 0
				icon_state = initial(icon_state)
				to_chat(user, span_notice("Você destranca.[src]As espadas de energia."))
				for(var/IS in 1 to swordamt)
					new /obj/item/melee/energy/sword/saber(drop_loc)
				return ITEM_INTERACT_SUCCESS

			if(!istype(tool, /obj/item/melee/energy/sword/saber))
				return NONE

			if(swordamt < 3)
				if(!user.temporarilyRemoveItemFromInventory(tool))
					return ITEM_INTERACT_BLOCKING
				created_name = "General Beepsky"
				name = "helmet/signaler/prox sensor/robot arm/energy sword assembly"
				icon_state = "grievous_assembly"
				to_chat(user, span_notice("Você vai embora.[tool]Em um dos[src]É o braço de fenda."))
				qdel(tool)
				swordamt++
				return ITEM_INTERACT_SUCCESS

			if(!can_finish_build(tool, user))
				return ITEM_INTERACT_BLOCKING

			to_chat(user, span_notice("Você completa o Securitron! Algo parece um pouco errado com ele...?"))
			var/mob/living/simple_animal/bot/secbot/grievous/S = new(drop_loc)
			S.name = created_name
			S.robot_arm = robot_arm
			qdel(tool)
			qdel(src)
			return ITEM_INTERACT_SUCCESS

//Firebot Assembly
/obj/item/bot_assembly/firebot
	name = "incomplete firebot assembly"
	desc = "Um extintor com um braço preso nele."
	icon_state = "firebot_arm"
	created_name = "Firebot"

/obj/item/bot_assembly/firebot/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(!istype(tool, /obj/item/clothing/head/utility/hardhat/red))
				return NONE
			if(!user.temporarilyRemoveItemFromInventory(tool))
				return ITEM_INTERACT_BLOCKING
			to_chat(user,span_notice("Você adiciona o[tool]Para[src]!"))
			icon_state = "firebot_helmet"
			desc = "Uma montagem incompleta do robô com um capacete de fogo."
			qdel(tool)
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_SECOND_STEP)
			if(!isprox(tool))
				return NONE
			if(!can_finish_build(tool, user))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("Você adiciona o[tool]Para[src]Beep Boop!"))
			var/mob/living/basic/bot/firebot/firebot = new(drop_location())
			firebot.name = created_name
			qdel(tool)
			qdel(src)
			return ITEM_INTERACT_SUCCESS

//Get cleaned
/obj/item/bot_assembly/hygienebot
	name = "incomplete hygienebot assembly"
	desc = "Limpe o pântano de uma vez por todas."
	icon_state = "hygienebot"
	created_name = "Hygienebot"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/bot_assembly/hygienebot/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	var/atom/drop_loc = drop_location()
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(tool.tool_behaviour == TOOL_WELDER) //Construct
				if(!tool.use_tool(src, user, 0, volume=40))
					return ITEM_INTERACT_BLOCKING
				to_chat(user, span_notice("Você solda um poço de água[src]!"))
				build_step++
				return ITEM_INTERACT_SUCCESS

			if(tool.tool_behaviour != TOOL_WRENCH) //Deconstruct
				return NONE
			if(!tool.use_tool(src, user, 0, volume=40))
				return ITEM_INTERACT_BLOCKING
			new /obj/item/stack/sheet/iron(drop_loc, 2)
			to_chat(user, span_notice("Você desliga a montagem do robô de higiene."))
			qdel(src)
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_SECOND_STEP)
			if(isprox(tool)) //Construct
				if(!user.temporarilyRemoveItemFromInventory(tool))
					return ITEM_INTERACT_BLOCKING

				build_step++
				to_chat(user, span_notice("Você acrescenta[tool]Para[src]."))
				qdel(tool)
				return ITEM_INTERACT_SUCCESS

			if(tool.tool_behaviour != TOOL_WELDER) //Deconstruct
				return NONE

			if(!tool.use_tool(src, user, 0, volume=30))
				return ITEM_INTERACT_BLOCKING

			to_chat(user, span_notice("Você solda o poço de água[src]!"))
			build_step--
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_THIRD_STEP)
			if(!can_finish_build(tool, user, 0))
				return ITEM_INTERACT_BLOCKING

			if(tool.tool_behaviour == TOOL_SCREWDRIVER) //deconstruct
				new /obj/item/assembly/prox_sensor(drop_loc)
				to_chat(user, span_notice("Você desliga o sensor de proximidade de[src]."))
				build_step--
				return ITEM_INTERACT_SUCCESS

			if(!istype(tool, /obj/item/stack/ducts)) //Construct
				return NONE

			var/obj/item/stack/ducts/D = tool
			if(D.get_amount() < 1)
				to_chat(user, span_warning("Você precisa de um duto fluido para terminar.[src]"))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("Você começa a falar[src]..."))
			if(!do_after(user, 4 SECONDS, target = src) && D.use(1))
				return ITEM_INTERACT_BLOCKING
			to_chat(user, span_notice("Você fala alto[src]."))
			var/mob/living/basic/bot/hygienebot/new_bot = new(drop_location())
			new_bot.name = created_name
			qdel(src)
			return ITEM_INTERACT_SUCCESS

// Vim Assembly
/obj/item/bot_assembly/vim
	name = "incomplete vim assembly"
	desc = "Um capacete espacial com uma perna presa nele. Parece que precisa de outra perna, para se tornar algo."
	icon_state = "vim_0"
	created_name = "\improper Vim"

/obj/item/bot_assembly/vim/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	switch(build_step)
		if(ASSEMBLY_FIRST_STEP)
			if(!istype(tool, /obj/item/bodypart/leg/left/robot) && !istype(tool, /obj/item/bodypart/leg/right/robot))
				return NONE
			if(!user.temporarilyRemoveItemFromInventory(tool))
				return ITEM_INTERACT_BLOCKING
			balloon_alert(user, "Perna presa")
			icon_state = "vim_1"
			desc = "Algum tipo de mecanismo incompleto. Parece estar faltando os faróis."
			qdel(tool)
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_SECOND_STEP)
			if(!istype(tool, /obj/item/flashlight))
				return NONE
			if(!user.temporarilyRemoveItemFromInventory(tool))
				return ITEM_INTERACT_SUCCESS
			balloon_alert(user, "Lampara adicionada")
			icon_state = "vim_2"
			desc = "Algum tipo de mecanismo incompleto. A lanterna foi adicionada, mas não está segura."
			qdel(tool)
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_THIRD_STEP)
			if(tool.tool_behaviour != TOOL_SCREWDRIVER)
				return NONE
			balloon_alert(user, "Segurando lanterna...")
			if(!tool.use_tool(src, user, 4 SECONDS, volume=100))
				return ITEM_INTERACT_BLOCKING
			balloon_alert(user, "Lanterna Segura.")
			icon_state = "vim_3"
			desc = "Algum tipo de mecanismo incompleto. Parece quase completo, e só precisa de uma reunião de voz."
			build_step++
			return ITEM_INTERACT_SUCCESS

		if(ASSEMBLY_FOURTH_STEP)
			if(!istype(tool, /obj/item/assembly/voice))
				return NONE
			if(!can_finish_build(tool, user))
				return ITEM_INTERACT_BLOCKING
			balloon_alert(user, "Montagem terminada")
			var/obj/vehicle/sealed/car/vim/new_vim = new(drop_location())
			new_vim.name = created_name
			qdel(tool)
			qdel(src)
			return ITEM_INTERACT_SUCCESS
