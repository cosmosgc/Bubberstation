
//i couldn't find any map that uses these, so they're delegated to admin events for now.

/obj/effect/mob_spawn/ghost_role/human/prisoner_transport
	name = "prisoner containment sleeper"
	desc = "Um adormecido projetado para colocar seu ocupante em coma profundo, inquebrável até que o adormecido desligue. Este vidro está rachado e você pode ver um rosto pálido, dormindo olhando para fora."
	prompt_name = "Um prisioneiro fugitivo."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	outfit = /datum/outfit/lavalandprisoner
	you_are_text = "Você é um prisioneiro, condenado ao trabalho duro em um dos campos de trabalho de Nanotrasen, mas parece que\
Embora o destino tenha outros planos para você."
	flavour_text = "Bom. Parece que sua nave caiu. Você se lembra que foi condenado por"
	spawner_job_path = /datum/job/escaped_prisoner
	allow_custom_character = GHOSTROLE_TAKE_PREFS_APPEARANCE

/obj/effect/mob_spawn/ghost_role/human/prisoner_transport/Initialize(mapload)
	. = ..()
	var/list/crimes = list("murder", "larceny", "embezzlement", "unionization", "dereliction of duty", "kidnapping", "gross incompetence", "grand theft", "collaboration with the Syndicate", \
	"worship of a forbidden deity", "interspecies relations", "mutiny")
	flavour_text += "[pick(crimes)]. but regardless of that, it seems like your crime doesn't matter now. You don't know where you are, but you know that it's out to kill you, and you're not going \
	to lose this opportunity. Find a way to get out of this mess and back to where you rightfully belong - your [pick("house", "apartment", "spaceship", "station")]."

/obj/effect/mob_spawn/ghost_role/human/prisoner_transport/Destroy()
	new /obj/structure/fluff/empty_sleeper/syndicate(get_turf(src))
	return ..()

/obj/effect/mob_spawn/ghost_role/human/prisoner_transport/special(mob/living/carbon/human/spawned_human, mob/mob_possessor, apply_prefs)
	. = ..()
	spawned_human.fully_replace_character_name(null, "NTP #LL-0[rand(111,999)]") //Nanotrasen Prisoner #Lavaland-(numbers)

/datum/outfit/lavalandprisoner
	name = "Lavaland Prisoner"
	uniform = /obj/item/clothing/under/rank/prisoner
	mask = /obj/item/clothing/mask/breath
	shoes = /obj/item/clothing/shoes/sneakers/orange
	r_pocket = /obj/item/tank/internals/emergency_oxygen


//spawners for the space hotel, which isn't currently in the code but heyoo secret away missions or something

//Space Hotel Staff
/obj/effect/mob_spawn/ghost_role/human/hotel_staff //not free antag u little shits
	name = "staff sleeper"
	desc = "Um adormecido projetado para estase de longo prazo entre visitas de hóspedes."
	prompt_name = "Um funcionário do hotel."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	outfit = /datum/outfit/hotelstaff
	you_are_text = "Você é um membro da equipe de um hotel espacial top de linha!"
	flavour_text = "Visitar convidados com sua equipe, anunciar o hotel, e garantir que o gerente não te demita. Lembre-se, o cliente está sempre certo!"
	important_text = "Não saia do hotel, pois isso é motivo para rescisão do contrato."
	spawner_job_path = /datum/job/hotel_staff
	allow_custom_character = ALL

/datum/outfit/hotelstaff
	name = "Hotel Staff"
	uniform = /obj/item/clothing/under/misc/assistantformal
	back = /obj/item/storage/backpack
	shoes = /obj/item/clothing/shoes/laceup
	r_pocket = /obj/item/radio/off

	implants = list(
		/obj/item/implant/exile/noteleport,
		/obj/item/implant/mindshield,
	)

/obj/effect/mob_spawn/ghost_role/human/hotel_staff/security
	name = "hotel security sleeper"
	prompt_name = "Um membro da segurança do hotel."
	outfit = /datum/outfit/hotelstaff/security
	you_are_text = "Você é um pacificador."
	flavour_text = "Você foi designado para este hotel para proteger os interesses da empresa enquanto mantém a paz entre\
convidados e funcionários."
	important_text = "Não saia do hotel, pois isso é motivo para rescisão do contrato."

/datum/outfit/hotelstaff/security
	name = "Hotel Security"
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt
	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	back = /obj/item/storage/backpack/security
	belt = /obj/item/storage/belt/security/full
	head = /obj/item/clothing/head/helmet/blueshirt
	shoes = /obj/item/clothing/shoes/jackboots

/obj/effect/mob_spawn/ghost_role/human/hotel_staff/Destroy()
	new/obj/structure/fluff/empty_sleeper/syndicate(get_turf(src))
	return ..()

/obj/effect/mob_spawn/ghost_role/human/syndicate
	name = "Syndicate Operative"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	prompt_name = "Um agente do sindicato."
	you_are_text = "Você é um agente do sindicato."
	flavour_text = "Você acordou, sem instrução. Morte a Nanotrasen! Se há pistas sobre o que você deveria estar fazendo, é melhor seguir essas."
	outfit = /datum/outfit/syndicate_empty
	spawner_job_path = /datum/job/space_syndicate
	allow_custom_character = ALL

/datum/outfit/syndicate_empty
	name = "Syndicate Operative Empty"
	id = /obj/item/card/id/advanced/chameleon
	id_trim = /datum/id_trim/chameleon/operative
	uniform = /obj/item/clothing/under/syndicate
	back = /obj/item/storage/backpack
	ears = /obj/item/radio/headset/syndicate/alt
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	shoes = /obj/item/clothing/shoes/combat

	implants = list(/obj/item/implant/weapons_auth)

/datum/outfit/syndicate_empty/post_equip(mob/living/carbon/human/H)
	H.add_faction(ROLE_SYNDICATE)

//For ghost bar.
/obj/effect/mob_spawn/ghost_role/human/space_bar_patron
	name = "bar cryogenics"
	uses = INFINITY
	prompt_name = "Um patrono da barra espacial"
	you_are_text = "Você é um patrono!"
	flavour_text = "Sair no bar e conversar com seus amigos. Sinta-se livre para voltar aos criogênicos quando terminar de conversar."
	outfit = /datum/outfit/cryobartender
	spawner_job_path = /datum/job/space_bar_patron
	allow_custom_character = ALL

/obj/effect/mob_spawn/ghost_role/human/space_bar_patron/attack_hand(mob/user, list/modifiers)
	var/despawn = tgui_alert(usr, "Voltar a dormir? (Aviso, sua multidão será deletada!)", null, list("Yes", "No"))
	if(despawn == "No" || !loc || !Adjacent(user))
		return
	user.visible_message(span_notice("[user.name] climbs back into cryosleep..."))
	qdel(user)

/datum/outfit/cryobartender
	name = "Cryogenic Bartender"
	neck = /obj/item/clothing/neck/bowtie
	uniform = /obj/item/clothing/under/costume/buttondown/slacks/service
	suit = /obj/item/clothing/suit/armor/vest
	back = /obj/item/storage/backpack
	glasses = /obj/item/clothing/glasses/sunglasses/reagent
	shoes = /obj/item/clothing/shoes/sneakers/black

//Timeless prisons: Spawns in Wish Granter prisons in lavaland. Ghosts become age-old users of the Wish Granter and are advised to seek repentance for their past.
/obj/effect/mob_spawn/ghost_role/human/exile
	name = "timeless prison"
	desc = "Embora esta cápsula de estase pareça medicinal, parece que é para preservar algo por muito tempo."
	prompt_name = "Um exílio penitente"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/shadow
	you_are_text = "Você está amaldiçoado."
	flavour_text = "Anos atrás, você sacrificou a vida de seus amigos de confiança e a humanidade de si mesmo para alcançar o Wish Grant. Embora você\
Fez isso, veio a um custo: seu próprio corpo rejeita a luz, condenando-o a vagar infinitamente neste horrível deserto."
	spawner_job_path = /datum/job/exile

/obj/effect/mob_spawn/ghost_role/human/exile/Destroy()
	new/obj/structure/fluff/empty_sleeper(get_turf(src))
	return ..()

/obj/effect/mob_spawn/ghost_role/human/exile/special(mob/living/new_spawn, mob/mob_possessor, apply_prefs)
	. = ..()
	new_spawn.fully_replace_character_name(null,"Wish Granter's Victim ([rand(1,999)])")
	var/wish = rand(1,4)
	var/message = ""
	switch(wish)
		if(1)
			message = "<b>You wished to kill, and kill you did. You've lost track of how many, but the spark of excitement that murder once held has winked out. You feel only regret.</b>"
		if(2)
			message = "<b>You wished for unending wealth, but no amount of money was worth this existence. Maybe charity might redeem your soul?</b>"
		if(3)
			message = "<b>You wished for power. Little good it did you, cast out of the light. You are the [gender == MALE ? "king" : "queen"] of a hell that holds no subjects. You feel only remorse.</b>"
		if(4)
			message = "<b>You wished for immortality, even as your friends lay dying behind you. No matter how many times you cast yourself into the lava, you awaken in this room again within a few days. There is no escape.</b>"
	to_chat(new_spawn, span_infoplain("[message]"))

/obj/effect/mob_spawn/ghost_role/human/nanotrasensoldier
	name = "sleeper"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	faction = list(FACTION_NANOTRASEN_PRIVATE)
	prompt_name = "Um oficial de segurança particular."
	you_are_text = "Você é um Oficial de Segurança Privada Nanotrasen!"
	flavour_text = "Se o comando superior tem uma missão para você, é melhor que siga isso. Caso contrário, morte para o Sindicato."
	outfit = /datum/outfit/nanotrasensoldier
	allow_custom_character = ALL

/obj/effect/mob_spawn/ghost_role/human/commander
	name = "sleeper"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "um comandante nanotrasen."
	you_are_text = "Você é um comandante Nanotrasen!"
	flavour_text = "Nanotrasen. Você deve ter o respeito que lhe é devido."
	outfit = /datum/outfit/nanotrasencommander
	allow_custom_character = GHOSTROLE_TAKE_PREFS_APPEARANCE

//space doctor, a rat with cancer, and bessie from an old removed lavaland ruin.

/obj/effect/mob_spawn/ghost_role/human/doctor
	name = "sleeper"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "Um médico do espaço."
	you_are_text = "Você é um médico do espaço!"
	flavour_text = "É o seu trabalho. Não, seu dever como médico, cuidar e curar os necessitados."
	outfit = /datum/outfit/job/doctor
	spawner_job_path = /datum/job/space_doctor
	allow_custom_character = ALL

/obj/effect/mob_spawn/ghost_role/human/doctor/alive/equip(mob/living/carbon/human/doctor)
	. = ..()
	// Remove radio and PDA so they wouldn't annoy station crew.
	var/list/del_types = list(/obj/item/modular_computer/pda, /obj/item/radio/headset)
	for(var/del_type in del_types)
		var/obj/item/unwanted_item = locate(del_type) in doctor
		qdel(unwanted_item)

/obj/effect/mob_spawn/ghost_role/mouse
	name = "sleeper"
	mob_type = /mob/living/basic/mouse
	prompt_name = "Um rato."
	you_are_text = "Você é um rato!"
	flavour_text = "Uh... sim! Grite, filho da puta."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"

/obj/effect/mob_spawn/ghost_role/cow
	name = "sleeper"
	mob_name = "Bessie"
	mob_type = /mob/living/basic/cow
	prompt_name = "Uma vaca."
	you_are_text = "Você é uma vaca!"
	flavour_text = "Vá pastar um pouco de grama, fedorento."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"

/obj/effect/mob_spawn/cow/special(mob/living/spawned_mob, mob/mob_possessor, apply_prefs)
	. = ..()
	gender = FEMALE

// snow operatives on snowdin - unfortunately seemingly removed in a map remake womp womp

/obj/effect/mob_spawn/ghost_role/human/snow_operative
	name = "sleeper"
	prompt_name = "Um agente da neve."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	faction = list(ROLE_SYNDICATE)
	outfit = /datum/outfit/snowsyndie
	you_are_text = "Você é um agente do sindicato recentemente acordado de criostase em um posto subterrâneo."
	flavour_text = "Monitore as comunicações de Nanotrasen e registre informações. Todos os intrusos devem ser eliminados.\
rapidamente para garantir que nenhuma informação recolhida seja roubada ou perdida. Tente não andar muito longe do posto avançado como o\
cavernas podem ser um lugar mortal mesmo para um agente treinado como você."
	allow_custom_character = ALL

/datum/outfit/snowsyndie
	name = "Syndicate Snow Operative"
	id = /obj/item/card/id/advanced/chameleon
	id_trim = /datum/id_trim/chameleon/operative
	uniform = /obj/item/clothing/under/syndicate/coldres
	ears = /obj/item/radio/headset/syndicate/alt
	shoes = /obj/item/clothing/shoes/combat/coldres
	r_pocket = /obj/item/gun/ballistic/automatic/pistol

	implants = list(/obj/item/implant/exile)

//Forgotten syndicate ship

/obj/effect/mob_spawn/ghost_role/human/syndicatespace
	name = "Syndicate Ship Crew Member"
	show_flavor = FALSE
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	prompt_name = "Tripulação ciberssun"
	you_are_text = "Você é um agente do sindicato na nave antiga, preso no espaço hostil."
	flavour_text = "Sua nave atraca depois de muito tempo em algum lugar no espaço hostil, relatando um defeito. Você está preso aqui, com a estação Nanotrasen nas proximidades. Conserte a nave, encontre uma maneira de energizá-la e siga as ordens do seu capitão."
	important_text = "Obedeça ordens dadas pelo seu capitão. Não deixe a nave cair em mãos inimigas."
	outfit = /datum/outfit/syndicatespace/syndicrew
	spawner_job_path = /datum/job/syndicate_cybersun
	allow_custom_character = ALL

/obj/effect/mob_spawn/ghost_role/human/syndicatespace/special(mob/living/new_spawn, mob/mob_possessor, apply_prefs)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_SPAWNER) // SKYRAT EDIT CHANGE - ORIGINAL: new_spawn.grant_language(/datum/language/codespeak, source = LANGUAGE_MIND)
	var/datum/job/spawn_job = SSjob.get_job_type(spawner_job_path)
	var/policy = get_policy(spawn_job.policy_index)
	if(policy)
		to_chat(new_spawn, span_bold("[policy]"))

/obj/effect/mob_spawn/ghost_role/human/syndicatespace/captain
	name = "Syndicate Ship Captain"
	prompt_name = "Um capitão de cybersun"
	you_are_text = "Você é o capitão de uma velha nave, presa no espaço hostil."
	flavour_text = "Sua nave atraca depois de muito tempo em algum lugar no espaço hostil, relatando um defeito. Você está preso aqui, com a estação Nanotrasen nas proximidades. Comande sua tripulação e transforme sua nave na fortaleza mais protegida."
	important_text = "Proteja a nave e documentos secretos em sua mochila com sua própria vida."
	outfit = /datum/outfit/syndicatespace/syndicaptain
	spawner_job_path = /datum/job/syndicate_cybersun_captain
	allow_custom_character = ALL

/obj/effect/mob_spawn/ghost_role/human/syndicatespace/captain/Destroy()
	new /obj/structure/fluff/empty_sleeper/syndicate/captain(get_turf(src))
	return ..()

/datum/outfit/syndicatespace
	name = "Syndicate Ship Base"
	id = /obj/item/card/id/advanced/black/syndicate_command/crew_id
	uniform = /obj/item/clothing/under/syndicate/combat
	back = /obj/item/storage/backpack
	belt = /obj/item/storage/belt/military/assault
	ears = /obj/item/radio/headset/syndicate/alt
	gloves = /obj/item/clothing/gloves/combat
	shoes = /obj/item/clothing/shoes/combat

	implants = list(/obj/item/implant/weapons_auth)

/datum/outfit/syndicatespace/post_equip(mob/living/carbon/human/syndie_scum)
	syndie_scum.add_faction(ROLE_SYNDICATE)

/datum/outfit/syndicatespace/syndicrew
	name = "Syndicate Ship Crew Member"
	glasses = /obj/item/clothing/glasses/night
	mask = /obj/item/clothing/mask/gas/syndicate
	l_pocket = /obj/item/gun/ballistic/automatic/pistol
	r_pocket = /obj/item/knife/combat/survival

/datum/outfit/syndicatespace/syndicaptain
	name = "Syndicate Ship Captain"
	id = /obj/item/card/id/advanced/black/syndicate_command/captain_id
	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	ears = /obj/item/radio/headset/syndicate/alt/leader
	head = /obj/item/clothing/head/hats/hos/beret/syndicate
	r_pocket = /obj/item/knife/combat/survival
	backpack_contents = list(
		/obj/item/documents/syndicate/red,
		/obj/item/gun/ballistic/automatic/pistol/aps,
		/obj/item/paper/fluff/ruins/forgottenship/password,
	)
