/obj/item/clothing/neck/heretic_focus
	name = "amber focus"
	desc = "Um vidro âmbar focado que fornece uma ligação para o mundo além. O colar parece se contorcer, mas só quando você olha pelo canto do olho."
	icon_state = "eldritch_necklace"
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FIRE_PROOF

/obj/item/clothing/neck/heretic_focus/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/heretic_focus)

/obj/item/clothing/neck/heretic_focus/crimson_medallion
	name = "crimson medallion"
	desc = "Um vidro de focagem vermelho-sangue que fornece uma ligação para o mundo além, e pior. Seu olho está constantemente se contorcendo e olhando em todas as direções. Quase parece estar gritando silenciosamente..."
	icon_state = "crimson_medallion"
	/// The aura healing component. Used to delete it when taken off.
	var/datum/component/component
	/// If active or not, used to add and remove its cult and heretic buffs.
	var/active = FALSE

/obj/item/clothing/neck/heretic_focus/crimson_medallion/equipped(mob/living/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_NECK))
		return

	var/team_color = COLOR_ADMIN_PINK
	if(IS_CULTIST(user))
		var/datum/action/innate/cult/blood_magic/magic_holder = locate() in user.actions
		team_color = COLOR_CULT_RED
		magic_holder.magic_enhanced = TRUE
	else if(IS_HERETIC_OR_MONSTER(user) && !active)
		for(var/datum/action/cooldown/spell/spell_action in user.actions)
			spell_action.cooldown_time *= 0.5
			active = TRUE
		team_color = COLOR_GREEN
	else
		team_color = pick(COLOR_CULT_RED, COLOR_GREEN)

	user.add_traits(list(TRAIT_MANSUS_TOUCHED, TRAIT_BLOOD_FOUNTAIN), REF(src))
	to_chat(user, span_alert("Seu coração tem um ritmo irregular estranho, mas calmante, e seu sangue parece significativamente menos viscoso do que costumava ser. Não tem certeza se isso é bom."))
	component = user.AddComponent( 		/datum/component/aura_healing, 		range = 3, 		brute_heal = 1, 		burn_heal = 1, 		blood_heal = 2, 		suffocation_heal = 5, 		simple_heal = 0.6, 		requires_visibility = FALSE, 		limit_to_trait = TRAIT_MANSUS_TOUCHED, 		healing_color = team_color, 	)

/obj/item/clothing/neck/heretic_focus/crimson_medallion/dropped(mob/living/user)
	. = ..()

	if(!istype(user))
		return

	if(HAS_TRAIT_FROM(user, TRAIT_MANSUS_TOUCHED, REF(src)))
		to_chat(user, span_notice("Seu coração e sangue retornam ao seu ritmo e fluxo normal."))

	if(IS_HERETIC_OR_MONSTER(user) && active)
		for(var/datum/action/cooldown/spell/spell_action in user.actions)
			spell_action.cooldown_time *= 2
			active = FALSE
	QDEL_NULL(component)
	user.remove_traits(list(TRAIT_MANSUS_TOUCHED, TRAIT_BLOOD_FOUNTAIN), REF(src))

	// If boosted enable is set, to prevent false dropped() calls from repeatedly nuking the max spells.
	var/datum/action/innate/cult/blood_magic/magic_holder = locate() in user.actions
	// Remove the last spell if over new limit, as we will reduce our max spell amount. Done beforehand as it causes a index out of bounds runtime otherwise.
	if(magic_holder?.magic_enhanced)
		QDEL_NULL(magic_holder.spells[ENHANCED_BLOODCHARGE])
	magic_holder?.magic_enhanced = FALSE


/obj/item/clothing/neck/heretic_focus/crimson_medallion/attack_self(mob/living/user, modifiers)
	. = ..()
	to_chat(user, span_danger("Você começa apertando forte [src]..."))
	if(!do_after(user, 1.25 SECONDS, src))
		return
	to_chat(user, span_danger("[src] explode em uma chuva de sangue e sangue, molhando seu braço. Você pode sentir o sangue escorrendo na sua pele. Você se sente imediatamente melhor, mas logo, a sensação fica oca como suas veias coçam."))
	new /obj/effect/gibspawner/generic(get_turf(src))
	var/heal_amt = user.adjust_brute_loss(-50)
	user.adjust_fire_loss( -(50 - abs(heal_amt)) ) // no double dipping

	// I want it to poison the user but I also think it'd be neat if they got their juice as well. But that cancels most of the damage out. So I dunno.
	user.reagents?.add_reagent(/datum/reagent/fuel/unholywater, rand(6, 10))
	user.reagents?.add_reagent(/datum/reagent/eldritch, rand(6, 10))
	qdel(src)

/obj/item/clothing/neck/heretic_focus/crimson_medallion/examine(mob/user)
	. = ..()

	var/magic_dude
	if(IS_CULTIST(user))
		. += span_cult_bold("Este foco permitirá que você guarde um feitiço extra e diminua o tempo de empoderamento, além de proporcionar um pequeno efeito regenerativo.")
		magic_dude = TRUE
	if(IS_HERETIC_OR_MONSTER(user))
		. += span_notice("Este foco vai reduzir para metade o seu feitiço, ao lado de conceder um pequeno efeito regenerativo a qualquer hereges ou monstros próximos, incluindo você.")
		magic_dude = TRUE

	if(magic_dude)
		. += span_red("Você também pode espremê-lo para recuperar uma grande quantidade de saúde rapidamente, a um custo ...")

/obj/item/clothing/neck/eldritch_amulet
	name = "warm eldritch medallion"
	desc = "Um medalhão estranho. Perscrutando a superfície cristalina, o mundo ao seu redor derrete. Você vê seu próprio coração batendo, e o pulsar de mil outros."
	icon = 'icons/obj/antags/eldritch.dmi'
	icon_state = "eye_medalion"
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FIRE_PROOF | UNACIDABLE | ACID_PROOF
	/// A secondary clothing trait only applied to heretics.
	var/heretic_only_trait = TRAIT_THERMAL_VISION

/obj/item/clothing/neck/eldritch_amulet/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/heretic_focus)

/obj/item/clothing/neck/eldritch_amulet/equipped(mob/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_NECK))
		return
	if(!ishuman(user) || !IS_HERETIC_OR_MONSTER(user))
		return

	ADD_TRAIT(user, heretic_only_trait, "[CLOTHING_TRAIT]_[REF(src)]")
	user.update_sight()

/obj/item/clothing/neck/eldritch_amulet/dropped(mob/user)
	. = ..()
	REMOVE_TRAIT(user, heretic_only_trait, "[CLOTHING_TRAIT]_[REF(src)]")
	user.update_sight()

/obj/item/clothing/neck/eldritch_amulet/piercing
	name = "piercing eldritch medallion"
	desc = "Um medalhão estranho. Perscrutando através da superfície cristalina, a luz refrata-se em novos e aterrorizantes espectros de cor. Você se vê, refletido em espelhos em cascata, distorcido em formas impossíveis."
	heretic_only_trait = TRAIT_XRAY_VISION

// Cosmetic-only version
/obj/item/clothing/neck/fake_heretic_amulet
	name = "religious icon"
	desc = "Um medalhão estranho, que faz com que seu usuário pareça parte de algum culto."
	icon = 'icons/obj/antags/eldritch.dmi'
	icon_state = "eye_medalion"
	w_class = WEIGHT_CLASS_SMALL

// The amulet conversion tool used by moon heretics
/obj/item/clothing/neck/heretic_focus/moon_amulet
	name = "moonlight amulet"
	desc = "Um pedaço da mente, da alma e da lua. Olhar para ele faz sua cabeça girar e ouvir sussurros de riso e alegria."
	icon = 'icons/obj/antags/eldritch.dmi'
	icon_state = "moon_amulette"
	w_class = WEIGHT_CLASS_SMALL
	/// How much damage does this item do to the targets sanity?
	var/sanity_damage = 20
	var/list/possible_sounds = list(
		'sound/items/sitcom_laugh/SitcomLaugh1.ogg',
		'sound/items/sitcom_laugh/SitcomLaugh2.ogg',
		'sound/items/sitcom_laugh/SitcomLaugh3.ogg',
	)
	var/valid_weapon_type = /obj/item/melee/sickly_blade
	var/sanity_threshold = SANITY_LEVEL_INSANE

/obj/item/clothing/neck/heretic_focus/moon_amulet/examine(mob/user)
	. = ..()
	if(IS_HERETIC(user))
		. += span_notice("Usar este amuleto aumenta sua velocidade de cura em 50%.")

/obj/item/clothing/neck/heretic_focus/moon_amulet/equipped(mob/living/user, slot)
	. = ..()
	if(!IS_HERETIC(user) && (slot_flags & slot))
		channel_amulet(user)
		return // Equipping the amulet as a non-heretic will give you a fat mood debuff and nothing else
	if(!(slot_flags & slot))
		on_amulet_deactivate(user)
		return
	on_amulet_activate(user)

/// Modifies any blades you hold/pickup/drop when the amulet is enabled
/obj/item/clothing/neck/heretic_focus/moon_amulet/proc/on_amulet_activate(mob/living/user)
	RegisterSignal(user, COMSIG_HERETIC_BLADE_ATTACK, PROC_REF(blade_channel))
	RegisterSignal(user, COMSIG_MOB_EQUIPPED_ITEM, PROC_REF(on_equip_item))
	RegisterSignal(user, COMSIG_MOB_DROPPED_ITEM, PROC_REF(on_dropped_item))
	// Just make sure we pacify blades potentially in our hands when we put on the amulet
	on_equip_item(user, user.get_active_held_item(), ITEM_SLOT_HANDS)
	on_equip_item(user, user.get_inactive_held_item(), ITEM_SLOT_HANDS)
	ADD_TRAIT(user, TRAIT_THERMAL_VISION, REF(src))
	user.update_sight()
	// If the equipper is a moon heretic, we buff their passive
	var/datum/status_effect/heretic_passive/moon/moon_passive = user.has_status_effect(/datum/status_effect/heretic_passive/moon)
	moon_passive?.amulet_equipped = TRUE

/// Modifies any blades you hold/pickup/drop when the amulet is disabled
/obj/item/clothing/neck/heretic_focus/moon_amulet/proc/on_amulet_deactivate(mob/living/user)
	// Make sure to restore the values of any blades we might be holding when our amulet is deactivated
	on_dropped_item(user, user.get_active_held_item())
	on_dropped_item(user, user.get_inactive_held_item())
	UnregisterSignal(user, list(COMSIG_HERETIC_BLADE_ATTACK, COMSIG_MOB_EQUIPPED_ITEM, COMSIG_MOB_DROPPED_ITEM))
	REMOVE_TRAIT(user, TRAIT_THERMAL_VISION, REF(src))
	user.update_sight()
	var/datum/status_effect/heretic_passive/moon/moon_passive = user.has_status_effect(/datum/status_effect/heretic_passive/moon)
	moon_passive?.amulet_equipped = FALSE

/obj/item/clothing/neck/heretic_focus/moon_amulet/dropped(mob/living/user)
	on_amulet_deactivate(user)
	return ..()

/obj/item/clothing/neck/heretic_focus/moon_amulet/attack(mob/living/target, mob/living/user, list/modifiers, list/attack_modifiers)
	if(channel_amulet(user, target))
		return
	return ..()

/obj/item/clothing/neck/heretic_focus/moon_amulet/proc/blade_channel(mob/living/attacker, mob/living/victim)
	SIGNAL_HANDLER
	channel_amulet(attacker, victim)

/// Makes whoever the target is a bit more insane. If they are insane enough, they will be zombified into a moon zombie
/obj/item/clothing/neck/heretic_focus/moon_amulet/proc/channel_amulet(mob/user, atom/target)

	if(!isliving(user))
		return FALSE
	var/mob/living/living_user = user
	if(!IS_HERETIC_OR_MONSTER(living_user))
		living_user.balloon_alert(living_user, "Você sente uma presença observando você")
		living_user.add_mood_event("Moon Amulet Insanity", /datum/mood_event/amulet_insanity)
		living_user.mob_mood.adjust_sanity(-50)
		return FALSE
	if(!isliving(target))
		return FALSE
	var/mob/living/living_target = target

	if(!ishuman(target))
		living_target.adjust_fire_loss(30)
		return TRUE
	var/mob/living/carbon/human/human_target = target
	if(IS_HERETIC_OR_MONSTER(human_target))
		living_user.balloon_alert(living_user, "resiste aos efeitos!")
		return FALSE
	if(human_target.has_status_effect(/datum/status_effect/moon_slept) || human_target.has_status_effect(/datum/status_effect/moon_converted))
		human_target.balloon_alert(living_user, "causando danos!")
		human_target.adjust_organ_loss(ORGAN_SLOT_BRAIN, 25)
		return FALSE
	if(human_target.can_block_magic(MAGIC_RESISTANCE_MOON))
		return FALSE
	if(!human_target.mob_mood)
		return FALSE
	if(human_target.mob_mood.sanity_level < sanity_threshold)
		human_target.balloon_alert(living_user, "A mente deles é muito forte!")
		human_target.add_mood_event("Moon Amulet Insanity", /datum/mood_event/amulet_insanity)
		human_target.mob_mood.adjust_sanity(-sanity_damage)
	else
		if(HAS_TRAIT(target, TRAIT_MINDSHIELD))
			human_target.balloon_alert(living_user, "Sua mente quase se dobra, mas algo a protege!")
			human_target.apply_status_effect(/datum/status_effect/moon_slept)
			return TRUE
		human_target.balloon_alert(living_user, "Sua mente se curva para ver a verdade!")
		human_target.apply_status_effect(/datum/status_effect/moon_converted)
		living_user.log_message("made [human_target] insane.", LOG_GAME)
		human_target.log_message("was driven insane by [living_user]", LOG_GAME)
	return TRUE

/// Modifies any blades that we equip while wearing the amulet
/obj/item/clothing/neck/heretic_focus/moon_amulet/proc/on_equip_item(mob/user, obj/item/blade, slot)
	SIGNAL_HANDLER
	if(!istype(blade, valid_weapon_type))
		return // We only care about modifying blades
	if(slot & ITEM_SLOT_HANDS)
		blade.force = 0
		blade.wound_bonus = 0
		blade.exposed_wound_bonus = 0
		blade.armour_penetration = 200
		RegisterSignal(blade, COMSIG_SEND_ITEM_ATTACK_MESSAGE_OBJECT, PROC_REF(modify_attack_message))
		return
	blade.force = initial(blade.force)
	blade.wound_bonus = initial(blade.wound_bonus)
	blade.exposed_wound_bonus = initial(blade.exposed_wound_bonus)
	blade.armour_penetration = initial(blade.armour_penetration)
	UnregisterSignal(blade, COMSIG_SEND_ITEM_ATTACK_MESSAGE_OBJECT)

/obj/item/clothing/neck/heretic_focus/moon_amulet/proc/modify_attack_message(obj/item/weapon, mob/living/victim, mob/living/attacker)
	SIGNAL_HANDLER

	var/list/attack_list = list(
		"You sweep [weapon] towards [victim], splitting [victim.p_Their()] image in two.",
		"You strike [victim] with [weapon], spilling forth a cascade from within. Immaculate.",
		"As it bite deep, your [weapon] unburdens [victim] of unneeded thought.",
	)
	to_chat(attacker, span_danger(pick(attack_list)))

	var/list/victim_list = list(
		"You are struck by [attacker], but the [weapon] tears away something more than parts of your body.",
		"You see an arch of light as [attacker]'s [weapon] twists towards you, and you see the world briefly in tetrachrome.",
		"As [attacker] carves into you with [weapon], you lose something deep within. The agony is worse than any wound.",
	)
	to_chat(victim, span_userdanger(pick(victim_list)))
	playsound(attacker, pick(possible_sounds), 40, TRUE)
	return SIGNAL_MESSAGE_MODIFIED

/// Modifies any blades that we drop while wearing the amulet
/obj/item/clothing/neck/heretic_focus/moon_amulet/proc/on_dropped_item(mob/user, obj/item/dropped_item)
	SIGNAL_HANDLER
	if(!istype(dropped_item, valid_weapon_type))
		return // We only care about modifying blades
	dropped_item.force = initial(dropped_item.force)
	dropped_item.wound_bonus = initial(dropped_item.wound_bonus)
	dropped_item.exposed_wound_bonus = initial(dropped_item.exposed_wound_bonus)
	dropped_item.armour_penetration = initial(dropped_item.armour_penetration)
	UnregisterSignal(dropped_item, COMSIG_SEND_ITEM_ATTACK_MESSAGE_OBJECT)
