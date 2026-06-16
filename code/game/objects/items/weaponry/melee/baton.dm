/obj/item/melee/baton
	name = "police baton"
	desc = "Um cassetete de madeira para bater na escória criminosa."
	desc_controls = "Left click to stun, right click to harm."
	icon = 'icons/obj/weapons/baton.dmi'
	icon_state = "classic_baton"
	inhand_icon_state = "classic_baton"
	worn_icon_state = "classic_baton"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 12 //9 hit crit
	w_class = WEIGHT_CLASS_NORMAL
	wound_bonus = 15
	sound_vary = TRUE

	/// Whether this baton is active or not
	var/active = TRUE
	/// Used interally, you don't want to modify
	var/cooldown_check = 0
	/// Default wait time until can stun again.
	var/cooldown = (4 SECONDS)
	/// The length of the knockdown applied to a struck living, non-cyborg mob.
	var/knockdown_time = (1.5 SECONDS)
	/// If affect_cyborg is TRUE, this is how long we stun cyborgs for on a hit.
	var/stun_time_cyborg = (5 SECONDS)
	/// The length of the knockdown applied to the user on clumsy_check()
	var/clumsy_knockdown_time = 18 SECONDS
	/// How much stamina damage we deal on a successful hit against a living, non-cyborg mob.
	var/stamina_damage = 55
	/// How much armor does our baton ignore? This operates as armour penetration, but only applies to the stun attack.
	var/stun_armour_penetration = 15 // pens very light / cosmetic armor
	/// What armor does our stun attack check before delivering the attack?
	var/armour_type_against_stun = MELEE
	/// Chance of causing force_say() when stunning a human mob
	var/force_say_chance = 33
	/// Can we stun cyborgs?
	var/affect_cyborg = FALSE
	/// The path of the default sound to play when we stun something.
	var/on_stun_sound = 'sound/effects/woodhit.ogg'
	/// The volume of the above.
	var/on_stun_volume = 75
	/// Whether the stun attack is logged. Only relevant for abductor batons, which have different modes.
	var/log_stun_attack = TRUE
	/// Boolean on whether people with chunky fingers can use this baton.
	var/chunky_finger_usable = FALSE
	/// Boolean, if TRUE when we harmbaton someone we will also try to stun if the baton is active / not on cooldown.
	var/stun_on_harmbaton = FALSE

	/// Text shown when trying to stun someone while the baton is on cooldown.
	var/wait_desc = ""

	/// What term do we use to describe our baton being 'ready', or the phrase to use when var/active is TRUE.
	var/activated_word = "ready"

	/// The context to show when the baton is active and targeting a living thing
	var/context_living_target_active = "Stun"

	/// The context to show when the baton is active and targeting a living thing in combat mode
	var/context_living_target_active_combat_mode = "Stun"

	/// The context to show when the baton is inactive and targeting a living thing
	var/context_living_target_inactive = "Prod"

	/// The context to show when the baton is inactive and targeting a living thing in combat mode
	var/context_living_target_inactive_combat_mode = "Attack"

	/// The RMB context to show when the baton is active and targeting a living thing
	var/context_living_rmb_active = "Attack"

	/// The RMB context to show when the baton is inactive and targeting a living thing
	var/context_living_rmb_inactive = "Attack"

/obj/item/melee/baton/Initialize(mapload)
	. = ..()

	register_item_context()
	add_deep_lore()

/obj/item/melee/baton/add_weapon_description()
	AddElement(/datum/element/weapon_description, attached_proc = PROC_REF(add_baton_notes))

/obj/item/melee/baton/proc/add_baton_notes()
	var/list/readout = list()

	if(affect_cyborg)
		readout += "It can stun cyborgs for [round((stun_time_cyborg/10), 1)] seconds."

	readout += "\n[active ? "It is currently [span_warning("[activated_word]")], and capable of stunning." : "It is [span_warning("not [activated_word]")], and not capable of stunning."]"

	if(stamina_damage <= 0) // The advanced baton actually does have 0 stamina damage so...yeah.
		readout += "Either it is [span_warning("completely unable to perform a stunning strike")], or it [span_warning("attacks via some unusual method")]."
		return readout.Join("\n")

	readout += "É preciso.[span_warning("[HITS_TO_CRIT(stamina_damage)] strike\s")]Para atardoar um inimigo."

	readout += "\nOs atos de cada ataque podem ser atenuados utilizando[span_warning("[armour_type_against_stun]")]Armadura."

	readout += "\nTem uma capacidade impressionante de perfurar armaduras.[span_warning("[stun_armour_penetration]%")]."
	return readout.Join("\n")

/obj/item/melee/baton/proc/add_deep_lore()
	return

#define STUN_ATTACK "stun attack"

/**
 * Checks if we can stun targets with the baton.
 *
 * Impure (has chat feedback and mutates state in some subtypes).
 * In other words don't call this unless a stun is being attempted.
 *
 * * target - The mob being hit with the baton
 * * user - The mob using the baton
 * * harmbatonning - Whether or not this is being called from a harmbaton attack
 *
 * Returns TRUE if we can stun the target, FALSE if we cannot.
 */
/obj/item/melee/baton/proc/try_stun(mob/living/target, mob/living/user, harmbatonning)
	PROTECTED_PROC(TRUE)
	if(!active)
		return FALSE
	if(!chunky_finger_usable && ishuman(user))
		var/mob/living/carbon/human/human_user = user
		if(human_user.check_chunky_fingers() && user.is_holding(src) && !HAS_MIND_TRAIT(user, TRAIT_CHUNKYFINGERS_IGNORE_BATON))
			if(!harmbatonning)
				balloon_alert(human_user, "Dedos são muito grandes!")
			return FALSE
	if(!COOLDOWN_FINISHED(src, cooldown_check))
		if(wait_desc && !harmbatonning)
			balloon_alert(user, wait_desc)
		return FALSE
	if(HAS_TRAIT_FROM(target, TRAIT_IWASBATONED, REF(user)) ) //no doublebaton abuse anon!
		if(!harmbatonning)
			target.balloon_alert(user, "Não posso atordoar ainda!")
		return FALSE
	return TRUE

// Stun attack
/obj/item/melee/baton/pre_attack(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(.)
		return TRUE

	if(!isliving(target))
		return FALSE // bashing objects

	var/harmbatonning = LAZYACCESS(modifiers, RIGHT_CLICK)
	if(harmbatonning && !stun_on_harmbaton)
		return FALSE // harmbatonning, no stun

	// see if this attack will result in a stun, or if we need to cancel it
	if(!try_stun(target, user, harmbatonning))
		if(harmbatonning)
			return FALSE // if harmbatonning, ALwAYS attack
		if(active)
			return TRUE  // if active, but can't stun? no attack
		if(!user.combat_mode)
			return TRUE  // if not in combat mode? no attack

		return FALSE // otherwise, attack normally

	// clumsy people redirect this attack - yes, this bypasses IWASBATONED and such
	if(HAS_TRAIT(user, TRAIT_CLUMSY) && prob(50))
		user.visible_message(
			span_danger("[user] Acidentalmente bate [user.p_them()] ego sobre a cabeça com [src] Que idiota!"),
			span_userdanger("Você acidentalmente bateu na cabeça com [src]!"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)

		finalize_baton_attack(user, user, clumsy = TRUE)
		user.apply_damage(2 * force, BRUTE, BODY_ZONE_HEAD, attacking_item = src)
		log_combat(user, user, "accidentally stun attacked [user.p_them()]self due to their clumsiness", src)
		user.do_attack_animation(user)
		user.changeNext_move(attack_speed)
		return TRUE // you hit yourself, nerd

	// if not harm batonning, we override the default attack properties do do nothing
	if(!harmbatonning)
		SET_ATTACK_FORCE(attack_modifiers, 0)
		MUTE_ATTACK_HITSOUND(attack_modifiers)
		HIDE_ATTACK_MESSAGES(attack_modifiers)
	// then denote the attack as "will stun" for afterattack
	LAZYSET(attack_modifiers, STUN_ATTACK, TRUE)
	return FALSE // attack and stun

// This is where stun gets applied
/obj/item/melee/baton/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(QDELETED(target) || !LAZYACCESS(attack_modifiers, STUN_ATTACK))
		return

	finalize_baton_attack(target, user)

	var/list/desc
	if(iscyborg(target))
		desc = get_cyborg_stun_description(target, user)
		if(!affect_cyborg)
			playsound(src, 'sound/effects/bang.ogg', 10, TRUE) //bonk
	else
		desc = get_stun_description(target, user)

	if(desc)
		target.visible_message(desc["visible"], desc["local"], visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE)

/obj/item/melee/baton/apply_fantasy_bonuses(bonus)
	. = ..()
	stamina_damage = modify_fantasy_variable("stamina_damage", stamina_damage, bonus * 4)

/obj/item/melee/baton/remove_fantasy_bonuses(bonus)
	stamina_damage = reset_fantasy_variable("stamina_damage", stamina_damage)
	return ..()

/obj/item/melee/baton/add_item_context(datum/source, list/context, atom/target, mob/living/user)
	if (isturf(target))
		return NONE

	if (isobj(target))
		context[SCREENTIP_CONTEXT_LMB] = "Attack"
	else
		if (active)
			context[SCREENTIP_CONTEXT_RMB] = context_living_rmb_active

			if (user.combat_mode)
				context[SCREENTIP_CONTEXT_LMB] = context_living_target_active_combat_mode
			else
				context[SCREENTIP_CONTEXT_LMB] = context_living_target_active
		else
			context[SCREENTIP_CONTEXT_RMB] = context_living_rmb_inactive

			if (user.combat_mode)
				context[SCREENTIP_CONTEXT_LMB] = context_living_target_inactive_combat_mode
			else
				context[SCREENTIP_CONTEXT_LMB] = context_living_target_inactive

	return CONTEXTUAL_SCREENTIP_SET

/// Wrapper for calling "stun()" and doing relevant vfx/sfx
/obj/item/melee/baton/proc/finalize_baton_attack(mob/living/target, mob/living/user, clumsy = FALSE)
	COOLDOWN_START(src, cooldown_check, cooldown)
	if(on_stun_sound)
		playsound(src, on_stun_sound, on_stun_volume, TRUE, -1)
	if(baton_effect(target, user, null, clumsy) && user)
		set_batoned(target, user, cooldown)
		log_combat(user, target, "stunned", src.name)

/// The actual "stun()" of the stun baton
/obj/item/melee/baton/proc/baton_effect(mob/living/target, mob/living/user, stun_override, clumsy)
	PROTECTED_PROC(TRUE)
	var/trait_check = HAS_TRAIT(target, TRAIT_BATON_RESISTANCE)
	if(iscyborg(target))
		if(!affect_cyborg)
			return FALSE
		target.flash_act(affect_silicon = TRUE)
		target.Paralyze((isnull(stun_override) ? stun_time_cyborg : stun_override) * (trait_check ? 0.1 : 1))
		additional_effects_cyborg(target, user)
	else
		if(ishuman(target))
			var/mob/living/carbon/human/human_target = target
			if(prob(force_say_chance))
				human_target.force_say()
		var/armour_block = target.run_armor_check(BODY_ZONE_CHEST, armour_type_against_stun, null, null, stun_armour_penetration)
		target.apply_damage(stamina_damage, STAMINA, blocked = armour_block)
		if(!trait_check)
			target.Knockdown((isnull(stun_override) ? knockdown_time : stun_override))
		additional_effects_non_cyborg(target, user)
	SEND_SIGNAL(target, COMSIG_MOB_BATONED, user, src)
	return TRUE

/// Default message for stunning a living, non-cyborg mob.
/obj/item/melee/baton/proc/get_stun_description(mob/living/target, mob/living/user)
	PROTECTED_PROC(TRUE)
	. = list()
	.["visible"] = span_danger("[user] Bate.[target] Abaixo com [src]!")
	.["local"] = span_userdanger("[user] Derruba você com [src]!")

/// Default message for stunning a cyborg.
/obj/item/melee/baton/proc/get_cyborg_stun_description(mob/living/target, mob/living/user)
	PROTECTED_PROC(TRUE)
	. = list()
	if(affect_cyborg)
		.["visible"] = span_danger("[user] pulsações [target] Os sensores com o bastão!")
		.["local"] = span_danger("Você pulsa.[target] Os sensores com o bastão!")
	else
		.["visible"] = span_danger("[user] Tenta derrubar [target] Com [src] E previsivelmente falha!") //look at this duuuuuude
		.["local"] = span_userdanger("[user] Tenta te derrubar com...[src]?") //look at the top of his head!

/// Contains any special effects that we apply to living, non-cyborg mobs we stun. Does not include applying a knockdown, dealing stamina damage, etc.
/obj/item/melee/baton/proc/additional_effects_non_cyborg(mob/living/target, mob/living/user)
	PROTECTED_PROC(TRUE)
	return

/// Contains any special effects that we apply to cyborgs we stun. Does not include flashing the cyborg's screen, hardstunning them, etc.
/obj/item/melee/baton/proc/additional_effects_cyborg(mob/living/target, mob/living/user)
	PROTECTED_PROC(TRUE)
	return

/// Used in marking a target as being hit by a baton
/obj/item/melee/baton/proc/set_batoned(mob/living/target, mob/living/user, cooldown)
	PRIVATE_PROC(TRUE)
	if(!cooldown)
		return
	var/user_ref = REF(user) // avoids harddels.
	ADD_TRAIT(target, TRAIT_IWASBATONED, user_ref)
	addtimer(TRAIT_CALLBACK_REMOVE(target, TRAIT_IWASBATONED, user_ref), cooldown)

#undef STUN_ATTACK

/obj/item/conversion_kit
	name = "conversion kit"
	desc = "Uma caixa estranha contendo ferramentas de trabalho de madeira e um papel de instrução para transformar bastões de choque em outra coisa."
	icon = 'icons/obj/storage/box.dmi'
	icon_state = "uk"
	custom_price = PAYCHECK_COMMAND * 4.5

/obj/item/melee/baton/telescopic
	name = "telescopic baton"
	desc = "Uma arma de defesa pessoal compacta e robusta. Pode ser escondido quando dobrado."
	icon = 'icons/obj/weapons/baton.dmi'
	icon_state = "telebaton"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	inhand_icon_state = null
	attack_verb_continuous = list("hits", "pokes")
	attack_verb_simple = list("hit", "poke")
	worn_icon_state = "tele_baton"
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	item_flags = NONE
	force = 0
	exposed_wound_bonus = 5
	clumsy_knockdown_time = 15 SECONDS
	active = FALSE
	activated_word = "extended"
	var/folded_drop_sound = 'sound/items/baton/telescopic_baton_folded_drop.ogg'
	var/folded_pickup_sound = 'sound/items/baton/telescopic_baton_folded_pickup.ogg'
	var/unfolded_drop_sound = 'sound/items/baton/telescopic_baton_unfolded_drop.ogg'
	var/unfolded_pickup_sound = 'sound/items/baton/telescopic_baton_unfolded_pickup.ogg'
	pickup_sound = 'sound/items/baton/telescopic_baton_folded_pickup.ogg'
	drop_sound = 'sound/items/baton/telescopic_baton_folded_drop.ogg'
	sound_vary = TRUE
	/// The sound effecte played when our baton is extended.
	var/on_sound = 'sound/items/weapons/batonextend.ogg'
	/// The inhand iconstate used when our baton is extended.
	var/on_inhand_icon_state = "nullrod"
	/// The force on extension.
	var/active_force = 10

/obj/item/melee/baton/telescopic/Initialize(mapload)
	. = ..()
	AddComponent( 		/datum/component/transforming, 		force_on = active_force, 		hitsound_on = hitsound, 		w_class_on = WEIGHT_CLASS_NORMAL, 		clumsy_check = FALSE, 		attack_verb_continuous_on = list("smacks", "strikes", "cracks", "beats"), 		attack_verb_simple_on = list("smack", "strike", "crack", "beat"), 	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/obj/item/melee/baton/telescopic/additional_effects_non_cyborg(mob/living/target, mob/living/user)
	target.apply_status_effect(/datum/status_effect/dazed)

/obj/item/melee/baton/telescopic/suicide_act(mob/living/user)
	var/mob/living/carbon/human/human_user = user
	var/obj/item/organ/brain/our_brain = human_user.get_organ_by_type(/obj/item/organ/brain)

	user.visible_message(span_suicide("[user] Coisas.[src] Para cima.[user.p_their()] Nariz e aperta o botão \"Extensor\"Parece que...[user.p_theyre()] Tentando limpar [user.p_their()] Mente."))
	if(active)
		playsound(src, on_sound, 50, TRUE)
		add_fingerprint(user)
	else
		attack_self(user)

	sleep(0.3 SECONDS)
	if (QDELETED(human_user))
		return
	if(!QDELETED(our_brain))
		human_user.organs -= our_brain
		qdel(our_brain)
	new /obj/effect/gibspawner/generic(human_user.drop_location(), human_user)
	return BRUTELOSS

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Gives feedback to the user and makes it show up inhand.
 */
/obj/item/melee/baton/telescopic/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	src.active = active
	inhand_icon_state = active ? on_inhand_icon_state : null // When inactive, there is no inhand icon_state.
	if(user)
		balloon_alert(user, active ? "extended" : "collapsed")
	if(!active)
		drop_sound = folded_drop_sound
		pickup_sound = folded_pickup_sound
	else
		drop_sound = unfolded_drop_sound
		pickup_sound = unfolded_pickup_sound
	playsound(src, on_sound, 50, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/melee/baton/telescopic/bronze
	name = "bronze-capped telescopic baton"
	desc = "Uma arma de defesa pessoal compacta e robusta. Pode ser escondido quando dobrado. Este é classificado como BRONZE, e assim tem poder penetrativo medíocre."
	icon_state = "telebaton_bronze"

/obj/item/melee/baton/telescopic/silver
	name = "silver-capped telescopic baton"
	desc = "Uma arma de defesa pessoal compacta e robusta. Pode ser escondido quando dobrado. Este é um SILVER classificado, e assim tem poder penetrativo decente."
	icon_state = "telebaton_silver"
	stun_armour_penetration = 30 // strong enough to pen sec armor

/obj/item/melee/baton/telescopic/gold
	name = "gold-capped telescopic baton"
	desc = "Uma arma de defesa pessoal compacta e robusta. Pode ser escondido quando dobrado. Este é classificado como GOLD, e assim tem excepcional poder penetrativo."
	icon_state = "telebaton_gold"
	stun_armour_penetration = 50 // strong enough to pen syndicate modsuits

/obj/item/melee/baton/telescopic/contractor_baton
	name = "contractor baton"
	desc = "Um bastão de choque telescópico de alta tecnologia, desenvolvido pelas Indústrias Cybersun. Dá um choque preciso ao sistema nervoso central do alvo para incapacitá-los."
	icon = 'icons/obj/weapons/baton.dmi'
	icon_state = "contractor_baton"
	worn_icon_state = "contractor_baton"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	item_flags = NONE
	force = 5
	cooldown = 2.5 SECONDS
	force_say_chance = 80 //very high force say chance because it's funny
	stamina_damage = 85
	stun_armour_penetration = 30 // strong enough to pen sec armor
	clumsy_knockdown_time = 24 SECONDS
	affect_cyborg = TRUE
	wait_desc = "Ainda carregando!"
	on_stun_sound = 'sound/items/weapons/contractor_baton/contractorbatonhit.ogg'
	unfolded_drop_sound = 'sound/items/baton/contractor_baton_unfolded_pickup.ogg'
	unfolded_pickup_sound = 'sound/items/baton/contractor_baton_unfolded_pickup.ogg'

	on_inhand_icon_state = "contractor_baton_on"
	on_sound = 'sound/items/weapons/contractorbatonextend.ogg'
	active_force = 16

/obj/item/melee/baton/telescopic/contractor_baton/additional_effects_non_cyborg(mob/living/target, mob/living/user)
	. = ..()
	target.set_jitter_if_lower(40 SECONDS * (HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) ? 0.5 : 1))
	target.set_stutter_if_lower(40 SECONDS * (HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) ? 0.5 : 1))

/obj/item/melee/baton/security
	name = "stun baton"
	desc = "O dispositivo de apreensão seguro, desenvolvido por Nanotrasen. Dá um choque preciso ao sistema nervoso central do alvo para incapacitá-los."
	desc_controls = "Left click to stun, right click to harm."
	icon = 'icons/obj/weapons/baton.dmi'
	icon_state = "stunbaton"
	base_icon_state = "stunbaton"
	inhand_icon_state = "stunbaton"
	worn_icon_state = "baton"
	icon_angle = -45
	force = 10
	wound_bonus = 0
	attack_verb_continuous = list("beats")
	attack_verb_simple = list("beat")
	armor_type = /datum/armor/baton_security
	throwforce = 7
	force_say_chance = 50
	stamina_damage = 60
	armour_type_against_stun = ENERGY
	knockdown_time = 5 SECONDS
	clumsy_knockdown_time = 15 SECONDS
	cooldown = 2.5 SECONDS
	on_stun_sound = 'sound/items/weapons/egloves.ogg'
	on_stun_volume = 50
	active = FALSE
	stun_on_harmbaton = TRUE
	wait_desc = "Ainda carregando!"
	activated_word = "activated"
	context_living_rmb_active = "Harmful Stun"
	light_range = 1.5
	light_system = OVERLAY_LIGHT
	light_on = FALSE
	light_color = LIGHT_COLOR_ORANGE
	light_power = 0.5
	var/inactive_drop_sound = 'sound/items/baton/stun_baton_inactive_drop.ogg'
	var/inactive_pickup_sound = 'sound/items/baton/stun_baton_inactive_pickup.ogg'
	var/active_drop_sound = 'sound/items/baton/stun_baton_active_drop.ogg'
	var/active_pickup_sound = 'sound/items/baton/stun_baton_active_pickup.ogg'
	drop_sound = 'sound/items/baton/stun_baton_inactive_drop.ogg'
	pickup_sound = 'sound/items/baton/stun_baton_inactive_pickup.ogg'
	sound_vary = TRUE

	var/throw_stun_chance = 35
	var/obj/item/stock_parts/power_store/cell
	var/preload_cell_type //if not empty the baton starts with this type of cell
	var/cell_hit_cost = STANDARD_CELL_CHARGE
	var/can_remove_cell = TRUE
	var/convertible = TRUE //if it can be converted with a conversion kit
	///Whether or not our inhand changes when active.
	var/active_changes_inhand = TRUE
	///When set, inhand_icon_state defaults to this instead of base_icon_state
	var/base_inhand_state = null

/datum/armor/baton_security
	bomb = 50
	fire = 80
	acid = 80

/obj/item/melee/baton/security/Initialize(mapload)
	. = ..()
	if(preload_cell_type)
		if(!ispath(preload_cell_type, /obj/item/stock_parts/power_store/cell))
			log_mapping("[src] at [AREACOORD(src)] had an invalid preload_cell_type: [preload_cell_type].")
		else
			cell = new preload_cell_type(src)
	RegisterSignal(src, COMSIG_ATOM_ATTACKBY, PROC_REF(convert))
	update_appearance()

/obj/item/melee/baton/security/get_cell()
	return cell

/obj/item/melee/baton/security/suicide_act(mob/living/user)
	if(cell?.charge && active)
		user.visible_message(span_suicide("[user] é colocar o vivo [name] Em [user.p_their()] Boca! Parece que...[user.p_theyre()] Tentando cometer suicídio!"))
		finalize_baton_attack(user, user)
		return FIRELOSS
	else
		user.visible_message(span_suicide("[user] Está empurrando\the [src] Pela garganta dele! Parece que...[user.p_theyre()] Tentando cometer suicídio!"))
		return OXYLOSS

/obj/item/melee/baton/security/Destroy()
	if(cell)
		QDEL_NULL(cell)
	UnregisterSignal(src, COMSIG_ATOM_ATTACKBY)
	return ..()

/obj/item/melee/baton/security/proc/convert(datum/source, obj/item/item, mob/user)
	SIGNAL_HANDLER

	if(!istype(item, /obj/item/conversion_kit) || !convertible)
		return
	var/turf/source_turf = get_turf(src)
	var/obj/item/melee/baton/baton = new (source_turf)
	baton.alpha = 20
	playsound(source_turf, 'sound/items/tools/drill_use.ogg', 80, TRUE, -1)
	animate(src, alpha = 0, time = 1 SECONDS)
	animate(baton, alpha = 255, time = 1 SECONDS)
	qdel(item)
	qdel(src)

/obj/item/melee/baton/security/on_saboteur(datum/source, disrupt_duration)
	. = ..()
	if(!active)
		return
	turn_off()
	update_appearance()
	return TRUE

/obj/item/melee/baton/security/Exited(atom/movable/mov_content)
	. = ..()
	if(mov_content == cell)
		cell = null
		turn_off()
		update_appearance()

/obj/item/melee/baton/security/update_icon_state()
	var/base_inhand = base_inhand_state || base_icon_state
	if(active)
		icon_state = "[base_icon_state]_active"
		if(active_changes_inhand)
			inhand_icon_state = "[base_inhand]_active"
		return ..()
	if(!cell)
		icon_state = "[base_icon_state]_nocell"
		inhand_icon_state = base_inhand
		return ..()
	icon_state = base_icon_state
	inhand_icon_state = base_inhand
	return ..()

/obj/item/melee/baton/security/examine(mob/user)
	. = ..()
	if(cell)
		. += span_notice("\The [src] É [round(cell.percent())] Está carregado.")
	else
		. += span_warning("\The [src] não tem uma fonte de energia instalada.")

/obj/item/melee/baton/security/screwdriver_act(mob/living/user, obj/item/tool)
	if(tryremovecell(user))
		tool.play_tool_sound(src)
	return TRUE

/obj/item/melee/baton/security/attackby(obj/item/item, mob/user, list/modifiers, list/attack_modifiers)
	if(istype(item, /obj/item/stock_parts/power_store/cell))
		var/obj/item/stock_parts/power_store/cell/active_cell = item
		if(cell)
			to_chat(user, span_warning("[src] Já tem uma cela!"))
		else
			if(active_cell.maxcharge < cell_hit_cost)
				to_chat(user, span_notice("[src] requer uma célula de maior capacidade."))
				return
			if(!user.transferItemToLoc(item, src))
				return
			cell = item
			to_chat(user, span_notice("Você instala uma célula em [src]."))
			update_appearance()
	else
		return ..()

/obj/item/melee/baton/security/proc/tryremovecell(mob/user)
	if(cell && can_remove_cell)
		cell.forceMove(drop_location())
		to_chat(user, span_notice("Você remove a célula de [src]."))
		return TRUE
	return FALSE

/obj/item/melee/baton/security/attack_self(mob/user)
	if(cell?.charge >= cell_hit_cost && !active)
		turn_on(user)
		balloon_alert(user, "Ligado.")
	else
		turn_off()
		if(!cell)
			balloon_alert(user, "Sem fonte de energia!")
		else if(cell?.charge < cell_hit_cost)
			balloon_alert(user, "Sem carga!")
		else
			balloon_alert(user, "desligado")
	add_fingerprint(user)

/// Toggles the stun baton's light
/obj/item/melee/baton/security/proc/toggle_light()
	set_light_on(!light_on)

/obj/item/melee/baton/security/proc/turn_on(mob/user)
	active = TRUE
	playsound(src, SFX_SPARKS, 75, TRUE, -1)
	update_appearance()
	toggle_light()
	do_sparks(1, TRUE, src)
	drop_sound = active_drop_sound
	pickup_sound = active_pickup_sound

/obj/item/melee/baton/security/proc/turn_off()
	active = FALSE
	set_light_on(FALSE)
	update_appearance()
	playsound(src, SFX_SPARKS, 75, TRUE, -1)
	drop_sound = inactive_drop_sound
	pickup_sound = inactive_pickup_sound

/obj/item/melee/baton/security/proc/deductcharge(deducted_charge)
	if(!cell)
		return
	//Note this value returned is significant, as it will determine
	//if a stun is applied or not
	. = cell.use(deducted_charge)
	if(active && cell.charge < cell_hit_cost)
		//we're below minimum, turn off
		turn_off()

/obj/item/melee/baton/security/try_stun(mob/living/target, mob/living/user, harmbatonning)
	if(!active && !harmbatonning && !user.combat_mode)
		target.visible_message(
			span_warning("[user] Golpes.[target] Com [src] Felizmente estava desligada."),
			span_warning("[user] Te cutuca com [src] Felizmente estava desligada."),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)
		return FALSE

	return ..()

/obj/item/melee/baton/security/baton_effect(mob/living/target, mob/living/user, stun_override, clumsy)
	if(iscyborg(loc))
		var/mob/living/silicon/robot/robot = loc
		if(!robot || !robot.cell || !robot.cell.use(cell_hit_cost))
			return FALSE
	else if(!deductcharge(cell_hit_cost))
		return FALSE
	stun_override = 0 //Avoids knocking people down prematurely.
	return ..()

/*
 * After a target is hit, we apply some status effects.
 * After a period of time, we then check to see what stun duration we give.
 */
/obj/item/melee/baton/security/additional_effects_non_cyborg(mob/living/target, mob/living/user)
	target.set_jitter_if_lower(40 SECONDS * (HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) ? 0.5 : 1))
	target.set_confusion_if_lower(10 SECONDS * (HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) ? 0.5 : 1))
	target.set_stutter_if_lower(16 SECONDS * (HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) ? 0.5 : 1))

	SEND_SIGNAL(target, COMSIG_LIVING_MINOR_SHOCK)
	addtimer(CALLBACK(src, PROC_REF(apply_stun_effect_end), target), 2 SECONDS)

/// After the initial stun period, we check to see if the target needs to have the stun applied.
/obj/item/melee/baton/security/proc/apply_stun_effect_end(mob/living/target)
	var/trait_check = HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) //var since we check it in out to_chat as well as determine stun duration
	if(!target.IsKnockdown())
		to_chat(target, span_warning("Seus músculos se apoderam, fazendo você entrar em colapso.[trait_check ? ", but your body quickly recovers..." : "!"]"))

	if(!trait_check)
		target.Knockdown(knockdown_time)

/obj/item/melee/baton/security/get_stun_description(mob/living/target, mob/living/user)
	. = list()

	.["visible"] = span_danger("[user] ATORDOAMENTOS [target] Com [src]!")
	.["local"] = span_userdanger("[user] Te atordoa com [src]!")

/obj/item/melee/baton/security/get_cyborg_stun_description(mob/living/target, mob/living/user)
	. = ..()
	if(!affect_cyborg)
		.["visible"] = span_danger("[user] Tenta atordoar [target] Com [src] E previsivelmente falha!")
		.["local"] = span_userdanger("[user] Tenta... te atordoar com [src]?")

/obj/item/melee/baton/security/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!. && active && prob(throw_stun_chance) && isliving(hit_atom))
		finalize_baton_attack(hit_atom, throwingdatum?.get_thrower())

/obj/item/melee/baton/security/emp_act(severity)
	. = ..()
	if (!cell)
		return
	if (!(. & EMP_PROTECT_SELF))
		cell.emp_act(severity)

	if (cell.charge >= cell_hit_cost)
		var/scramble_time
		scramble_mode()
		for(var/loops in 1 to rand(6, 12))
			scramble_time = rand(5, 15) / (1 SECONDS)
			addtimer(CALLBACK(src, PROC_REF(scramble_mode)), scramble_time*loops * (1 SECONDS))

/obj/item/melee/baton/security/proc/scramble_mode()
	if (!cell || cell.charge < cell_hit_cost)
		return
	active = !active
	toggle_light()
	do_sparks(1, TRUE, src)
	playsound(src, SFX_SPARKS, 75, TRUE, -1)
	update_appearance()

/obj/item/melee/baton/security/loaded //this one starts with a cell pre-installed.
	preload_cell_type = /obj/item/stock_parts/power_store/cell/high

/obj/item/melee/baton/security/loaded/hos
	preload_cell_type = /obj/item/stock_parts/power_store/cell/super

// Stunsword Skins
/datum/atom_skin/stunsword
	abstract_type = /datum/atom_skin/stunsword
	change_inhand_icon_state = TRUE
	change_base_icon_state = TRUE
	change_worn_icon_state = FALSE

/datum/atom_skin/stunsword/default
	preview_name = "Default"
	new_icon_state = "stunsword"

/datum/atom_skin/stunsword/energy
	preview_name = "Energy"
	new_icon_state = "stunsword_energy"

///Stun Sword
/obj/item/melee/baton/security/stunsword
	name = "\improper NT-20 'Excalibur' Stunsword"
	desc = "É uma espada. Ele atordoa. O que mais você poderia querer?"
	icon_state = "stunsword"
	inhand_icon_state = "stunsword"
	base_icon_state = "stunsword"
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "cut")
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	w_class = WEIGHT_CLASS_HUGE
	sharpness = SHARP_EDGED
	force = 30
	throwforce = 10
	wound_bonus = 0
	exposed_wound_bonus = 30
	stun_armour_penetration = 40
	throw_stun_chance = 60
	convertible = FALSE

	obj_flags = UNIQUE_RENAME

/obj/item/melee/baton/security/stunsword/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/stunsword)

/obj/item/melee/baton/security/stunsword/add_deep_lore()
	return

/obj/item/melee/baton/security/stunsword/loaded
	preload_cell_type = /obj/item/stock_parts/power_store/cell/bluespace // 40% stun_armour_penetration

//Makeshift stun baton. Replacement for stun gloves.
/obj/item/melee/baton/security/cattleprod
	name = "stunprod"
	desc = "Um bastão de choque improvisado."
	desc_controls = "Left click to stun, right click to harm."
	icon = 'icons/obj/weapons/spear.dmi'
	icon_state = "stunprod"
	base_icon_state = "stunprod"
	inhand_icon_state = "prod"
	base_inhand_state = "prod"
	worn_icon_state = null
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	force = 3
	throwforce = 5
	cell_hit_cost = STANDARD_CELL_CHARGE * 2
	throw_stun_chance = 10
	slot_flags = ITEM_SLOT_BACK
	convertible = FALSE
	active_changes_inhand = FALSE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.15, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)
	var/obj/item/assembly/igniter/sparkler
	///Determines whether or not we can improve the cattleprod into a new type. Prevents turning the cattleprod subtypes into different subtypes, or wasting materials on making it....another version of itself.
	var/can_upgrade = TRUE

/obj/item/melee/baton/security/cattleprod/Initialize(mapload)
	. = ..()
	sparkler = new (src)

/obj/item/melee/baton/security/cattleprod/add_deep_lore()
	return

/obj/item/melee/baton/security/cattleprod/attackby(obj/item/item, mob/user, list/modifiers, list/attack_modifiers)//handles sticking a crystal onto a stunprod to make an improved cattleprod
	if(!istype(item, /obj/item/stack))
		return ..()

	if(!can_upgrade)
		user.visible_message(span_warning("Este prod já está melhorado!"))
		return ..()

	if(cell)
		user.visible_message(span_warning("Você não pode colocar o cristal no atordoador enquanto ele tem uma célula de energia instalada!"))
		return ..()

	var/our_prod
	if(istype(item, /obj/item/stack/ore/bluespace_crystal))
		var/obj/item/stack/ore/bluespace_crystal/our_crystal = item
		our_crystal.use(1)
		our_prod = /obj/item/melee/baton/security/cattleprod/teleprod

	else if(istype(item, /obj/item/stack/telecrystal))
		var/obj/item/stack/telecrystal/our_crystal = item
		our_crystal.use(1)
		our_prod = /obj/item/melee/baton/security/cattleprod/telecrystalprod
	else
		to_chat(user, span_notice("Você não acha\the [item] fará qualquer coisa para melhorar.\the [src]."))
		return ..()

	to_chat(user, span_notice("Seu lugar.\the [item] Firme em\the [sparkler]."))
	remove_item_from_storage(user)
	qdel(src)
	var/obj/item/melee/baton/security/cattleprod/brand_new_prod = new our_prod(user.loc)
	user.put_in_hands(brand_new_prod)

/obj/item/melee/baton/security/cattleprod/try_stun(mob/living/target, mob/living/user, harmbatonning)
	return ..() && sparkler.activate()

/obj/item/melee/baton/security/cattleprod/Destroy()
	QDEL_NULL(sparkler)
	return ..()

/obj/item/melee/baton/security/cattleprod/loaded
	preload_cell_type = /obj/item/stock_parts/power_store/cell/high

/obj/item/melee/baton/security/boomerang
	name = "\improper OZtek Boomerang"
	desc = "Um dispositivo inventado em 2486 para a grande guerra Space Emu pela confederação de Australicus, esses bumerangues de alta tecnologia também funcionam excepcionalmente bem em membros de tripulação impressionantes. Só tenha cuidado para pegá-lo quando lançado!"
	throw_speed = 1
	icon = 'icons/obj/weapons/thrown.dmi'
	icon_state = "boomerang"
	base_icon_state = "boomerang"
	inhand_icon_state = "boomerang"
	force = 5
	throwforce = 5
	throw_range = 5
	cell_hit_cost = STANDARD_CELL_CHARGE * 2
	throw_stun_chance = 99  //Have you prayed today?
	convertible = FALSE
	active_changes_inhand = FALSE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT*2, /datum/material/silver = SHEET_MATERIAL_AMOUNT*5, /datum/material/gold = SHEET_MATERIAL_AMOUNT)

/obj/item/melee/baton/security/boomerang/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/boomerang, throw_range + 2, TRUE)

/obj/item/melee/baton/security/boomerang/add_deep_lore()
	return

/obj/item/melee/baton/security/boomerang/loaded //Same as above, comes with a cell.
	preload_cell_type = /obj/item/stock_parts/power_store/cell/high

/obj/item/melee/baton/security/cattleprod/teleprod
	name = "teleprod"
	desc = "Um prod com um cristal azul no final. O cristal não parece muito divertido para tocar."
	w_class = WEIGHT_CLASS_NORMAL
	icon_state = "teleprod"
	base_icon_state = "teleprod"
	inhand_icon_state = "teleprod"
	slot_flags = null
	can_upgrade = FALSE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.15, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)

/obj/item/melee/baton/security/cattleprod/teleprod/baton_effect(mob/living/target, mob/living/user, stun_override, clumsy)
	. = ..()
	if(!. || target.move_resist >= MOVE_FORCE_OVERPOWERING)
		return
	do_teleport(target, get_turf(target), clumsy ? 50 : 15, channel = TELEPORT_CHANNEL_BLUESPACE)

/obj/item/melee/baton/security/cattleprod/telecrystalprod
	name = "snatcherprod"
	desc = "Um prod com um telecristal no final. Ele acende com um desejo de roubo e subversão."
	w_class = WEIGHT_CLASS_NORMAL
	icon_state = "telecrystalprod"
	base_icon_state = "telecrystalprod"
	inhand_icon_state = "telecrystalprod"
	slot_flags = null
	throw_stun_chance = 50 //I think it'd be funny
	can_upgrade = FALSE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.15, /datum/material/telecrystal = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)

/obj/item/melee/baton/security/cattleprod/telecrystalprod/baton_effect(mob/living/target, mob/living/user, stun_override, clumsy)
	. = ..()
	if(!.)
		return
	var/obj/item/stuff_in_hand = target.get_active_held_item()
	if(!user || !stuff_in_hand || !target.temporarilyRemoveItemFromInventory(stuff_in_hand))
		return
	if(user.put_in_inactive_hand(stuff_in_hand))
		stuff_in_hand.loc.visible_message(span_warning("[stuff_in_hand] De arrependimento apareceu em [user] A mão!"))
	else
		stuff_in_hand.forceMove(user.drop_location())
		stuff_in_hand.loc.visible_message(span_warning("[stuff_in_hand] De arrependimento apareceu!"))

	if(clumsy && user.dropItemToGround(src, force = TRUE, silent = TRUE))
		do_teleport(src, get_turf(user), 50, channel = TELEPORT_CHANNEL_BLUESPACE) //Wait, where did it go?

/obj/item/melee/baton/nunchaku
	name = "Syndie Fitness Nunchuks"
	desc = "O equipamento de fitness mais comum em todo o sindicato, hastes de titânio pesam estritamente 13 libras"
	desc_controls = "Left click to stun, right click to harm. Throw mode counterattack any melee/throwable attacks."
	icon_state = "nunchaku"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	inhand_icon_state = "nunchaku"
	worn_icon_state = "nunchaku"
	attack_verb_continuous = list("beats", "whips", "smashes", "punishes")
	attack_verb_simple = list("beat", "whip", "smash", "punish")
	hitsound = 'sound/items/weapons/chainhit.ogg'
	block_sound = 'sound/items/weapons/block_shield.ogg'
	slot_flags = ITEM_SLOT_BELT
	cooldown = CLICK_CD_MELEE
	knockdown_time = 0.25 SECONDS
	demolition_mod = 1.5
	stamina_damage = 30 // 4 hit stamcrit
	stun_armour_penetration = 25 // bronze-silver telescopic
	force = 16 // 7 hit crit
	exposed_wound_bonus = 5

/obj/item/melee/baton/nunchaku/proc/randomize_state()
	icon_state = pick(list("nunchaku", "nunchaku_x", "nunchaku_y"))
	update_appearance()

/obj/item/melee/baton/nunchaku/after_throw(datum/callback/callback)
	. = ..()
	randomize_state()

/obj/item/melee/baton/nunchaku/afterattack(atom/target, mob/user, click_parameters)
	. = ..()
	randomize_state()

/obj/item/melee/baton/nunchaku/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text, final_block_chance, damage, attack_type, damage_type)
	if(attack_type == PROJECTILE_ATTACK || !owner.throw_mode)
		return ..()

	randomize_state()

	// blocks any melee/throwable attacks
	owner.adjust_stamina_loss(5)
	final_block_chance = 100

	// counterattack at melee
	if(attack_type in list(MELEE_ATTACK, UNARMED_ATTACK, LEAP_ATTACK))
		var/mob/living/attacker = GET_ASSAILANT(hitby)
		playsound(src, pick(list('sound/items/weapons/cqchit2.ogg', 'sound/items/weapons/cqchit1.ogg')), 70, FALSE)
		melee_attack_chain(owner, attacker, LEFT_CLICK)

	return ..()

// Deep Lore //

/obj/item/melee/baton/security/add_deep_lore()
	AddElement(/datum/element/examine_lore, 		lore_hint = span_notice("Você pode.[EXAMINE_HINT("look closer")]Para apresentar um poco mais sobre [src]."), 		lore = "O Dispositivo de Apreensão Segura (às vezes referido como o DAU nos manuais de treinamento de oficiais) é a união profana de um maça e um pé de gado. Este dispositivo não letal foi projetado para acabar com rufiões, canalhas, ne'er-do-wells e criminosos onde quer que eles possam levantar suas cabeças feias.<br>		<br>Um símbolo das forças de segurança de Nanotrasen, o bastão de choque é a principal ferramenta que os oficiais empregam contra a escória ilegal e a vilania do Spinward e no exterior. Treinada para \"Baton primeiro, interroga depois\", a segurança de Nanotrasen ganhou uma reputação mista. Capaz de desligar rapidamente o sistema nervoso central de um criminoso com apenas algumas aplicações diretas da cabeça condutora do dispositivo, poucos possíveis encrenqueiros querem encontrar-se no lado errado de um oficial brandindo este bastão.<br>		<br>A polícia de Terragov evitou a adoção de bastões de choque devido a vários dilemas éticos colocados por seu uso, em grande parte devido às ramificações físicas e mentais de longo prazo de ser atingido por um gado humano. Grupos de defesa de direitos dos cidadãos protestam contra a proliferação de morcegos atordoados como uma ferramenta de policiamento, argumentando que eles são 'desumanos' e 'autoritários'. Nanotrasen, por outro lado, não teve tais escrúpulos ao implantar bastões de choque como medida de conformidade em todas as estações e instalações existentes contra membros indisciplinados do pessoal." 	)

// Contractor Baton

/obj/item/melee/baton/telescopic/contractor_baton/add_deep_lore()
	AddElement(/datum/element/examine_lore, 		lore_hint = span_notice("Você pode.[EXAMINE_HINT("look closer")]Para apresentar um poco mais sobre [src]."), 		lore = "O Dispositivo de Aquisição de Contratos (às vezes referido como CAD em correspondência criptografada) é um dos exemplos mais frequentes de armamento das Indústrias Cybersun. Extremamente parecido com o próprio dispositivo de apreensão segura de Nanotrasen (também simplesmente conhecido como bastão de choque), o bastão contratante é capaz de induzir a ruptura do SNC em um alvo para torná-los indefesos. Também é capaz de devastador trauma contundente se usado como um espancamento. O bastão do empreiteiro também é capaz de implantação telescópica, permitindo discrição enquanto faz uma aproximação para um alvo.<br>		<br>O bastão do empreiteiro está associado com empreiteiros, agentes de campo da Cybersun. Enquanto o agente padrão muitas vezes seria encarregado de sabotagem, terrorismo, assassinato ou roubo, empreiteiros têm a tarefa crítica de sequestrar pessoal de alto valor. Qualquer um com potencial para possuir dados confidenciais ou sensíveis sobre sistemas de segurança e dispositivos Nanotrasen pode ser um alvo para Cybersun.<br>		<br>Extrair essa informação é mais fácil em indivíduos vivos. Como tal, o bastão foi projetado com incapacidade não letal em mente. No entanto, as Indústrias Cybersun há muito tempo encontraram soluções para extrair dados do falecido, caso o empreiteiro se encontre com apenas um cadáver para enviar de volta. A morte não pode poupá-lo das maquinações das Indústrias Cybersun se considerarem você um bem valioso para seus objetivos.<br>		<br>Nanotrasen utiliza uma série de contramedidas para insurgências de empreiteiros, tais como empregar memória seletiva limpando ou falsa injeção de memória, a criação de pessoal de comando 'dummy' através da aceleração artificial de membros de outra forma incompetentes mas úteis da tripulação (cuja incompetência muitas vezes resultará em um grau aceitável de interrupção operacional), que fornece bodes expiatórios convenientes no caso de uma quebra de segurança, bem como rotatividade frequente de pessoal e reatribuição." 	)
