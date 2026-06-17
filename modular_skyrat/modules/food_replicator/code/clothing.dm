/obj/item/clothing/under/colonial
	name = "colonial outfit"
	desc = "Camisa de cetim branca e calças de algodão com cinto de couro sintético preto."
	icon = 'modular_skyrat/modules/food_replicator/icons/clothing.dmi'
	worn_icon = 'modular_skyrat/modules/food_replicator/icons/clothing_worn.dmi'
	worn_icon_digi = 'modular_skyrat/modules/food_replicator/icons/clothing_digi.dmi'
	icon_state = "under_colonial"

/obj/item/clothing/under/colonial/mob_can_equip(mob/living/equipper, slot, disable_warning, bypass_equip_delay_self, ignore_equipped, indirect_action)
	if(is_species(equipper, /datum/species/teshari))
		to_chat(equipper, span_warning("[src] is far too big for you!"))
		return FALSE

	return ..()

/obj/item/clothing/shoes/jackboots/colonial
	name = "colonial half-boots"
	desc = "Boas botas sem renda, com um dedão de plástico resistente para, teoricamente, manter os dedos dos pés abertos."
	icon = 'modular_skyrat/modules/food_replicator/icons/clothing.dmi'
	worn_icon = 'modular_skyrat/modules/food_replicator/icons/clothing_worn.dmi'
	worn_icon_digi = 'modular_skyrat/modules/food_replicator/icons/clothing_digi.dmi'
	icon_state = "boots_colonial"

/obj/item/clothing/shoes/jackboots/colonial/mob_can_equip(mob/living/equipper, slot, disable_warning, bypass_equip_delay_self, ignore_equipped, indirect_action)
	if(is_species(equipper, /datum/species/teshari))
		to_chat(equipper, span_warning("[src] is far too big for you!"))
		return FALSE

	return ..()

/obj/item/clothing/neck/cloak/colonial
	name = "colonial cloak"
	desc = "Um manto feito de lona pesada. Vento próximo e à prova d'água graças ao seu design."
	slot_flags = ITEM_SLOT_OCLOTHING|ITEM_SLOT_NECK
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'modular_skyrat/modules/food_replicator/icons/clothing.dmi'
	worn_icon = 'modular_skyrat/modules/food_replicator/icons/clothing_worn.dmi'
	worn_icon_digi = 'modular_skyrat/modules/food_replicator/icons/clothing_digi.dmi'
	icon_state = "cloak_colonial"
	allowed = /obj/item/clothing/suit/jacket/leather::allowed // these are special and can be worn in the suit slot, so we need this var to be defined

/obj/item/clothing/neck/cloak/colonial/mob_can_equip(mob/living/equipper, slot, disable_warning, bypass_equip_delay_self, ignore_equipped, indirect_action)
	if(is_species(equipper, /datum/species/teshari))
		to_chat(equipper, span_warning("[src] is far too big for you!"))
		return FALSE

	return ..()

/obj/item/clothing/head/hats/colonial
	name = "colonial cap"
	desc = "Uma tampa de lona coberta por alguns tecidos. É resistente e confortável, e parece manter sua forma muito bem."
	icon = 'modular_skyrat/modules/food_replicator/icons/clothing.dmi'
	worn_icon = 'modular_skyrat/modules/food_replicator/icons/clothing_worn.dmi'
	worn_icon_digi = 'modular_skyrat/modules/food_replicator/icons/clothing_digi.dmi'
	icon_state = "cap_colonial"
	inhand_icon_state = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hats/colonial/mob_can_equip(mob/living/equipper, slot, disable_warning, bypass_equip_delay_self, ignore_equipped, indirect_action)
	if(is_species(equipper, /datum/species/teshari))
		to_chat(equipper, span_warning("[src] is far too big for you!"))
		return FALSE

	return ..()

/obj/item/clothing/accessory/colonial_webbing
	name = "slim colonial webbing vest"
	desc = "Um versátil equipamento de transporte, apreciado por colonos e colecionadores. Compacto o suficiente para ser usado sob roupas volumosas."
	icon = 'modular_skyrat/modules/food_replicator/icons/clothing.dmi'
	worn_icon = 'modular_skyrat/modules/food_replicator/icons/clothing_worn.dmi'
	icon_state = "accessory_webbing"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/clothing/accessory/colonial_webbing/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/colonial_webbing)

/obj/item/clothing/accessory/colonial_webbing/can_attach_accessory(obj/item/clothing/under/attach_to, mob/living/user)
	. = ..()
	if(!.)
		return

	if(!isnull(attach_to.atom_storage))
		if(user)
			attach_to.balloon_alert(user, "Não é compatível!")
		return FALSE
	return TRUE

/datum/storage/pockets/colonial_webbing
	do_rustle = TRUE
	max_slots = 3
	max_specific_storage = WEIGHT_CLASS_SMALL
