/obj/item/ammo_box/magazine/security
	name = "pistol magazine (9mm Murphy)"
	desc = "Uma revista de 9mm, adequada para o Nanotrasen Service Pistol. Vem com uma mola mais robusta do que a revista média e peso para arrancar."
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/magazine.dmi'
	icon_state = "9x19p"
	base_icon_state = "9x19p"
	ammo_type = /obj/item/ammo_casing/security
	caliber = CALIBER_9MM_SEC
	max_ammo = 14
	ammo_band_color = null
	multiple_sprites = AMMO_BOX_PER_BULLET
	multiple_sprite_use_base = TRUE
	var/murphy_eject_sound = 'sound/items/weapons/throwhard.ogg'
	var/was_ejected = 0

/obj/item/ammo_box/magazine/security/rocket
	name = "pistol magazine (9mm Murphy Rocket Eject)"
	desc = parent_type::desc + "Com uma pequena carga dentro que provoca ejeção, esta tem menos espaço para munição e uma velocidade letal para ejeções."
	ammo_type = /obj/item/ammo_casing/security
	max_ammo = 10
	base_icon_state = "9x19pI"
	murphy_eject_sound = 'sound/items/weapons/gun/general/rocket_launch.ogg'

/obj/item/ammo_box/magazine/security/rocket/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(QDELETED(src))
		return
	if(was_ejected)
		playsound(get_turf(src.loc), 'sound/effects/explosion/explosion1.ogg', 40, 1)
		visible_message(span_warning("[src]Se desfaz em sucata pela força do impacto."))
		if(isliving(hit_atom))
			var/mob/living/hit_mob = hit_atom
			hit_mob.Knockdown(2 SECONDS)
			hit_mob.apply_damage(40, BRUTE, BODY_ZONE_CHEST)
		qdel(src)

/obj/item/ammo_box/magazine/recharge/ntusp
	name = "small disabling power pack"
	desc = "Um pequeno pacote de energia recarregável para o NT22 HCS 'Enforcer'. Sintetiza até 12 balas 22HL que se cansam de alvos."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ammo.dmi'
	base_icon_state = "powerpack_small"
	icon_state = "powerpack_small-12"
	ammo_type = /obj/item/ammo_casing/caseless/c22hl
	max_ammo = 12

/obj/item/ammo_box/magazine/recharge/ntusp/laser
	name = "small lethal power pack"
	desc = "Um pequeno, recarregável pacote de energia para o NT22 HCS 'Enforcer' que foi modificado. Sintetiza até 8 balas 22LS que disparam lasers."
	ammo_type = /obj/item/ammo_casing/caseless/c22ls
	base_icon_state = "powerpack_small-l"
	icon_state = "powerpack_small-l-8"
	max_ammo = 8

/obj/item/ammo_box/magazine/recharge/ntusp/laser/empty
	start_empty = TRUE // so you cant field convert mags to full laser ones

/obj/item/ammo_box/magazine/recharge/ntusp/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/recharge/ntusp/emp_act(severity) //shooting physical bullets wont stop you dying to an EMP
	. = ..()
	if(!(. & EMP_PROTECT_CONTENTS))
		var/bullet_count = ammo_count()
		var/bullets_to_remove = round(bullet_count / severity)
		for(var/i = 0; i < bullets_to_remove; i++)
			qdel(get_round())
		update_icon()

/obj/item/ammo_box/speedloader/security
	name = "speed loader (9mm Murphy)"
	desc = "Projetado para recarregar rapidamente revólveres de 9mm."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ammo.dmi'
	icon_state = "9mm"
	base_icon_state = "9mm"
	ammo_type = /obj/item/ammo_casing/security
	caliber = CALIBER_9MM_SEC
	max_ammo = 5
	ammo_band_icon = null
	ammo_band_color = null

/obj/item/ammo_box/speedloader/security/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-base"

/obj/item/ammo_box/speedloader/security/update_overlays()
	. = ..()
	if(!LAZYLEN(stored_ammo))
		return
	for(var/inserted_ammo in 1 to stored_ammo.len)
		. += "9mm-revolver-[inserted_ammo]"
