/// how many units of blood one charge of blood rites is worth
#define USES_TO_BLOOD 2
/// blood rites charges gained from sapping blood from a victim
#define BLOOD_DRAIN_GAIN 50
/// penalty for self healing, 1 point of damage * this # = charges required
#define SELF_HEAL_PENALTY 1.65

/datum/action/innate/cult/blood_magic //Blood magic handles the creation of blood spells (formerly talismans)
	name = "Prepare Blood Magic"
	button_icon_state = "carve"
	desc = "Prepare magia de sangue esculpindo runas em sua carne. Isso é mais fácil com um<b>Empoderando runa</b>."
	default_button_position = DEFAULT_BLOODSPELLS
	var/list/spells = list()
	var/channeling = FALSE
	/// If the magic has been enhanced somehow, likely due to a crimson medallion.
	var/magic_enhanced = FALSE

/datum/action/innate/cult/blood_magic/Remove()
	for(var/X in spells)
		qdel(X)
	..()

/datum/action/innate/cult/blood_magic/IsAvailable(feedback = FALSE)
	if(!IS_CULTIST(owner))
		return FALSE
	return ..()

/datum/action/innate/cult/blood_magic/proc/Positioning()
	for(var/datum/hud/hud as anything in viewers)
		var/our_view = hud.mymob?.canon_client?.view || "15x15"
		var/atom/movable/screen/movable/action_button/button = viewers[hud]
		var/position = screen_loc_to_offset(button.screen_loc)
		var/list/position_list = list()
		for(var/possible_position in 1 to magic_enhanced ? ENHANCED_BLOODCHARGE : MAX_BLOODCHARGE)
			position_list += possible_position
		for(var/datum/action/innate/cult/blood_spell/blood_spell in spells)
			if(blood_spell.positioned)
				position_list.Remove(blood_spell.positioned)
				continue
			var/atom/movable/screen/movable/action_button/moving_button = blood_spell.viewers[hud]
			if(!moving_button)
				continue
			var/first_available_slot = position_list[1]
			var/our_x = position[1] + first_available_slot * ICON_SIZE_X // Offset any new buttons into our list
			hud.position_action(moving_button, offset_to_screen_loc(our_x, position[2], our_view))
			blood_spell.positioned = first_available_slot

/datum/action/innate/cult/blood_magic/Activate()
	var/rune = FALSE
	var/limit = RUNELESS_MAX_BLOODCHARGE
	for(var/obj/effect/rune/empower/R in range(1, owner))
		rune = TRUE
		break
	if(rune)
		limit = magic_enhanced ? ENHANCED_BLOODCHARGE : MAX_BLOODCHARGE
	if(length(spells) >= limit)
		if(rune)
			to_chat(owner, span_cult_italic("Você não pode armazenar mais do que [limit] Feitiços.<b>Escolha um feitiço para remover.</b>"))
		else
			to_chat(owner, span_cult_bold_italic("<u>Você não pode armazenar mais do que [RUNELESS_MAX_BLOODCHARGE] feitiços sem uma runa poderosa! Escolha um feitiço para remover.</u>"))
		var/nullify_spell = tgui_input_list(owner, "Spell to remove", "Current Spells", spells)
		if(isnull(nullify_spell))
			return
		qdel(nullify_spell)
	var/entered_spell_name
	var/datum/action/innate/cult/blood_spell/BS
	var/list/possible_spells = list()
	for(var/I in subtypesof(/datum/action/innate/cult/blood_spell))
		var/datum/action/innate/cult/blood_spell/J = I
		var/cult_name = initial(J.name)
		possible_spells[cult_name] = J
	possible_spells += "(REMOVE SPELL)"
	entered_spell_name = tgui_input_list(owner, "Blood spell to prepare", "Spell Choices", possible_spells)
	if(isnull(entered_spell_name))
		return
	if(entered_spell_name == "(REMOVE SPELL)")
		var/nullify_spell = tgui_input_list(owner, "Spell to remove", "Current Spells", spells)
		if(isnull(nullify_spell))
			return
		qdel(nullify_spell)
	BS = possible_spells[entered_spell_name]
	if(QDELETED(src) || owner.incapacitated || !BS || (rune && !(locate(/obj/effect/rune/empower) in range(1, owner))) || (length(spells) >= limit))
		return
	to_chat(owner,span_warning("Você começa a esculpir símbolos não naturais em sua carne!"))
	SEND_SOUND(owner, sound('sound/items/weapons/slice.ogg',0,1,10))
	if(!channeling)
		channeling = TRUE
	else
		to_chat(owner, span_cult_italic("Você já está invocando magia de sangue!"))
		return
	var/spell_carving_timer = 10 SECONDS
	if(rune)
		spell_carving_timer = 4 SECONDS
	if(magic_enhanced)
		spell_carving_timer *= 0.5
	if(do_after(owner, spell_carving_timer, target = owner))
		if(ishuman(owner))
			var/mob/living/carbon/human/human_owner = owner
			human_owner.bleed(rune ? 8 : 40)
		var/datum/action/innate/cult/blood_spell/new_spell = new BS(owner.mind)
		new_spell.Grant(owner, src)
		spells += new_spell
		Positioning()
		to_chat(owner, span_warning("Suas feridas brilham com poder, você preparou um [new_spell.name] Invocação!"))
	channeling = FALSE

/datum/action/innate/cult/blood_spell //The next generation of talismans, handles storage/creation of blood magic
	name = "Blood Magic"
	button_icon_state = "telerune"
	desc = "Medo do Velho Sangue."
	var/charges = 1
	var/magic_path = null
	var/obj/item/melee/blood_magic/hand_magic
	var/datum/action/innate/cult/blood_magic/all_magic
	var/base_desc //To allow for updating tooltips
	var/invocation
	var/health_cost = 0
	/// Have we already been positioned into our starting location?
	var/positioned = FALSE
	/// If false, the spell will not delete after running out of charges
	var/deletes_on_empty = TRUE

/datum/action/innate/cult/blood_spell/Grant(mob/living/owner, datum/action/innate/cult/blood_magic/BM)
	if(health_cost)
		desc += "<br>Deals <u>[health_cost] damage</u> to your arm per use."
	base_desc = desc
	desc += "<br><b><u>Has [charges] use\s remaining</u></b>."
	all_magic = BM
	return ..()

/datum/action/innate/cult/blood_spell/Remove()
	if(all_magic)
		all_magic.spells -= src
	if(hand_magic)
		qdel(hand_magic)
		hand_magic = null
	..()

/datum/action/innate/cult/blood_spell/IsAvailable(feedback = FALSE)
	if(!IS_CULTIST(owner) || owner.incapacitated || (!charges && deletes_on_empty))
		return FALSE
	return ..()

/datum/action/innate/cult/blood_spell/Activate()
	if(!magic_path) // only concerned with spells that flow from the hand
		return
	if(hand_magic)
		qdel(hand_magic)
		hand_magic = null
		to_chat(owner, span_warning("Você apaga o feitiço, guarda para depois."))
		return
	hand_magic = new magic_path(owner, src)
	if(!owner.put_in_hands(hand_magic))
		qdel(hand_magic)
		hand_magic = null
		to_chat(owner, span_warning("Você não tem mão vazia para invocar magia de sangue!"))
		return
	to_chat(owner, span_notice("Suas feridas brilham enquanto você invoca o [name]."))

//Cult Blood Spells
/datum/action/innate/cult/blood_spell/stun
	name = "Stun"
	desc = "Capacita sua mão para atordoar e silenciar uma vítima em contato. Fica mais fraco dependendo de quantos se juntaram ao Cult."
	button_icon_state = "hand"
	magic_path = /obj/item/melee/blood_magic/stun
	health_cost = 10

/datum/action/innate/cult/blood_spell/teleport
	name = "Teleport"
	desc = "Pode se teletransportar ou se teletransportar para uma runa de teletransporte em contato."
	button_icon_state = "tele"
	magic_path = /obj/item/melee/blood_magic/teleport
	health_cost = 7

/datum/action/innate/cult/blood_spell/emp
	name = "Electromagnetic Pulse"
	desc = "Emite um grande pulso eletromagnético."
	button_icon_state = "emp"
	health_cost = 10
	invocation = "Ta'gh fara'qha fel d'amar det!"

/datum/action/innate/cult/blood_spell/emp/Activate()
	owner.whisper(invocation, language = /datum/language/common, forced = "cult invocation")
	owner.visible_message(span_warning("[owner] A mão brilha um azul brilhante!"), 		span_cult_italic("Você fala as palavras amaldiçoadas, emitindo uma explosão de PEM de sua mão."))
	empulse(owner, 2, 5, emp_source = src)
	charges--
	SSblackbox.record_feedback("tally", "cult_spell_invoke", 1, "[name]")
	if(charges <= 0)
		qdel(src)

/datum/action/innate/cult/blood_spell/shackles
	name = "Shadow Shackles"
	desc = "Capacita sua mão para algemar a vítima no contato, e muda-los se tiver sucesso."
	button_icon_state = "cuff"
	charges = 4
	magic_path = /obj/item/melee/blood_magic/shackles

/datum/action/innate/cult/blood_spell/construction
	name = "Twisted Construction"
	desc = "Pode corromper certos objetos metálicos.<br><u>Conversos:</u><br>Plasteel em metal fundido<br>50 metal em uma concha de construção.<br>Vivendo cyborgs em construções após um atraso<br>Conchas de Cyborg em conchas de construção<br>Pedras de alma purificadas (e qualquer sombra interior) em pedras de alma cultistas<br>Travessas de ar em comportas de ar quebradiças depois de um atraso (intenção de dano)"
	button_icon_state = "transmute"
	magic_path = /obj/item/melee/blood_magic/construction
	health_cost = 12

/datum/action/innate/cult/blood_spell/equipment
	name = "Summon Combat Equipment"
	desc = "Capacite sua mão para chamar equipamento de combate para um cultista que você toca, incluindo armadura de culto, uma bola de culto, e uma espada de culto. Não recomendado para uso antes da presença do culto de sangue ser revelada."
	button_icon_state = "equip"
	magic_path = /obj/item/melee/blood_magic/armor

/datum/action/innate/cult/blood_spell/dagger
	name = "Summon Ritual Dagger"
	desc = "Permite invocar uma adaga ritual, caso tenha perdido a adaga que lhe foi dada."
	invocation = "Wur d'dai leev'mai k'sagan!" //where did I leave my keys, again?
	button_icon_state = "equip" //this is the same icon that summon equipment uses, but eh, I'm not a spriter
	/// The item given to the cultist when the spell is invoked. Typepath.
	var/obj/item/summoned_type = /obj/item/melee/cultblade/dagger

/datum/action/innate/cult/blood_spell/dagger/Activate()
	var/turf/owner_turf = get_turf(owner)
	owner.whisper(invocation, language = /datum/language/common, forced = "cult invocation")
	owner.visible_message(span_warning("[owner] A mão brilha vermelha por um momento."), 		span_cult_italic("Seu pedido de ajuda é respondido, e a luz começa a brilhar e tomar forma em suas mãos!"))
	var/obj/item/summoned_blade = new summoned_type(owner_turf)
	if(owner.put_in_hands(summoned_blade))
		to_chat(owner, span_warning("A [summoned_blade] aparece em suas mãos!"))
	else
		owner.visible_message(span_warning("A [summoned_blade] aparece em [owner] Pés!"), 			span_cult_italic("A [summoned_blade] se materializa aos seus pés."))
	SEND_SOUND(owner, sound('sound/effects/magic.ogg', FALSE, 0, 25))
	charges--
	SSblackbox.record_feedback("tally", "cult_spell_invoke", 1, "[name]")
	if(charges <= 0)
		qdel(src)

/datum/action/innate/cult/blood_spell/horror
	name = "Hallucinations"
	desc = "Dá alucinações a um alvo ao alcance. Um feitiço silencioso e invisível."
	button_icon_state = "horror"
	charges = 4
	click_action = TRUE
	enable_text = span_cult("Você se prepara para aterrorizar um alvo...")
	disable_text = span_cult("Você dissipa a magia...")

/datum/action/innate/cult/blood_spell/horror/InterceptClickOn(mob/living/clicker, params, atom/clicked_on)
	var/turf/caller_turf = get_turf(clicker)
	if(!isturf(caller_turf))
		return FALSE

	if(!ishuman(clicked_on) || get_dist(clicker, clicked_on) > 7)
		return FALSE

	var/mob/living/carbon/human/human_clicked = clicked_on
	if(IS_CULTIST(human_clicked))
		return FALSE

	return ..()

/datum/action/innate/cult/blood_spell/horror/do_ability(mob/living/clicker, mob/living/carbon/human/clicked_on)

	clicked_on.set_hallucinations_if_lower(240 SECONDS)
	SEND_SOUND(clicker, sound('sound/effects/ghost.ogg', FALSE, TRUE, 50))

	var/image/sparkle_image = image('icons/effects/cult.dmi', clicked_on, "bloodsparkles", ABOVE_MOB_LAYER)
	clicked_on.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/has_antagonist/cult, "cult_apoc", sparkle_image, NONE)

	addtimer(CALLBACK(clicked_on, TYPE_PROC_REF(/atom/, remove_alt_appearance), "cult_apoc", TRUE), 4 MINUTES, TIMER_OVERRIDE|TIMER_UNIQUE)
	to_chat(clicker, span_cult_bold("[clicked_on] Foi amaldiçoado com pesadelos vivos!"))

	charges--
	desc = base_desc
	desc += "<br><b><u>Has [charges] use\s remaining</u></b>."
	build_all_button_icons()
	SSblackbox.record_feedback("tally", "cult_spell_invoke", 1, "[name]")
	if(charges <= 0)
		to_chat(clicker, span_cult("Você esgotou o poder do feitiço!"))
		qdel(src)

	return TRUE

/datum/action/innate/cult/blood_spell/veiling
	name = "Conceal Presence"
	desc = "Alterna entre esconder e revelar estruturas de culto e runas próximas."
	invocation = "Kla'atu barada nikt'o!"
	button_icon_state = "gone"
	charges = 10
	var/revealing = FALSE //if it reveals or not

/datum/action/innate/cult/blood_spell/veiling/Activate()
	if(!revealing)
		owner.visible_message(span_warning("A poeira cinza fina cai de [owner] A mão!"), 			span_cult_italic("Você invoca o feitiço de vela, escondendo runas próximas."))
		charges--
		SEND_SOUND(owner, sound('sound/effects/magic/smoke.ogg',0,1,25))
		owner.whisper(invocation, language = /datum/language/common, forced = "cult invocation")
		for(var/obj/effect/rune/R in range(5,owner))
			R.conceal()
		for(var/obj/structure/destructible/cult/S in range(5,owner))
			S.conceal()
		for(var/turf/open/floor/engine/cult/T  in range(5,owner))
			if(!T.realappearance)
				continue
			T.realappearance.alpha = 0
		for(var/obj/machinery/door/airlock/cult/AL in range(5, owner))
			AL.conceal()
		revealing = TRUE
		name = "Reveal Runes"
		button_icon_state = "back"
	else
		owner.visible_message(span_warning("Um flash de luz brilha de [owner] A mão!"), 			span_cult_italic("Você invoca o contra-feitiço, revelando runas próximas."))
		charges--
		owner.whisper(invocation, language = /datum/language/common, forced = "cult invocation")
		SEND_SOUND(owner, sound('sound/effects/magic/enter_blood.ogg',0,1,25))
		for(var/obj/effect/rune/R in range(7,owner)) //More range in case you weren't standing in exactly the same spot
			R.reveal()
		for(var/obj/structure/destructible/cult/S in range(6,owner))
			S.reveal()
		for(var/turf/open/floor/engine/cult/T  in range(6,owner))
			if(!T.realappearance)
				continue
			T.realappearance.alpha = initial(T.realappearance.alpha)
		for(var/obj/machinery/door/airlock/cult/AL in range(6, owner))
			AL.reveal()
		revealing = FALSE
		name = "Conceal Runes"
		button_icon_state = "gone"
	SSblackbox.record_feedback("tally", "cult_spell_invoke", 1, "Conceal Runes")
	if(charges <= 0)
		qdel(src)
	desc = base_desc
	desc += "<br><b><u>Has [charges] use\s remaining</u></b>."
	build_all_button_icons()

/datum/action/innate/cult/blood_spell/manipulation
	name = "Blood Rites"
	desc = "Capacita sua mão para absorver sangue para ser usado para ritos avançados, ou curar um cultista em contato. Use o feitiço para lançar ritos avançados."
	invocation = "Fel'th Dol Ab'orod!"
	button_icon_state = "manip"
	charges = 5
	magic_path = /obj/item/melee/blood_magic/manipulator
	deletes_on_empty = FALSE

// The "magic hand" items
/obj/item/melee/blood_magic
	name = "\improper magical aura"
	desc = "Uma aura sinistra que distorce o fluxo da realidade ao seu redor."
	icon = 'icons/obj/weapons/hand.dmi'
	lefthand_file = 'icons/mob/inhands/items/touchspell_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/touchspell_righthand.dmi'
	icon_state = "disintegrate"
	inhand_icon_state = "disintegrate"
	item_flags = NEEDS_PERMIT | ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	throwforce = 0
	throw_range = 0
	throw_speed = 0
	var/invocation
	var/uses = 1
	var/health_cost = 0 //The amount of health taken from the user when invoking the spell
	var/datum/action/innate/cult/blood_spell/source

/obj/item/melee/blood_magic/Initialize(mapload, spell)
	. = ..()
	if(spell)
		source = spell
		uses = source.charges
		health_cost = source.health_cost

/obj/item/melee/blood_magic/Destroy()
	if(!QDELETED(source))
		if(uses <= 0 && source.deletes_on_empty)
			source.hand_magic = null
			qdel(source)
			source = null
		else
			source.hand_magic = null
			source.charges = uses
			source.desc = source.base_desc
			source.desc += "<br><b><u>Has [uses] use\s remaining</u></b>."
			source.build_all_button_icons()
	return ..()

/obj/item/melee/blood_magic/attack_self(mob/living/user)
	cast_spell(user, user)

/obj/item/melee/blood_magic/attack(mob/living/M, mob/living/carbon/user)
	if(!cast_spell(M, user))
		return
	log_combat(user, M, "used a cult spell on", src, "")
	SSblackbox.record_feedback("tally", "cult_spell_invoke", 1, "[name]")
	M.lastattacker = user.real_name
	M.lastattackerckey = user.ckey
	user.do_attack_animation(M)

/obj/item/melee/blood_magic/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!iscarbon(user) || !IS_CULTIST(user))
		uses = 0
		qdel(src)
		return ITEM_INTERACT_BLOCKING

	if(isliving(interacting_with))
		return ITEM_INTERACT_SKIP_TO_ATTACK

	var/spell_name = source.name // Spell action is deleted in cast_spell() if we're out of charges

	if(!cast_spell(interacting_with, user))
		return ITEM_INTERACT_BLOCKING

	user.do_attack_animation(interacting_with)
	log_combat(user, interacting_with, "used a cult spell on", spell_name)
	SSblackbox.record_feedback("tally", "cult_spell_invoke", 1, "[name]")
	return ITEM_INTERACT_SUCCESS

/obj/item/melee/blood_magic/proc/cast_spell(atom/target, mob/living/carbon/user)
	if(invocation)
		user.whisper(invocation, language = /datum/language/common, forced = "cult invocation")
	if(health_cost)
		if(user.active_hand_index == 1)
			user.apply_damage(health_cost, BRUTE, BODY_ZONE_L_ARM, wound_bonus = CANT_WOUND)
		else
			user.apply_damage(health_cost, BRUTE, BODY_ZONE_R_ARM, wound_bonus = CANT_WOUND)
	if(uses <= 0)
		qdel(src)
		return TRUE
	if(source)
		source.desc = source.base_desc
		source.desc += "<br><b><u>Has [uses] use\s remaining</u></b>."
		source.build_all_button_icons()
	return TRUE

//Stun
/obj/item/melee/blood_magic/stun
	name = "Stunning Aura"
	desc = "Vai atordoar e silenciar uma vítima de mente fraca no contato."
	color = RUNE_COLOR_RED
	invocation = "Fuu ma'jin!"

/obj/item/melee/blood_magic/stun/cast_spell(mob/living/target, mob/living/carbon/user)
	if(!istype(target) || IS_CULTIST(target))
		return
	var/datum/antagonist/cult/cultist = GET_CULTIST(user)
	var/datum/team/cult/cult_team = cultist?.get_team()
	var/effect_coef = 1
	if(cult_team?.cult_ascendent)
		effect_coef = 0.1
	else if(cult_team?.cult_risen)
		effect_coef = 0.4
	if(IS_CULTIST(user) && isnull(GET_CULTIST(user)))
		effect_coef = 0.2
	user.visible_message(
		span_warning("[user] Espera.[user.p_their()] Mão, que explode em um clarão de luz vermelha!"),
		span_cult_italic("Você tenta atordoar [target] Com o feitiço!"),
		visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
	)
	user.mob_light(range = 1.1, power = 2, color = LIGHT_COLOR_BLOOD_MAGIC, duration = 0.2 SECONDS)
	uses--
	// Heretics are momentarily disoriented by the stunning aura. Enough for both parties to go 'oh shit' but only a mild combat ability.
	// Heretics have an identical effect on their grasp. The cultist's worse spell preparation is offset by their extra gear and teammates.
	if(IS_HERETIC(target))
		target.AdjustKnockdown(0.5 SECONDS)
		target.adjust_confusion_up_to(1.5 SECONDS, 3 SECONDS)
		target.adjust_dizzy_up_to(1.5 SECONDS, 3 SECONDS)
		ADD_TRAIT(target, TRAIT_NO_SIDE_KICK, REF(src)) // We don't want this to be a good stunning tool, just minor disorientation
		addtimer(TRAIT_CALLBACK_REMOVE(target, TRAIT_NO_SIDE_KICK, REF(src)), 1 SECONDS)

		var/old_color = target.color
		target.color = COLOR_HERETIC_GREEN
		animate(target, color = old_color, time = 4 SECONDS, easing = SINE_EASING|EASE_IN)
		target.mob_light(range = 1.5, power = 2.5, color = COLOR_HERETIC_GREEN, duration = 0.5 SECONDS)
		playsound(target, 'sound/effects/magic/magic_block_mind.ogg', 150, TRUE) // insanely quiet

		to_chat(user, span_warning("Uma força de Eldritch intervém enquanto você toca.[target], absorvendo a maioria dos efeitos!"))
		to_chat(target, span_warning("Como [user] O Mansus absorve a maioria dos efeitos!"))
		target.balloon_alert_to_viewers("absorbed!")
		return ..()
		// SKYRAT EDIT ADDITION START
	else if(IS_CLOCK(target))
		to_chat(user, span_warning("Alguma força maior do que você intervém![target] Está protegido pelo herege Ratvar!"))
		to_chat(target, span_warning("Você está protegido por sua fé em Ratvar!"))
		var/old_color = target.color
		target.color = rgb(190, 135, 0)
		animate(target, color = old_color, time = 1 SECONDS, easing = EASE_IN)
		// SKYRAT EDIT ADDITION END
		return ..()

	if(target.can_block_magic())
		to_chat(user, span_warning("O feitiço não teve efeito!"))
		return ..()

	to_chat(user, span_cult_italic("Em um brilhante flash de vermelho,[target] Cai no chão!"))
	target.Paralyze(16 SECONDS * effect_coef)
	target.flash_act(1, TRUE)
	if(issilicon(target))
		var/mob/living/silicon/silicon_target = target
		silicon_target.emp_act(EMP_HEAVY)
	else if(iscarbon(target))
		var/mob/living/carbon/carbon_target = target
		carbon_target.adjust_silence(12 SECONDS * effect_coef)
		carbon_target.adjust_stutter(30 SECONDS * effect_coef)
		carbon_target.adjust_timed_status_effect(30 SECONDS * effect_coef, /datum/status_effect/speech/slurring/cult)
		carbon_target.set_jitter_if_lower(30 SECONDS * effect_coef)
	return ..()

//Teleportation
/obj/item/melee/blood_magic/teleport
	name = "Teleporting Aura"
	color = RUNE_COLOR_TELEPORT
	desc = "Vai teletransportar um cultista para uma runa teletransportada em contato."
	invocation = "Sas'so c'arta forbici!"

/obj/item/melee/blood_magic/teleport/cast_spell(mob/living/target, mob/living/carbon/user)
	if(!istype(target) || !IS_CULTIST(target))
		to_chat(user, span_warning("Você só pode teletransportar cultistas com este feitiço!"))
		return

	var/list/potential_runes = list()
	var/list/teleportnames = list()
	for(var/obj/effect/rune/teleport/teleport_rune as anything in GLOB.teleport_runes)
		potential_runes[avoid_assoc_duplicate_keys(teleport_rune.listkey, teleportnames)] = teleport_rune

	if(!length(potential_runes))
		to_chat(user, span_warning("Não há runas válidas para se teletransportar!"))
		return
	var/turf/T = get_turf(src)
	if(is_away_level(T.z))
		to_chat(user, span_cult_italic("Você não está na dimensão certa!"))
		return
	var/input_rune_key = tgui_input_list(user, "Rune to teleport to", "Teleportation Target", potential_runes) //we know what key they picked
	if(isnull(input_rune_key))
		return
	if(isnull(potential_runes[input_rune_key]))
		to_chat(user, span_warning("Você deve escolher uma runa válida!"))
		return
	var/obj/effect/rune/teleport/actual_selected_rune = potential_runes[input_rune_key] //what rune does that key correspond to?
	if(QDELETED(src) || !user || !user.is_holding(src) || user.incapacitated || !actual_selected_rune)
		return
	var/turf/dest = get_turf(actual_selected_rune)
	if(dest.is_blocked_turf(TRUE))
		to_chat(user, span_warning("A runa do alvo está bloqueada. Não pode se teletransportar lá."))
		return
	uses--
	var/turf/origin = get_turf(user)
	if(do_teleport(target, dest, channel = TELEPORT_CHANNEL_CULT))
		origin.visible_message(
			span_warning("O pó flui de [user]'s mão, e [user.p_they()] Desapareça.[user.p_s()] com uma rachadura afiada!"),
			span_cult_italic("Você fala as palavras do talismã e encontra-se em outro lugar!"),
			span_hear("Você ouve uma rachadura afiada."),
		)
		dest.visible_message(
			span_warning("Há uma explosão de ar como algo aparece acima da runa!"),
			null,
			span_hear("Você ouve um boom."),
		)
		playsound(origin, SFX_PORTAL_ENTER, 50, TRUE, SILENCED_SOUND_EXTRARANGE)
		playsound(dest, SFX_PORTAL_ENTER, 50, TRUE, SILENCED_SOUND_EXTRARANGE)
	return ..()

//Shackles
/obj/item/melee/blood_magic/shackles
	name = "Shackling Aura"
	desc = "Começará a algemar uma vítima em contato, e a silenciar se tiver sucesso."
	invocation = "In'totum Lig'abis!"
	color = COLOR_BLACK // black

/obj/item/melee/blood_magic/shackles/cast_spell(atom/target, mob/living/carbon/user)
	if(!iscarbon(target))
		return
	var/mob/living/carbon/C = target
	if(IS_CULTIST(C))
		return
	if(!C.canBeHandcuffed())
		user.visible_message(span_cult_italic("Esta vítima não tem braços suficientes para completar a contenção!"))
		return
	CuffAttack(C, user)
	return ..()

/obj/item/melee/blood_magic/shackles/proc/CuffAttack(mob/living/carbon/C, mob/living/user)
	if(!C.handcuffed)
		playsound(loc, 'sound/items/weapons/cablecuff.ogg', 30, TRUE, -2)
		C.visible_message(span_danger("[user] Começa a restrição.[C] com magia negra!"), 								span_userdanger("[user] começa a moldar algemas mágicas escuras ao redor de seus pulsos!"))
		if(do_after(user, 3 SECONDS, C))
			if(!C.handcuffed)
				C.equip_to_slot_or_del(new /obj/item/restraints/handcuffs/cult, ITEM_SLOT_HANDCUFFED, indirect_action = TRUE)
				C.adjust_silence(10 SECONDS)
				to_chat(user, span_notice("Você está algemado.[C]."))
				log_combat(user, C, "shackled")
				uses--
			else
				to_chat(user, span_warning("[C] Já está preso."))
		else
			to_chat(user, span_warning("Você falha em amarrar [C]."))
	else
		to_chat(user, span_warning("[C] Já está preso."))

//Construction: Converts 50 iron to a construct shell, plasteel to runed metal, airlock to brittle runed airlock, a borg to a construct, or borg shell to a construct shell
/obj/item/melee/blood_magic/construction
	name = "Twisting Aura"
	desc = "Corrompe certos objetos metálicos em contato."
	invocation = "Ethra p'ni dedol!"
	color = COLOR_BLACK // black
	var/channeling = FALSE

/obj/item/melee/blood_magic/construction/examine(mob/user)
	. = ..()
	. += {"<u>A sinister spell used to convert:</u>\n
	Plasteel into runed metal\n
	[IRON_TO_CONSTRUCT_SHELL_CONVERSION] iron into a construct shell\n
	Living cyborgs into constructs after a delay\n
	Cyborg shells into construct shells\n
	Purified soulstones (and any shades inside) into cultist soulstones\n
	Airlocks into brittle runed airlocks after a delay (harm intent)"}

/obj/item/melee/blood_magic/construction/cast_spell(atom/target, mob/living/carbon/user)
	if(channeling)
		to_chat(user, span_cult_italic("Você já está invocando construções distorcidas!"))
		return

	var/turf/T = get_turf(target)
	if(istype(target, /obj/item/stack/sheet/iron))
		var/obj/item/stack/sheet/candidate = target
		if(!candidate.use(IRON_TO_CONSTRUCT_SHELL_CONVERSION))
			to_chat(user, span_warning("Você precisa.[IRON_TO_CONSTRUCT_SHELL_CONVERSION] ferro para produzir uma concha de construção!"))
			return
		uses--
		to_chat(user, span_warning("Uma nuvem escura emana de sua mão e gira em torno do ferro, torcendo-o em uma concha de construção!"))
		new /obj/structure/constructshell(T)
		SEND_SOUND(user, sound('sound/effects/magic.ogg',0,1,25))
		return ..()

	if(istype(target, /obj/item/stack/sheet/plasteel))
		var/obj/item/stack/sheet/plasteel/candidate = target
		var/quantity = candidate.amount
		if(!candidate.use(quantity))
			return

		uses--
		new /obj/item/stack/sheet/runed_metal(T,quantity)
		to_chat(user, span_warning("Uma nuvem escura emana de sua mão e gira em torno do plasteel, transformando-o em metal fundido!"))
		SEND_SOUND(user, sound('sound/effects/magic.ogg',0,1,25))
		return ..()

	if(istype(target,/mob/living/silicon/robot))
		var/mob/living/silicon/robot/candidate = target
		if(candidate.mmi || candidate.shell)
			channeling = TRUE
			user.visible_message(span_danger("Uma nuvem escura emana de [user] A mão e as voltas [candidate]!"))
			playsound(T, 'sound/machines/airlock/airlock_alien_prying.ogg', 80, TRUE)
			var/prev_color = candidate.color
			candidate.color = "black"
			if(!do_after(user, 9 SECONDS, target = candidate))
				channeling = FALSE
				candidate.color = prev_color
				return
			candidate.undeploy()
			candidate.emp_act(EMP_HEAVY)
			var/construct_class = show_radial_menu(user, src, GLOB.construct_radial_images, custom_check = CALLBACK(src, PROC_REF(check_menu), user), require_near = TRUE, tooltips = TRUE)
			if(!check_menu(user) || QDELETED(candidate))
				channeling = FALSE
				candidate.color = prev_color
				return
			candidate.grab_ghost()
			user.visible_message(span_danger("A nuvem escura recua do que antes era.[candidate], revelando um [construct_class]!"))
			make_new_construct_from_class(construct_class, THEME_CULT, candidate, user, FALSE, T)
			uses--
			qdel(candidate)
			channeling = FALSE
			return ..()

		uses--
		to_chat(user, span_warning("Uma nuvem escura emana de sua mão e gira ao redor [candidate]- Torcê-lo em uma concha de construção!"))
		new /obj/structure/constructshell(T)
		SEND_SOUND(user, sound('sound/effects/magic.ogg',0,1,25))
		qdel(candidate)
		return ..()

	if(istype(target,/obj/machinery/door/airlock))
		channeling = TRUE
		playsound(T, 'sound/machines/airlock/airlockforced.ogg', 50, TRUE)
		do_sparks(5, TRUE, target)
		if(!do_after(user, 5 SECONDS, target = user) && !QDELETED(target))
			channeling = FALSE
			return

		target.narsie_act()
		uses--
		user.visible_message(span_warning("As fitas pretas de repente emanam de [user] A mão e agarra-se à câmara de ar. Torcendo e corrompendo-a!"))
		SEND_SOUND(user, sound('sound/effects/magic.ogg',0,1,25))
		channeling = FALSE
		return ..()

	if(istype(target,/obj/item/soulstone))
		var/obj/item/soulstone/candidate = target
		if(!candidate.corrupt())
			return

		uses--
		to_chat(user, span_warning("Seu corrupto.[candidate]!"))
		SEND_SOUND(user, sound('sound/effects/magic.ogg',0,1,25))
		return ..()

	to_chat(user, span_warning("O feitiço não funcionará.[target]!"))

/obj/item/melee/blood_magic/construction/proc/check_menu(mob/user)
	if(!istype(user))
		CRASH("The cult construct selection radial menu was accessed by something other than a valid user.")
	if(user.incapacitated || !user.Adjacent(src))
		return FALSE
	return TRUE


//Armor: Gives the target (cultist) a basic cultist combat loadout
/obj/item/melee/blood_magic/armor
	name = "Arming Aura"
	desc = "Vai equipar equipamento de combate de culto em um cultista em contato."
	color = "#33cc33" // green

/obj/item/melee/blood_magic/armor/cast_spell(mob/living/target, mob/living/carbon/user)
	if(!iscarbon(target) || !IS_CULTIST(target))
		return
	uses--
	var/mob/living/carbon/carbon_target = target
	carbon_target.visible_message(span_warning("A armadura de outro mundo aparece de repente.[carbon_target]!"))
	carbon_target.equip_to_slot_or_del(new /obj/item/clothing/under/color/black,ITEM_SLOT_ICLOTHING)
	carbon_target.equip_to_slot_or_del(new /obj/item/clothing/suit/hooded/cultrobes/alt(user), ITEM_SLOT_OCLOTHING)
	carbon_target.equip_to_slot_or_del(new /obj/item/clothing/shoes/cult/alt(user), ITEM_SLOT_FEET)
	carbon_target.equip_to_slot_or_del(new /obj/item/storage/backpack/cultpack(user), ITEM_SLOT_BACK)
	if(carbon_target == user)
		qdel(src) //Clears the hands
	carbon_target.put_in_hands(new /obj/item/melee/cultblade/dagger(user))
	carbon_target.put_in_hands(new /obj/item/restraints/legcuffs/bola/cult(user))
	return ..()

/obj/item/melee/blood_magic/manipulator
	name = "Blood Rite Aura"
	desc = "Absorve sangue de qualquer coisa que toque. Tocar cultistas e construções pode curá-los. Use em mãos para lançar um ritual avançado."
	color = "#7D1717"

/obj/item/melee/blood_magic/manipulator/examine(mob/user)
	. = ..()
	. += "Bloody halberd, blood bolt barrage, and blood beam cost [BLOOD_HALBERD_COST], [BLOOD_BARRAGE_COST], and [BLOOD_BEAM_COST] charges respectively."

/**
 * handles inhand use of blood rites on constructs, humans, or non-living blood sources
 *
 * see '/obj/item/melee/blood_magic/manipulator/proc/heal_construct' for construct/shade behavior
 * see '/obj/item/melee/blood_magic/manipulator/proc/heal_cultist' for human cultist behavior
 * see '/obj/item/melee/blood_magic/manipulator/proc/drain_victim' for human non-cultist behavior
 * if any of the above procs return FALSE, '/obj/item/melee/blood_magic/afterattack' will not be called
 *
 * '/obj/item/melee/blood_magic/manipulator/proc/blood_draw' handles blood pools/trails and does not affect parent proc
 */
/obj/item/melee/blood_magic/manipulator/cast_spell(mob/living/target, mob/living/carbon/user)
	if(isconstruct(target) || isshade(target))
		if (heal_construct(target, user))
			return ..()
		return
	if(istype(target, /obj/effect/decal/cleanable/blood) || isturf(target))
		blood_draw(target, user)
		return ..()
	if(!ishuman(target))
		return
	var/mob/living/carbon/human/human_bloodbag = target
	if(!CAN_HAVE_BLOOD(human_bloodbag))
		human_bloodbag.balloon_alert(user, "Sem sangue!")
		return
	if(human_bloodbag.stat == DEAD)
		human_bloodbag.balloon_alert(user, "Morto!")
		return
	if(IS_CULTIST(human_bloodbag) && !heal_cultist(human_bloodbag, user))
		return
	if(!IS_CULTIST(human_bloodbag) && !drain_victim(human_bloodbag, user))
		return
	return ..()

/**
 * handles blood rites usage on constructs
 *
 * will only return TRUE if some amount healing is done
 */
/obj/item/melee/blood_magic/manipulator/proc/heal_construct(atom/target, mob/living/carbon/human/user)
	var/mob/living/basic/construct_thing = target
	if(!IS_CULTIST(construct_thing))
		return FALSE
	var/missing_health = construct_thing.maxHealth - construct_thing.health
	if(!missing_health)
		to_chat(user,span_cult("Aquele cultista não precisa de cura!"))
		return FALSE
	if(uses <= 0)
		construct_thing.balloon_alert(user, "Sem sangue!")
		return FALSE
	if(uses > missing_health)
		construct_thing.adjust_health(-missing_health)
		construct_thing.visible_message(span_warning("[construct_thing] está completamente curado por [user] É magia de sangue!"))
		uses -= missing_health
	else
		construct_thing.adjust_health(-uses)
		construct_thing.visible_message(span_warning("[construct_thing] é parcialmente curado por [user] É magia de sangue!"))
		uses = 0
	playsound(get_turf(construct_thing), 'sound/effects/magic/staff_healing.ogg', 25)
	user.Beam(construct_thing, icon_state="sendbeam", time = 1 SECONDS)
	return TRUE

/**
 * handles blood rites usage on human cultists
 *
 * first restores blood, then heals damage. healing damage is more expensive, especially if performed on oneself
 * returns TRUE if some amount of blood is restored and/or damage is healed
 */
/obj/item/melee/blood_magic/manipulator/proc/heal_cultist(mob/living/carbon/human/human_bloodbag, mob/living/carbon/human/user)
	if(uses <= 0)
		human_bloodbag.balloon_alert(user, "Sem sangue!")
		return FALSE

	/// used to ensure the proc returns TRUE if we completely restore an undamaged persons blood
	var/blood_donor = FALSE
	var/cached_blood_volume = human_bloodbag.get_blood_volume()
	if(cached_blood_volume < BLOOD_VOLUME_SAFE)
		var/blood_needed = BLOOD_VOLUME_SAFE - cached_blood_volume
		/// how much blood we are capable of restoring, based on spell charges
		var/blood_bank = USES_TO_BLOOD * uses
		if(blood_bank < blood_needed)
			human_bloodbag.adjust_blood_volume(blood_bank)
			to_chat(user,span_danger("Use o último de seus ritos de sangue para restaurar o sangue que puder!"))
			uses = 0
			return TRUE
		blood_donor = TRUE
		human_bloodbag.set_blood_volume(BLOOD_VOLUME_SAFE)
		uses -= round(blood_needed / USES_TO_BLOOD)
		to_chat(user,span_warning("Seus ritos de sangue foram restaurados.[human_bloodbag == user ? "your" : "[human_bloodbag.p_their()]"]Sangue para níveis seguros!"))

	var/overall_damage = human_bloodbag.get_brute_loss() + human_bloodbag.get_fire_loss() + human_bloodbag.get_tox_loss() + human_bloodbag.get_oxy_loss()
	if(overall_damage == 0)
		if(blood_donor)
			return TRUE
		to_chat(user,span_cult("Aquele cultista não precisa de cura!"))
		return FALSE
	/// how much damage we can/will heal
	var/damage_healed = -1 * min(uses, overall_damage)
	/// how many spell charges will be consumed to heal said damage
	var/healing_cost = damage_healed
	if(human_bloodbag == user)
		to_chat(user,span_cult("<b>Seu sangue é muito menos eficiente quando usado em si mesmo!</b>"))
		damage_healed = -1 * min(uses * (1 / SELF_HEAL_PENALTY), overall_damage)
		healing_cost = damage_healed * SELF_HEAL_PENALTY
	uses += round(healing_cost)
	human_bloodbag.visible_message(span_warning("[human_bloodbag] É[uses == 0 ? "partially healed":"fully healed"]por[human_bloodbag == user ? "[human_bloodbag.p_their()]":"[human_bloodbag]'s"]Magia de sangue!"))

	var/need_mob_update = FALSE
	need_mob_update += human_bloodbag.adjust_oxy_loss(damage_healed * (human_bloodbag.get_oxy_loss() / overall_damage), updating_health = FALSE)
	need_mob_update += human_bloodbag.adjust_tox_loss(damage_healed * (human_bloodbag.get_tox_loss() / overall_damage), updating_health = FALSE)
	need_mob_update += human_bloodbag.adjust_fire_loss(damage_healed * (human_bloodbag.get_fire_loss() / overall_damage), updating_health = FALSE)
	need_mob_update += human_bloodbag.adjust_brute_loss(damage_healed * (human_bloodbag.get_brute_loss() / overall_damage), updating_health = FALSE)
	if(need_mob_update)
		human_bloodbag.updatehealth()
	playsound(get_turf(human_bloodbag), 'sound/effects/magic/staff_healing.ogg', 25)
	new /obj/effect/temp_visual/cult/sparks(get_turf(human_bloodbag))
	if (user != human_bloodbag) //Dont create beam from the user to the user
		user.Beam(human_bloodbag, icon_state="sendbeam", time = 15)
	return TRUE

/**
 * handles blood rites use on a non-cultist human
 *
 * returns TRUE if blood is successfully drained from the victim
 */
/obj/item/melee/blood_magic/manipulator/proc/drain_victim(mob/living/carbon/human/human_bloodbag, mob/living/carbon/human/user)
	if(human_bloodbag.has_status_effect(/datum/status_effect/speech/slurring/cult))
		to_chat(user,span_danger("[human_bloodbag.p_Their()] O sangue foi contaminado por uma forma ainda mais forte de magia de sangue, não adianta para nós assim!"))
		return FALSE
	if(human_bloodbag.get_blood_volume() <= BLOOD_VOLUME_SAFE)
		to_chat(user,span_warning("[human_bloodbag.p_Theyre()] Faltando muito sangue - você não pode drenar [human_bloodbag.p_them()] Mais longe!"))
		return FALSE
	human_bloodbag.adjust_blood_volume(-BLOOD_DRAIN_GAIN * USES_TO_BLOOD)
	uses += BLOOD_DRAIN_GAIN
	user.Beam(human_bloodbag, icon_state="drainbeam", time = 1 SECONDS)
	playsound(get_turf(human_bloodbag), 'sound/effects/magic/enter_blood.ogg', 50)
	human_bloodbag.visible_message(span_danger("[user] Esvazia alguns de [human_bloodbag] Sangue!"))
	to_chat(user,span_cult_italic("Seu rito de sangue ganha 50 acusações de drenagem.[human_bloodbag] É sangue."))
	new /obj/effect/temp_visual/cult/sparks(get_turf(human_bloodbag))
	return TRUE

/**
 * handles blood rites use on turfs, blood pools, and blood trails
 */
/obj/item/melee/blood_magic/manipulator/proc/blood_draw(atom/target, mob/living/carbon/human/user)
	var/blood_to_gain = 0
	var/turf/our_turf = get_turf(target)
	if(!our_turf)
		return
	for(var/obj/effect/decal/cleanable/blood/blood_around_us in range(our_turf, 2))
		if(blood_around_us.decal_reagent == /datum/reagent/blood || blood_around_us.reagents?.has_reagent(/datum/reagent/blood))
			blood_to_gain += max(blood_around_us.bloodiness * 0.6 * BLOOD_TO_UNITS_MULTIPLIER, 1)
			new /obj/effect/temp_visual/cult/turf/floor(get_turf(blood_around_us))
			qdel(blood_around_us)

	if(!blood_to_gain)
		return
	user.Beam(our_turf,icon_state="drainbeam", time = 15)
	new /obj/effect/temp_visual/cult/sparks(get_turf(user))
	playsound(our_turf, 'sound/effects/magic/enter_blood.ogg', 50)
	to_chat(user, span_cult_italic("Seu rito de sangue ganhou [round(blood_to_gain)] Cargas de fontes de sangue ao seu redor!"))
	uses += max(1, round(blood_to_gain))

/**
 * handles untargeted use of blood rites
 *
 * allows user to trade in spell uses for equipment or spells
 */
/obj/item/melee/blood_magic/manipulator/attack_self(mob/living/user)
	var/static/list/spells = list(
		"Bloody Halberd (150)" = image(icon = 'icons/obj/weapons/spear.dmi', icon_state = "occultpoleaxe0"),
		"Blood Bolt Barrage (300)" = image(icon = 'icons/obj/weapons/guns/ballistic.dmi', icon_state = "arcane_barrage"),
		"Blood Beam (500)" = image(icon = 'icons/obj/weapons/hand.dmi', icon_state = "disintegrate")
		)
	var/choice = show_radial_menu(user, src, spells, custom_check = CALLBACK(src, PROC_REF(check_menu), user), require_near = TRUE)
	if(!check_menu(user))
		to_chat(user, span_cult_italic("Você decide não conduzir um ritual de sangue maior."))
		return

	switch(choice)
		if("Bloody Halberd (150)")
			if(uses < BLOOD_HALBERD_COST)
				to_chat(user, span_cult_italic("Você precisa.[BLOOD_HALBERD_COST] acusações para realizar este ritual."))
				return
			uses -= BLOOD_HALBERD_COST
			var/turf/current_position = get_turf(user)
			qdel(src)
			var/datum/action/innate/cult/halberd/halberd_act_granted = new(user)
			var/obj/item/melee/cultblade/halberd/rite = new(current_position)
			halberd_act_granted.Grant(user, rite)
			rite.halberd_act = halberd_act_granted
			if(user.put_in_hands(rite))
				to_chat(user, span_cult_italic("A [rite.name] aparece em suas mãos!"))
			else
				user.visible_message(span_warning("A [rite.name] aparece em [user] Pés!"), 					span_cult_italic("A [rite.name] se materializa aos seus pés."))

		if("Blood Bolt Barrage (300)")
			if(uses < BLOOD_BARRAGE_COST)
				to_chat(user, span_cult_italic("Você precisa.[BLOOD_BARRAGE_COST] acusações para realizar este ritual."))
				return
			var/obj/rite = new /obj/item/gun/magic/wand/arcane_barrage/blood()
			uses -= BLOOD_BARRAGE_COST
			qdel(src)
			if(user.put_in_hands(rite))
				to_chat(user, span_cult("<b>Suas mãos brilham com poder!</b>"))
			else
				to_chat(user, span_cult_italic("Você precisa de uma mão livre para este ritual!"))
				qdel(rite)

		if("Blood Beam (500)")
			if(uses < BLOOD_BEAM_COST)
				to_chat(user, span_cult_italic("Você precisa.[BLOOD_BEAM_COST] acusações para realizar este ritual."))
				return
			var/obj/rite = new /obj/item/blood_beam()
			uses -= BLOOD_BEAM_COST
			qdel(src)
			if(user.put_in_hands(rite))
				to_chat(user, span_cult_large("<b>Suas mãos brilham com poder!</b>"))
			else
				to_chat(user, span_cult_italic("Você precisa de uma mão livre para este ritual!"))
				qdel(rite)

/obj/item/melee/blood_magic/manipulator/proc/check_menu(mob/living/user)
	if(!istype(user))
		CRASH("The Blood Rites manipulator radial menu was accessed by something other than a valid user.")
	if(user.incapacitated || !user.Adjacent(src))
		return FALSE
	return TRUE

#undef USES_TO_BLOOD
#undef BLOOD_DRAIN_GAIN
#undef SELF_HEAL_PENALTY
