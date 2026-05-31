/obj/item/lipstick
	gender = PLURAL
	name = "red lipstick"
	desc = "Uma marca genérica de batom."
	icon =  'modular_skyrat/modules/salon/icons/items.dmi' //SKYRAT EDIT CHANGE - ORIGINAL: icon = 'icons/obj/cosmetic.dmi'
	icon_state = "lipstick"
	base_icon_state = "lipstick"
	inhand_icon_state = "lipstick"
	w_class = WEIGHT_CLASS_TINY
	interaction_flags_click = NEED_DEXTERITY|NEED_HANDS|ALLOW_RESTING
	var/open = FALSE
	/// Actual color of the lipstick, also gets applied to the human
	var/lipstick_color = COLOR_RED
	/// The style of lipstick. Upper, middle, or lower lip. Default is middle.
	var/style = "lipstick"
	/// A trait that's applied while someone has this lipstick applied, and is removed when the lipstick is removed
	var/lipstick_trait
	/// Can this lipstick spawn randomly
	var/random_spawn = TRUE

/obj/item/lipstick/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	update_appearance(UPDATE_ICON)

/obj/item/lipstick/vv_edit_var(vname, vval)
	. = ..()
	if(vname == NAMEOF(src, open))
		update_appearance(UPDATE_ICON)

/obj/item/lipstick/examine(mob/user)
	. = ..()
	. += "Alt-click to change the style."

/obj/item/lipstick/update_icon_state()
	icon_state = "[base_icon_state][open ? "_uncap" : null]"
	inhand_icon_state = "[base_icon_state][open ? "open" : null]"
	return ..()

/obj/item/lipstick/update_overlays()
	. = ..()
	if(!open)
		return
	var/mutable_appearance/colored_overlay = mutable_appearance(icon, "lipstick_uncap_color")
	colored_overlay.color = lipstick_color
	. += colored_overlay

/obj/item/lipstick/click_alt(mob/user)
	display_radial_menu(user)
	return CLICK_ACTION_SUCCESS

/obj/item/lipstick/proc/display_radial_menu(mob/living/carbon/human/user)
	var/style_options = list(
		UPPER_LIP = icon('icons/hud/radial.dmi', UPPER_LIP),
		MIDDLE_LIP = icon('icons/hud/radial.dmi', MIDDLE_LIP),
		LOWER_LIP = icon('icons/hud/radial.dmi', LOWER_LIP),
	)
	var/pick = show_radial_menu(user, src, style_options, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
	if(!pick)
		return TRUE

	switch(pick)
		if(MIDDLE_LIP)
			style = "lipstick"
		if(LOWER_LIP)
			style = "lipstick_lower"
		if(UPPER_LIP)
			style = "lipstick_upper"
	return TRUE

/obj/item/lipstick/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated || !user.is_holding(src))
		return FALSE
	return TRUE

/obj/item/lipstick/purple
	name = "purple lipstick"
	lipstick_color = COLOR_PURPLE

/obj/item/lipstick/jade
	name = "jade lipstick"
	lipstick_color = COLOR_JADE

/obj/item/lipstick/blue
	name = "blue lipstick"
	lipstick_color = COLOR_BLUE

/obj/item/lipstick/green
	name = "green lipstick"
	lipstick_color = COLOR_GREEN

/obj/item/lipstick/white
	name = "white lipstick"
	lipstick_color = COLOR_WHITE

/obj/item/lipstick/black
	name = "black lipstick"
	lipstick_color = COLOR_BLACK

/obj/item/lipstick/black/death
	name = "\improper Kiss of Death"
	desc = "Um tubo de batom incrivelmente potente feito do veneno do temido lagarto espacial manchado amarelo, tão mortal quanto chique. Tente não manchar!"
	lipstick_trait = TRAIT_KISS_OF_DEATH
	random_spawn = FALSE

/obj/item/lipstick/syndie
	name = "syndie lipstick"
	desc = "Baton marcado com uma dose de beijos. Observe as regras de segurança!"
	icon_state = "slipstick"
	base_icon_state = "slipstick"
	lipstick_color = COLOR_SYNDIE_RED
	lipstick_trait = TRAIT_SYNDIE_KISS
	random_spawn = FALSE

/obj/item/lipstick/random
	name = "lipstick"
	icon_state = "random_lipstick"

/obj/item/lipstick/random/Initialize(mapload)
	. = ..()
	icon_state = "lipstick"
	var/static/list/possible_colors
	if(!possible_colors)
		possible_colors = list()
		for(var/obj/item/lipstick/lipstick_path as anything in (typesof(/obj/item/lipstick) - src.type))
			if(!initial(lipstick_path.lipstick_color) || !initial(lipstick_path.random_spawn))
				continue
			possible_colors[initial(lipstick_path.lipstick_color)] = initial(lipstick_path.name)
	lipstick_color = pick(possible_colors)
	name = possible_colors[lipstick_color]
	update_appearance()

/obj/item/lipstick/attack_self(mob/user)
	to_chat(user, span_notice("Você torce.[src] [open ? "closed" : "open"]."))
	open = !open
	update_appearance(UPDATE_ICON)

/obj/item/lipstick/attack(mob/M, mob/user)
	if(!open || !ismob(M))
		return

	if(!ishuman(M))
		to_chat(user, span_warning("Onde estão os lábios disso?"))
		return

	var/mob/living/carbon/human/target = M
	if(target.is_mouth_covered())
		to_chat(user, span_warning("Remover[ target == user ? "your" : "[target.p_their()]" ]Máscara!"))
		return
	if(target.lip_style) //if they already have lipstick on
		to_chat(user, span_warning("Você precisa limpar o batom velho primeiro!"))
		return

	if(target == user)
		user.visible_message(span_notice("[user]Sim.[user.p_their()]lábios com\the [src]."), 			span_notice("Tire um momento para se candidatar.\the [src]Perfeito!"))
		target.update_lips(style, lipstick_color, lipstick_trait)
		return

	user.visible_message(span_warning("[user]Começa a fazer[target]Os lábios com\the [src]."), 		span_notice("Você começa a aplicar\the [src]Vamos.[target]Os lábios..."))
	if(!do_after(user, 2 SECONDS, target = target))
		return
	user.visible_message(span_notice("[user]Sim.[target]Os lábios com\the [src]."), 		span_notice("Você se candidata.\the [src]Vamos.[target]Os lábios."))
	target.update_lips(style, lipstick_color, lipstick_trait)

//you can wipe off lipstick with paper!
/obj/item/paper/attack(mob/M, mob/user)
	if(user.zone_selected != BODY_ZONE_PRECISE_MOUTH || !ishuman(M))
		return ..()

	var/mob/living/carbon/human/target = M
	if(target == user)
		to_chat(user, span_notice("Você limpa o batom com[src]."))
		target.update_lips(null)
		return
	user.visible_message(span_warning("[user]Começa a limpar[target]É batom com\the [src]."), 		span_notice("Você começa a limpar.[target]É batom..."))
	if(!do_after(user, 1 SECONDS, target = target))
		return
	user.visible_message(span_notice("[user]Toalhitas[target]É batom com\the [src]."), 		span_notice("Você se limpa.[target]É batom."))
	target.update_lips(null)

/* SKYRAT EDIT REMOVAL
/obj/item/razor
	name = "electric razor"
	desc = "A mais recente e mais poderosa navalha nascida da ciência de barbear."
	icon = 'icons/obj/cosmetic.dmi'
	icon_state = "razor"
	inhand_icon_state = "razor"
	obj_flags = CONDUCTS_ELECTRICITY
	w_class = WEIGHT_CLASS_TINY
	sound_vary = TRUE
	pickup_sound = SFX_GENERIC_DEVICE_PICKUP
	drop_sound = SFX_GENERIC_DEVICE_DROP

/obj/item/razor/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user]Começa a fazer a barba.[user.p_them()]Sem o guarda navalha! Parece que...[user.p_theyre()]Tentando cometer suicídio!"))
	shave(user, BODY_ZONE_PRECISE_MOUTH)
	shave(user, BODY_ZONE_HEAD)//doesn't need to be BODY_ZONE_HEAD specifically, but whatever
	return BRUTELOSS

/obj/item/razor/proc/shave(mob/living/carbon/human/skinhead, location = BODY_ZONE_PRECISE_MOUTH)
	if(location == BODY_ZONE_PRECISE_MOUTH)
		skinhead.set_facial_hairstyle("Shaved", update = TRUE)
	else
		skinhead.set_hairstyle("Skinhead", update = TRUE)
	playsound(loc, 'sound/items/hair-clippers.ogg', 20, TRUE)

/obj/item/razor/attack(mob/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	if(!ishuman(target_mob))
		return ..()
	var/mob/living/carbon/human/human_target = target_mob
	var/obj/item/bodypart/head/noggin =  human_target.get_bodypart(BODY_ZONE_HEAD)
	var/location = user.zone_selected
	var/static/list/head_zones = list(BODY_ZONE_PRECISE_EYES, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_HEAD)
	if(!noggin && (location in head_zones))
		to_chat(user, span_warning("[human_target]Não tem cabeça!"))
		return
	if(location == BODY_ZONE_PRECISE_MOUTH)
		if(!user.combat_mode)
			if(human_target.gender == MALE)
				if(human_target == user)
					to_chat(user, span_warning("Precisa de um espelho para estilizar seu próprio cabelo facial!"))
					return
				if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
					return
				var/new_style = tgui_input_list(user, "Select a facial hairstyle", "Grooming", SSaccessories.facial_hairstyles_list)
				if(isnull(new_style))
					return
				var/covering = human_target.is_mouth_covered()
				if(covering)
					to_chat(user, span_warning("[covering]Está no caminho!"))
					return
				if(!(noggin.head_flags & HEAD_FACIAL_HAIR))
					to_chat(user, span_warning("Não há cabelo facial para estilizar!"))
					return
				if(HAS_TRAIT(human_target, TRAIT_SHAVED))
					to_chat(user, span_warning("[human_target]Está muito barbeado. Realmente raspada."))
					return
				user.visible_message(span_notice("[user]Tenta mudar[human_target]O penteado facial usando[src]."), span_notice("Você tenta mudar[human_target]O penteado facial usando[src]."))
				playsound(src, 'sound/items/hair-clippers.ogg', 50)
				if(new_style && do_after(user, 6 SECONDS, target = human_target))
					user.visible_message(span_notice("[user]com sucesso muda[human_target]O penteado facial usando[src]."), span_notice("Você mudou com sucesso.[human_target]O penteado facial usando[src]."))
					human_target.set_facial_hairstyle(new_style, update = TRUE)
					return
			else
				return
		else
			var/covering = human_target.is_mouth_covered()
			if(covering)
				to_chat(user, span_warning("[covering]Está no caminho!"))
				return
			if(!(noggin.head_flags & HEAD_FACIAL_HAIR))
				to_chat(user, span_warning("Não há pêlos faciais para barbear!"))
				return
			if(human_target.facial_hairstyle == "Shaved")
				to_chat(user, span_warning("Já barbeado!"))
				return

			if(human_target == user) //shaving yourself
				user.visible_message(span_notice("[user]Começa a se barbear.[user.p_their()]Cabelo facial com[src]."), 					span_notice("Tire um momento para raspar seu cabelo facial com[src]..."))
				playsound(src, 'sound/items/hair-clippers.ogg', 50)
				if(do_after(user, 5 SECONDS, target = user))
					user.visible_message(span_notice("[user]Barba.[user.p_their()]Cabelo facial limpo com[src]."), 						span_notice("Você termina de fazer a barba com[src]Rápido e limpo!"))
					shave(user, location)
				return
			else
				user.visible_message(span_warning("[user]Tenta se barbear.[human_target]É o cabelo facial com[src]."), 					span_notice("Você começa a fazer a barba.[human_target]O cabelo facial..."))
				playsound(src, 'sound/items/hair-clippers.ogg', 50)
				if(do_after(user, 5 SECONDS, target = human_target))
					user.visible_message(span_warning("[user]Raspa.[human_target]É o cabelo facial com[src]."), 						span_notice("Você se barbeia.[human_target]O cabelo facial está limpo."))
					shave(human_target, location)
				return
	else if(location == BODY_ZONE_HEAD)
		if(!user.combat_mode)
			if(human_target == user)
				to_chat(user, span_warning("Você precisa de um espelho para fazer seu próprio cabelo!"))
				return
			if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
				return
			var/new_style = tgui_input_list(user, "Select a hairstyle", "Grooming", SSaccessories.hairstyles_list)
			if(isnull(new_style))
				return
			if(!human_target.is_location_accessible(location))
				to_chat(user, span_warning("O capacete está no caminho!"))
				return
			if(!(noggin.head_flags & HEAD_HAIR))
				to_chat(user, span_warning("Não há cabelo para estilizar!"))
				return
			if(HAS_TRAIT(human_target, TRAIT_BALD))
				to_chat(user, span_warning("[human_target]É muito careca. Muito careca."))
				return
			user.visible_message(span_notice("[user]Tenta mudar[human_target]O penteado usando[src]."), span_notice("Você tenta mudar[human_target]O penteado usando[src]."))
			playsound(src, 'sound/items/hair-clippers.ogg', 50)
			if(new_style && do_after(user, 6 SECONDS, target = human_target))
				user.visible_message(span_notice("[user]com sucesso muda[human_target]O penteado usando[src]."), span_notice("Você mudou com sucesso.[human_target]O penteado usando[src]."))
				human_target.set_hairstyle(new_style, update = TRUE)
				return
		else
			if(!human_target.is_location_accessible(location))
				to_chat(user, span_warning("O capacete está no caminho!"))
				return
			if(!(noggin.head_flags & HEAD_HAIR))
				to_chat(user, span_warning("Não há cabelo para barbear!"))
				return
			if(human_target.hairstyle == "Bald" || human_target.hairstyle == "Balding Hair" || human_target.hairstyle == "Skinhead")
				to_chat(user, span_warning("Não há cabelo suficiente para se barbear!"))
				return

			if(human_target == user) //shaving yourself
				user.visible_message(span_notice("[user]Começa a se barbear.[user.p_their()]cabeça com[src]."), 					span_notice("Você começa a raspar a cabeça com[src]..."))
				playsound(src, 'sound/items/hair-clippers.ogg', 50)
				if(do_after(user, 5 SECONDS, target = user))
					user.visible_message(span_notice("[user]Barba.[user.p_their()]cabeça com[src]."), 						span_notice("Você termina de fazer a barba com[src]."))
					shave(user, location)
				return
			else
				user.visible_message(span_warning("[user]Tenta se barbear.[human_target]'s cabeça com[src]!"), 					span_notice("Você começa a fazer a barba.[human_target]A cabeça..."))
				playsound(src, 'sound/items/hair-clippers.ogg', 50)
				if(do_after(user, 5 SECONDS, target = human_target))
					user.visible_message(span_warning("[user]Barba.[human_target]É careca com a cabeça[src]!"), 						span_notice("Você se barbeia.[human_target]É careca."))
					shave(human_target, location)
				return
	return ..()
*/

/obj/item/razor/surgery
	name = "surgical razor"
	desc = "Uma navalha de grau médico. Suas lâminas de precisão fornecem um barbear limpo para preparação cirúrgica."
	icon = 'icons/obj/cosmetic.dmi'
	icon_state = "medrazor"

/obj/item/razor/surgery/get_surgery_tool_overlay(tray_extended)
	return "razor"
