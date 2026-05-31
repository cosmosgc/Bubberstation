/// Use this file to add UPGRADES to borgs, the standard items will go in the modular robot_items.dm

/*
*	ADVANCED MEDICAL CYBORG UPGRADES
*/

/// Advanced Surgery Tools
/obj/item/borg/upgrade/surgerytools
	name = "medical cyborg advanced surgery tools"
	desc = "Uma atualização para a cirurgia do cyborg modelo médico, substituindo ferramentas não avançadas por sua contraparte avançada."
	icon_state = "module_medical"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/medical)
	model_flags = BORG_MODEL_MEDICAL

	items_to_add = list(/obj/item/scalpel/advanced,
						/obj/item/retractor/advanced,
						/obj/item/cautery/advanced,
						/obj/item/blood_filter/advanced,
						/obj/item/healthanalyzer/advanced,
						)
	items_to_remove = list(
						/obj/item/borg/cyborg_omnitool/medical,
						/obj/item/borg/cyborg_omnitool/medical, // Twice because you get two
						/obj/item/blood_filter,
						/obj/item/healthanalyzer,
						)

/*
*	ADVANCED ENGINEERING CYBORG UPGRADES
*/

/// Advanced Materials
#define ENGINEERING_CYBORG_CHARGE_PER_STACK 1000

/datum/robot_energy_storage/plasteel
	name = "Plasteel Processor"
	recharge_rate = 0
	max_energy = ENGINEERING_CYBORG_CHARGE_PER_STACK * 50

/datum/robot_energy_storage/titanium
	name = "Titanium Processor"
	recharge_rate = 0
	max_energy = ENGINEERING_CYBORG_CHARGE_PER_STACK * 50

/obj/item/stack/sheet/plasteel/cyborg
	cost = ENGINEERING_CYBORG_CHARGE_PER_STACK
	is_cyborg = TRUE
	source = /datum/robot_energy_storage/plasteel

/obj/item/stack/sheet/titaniumglass/cyborg
	cost = ENGINEERING_CYBORG_CHARGE_PER_STACK
	is_cyborg = TRUE
	source = /datum/robot_energy_storage/titanium

#undef ENGINEERING_CYBORG_CHARGE_PER_STACK

/obj/item/borg/upgrade/advanced_materials
	name = "engineering advanced materials processor"
	desc = "permite a um cyborg sintetizar e armazenar materiais avançados"
	icon_state = "module_engineer"
	model_type = list(/obj/item/robot_model/engineering)
	model_flags = BORG_MODEL_ENGINEERING

	items_to_add = list(/obj/item/stack/sheet/plasteel/cyborg,
						/obj/item/stack/sheet/titaniumglass/cyborg,
						)

/obj/item/borg/upgrade/advanced_materials/deactivate(mob/living/silicon/robot/borg, mob/living/user)
	. = ..()
	for(var/datum/robot_energy_storage/plasteel/plasteel_energy in borg.model.storages)
		qdel(plasteel_energy)
	for(var/datum/robot_energy_storage/titanium/titanium_energy in borg.model.storages)
		qdel(titanium_energy)

/*
*	ADVANCED MINING CYBORG UPGRADES
*/

/// Welder
/obj/item/borg/upgrade/welder
	name = "mining cyborg welder upgrade"
	desc = "Um soldador normal com um tanque maior para ciborgues."
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER

	items_to_add = list(/obj/item/weldingtool/largetank/cyborg)

/*
*	ADVANCED CARGO CYBORG UPGRADES
*/
/datum/design/borg_upgrade_clamp
	name = "Improved Integrated Hydraulic Clamp Module"
	id = "borg_upgrade_clamp"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/better_clamp
	materials = list(
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_CARGO,
	)

/obj/item/borg/upgrade/better_clamp
	name = "improved integrated hydraulic clamp"
	desc = "Uma pinça hidráulica melhorada para permitir que pacotes maiores sejam pegos também!"
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_cargo"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/cargo)
	model_flags = BORG_MODEL_CARGO

	items_to_add = list(/obj/item/borg/hydraulic_clamp/better)

/datum/design/borg_upgrade_cargo_tele
	name = "Cargo teleporter module"
	id = "borg_upgrade_cargo_tele"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/cargo_tele
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/plastic = SMALL_MATERIAL_AMOUNT * 5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 5)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_CARGO
	)

/obj/item/borg/upgrade/cargo_tele
	name = "cargo teleporter module"
	desc = "Permite atualizar um cyborg de carga com o teletransportador."
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_cargo"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/cargo)
	model_flags = BORG_MODEL_CARGO

	items_to_add = list(/obj/item/cargo_teleporter)

/datum/design/borg_upgrade_forging
	name = "Forging module"
	id = "borg_upgrade_forging"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/forging
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 5)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_CARGO
	)

/obj/item/borg/upgrade/forging
	name = "cyborg forging module"
	desc = "Permite ativar um cyborg de carga com equipamento de forja"
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_cargo"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/cargo)
	model_flags = BORG_MODEL_CARGO

	items_to_add = list(/obj/item/forging/hammer,
						/obj/item/forging/billow,
						/obj/item/forging/tongs,
						/obj/item/borg/forging_setup,
						)

/*
* SERVICE CYBORG UPGRADES
*/

/datum/design/borg_upgrade_artistic
	name = "Artistic module"
	id = "borg_upgrade_artistic"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/artistic
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2,
					/datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_SERVICE
	)

/obj/item/borg/upgrade/artistic
	name = "borg artistic module"
	desc = "Permite atualizar um ciborgue com ferramentas para criar arte."
	icon_state = "module_general"
	items_to_add = list(
			/obj/item/pen,
			/obj/item/toy/crayon/spraycan/borg,
			/obj/item/instrument/guitar,
			/obj/item/instrument/piano_synth,
			/obj/item/stack/pipe_cleaner_coil/cyborg,
			/obj/item/chisel,
			)

/*
*	UNIVERSAL CYBORG UPGRADES
*/

/// ShapeShifter
/obj/item/borg/upgrade/borg_shapeshifter
	name = "cyborg shapeshifter module"
	desc = "Um dispositivo experimental que permite que um ciborgue se disfarce em outro tipo de ciborgue."
	icon_state = "module_general"

	items_to_add = list(/obj/item/borg_shapeshifter)

/// Quadborg time
/obj/item/borg/upgrade/affectionmodule
	name = "borg affection module"
	desc = "Um módulo que melhora a capacidade dos borgs de demonstrar afeição."
	icon_state = "module_peace"

	items_to_add = list(/obj/item/quadborg_tongue,
						/obj/item/quadborg_nose)

/obj/item/quadborg_tongue/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/mob/living/silicon/robot/borg = user
	var/mob/living/mob = interacting_with
	if(!istype(mob))
		return ITEM_INTERACT_BLOCKING
	if(HAS_TRAIT(interacting_with, TRAIT_AFFECTION_AVERSION)) // Checks for Affection Aversion trait
		to_chat(user, span_warning("ERRO:[interacting_with]está no registro Do Not Lick!"))
		return ITEM_INTERACT_BLOCKING
	if(check_zone(borg.zone_selected) == "head")
		borg.visible_message(span_warning("\the [borg]Afetivamente lambe\the [mob]Ó rosto!"), span_notice("Você amavelmente lambe\the [mob]Ó rosto!"))
	else
		borg.visible_message(span_warning("\the [borg]Afetivamente lambe\the [mob]!"), span_notice("Você amavelmente lambe\the [mob]!"))
	playsound(borg, 'sound/effects/blob/attackblob.ogg', 50, 1)
	return ITEM_INTERACT_SUCCESS

/obj/item/quadborg_nose/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(HAS_TRAIT(interacting_with, TRAIT_AFFECTION_AVERSION)) // Checks for Affection Aversion trait
		to_chat(user, span_warning("ERRO:[interacting_with]está no registro Sem Nosing!"))
		return ITEM_INTERACT_BLOCKING

	do_attack_animation(interacting_with, null, src)
	user.visible_message(span_notice("[user] [pick("nuzzles", "pushes", "boops")] \the [interacting_with.name]Com nariz!"))
	return ITEM_INTERACT_SUCCESS

/// The Shrinkening
/mob/living/silicon/robot
	var/hasShrunk = FALSE

// Added checks for borg models who come from the Zoolander Center for Borgs Who Can't Upgrade Good
/obj/item/borg/upgrade/expand/action(mob/living/silicon/robot/borg, mob/living/user = usr)
	if(TRAIT_R_EXPANDER_BLOCKED in borg.model.model_features)
		to_chat(usr, span_warning("Esta unidade é incapaz de equipar um módulo de expansão!"))
		return FALSE

	if(borg.model.type == /obj/item/robot_model)
		to_chat(usr, span_warning("Esta unidade ainda está na configuração padrão da fábrica!"))
		return FALSE

	return ..()

/obj/item/borg/upgrade/shrink
	name = "borg shrinker"
	desc = "Um cyborg resizer, faz um cyborg pequeno."
	icon_state = "module_general"

/obj/item/borg/upgrade/shrink/action(mob/living/silicon/robot/borg, user = usr)
	. = ..()
	if(!. || HAS_TRAIT(borg, TRAIT_NO_TRANSFORM))
		return FALSE

	if(borg.model.type == /obj/item/robot_model)
		to_chat(usr, span_warning("Esta unidade ainda está na configuração padrão da fábrica!"))
		return FALSE

	if(borg.hasShrunk)
		to_chat(usr, span_warning("Esta unidade já tem um módulo de psiquiatra instalado!"))
		return FALSE

	if(TRAIT_R_SMALL in borg.model.model_features)
		to_chat(usr, span_warning("O chassi desta unidade não pode ser encolhido mais."))
		return FALSE

	ADD_TRAIT(borg, TRAIT_NO_TRANSFORM, REF(src))
	var/prev_lockcharge = borg.lockcharge
	borg.SetLockdown(TRUE)
	borg.set_anchored(TRUE)
	do_smoke(4, src, loc, smoke_type = /datum/effect_system/fluid_spread/smoke)
	sleep(0.2 SECONDS)
	for(var/i in 1 to 4)
		playsound(borg, pick(
			'sound/items/tools/drill_use.ogg',
			'sound/items/tools/jaws_cut.ogg',
			'sound/items/tools/jaws_pry.ogg',
			'sound/items/tools/welder.ogg',
			'sound/items/tools/ratchet.ogg',
			), 80, TRUE, -1)
		sleep(1.2 SECONDS)
	if(!prev_lockcharge)
		borg.SetLockdown(FALSE)
	borg.set_anchored(FALSE)
	REMOVE_TRAIT(borg, TRAIT_NO_TRANSFORM, REF(src))
	borg.hasShrunk = TRUE
	borg.update_transform(0.75)

/obj/item/borg/upgrade/shrink/deactivate(mob/living/silicon/robot/borg, user = usr)
	. = ..()
	if (.)
		if (borg.hasShrunk)
			borg.hasShrunk = FALSE
			borg.update_transform(4/3)

/// Syndijack
/obj/item/borg/upgrade/transform/syndicatejack
	name = "borg module picker (Syndicate)"
	desc = "Permite transformar um ciborgue em um pecado experimental."
	icon_state = "module_illegal"
	new_model = /obj/item/robot_model/syndicatejack

/obj/item/borg/upgrade/transform/syndicatejack/action(mob/living/silicon/robot/cyborg, user = usr) // Only usable on emagged cyborgs. In exchange. makes you unable to get locked down or detonated.
	if(cyborg.emagged)
		return ..()

/// Dominatrix time
/obj/item/borg/upgrade/dominatrixmodule
	name = "borg dominatrix module"
	desc = "Um módulo que melhora muito a habilidade dos borgs em demonstrar afeto."
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "module_lust"
	custom_price = 0

	items_to_add = list(/obj/item/kinky_shocker,
						/obj/item/clothing/mask/leatherwhip,
						/obj/item/spanking_pad,
						/obj/item/tickle_feather,
						/obj/item/clothing/erp_leash,
						/obj/item/clicker
						)
