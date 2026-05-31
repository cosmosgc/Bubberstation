/obj/machinery/power/apc/proc/get_malf_status(mob/living/silicon/ai/malf)
	if(!istype(malf) || !malf.malf_picker)
		return APC_AI_NO_MALF
	if(malfai != malf)
		return APC_AI_NO_HACK
	if(occupier == malf)
		return APC_AI_HACK_SHUNT_HERE
	if(istype(malf.loc, /obj/machinery/power/apc))
		return APC_AI_HACK_SHUNT_ANOTHER
	return APC_AI_HACK_NO_SHUNT

/obj/machinery/power/apc/proc/malfhack(mob/living/silicon/ai/malf)
	if(!istype(malf))
		return
	if(get_malf_status(malf) != APC_AI_NO_HACK)
		return
	if(malf.malfhacking)
		to_chat(malf, span_warning("Você já está hackeando um APC!"))
		return
	to_chat(malf, span_notice("Iniciando a substituição dos sistemas APC. Isso leva algum tempo, e você não pode realizar outras ações durante o processo."))
	malf.malfhack = src
	malf.malfhacking = addtimer(CALLBACK(malf, TYPE_PROC_REF(/mob/living/silicon/ai/, malfhacked), src), 30 SECONDS + 10*malf.hacked_apcs.len SECONDS, TIMER_STOPPABLE)

	var/atom/movable/screen/alert/hackingapc/hacking_apc
	hacking_apc = malf.throw_alert(ALERT_HACKING_APC, /atom/movable/screen/alert/hackingapc)
	hacking_apc.target = src

/obj/machinery/power/apc/proc/malfoccupy(mob/living/silicon/ai/malf)
	if(!istype(malf))
		return
	if(istype(malf.loc, /obj/machinery/power/apc)) // Already in an APC
		to_chat(malf, span_warning("Você deve evacuar seu atual APC primeiro!"))
		return
	if(!malf.can_shunt)
		to_chat(malf, span_warning("Você não pode desviar!"))
		return
	if(!is_station_level(z))
		return
	INVOKE_ASYNC(src, PROC_REF(malfshunt), malf)

/obj/machinery/power/apc/proc/malfshunt(mob/living/silicon/ai/malf)
	var/confirm = tgui_alert(malf, "Tem certeza que quer desviar? Isso vai te tirar do seu núcleo!", "Shunt to [name]?", list("Yes", "No"))
	if(confirm != "Yes")
		return
	malf.ShutOffDoomsdayDevice()
	occupier = malf
	if (isturf(malf.loc)) // create a deactivated AI core if the AI isn't coming from an emergency mech shunt
		malf.create_core_link(new /obj/structure/ai_core(malf.loc, CORE_STATE_FINISHED, malf.make_mmi()))
	malf.forceMove(src) // move INTO the APC, not to its tile
	if(!findtext(occupier.name, "APC Copy"))
		occupier.name = "[malf.name] APC Copy"
	malf.shunted = TRUE
	occupier.eyeobj.name = "[occupier.name] (AI Eye)"
	occupier.eyeobj.forceMove(src.loc)
	for(var/obj/item/pinpointer/nuke/disk_pinpointers in GLOB.pinpointer_list)
		disk_pinpointers.switch_mode_to(TRACK_MALF_AI) //Pinpointer will track the shunted AI
	var/datum/action/innate/core_return/return_action = new
	return_action.Grant(occupier)
	SEND_SIGNAL(src, COMSIG_SILICON_AI_OCCUPY_APC, occupier)
	SEND_SIGNAL(occupier, COMSIG_SILICON_AI_OCCUPY_APC, occupier)
	occupier.cancel_camera()

/obj/machinery/power/apc/proc/malfvacate(forced)
	if(!occupier)
		return
	SEND_SIGNAL(occupier, COMSIG_SILICON_AI_VACATE_APC, occupier)
	SEND_SIGNAL(src, COMSIG_SILICON_AI_VACATE_APC, occupier)
	if(forced)
		occupier.forceMove(drop_location())
		INVOKE_ASYNC(occupier, TYPE_PROC_REF(/mob/living, death))
		occupier.gib(DROP_ALL_REMAINS)
		occupier = null
		return
	if(occupier.linked_core)
		occupier.shunted = FALSE
		occupier.resolve_core_link()
		occupier = null
	else
		stack_trace("An AI: [occupier] has vacated an APC with no linked core and without being gibbed.")

	if(!occupier.nuking) //Pinpointers go back to tracking the nuke disk, as long as the AI (somehow) isn't mid-nuking.
		for(var/obj/item/pinpointer/nuke/disk_pinpointers in GLOB.pinpointer_list)
			disk_pinpointers.switch_mode_to(TRACK_NUKE_DISK)
			disk_pinpointers.alert = FALSE

/obj/machinery/power/apc/transfer_ai(interaction, mob/user, mob/living/silicon/ai/AI, obj/item/aicard/card)
	. = ..()
	if(!.)
		return
	if(card.AI)
		to_chat(user, span_warning("[card]Já está ocupado!"))
		return FALSE
	if(!occupier)
		to_chat(user, span_warning("Não há nada dentro[src]Para transferir!"))
		return FALSE
	if(!occupier.mind || !occupier.client)
		to_chat(user, span_warning("[occupier]ou está inativa ou destruída!"))
		return FALSE
	if(occupier.linked_core) //if they have an active linked_core, they can't be transferred from an APC
		to_chat(user, span_warning("[occupier]está recusando todas as tentativas de transferência!") )
		return FALSE
	if(transfer_in_progress)
		to_chat(user, span_warning("Já há uma transferência em andamento!"))
		return FALSE
	if(interaction != AI_TRANS_TO_CARD || occupier.stat)
		return FALSE
	var/turf/user_turf = get_turf(user)
	if(!user_turf)
		return FALSE
	transfer_in_progress = TRUE
	user.visible_message(span_notice("[user]slots[card]Em[src]..."), span_notice("Processo de transferência iniciado. Enviando pedido de aprovação da IA..."))
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	SEND_SOUND(occupier, sound('sound/announcer/notice/notice2.ogg')) //To alert the AI that someone's trying to card them if they're tabbed out
	if(tgui_alert(occupier, "[user]está tentando transferi-lo para\a [card.name]Você concorda com isso?", "APC Transfer", list("Yes - Transfer Me", "No - Keep Me Here")) == "No - Keep Me Here")
		to_chat(user, span_danger("AI negou o pedido de transferência. Processo encerrado."))
		playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 50, TRUE)
		transfer_in_progress = FALSE
		return FALSE
	if(user.loc != user_turf)
		to_chat(user, span_danger("A localização mudou. Processo encerrado."))
		to_chat(occupier, span_warning("[user]Afaste-se! Transferência cancelada."))
		transfer_in_progress = FALSE
		return FALSE
	to_chat(user, span_notice("AI aceitou o pedido. Transferindo informações armazenadas para[card]..."))
	to_chat(occupier, span_notice("Transferência começando. Você será transferido para[card]Em breve."))
	if(!do_after(user, 5 SECONDS, target = src))
		to_chat(occupier, span_warning("[user]Foi interrompido! Transferência cancelada."))
		transfer_in_progress = FALSE
		return FALSE
	if(!occupier || !card)
		transfer_in_progress = FALSE
		return FALSE
	user.visible_message(span_notice("[user]Transferências[occupier]Para[card]!"), span_notice("Transferência completa![occupier]está agora armazenado em[card]."))
	to_chat(occupier, span_notice("Transferência completa! Você foi armazenado em[user]'s[card.name]."))
	occupier.forceMove(card)
	card.AI = occupier
	occupier.shunted = FALSE
	occupier.cancel_camera()
	occupier = null
	transfer_in_progress = FALSE
	return TRUE
