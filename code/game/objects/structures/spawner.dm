/obj/structure/spawner
	name = "monster nest"
	icon = 'icons/mob/simple/animal.dmi'
	icon_state = "hole"
	max_integrity = 100

	move_resist = MOVE_FORCE_EXTREMELY_STRONG
	anchored = TRUE
	density = TRUE

	faction = list(FACTION_HOSTILE)

	var/max_mobs = 5
	var/spawn_time = 30 SECONDS
	var/mob_types = list(/mob/living/basic/carp)
	var/spawn_text = "emerges from"
	var/spawner_type = /datum/component/spawner
	/// Is this spawner taggable with something?
	var/scanner_taggable = FALSE
	/// If this spawner's taggable, what can we tag it with?
	var/static/list/scanner_types = list(/obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner)
	/// If this spawner's taggable, what's the text we use to describe what we can tag it with?
	var/scanner_descriptor = "mining analyzer"
	/// Has this spawner been tagged/analyzed by a mining scanner?
	var/gps_tagged = FALSE
	/// A short identifier for the mob it spawns. Keep around 3 characters or less?
	var/mob_gps_id = "???"
	/// A short identifier for what kind of spawner it is, for use in putting together its GPS tag.
	var/spawner_gps_id = "Creature Nest"
	/// A complete identifier. Generated on tag (if tagged), used for its examine.
	var/assigned_tag

/obj/structure/spawner/examine(mob/user)
	. = ..()
	if(!scanner_taggable)
		return
	if(gps_tagged)
		. += span_notice("Um holotag foi anexado, projetando\"<b>[assigned_tag]</b>\".")
	else
		. += span_notice("Parece que você poderia escanear e marcar com um<b>[scanner_descriptor]</b>.")

/obj/structure/spawner/attackby(obj/item/item, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(.)
		return TRUE
	if(scanner_taggable && is_type_in_list(item, scanner_types))
		gps_tag(user)
		return TRUE

/// Tag the spawner, prefixing its GPS entry with an identifier - or giving it one, if nonexistent.
/obj/structure/spawner/proc/gps_tag(mob/user)
	if(gps_tagged)
		to_chat(user, span_warning("[src]Já tem uma holotag anexada!"))
		return
	to_chat(user, span_notice("Você coloca uma holotag em[src]."))
	playsound(src, 'sound/machines/beep/twobeep.ogg', 100)
	gps_tagged = TRUE
	assigned_tag = "\[[mob_gps_id]-[rand(100,999)]\] " + spawner_gps_id
	var/datum/component/gps/our_gps = GetComponent(/datum/component/gps)
	if(our_gps)
		our_gps.gpstag = assigned_tag
		return
	AddComponent(/datum/component/gps, assigned_tag)

/obj/structure/spawner/Initialize(mapload)
	. = ..()
	AddComponent(		spawner_type, 		spawn_types = mob_types, 		spawn_time = spawn_time, 		max_spawned = max_mobs, 		faction = faction, 		spawn_text = spawn_text,		spawn_callback = CALLBACK(src, PROC_REF(on_mob_spawn)), 		initial_spawn_delay = !mapload, 	)

/obj/structure/spawner/attack_animal(mob/living/simple_animal/user, list/modifiers)
	if(faction_check_atom(user) && !user.client)
		return
	return ..()

/obj/structure/spawner/proc/on_mob_spawn(atom/created_atom)
	return

/obj/structure/spawner/syndicate
	name = "warp beacon"
	icon = 'icons/obj/machines/beacon.dmi'
	icon_state = "syndbeacon"
	spawn_text = "Deformações de"
	mob_types = list(/mob/living/basic/trooper/syndicate/ranged)
	faction = list(ROLE_SYNDICATE)
	mob_gps_id = "SYN" // syndicate
	spawner_gps_id = "Hostile Warp Beacon"

/obj/structure/spawner/skeleton
	name = "bone pit"
	desc = "Um poço cheio de ossos, e alguns ainda parecem estar se movendo..."
	icon_state = "hole"
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	max_integrity = 150
	max_mobs = 15
	spawn_time = 15 SECONDS
	mob_types = list(/mob/living/basic/skeleton)
	spawn_text = "Subindo para fora"
	faction = list(FACTION_SKELETON)
	mob_gps_id = "SKL" // skeletons
	spawner_gps_id = "Bone Pit"

/obj/structure/spawner/clown
	name = "Laughing Larry"
	desc = "Uma figura jovial. Algo parece preso na garganta dele."
	icon_state = "clownbeacon"
	icon = 'icons/obj/machines/beacon.dmi'
	max_integrity = 200
	max_mobs = 15
	spawn_time = 15 SECONDS
	mob_types = list(
		/mob/living/basic/clown,
		/mob/living/basic/clown/banana,
		/mob/living/basic/clown/clownhulk,
		/mob/living/basic/clown/clownhulk/chlown,
		/mob/living/basic/clown/clownhulk/honkmunculus,
		/mob/living/basic/clown/fleshclown,
		/mob/living/basic/clown/mutant/glutton,
		/mob/living/basic/clown/honkling,
		/mob/living/basic/clown/longface,
		/mob/living/basic/clown/lube,
	)
	spawn_text = "Subindo para fora"
	faction = list(FACTION_CLOWN)
	mob_gps_id = "???" // clowns
	spawner_gps_id = "Clown Planet Distortion"

/obj/structure/spawner/mining
	name = "monster den"
	desc = "Um buraco escavado no chão, abrigando todos os tipos de monstros encontrados na maioria das cavernas ou minerando asteróides."
	icon_state = "hole"
	max_integrity = 200
	max_mobs = 3
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	spawn_text = "Rasteja para fora"
	mob_types = list(
		/mob/living/basic/mining/basilisk,
		/mob/living/basic/mining/goldgrub,
		/mob/living/basic/mining/goliath/ancient,
		/mob/living/basic/mining/hivelord,
		/mob/living/basic/wumborian_fugu,
	)
	faction = list(FACTION_MINING)

/obj/structure/spawner/mining/goldgrub
	name = "goldgrub den"
	desc = "Um covil abrigando um ninho de dourados, irritante, mas indiscutivelmente muito melhor do que qualquer outra coisa que você encontrará em um ninho."
	mob_types = list(/mob/living/basic/mining/goldgrub)
	mob_gps_id = "GG"

/obj/structure/spawner/mining/goliath
	name = "goliath den"
	desc = "Um covil abrigando um ninho de golias, por quê?"
	mob_types = list(/mob/living/basic/mining/goliath/ancient)
	mob_gps_id = "GL|A"

/obj/structure/spawner/mining/hivelord
	name = "hivelord den"
	desc = "Uma toca abrindo um ninho de colmeias."
	mob_types = list(/mob/living/basic/mining/hivelord)
	mob_gps_id = "HL"

/obj/structure/spawner/mining/basilisk
	name = "basilisk den"
	desc = "Uma toca abrindo um ninho de basilisks, traga um casaco."
	mob_types = list(/mob/living/basic/mining/basilisk)
	mob_gps_id = "BK"

/obj/structure/spawner/mining/wumborian
	name = "wumborian fugu den"
	desc = "Uma toca abrigando um ninho de fugus wumborianos, como eles se encaixam lá?"
	mob_types = list(/mob/living/basic/wumborian_fugu)
	mob_gps_id = "WF"

/obj/structure/spawner/nether
	name = "netherworld link"
	desc = null //see examine()
	icon_state = "nether"
	max_integrity = 50
	spawn_time = 60 SECONDS
	max_mobs = 15
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	spawn_text = "Rasteja através"
	mob_types = list(
		/mob/living/basic/blankbody,
		/mob/living/basic/creature,
		/mob/living/basic/migo,
	)
	faction = list(FACTION_NETHER)
	scanner_taggable = TRUE
	mob_gps_id = "?!?"
	spawner_gps_id = "Netheric Distortion"

/obj/structure/spawner/nether/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSprocessing, src)

/obj/structure/spawner/nether/examine(mob/user)
	. = ..()
	if(isskeleton(user) || iszombie(user))
		. += "A direct link to another dimension full of creatures very happy to see you. [span_nicegreen("You can see your house from here!")]"
	else
		. += "A direct link to another dimension full of creatures not very happy to see you. [span_warning("Entering the link would be a very bad idea.")]"

/obj/structure/spawner/nether/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(isskeleton(user) || iszombie(user))
		to_chat(user, span_notice("Você não quer ir para casa ainda..."))
	else
		user.visible_message(span_warning("[user]é violentamente puxado para o link!"), 							span_userdanger("Ao tocar o portal, você é rapidamente puxado para um mundo de horror inimaginável!"))
		contents.Add(user)

/obj/structure/spawner/nether/process(seconds_per_tick)
	for(var/mob/living/living_mob in contents)
		playsound(src, 'sound/effects/magic/demon_consume.ogg', 50, TRUE)
		living_mob.adjust_brute_loss(60 * seconds_per_tick)
		new /obj/effect/gibspawner/generic(get_turf(living_mob), living_mob)
		if(living_mob.stat == DEAD)
			var/mob/living/basic/blankbody/newmob = new(loc)
			newmob.name = "[living_mob]"
			newmob.desc = "It's [living_mob], but [living_mob.p_their()] flesh has an ashy texture, and [living_mob.p_their()] face is featureless save an eerie smile."
			src.visible_message(span_warning("[living_mob]Reemerges da ligação!"))
			qdel(living_mob)

/obj/structure/spawner/sentient
	var/role_name = "A sentient mob"
	var/assumed_control_message = "You are a sentient mob from a badly coded spawner"

/obj/structure/spawner/sentient/Initialize(mapload)
	. = ..()
	notify_ghosts(
		"A [name] has been created in \the [get_area(src)]!",
		source = src,
		header = "Senciente Spawner Criado",
		notify_flags = NOTIFY_CATEGORY_NOFLASH,
	)

/obj/structure/spawner/sentient/on_mob_spawn(atom/created_atom)
	created_atom.AddComponent(		/datum/component/ghost_direct_control,		role_name = src.role_name,		assumed_control_message = src.assumed_control_message,		after_assumed_control = CALLBACK(src, PROC_REF(became_player_controlled)),	)

/obj/structure/spawner/sentient/proc/became_player_controlled(mob/proteon)
	return

/obj/structure/spawner/sentient/proteon_spawner
	name = "eldritch gateway"
	desc = "Uma estrutura vertiginosa que de alguma forma se liga ao domínio de Nar'Sie. Os gritos do maldito eco continuamente."
	icon = 'icons/obj/antags/cult/structures.dmi'
	icon_state = "hole"
	light_power = 2
	light_color = COLOR_CULT_RED
	max_integrity = 50
	density = FALSE
	max_mobs = 2
	spawn_time = 15 SECONDS
	mob_types = list(/mob/living/basic/construct/proteon/hostile)
	spawn_text = "pico de"
	faction = list(FACTION_CULT)
	role_name = "A proteon cult construct"
	assumed_control_message = null

/obj/structure/spawner/sentient/proteon_spawner/examine_status(mob/user)
	if(IS_CULTIST(user) || !isliving(user))
		return span_cult("Está em<b>[round(atom_integrity * 100 / max_integrity)]%</b>Estabilidade.")
	return ..()

/obj/structure/spawner/sentient/proteon_spawner/examine(mob/user)
	. = ..()
	if(!IS_CULTIST(user) && isliving(user))
		var/mob/living/living_user = user
		living_user.adjust_organ_loss(ORGAN_SLOT_BRAIN, 15)
		. += span_danger("As vozes do maldito eco incansavelmente em sua mente, constantemente rebobinando nas paredes de seu eu quanto mais você se concentrar em[src]Seus quilos da cabeça, melhor ficar longe...")
	else
		. += span_cult("O portal criará um proteon fraco construir cada[spawn_time * 0.1]segundos, até um total de[max_mobs], que pode ser controlado pelos espíritos dos mortos.")

/obj/structure/spawner/sentient/proteon_spawner/became_player_controlled(mob/living/basic/construct/proteon/proteon)
	proteon.mind.add_antag_datum(/datum/antagonist/cult)
	proteon.add_filter("awoken_proteon", 3, list("type" = "outline", "color" = COLOR_CULT_RED, "size" = 2))
	visible_message(span_cult_bold("[proteon]Desperta, brilhando um vermelho assutador se agito de seu estupor!"))
	playsound(proteon, 'sound/items/haunted/ghostitemattack.ogg', 100, TRUE)
	proteon.balloon_alert_to_viewers("awoken!")
	addtimer(CALLBACK(src, PROC_REF(remove_wake_outline), proteon), 8 SECONDS)

/obj/structure/spawner/sentient/proteon_spawner/proc/remove_wake_outline(mob/proteon)
	proteon.remove_filter("awoken_proteon")
	proteon.add_filter("sentient_proteon", 3, list("type" = "outline", "color" = COLOR_CULT_RED, "size" = 2, "alpha" = 40))

/obj/structure/spawner/sentient/proteon_spawner/handle_deconstruct(disassembled)
	playsound(src, 'sound/effects/hallucinations/veryfar_noise.ogg', 75)
	visible_message(span_cult_bold("[src]completamente desmoronou, os gritos dos condenados alcançando um passo febril antes de lentamente desaparecer em nada."))
