/// One of the potential shuttle loans you might receive.
/datum/shuttle_loan_situation
	/// Who sent the shuttle
	var/sender = "Centcom"
	/// What they said about it.
	var/announcement_text = "Unset announcement text"
	/// What the shuttle says about it.
	var/shuttle_transit_text = "Unset transit text"
	/// Supply points earned for taking the deal.
	var/bonus_points = CARGO_CRATE_VALUE * 50
	/// Response for taking the deal.
	var/thanks_msg = "The cargo shuttle should return in five minutes. Have some supply points for your trouble."
	/// Small description of the loan for easier log reading.
	var/logging_desc

/datum/shuttle_loan_situation/New()
	. = ..()
	if(!logging_desc)
		stack_trace("No logging blurb set for [src.type]!")
	if(HAS_TRAIT(SSstation, STATION_TRAIT_LOANER_SHUTTLE))
		bonus_points *= 1.15

/// Spawns paths added to `spawn_list`, and passes empty shuttle turfs so you can spawn more complicated things like dead bodies.
/datum/shuttle_loan_situation/proc/spawn_items(list/spawn_list, list/empty_shuttle_turfs, list/blocked_shutte_turfs)
	SHOULD_CALL_PARENT(FALSE)
	CRASH("Unimplemented get_spawned_items() on [src.type].")

/datum/shuttle_loan_situation/antidote
	sender = "CentCom Research Initiatives"
	announcement_text = "Sua estação foi escolhida para um projeto de pesquisa epidemiológica. Envie-nos seu transporte de carga para receber suas amostras de pesquisa."
	shuttle_transit_text = "Amostras de vírus chegando."
	logging_desc = "Vírus"

/datum/shuttle_loan_situation/antidote/spawn_items(list/spawn_list, list/empty_shuttle_turfs, list/blocked_shutte_turfs)
	var/obj/effect/mob_spawn/corpse/human/assistant/infected_assistant = pick(list(
		/obj/effect/mob_spawn/corpse/human/assistant/beesease_infection,
		/obj/effect/mob_spawn/corpse/human/assistant/brainrot_infection,
		/obj/effect/mob_spawn/corpse/human/assistant/spanishflu_infection,
	))
	for(var/i in 1 to 10)
		if(prob(15))
			spawn_list.Add(/obj/item/reagent_containers/cup/bottle)
		else if(prob(15))
			spawn_list.Add(/obj/item/reagent_containers/syringe)
		else if(prob(25))
			spawn_list.Add(/obj/item/shard)
		var/turf/assistant_turf = pick_n_take(empty_shuttle_turfs)
		new infected_assistant(assistant_turf)
	spawn_list.Add(/obj/structure/closet/crate)
	spawn_list.Add(/obj/item/reagent_containers/cup/bottle/pierrot_throat)
	spawn_list.Add(/obj/item/reagent_containers/cup/bottle/magnitis)

/datum/shuttle_loan_situation/department_resupply
	sender = "CentCom Supply Department"
	announcement_text = "Parece que pedimos dois pacotes de reabastecimento este mês. Podemos mandá-los para você?"
	shuttle_transit_text = "Reforço do departamento chegando."
	thanks_msg = "The cargo shuttle should return in five minutes."
	bonus_points = 0
	logging_desc = "Pacotes de reposição"

/datum/shuttle_loan_situation/department_resupply/spawn_items(list/spawn_list, list/empty_shuttle_turfs, list/blocked_shutte_turfs)
	var/list/crate_types = list(
		/datum/supply_pack/emergency/equipment,
		/datum/supply_pack/security/supplies,
		/datum/supply_pack/organic/food,
		/datum/supply_pack/emergency/weedcontrol,
		/datum/supply_pack/engineering/tools,
		/datum/supply_pack/engineering/engiequipment,
		/datum/supply_pack/science/robotics,
		/datum/supply_pack/science/plasma,
		/datum/supply_pack/medical/supplies
		)
	for(var/crate in crate_types)
		var/datum/supply_pack/pack = SSshuttle.supply_packs[crate]
		pack.generate(pick_n_take(empty_shuttle_turfs))

	for(var/i in 1 to 5)
		var/decal = pick(/obj/effect/decal/cleanable/food/flour, /obj/effect/decal/cleanable/blood/gibs/robot_debris, /obj/effect/decal/cleanable/blood/oil)
		new decal(pick_n_take(empty_shuttle_turfs))

/datum/shuttle_loan_situation/syndiehijacking
	sender = "CentCom Counterintelligence"
	announcement_text = "O sindicato está tentando se infiltrar na sua estação. Se deixar que sequestrem sua nave, vai nos poupar de dor de cabeça."
	shuttle_transit_text = "Equipe de seqüestradores chegando."
	logging_desc = "Grupo de embarque do Sindicato"

/datum/shuttle_loan_situation/syndiehijacking/spawn_items(list/spawn_list, list/empty_shuttle_turfs, list/blocked_shutte_turfs)
	var/datum/supply_pack/pack = SSshuttle.supply_packs[/datum/supply_pack/imports/specialops]
	pack.generate(pick_n_take(empty_shuttle_turfs))

	spawn_list.Add(/mob/living/basic/trooper/syndicate/ranged/infiltrator)
	spawn_list.Add(/mob/living/basic/trooper/syndicate/ranged/infiltrator)
	if(prob(75))
		spawn_list.Add(/mob/living/basic/trooper/syndicate/ranged/infiltrator)
	if(prob(50))
		spawn_list.Add(/mob/living/basic/trooper/syndicate/ranged/infiltrator)

/datum/shuttle_loan_situation/lots_of_bees
	sender = "CentCom Janitorial Division"
	announcement_text = "Um de nossos cargueiros carregando um carregamento de abelhas foi atacado por ecoterroristas. Pode limpar a bagunça para nós?"
	shuttle_transit_text = "Limpeza de risco biológico chegando."
	bonus_points = CARGO_CRATE_VALUE * 100 //Toxin bees can be unbeelievably lethal
	logging_desc = "Transporte cheio de abelhas"

/datum/shuttle_loan_situation/lots_of_bees/spawn_items(list/spawn_list, list/empty_shuttle_turfs, list/blocked_shutte_turfs)
	var/datum/supply_pack/pack = SSshuttle.supply_packs[/datum/supply_pack/organic/hydroponics/beekeeping_fullkit]
	pack.generate(pick_n_take(empty_shuttle_turfs))

	spawn_list.Add(/obj/effect/mob_spawn/corpse/human/bee_terrorist)
	spawn_list.Add(/obj/effect/mob_spawn/corpse/human/cargo_tech)
	spawn_list.Add(/obj/effect/mob_spawn/corpse/human/cargo_tech)
	spawn_list.Add(/obj/effect/mob_spawn/corpse/human/nanotrasensoldier)
	spawn_list.Add(/obj/item/gun/ballistic/automatic/pistol/no_mag)
	spawn_list.Add(/obj/item/gun/ballistic/automatic/pistol/m1911/no_mag)
	spawn_list.Add(/obj/item/honey_frame)
	spawn_list.Add(/obj/item/honey_frame)
	spawn_list.Add(/obj/item/honey_frame)
	spawn_list.Add(/obj/structure/beebox/unwrenched)
	spawn_list.Add(/obj/item/queen_bee/bought)
	spawn_list.Add(/obj/structure/closet/crate/hydroponics)

	for(var/i in 1 to 8)
		spawn_list.Add(/mob/living/basic/bee/toxin)

	for(var/i in 1 to 5)
		var/decal = pick(/obj/effect/decal/cleanable/blood, /obj/effect/decal/cleanable/insectguts)
		new decal(pick_n_take(empty_shuttle_turfs))

	for(var/i in 1 to 10)
		var/casing = /obj/item/ammo_casing/spent
		new casing(pick_n_take(empty_shuttle_turfs))

/datum/shuttle_loan_situation/jc_a_bomb
	sender = "CentCom Security Division"
	announcement_text = "Descobrimos uma bomba ativa perto das linhas de combustível da nave VIP. Se estiver à altura da tarefa, pagaremos por desarmá-la."
	shuttle_transit_text = "Tiro explosivo ao vivo chegando. Tenha muito cuidado."
	thanks_msg = "Live explosive ordnance incoming via supply shuttle. Evacuating cargo bay is recommended."
	bonus_points = CARGO_CRATE_VALUE * 225 //If you mess up, people die and the shuttle gets turned into swiss cheese
	logging_desc = "Transportador com uma bomba."

/datum/shuttle_loan_situation/jc_a_bomb/spawn_items(list/spawn_list, list/empty_shuttle_turfs, list/blocked_shutte_turfs)
	spawn_list.Add(/obj/machinery/syndicatebomb/shuttle_loan)
	if(prob(95))
		spawn_list.Add(/obj/item/paper/fluff/cargo/bomb)
	else
		spawn_list.Add(/obj/item/paper/fluff/cargo/bomb/allyourbase)

/datum/shuttle_loan_situation/papers_please
	sender = "CentCom Paperwork Division"
	announcement_text = "Uma estação vizinha precisa de ajuda para cuidar da papelada. Você poderia ajudar a processar para nós?"
	shuttle_transit_text = "Papelada chegando."
	thanks_msg = "The cargo shuttle should return in five minutes. Payment will be rendered when the paperwork is processed and returned."
	bonus_points = 0 //Payout is made when the stamped papers are returned
	logging_desc = "Envio de papelaria."

/datum/shuttle_loan_situation/papers_please/spawn_items(list/spawn_list, list/empty_shuttle_turfs, list/blocked_shutte_turfs)
	spawn_list += subtypesof(/obj/item/paperwork) - typesof(/obj/item/paperwork/photocopy) - typesof(/obj/item/paperwork/ancient)

/datum/shuttle_loan_situation/pizza_delivery
	sender = "CentCom Spacepizza Division"
	announcement_text = "Parece que uma estação vizinha acidentalmente entregou a pizza para você."
	shuttle_transit_text = "Entrega de pizza!"
	thanks_msg = "The cargo shuttle should return in five minutes."
	bonus_points = 0
	logging_desc = "Entrega de pizza."

/datum/shuttle_loan_situation/pizza_delivery/spawn_items(list/spawn_list, list/empty_shuttle_turfs, list/blocked_shutte_turfs)
	var/naughtypizza = list(/obj/item/pizzabox/bomb, /obj/item/pizzabox/margherita/robo) //oh look another blacklist, for pizza nonetheless!
	var/nicepizza = list(/obj/item/pizzabox/margherita, /obj/item/pizzabox/meat, /obj/item/pizzabox/vegetable, /obj/item/pizzabox/mushroom)
	for(var/i in 1 to 6)
		spawn_list.Add(pick(prob(5) ? naughtypizza : nicepizza))

/datum/shuttle_loan_situation/russian_party
	sender = "CentCom Russian Outreach Program"
	announcement_text = "Um grupo de russos zangados quer dar uma festa. Pode mandar sua nave de carga e fazê-los desaparecer?"
	shuttle_transit_text = "Os russos estão chegando."
	logging_desc = "Pelotão russo do partido"

/datum/shuttle_loan_situation/russian_party/spawn_items(list/spawn_list, list/empty_shuttle_turfs, list/blocked_shutte_turfs)
	var/datum/supply_pack/pack = SSshuttle.supply_packs[/datum/supply_pack/service/party]
	pack.generate(pick_n_take(empty_shuttle_turfs))

	spawn_list.Add(/mob/living/basic/trooper/russian)
	spawn_list.Add(/mob/living/basic/trooper/russian/ranged) //drops a mateba
	spawn_list.Add(/mob/living/basic/bear/russian)
	if(prob(75))
		spawn_list.Add(/mob/living/basic/trooper/russian)
	if(prob(50))
		spawn_list.Add(/mob/living/basic/bear/russian)

/datum/shuttle_loan_situation/spider_gift
	sender = "CentCom Diplomatic Corps"
	announcement_text = "O Clã Aranha nos enviou um presente misterioso. Podemos enviar para você para ver o que tem dentro?"
	shuttle_transit_text = "Presente do Clã Aranha chegando."
	logging_desc = "Nave cheia de aranhas"

/datum/shuttle_loan_situation/spider_gift/spawn_items(list/spawn_list, list/empty_shuttle_turfs, list/blocked_shutte_turfs)
	var/datum/supply_pack/pack = SSshuttle.supply_packs[/datum/supply_pack/imports/specialops]
	pack.generate(pick_n_take(empty_shuttle_turfs))

	spawn_list.Add(/mob/living/basic/spider/giant)
	spawn_list.Add(/mob/living/basic/spider/giant)
	spawn_list.Add(/mob/living/basic/spider/giant/nurse)
	if(prob(50))
		spawn_list.Add(/mob/living/basic/spider/giant/hunter)

	var/turf/victim_turf = pick_n_take(empty_shuttle_turfs)

	new /obj/effect/decal/remains/human(victim_turf)
	new /obj/item/clothing/shoes/jackboots/fast(victim_turf)
	new /obj/item/clothing/mask/balaclava(victim_turf)

	for(var/i in 1 to 5)
		var/turf/web_turf = pick_n_take(empty_shuttle_turfs)
		new /obj/structure/spider/stickyweb(web_turf)

#define DENT_WALL "dent"
#define CHANGE_WALL "change"
#define DISMANTLE_WALL "dismantle"

#define BREAK_TILE "break"
#define PLATING_TILE "plating"
#define RUST_TILE "rust"

/**
 * A special shuttle loan situation enabled by the 'mail blocked' station trait.
 * It sends back a lot of mail to the station, at the cost of wrecking the cargo shuttle a little.
 */
/datum/shuttle_loan_situation/mail_strike
	sender = "Spinward Mail Workers Union"
	announcement_text = "O Sindicato dos Trabalhadores do Correio quer seu transporte de carga emprestado para empregar\"táticas de greve de união avançada\"Com. O pagamento é estritamente no correio."
	bonus_points = 0
	thanks_msg = "The cargo shuttle should return in five minutes."
	shuttle_transit_text = "Nada para o correio."
	logging_desc = "Transporte cheio de cartas sombrias"

/datum/shuttle_loan_situation/mail_strike/spawn_items(list/spawn_list, list/empty_shuttle_turfs, list/blocked_shutte_turfs)
	for(var/i in 1 to rand(7, 12))
		var/turf/closed/wall/wall = pick_n_take(blocked_shutte_turfs)
		if(!istype(wall))
			continue
		var/static/list/wall_bad_stuff = list(DENT_WALL = 85, CHANGE_WALL = 13, DISMANTLE_WALL = 2)
		var/static/list/possible_new_walls = list(
			/turf/closed/wall/mineral/sandstone,
			/turf/closed/wall/mineral/wood,
			/turf/closed/wall/mineral/iron,
			/turf/closed/wall/metal_foam_base,
			/turf/closed/wall/r_wall,
		)
		var/damage_done = pick_weight(wall_bad_stuff)
		switch(damage_done)
			if(DENT_WALL)
				for(var/dent in 1 to rand(1, MAX_DENT_DECALS))
					wall.add_dent(prob(90) ? WALL_DENT_SHOT : WALL_DENT_HIT)
			if(CHANGE_WALL)
				wall.ChangeTurf(pick(possible_new_walls - wall.type))
				if(prob(25))
					for(var/dent in 1 to rand(1, MAX_DENT_DECALS))
						wall.add_dent(prob(90) ? WALL_DENT_SHOT : WALL_DENT_HIT)
			if(DISMANTLE_WALL)
				wall.dismantle_wall()

	for(var/i in 1 to rand(7, 12))
		var/turf/open/floor/floor = pick_n_take(empty_shuttle_turfs)
		if(!istype(floor))
			continue
		var/static/list/floor_bad_stuff = list(BREAK_TILE = 65, PLATING_TILE = 25, RUST_TILE = 10)
		var/damage_done = pick_weight(floor_bad_stuff)
		switch(damage_done)
			if(BREAK_TILE)
				if(prob(50))
					floor.break_tile()
				else
					floor.burn_tile()
			if(PLATING_TILE)
				if(prob(25))
					floor.remove_tile()
				else
					floor.make_plating()
			if(RUST_TILE)
				floor.ChangeTurf(/turf/open/floor/plating/rust)
	if(prob(25))
		spawn_list += pick(/obj/effect/gibspawner/robot, /obj/effect/gibspawner/human)

	for(var/i in 1 to rand(4, 7))
		spawn_list += /obj/structure/closet/crate/mail/full/mail_strike

#undef BREAK_TILE
#undef PLATING_TILE
#undef RUST_TILE

#undef DENT_WALL
#undef CHANGE_WALL
#undef DISMANTLE_WALL
