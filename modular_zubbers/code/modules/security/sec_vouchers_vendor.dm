
/obj/item/security_voucher
	name = "security voucher"
	desc = "Um símbolo para resgatar um equipamento."
	icon = 'modular_zubbers/icons/obj/security_voucher.dmi'
	icon_state = "security_voucher_primary"
	w_class = WEIGHT_CLASS_TINY

/obj/item/security_voucher/examine(mob/user)
	. = ..()

	. += span_notice("You can redeem it at a [EXAMINE_HINT("security equipment vendor")] or [EXAMINE_HINT("any lathe")].")

/obj/item/security_voucher/primary
	name = "security primary voucher"
	icon_state = "security_voucher_primary"

/obj/item/security_voucher/utility
	name = "security utility voucher"
	icon_state = "security_voucher_utility"

/obj/machinery/vending/security/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/voucher_redeemer, /obj/item/security_voucher/primary, /datum/voucher_set/security/primary)
	AddElement(/datum/element/voucher_redeemer, /obj/item/security_voucher/utility, /datum/voucher_set/security/utility)

/obj/machinery/rnd/production/techfab/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/voucher_redeemer, /obj/item/security_voucher/primary, /datum/voucher_set/security/primary)
	AddElement(/datum/element/voucher_redeemer, /obj/item/security_voucher/utility, /datum/voucher_set/security/utility)

/obj/machinery/rnd/production/protolathe/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/voucher_redeemer, /obj/item/security_voucher/primary, /datum/voucher_set/security/primary)
	AddElement(/datum/element/voucher_redeemer, /obj/item/security_voucher/utility, /datum/voucher_set/security/utility)

/datum/voucher_set/security
	blackbox_key = "security_voucher_redeemed"

/datum/voucher_set/security/primary

/datum/voucher_set/security/utility

/datum/voucher_set/security/primary/disabler
	name = "Disabler"
	description = "A arma de energia padrão das forças de segurança Nanotrasen. Vem com o próprio coldre."
	icon = 'icons/obj/weapons/guns/energy.dmi'
	icon_state = "disabler"
	set_items = list(
		/obj/item/storage/belt/holster/energy/disabler,
		)

/datum/voucher_set/security/primary/advanced_taser
	name = "Hybrid Taser"
	description = "Um taser de modo duplo projetado para disparar eletrodos de alta potência de curto alcance e feixes desativadores de longo alcance."
	icon = 'icons/obj/weapons/guns/energy.dmi'
	icon_state = "advtaser"
	set_items = list(
		/obj/item/gun/energy/e_gun/advtaser,
		)

/datum/voucher_set/security/primary/disabler_smg
	name = "Pepperball AGH"
	description = "Uma arma de fogo mais lenta que dispara \"pepperballs\", que facilmente lança alvos para o chão."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/pepperball/pepperball.dmi'
	icon_state = "peppergun"
	set_items = list(
		/obj/item/gun/ballistic/automatic/pistol/pepperball,
		/obj/item/ammo_box/magazine/pepperball
		)

/datum/voucher_set/security/primary/strobe_shield
	name = "Strobe Shield"
	description = "Um escudo com uma luz de alta intensidade capaz de cegar e desorientar suspeitos. Leva flashes de mão regulares como lâmpadas."
	icon = 'icons/obj/weapons/shields.dmi'
	icon_state = "flashshield"
	set_items = list(
		/obj/item/shield/riot/flash,
		)

/datum/voucher_set/security/primary/archery
	name = "Archery Kit"
	description = "Um arco poderoso, um manual de treinamento, e uma tremedeira com flechas não-menos-que-letais. Você ainda precisará pedir o livro da carga se quiser fazer flechas letais."
	icon = 'icons/obj/weapons/bows/bows.dmi'
	icon_state = "hardlightbow"
	set_items = list(
		/obj/item/gun/ballistic/bow/security,
		/obj/item/storage/bag/quiver/lesser/security,
		/obj/item/book/granter/crafting_recipe/fletching/nonlethal,
		/obj/item/hatchet,
	)

/obj/item/storage/bag/quiver/lesser/security
	name = "security quiver"
	desc = "Uma tremedeira leve e de baixa capacidade capaz de ser dobrada em bolsos, mas nada mais."
	slot_flags = ITEM_SLOT_LPOCKET|ITEM_SLOT_RPOCKET|ITEM_SLOT_BELT

/obj/item/storage/bag/quiver/lesser/security/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_casing/arrow/blunt = 7,
		/obj/item/ammo_casing/arrow/taser = 3
	)

	generate_items_inside(items_inside, src)

/obj/item/book/granter/crafting_recipe/fletching/nonlethal
	name = "Aim for the knees, not the eyes!"
	desc = "Um manual sobre como construir arcos e flechas sub-letais, como melhor usá-los... e como construir violinos?"
	crafting_recipe_types = list(
		/datum/crafting_recipe/shortbow,
		/datum/crafting_recipe/blunted_arrow,
		/datum/crafting_recipe/taser_arrow,
		/datum/crafting_recipe/violin,
	)
	uses = 1

/datum/voucher_set/security/primary/nt_usp
	name = "NT22-HCS 'Enforcer' Pistol"
	description = "Uma pequena pistola que usa tecnologia de luz dura para sintetizar balas. Devido à sua baixa potência, não tem muito uso além de cansar criminosos."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "ntusp_full"
	set_items = list(
		/obj/item/gun/ballistic/automatic/pistol/ntusp,
		/obj/item/ammo_box/magazine/recharge/ntusp,
		)

/datum/voucher_set/security/utility/sec_projector
	name = "Security Holobarrier Projector"
	description = "Um projetor holográfico que cria barreiras de segurança holográficas junto com algemas holográficas."
	icon = 'icons/obj/devices/tool.dmi'
	icon_state = "signmaker_sec"
	set_items = list(
		/obj/item/holosign_creator/security,
		)

/datum/voucher_set/security/utility/lawbook
	name = "Weighted Space Law Book"
	description = "Uma edição especial da Lei Espacial Nanotrasen. A cobertura de metal decorativo adiciona bastante... Cuidado com o balanço."
	icon = 'modular_zubbers/icons/obj/security_voucher.dmi'
	icon_state = "SpaceLawWeighted"
	set_items = list(
		/obj/item/book/manual/wiki/security_space_law/weighted,
		)

/datum/voucher_set/security/utility/donut_box
	name = "Box of Donuts"
	description = "Tantalizing..."
	icon = 'icons/obj/food/donuts.dmi'
	icon_state = "donutbox"
	set_items = list(
		/obj/item/storage/fancy/donut_box,
		/obj/item/reagent_containers/cup/glass/coffee,
		)

/datum/voucher_set/security/utility/barrier
	name = "Barrier Grenades"
	description = "Duas granadas de barreira."
	icon = 'icons/obj/weapons/grenade.dmi'
	icon_state = "wallbang"
	set_items = list(
		/obj/item/grenade/barrier,
		/obj/item/grenade/barrier,
		)

/datum/voucher_set/security/utility/stingbang
	name = "Stingbang Grenades"
	description = "Duas granadas."
	icon = 'icons/obj/weapons/grenade.dmi'
	icon_state = "timeg_locked"
	set_items = list(
		/obj/item/grenade/stingbang,
		/obj/item/grenade/stingbang,
		)

/datum/voucher_set/security/utility/justice_helmet
	name = "Helmet of Justice"
	description = "O crime teme o capacete da justiça."
	icon = 'icons/obj/clothing/head/helmet.dmi'
	icon_state = "justice"
	set_items = list(
		/obj/item/clothing/mask/gas/sechailer/swat,
		/obj/item/clothing/head/helmet/toggleable/justice,
		)

/datum/voucher_set/security/utility/pinpointer_pairs
	name = "Pinpointer Pair"
	description = "Um par de dispositivos de rastreamento que travam a outra metade do par."
	icon = 'icons/obj/devices/tracker.dmi'
	icon_state = "pinpointer"
	set_items = list(
		/obj/item/storage/box/pinpointer_pairs,
		)

/datum/voucher_set/security/utility/laptop
	name = "Security Laptop"
	description = "Um laptop pré-carregado com software de segurança."
	icon = 'icons/obj/devices/modular_laptop.dmi'
	icon_state = "laptop-closed"
	set_items = list(
		/obj/item/modular_computer/laptop/preset/security,
	)

/obj/item/modular_computer/laptop/preset/security
	starting_programs = list(
		/datum/computer_file/program/chatclient,
		/datum/computer_file/program/crew_manifest,
		/datum/computer_file/program/records/security,
		/datum/computer_file/program/secureye,
	)
