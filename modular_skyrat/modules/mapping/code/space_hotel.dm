/// A simple one-use beacon to activate a two-way portal to the anchored receiver it's linked to.
/obj/item/permanent_portal_creator
	name = "two-way bluespace entanglement device"
	desc = "Um dispositivo com um nome muito complexo, que só é usado para confirmar o segundo local que está amarrado a uma âncora de emaranhamento estacionária."
	icon = 'icons/obj/devices/tracker.dmi'
	icon_state = "hand_tele"
	inhand_icon_state = "electronic"
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 3
	throw_range = 5
	armor_type = /datum/armor/item_permanent_portal_creator
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	/// The weakref to the linked entanglement anchor.
	var/datum/weakref/linked_anchor = null
	/// The name of the portal created at the position of the device.
	var/beacon_portal_name = "portal to somewhere"
	/// The name of the portal created at the position of the anchor.
	var/anchor_portal_name = "exit from somewhere"


/datum/armor/item_permanent_portal_creator
	bomb = 30
	fire = 100
	acid = 100

/obj/item/permanent_portal_creator/attack_self(mob/user, modifiers)
	if(!linked_anchor)
		balloon_alert(user, "não vinculado!")
		return

	if(!isweakref(linked_anchor))
		balloon_alert(user, "Destino inválido!")
		return

	var/obj/item/permanent_portal_anchor/portal_anchor = linked_anchor.resolve()

	if(!istype(portal_anchor) || !get_turf(portal_anchor))
		balloon_alert(user, "Destino inválido!")
		return

	if(tgui_alert(user, "Tem certeza que este é o lugar onde quer ter o portal localizado? Esta ação é permanente e não pode ser desfeita.", "Are you sure?", list("Yes", "No")) != "Yes")
		return

	balloon_alert(user, "Começando o processo de emaranhamento...")

	if(!do_after(user, 5 SECONDS))
		balloon_alert(user, "Enredo cancelado!")
		return

	var/list/obj/effect/portal/created_portals = create_portal_pair(get_turf(src), get_turf(portal_anchor), _lifespan = NONE)
	created_portals[1].name = beacon_portal_name
	created_portals[2].name = anchor_portal_name

	created_portals[1].balloon_alert(user, "Enredo bem sucedido!")

	qdel(portal_anchor)
	qdel(src)


/obj/item/permanent_portal_creator/space_hotel
	name = "\improper Twin Nexus two-way bluespace entanglement device"
	beacon_portal_name = "portal to the Twin Nexus"
	anchor_portal_name = "exit of the Twin Nexus"


/obj/item/permanent_portal_creator/space_hotel/examine(mob/user)
	. = ..()
	. += "\nThis one seems to have the Twin Nexus hotel's logo engraved on its back."


/obj/item/permanent_portal_anchor
	name = "two-way bluespace entanglement anchor"
	desc = "Um dispositivo com um nome muito complexo, que serve como o alvo estacionário de um dispositivo de emaranhamento bidirecional ligado."
	icon = 'icons/obj/devices/tracker.dmi'
	icon_state = "beacon"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	anchored = FALSE
	density = FALSE
	layer = BELOW_MOB_LAYER
	/// Does it automatically deploy when initialized?
	var/deploy_on_init = FALSE


/obj/item/permanent_portal_anchor/Initialize(mapload)
	. = ..()
	if(deploy_on_init)
		deploy()


/obj/item/permanent_portal_anchor/attack_self(mob/user, modifiers)
	if(!ishuman(user))
		return

	balloon_alert(user, "deploying...")

	if(!do_after(user, 5 SECONDS))
		balloon_alert(user, "A implantação falhou!")
		return

	deploy(user)

	playsound(src, 'modular_skyrat/modules/aesthetics/airlock/sound/bolts_down.ogg', 50, FALSE)

	balloon_alert(user, "implantação bem sucedida!")


/// Simple helper proc to deploy the anchor, with mob/user as an optional argument to make them drop it if they're holding it.
/obj/item/permanent_portal_anchor/proc/deploy(mob/user = null)
	if(user)
		user.dropItemToGround(src, force = TRUE, silent = TRUE)

	set_anchored(TRUE)

	// Just to make it look a little nicer.
	pixel_x = 0
	pixel_y = -10


/obj/item/permanent_portal_anchor/attackby(obj/item/attacking_item, mob/user, params)
	if(!istype(attacking_item, /obj/item/permanent_portal_creator))
		return ..()

	if(!anchored)
		balloon_alert(user, "Precisa ser destinada!")
		return

	var/obj/item/permanent_portal_creator/portal_maker = attacking_item
	portal_maker.linked_anchor = WEAKREF(src)

	balloon_alert(user, "Ligando sucesso!")


/obj/item/permanent_portal_anchor/space_hotel
	name = "\improper Twin Nexus two-way bluespace entanglement anchor"
	desc = "Um dispositivo com um nome muito complexo, que serve como o alvo estacionário de um dispositivo de emaranhamento bidirecional ligado.\n\nNo seu caso, serve para libertar seus convidados."


//Space Hotel Keycards and Room Doors
/obj/item/key_card/hotel_room
	name = "\improper Twin Nexus keycard"
	desc = "Um cartão-chave, para abrir um quarto de hotel fechado."
	access_id = "guest_room_"
	/// The number of the room, so that it gets automatically handled by the code everywhere
	/// it's relevant.
	var/room_number = null


/obj/item/key_card/hotel_room/Initialize(mapload)
	. = ..()

	if(!room_number)
		return

	access_id += "[room_number]"


/obj/item/key_card/hotel_room/examine(mob/user)
	. = ..()

	if(!room_number)
		return

	. += "It has an engraving on it that reads: \"Guest Room [room_number]\""


/obj/item/key_card/hotel_room/master
	name = "\improper Twin Nexus master keycard"
	desc = "Um cartão-chave para abrir todos os quartos de hotel.\nTem uma gravura nela que diz:\"Acesso Mestre\""
	access_id = null
	master_access = TRUE

/obj/effect/mapping_helpers/airlock/access/all/twin_nexus_staff/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_TWIN_NEXUS_STAFF
	return access_list

/obj/effect/mapping_helpers/airlock/access/all/twin_nexus_staff/manager/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_TWIN_NEXUS_MANAGER
	return access_list

/obj/machinery/door/airlock/keyed/hotel_room
	name = "Guest Room"
	access_id = "guest_room_"
	autoclose = TRUE
	greyscale_accent_color = null
	/// The number of the room, so that it gets automatically handled by the code everywhere
	/// it's relevant.
	var/room_number = null
	var/alternate = FALSE


/obj/machinery/door/airlock/keyed/hotel_room/Initialize(mapload)
	. = ..()

	if(!room_number)
		return

	name += " [room_number]"
	access_id += "[room_number]"
	fill_state_suffix = "_[room_number]"

	update_appearance()


/obj/item/key_card/hotel_room/one
	color = "#E0E000"
	room_number = 1

/obj/machinery/door/airlock/keyed/hotel_room/one
	greyscale_accent_color = "#E0E000"
	room_number = 1


/obj/item/key_card/hotel_room/two
	color = "#C4004E"
	room_number = 2

/obj/machinery/door/airlock/keyed/hotel_room/two
	greyscale_accent_color = "#C4004E"
	room_number = 2


/obj/item/key_card/hotel_room/three
	color = "#00C074"
	room_number = 3

/obj/machinery/door/airlock/keyed/hotel_room/three
	greyscale_accent_color = "#00C074"
	room_number = 3


/obj/item/key_card/hotel_room/four
	color = "#2CAF2C"
	room_number = 4

/obj/machinery/door/airlock/keyed/hotel_room/four
	greyscale_accent_color = "#2CAF2C"
	room_number = 4


/obj/item/key_card/hotel_room/five
	color = "#E55C01"
	room_number = 5

/obj/machinery/door/airlock/keyed/hotel_room/five
	greyscale_accent_color = "#E55C01"
	room_number = 5


/obj/item/key_card/hotel_room/six
	color = "#AC00AC"
	room_number = 6

/obj/machinery/door/airlock/keyed/hotel_room/six
	greyscale_accent_color = "#AC00AC"
	room_number = 6


/obj/item/key_card/hotel_room/seven
	color = "#0AA7E9"
	room_number = 7

/obj/machinery/door/airlock/keyed/hotel_room/seven
	greyscale_accent_color = "#0AA7E9"
	room_number = 7

/area/ruin/space/has_grav/hotel
	ambience_index = AMBIENCE_GENERIC
