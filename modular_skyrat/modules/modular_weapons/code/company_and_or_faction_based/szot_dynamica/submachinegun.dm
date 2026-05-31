// Rapid firing submachinegun firing .27-54 Cesarzowa

/obj/item/gun/ballistic/automatic/miecz
	name = "\improper Miecz Submachine Gun"
	desc = "Um pequeno barril, mais compactado conversão do rifle 'Lanca' para disparar cartuchos calibre 27-54. Devido ao propósito pretendido da arma, e menor que o ideal desempenho variado do projétil, ele não tem nada mais do que visão de brilho básico em oposição ao alcance variado que os usuários Lanca podem estar acostumados."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_48.dmi'
	icon_state = "miecz"

	inhand_icon_state = "c20r"
	worn_icon_state = "gun"

	SET_BASE_PIXEL(-8, 0)

	special_mags = FALSE

	bolt_type = BOLT_TYPE_STANDARD

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE

	accepted_magazine_type = /obj/item/ammo_box/magazine/miecz

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/smg_light.ogg'
	can_suppress = TRUE
	suppressor_x_offset = 0
	suppressor_y_offset = 0

	burst_size = 1
	fire_delay = 0.2 SECONDS
	actions_types = list()

	spread = 5

/obj/item/gun/ballistic/automatic/miecz/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/miecz/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/automatic/miecz/examine(mob/user)
	. = ..()
	. += span_notice("Você pode.<b>Examine mais perto.</b>para aprender um pouco mais sobre esta arma.")

/obj/item/gun/ballistic/automatic/miecz/examine_more(mob/user)
	. = ..()

	. += "The Meicz is one of the newest weapons to come out of CIN member state hands and 		into the wild, typically the frontier. It was built alongside the round it fires, the 		.27-54 Cesarzawa pistol round. Based on the proven Lanca design, it seeks to bring that 		same reliable weapon design into the factor of a submachinegun. While it is significantly 		larger than many comparable weapons in TerraGov use, it more than makes up for it with ease 		of control and significant firerate."

	return .

/obj/item/gun/ballistic/automatic/miecz/no_mag
	spawnwithmagazine = FALSE
