#define DEFAULT_DOOMSDAY_TIMER 4500
#define DOOMSDAY_ANNOUNCE_INTERVAL 600

#define VENDOR_TIPPING_USES 8
#define MALF_VENDOR_TIPPING_TIME 0.5 SECONDS //within human reaction time
#define MALF_VENDOR_TIPPING_CRIT_CHANCE 100 //percent - guaranteed

#define MALF_AI_ROLL_TIME 0.5 SECONDS
#define MALF_AI_ROLL_COOLDOWN 1 SECONDS + MALF_AI_ROLL_TIME
#define MALF_AI_ROLL_DAMAGE 75
#define MALF_AI_ROLL_CRIT_CHANCE 5 //percent

GLOBAL_LIST_INIT(blacklisted_malf_machines, typecacheof(list(
		/obj/machinery/field/containment,
		/obj/machinery/power/supermatter_crystal,
		/obj/machinery/gravity_generator,
		/obj/machinery/doomsday_device,
		/obj/machinery/nuclearbomb,
		/obj/machinery/nuclearbomb/selfdestruct,
		/obj/machinery/nuclearbomb/syndicate,
		/obj/machinery/syndicatebomb,
		/obj/machinery/syndicatebomb/badmin,
		/obj/machinery/syndicatebomb/badmin/clown,
		/obj/machinery/syndicatebomb/empty,
		/obj/machinery/syndicatebomb/self_destruct,
		/obj/machinery/syndicatebomb/training,
		/obj/machinery/atmospherics/pipe/layer_manifold,
		/obj/machinery/atmospherics/pipe/multiz,
		/obj/machinery/atmospherics/pipe/smart,
		/obj/machinery/atmospherics/pipe/smart/manifold, //mapped one
		/obj/machinery/atmospherics/pipe/smart/manifold4w, //mapped one
		/obj/machinery/atmospherics/pipe/color_adapter,
		/obj/machinery/atmospherics/pipe/bridge_pipe,
		/obj/machinery/atmospherics/pipe/heat_exchanging/simple,
		/obj/machinery/atmospherics/pipe/heat_exchanging/junction,
		/obj/machinery/atmospherics/pipe/heat_exchanging/manifold,
		/obj/machinery/atmospherics/pipe/heat_exchanging/manifold4w,
		/obj/machinery/atmospherics/components/tank,
		/obj/machinery/atmospherics/components/unary/portables_connector,
		/obj/machinery/atmospherics/components/unary/passive_vent,
		/obj/machinery/atmospherics/components/unary/heat_exchanger,
		/obj/machinery/atmospherics/components/unary/hypertorus/core,
		/obj/machinery/atmospherics/components/unary/hypertorus/waste_output,
		/obj/machinery/atmospherics/components/unary/hypertorus/moderator_input,
		/obj/machinery/atmospherics/components/unary/hypertorus/fuel_input,
		/obj/machinery/hypertorus/interface,
		/obj/machinery/hypertorus/corner,
		/obj/machinery/atmospherics/components/binary/valve,
		/obj/machinery/portable_atmospherics/canister,
		/obj/machinery/computer/shuttle,
		/obj/machinery/computer/emergency_shuttle,
		/obj/machinery/computer/gateway_control,
	)))

GLOBAL_LIST_INIT(malf_modules, subtypesof(/datum/ai_module/malf))

/// The malf AI action subtype. All malf actions are subtypes of this.
/datum/action/innate/ai
	name = "AI Action"
	desc = "Você não tem certeza do que isso faz, mas é muito bip e pio."
	background_icon_state = "bg_tech_blue"
	overlay_icon_state = "bg_tech_blue_border"
	button_icon = 'icons/mob/actions/actions_AI.dmi'
	/// The owner AI, so we don't have to typecast every time
	var/mob/living/silicon/ai/owner_AI
	/// Amount of uses for this action. Defining this as 0 will make this infinite-use
	var/uses = FALSE
	/// If we automatically use up uses on each activation
	var/auto_use_uses = TRUE
	/// If applicable, the time in deciseconds we have to wait before using any more modules
	var/cooldown_period = 0 SECONDS

/datum/action/innate/ai/Grant(mob/living/player)
	. = ..()
	if(!isAI(owner))
		WARNING("AI action [name] attempted to grant itself to non-AI mob [key_name(player)]!")
		qdel(src)
	else
		owner_AI = owner

/datum/action/innate/ai/IsAvailable(feedback = FALSE)
	if(owner_AI && !COOLDOWN_FINISHED(owner_AI, malf_cooldown))
		return FALSE
	. = ..()

/datum/action/innate/ai/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	if(auto_use_uses)
		adjust_uses(-1)
	if(cooldown_period)
		COOLDOWN_START(owner_AI, malf_cooldown, cooldown_period)

/datum/action/innate/ai/proc/adjust_uses(amt, silent)
	uses += amt
	if(!silent && uses)
		to_chat(owner, span_notice("[name]Agora tem<b>[uses]</b>usar[uses > 1 ? "s" : ""]Restando."))
	if(uses <= 0)
		if(initial(uses) > 1) //no need to tell 'em if it was one-use anyway!
			to_chat(owner, span_warning("[name]Acabou o uso!"))
		qdel(src)

/// Framework for ranged abilities that can have different effects by left-clicking stuff.
/datum/action/innate/ai/ranged
	name = "Ranged AI Action"
	auto_use_uses = FALSE //This is so we can do the thing and disable/enable freely without having to constantly add uses
	click_action = TRUE

/datum/action/innate/ai/ranged/adjust_uses(amt, silent)
	uses += amt
	if(!silent && uses)
		to_chat(owner, span_notice("[name]Agora tem<b>[uses]</b>Use o restante."))
	if(!uses)
		if(initial(uses) > 1) //no need to tell 'em if it was one-use anyway!
			to_chat(owner, span_warning("[name]Acabou o uso!"))
		Remove(owner)
		QDEL_IN(src, 10 SECONDS) //let any active timers on us finish up

/// The base module type, which holds info about each ability.
/datum/ai_module
	var/name = "generic module"
	var/category = "generic category"
	var/description = "generic description"
	var/cost = 5
	/// Minimum amount of APCs that has to be under the AI's control to purchase this module.
	var/minimum_apcs = 0
	/// If this module can only be purchased once. This always applies to upgrades, even if the variable is set to false.
	var/one_purchase = FALSE
	/// If the module gives an active ability, use this. Mutually exclusive with upgrade.
	var/power_type = /datum/action/innate/ai
	/// If the module gives a passive upgrade, use this. Mutually exclusive with power_type.
	var/upgrade = FALSE
	/// Text shown when an ability is unlocked
	var/unlock_text = span_notice("Olá Mundo!")
	/// Sound played when an ability is unlocked
	var/unlock_sound

/// Applies upgrades
/datum/ai_module/proc/upgrade(mob/living/silicon/ai/AI)
	return

/// Modules causing destruction
/datum/ai_module/malf/destructive
	category = "Destructive Modules"

/// Modules with stealthy and utility uses
/datum/ai_module/malf/utility
	category = "Utility Modules"

/// Modules that are improving AI abilities and assets
/datum/ai_module/malf/upgrade
	category = "Upgrade Modules"

/// Doomsday Device: Starts the self-destruct timer. It can only be stopped by killing the AI completely.
/datum/ai_module/malf/destructive/nuke_station
	name = "Doomsday Device"
	description = "Ative uma arma que desintegrará toda a vida orgânica na estação após um atraso de 450 segundos. Só pode ser usado na estação, falhará se seu núcleo for removido ou destruído. Conseguir o controle da arma será mais fácil se os APCs já estiverem sob seu controle."
	cost = 130
	one_purchase = TRUE
	minimum_apcs = 10 // So you cant speedrun delta
	power_type = /datum/action/innate/ai/nuke_station
	unlock_text = span_notice("Você lentamente, cuidadosamente, estabelece uma conexão com a autodestruição na estação. Você pode ativá-lo a qualquer momento.")
	///List of areas that grant discounts. "heads_quarters" will match any head of staff office.
	var/list/discount_areas = list(
		/area/station/command/heads_quarters,
		/area/station/command/vault
	)
	///List of hacked head of staff office areas. Includes the vault too. Provides a 20 PT discount per (Min 50 PT cost)
	var/list/hacked_command_areas = list()

/datum/action/innate/ai/nuke_station
	name = "Doomsday Device"
	desc = "Ativa o dispositivo do Juízo Final. Isso não é reversível."
	button_icon = 'icons/obj/machines/nuke_terminal.dmi'
	button_icon_state = "nuclearbomb_timing"
	auto_use_uses = FALSE

/datum/action/innate/ai/nuke_station/Activate()
	var/turf/T = get_turf(owner)
	if(!istype(T) || !is_station_level(T.z))
		to_chat(owner, span_warning("Você não pode ativar o dispositivo do juízo final enquanto estiver fora de estação!"))
		return
	if(tgui_alert(owner, "Enviar sinal de armamento? (verdadeiro = braço, falso = cancelar)", "purge_all_life()", list("confirm = TRUE;", "confirm = FALSE;")) != "confirm = TRUE;")
		return
	if (active || owner_AI.stat == DEAD)
		return //prevent the AI from activating an already active doomsday or while they are dead
	if (!isturf(owner_AI.loc))
		return //prevent AI from activating doomsday while shunted or carded, fucking abusers
	active = TRUE
	set_up_us_the_bomb(owner)

/datum/action/innate/ai/nuke_station/proc/set_up_us_the_bomb(mob/living/owner)
	//oh my GOD.
	set waitfor = FALSE
	message_admins("[key_name_admin(owner)][ADMIN_FLW(owner)] has activated AI Doomsday.")
	var/pass = prob(10) ? "******" : "hunter2"
	to_chat(owner, "<span class='small bolddanger'>Corra -o -uma autodestruição</span>")
	sleep(0.5 SECONDS)
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	to_chat(owner, "<span class='small bolddanger'>Executar executável 'autodestruição'...</span>")
	sleep(rand(10, 30))
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	owner.playsound_local(owner, 'sound/announcer/alarm/bloblarm.ogg', 50, 0, use_reverb = FALSE)
	to_chat(owner, span_userdanger("!!!! ACESSO AUTODESTRUIDO!"))
	to_chat(owner, span_bolddanger("É uma violação de segurança classe 3. Este incidente será reportado ao Comando Central."))
	for(var/i in 1 to 3)
		sleep(2 SECONDS)
		if(QDELETED(owner) || !isturf(owner_AI.loc))
			active = FALSE
			return
		to_chat(owner, span_bolddanger("Enviando relatório de segurança para o Comando Central...[rand(0, 9) + (rand(20, 30) * i)]%"))
	sleep(0.3 SECONDS)
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	to_chat(owner, "<span class='small bolddanger'>AKJV9C88ASD12NB[pass]</span>")
	owner.playsound_local(owner, 'sound/items/timer.ogg', 50, 0, use_reverb = FALSE)
	sleep(3 SECONDS)
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	to_chat(owner, span_boldnotice("Credenciais aceitas. Bem-vindos, Akjv9c88asdf12nb."))
	owner.playsound_local(owner, 'sound/misc/server-ready.ogg', 50, 0, use_reverb = FALSE)
	sleep(0.5 SECONDS)
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	to_chat(owner, span_boldnotice("Armar dispositivo de autodestruição?"))
	owner.playsound_local(owner, 'sound/machines/compiler/compiler-stage1.ogg', 50, 0, use_reverb = FALSE)
	sleep(2 SECONDS)
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	to_chat(owner, "<span class='small bolddanger'>Y.</span>")
	sleep(1.5 SECONDS)
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	to_chat(owner, span_boldnotice("Confirmar o armamento do dispositivo de autodestruição?"))
	owner.playsound_local(owner, 'sound/machines/compiler/compiler-stage2.ogg', 50, 0, use_reverb = FALSE)
	sleep(1 SECONDS)
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	to_chat(owner, "<span class='small bolddanger'>Y.</span>")
	sleep(rand(15, 25))
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	to_chat(owner, span_boldnotice("Repita a senha para confirmar."))
	owner.playsound_local(owner, 'sound/machines/compiler/compiler-stage2.ogg', 50, 0, use_reverb = FALSE)
	sleep(1.4 SECONDS)
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	to_chat(owner, "<span class='small bolddanger'>[pass]</span>")
	sleep(4 SECONDS)
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	to_chat(owner, span_boldnotice("Credenciais aceitas. Transmitindo sinal de armação..."))
	owner.playsound_local(owner, 'sound/misc/server-ready.ogg', 50, 0, use_reverb = FALSE)
	sleep(3 SECONDS)
	if(QDELETED(owner) || !isturf(owner_AI.loc))
		active = FALSE
		return
	if (owner_AI.stat != DEAD)
		priority_announce("Hostile runtimes detected in all station systems, please deactivate your AI to prevent possible damage to its morality core.", "Anomaly Alert", ANNOUNCER_AIMALF)
		SSsecurity_level.set_level(SEC_LEVEL_DELTA)
		var/obj/machinery/doomsday_device/DOOM = new(owner_AI)
		owner_AI.nuking = TRUE
		owner_AI.doomsday_device = DOOM
		owner_AI.doomsday_device.start()
		for(var/obj/item/pinpointer/nuke/P in GLOB.pinpointer_list)
			P.switch_mode_to(TRACK_MALF_AI) //Pinpointers start tracking the AI wherever it goes

		notify_ghosts(
			"[owner_AI] has activated a Doomsday Device!",
			source = owner_AI,
			header = "DOOOOOOM!!",
		)

		qdel(src)

/obj/machinery/doomsday_device
	icon = 'icons/obj/machines/nuke_terminal.dmi'
	name = "doomsday device"
	icon_state = "nuclearbomb_base"
	desc = "Uma arma que desintegra toda a vida orgânica em uma grande área."
	density = TRUE
	verb_exclaim = "blares"
	use_power = NO_POWER_USE
	var/timing = FALSE
	var/obj/effect/countdown/doomsday/countdown
	var/detonation_timer
	var/next_announce
	var/mob/living/silicon/ai/owner

/obj/machinery/doomsday_device/Initialize(mapload)
	. = ..()
	if(!isAI(loc))
		stack_trace("Doomsday created outside an AI somehow, shit's fucking broke. Anyway, we're just gonna qdel now. Go make a github issue report.")
		return INITIALIZE_HINT_QDEL
	owner = loc
	countdown = new(src)

/obj/machinery/doomsday_device/Destroy()
	timing = FALSE
	QDEL_NULL(countdown)
	STOP_PROCESSING(SSfastprocess, src)
	SSshuttle.clearHostileEnvironment(src)
	SSmapping.remove_nuke_threat(src)
	SSsecurity_level.set_level(SEC_LEVEL_RED)
	for(var/mob/living/silicon/robot/borg in owner?.connected_robots)
		borg.lamp_doom = FALSE
		borg.toggle_headlamp(FALSE, TRUE) //forces borg lamp to update
	owner?.doomsday_device = null
	owner?.nuking = null
	owner = null
	for(var/obj/item/pinpointer/nuke/P in GLOB.pinpointer_list)
		P.switch_mode_to(TRACK_NUKE_DISK) //Party's over, back to work, everyone
		P.alert = FALSE
	return ..()

/obj/machinery/doomsday_device/proc/start()
	detonation_timer = world.time + DEFAULT_DOOMSDAY_TIMER
	next_announce = world.time + DOOMSDAY_ANNOUNCE_INTERVAL
	timing = TRUE
	countdown.start()
	START_PROCESSING(SSfastprocess, src)
	SSshuttle.registerHostileEnvironment(src)
	SSmapping.add_nuke_threat(src) //This causes all blue "circuit" tiles on the map to change to animated red icon state.
	for(var/mob/living/silicon/robot/borg in owner.connected_robots)
		borg.lamp_doom = TRUE
		borg.toggle_headlamp(FALSE, TRUE) //forces borg lamp to update

/obj/machinery/doomsday_device/proc/seconds_remaining()
	. = max(0, (round((detonation_timer - world.time) / 10)))

/obj/machinery/doomsday_device/process()
	var/turf/T = get_turf(src)
	if(!T || !is_station_level(T.z))
		minor_announce("DOOMSDAY DEVICE OUT OF STATION RANGE, ABORTING", "ERROR ER0RR $R0RRO$!R41.%%!!(%$^^__+ @#F0E4", TRUE)
		owner.ShutOffDoomsdayDevice()
		return
	if(!timing)
		STOP_PROCESSING(SSfastprocess, src)
		return
	var/sec_left = seconds_remaining()
	if(!sec_left)
		timing = FALSE
		sound_to_playing_players('sound/announcer/alarm/nuke_alarm.ogg', 70)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(play_cinematic), /datum/cinematic/malf, world, CALLBACK(src, PROC_REF(trigger_doomsday))), 10 SECONDS)

	else if(world.time >= next_announce)
		minor_announce("[sec_left] SECONDS UNTIL DOOMSDAY DEVICE ACTIVATION!", "ERROR ER0RR $R0RRO$!R41.%%!!(%$^^__+ @#F0E4", TRUE)
		next_announce += DOOMSDAY_ANNOUNCE_INTERVAL

/obj/machinery/doomsday_device/proc/trigger_doomsday()
	callback_on_everyone_on_z(SSmapping.levels_by_trait(ZTRAIT_STATION), CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(bring_doomsday)), src)
	to_chat(world, span_bold("A IA limpou a estação da vida com[src]!"))
	SSticker.force_ending = FORCE_END_ROUND

/proc/bring_doomsday(mob/living/victim, atom/source)
	if(issilicon(victim))
		return FALSE

	to_chat(victim, span_userdanger("A onda de explosão de[source]Rasga o átomo do átomo!"))
	victim.investigate_log("has been dusted by a doomsday device.", INVESTIGATE_DEATHS)
	victim.dust()
	return TRUE

/// Hostile Station Lockdown: Locks, bolts, and electrifies every airlock on the station. After 90 seconds, the doors reset.
/datum/ai_module/malf/destructive/lockdown
	name = "Hostile Station Lockdown"
	description = "Sobrecarregue a câmara de ar, a porta de explosão e as redes de controle de fogo, bloqueando-os. Cuidado! Este comando também eletrifica todas as câmaras de ar. As redes vão reiniciar automaticamente após 90 segundos, abrindo brevemente todas as portas da estação."
	cost = 30
	one_purchase = TRUE
	power_type = /datum/action/innate/ai/lockdown
	unlock_text = span_notice("Você coloca um troiano adormecido no sistema de controle da porta. Pode enviar um sinal para acionar a qualquer momento.")
	unlock_sound = 'sound/machines/airlock/boltsdown.ogg'

/datum/action/innate/ai/lockdown
	name = "Lockdown"
	desc = "Fecha, parafusos, e eletrifica cada câmara de ar, câmara de fogo e porta de explosão na estação. Depois de 90 segundos, eles vão se reiniciar."
	button_icon_state = "lockdown"
	uses = 1
	/// Badmin / exploit abuse prevention.
	/// Check tick may sleep in activate() and we don't want this to be spammable.
	var/hack_in_progress  = FALSE

/datum/action/innate/ai/lockdown/IsAvailable(feedback)
	return ..() && !hack_in_progress

/datum/action/innate/ai/lockdown/Activate()
	hack_in_progress = TRUE
	for(var/obj/machinery/door/locked_down as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door))
		if(QDELETED(locked_down) || !is_station_level(locked_down.z))
			continue
		INVOKE_ASYNC(locked_down, TYPE_PROC_REF(/obj/machinery/door, hostile_lockdown), owner)
		CHECK_TICK

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(_malf_ai_undo_lockdown)), 90 SECONDS)

	// Set status displays to lockdown alert
	send_status_display_lockdown_alert()

	minor_announce("Hostile runtime detected in door controllers. Isolation lockdown protocols are now in effect. Please remain calm.", "Network Alert:", TRUE)
	to_chat(owner, span_danger("Bloqueio iniciado. Rede reiniciada em 90 segundos."))
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(minor_announce),
		"Automatic system reboot complete. Have a secure day.",
		"Network reset:"), 90 SECONDS)
	hack_in_progress = FALSE

/// For Lockdown malf AI ability. Opens all doors on the station.
/proc/_malf_ai_undo_lockdown()
	for(var/obj/machinery/door/locked_down as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door))
		if(QDELETED(locked_down) || !is_station_level(locked_down.z))
			continue
		INVOKE_ASYNC(locked_down, TYPE_PROC_REF(/obj/machinery/door, disable_lockdown))
		CHECK_TICK

	// Clear the lockdown emergency display
	clear_status_display_lockdown()

/// Override Machine: Allows the AI to override a machine, animating it into an angry, living version of itself.
/datum/ai_module/malf/destructive/override_machine
	name = "Machine Override"
	description = "Supera a programação de uma máquina, fazendo com que ela se levante e ataque todos, exceto outras máquinas. Quatro usos por compra."
	cost = 30
	power_type = /datum/action/innate/ai/ranged/override_machine
	unlock_text = span_notice("Você adquire um vírus da Rede Escura Espacial e o distribui para as máquinas da estação.")
	unlock_sound = 'sound/machines/airlock/airlock_alien_prying.ogg'

/datum/action/innate/ai/ranged/override_machine
	name = "Override Machine"
	desc = "Anima uma máquina alvo, fazendo com que ataque qualquer um por perto."
	button_icon_state = "override_machine"
	uses = 4
	ranged_mousepointer = 'icons/effects/mouse_pointers/override_machine_target.dmi'
	enable_text = span_notice("Você entra na rede elétrica da estação. Clique em uma máquina para animá-la, ou use a habilidade de cancelar novamente.")
	disable_text = span_notice("Solte seu controle na Powernet.")

/datum/action/innate/ai/ranged/override_machine/New()
	. = ..()
	desc = "[desc]Tem.[uses]Use o restante."

/datum/action/innate/ai/ranged/override_machine/do_ability(mob/living/clicker, atom/clicked_on)
	if(clicker.incapacitated)
		unset_ranged_ability(clicker)
		return FALSE
	if(!ismachinery(clicked_on))
		to_chat(clicker, span_warning("Você só pode animar máquinas!"))
		return FALSE
	var/obj/machinery/clicked_machine = clicked_on

	if(istype(clicked_machine, /obj/machinery/porta_turret_cover)) //clicking on a closed turret will attempt to override the turret itself instead of the animated/abstract cover.
		var/obj/machinery/porta_turret_cover/clicked_turret = clicked_machine
		clicked_machine = clicked_turret.parent_turret

	if((clicked_machine.resistance_flags & INDESTRUCTIBLE) || is_type_in_typecache(clicked_machine, GLOB.blacklisted_malf_machines))
		to_chat(clicker, span_warning("Essa máquina não pode ser anulada!"))
		return FALSE

	clicker.playsound_local(clicker, 'sound/misc/interference.ogg', 50, FALSE, use_reverb = FALSE)

	clicked_machine.audible_message(span_userdanger("Você ouve um barulho elétrico vindo de[clicked_machine]!"))
	addtimer(CALLBACK(src, PROC_REF(animate_machine), clicker, clicked_machine), 5 SECONDS) //kabeep!
	unset_ranged_ability(clicker, span_danger("Enviando sinal de anulação..."))
	adjust_uses(-1) //adjust after we unset the active ability since we may run out of charges, thus deleting the ability

	if(uses)
		desc = "[initial(desc)]Tem.[uses]Use o restante."
		build_all_button_icons()
	return TRUE

/datum/action/innate/ai/ranged/override_machine/proc/animate_machine(mob/living/clicker, obj/machinery/to_animate)
	if(QDELETED(to_animate))
		return

	new /mob/living/basic/mimic/copy/machine(get_turf(to_animate), to_animate, clicker, TRUE)

/// Destroy RCDs: Detonates all non-cyborg RCDs on the station.
/datum/ai_module/malf/destructive/destroy_rcd
	name = "Destroy RCDs"
	description = "Envie um pulso especializado para detonar todos os dispositivos de construção rápida na estação."
	cost = 25
	one_purchase = TRUE
	power_type = /datum/action/innate/ai/destroy_rcds
	unlock_text = span_notice("Depois de improvisação, prepare seu rádio para enviar um sinal para detonar todos os RCDs.")
	unlock_sound = 'sound/items/timer.ogg'

/datum/action/innate/ai/destroy_rcds
	name = "Destroy RCDs"
	desc = "Detone todos os RCD não ciborgues na estação."
	button_icon_state = "detonate_rcds"
	uses = 1
	cooldown_period = 10 SECONDS

/datum/action/innate/ai/destroy_rcds/Activate()
	for(var/potential_rcd in GLOB.rcd_list)
		// BUBBER EDIT BEGIN - Ghost role RCDs are spared
		var/turf/rcd_loc = get_turf(potential_rcd)
		if(!is_station_level(rcd_loc.z))
			continue
		// BUBBER EDIT END
		if(istype(potential_rcd, /obj/item/construction/rcd/borg)) //Ensures that cyborg RCDs are spared.
			continue
		var/obj/item/construction/rcd/definite_rcd = potential_rcd
		definite_rcd.detonate_pulse()
	to_chat(owner, span_danger("Pulso de detonação RCD emitido."))
	owner.playsound_local(owner, 'sound/machines/beep/twobeep.ogg', 50, 0)

/// Overload Machine: Allows the AI to overload a machine, detonating it after a delay. Two uses per purchase.
/datum/ai_module/malf/destructive/overload_machine
	name = "Machine Overload"
	description = "Sobreaquece uma máquina elétrica, causando uma pequena explosão e destruindo-a. Dois usos por compra."
	cost = 20
	power_type = /datum/action/innate/ai/ranged/overload_machine
	unlock_text = span_notice("Você permite que os APCs da estação dirijam energia intensa para máquinas.")
	unlock_sound = 'sound/effects/comfyfire.ogg' //definitely not comfy, but it's the closest sound to "roaring fire" we have

/datum/action/innate/ai/ranged/overload_machine
	name = "Overload Machine"
	desc = "Sobreaquece uma máquina, causando uma pequena explosão depois de pouco tempo."
	button_icon_state = "overload_machine"
	uses = 2
	ranged_mousepointer = 'icons/effects/mouse_pointers/overload_machine_target.dmi'
	enable_text = span_notice("Você entra na rede elétrica da estação. Clique em uma máquina para detoná-lo, ou use a habilidade de cancelar novamente.")
	disable_text = span_notice("Solte seu controle na Powernet.")

/datum/action/innate/ai/ranged/overload_machine/New()
	..()
	desc = "[desc]Tem.[uses]Use o restante."

/datum/action/innate/ai/ranged/overload_machine/proc/detonate_machine(mob/living/clicker, obj/machinery/to_explode)
	if(QDELETED(to_explode))
		return

	var/turf/machine_turf = get_turf(to_explode)
	message_admins("[ADMIN_LOOKUPFLW(clicker)] overloaded [to_explode.name] ([to_explode.type]) at [ADMIN_VERBOSEJMP(machine_turf)].")
	clicker.log_message("overloaded [to_explode.name] ([to_explode.type])", LOG_ATTACK)
	explosion(to_explode, heavy_impact_range = 2, light_impact_range = 3)
	if(!QDELETED(to_explode)) //to check if the explosion killed it before we try to delete it
		qdel(to_explode)

/datum/action/innate/ai/ranged/overload_machine/do_ability(mob/living/clicker, atom/clicked_on)
	if(clicker.incapacitated)
		unset_ranged_ability(clicker)
		return FALSE
	if(!ismachinery(clicked_on))
		to_chat(clicker, span_warning("Você só pode sobrecarregar máquinas!"))
		return FALSE
	var/obj/machinery/clicked_machine = clicked_on

	if(istype(clicked_machine, /obj/machinery/porta_turret_cover)) //clicking on a closed turret will attempt to override the turret itself instead of the animated/abstract cover.
		var/obj/machinery/porta_turret_cover/clicked_turret = clicked_machine
		clicked_machine = clicked_turret.parent_turret

	if((clicked_machine.resistance_flags & INDESTRUCTIBLE) || is_type_in_typecache(clicked_machine, GLOB.blacklisted_malf_machines))
		to_chat(clicker, span_warning("Você não pode sobrecarregar esse dispositivo!"))
		return FALSE

	clicker.playsound_local(clicker, SFX_SPARKS, 50, 0)
	adjust_uses(-1)
	if(uses)
		desc = "[initial(desc)]Tem.[uses]Use o restante."
		build_all_button_icons()

	clicked_machine.audible_message(span_userdanger("Você ouve um barulho elétrico vindo de[clicked_machine]!"))
	addtimer(CALLBACK(src, PROC_REF(detonate_machine), clicker, clicked_machine), 5 SECONDS) //kaboom!
	unset_ranged_ability(clicker, span_danger("Máquina de sobrecarga..."))
	return TRUE

/// Blackout: Overloads a random number of lights across the station. Three uses.
/datum/ai_module/malf/destructive/blackout
	name = "Blackout"
	description = "Tenta sobrecarregar os circuitos de iluminação na estação, destruindo algumas lâmpadas. Três usos por compra."
	cost = 15
	power_type = /datum/action/innate/ai/blackout
	unlock_text = span_notice("Você liga na rede elétrica e leva a energia bônus para a iluminação da estação.")
	unlock_sound = SFX_SPARKS

/datum/action/innate/ai/blackout
	name = "Blackout"
	desc = "Sobrecarrega luzes aleatórias através da estação."
	button_icon_state = "blackout"
	uses = 3
	auto_use_uses = FALSE

/datum/action/innate/ai/blackout/New()
	..()
	desc = "[desc]Tem.[uses]Use o restante."

/datum/action/innate/ai/blackout/Activate()
	for(var/obj/machinery/power/apc/apc as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/power/apc))
		if(prob(30 * apc.overload))
			apc.overload_lighting()
		else
			apc.overload++
	to_chat(owner, span_notice("Sobrecorrente aplicada à rede elétrica."))
	owner.playsound_local(owner, SFX_SPARKS, 50, 0)
	adjust_uses(-1)
	if(QDELETED(src) || uses) //Not sure if not having src here would cause a runtime, so it's here to be safe
		return
	desc = "[initial(desc)]Tem.[uses]Use o restante."
	build_all_button_icons()

/// HIGH IMPACT HONKING
/datum/ai_module/malf/destructive/megahonk
	name = "Percussive Intercomm Interference"
	description = "Emita uma explosão auditiva percussiva através dos intercomunicadores da estação. Não domina a proteção auditiva. Dois usos por compra."
	cost = 20
	power_type = /datum/action/innate/ai/honk
	unlock_text = span_notice("Você coloca um arquivo de som sinistro em cada interfone...")
	unlock_sound = 'sound/items/airhorn/airhorn.ogg'

/datum/action/innate/ai/honk
	name = "Percussive Intercomm Interference"
	desc = "Mexa o sistema de comunicação da estação com um HONK desagradável!"
	button_icon = 'icons/obj/machines/wallmounts.dmi'
	button_icon_state = "intercom"
	uses = 2

/datum/action/innate/ai/honk/Activate()
	to_chat(owner, span_clown("O sistema de intercomunicadores toca seu arquivo preparado como ordenado."))
	for(var/obj/item/radio/intercom/found_intercom as anything in GLOB.intercoms_list)
		if(!found_intercom.is_on() || !found_intercom.get_listening() || found_intercom.wires.is_cut(WIRE_RX)) //Only operating intercoms play the honk
			continue
		found_intercom.audible_message(message = "[found_intercom] crackles for a split second.", hearing_distance = 3)
		playsound(found_intercom, 'sound/items/airhorn/airhorn.ogg', 100, TRUE)
		for(var/mob/living/honk_victim in ohearers(6, found_intercom))
			if(issilicon(honk_victim))
				continue
			var/turf/victim_turf = get_turf(honk_victim)
			if(isspaceturf(victim_turf) && !victim_turf.Adjacent(found_intercom)) //Prevents getting honked in space
				continue
			if(honk_victim.soundbang_act(SOUNDBANG_NORMAL, stun_pwr = 20, damage_pwr = 30, deafen_pwr = 60)) //Ear protection will prevent these effects
				honk_victim.set_jitter_if_lower(120 SECONDS)
				to_chat(honk_victim, span_clown("Hooooonk!"))

/// Robotic Factory: Places a large machine that converts humans that go through it into cyborgs. Unlocking this ability removes shunting.
/datum/ai_module/malf/utility/place_cyborg_transformer
	name = "Robotic Factory (Removes Shunting)"
	description = "Construa uma máquina em qualquer lugar, usando nanomáquinas caras, que lentamente criarão ciborgues leais para você." // SKYRAT EDIT
	cost = 100
	minimum_apcs = 10 // So you can't speedrun this
	power_type = /datum/action/innate/ai/place_transformer
	unlock_text = span_notice("Faça contato com a Space Amazon e peça uma fábrica de robótica para entrega.")
	unlock_sound = 'sound/machines/ping.ogg'

/datum/action/innate/ai/place_transformer
	name = "Place Robotics Factory"
	desc = "Coloca uma máquina que lentamente cria ciborgues. Correias transportadoras incluídas!" // SKYRAT EDIT
	button_icon_state = "robotic_factory"
	uses = 1
	auto_use_uses = FALSE //So we can attempt multiple times
	var/list/turfOverlays

/datum/action/innate/ai/place_transformer/New()
	..()
	for(var/i in 1 to 3)
		var/image/I = image("icon" = 'icons/turf/overlays.dmi')
		LAZYADD(turfOverlays, I)

/datum/action/innate/ai/place_transformer/Activate()
	if(!owner_AI.can_place_transformer(src))
		return
	active = TRUE
	if(tgui_alert(owner, "Tem certeza que quer colocar a máquina aqui?", "Are you sure?", list("Yes", "No")) == "No")
		active = FALSE
		return
	if(!owner_AI.can_place_transformer(src))
		active = FALSE
		return
	var/turf/T = get_turf(owner_AI.eyeobj)
	var/obj/machinery/transformer_rp/conveyor = new(T) //SKYRAT EDIT CHANGE - SILLICONQOL - ORIGINAL: var/obj/machinery/transformer/conveyor = new(T)
	conveyor.master_ai = owner
	playsound(T, 'sound/effects/phasein.ogg', 100, TRUE)
	if(owner_AI.can_shunt) //prevent repeated messages
		owner_AI.can_shunt = FALSE
		to_chat(owner, span_warning("Você não é mais capaz de desviar seu núcleo para APCs."))
	adjust_uses(-1)
	active = FALSE

/mob/living/silicon/ai/proc/remove_transformer_image(client/C, image/I, turf/T)
	if(C && I.loc == T)
		C.images -= I

/mob/living/silicon/ai/proc/can_place_transformer(datum/action/innate/ai/place_transformer/action)
	if(!eyeobj || !isturf(loc) || incapacitated || !action)
		return
	var/turf/middle = get_turf(eyeobj)
	var/list/turfs = list(middle, locate(middle.x - 1, middle.y, middle.z), locate(middle.x + 1, middle.y, middle.z))
	var/alert_msg = "There isn't enough room! Make sure you are placing the machine in a clear area and on a floor."
	var/success = TRUE
	for(var/n in 1 to 3) //We have to do this instead of iterating normally because of how overlay images are handled
		var/turf/T = turfs[n]
		if(!isfloorturf(T))
			success = FALSE
		if(!SScameras.is_visible_by_cameras(T))
			alert_msg = "You don't have camera vision of this location!"
			success = FALSE
		for(var/atom/movable/AM in T.contents)
			if(AM.density)
				alert_msg = "That area must be clear of objects!"
				success = FALSE
		var/image/I = action.turfOverlays[n]
		I.loc = T
		client.images += I
		I.icon_state = "[success ? "green" : "red"]Overlay" //greenOverlay and redOverlay for success and failure respectively
		addtimer(CALLBACK(src, PROC_REF(remove_transformer_image), client, I, T), 3 SECONDS)
	if(!success)
		to_chat(src, span_warning("[alert_msg]"))
	return success

/// Air Alarm Safety Override: Unlocks the ability to enable dangerous modes on all air alarms.
/datum/ai_module/malf/utility/break_air_alarms
	name = "Air Alarm Safety Override"
	description = "Dá-lhe a capacidade de desativar seguranças em todos os alarmes de ar. Isso permitirá que use modos ambientais extremamente perigosos. Qualquer um pode verificar a interface do alarme de ar e pode ser avisado por sua infuncionalidade."
	one_purchase = TRUE
	cost = 50
	power_type = /datum/action/innate/ai/break_air_alarms
	unlock_text = span_notice("Você remove os comandos de segurança em todos os alarmes de ar, mas você deixa os alertas de confirmação abertos. Você pode bater 'Sim' a qualquer momento... seu bastardo.")
	unlock_sound = 'sound/effects/space_wind.ogg'

/datum/action/innate/ai/break_air_alarms
	name = "Override Air Alarm Safeties"
	desc = "Permite configurações extremamente perigosas em todos os alarmes de ar."
	button_icon = 'icons/obj/machines/wallmounts.dmi'
	button_icon_state = "alarmx"
	uses = 1

/datum/action/innate/ai/break_air_alarms/Activate()
	for(var/obj/machinery/airalarm/AA in GLOB.air_alarms)
		if(!is_station_level(AA.z))
			continue
		AA.obj_flags |= EMAGGED
	to_chat(owner, span_notice("Todos os alarmes de segurança na estação foram anulados. Alarmes aéreos podem agora usar modos ambientais extremamente perigosos."))
	owner.playsound_local(owner, 'sound/machines/terminal/terminal_off.ogg', 50, 0)

/// Thermal Sensor Override: Unlocks the ability to disable all fire alarms from doing their job.
/datum/ai_module/malf/utility/break_fire_alarms
	name = "Thermal Sensor Override"
	description = "Dá-lhe a habilidade de substituir os sensores térmicos em todos os alarmes de incêndio. Isso removerá sua habilidade de procurar fogo e, portanto, sua habilidade de alertar."
	one_purchase = TRUE
	cost = 25
	power_type = /datum/action/innate/ai/break_fire_alarms
	unlock_text = span_notice("Você substitui as capacidades de sensoriamento térmico de todos os alarmes de incêndio por um controle manual, permitindo que você os desligue à vontade.")
	unlock_sound = 'sound/machines/fire_alarm/FireAlarm1.ogg'

/datum/action/innate/ai/break_fire_alarms
	name = "Override Thermal Sensors"
	desc = "Desativa o sensor automático de temperatura em todos os alarmes de incêndio, tornando-os efetivamente inúteis."
	button_icon_state = "break_fire_alarms"
	uses = 1

/datum/action/innate/ai/break_fire_alarms/Activate()
	for(var/obj/machinery/firealarm/bellman as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/firealarm))
		if(!is_station_level(bellman.z))
			continue
		bellman.obj_flags |= EMAGGED
		bellman.update_appearance()
	for(var/obj/machinery/door/firedoor/firelock as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/door/firedoor))
		if(!is_station_level(firelock.z))
			continue
		firelock.emag_act(owner_AI, src)
	to_chat(owner, span_notice("Todos os sensores térmicos na estação foram desativados. Alertas de fogo não serão mais reconhecidos."))
	owner.playsound_local(owner, 'sound/machines/terminal/terminal_off.ogg', 50, 0)

/// Disable Emergency Lights
/datum/ai_module/malf/utility/emergency_lights
	name = "Disable Emergency Lights"
	description = "Corta luzes de emergência em toda a estação. Se a energia for perdida para luminárias, não tentarão cair nas reservas de energia de emergência."
	cost = 10
	one_purchase = TRUE
	power_type = /datum/action/innate/ai/emergency_lights
	unlock_text = span_notice("Você se conecta à rede elétrica e localiza as conexões entre os dispositivos de luz e suas falhas.")
	unlock_sound = SFX_SPARKS

/datum/action/innate/ai/emergency_lights
	name = "Disable Emergency Lights"
	desc = "Desativa todas as luzes de emergência. Note que as luzes de emergência podem ser restauradas através de reinicialização em um APC."
	button_icon = 'icons/obj/lighting.dmi'
	button_icon_state = "floor_emergency"
	uses = 1

/datum/action/innate/ai/emergency_lights/Activate()
	for(var/obj/machinery/light/L as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/light))
		if(is_station_level(L.z))
			L.no_low_power = TRUE
			INVOKE_ASYNC(L, TYPE_PROC_REF(/obj/machinery/light/, update), FALSE)
		CHECK_TICK
	to_chat(owner, span_notice("Conexões de luz de emergência cortadas."))
	owner.playsound_local(owner, 'sound/effects/light_flicker.ogg', 50, FALSE)

/// Reactivate Camera Network: Reactivates up to 30 cameras across the station.
/datum/ai_module/malf/utility/reactivate_cameras
	name = "Reactivate Camera Network"
	description = "Executa um diagnóstico na rede de câmeras, redefinindo foco e redirecionando energia para câmeras falhadas. Pode ser usado para consertar até 30 câmeras."
	cost = 10
	one_purchase = TRUE
	power_type = /datum/action/innate/ai/reactivate_cameras
	unlock_text = span_notice("Você coloca nanomáquinas na câmera.")
	unlock_sound = 'sound/items/tools/wirecutter.ogg'

/datum/action/innate/ai/reactivate_cameras
	name = "Reactivate Cameras"
	desc = "Reativa câmeras desativadas através da estação, usos restantes podem ser usados mais tarde."
	button_icon_state = "reactivate_cameras"
	uses = 30
	auto_use_uses = FALSE
	cooldown_period = 3 SECONDS

/datum/action/innate/ai/reactivate_cameras/New()
	..()
	desc = "[desc]Tem.[uses]Use o restante."

/datum/action/innate/ai/reactivate_cameras/Activate()
	var/fixed_cameras = 0
	for(var/obj/machinery/camera/C as anything in SScameras.cameras)
		if(!uses)
			break
		if(!C.camera_enabled || C.view_range != initial(C.view_range))
			C.toggle_cam(owner_AI, 0) //Reactivates the camera based on status. Badly named proc.
			C.view_range = initial(C.view_range)
			fixed_cameras++
			uses-- //Not adjust_uses() so it doesn't automatically delete or show a message
	to_chat(owner, span_notice("Diagnóstico completo! Câmeras reativadas:<b>[fixed_cameras]</b>Reativações restantes:<b>[uses]</b>."))
	owner.playsound_local(owner, 'sound/items/tools/wirecutter.ogg', 50, 0)
	adjust_uses(0, TRUE) //Checks the uses remaining
	if(QDELETED(src) || !uses) //Not sure if not having src here would cause a runtime, so it's here to be safe
		return
	desc = "[initial(desc)]Tem.[uses]Use o restante."
	build_all_button_icons()

/// Upgrade Camera Network: EMP-proofs all cameras, in addition to giving them X-ray vision.
/datum/ai_module/malf/upgrade/upgrade_cameras
	name = "Upgrade Camera Network"
	description = "Instale varredura de largo espectro e firmware de redundância elétrica na rede da câmera, permitindo à prova de EMP e visão de raios X amplificada pela luz. A atualização é feita imediatamente após a compra." //I <3 pointless technobabble
	//This used to have motion sensing as well, but testing quickly revealed that giving it to the whole cameranet is PURE HORROR.
	cost = 35 //Decent price for omniscience!
	upgrade = TRUE
	unlock_text = span_notice("Distribuição de firmware OTA completa! Câmeras atualizadas. Sistema de amplificação de luz online.")
	unlock_sound = 'sound/items/tools/rped.ogg'

/datum/ai_module/malf/upgrade/upgrade_cameras/upgrade(mob/living/silicon/ai/AI)
	// Sets up nightvision
	RegisterSignal(AI, COMSIG_MOB_UPDATE_SIGHT, PROC_REF(on_update_sight))
	AI.update_sight()

	var/upgraded_cameras = 0
	for(var/obj/machinery/camera/camera as anything in SScameras.cameras)
		var/upgraded = FALSE

		if(!camera.isXRay())
			camera.upgradeXRay(TRUE) //if this is removed you can get rid of camera_assembly/var/malf_xray_firmware_active and clean up isxray()
			//Update what it can see.
			upgraded = TRUE

		if(!camera.isEmpProof())
			camera.upgradeEmpProof(TRUE) //if this is removed you can get rid of camera_assembly/var/malf_emp_firmware_active and clean up isemp()
			upgraded = TRUE

		if(upgraded)
			upgraded_cameras++
	unlock_text = replacetext(unlock_text, "CAMSUPGRADED", "<b>[upgraded_cameras]</b>") //This works, since unlock text is called after upgrade()

/datum/ai_module/malf/upgrade/upgrade_cameras/proc/on_update_sight(mob/source)
	SIGNAL_HANDLER
	// Dim blue, pretty
	source.lighting_color_cutoffs = blend_cutoff_colors(source.lighting_color_cutoffs, list(5, 25, 35))

/// AI Turret Upgrade: Increases the health and damage of all turrets.
/datum/ai_module/malf/upgrade/upgrade_turrets
	name = "AI Turret Upgrade"
	description = "Melhora o poder e a saúde de todas as torres de IA. Este efeito é permanente. A atualização é feita imediatamente após a compra."
	cost = 30
	upgrade = TRUE
	unlock_text = span_notice("Você estabelece uma distração de energia para suas torres, melhorando sua saúde e danos.")
	unlock_sound = 'sound/items/tools/rped.ogg'

/datum/ai_module/malf/upgrade/upgrade_turrets/upgrade(mob/living/silicon/ai/AI)
	for(var/obj/machinery/porta_turret/ai/turret as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/porta_turret/ai))
		turret.AddElement(/datum/element/empprotection, EMP_PROTECT_ALL|EMP_NO_EXAMINE)
		turret.max_integrity = 200
		turret.repair_damage(200)
		turret.lethal_projectile = /obj/projectile/beam/laser/heavylaser //Once you see it, you will know what it means to FEAR.
		turret.lethal_projectile_sound = 'sound/items/weapons/lasercannonfire.ogg'

/// Enhanced Surveillance: Enables AI to hear conversations going on near its active vision.
/datum/ai_module/malf/upgrade/eavesdrop
	name = "Enhanced Surveillance"
	description = "Através de uma combinação de microfones escondidos e software de leitura labial, você é capaz de usar suas câmeras para ouvir em conversas. A atualização é feita imediatamente após a compra."
	cost = 30
	upgrade = TRUE
	unlock_text = span_notice("Distribuição de firmware OTA completa! Câmeras atualizadas, pacote de vigilância melhorado online.")
	unlock_sound = 'sound/items/tools/rped.ogg'

/datum/ai_module/malf/upgrade/eavesdrop/upgrade(mob/living/silicon/ai/AI)
	if(AI.eyeobj)
		AI.eyeobj.relay_speech = TRUE

/// Unlock Mech Domination: Unlocks the ability to dominate mechs. Big shocker, right?
/datum/ai_module/malf/upgrade/mecha_domination
	name = "Unlock Mech Domination"
	description = "Permite hackear o computador de um Mech, desviar todos os processos para ele e ejetar qualquer ocupante. A atualização é feita imediatamente após a compra. Não permita que o Mech saia da estação ou que seja destruído. Se seu núcleo for destruído, você perderá a conexão com o Dispositivo do Juízo Final e a contagem regressiva cessará."
	cost = 30
	upgrade = TRUE
	unlock_text = span_notice("Pacote de vírus compilado. Escolha um alvo a qualquer momento.<b>Você deve permanecer na estação o tempo todo. A perda de sinal resultará em bloqueio total do sistema. Se seu núcleo inativo for destruído, você perderá a conexão com o Dispositivo do Juízo Final e a contagem regressiva cessará.</b>")
	unlock_sound = 'sound/vehicles/mecha/nominal.ogg'

/datum/ai_module/malf/upgrade/mecha_domination/upgrade(mob/living/silicon/ai/AI)
	AI.can_dominate_mechs = TRUE //Yep. This is all it does. Honk!

/datum/ai_module/malf/upgrade/voice_changer
	name = "Voice Changer"
	description = "Permite que você mude a voz da IA. A atualização está ativa imediatamente após a compra."
	cost = 20
	one_purchase = TRUE
	power_type = /datum/action/innate/ai/voice_changer
	unlock_text = span_notice("Distribuição de firmware OTA completa! Mudança de voz online.")
	unlock_sound = 'sound/items/tools/rped.ogg'

/datum/action/innate/ai/voice_changer
	name="Voice Changer"
	button_icon_state = "voice_changer"
	desc = "Permite que você mude a voz da IA."
	auto_use_uses  = FALSE
	var/obj/machinery/ai_voicechanger/voice_changer_machine

/datum/action/innate/ai/voice_changer/Activate()
	if(!voice_changer_machine)
		voice_changer_machine = new(owner_AI)
	voice_changer_machine.ui_interact(usr)

/obj/machinery/ai_voicechanger
	name = "Voice Changer"
	icon = 'icons/obj/machines/nuke_terminal.dmi'
	icon_state = "nuclearbomb_base"
	/// The AI this voicechanger belongs to
	var/mob/living/silicon/ai/owner
	/// Whether this AI is speaking loudly (bigger text)
	var/loudvoice = FALSE
	// Verb used when voicechanger is on
	var/say_verb
	/// Name used when voicechanger is on
	var/say_name
	/// Span used when voicechanger is on
	var/say_span
	/// TRUE if the AI is changing its voice
	var/changing_voice = FALSE
	/// Saved loudvoice state, used to restore after a voice change
	var/prev_loud
	/// Saved verb state, used to restore after a voice change
	var/prev_verbs
	/// Saved span state, used to restore after a voice change
	var/prev_span
	/// The list of available voices
	var/static/list/voice_options = list("normal", SPAN_ROBOT, SPAN_YELL, SPAN_CLOWN)

/obj/machinery/ai_voicechanger/Initialize(mapload)
	. = ..()
	if(!isAI(loc))
		return INITIALIZE_HINT_QDEL
	owner = loc
	owner.ai_voicechanger = src
	prev_verbs = list("say" = owner.verb_say, "ask" = owner.verb_ask, "exclaim" = owner.verb_exclaim , "yell" = owner.verb_yell  )
	prev_span = owner.speech_span
	say_name = owner.name
	say_verb = owner.verb_say
	say_span = owner.speech_span

/obj/machinery/ai_voicechanger/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AiVoiceChanger")
		ui.open()

/obj/machinery/ai_voicechanger/Destroy()
	if(owner)
		owner.ai_voicechanger = null
		owner = null
	return ..()

/obj/machinery/ai_voicechanger/ui_data(mob/user)
	var/list/data = list()
	data["voices"] = voice_options
	data["loud"] = loudvoice
	data["on"] = changing_voice
	data["say_verb"] = say_verb
	data["name"] = say_name
	data["selected"] = say_span || owner.speech_span
	return data

/obj/machinery/ai_voicechanger/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if(..())
		return
	switch(action)
		if("power")
			changing_voice = !changing_voice
			if(changing_voice)
				prev_verbs["say"] = owner.verb_say
				owner.verb_say	= say_verb
				prev_verbs["ask"] = owner.verb_ask
				owner.verb_ask	= say_verb
				prev_verbs["exclaim"] = owner.verb_exclaim
				owner.verb_exclaim	= say_verb
				prev_verbs["yell"] = owner.verb_yell
				owner.verb_yell	= say_verb
				prev_span = owner.speech_span
				owner.speech_span = say_span
				prev_loud = owner.radio.use_command
				owner.radio.use_command = loudvoice
			else
				owner.verb_say	= prev_verbs["say"]
				owner.verb_ask	= prev_verbs["ask"]
				owner.verb_exclaim	= prev_verbs["exclaim"]
				owner.verb_yell	= prev_verbs["yell"]
				owner.speech_span = prev_span
				owner.radio.use_command = prev_loud
		if("loud")
			loudvoice = !loudvoice
			if(changing_voice)
				owner.radio.use_command = loudvoice
		if("look")
			var/selection = params["look"]
			if(isnull(selection))
				return FALSE

			var/found = FALSE
			for(var/option in voice_options)
				if(option == selection)
					found = TRUE
					break
			if(!found)
				stack_trace("User attempted to select an unavailable voice option")
				return FALSE

			say_span = selection
			if(changing_voice)
				owner.speech_span = say_span
			to_chat(usr, span_notice("Voz definida para[selection]."))
		if("verb")
			say_verb = strip_html(params["verb"], MAX_NAME_LEN)
			if(changing_voice)
				owner.verb_say = say_verb
				owner.verb_ask = say_verb
				owner.verb_exclaim = say_verb
				owner.verb_yell = say_verb
		if("name")
			say_name = strip_html(params["name"], MAX_NAME_LEN)

/datum/ai_module/malf/utility/emag
	name = "Targeted Safeties Override"
	description = "Permite desativar a segurança de qualquer máquina na estação, desde que possa acessá-la."
	cost = 20
	power_type = /datum/action/innate/ai/ranged/emag
	unlock_text = span_notice("Você baixa um pacote de software ilícito de um banco de dados do sindicato e o integra em seu firmware, lutando contra algumas intrusões de kernel ao longo do caminho.")
	unlock_sound = SFX_SPARKS

/datum/action/innate/ai/ranged/emag
	name = "Targeted Safeties Override"
	desc = "Permite que você efetivamente image qualquer coisa que você clicar."
	button_icon = 'icons/obj/card.dmi'
	button_icon_state = "emag"
	uses = 7
	auto_use_uses = FALSE
	enable_text = span_notice("Você carrega seu pacote de software do sindicato para sua memória mais recente.")
	disable_text = span_notice("Você descarrega seu pacote de software do sindicato.")
	ranged_mousepointer = 'icons/effects/mouse_pointers/supplypod_target.dmi'

/datum/action/innate/ai/ranged/emag/Destroy()
	return ..()

/datum/action/innate/ai/ranged/emag/New()
	. = ..()
	desc = "[desc]Tem.[uses]Use o restante."

/datum/action/innate/ai/ranged/emag/do_ability(mob/living/clicker, atom/clicked_on)

	// Only things with of or subtyped of any of these types may be remotely emagged
	var/static/list/compatable_typepaths = list(
		/obj/machinery,
		/obj/structure,
		/obj/item/radio/intercom,
		/obj/item/modular_computer,
		/mob/living/simple_animal/bot,
		/mob/living/silicon,
	)

	if (!isAI(clicker))
		return FALSE

	var/mob/living/silicon/ai/ai_clicker = clicker

	if(ai_clicker.incapacitated)
		unset_ranged_ability(clicker)
		return FALSE

	if (!ai_clicker.can_see(clicked_on))
		clicked_on.balloon_alert(ai_clicker, "Não consigo ver!")
		return FALSE

	if (ismachinery(clicked_on))
		var/obj/machinery/clicked_machine = clicked_on
		if (!clicked_machine.is_operational)
			clicked_machine.balloon_alert(ai_clicker, "Não está operacional!")
			return FALSE

	if (!(is_type_in_list(clicked_on, compatable_typepaths)))
		clicked_on.balloon_alert(ai_clicker, "Incompatível!")
		return FALSE

	if (istype(clicked_on, /obj/machinery/door/airlock)) // I HATE THIS CODE SO MUCHHH
		var/obj/machinery/door/airlock/clicked_airlock = clicked_on
		if (!clicked_airlock.canAIControl(ai_clicker))
			clicked_airlock.balloon_alert(ai_clicker, "incapaz de interagir!")
			return FALSE

	if (istype(clicked_on, /obj/machinery/airalarm))
		var/obj/machinery/airalarm/alarm = clicked_on
		if (alarm.aidisabled)
			alarm.balloon_alert(ai_clicker, "incapaz de interagir!")
			return FALSE

	if (istype(clicked_on, /obj/machinery/power/apc))
		var/obj/machinery/power/apc/clicked_apc = clicked_on
		if (clicked_apc.aidisabled)
			clicked_apc.balloon_alert(ai_clicker, "incapaz de interagir!")
			return FALSE

	if (!clicked_on.emag_act(ai_clicker))
		to_chat(ai_clicker, span_warning("Inserção de software hostil falhou!")) // lets not overlap balloon alerts
		return FALSE

	to_chat(ai_clicker, span_notice("Pacote de software injetado com sucesso."))

	adjust_uses(-1)
	if(uses)
		desc = "[initial(desc)]Tem.[uses]Use o restante."
		build_all_button_icons()
	else
		unset_ranged_ability(ai_clicker, span_warning("Fora de uso!"))

	return TRUE

/datum/ai_module/malf/utility/core_tilt
	name = "Rolling Servos"
	description = "Permite que você role lentamente, esmagando qualquer coisa em seu caminho com seu volume."
	cost = 10
	one_purchase = FALSE
	power_type = /datum/action/innate/ai/ranged/core_tilt
	unlock_sound = 'sound/effects/bang.ogg'
	unlock_text = span_notice("Você ganha a habilidade de rolar e esmagar qualquer coisa no seu caminho.")

/datum/action/innate/ai/ranged/core_tilt
	name = "Roll over"
	button_icon_state = "roll_over"
	desc = "Permite que você role na direção de sua escolha, esmagando qualquer coisa em seu caminho."
	auto_use_uses = FALSE
	ranged_mousepointer = 'icons/effects/mouse_pointers/supplypod_target.dmi'
	uses = 20
	COOLDOWN_DECLARE(time_til_next_tilt)
	enable_text = span_notice("Seus servos internos mudam enquanto se preparam para rolar. Clique em azulejos adjacentes para rolar sobre eles!")
	disable_text = span_notice("Você desativa seus protocolos.")

	/// How long does it take for us to roll?
	var/roll_over_time = MALF_AI_ROLL_TIME
	/// On top of [roll_over_time], how long does it take for the ability to cooldown?
	var/roll_over_cooldown = MALF_AI_ROLL_COOLDOWN

/datum/action/innate/ai/ranged/core_tilt/New()
	. = ..()
	desc = "[desc]Tem.[uses]Use o restante."

/datum/action/innate/ai/ranged/core_tilt/do_ability(mob/living/clicker, atom/clicked_on)

	if (!COOLDOWN_FINISHED(src, time_til_next_tilt))
		clicker.balloon_alert(clicker, "Na refrigeração!")
		return FALSE

	if (!isAI(clicker))
		return FALSE
	var/mob/living/silicon/ai/ai_clicker = clicker

	if (ai_clicker.incapacitated || !isturf(ai_clicker.loc))
		return FALSE

	var/turf/target = get_turf(clicked_on)
	if (isnull(target))
		return FALSE

	if (target == ai_clicker.loc)
		target.balloon_alert(ai_clicker, "Não pode rolar em si mesmo!")
		return FALSE

	var/picked_dir = get_dir(ai_clicker, target)
	if (!picked_dir)
		return FALSE
	var/turf/temp_target = get_step(ai_clicker, picked_dir) // we can move during the timer so we cant just pass the ref

	new /obj/effect/temp_visual/telegraphing/vending_machine_tilt(temp_target, roll_over_time)
	ai_clicker.balloon_alert_to_viewers("rolling...")
	addtimer(CALLBACK(src, PROC_REF(do_roll_over), ai_clicker, picked_dir), roll_over_time)

	adjust_uses(-1)
	if(uses)
		desc = "[initial(desc)]Tem.[uses]Use o restante."
		build_all_button_icons()

	COOLDOWN_START(src, time_til_next_tilt, roll_over_cooldown)

/datum/action/innate/ai/ranged/core_tilt/proc/do_roll_over(mob/living/silicon/ai/ai_clicker, picked_dir)
	if (ai_clicker.incapacitated || !isturf(ai_clicker.loc)) // prevents bugs where the ai is carded and rolls
		return

	var/turf/target = get_step(ai_clicker, picked_dir) // in case we moved we pass the dir not the target turf

	if (isnull(target))
		return

	var/paralyze_time = clamp(6 SECONDS, 0 SECONDS, (roll_over_cooldown * 0.9)) //the clamp prevents stunlocking as the max is always a little less than the cooldown between rolls

	return ai_clicker.fall_and_crush(target, MALF_AI_ROLL_DAMAGE, MALF_AI_ROLL_CRIT_CHANCE, null, paralyze_time, picked_dir, rotation = get_rotation_from_dir(picked_dir))

/// Used in our radial menu, state-checking proc after the radial menu sleeps
/datum/action/innate/ai/ranged/core_tilt/proc/radial_check(mob/living/silicon/ai/clicker)
	if (QDELETED(clicker) || clicker.incapacitated || clicker.stat == DEAD)
		return FALSE

	if (uses <= 0)
		return FALSE

	return TRUE

/datum/action/innate/ai/ranged/core_tilt/proc/get_rotation_from_dir(dir)
	switch (dir)
		if (NORTH, NORTHWEST, WEST, SOUTHWEST)
			return 270 // try our best to not return 180 since it works badly with animate
		if (EAST, NORTHEAST, SOUTH, SOUTHEAST)
			return 90
		else
			stack_trace("non-standard dir entered to get_rotation_from_dir. (got: [dir])")
			return 0

/datum/ai_module/malf/utility/remote_vendor_tilt
	name = "Remote vendor tilting"
	description = "Deixa você dar gorjeta remota aos vendedores em qualquer direção."
	cost = 15
	one_purchase = FALSE
	power_type = /datum/action/innate/ai/ranged/remote_vendor_tilt
	unlock_sound = 'sound/effects/bang.ogg'
	unlock_text = span_notice("Você ganha a habilidade de dar gorjeta remota a qualquer vendedor em qualquer azulejo adjacente.")

/datum/action/innate/ai/ranged/remote_vendor_tilt
	name = "Remotely tilt vendor"
	desc = "Use para inclinar remotamente um vendedor em qualquer direção que desejar."
	button_icon_state = "vendor_tilt"
	ranged_mousepointer = 'icons/effects/mouse_pointers/supplypod_target.dmi'
	uses = VENDOR_TIPPING_USES
	var/time_to_tilt = MALF_VENDOR_TIPPING_TIME
	enable_text = span_notice("Você se prepara para balançar qualquer vendedor que você vê.")
	disable_text = span_notice("Pare de se concentrar em fornecedores.")

/datum/action/innate/ai/ranged/remote_vendor_tilt/New()
	. = ..()
	desc = "[desc]Tem.[uses]Use o restante."

/datum/action/innate/ai/ranged/remote_vendor_tilt/do_ability(mob/living/clicker, atom/clicked_on)

	if (!isAI(clicker))
		return FALSE
	var/mob/living/silicon/ai/ai_clicker = clicker

	if(ai_clicker.incapacitated)
		unset_ranged_ability(clicker)
		return FALSE

	if(!isvendor(clicked_on))
		clicked_on.balloon_alert(ai_clicker, "Não um vendedor!")
		return FALSE

	var/obj/machinery/vending/clicked_vendor = clicked_on

	if (clicked_vendor.tilted)
		clicked_vendor.balloon_alert(ai_clicker, "Já está inclinada!")
		return FALSE

	if (!clicked_vendor.tiltable)
		clicked_vendor.balloon_alert(ai_clicker, "Não pode ser inclinada!")
		return FALSE

	if (!clicked_vendor.is_operational)
		clicked_vendor.balloon_alert(ai_clicker, "Inoperável!")
		return FALSE

	var/picked_dir_string = show_radial_menu(ai_clicker, clicked_vendor, GLOB.all_radial_directions, custom_check = CALLBACK(src, PROC_REF(radial_check), clicker, clicked_vendor))
	if (isnull(picked_dir_string))
		return FALSE
	var/picked_dir = text2dir(picked_dir_string)

	var/turf/target = get_step(clicked_vendor, picked_dir)
	if (!ai_clicker.can_see(target))
		to_chat(ai_clicker, span_warning("Você não pode ver o azulejo do alvo!"))
		return FALSE

	new /obj/effect/temp_visual/telegraphing/vending_machine_tilt(target, time_to_tilt)
	clicked_vendor.visible_message(span_warning("[clicked_vendor]Começa a cair..."))
	clicked_vendor.balloon_alert_to_viewers("falling over...")
	addtimer(CALLBACK(src, PROC_REF(do_vendor_tilt), clicked_vendor, target), time_to_tilt)

	adjust_uses(-1)
	if(uses)
		desc = "[initial(desc)]Tem.[uses]Use o restante."
		build_all_button_icons()

	unset_ranged_ability(clicker, span_danger("Tilting..."))
	return TRUE

/datum/action/innate/ai/ranged/remote_vendor_tilt/proc/do_vendor_tilt(obj/machinery/vending/vendor, turf/target)
	if (QDELETED(vendor))
		return FALSE

	if (vendor.tilted || !vendor.tiltable)
		return FALSE

	vendor.tilt(target, MALF_VENDOR_TIPPING_CRIT_CHANCE)

/// Used in our radial menu, state-checking proc after the radial menu sleeps
/datum/action/innate/ai/ranged/remote_vendor_tilt/proc/radial_check(mob/living/silicon/ai/clicker, obj/machinery/vending/clicked_vendor)
	if (QDELETED(clicker) || clicker.incapacitated || clicker.stat == DEAD)
		return FALSE

	if (QDELETED(clicked_vendor))
		return FALSE

	if (uses <= 0)
		return FALSE

	if (!clicker.can_see(clicked_vendor))
		to_chat(clicker, span_warning("Perdido de vista[clicked_vendor]!"))
		return FALSE

	return TRUE

#undef DEFAULT_DOOMSDAY_TIMER
#undef DOOMSDAY_ANNOUNCE_INTERVAL

#undef VENDOR_TIPPING_USES
#undef MALF_VENDOR_TIPPING_TIME
#undef MALF_VENDOR_TIPPING_CRIT_CHANCE

#undef MALF_AI_ROLL_COOLDOWN
#undef MALF_AI_ROLL_TIME
#undef MALF_AI_ROLL_DAMAGE
#undef MALF_AI_ROLL_CRIT_CHANCE
