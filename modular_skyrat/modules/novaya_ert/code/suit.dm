#define NRI_POWERUSE_HIT 100
#define NRI_POWERUSE_HEAL 150

#define NRI_COOLDOWN_HEAL (10 SECONDS)
#define NRI_COOLDOWN_RADS (20 SECONDS)
#define NRI_COOLDOWN_ACID (20 SECONDS)

#define NRI_HEAL_AMOUNT 10
#define NRI_BLOOD_REPLENISHMENT 20

/obj/item/clothing/suit/space/hev_suit/nri
	name = "\improper VOSKHOD powered combat armor"
	desc = "Um conjunto híbrido de armaduras resistentes ao espaço construída sobre um traje de voo Nomex-Aerogel modificado, poliureia revestida com placas de plasteel de luz revestidas com fio de poliureia dificultam a mobilidade o mínimo possível enquanto o sistema de suporte de vida a bordo ajuda o usuário em combate. A célula de energia é o que faz a armadura funcionar sem problemas, um adesivo na unidade de fonte de energia avisa qualquer um lendo para controlar os níveis de bateria."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/spacesuit.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/spacesuit.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/spacesuit_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/suit.dmi'
	icon_state = "nri_soldier"
	armor_type = /datum/armor/hev_suit_nri
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDESEXTOY|HIDETAIL
	allowed = list(/obj/item/gun, /obj/item/ammo_box,/obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/energy/sword, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	cell = /obj/item/stock_parts/power_store/cell/bluespace
	actions_types = list(/datum/action/item_action/hev_toggle/nri, /datum/action/item_action/hev_toggle_notifs/nri, /datum/action/item_action/toggle_spacesuit)
	resistance_flags = FIRE_PROOF|UNACIDABLE|ACID_PROOF|FREEZE_PROOF
	clothing_flags = STOPSPRESSUREDAMAGE|SNUG_FIT
	clothing_traits = list(TRAIT_BRAWLING_KNOCKDOWN_BLOCKED)

	activation_song = null //No nice song.

	radio_channel = RADIO_CHANNEL_CENTCOM

	armor_unpowered = /datum/armor/hev_suit_nri
	armor_powered = /datum/armor/hev_suit_nri/powered
	heal_amount = NRI_HEAL_AMOUNT
	blood_replenishment = NRI_BLOOD_REPLENISHMENT
	health_static_cooldown = NRI_COOLDOWN_HEAL
	rads_static_cooldown = NRI_COOLDOWN_RADS
	acid_static_cooldown = NRI_COOLDOWN_ACID
	suit_name = "VOSKHOD"
	first_use = FALSE //No nice song.



/datum/armor/hev_suit_nri
	melee = 25
	bullet = 25
	laser = 25
	energy = 25
	bomb = 25
	bio = 25
	fire = 30
	acid = 30
	wound = 30
	consume = 10

/datum/armor/hev_suit_nri/powered
	melee = 40
	bullet = 50
	laser = 30
	energy = 40
	bomb = 60
	bio = 75
	fire = 50
	acid = 50
	wound = 50
	consume = 40

/datum/action/item_action/hev_toggle/nri
	name = "Toggle VOSKHOD Suit"
	button_icon = 'modular_skyrat/modules/novaya_ert/icons/toggles.dmi'
	button_icon_state = "system_off"
	background_icon = 'modular_skyrat/modules/novaya_ert/icons/toggles.dmi'
	background_icon_state = "bg_nri"

/datum/action/item_action/hev_toggle_notifs/nri
	name = "Toggle VOSKHOD Suit Notifications"
	button_icon = 'modular_skyrat/modules/novaya_ert/icons/toggles.dmi'
	button_icon_state = "sound_VOICE_AND_TEXT"
	background_icon = 'modular_skyrat/modules/novaya_ert/icons/toggles.dmi'
	background_icon_state = "bg_nri"

/obj/item/clothing/suit/space/hev_suit/nri/captain
	name = "\improper VOSKHOD-2 powered combat armor"
	desc = "Um conjunto híbrido único de armaduras resistentes ao espaço feita para agentes NRI de alto escalão, construído com um acolchoado de durathread proprietário, Akulan fez Larr'Takh uniforme utilitário de seda. Placas de plastitanio revestidas de poliureia com hexagrafeno dificultam a mobilidade o mínimo possível enquanto o sistema de suporte de vida a bordo ajuda o usuário em combate. A célula de energia é o que faz a armadura funcionar sem problemas, um adesivo na unidade de fonte de energia avisa qualquer um lendo para controlar os níveis de bateria."
	icon_state = "nri_captain"

/obj/item/clothing/suit/space/hev_suit/nri/medic
	name = "\improper VOSKHOD-KH powered combat armor"
	desc = "Um conjunto híbrido de armaduras resistentes ao espaço construída sobre um equipamento de campo de cirurgião Dipolyester-Aerogel modificado, placas de titânio revestidas de poliureia dificultam a mobilidade o mínimo possível enquanto o sistema de suporte de vida a bordo ajuda o usuário em combate e fornece funções médicas adicionais. A célula de energia é o que faz a armadura funcionar sem problemas, um adesivo na unidade de fonte de energia avisa qualquer um lendo para controlar os níveis de bateria."
	icon_state = "nri_medic"

/obj/item/clothing/suit/space/hev_suit/nri/engineer
	name = "\improper VOSKHOD-IN powered combat armor"
	desc = "Um conjunto híbrido de armaduras resistentes ao espaço construído sobre um equipamento de engenharia Nanotrasen modificado, placas de plasteel leve revestidas de poliureia dificultam a mobilidade o mínimo possível e oferecem proteção contra radiação adicional enquanto o sistema de suporte de vida a bordo ajuda o usuário em combate. A célula de energia é o que faz a armadura funcionar sem problemas, um adesivo na unidade de fonte de energia avisa qualquer um lendo para controlar os níveis de bateria."
	icon_state = "nri_engineer"

#undef NRI_POWERUSE_HIT
#undef NRI_POWERUSE_HEAL

#undef NRI_COOLDOWN_HEAL
#undef NRI_COOLDOWN_RADS
#undef NRI_COOLDOWN_ACID

#undef NRI_HEAL_AMOUNT
#undef NRI_BLOOD_REPLENISHMENT
