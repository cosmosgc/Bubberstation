//code & items for the hauntedtradingpost.dmm ruin
//CONTAINS: [Lore Papers],[Outpost ID Cards],[Gimmick Treasure],[Hazards & Traps],[Custom Turrets]

// [Lore Papers]
// clues to traps that exist in the ruin or just insights into the backstory of the place
/obj/item/paper/fluff/ruins/hauntedtradingpost/warning
	name = "Last Warning"
	default_raw_text = "A próxima pessoa que quebrar uma máquina de venda com aquelas armas de brinquedo é disparada no local. Tente. Estou doente dessa merda.<BR><BR>Assinado, seu maldito chefe."

/obj/item/paper/fluff/ruins/hauntedtradingpost/warning/turrets
	name = "Warning! Important! Read this!"
	default_raw_text = "Dardos de espuma não vão nas torres de defesa! Só munição viva!"

/obj/item/paper/fluff/ruins/hauntedtradingpost/brainstorming
	name = "Notes"
	default_raw_text = "\"Pizza no seu bolso\"<BR><BR>Tomate Mozzerella Basil<BR>etc<BR><BR>Aranha 17-02667 Loja 31-00314<BR><BR>18 mil aproximadamente BSD<BR><BR>Alérgenos comuns?<BR><BR><BR>6127"

/obj/item/paper/fluff/ruins/hauntedtradingpost/brainstorming/eureka
	default_raw_text = "Consegui alguns ingredientes da frota de comércio de traças e usei alguns do nosso orçamento discricionário para contratar algum espaço de fábrica. Protótipos estão indo bem com público e funcionários. Se conseguirmos financiar a produção em massa, veremos um aumento permanente de 18% no lucro regional de acordo com a IA. Isso se encaixa no mercado de brunch local."

/obj/item/paper/fluff/ruins/hauntedtradingpost/brainstorming/eureka2
	default_raw_text = "Experimentos iniciais com uma receita totalmente livre de carboidratos indo bem. Testes de gosto são positivos, só preciso de uma maneira de reduzir os custos."

/obj/item/paper/fluff/ruins/hauntedtradingpost/brainstorming/eureka3
	default_raw_text = "Projeto Big Donk<BR>RND tem alguns protótipos preparados.<BR>Os testes estarão completos no final da semana."

/obj/item/paper/fluff/ruins/hauntedtradingpost/rpgclub
	name = "RPG Club"
	default_raw_text = "O RPG Club é toda quinta-feira das 20:00 às 01:00 da manhã. A entrada na sala de descanso é estritamente por convite apenas durante esse período de tempo.<BR> <BR>Pedimos desculpas por qualquer inconveniente."

/obj/item/paper/fluff/ruins/hauntedtradingpost/rpgrules
	name = "GM Notes"
	default_raw_text = "Sessão 4 NPCS<BR>Guerreiros das Sombras<BR>S A T C H<BR> 40 65 40 15 10 <BR><BR>Clã das Sombras<BR>S A T C H<BR> 40 65 40 15 10 <BR>Obtém magia de sombra.<BR><BR><BR>Dire Corgi.<BR>S A T C H<BR> 60 25 65 25 12 <BR><BR>Se eles vencerem isso, eles vão rolar na mesa de saques 4 duas vezes, mas se for 65-70 ou 15-30, faça com que seja botas mágicas."

/obj/item/paper/fluff/ruins/hauntedtradingpost/curatorsnote
	name = "For Adventurers"
	default_raw_text = "A praça de alimentação e as barracas estão seguras, em todos os outros lugares. Há cofres nas barracas e eu não tinha um jeito de abri-los, então se conseguir o que tem dentro, bom para você. A área de funcionários pode ser introduzida seguindo os robôs, mas os sistemas de segurança estão ativos lá atrás. Levei um tiro de uma torre olhando, e quando me costurei e tentei a outra porta, entrei numa armadilha e quase perdi um braço.<BR><BR>Se você está investigando este sinal, tenha cuidado.<BR>Só para constar, eu decidi que nada lá vale o risco. Se for mais corajoso que eu, boa sorte.<BR>Assinado, Curador P."

/obj/item/paper/fluff/ruins/hauntedtradingpost/officememo
	name = "Memo"
	default_raw_text = "O sistema de defesa guiado pela IA permanecerá ativo para proteger a propriedade da empresa. Por favor, certifique-se de que todos os itens pessoais sejam removidos das instalações, pois serão impossíveis de recuperar se esquecidos.<BR><BR>Donk Co. não assume nenhuma responsabilidade por propriedade pessoal perdida ou afeta."

/obj/item/paper/fluff/ruins/hauntedtradingpost/receipt
	name = "Old Receipt"
	desc = "Um velho recibo de vendas impresso em papel térmico barato."
	default_raw_text = "DOnk CO OUTLET 6013<BR>Seu servo de hoje foi:<BR><BR>2x DONKPOCKETPIZBOX 400<BR>1x CRYPTOGRAPHICSEQ 800<BR>2x CRYPTOGRAFICTOY 200<BR>1x DOnkPOCKETPLUSHY 120<BR><BR>VALOR TOTAL 1520<BR><BR>PAGAMENTO:"
	icon_state = "paperslip"

/obj/item/paper/fluff/ruins/hauntedtradingpost/receipt/alternate
	default_raw_text = "DOnk CO OUTLET 6013<BR>Seu servo de hoje foi:<BR><BR>1x DOnkPOCKETBERBOX 200<BR>1x GORLEX MODSUITED 1400<BR>1x MODUITMICROWAVE 200<BR><BR>VALOR TOTAL 1800<BR><BR>PAGAMENTO:"

/obj/item/paper/fluff/ruins/hauntedtradingpost/receipt/alternate_alt
	default_raw_text = "DOnk CO OUTLET 6013<BR>Seu servo de hoje foi:<BR><BR>10xDONKPOCKETORGBOX 2000<BR>4x GORLEX MOUDEU 9600<BR>4x MODUITMICROWAVE 800<BR><BR>VALOR TOTAL 13400<BR><BR>CARTÃO"

/obj/item/paper/fluff/ruins/hauntedtradingpost/nomodsuits
	name = "Notice"
	desc = "Um monte de palavras foram escritas neste papel. Verdadeiramente, este é o futuro."
	default_raw_text = "Estamos sem modsuits."
	icon_state = "paperslip"

/obj/item/paper/fluff/ruins/hauntedtradingpost/oldnote
	name = "Old Note"
	default_raw_text = "Lembre-se de verificar todas as munições antes de serem alimentadas nas torres. Se o calibre errado estiver carregado, as torres vão falhar.<BR>Usamos munição de 9mm."

/obj/item/paper/fluff/ruins/hauntedtradingpost/oldnote/aiclue
	name = "Old Handwritten Note"
	default_raw_text = "Todos os aparelhos estão ligados à IA. Se houver algum problema, informe o representante do Cybersun."

// [Outpost ID Cards]
//ID cards for the space ruin
/obj/item/card/id/away/donk
	name = "\improper Donk Co. ID Card"
	desc = "Um cartão de plástico que identifica seu portador como um empregado da Donk Co. Há chips eletrônicos embutidos para se comunicar com comportas e outras máquinas. Não tem um nome."
	icon_state = "card_donk"
	trim = /datum/id_trim/away/hauntedtradingpost

/obj/item/card/id/away/donk/boss
	desc = "Um cartão de plástico que identifica seu portador como um funcionário sênior da Donk Co. Há chips eletrônicos embutidos para se comunicar com comportas e outras máquinas. Não tem um nome."
	icon_state = "card_donkboss"
	trim = /datum/id_trim/away/hauntedtradingpost/boss

// [Gimmick Treasure]
// loot & weird items that should only exist in hauntedtradingpost.dmm
//aquarium with two donkfish in it
/obj/structure/aquarium/donkfish
	name = "office aquarium"
	desc = "Um lar para peixes cativos. Este tem \"DONK CO\" gravado no vidro."
	init_mode = AQUARIUM_MODE_SAFE

/obj/structure/aquarium/donkfish/Initialize(mapload)
	. = ..()
	new /obj/item/aquarium_prop/rocks(src)
	new /obj/item/aquarium_prop/seaweed(src)
	new /obj/item/fish/donkfish(src)
	new /obj/item/fish/donkfish(src)

//gimmick ketchup bottle for healing minor injuries
/obj/item/reagent_containers/condiment/donksauce
	name = "\improper Donk Co. Secret Sauce"
	desc = "O famoso ketchup com uma receita altamente confidencial."
	list_reagents = list(
		/datum/reagent/consumable/ketchup = 25,
		/datum/reagent/medicine/omnizine = 10,
		/datum/reagent/consumable/astrotame = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/bungojuice = 1,
		/datum/reagent/consumable/curry_powder = 1,
		/datum/reagent/consumable/soymilk = 1,
		/datum/reagent/consumable/tomatojuice = 1,
		/datum/reagent/consumable/vitfro = 1,
	)
	icon_state = "ketchup"
	fill_icon_thresholds = null

// [Hazards & Traps]
//cyborg holobarriers that die when the boss dies, how exciting
#define SELFDESTRUCT_QUEUE "hauntedtradingpost_sd" //make sure it matches the AI cores ID
/obj/structure/holosign/barrier/cyborg/cybersun_ai_shield
	desc = "Um frágil campo de energia holográfica projetado por um núcleo de IA. Mantém humanóides indesejados a uma distância segura."

/obj/structure/holosign/barrier/cyborg/cybersun_ai_shield/Initialize(mapload)
	. = ..()
	if(mapload) //shouldnt queue when we arent even part of a ruin, probably admin shitspawned
		SSqueuelinks.add_to_queue(src, SELFDESTRUCT_QUEUE)

//smes that produces power, until the boss dies then it self destructs and you gotta make your own power
/obj/machinery/power/smes/magical/cybersun
	name = "cybersun-brand power storage unit"
	desc = "Uma unidade supercondutora de alta capacidade de armazenamento de energia magnética. Parece com qualquer outra unidade SMES, exceto esta que diz \"Cybersun\"."
	//is this being used as part of the haunted trading post ruin? if true, will self destruct when boss dies
	var/donk_ai_slave = FALSE

/obj/machinery/power/smes/magical/cybersun/Initialize(mapload)
	. = ..()
	if(donk_ai_slave)
		SSqueuelinks.add_to_queue(src, SELFDESTRUCT_QUEUE)

//this is a trigger for traps involving doors and shutters
//doors get closed and bolted, shutters get cycled open/closed
/obj/machinery/button/door/invisible_tripwire
	name = "Sonic Tripwire"
	desc = "Um gatilho invisível para persianas e portas. Aciona quando alguém pisa no azulejo."
	max_integrity = 50
	invisibility = INVISIBILITY_ABSTRACT
	anchored = TRUE
	//is this being used as part of the haunted trading post ruin? if true, will self destruct when boss dies
	var/donk_ai_slave = FALSE
	//can the trap trigger more than once?
	var/multiuse = FALSE
	//(if multiuse) how many times the trap can trigger. 0 or lower is infinite
	var/uses_remaining = 0
	//if true, the trap will unbolt all doors it bolted and cycle shutters a second time after a delay
	var/resets_self = FALSE
	//time before resets_self kicks in
	var/reset_timer = 1.8 SECONDS
	//when multiple tripwires are in the same suicide pact, they will all die when any of them die
	var/suicide_pact = FALSE
	//id of the suicide pact this tripwire is in
	var/suicide_pact_id

/obj/machinery/button/door/invisible_tripwire/Initialize(mapload)
	. = ..()
	if(donk_ai_slave)
		SSqueuelinks.add_to_queue(src, SELFDESTRUCT_QUEUE)
	if(suicide_pact && suicide_pact_id != null)
		SSqueuelinks.add_to_queue(src, suicide_pact_id)
		. = INITIALIZE_HINT_LATELOAD
	var/static/list/loc_connections = list(
	COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/machinery/button/door/invisible_tripwire/find_and_mount_on_atom(mark_for_late_init, late_init)
	return //these exist independently on an turf

/obj/machinery/button/door/invisible_tripwire/post_machine_initialize()
	. = ..()
	if(!suicide_pact || isnull(SSqueuelinks.queues[suicide_pact_id]))
		return // we got beat to it
	SSqueuelinks.pop_link(suicide_pact_id)

/obj/machinery/button/door/invisible_tripwire/MatchedLinks(id, list/partners)
	if(id != suicide_pact_id)
		return
	for(var/partner in partners)
		RegisterSignal(partner, COMSIG_PUZZLE_COMPLETED, TYPE_PROC_REF(/datum, selfdelete))

/obj/machinery/button/door/invisible_tripwire/proc/on_entered(atom/source, atom/movable/victim)
	SIGNAL_HANDLER
	if(!isliving(victim))
		return
	var/mob/living/target = victim
	if(target.stat != DEAD && target.mob_size == MOB_SIZE_HUMAN && target.mob_biotypes != MOB_ROBOTIC)
		tripwire_triggered(target)
		if(multiuse && uses_remaining < 1)
			uses_remaining--
		if(resets_self)
			addtimer(CALLBACK(src, PROC_REF(tripwire_triggered), victim), reset_timer)

/obj/machinery/button/door/invisible_tripwire/proc/tripwire_triggered(atom/victim)
	INVOKE_ASYNC(src, TYPE_PROC_REF(/atom, interact), victim)
	if(multiuse && uses_remaining != 1)
		return
	if(suicide_pact && suicide_pact_id)
		SEND_SIGNAL(src, COMSIG_PUZZLE_COMPLETED)
	qdel(src)

//door button that destroys itself when it is pressed
/obj/machinery/button/door/selfdestructs
	icon_state= "button-warning"
	skin = "-warning"

/obj/machinery/button/door/selfdestructs/attempt_press(mob/user)
	. = ..()
	do_sparks(rand(1,3), src)
	playsound(src, SFX_SPARKS, 100, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	qdel(src)

//trap that gloms onto the first machine it finds on its tile, and lives inside it
//then it zaps everyone who gets close. disarm by dissassembling the machine, or running out its charges
/obj/effect/overloader_trap
	name = "overloader trap"
	desc = "Uma armadilha que sobrecarrega máquinas para eletrificar pessoas que andam por perto."
	alpha = 70
	max_integrity = 50
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	icon = 'icons/effects/effects.dmi'
	icon_state = "empdisable"
	//trap won't damage mobs in its faction. set this to null to make it attack everyone
	faction = list(ROLE_SYNDICATE)
	invisibility = INVISIBILITY_ABSTRACT
	plane = ABOVE_GAME_PLANE
	//datum we use to trigger when someones close
	var/datum/proximity_monitor/proximity_monitor
	// how close someone has to be to set the trap off
	var/trigger_range = 1
	// max range the trap can zap someone
	var/shock_range = 1
	/// damage from getting zapped by this trap
	var/shock_damage = 35
	// length of time target spends stunned
	var/stun_duration = 1.5 SECONDS
	// length of time targets spend jittery
	var/jitter_time = 5 SECONDS
	// length of time targets stutter
	var/stutter_time = 2 SECONDS
	//is this being used as part of the haunted trading post ruin? if true, will self destruct when boss dies
	var/donk_ai_slave = FALSE
	// machine that the trap inhabits
	var/obj/machinery/host_machine
	// turf that the trap is on
	var/turf/my_turf
	//how long until trap zaps everything, after it detects something
	var/trigger_delay = 0.7 SECONDS
	COOLDOWN_DECLARE(trigger_cooldown)
	//time until trap can be triggered again
	var/trigger_cooldown_duration = 4 SECONDS
	//max amount of times the trap can trigger
	var/uses_remaining = 4
	//amount of damage the trap does to the machine its on, when its triggered
	//this can kill the machine and if it does, the trap effectively disarms itself
	//so acts as a soft cap of sorts on number of trap activations
	var/machine_overload_damage = 80 //machine integrity is usually 200 or 300

/obj/effect/overloader_trap/Initialize(mapload)
	. = ..()
	proximity_monitor = new(src, 0)
	proximity_monitor?.set_range(trigger_range)
	my_turf = get_turf(src)
	host_machine = locate(/obj/machinery) in loc
	if(donk_ai_slave)
		SSqueuelinks.add_to_queue(src, SELFDESTRUCT_QUEUE)

/obj/effect/overloader_trap/HasProximity(mob/living/target as mob)
	if(!locate(host_machine) in loc) //muh machine's gone, delete myself because im disarmed
		qdel(src)
		return
	if(!isliving(target))
		return
	if(!COOLDOWN_FINISHED(src, trigger_cooldown)) //do nothing if we're on cooldown
		return
	if(uses_remaining == 0) //deletes trap if it triggers when it has no uses left. should only happen if var edited but lets just be safe
		qdel(src)
		return
	if (target.stat) //ensure the guy triggering us is alive
		return
	if (!faction_check_atom(target)) //and make sure it ain't someone on our team
		COOLDOWN_START(src, trigger_cooldown, 4 SECONDS)
		trap_alerted()

/obj/effect/overloader_trap/proc/trap_alerted()
	if(host_machine in loc) //if someone breaks or moves the machine before the trap goes off, this should fail to do anything
		visible_message(span_boldwarning("As faíscas voam de[host_machine]como ela treme vigorosamente!"))
		do_sparks(number = 3, source = host_machine)
		host_machine.Shake(2, 1, trigger_delay)
		addtimer(CALLBACK(src, PROC_REF(trap_effect)), trigger_delay)

/obj/effect/overloader_trap/proc/trap_effect()
	for(var/mob/living/living_mob in range(shock_range, src))
		if(faction_check_atom(living_mob))
			continue
		to_chat(living_mob, span_warning("Você é atingido por um arco de eletricidade!"))
		src.Beam(living_mob, icon_state = "lightning[rand(1,12)]", time = 0.5 SECONDS)
		living_mob.electrocute_act(shock_damage, host_machine, 1, SHOCK_NOGLOVES, stun_duration, jitter_time, stutter_time)
	for(var/obj/item/food/deadmouse in range(shock_range, src))
		src.Beam(deadmouse, icon_state = "lightning[rand(1,12)]", time = 0.5 SECONDS)
	do_sparks(number = 1, source = host_machine)
	host_machine.take_damage(machine_overload_damage, sound_effect = FALSE)
	uses_remaining--
	if(uses_remaining <= 0)
		qdel(src)

// [Custom Turrets]
//these are the non-mob defenders of the hauntedtradingpost.dmm ruin
//they are controlled with a syndicate ID and are hostile to anything non-syndicate by default

//donk turret - 9mm
/obj/machinery/porta_turret/syndicate/donk
	//Medium speed, medium damage, fragile. Does brute damage.
	name = "\improper Donk Co. Defense Turret"
	icon_state = "donk_lethal"
	max_integrity = 120
	base_icon_state = "donk"
	stun_projectile = /obj/projectile/bullet/foam_dart/riot
	lethal_projectile = /obj/projectile/bullet/c9mm/blunttip
	lethal_projectile_sound = 'sound/items/weapons/gun/pistol/shot.ogg'
	stun_projectile_sound = 'sound/items/weapons/gun/pistol/shot.ogg'
	desc = "Uma metralhadora balística com marca Donk Co.. Usa balas de 9mm."
	armor_type = /datum/armor/donk_turret
	scan_range = 6
	shot_delay = 1 SECONDS

/datum/armor/donk_turret
	melee = 20
	bullet = 20
	laser = 40
	energy = 40
	bomb = 20
	fire = 50
	acid = 100

/obj/projectile/bullet/c9mm/blunttip
	wound_bonus = -40 //this will still cause bleeding wounds, but less often.

//cybersun turret - plasma beam
/obj/machinery/porta_turret/syndicate/energy/cybersun
	//Slow speed, high damage. Does burn damage.
	name = "\improper Cybersun Plasma Auto-turret"
	icon_state = "red_lethal"
	base_icon_state = "red"
	stun_projectile = /obj/projectile/energy/electrode
	stun_projectile_sound = 'sound/items/weapons/taser.ogg'
	lethal_projectile = /obj/projectile/beam/laser/cybersun
	lethal_projectile_sound = 'sound/items/weapons/lasercannonfire.ogg'
	desc = "Uma arma de energia automática com marca Cybersun. Dispara feixes de plasma de alta energia que causam muitos danos, mas pode ser bastante lento."
	armor_type = /datum/armor/syndicate_shuttle
	scan_range = 6
	shot_delay = 5 SECONDS
	always_up = FALSE
	has_cover = TRUE

/obj/projectile/beam/laser/cybersun
	name = "plasma beam"
	desc = "Um grande feixe de plasma vermelho, atualmente em voo."
	icon_state = "lava"
	light_color = COLOR_DARK_RED
	damage = 30
	wound_bonus = -50

#undef SELFDESTRUCT_QUEUE
