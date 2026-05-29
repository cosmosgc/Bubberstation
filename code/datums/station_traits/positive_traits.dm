#define PARTY_COOLDOWN_LENGTH_MIN (6 MINUTES)
#define PARTY_COOLDOWN_LENGTH_MAX (12 MINUTES)

/datum/station_trait/lucky_winner
	name = "Ganhador sortudo"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 1
	show_in_report = TRUE
	report_message = "Sua estação ganhou o grande prêmio do evento anual de caridade da estação. Lanches grátis serão entregues ao bar de vez em quando."
	trait_processes = TRUE
	COOLDOWN_DECLARE(party_cooldown)

/datum/station_trait/lucky_winner/on_round_start()
	. = ..()
	COOLDOWN_START(src, party_cooldown, rand(PARTY_COOLDOWN_LENGTH_MIN, PARTY_COOLDOWN_LENGTH_MAX))

/datum/station_trait/lucky_winner/process(seconds_per_tick)
	if(!COOLDOWN_FINISHED(src, party_cooldown))
		return

	COOLDOWN_START(src, party_cooldown, rand(PARTY_COOLDOWN_LENGTH_MIN, PARTY_COOLDOWN_LENGTH_MAX))

	var/pizza_type_to_spawn = pick(list(
		/obj/item/pizzabox/margherita,
		/obj/item/pizzabox/mushroom,
		/obj/item/pizzabox/meat,
		/obj/item/pizzabox/vegetable,
		/obj/item/pizzabox/pineapple
	))

	var/area/bar_area = pick(GLOB.bar_areas)
	podspawn(list(
		"target" = pick(bar_area.contents),
		"path" = /obj/structure/closet/supplypod/centcompod,
		"spawn" = list(
			pizza_type_to_spawn,
			/obj/item/reagent_containers/cup/glass/bottle/beer = 6
		)
	))

#undef PARTY_COOLDOWN_LENGTH_MIN
#undef PARTY_COOLDOWN_LENGTH_MAX

/datum/station_trait/galactic_grant
	name = "Subsídio galáctico"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	show_in_report = TRUE
	report_message = "Sua estação foi selecionada para um subsídio especial. Fundos extras foram disponibilizados para seu departamento de carga."

/datum/station_trait/galactic_grant/on_round_start()
	var/datum/bank_account/cargo_bank = SSeconomy.get_dep_account(ACCOUNT_CAR)
	cargo_bank.adjust_money(rand(2000, 5000))

/datum/station_trait/premium_internals_box
	name = "Caixas de respiração premium"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	show_in_report = TRUE
	report_message = "As caixas de respiração para sua tripulação foram ampliadas e preenchidas com equipamentos extras."
	trait_to_give = STATION_TRAIT_PREMIUM_INTERNALS

/datum/station_trait/bountiful_bounties
	name = "Recompensas generosas"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	cost = STATION_TRAIT_COST_LOW
	show_in_report = TRUE
	report_message = "Parece que os colecionadores neste sistema estão muito interessados em recompensas e pagarão mais para vê-las concluídas."

/datum/station_trait/bountiful_bounties/on_round_start()
	SSeconomy.bounty_modifier *= 1.2

///A positive station trait that scatters a bunch of lit glowsticks throughout maintenance
/datum/station_trait/glowsticks
	name = "Festa de glowsticks"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 2
	show_in_report = TRUE
	report_message = "Temos glowsticks de sobra, então espalhamos alguns pela manutenção (mais algumas luzes de chão)."

/datum/station_trait/glowsticks/New()
	..()
	RegisterSignal(SSticker, COMSIG_TICKER_ENTER_PREGAME, PROC_REF(on_pregame))

/datum/station_trait/glowsticks/proc/on_pregame(datum/source)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(light_up_the_night))

/datum/station_trait/glowsticks/proc/light_up_the_night()
	var/list/glowsticks = list(
		/obj/item/flashlight/glowstick,
		/obj/item/flashlight/glowstick/red,
		/obj/item/flashlight/glowstick/blue,
		/obj/item/flashlight/glowstick/cyan,
		/obj/item/flashlight/glowstick/orange,
		/obj/item/flashlight/glowstick/yellow,
		/obj/item/flashlight/glowstick/pink,
	)
	for(var/area/station/maintenance/maint in GLOB.areas)
		var/list/turfs = get_area_turfs(maint)
		for(var/i in 1 to round(length(turfs) * 0.115))
			CHECK_TICK
			var/turf/open/chosen = pick_n_take(turfs)
			if(!istype(chosen))
				continue
			var/skip_this = FALSE
			for(var/atom/movable/mov as anything in chosen) //stop glowing sticks from spawning on windows
				if(mov.density && !(mov.pass_flags_self & LETPASSTHROW))
					skip_this = TRUE
					break
			if(skip_this)
				continue
			if(prob(3.4)) ///Rare, but this is something that can survive past the lifespawn of glowsticks.
				new /obj/machinery/light/floor(chosen)
				continue
			var/stick_type = pick(glowsticks)
			var/obj/item/flashlight/glowstick/stick = new stick_type(chosen, rand(10, 45))
			///we want a wider range, otherwise they'd all burn out in about 20 minutes.
			stick.turn_on()

/datum/station_trait/strong_supply_lines
	name = "Linhas de suprimento fortes"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	show_in_report = TRUE
	report_message = "Os preços estão baixos neste sistema, COMPRE COMPRE COMPRE!"
	blacklist = list(/datum/station_trait/distant_supply_lines)

/datum/station_trait/strong_supply_lines/on_round_start()
	SSeconomy.pack_price_modifier *= 0.8

/datum/station_trait/filled_maint
	name = "Manutenção abastecida"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	cost = STATION_TRAIT_COST_LOW
	show_in_report = TRUE
	report_message = "Nossos trabalhadores acidentalmente esqueceram mais de seus pertences pessoais nas áreas de manutenção."
	blacklist = list(/datum/station_trait/empty_maint)
	trait_to_give = STATION_TRAIT_FILLED_MAINT

	// This station trait is checked when loot drops initialize, so it's too late
	can_revert = FALSE

/datum/station_trait/quick_shuttle
	name = "Ônibus rápido"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	show_in_report = TRUE
	report_message = "Devido à proximidade da nossa estação de suprimentos, o ônibus de carga terá um tempo de voo mais rápido para o seu departamento de carga."
	blacklist = list(/datum/station_trait/slow_shuttle)

/datum/station_trait/quick_shuttle/on_round_start()
	. = ..()
	SSshuttle.supply.callTime *= 0.5

/datum/station_trait/deathrattle_department
	name = "departamento com morte rastreada"
	trait_type = STATION_TRAIT_POSITIVE
	show_in_report = TRUE
	abstract_type = /datum/station_trait/deathrattle_department
	blacklist = list(/datum/station_trait/deathrattle_all)

	var/department_to_apply_to
	var/department_name = "departamento"
	var/datum/deathrattle_group/deathrattle_group

/datum/station_trait/deathrattle_department/New()
	. = ..()
	deathrattle_group = new("[department_name] grupo")
	blacklist += subtypesof(/datum/station_trait/deathrattle_department) - type //All but ourselves
	report_message = "Todos os membros do [department_name] receberam um implante para notificar uns aos outros se um deles morrer. Isto deve ajudar a melhorar a segurança no trabalho!"
	RegisterSignal(SSdcs, COMSIG_GLOB_JOB_AFTER_SPAWN, PROC_REF(on_job_after_spawn))


/datum/station_trait/deathrattle_department/proc/on_job_after_spawn(datum/source, datum/job/job, mob/living/spawned, client/player_client)
	SIGNAL_HANDLER

	if(!(job.departments_bitflags & department_to_apply_to))
		return

	var/obj/item/implant/deathrattle/implant_to_give = new()
	deathrattle_group.register(implant_to_give)
	implant_to_give.implant(spawned, spawned, TRUE, TRUE)


/datum/station_trait/deathrattle_department/service
	name = "Serviço com Morte Rastreada"
	weight = 1
	department_to_apply_to = DEPARTMENT_BITFLAG_SERVICE
	department_name = "Serviço"

/datum/station_trait/deathrattle_department/cargo
	name = "Carga com Morte Rastreada"
	weight = 1
	department_to_apply_to = DEPARTMENT_BITFLAG_CARGO
	department_name = "Carga"

/datum/station_trait/deathrattle_department/engineering
	name = "Engenharia com Morte Rastreada"
	weight = 1
	department_to_apply_to = DEPARTMENT_BITFLAG_ENGINEERING
	department_name = "Engenharia"

/datum/station_trait/deathrattle_department/command
	name = "Comando com Morte Rastreada"
	weight = 1
	department_to_apply_to = DEPARTMENT_BITFLAG_COMMAND
	department_name = "Comando"

/datum/station_trait/deathrattle_department/science
	name = "Ciência com Morte Rastreada"
	weight = 1
	department_to_apply_to = DEPARTMENT_BITFLAG_SCIENCE
	department_name = "Ciência"

/datum/station_trait/deathrattle_department/security
	name = "Segurança com Morte Rastreada"
	weight = 1
	department_to_apply_to = DEPARTMENT_BITFLAG_SECURITY
	department_name = "Segurança"

/datum/station_trait/deathrattle_department/medical
	name = "Medicina com Morte Rastreada"
	weight = 1
	department_to_apply_to = DEPARTMENT_BITFLAG_MEDICAL
	department_name = "Medicina"

/datum/station_trait/deathrattle_all
	name = "Estação com Morte Rastreada"
	trait_type = STATION_TRAIT_POSITIVE
	show_in_report = TRUE
	weight = 1
	report_message = "Todos os membros da estação receberam um implante para notificar uns aos outros se um deles morrer. Isto deve ajudar a melhorar a segurança no trabalho!"
	var/datum/deathrattle_group/deathrattle_group

/datum/station_trait/deathrattle_all/New()
	. = ..()
	deathrattle_group = new("grupo da estação")
	blacklist = subtypesof(/datum/station_trait/deathrattle_department)
	RegisterSignal(SSdcs, COMSIG_GLOB_JOB_AFTER_SPAWN, PROC_REF(on_job_after_spawn))

/datum/station_trait/deathrattle_all/proc/on_job_after_spawn(datum/source, datum/job/job, mob/living/spawned, client/player_client)
	SIGNAL_HANDLER

	var/obj/item/implant/deathrattle/implant_to_give = new()
	deathrattle_group.register(implant_to_give)
	implant_to_give.implant(spawned, spawned, TRUE, TRUE)

/datum/station_trait/cybernetic_revolution
	name = "Revolução Cibernética"
	trait_type = STATION_TRAIT_POSITIVE
	show_in_report = TRUE
	weight = 1
	report_message = "As novas tendências em cibernética chegaram à estação! Todos têm alguma forma de implante cibernético."
	trait_to_give = STATION_TRAIT_CYBERNETIC_REVOLUTION
	/// List of all job types with the cybernetics they should receive.
	var/static/list/job_to_cybernetic = list(
		/datum/job/assistant = /obj/item/organ/heart/cybernetic, //real cardiac
		/datum/job/atmospheric_technician = /obj/item/organ/cyberimp/mouth/breathing_tube,
		/datum/job/bartender = /obj/item/organ/liver/cybernetic/tier3,
		/datum/job/bitrunner = /obj/item/organ/eyes/robotic/thermals,
		/datum/job/botanist = /obj/item/organ/cyberimp/chest/nutriment,
		/datum/job/captain = /obj/item/organ/heart/cybernetic/tier3,
		/datum/job/cargo_technician = /obj/item/organ/stomach/cybernetic/tier2,
		/datum/job/chaplain = /obj/item/organ/cyberimp/brain/anti_drop,
		/datum/job/chemist = /obj/item/organ/liver/cybernetic/tier2,
		/datum/job/chief_engineer = /obj/item/organ/cyberimp/chest/thrusters,
		/datum/job/chief_medical_officer = /obj/item/organ/cyberimp/chest/reviver,
		/datum/job/clown = /obj/item/organ/cyberimp/brain/anti_stun, //HONK!
		/datum/job/cook = /obj/item/organ/cyberimp/chest/nutriment/plus,
		/datum/job/coroner = /obj/item/organ/tongue/bone, //hes got a bone to pick with you
		/datum/job/curator = /obj/item/organ/cyberimp/brain/connector,
		/datum/job/detective = /obj/item/organ/lungs/cybernetic/tier3,
		/datum/job/doctor = /obj/item/organ/cyberimp/arm/toolkit/surgery,
		/datum/job/geneticist = /obj/item/organ/fly, //we don't care about implants, we have cancer.
		/datum/job/head_of_personnel = /obj/item/organ/eyes/robotic,
		/datum/job/head_of_security = /obj/item/organ/eyes/robotic/thermals,
		/datum/job/human_ai = /obj/item/organ/brain/cybernetic,
		/datum/job/janitor = /obj/item/organ/eyes/robotic/xray,
		/datum/job/lawyer = /obj/item/organ/heart/cybernetic/tier2,
		/datum/job/mime = /obj/item/organ/tongue/robot, //...
		/datum/job/paramedic = /obj/item/organ/cyberimp/eyes/hud/medical,
		/datum/job/prisoner = /obj/item/organ/eyes/robotic/shield,
		/datum/job/psychologist = /obj/item/organ/ears/cybernetic/whisper,
		/datum/job/pun_pun = /obj/item/organ/cyberimp/arm/strongarm,
		/datum/job/quartermaster = /obj/item/organ/stomach/cybernetic/tier3,
		/datum/job/research_director = /obj/item/organ/cyberimp/bci,
		/datum/job/roboticist = /obj/item/organ/cyberimp/eyes/hud/diagnostic,
		/datum/job/scientist = /obj/item/organ/ears/cybernetic,
		/datum/job/security_officer = /obj/item/organ/cyberimp/arm/toolkit/flash,
		/datum/job/shaft_miner = /obj/item/organ/monster_core/rush_gland,
		/datum/job/station_engineer = /obj/item/organ/cyberimp/arm/toolkit/toolset,
		/datum/job/warden = /obj/item/organ/cyberimp/eyes/hud/security,
		// BUBBER EDIT ADDITION START - MODULAR JOBS
		/datum/job/blueshield = /obj/item/organ/cyberimp/brain/anti_stun,
		/datum/job/nanotrasen_consultant = /obj/item/organ/heart/cybernetic/tier3,
		/datum/job/barber = /obj/item/organ/ears/cybernetic/whisper,
		/datum/job/corrections_officer = /obj/item/organ/cyberimp/arm/toolkit/flash,
		/datum/job/orderly = /obj/item/organ/cyberimp/brain/anti_drop,
		/datum/job/science_guard = /obj/item/organ/cyberimp/arm/toolkit/flash,
		/datum/job/customs_agent = /obj/item/organ/cyberimp/eyes/hud/security,
		/datum/job/bouncer = /obj/item/organ/cyberimp/arm/strongarm,
		/datum/job/engineering_guard = /obj/item/organ/cyberimp/arm/toolkit/flash,
		/datum/job/telecomms_specialist = /obj/item/organ/ears/cybernetic/xray,
		// BUBBER EDIT END
	)

/datum/station_trait/cybernetic_revolution/New()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_JOB_AFTER_SPAWN, PROC_REF(on_job_after_spawn))

/datum/station_trait/cybernetic_revolution/proc/on_job_after_spawn(datum/source, datum/job/job, mob/living/spawned, client/player_client)
	SIGNAL_HANDLER

	var/datum/quirk/body_purist/body_purist = /datum/quirk/body_purist
	if(initial(body_purist.name) in player_client.prefs.all_quirks)
		return
	var/cybernetic_type = job_to_cybernetic[job.type]
	if(!cybernetic_type)
		if(isAI(spawned))
			var/mob/living/silicon/ai/ai = spawned
			ai.eyeobj.relay_speech = TRUE //surveillance upgrade. the ai gets cybernetics too.
		return
	var/obj/item/organ/cybernetic = new cybernetic_type()
	cybernetic.Insert(spawned, special = TRUE, movement_flags = DELETE_IF_REPLACED)

/datum/station_trait/luxury_escape_pods
	name = "Cápsulas de Fuga de Luxo"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	show_in_report = TRUE
	report_message = "Devido ao bom desempenho, fornecemos à sua estação cápsulas de fuga de luxo."
	trait_to_give = STATION_TRAIT_BIGGER_PODS
	blacklist = list(/datum/station_trait/cramped_escape_pods)

/datum/station_trait/medbot_mania
	name = "Medbots Avançados"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	cost = STATION_TRAIT_COST_LOW
	show_in_report = TRUE
	report_message = "Os medibots da sua estação receberam uma atualização de hardware, permitindo capacidades de cura expandidas."
	trait_to_give = STATION_TRAIT_MEDBOT_MANIA

/datum/station_trait/random_event_weight_modifier/shuttle_loans
	name = "Ônibus Emprestado"
	report_message = "Devido a um aumento nos ataques de piratas em seu setor, há poucas naves de suprimentos no espaço próximo dispostas a ajudar com pedidos especiais. Espere receber mais oportunidades de empréstimo de ônibus, com pagamentos ligeiramente maiores."
	trait_type = STATION_TRAIT_POSITIVE
	weight = 4
	event_control_path = /datum/round_event_control/shuttle_loan
	weight_multiplier = 2.5
	max_occurrences_modifier = 5 //All but one loan event will occur over the course of a round.
	trait_to_give = STATION_TRAIT_LOANER_SHUTTLE

/datum/station_trait/random_event_weight_modifier/wise_cows
	name = "Invasão de Vacas Sábias"
	report_message = "Leituras harmônicas de bluespace mostram sinais interpolativos incomuns entre seu setor e o setor agrícola MMF-D-02. Espere um aumento em encontros com vacas. Encontros, se você preferir."
	trait_type = STATION_TRAIT_POSITIVE
	weight = 1
	event_control_path = /datum/round_event_control/wisdomcow
	weight_multiplier = 3
	max_occurrences_modifier = 10 //lotta cows

/datum/station_trait/random_event_weight_modifier/wise_cows/get_pulsar_message()
	var/advisory_string = "Nível de Alerta: <b>Planeta Vaca</b></center><BR>"
	advisory_string += "O nível de alerta do seu setor é Planeta Vaca. Nós realmente não sabemos o que isto significa -- o modelo que usamos para criar estes relatórios de ameaça nunca produziu este resultado antes. Cuidado com as vacas, eu acho? Boa sorte!"
	return advisory_string

/datum/station_trait/bright_day
	name = "Dia Claro"
	report_message = "As estrelas brilham forte e as nuvens são mais escassas que o normal. É um dia claro aqui na superfície da Lua de Gelo."
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	show_in_report = TRUE
	trait_flags = STATION_TRAIT_PLANETARY
	trait_to_give = STATION_TRAIT_BRIGHT_DAY

/datum/station_trait/shuttle_sale
	name = "Liquidação de Ônibus"
	report_message = "A equipe de Despacho de Emergência da Nanotrasen está celebrando um número recorde de chamadas de ônibus no trimestre recente. Algumas de suas opções de ônibus de emergência foram descontadas!"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 4
	trait_to_give = STATION_TRAIT_SHUTTLE_SALE
	show_in_report = TRUE

/datum/station_trait/missing_wallet
	name = "Carteira Perdida"
	report_message = "Um técnico de reparos deixou sua carteira em algum armário. Eles agradeceriam muito se você pudesse localizá-la e devolvê-la quando o turno terminar."
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	cost = STATION_TRAIT_COST_LOW
	show_in_report = TRUE

/datum/station_trait/missing_wallet/on_round_start()
	. = ..()

	var/obj/structure/closet/locker_to_fill = pick(GLOB.roundstart_station_closets)

	var/obj/item/storage/wallet/new_wallet = new(locker_to_fill)

	new /obj/item/stack/spacecash/c500(new_wallet)
	if(prob(25)) //Jackpot!
		new /obj/item/stack/spacecash/c1000(new_wallet)

	new /obj/item/card/id/advanced/technician_id(new_wallet)
	new_wallet.refreshID()

	if(prob(35))
		report_message += " O técnico relata que se lembra pela última vez de ter a carteira por volta de [get_area_name(new_wallet)]."

	message_admins("Uma carteira perdida foi colocada no armário [locker_to_fill], na área [get_area_name(locker_to_fill)].")

/obj/item/card/id/advanced/technician_id
	name = "ID de Técnico de Reparo"
	desc = "Técnico de Reparo? Nós não temos isso neste setor, só um bando de engenheiros preguiçosos! Isso deve ser da equipe de troca de turno..."
	registered_name = "Pluoxium LXVII"
	registered_age = 67
	trim = /datum/id_trim/technician_id

/datum/id_trim/technician_id
	access = list(ACCESS_EXTERNAL_AIRLOCKS, ACCESS_MAINT_TUNNELS)
	assignment = "Técnico de Reparo"
	trim_state = "trim_stationengineer"
	department_color = COLOR_ASSISTANT_GRAY

/// Spawns assistants with some gear, either gimmicky or functional. Maybe, one day, it will inspire an assistant to do something productive or fun
/datum/station_trait/assistant_gimmicks
	name = "Piloto de Assistentes Equipados"
	report_message = "A divisão de Assuntos de Assistentes da Nanotrasen está conduzindo um piloto para ver se diferentes equipamentos de assistente ajudam a melhorar a produtividade!"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 3
	trait_to_give = STATION_TRAIT_ASSISTANT_GIMMICKS
	show_in_report = TRUE
	blacklist = list(/datum/station_trait/colored_assistants)

/datum/station_trait/random_event_weight_modifier/assistant_gimmicks/get_pulsar_message()
	var/advisory_string = "Nível de Alerta: <b>Céu Cinza</b></center><BR>"
	advisory_string += "O nível de alerta do seu setor é Céu Cinza. Nossos sensores detectam atividade anormal entre os assistentes designados para sua estação. Recomendamos monitorar de perto o Depósito de Ferramentas, Ponte, Depósito Técnico e Brig por aglomerações ou pequenos furtos."
	return advisory_string
