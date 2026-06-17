/**
 * # Fluff structure
 *
 * Fluff structures serve no purpose and exist only for enriching the environment. By default, they can be deconstructed with a wrench.
 */
/obj/structure/fluff
	name = "fluff structure"
	desc = "Mais macio que uma ovelha. Isso não deveria existir."
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "minibar"
	anchored = TRUE
	density = FALSE
	opacity = FALSE
	///If true, the structure can be deconstructed into a metal sheet with a wrench.
	var/deconstructible = TRUE

/obj/structure/fluff/attackby(obj/item/I, mob/living/user, list/modifiers, list/attack_modifiers)
	if(I.tool_behaviour == TOOL_WRENCH && deconstructible)
		user.visible_message(span_notice("[user] starts disassembling [src]..."), span_notice("You start disassembling [src]..."))
		I.play_tool_sound(src)
		if(I.use_tool(src, user, 50))
			user.visible_message(span_notice("[user] disassembles [src]!"), span_notice("You break down [src] into scrap metal."))
			playsound(user, 'sound/items/deconstruct.ogg', 50, TRUE)
			new/obj/item/stack/sheet/iron(drop_location())
			qdel(src)
		return
	..()

/**
 * Empty terrariums are created when a preserved terrarium in a lavaland seed vault is activated.
 */
/obj/structure/fluff/empty_terrarium
	name = "empty terrarium"
	desc = "Uma máquina antiga que parece ser usada para armazenar matéria vegetal. A escotilha está aberta."
	icon = 'icons/obj/mining_zones/spawners.dmi'
	icon_state = "terrarium_open"
	density = TRUE

/**
 * Empty sleepers are created by a good few ghost roles in lavaland.
 */
/obj/structure/fluff/empty_sleeper
	name = "empty sleeper"
	desc = "Um dorminhoco aberto. Parece que estaria esperando outro paciente, se não estivesse quebrado."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper-open"

/obj/structure/fluff/empty_sleeper/nanotrasen
	name = "broken hypersleep chamber"
	desc = "Uma câmara hiper-sono de Nanotrasen - esta parece quebrada.\
Há parafusos expostos para desmontar facilmente usando uma chave inglesa."
	icon_state = "sleeper-o"

/obj/structure/fluff/empty_sleeper/syndicate
	icon_state = "sleeper_s-open"

/**
 * Empty cryostasis sleepers are created when a malfunctioning cryostasis sleeper in a lavaland shelter is activated.
 */
/obj/structure/fluff/empty_cryostasis_sleeper
	name = "empty cryostasis sleeper"
	desc = "Embora confortável, este dorminhoco não funcionará como nada além de uma cama nunca mais."
	icon = 'icons/obj/mining_zones/spawners.dmi'
	icon_state = "cryostasis_sleeper_open"

/**
 * Ash drake status spawn on either side of the necropolis gate in lavaland.
 */
/obj/structure/fluff/drake_statue
	name = "drake statue"
	desc = "Uma escultura de basalto de um orgulhoso e real Drake. Seus olhos são seis pedras preciosas brilhantes."
	icon = 'icons/effects/64x64.dmi'
	icon_state = "drake_statue"
	pixel_x = -16
	maptext_height = 64
	maptext_width = 64
	density = TRUE
	deconstructible = FALSE
	layer = EDGED_TURF_LAYER

/**
 * shower drain placed usually under showers just so it looks like something picks the water up.
 */
/obj/structure/fluff/shower_drain
	name = "shower drain"
	desc = "Acho que vi uma bola de cabelo."
	icon = 'icons/obj/mining_zones/survival_pod.dmi'
	icon_state = "fan_tiny"
	plane = FLOOR_PLANE
	layer = BELOW_CATWALK_LAYER

/**
 * A variety of statue in disrepair; parts are broken off and a gemstone is missing
 */
/obj/structure/fluff/drake_statue/falling
	desc = "Uma escultura de basalto de um Drake. As rachaduras descem pela superfície e partes dela caem."
	icon_state = "drake_statue_falling"


/obj/structure/fluff/bus
	name = "bus"
	desc = "Vá para a escola. Leia um livro."
	icon = 'icons/obj/fluff/bus.dmi'
	icon_state = null
	density = TRUE
	anchored = TRUE
	deconstructible = FALSE

/obj/structure/fluff/bus/dense
	name = "bus"
	icon_state = "backwall"

/obj/structure/fluff/bus/passable
	name = "bus"
	icon_state = "frontwalltop"
	density = FALSE
	layer = ABOVE_ALL_MOB_LAYER //except for the stairs tile, which should be set to OBJ_LAYER aka 3.
	plane = ABOVE_GAME_PLANE


/obj/structure/fluff/bus/passable/seat
	name = "seat"
	desc = "Apertem o cinto! Como assim, sem cintos?"
	icon_state = "backseat"
	pixel_y = 17
	layer = OBJ_LAYER
	plane = GAME_PLANE


/obj/structure/fluff/bus/passable/seat/driver
	name = "driver's seat"
	desc = "Jesus do Espaço é meu copiloto."
	icon_state = "driverseat"

/obj/structure/fluff/bus/passable/seat/driver/attack_hand(mob/user, list/modifiers)
	playsound(src, 'sound/items/carhorn.ogg', 50, TRUE)
	. = ..()

/obj/structure/fluff/paper
	name = "dense lining of papers"
	desc = "Um forro de papel espalhado pelo fundo de uma parede."
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "paper"
	deconstructible = FALSE

/obj/structure/fluff/paper/corner
	icon_state = "papercorner"

/obj/structure/fluff/paper/stack
	name = "dense stack of papers"
	desc = "Uma pilha de vários papéis, rabiscos infantis espalhados por cada página."
	icon_state = "paperstack"


/obj/structure/fluff/divine
	name = "Miracle"
	icon = 'icons/obj/service/hand_of_god_structures.dmi'
	icon_state = "error"
	anchored = TRUE
	density = TRUE

/obj/structure/fluff/divine/nexus
	name = "nexus"
	desc = "Ele ancora uma divindade neste mundo. Ele irradia uma aura incomum. Parece bem protegido de choque explosivo."
	icon_state = "nexus"

/obj/structure/fluff/divine/conduit
	name = "conduit"
	desc = "Permite que uma divindade estenda seu alcance. Seus poderes são tão potentes quanto um nexo."
	icon_state = "conduit"

/obj/structure/fluff/divine/convertaltar
	name = "conversion altar"
	desc = "Um altar dedicado a uma divindade."
	icon_state = "convertaltar"
	density = FALSE
	can_buckle = 1

/obj/structure/fluff/divine/powerpylon
	name = "power pylon"
	desc = "Um pilar que aumenta a taxa da divindade pode influenciar o mundo."
	icon_state = "powerpylon"
	can_buckle = 1

/obj/structure/fluff/divine/defensepylon
	name = "defense pylon"
	desc = "Um pilão que é abençoado para resistir a muitos golpes, e atirar parafusos fortes em incrédulos. Um deus pode mudar isso."
	icon_state = "defensepylon"

/obj/structure/fluff/divine/shrine
	name = "shrine"
	desc = "Um santuário dedicado a uma divindade."
	icon_state = "shrine"

/obj/structure/fluff/fokoff_sign
	name = "crude sign"
	desc = "Um sinal feito com as palavras \"fok\" escrito em algum tipo de tinta vermelha."
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "fokof"

/obj/structure/fluff/big_chain
	name = "giant chain"
	desc = "Uma enorme ligação de correntes que leva ao teto."
	icon = 'icons/effects/32x96.dmi'
	icon_state = "chain"
	anchored = TRUE
	density = TRUE
	deconstructible = FALSE
	layer = ABOVE_ALL_MOB_LAYER
	plane = ABOVE_GAME_PLANE

/obj/structure/fluff/beach_towel
	name = "beach towel"
	desc = "Uma toalha decorada com vários desenhos de praia."
	icon = 'icons/obj/railings.dmi'
	icon_state = "railing"
	density = FALSE
	anchored = TRUE
	deconstructible = FALSE

/obj/structure/fluff/beach_umbrella
	name = "beach umbrella"
	desc = "Um guarda-chuva chique projetado para manter o sol longe da praia."
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "brella"
	density = FALSE
	anchored = TRUE
	deconstructible = FALSE

/obj/structure/fluff/beach_umbrella/security
	icon_state = "hos_brella"

/obj/structure/fluff/beach_umbrella/science
	icon_state = "rd_brella"

/obj/structure/fluff/beach_umbrella/engine
	icon_state = "ce_brella"

/obj/structure/fluff/beach_umbrella/cap
	icon_state = "cap_brella"

/obj/structure/fluff/beach_umbrella/syndi
	icon_state = "syndi_brella"

/obj/structure/fluff/clockwork
	name = "Clockwork Fluff"
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "error"
	deconstructible = FALSE

/obj/structure/fluff/clockwork/alloy_shards
	name = "replicant alloy shards"
	desc = "Cacos quebrados de metal maleável. Eles ocasionalmente se movem e parecem brilhar."
	icon_state = "alloy_shards"

/obj/structure/fluff/clockwork/alloy_shards/small
	icon_state = "shard_small1"

/obj/structure/fluff/clockwork/alloy_shards/medium
	icon_state = "shard_medium1"

/obj/structure/fluff/clockwork/alloy_shards/medium_gearbit
	icon_state = "gear_bit1"

/obj/structure/fluff/clockwork/alloy_shards/large
	icon_state = "shard_large1"

/obj/structure/fluff/clockwork/blind_eye
	name = "blind eye"
	desc = "Um olho de bronze pesado, sua íris vermelha caiu escuro."
	icon_state = "blind_eye"

/obj/structure/fluff/clockwork/fallen_armor
	name = "fallen armor"
	desc = "Pedaços de armadura sem vida. Eles são projetados de uma forma estranha e não cabem em você."
	icon_state = "fallen_armor"

/obj/structure/fluff/clockwork/clockgolem_remains
	name = "clockwork golem scrap"
	desc = "Uma pilha de sucata. Parece danificado sem conserto."
	icon_state = "clockgolem_dead"

/obj/structure/fluff/tram_rail
	name = "tram rail"
	desc = "Ótimo para bondes, não tão bom para patinar."
	icon = 'icons/obj/tram/tram_rails.dmi'
	icon_state = "rail"
	layer = TRAM_RAIL_LAYER
	plane = FLOOR_PLANE
	resistance_flags =  INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	deconstructible = FALSE
	can_buckle = TRUE
	buckle_requires_restraints = TRUE
	buckle_lying = 90

/obj/structure/fluff/tram_rail/post_buckle_mob(mob/living/target)
	. = ..()
	target.pixel_y += dir == SOUTH ? -3 : 14
	RegisterSignal(target, COMSIG_LIVING_HIT_BY_TRAM, PROC_REF(on_buckled_tram_smashed))

/obj/structure/fluff/tram_rail/post_unbuckle_mob(mob/living/target)
	. = ..()
	target.pixel_y -= dir == SOUTH ? -3 : 14
	UnregisterSignal(target, COMSIG_LIVING_HIT_BY_TRAM)

/// If someone gets hit by the tram while buckled to us (mission accomplished) unbuckle them so that they can fly away
/// Also we rip one of their arms off to "uncuff" them
/obj/structure/fluff/tram_rail/proc/on_buckled_tram_smashed(mob/living/smashed)
	SIGNAL_HANDLER
	unbuckle_mob(smashed, force = TRUE, can_fall = FALSE) // Make sure they don't fall down a z-level until they've been thrown

/obj/structure/fluff/tram_rail/floor
	name = "tram rail protective cover"
	icon_state = "rail_floor"

/obj/structure/fluff/tram_rail/end
	icon_state = "railend"

/obj/structure/fluff/tram_rail/anchor
	name = "tram rail anchor"
	icon_state = "anchor"

/obj/structure/fluff/tram_rail/electric
	desc = "Ótimo para bondes, não tão bom para patinar. Este é um trilho de força."
	/// What power channel from the APC do we check for power?
	var/power_channel = AREA_USAGE_ENVIRON

/obj/structure/fluff/tram_rail/electric/anchor
	name = "tram rail anchor"
	icon_state = "anchor"

/obj/structure/fluff/tram_rail/electric/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/electrified_buckle,\
		input_requirements = SHOCK_REQUIREMENT_AREA_POWER,\
		shock_immediately = TRUE,\
		print_message = FALSE,\
		damage_on_shock = 5,\
		loop_length = 8 SECONDS,\
		area_power_channel = power_channel,\
		shock_flags = SHOCK_NOSTUN\
	)

/obj/structure/fluff/tram_rail/electric/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	var/area/our_area = get_area(src)
	if(our_area?.powered(power_channel) && user.electrocute_act(75, src))
		do_sparks(5, TRUE, src)

/obj/structure/fluff/broken_canister_frame
	name = "broken canister frame"
	desc = "Uma lata rasgada. Parece que algum metal pode ser recuperado com uma chave inglesa."
	icon_state = "broken_canister"
	anchored = FALSE
	density = TRUE
	deconstructible = TRUE

/obj/structure/fluff/wallsign
	name = "direction sign"
	desc = "Agora, para onde ir?"
	density = FALSE
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "wallsign"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/fluff/wallsign, 32)
