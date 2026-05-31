#define CHALLENGE_TELECRYSTALS 280
#define CHALLENGE_TIME_LIMIT (5 MINUTES)
#define CHALLENGE_SHUTTLE_DELAY (25 MINUTES) // 25 minutes, so the ops have at least 5 minutes before the shuttle is callable.

GLOBAL_LIST_EMPTY(jam_on_wardec)

/obj/item/nuclear_challenge
	name = "Declaration of War (Challenge Mode)"
	icon = 'icons/obj/devices/voice.dmi'
	icon_state = "nukietalkie"
	inhand_icon_state = "nukietalkie"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	desc = "Use para enviar uma declaração de hostilidades ao alvo, atrasando sua partida por 20 minutos enquanto se preparam para seu ataque. Tal movimento descarado atrairá a atenção de poderosos benfeitores dentro do Sindicato, que fornecerão à sua equipe uma enorme quantidade de bônus telecristais. Deve ser usado em cinco minutos, ou seus benfeitores perderão o interesse."
	var/declaring_war = FALSE
	var/uplink_type = /obj/item/uplink/nuclear
	var/announcement_sound = 'sound/announcer/alarm/nuke_alarm.ogg'

/obj/item/nuclear_challenge/attack_self(mob/living/user)
	if(!check_allowed(user))
		return

	declaring_war = TRUE
	var/are_you_sure = tgui_alert(user, "Consulte sua equipe de cuidados antes de declarar guerra.[station_name()]Tem certeza que quer alertar a tripulação inimiga? Você tem[DisplayTimeText(CHALLENGE_TIME_LIMIT - world.time - SSticker.round_start_time)]Para decidir.", "Declare war?", list("Yes", "No"))
	declaring_war = FALSE

	if(!check_allowed(user))
		return

	if(are_you_sure != "Yes")
		to_chat(user, span_notice("Pensando bem, o elemento surpresa não é tão ruim."))
		return

	var/war_declaration = "A syndicate fringe group has declared their intent to utterly destroy [station_name()] with a nuclear device, and dares the crew to try and stop them."

	declaring_war = TRUE
	var/custom_threat = tgui_alert(user, "Quer personalizar sua declaração?", "Customize?", list("Yes", "No"))
	declaring_war = FALSE

	if(!check_allowed(user))
		return

	if(custom_threat == "Yes")
		declaring_war = TRUE
		war_declaration = tgui_input_text(user, "Insert your custom declaration", "Declaration", max_length = MAX_MESSAGE_LEN, multiline = TRUE, encode = FALSE)
		declaring_war = FALSE

	if(!check_allowed(user) || !war_declaration)
		return

	war_was_declared(user, memo = war_declaration)

///Admin only proc to bypass checks and force a war declaration. Button on antag panel.
/obj/item/nuclear_challenge/proc/force_war()
	var/are_you_sure = tgui_alert(usr, "Are you sure you wish to force a war declaration?[GLOB.player_list.len < CHALLENGE_MIN_PLAYERS ? " Note, the player count is under the required limit." : ""]", "Declare war?", list("Yes", "No"))

	if(are_you_sure != "Yes")
		return

	var/war_declaration = "A syndicate fringe group has declared their intent to utterly destroy [station_name()] with a nuclear device, and dares the crew to try and stop them."

	var/custom_threat = tgui_alert(usr, "Quer personalizar a declaração?", "Customize?", list("Yes", "No"))

	if(custom_threat == "Yes")
		war_declaration = tgui_input_text(usr, "Insert your custom declaration", "Declaration", max_length = MAX_MESSAGE_LEN, multiline = TRUE, encode = FALSE)

	if(!war_declaration)
		tgui_alert(usr, "Declaração de guerra inválida.", "Poor Choice of Words")
		return

	for(var/obj/item/circuitboard/computer/syndicate_shuttle/board as anything in GLOB.syndicate_shuttle_boards)
		if(board.challenge_start_time)
			tgui_alert(usr, "A guerra já foi declarada!", "War Was Declared")
			return

	war_was_declared(memo = war_declaration)

/obj/item/nuclear_challenge/proc/war_was_declared(mob/living/user, memo)
	priority_announce(
		text = memo,
		title = "Declaração de Guerra",
		sound = announcement_sound,
		has_important_message = TRUE,
		sender_override = "Nuclear Operative Outpost",
		color_override = "red",
	)
	if(user)
		to_chat(user, "Você atraiu a atenção de forças poderosas dentro do sindicato. Um pacote bônus de telecristais foi concedido à sua equipe. Grandes coisas esperam por você se completar a missão.")

	distribute_tc()
	CONFIG_SET(number/shuttle_refuel_delay, max(CONFIG_GET(number/shuttle_refuel_delay), CHALLENGE_SHUTTLE_DELAY))
	SSblackbox.record_feedback("amount", "nuclear_challenge_mode", 1)

	for(var/obj/item/circuitboard/computer/syndicate_shuttle/board as anything in GLOB.syndicate_shuttle_boards)
		board.challenge_start_time = world.time

	for(var/obj/machinery/computer/camera_advanced/shuttle_docker/dock as anything in GLOB.jam_on_wardec)
		dock.jammed = TRUE

	var/datum/techweb/station_techweb = locate(/datum/techweb/science) in SSresearch.techwebs
	if(station_techweb)
		var/obj/machinery/announcement_system/announcement_system = get_announcement_system(null, null, list(RADIO_CHANNEL_SCIENCE))
		if (!isnull(announcement_system))
			announcement_system.broadcast("Additional research data received from Nanotrasen R&D Division following the emergency protocol.", list(RADIO_CHANNEL_SCIENCE), TRUE)
		station_techweb.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS * 3))

	qdel(src)

/obj/item/nuclear_challenge/proc/distribute_tc()
	var/list/orphans = list()
	var/list/uplinks = list()

	for (var/datum/mind/M in get_antag_minds(/datum/antagonist/nukeop))
		if (iscyborg(M.current))
			continue
		var/datum/component/uplink/uplink = M.find_syndicate_uplink()
		if (!uplink)
			orphans += M.current
			continue
		uplinks += uplink

	var/tc_to_distribute = CHALLENGE_TELECRYSTALS
	var/tc_per_nukie = round(tc_to_distribute / (length(orphans)+length(uplinks)))

	for (var/datum/component/uplink/uplink in uplinks)
		uplink.uplink_handler.add_telecrystals(tc_per_nukie)
		tc_to_distribute -= tc_per_nukie

	for (var/mob/living/L in orphans)
		var/TC = new /obj/item/stack/telecrystal(L.drop_location(), tc_per_nukie)
		to_chat(L, span_warning("Seu uplink não pôde ser encontrado então sua parte do bônus da equipe telecristais foi bluespaced para o seu[L.put_in_hands(TC) ? "hands" : "feet"]."))
		tc_to_distribute -= tc_per_nukie

	if (tc_to_distribute > 0) // What shall we do with the remainder...
		for (var/mob/living/basic/carp/pet/cayenne/C in GLOB.mob_living_list)
			if (C.stat != DEAD)
				var/obj/item/stack/telecrystal/TC = new(C.drop_location(), tc_to_distribute)
				TC.throw_at(get_step(C, C.dir), 3, 3)
				C.visible_message(span_notice("[C]Um meio digerido telecristal"),span_notice("Você tossiu um telecristal meio digerido!"))
				break


/obj/item/nuclear_challenge/proc/check_allowed(mob/living/user)
	if(declaring_war)
		to_chat(user, span_boldwarning("Você já está em processo de declarar guerra! Decida-se."))
		return FALSE
	if(GLOB.player_list.len < CHALLENGE_MIN_PLAYERS)
		to_chat(user, span_boldwarning("A tripulação inimiga é muito pequena para valer a pena declarar guerra."))
		return FALSE
	if(!user.onSyndieBase())
		to_chat(user, span_boldwarning("Você tem que estar na sua base para usar isso."))
		return FALSE
	if(world.time - SSticker.round_start_time > CHALLENGE_TIME_LIMIT)
		to_chat(user, span_boldwarning("É tarde demais para declarar hostilidades. Seus benfeitores já estão ocupados com outros esquemas. Terá que se contentar com o que tem na mão."))
		return FALSE
	for(var/obj/item/circuitboard/computer/syndicate_shuttle/board as anything in GLOB.syndicate_shuttle_boards)
		if(board.moved)
			to_chat(user, span_boldwarning("A nave já foi movida! Você perdeu o direito de declarar guerra."))
			return FALSE
		if(board.challenge_start_time)
			to_chat(user, span_boldwarning("A guerra já foi declarada!"))
			return FALSE
	return TRUE

/obj/item/nuclear_challenge/clownops
	uplink_type = /obj/item/uplink/clownop
	announcement_sound = 'sound/announcer/alarm/clownops.ogg'

/// Subtype that does nothing but plays the war op message. Intended for debugging
/obj/item/nuclear_challenge/literally_just_does_the_message
	name = "\"Declaration of War\""
	desc = "É uma Declaração de Guerra do Sindicato, mas só toca o som alto e a mensagem. Nada mais."
	var/admin_only = TRUE

/obj/item/nuclear_challenge/literally_just_does_the_message/check_allowed(mob/living/user)
	if(admin_only && !check_rights_for(user.client, R_SPAWN|R_FUN|R_DEBUG))
		to_chat(user, span_hypnophrase("Você não deveria ter isso!"))
		return FALSE

	return TRUE

/obj/item/nuclear_challenge/literally_just_does_the_message/war_was_declared(mob/living/user, memo)
#ifndef TESTING
	// Reminder for our friends the admins
	var/are_you_sure = tgui_alert(user, "Último segundo lembrete de que declarações falsas de guerra são uma ideia horrível e sim, isso faz tudo, então tenha cuidado com o que está fazendo.", "Don't do it", list("I'm sure", "You're right"))
	if(are_you_sure != "I'm sure")
		return
#endif

	priority_announce(
		text = memo,
		title = "Declaração de Guerra",
		sound = announcement_sound,
		has_important_message = TRUE,
		sender_override = "Nuclear Operative Outpost",
		color_override = "red",
	)

/obj/item/nuclear_challenge/literally_just_does_the_message/distribute_tc()
	return

#undef CHALLENGE_TELECRYSTALS
#undef CHALLENGE_TIME_LIMIT
#undef CHALLENGE_SHUTTLE_DELAY
