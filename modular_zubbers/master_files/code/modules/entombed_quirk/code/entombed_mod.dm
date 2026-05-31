/datum/mod_theme/entombed
	name = "fused"
	desc = "Circunstâncias transformaram esse traje protetor na segunda pele de alguém. Literalmente."
	extended_desc = "Algum grande aspecto do passado de alguém os amarrou permanentemente a este dispositivo, para melhor ou pior."

	default_skin = "standard"
	armor_type = /datum/armor/mod_theme_civilian
	resistance_flags = FIRE_PROOF | ACID_PROOF // It is better to die for the Emperor than live for yourself.
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	complexity_max = DEFAULT_MAX_COMPLEXITY - 2 // Sets the modsuit complexity to a total of 13 (functionally 10 as the default storage module consumes 3. ) to keep it in line with the civilian modsuit.
	charge_drain = DEFAULT_CHARGE_DRAIN
	slowdown_deployed = 0.95
	inbuilt_modules = list(
		/obj/item/mod/module/joint_torsion/entombed
	)
	allowed_suit_storage = list(
		/obj/item/tank/internals,
		/obj/item/flashlight,
	)

/obj/item/mod/module/joint_torsion/entombed
	name = "internal joint torsion adaptation"
	desc = "Sua adaptação à vida nesta concha MODsuit permite que você deambule de tal forma que seus movimentos recarreguem as baterias internas do terno ligeiramente, mas apenas enquanto sob o efeito da gravidade."
	removable = FALSE
	complexity = 0
	power_per_step = DEFAULT_CHARGE_DRAIN * 0.4

/obj/item/mod/module/plasma_stabilizer/entombed
	name = "colony-stabilized interior seal"
	desc = "Sua colônia integrou completamente os segmentos internos da placa de seu terno em seu esqueleto, formando um selo hermético entre você e o mundo exterior do qual nenhuma de sua atmosfera pode escapar. Isso é suficiente para permitir que sua cabeça veja o mundo com seu capacete retraído."
	complexity = 0
	idle_power_cost = 0
	removable = FALSE

/obj/item/mod/control/pre_equipped/entombed
	theme = /datum/mod_theme/entombed
	applied_cell = /obj/item/stock_parts/power_store/cell/high
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity
	)

// CUSTOM BEHAVIOR

/obj/item/mod/control/pre_equipped/entombed/canStrip(mob/who)
	return TRUE //you can always try, and it'll hit doStrip below

/obj/item/mod/control/pre_equipped/entombed/doStrip(mob/who)
	// attempt to handle custom stripping behavior - if we have a storage module of some kind
	var/obj/item/mod/module/storage/inventory = locate() in src.modules
	if (!isnull(inventory))
		src.atom_storage.remove_all()
		to_chat(who, span_notice("Você esvazia todos os itens do módulo de armazenamento do MODsuit!"))
		who.balloon_alert(who, "Esvaziou itens de armamento MOD!")
		return TRUE

	to_chat(who, span_warning("A roupa parece permanentemente fundida ao quadro. Não pode removê-lo!"))
	who.balloon_alert(who, "Não posso tirar um traje fundido!")
	return ..()

/obj/item/mod/control/pre_equipped/entombed/retract(mob/user, obj/item/part, instant = FALSE)
	if (ishuman(user))
		var/mob/living/carbon/human/human_user = user
		var/datum/quirk/equipping/entombed/tomb_quirk = human_user.get_quirk(/datum/quirk/equipping/entombed)
		//check to make sure we're not retracting something we shouldn't be able to
		if (tomb_quirk && tomb_quirk.deploy_locked)
			if (istype(part, /obj/item/clothing)) // make sure it's a modsuit piece and not a module, we retract those too
				if (!istype(part, /obj/item/clothing/head/mod)) // they can only retract the helmet, them's the sticks
					human_user.balloon_alert(human_user, "A parte está fundida para você - não pode se retrair!")
					playsound(src, 'sound/machines/scanner/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
					return
	return ..()

/obj/item/mod/control/pre_equipped/entombed/quick_deploy(mob/user)
	if (ishuman(user))
		var/mob/living/carbon/human/human_user = user
		var/datum/quirk/equipping/entombed/tomb_quirk = human_user.get_quirk(/datum/quirk/equipping/entombed)
		//if we're deploy_locked, just disable this functionality entirely
		if (tomb_quirk && tomb_quirk.deploy_locked)
			human_user.balloon_alert(human_user, "Você só pode retirar seu capacete, e apenas manualmente!")
			playsound(src, 'sound/machines/scanner/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
			return
	return ..()

/obj/item/mod/control/pre_equipped/entombed/Initialize(mapload, new_theme, new_skin, new_core)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, QUIRK_TRAIT)

/obj/item/mod/control/pre_equipped/entombed/dropped(mob/user)
	. = ..()
	// we do this so that in the rare event that someone gets gibbed/destroyed, their suit can be retrieved easily w/o requiring admin intervention
	REMOVE_TRAIT(src, TRAIT_NODROP, QUIRK_TRAIT)
