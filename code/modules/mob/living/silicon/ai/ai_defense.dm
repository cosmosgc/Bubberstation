
/mob/living/silicon/ai/attackby(obj/item/W, mob/user, list/modifiers, list/attack_modifiers)
	if(istype(W, /obj/item/ai_module))
		var/obj/item/ai_module/MOD = W
		disconnect_shell()
		if(!mind) //A player mind is required for law procs to run antag checks.
			to_chat(user, span_warning("[src]Não responde completamente!"))
			return
		MOD.install(laws, user) //Proc includes a success mesage so we don't need another one
		return

	return ..()

/mob/living/silicon/ai/blob_act(obj/structure/blob/B)
	if (stat != DEAD)
		adjust_brute_loss(60)
		return TRUE
	return FALSE

/mob/living/silicon/ai/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	disconnect_shell()
	if (prob(30))
		switch(pick(1,2))
			if(1)
				view_core()
			if(2)
				SSshuttle.requestEvac(src,"ALERT: Energy surge detected in AI core! Station integrity may be compromised! Initiati--%m091#ar-BZZT")

/mob/living/silicon/ai/ex_act(severity, target)
	switch(severity)
		if(EXPLODE_DEVASTATE)
			investigate_log("has been gibbed by an explosion.", INVESTIGATE_DEATHS)
			gib(DROP_ALL_REMAINS)
		if(EXPLODE_HEAVY)
			if (stat != DEAD)
				adjust_brute_loss(60)
				adjust_fire_loss(60)
		if(EXPLODE_LIGHT)
			if (stat != DEAD)
				adjust_brute_loss(30)

	return TRUE

/mob/living/silicon/ai/flash_act(intensity = 1, override_blindness_check = 0, affect_silicon = 0, visual = 0, type = /atom/movable/screen/fullscreen/flash, length = 25)
	return // no eyes, no flashing

/mob/living/silicon/ai/emag_act(mob/user, obj/item/card/emag/emag_card) ///emags access panel lock, so you can crowbar it without robotics access or consent
	. = ..()
	if(emagged)
		balloon_alert(user, "Fechamento do painel de acesso já encurtado!")
		return
	balloon_alert(user, "Dorel de acesso travado encurtado")
	var/message = (user ? "[user] shorts out your access panel lock!" : "Your access panel lock was short circuited!")
	to_chat(src, span_warning(message))
	do_sparks(3, FALSE, src) // just a bit of extra "oh shit" to the ai - might grab its attention
	emagged = TRUE
	return TRUE

/mob/living/silicon/ai/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	if(user.combat_mode)
		return
	if(stat != DEAD && !incapacitated && (client || deployed_shell?.client))
		// alive and well AIs control their floor bolts
		balloon_alert(user, "Os motores da IA resistem.")
		return ITEM_INTERACT_SUCCESS
	balloon_alert(user, "[!is_anchored ? "tightening" : "loosening"]Pernos...")
	balloon_alert(src, "Os parafusos estão sendo...[!is_anchored ? "tightened" : "loosened"]...")
	if(!tool.use_tool(src, user, 4 SECONDS))
		return ITEM_INTERACT_SUCCESS
	flip_anchored()
	balloon_alert(user, "Parafusos[is_anchored ? "tightened" : "loosened"]")
	balloon_alert(src, "Parafusos[is_anchored ? "tightened" : "loosened"]")
	return ITEM_INTERACT_SUCCESS

/mob/living/silicon/ai/crowbar_act(mob/living/user, obj/item/tool)
	. = ..()
	if(user.combat_mode)
		return
	if(!is_anchored)
		balloon_alert(user, "Derrube-o primeiro!")
		return ITEM_INTERACT_SUCCESS
	if(opened)
		if(emagged)
			balloon_alert(user, "Fechamento do Painel de Acesso Danificado!")
			return ITEM_INTERACT_SUCCESS
		balloon_alert(user, "Fechando painel de acesso...")
		balloon_alert(src, "Paisel de acesso sendo fechado...")
		if(!tool.use_tool(src, user, 5 SECONDS))
			return ITEM_INTERACT_SUCCESS
		balloon_alert(src, "Painel de acesso fechado")
		balloon_alert(user, "Painel de acesso fechado")
		opened = FALSE
		return ITEM_INTERACT_SUCCESS
	if(stat == DEAD)
		to_chat(user, span_warning("O painel de acesso parece danificado, removedor de tendas a tampa."))
	else
		var/consent
		var/consent_override = FALSE
		if(ishuman(user))
			var/mob/living/carbon/human/human_user = user
			if(human_user.wear_id)
				var/list/access = human_user.wear_id.GetAccess()
				if(ACCESS_ROBOTICS in access)
					consent_override = TRUE
		if(mind)
			consent = tgui_alert(src, "[user] is attempting to open your access panel, unlock the cover?", "AI Access Panel", list("Yes", "No"))
			if(consent == "No" && !consent_override && !emagged)
				to_chat(user, span_notice("[src]Se recusa a abrir seu painel de acesso."))
				return ITEM_INTERACT_SUCCESS
			if(consent != "Yes" && (consent_override || emagged))
				to_chat(user, span_warning("[src]Se você quiser abrir o painel de acesso.[!emagged ? " swipe your ID and " : " "]Abra mesmo assim!"))
		else
			if(!consent_override && !emagged)
				to_chat(user, span_notice("[src]Não respondeu ao seu pedido para abrir o painel de acesso."))
				return ITEM_INTERACT_SUCCESS
			else
				to_chat(user, span_notice("[src]Não respondeu ao seu pedido para abrir o painel de acesso. Você.[!emagged ? " swipe your ID and " : " "]Abra mesmo assim."))

	balloon_alert(user, "Investigado painel de acesso aberto...")
	balloon_alert(src, "Painel de acesso sendo aberto...")
	if(!tool.use_tool(src, user, (stat == DEAD ? 40 SECONDS : 5 SECONDS)))
		return ITEM_INTERACT_SUCCESS
	balloon_alert(src, "Painel de acesso aberto.")
	balloon_alert(user, "Painel de acesso aberto.")
	opened = TRUE
	return ITEM_INTERACT_SUCCESS

/mob/living/silicon/ai/wirecutter_act(mob/living/user, obj/item/tool)
	. = ..()
	if(user.combat_mode)
		return
	if(!is_anchored)
		balloon_alert(user, "Derrube-o primeiro!")
		return ITEM_INTERACT_SUCCESS
	if(!opened)
		balloon_alert(user, "Abra o painel de acesso primeiro!")
		return ITEM_INTERACT_SUCCESS
	balloon_alert(src, "Rede neural sendo desconectada...")
	balloon_alert(user, "Desligando rede neural...")
	if(!tool.use_tool(src, user, (stat == DEAD ? 5 SECONDS : 40 SECONDS)))
		return ITEM_INTERACT_SUCCESS
	if(IS_MALF_AI(src))
		to_chat(user, span_userdanger("A tensão dentro dos fios sobe dramaticamente!"))
		user.electrocute_act(120, src)
		opened = FALSE
		return ITEM_INTERACT_SUCCESS
	to_chat(src, span_danger("Você se sente incrivelmente confuso e desorientado."))
	var/atom/ai_structure = ai_mob_to_structure()
	ai_structure.balloon_alert(user, "Rede neural desconectada.")
	return ITEM_INTERACT_SUCCESS

/mob/living/silicon/ai/attack_effects(damage_done, hit_zone, armor_block, obj/item/attacking_item, mob/living/attacker)
	if(damage_done > 0 && attacking_item.damtype != STAMINA && stat != DEAD)
		spark_system.start()
		. = TRUE
	return ..() || .
