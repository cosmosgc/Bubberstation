// Resurrection crystal

/obj/item/resurrection_crystal
	name = "resurrection crystal"
	desc = "Quando usado por qualquer coisa segurando-o, este cristal lhes dá uma segunda chance de vida se eles morrerem."
	icon = 'icons/obj/mining.dmi'
	icon_state = "demonic_crystal"

/obj/item/resurrection_crystal/attack_self(mob/living/user)
	if(!iscarbon(user))
		to_chat(user, span_notice("Uma presença escura o impede de absorver o cristal."))
		return
	forceMove(user)
	to_chat(user, span_notice("Você se sente um pouco mais seguro... mas uma presença demoníaca espreita na parte de trás da sua cabeça..."))
	RegisterSignal(user, COMSIG_LIVING_DEATH, PROC_REF(resurrect))

/// Resurrects the target when they die by moving them and dusting a clone in their place, one life for another
/obj/item/resurrection_crystal/proc/resurrect(mob/living/carbon/user, gibbed)
	SIGNAL_HANDLER
	if(gibbed)
		to_chat(user, span_notice("Este poder não pode ser usado se todo o seu corpo mortal estiver desintegrado..."))
		return
	user.visible_message(span_notice("Viu?[user] A alma arrastada para fora de seu corpo!"), span_notice("Você sente sua alma arrastada para um corpo novo!"))
	var/typepath = user.type
	var/mob/living/carbon/clone = new typepath(user.loc)
	clone.real_name = user.real_name
	INVOKE_ASYNC(user.dna, TYPE_PROC_REF(/datum/dna, copy_dna), clone.dna, COPY_DNA_SE|COPY_DNA_SPECIES)
	clone.updateappearance(mutcolor_update=1)
	var/turf/T = find_maintenance_spawn(atmos_sensitive = TRUE, require_darkness = TRUE) || find_safe_turf()
	user.forceMove(T)
	user.revive(ADMIN_HEAL_ALL)
	INVOKE_ASYNC(user, TYPE_PROC_REF(/mob/living/carbon, set_species), /datum/species/shadow)
	to_chat(user, span_notice("Você pisca e se encontra em [get_area_name(T)]...sentido-se um pouco mais escuro."))
	clone.dust()
	qdel(src)

// Cursed boots

/obj/item/clothing/shoes/winterboots/ice_boots/ice_trail
	name = "cursed ice hiking boots"
	desc = "Um par de botas de inverno contratualmente feitas por um diabo, eles não podem ser tirados uma vez colocado."
	actions_types = list(/datum/action/item_action/toggle)
	var/on = FALSE
	var/change_turf = /turf/open/misc/ice/icemoon/no_planet_atmos
	var/duration = 6 SECONDS

/obj/item/clothing/shoes/winterboots/ice_boots/ice_trail/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_SHOES_STEP_ACTION, PROC_REF(on_step))

/obj/item/clothing/shoes/winterboots/ice_boots/ice_trail/equipped(mob/user, slot)
	. = ..()
	if(slot & ITEM_SLOT_FEET)
		ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT(type))

/obj/item/clothing/shoes/winterboots/ice_boots/ice_trail/dropped(mob/user)
	. = ..()
	// Could have been blown off in an explosion from the previous owner
	REMOVE_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT(type))

/obj/item/clothing/shoes/winterboots/ice_boots/ice_trail/ui_action_click(mob/user)
	on = !on
	to_chat(user, span_notice("Você.[on ? "activate" : "deactivate"] [src]."))

/obj/item/clothing/shoes/winterboots/ice_boots/ice_trail/examine(mob/user)
	. = ..()
	. += span_notice("Os sapatos são[on ? "enabled" : "disabled"].")

/obj/item/clothing/shoes/winterboots/ice_boots/ice_trail/proc/on_step()
	SIGNAL_HANDLER

	var/turf/T = get_turf(loc)
	if(!on || isclosedturf(T) || istype(T, change_turf))
		return
	var/reset_turf = T.type
	T.ChangeTurf(change_turf, flags = CHANGETURF_INHERIT_AIR)
	addtimer(CALLBACK(T, TYPE_PROC_REF(/turf, ChangeTurf), reset_turf, null, CHANGETURF_INHERIT_AIR), duration, TIMER_OVERRIDE|TIMER_UNIQUE)

// Demonic jackhammer

/obj/item/pickaxe/drill/jackhammer/demonic
	name = "demonic jackhammer"
	desc = "Quebra rochas a uma velocidade desumana, além de ser reforçada para fins de combate."
	toolspeed = 0

/obj/item/pickaxe/drill/jackhammer/demonic/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/knockback, 4, TRUE, FALSE)
	AddElement(/datum/element/lifesteal, 5)

/obj/item/pickaxe/drill/jackhammer/demonic/use_tool(atom/target, mob/living/user, delay, amount=0, volume=0, datum/callback/extra_checks)
	var/turf/T = get_turf(target)
	mineral_scan_pulse(T, world.view + 1, src)
	. = ..()

// Ice energy crystal

/obj/item/ice_energy_crystal
	name = "ice energy crystal"
	desc = "Remnantes dos mineiros de gelo demoníacos energia de gelo."
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "ice_crystal"
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
