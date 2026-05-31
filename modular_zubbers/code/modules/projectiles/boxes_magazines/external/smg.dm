/obj/item/ammo_box/magazine/wt550m9
	name = "\improper WT-550 magazine"

/obj/item/ammo_box/magazine/wt550m9/wtap
	name = "wt550 Armour-piercing magazine"

/obj/item/ammo_box/magazine/wt550m9/wtic
	name = "wt550 incendiary magazine"


/obj/item/ammo_box/magazine/recharge/ntmp5
	name = "large disabling power pack"
	desc = "Um pacote de energia recarregável para o 'Lancer' NT22-HCS-MP. Sintetiza até vinte balas 22HL que se cansam de alvos."
	parent_type = /obj/item/ammo_box/magazine/recharge/ntusp
	ammo_type = /obj/item/ammo_casing/caseless/c22hl/ntmp5
	base_icon_state = "powerpack"
	icon_state = "powerpack"
	max_ammo = 20
	custom_materials = null

/obj/item/ammo_box/magazine/recharge/ntmp5/proc/get_charge_overlay_state()
	var/current_ammo = ammo_count()
	if(current_ammo <= 0 || max_ammo <= 0)
		return null
	var/ammo_percent = current_ammo / max_ammo
	var/list/overlay_candidates
	if(ammo_percent < 0.5)
		overlay_candidates = list("powerpack_half", "powerpack-half", "powerpack_half-l", "powerpack-half-l")
	else
		overlay_candidates = list("powerpack-full", "powerpack_full", "powerpack-full-l", "powerpack_full-l")

	for(var/overlay_state in overlay_candidates)
		if(icon_exists(icon, overlay_state))
			return overlay_state

	return null

/obj/item/ammo_box/magazine/recharge/ntmp5/update_icon_state()
	. = ..()
	icon_state = initial(base_icon_state)

/obj/item/ammo_box/magazine/recharge/ntmp5/update_overlays()
	. = ..()
	var/charge_overlay_state = get_charge_overlay_state()
	if(charge_overlay_state)
		. += charge_overlay_state

/obj/item/ammo_box/magazine/recharge/ntmp5/laser
	name = "large lethal power pack"
	desc = "Um pacote de energia recarregável para o 'Lancer' NT22-HCS-MP que foi modificado. Sintetiza até 16 balas 22LS que disparam lasers."
	ammo_type = /obj/item/ammo_casing/caseless/c22ls/ntmp5
	base_icon_state = "powerpack-l"
	icon_state = "powerpack-l"
	max_ammo = 16

/obj/item/ammo_box/magazine/recharge/ntmp5/laser/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/recharge/ntmp5/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/recharge/ntmp5/attackby(obj/item/A, mob/user)
	if(istype(A, /obj/item/ntusp_conversion_kit))
		to_chat(user, span_danger("[A]faz um zumbido enquanto modifica\the [src]As lentes para fabricar balas mais letais."))
		new /obj/item/ammo_box/magazine/recharge/ntmp5/laser/empty(get_turf(src))
		qdel(src)
	else
		return ..()

/obj/item/ammo_box/magazine/recharge/ntmp5/laser/attackby(obj/item/A, mob/user)
	if(istype(A, /obj/item/ntusp_conversion_kit))
		to_chat(user, span_notice("[A]faz um zumbido enquanto modifica\the [src]A lente para fabricar balas menos letais."))
		new /obj/item/ammo_box/magazine/recharge/ntmp5/empty(get_turf(src))
		qdel(src)
	else
		return ..()
