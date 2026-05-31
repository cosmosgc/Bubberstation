//////////////////////
//     BLOODBAG     //
//////////////////////

#define BLOODBAG_GULP_SIZE 5

/obj/item/reagent_containers/blood
	var/being_drunk = FALSE

/// Taken from drinks.dm
/obj/item/reagent_containers/blood/attack(mob/living/victim, mob/living/attacker, params)
	if(!can_drink(victim, attacker) || being_drunk)
		return
	being_drunk = TRUE
	if(victim != attacker)
		// show to both victim and attacker
		INVOKE_ASYNC(src, GLOBAL_PROC_REF(do_after), victim, 5 SECONDS, attacker)
		do_after(victim, 5 SECONDS, attacker)
		if(!do_after(attacker, 5 SECONDS, victim))
			being_drunk = FALSE
			return
		attacker.visible_message(
			span_notice("[attacker]forças[victim]para beber da[src]."),
			span_notice("Você colocou o[src]até[victim]A boca."))
		reagents.trans_to(victim, BLOODBAG_GULP_SIZE, transferred_by = attacker, methods = INGEST)
		playsound(victim.loc, 'sound/items/drink.ogg', 30, 1)
		being_drunk = FALSE
		return TRUE

	while(do_after(victim, 1 SECONDS, timed_action_flags = IGNORE_USER_LOC_CHANGE, extra_checks = CALLBACK(src, PROC_REF(can_drink), attacker, victim)))
		victim.visible_message(
			span_notice("[victim]coloca o[src]Até a boca deles."),
			span_notice("Você toma um gole do[src]."),
		)
		reagents.trans_to(victim, BLOODBAG_GULP_SIZE, transferred_by = attacker, methods = INGEST)
		playsound(victim.loc, 'sound/items/drink.ogg', 30, 1)
	being_drunk = FALSE
	return TRUE

#undef BLOODBAG_GULP_SIZE

/obj/item/reagent_containers/blood/proc/can_drink(mob/living/victim, mob/living/attacker)
	if(!canconsume(victim, attacker))
		return FALSE
	if(!reagents || !reagents.total_volume)
		to_chat(victim, span_warning("[src]Está vazio!"))
		return FALSE
	return TRUE

///Bloodbag of Bloodsucker blood (used by Ghouls only)
/obj/item/reagent_containers/blood/o_minus/bloodsucker
	name = "blood pack"
	blood_type = null
	list_reagents = list(/datum/reagent/blood/bloodsucker = 200)

/obj/item/reagent_containers/blood/o_minus/bloodsucker/examine(mob/user)
	. = ..()
	if(user.mind.has_antag_datum(/datum/antagonist/ex_ghoul) || user.mind.has_antag_datum(/datum/antagonist/ghoul/revenge))
		. += span_notice("Parece ser da mesma cor do seu mestre...")

//////////////////////
//      STAKES      //
//////////////////////
/obj/item/stack/sheet/mineral/wood/attackby(obj/item/item, mob/user, params)
	if(!item.get_sharpness())
		return ..()
	user.visible_message(
		span_notice("[user]Começa a roçar[src]em um objeto pontudo."),
		span_notice("Você começa a roçar[src]em um ponto afiado em uma extremidade."),
		span_hear("Você ouve madeira esculpindo."),
	)
	// 5 Second Timer
	if(!do_after(user, 5 SECONDS, src, NONE, TRUE))
		return
	// Make Stake
	var/obj/item/stake/new_item = new(user.loc)
	user.visible_message(
		span_notice("[user]termina de esculpir uma estaca de[src]."),
		span_notice("Você termina de esculpir uma estaca[src]."),
	)
	// Prepare to Put in Hands (if holding wood)
	var/obj/item/stack/sheet/mineral/wood/wood_stack = src
	var/replace = (user.get_inactive_held_item() == wood_stack)
	// Use Wood
	wood_stack.use(1)
	// If stack depleted, put item in that hand (if it had one)
	if(!wood_stack && replace)
		user.put_in_hands(new_item)

// TODO move this into bloodsuckerdatum
/// Do I have a stake in my heart?
/mob/living/proc/am_staked()
	var/obj/item/bodypart/chosen_bodypart = get_bodypart(BODY_ZONE_CHEST)
	var/obj/item/stake/stake = locate() in chosen_bodypart.embedded_objects
	return stake

/mob/living/proc/get_stakes()
	var/obj/item/bodypart/chosen_bodypart = get_bodypart(BODY_ZONE_CHEST)
	if(!chosen_bodypart)
		return FALSE
	var/list/stakes = list()
	for(var/obj/item/embedded_stake in chosen_bodypart.embedded_objects)
		if(istype(embedded_stake, /obj/item/stake))
			stakes += list(embedded_stake)
	return stakes

/datum/embedding/stake
	embed_chance = 20

/obj/item/stake
	name = "wooden stake"
	desc = "Uma simples estaca de madeira esculpida até um ponto afiado."
	icon = 'modular_zubbers/icons/obj/equipment/stakes.dmi'
	icon_state = "wood"
	inhand_icon_state = "wood"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/bloodsucker_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/bloodsucker_righthand.dmi'
	slot_flags = ITEM_SLOT_POCKETS
	w_class = WEIGHT_CLASS_SMALL
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("staked", "stabbed", "tore into")
	attack_verb_simple = list("staked", "stabbed", "tore into")
	sharpness = SHARP_EDGED
	embed_data = /datum/embedding/stake
	force = 6
	throwforce = 10
	max_integrity = 30
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 3)

	///Time it takes to embed the stake into someone's chest.
	var/staketime = 5 SECONDS
	var/kills_blodsuckers = FALSE

/obj/item/stake/examine_more(mob/user)
	. = ..()
	. += span_notice("Você pode usar[src]Para enfiar alguém no peito, se estiver deitado ou agarrado pelo pescoço.")
	if(IS_BLOODSUCKER(user))
		. += span_warning("Você sente uma sensação de medo enquanto olha para o[src]...")

/obj/item/stake/attack(mob/living/target, mob/living/user, params)
	. = ..()
	if(.)
		return
	// Invalid Target, or not targetting the chest?
	if(check_zone(user.zone_selected) != BODY_ZONE_CHEST)
		return
	if(target == user)
		return
	if(!target.can_be_staked()) // Oops! Can't.
		to_chat(user, span_danger("Você não pode apostar[target]Quando eles estão se movendo! Eles têm que estar deitados ou agarrados pelo pescoço!"))
		return
	if(HAS_TRAIT(target, TRAIT_PIERCEIMMUNE))
		to_chat(user, span_danger("[target]O peito resiste à estaca. Não vai entrar."))
		return

	to_chat(user, span_notice("Você colocou todo o seu peso em incorporar a estaca em[target]O peito..."))
	playsound(user, 'sound/effects/magic/Demon_consume.ogg', 50, 1)
	if(!do_after(user, staketime, target, extra_checks = CALLBACK(target, TYPE_PROC_REF(/mob/living/carbon, can_be_staked)))) // user / target / time / uninterruptable / show progress bar / extra checks
		return
	// Drop & Embed Stake
	user.visible_message(
		span_danger("[user.name]Dirige o[src]em[target]O peito!"),
		span_danger("Você dirige o[src]em[target]O peito!"),
	)
	playsound(get_turf(target), 'sound/effects/splat.ogg', 40, 1)
	if(force_embed(target, target.get_bodypart(BODY_ZONE_CHEST))) //and if it embeds successfully in their chest, cause a lot of pain
		target.apply_damage(max(10, force * 1.2), BRUTE, BODY_ZONE_CHEST, wound_bonus = 0, sharpness = TRUE)
		on_stake_embed(target, user)

/obj/item/stake/proc/on_stake_embed(mob/living/target, mob/living/user)
	return

/obj/item/stake/hardened/silver/on_stake_embed(mob/living/target, mob/living/user)
	var/obj/item/organ/heart/heart = target.get_organ_slot(ORGAN_SLOT_HEART)
	if(!heart)
		return
	target.visible_message(
		span_danger("O[src.name]Pierces[target]O peito, destruindo o[heart.name]!"),
		span_userdanger("Você sente uma dor horrível como o[src.name]perfura seu peito, destruindo seu[heart.name]!"),
	)
	qdel(heart)

/obj/item/stake/force_embed(mob/living/carbon/victim, obj/item/bodypart/target_limb)
	. = ..()
	if(!.)
		return .
	SEND_SIGNAL(target_limb, COMSIG_BODYPART_STAKED, TRUE)
	SEND_SIGNAL(victim, COMSIG_MOB_STAKED, TRUE)
	return .

///Can this target be staked? If someone stands up before this is complete, it fails. Best used on someone stationary.
/mob/living/proc/can_be_staked()
	return FALSE

/mob/living/carbon/can_be_staked()
	if(body_position == LYING_DOWN)
		return TRUE
	return FALSE

/datum/embedding/stake/hardened
	embed_chance = 35
	fall_chance = 0

/// Created by welding and acid-treating a simple stake.
/obj/item/stake/hardened
	name = "hardened stake"
	desc = "Uma estaca de madeira esculpida num ponto afiado e endurecida pelo fogo."
	icon_state = "hardened"
	force = 8
	throwforce = 12
	armour_penetration = 10
	embed_data = /datum/embedding/stake/hardened
	staketime = 12 SECONDS
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/stake/hardened/examine_more(mob/user)
	. = ..()
	. += span_notice("O[src]Não vai cair sozinho, se estiver embutido em alguém.")

/datum/embedding/stake/silver
	embed_chance = 0 // we want it to only be embeddable manually
	fall_chance = 0

/obj/item/stake/hardened/silver
	name = "silver stake"
	desc = "Polido e afiado no final. Para quando algum mofo está sempre tentando iceskate uphill."
	icon_state = "silver"
	inhand_icon_state = "silver"
	siemens_coefficient = 1
	force = 9
	armour_penetration = 25
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/silver = SHEET_MATERIAL_AMOUNT)
	embed_data = /datum/embedding/stake/silver
	staketime = 15 SECONDS

/obj/item/stake/hardened/silver/examine_more(mob/user)
	. = ..()
	. += span_notice("Você acha que o[src]Pode destruir o coração de alguém se você realmente bater nas costelas de alguém corretamente.")

//////////////////////
//     ARCHIVES     //
//////////////////////

/**
 *	# Archives of the Kindred:
 *+
 *	A book that can only be used by Curators.
 *	When used on a player, after a short timer, will reveal if the player is a Bloodsucker, including their real name and Clan.
 *	This book should not work on Bloodsuckers using the Masquerade ability.
 *	If it reveals a Bloodsucker, the Curator will then be able to tell they are a Bloodsucker on examine (Like a Ghoul).
 *	Reading it normally will allow Curators to read what each Clan does, with some extra flavor text ones.
 *
 *	Regular Bloodsuckers won't have any negative effects from the book, while everyone else will get burns/eye damage.
 */
/obj/item/book/kindred
	name = "\improper Book of Nod"
	starting_title = "the Book of Nod"
	desc = "Documentos criptográficos explicando verdades escondidas atrás de seres mortos-vivos. Dizem que só os curadores podem decifrar o que realmente significam."
	icon = 'modular_zubbers/icons/obj/structures/vamp_obj.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/bloodsucker_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/bloodsucker_righthand.dmi'
	icon_state = "kindred_book"
	starting_author = "dozens of generations of Curators"
	unique = TRUE
	throw_speed = 1
	throw_range = 10
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	///Boolean on whether the book is currently being used, so you can only use it on one person at a time.
	COOLDOWN_DECLARE(bloodsucker_check_cooldown)
	var/cooldown_time = 1 MINUTES

/obj/item/book/kindred/Initialize(mapload)
	. = ..()
	SSpoints_of_interest.make_point_of_interest(src)

/obj/item/book/kindred/carving_act(mob/living/user, obj/item/tool)
	to_chat(user, span_notice("Você sente os suaves sussurros de um Bibliotecário dizendo para não cortar[starting_title]."))
	return ITEM_INTERACT_BLOCKING

///Attacking someone with the book.
/obj/item/book/kindred/afterattack(mob/living/target, mob/living/user, flag, params)
	. = ..()
	if(!user.can_read(src) || (target == user) || !ismob(target))
		return
	if(!HAS_TRAIT(user.mind, TRAIT_BLOODSUCKER_HUNTER))
		if(IS_BLOODSUCKER(user))
			to_chat(user, span_notice("[src]Parece muito complicado para você. Seria melhor deixar isso para outra pessoa pegar."))
			return
		to_chat(user, span_warning("[src]Queima suas mãos enquanto tenta usá-la!"))
		user.apply_damage(3, BURN, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
		return

	if(!COOLDOWN_FINISHED(src, bloodsucker_check_cooldown))
		user.balloon_alert(user, "Sua cabeça dói, espere um minuto.")
		addtimer(CALLBACK(user, TYPE_PROC_REF(/atom, balloon_alert), user, "You feel your head clear up."), cooldown_time)
		return
	user.balloon_alert_to_viewers(user, "reading book...")
	user.balloon_alert(target, "Olhe para você e verifique o seu[src]...")
	if(!do_after(user, 3 SECONDS, target, timed_action_flags = NONE, progress = TRUE))
		to_chat(user, span_notice("Você rapidamente fecha.[src]."))
		return
	COOLDOWN_START(src, bloodsucker_check_cooldown, cooldown_time)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(target)
	// Are we a Bloodsucker | Are we on Masquerade. If one is true, they will fail.
	if(IS_BLOODSUCKER(target) && !HAS_TRAIT(target, TRAIT_MASQUERADE))
		if(bloodsuckerdatum.broke_masquerade)
			to_chat(user, span_warning("[target], também conhecido como '[bloodsuckerdatum.return_full_name()]', é realmente um Bloodsucker, mas você já sabia disso."))
			return
		to_chat(user, span_warning("[target], também conhecido como '[bloodsuckerdatum.return_full_name()]', [bloodsuckerdatum.my_clan ? "is part of the [bloodsuckerdatum.my_clan]!" : "is not part of a clan."]Você rapidamente anota essa informação, memorizando-a."))
		bloodsuckerdatum.break_masquerade()
	else
		to_chat(user, span_notice("Você não tira conclusões para[target]sendo um Bloodsucker."))

/obj/item/book/kindred/attack_self(mob/living/user)
	if(user.mind && !(HAS_TRAIT(user.mind, TRAIT_BLOODSUCKER_HUNTER) || IS_BLOODSUCKER(user)))
		to_chat(user, span_warning("Você sente seus olhos incapazes de ler os textos chatos..."))
		user.set_eye_blur_if_lower(10 SECONDS)
		return
	ui_interact(user)

/obj/item/book/kindred/ui_interact(mob/living/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "KindredBook", name)
		ui.open()

/obj/item/book/kindred/ui_static_data(mob/user)
	var/data = list()

	for(var/datum/bloodsucker_clan/clans as anything in subtypesof(/datum/bloodsucker_clan))
		var/clan_data = list()
		clan_data["clan_name"] = initial(clans.name)
		clan_data["clan_desc"] = initial(clans.description)
		data["clans"] += list(clan_data)

	return data

/obj/structure/displaycase/curator
	desc = "Este livro foi encontrado dentro de um caixão de um curador morto. Dizem que pode revelar a verdadeira natureza daqueles que se alimentam da humanidade."
	start_showpiece_type = /obj/item/book/kindred
	req_access = list(ACCESS_LIBRARY)


/// just a typepath to specify that it's monkey-owned, used for the heart thief objective
/obj/item/organ/heart/monkey

/obj/item/organ/heart/examine_more(mob/user)
	. = ..()
	var/datum/antagonist/bloodsucker/vampire = IS_BLOODSUCKER(user)
	if(!vampire)
		return
	var/datum/objective/steal_n_of_type/heart_thief = locate() in vampire?.objectives
	if(!heart_thief)
		return
	if(heart_thief.check_if_valid_item(src))
		. += span_notice("Isto.[src.name]fará para seus propósitos...")
	else
		. += span_notice("Isto.[src.name]é de menor qualidade, não vai fazer...")
