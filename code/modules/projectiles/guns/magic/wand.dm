/obj/item/gun/magic/wand
	name = "wand"
	desc = "Você não deveria ter isso."
	ammo_type = /obj/item/ammo_casing/magic
	icon_state = "nothingwand"
	inhand_icon_state = "wand"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	base_icon_state = "nothingwand"
	w_class = WEIGHT_CLASS_SMALL
	self_charging = FALSE
	max_charges = 100 //100, 50, 50, 34 (max charge distribution by 25%ths)
	/// If true, we have a 25% chance of listed max charges, 50% chance of 1/2 max charges, 25% chance of 1/3 max charges
	var/variable_charges = TRUE

/obj/item/gun/magic/wand/Initialize(mapload)
	if (!variable_charges || prob(25))
		return ..()

	if(prob(33)) // 33% of the remaining 75% so another 25%
		max_charges = ceil(max_charges / 3)
	else
		max_charges = ceil(max_charges / 2)
	return ..()

/obj/item/gun/magic/wand/examine(mob/user)
	. = ..()
	. += "Has [charges] charge\s remaining."

/obj/item/gun/magic/wand/update_icon_state()
	icon_state = "[base_icon_state][charges ? null : "-drained"]"
	return ..()

/obj/item/gun/magic/wand/attack(atom/target, mob/living/user)
	if(target == user)
		return
	return ..()

/obj/item/gun/magic/wand/try_fire_gun(atom/target, mob/living/user, params)
	if(!charges)
		shoot_with_empty_chamber(user)
		return FALSE
	if(target == user)
		if(no_den_usage && istype(get_area(user), /area/centcom/wizard_station))
			to_chat(user, span_warning("Você sabe melhor do que violar a segurança do Den, é melhor esperar até sair para usar[src]."))
			return FALSE
		zap_self(user)
		. = TRUE

	else
		. = ..()

	if(.)
		update_appearance()
	return .

/// Called if we poke ourselves with the wand
/obj/item/gun/magic/wand/proc/zap_self(mob/living/user, suicide = FALSE)
	user.visible_message(span_danger("[user]Zaps[user.p_them()]ego com[src]."))
	playsound(user, fire_sound, 50, TRUE)
	user.log_message("zapped [user.p_them()]self with a <b>[src]</b>", LOG_ATTACK)

/obj/item/gun/magic/wand/do_suicide(mob/living/user)
	zap_self(user, suicide = TRUE)
	return FIRELOSS

/// Wand which kills people and heals skeletons
/obj/item/gun/magic/wand/death
	name = "wand of death"
	desc = "Esta varinha mortal oprime o corpo da vítima com energia pura, matando-os sem falta."
	school = SCHOOL_NECROMANCY
	fire_sound = 'sound/effects/magic/wandodeath.ogg'
	ammo_type = /obj/item/ammo_casing/magic/death
	icon_state = "deathwand"
	base_icon_state = "deathwand"
	max_charges = 3 //3, 2, 2, 1

/obj/item/gun/magic/wand/death/zap_self(mob/living/user, suicide = FALSE)
	. = ..()
	charges--
	if(user.can_block_magic())
		user.visible_message(span_warning("[src]Não tem efeito sobre[user]!"))
		return
	if(isliving(user))
		if(user.mob_biotypes & MOB_UNDEAD) //negative energy heals the undead
			user.revive(ADMIN_HEAL_ALL, force_grab_ghost = TRUE) // This heals suicides
			if (!suicide)
				to_chat(user, span_notice("Você se sente ótimo!"))
			return
	to_chat(user, span_warning("Você se irradia com pura energia negativa![pick("Do not pass go. Do not collect 200 zorkmids.","You feel more confident in your spell casting skills.","You die...","Do you want your possessions identified?")]"))
	user.death(FALSE)

/obj/item/gun/magic/wand/death/do_suicide(mob/living/user)
	. = ..()
	if (user.stat == DEAD)
		return MANUAL_SUICIDE
	user.visible_message(span_suicide("...mas se alguma coisa[user.p_they()]Parece mais saudável do que antes."))
	return SHAME

/obj/item/gun/magic/wand/death/debug
	desc = "Em alguns círculos obscuros, isso é conhecido como \"amigo do testador de clonagem\"."
	max_charges = 500
	variable_charges = FALSE
	self_charging = TRUE
	recharge_rate = 1


/// Wand which kills skeletons and heals people
/obj/item/gun/magic/wand/resurrection
	name = "wand of healing"
	desc = "Esta varinha usa magias curativas para curar e reviver. Eles raramente são usados dentro da Federação Mágica por alguma razão."
	school = SCHOOL_RESTORATION
	ammo_type = /obj/item/ammo_casing/magic/heal
	fire_sound = 'sound/effects/magic/staff_healing.ogg'
	icon_state = "revivewand"
	base_icon_state = "revivewand"
	max_charges = 10 //10, 5, 5, 4

/obj/item/gun/magic/wand/resurrection/zap_self(mob/living/user, suicide = FALSE)
	..()
	charges--
	if(user.can_block_magic())
		user.visible_message(span_warning("[src]Não tem efeito sobre[user]!"))
		return
	if(isliving(user))
		var/mob/living/L = user
		if(L.mob_biotypes & MOB_UNDEAD) //positive energy harms the undead
			to_chat(user, span_warning("Você se irradia com pura energia positiva![pick("Do not pass go. Do not collect 200 zorkmids.","You feel more confident in your spell casting skills.","You die...","Do you want your possessions identified?")]"))
			user.investigate_log("has been killed by a bolt of resurrection.", INVESTIGATE_DEATHS)
			user.death(FALSE)
			return
	user.revive(ADMIN_HEAL_ALL, force_grab_ghost = TRUE) // This heals suicides
	if (!suicide)
		to_chat(user, span_notice("Você se sente ótimo!"))

/obj/item/gun/magic/wand/resurrection/do_suicide(mob/living/user)
	. = ..()
	if (user.stat == DEAD)
		return MANUAL_SUICIDE
	user.visible_message(span_suicide("...mas se alguma coisa[user.p_they()]Parece mais saudável do que antes."))
	return SHAME

/obj/item/gun/magic/wand/resurrection/debug //for testing
	desc = "É possível que algo seja ainda mais poderoso do que magia normal? Esta varinha é."
	max_charges = 500
	variable_charges = FALSE
	self_charging = TRUE
	recharge_rate = 1

/// Wand which turns mobs into other mobs
/obj/item/gun/magic/wand/polymorph
	name = "wand of polymorph"
	desc = "Esta varinha está sintonizada com o caos e irá alterar radicalmente a forma da vítima."
	school = SCHOOL_TRANSMUTATION
	ammo_type = /obj/item/ammo_casing/magic/change
	icon_state = "polywand"
	base_icon_state = "polywand"
	fire_sound = 'sound/effects/magic/staff_change.ogg'
	max_charges = 10 //10, 5, 5, 4

/obj/item/gun/magic/wand/polymorph/zap_self(mob/living/user, suicide = FALSE)
	. = ..() //because the user mob ceases to exists by the time wabbajack fully resolves
	user.wabbajack()
	charges--

/obj/item/gun/magic/wand/polymorph/do_suicide(mob/living/user)
	var/static/list/corpse_types = list(
		/obj/effect/decal/cleanable/insectguts,
		/obj/item/food/deadmouse,
		/obj/item/trash/bee,
	)
	playsound(loc, fire_sound, 50, TRUE, -1)
	var/corpse_path = pick(corpse_types)
	var/atom/corpse = new corpse_path(user.drop_location())
	corpse.name = user.real_name
	user.unequip_everything()
	user.ghostize()
	qdel(user)
	return MANUAL_SUICIDE

/// Wand of go somewhere else
/obj/item/gun/magic/wand/teleport
	name = "wand of teleportation"
	desc = "Esta varinha vai espremer alvos através do espaço e do tempo para movê-los para outro lugar."
	school = SCHOOL_TRANSLOCATION
	ammo_type = /obj/item/ammo_casing/magic/teleport
	fire_sound = 'sound/effects/magic/wand_teleport.ogg'
	icon_state = "telewand"
	base_icon_state = "telewand"
	max_charges = 10 //10, 5, 5, 4
	no_den_usage = TRUE

/obj/item/gun/magic/wand/teleport/zap_self(mob/living/user, suicide = FALSE)
	if(do_teleport(user, user, 10, channel = TELEPORT_CHANNEL_MAGIC))
		do_smoke(3, src, user.loc)
		charges--
	return ..()

/obj/item/gun/magic/wand/teleport/do_suicide(mob/living/user)
	playsound(loc, fire_sound, 50, TRUE, -1)
	do_smoke(3, src, user.loc)
	if (!iscarbon(user))
		return SHAME

	var/mob/living/carbon/suicider = user
	var/obj/item/teleport_part = suicider.get_organ_slot(ORGAN_SLOT_BRAIN)
	if (!teleport_part)
		teleport_part = suicider.get_bodypart(BODY_ZONE_HEAD)
	if (!teleport_part)
		return SHAME

	var/turf/destination = user.drop_location() // Grab this first in case moving the brain out dusts you or something

	if (isorgan(teleport_part))
		var/obj/item/organ/brain = teleport_part
		brain.Remove(user, special = FALSE)
	else
		var/obj/item/bodypart/head = teleport_part
		head.dismember(BRUTE)

	teleport_part.forceMove(destination)
	do_teleport(teleport_part, destination, 10, channel = TELEPORT_CHANNEL_MAGIC)
	if (user.stat != DEAD)
		return SHAME
	return MANUAL_SUICIDE

/// Wand of go somewhere else which is safe-ish
/obj/item/gun/magic/wand/safety
	name = "wand of safety"
	desc = "Esta varinha usará as correntes mais leves do espaço azul para colocar o alvo em um lugar seguro."
	school = SCHOOL_TRANSLOCATION
	ammo_type = /obj/item/ammo_casing/magic/safety
	fire_sound = 'sound/effects/magic/wand_teleport.ogg'
	icon_state = "telewand"
	base_icon_state = "telewand"
	max_charges = 10 //10, 5, 5, 4
	no_den_usage = FALSE

/obj/item/gun/magic/wand/safety/zap_self(mob/living/user, suicide = FALSE)
	var/turf/origin = get_turf(user)
	var/turf/destination = find_safe_turf(extended_safety_checks = TRUE)

	if(!do_teleport(user, destination, channel = TELEPORT_CHANNEL_MAGIC))
		return ..()

	for(var/turf/smoke_turf as anything in list(origin, destination))
		do_smoke(0, src, smoke_turf)
	return ..()

/obj/item/gun/magic/wand/safety/do_suicide(mob/living/user)
	. = ..()
	return SHAME // It's a safety wand sorry

/obj/item/gun/magic/wand/safety/debug
	desc = "Esta varinha tem 'find safe turf()' gravado em sua madeira azul. Talvez seja uma mensagem secreta?"
	max_charges = 500
	variable_charges = FALSE
	self_charging = TRUE
	recharge_rate = 1


/// Wand of making doors
/obj/item/gun/magic/wand/door
	name = "wand of door creation"
	desc = "Esta varinha em particular pode criar portas em qualquer parede para o mago inescrupuloso que evita magia de teletransporte."
	school = SCHOOL_TRANSMUTATION
	ammo_type = /obj/item/ammo_casing/magic/door
	icon_state = "doorwand"
	base_icon_state = "doorwand"
	fire_sound = 'sound/effects/magic/staff_door.ogg'
	max_charges = 20 //20, 10, 10, 7
	no_den_usage = TRUE

/obj/item/gun/magic/wand/door/zap_self(mob/living/user, suicide = FALSE)
	to_chat(user, span_notice("Você se sente vagamente mais aberto com seus sentimentos."))
	charges--
	return ..()

/obj/item/gun/magic/wand/door/do_suicide(mob/living/user)
	if (!iscarbon(user))
		. = ..()
		var/static/list/shared_feelings = list(
			"I can't take it any more!!",
			"I can't do this any more!!",
			"I don't want to live in this world!!",
			"I wish I was dead!!",
			"Nothing matters to me any more!!",
			"Someone please kill me!!",
			"The pain is unbearable!!",
		)
		user.say(pick(shared_feelings), forced = "failed wand suicide")
		return SHAME
	playsound(loc, fire_sound, 50, TRUE, -1)
	var/mob/living/carbon/suicider = user
	var/obj/item/bodypart/chest = suicider.get_bodypart(BODY_ZONE_CHEST) // I think it's impossible not to have a chest so we'll just assume they have one
	user.visible_message(span_suicide("[user]O peito se abre como uma porta!"))
	chest.dismember(BRUTE, silent = FALSE, wounding_type = WOUND_SLASH)
	return BRUTELOSS

/// Wand of blowing shit up
/obj/item/gun/magic/wand/fireball
	name = "wand of fireball"
	desc = "Esta varinha atira bolas de fogo escaldantes que explodem em chamas destrutivas."
	school = SCHOOL_EVOCATION
	fire_sound = 'sound/effects/magic/fireball.ogg'
	ammo_type = /obj/item/ammo_casing/magic/fireball
	icon_state = "firewand"
	base_icon_state = "firewand"
	max_charges = 8 //8, 4, 4, 3

/obj/item/gun/magic/wand/fireball/zap_self(mob/living/user, suicide = FALSE)
	..()
	explosion(user, devastation_range = -1, light_impact_range = 2, flame_range = 2, flash_range = 3, adminlog = FALSE, explosion_cause = src)
	charges--

/// Wand of doing fuck all
/obj/item/gun/magic/wand/nothing
	name = "wand of nothing"
	desc = "Não é só um pau, é um pau mágico?"
	ammo_type = /obj/item/ammo_casing/magic/nothing

//disabler wand
/obj/item/gun/magic/wand/disabler
	name = "wand of non harmful incapasitation"
	desc = "Uma dessas varinhas mágicas que você pode comprar de um vendedor de fantasias, mas esta não é totalmente inútil, engraçada."
	ammo_type = /obj/item/ammo_casing/energy/disabler/smoothbore
	self_charging = TRUE


//real magic missile wand
/obj/item/gun/magic/wand/missile
	name = "wand of MISSILE"
	desc = "Uma daquelas varinhas mágicas que você pode comprar de um vendedor de fantasias, mas esta tem um monte de adesivos de explosão/mísseis nele, também obviamente pintado de vermelho."
	ammo_type = /obj/item/ammo_casing/rocket/heap
	color = "#FF0000"


//arrow wand
/obj/item/gun/magic/wand/arrow
	name = "AWSOME WAND OF BULLET MURDER"
	desc = "Que porra é essa? Parece uma daquelas varinhas que você compra do vendedor de fantasias, mas tem um adesivo que diz \"AWSOME WAND OF BULLET MURDER\""
	ammo_type = /obj/item/ammo_casing/arrow


//20mm wand
/obj/item/gun/magic/wand/anti_tank
	name = "wand of tank shell"
	desc = "Uma dessas varinhas mágicas que você pode comprar de um vendedor de fantasias, esta reaks de pólvora e tem uma aura diferente no entanto, tenha cuidado onde você aponta isso"
	ammo_type = /obj/item/ammo_casing/mm20x138
	self_charging = TRUE

/obj/item/gun/magic/wand/nothing/do_suicide(mob/living/user)
	. = ..()
	return SHAME

/// Also wand of doing fuck all
/obj/item/gun/magic/wand/nothing/fake_resurrection
	name = "holy staff"
	desc = "É só uma equipe chique para que clérigos e padres sejam legais. O quê? Não achou que alguém deixaria um artefato mágico com um boneco de neve no frio, achou?"
	fire_sound = 'sound/effects/magic/staff_healing.ogg'
	icon_state = "revivewand"
	base_icon_state = "revivewand"
	ammo_type = /obj/item/ammo_casing/magic

/// Wand of making things small
/obj/item/gun/magic/wand/shrink
	name = "wand of shrinking"
	desc = "Sinta o pequeno terror de eldritch de uma... cabecinha..."
	ammo_type = /obj/item/ammo_casing/magic/shrink/wand
	icon_state = "shrinkwand"
	base_icon_state = "shrinkwand"
	fire_sound = 'sound/effects/magic/staff_shrink.ogg'
	max_charges = 10 //10, 5, 5, 4
	no_den_usage = TRUE
	w_class = WEIGHT_CLASS_TINY

/obj/item/gun/magic/wand/shrink/zap_self(mob/living/user, suicide = FALSE)
	to_chat(user, span_notice("O mundo cresce..."))
	charges--
	user.AddComponent(/datum/component/shrink, -1) // small forever
	return ..()

/obj/item/gun/magic/wand/shrink/do_suicide(mob/living/user)
	playsound(user, fire_sound, 50, TRUE)
	user.unequip_everything()
	user.visible_message(span_suicide("[user]encolhe em nada!"), span_suicide("Você não encolhe em nada!"))
	user.Stun(20 SECONDS, ignore_canstun = TRUE)
	user.set_suicide(TRUE)
	user.ghostize()
	animate(user, transform = matrix() * 0, time = 1 SECONDS)
	QDEL_IN(user, 1 SECONDS)
	return MANUAL_SUICIDE

// Wands of debugging

#ifdef TESTING

/obj/item/gun/magic/wand/antag
	name = "wand of antag"
	desc = "Esta varinha usa os poderes da besteira para transformar qualquer um que ele bate em uma antag"
	school = SCHOOL_FORBIDDEN
	ammo_type = /obj/item/ammo_casing/magic/antag
	icon_state = "revivewand"
	base_icon_state = "revivewand"
	color = COLOR_ADMIN_PINK
	max_charges = 99999

/obj/item/gun/magic/wand/antag/zap_self(mob/living/user, suicide = FALSE)
	. = ..()
	var/obj/item/ammo_casing/magic/antag/casing = new ammo_type()
	var/obj/projectile/magic/magic_proj = casing.projectile_type
	magic_proj = new magic_proj(src)
	magic_proj.on_hit(user)
	QDEL_NULL(casing)

/obj/item/ammo_casing/magic/antag
	projectile_type = /obj/projectile/magic/antag
	harmful = FALSE

/obj/projectile/magic/antag
	name = "bolt of antag"
	icon_state = "ion"
	var/antag = /datum/antagonist/traitor

/obj/projectile/magic/antag/on_hit(atom/target, blocked, pierce_hit)
	. = ..()

	if(isliving(target))
		var/mob/living/victim = target
		if(isnull(victim.mind))
			victim.mind_initialize()
		if(victim.mind.has_antag_datum(antag))
			victim.mind.remove_antag_datum(antag)
			to_chat(world, "removed")
		else
			victim.mind.add_antag_datum(antag)
			to_chat(world, "added")

/obj/item/gun/magic/wand/antag/heretic
	name = "wand of antag heretic"
	desc = "Esta varinha usa os poderes da besteira para transformar qualquer um que ele bate em um herege antag"
	color = COLOR_GREEN
	ammo_type = /obj/item/ammo_casing/magic/antag/heretic

/obj/item/ammo_casing/magic/antag/heretic
	projectile_type = /obj/projectile/magic/antag/heretic

/obj/projectile/magic/antag/heretic
	name = "bolt of antag heretic"
	icon_state = "ion"
	antag = /datum/antagonist/heretic

/obj/item/gun/magic/wand/antag/cult
	name = "wand of antag cultist"
	desc = "Esta varinha usa os poderes da besteira para transformar qualquer um que ele bate em um culto de antag"
	color = COLOR_CULT_RED
	ammo_type = /obj/item/ammo_casing/magic/antag/cult

/obj/item/ammo_casing/magic/antag/cult
	projectile_type = /obj/projectile/magic/antag/cult

/obj/projectile/magic/antag/cult
	name = "bolt of antag cult"
	icon_state = "ion"
	antag = /datum/antagonist/cult

#endif
