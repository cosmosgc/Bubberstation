/obj/item/gun/ballistic/revolver
	name = "\improper .357 revolver"
	desc = "Um revólver suspeito. Usa munição .357."
	icon_state = "revolver"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder
	fire_sound = 'sound/items/weapons/gun/revolver/shot_alt.ogg'
	load_sound = 'sound/items/weapons/gun/revolver/load_bullet.ogg'
	eject_sound = 'sound/items/weapons/gun/revolver/empty.ogg'
	fire_sound_volume = 90
	dry_fire_sound = 'sound/items/weapons/gun/revolver/dry_fire.ogg'
	casing_ejector = FALSE
	internal_magazine = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	tac_reloads = FALSE
	var/spin_delay = 10
	var/recent_spin = 0
	var/last_fire = 0

/obj/item/gun/ballistic/revolver/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)
	. = ..()
	if(.)
		last_fire = world.time

/obj/item/gun/ballistic/revolver/chamber_round(spin_cylinder = TRUE, replace_new_round)
	if(!magazine) //if it mag was qdel'd somehow.
		CRASH("revolver tried to chamber a round without a magazine!")
	if(chambered)
		UnregisterSignal(chambered, COMSIG_MOVABLE_MOVED)
	if (spin_cylinder)
		chambered = magazine.get_round()
	else
		chambered = magazine.stored_ammo[1]
		if (ispath(chambered))
			chambered = new chambered(src)
			magazine.stored_ammo[1] = chambered
	if(chambered)
		RegisterSignal(chambered, COMSIG_MOVABLE_MOVED, PROC_REF(clear_chambered))

/obj/item/gun/ballistic/revolver/shoot_with_empty_chamber(mob/living/user as mob|obj)
	..()
	chamber_round()

/obj/item/gun/ballistic/revolver/click_alt(mob/user)
	spin()
	return CLICK_ACTION_SUCCESS

/obj/item/gun/ballistic/revolver/fire_sounds()
	var/frequency_to_use = sin((90/magazine?.max_ammo) * get_ammo(TRUE, FALSE)) // fucking REVOLVERS
	var/click_frequency_to_use = 1 - frequency_to_use * 0.75
	var/play_click = sqrt(magazine?.max_ammo) > get_ammo(TRUE, FALSE)
	if(suppressed)
		playsound(src, suppressed_sound, suppressed_volume, vary_fire_sound, ignore_walls = FALSE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_distance = 0)
		if(play_click)
			playsound(src, 'sound/items/weapons/gun/general/ballistic_click.ogg', suppressed_volume, vary_fire_sound, ignore_walls = FALSE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_distance = 0, frequency = click_frequency_to_use)
	else
		playsound(src, fire_sound, fire_sound_volume, vary_fire_sound)
		if(play_click)
			playsound(src, 'sound/items/weapons/gun/general/ballistic_click.ogg', fire_sound_volume, vary_fire_sound, frequency = click_frequency_to_use)

/obj/item/gun/ballistic/revolver/verb/spin()
	set name = "Spin Chamber"
	var/mob/user = usr

	if(user.stat || !in_range(user, src))
		return

	if (recent_spin > world.time)
		return
	recent_spin = world.time + spin_delay

	if(do_spin())
		playsound(usr, SFX_REVOLVER_SPIN, 30, FALSE)
		visible_message(span_notice("[user] gira [src] Câmara."), span_notice("Você gira [src] Câmara."))
		balloon_alert(user, "Câmara girada")
	else
		verbs -= /obj/item/gun/ballistic/revolver/verb/spin

/obj/item/gun/ballistic/revolver/proc/do_spin()
	var/obj/item/ammo_box/magazine/internal/cylinder/C = magazine
	. = istype(C)
	if(.)
		C.spin()
		chamber_round(spin_cylinder = FALSE)

/obj/item/gun/ballistic/revolver/get_ammo(countchambered = FALSE, countempties = TRUE)
	var/boolets = 0 //mature var names for mature people
	if (chambered && countchambered)
		boolets++
	if (magazine)
		boolets += magazine.ammo_count(countempties)
	return boolets

/obj/item/gun/ballistic/revolver/examine(mob/user)
	. = ..()
	var/live_ammo = get_ammo(FALSE, FALSE)
	. += "[live_ammo ? live_ammo : "None"] of those are live rounds."
	. += span_notice("Pode ser girado com[EXAMINE_HINT("alt-click")].")

/obj/item/gun/ballistic/revolver/ignition_effect(atom/A, mob/user)
	if(last_fire && last_fire + 15 SECONDS > world.time)
		return span_rose("[user] toca o fim de [src] para\the [A], usando o calor residual para incendiá-lo em um sopro de fumaça. Que fodão.")

/obj/item/gun/ballistic/revolver/c38
	name = "\improper .38 revolver"
	desc = "Um clássico, se não ultrapassado, arma de fogo letal. Usa .38 balas especiais."
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rev38
	icon_state = "c38"
	base_icon_state = "c38"
	fire_sound = 'sound/items/weapons/gun/revolver/shot.ogg'

// 38 special skins
/datum/atom_skin/det_revolver
	abstract_type = /datum/atom_skin/det_revolver
	change_base_icon_state = TRUE

/datum/atom_skin/det_revolver/default
	preview_name = "Default"
	new_icon_state = "c38"

/datum/atom_skin/det_revolver/fitz_special
	preview_name = "Fitz Special"
	new_icon_state = "c38_fitz"

/datum/atom_skin/det_revolver/police_positive_special
	preview_name = "Police Positive Special"
	new_icon_state = "c38_police"

/datum/atom_skin/det_revolver/blued_steel
	preview_name = "Blued Steel"
	new_icon_state = "c38_blued"

/datum/atom_skin/det_revolver/stainless_steel
	preview_name = "Stainless Steel"
	new_icon_state = "c38_stainless"

/datum/atom_skin/det_revolver/gold_trim
	preview_name = "Gold Trim"
	new_icon_state = "c38_trim"

/datum/atom_skin/det_revolver/golden
	preview_name = "Golden"
	new_icon_state = "c38_gold"

/datum/atom_skin/det_revolver/peacemaker
	preview_name = "The Peacemaker"
	new_icon_state = "c38_peacemaker"

/datum/atom_skin/det_revolver/black_panther
	preview_name = "Black Panther"
	new_icon_state = "c38_panther"

/obj/item/gun/ballistic/revolver/c38/detective
	name = "\improper Colt Detective Special"
	desc = "Uma arma de fogo clássica, se não ultrapassada. Usa .38 balas especiais.\nAlguns rumores espalhados que se você soltar o barril com uma chave inglesa, você pode\"Melhorar\"Ele."

	can_modify_ammo = TRUE
	initial_caliber = CALIBER_38
	initial_fire_sound = 'sound/items/weapons/gun/revolver/shot.ogg'
	alternative_caliber = CALIBER_357
	alternative_fire_sound = 'sound/items/weapons/gun/revolver/shot_alt.ogg'
	alternative_ammo_misfires = TRUE
	misfire_probability = 0
	misfire_percentage_increment = 25 //about 1 in 4 rounds, which increases rapidly every shot

	obj_flags = UNIQUE_RENAME

/obj/item/gun/ballistic/revolver/c38/detective/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/det_revolver)

/obj/item/gun/ballistic/revolver/badass
	name = "\improper Badass Revolver"
	desc = "Um revólver de 7 câmaras fabricado pela Waffle Corp para fazer seus agentes se sentirem fodas. Não oferece nenhuma vantagem tática. Usa munição .357."
	icon_state = "revolversyndie"

/obj/item/gun/ballistic/revolver/badass/nuclear
	pin = /obj/item/firing_pin/implant/pindicate

/obj/item/gun/ballistic/revolver/cowboy
	desc = "Um revólver clássico, remodelado para uso moderno. Usa munição .357."
	//There's already a cowboy sprite in there!
	icon_state = "lucky"

/obj/item/gun/ballistic/revolver/cowboy/nuclear
	pin = /obj/item/firing_pin/implant/pindicate

/obj/item/gun/ballistic/revolver/mateba
	name = "\improper Unica 6 auto-revolver"
	desc = "Um autorrevolver retro potente normalmente usado por oficiais do exército da Nova Rússia. Usa munição .357."
	icon_state = "mateba"

/obj/item/gun/ballistic/revolver/golden
	name = "\improper Golden revolver"
	desc = "Isto não é um jogo, nunca foi um show, e terei prazer em matar a senhora mais velha que conhece. Usa munição .357."
	icon_state = "goldrevolver"
	fire_sound = 'sound/items/weapons/resonator_blast.ogg'
	recoil = 8
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/revolver/nagant
	name = "\improper Nagant revolver"
	desc = "Um velho modelo de revólver que se originou na Rússia. Capaz de ser suprimida. Usa munição 7.62x38mmR."
	icon_state = "nagant"
	can_suppress = TRUE

	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rev762


// A gun to play Russian Roulette!
// You can spin the chamber to randomize the position of the bullet.

/obj/item/gun/ballistic/revolver/russian
	name = "\improper Russian revolver"
	desc = "Um revólver russo para jogos de bebida. Usa munição .357, e tem um mecanismo que requer que você gire a câmara antes de cada gatilho puxar."
	icon_state = "russianrevolver"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rus357
	hidden_chambered = TRUE //Cheater.
	gun_flags = NOT_A_REAL_GUN
	can_hold_up = FALSE // for obvious reasons
	doafter_self_shoot = FALSE // snowflake
	/// If we've been spun before firing
	var/spun = FALSE
	/// Do after for trying to fire the gun
	var/aim_time = 4 SECONDS

/obj/item/gun/ballistic/revolver/russian/examine(mob/user)
	. = ..()
	. += span_notice("Você pode mudar o comprimento da sua pausa antes de puxar o gatilho com[EXAMINE_HINT("alt-right-click")].")

/obj/item/gun/ballistic/revolver/russian/click_alt_secondary(mob/user)
	if(loc != user)
		to_chat(user, span_warning("Precisa segurar a arma para determinar quanto tempo vai parar!"))
		return CLICK_ACTION_BLOCKING
	var/new_aim_time = tgui_input_number(user, "How long will you pause before pulling the trigger (seconds)?", "Do you feel lucky?", (aim_time / (1 SECONDS)), 10, 0)
	if(loc != user || user.incapacitated)
		return CLICK_ACTION_BLOCKING
	aim_time = new_aim_time * (1 SECONDS)
	to_chat(user, span_warning("Você vai parar.[aim_time] Segundo antes de puxar o gatilho[aim_time == 0 ? "... Good luck" : ""]."))
	return CLICK_ACTION_SUCCESS

/obj/item/gun/ballistic/revolver/russian/dropped(mob/user, silent)
	. = ..()
	aim_time = initial(aim_time) // next person chooses their own time

/obj/item/gun/ballistic/revolver/russian/do_spin()
	. = ..()
	if(.)
		spun = TRUE

/obj/item/gun/ballistic/revolver/russian/can_shoot()
	return TRUE // we ALWAYS want to shoot. even if we don't have a chambered round, even if our chambered round has no bullet

/obj/item/gun/ballistic/revolver/russian/load_gun(obj/item/ammo, mob/living/user)
	. = ..()
	if(!.)
		return
	do_spin()

/obj/item/gun/ballistic/revolver/russian/can_trigger_gun(mob/living/user, akimbo_usage)
	if(akimbo_usage)
		return FALSE
	return ..()

/obj/item/gun/ballistic/revolver/russian/attack_self(mob/user)
	if(!spun)
		spin()
		return TRUE
	return ..()

/obj/item/gun/ballistic/revolver/russian/handle_chamber(empty_chamber = TRUE, from_firing = TRUE, chamber_next_round = TRUE)
	from_firing = FALSE // never eject casings from firing the gun
	return ..()

/obj/item/gun/ballistic/revolver/russian/try_fire_gun(atom/target, mob/living/user, params)
	if(user.combat_mode)
		return FALSE // melee attack
	if(target != user)
		shoot_with_empty_chamber(user)
		spun = FALSE
		user.visible_message(
			span_danger("[user] Tenta atirar\the [src] mirar em outra coisa, mas só consegue parecer um idiota."),
			span_danger("\The [src] O mecanismo anti-combate o impede de atirar em qualquer um além de você mesmo!"),
		)
		return TRUE // no melee attack
	if(!spun)
		to_chat(user, span_warning("Você precisa girar\the [src] A câmara primeiro!"))
		return TRUE // no melee attack
	if(HAS_TRAIT(user, TRAIT_CURSED)) // I cannot live, I cannot die, trapped in myself, body my holding cell.
		to_chat(user, span_warning("Que noite horrível... Ter uma maldição!"))
		return TRUE // no melee attack
	if(loc != user)
		if(tk_firing(user))
			to_chat(user, span_warning("Roleta russa é estressante o suficiente sem tentar se concentrar na telecinese!"))
		else
			to_chat(user, span_warning("Você precisa segurar a arma para atirar!"))
		return TRUE // no melee attack

	return ..() // try to shoot the gun

// Replaces clumsy check with a do after
/obj/item/gun/ballistic/revolver/russian/check_botched(mob/living/user, atom/target)
	if(aim_time <= 0)
		return FALSE
	user.visible_message(
		span_danger("[user] Objetivos\the [src] em [user.p_their()] [parse_zone(user.zone_selected)]..."),
		span_userdanger("Você aponta\the [src] em seu [parse_zone(user.zone_selected)]..."),
		visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
	)
	if(prob(10) && !HAS_TRAIT(user, TRAIT_FEARLESS))
		user.adjust_jitter(aim_time)
	if(!do_after(user, aim_time, target))
		if(!user.incapacitated)
			user.visible_message(
				span_danger("[user] perde [user.p_their()] Enerva e coloca\the [src] Abaixe-se."),
				span_userdanger("Você perde a coragem e coloca\the [src] Abaixe-se."),
				visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
			)
		return TRUE
	return FALSE

/obj/item/gun/ballistic/revolver/russian/before_firing(atom/target, mob/user)
	if(target != user)
		CRASH("Russian revolver somehow got to before_firing with a target that isn't the user!")
	// we will definitely have a chambered round, but not always projectile
	if(check_zone(user.zone_selected) == BODY_ZONE_HEAD)
		chambered.loaded_projectile?.damage = 300
		chambered.loaded_projectile?.wound_bonus = 100
	else
		chambered.loaded_projectile?.damage = 80
		chambered.loaded_projectile?.wound_bonus = 10

/obj/item/gun/ballistic/revolver/russian/fire_gun(atom/target, mob/living/user, flag, params)
	// . = false = no shot fired
	. = ..()
	spun = FALSE
	var/is_target_face = check_zone(user.zone_selected) == BODY_ZONE_HEAD
	var/aimed_at_readable = parse_zone(user.zone_selected)
	var/loaded_rounds = get_ammo(FALSE, FALSE) // check before it is fired
	if(loaded_rounds && is_target_face)
		add_memory_in_range(user, 7, /datum/memory/witnessed_russian_roulette, 			protagonist = user, 			antagonist = src, 			rounds_loaded = loaded_rounds, 			aimed_at = aimed_at_readable, 			result = (. ? "lost" : "won"), 		)

	if(!.)
		if(loaded_rounds && is_target_face)
			user.add_mood_event("russian_roulette_win", /datum/mood_event/russian_roulette_win, loaded_rounds)
		user.visible_message(
			span_danger("[user][is_target_face ? "": " cowardly"]Pontos\the [src] em [user.p_their()] [aimed_at_readable], puxa o gatilho, e ... nada acontece!"),
			span_danger("Você.[is_target_face ? "": " cowardly"]Ponto\the [src] em seu [aimed_at_readable], puxe o gatilho, e ... nada acontece!"),
			span_hear("Você ouve um clique!"),
			vision_distance = COMBAT_MESSAGE_RANGE,
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)
		return TRUE // so they don't hit themselves in the forehead. because returning FALSE translates to "do melee attack" for whatever reason

	user.visible_message(
		span_danger("[user][is_target_face ? "": " cowardly"]Objetivos\the [src] em [user.p_their()] [aimed_at_readable] Quando ele explodir!"),
		span_danger("Você.[is_target_face ? "": " cowardly"]Apontar\the [src] em seu [aimed_at_readable] Quando ele explodir![user.stat >= HARD_CRIT ? " <b>Everything suddenly goes black.</b>" : ""]"),
		span_hear("Você ouve um grunhido[user.stat == CONSCIOUS ? "" : ", followed by a thud"]!"),
		vision_distance = COMBAT_MESSAGE_RANGE,
		visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
	)
	shoot_self(user, check_zone(user.zone_selected))
	return .

/obj/item/gun/ballistic/revolver/russian/on_mail_unwrap(atom/source, mob/user, obj/item/mail/traitor/letter)
	if((get_ammo(FALSE, FALSE) > 1) || (get_ammo(TRUE, TRUE) < 6))
		return NONE
	return ..()

/// Called after successfully(if you can call it that) shooting ourselves
/obj/item/gun/ballistic/revolver/russian/proc/shoot_self(mob/living/carbon/human/user, affecting = BODY_ZONE_HEAD)
	user.add_mood_event(
		"russian_roulette_lose",
		affecting == BODY_ZONE_HEAD ? /datum/mood_event/russian_roulette_lose : /datum/mood_event/russian_roulette_lose_cheater,
	)

/obj/item/gun/ballistic/revolver/russian/soul
	name = "cursed Russian revolver"
	desc = "Jogar com este revólver requer apostar sua alma."

/obj/item/gun/ballistic/revolver/russian/soul/shoot_self(mob/living/user, affecting = BODY_ZONE_HEAD)
	. = ..()
	if(affecting == BODY_ZONE_HEAD)
		var/obj/item/soulstone/anybody/revolver/stone = new(user.drop_location())
		if(!stone.capture_soul(user, forced = TRUE)) //Something went wrong
			qdel(stone)
			return
		user.visible_message(
			span_danger("[user] A alma é capturada por\the [src]!"),
			span_userdanger("Você perdeu a aposta! Sua alma está perdida!"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)
		return

	user.visible_message(
		span_danger("[user] é punido por tentar enganar o jogo!"),
		span_userdanger("Você perdeu a aposta! Não só sua alma está perdida, mas é levada para longe por tentar enganar a morte!"),
		visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
	)
	user.dust(drop_items = TRUE)

/obj/item/gun/ballistic/revolver/reverse //Fires directly at its user... unless the user is a clown, of course.
	clumsy_check = FALSE

/obj/item/gun/ballistic/revolver/reverse/can_trigger_gun(mob/living/user, akimbo_usage)
	if(akimbo_usage)
		return FALSE
	if(HAS_TRAIT(user, TRAIT_CLUMSY) || is_clown_job(user.mind?.assigned_role))
		return ..()
	if(process_fire(user, user, FALSE, null, BODY_ZONE_HEAD))
		user.visible_message(span_warning("[user] De alguma forma consegue atirar [user.p_them()] Na cara!"), span_userdanger("De alguma forma você atira na sua cara! Como diabos?"))
		user.emote("scream")
		user.drop_all_held_items()
		user.Paralyze(80)

/obj/item/gun/ballistic/revolver/reverse/mateba
	name = /obj/item/gun/ballistic/revolver/mateba::name
	desc = /obj/item/gun/ballistic/revolver/mateba::desc
	clumsy_check = FALSE
	icon_state = "mateba"

/obj/item/gun/ballistic/revolver/peashooter
	name = "peashooter"
	icon_state = "peashooter"
	desc = "Uma mutação vegetal selvagem que atira ervilhas endurecidas. Incrível."
	fire_sound = 'sound/items/weapons/peashoot.ogg'
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/peashooter
