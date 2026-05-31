///Defines for the pressure strength of the fist
#define LOW_PRESSURE 1
#define MID_PRESSURE 2
#define HIGH_PRESSURE 3
///Defines for the tank change action
#define TANK_INSERTING 0
#define TANK_REMOVING 1

/obj/item/melee/powerfist
	name = "power-fist"
	desc = "Uma luva de metal com um aríete movido a pistão em cima para aquele extra \"Oomph\"Em seu soco."
	icon = 'icons/obj/antags/syndicate_tools.dmi'
	icon_state = "powerfist"
	inhand_icon_state = "powerfist"
	icon_angle = 180
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	attack_verb_continuous = list("whacks", "fists", "power-punches")
	attack_verb_simple = list("whack", "fist", "power-punch")
	force = 20
	throwforce = 10
	throw_range = 7
	w_class = WEIGHT_CLASS_NORMAL
	armor_type = /datum/armor/melee_powerfist
	resistance_flags = FIRE_PROOF
	/// Delay between attacks
	var/click_delay = 0.15 SECONDS
	/// Pressure level on the fist
	var/fist_pressure_setting = LOW_PRESSURE
	/// Amount of moles per punch
	var/gas_per_fist = 3
	/// Tank used for the gauntlet's piston-ram.
	var/obj/item/tank/internals/tank

/datum/armor/melee_powerfist
	fire = 100
	acid = 40

/obj/item/melee/powerfist/proc/pressure_setting_to_text(fist_pressure_setting)
	switch(fist_pressure_setting)
		if(LOW_PRESSURE)
			return "low"
		if(MID_PRESSURE)
			return "medium"
		if(HIGH_PRESSURE)
			return "high"
		else
			CRASH("Invalid pressure setting: [fist_pressure_setting]!")

/obj/item/melee/powerfist/examine(mob/user)
	. = ..()
	if(!in_range(user, src))
		. += span_notice("Precisa se aproximar mais para ver.")
		return
	if(tank)
		. += span_notice("[icon2html(tank, user)]Tem.\a [tank]Montado nele.")
		. += span_notice("Pode ser removido com um<b>Chave de Fenda</b>.")

	. += span_notice("Use um.<b>Chave Inglesa.</b>Para mudar a força da válvula. A força atual está em<b>[pressure_setting_to_text(fist_pressure_setting)]</b>Nível.")

/obj/item/melee/powerfist/wrench_act(mob/living/user, obj/item/tool)
	fist_pressure_setting = fist_pressure_setting >= HIGH_PRESSURE ? LOW_PRESSURE : fist_pressure_setting + 1
	tool.play_tool_sound(src)
	balloon_alert(user, "Pistão de força ajustado para[pressure_setting_to_text(fist_pressure_setting)]")
	return TRUE

/obj/item/melee/powerfist/screwdriver_act(mob/living/user, obj/item/tool)
	if(!tank)
		balloon_alert(user, "Nenum tanque presente.")
		return
	update_tank(tank, TANK_REMOVING, user)
	return TRUE

/obj/item/melee/powerfist/attackby(obj/item/item_to_insert, mob/user, list/modifiers, list/attack_modifiers)
	if(!istype(item_to_insert, /obj/item/tank/internals))
		return ..()
	if(tank)
		to_chat(user, span_notice("Um tanque já está presente, remova-o com uma chave de fenda primeiro."))
		return
	var/obj/item/tank/internals/tank_to_insert = item_to_insert
	if(tank_to_insert.volume <= 3)
		to_chat(user, span_warning("\The [tank_to_insert]É muito pequeno para\the [src]."))
		return
	update_tank(item_to_insert, TANK_INSERTING, user)

/obj/item/melee/powerfist/proc/update_tank(obj/item/tank/internals/the_tank, removing = TANK_INSERTING, mob/living/carbon/human/user)
	if(removing)
		if(!tank)
			to_chat(user, span_notice("\The [src]Atualmente não tem nenhum tanque ligado a ele."))
			return
		to_chat(user, span_notice("Você se desprende.\the [the_tank]De\the [src]."))
		tank.forceMove(get_turf(user))
		user.put_in_hands(tank)
		tank = null
		return

	if(tank)
		to_chat(user, span_warning("\The [src]Já tem um tanque."))
		return
	if(!user.transferItemToLoc(the_tank, src))
		return
	to_chat(user, span_notice("Você gancho.\the [the_tank]até\the [src]."))
	tank = the_tank

/obj/item/melee/powerfist/attack(mob/living/target, mob/living/user)
	if(!tank)
		to_chat(user, span_warning("\The [src]Não posso operar sem uma fonte de gás!"))
		return
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("Você não quer machucar outros seres vivos!"))
		return
	var/turf/our_turf = get_turf(src)
	if(!our_turf)
		return

	var/datum/gas_mixture/gas_used = tank.remove_air(gas_per_fist * fist_pressure_setting)
	if(!gas_used)
		to_chat(user, span_warning("\The [src]O tanque está vazio!"))
		target.apply_damage((force / 5), BRUTE)
		playsound(loc, 'sound/items/weapons/punch1.ogg', 50, TRUE)
		target.visible_message(span_danger("[user]O powerfist deixa sair uma coisa chata como[user.p_they()]Soco.[user.p_es()] [target.name]!"), 			span_userdanger("[user]Ele te soca!"))
		return

	if(!molar_cmp_equals(gas_used.total_moles(), gas_per_fist * fist_pressure_setting))
		our_turf.assume_air(gas_used)
		to_chat(user, span_warning("\The [src]O pistão-ram solta um chiado fraco, precisa de mais gasolina!"))
		playsound(loc, 'sound/items/weapons/punch4.ogg', 50, TRUE)
		target.apply_damage((force / 2), BRUTE)
		target.visible_message(span_danger("[user]O powerfist deixa sair um chiado fraco como[user.p_they()]Soco.[user.p_es()] [target.name]!"), 			span_userdanger("[user]É golpear com força!"))
		return

	target.visible_message(span_danger("[user]O powerfist faz um barulho alto como[user.p_they()]Soco.[user.p_es()] [target.name]!"), 		span_userdanger("Você grita de dor como[user]É o soco que te atira para trás!"))
	new /obj/effect/temp_visual/kinetic_blast(target.loc)
	target.apply_damage(force * fist_pressure_setting, BRUTE, wound_bonus = CANT_WOUND)
	playsound(src, 'sound/items/weapons/resonator_blast.ogg', 50, TRUE)
	playsound(src, 'sound/items/weapons/genhit2.ogg', 50, TRUE)

	if(!QDELETED(target))
		var/atom/throw_target = get_edge_target_turf(target, get_dir(src, get_step_away(target, src)))

		target.throw_at(throw_target, 5 * fist_pressure_setting, 0.5 + (fist_pressure_setting / 2))

	log_combat(user, target, "power fisted", src)

	user.changeNext_move(CLICK_CD_MELEE * click_delay)

	our_turf.assume_air(gas_used)

#undef LOW_PRESSURE
#undef MID_PRESSURE
#undef HIGH_PRESSURE
#undef TANK_INSERTING
#undef TANK_REMOVING
