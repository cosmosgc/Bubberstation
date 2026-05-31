
/obj/item/storage/box/lipsticks
	name = "lipstick box"

/obj/item/storage/box/lipsticks/PopulateContents()
	..()
	new /obj/item/lipstick(src)
	new /obj/item/lipstick/purple(src)
	new /obj/item/lipstick/jade(src)
	new /obj/item/lipstick/black(src)

/obj/item/lipstick/quantum
	name = "quantum lipstick"

/obj/item/lipstick/quantum/attack(mob/attacked_mob, mob/user)
	if(!open || !ismob(attacked_mob))
		return

	if(!ishuman(attacked_mob))
		to_chat(user, span_warning("Onde estão os lábios disso?"))
		return

	INVOKE_ASYNC(src, PROC_REF(async_set_color), attacked_mob, user)

/obj/item/lipstick/quantum/proc/async_set_color(mob/attacked_mob, mob/user)
	// BUBBERSTATION EDIT START: TGUI COLOR PICKER
	var/new_color = tgui_color_picker(
			user,
			"Select lipstick color",
			null,
			COLOR_WHITE,
		)
	// BUBBERSTATION EDIT END: TGUI COLOR PICKER

	var/mob/living/carbon/human/target = attacked_mob
	if(target.is_mouth_covered())
		to_chat(user, span_warning("Removedor[ target == user ? "your" : "[target.p_their()]" ]Máscara!"))
		return
	if(target.lip_style) //if they already have lipstick on
		to_chat(user, span_warning("Você precisa limpar o batom velho primeiro!"))
		return

	if(target == user)
		user.visible_message(span_notice("[user]Sim.[user.p_their()]lábios com\the [src]."), 			span_notice("Tire um momento para se candidatar.\the [src]Perfeito!"))
		target.update_lips("lipstick", new_color, lipstick_trait)
		return

	user.visible_message(span_warning("[user]Começa a fazer[target]Os lábios com\the [src]."), 		span_notice("Você começa a aplicar\the [src]Vamos.[target]Os lábios..."))
	if(!do_after(user, 2 SECONDS, target = target))
		return
	user.visible_message(span_notice("[user]Sim.[target]Os lábios com\the [src]."), 		span_notice("Você se candidata.\the [src]Vamos.[target]Os lábios."))
	target.update_lips("lipstick", new_color, lipstick_trait)

/obj/item/hairbrush/comb
	name = "comb"
	desc = "Uma ferramenta simples, usada para endireitar o cabelo e nós nele."
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "blackcomb"

/obj/item/hairstyle_preview_magazine
	name = "hip hairstyles magazine"
	desc = "Uma revista com uma magnitude de penteados!"

/obj/item/hairstyle_preview_magazine/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	// A simple GUI with a list of hairstyles and a view, so people can choose a hairstyle!

/obj/effect/decal/cleanable/hair
	name = "hair cuttings"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "cut_hair"

/obj/item/razor
	name = "electric razor"
	desc = "A mais recente e mais poderosa navalha nascida da ciência de barbear."
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "razor"
	obj_flags = CONDUCTS_ELECTRICITY
	w_class = WEIGHT_CLASS_TINY
	// How long do we take to shave someone's (facial) hair?
	var/shaving_time = 5 SECONDS

/obj/item/razor/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user]Começa a fazer a barba.[user.p_them()]Sem o guarda navalha! Parece que...[user.p_theyre()]Tentando cometer suicídio!"))
	shave(user, BODY_ZONE_PRECISE_MOUTH)
	shave(user, BODY_ZONE_HEAD)//doesnt need to be BODY_ZONE_HEAD specifically, but whatever
	return BRUTELOSS

/obj/item/razor/proc/shave(mob/living/carbon/human/target_human, location = BODY_ZONE_PRECISE_MOUTH)
	if(location == BODY_ZONE_PRECISE_MOUTH)
		target_human.set_facial_hairstyle("Shaved", update = TRUE)
	else
		target_human.set_hairstyle("Bald", update = TRUE)

	playsound(loc, 'sound/items/unsheath.ogg', 20, TRUE)


/obj/item/razor/attack(mob/attacked_mob, mob/living/user)
	if(!ishuman(attacked_mob))
		return ..()

	var/mob/living/carbon/human/target_human = attacked_mob
	var/location = user.zone_selected
	var/obj/item/bodypart/head/noggin = target_human.get_bodypart(BODY_ZONE_HEAD)
	var/static/list/head_zones = list(BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_HEAD)

	if(!noggin && (location in head_zones))
		to_chat(user, span_warning("[target_human]Não tem cabeça!"))
		return

	if(!(location in head_zones) && !user.combat_mode)
		to_chat(user, span_warning("Pare, olhe para o que está segurando e pense em si mesmo.\"Deve ser usado no cabelo ou no cabelo facial.\""))
		return

	if(location == BODY_ZONE_PRECISE_MOUTH)
		if(!(noggin.head_flags & HEAD_FACIAL_HAIR))
			to_chat(user, span_warning("Não há pêlos faciais para barbear!"))
			return

		var/covering = target_human.is_mouth_covered()
		if(covering)
			to_chat(user, span_warning("[covering]Está no caminho!"))
			return

		if(HAS_TRAIT(target_human, TRAIT_SHAVED))
			to_chat(user, span_warning("[target_human]Está muito barbeado. Realmente raspada."))
			return

		if(target_human.facial_hairstyle == "Shaved")
			to_chat(user, span_warning("Já barbeado!"))
			return

		var/self_shaving = target_human == user // Shaving yourself?
		user.visible_message(span_notice("[user]Começa a se barbear.[self_shaving ? user.p_their() : "[target_human]'s"]Cabelo com[src]."), 			span_notice("Tire um momento para se barbear.[self_shaving ? "your" : "[target_human]'s" ]Cabelo com[src]..."))

		if(do_after(user, shaving_time, target = target_human))
			user.visible_message(span_notice("[user]Barba.[self_shaving ? user.p_their() : "[target_human]'s"]Cabelo limpo com[src]."), 				span_notice("Você termina de fazer a barba.[self_shaving ? "your" : " [target_human]'s"]Cabelo com[src]Rápido e limpo!"))

			shave(target_human, location)

	else if(location == BODY_ZONE_HEAD)
		if(!(noggin.head_flags & HEAD_HAIR))
			to_chat(user, span_warning("Não há cabelo para barbear!"))
			return

		if(!target_human.is_location_accessible(location))
			to_chat(user, span_warning("O capacete está no caminho!"))
			return

		if(target_human.hairstyle == "Bald" || target_human.hairstyle == "Balding Hair" || target_human.hairstyle == "Skinhead")
			to_chat(user, span_warning("Não há cabelo suficiente para se barbear!"))
			return

		if(HAS_TRAIT(target_human, TRAIT_SHAVED))
			to_chat(user, span_warning("[target_human]Está muito barbeado. Realmente raspada."))
			return

		var/self_shaving = target_human == user // Shaving yourself?
		user.visible_message(span_notice("[user]Começa a se barbear.[self_shaving ? user.p_their() : "[target_human]'s"]Cabelo com[src]."), 			span_notice("Tire um momento para se barbear.[self_shaving ? "your" : "[target_human]'s" ]Cabelo com[src]..."))

		if(do_after(user, shaving_time, target = target_human))
			user.visible_message(span_notice("[user]Barba.[self_shaving ? user.p_their() : "[target_human]'s"]Cabelo limpo com[src]."), 				span_notice("Você termina de fazer a barba.[self_shaving ? "your" : " [target_human]'s"]Cabelo com[src]Rápido e limpo!"))

			shave(target_human, location)

		return

	return ..()

/obj/structure/sign/barber
	name = "barbershop sign"
	desc = "Uma faixa vermelha-azul-branca brilhante que você não vai confundir com qualquer outro!"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "barber"
	buildable_sign = FALSE // Don't want them removed, they look too jank.

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/barber, 13)

/obj/structure/sign/barber/Initialize(mapload)
	. = ..()
	if(mapload)
		find_and_mount_on_atom()

/obj/structure/sign/barber/get_turfs_to_mount_on()
	return list(get_step(src, dir))
