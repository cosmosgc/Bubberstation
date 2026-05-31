/obj/item/keycard/meatderelict/director
	name = "directors keycard"
	desc = "Um cartão chique. Provavelmente abre o escritório dos diretores. O crachá está todo borrado."
	color = "#990000"
	puzzle_id = "md_director"

/obj/item/keycard/meatderelict/engpost
	name = "post keycard"
	desc = "Um cartão chique. Tem a insígnia de engenharia nele."
	color = "#f0da12"
	puzzle_id = "md_engpost"

/obj/item/keycard/meatderelict/armory
	name = "armory keycard"
	desc = "Um cartão vermelho. Tem uma imagem muito legal de uma arma. Chique."
	color = "#FF7276"
	puzzle_id = "md_armory"

/obj/item/paper/crumpled/bloody/fluff/meatderelict/directoroffice
	name = "directors note"
	default_raw_text = "<i>A pesquisa estava indo bem... mas o experimento não foi como planejado. Ele convulsionou e gritou enquanto lentamente se transformava naquela coisa. Começou a se espalhar por todo lado, fora do laboratório também. Não há como encobrirmos que não somos um posto avançado de pesquisa, então tranquei o laboratório, mas eles já sabem. Mandaram um esquadrão para nos resgatar, mas...</i>"

/obj/item/paper/crumpled/fluff/meatderelict/shieldgens
	name = "shield gate marketing sketch"
	default_raw_text = "O<b>QR-109 Shield Gate</b>é uma robusta máquina de luz dura capaz de produzir um escudo forte para entrar na barra. Com a integração do painel de controle, pode ser ativado ou desativado de qualquer lugar, como a Ponte da nave,<b>Área de Engenharia</b>Ou em qualquer outro lugar!<i>O resto está desbotado...</i>"

/obj/item/paper/crumpled/fluff/meatderelict
	name = "engineer note"
	default_raw_text = "Eu overclocked os geradores de energia para adicionar que precisava de suco para o experimento, embora eles são um pouco instável."

/obj/item/paper/crumpled/fluff/meatderelict/fridge
	name = "engineer complaint"
	default_raw_text = "Quem continuar roubando meu sorvete da minha geladeira, juro que vou acabar com você. Não é barato comprar este delicioso sorvete aqui, nem é para você.<b>E não toque no meu lanche na gaveta!</b>"

/obj/machinery/computer/terminal/meatderelict
	upperinfo = "COPYRIGHT 2500 NANOSOFT-TM - DO NOT REDISTRIBUTE - Now with audio!" //not that old
	content = list(
		"Experimental Test Satellite 37B<br/>Nanotrasen™️ approved deep space experimentation lab<br/><br/>Entry 1:<br/><br/>Subject - \[Species 501-C-12\]<br/>Date - \[REDACTED\]<br/>We have acquired a biological sample of unknown origins \[Species 501-C-12\] from an NT outpost on the far reaches. Initial experiments have determined the sample to be a creature never previously recorded. It weighs approximately 7 grams and seems to be docile. Initial examinations determine that it is an extremely fast replicating organism which can alter its physiology to take multiple differing shapes. \[Recording Terminated\]<br/>- Dr. Phil Cornelius",
		"Entry 2:<br/><br/>Subject - \[Species 501-C-12\]<br/>Date - \[REDACTED\]<br/>The creature responds to electrical stimuli. It has failed to respond to Light, Heat, Cold, Oxygen, Plasma, CO2, Nitrogen. It, within moments, seemed to have generated muscle tissue within its otherwise shapeless form and moved away from the source of electricity. Feeding the creature has been a simple matter, it consumed just about any form of protein. It appears to rapidly digest and convert forms of protein into more of itself. Any undigestible products are simply left alone. Will continue to monitor creature and provide reports to Nanotrasen Central Command. \[Recording Terminated\]<br/>- Dr. Phil Cornelius",
		"Entry 3:<br/><br/>Subject - \[Species 501-C-12\]<br/>Date - \[REDACTED\]<br/>Any attempts at contacting Nanotrasen has failed. I've never seen anything like it. I... I don't think I'm going to survive much longer, I can hear it pushing on my room door. If anyone reads this, let my family know that I- \[Loud crash\]<br/>GET BACK \[Gunshots\]<br/>AHHHHHHHHHHHH \[Recording Terminated\]<br/>- Dr. Phil Cornelius"
	)

/obj/machinery/door/puzzle/meatderelict
	name = "lockdown door"
	desc = "Uma porta batida, ainda resistente. Impermeável aos métodos convencionais de destruição, deve ser uma maneira de abri-lo nas proximidades."
	icon = 'icons/obj/doors/puzzledoor/danger.dmi'
	puzzle_id = "md_prevault"

/mob/living/basic/meteor_heart/opens_puzzle_door
	///the puzzle id we send on death
	var/id
	///queue size, must match
	var/queue_size = 2

/mob/living/basic/meteor_heart/opens_puzzle_door/Initialize(mapload)
	. = ..()
	new /obj/effect/puzzle_death_signal_holder(loc, src, id, queue_size)

/obj/effect/puzzle_death_signal_holder // ok apparently registering signals on qdeling stuff is not very functional
	///delay
	var/delay = 2.5 SECONDS
	invisibility = INVISIBILITY_ABSTRACT

/obj/effect/puzzle_death_signal_holder/Initialize(mapload, mob/listened, id, queue_size = 2)
	. = ..()
	if(isnull(id))
		return INITIALIZE_HINT_QDEL
	RegisterSignal(listened, COMSIG_LIVING_DEATH, PROC_REF(on_death))
	SSqueuelinks.add_to_queue(src, id, queue_size)

/obj/effect/puzzle_death_signal_holder/proc/on_death(datum/source)
	SIGNAL_HANDLER
	addtimer(CALLBACK(src, PROC_REF(send_sig)), delay)

/obj/effect/puzzle_death_signal_holder/proc/send_sig()
	SEND_SIGNAL(src, COMSIG_PUZZLE_COMPLETED)
	qdel(src)

/obj/machinery/puzzle/button/meatderelict
	name = "lockdown panel"
	desc = "Um painel que controla o bloqueio deste posto avançado."
	id = "md_prevault"

/obj/machinery/puzzle/button/meatderelict/on_puzzle_complete()
	. = ..()
	playsound(src, 'sound/effects/alert.ogg', 100, TRUE)
	visible_message(span_warning("[src]Solta um alarme enquanto o confinamento é levantado!"))

/obj/structure/puzzle_blockade/meat
	name = "mass of meat and teeth"
	desc = "Uma massa horrível de carne e dentes. Pode te ver? Você espera que não. Virtualmente indestrutível, deve ser uma forma de dar a volta."
	icon = 'icons/obj/structures.dmi'
	icon_state = "meatblockade"
	opacity = TRUE

/obj/structure/puzzle_blockade/meat/try_signal(datum/source)
	Shake(duration = 0.5 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(open_up)), 0.5 SECONDS)

/obj/structure/puzzle_blockade/meat/proc/open_up()
	new /obj/effect/gibspawner/generic(drop_location())
	qdel(src)

/obj/lightning_thrower
	name = "overcharged SMES"
	desc = "Uma PME overclockada, Cheia de energia."
	anchored = TRUE
	density = TRUE
	icon = 'icons/obj/machines/engine/other.dmi'
	icon_state = "smes"
	/// do we currently want to shock diagonal tiles? if not, we shock cardinals
	var/throw_diagonals = FALSE
	/// flags we apply to the shock
	var/shock_flags = SHOCK_KNOCKDOWN | SHOCK_NOGLOVES
	/// damage of the shock
	var/shock_damage = 20
	/// list of turfs that are currently shocked so we can unregister the signal
	var/list/signal_turfs = list()
	/// how long do we shock
	var/shock_duration = 0.5 SECONDS

/obj/lightning_thrower/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSprocessing, src)

/obj/lightning_thrower/Destroy()
	. = ..()
	clear_signals()
	signal_turfs = null
	STOP_PROCESSING(SSprocessing, src)

/obj/lightning_thrower/process(seconds_per_tick)
	var/list/dirs = throw_diagonals ? GLOB.diagonals : GLOB.cardinals
	throw_diagonals = !throw_diagonals
	playsound(src, 'sound/effects/magic/lightningbolt.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, ignore_walls = FALSE)
	if(length(signal_turfs))
		clear_signals()
	for(var/direction in dirs)
		var/victim_turf = get_step(src, direction)
		if(isclosedturf(victim_turf))
			continue
		Beam(victim_turf, icon_state="lightning[rand(1,12)]", time = shock_duration)
		RegisterSignal(victim_turf, COMSIG_ATOM_ENTERED, PROC_REF(shock_victim)) //we cant move anyway
		signal_turfs += victim_turf
		for(var/mob/living/victim in victim_turf)
			shock_victim(null, victim)
	addtimer(CALLBACK(src, PROC_REF(clear_signals)), shock_duration)

/obj/lightning_thrower/proc/clear_signals()
	for(var/turf in signal_turfs)
		UnregisterSignal(turf, COMSIG_ATOM_ENTERED)
		signal_turfs -= turf

/obj/lightning_thrower/proc/shock_victim(datum/source, mob/living/victim)
	SIGNAL_HANDLER
	if(!istype(victim))
		return
	victim.electrocute_act(shock_damage, src, flags = shock_flags)
