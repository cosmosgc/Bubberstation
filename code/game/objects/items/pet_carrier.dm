#define pet_carrier_full(carrier) carrier.occupants.len >= carrier.max_occupants || carrier.occupant_weight >= carrier.max_occupant_weight

//Used to transport little animals without having to drag them across the station.
//Comes with a handy lock to prevent them from running off.
/obj/item/pet_carrier
	name = "pet carrier"
	desc = "Um grande portador de animais de estimação branco e azul. Bom para carregar<s>Carne para o chef</s>Animais bonitos por preto."
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/pet_carrier"
	post_init_icon_state = "pet_carrier_open"
	base_icon_state = "pet_carrier"
	inhand_icon_state = "pet_carrier"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	greyscale_config = /datum/greyscale_config/pet_carrier
	greyscale_config_inhand_left = /datum/greyscale_config/pet_carrier_inhands_left
	greyscale_config_inhand_right = /datum/greyscale_config/pet_carrier_inhands_right
	greyscale_colors = COLOR_BLUE
	force = 5
	attack_verb_continuous = list("bashes", "carries")
	attack_verb_simple = list("bash", "carry")
	w_class = WEIGHT_CLASS_BULKY
	throw_speed = 2
	throw_range = 3
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT)
	interaction_flags_mouse_drop = NEED_DEXTERITY
	/// Is the pet carrier open? Allows you to collect/remove pets.
	var/open = TRUE
	/// Does this carrier allow locking? Disabled for the small pet carrier.
	var/allows_locking = TRUE
	/// Is this carrier locked? Locks don't require access, just an alt click.
	var/locked = FALSE
	/// List of all mob occupants from inside of the pet carrier.
	var/list/occupants = list()
	/// Combined weight of all mob occupants based on the MOB_SIZE_ defines.
	var/occupant_weight = 0
	/// Maximum number of mobs that can fit in a pet carrier, so you can't have infinite mice or something in one carrier
	var/max_occupants = 3
	/// Maximum weight of a mob that can be carried. This is calculated from the mob sizes of occupants
	var/max_occupant_weight = MOB_SIZE_SMALL

	/// Sound played when the mob carrier is opened.
	var/open_sound = 'sound/items/handling/cardboard_box/cardboard_box_rustle.ogg'
	/// Sound played when the mob carrier is closed.
	var/close_sound = 'sound/items/handling/cardboard_box/cardboardbox_drop.ogg'

/obj/item/pet_carrier/Initialize(mapload)
	. = ..()
	register_context()
	AddElement(/datum/element/cuffable_item)

/obj/item/pet_carrier/Destroy()
	if(occupants.len)
		for(var/V in occupants)
			remove_occupant(V)
	return ..()

/obj/item/pet_carrier/Exited(atom/movable/gone, direction)
	. = ..()
	if(isliving(gone) && (gone in occupants))
		var/mob/living/living_gone = gone
		occupants -= gone
		occupant_weight -= living_gone.mob_size

/obj/item/pet_carrier/examine(mob/user)
	. = ..()
	if(occupants.len)
		for(var/V in occupants)
			var/mob/living/L = V
			. += span_notice("Tem.[L]Dentro.")
	else
		. += span_notice("Não tem nada dentro.")

	// At some point these need to be converted to contextual screentips
	. += span_notice("Ative-o em sua mão para[open ? "close" : "open"]Sua porta. Click-drag no chão para liberar seus ocupantes.")
	if(!open && allows_locking)
		. += span_notice("Alt-click para[locked ? "unlock" : "lock"]Sua porta.")

/obj/item/pet_carrier/attack_self(mob/living/user)
	if(open)
		to_chat(user, span_notice("Você fecha.[src]É a porta."))
		playsound(user, close_sound, 50, TRUE)
		open = FALSE
	else
		if(locked)
			to_chat(user, span_warning("[src]Está trancada!"))
			return
		to_chat(user, span_notice("Você abre.[src]É a porta."))
		playsound(user, open_sound, 50, TRUE)
		open = TRUE
	update_appearance()

/obj/item/pet_carrier/click_alt(mob/living/user)
	if(open || !allows_locking)
		return CLICK_ACTION_BLOCKING
	locked = !locked
	to_chat(user, span_notice("Você liga o interruptor.[locked ? "down" : "up"]."))
	if(locked)
		playsound(user, 'sound/machines/airlock/boltsdown.ogg', 30, TRUE)
	else
		playsound(user, 'sound/machines/airlock/boltsup.ogg', 30, TRUE)
	update_appearance()
	return CLICK_ACTION_SUCCESS

/obj/item/pet_carrier/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(user.combat_mode || !isliving(interacting_with))
		return NONE
	if(!open)
		to_chat(user, span_warning("Você precisa abrir.[src]Uma porta!"))
		return ITEM_INTERACT_BLOCKING
	var/mob/living/target = interacting_with
	if(target.mob_size > max_occupant_weight)
		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			if(isfeline(H)) // SKYRAT EDIT - FELINE TRAITS. Was: isfelinid(H)
				to_chat(user, span_warning("Precisaria de muito petisco e guloseimas, mais talvez um ponteiro laser, para isso funcionar."))
			else
				to_chat(user, span_warning("Humanos, geralmente, não se encaixam em portadores de animais."))
		else
			to_chat(user, span_warning("Você tem a sensação[target]Não é para um[name]."))
		return ITEM_INTERACT_BLOCKING
	if(user == target)
		to_chat(user, span_warning("Por que faria isso?"))
		return ITEM_INTERACT_BLOCKING
	load_occupant(user, target)
	return ITEM_INTERACT_SUCCESS

/obj/item/pet_carrier/relaymove(mob/living/user, direction)
	if(open)
		loc.visible_message(span_notice("[user]Subindo para fora[src]!"), 		span_warning("[user]Pula para fora[src]!"))
		remove_occupant(user)
		return
	else if(!locked)
		loc.visible_message(span_notice("[user]Empurra abre a porta para[src]!"), 		span_warning("[user]Empurra abre a porta de[src]!"))
		open = TRUE
		update_appearance()
		return
	else if(user.client)
		container_resist_act(user)

/obj/item/pet_carrier/container_resist_act(mob/living/user)
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	if(user.mob_size <= MOB_SIZE_SMALL)
		to_chat(user, span_notice("Você cutuca um membro[src]As barras e começar a falhar para o interruptor de fechadura ... Isso vai levar algum tempo."))
		to_chat(loc, span_warning("Viu?[user]Aproximem-se pelas barras e desafie-se para o interruptor!"))
		if(!do_after(user, rand(300, 400), target = user) || open || !locked || !(user in occupants))
			return
		loc.visible_message(span_warning("[user]Liga o Interruptor de Bloqueio.[src]Chegando através!"), null, null, null, user)
		to_chat(user, span_bolddanger("Bingo! Uma \"fechadura abra\"!"))
		locked = FALSE
		playsound(src, 'sound/machines/airlock/boltsup.ogg', 30, TRUE)
		update_appearance()
	else
		loc.visible_message(span_warning("[src]Começa a bater como algo empurra contra a porta!"), null, null, null, user)
		to_chat(user, span_notice("Você começa a empurrar para fora[src]Isso levará cerca de 20 segundos."))
		if(!do_after(user, 20 SECONDS, target = user) || open || !locked || !(user in occupants))
			return
		loc.visible_message(span_warning("[user]Empurra para fora[src]!"), null, null, null, user)
		to_chat(user, span_notice("Você se abre.[src]A porta contra a resistência da fechadura e cair!"))
		locked = FALSE
		open = TRUE
		update_appearance()
		remove_occupant(user)

/obj/item/pet_carrier/update_icon_state()
	if(open)
		icon_state = "[base_icon_state]_open"
		return ..()
	icon_state = "[base_icon_state]_[!occupants.len ? "closed" : "occupied"]_[locked ? "trancado" : "destrancado"]"
	return ..()

/obj/item/pet_carrier/mouse_drop_dragged(atom/over_atom, mob/user, src_location, over_location, params)
	if(isopenturf(over_atom) && open && occupants.len)
		user.visible_message(span_notice("[user]Descarrega.[src]."), 		span_notice("Você descarrega.[src]em frente[over_atom]."))
		for(var/V in occupants)
			remove_occupant(V, over_atom)

/obj/item/pet_carrier/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	if(!locked)
		context[SCREENTIP_CONTEXT_LMB] = open ? "Close door" : "Open door"
		return TRUE
	if(allows_locking)
		context[SCREENTIP_CONTEXT_ALT_LMB] = locked ? "Unlock door" : "Lock door"
		return  TRUE

/obj/item/pet_carrier/proc/load_occupant(mob/living/user, mob/living/target)
	if(pet_carrier_full(src))
		to_chat(user, span_warning("[src]Já está carregando demais!"))
		return
	user.visible_message(span_notice("[user]Começa a carregar.[target]Em[src]."), 	span_notice("Você começa a carregar[target]Em[src]..."), null, null, target)
	to_chat(target, span_userdanger("[user]Começa a carregar você para[user.p_their()] [name]!"))
	if(!do_after(user, 3 SECONDS, target))
		return
	if(target in occupants)
		return
	if(pet_carrier_full(src)) //Run the checks again, just in case
		to_chat(user, span_warning("[src]Já está carregando demais!"))
		return
	user.visible_message(span_notice("[user]Cargas.[target]Em[src]!"), 	span_notice("Você carrega.[target]Em[src]."), null, null, target)
	to_chat(target, span_userdanger("[user]Carrega você em[user.p_their()] [name]!"))
	add_occupant(target)

/obj/item/pet_carrier/proc/add_occupant(mob/living/occupant)
	if((occupant in occupants) || !istype(occupant))
		return
	occupant.forceMove(src)
	occupants += occupant
	occupant_weight += occupant.mob_size

/obj/item/pet_carrier/proc/remove_occupant(mob/living/occupant, turf/new_turf)
	if(!(occupant in occupants) || !istype(occupant))
		return
	occupant.forceMove(new_turf ? new_turf : drop_location())
	occupants -= occupant
	occupant_weight -= occupant.mob_size
	occupant.setDir(SOUTH)

/obj/item/pet_carrier/biopod
	name = "biopod"
	desc = "Dispositivo alienígena usado para propósito indescritível. Ou carregando animais de estimação."
	icon = 'icons/obj/pet_carrier.dmi'
	icon_state = "biopod_open"
	post_init_icon_state = null
	base_icon_state = "biopod"
	inhand_icon_state = "biopod"
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_colors = null

/obj/item/pet_carrier/small
	name = "small pet carrier"
	desc = "Um pequeno porta-animais para animais de tamanho miniatura."
	icon = 'icons/obj/pet_carrier.dmi'
	icon_state = "small_carrier_open"
	post_init_icon_state = null
	w_class = WEIGHT_CLASS_NORMAL
	base_icon_state = "small_carrier"
	inhand_icon_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_colors = null

	max_occupants = 1
	allows_locking = FALSE

/obj/item/pet_carrier/small/mouse
	name = "small mouse carrier"
	desc = "Um pequeno porta-animais para animais de tamanho miniatura. Parece preparado para um rato."
	icon_state = "small_carrier_occupied_unlocked"
	open = FALSE

/obj/item/pet_carrier/small/mouse/Initialize(mapload)
	var/mob/living/basic/mouse/hero_mouse = new /mob/living/basic/mouse(src)
	add_occupant(hero_mouse) //mouse hero
	return ..()

#undef pet_carrier_full
