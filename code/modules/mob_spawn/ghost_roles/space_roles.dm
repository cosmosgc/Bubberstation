
//Ancient cryogenic sleepers. Players become NT crewmen from a hundred year old space station, now on the verge of collapse.
/obj/effect/mob_spawn/ghost_role/human/oldstation
	name = "old cryogenics pod"
	desc = "Uma cápsula criogênica. Mal se reconhece um uniforme debaixo do gelo. A máquina está tentando acordar seu ocupante."
	prompt_name = "Um antigo tripulante."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/human
	you_are_text = "Você é um tripulante trabalhando para Nanotrasen, estacionado a bordo de uma estação de pesquisa de última geração."
	flavour_text = "Você vagamente se lembra de correr para uma cápsula de criogenia devido a uma tempestade de radiação vindoura. A última coisa que se lembra é o Programa Artificial da estação dizendo que você só dormiria por oito horas. Quando você abre os olhos, tudo parece enferrujado e quebrado, uma sensação escura incha seu intestino enquanto você sai da sua cápsula."
	important_text = "Trabalhe como uma equipe com seus companheiros sobreviventes e não os abandone."
	outfit = /datum/outfit/oldeng
	spawner_job_path = /datum/job/ancient_crew
	allow_custom_character = GHOSTROLE_TAKE_PREFS_APPEARANCE

/obj/effect/mob_spawn/ghost_role/human/oldstation/Destroy()
	new /obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()


/obj/effect/mob_spawn/ghost_role/human/oldstation/sec
	desc = "Uma cápsula criogênica. Mal se reconhece um uniforme de segurança debaixo do gelo. A máquina está tentando acordar seu ocupante."
	prompt_name = "Um oficial de segurança."
	you_are_text = "Você é um oficial de segurança trabalhando para Nanotrasen, estacionado a bordo de uma estação de pesquisa de última geração."
	outfit = /datum/outfit/oldsec

/datum/outfit/oldsec
	name = "Ancient Security"
	id = /obj/item/card/id/away/old/sec
	uniform = /obj/item/clothing/under/rank/security/officer
	shoes = /obj/item/clothing/shoes/jackboots
	l_pocket = /obj/item/assembly/flash/handheld
	r_pocket = /obj/item/restraints/handcuffs

/obj/effect/mob_spawn/ghost_role/human/oldstation/eng
	desc = "Uma cápsula criogênica. Mal se reconhece um uniforme de engenharia debaixo do gelo. A máquina está tentando acordar seu ocupante."
	prompt_name = "Um engenheiro."
	you_are_text = "Você é um engenheiro trabalhando para Nanotrasen, estacionado a bordo de uma estação de pesquisa de última geração."
	outfit = /datum/outfit/oldeng

/datum/outfit/oldeng
	name = "Ancient Engineer"
	id = /obj/item/card/id/away/old/eng
	uniform = /obj/item/clothing/under/rank/engineering/engineer
	gloves = /obj/item/clothing/gloves/color/fyellow/old
	shoes = /obj/item/clothing/shoes/workboots
	l_pocket = /obj/item/tank/internals/emergency_oxygen

/datum/outfit/oldeng/mod
	name = "Ancient Engineer (MODsuit)"
	suit_store = /obj/item/tank/internals/oxygen
	back = /obj/item/mod/control/pre_equipped/prototype
	mask = /obj/item/clothing/mask/breath
	internals_slot = ITEM_SLOT_SUITSTORE

/obj/effect/mob_spawn/ghost_role/human/oldstation/sci
	desc = "Uma cápsula criogênica. Mal se reconhece um uniforme científico debaixo do gelo. A máquina está tentando acordar seu ocupante."
	prompt_name = "Um cientista."
	you_are_text = "Você é um cientista trabalhando para Nanotrasen, estacionado a bordo de uma estação de pesquisa de última geração."
	outfit = /datum/outfit/oldsci

/datum/outfit/oldsci
	name = "Ancient Scientist"
	id = /obj/item/card/id/away/old/sci
	uniform = /obj/item/clothing/under/rank/rnd/scientist
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/stack/medical/bruise_pack

///asteroid comms agent

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/comms/space
	you_are_text = "Você é um agente do sindicato, designado para uma pequena estação de escuta situada perto da instalação de pesquisa secreta do inimigo odiado, Estação Espacial 13."
	flavour_text = "Monitore a atividade inimiga o melhor que puder, e tente ser discreto. Use o equipamento de comunicação para fornecer suporte a qualquer agente de campo, e semear desinformação para tirar Nanotrasen de sua trilha. Não deixe a base cair em mãos inimigas!"
	important_text = "Não abandone a base."

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate/comms/space/Initialize(mapload)
	. = ..()
	if(prob(85)) //only has a 15% chance of existing, otherwise it'll just be a NPC syndie.
		new /mob/living/basic/trooper/syndicate/ranged(get_turf(src))
		return INITIALIZE_HINT_QDEL

///battlecruiser stuff

/obj/effect/mob_spawn/ghost_role/human/syndicate/battlecruiser
	name = "Syndicate Battlecruiser Ship Operative"
	you_are_text = "Você é um membro da tripulação a bordo do navio-chefe do sindicato, o SBC Starfury."
	flavour_text = "Seu trabalho é seguir as ordens de seu capitão, manter a nave, e manter a energia fluindo."
	important_text = "O arsenal não é uma loja de doces, e seu papel não é atacar a estação diretamente, deixar esse trabalho para os agentes de assalto."
	prompt_name = "Um membro da tripulação do cruzador de batalha."
	outfit = /datum/outfit/syndicate_empty/battlecruiser
	spawner_job_path = /datum/job/battlecruiser_crew
	uses = 4
	allow_custom_character = ALL

	/// The antag team to apply the player to
	var/datum/team/antag_team
	/// The antag datum to give to the player spawned
	var/antag_datum_to_give = /datum/antagonist/battlecruiser

/obj/effect/mob_spawn/ghost_role/human/syndicate/battlecruiser/allow_spawn(mob/user, silent = FALSE)
	if(!(user.ckey in antag_team.players_spawned))
		return TRUE
	if(!silent)
		to_chat(user, span_boldwarning("Você já usou sua chance de rolar como cruzador de batalha."))
	return FALSE

/obj/effect/mob_spawn/ghost_role/human/syndicate/battlecruiser/special(mob/living/spawned_mob, mob/possesser)
	. = ..()
	if(!spawned_mob.mind)
		spawned_mob.mind_initialize()
	var/datum/mind/mob_mind = spawned_mob.mind
	mob_mind.add_antag_datum(antag_datum_to_give, antag_team)
	antag_team.players_spawned += (spawned_mob.ckey)

/datum/outfit/syndicate_empty/battlecruiser
	name = "Syndicate Battlecruiser Ship Operative"
	belt = /obj/item/storage/belt/military/assault
	l_pocket = /obj/item/gun/ballistic/automatic/pistol/clandestine
	r_pocket = /obj/item/knife/combat/survival

	box = /obj/item/storage/box/survival/syndie

/obj/effect/mob_spawn/ghost_role/human/syndicate/battlecruiser/assault
	name = "Syndicate Battlecruiser Assault Operative"
	you_are_text = "Você é um agente de assalto a bordo do navio-chefe do sindicato, o SBC Starfury."
	flavour_text = "Seu trabalho é seguir as ordens do seu capitão, manter intrusos fora da nave, e atacar a Estação Espacial 13. Há um arsenal, várias naves de assalto, e canhões para atacar a estação."
	important_text = "Trabalhem como uma equipe com seus colegas operacionais e organizem um plano de ataque. Se estiver sobrecarregado, fuja de volta para sua nave!"
	prompt_name = "Um agente cruzador de batalha."
	outfit = /datum/outfit/syndicate_empty/battlecruiser/assault
	uses = 8

/datum/outfit/syndicate_empty/battlecruiser/assault
	name = "Syndicate Battlecruiser Assault Operative"
	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/armor/vest
	suit_store = /obj/item/gun/ballistic/automatic/pistol/clandestine
	back = /obj/item/storage/backpack
	belt = /obj/item/storage/belt/military
	mask = /obj/item/clothing/mask/gas/syndicate
	l_pocket = /obj/item/uplink/nuclear
	r_pocket = /obj/item/modular_computer/pda/nukeops

	skillchips = list(/obj/item/skillchip/disk_verifier)

/obj/effect/mob_spawn/ghost_role/human/syndicate/battlecruiser/captain
	name = "Syndicate Battlecruiser Captain"
	you_are_text = "Você é o capitão a bordo do navio-chefe do sindicato: o SBC Starfury."
	flavour_text = "Seu trabalho é supervisionar sua tripulação, defender a nave e destruir a Estação Espacial 13. A nave tem um arsenal, várias naves, canhões de feixe, e vários tripulantes para alcançar este objetivo."
	important_text = "Como capitão, toda esta operação cai sobre seus ombros. Ajude seus agentes a detonar uma bomba nuclear na estação."
	prompt_name = "Um capitão de guerra."
	outfit = /datum/outfit/syndicate_empty/battlecruiser/assault/captain
	spawner_job_path = /datum/job/battlecruiser_captain
	antag_datum_to_give = /datum/antagonist/battlecruiser/captain
	uses = 1

/datum/outfit/syndicate_empty/battlecruiser/assault/captain
	name = "Syndicate Battlecruiser Captain"
	id = /obj/item/card/id/advanced/black/syndicate_command/captain_id
	id_trim = /datum/id_trim/battlecruiser/captain
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	suit_store = /obj/item/gun/ballistic/revolver/mateba
	back = /obj/item/storage/backpack/satchel/leather
	ears = /obj/item/radio/headset/syndicate/alt/leader
	glasses = /obj/item/clothing/glasses/thermal/eyepatch
	head = /obj/item/clothing/head/hats/hos/cap/syndicate
	mask = /obj/item/cigarette/cigar/havana
	l_pocket = /obj/item/melee/energy/sword/saber/red
	r_pocket = /obj/item/melee/baton/telescopic

//film studio space ruins, actors and such.
/obj/effect/mob_spawn/ghost_role/human/actor
	name = "cryogenics pod"
	desc = "Uma cápsula criogênica. Você reconhece a pessoa dentro como uma celebridade local."
	prompt_name = "Um ator."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/human
	you_are_text = "Você é ator/atriz trabalhando para a Sophronia Broadcasting Inc., estacionada a bordo do estúdio de TV local."
	flavour_text = "A última vez que se lembra, a corporação disse para todos irem dormir por algum motivo, para onde todos foram?"
	important_text = "Trabalhe como uma equipe com seus colegas atores e o diretor para fazer entretenimento para as massas."
	outfit = /datum/outfit/actor
	spawner_job_path = /datum/job/ghost_role
	allow_custom_character = ALL

/datum/outfit/actor
	name = "Actor"
	id = /obj/item/card/id/away/filmstudio
	id_trim= /datum/id_trim/away/actor
	ears = /obj/item/radio/headset
	uniform = /obj/item/clothing/under/suit/charcoal
	back = /obj/item/storage/backpack/satchel
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/clothing/mask/chameleon
	r_pocket = /obj/item/card/id/advanced/chameleon

/obj/effect/mob_spawn/ghost_role/human/director
	name = "cryogenics pod"
	desc = "Uma cápsula criogênica. Você reconhece a pessoa dentro como uma celebridade local."
	prompt_name = "Um diretor."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/human
	you_are_text = "Você é um diretor da Sophronia Broadcasting Inc., estacionado a bordo do estúdio de TV local."
	flavour_text = "Você foi contratado para dirigir shows e entretenimento para um estúdio de TV local, fazer com sua equipe e produzir algo!"
	important_text = "Trabalhe como uma equipe com seus colegas atores e o diretor para fazer entretenimento para as massas."
	outfit = /datum/outfit/actor/director
	spawner_job_path = /datum/job/ghost_role
	allow_custom_character = ALL

/datum/outfit/actor/director
	name = "Director"
	id_trim = /datum/id_trim/away/director
	uniform = /obj/item/clothing/under/suit/red
	head = /obj/item/clothing/head/beret/frenchberet
