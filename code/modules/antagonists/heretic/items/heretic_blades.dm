
/obj/item/melee/sickly_blade
	name = "\improper sickly blade"
	desc = "Uma lâmina crescente verde doente, decorada com um olho ornamental. Você sente que está sendo vigiado..."
	icon = 'icons/obj/weapons/khopesh.dmi'
	icon_state = "eldritch_blade"
	inhand_icon_state = "eldritch_blade"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	force = 20
	throwforce = 10
	wound_bonus = 5
	exposed_wound_bonus = 15
	toolspeed = 0.375
	demolition_mod = 0.8
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	armour_penetration = 35
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "rends")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "rend")
	var/after_use_message = ""
	/// Tracks how many times attack_self() is called so that breaking a blade while in an arena has to be intentional
	var/escape_attempts = 0
	/// Timer that resets your escape_attempts back to 0
	var/escape_timer

/obj/item/melee/sickly_blade/examine(mob/user)
	. = ..()
	if(!check_usability(user))
		return

	. += span_notice("Você pode quebrar a lâmina para se teletransportar para um local aleatório, (principalmente) seguro por<b>ativando na mão.</b>.")

/// Checks if the passed mob can use this blade without being stunned
/obj/item/melee/sickly_blade/proc/check_usability(mob/living/user)
	return IS_HERETIC_OR_MONSTER(user)

/obj/item/melee/sickly_blade/pre_attack(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(.)
		return .
	if(!check_usability(user))
		to_chat(user, span_danger("Você sente um pulso de intelecto alienígena atacando sua mente!"))
		var/mob/living/carbon/human/human_user = user
		human_user.AdjustParalyzed(5 SECONDS)
		return TRUE

	return .

/obj/item/melee/sickly_blade/attack_self(mob/user)
	var/datum/antagonist/heretic/heretic_datum = GET_HERETIC(user)
	if(heretic_datum?.unlimited_blades)
		return
	if(HAS_TRAIT(user, TRAIT_ELDRITCH_ARENA_PARTICIPANT))
		user.balloon_alert(user, "Não posso escapar!")
		if(escape_attempts > 2)
			to_chat(user, span_hypnophrase(span_big("Ovelhas covardes serão massacradas!")))
			playsound(src, SFX_SHATTER, 70, TRUE)
			var/obj/item/bodypart/to_remove = user.get_active_hand()
			to_remove.dismember()
			deltimer(escape_timer)
			qdel(src)
			return
		escape_attempts++
		escape_timer = addtimer(CALLBACK(src, PROC_REF(reset_attempts)), 2 SECONDS, TIMER_STOPPABLE)
		return
	if(HAS_TRAIT(user, TRAIT_NO_TELEPORT))
		user.balloon_alert(user, "Não posso quebrar!")
		return
	seek_safety(user)

/obj/item/melee/sickly_blade/proc/reset_attempts()
	escape_attempts = 0
	deltimer(escape_timer)

/// Attempts to teleport the passed mob to somewhere safe on the station, if they can use the blade.
/obj/item/melee/sickly_blade/proc/seek_safety(mob/user)
	var/turf/safe_turf = find_safe_turf(z, extended_safety_checks = TRUE)
	if(check_usability(user))
		if(do_teleport(user, safe_turf, channel = TELEPORT_CHANNEL_MAGIC))
			to_chat(user, span_warning("Enquanto você quebra[src]Você sente uma rajada de energia fluindo pelo seu corpo.[after_use_message]"))
		else
			to_chat(user, span_warning("Você quebra[src]Mas seu pedido não foi respondido."))
	else
		to_chat(user,span_warning("Você quebra[src]."))
	playsound(src, SFX_SHATTER, 70, TRUE) //copied from the code for smashing a glass sheet onto the ground to turn it into a shard
	qdel(src)

/obj/item/melee/sickly_blade/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	SEND_SIGNAL(user, COMSIG_HERETIC_BLADE_ATTACK, target, src)

/obj/item/melee/sickly_blade/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	SEND_SIGNAL(user, COMSIG_HERETIC_RANGED_BLADE_ATTACK, interacting_with, src)
	return ITEM_INTERACT_BLOCKING

// Path of Rust's blade
/obj/item/melee/sickly_blade/rust
	name = "\improper rusted blade"
	desc = "Esta lâmina crescente está decrépita, desperdiçando para enferrujar. Mas ainda morde, rasgando carne e osso com dentes podres."
	icon_state = "rust_blade"
	inhand_icon_state = "rust_blade"
	after_use_message = "As Colinas Rusted ouvem seu chamado..."

// Path of Ash's blade
/obj/item/melee/sickly_blade/ash
	name = "\improper ashen blade"
	desc = "Derretido e em bruto, um pedaço de metal dobrado em cinzas e escória. Desfeito, aspira ser mais do que é, e tesouras feridas cheias de fuligem com uma borda contundente."
	icon_state = "ash_blade"
	inhand_icon_state = "ash_blade"
	after_use_message = "O Observador da Noite ouve seu chamado..."
	resistance_flags = FIRE_PROOF

// Path of Flesh's blade
/obj/item/melee/sickly_blade/flesh
	name = "\improper bloody blade"
	desc = "Uma lâmina crescente nascida de uma criatura de carne. Conscientes, ele procura espalhar para os outros o sofrimento que ele suportou de suas terríveis origens."
	icon_state = "flesh_blade"
	inhand_icon_state = "flesh_blade"
	after_use_message = "O Marechal ouve sua chamada..."

/obj/item/melee/sickly_blade/flesh/Initialize(mapload)
	. = ..()

	AddComponent(
		/datum/component/blood_walk,		blood_type = /obj/effect/decal/cleanable/blood,		blood_spawn_chance = 66.6,		max_blood = INFINITY,	)

	AddComponent(
		/datum/component/bloody_spreader,		blood_dna = list("Alien DNA" = get_blood_type(BLOOD_TYPE_XENO)),	)

// Path of Void's blade
/obj/item/melee/sickly_blade/void
	name = "\improper void blade"
	desc = "Devoto de qualquer substância, esta lâmina reflete nada. É uma verdadeira representação da pureza, e caos que se segue após sua implementação."
	icon_state = "void_blade"
	inhand_icon_state = "void_blade"
	after_use_message = "O Aristocrata ouve seu chamado..."

// Path of the Blade's... blade.
// Opting for /dark instead of /blade to avoid "sickly_blade/blade".
/obj/item/melee/sickly_blade/dark
	name = "\improper sundered blade"
	desc = "Uma lâmina galiante, enfeitada e rasgada. Furiosamente, a lâmina corta. Cicatrizes de prata a ligam para sempre ao seu propósito sombrio."
	icon_state = "dark_blade"
	base_icon_state = "dark_blade"
	inhand_icon_state = "dark_blade"
	after_use_message = "O Campeão da Tortura ouve seu chamado..."
	///If our blade is currently infused with the mansus grasp
	var/infused = FALSE

/obj/item/melee/sickly_blade/dark/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(!infused || target == user || !isliving(target) || QDELETED(target))
		return
	var/datum/antagonist/heretic/heretic_datum = GET_HERETIC(user)
	var/mob/living/living_target = target
	if(!heretic_datum)
		return

	// Apply our heretic mark
	var/datum/heretic_knowledge/limited_amount/starting/base_blade/mark_to_apply = heretic_datum.get_knowledge(/datum/heretic_knowledge/limited_amount/starting/base_blade)
	if(!mark_to_apply)
		return
	mark_to_apply.create_mark(user, living_target)
	infused = FALSE
	update_appearance(UPDATE_ICON)
	user.update_held_items()

	if(!check_behind(user, living_target))
		return
	// We're officially behind them, apply effects
	living_target.AdjustParalyzed(1.5 SECONDS)
	living_target.apply_damage(10, BRUTE, wound_bonus = CANT_WOUND)
	living_target.balloon_alert(user, "Apunhalar as costas!")
	playsound(living_target, 'sound/items/weapons/guillotine.ogg', 100, TRUE)

/obj/item/melee/sickly_blade/dark/dropped(mob/user, silent)
	. = ..()
	if(infused)
		infused = FALSE
		update_appearance(UPDATE_ICON)

/obj/item/melee/sickly_blade/dark/update_icon_state()
	. = ..()
	if(infused)
		icon_state = base_icon_state + "_infused"
		inhand_icon_state = base_icon_state + "_infused"
	else
		icon_state = base_icon_state
		inhand_icon_state = base_icon_state

// Path of Cosmos's blade
/obj/item/melee/sickly_blade/cosmic
	name = "\improper cosmic blade"
	desc = "Um mote de ressonância celestial, moldado em uma lâmina tecida por estrelas. Um exílio iridescente, esculpindo trilhas radiantes, buscando desesperadamente a unificação."
	icon_state = "cosmic_blade"
	inhand_icon_state = "cosmic_blade"
	after_use_message = "O Stargazer ouve seu chamado..."

// Path of Knock's blade
/obj/item/melee/sickly_blade/lock
	name = "\improper key blade"
	desc = "Uma lâmina e uma chave, uma chave para o quê? Que grandes portões ele abre?"
	icon_state = "key_blade"
	inhand_icon_state = "key_blade"
	after_use_message = "Os Stewards ouvem seu chamado..."
	tool_behaviour = TOOL_CROWBAR
	toolspeed = 1.3

// Path of Moon's blade
/obj/item/melee/sickly_blade/moon
	name = "\improper moon blade"
	desc = "Uma lâmina de ferro, refletindo a verdade da terra, todos se unam à trupe um dia. Uma trupe trazendo alegria, esculpindo sorrisos em seus rostos se quiserem ou não."
	icon_state = "moon_blade"
	inhand_icon_state = "moon_blade"
	after_use_message = "A Lua ouve seu chamado..."

// Path of Nar'Sie's blade
// What!? This blade is given to cultists as an altar item when they sacrifice a heretic.
// It is also given to the heretic themself if they sacrifice a cultist.
/obj/item/melee/sickly_blade/cursed
	name = "\improper cursed blade"
	desc = "Uma lâmina escura, amaldiçoada para sangrar para sempre. Em constante luta entre o eldritch e o escuro, é forçado a aceitar qualquer empunhador como seu mestre. A córnea do olho pinga sangue para o chão, mas seu olhar penetrante permanece em você."
	force = 25
	throwforce = 15
	block_chance = 35
	wound_bonus = 25
	exposed_wound_bonus = 15
	armour_penetration = 35
	icon_state = "cursed_blade"
	inhand_icon_state = "cursed_blade"

/obj/item/melee/sickly_blade/cursed/Initialize(mapload)
	. = ..()

	var/examine_text = {"Allows the scribing of blood runes of the cult of Nar'Sie.
	The combination of eldritch power and Nar'Sie's might allows for vastly increased rune drawing speed,
	alongside the vicious strength of the blade being more powerful than usual.\n
	<b>It can also be shattered in-hand by cultists (via right-click), teleporting them to relative safety.<b>"}

	AddComponent(/datum/component/cult_ritual_item, span_cult(examine_text), turfs_that_boost_us = /turf) // Always fast to draw!

/obj/item/melee/sickly_blade/cursed/attack_self_secondary(mob/user)
	seek_safety(user, TRUE)

/obj/item/melee/sickly_blade/cursed/seek_safety(mob/user, secondary_attack = FALSE)
	if(IS_CULTIST(user) && !secondary_attack)
		return FALSE
	return ..()

/obj/item/melee/sickly_blade/cursed/check_usability(mob/living/user)
	if(IS_HERETIC_OR_MONSTER(user) || IS_CULTIST(user))
		return TRUE
	if(prob(15))
		to_chat(user, span_cult_large(pick("\"Uma mente intocada? Divertido.\"", "\"Suponho que não vale a pena o esforço para impedi-lo.\"", "\"Vá em frente. Não me importo.\"", "\"Você será meu em breve.\"")))
		user.apply_damage(5, BURN, user.get_active_hand())
		playsound(src, SFX_SEAR, 25, TRUE)
		to_chat(user, span_danger("Sua mão se cala.")) // Nar nar might not care but their essence still doesn't like you
	else if(prob(15))
		to_chat(user, span_big(span_hypnophrase("LW'NAFH'NAHOR UH'ENAH'YMG EPGOKA AH NAFL MGEMPGAH'EHYE")))
		to_chat(user, span_danger("Horríveis e ininteligíveis declarações inundam sua mente!"))
		user.adjust_organ_loss(ORGAN_SLOT_BRAIN, 15) // This can kill you if you ignore it
	return TRUE

/obj/item/melee/sickly_blade/cursed/equipped(mob/user, slot)
	. = ..()
	if(IS_HERETIC_OR_MONSTER(user))
		after_use_message = "O Mansus ouve seu chamado..."
	else if(IS_CULTIST(user))
		after_use_message = "Nar'Sie ouve seu chamado..."
	else
		after_use_message = null

/obj/item/melee/sickly_blade/cursed/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	. = ..()

	var/datum/antagonist/heretic/heretic_datum = GET_HERETIC(user)
	if(!heretic_datum)
		return NONE

	// Can only carve runes with it if off combat mode.
	if(isopenturf(target) && !user.combat_mode)
		heretic_datum.try_draw_rune(user, target, drawing_time = 14 SECONDS) // Faster than pen, slower than cicatrix
		return ITEM_INTERACT_BLOCKING
	return NONE

/obj/item/melee/sickly_blade/cursed/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == OVERWHELMING_ATTACK)
		return FALSE
	return ..()

// Weaker blade variant given to people so they can participate in the heretic arena spell
/obj/item/melee/sickly_blade/training
	name = "\improper imperfect blade"
	desc = "Uma lâmina dada àqueles que não podem aceitar a verdade, por pena. Que aja como uma bênção no curto espaço de tempo que permanece ao seu lado."
	force = 17
	armour_penetration = 0

/obj/item/melee/sickly_blade/training/check_usability(mob/living/user)
	return TRUE // If you can hold this, you can use it
