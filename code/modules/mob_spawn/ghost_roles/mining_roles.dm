
//lava hermit

//Malfunctioning cryostasis sleepers: Spawns in makeshift shelters in lavaland. Ghosts become hermits with knowledge of how they got to where they are now.
/obj/effect/mob_spawn/ghost_role/human/hermit
	name = "malfunctioning cryostasis sleeper"
	desc = "Um dorminhoco com um ocupante silhueta dentro. Sua função de estase está quebrada e provavelmente está sendo usada como cama."
	prompt_name = "um eremita encalhado"
	icon = 'icons/obj/mining_zones/spawners.dmi'
	icon_state = "cryostasis_sleeper"
	outfit = /datum/outfit/hermit
	you_are_text = "Você está preso nesta prisão sem Deus de um planeta há mais tempo do que se lembra."
	flavour_text = "A cada dia que passa, e entre as terríveis condições de seu abrigo improvisado, as criaturas hostis, e as cinzas dos Drakes descendo dos céus nublados, tudo que você pode desejar é a sensação de grama macia entre seus dedos dos pés e o ar fresco da Terra. Esses pensamentos são dissipados por mais uma lembrança de como você chegou aqui..."
	spawner_job_path = /datum/job/hermit
	allow_custom_character = ALL
	quirks_enabled = TRUE // SKYRAT EDIT ADDITION - ghost role loadouts
	random_appearance = FALSE // SKYRAT EDIT ADDITION

/obj/effect/mob_spawn/ghost_role/human/hermit/Initialize(mapload)
	. = ..()
	outfit = new outfit //who cares equip outfit works with outfit as a path or an instance
	var/arrpee = rand(1,4)
	switch(arrpee)
		if(1)
			flavour_text += "you were a [pick("arms dealer", "shipwright", "docking manager")]'s assistant on a small trading station several sectors from here. Raiders attacked, and there was 			only one pod left when you got to the escape bay. You took it and launched it alone, and the crowd of terrified faces crowding at the airlock door as your pod's engines burst to 			life and sent you to this hell are forever branded into your memory."
			outfit.uniform = /obj/item/clothing/under/misc/assistantformal
		if(2)
			flavour_text += "you're an exile from the Tiger Cooperative. Their technological fanaticism drove you to question the power and beliefs of the Exolitics, and they saw you as a 			heretic and subjected you to hours of horrible torture. You were hours away from execution when a high-ranking friend of yours in the Cooperative managed to secure you a pod, 			scrambled its destination's coordinates, and launched it. You awoke from stasis when you landed and have been surviving - barely - ever since."
			outfit.uniform = /obj/item/clothing/under/rank/prisoner
			outfit.shoes = /obj/item/clothing/shoes/sneakers/orange
		if(3)
			flavour_text += "you were a doctor on one of Nanotrasen's space stations, but you left behind that damn corporation's tyranny and everything it stood for. From a metaphorical hell 			to a literal one, you find yourself nonetheless missing the recycled air and warm floors of what you left behind... but you'd still rather be here than there."
			outfit.uniform = /obj/item/clothing/under/rank/medical/doctor
			outfit.suit = /obj/item/clothing/suit/toggle/labcoat
			outfit.back = /obj/item/storage/backpack/medic
		if(4)
			flavour_text += "you were always joked about by your friends for \"not playing with a full deck\", as they so kindly put it. It seems that they were right when you, on a tour 			at one of Nanotrasen's state-of-the-art research facilities, were in one of the escape pods alone and saw the red button. It was big and shiny, and it caught your eye. You pressed 			it, and after a terrifying and fast ride for days, you landed here. You've had time to wisen up since then, and you think that your old friends wouldn't be laughing now."

/obj/effect/mob_spawn/ghost_role/human/hermit/Destroy()
	new/obj/structure/fluff/empty_cryostasis_sleeper(get_turf(src))
	return ..()

/datum/outfit/hermit
	name = "Lavaland Hermit"
	uniform = /obj/item/clothing/under/color/grey/ancient
	back = /obj/item/storage/backpack
	mask = /obj/item/clothing/mask/breath
	shoes = /obj/item/clothing/shoes/sneakers/black
	l_pocket = /obj/item/tank/internals/emergency_oxygen
	r_pocket = /obj/item/flashlight/glowstick

//Icebox version of hermit
/obj/effect/mob_spawn/ghost_role/human/hermit/icemoon
	name = "cryostasis bed"
	desc = "Um dorminhoco com um ocupante silhueta dentro. Sua função de estase está quebrada e provavelmente está sendo usada como cama."
	prompt_name = "Um velho rabugento."
	icon = 'icons/obj/mining_zones/spawners.dmi'
	icon_state = "cryostasis_sleeper"
	outfit = /datum/outfit/hermit
	you_are_text = "Você caça ursos polares há 40 anos! O que esses novatos da 'NaniteTrans' querem?"
	flavour_text = "Você estava bem caçando ursos polares e domesticando lobos por aqui sozinho, mas agora que há idiotas corporativos por aí, você precisa ter cuidado."
	spawner_job_path = /datum/job/hermit

//beach dome

/obj/effect/mob_spawn/ghost_role/human/beach
	prompt_name = "Um vagabundo de praia."
	name = "beach bum sleeper"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	you_are_text = "Você é, tipo, totalmente um mano, mano."
	flavour_text = "Ch'yea. Você veio aqui, tipo, nas férias de primavera, esperando para pegar algumas gostosas, ok?"
	spawner_job_path = /datum/job/beach_bum
	outfit = /datum/outfit/beachbum
	allow_custom_character = GHOSTROLE_TAKE_PREFS_APPEARANCE
	quirks_enabled = TRUE // SKYRAT EDIT ADDITION - ghost role loadouts
	random_appearance = FALSE // SKYRAT EDIT ADDITION

/obj/effect/mob_spawn/ghost_role/human/beach/lifeguard
	you_are_text = "Você é um salva-vidas corajoso!"
	flavour_text = "Cabe a você garantir que ninguém se afogue ou seja comido por tubarões."
	name = "lifeguard sleeper"
	outfit = /datum/outfit/beachbum/lifeguard
	allow_custom_character = NONE

/obj/effect/mob_spawn/ghost_role/human/beach/lifeguard/special(mob/living/carbon/human/lifeguard, mob/mob_possessor, apply_prefs)
	. = ..()
	lifeguard.gender = FEMALE
	lifeguard.update_body()

/datum/outfit/beachbum
	name = "Beach Bum"
	id = /obj/item/card/id/advanced
	uniform = /obj/item/clothing/under/pants/jeans
	glasses = /obj/item/clothing/glasses/sunglasses
	l_pocket = /obj/item/food/pizzaslice/dank
	r_pocket = /obj/item/storage/wallet/random

/datum/outfit/beachbum/post_equip(mob/living/carbon/human/bum, visuals_only = FALSE)
	. = ..()
	if(visuals_only)
		return
	bum.dna.add_mutation(/datum/mutation/stoner, MUTATION_SOURCE_GHOST_ROLE)

/datum/outfit/beachbum/lifeguard
	name = "Beach Lifeguard"
	id_trim = /datum/id_trim/lifeguard
	uniform = /obj/item/clothing/under/shorts/red

/obj/effect/mob_spawn/ghost_role/human/bartender
	name = "bartender sleeper"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "Um barman espacial."
	you_are_text = "Você é um bartender espacial!"
	flavour_text = "Hora de misturar bebidas e mudar vidas. Fumar drogas espaciais torna mais fácil entender o dialeto estranho de seus clientes."
	spawner_job_path = /datum/job/space_bartender
	outfit = /datum/outfit/spacebartender
	allow_custom_character = ALL
	random_appearance = FALSE // SKYRAT EDIT ADDITION

/datum/outfit/spacebartender
	name = "Space Bartender"
	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/space_bartender
	neck = /obj/item/clothing/neck/bowtie
	uniform = /obj/item/clothing/under/costume/buttondown/slacks/service
	suit = /obj/item/clothing/suit/armor/vest
	back = /obj/item/storage/backpack
	glasses = /obj/item/clothing/glasses/sunglasses/reagent
	shoes = /obj/item/clothing/shoes/sneakers/black

/datum/outfit/spacebartender/post_equip(mob/living/carbon/human/bartender, visuals_only = FALSE)
	. = ..()
	var/obj/item/card/id/id_card = bartender.wear_id
	if(bartender.age < AGE_MINOR)
		id_card.registered_age = AGE_MINOR
		to_chat(bartender, span_notice("Não tem idade para acessar ou servir álcool, mas sua identidade foi discretamente modificada para mostrar sua idade como [AGE_MINOR] Tente manter isso em segredo!"))

//Preserved terrarium/seed vault: Spawns in seed vault structures in lavaland. Ghosts become plantpeople and are advised to begin growing plants in the room near them.
/obj/effect/mob_spawn/ghost_role/human/seed_vault
	name = "preserved terrarium"
	desc = "Uma máquina antiga que parece ser usada para armazenar matéria vegetal. O vidro é obstruído por um tapete de videiras."
	prompt_name = "lifebringer"
	icon = 'icons/obj/mining_zones/spawners.dmi'
	icon_state = "terrarium"
	density = TRUE
	mob_species = /datum/species/pod
	you_are_text = "Você é um ecossistema sensível, um exemplo do domínio sobre a vida que seus criadores possuíam."
	flavour_text = "Seus mestres, benevolentes como eram, criaram abóbadas de sementes incontáveis e os espalharam pelo universo para todos os planetas que pudessem mapear. Você está em um desses cofres de sementes. Seu objetivo é proteger o cofre para o qual você está designado, cultivar as sementes passadas para você, e, eventualmente, trazer vida para este planeta desolado enquanto espera pelo contato de seus criadores. Tempo estimado do último contato, implantação, 5000 milênios atrás."
	spawner_job_path = /datum/job/lifebringer
	restricted_species = list(/datum/species/pod) //SKYRAT EDIT ADDITION
	random_appearance = FALSE // SKYRAT EDIT ADDITION
	allow_custom_character = ALL // BUBBER EDIT ADDITION

/obj/effect/mob_spawn/ghost_role/human/seed_vault/Initialize(mapload)
	. = ..()
	mob_name = pick("Tomato", "Potato", "Broccoli", "Carrot", "Ambrosia", "Pumpkin", "Ivy", "Kudzu", "Banana", "Moss", "Flower", "Bloom", "Root", "Bark", "Glowshroom", "Petal", "Leaf", 	"Venus", "Sprout","Cocoa", "Strawberry", "Citrus", "Oak", "Cactus", "Pepper", "Juniper")

/obj/effect/mob_spawn/ghost_role/human/seed_vault/Destroy()
	new/obj/structure/fluff/empty_terrarium(get_turf(src))
	return ..()

//Ash walker eggs: Spawns in ash walker dens in lavaland. Ghosts become unbreathing lizards that worship the Necropolis and are advised to retrieve corpses to create more ash walkers.

/obj/structure/ash_walker_eggshell
	name = "ash walker egg"
	desc = "Um ovo amarelo do tamanho de um homem, gerado de uma criatura insondável. Uma silhueta humanóide se esconde por dentro. A casca do ovo parece resistente à temperatura, mas de outra forma bastante frágil."
	icon = 'icons/mob/simple/lavaland/lavaland_monsters.dmi'
	icon_state = "large_egg"
	resistance_flags = LAVA_PROOF | FIRE_PROOF | FREEZE_PROOF
	max_integrity = 80
	var/obj/effect/mob_spawn/ghost_role/human/ash_walker/egg

/obj/structure/ash_walker_eggshell/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0) //lifted from xeno eggs
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(loc, 'sound/effects/blob/attackblob.ogg', 100, TRUE)
			else
				playsound(src, 'sound/items/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			if(damage_amount)
				playsound(loc, 'sound/items/tools/welder.ogg', 100, TRUE)

/obj/structure/ash_walker_eggshell/attack_ghost(mob/user) //Pass on ghost clicks to the mob spawner
	if(egg)
		egg.attack_ghost(user)
	. = ..()

/obj/structure/ash_walker_eggshell/Destroy()
	if(!egg)
		return ..()
	var/mob/living/carbon/human/yolk = new(get_turf(src))
	yolk.set_species(/datum/species/lizard/ashwalker)
	yolk.fully_replace_character_name(null, yolk.generate_random_mob_name(TRUE))
	yolk.underwear = "Nude"
	yolk.equipOutfit(/datum/outfit/ashwalker)//this is an authentic mess we're making
	yolk.update_body()
	yolk.gib(DROP_ALL_REMAINS)
	QDEL_NULL(egg)
	return ..()

/obj/effect/mob_spawn/ghost_role/human/ash_walker
	name = "ash walker egg"
	desc = "Um ovo amarelo do tamanho de um homem, gerado de uma criatura insondável. Uma silhueta humanóide se esconde por dentro."
	prompt_name = "Necropolis Ash Walker"
	icon = 'icons/mob/simple/lavaland/lavaland_monsters.dmi'
	icon_state = "large_egg"
	mob_species = /datum/species/lizard/ashwalker
	outfit = /datum/outfit/ashwalker
	move_resist = MOVE_FORCE_NORMAL
	density = FALSE
	you_are_text = "Você é um caminhante de cinzas. Sua tribo adora a necrópole."
	flavour_text = "Os resíduos são terrenos sagrados, seus monstros uma bendita recompensa. Você viu luzes à distância... eles prefiguram a chegada de estranhos que procuram destruir a necrópole e seu domínio. Sacrifícios frescos pelo seu ninho."
	spawner_job_path = /datum/job/ash_walker
	var/datum/team/ashwalkers/team
	var/obj/structure/ash_walker_eggshell/eggshell
	restricted_species = list(/datum/species/lizard/ashwalker) //SKYRAT EDIT ADDITION
	random_appearance = FALSE // SKYRAT EDIT ADDITION
	allow_custom_character = GHOSTROLE_TAKE_PREFS_SPECIES // BUBBER EDIT ADDITION

/obj/effect/mob_spawn/ghost_role/human/ash_walker/Destroy()
	eggshell = null
	return ..()

/obj/effect/mob_spawn/ghost_role/human/ash_walker/allow_spawn(mob/user, silent = FALSE)
	if(isnull(team))
		return FALSE
	if(!(user.ckey in team.players_spawned))//one per person unless you get a bonus spawn
		return TRUE
	if(!silent)
		to_chat(user, span_warning("Você esgotou sua utilidade para a necrópole."))
	return FALSE

/obj/effect/mob_spawn/ghost_role/human/ash_walker/special(mob/living/carbon/human/spawned_human, mob/mob_possessor, apply_prefs)
	// SKYRAT EDIT ADDITION BEGIN
	spawned_human.fully_replace_character_name(null, spawned_human.generate_random_mob_name(TRUE)) // SKYRAT EDIT MOVE - Moving before parent call prevents char name randomization
	quirks_enabled = TRUE // ghost role quirks
	// SKYRAT EDIT ADDITION END
	. = ..()
	spawned_human.fully_replace_character_name(null, spawned_human.generate_random_mob_name(TRUE))
	to_chat(spawned_human, "<b>Arraste os cadáveres de homens e animais para o seu ninho. Vai absorvê-los para criar mais do seu tipo. Invadir a estranha estrutura dos forasteiros, se for preciso. Não cause destruição desnecessária, pois sujar os resíduos com destroços feios é certo que não ganhará favores. Glória à Necrópole!</b>")

	spawned_human.mind.add_antag_datum(/datum/antagonist/ashwalker, team)

	spawned_human.remove_language(/datum/language/common)
	team.players_spawned += (spawned_human.ckey)
	eggshell.egg = null
	QDEL_NULL(eggshell)

/obj/effect/mob_spawn/ghost_role/human/ash_walker/Initialize(mapload, datum/team/ashwalkers/ashteam)
	. = ..()
	var/area/spawner_area = get_area(src)
	team = ashteam
	eggshell = new /obj/structure/ash_walker_eggshell(get_turf(loc))
	eggshell.egg = src
	src.forceMove(eggshell)
	if(spawner_area)
		notify_ghosts(
			"An ash walker egg is ready to hatch in \the [spawner_area.name].",
			source = src,
			header = "Ash Walker Egg",
			click_interact = TRUE,
			ignore_key = POLL_IGNORE_ASHWALKER,
			notify_flags = NOTIFY_CATEGORY_NOFLASH,
		)

/datum/outfit/ashwalker
	name = "Ash Walker"
	head = /obj/item/clothing/head/helmet/gladiator
	uniform = /obj/item/clothing/under/costume/gladiator/ash_walker

/datum/outfit/ashwalker/spear
	name = "Ash Walker - Spear"
	back = /obj/item/spear/bonespear

///Syndicate Listening Post

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate
	name = "Syndicate Bioweapon Scientist"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	prompt_name = "um técnico de ciência do sindicato."
	you_are_text = "Você é um técnico de ciência do sindicato, empregado em uma instalação de pesquisa ultra secreta desenvolvendo armas biológicas."
	flavour_text = "Infelizmente, seu inimigo odiado, Nanotrasen, começou a mineração neste setor. Continue sua pesquisa o melhor que puder, e tente ser discreto."
	important_text = "A base está equipada com explosivos, não a abandone ou deixe cair em mãos inimigas!"
	outfit = /datum/outfit/lavaland_syndicate
	spawner_job_path = /datum/job/lavaland_syndicate
	loadout_enabled = TRUE // SKYRAT EDIT ADDITION - ghost role loadouts
	quirks_enabled = TRUE // SKYRAT EDIT ADDITION - ghost role loadouts
	random_appearance = FALSE // SKYRAT EDIT ADDITION
	deletes_on_zero_uses_left = FALSE
	allow_custom_character = ALL

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/special(mob/living/new_spawn, mob/mob_possessor, apply_prefs)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_SPAWNER) // SKYRAT EDIT CHANGE - ORIGINAL: new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_MIND)

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/comms
	name = "Syndicate Comms Agent"
	prompt_name = "Um agente de comunicação do sindicato."
	you_are_text = "Você é um agente de comunicação do sindicato, empregado em uma instalação de pesquisa secreta desenvolvendo armas biológicas."
	flavour_text = "Infelizmente, seu inimigo odiado, Nanotrasen, começou a mineração neste setor. Monitore a atividade inimiga o melhor que puder, e tente ser discreto. Use o equipamento de comunicação para fornecer suporte a qualquer agente de campo, e semear desinformação para tirar Nanotrasen de sua trilha. Não deixe a base cair em mãos inimigas!"
	important_text = "Não abandone a base."
	outfit = /datum/outfit/lavaland_syndicate/comms

/datum/outfit/lavaland_syndicate
	name = "Lavaland Syndicate Agent"
	id = /obj/item/card/id/advanced/chameleon
	id_trim = /datum/id_trim/chameleon/operative
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/toggle/labcoat
	back = /obj/item/storage/backpack
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/syndicate/alt
	shoes = /obj/item/clothing/shoes/combat
	r_pocket = /obj/item/gun/ballistic/automatic/pistol
	// r_hand = /obj/item/gun/ballistic/rifle/sniper_rifle //Bubberstation Edit
	belt = /obj/item/storage/belt/utility/full
	glasses = /obj/item/clothing/glasses/welding/up

	implants = list(/obj/item/implant/weapons_auth)
	id_trim = /datum/id_trim/syndicom/skyrat/interdyne //SKYRAT EDIT

/datum/outfit/lavaland_syndicate/post_equip(mob/living/carbon/human/syndicate, visuals_only = FALSE)
	syndicate.add_faction(ROLE_SYNDICATE)

/datum/outfit/lavaland_syndicate/comms
	name = "Lavaland Syndicate Comms Agent"
	suit = /obj/item/clothing/suit/armor/vest
	mask = /obj/item/clothing/mask/chameleon/gps
	r_hand = /obj/item/melee/energy/sword/saber
	belt = /obj/item/storage/belt/utility/full
	glasses = /obj/item/clothing/glasses/welding/up

/datum/outfit/lavaland_syndicate/comms/icemoon
	name = "Icemoon Syndicate Comms Agent"
	mask = /obj/item/clothing/mask/chameleon
	shoes = /obj/item/clothing/shoes/winterboots/ice_boots/eva

/obj/item/clothing/mask/chameleon/gps/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/gps, "Encrypted Signal")

///Icemoon Syndicate Comms Agent

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/comms/icemoon
	name = "Icemoon Comms Agent"
	prompt_name = "Um agente de comunicação do sindicato."
	you_are_text = "Você é um agente de comunicação do sindicato, designado em um posto secreto subterrâneo de escuta perto das instalações do seu inimigo."
	flavour_text = "Infelizmente, seu inimigo odiado, Nanotrasen, começou a mineração neste setor. Monitore a atividade inimiga o melhor que puder, e tente ser discreto. Use o equipamento de comunicação para fornecer suporte a qualquer agente de campo, e semear desinformação para tirar Nanotrasen de sua trilha. Não deixe o posto avançado cair em mãos inimigas!"
	important_text = "Não deixe o posto avançado cair em mãos inimigas."
	outfit = /datum/outfit/lavaland_syndicate/comms/icemoon
