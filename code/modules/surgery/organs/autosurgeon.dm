/obj/item/autosurgeon
	name = "autosurgeon"
	desc = "Um dispositivo que insere automaticamente um implante, chip de habilidade ou órgão no usuário sem o incômodo de uma cirurgia extensa. Tem um espaço para inserir implantes ou órgãos e uma chave de fenda para remover itens acidentalmente adicionados."
	icon = 'icons/obj/devices/tool.dmi'
	icon_state = "autosurgeon"
	inhand_icon_state = "nothing"
	w_class = WEIGHT_CLASS_SMALL

	/// How many times you can use the autosurgeon before it becomes useless
	var/uses = INFINITY
	/// What organ will the autosurgeon sub-type will start with. ie, CMO autosurgeon start with a medi-hud.
	var/starting_organ
	/// The organ currently loaded in the autosurgeon, ready to be implanted.
	var/obj/item/organ/stored_organ
	/// The list of organs and their children we allow into the autosurgeon. An empty list means no whitelist.
	var/list/organ_whitelist = list()
	/// The percentage modifier for how fast you can use the autosurgeon to implant other people.
	var/surgery_speed = 1
	/// The overlay that shows when the autosurgeon has an organ inside of it.
	var/loaded_overlay = "autosurgeon_loaded_overlay"

/obj/item/autosurgeon/attack_self_tk(mob/user)
	return //stops TK fuckery

/obj/item/autosurgeon/Initialize(mapload)
	. = ..()
	if(starting_organ)
		load_organ(new starting_organ(src))

/obj/item/autosurgeon/update_overlays()
	. = ..()
	if(stored_organ)
		. += loaded_overlay
		. += emissive_appearance(icon, loaded_overlay, src)

/obj/item/autosurgeon/proc/load_organ(obj/item/organ/loaded_organ, mob/living/user)
	if(user)
		if(stored_organ)
			to_chat(user, span_alert("[src]Já tem um implante armazenado."))
			return

		if(uses <= 0)
			to_chat(user, span_alert("[src]é usado e não pode ser carregado com mais implantes."))
			return

		if(organ_whitelist.len)
			var/organ_whitelisted
			for(var/whitelisted_organ in organ_whitelist)
				if(istype(loaded_organ, whitelisted_organ))
					organ_whitelisted = TRUE
					break
			if(!organ_whitelisted)
				to_chat(user, span_alert("[src]Não é compatível com[loaded_organ]."))
				return

		if(!user.transferItemToLoc(loaded_organ, src))
			to_chat(user, span_alert("[loaded_organ]está preso em sua mão!"))
			return

	stored_organ = loaded_organ
	loaded_organ.forceMove(src)

	name = "[initial(name)] ([stored_organ.name])" //to tell you the organ type, like "suspicious autosurgeon (Reviver implant)"
	update_appearance()

/obj/item/autosurgeon/proc/use_autosurgeon(mob/living/target, mob/living/user, implant_time)
	if(!stored_organ)
		to_chat(user, span_alert("[src]Atualmente não tem nenhum implante armazenado."))
		return

	if(uses <= 0)
		to_chat(user, span_alert("[src]Já foi usado. As ferramentas são chatas e não vão reativar."))
		return

	if(implant_time)
		user.visible_message(
			span_notice("[user]Prepara-se para usar[src]Vamos.[target]."),
			span_notice("Você se prepara para usar[src]Vamos.[target]."),
		)
		if(!do_after(user, (implant_time * surgery_speed), target))
			return

	if(target != user)
		log_combat(user, target, "autosurgeon implanted [stored_organ] into", "[src]", "in [AREACOORD(target)]")
		user.visible_message(span_notice("[user]Aperte um botão.[src]Como ele mergulha em[target]Ó corpo."), span_notice("Aperte um botão.[src]Como ele mergulha em[target]Ó corpo."))
	else
		user.visible_message(
			span_notice("[user]Aperte um botão.[src]Como ele mergulha em[user.p_their()]Corpo."),
			span_notice("Aperte um botão.[src]como ele mergulha em seu corpo."),
		)

	if (stored_organ.valid_zones && user.get_held_index_of_item(src))
		var/list/checked_zones = list(user.zone_selected)
		if (IS_RIGHT_INDEX(user.get_held_index_of_item(src)))
			checked_zones += list(BODY_ZONE_R_ARM, BODY_ZONE_R_LEG)
		else
			checked_zones += list(BODY_ZONE_L_ARM, BODY_ZONE_L_LEG)

		for (var/check_zone in checked_zones)
			if (stored_organ.valid_zones[check_zone])
				stored_organ.swap_zone(check_zone)
				break

	if (!stored_organ.Insert(target)) // insert stored organ into the user
		balloon_alert(user, "A inserção falhou!")
		return

	stored_organ = null
	name = initial(name) //get rid of the organ in the name
	playsound(target.loc, 'sound/items/weapons/circsawhit.ogg', 50, vary = TRUE)
	update_appearance()

	uses--
	if(uses <= 0)
		desc = "[initial(desc)]Parece que foi usado."

/obj/item/autosurgeon/attack_self(mob/user)//when the object it used...
	use_autosurgeon(user, user)

/obj/item/autosurgeon/attack(mob/living/target, mob/living/user, list/modifiers, list/attack_modifiers)
	add_fingerprint(user)
	use_autosurgeon(target, user, 8 SECONDS)

/obj/item/autosurgeon/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(isorgan(tool))
		load_organ(tool, user)
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/item/autosurgeon/screwdriver_act(mob/living/user, obj/item/screwtool)
	if(..())
		return TRUE
	if(!stored_organ)
		to_chat(user, span_warning("Não há implante em[src]Para você se retirar!"))
	else
		var/atom/drop_loc = user.drop_location()
		for(var/atom/movable/stored_implant as anything in src)
			stored_implant.forceMove(drop_loc)
			to_chat(user, span_notice("Você remove o[stored_organ]De[src]."))
			stored_organ = null

		screwtool.play_tool_sound(src)
		uses--
		if(uses <= 0)
			desc = "[initial(desc)]Parece que foi usado."
		update_appearance(UPDATE_ICON)
	return TRUE

/obj/item/autosurgeon/medical_hud
	desc = "Um autocirurgião de uso único que contém um aumento no monitor médico. Uma chave de fenda pode ser usada para removê-la, mas implantes não podem ser colocados de volta."
	uses = 1
	starting_organ = /obj/item/organ/cyberimp/eyes/hud/medical

/obj/item/autosurgeon/syndicate
	name = "suspicious autosurgeon"
	icon_state = "autosurgeon_syndicate"
	surgery_speed = 0.75
	loaded_overlay = "autosurgeon_syndicate_loaded_overlay"

/obj/item/autosurgeon/syndicate/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)

/obj/item/autosurgeon/syndicate/laser_arm
	desc = "Um autocirurgião de uso único que contém um laser de combate. Uma chave de fenda pode ser usada para removê-la, mas implantes não podem ser colocados de volta."
	uses = 1
	starting_organ = /obj/item/organ/cyberimp/arm/toolkit/gun/laser

/obj/item/autosurgeon/syndicate/thermal_eyes
	starting_organ = /obj/item/organ/eyes/robotic/thermals

/obj/item/autosurgeon/syndicate/thermal_eyes/single_use
	uses = 1

/obj/item/autosurgeon/syndicate/xray_eyes
	starting_organ = /obj/item/organ/eyes/robotic/xray

/obj/item/autosurgeon/syndicate/xray_eyes/single_use
	uses = 1

/obj/item/autosurgeon/syndicate/anti_stun
	starting_organ = /obj/item/organ/cyberimp/brain/anti_stun

/obj/item/autosurgeon/syndicate/anti_stun/single_use
	uses = 1

/obj/item/autosurgeon/syndicate/reviver
	starting_organ = /obj/item/organ/cyberimp/chest/reviver

/obj/item/autosurgeon/syndicate/reviver/single_use
	uses = 1

/obj/item/autosurgeon/syndicate/commsagent
	desc = "Um dispositivo que automaticamente, dolorosamente, insere um implante. Parece que alguém modificou especialmente este para inserir apenas... línguas. Horrível."
	starting_organ = /obj/item/organ/tongue

/obj/item/autosurgeon/syndicate/commsagent/Initialize(mapload)
	. = ..()
	organ_whitelist += /obj/item/organ/tongue

/obj/item/autosurgeon/syndicate/emaggedsurgerytoolset
	starting_organ = /obj/item/organ/cyberimp/arm/toolkit/surgery/emagged

/obj/item/autosurgeon/syndicate/emaggedsurgerytoolset/single_use
	uses = 1

/obj/item/autosurgeon/syndicate/contraband_sechud
	desc = "Contém um implante de contrabando, indetectável por scanners de saúde."
	uses = 1
	starting_organ = /obj/item/organ/cyberimp/eyes/hud/security/syndicate
