/// How much health super kitties have by default.
#define SUPER_KITTY_HEALTH 50
/// How much health syndicate super kitties have by default.
#define SYNDIE_SUPER_KITTY_HEALTH 80

//Super cats are specifically used for the kitty form spell but can be also spawned in at xenobio temporarily.
//Super cats stronger and faster than normal cats and far more agressive.
/mob/living/basic/pet/cat/super
	name = "Super Cat"
	desc = "Kitty! Este parece forte e Zangado!"
	health = SUPER_KITTY_HEALTH
	maxHealth = SUPER_KITTY_HEALTH
	speed = 0
	can_breed = FALSE
	gold_core_spawnable = HOSTILE_SPAWN
	melee_damage_lower = 7
	melee_damage_upper = 15
	ai_controller = /datum/ai_controller/basic_controller/simple/simple_hostile
	faction = list(FACTION_HOSTILE)


/mob/living/basic/pet/cat/super/Initialize(mapload)
	. = ..()
	add_traits(list(TRAIT_NOGUNS, TRAIT_NO_TWOHANDING), INNATE_TRAIT)
	AddElement(/datum/element/dextrous)
	AddComponent(/datum/component/personal_crafting)

/mob/living/basic/pet/cat/super/can_use_guns(obj/item/G)
	. = ..()
	if(HAS_TRAIT(src, TRAIT_NOGUNS)) // Who am I to stop admins from making them stronger?
		balloon_alert(src, "Suas patas são muito macias!")
		return FALSE

/mob/living/basic/pet/cat/super/move_into_vent(obj/machinery/atmospherics/components/ventcrawl_target)
	. = ..()
	drop_all_held_items()

/mob/living/basic/pet/cat/super/tux //Fake runtime
	name = "Super Tux Cat"
	desc = "GCA... Espere, algo está errado."
	gender = FEMALE
	icon_state = "cat"
	icon_living = "cat"
	icon_dead = "cat_dead"
	held_state = "cat"

/mob/living/basic/pet/cat/super/pancake
	name = "Super Pancake Cat"
	desc = "É um Super Gato feito de uma panqueca!"
	icon = 'modular_zubbers/icons/mob/simple/pets.dmi'
	icon_state = "pancake"
	icon_living = "pancake"
	icon_dead = "pancake_dead"
	gold_core_spawnable = NO_SPAWN

/mob/living/basic/pet/cat/super/original
	name = "Super Batsy"
	desc = "Produto de DNA alienígena e geneticistas entediados."
	gender = FEMALE
	icon_state = "original"
	icon_living = "original"
	icon_dead = "original_dead"
	held_state = "original"
	gold_core_spawnable = NO_SPAWN

/mob/living/basic/pet/cat/super/breadcat
	name = "Super Bread Cat"
	desc = "Eles são um gato... com um pão!"
	icon_state = "breadcat"
	icon_living = "breadcat"
	icon_dead = "breadcat_dead"
	held_state = "breadcat"
	can_interact_with_stove = TRUE
	gold_core_spawnable = NO_SPAWN

/mob/living/basic/pet/cat/cak/super //Special type
	name = "Super Keeki Cat"
	desc = "Ela é uma Super Gato feito de um bolo de bondade."
	speed = 0
	gold_core_spawnable = FRIENDLY_SPAWN
	faction = list(FACTION_CAT)

/mob/living/basic/pet/cat/cak/super/Initialize(mapload)
	. = ..()
	add_traits(list(TRAIT_PACIFISM, TRAIT_NO_TWOHANDING), INNATE_TRAIT) //Passive kitty bring kind meows
	AddElement(/datum/element/dextrous)
	AddComponent(/datum/component/personal_crafting)

/mob/living/basic/pet/cat/cak/move_into_vent(obj/machinery/atmospherics/components/ventcrawl_target)
	. = ..()
	drop_all_held_items()

// SUPER SYNDICATS!!! GET DAT MRR MRRAW DISK!!!
/mob/living/basic/pet/cat/syndicat/super
	name = "Super Syndie Cat"
	desc = "Oh Deus! Corra! Pode cheirar a louça!"
	speed = 0.3 // Slightly slower than a normal super cat since they have a suit
	health = SYNDIE_SUPER_KITTY_HEALTH
	maxHealth = SYNDIE_SUPER_KITTY_HEALTH

/mob/living/basic/pet/cat/syndicat/super/Initialize(mapload)
	. = ..()
	add_traits(list(TRAIT_NOGUNS, TRAIT_NO_TWOHANDING), INNATE_TRAIT)
	AddElement(/datum/element/dextrous)
	AddComponent(/datum/component/personal_crafting)
	// get rid of the microbomb normal syndie cats have
	for(var/obj/item/implant/explosive/implant_to_remove in implants)
		qdel(implant_to_remove)

/mob/living/basic/pet/cat/syndicat/super/can_use_guns(obj/item/G)
	. = ..()
	if(HAS_TRAIT(src, TRAIT_NOGUNS)) // Who am I to stop admins from making them stronger?
		balloon_alert(src, "Suas patas estão muito fracas!")
		return FALSE

/mob/living/basic/pet/cat/syndicat/super/move_into_vent(obj/machinery/atmospherics/components/ventcrawl_target)
	. = ..()
	drop_all_held_items()

#undef SUPER_KITTY_HEALTH
#undef SYNDIE_SUPER_KITTY_HEALTH
