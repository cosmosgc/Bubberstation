/obj/item/mecha_ammo
	name = "generic ammo box"
	desc = "Uma caixa de munição para uma arma desconhecida."
	w_class = WEIGHT_CLASS_BULKY
	icon = 'icons/obj/weapons/guns/mecha_ammo.dmi'
	icon_state = "empty"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	var/rounds = 0
	var/direct_load //For weapons where we re-load the weapon itself rather than adding to the ammo storage.
	var/load_audio = 'sound/items/weapons/gun/general/mag_bullet_insert.ogg'
	var/ammo_type
	/// whether to qdel this mecha_ammo when it becomes empty
	var/qdel_on_empty = FALSE

/obj/item/mecha_ammo/update_name()
	. = ..()
	name = "[rounds ? null : "empty "][initial(name)]"

/obj/item/mecha_ammo/update_desc()
	. = ..()
	desc = rounds ? initial(desc) : "Uma caixa de ammuniton de exossuit que foi esvaziada desde então. Pode ser dobrado para reciclagem."

/obj/item/mecha_ammo/update_icon_state()
	icon_state = rounds ? initial(icon_state) : "[initial(icon_state)]_e"
	return ..()

/obj/item/mecha_ammo/attack_self(mob/user)
	..()
	if(rounds)
		to_chat(user, span_warning("Você não pode achatar a caixa de munição até que esteja vazia!"))
		return

	to_chat(user, span_notice("Você dobra [src] Plano."))
	var/trash = new /obj/item/stack/sheet/iron(user.loc)
	qdel(src)
	user.put_in_hands(trash)

/obj/item/mecha_ammo/examine(mob/user)
	. = ..()
	if(rounds)
		. += "There [rounds > 1?"are":"is"] [rounds] [ammo_type][rounds > 1?"s":""] left."
	else
		. += span_notice("Use na mão para dobrar em uma folha de ferro.")

/obj/item/mecha_ammo/incendiary
	name = "incendiary ammo box"
	desc = "Uma caixa de munição incendiária para uso com armas de exosuit."
	icon_state = "incendiary"
	custom_materials = list(/datum/material/iron= SHEET_MATERIAL_AMOUNT*3)
	rounds = 24
	ammo_type = MECHA_AMMO_INCENDIARY

/obj/item/mecha_ammo/scattershot
	name = "scattershot ammo box"
	desc = "Uma caixa de chumbo escalonado, para uso em espingardas de exosuit."
	icon_state = "scattershot"
	custom_materials = list(/datum/material/iron= SHEET_MATERIAL_AMOUNT*3)
	rounds = 40
	ammo_type = MECHA_AMMO_BUCKSHOT

/obj/item/mecha_ammo/lmg
	name = "machine gun ammo box"
	desc = "Uma caixa de munição ligada, projetada para a arma de exossuit Ultra AC 2."
	icon_state = "lmg"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2)
	rounds = 300
	ammo_type = MECHA_AMMO_LMG

/// Missile Ammo
/// SRM-8 Missile type - Used by Nuclear Operatives
/obj/item/mecha_ammo/missiles_srm
	name = "short range missiles"
	desc = "Uma caixa de mísseis grandes, prontos para carregar em um rack de mísseis SRM-8."
	icon_state = "missile_he"
	rounds = 8
	direct_load = TRUE
	load_audio = 'sound/items/weapons/gun/general/mag_bullet_insert.ogg'
	ammo_type = MECHA_AMMO_MISSILE_SRM

/// PEP-6 Missile type - Used by Robotics
/obj/item/mecha_ammo/missiles_pep
	name = "precision explosive missiles"
	desc = "Uma caixa de mísseis grandes, prontos para carregar em um rack de mísseis de exosuit PEP-6."
	icon_state = "missile_br"
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*4,/datum/material/gold=SMALL_MATERIAL_AMOUNT*5)
	rounds = 6
	direct_load = TRUE
	load_audio = 'sound/items/weapons/gun/general/mag_bullet_insert.ogg'
	ammo_type = MECHA_AMMO_MISSILE_PEP

/obj/item/mecha_ammo/flashbang
	name = "launchable flashbangs"
	desc = "Uma caixa de flashbangs suaves, para uso com um grande lançador de exosuits. Não pode ser preparado à mão."
	icon_state = "flashbang"
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*2,/datum/material/gold=SMALL_MATERIAL_AMOUNT*5)
	rounds = 6
	ammo_type = MECHA_AMMO_FLASHBANG

/obj/item/mecha_ammo/clusterbang
	name = "launchable flashbang clusters"
	desc = "Uma caixa de flashbangs agrupados, para uso com um lançador de cluster de exosuit especializado. Não pode ser preparado à mão."
	icon_state = "clusterbang"
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*3,/datum/material/gold=HALF_SHEET_MATERIAL_AMOUNT * 1.5,/datum/material/uranium=HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	rounds = 3
	direct_load = TRUE
	ammo_type = MECHA_AMMO_CLUSTERBANG
