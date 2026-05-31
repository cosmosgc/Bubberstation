/datum/heretic_knowledge_tree_column/lock
	route = PATH_LOCK
	ui_bgr = "node_lock"
	complexity = "Medium"
	complexity_color = COLOR_YELLOW
	icon = list(
		"icon" = 'icons/obj/weapons/khopesh.dmi',
		"state" = "key_blade",
		"frame" = 1,
		"dir" = SOUTH,
		"moving" = FALSE,
	)
	description = list(
		"The Path of Lock revolves around access, area denial, theft and gadgets.",
		"Pick this path if you want a less confrontational playstyle and more interested in being a slippery rat.",
	)
	pros = list(
		"Your mansus grasp can open any lock, unlock every terminal and bypass any access restriction.",
		"lock heretics get a discount from the knowledge shop, making it the perfect path if you want to experiment with the various trinkets the shop has to offer.",
	)
	cons = list(
		"The weakest heretic path in direct combat, period.",
		"Very limited direct combat benefits.",
		"You have no defensive benefits or immunities.",
		"no mobility or direct additional teleportation",
		"Highly reliant on sourcing power from other departments, players and the game world.",
	)
	tips = list(
		"Your mansus grasp allows you to access everything, from airlocks, consoles and even exosuits, but it has no additional effects on players. It will however leave a mark that when triggered will make your victim unable to leave the room you are in.",
		"Your blade also functions as a crowbar! You can store it in utility belts And, in a pitch, use it to force open an airlock.",
		"Your Eldritch ID can create a portal between 2 different airlocks. Useful if you want to enstablish a secret base.",
		"Use your labyrinth book to shake off pursuers. It creates impassible walls to anyone but you.",
	)

	start = /datum/heretic_knowledge/limited_amount/starting/base_lock
	knowledge_tier1 = /datum/heretic_knowledge/key_ring
	guaranteed_side_tier1 = /datum/heretic_knowledge/painting
	knowledge_tier2 = /datum/heretic_knowledge/limited_amount/concierge_rite
	guaranteed_side_tier2 = /datum/heretic_knowledge/spell/opening_blast
	robes = /datum/heretic_knowledge/armor/lock
	knowledge_tier3 = /datum/heretic_knowledge/spell/burglar_finesse
	guaranteed_side_tier3 = /datum/heretic_knowledge/summon/fire_shark
	blade = /datum/heretic_knowledge/blade_upgrade/flesh/lock
	knowledge_tier4 = /datum/heretic_knowledge/spell/caretaker_refuge
	ascension = /datum/heretic_knowledge/ultimate/lock_final

/datum/heretic_knowledge/limited_amount/starting/base_lock
	name = "A Steward's Secret"
	desc = "Abre o caminho da fechadura para você. Permite que transmute uma faca e um pé de cabra em uma lâmina chave. Você só pode criar dois de cada vez e eles funcionam como pé de cabra rápido. Além disso, eles podem caber em cintos utilitários."
	gain_text = "O Labirinto Fechado leva à liberdade. Mas só os guardas presos conhecem o caminho certo."
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/crowbar = 1,
	)
	result_atoms = list(/obj/item/melee/sickly_blade/lock)
	limit = 2
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "key_blade"
	mark_type = /datum/status_effect/eldritch/lock
	eldritch_passive = /datum/status_effect/heretic_passive/lock

/datum/heretic_knowledge/limited_amount/starting/base_lock/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	RegisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK_SECONDARY, PROC_REF(on_secondary_mansus_grasp))
	var/datum/action/cooldown/spell/touch/mansus_grasp/grasp_spell = locate() in user.actions
	grasp_spell?.invocation_type = INVOCATION_NONE
	grasp_spell?.sound = null

/datum/heretic_knowledge/limited_amount/starting/base_lock/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	UnregisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK_SECONDARY)

/datum/heretic_knowledge/limited_amount/starting/base_lock/on_mansus_grasp(mob/living/source, mob/living/target)
	. = ..()

	var/obj/item/clothing/under/suit = target.get_item_by_slot(ITEM_SLOT_ICLOTHING)
	if(!suit.can_adjust)
		return
	if(istype(suit) && suit.adjusted == NORMAL_STYLE)
		suit.toggle_jumpsuit_adjust()
		suit.update_appearance()

/datum/heretic_knowledge/limited_amount/starting/base_lock/proc/on_secondary_mansus_grasp(mob/living/source, atom/target)
	SIGNAL_HANDLER

	if(ismecha(target))
		var/obj/vehicle/sealed/mecha/mecha = target
		mecha.dna_lock = null
		mecha.mecha_flags &= ~ID_LOCK_ON
		for(var/mob/living/occupant as anything in mecha.occupants)
			if(isAI(occupant))
				continue
			mecha.mob_exit(occupant, randomstep = TRUE)
			occupant.Paralyze(5 SECONDS)
	else if(istype(target,/obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/door = target
		door.unbolt()
	else if(istype(target, /obj/machinery/computer))
		var/obj/machinery/computer/computer = target
		computer.authenticated = TRUE
		computer.balloon_alert(source, "unlocked")

	var/turf/target_turf = get_turf(target)
	SEND_SIGNAL(target_turf, COMSIG_ATOM_MAGICALLY_UNLOCKED, src, source)
	SEND_SOUND(source, 'sound/effects/magic/hereticknock.ogg')

	if(HAS_TRAIT(source, TRAIT_LOCK_GRASP_UPGRADED))
		var/datum/action/cooldown/spell/touch/mansus_grasp/grasp = locate() in source.actions
		if(grasp)
			grasp.next_use_time -= round(grasp.cooldown_time*0.75)
			grasp.build_all_button_icons()
		return

	return COMPONENT_USE_HAND

/datum/heretic_knowledge/key_ring
	name = "Key Keeper’s Burden"
	desc = "Permite que transmute uma carteira, uma vara de ferro e um cartão de identidade para criar um cartão Eldritch. Bata em um par de comportas com ele para criar um par de portais, que irá teletransportá-lo entre eles, mas teletransportar não hereges aleatoriamente. Você pode clicar no cartão para inverter esse comportamento para portais criados. Cada carta só pode sustentar um par de portais ao mesmo tempo. Ele também funciona e parece o mesmo que um cartão de identificação regular. Atacá-lo com um cartão de identidade normal o consome e ganha seu acesso, e você pode usá-lo para mudar sua aparência para um cartão que você fundiu."
	gain_text = "O Guardião escarneceu.\"Estes retângulos de plástico são uma zombaria das chaves, e eu amaldiçoo cada porta que as deseja.\""
	required_atoms = list(
		/obj/item/storage/wallet = 1,
		/obj/item/stack/rods = 1,
		/obj/item/card/id/advanced = 1,
	)
	result_atoms = list(/obj/item/card/id/advanced/heretic)
	cost = 2
	research_tree_icon_path = 'icons/obj/card.dmi'
	research_tree_icon_state = "card_gold"

/datum/heretic_knowledge/key_ring/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/obj/item/card/id = locate(/obj/item/card/id/advanced) in selected_atoms
	if(isnull(id))
		return FALSE
	var/obj/item/card/id/advanced/heretic/result_item = new(loc)
	if(!istype(result_item))
		return FALSE
	selected_atoms -= id
	result_item.eat_card(id)
	result_item.shapeshift(id)
	return TRUE

/datum/heretic_knowledge/limited_amount/concierge_rite
	name = "Concierge's Rite"
	desc = "Permite que transmute um lápis de cera, uma tábua de madeira, e uma multitool para criar um Manual Labirinto. Pode materializar uma barricada ao alcance que só você e as pessoas resistentes à magia podem passar. Tem 5 cargas que se regeneram com o tempo."
	gain_text = "O Concierge rabiscou meu nome no Manual.\"Bem-vindo à sua nova casa, companheiro Steward.\""
	required_atoms = list(
		/obj/item/toy/crayon = 1,
		/obj/item/stack/sheet/mineral/wood = 1,
		/obj/item/multitool = 1,
	)
	result_atoms = list(/obj/item/heretic_labyrinth_handbook)
	cost = 2
	research_tree_icon_path = 'icons/obj/service/library.dmi'
	research_tree_icon_state = "heretichandbook"
	drafting_tier = 5

/datum/heretic_knowledge/armor/lock
	desc = "Permite que transmute uma mesa (ou um terno), uma máscara e um pé de cabra para criar um disfarce. Concede camuflagem das câmeras, esconde sua identidade, voz e abafa seus passos. Atua como foco enquanto encapuza."
	gain_text = "Enquanto os mordomos são conhecidos pelo Concierge, eles ainda consorciam entre si e com estranhos sob capas sombreadas e capas desenhadas. Familiaridade é traição, até para si mesmo."
	result_atoms = list(/obj/item/clothing/suit/hooded/cultrobes/eldritch/lock)
	research_tree_icon_state = "lock_armor"
	required_atoms = list(
		list(/obj/structure/table, /obj/item/clothing/suit) = 1,
		/obj/item/clothing/mask = 1,
		/obj/item/crowbar = 1,
	)

/datum/heretic_knowledge/spell/burglar_finesse
	name = "Burglar's Finesse"
	desc = "Concede-lhe Finesse do ladrão, um feitiço de um único alvo que coloca um item aleatório da mochila das vítimas em sua mão."
	gain_text = "Consortir-se com espíritos assaltantes é desaprovado, mas um criado sempre vai querer aprender sobre novas portas."

	action_to_add = /datum/action/cooldown/spell/pointed/burglar_finesse
	cost = 2

/datum/heretic_knowledge/blade_upgrade/flesh/lock
	name = "Opening Blade"
	desc = "Sua lâmina pode causar uma avulsão ao ataque."
	gain_text = "O cirurgião peregrino não era um criado. No entanto, suas lâminas e suturas provaram ser compatíveis com suas chaves."
	wound_type = /datum/wound/slash/flesh/critical
	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "blade_upgrade_lock"
	var/chance = 35

/datum/heretic_knowledge/blade_upgrade/flesh/lock/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	if(prob(chance))
		return ..()

/datum/heretic_knowledge/spell/caretaker_refuge
	name = "Caretaker’s Last Refuge"
	desc = "Te dá um feitiço que te torna transparente e não denso. Não pode ser usado perto de seres sencientes vivos. Enquanto está em refúgio, você não pode usar suas mãos ou feitiços, e você é imune a desacelerar. Você é invencível, mas incapaz de prejudicar nada. Cancelado por ser atingido com um item anti-mágico."
	gain_text = "Ciúmes, a Guarda e o Cão de Caça me caçaram. Mas eu desbloqueei minha forma, e era apenas uma névoa, intocável."
	action_to_add = /datum/action/cooldown/spell/caretaker
	cost = 2
	is_final_knowledge = TRUE

/datum/heretic_knowledge/ultimate/lock_final
	name = "Unlock the Labyrinth"
	desc = "O ritual de ascensão do Caminho do Knock. Traga 3 cadáveres sem órgãos no tronco para uma runa de transmutação para completar o ritual. Quando terminar, você ganha a habilidade de se transformar em criaturas eldritch poderosas e suas lâminas de chave se tornarão ainda mais mortais. Além disso, você vai criar uma lágrima no coração do Labirinto, uma lágrima na realidade localizada no local deste ritual. Criaturas Eldritch derramarão infinitamente desta fenda que estão obrigadas a obedecer suas instruções."
	gain_text = "Os criados me guiaram, e eu os guiei. Meus inimigos eram as fechaduras e minhas lâminas eram a chave! O Labirinto não será mais trancado, e a liberdade será nossa! TESTEMUNHA NÓS!"
	required_atoms = list(/mob/living/carbon/human = 3)
	ascension_achievement = /datum/award/achievement/misc/lock_ascension
	announcement_text = "Anomalia dimensional de classe Delta detectada. Portais abertos, portas abertas, %NAME% subiu! Medo da maré! SPOOKY"
	announcement_sound = 'sound/music/antag/heretic/ascend_knock.ogg'

/datum/heretic_knowledge/ultimate/lock_final/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/body in atoms)
		if(body.stat != DEAD)
			continue
		if(LAZYLEN(body.get_organs_for_zone(BODY_ZONE_CHEST)))
			to_chat(user, span_hierophant_warning("[body]tem órgãos no peito."))
			continue

		selected_atoms += body

	if(!LAZYLEN(selected_atoms))
		loc.balloon_alert(user, "O ritual falhou, não há corpos válidos suficientes!")
		return FALSE
	return TRUE

/datum/heretic_knowledge/ultimate/lock_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	// buffs
	var/datum/action/cooldown/spell/shapeshift/eldritch/ascension/transform_spell = new(user.mind)
	transform_spell.Grant(user)
	var/datum/antagonist/heretic/heretic_datum = GET_HERETIC(user)
	var/datum/heretic_knowledge/blade_upgrade/flesh/lock/blade_upgrade = heretic_datum.get_knowledge(/datum/heretic_knowledge/blade_upgrade/flesh/lock)
	blade_upgrade.chance += 30
	new /obj/structure/lock_tear(loc, user.mind)
