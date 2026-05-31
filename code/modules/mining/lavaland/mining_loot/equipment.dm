// Rod of Asclepius
/obj/item/rod_of_asclepius
	name = "\improper Rod of Asclepius"
	desc = "Uma vara de madeira do tamanho do antebraço com uma cobra esculpida ao seu redor, enrolando o seu caminho até os lados da vara. Algo sobre isso parece inspirar em você a responsabilidade e o dever de ajudar os outros."
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	icon_state = "asclepius_dormant"
	inhand_icon_state = "asclepius_dormant"
	icon_angle = -45
	var/activated = FALSE
	var/static/list/oath_lines = list(
		"I swear to fulfill, to the best of my ability and judgment, this covenant:",
		"I will apply, for the benefit of the sick, all measures that are required, avoiding those twin traps of overtreatment and therapeutic nihilism.",
		"I will remember that I remain a member of society, with special obligations to all my fellow human beings, those sound of mind and body as well as the infirm.",
		"If I do not violate this oath, may I enjoy life and art, respected while I live and remembered with affection thereafter. May I always act so as to preserve the finest traditions of my calling and may I long experience the joy of healing those who seek my help.",
	)

/obj/item/rod_of_asclepius/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/rod_of_asclepius/update_desc(updates)
	. = ..()
	desc = activated ? "Uma vara de madeira curta com uma cobra mística inseparavelmente agarrando-se e a vara ao seu antebraço. Ela flui com uma energia curativa que se dispersa entre você e aqueles ao seu redor." : initial(desc)

/obj/item/rod_of_asclepius/update_icon_state()
	. = ..()
	icon_state = inhand_icon_state = "asclepius_[activated ? "active" : "dormant"]"

/obj/item/rod_of_asclepius/vv_edit_var(vname, vval)
	. = ..()
	if(vname == NAMEOF(src, activated) && activated)
		activated()

/obj/item/rod_of_asclepius/attack_self(mob/user)
	if(activated)
		return
	if(!iscarbon(user))
		to_chat(user, span_warning("A escultura de cobra parece ganhar vida, nem que seja por um momento, antes de voltar ao seu estado adormecido, quase como se achasse você incapaz de cumprir seu juramento."))
		return
	var/mob/living/carbon/itemUser = user
	if(itemUser.has_status_effect(/datum/status_effect/hippocratic_oath))
		to_chat(user, span_warning("Você não pode lidar com a responsabilidade de mais de uma vara!"))
		return

	var/static/failText = span_warning("A cobra parece insatisfeita com seu juramento incompleto e retorna ao seu lugar anterior na vara, retornando ao seu estado adormecido de madeira. Você deve ficar parado enquanto completa seu juramento!")
	to_chat(itemUser, span_notice("A cobra de madeira que foi esculpida na vara parece de repente ganhar vida e começa a descer pelo seu braço! A compulsão para ajudar os outros cresce anormalmente forte..."))
	for(var/oath_line in oath_lines)
		if(do_after(itemUser, 3 SECONDS, target = itemUser))
			itemUser.say(oath_line, forced = "hippocratic oath")
			continue

		balloon_alert(itemUser, "Interrompido!")
		to_chat(itemUser, failText)
		return

	apply_oath(itemUser)

/obj/item/rod_of_asclepius/proc/apply_oath(mob/living/carbon/user)
	to_chat(user, span_notice("A cobra, satisfeita com seu juramento, se apega e a vara ao seu antebraço com um aperto inseparável. Seus pensamentos parecem apenas girar em torno da ideia central de ajudar os outros, e o mal não é nada mais que uma memória distante e má..."))
	var/datum/status_effect/hippocratic_oath/effect = user.apply_status_effect(/datum/status_effect/hippocratic_oath)
	effect.hand = user.get_held_index_of_item(src)
	activated()

/obj/item/rod_of_asclepius/proc/activated()
	item_flags = DROPDEL | ABSTRACT
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT(type))
	activated = TRUE
	update_appearance()

// Red/Blue Cubes

/obj/item/warp_cube
	name = "blue cube"
	desc = "Um mistério cubo azul."
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "blue_cube"
	var/teleport_color = "#3FBAFD"
	var/obj/item/warp_cube/linked
	var/teleporting = FALSE

/obj/item/warp_cube/Destroy()
	if(!QDELETED(linked))
		qdel(linked)
	linked = null
	return ..()

/obj/item/warp_cube/attack_self(mob/user)
	var/turf/current_location = get_turf(user)
	if(!linked || isnull(get_turf(linked)) || !check_teleport_valid(src, current_location))
		to_chat(user, span_warning("[src]Estraga inútilmente."))
		return
	if(teleporting)
		return
	teleporting = TRUE
	linked.teleporting = TRUE
	var/turf/T = get_turf(src)
	new /obj/effect/temp_visual/warp_cube(T, user, teleport_color, TRUE)
	SSblackbox.record_feedback("tally", "warp_cube", 1, type)
	new /obj/effect/temp_visual/warp_cube(get_turf(linked), user, linked.teleport_color, FALSE)
	var/obj/effect/warp_cube/link_holder = new /obj/effect/warp_cube(T)
	user.forceMove(link_holder) //mess around with loc so the user can't wander around
	sleep(0.25 SECONDS)
	if(QDELETED(user))
		qdel(link_holder)
		return
	if(QDELETED(linked) || isnull(get_turf(linked)))
		user.forceMove(get_turf(link_holder))
		qdel(link_holder)
		return
	link_holder.forceMove(get_turf(linked))
	sleep(0.25 SECONDS)
	if(QDELETED(user))
		qdel(link_holder)
		return
	teleporting = FALSE
	if(!QDELETED(linked))
		linked.teleporting = FALSE
	user.forceMove(get_turf(link_holder))
	qdel(link_holder)

/obj/item/warp_cube/red
	name = "red cube"
	desc = "Um mistério cubo vermelho."
	icon_state = "red_cube"
	teleport_color = "#FD3F48"

/obj/item/warp_cube/red/Initialize(mapload)
	. = ..()
	if(!linked)
		var/obj/item/warp_cube/blue = new(src.loc)
		linked = blue
		blue.linked = src

/obj/effect/warp_cube
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	anchored = TRUE

// Immortality Talisman

/obj/item/immortality_talisman
	name = "\improper Immortality Talisman"
	desc = "Um terrível talismã que pode torná-lo completamente invulnerável."
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "talisman"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	actions_types = list(/datum/action/item_action/immortality)
	var/cooldown = 0

/obj/item/immortality_talisman/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/anti_magic, ALL)

/datum/action/item_action/immortality
	name = "Immortality"

/obj/item/immortality_talisman/attack_self(mob/user)
	if(cooldown < world.time)
		SSblackbox.record_feedback("amount", "immortality_talisman_uses", 1)
		cooldown = world.time + 600
		new /obj/effect/immortality_talisman(get_turf(user), user)
	else
		to_chat(user, span_warning("[src]Ainda não está pronto!"))

/obj/effect/immortality_talisman
	name = "hole in reality"
	desc = "Tem a forma de uma pessoa."
	icon_state = "blank"
	icon = 'icons/effects/effects.dmi'
	var/vanish_description = "vanishes from reality"
	// Weakref to the user who we're "acting" on
	var/datum/weakref/user_ref

/obj/effect/immortality_talisman/Initialize(mapload, mob/new_user)
	. = ..()
	if(new_user)
		vanish(new_user)

/obj/effect/immortality_talisman/Destroy()
	// If we have a mob, we need to free it before cleanup
	// This is a safety to prevent nuking a human, not so much a good pattern in general
	unvanish()
	return ..()

/obj/effect/immortality_talisman/proc/unvanish()
	var/mob/user = user_ref?.resolve()
	user_ref = null

	if(!user)
		return

	user.remove_traits(list(TRAIT_GODMODE, TRAIT_NO_TRANSFORM), REF(src))
	user.forceMove(get_turf(src))
	user.visible_message(span_danger("[user]Volta para a realidade!"))

/obj/effect/immortality_talisman/proc/vanish(mob/user)
	user.visible_message(span_danger("[user] [vanish_description], deixando um buraco[user.p_their()]Lugar!"))

	desc = "Tem um formato horrível como[user.name]."
	setDir(user.dir)

	user.forceMove(src)
	user.add_traits(list(TRAIT_GODMODE, TRAIT_NO_TRANSFORM), REF(src))

	user_ref = WEAKREF(user)

	addtimer(CALLBACK(src, PROC_REF(dissipate)), 10 SECONDS)

/obj/effect/immortality_talisman/proc/dissipate()
	qdel(src)

/obj/effect/immortality_talisman/attackby()
	return

/obj/effect/immortality_talisman/relaymove(mob/living/user, direction)
	// Won't really come into play since our mob has TRAIT_NO_TRANSFORM and cannot move,
	// but regardless block all relayed moves, because no, you cannot move in the void.
	return

/obj/effect/immortality_talisman/singularity_pull(atom/singularity, current_size)
	return

/obj/effect/immortality_talisman/void
	vanish_description = "é arrastado para o vazio"

// Shared Bag

/obj/item/shared_storage
	name = "paradox bag"
	desc = "De alguma forma, está em dois lugares ao mesmo tempo."
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "paradox_bag"
	worn_icon_state = "paradoxbag"
	slot_flags = ITEM_SLOT_BELT
	resistance_flags = INDESTRUCTIBLE

/obj/item/shared_storage/red

/obj/item/shared_storage/red/Initialize(mapload)
	. = ..()

	create_storage(max_total_storage = 15, max_slots = 21)

	new /obj/item/shared_storage/blue(drop_location(), src)

/obj/item/shared_storage/blue/Initialize(mapload, atom/master)
	. = ..()
	if(!istype(master))
		return INITIALIZE_HINT_QDEL
	create_storage(max_total_storage = 15, max_slots = 21)

	atom_storage.set_real_location(master)
