//Programs that are generally useful for population control and non-harmful suppression.

/datum/nanite_program/sleepy
	name = "Sleep Induction"
	desc = "Os nanites induzem rápida narcolepsia quando acionados."
	can_trigger = TRUE
	trigger_cost = 15
	trigger_cooldown = 1200
	rogue_types = list(/datum/nanite_program/brain_misfire, /datum/nanite_program/brain_decay)

/datum/nanite_program/sleepy/on_trigger(comm_message)
	to_chat(host_mob, span_warning("Você começa a sentir muito sono..."))
	host_mob.adjust_drowsiness(20)
	addtimer(CALLBACK(host_mob, TYPE_PROC_REF(/mob/living, Sleeping), 200), rand(60,200))

/datum/nanite_program/paralyzing
	name = "Paralysis"
	desc = "Os nanites forçam contração muscular, efetivamente paralisando o hospedeiro."
	use_rate = 3
	rogue_types = list(/datum/nanite_program/nerve_decay)

/datum/nanite_program/paralyzing/active_effect()
	host_mob.Stun(40)

/datum/nanite_program/paralyzing/enable_passive_effect()
	. = ..()
	to_chat(host_mob, span_warning("Seus músculos se apoderam! Não pode se mexer!"))

/datum/nanite_program/paralyzing/disable_passive_effect()
	. = ..()
	to_chat(host_mob, span_notice("Seus músculos relaxam, e você pode se mover novamente."))

/datum/nanite_program/shocking
	name = "Electric Shock"
	desc = "Os nanites chocam o hospedeiro quando acionados. Destrui uma grande quantidade de nanites!"
	can_trigger = TRUE
	trigger_cost = 10
	trigger_cooldown = 300
	program_flags = NANITE_SHOCK_IMMUNE
	rogue_types = list(/datum/nanite_program/toxic)

/datum/nanite_program/shocking/on_trigger(comm_message)
	host_mob.electrocute_act(rand(5,10), "shock nanites", 1, SHOCK_NOGLOVES)

/datum/nanite_program/stun
	name = "Neural Shock"
	desc = "Os nanites pulsam os nervos do hospedeiro quando acionados, inapacificando-os por um curto período."
	can_trigger = TRUE
	trigger_cost = 4
	trigger_cooldown = 300
	rogue_types = list(/datum/nanite_program/shocking, /datum/nanite_program/nerve_decay)

/datum/nanite_program/stun/on_trigger(comm_message)
	playsound(host_mob, "sparks", 75, TRUE, -1, SHORT_RANGE_SOUND_EXTRARANGE)
	host_mob.Paralyze(80)

/datum/nanite_program/pacifying
	name = "Pacification"
	desc = "Os nanites suprimem o centro de agressão do cérebro, impedindo que o hospedeiro cause danos diretos aos outros."
	use_rate = 1
	rogue_types = list(/datum/nanite_program/brain_misfire, /datum/nanite_program/brain_decay)

/datum/nanite_program/pacifying/enable_passive_effect()
	. = ..()
	ADD_TRAIT(host_mob, TRAIT_PACIFISM, NANITES_TRAIT)

/datum/nanite_program/pacifying/disable_passive_effect()
	. = ..()
	REMOVE_TRAIT(host_mob, TRAIT_PACIFISM, NANITES_TRAIT)

/datum/nanite_program/blinding
	name = "Blindness"
	desc = "Os nanites suprimem os nervos oculares do hospedeiro, cegando-os enquanto estão ativos."
	use_rate = 1.5
	rogue_types = list(/datum/nanite_program/nerve_decay)

/datum/nanite_program/blinding/enable_passive_effect()
	. = ..()
	host_mob.become_blind(NANITES_TRAIT)

/datum/nanite_program/blinding/disable_passive_effect()
	. = ..()
	host_mob.cure_blind(NANITES_TRAIT)

/datum/nanite_program/mute
	name = "Mute"
	desc = "Os nanites suprimem o discurso do hospedeiro, fazendo-os mudos enquanto estão ativos."
	use_rate = 0.75
	rogue_types = list(/datum/nanite_program/brain_decay, /datum/nanite_program/brain_misfire)

/datum/nanite_program/mute/enable_passive_effect()
	. = ..()
	ADD_TRAIT(host_mob, TRAIT_MUTE, NANITES_TRAIT)

/datum/nanite_program/mute/disable_passive_effect()
	. = ..()
	REMOVE_TRAIT(host_mob, TRAIT_MUTE, NANITES_TRAIT)

/datum/nanite_program/fake_death
	name = "Death Simulation"
	desc = "Os nanites induzem um coma mortal ao hospedeiro, capaz de enganar a maioria dos exames médicos."
	use_rate = 3.5
	rogue_types = list(/datum/nanite_program/nerve_decay, /datum/nanite_program/necrotic, /datum/nanite_program/brain_decay)

/datum/nanite_program/fake_death/enable_passive_effect()
	. = ..()
	host_mob.emote("deathgasp")
	host_mob.fakedeath("nanites")

/datum/nanite_program/fake_death/disable_passive_effect()
	. = ..()
	host_mob.cure_fakedeath("nanites")

//Can receive transmissions from a nanite communication remote for customized messages
/datum/nanite_program/comm
	can_trigger = TRUE
	var/comm_message = ""

/datum/nanite_program/comm/register_extra_settings()
	extra_settings[NES_COMM_CODE] = new /datum/nanite_extra_setting/number(0, 0, 9999)

/datum/nanite_program/comm/proc/receive_comm_signal(signal_comm_code, comm_message, comm_source)
	var/datum/nanite_extra_setting/comm_code = extra_settings[NES_COMM_CODE]
	if(!activated || !comm_code.get_value())
		return
	if(signal_comm_code == comm_code.get_value())
		host_mob.investigate_log("'s [name] nanite program was messaged by [comm_source] with comm code [signal_comm_code] and message '[comm_message]'.", INVESTIGATE_NANITES)
		trigger(FALSE, comm_message)

/datum/nanite_program/comm/speech
	name = "Forced Speech"
	desc = "Os nanites forçam o hospedeiro a dizer uma sentença pré-programada quando acionado."
	unique = FALSE
	trigger_cost = 3
	trigger_cooldown = 20
	rogue_types = list(/datum/nanite_program/brain_misfire, /datum/nanite_program/brain_decay)
	var/static/list/blacklist = list(
		"*surrender",
		"*collapse",
		"*faint",
	)

/datum/nanite_program/comm/speech/register_extra_settings()
	. = ..()
	extra_settings[NES_SENTENCE] = new /datum/nanite_extra_setting/text("")

/datum/nanite_program/comm/speech/on_trigger(comm_message)
	var/sent_message = comm_message
	if(!comm_message)
		var/datum/nanite_extra_setting/sentence = extra_settings[NES_SENTENCE]
		sent_message = sentence.get_value()
	if(sent_message in blacklist)
		return
	if(host_mob.stat == DEAD)
		return
	to_chat(host_mob, span_warning("Você se sente compelido a falar..."))
	host_mob.say(sent_message, forced = "nanite speech")

/datum/nanite_program/comm/voice
	name = "Skull Echo"
	desc = "Os nanites ecoam uma mensagem sintetizada dentro do crânio do hospedeiro."
	unique = FALSE
	trigger_cost = 1
	trigger_cooldown = 20
	rogue_types = list(/datum/nanite_program/brain_misfire, /datum/nanite_program/brain_decay)

/datum/nanite_program/comm/voice/register_extra_settings()
	. = ..()
	extra_settings[NES_MESSAGE] = new /datum/nanite_extra_setting/text("")

/datum/nanite_program/comm/voice/on_trigger(comm_message)
	var/sent_message = comm_message
	if(!comm_message)
		var/datum/nanite_extra_setting/message_setting = extra_settings[NES_MESSAGE]
		sent_message = message_setting.get_value()
	if(host_mob.stat == DEAD)
		return
	send_user_message(sent_message)

/datum/nanite_program/comm/hallucination
	name = "Hallucination"
	desc = "Os nanites fazem o hospedeiro alucinar quando acionado."
	trigger_cost = 4
	trigger_cooldown = 80
	unique = FALSE
	rogue_types = list(/datum/nanite_program/brain_misfire)
	var/list/hallucination_options = list(
		"Message" = /datum/hallucination/chat,
		"Battle" = /datum/hallucination/battle,
		"Sound" = /datum/hallucination/fake_sound,
		"Weird Sound" = /datum/hallucination/fake_sound/weird,
		"Station Message" = /datum/hallucination/station_message,
		"Health" = null,
		"Alert" = /datum/hallucination/fake_alert,
		"Fire" = /datum/hallucination/fire,
		"Shock" = /datum/hallucination/shock,
		"Plasma Flood" = /datum/hallucination/fake_flood,
		"Random" = null
	)

/datum/nanite_program/comm/hallucination/register_extra_settings()
	. = ..()
	var/list/options = assoc_to_keys(hallucination_options)
	extra_settings[NES_HALLUCINATION_TYPE] = new /datum/nanite_extra_setting/type("Message", options)
	extra_settings[NES_HALLUCINATION_DETAIL] = new /datum/nanite_extra_setting/text("")

/datum/nanite_program/comm/hallucination/on_trigger(comm_message)
	var/datum/nanite_extra_setting/hal_setting = extra_settings[NES_HALLUCINATION_TYPE]
	var/hal_type = hal_setting.get_value()
	var/datum/nanite_extra_setting/hal_detail_setting = extra_settings[NES_HALLUCINATION_DETAIL]
	var/hal_details = hal_detail_setting.get_value()
	if(comm_message && (hal_type != "Message")) //Triggered via comm remote, but not set to a message hallucination
		return
	var/sent_message = comm_message //Comm remotes can send custom hallucination messages for the chat hallucination
	if(!sent_message)
		sent_message = hal_details

	if(!iscarbon(host_mob))
		return
	var/mob/living/carbon/carbon = host_mob
	if(hal_details == "random")
		hal_details = null
	switch(hal_type)
		if("Random")
			carbon.adjust_hallucinations(15)
		if("Health")
			switch(hal_details)
				if("critical")
					carbon.adjust_timed_status_effect(3 MINUTES, /datum/status_effect/grouped/screwy_hud/fake_crit)
				if("dead")
					carbon.adjust_timed_status_effect(3 MINUTES, /datum/status_effect/grouped/screwy_hud/fake_dead)
				if("healthy")
					carbon.adjust_timed_status_effect(3 MINUTES, /datum/status_effect/grouped/screwy_hud/fake_healthy)
		else
			if(hallucination_options[hal_type])
				carbon.cause_hallucination(hallucination_options[hal_type], TRUE, hal_details)

/datum/nanite_program/comm/hallucination/set_extra_setting(setting, value)
	. = ..()
	if(setting == NES_HALLUCINATION_TYPE)
		switch(value)
			if("Message")
				extra_settings[NES_HALLUCINATION_DETAIL] = new /datum/nanite_extra_setting/text("")
			if("Battle")
				extra_settings[NES_HALLUCINATION_DETAIL] = new /datum/nanite_extra_setting/type("random", list("random","laser","disabler","esword","gun","stunprod","harmbaton","bomb"))
			if("Sound")
				extra_settings[NES_HALLUCINATION_DETAIL] = new /datum/nanite_extra_setting/type("random", list("random","airlock","airlock pry","console","explosion","far explosion","mech","glass","alarm","beepsky","mech","wall decon","door hack"))
			if("Weird Sound")
				extra_settings[NES_HALLUCINATION_DETAIL] = new /datum/nanite_extra_setting/type("random", list("random","phone","hallelujah","highlander","laughter","hyperspace","game over","creepy","tesla"))
			if("Station Message")
				extra_settings[NES_HALLUCINATION_DETAIL] = new /datum/nanite_extra_setting/type("random", list("random","ratvar","shuttle dock","blob alert","malf ai","meteors","supermatter"))
			if("Health")
				extra_settings[NES_HALLUCINATION_DETAIL] = new /datum/nanite_extra_setting/type("random", list("random","critical","dead","healthy"))
			if("Alert")
				extra_settings[NES_HALLUCINATION_DETAIL] = new /datum/nanite_extra_setting/type("random", list("random","not_enough_oxy","not_enough_tox","not_enough_co2","too_much_oxy","too_much_co2","too_much_tox","newlaw","nutrition","charge","gravity","fire","locked","hacked","temphot","tempcold","pressure"))
			else
				extra_settings.Remove(NES_HALLUCINATION_DETAIL)

/datum/nanite_program/mood
	name = "Happiness Enhancer"
	desc = "Os nanites sintetizam serotonina dentro do cérebro do hospedeiro, criando uma sensação artificial de felicidade."
	use_rate = 0.1
	rogue_types = list(/datum/nanite_program/brain_decay)
	var/mood_event = /datum/mood_event/nanite_happiness
	var/default_text = "HAPPINESS ENHANCEMENT"
	var/mood_category = "nanite_happy"

/datum/nanite_program/mood/register_extra_settings()
	. = ..()
	extra_settings[NES_MOOD_MESSAGE] = new /datum/nanite_extra_setting/text(default_text)

/datum/nanite_program/mood/enable_passive_effect()
	. = ..()
	host_mob.add_mood_event(mood_category, mood_event, get_extra_setting_value(NES_MOOD_MESSAGE))

/datum/nanite_program/mood/disable_passive_effect()
	. = ..()
	host_mob.clear_mood_event(mood_category)

/datum/nanite_program/mood/bad
	name = "Happiness Suppressor"
	desc = "Os nanites suprimem a produção de serotonina dentro do cérebro do hospedeiro, criando um estado artificial de depressão."
	mood_event = /datum/mood_event/nanite_sadness
	default_text = "SUPRESSÃO DA FELICIDADE"
	mood_category = "nanite_unhappy"
