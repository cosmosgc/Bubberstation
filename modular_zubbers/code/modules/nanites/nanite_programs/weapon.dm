//Programs specifically engineered to cause harm to either the user or its surroundings (as opposed to ones that only do it due to broken programming)
//Very dangerous!

/datum/nanite_program/flesh_eating
	name = "Cellular Breakdown"
	desc = "Os nanites destroem estruturas celulares no corpo do hospedeiro, causando danos brutos."
	use_rate = 1.5
	rogue_types = list(/datum/nanite_program/necrotic)

/datum/nanite_program/flesh_eating/active_effect()
	if(iscarbon(host_mob))
		var/mob/living/carbon/C = host_mob
		C.take_bodypart_damage(1, 0, TRUE)
	else
		host_mob.adjust_brute_loss(1, TRUE)
	if(prob(3))
		to_chat(host_mob, span_warning("Você sente dor de algum lugar dentro de você."))

/datum/nanite_program/poison
	name = "Poisoning"
	desc = "Os nanites entregam substâncias químicas venenosas aos órgãos internos do hospedeiro, causando danos nas toxinas e vômitos."
	use_rate = 1.5
	rogue_types = list(/datum/nanite_program/toxic)

/datum/nanite_program/poison/active_effect()
	host_mob.adjust_tox_loss(1)
	if(prob(2))
		to_chat(host_mob, span_warning("Você está com náuseas."))
		if(iscarbon(host_mob))
			var/mob/living/carbon/C = host_mob
			C.vomit(20)

/datum/nanite_program/memory_leak
	name = "Memory Leak"
	desc = "Este programa invade o espaço de memória usado por outros programas, causando freqüentes corrupção e erros."
	use_rate = 0
	rogue_types = list(/datum/nanite_program/toxic)

/datum/nanite_program/memory_leak/active_effect()
	if(prob(6))
		var/datum/nanite_program/target = pick(nanites.programs)
		if(target == src)
			return
		target.software_error()
		host_mob.investigate_log("[target] nanite program received a software error due to Memory Leak program.", INVESTIGATE_NANITES)

/datum/nanite_program/aggressive_replication
	name = "Aggressive Replication"
	desc = "Nanitas consumirão matéria orgânica para melhorar sua taxa de replicação, prejudicando o hospedeiro. A eficiência aumenta com o volume de nanites, exigindo 200 para se quebrarem, e escalando linearmente para uma taxa líquida positiva de 0,1 de produção por 20 volumes de nanites além disso."
	use_rate = 1
	rogue_types = list(/datum/nanite_program/necrotic)

/datum/nanite_program/aggressive_replication/active_effect()
	var/extra_regen = round(nanites.nanite_volume / 200, 0.1)
	nanites.adjust_nanites(null, extra_regen)
	host_mob.adjust_brute_loss(extra_regen / 2, TRUE)

/datum/nanite_program/meltdown
	name = "Meltdown"
	desc = "Causa um colapso interno dentro dos nanites, causando queimaduras internas dentro do hospedeiro, bem como rapidamente destruindo a população nanite. Coloca o limiar de segurança dos nanites em 0 quando ativados."
	use_rate = 10
	rogue_types = list(/datum/nanite_program/glitch)

/datum/nanite_program/meltdown/active_effect()
	host_mob.adjust_fire_loss(3.5)

/datum/nanite_program/meltdown/enable_passive_effect()
	. = ..()
	to_chat(host_mob, span_userdanger("Seu sangue está queimando!"))
	nanites.safety_threshold = 0

/datum/nanite_program/meltdown/disable_passive_effect()
	. = ..()
	to_chat(host_mob, span_warning("Seu sangue esfria, e um dor gradualmente desaparecido."))

/datum/nanite_program/explosive
	name = "Chain Detonation"
	desc = "Detona todos os nanites dentro do hospedeiro em uma reação em cadeia quando acionados."
	can_trigger = TRUE
	trigger_cost = 25 //plus every idle nanite left afterwards
	trigger_cooldown = 100 //Just to avoid double-triggering
	rogue_types = list(/datum/nanite_program/toxic)

/datum/nanite_program/explosive/on_trigger(comm_message)
	host_mob.visible_message(span_warning("[host_mob]começa a emitir um zumbido agudo, e[host_mob.p_their()]A pele começa a brilhar..."),							span_userdanger("Você começa a emitir um zumbido agudo, e sua pele começa a brilhar..."))
	addtimer(CALLBACK(src, PROC_REF(boom)), clamp((nanites.nanite_volume * 0.35), 25, 150))

/datum/nanite_program/explosive/proc/boom()
	dyn_explosion(host_mob, nanites.nanite_volume / 50)
	qdel(nanites)

//TODO make it defuse if triggered again

/datum/nanite_program/heart_stop
	name = "Heart-Stopper"
	desc = "Para o coração do hospedeiro quando acionado, reinicia se acionado novamente."
	can_trigger = TRUE
	trigger_cost = 12
	trigger_cooldown = 10
	rogue_types = list(/datum/nanite_program/nerve_decay)

/datum/nanite_program/heart_stop/on_trigger(comm_message)
	if(iscarbon(host_mob))
		var/mob/living/carbon/carbon = host_mob
		var/obj/item/organ/heart/heart = carbon.get_organ_slot(ORGAN_SLOT_HEART)
		if(heart)
			if(heart.is_beating())
				heart.Stop()
			else
				heart.Restart()

/datum/nanite_program/emp
	name = "Electromagnetic Resonance"
	desc = "Os nanites causam um pulso eletromagnético ao redor do hospedeiro quando acionado. Vai corromper outros programas nanites!"
	can_trigger = TRUE
	trigger_cost = 10
	trigger_cooldown = 50
	program_flags = NANITE_EMP_IMMUNE
	rogue_types = list(/datum/nanite_program/toxic)

/datum/nanite_program/emp/on_trigger(comm_message)
	empulse(host_mob, 1, 2)

/datum/nanite_program/pyro
	name = "Sub-Dermal Combustion"
	desc = "Os nanites causam acúmulo de fluidos inflamáveis sob a pele do hospedeiro, então os inflama."
	use_rate = 4
	rogue_types = list(/datum/nanite_program/skin_decay, /datum/nanite_program/cryo)

/datum/nanite_program/pyro/check_conditions()
	if(host_mob.fire_stacks >= 10 && host_mob.on_fire)
		return FALSE
	return ..()

/datum/nanite_program/pyro/active_effect()
	host_mob.adjust_fire_stacks(1)
	host_mob.ignite_mob()

/datum/nanite_program/cryo
	name = "Cryogenic Treatment"
	desc = "Os nanites afundam rapidamente o calor através da pele do hospedeiro, diminuindo sua temperatura."
	use_rate = 1
	rogue_types = list(/datum/nanite_program/skin_decay, /datum/nanite_program/pyro)

/datum/nanite_program/cryo/check_conditions()
	if(host_mob.bodytemperature <= 70)
		return FALSE
	return ..()

/datum/nanite_program/cryo/active_effect()
	host_mob.adjust_bodytemperature(-rand(15,25), 50)

/datum/nanite_program/comm/mind_control
	name = "Mind Control"
	desc = "Os nanites imprimem uma diretiva absoluta no cérebro do hospedeiro por um minuto quando acionado."
	trigger_cost = 30
	trigger_cooldown = 1800
	rogue_types = list(/datum/nanite_program/brain_decay, /datum/nanite_program/brain_misfire)

/datum/nanite_program/comm/mind_control/register_extra_settings()
	. = ..()
	extra_settings[NES_DIRECTIVE] = new /datum/nanite_extra_setting/text("...")

/datum/nanite_program/comm/mind_control/on_trigger(comm_message)
	if(host_mob.stat == DEAD)
		return
	var/sent_directive = comm_message
	if(!comm_message)
		var/datum/nanite_extra_setting/ES = extra_settings[NES_DIRECTIVE]
		sent_directive = ES.get_value()
	brainwash(host_mob, sent_directive)
	log_game("A mind control nanite program brainwashed [key_name(host_mob)] with the objective '[sent_directive]'.")
	host_mob.log_message("has been brainwashed with the objective '[sent_directive]' triggered by a mind control nanite program.", LOG_ATTACK)
	addtimer(CALLBACK(src, PROC_REF(end_brainwashing)), 600)

/datum/nanite_program/comm/mind_control/proc/end_brainwashing()
	if(host_mob.mind && host_mob.mind.has_antag_datum(/datum/antagonist/brainwashed))
		host_mob.mind.remove_antag_datum(/datum/antagonist/brainwashed)
	log_game("[key_name(host_mob)] is no longer brainwashed by nanites.")

/datum/nanite_program/comm/mind_control/disable_passive_effect()
	. = ..()
	end_brainwashing()
