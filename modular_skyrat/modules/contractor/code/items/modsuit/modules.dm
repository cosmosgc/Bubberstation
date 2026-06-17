/obj/item/mod/module/baton_holster
	name = "MOD baton holster module"
	desc = "Um módulo instalado no peito de um MODSuit, isso permite que você\
para recuperar um bastão inserido do terno à vontade. Insira um bastão\
Batendo no módulo, enquanto é removido do terno, com o bastão."
	icon_state = "holster"
	icon = 'modular_skyrat/modules/contractor/icons/modsuit_modules.dmi'
	module_type = MODULE_ACTIVE
	complexity = 3
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	device = /obj/item/melee/baton/telescopic/contractor_baton
	incompatible_modules = list(/obj/item/mod/module/baton_holster)
	cooldown_time = 0.5 SECONDS
	allow_flags = MODULE_ALLOW_INACTIVE
	required_slots = list(ITEM_SLOT_GLOVES)
	/// Have they sacrificed a baton to actually be able to use this?
	var/eaten_baton = FALSE

/obj/item/mod/module/baton_holster/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()
	if(!istype(attacking_item, /obj/item/melee/baton/telescopic/contractor_baton) || eaten_baton)
		return
	balloon_alert(user, "[attacking_item] inserted")
	eaten_baton = TRUE
	for(var/obj/item/melee/baton/telescopic/contractor_baton/device_baton as anything in src)
		for(var/obj/item/baton_upgrade/original_upgrade in attacking_item)
			var/obj/item/baton_upgrade/new_upgrade = new original_upgrade.type(device_baton)
			device_baton.add_upgrade(new_upgrade)
		for(var/obj/item/restraints/handcuffs/cable/baton_cuffs in attacking_item)
			baton_cuffs.forceMove(device_baton)
	qdel(attacking_item)

/obj/item/mod/module/baton_holster/on_activation()
	if(!eaten_baton)
		balloon_alert(mod.wearer, "Nenhum bastão inserido.")
		return
	return ..()

/obj/item/mod/module/baton_holster/preloaded
	eaten_baton = TRUE
	device = /obj/item/melee/baton/telescopic/contractor_baton

/obj/item/mod/module/baton_holster/preloaded/upgraded
	device = /obj/item/melee/baton/telescopic/contractor_baton/upgraded

/obj/item/mod/module/chameleon/contractor // zero complexity module to match pre-TGification
	complexity = 0

/obj/item/mod/module/springlock/contractor
	name = "MOD magnetic deployment module"
	desc = "Uma versão muito mais moderna de um sistema Springlock.\
Este é um módulo que usa ímãs para acelerar o tempo de implantação e retração do seu MODsuit."
	icon_state = "magnet"
	icon = 'modular_skyrat/modules/contractor/icons/modsuit_modules.dmi'

/obj/item/mod/module/springlock/contractor/on_part_activation() // This module is actually *not* a death trap
	return

/obj/item/mod/module/springlock/contractor/on_part_deactivation(deleting = FALSE)
	return

/// This exists for the adminbus contractor modsuit. Do not use otherwise
/obj/item/mod/module/springlock/contractor/no_complexity
	complexity = 0

/obj/item/mod/module/scorpion_hook
	name = "MOD SCORPION hook module"
	desc = "Um módulo instalado no pulso de um MODSuit, este altamente\
O módulo ilegal usa um gancho para puxar com força.\
Um alvo para você em alta velocidade, derrubá-los e\
parcialmente esgotando-os."
	icon_state = "hook"
	icon = 'modular_skyrat/modules/contractor/icons/modsuit_modules.dmi'
	incompatible_modules = list(/obj/item/mod/module/scorpion_hook)
	module_type = MODULE_ACTIVE
	complexity = 3
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	device = /obj/item/gun/magic/hook/contractor
	cooldown_time = 0.5 SECONDS
	required_slots = list(ITEM_SLOT_GLOVES)
