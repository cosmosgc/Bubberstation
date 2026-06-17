// .35 Sol pistol

/obj/item/gun/ballistic/automatic/pistol/sol
	name = "\improper Wespe Pistol"
	desc = "A pistola de serviço padrão dos vários ramos militares de Terragov. Usa .35 Sol e vem com uma luz anexa."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/trappiste_fabriek/guns32x.dmi'
	icon_state = "wespe"

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/pistol_light.ogg'

	w_class = WEIGHT_CLASS_NORMAL

	accepted_magazine_type = /obj/item/ammo_box/magazine/c35sol_pistol
	special_mags = TRUE

	suppressor_x_offset = 7
	suppressor_y_offset = 0

	fire_delay = 0.3 SECONDS

/obj/item/gun/ballistic/automatic/pistol/sol/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_TRAPPISTE)

/obj/item/gun/ballistic/automatic/pistol/sol/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		starting_light = new /obj/item/flashlight/seclite(src), \
		is_light_removable = FALSE, \
		)

/obj/item/gun/ballistic/automatic/pistol/sol/examine(mob/user)
	. = ..()
	. += span_notice("Você pode.<b>Examine mais perto.</b>para aprender um pouco mais sobre esta arma.")

/obj/item/gun/ballistic/automatic/pistol/sol/examine_more(mob/user)
	. = ..()

	. += "The Wespe is a pistol that was made entirely for military use. \
		Required to use a standard round, standard magazines, and be able \
		to function in all of the environments that TerraGov operated in \
		commonly. These qualities just so happened to make the weapon \
		popular in frontier space and is likely why you are looking at \
		one now."

	return .

/obj/item/gun/ballistic/automatic/pistol/sol/no_mag
	spawnwithmagazine = FALSE

// Sol pistol evil gun

/obj/item/gun/ballistic/automatic/pistol/sol/evil
	desc = "A pistola de serviço padrão dos vários ramos militares de Terragov. Vem com luz presa. Este é pintado de preto."

	icon_state = "wespe_evil"

/obj/item/gun/ballistic/automatic/pistol/sol/evil/no_mag
	spawnwithmagazine = FALSE

// Trappiste high caliber pistol in .585

/obj/item/gun/ballistic/automatic/pistol/trappiste
	name = "\improper Skild Pistol"
	desc = "É um pouco raro ver a pistola Trappiste disparando o calibre .585 desenvolvido pela mesma empresa.\
Vê uso raro principalmente devido à sua tendência a causar desconforto grave no pulso."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/trappiste_fabriek/guns32x.dmi'
	icon_state = "skild"

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/pistol_heavy.ogg'
	suppressed_sound = 'modular_skyrat/modules/modular_weapons/sounds/suppressed_heavy.ogg'

	w_class = WEIGHT_CLASS_NORMAL

	accepted_magazine_type = /obj/item/ammo_box/magazine/c585trappiste_pistol

	suppressor_x_offset = 8
	suppressor_y_offset = 0

	fire_delay = 1 SECONDS

	recoil = 3

/obj/item/gun/ballistic/automatic/pistol/trappiste/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_TRAPPISTE)

/obj/item/gun/ballistic/automatic/pistol/sol/examine(mob/user)
	. = ..()
	. += span_notice("Você pode.<b>Examine mais perto.</b>para aprender um pouco mais sobre esta arma.")

/obj/item/gun/ballistic/automatic/pistol/trappiste/examine_more(mob/user)
	. = ..()

	. += "The Skild only exists due to a widely known event that TerraGov's military \
		would prefer wasn't anywhere near as popular. A general, name unknown as of now, \
		was recorded complaining about the lack of capability the Wespe provided to the \
		military, alongside several statements comparing the Wespe's lack of masculinity \
		to the, quote, 'unique lack of testosterone those NRI mongrels field'. While the \
		identities of both the general and people responsible for the leaking of the recording \
		are still classified, many high ranking TerraGov military staff suspiciously have stopped \
		appearing in public, unlike the Skild. A lot of several thousand pistols, the first \
		of the weapons to ever exist, were not so silently shipped to TerraGov's Plutonian \
		shipping hub from TRAPPIST. TerraGov military command refuses to answer any \
		further questions about the incident to this day."

	return .

/obj/item/gun/ballistic/automatic/pistol/trappiste/no_mag
	spawnwithmagazine = FALSE
