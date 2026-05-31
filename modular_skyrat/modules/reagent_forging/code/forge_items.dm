/obj/item/forging
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_items.dmi'
	lefthand_file = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_l.dmi'
	righthand_file = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_r.dmi'
	toolspeed = 1 SECONDS
	///whether the item is in use or not
	var/in_use = FALSE

/obj/item/forging/tongs
	name = "forging tongs"
	desc = "Um conjunto de pinças especificamente concebidas para uso na forja. Um sábio disse uma vez: \"Levantei as coisas e as larguei\"."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_items.dmi'
	icon_state = "tong_empty"
	tool_behaviour = TOOL_TONG

/obj/item/forging/tongs/primitive
	name = "primitive forging tongs"
	toolspeed = 2 SECONDS
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/forging/tongs/attack_self(mob/user, modifiers)
	. = ..()
	var/obj/search_obj = locate(/obj) in contents
	if(search_obj)
		search_obj.forceMove(get_turf(src))
		icon_state = "tong_empty"
		return

/obj/item/forging/hammer
	name = "forging mallet"
	desc = "Um martelo especificamente feito para forjar. Usado para moldar metal lentamente; cuidado, você poderia quebrar algo com ele!"
	icon_state = "hammer"
	inhand_icon_state = "hammer"
	worn_icon_state = "hammer_back"
	tool_behaviour = TOOL_HAMMER
	///the list of things that, if attacked, will set the attack speed to rapid
	var/static/list/fast_attacks = list(
		/obj/structure/reagent_anvil,
		/obj/structure/reagent_crafting_bench
	)

/obj/item/forging/hammer/primitive
	name = "primitive forging hammer"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/forging/billow
	name = "forging billow"
	desc = "Uma onda especificamente criada para ser usada na forja. Costumava acender as chamas e manter a forja acesa."
	icon_state = "billow"
	tool_behaviour = TOOL_BILLOW

/obj/item/forging/billow/primitive
	name = "primitive forging billow"
	toolspeed = 2 SECONDS
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 5)

//incomplete pre-complete items
/obj/item/forging/incomplete
	name = "parent dev item"
	desc = "Um item de forja incompleto, continue trabalhando duro para ser recompensado por seus esforços."
	//the time remaining that you can hammer before too cool
	COOLDOWN_DECLARE(heating_remainder)
	//the time between each strike
	COOLDOWN_DECLARE(striking_cooldown)
	///the amount of times it takes for the item to become ready
	var/average_hits = 30
	///the amount of times the item has been hit currently
	var/times_hit = 0
	///the required time before each strike to prevent spamming
	var/average_wait = 1 SECONDS
	///the number of current perfect hits (really only impacts weapons atm)
	var/current_perfects = 0
	///the path of the item that will be spawned upon completion
	var/spawn_item
	//because who doesn't want to have a plasma sword?
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR

/obj/item/forging/incomplete/tong_act(mob/living/user, obj/item/tool)
	. = ..()
	if(length(tool.contents) > 0)
		user.balloon_alert(user, "As pinças já estão cheias!")
		return
	forceMove(tool)
	tool.icon_state = "tong_full"

/obj/item/forging/incomplete/chain
	name = "incomplete chain"
	icon_state = "hot_chain"
	average_hits = 10
	average_wait = 0.5 SECONDS
	spawn_item = /obj/item/forging/complete/chain

/obj/item/forging/incomplete/plate
	name = "incomplete plate"
	icon_state = "hot_plate"
	average_hits = 10
	average_wait = 0.5 SECONDS
	spawn_item = /obj/item/forging/complete/plate

/obj/item/forging/incomplete/sword
	name = "incomplete sword blade"
	icon_state = "hot_blade"
	spawn_item = /obj/item/forging/complete/sword

/obj/item/forging/incomplete/katana
	name = "incomplete katana blade"
	icon_state = "hot_katanablade"
	spawn_item = /obj/item/forging/complete/katana

/obj/item/forging/incomplete/rapier
	name = "incomplete rapier blade"
	icon_state = "hot_rapierblade"
	spawn_item = /obj/item/forging/complete/rapier

/obj/item/forging/incomplete/dagger
	name = "incomplete dagger blade"
	icon_state = "hot_daggerblade"
	spawn_item = /obj/item/forging/complete/dagger

/obj/item/forging/incomplete/staff
	name = "incomplete staff head"
	icon_state = "hot_staffhead"
	spawn_item = /obj/item/forging/complete/staff

/obj/item/forging/incomplete/spear
	name = "incomplete spear head"
	icon_state = "hot_spearhead"
	spawn_item = /obj/item/forging/complete/spear

/obj/item/forging/incomplete/axe
	name = "incomplete axe head"
	icon_state = "hot_axehead"
	spawn_item = /obj/item/forging/complete/axe

/obj/item/forging/incomplete/hammer
	name = "incomplete hammer head"
	icon_state = "hot_hammerhead"
	spawn_item = /obj/item/forging/complete/hammer

/obj/item/forging/incomplete/pickaxe
	name = "incomplete pickaxe head"
	icon_state = "hot_pickaxehead"
	spawn_item = /obj/item/forging/complete/pickaxe

/obj/item/forging/incomplete/shovel
	name = "incomplete shovel head"
	icon_state = "hot_shovelhead"
	spawn_item = /obj/item/forging/complete/shovel

/obj/item/forging/incomplete/arrowhead
	name = "incomplete arrowhead"
	icon_state = "hot_arrowhead"
	average_hits = 12
	average_wait = 0.5 SECONDS
	spawn_item = /obj/item/forging/complete/arrowhead

/obj/item/forging/incomplete/rail_nail
	name = "incomplete rail nail"
	icon = 'modular_skyrat/modules/ashwalkers/icons/railroad.dmi'
	icon_state = "hot_nail"
	average_hits = 10
	average_wait = 0.5 SECONDS
	spawn_item = /obj/item/forging/complete/rail_nail

/obj/item/forging/incomplete/rail_cart
	name = "incomplete rail cart"
	icon = 'modular_skyrat/modules/ashwalkers/icons/railroad.dmi'
	icon_state = "hot_cart"
	spawn_item = /obj/vehicle/ridden/rail_cart

//"complete" pre-complete items
/obj/item/forging/complete
	///the path of the item that will be created
	var/spawning_item
	///the amount of perfect hits on the item, if it was allowed
	var/current_perfects = 0
	//because who doesn't want to have a plasma sword?
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR

/obj/item/forging/complete/examine(mob/user)
	. = ..()
	if(spawning_item)
		. += span_notice("<br>Para terminar este item, uma bancada será necessária!")

/obj/item/forging/complete/chain
	name = "chain"
	desc = "Uma corrente singular, melhor usada em combinação com várias correntes."
	icon_state = "chain"

/obj/item/forging/complete/plate
	name = "plate"
	desc = "Uma placa, melhor usada em combinação com várias placas."
	icon_state = "plate"

/obj/item/forging/complete/sword
	name = "sword blade"
	desc = "Uma lâmina de espada, pronta para pegar madeira para a conclusão."
	icon_state = "blade"
	spawning_item = /obj/item/forging/reagent_weapon/sword

/obj/item/forging/complete/katana
	name = "katana blade"
	desc = "Uma lâmina katana, pronta para pegar madeira para a conclusão."
	icon_state = "katanablade"
	spawning_item = /obj/item/forging/reagent_weapon/katana

/obj/item/forging/complete/rapier
	name = "rapier blade"
	desc = "Uma lâmina rapier, pronta para pegar madeira para a conclusão."
	icon_state = "rapierblade"
	spawning_item = /obj/item/forging/reagent_weapon/rapier

/obj/item/forging/complete/dagger
	name = "dagger blade"
	desc = "Uma lâmina de adaga, pronta para pegar madeira para a conclusão."
	icon_state = "daggerblade"
	spawning_item = /obj/item/forging/reagent_weapon/dagger

/obj/item/forging/complete/staff
	name = "staff head"
	desc = "Uma cabeça de bastão, pronta para pegar lenha para a conclusão."
	icon_state = "staffhead"
	spawning_item = /obj/item/forging/reagent_weapon/staff

/obj/item/forging/complete/spear
	name = "spear head"
	desc = "Uma cabeça de lança, pronta para pegar lenha para a conclusão."
	icon_state = "spearhead"
	spawning_item = /obj/item/forging/reagent_weapon/spear

/obj/item/forging/complete/axe
	name = "axe head"
	desc = "Uma cabeça de machado, pronta para pegar lenha para a conclusão."
	icon_state = "axehead"
	spawning_item = /obj/item/forging/reagent_weapon/axe

/obj/item/forging/complete/hammer
	name = "hammer head"
	desc = "Uma cabeça de martelo, pronta para pegar madeira para a conclusão."
	icon_state = "hammerhead"
	spawning_item = /obj/item/forging/reagent_weapon/hammer

/obj/item/forging/complete/pickaxe
	name = "pickaxe head"
	desc = "Uma cabeça de picareta, pronta para pegar lenha para a conclusão."
	icon_state = "pickaxehead"
	spawning_item = /obj/item/pickaxe/reagent_weapon

/obj/item/forging/complete/shovel
	name = "shovel head"
	desc = "Uma cabeça de pá, pronta para pegar madeira para a conclusão."
	icon_state = "shovelhead"
	spawning_item = /obj/item/shovel/reagent_weapon

/obj/item/forging/complete/arrowhead
	name = "arrowhead"
	desc = "Uma ponta de flecha, pronta para pegar lenha para a conclusão."
	icon_state = "arrowhead"
	spawning_item = /obj/item/arrow_spawner

/obj/item/forging/complete/rail_nail
	name = "rail nail"
	desc = "Um prego, pronto para ser usado com madeira para fazer trilhas."
	icon = 'modular_skyrat/modules/ashwalkers/icons/railroad.dmi'
	icon_state = "nail"
	spawning_item = /obj/item/stack/rail_track/ten

/obj/item/forging/coil
	name = "coil"
	desc = "Uma simples bobina, composta de barras de ferro enroladas."
	icon_state = "coil"

/obj/item/forging/incomplete_bow
	name = "incomplete longbow"
	desc = "Um arco de madeira que ainda não foi amarrado."
	icon_state = "nostring_bow"

/obj/item/forging/incomplete_bow/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/weaponcrafting/silkstring))
		new /obj/item/gun/ballistic/bow/longbow(get_turf(src))
		qdel(attacking_item)
		qdel(src)
		return
	return ..()

/obj/item/arrow_spawner
	name = "arrow spawner"
	desc = "Você não deveria ver isso."
	/// the amount of arrows that are spawned from the spawner
	var/spawning_amount = 4

/obj/item/arrow_spawner/Initialize(mapload)
	. = ..()
	var/turf/src_turf = get_turf(src)
	for(var/i in 1 to spawning_amount)
		new /obj/item/ammo_casing/arrow/(src_turf)
	qdel(src)

/obj/item/stock_parts/power_store/cell/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/forging/coil))
		var/obj/item/stock_parts/power_store/cell/crank/new_crank = new(get_turf(src))
		new_crank.maxcharge = maxcharge
		new_crank.charge = charge
		qdel(attacking_item)
		qdel(src)
		return
	return ..()

/obj/item/stack/tong_act(mob/living/user, obj/item/tool)
	. = ..()
	if(length(tool.contents) > 0)
		user.balloon_alert(user, "As pinças já estão cheias!")
		return FALSE
	if(!material_type && !custom_materials)
		user.balloon_alert(user, "Material inválido!")
		return
	forceMove(tool)
	tool.icon_state = "tong_full"

/obj/tong_act(mob/living/user, obj/item/tool)
	. = ..()
	if(length(tool.contents))
		user.balloon_alert(user, "As pinças já estão cheias!")
		return FALSE
	if(skyrat_obj_flags & ANVIL_REPAIR)
		forceMove(tool)
		tool.icon_state = "tong_full"

/obj/item/empty_circuit
	name = "empty circuit"
	desc = "Este é um circuito que está perto de ser terminado, só requer algumas previsões e ouro."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_items.dmi'
	icon_state = "circuit"
	var/static/recycleable_circuits = typecacheof(list(
		/obj/item/electronics/airalarm,
		/obj/item/electronics/firealarm,
		/obj/item/electronics/apc,
	))//A typecache of circuits consumable for material

/obj/item/empty_circuit/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/stack/sheet/mineral/gold))
		var/obj/item/stack/attacking_stack = attacking_item

		if(user.mind.get_skill_level(/datum/skill/research) < SKILL_LEVEL_JOURNEYMAN)
			to_chat(user, span_warning("Você não tem habilidade suficiente em pesquisa para criar um circuito!"))
			return

		var/choice = tgui_input_list(user, "Which circuit are you thinking about?", "Circuit Creation", recycleable_circuits)
		if(!choice)
			to_chat(user, span_notice("Você decide contra a criação do circuito..."))
			return

		if(!do_after(user, 5 SECONDS, src))
			to_chat(user, span_warning("Você se moveu, destruindo o circuito!"))
			qdel(src)
			return

		if(!attacking_stack.use(1))
			to_chat(user, span_warning("Você não conseguiu usar o ouro, destruindo o circuito!"))
			qdel(src)
			return

		new choice(get_turf(src))
		qdel(src)
		return

	return ..()
