//Programs that interact with other programs or nanites directly, or have other special purposes.
/datum/nanite_program/viral
	name = "Viral Replica"
	desc = "Os nanites constantemente enviam sinais criptografados tentando copiar sua própria programação para outros clusters nanites, também sobrepondo ou desativando sua sincronização na nuvem."
	use_rate = 0.5
	rogue_types = list(/datum/nanite_program/toxic)
	var/pulse_cooldown = 0

/datum/nanite_program/viral/register_extra_settings()
	extra_settings[NES_PROGRAM_OVERWRITE] = new /datum/nanite_extra_setting/type("Add To", list("Overwrite", "Add To", "Ignore"))
	extra_settings[NES_CLOUD_OVERWRITE] = new /datum/nanite_extra_setting/number(NANITE_MIN_CLOUD_ID, NANITE_MIN_CLOUD_ID, NANITE_MAX_CLOUD_ID)

/datum/nanite_program/viral/active_effect()
	if(world.time < pulse_cooldown)
		return
	var/datum/nanite_extra_setting/program = extra_settings[NES_PROGRAM_OVERWRITE]
	var/datum/nanite_extra_setting/cloud = extra_settings[NES_CLOUD_OVERWRITE]
	for(var/mob/M in orange(host_mob, 5))
		if(SEND_SIGNAL(M, COMSIG_NANITE_IS_STEALTHY))
			continue
		switch(program.get_value())
			if("Overwrite")
				SEND_SIGNAL(M, COMSIG_NANITE_SYNC, nanites, TRUE)
			if("Add To")
				SEND_SIGNAL(M, COMSIG_NANITE_SYNC, nanites, FALSE)
		SEND_SIGNAL(M, COMSIG_NANITE_SET_CLOUD, cloud.get_value())
	pulse_cooldown = world.time + 75

/datum/nanite_program/monitoring
	name = "Monitoring"
	desc = "Os nanites monitoram os sinais vitais e a localização do hospedeiro, enviando-os para a rede de sensores."
	rogue_types = list(/datum/nanite_program/toxic)

/datum/nanite_program/monitoring/enable_passive_effect()
	. = ..()
	ADD_TRAIT(host_mob, TRAIT_NANITE_MONITORING, NANITES_TRAIT) //Shows up in diagnostic and medical HUDs as a small blinking icon
	if(ishuman(host_mob))
		GLOB.nanite_sensors_list |= host_mob
	host_mob.hud_set_nanite_indicator()

/datum/nanite_program/monitoring/disable_passive_effect()
	. = ..()
	REMOVE_TRAIT(host_mob, TRAIT_NANITE_MONITORING, "nanites")
	if(ishuman(host_mob))
		GLOB.nanite_sensors_list -= host_mob

	host_mob.hud_set_nanite_indicator()

/datum/nanite_program/self_scan
	name = "Host Scan"
	desc = "Os nanites mostram uma leitura detalhada de uma varredura corporal para o hospedeiro."
	unique = FALSE
	can_trigger = TRUE
	trigger_cost = 3
	trigger_cooldown = 50
	rogue_types = list(/datum/nanite_program/toxic)

/datum/nanite_program/self_scan/register_extra_settings()
	extra_settings[NES_SCAN_TYPE] = new /datum/nanite_extra_setting/type("Medical", list("Medical", "Chemical", "Wound", "Nanite"))

/datum/nanite_program/self_scan/on_trigger(comm_message)
	if(host_mob.stat == DEAD)
		return
	var/datum/nanite_extra_setting/NS = extra_settings[NES_SCAN_TYPE]
	switch(NS.get_value())
		if("Medical")
			healthscan(host_mob, host_mob)
		if("Chemical")
			chemscan(host_mob, host_mob)
		if("Wound")
			woundscan(host_mob, host_mob)
		if("Nanite")
			SEND_SIGNAL(host_mob, COMSIG_NANITE_SCAN, host_mob, TRUE)

/datum/nanite_program/stealth
	name = "Stealth"
	desc = "Os nanites mascaram sua atividade de varreduras superficiais, tornando-se indetectáveis por HUDs e scanners não especializados."
	rogue_types = list(/datum/nanite_program/toxic)
	use_rate = 0.2

/datum/nanite_program/stealth/enable_passive_effect()
	. = ..()
	nanites.stealth = TRUE

/datum/nanite_program/stealth/disable_passive_effect()
	. = ..()
	nanites.stealth = FALSE

/datum/nanite_program/nanite_debugging
	name = "Nanite Debugging"
	desc = "Permite vários diagnósticos de alto custo nos nanites, tornando-os capazes de comunicar sua lista de programas para scanners portáteis. Fazer isso usa algum poder, diminuindo ligeiramente sua velocidade de replicação."
	rogue_types = list(/datum/nanite_program/toxic)
	use_rate = 0.1

/datum/nanite_program/nanite_debugging/enable_passive_effect()
	. = ..()
	nanites.diagnostics = TRUE

/datum/nanite_program/nanite_debugging/disable_passive_effect()
	. = ..()
	nanites.diagnostics = FALSE

/datum/nanite_program/relay
	name = "Relay"
	desc = "Os nanites recebem e transmitem sinais de nanites de longo alcance."
	rogue_types = list(/datum/nanite_program/toxic)

/datum/nanite_program/relay/register_extra_settings()
	extra_settings[NES_RELAY_CHANNEL] = new /datum/nanite_extra_setting/number(1, 1, 9999)

/datum/nanite_program/relay/enable_passive_effect()
	. = ..()
	SSnanites.nanite_relays |= src

/datum/nanite_program/relay/disable_passive_effect()
	. = ..()
	SSnanites.nanite_relays -= src

/datum/nanite_program/relay/proc/relay_signal(code, relay_code, source)
	if(!activated)
		return
	if(!host_mob)
		return
	var/datum/nanite_extra_setting/NS = extra_settings[NES_RELAY_CHANNEL]
	if(relay_code != NS.get_value())
		return
	SEND_SIGNAL(host_mob, COMSIG_NANITE_SIGNAL, code, source)

/datum/nanite_program/relay/proc/relay_comm_signal(comm_code, relay_code, comm_message)
	if(!activated)
		return
	if(!host_mob)
		return
	var/datum/nanite_extra_setting/NS = extra_settings[NES_RELAY_CHANNEL]
	if(relay_code != NS.get_value())
		return
	SEND_SIGNAL(host_mob, COMSIG_NANITE_COMM_SIGNAL, comm_code, comm_message)

/datum/nanite_program/metabolic_synthesis
	name = "Metabolic Synthesis"
	desc = "Os nanites usam o ciclo metabólico do hospedeiro para acelerar sua taxa de replicação, usando sua nutrição extra como combustível."
	use_rate = -0.5 //generates nanites
	rogue_types = list(/datum/nanite_program/toxic)

/datum/nanite_program/metabolic_synthesis/check_conditions()
	if(!iscarbon(host_mob))
		return FALSE
	var/mob/living/carbon/C = host_mob
	if(C.nutrition <= NUTRITION_LEVEL_WELL_FED)
		return FALSE
	return ..()

/datum/nanite_program/metabolic_synthesis/active_effect()
	host_mob.adjust_nutrition(-0.5)

/datum/nanite_program/access
	name = "Subdermal ID"
	desc = "Os nanites armazenam os direitos de acesso do hospedeiro em uma faixa magnética subdérmica. Atualizações quando acionado, copiando o acesso atual do hospedeiro."
	can_trigger = TRUE
	trigger_cost = 3
	trigger_cooldown = 30
	rogue_types = list(/datum/nanite_program/skin_decay)
	var/access = list()

//Syncs the nanites with the cumulative current mob's access level. Can potentially wipe existing access.
/datum/nanite_program/access/on_trigger(comm_message)
	var/list/potential_items = list()

	potential_items += host_mob.get_active_held_item()
	potential_items += host_mob.get_inactive_held_item()
	potential_items += host_mob.pulling

//We now use the simple_access component.
/* 	if(ishuman(host_mob))
		var/mob/living/carbon/human/H = host_mob
		potential_items += H.wear_id
	else if(isanimal(host_mob))
		var/mob/living/simple_animal/A = host_mob
		potential_items += A.access_card */

	var/list/new_access = list(COMSIG_MOB_RETRIEVE_ACCESS)
	for(var/obj/item/I in potential_items)
		new_access += I.GetAccess()

	access = new_access

/datum/nanite_program/spreading
	name = "Infective Exo-Locomotion"
	desc = "Os nanites ganham a habilidade de sobreviver por breves períodos fora do corpo humano, assim como a capacidade de iniciar novas colônias sem um processo de integração, resultando em uma tensão extremamente infecciosa de nanites."
	use_rate = 1.50
	rogue_types = list(/datum/nanite_program/aggressive_replication, /datum/nanite_program/necrotic)
	var/spread_cooldown = 0

/datum/nanite_program/spreading/active_effect()
	if(world.time < spread_cooldown)
		return
	spread_cooldown = world.time + 50
	var/list/mob/living/target_hosts = list()
	for(var/mob/living/L in oview(5, host_mob))
		if(!prob(25))
			continue
		if(!CAN_HAVE_NANITES(L))
			continue
		target_hosts += L
	if(!target_hosts.len)
		return
	var/mob/living/infectee = pick(target_hosts)
	if(prob(100 - infectee.getarmor(null, BIO)))
		//this will potentially take over existing nanites!
		infectee.AddComponent(/datum/component/nanites, 10)
		SEND_SIGNAL(infectee, COMSIG_NANITE_SYNC, nanites)
		SEND_SIGNAL(infectee, COMSIG_NANITE_SET_CLOUD, nanites.cloud_id)
		infectee.investigate_log("was infected by spreading nanites with cloud ID [nanites.cloud_id] by [key_name(host_mob)] at [AREACOORD(infectee)].", INVESTIGATE_NANITES)

/datum/nanite_program/nanite_sting
	name = "Nanite Sting"
	desc = "Quando acionado, constrói um espigão invisível de nanites na pele do hospedeiro que pode infectar um não-anfitrião próximo com uma cópia do aglomerado de nanites do hospedeiro que está desconectado da nuvem. Não funcionará com hospedeiros ou já infectados."
	can_trigger = TRUE
	trigger_cost = 15
	trigger_cooldown = 100
	rogue_types = list(/datum/nanite_program/glitch, /datum/nanite_program/toxic)
	var/decay_timer

/datum/nanite_program/nanite_sting/Destroy()
	if(!decay_timer)
		return ..()
	decay_sting()
	. = ..()

/datum/nanite_program/nanite_sting/on_trigger(comm_message)
	to_chat(host_mob, span_warning("Suas mãos ficam afiadas e espinhosas."))
	RegisterSignal(host_mob, COMSIG_LIVING_EARLY_UNARMED_ATTACK, PROC_REF(on_attack_hand))
	decay_timer = addtimer(CALLBACK(src, PROC_REF(decay_sting)), 30 SECONDS, TIMER_STOPPABLE)

/datum/nanite_program/nanite_sting/proc/on_attack_hand(atom/attacker, mob/attack_target, proximity_flag, list/modifiers)
	SIGNAL_HANDLER
	var/mob/living/living = attack_target
	if(!isliving(living))
		return
	if(!CAN_HAVE_NANITES(living))
		host_mob.balloon_alert(host_mob, "Não pode ser infectado!")
		return
	if(SEND_SIGNAL(living, COMSIG_HAS_NANITES))
		host_mob.balloon_alert(host_mob, "Já infectado!")
		return
	if(!living.Adjacent(host_mob))
		host_mob.balloon_alert(host_mob, "não alcança!")
		return
	var/chances = 100 - living.run_armor_check(host_mob.zone_selected, BIO, silent = TRUE)
	var/success = prob(chances)
	host_mob.balloon_alert(host_mob, "[chances]% de chance[success ? "success" : "failed!"]")
	if(success)
		//unlike with Infective Exo-Locomotion, this can't take over existing nanites, because Nanite Sting only targets non-hosts.
		living.AddComponent(/datum/component/nanites, 5)
		SEND_SIGNAL(living, COMSIG_NANITE_SYNC, nanites)
		// SEND_SIGNAL(living, COMSIG_NANITE_SET_CLOUD, nanites.cloud_id) won't set the cloud
		SEND_SIGNAL(living, COMSIG_NANITE_SET_CLOUD_SYNC, NANITE_CLOUD_DISABLE)
		living.investigate_log("was infected by a nanite cluster with cloud ID [nanites.cloud_id] by [key_name(host_mob)] at [AREACOORD(living)].", INVESTIGATE_NANITES)
		to_chat(living, span_warning("Você sente uma picadinha."))
	decay_sting()

/datum/nanite_program/nanite_sting/proc/decay_sting()
	to_chat(host_mob, span_warning("Suas mãos não parecem mais estar cobertas de espinhos."))
	deltimer(decay_timer)
	decay_timer = null
	UnregisterSignal(host_mob, COMSIG_LIVING_EARLY_UNARMED_ATTACK)

/datum/nanite_program/mitosis
	name = "Mitosis"
	desc = "Os nanites ganham a habilidade de se auto-replicarem, usando o espaço azul para alimentar o processo. Torna-se mais eficaz quanto mais nanites já estão no hospedeiro; Para cada 50 volume de nanite no hospedeiro, a taxa de produção é aumentada em 0,5. A replicação também tem a chance de corromper a programação nanite devido a falhas de cópia. Sincronização constante em nuvem é altamente recomendada."
	use_rate = 0
	rogue_types = list(/datum/nanite_program/toxic)

/datum/nanite_program/mitosis/active_effect()
	var/rep_rate = round(nanites.nanite_volume / 50, 1) //0.5 per 50 nanite volume
	rep_rate *= 0.5
	nanites.adjust_nanites(null, rep_rate)
	if(prob(rep_rate))
		var/datum/nanite_program/fault = pick(nanites.programs)
		if(fault == src)
			return
		fault.software_error()
		host_mob.investigate_log("[fault] nanite program received a software error due to Mitosis program.", INVESTIGATE_NANITES)

/datum/nanite_program/dermal_button
	name = "Dermal Button"
	desc = "Mostra um botão na pele do hospedeiro, que pode ser usado para enviar um sinal para os nanites."
	unique = FALSE
	var/datum/action/innate/nanite_button/button

/datum/nanite_program/dermal_button/register_extra_settings()
	extra_settings[NES_SENT_CODE] = new /datum/nanite_extra_setting/number(1, 1, 9999)
	extra_settings[NES_BUTTON_NAME] = new /datum/nanite_extra_setting/text("Button")
	extra_settings[NES_ICON] = new /datum/nanite_extra_setting/type("power", list("blank","one","two","three","four","five","plus","minus","exclamation","question","cross","info","heart","skull","brain","brain_damage","injection","blood","shield","reaction","network","power","radioactive","electricity","magnetism","scan","repair","id","wireless","say","sleep","bomb"))

/datum/nanite_program/dermal_button/enable_passive_effect()
	. = ..()
	var/datum/nanite_extra_setting/bn_name = extra_settings[NES_BUTTON_NAME]
	var/datum/nanite_extra_setting/bn_icon = extra_settings[NES_ICON]
	if(!button)
		button = new(src, bn_name.get_value(), bn_icon.get_value())
	button.target = host_mob
	button.Grant(host_mob)

/datum/nanite_program/dermal_button/disable_passive_effect()
	. = ..()
	if(button)
		button.Remove(host_mob)

/datum/nanite_program/dermal_button/on_mob_remove()
	. = ..()
	QDEL_NULL(button)

/datum/nanite_program/dermal_button/proc/press()
	if(activated)
		host_mob.visible_message(span_notice("[host_mob]Aperte um botão.[host_mob.p_their()]antebraço."),
								span_notice("Aperte o botão nanite no antebraço."), null, 2)
		var/datum/nanite_extra_setting/sent_code = extra_settings[NES_SENT_CODE]
		SEND_SIGNAL(host_mob, COMSIG_NANITE_SIGNAL, sent_code.get_value(), "a [name] program")

/datum/action/innate/nanite_button
	name = "Button"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_CONSCIOUS
	button_icon_state = "bci_power"
	var/datum/nanite_program/dermal_button/program

/datum/action/innate/nanite_button/New(datum/nanite_program/dermal_button/_program, _name, _icon)
	..()
	program = _program
	name = _name
	button_icon_state = "bci_[_icon]"

/datum/action/innate/nanite_button/Activate()
	program.press()
