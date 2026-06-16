//defines the drill hat's yelling setting
#define DRILL_DEFAULT "default"
#define DRILL_SHOUTING "shouting"
#define DRILL_YELLING "yelling"
#define DRILL_CANADIAN "canadian"

//Chef
/obj/item/clothing/head/utility/chefhat
	name = "chef's hat"
	inhand_icon_state = "chefhat"
	icon_state = "chef"
	desc = "O comandante na cabeça do chef usar."
	strip_delay = 1 SECONDS
	equip_delay_other = 1 SECONDS
	dog_fashion = /datum/dog_fashion/head/chef
	/// The chance that the movements of a mouse inside of this hat get relayed to the human wearing the hat
	var/mouse_control_probability = 20
	/// Allowed time between movements
	COOLDOWN_DECLARE(move_cooldown)
	pickup_sound = null
	drop_sound = null
	equip_sound = null

/// Admin variant of the chef hat where every mouse pilot input will always be transferred to the wearer
/obj/item/clothing/head/utility/chefhat/i_am_assuming_direct_control
	desc = "O comandante na cabeça do chef usar. Após inspeção mais próxima, parece haver dezenas de pequenas alavancas, botões, mostradores e telas dentro deste chapéu. Que diabos...?"
	mouse_control_probability = 100

/obj/item/clothing/head/utility/chefhat/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/chefhat)

/obj/item/clothing/head/utility/chefhat/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	var/mob/living/basic/new_boss = get_mouse(arrived)
	if(!new_boss)
		return
	RegisterSignal(new_boss, COMSIG_MOB_PRE_EMOTED, PROC_REF(on_mouse_emote))
	RegisterSignal(new_boss, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(on_mouse_moving))
	RegisterSignal(new_boss, COMSIG_MOB_CLIENT_PRE_LIVING_MOVE, PROC_REF(on_mouse_moving))

/obj/item/clothing/head/utility/chefhat/Exited(atom/movable/gone, direction)
	. = ..()
	var/mob/living/basic/old_boss = get_mouse(gone)
	if(!old_boss)
		return
	UnregisterSignal(old_boss, list(COMSIG_MOB_PRE_EMOTED, COMSIG_MOVABLE_PRE_MOVE, COMSIG_MOB_CLIENT_PRE_LIVING_MOVE))

/// Returns a mob stored inside a mob container, if there is one
/obj/item/clothing/head/utility/chefhat/proc/get_mouse(atom/possible_mouse)
	if (!ispickedupmob(possible_mouse))
		return
	var/obj/item/mob_holder/mousey_holder = possible_mouse
	return locate(/mob/living/basic) in mousey_holder.contents

/// Relays emotes emoted by your boss to the hat wearer for full immersion
/obj/item/clothing/head/utility/chefhat/proc/on_mouse_emote(mob/living/source, key, emote_message, type_override, intentional, datum/emote/emote)
	SIGNAL_HANDLER
	var/mob/living/carbon/wearer = loc
	if(!wearer || INCAPACITATED_IGNORING(wearer, INCAPABLE_RESTRAINTS))
		return
	if (!prob(mouse_control_probability))
		return COMPONENT_CANT_EMOTE
	INVOKE_ASYNC(wearer, TYPE_PROC_REF(/mob, emote), key, type_override, emote_message, FALSE)
	return COMPONENT_CANT_EMOTE

/// Relays movement made by the mouse in your hat to the wearer of the hat
/obj/item/clothing/head/utility/chefhat/proc/on_mouse_moving(mob/living/source, atom/moved_to)
	SIGNAL_HANDLER
	if (!prob(mouse_control_probability) || !COOLDOWN_FINISHED(src, move_cooldown))
		return COMPONENT_MOVABLE_BLOCK_PRE_MOVE // Didn't roll well enough or on cooldown

	var/mob/living/carbon/wearer = loc
	if(!wearer || INCAPACITATED_IGNORING(wearer, INCAPABLE_RESTRAINTS))
		return COMPONENT_MOVABLE_BLOCK_PRE_MOVE // Not worn or can't move

	var/move_direction = get_dir(wearer, moved_to)
	if(!wearer.Process_Spacemove(move_direction))
		return COMPONENT_MOVABLE_BLOCK_PRE_MOVE // Currently drifting in space
	if(!has_gravity() || !isturf(wearer.loc))
		return COMPONENT_MOVABLE_BLOCK_PRE_MOVE // Not in a location where we can move

	step_towards(wearer, moved_to)
	var/move_delay = wearer.cached_multiplicative_slowdown
	if (ISDIAGONALDIR(move_direction))
		move_delay *= sqrt(2)
	COOLDOWN_START(src, move_cooldown, move_delay)
	return COMPONENT_MOVABLE_BLOCK_PRE_MOVE

/obj/item/clothing/head/utility/chefhat/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] Está donando.[src] Parece que...[user.p_theyre()] Tentando se rasgar um chef."))
	user.say("Bork Bork Bork!", forced = "chef hat suicide")
	sleep(2 SECONDS)
	user.visible_message(span_suicide("[user] sobe em um forno imaginário!"))
	user.say("BOOORK!", forced = "chef hat suicide")
	playsound(user, 'sound/machines/ding.ogg', 50, TRUE)
	return FIRELOSS

//Captain
/obj/item/clothing/head/hats/caphat
	name = "captain's hat"
	desc = "É bom ser o rei."
	icon_state = "captain"
	inhand_icon_state = "that"
	flags_inv = 0
	armor_type = /datum/armor/hats_caphat
	strip_delay = 6 SECONDS
	dog_fashion = /datum/dog_fashion/head/captain

//Captain: This is no longer space-worthy
/datum/armor/hats_caphat
	melee = 25
	bullet = 15
	laser = 25
	energy = 35
	bomb = 25
	fire = 50
	acid = 50
	wound = 5

/obj/item/clothing/head/hats/caphat/parade
	name = "captain's parade cap"
	desc = "Usado apenas por capitães com uma abundância de classe."
	icon_state = "capcap"
	dog_fashion = null

/obj/item/clothing/head/hats/caphat/bicorne
	name = "captain's bicorne"
	desc = "Why be king when you can be Emperor?"
	icon_state = "capbicorne"
	dog_fashion = null

/obj/item/clothing/head/caphat/beret
	name = "captain's beret"
	desc = "Para os capitães conhecidos por seu senso de moda."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/caphat/beret"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#0070B7#FFCE5B"
	hair_mask = /datum/hair_mask/standard_hat_middle

//Head of Personnel
/obj/item/clothing/head/hats/hopcap
	name = "head of personnel's cap"
	icon_state = "hopcap"
	desc = "O símbolo da verdadeira microgestão burocrática."
	armor_type = /datum/armor/hats_hopcap
	dog_fashion = /datum/dog_fashion/head/hop

//Chaplain
/datum/armor/hats_hopcap
	melee = 25
	bullet = 15
	laser = 25
	energy = 35
	bomb = 25
	fire = 50
	acid = 50

/obj/item/clothing/head/chaplain/nun_hood
	name = "nun hood"
	desc = "Piedade máxima neste sistema estelar."
	icon_state = "nun_hood"
	flags_inv = HIDEHAIR
	flags_cover = HEADCOVERSEYES

/obj/item/clothing/head/chaplain/habit_veil
	name = "nun veil"
	desc = "Sem roupa de freira."
	icon_state = "nun_hood_alt"
	flags_inv = HIDEHAIR | HIDEEARS
	clothing_flags = SNUG_FIT // can't be knocked off by throwing a paper hat.

/obj/item/clothing/head/chaplain/bishopmitre
	name = "bishop mitre"
	desc = "Um chapéu opulento que funciona como um rádio para Deus. Ou como pára-raios, dependendo de quem perguntar."
	icon_state = "bishopmitre"

#define CANDY_CD_TIME 2 MINUTES

//Detective
/obj/item/clothing/head/fedora/det_hat
	name = "detective's fedora"
	desc = "Só há um homem que pode farejar o fedor sujo do crime, e provavelmente está usando este chapéu."
	armor_type = /datum/armor/fedora_det_hat
	icon_state = "detective"
	interaction_flags_click = NEED_DEXTERITY|NEED_HANDS|ALLOW_RESTING
	dog_fashion = /datum/dog_fashion/head/detective
	/// Path for the flask that spawns inside their hat roundstart
	var/flask_path = /obj/item/reagent_containers/cup/glass/flask/det
	/// Cooldown for retrieving precious candy corn with rmb
	COOLDOWN_DECLARE(candy_cooldown)

/datum/armor/fedora_det_hat
	melee = 25
	bullet = 5
	laser = 25
	energy = 35
	fire = 30
	acid = 50
	wound = 5

/obj/item/clothing/head/fedora/det_hat/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/small/fedora/detective)

	register_context()

	new flask_path(src)


/obj/item/clothing/head/fedora/det_hat/examine(mob/user)
	. = ..()
	. += span_notice("Alt-clique para pegar um milhão doce.")


/obj/item/clothing/head/fedora/det_hat/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	context[SCREENTIP_CONTEXT_ALT_LMB] = "Candy Time"

	return CONTEXTUAL_SCREENTIP_SET


/// Now to solve where all these keep coming from
/obj/item/clothing/head/fedora/det_hat/click_alt(mob/user)
	if(!COOLDOWN_FINISHED(src, candy_cooldown))
		to_chat(user, span_warning("Um doce de milho foi levado! Você deve esperar alguns minutos, para não queimar o estoque."))
		return CLICK_ACTION_BLOCKING

	var/obj/item/food/candy_corn/sweets = new /obj/item/food/candy_corn(src)
	user.put_in_hands(sweets)
	to_chat(user, span_notice("Você tira um doce de milho\the [src]."))
	COOLDOWN_START(src, candy_cooldown, CANDY_CD_TIME)

	return CLICK_ACTION_SUCCESS


#undef CANDY_CD_TIME

/obj/item/clothing/head/fedora/det_hat/minor
	flask_path = /obj/item/reagent_containers/cup/glass/flask/det/minor

/obj/item/clothing/head/fedora/det_hat/noir
	name = "detective's noir fedora"
	desc = "There's only one man who can recklessly discharge a firearm into a crowded street while trying to stop a criminal, \
		and he's likely wearing this hat."
	icon_state = /obj/item/clothing/head/fedora::icon_state

///Detectives Fedora, but like Inspector Gadget. Not a subtype to not inherit candy corn stuff
/obj/item/clothing/head/fedora/inspector_hat
	name = "inspector's fedora"
	desc = "Só um homem pode tentar deter um vilão mau."
	armor_type = /datum/armor/fedora_det_hat
	icon_state = "detective"
	dog_fashion = /datum/dog_fashion/head/detective
	interaction_flags_click = FORBID_TELEKINESIS_REACH|ALLOW_RESTING
	///prefix our phrases must begin with
	var/prefix = "go go gadget"
	///an assoc list of regex = item (like regex datum = revolver item)
	var/list/items_by_regex = list()
	///A an assoc list of regex = phrase (like regex datum = gun text)
	var/list/phrases_by_regex = list()
	///how many gadgets can we hold
	var/max_items = 4
	///items above this weight cannot be put in the hat
	var/max_weight = WEIGHT_CLASS_NORMAL

/obj/item/clothing/head/fedora/inspector_hat/Initialize(mapload)
	. = ..()
	become_hearing_sensitive(ROUNDSTART_TRAIT)
	QDEL_NULL(atom_storage)

/obj/item/clothing/head/fedora/inspector_hat/proc/set_prefix(desired_prefix)

	prefix = desired_prefix

	// Regenerated the phrases here.
	for(var/old_regex in phrases_by_regex)
		var/old_phrase = phrases_by_regex[old_regex]
		var/obj/item/old_item = items_by_regex[old_regex]
		items_by_regex -= old_regex
		phrases_by_regex -= old_regex
		set_phrase(old_phrase,old_item)

	return TRUE

/obj/item/clothing/head/fedora/inspector_hat/proc/set_phrase(desired_phrase,obj/item/associated_item)

	var/regex/phrase_regex = regex("[prefix]\[\\s\\W\]+[desired_phrase]","i")

	phrases_by_regex[phrase_regex] = desired_phrase
	items_by_regex[phrase_regex] = associated_item

	return TRUE

/obj/item/clothing/head/fedora/inspector_hat/examine(mob/user)
	. = ..()
	. += span_notice("Você pode colocar itens dentro, e tirá-los dizendo uma frase, ou usando na mão!")
	. += span_notice("O prefixo é<b>[prefix]</b>, e você pode mudá-lo com alt-click!\n")
	for(var/found_regex in phrases_by_regex)
		var/found_phrase = phrases_by_regex[found_regex]
		var/obj/item/found_item = items_by_regex[found_regex]
		. += span_notice("[icon2html(found_item, user)] Você pode remover [found_item] Dizendo<b>\"[prefix] [found_phrase]\"</b>!")

/obj/item/clothing/head/fedora/inspector_hat/Hear(atom/movable/speaker, message_language, raw_message, radio_freq, radio_freq_name, radio_freq_color, list/spans, list/message_mods = list(), message_range)
	. = ..()
	var/mob/living/carbon/wearer = loc
	if(!istype(wearer) || speaker != wearer) //if we are worn
		return

	raw_message = htmlrendertext(raw_message)

	for(var/regex/found_regex as anything in phrases_by_regex)
		if(!found_regex.Find(raw_message))
			continue
		var/obj/item/found_item = items_by_regex[found_regex]
		if(wearer.put_in_hands(found_item))
			wearer.visible_message(span_warning("[src] Gotas [found_item] nas mãos de [wearer]!"))
			. = TRUE
		else
			balloon_alert(wearer, "Não posso colocar em mãos!")
			break

	return .

/obj/item/clothing/head/fedora/inspector_hat/attackby(obj/item/item, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()

	if(LAZYLEN(contents) >= max_items)
		balloon_alert(user, "Cheio!")
		return
	if(item.w_class > max_weight)
		balloon_alert(user, "Grandes demais!")
		return

	var/desired_phrase = tgui_input_text(user, "What is the activation phrase?", "Activation phrase", "gadget", max_length = 26)
	if(!desired_phrase || !user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return

	if(item.loc != user || !user.transferItemToLoc(item, src))
		return

	to_chat(user, span_notice("Você instala.[item] Parao [thtotext(contents.len)] slot of [src]."))
	playsound(src, 'sound/machines/click.ogg', 30, TRUE)
	set_phrase(desired_phrase,item)

	return TRUE

/obj/item/clothing/head/fedora/inspector_hat/attack_self(mob/user)
	. = ..()
	if(!length(items_by_regex))
		return CLICK_ACTION_BLOCKING
	var/list/found_items = list()
	for(var/found_regex in items_by_regex)
		found_items += items_by_regex[found_regex]
	var/obj/found_item = tgui_input_list(user, "What item do you want to remove?", "Item Removal", found_items)
	if(!found_item || !user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return CLICK_ACTION_BLOCKING
	user.put_in_inactive_hand(found_item)

/obj/item/clothing/head/fedora/inspector_hat/click_alt(mob/user)
	var/new_prefix = tgui_input_text(user, "What should be the new prefix?", "Activation prefix", prefix, max_length = 24)
	if(!new_prefix || !user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return CLICK_ACTION_BLOCKING
	set_prefix(new_prefix)
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/head/fedora/inspector_hat/Exited(atom/movable/gone, direction)
	. = ..()
	for(var/found_regex in items_by_regex)
		var/obj/item/found_item = items_by_regex[found_regex]
		if(gone != found_item)
			continue
		items_by_regex -= found_regex
		phrases_by_regex -= found_regex
		break

/obj/item/clothing/head/fedora/inspector_hat/atom_destruction(damage_flag)

	var/atom/atom_location = drop_location()
	for(var/found_regex in items_by_regex)
		var/obj/item/result = items_by_regex[found_regex]
		result.forceMove(atom_location)
		items_by_regex -= found_regex
		phrases_by_regex -= found_regex

	return ..()

/obj/item/clothing/head/fedora/inspector_hat/Destroy()
	QDEL_LIST_ASSOC(items_by_regex) //Anything that failed to drop gets deleted.
	return ..()

//Mime
/obj/item/clothing/head/beret
	name = "beret"
	desc = "Uma boina, a roupa favorita de um mímico."
	dog_fashion = /datum/dog_fashion/head/beret
	icon = 'icons/map_icons/clothing/head/beret.dmi'
	icon_state = "/obj/item/clothing/head/beret"
	post_init_icon_state = "beret"
	greyscale_config = /datum/greyscale_config/beret
	greyscale_config_worn = /datum/greyscale_config/beret/worn
	greyscale_colors = "#972A2A"
	flags_1 = IS_PLAYER_COLORABLE_1
	hair_mask = /datum/hair_mask/standard_hat_middle

//Security
/obj/item/clothing/head/hats/hos
	name = "generic head of security hat"
	desc = "Por favor, entre em contato com o Departamento de Costumes de Nanotrasen."
	abstract_type = /obj/item/clothing/head/hats/hos
	armor_type = /datum/armor/hats_hos
	strip_delay = 8 SECONDS

/obj/item/clothing/head/hats/hos/cap
	name = "head of security cap"
	desc = "A robusta tampa padrão do chefe de segurança. Por mostrar aos oficiais quem está no comando. Parece um pouco forte."
	icon_state = "hoscap"

/obj/item/clothing/head/hats/hos/cap/Initialize(mapload)
	. = ..()
	// Give it a little publicity
	var/static/list/slapcraft_recipe_list = list(		/datum/crafting_recipe/sturdy_shako,		)

	AddElement(
		/datum/element/slapcrafting,		slapcraft_recipes = slapcraft_recipe_list,	)

/datum/armor/hats_hos
	melee = 40
	bullet = 30
	laser = 25
	energy = 35
	bomb = 25
	bio = 10
	fire = 50
	acid = 60
	wound = 10

/obj/item/clothing/head/hats/hos/cap/syndicate
	name = "syndicate cap"
	desc = "Um boné preto para um alto oficial do sindicato."

/obj/item/clothing/head/hats/hos/shako
	name = "sturdy shako"
	desc = "Usar isso faz você querer gritar\"Desça e me dê vinte!\"com alguém."
	icon_state = "hosshako"
	worn_icon = 'icons/mob/large-worn-icons/64x64/head.dmi'
	worn_x_dimension = 64
	worn_y_dimension = 64
	custom_materials = list(/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 2, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/clothing/head/hats/hos/beret
	name = "head of security's beret"
	desc = "Uma boina robusta para o Chefe de Segurança, por parecer elegante e não sacrificar proteção."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/hats/hos/beret"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#39393f#f0cc8f"
	hair_mask = /datum/hair_mask/standard_hat_middle

/obj/item/clothing/head/hats/hos/beret/navyhos
	name = "head of security's formal beret"
	desc = "Uma boina especial com a insígnia do Chefe de Segurança. Um símbolo de excelência, um distintivo de coragem, uma marca de distinção."
	icon_state = "/obj/item/clothing/head/hats/hos/beret/navyhos"
	greyscale_colors = "#638799#f0cc8f"

/obj/item/clothing/head/hats/hos/beret/syndicate
	name = "syndicate beret"
	desc = "Uma boina preta com armadura grossa dentro. Elegante e robusto."

/obj/item/clothing/head/hats/warden
	name = "warden's police hat"
	desc = "É um chapéu blindado especial emitido ao Diretor de uma força de segurança. Protege a cabeça de impactos."
	icon_state = "policehelm"
	armor_type = /datum/armor/hats_warden
	strip_delay = 6 SECONDS
	dog_fashion = /datum/dog_fashion/head/warden

/datum/armor/hats_warden
	melee = 40
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 30
	acid = 60
	wound = 5

/obj/item/clothing/head/hats/warden/police
	name = "police officer's hat"
	desc = "Um chapéu de policial. Este chapéu enfatiza que você é a lei."

/obj/item/clothing/head/hats/warden/red
	name = "warden's hat"
	desc = "Um chapéu vermelho do diretor. Olhar para ele dá a sensação de querer manter as pessoas nas celas o máximo possível."
	icon_state = "wardenhat"
	dog_fashion = /datum/dog_fashion/head/warden_red

/obj/item/clothing/head/hats/warden/drill
	name = "warden's campaign hat"
	desc = "Um chapéu especial com a insígnia de segurança. Usa tecido reforçado para oferecer proteção suficiente."
	icon_state = "wardendrill"
	inhand_icon_state = null
	dog_fashion = null
	var/mode = DRILL_DEFAULT

/obj/item/clothing/head/hats/warden/drill/screwdriver_act(mob/living/carbon/human/user, obj/item/I)
	if(..())
		return TRUE
	switch(mode)
		if(DRILL_DEFAULT)
			to_chat(user, span_notice("Ajuste o circuito de voz para a posição central."))
			mode = DRILL_SHOUTING
		if(DRILL_SHOUTING)
			to_chat(user, span_notice("Ajuste o circuito de voz para a última posição."))
			mode = DRILL_YELLING
		if(DRILL_YELLING)
			to_chat(user, span_notice("Ajuste o circuito de voz para a primeira posição."))
			mode = DRILL_DEFAULT
		if(DRILL_CANADIAN)
			to_chat(user, span_danger("Você ajusta o circuito de voz, mas nada acontece, provavelmente porque está quebrado."))
	return TRUE

/obj/item/clothing/head/hats/warden/drill/wirecutter_act(mob/living/user, obj/item/I)
	..()
	if(mode != DRILL_CANADIAN)
		to_chat(user, span_danger("Você quebrou o circuito de voz!"))
		mode = DRILL_CANADIAN
	return TRUE

/obj/item/clothing/head/hats/warden/drill/equipped(mob/M, slot)
	. = ..()
	if (slot & ITEM_SLOT_HEAD)
		RegisterSignal(M, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	else
		UnregisterSignal(M, COMSIG_MOB_SAY)

/obj/item/clothing/head/hats/warden/drill/dropped(mob/M)
	. = ..()
	UnregisterSignal(M, COMSIG_MOB_SAY)

/obj/item/clothing/head/hats/warden/drill/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		switch (mode)
			if(DRILL_SHOUTING)
				message += "!"
			if(DRILL_YELLING)
				message += "!!"
			if(DRILL_CANADIAN)
				message = "[message]"
				var/list/canadian_words = strings("canadian_replacement.json", "canadian")

				for(var/key in canadian_words)
					var/value = canadian_words[key]
					if(islist(value))
						value = pick(value)

					message = replacetextEx(message, " [uppertext(key)]", " [uppertext(value)]")
					message = replacetextEx(message, " [capitalize(key)]", " [capitalize(value)]")
					message = replacetextEx(message, " [key]", " [value]")

				if(prob(30))
					message += pick(", eh?", ", EH?")
		speech_args[SPEECH_MESSAGE] = message

/obj/item/clothing/head/beret/sec
	name = "security beret"
	desc = "Uma boina robusta com a insígnia de segurança. Usa tecido reforçado para oferecer proteção suficiente."
	icon_state = "/obj/item/clothing/head/beret/sec"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#a52f29#F2F2F2"
	armor_type = /datum/armor/cosmetic_sec
	strip_delay = 6 SECONDS
	dog_fashion = null
	flags_1 = NONE

/datum/armor/cosmetic_sec
	melee = 30
	bullet = 25
	laser = 25
	energy = 35
	bomb = 25
	fire = 20
	acid = 50
	wound = 5

/obj/item/clothing/head/beret/sec/navywarden
	name = "warden's beret"
	desc = "Uma boina especial com a insígnia do diretor. Para diretores com classe."
	icon_state = "/obj/item/clothing/head/beret/sec/navywarden"
	greyscale_colors = "#638799#ebebeb"
	strip_delay = 6 SECONDS

/obj/item/clothing/head/beret/sec/navyofficer
	desc = "Uma boina especial com a insígnia de segurança. Para oficiais com classe."
	icon_state = "/obj/item/clothing/head/beret/sec/navyofficer"
	greyscale_colors = "#638799#a52f29"

//Science
/obj/item/clothing/head/beret/science
	name = "science beret"
	desc = "Uma boina temática científica para nossos cientistas trabalhadores."
	icon_state = "/obj/item/clothing/head/beret/science"
	greyscale_colors = "#8D008F"
	flags_1 = NONE

/obj/item/clothing/head/beret/science/rd
	desc = "Um distintivo roxo com a insígnia do diretor de pesquisa anexada. Para o embaralhador de papel em você!"
	icon_state = "/obj/item/clothing/head/beret/science/rd"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#7e1980#c9cbcb"

//Medical
/obj/item/clothing/head/beret/medical
	name = "medical beret"
	desc = "Uma boina de sabor médico para o médico em você!"
	icon_state = "/obj/item/clothing/head/beret/medical"
	greyscale_colors = COLOR_WHITE
	flags_1 = NONE

/obj/item/clothing/head/beret/medical/paramedic
	name = "paramedic beret"
	desc = "Por encontrar cadáveres em grande estilo!"
	icon_state = "/obj/item/clothing/head/beret/medical/paramedic"
	greyscale_colors = "#16313D"

/obj/item/clothing/head/beret/medical/cmo
	name = "chief medical officer beret"
	desc = "Uma boina em uma distinta turquesa cirúrgica!"
	icon_state = "/obj/item/clothing/head/beret/medical/cmo"
	greyscale_colors = "#5EB8B8"

/obj/item/clothing/head/utility/surgerycap
	name = "blue surgery cap"
	icon_state = "surgicalcap"
	desc = "Um boné médico azul para evitar que o cabelo do cirurgião entre no interior do paciente!"
	flags_inv = HIDEHAIR //Cover your head doctor!
	w_class = WEIGHT_CLASS_SMALL //surgery cap can be easily crumpled
	pickup_sound = SFX_CLOTH_PICKUP
	drop_sound = SFX_CLOTH_DROP
	equip_sound = null

/obj/item/clothing/head/utility/surgerycap/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -3) //FISH DOCTOR?!

/obj/item/clothing/head/utility/surgerycap/attack_self(mob/user)
	. = ..()
	if(.)
		return
	balloon_alert(user, "[flags_inv & HIDEHAIR ? "loosening" : "tightening"]Cordas...")
	if(!do_after(user, 3 SECONDS, src))
		return
	flags_inv ^= HIDEHAIR
	balloon_alert(user, "[flags_inv & HIDEHAIR ? "tightened" : "loosened "]Cordas.")
	return TRUE

/obj/item/clothing/head/utility/surgerycap/examine(mob/user)
	. = ..()
	. += span_notice("Use em mãos para[flags_inv & HIDEHAIR ? "loosen" : "tighten"]Como cordas.")

/obj/item/clothing/head/utility/surgerycap/purple
	name = "burgundy surgery cap"
	icon_state = "surgicalcapwine"
	desc = "Um boné de cirurgia médica para impedir que o cabelo do cirurgião entre no interior do paciente!"

/obj/item/clothing/head/utility/surgerycap/green
	name = "green surgery cap"
	icon_state = "surgicalcapgreen"
	desc = "Um boné médico verde para evitar que o cabelo do cirurgião entre no interior do paciente!"

/obj/item/clothing/head/utility/surgerycap/cmo
	name = "turquoise surgery cap"
	icon_state = "surgicalcapcmo"
	desc = "O boné médico da OCM para impedir que o cabelo entre no interior do paciente!"

/obj/item/clothing/head/utility/surgerycap/black
	name = "black surgery cap"
	icon_state = "surgicalcapblack"
	desc = "Um boné médico preto para evitar que o cabelo do cirurgião entre no interior do paciente!"

/obj/item/clothing/head/utility/head_mirror
	name = "head mirror"
	desc = "Usado por médicos para olhar nos olhos, ouvidos e boca de um paciente. Um pouco inútil agora, dada a tecnologia disponível, mas certamente completa o visual."
	icon_state = "headmirror"
	body_parts_covered = NONE
	pickup_sound = null
	drop_sound = null
	equip_sound = null

/obj/item/clothing/head/utility/head_mirror/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -3) //FISH DOCTOR?!

/obj/item/clothing/head/utility/head_mirror/examine(mob/user)
	. = ..()
	. += span_notice("Em uma sala bem iluminada, você pode usar isso para examinar os olhos, ouvidos e boca das pessoas.<i>Mais preto.</i>.")

/obj/item/clothing/head/utility/head_mirror/equipped(mob/living/user, slot)
	. = ..()
	if(slot & slot_flags)
		RegisterSignal(user, COMSIG_MOB_EXAMINING_MORE, PROC_REF(examining))
	else
		UnregisterSignal(user, COMSIG_MOB_EXAMINING_MORE)

/obj/item/clothing/head/utility/head_mirror/dropped(mob/living/user)
	. = ..()
	UnregisterSignal(user, COMSIG_MOB_EXAMINING_MORE)

/obj/item/clothing/head/utility/head_mirror/proc/examining(mob/living/examiner, atom/examining, list/examine_list, list/examine_overrides)
	SIGNAL_HANDLER
	if(!ishuman(examining) || examining == examiner || examiner.is_blind() || !examiner.Adjacent(examining))
		return
	var/mob/living/carbon/human/human_examined = examining
	if(!human_examined.get_bodypart(BODY_ZONE_HEAD))
		return
	if(!examiner.has_light_nearby())
		examine_list += span_warning("Você tenta usar o seu [name] Para examinar [examining] A cabeça está melhor... mas está muito escuro. Devia ter investido em uma lâmpada.")
		return
	if(examiner.dir == examining.dir) // disallow examine from behind - every other dir is OK
		examine_list += span_warning("Você tenta usar o seu [name] Para examinar [examining] A cabeça está melhor... mas...[examining.p_theyre()] De frente para o lado errado.")
		return

	var/list/final_message = list("You examine [examining]'s head closer with your [name], you notice [examining.p_they()] [examining.p_have()]...")
	if(human_examined.is_mouth_covered())
		final_message += "\tYou can't see [examining.p_their()] mouth."
	else
		var/obj/item/organ/tongue/has_tongue = human_examined.get_organ_slot(ORGAN_SLOT_TONGUE)
		var/pill_count = 0
		for(var/datum/action/item_action/activate_pill/pill in human_examined.actions)
			pill_count++

		if(pill_count >= 1 && has_tongue)
			final_message += "\t[pill_count] pill\s in [examining.p_their()] mouth, and \a [has_tongue]."
		else if(pill_count >= 1)
			final_message += "\t[pill_count] pill\s in [examining.p_their()] mouth, but oddly no tongue."
		else if(has_tongue)
			final_message += "\t\A [has_tongue] in [examining.p_their()] mouth - go figure."
		else
			final_message += "\tNo tongue in [examining.p_their()] mouth, oddly enough."

	if(human_examined.is_ears_covered())
		final_message += "\tYou can't see [examining.p_their()] ears."
	else
		var/obj/item/organ/ears/has_ears = human_examined.get_organ_slot(ORGAN_SLOT_EARS)
		if(has_ears)
			if(has_ears.temporary_deafness)
				final_message += "\tDamaged eardrums in [examining.p_their()] ear canals."
			else
				final_message += "\tA set of [has_ears.damage ? "" : "healthy "][has_ears.name]."
		else
			final_message += "\tNo eardrums and empty ear canals... how peculiar."

	if(human_examined.is_eyes_covered())
		final_message += "\tYou can't see [examining.p_their()] eyes."
	else
		var/obj/item/organ/eyes/has_eyes = human_examined.get_organ_slot(ORGAN_SLOT_EYES)
		if(has_eyes)
			final_message += "\tA pair of [has_eyes.damage ? "" : "healthy "][has_eyes.name]."
		else
			final_message += "\tEmpty eye sockets."

	examine_list += span_notice("<i>[jointext(final_message, "\n")]</i>")

//Engineering
/obj/item/clothing/head/beret/engi
	name = "engineering beret"
	desc = "Pode não protegê-lo da radiação, mas definitivamente irá protegê-lo de parecer inexpugnável!"
	icon_state = "/obj/item/clothing/head/beret/engi"
	greyscale_colors = "#FFBC30"
	flags_1 = NONE

//Cargo
/obj/item/clothing/head/beret/cargo
	name = "cargo beret"
	desc = "Não precisa compensar quando pode usar esta boina!"
	icon_state = "/obj/item/clothing/head/beret/cargo"
	greyscale_colors = "#b7723d"
	flags_1 = NONE

//Curator
/obj/item/clothing/head/fedora/curator
	name = "treasure hunter's fedora"
	desc = "Recebeu uma mensagem vermelha hoje, mas não significa que tenha que gostar."
	icon_state = "curator"

/obj/item/clothing/head/beret/durathread
	name = "durathread beret"
	desc = "Uma boina feita de Durathread, suas fibras resilientes fornecem proteção ao usuário."
	icon_state = "/obj/item/clothing/head/beret/durathread"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#C5D4F3#ECF1F8"
	armor_type = /datum/armor/beret_durathread

/datum/armor/beret_durathread
	melee = 15
	bullet = 5
	laser = 15
	energy = 25
	bomb = 10
	fire = 30
	acid = 5
	wound = 5

/obj/item/clothing/head/beret/highlander
	desc = "Era tecido branco.<i>Era.</i>"
	dog_fashion = null //THIS IS FOR SLAUGHTER, NOT PUPPIES

/obj/item/clothing/head/beret/highlander/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HIGHLANDER_TRAIT)

//CentCom
/obj/item/clothing/head/beret/centcom_formal
	name = "\improper CentCom Formal Beret"
	desc = "Às vezes, um compromisso entre moda e defesa precisa ser feito. Graças às mais recentes melhorias de durabilidade nano-fabricas de Nanotrasen, desta vez, não é o caso."
	icon_state = "/obj/item/clothing/head/beret/centcom_formal"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#46b946#f2c42e"
	armor_type = /datum/armor/beret_centcom_formal
	strip_delay = 10 SECONDS


#undef DRILL_DEFAULT
#undef DRILL_SHOUTING
#undef DRILL_YELLING
#undef DRILL_CANADIAN

/datum/armor/beret_centcom_formal
	melee = 80
	bullet = 80
	laser = 50
	energy = 50
	bomb = 100
	bio = 100
	fire = 100
	acid = 90
	wound = 10

//Independant Militia
/obj/item/clothing/head/beret/militia
	name = "\improper Militia General's Beret"
	desc = "Um grito de protesto para os habitantes do Setor Spinward, os heróis que usam isso mantêm os horrores da galáxia à distância. Chame-os, e eles estarão lá em um minuto!"
	icon_state = "/obj/item/clothing/head/beret/militia"
	post_init_icon_state = "beret_badge"
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#43523d#a2abb0"
	armor_type = /datum/armor/cosmetic_sec
