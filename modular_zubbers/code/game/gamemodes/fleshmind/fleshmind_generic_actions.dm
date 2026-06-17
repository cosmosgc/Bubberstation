/datum/action/cooldown/fleshmind_create_structure
	name = "Create Tech Structure"
	desc = "Cria uma estrutura tecnológica de sua escolha em sua localização (deve estar em algas)."
	background_icon_state = "bg_fugu"
	button_icon = 'icons/obj/scrolls.dmi'
	button_icon_state = "blueprints"
	cooldown_time = 2 MINUTES
	var/list/possible_structures = list(
		/obj/structure/fleshmind/structure/babbler,
		/obj/structure/fleshmind/structure/whisperer,
		/obj/structure/fleshmind/structure/modulator,
		/obj/structure/fleshmind/structure/screamer,
		/obj/structure/fleshmind/structure/turret,
	)

/datum/action/cooldown/fleshmind_create_structure/Activate(atom/target)
	var/datum/component/human_corruption/our_component = owner.GetComponent(/datum/component/human_corruption)
	if(!our_component?.our_controller)
		to_chat(owner, span_warning("Não há ligação entre colméias e essa energia!"))
		return
	var/datum/fleshmind_controller/owner_controller = our_component.our_controller

	var/list/built_radial_menu = list()
	for(var/obj/iterating_type as anything in possible_structures)
		built_radial_menu[iterating_type] = image(icon = initial(iterating_type.icon), icon_state = initial(iterating_type.icon_state))
	var/obj/structure/fleshmind/structure/picked_stucture_type = show_radial_menu(owner, owner, built_radial_menu, radius = 40)
	if(!picked_stucture_type)
		return
	var/obj/structure/fleshmind/wireweed/under_wireweed = locate() in get_turf(owner)
	if(!under_wireweed)
		to_chat(owner, span_warning("Tem que haver algas debaixo de você!"))
		return
	if(QDELETED(owner_controller)) // Input is not async
		return
	if(initial(picked_stucture_type.required_controller_level) > owner_controller.level)
		to_chat(owner, span_warning("Nosso núcleo de processador ainda não está forte o suficiente!"))
		return
	owner_controller.spawn_structure(get_turf(owner), picked_stucture_type)
	StartCooldownSelf()

/datum/action/cooldown/fleshmind_create_structure/basic
	name = "Create Basic Structure"
	desc = "Cria uma estrutura básica de sua escolha na sua localização."
	button_icon_state = "mjollnir1"
	button_icon = 'icons/obj/weapons/hammer.dmi'
	possible_structures = list(
		/obj/structure/fleshmind/structure/wireweed_door,
		/obj/structure/fleshmind/structure/wireweed_wall,
	)
	cooldown_time = 5 SECONDS

/datum/action/cooldown/fleshmind_flesh_call
	name = "Call Flesh Reinforcements"
	desc = "Todos os mobs de carne vêm para sua localização em um raio."
	background_icon_state = "bg_fugu"
	button_icon = 'icons/obj/signs.dmi'
	button_icon_state = "bio"
	cooldown_time = 2 MINUTES

/datum/action/cooldown/fleshmind_flesh_call/Activate(atom/target)
	for(var/mob/living/basic/fleshmind/iterating_mob in view(DEFAULT_VIEW_RANGE, owner))
		if(iterating_mob.faction_check_atom(owner.get_faction(), iterating_mob))
			continue
		iterating_mob.ai_controller.set_blackboard_key(BB_BASIC_MOB_REINFORCEMENT_TARGET, owner.loc)
	owner.visible_message(span_warning("[owner] lets out a horrible screech!"), span_notice("Você soltou um grito!"))
	playsound(owner, 'modular_skyrat/modules/horrorform/sound/horror_scream.ogg', 100, TRUE)
	StartCooldownSelf()

/datum/action/innate/fleshmind_flesh_chat
	name = "Flesh Chat"
	desc = "Envia uma mensagem para todos os outros seres sencientes."
	background_icon_state = "bg_fugu"
	button_icon = 'icons/mob/actions/actions_changeling.dmi'
	button_icon_state = "hivemind_link"

/datum/action/innate/fleshmind_flesh_chat/Activate(atom/target)
	var/message = tgui_input_text(owner, "Send a message to the fleshmind.", "Flesh Chat")
	if(!message)
		return
	for(var/mob/iterating_mob in GLOB.player_list)
		if(!(iterating_mob.has_faction(FACTION_FLESHMIND)) && !isobserver(iterating_mob))
			continue
		to_chat(iterating_mob, span_purple("<b>FLESHMIND ([owner]):</b> [message]"))

/datum/action/cooldown/fleshmind_plant_weeds
	name = "Create Wireweed"
	desc = "Cria um único pedaço de algas na sua localização."
	button_icon = 'modular_zubbers/icons/fleshmind/fleshmind_structures.dmi'
	background_icon_state = "bg_fugu"
	button_icon_state = "wires-0"
	cooldown_time = 10 SECONDS

/datum/action/cooldown/fleshmind_plant_weeds/Activate(atom/target)
	var/datum/component/human_corruption/our_component = owner.GetComponent(/datum/component/human_corruption)
	if(!our_component?.our_controller)
		to_chat(owner, span_warning("Não há ligação entre colméias e essa energia!"))
		return
	var/datum/fleshmind_controller/owner_controller = our_component.our_controller
	var/obj/structure/fleshmind/wireweed/under_wireweed = locate() in get_turf(owner)
	if(under_wireweed)
		to_chat(owner, span_warning("Já há algas abaixo de você!"))
		return
	owner_controller.spawn_wireweed(get_turf(owner), /obj/structure/fleshmind/wireweed)
	to_chat(owner, span_green("Erva de arame plantada!"))
	StartCooldownSelf()
