/obj/item/borg/upgrade/transform/ntjack
	name = "borg module picker (Centcom)"
	desc = "Permite transformar um cyborg em um cyborg experimental."
	icon_state = "module_illegal"
	new_model = /obj/item/robot_model/centcom

/obj/item/borg/upgrade/transform/ntjack/action(mob/living/silicon/robot/cyborg, user = usr)
	return ..()

/obj/item/borg/upgrade/transform/security
	name = "borg model picker (Security)"
	desc = "Permite que você transforme um cyborg em um modelo de segurança."
	icon_state = "module_security"
	new_model = /obj/item/robot_model/security

//Research borg upgrades

//ADVANCED ROBOTICS REPAIR
/obj/item/borg/upgrade/healthanalyzer
	name = "Research cyborg advanced Health Analyzer"
	desc = "Uma atualização para o analisador de saúde padrão do cyborg."
	icon_state = "module_medical"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH
	items_to_add = list(/obj/item/healthanalyzer/advanced)
	items_to_remove = list(/obj/item/healthanalyzer)


//Science inducer
/obj/item/borg/upgrade/inducer_sci
	name = "Research integrated power inducer"
	desc = "Um indutor integrado que pode carregar a célula interna de um dispositivo da energia fornecida pelo cyborg."
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH
	items_to_add = list(/obj/item/inducer/cyborg/sci)

//Bluespace RPED
/obj/item/borg/upgrade/brped
	name = "Research cyborg Rapid Part Exchange Device Upgrade"
	desc = "Uma atualização para o modelo de pesquisa cyborg padrão RPED."
	icon_state = "module_engineer"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH
	items_to_add = list(/obj/item/storage/part_replacer/bluespace)
	items_to_remove = list(/obj/item/storage/part_replacer)

// Drapes upgrades
/obj/item/borg/upgrade/processor/Initialize(mapload)
	. = ..()
	model_type += /obj/item/robot_model/sci
	model_flags += BORG_MODEL_RESEARCH

// Engineering BRPED
/obj/item/borg/upgrade/rped/Initialize(mapload)
	. = ..()
	items_to_add = list(/obj/item/storage/part_replacer/bluespace)
	items_to_add -= list(/obj/item/storage/part_replacer)

//Upgrade for the experi scanner
/obj/item/borg/upgrade/experi_scanner
	name = "Research cyborg BlueSpace Experi-Scanner"
	desc = "Uma atualização para o analisador de saúde padrão do cyborg."
	icon_state = "module_general"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH
	items_to_add = list(/obj/item/experi_scanner/bluespace)
	items_to_remove = list(/obj/item/experi_scanner)

// Borg Dom Aura :)
/obj/item/borg/upgrade/dominatrixmodule/action(mob/living/silicon/robot/borg, mob/living/user)
	if(borg.hasToys)
		to_chat(usr, span_warning("Esta unidade já tem um módulo 'recreativo' instalado!"))
		return FALSE
	. = ..()
	if(.)
		borg.hasToys = TRUE
		borg.add_quirk(/datum/quirk/dominant_aura)

/obj/item/borg/upgrade/dominatrixmodule/deactivate(mob/living/silicon/robot/borg, mob/living/user)
	. = ..()
	if(.)
		if(borg.hasToys)
			borg.hasToys = FALSE
		borg.remove_quirk(/datum/quirk/dominant_aura)

// Engineering RLD
/obj/item/borg/upgrade/rld
	name = "Engineering Cyborg Rapid Lighting Device Upgrade"
	desc = "Uma atualização para permitir que um cyborg use um dispositivo de iluminação rápida."
	icon_state = "module_engineer"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/engineering, /obj/item/robot_model/janitor)
	model_flags = list(BORG_MODEL_ENGINEERING, BORG_MODEL_JANITOR)
	items_to_add = list(/obj/item/construction/rld/cyborg)

// Borg Advanced Xenoarchaeology Bag

/obj/item/borg/upgrade/xenoarch/adv
	name = "Cyborg Advanced Xenoarchaeology Bag"
	desc = "Um saco melhorado para pegar pedras estranhas para a ciência."
	icon_state = "module_general"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner, /obj/item/robot_model/sci)
	model_flags = list(BORG_MODEL_MINER, BORG_MODEL_RESEARCH)
	items_to_add = list(/obj/item/storage/bag/xenoarch/adv)


// Mining Borg Vent Pinpointer

/obj/item/borg/upgrade/pinpointer/vent
	name = "Vent Pinpointer"
	desc = "Um dispositivo de rastreamento modularizado. Vai localizar e apontar para as saídas próximas."
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/pinpointer/vent)

//Borg Proto-Kinetic Accelerators

/obj/item/borg/upgrade/modkit/action(mob/living/silicon/robot/mining_mods)
	. = ..()
	if (.)
		for(var/obj/item/gun/energy/recharge/kinetic_accelerator/pkamods in mining_mods.model.modules)
			return install(pkamods, usr, FALSE)

/obj/item/gun/energy/recharge/kinetic_accelerator/railgun/cyborg
	desc = "Acelerador de partículas portátil. Só utilizável em lavaland."
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/recharge/kinetic_accelerator/repeater/cyborg
	desc = "Um PKA com uma revista de três tiros"
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/recharge/kinetic_accelerator/shotgun/cyborg
	desc = "Um PKA que dispara três tiros com uma refrigeração mais longa."
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/recharge/kinetic_accelerator/glock/cyborg
	desc = "Um Snub Nosed PKA com mais capacidade de modo mas menos danos e alcance."
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/recharge/kinetic_accelerator/shockwave/cyborg
	desc = "Cria uma onda de choque em torno do usuário, com o mesmo poder da base PKA."
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/recharge/kinetic_accelerator/m79/cyborg
	desc = "Dispara as mesmas bombas usadas pelo modsuit de mineração. Só utilizável em lavaland."
	holds_charge = TRUE
	unique_frequency = TRUE

// Mining Borg PKA Upgrades

/obj/item/borg/upgrade/kinetic_accelerator/railgun/cyborg
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/railgun::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/railgun::desc
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/railgun/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator)

/obj/item/borg/upgrade/kinetic_accelerator/repeater/cyborg
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/repeater::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/repeater::desc
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/repeater/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator)

/obj/item/borg/upgrade/kinetic_accelerator/shotgun/cyborg
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/shotgun::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/shotgun::desc
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/shotgun/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator)

/obj/item/borg/upgrade/kinetic_accelerator/glock/cyborg
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/glock::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/glock::desc
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/glock/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator)

/obj/item/borg/upgrade/kinetic_accelerator/shockwave/cyborg
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/shockwave::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/shockwave::desc
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/shockwave/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator)

/obj/item/borg/upgrade/kinetic_accelerator/m79/cyborg
	name = /obj/item/gun/energy/recharge/kinetic_accelerator/m79::name
	desc = /obj/item/gun/energy/recharge/kinetic_accelerator/m79::desc
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER
	items_to_add = list(/obj/item/gun/energy/recharge/kinetic_accelerator/m79/cyborg)
	items_to_remove = list(/obj/item/gun/energy/recharge/kinetic_accelerator)

/// "Good Borg" Obedience Training
/mob/living/silicon/robot
	var/hasToys = FALSE

/obj/item/borg/upgrade/obediencemodule
	name = "Cyborg Obedience Module"
	desc = "Um módulo que melhora muito a habilidade dos borgs em demonstrar afeto."
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_lust"
	custom_price = 0

	items_to_add = list(/obj/item/kinky_shocker,
						/obj/item/clothing/mask/leatherwhip,
						/obj/item/spanking_pad,
						/obj/item/tickle_feather,
						/obj/item/clothing/erp_leash,
						)

// WellTrained Obedience Behaviour
/obj/item/borg/upgrade/obediencemodule/action(mob/living/silicon/robot/borg, mob/living/user)
	if(borg.hasToys)
		to_chat(usr, span_warning("Esta unidade já tem um módulo 'recreativo' instalado!"))
		return FALSE
	. = ..()
	if(.)
		borg.hasToys = TRUE
		borg.add_quirk(/datum/quirk/well_trained)

/obj/item/borg/upgrade/obediencemodule/deactivate(mob/living/silicon/robot/borg, mob/living/user)
	. = ..()
	if(.)
		if(borg.hasToys)
			borg.hasToys = FALSE

		borg.remove_quirk(/datum/quirk/well_trained)

/obj/item/borg/upgrade/detailer
	name = "janitor detailing toolset"
	desc = "Melhora as capacidades de tiling de um zelador cyborgs enquanto adiciona a habilidade de modificar decalques de piso."
	icon_state = "module_janitor"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/janitor)
	model_flags = BORG_MODEL_JANITOR

	items_to_add = list(/obj/item/construction/rtd/borg,
						/obj/item/airlock_painter/decal/cyborg,
						)

/obj/item/borg/upgrade/cyborg_cable_coil
	name = "integrated cable coil"
	desc = "A tecnologia condensada permite a tecnologia de cabeamento em módulos de limpeza."
	icon_state = "module_janitor"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/janitor)
	model_flags = BORG_MODEL_JANITOR

	items_to_add = list (/obj/item/stack/cable_coil)

//Research cyborg RCD

/obj/item/borg/upgrade/robotics_rcd
	name = "Research cyborg synthetic repair tool"
	desc = "Um RCD reduzido projetado para ajudar em reparos sintéticos."
	require_model = TRUE
	model_type = list(/obj/item/robot_model/sci)
	model_flags = BORG_MODEL_RESEARCH
	items_to_add = list(/obj/item/construction/rcd/borg/robotics_rcd)
