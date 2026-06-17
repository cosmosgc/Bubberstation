/obj/machinery/barsign // All Signs are 64 by 32 pixels, they take two tiles
	name = "bar sign"
	desc = "Um sinal de bar que não foi inicializado, de alguma forma. Reclame de um programador!"
	icon = 'icons/obj/machines/barsigns.dmi'
	icon_state = "empty"
	req_access = list(ACCESS_BAR)
	max_integrity = 500
	integrity_failure = 0.5
	armor_type = /datum/armor/sign_barsign
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 0.15
	/// Selected barsign being used
	var/datum/barsign/chosen_sign
	/// Do we attempt to rename the area we occupy when the chosen sign is changed?
	var/change_area_name = FALSE
	/// What kind of sign do we drop upon being disassembled?
	var/disassemble_result = /obj/item/wallframe/barsign

/datum/armor/sign_barsign
	melee = 20
	bullet = 20
	laser = 20
	energy = 100
	fire = 50
	acid = 50

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/barsign, 32)

/obj/machinery/barsign/Initialize(mapload)
	. = ..()
	//Roundstart/map specific barsigns "belong" in their area and should be renaming it, signs created from wallmounts will not.
	change_area_name = mapload
	set_sign(new /datum/barsign/hiddensigns/signoff)
	if(mapload)
		find_and_mount_on_atom()

/obj/machinery/barsign/proc/set_sign(datum/barsign/sign)
	if(!istype(sign))
		return

	var/area/bar_area = get_area(src)
	if(change_area_name && sign.rename_area)
		rename_area(bar_area, sign.name)

	chosen_sign = sign
	update_appearance()

/obj/machinery/barsign/update_icon_state()
	if(!(machine_stat & BROKEN) && (!(machine_stat & NOPOWER) || machine_stat & EMPED) && chosen_sign && chosen_sign.icon_state)
		icon_state = chosen_sign.icon_state
	else
		icon_state = "empty"

	return ..()

/obj/machinery/barsign/update_desc()
	. = ..()

	if(chosen_sign && chosen_sign.desc)
		desc = chosen_sign.desc

/obj/machinery/barsign/update_name()
	. = ..()
	if(chosen_sign && chosen_sign.rename_area)
		name = "[initial(name)] ([chosen_sign.name])"
	else
		name = "[initial(name)]"

/obj/machinery/barsign/update_overlays()
	. = ..()

	if(((machine_stat & NOPOWER) && !(machine_stat & EMPED)) || (machine_stat & BROKEN))
		return

	if(chosen_sign && chosen_sign.light_mask)
		. += emissive_appearance(icon, "[chosen_sign.icon_state]-light-mask", src)

/obj/machinery/barsign/update_appearance(updates=ALL)
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN))
		set_light(0)
		return
	if(chosen_sign && chosen_sign.neon_color)
		set_light(MINIMUM_USEFUL_LIGHT_RANGE, 0.7, chosen_sign.neon_color)

/obj/machinery/barsign/proc/set_sign_by_name(sign_name)
	for(var/datum/barsign/sign as anything in subtypesof(/datum/barsign))
		if(initial(sign.name) == sign_name)
			var/new_sign = new sign
			set_sign(new_sign)

/obj/machinery/barsign/atom_break(damage_flag)
	. = ..()
	if(machine_stat & BROKEN)
		set_sign(new /datum/barsign/hiddensigns/signoff)

/obj/machinery/barsign/on_deconstruction(disassembled)
	if(disassembled)
		new disassemble_result(drop_location())
	else
		new /obj/item/stack/sheet/iron(drop_location(), 2)
		new /obj/item/stack/cable_coil(drop_location(), 2)

/obj/machinery/barsign/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			playsound(src.loc, 'sound/effects/glass/glasshit.ogg', 75, TRUE)
		if(BURN)
			playsound(src.loc, 'sound/items/tools/welder.ogg', 100, TRUE)

/obj/machinery/barsign/attack_ai(mob/user)
	return attack_hand(user)

/obj/machinery/barsign/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!allowed(user))
		balloon_alert(user, "Acesso negado!")
		return
	if(machine_stat & (NOPOWER|BROKEN|EMPED))
		balloon_alert(user, "Os controles não respondem!")
		return
	pick_sign(user)

/obj/machinery/barsign/screwdriver_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	panel_open = !panel_open
	if(panel_open)
		balloon_alert(user, "Painel aberto")
		set_sign(new /datum/barsign/hiddensigns/signoff)
		return ITEM_INTERACT_SUCCESS

	balloon_alert(user, "Painel fechado")

	if(machine_stat & (NOPOWER|BROKEN) || !chosen_sign)
		set_sign(new /datum/barsign/hiddensigns/signoff)
	else
		set_sign(chosen_sign)

	return ITEM_INTERACT_SUCCESS

/obj/machinery/barsign/wrench_act(mob/living/user, obj/item/tool)
	if(!panel_open)
		balloon_alert(user, "Abra o painel primeiro!")
		return ITEM_INTERACT_BLOCKING

	tool.play_tool_sound(src)
	if(!do_after(user, (10 SECONDS), target = src))
		return ITEM_INTERACT_BLOCKING

	tool.play_tool_sound(src)
	deconstruct(disassembled = TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/barsign/attackby(obj/item/attacking_item, mob/user)

	if(istype(attacking_item, /obj/item/blueprints) && !change_area_name)
		if(!panel_open)
			balloon_alert(user, "Abra o painel primeiro!")
			return TRUE

		change_area_name = TRUE
		balloon_alert(user, "sinal registrado")
		return TRUE

	if(istype(attacking_item, /obj/item/stack/cable_coil) && panel_open)
		var/obj/item/stack/cable_coil/wire = attacking_item

		if(atom_integrity >= max_integrity)
			balloon_alert(user, "Não precisa de reparos!")
			return TRUE

		if(!wire.use(2))
			balloon_alert(user, "Preciso de dois cabos!")
			return TRUE

		balloon_alert(user, "repaired")
		atom_integrity = max_integrity
		set_machine_stat(machine_stat & ~BROKEN)
		update_appearance()
		return TRUE

	return ..()

/obj/machinery/barsign/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return

	set_machine_stat(machine_stat | EMPED)
	addtimer(CALLBACK(src, PROC_REF(fix_emp), chosen_sign), 60 SECONDS)
	set_sign(new /datum/barsign/hiddensigns/empbarsign)

/// Callback to un-emp the sign some time.
/obj/machinery/barsign/proc/fix_emp(datum/barsign/sign)
	set_machine_stat(machine_stat & ~EMPED)
	if(!istype(sign))
		return

	set_sign(sign)

/obj/machinery/barsign/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(machine_stat & (NOPOWER|BROKEN|EMPED))
		balloon_alert(user, "Os controles não respondem!")
		return FALSE

	balloon_alert(user, "Barsign ilegal carregado")
	addtimer(CALLBACK(src, PROC_REF(finish_emag_act)), 10 SECONDS)
	return TRUE

/// Timer proc, called after ~10 seconds after [emag_act], since [emag_act] returns a value and cannot sleep
/obj/machinery/barsign/proc/finish_emag_act()
	set_sign(new /datum/barsign/hiddensigns/syndibarsign)

/obj/machinery/barsign/proc/pick_sign(mob/user)
	var/picked_name = tgui_input_list(user, "Available Signage", "Bar Sign", sort_list(get_bar_names()))
	if(isnull(picked_name))
		return
	set_sign_by_name(picked_name)
	SSblackbox.record_feedback("tally", "barsign_picked", 1, chosen_sign.type)

/proc/get_bar_names()
	var/list/names = list()
	for(var/d in subtypesof(/datum/barsign))
		var/datum/barsign/D = d
		if(!initial(D.hidden))
			names += initial(D.name)
	. = names

/datum/barsign
	/// User-visible name of the sign.
	var/name
	/// Icon state associated with this sign
	var/icon_state
	/// Description shown in the sign's examine text.
	var/desc
	/// Hidden from list of selectable options.
	var/hidden = FALSE
	/// Rename the area when this sign is selected.
	var/rename_area = TRUE
	/// If a barsign has a light mask for emission effects
	var/light_mask = TRUE
	/// The emission color of the neon light
	var/neon_color

/datum/barsign/New()
	if(!desc)
		desc = "It displays \"[name]\"."

// Specific bar signs.

/datum/barsign/maltesefalcon
	name = "Maltese Falcon"
	icon_state = "maltesefalcon"
	desc = "Falcão Maltês, Barra Espacial e Grill."
	neon_color = "#5E8EAC"

/datum/barsign/thebark
	name = "The Bark"
	icon_state = "thebark"
	desc = "O bar do Ian."
	neon_color = "#f7a604"

/datum/barsign/harmbaton
	name = "The Harmbaton"
	icon_state = "theharmbaton"
	desc = "Uma grande experiência de jantar para membros de segurança e assistentes."
	neon_color = "#ff7a4d"

/datum/barsign/thesingulo
	name = "The Singulo"
	icon_state = "thesingulo"
	desc = "Onde as pessoas vão que preferem não ser chamadas pelo nome."
	neon_color = "#E600DB"

/datum/barsign/thedrunkcarp
	name = "The Drunk Carp"
	icon_state = "thedrunkcarp"
	desc = "Não beba e nade."
	neon_color = "#a82196"

/datum/barsign/scotchservinwill
	name = "Scotch Servin Willy's"
	icon_state = "scotchservinwill"
	desc = "Willy mudou de palhaço para barman."
	neon_color = "#fee4bf"

/datum/barsign/officerbeersky
	name = "Officer Beersky's"
	icon_state = "officerbeersky"
	desc = "O homem come um dong, essas bebidas são ótimas."
	neon_color = "#16C76B"

/datum/barsign/thecavern
	name = "The Cavern"
	icon_state = "thecavern"
	desc = "Belas bebidas enquanto ouvia músicas bonitas."
	neon_color = "#0fe500"

/datum/barsign/theouterspess
	name = "The Outer Spess"
	icon_state = "theouterspess"
	desc = "Este bar não está localizado no espaço."
	neon_color = "#30f3cc"

/datum/barsign/slipperyshots
	name = "Slippery Shots"
	icon_state = "slipperyshots"
	desc = "Declive escorregadio para a bebedeira com nossos tiros!"
	neon_color = "#70DF00"

/datum/barsign/thegreytide
	name = "The Grey Tide"
	icon_state = "thegreytide"
	desc = "Abandone suas ferramentas e aproveite uma cerveja preguiçosa!"
	neon_color = "#00F4D6"

/datum/barsign/honkednloaded
	name = "Honked 'n' Loaded"
	icon_state = "honkednloaded"
	desc = "Honk."
	neon_color = "#FF998A"

/datum/barsign/le_cafe_silencieux
	name = "Le Café Silencieux"
	icon_state = "le_cafe_silencieux"
	desc = "..."
	neon_color = "#ffffff"

/datum/barsign/thenest
	name = "The Nest"
	icon_state = "thenest"
	desc = "Um bom lugar para se aposentar para beber depois de uma longa noite de luta contra o crime."
	neon_color = "#4d6796"

/datum/barsign/thecoderbus
	name = "The Coderbus"
	icon_state = "thecoderbus"
	desc = "Um bar muito controverso conhecido por sua grande variedade de bebidas em constante mudança."
	neon_color = "#ffffff"

/datum/barsign/theadminbus
	name = "The Adminbus"
	icon_state = "theadminbus"
	desc = "Um estabelecimento visitado principalmente por juízes espaciais. Não é bombardeado tanto quanto audiências."
	neon_color = "#ffffff"

/datum/barsign/oldcockinn
	name = "The Old Cock Inn"
	icon_state = "oldcockinn"
	desc = "Algo neste sinal te enche de desespero."
	neon_color = "#a4352b"

/datum/barsign/thewretchedhive
	name = "The Wretched Hive"
	icon_state = "thewretchedhive"
	desc = "Legalmente obrigado a instruí-lo para verificar suas bebidas para ácido antes do consumo."
	neon_color = "#26b000"

/datum/barsign/robustacafe
	name = "The Robusta Cafe"
	icon_state = "robustacafe"
	desc = "O titular do recorde de 'Mais Letal Barfights' 5 anos não contestado."
	neon_color = "#c45f7a"

/datum/barsign/emergencyrumparty
	name = "The Emergency Rum Party"
	icon_state = "emergencyrumparty"
	desc = "Recentemente relicenciado após um longo encerramento."
	neon_color = "#f90011"

/datum/barsign/combocafe
	name = "The Combo Cafe"
	icon_state = "combocafe"
	desc = "Renowned sistema-wide para suas combinações de bebidas totalmente não criativas."
	neon_color = "#33ca40"

/datum/barsign/vladssaladbar
	name = "Vlad's Salad Bar"
	icon_state = "vladssaladbar"
	desc = "Sob nova gestão. Vlad estava sempre muito feliz com aquela espingarda."
	neon_color = "#306900"

/datum/barsign/theshaken
	name = "The Shaken"
	icon_state = "theshaken"
	desc = "Este estabelecimento não serve bebidas agitadas."
	neon_color = "#dcd884"

/datum/barsign/thealenath
	name = "The Ale' Nath"
	icon_state = "thealenath"
	desc = "Tudo bem, amigo. Acho que você já teve o EI NATH. Hora de pegar um táxi."
	neon_color = "#ed0000"

/datum/barsign/thealohasnackbar
	name = "The Aloha Snackbar"
	icon_state = "alohasnackbar"
	desc = "Um de bom gosto, inofensivo sinal de bar Tiki."
	neon_color = ""

/datum/barsign/thenet
	name = "The Net"
	icon_state = "thenet"
	desc = "Você parece ficar preso nele por horas."
	neon_color = "#0e8a00"

/datum/barsign/maidcafe
	name = "Maid Cafe"
	icon_state = "maidcafe"
	desc = "Bem-vindo de volta, mestre!"
	neon_color = "#ff0051"

/datum/barsign/the_lightbulb
	name = "The Lightbulb"
	icon_state = "the_lightbulb"
	desc = "Um café popular entre mariposas e moffs. Uma vez fechou por uma semana depois que o barman usou naftalina para proteger seus uniformes."
	neon_color = "#faff82"

/datum/barsign/goose
	name = "The Loose Goose"
	icon_state = "goose"
	desc = "Beba até vomitar e/ou quebrar as leis da realidade!"
	neon_color = "#00cc33"

/datum/barsign/maltroach
	name = "Maltroach"
	icon_state = "maltroach"
	desc = "Mothroaches educadamente recebê-los no bar, ou eles estão se cumprimentando?"
	neon_color = "#649e8a"

/datum/barsign/rock_bottom
	name = "Rock Bottom"
	icon_state = "rock-bottom"
	desc = "Quando sentir que está preso em um poço, é melhor tomar uma bebida."
	neon_color = "#aa2811"

/datum/barsign/orangejuice
	name = "Oranges' Juicery"
	icon_state = "orangejuice"
	desc = "Para aqueles que desejam ter o máximo de tato com a população não alcoólica."
	neon_color = COLOR_ORANGE

/datum/barsign/tearoom
	name = "Little Treats Tea Room"
	icon_state = "little_treats"
	desc = "Um salão de chá relaxante para todos os rapazes chiques do cosmos."
	neon_color = COLOR_LIGHT_ORANGE

/datum/barsign/assembly_line
	name = "The Assembly Line"
	icon_state = "the-assembly-line"
	desc = "Onde cada bebida é trabalhada magistralmente com eficiência industrial!"
	neon_color = "#ffffff"

/datum/barsign/bargonia
	name = "Bargonia"
	icon_state = "bargonia"
	desc = "O armazém anseia por uma chamada mais alta... então Supply declarou BARGONIA!"
	neon_color = COLOR_WHITE

/datum/barsign/cult_cove
	name = "Cult Cove"
	icon_state = "cult-cove"
	desc = "O retiro favorito de Nar'Sie."
	neon_color = COLOR_RED

/datum/barsign/neon_flamingo
	name = "Neon Flamingo"
	icon_state = "neon-flamingo"
	desc = "Um ônibus para todos, menos os flamboyantly desafiado."
	neon_color = COLOR_PINK

/datum/barsign/slowdive
	name = "Slowdive"
	icon_state = "slowdive"
	desc = "Primeira parada do inferno, última parada antes do céu."
	neon_color = COLOR_RED

/datum/barsign/the_red_mons
	name = "The Red Mons"
	icon_state = "the-red-mons"
	desc = "Bebidas do Planeta Vermelho."
	neon_color = COLOR_RED

/datum/barsign/the_rune
	name = "The Rune"
	icon_state = "therune"
	desc = "Bebidas de mudança de realidade."
	neon_color = COLOR_RED

/datum/barsign/the_wizard
	name = "The Wizard"
	icon_state = "the-wizard"
	desc = "Misturas mágicas."
	neon_color = COLOR_RED

/datum/barsign/months_moths_moths
	name = "Moths Moths Moths"
	icon_state = "moths-moths-moths"
	desc = "Mães vivas!"
	neon_color = COLOR_RED

/datum/barsign/coldones
	name = "Cold Ones"
	icon_state = "cold-ones"
	desc = "É como chamam o efeito iogurte."
	neon_color = ""

/datum/barsign/doctorsorders
	name = "Doctor's Orders"
	icon_state = "doctors-orders"
	desc = "Para analgésicos."
	neon_color = ""

/datum/barsign/wrongturn
	name = "Wrong Turn"
	icon_state = "wrong-turn"
	desc = "Você não se sente perdido. Nada que algumas bebidas não consertem."
	neon_color = ""

/datum/barsign/punpunspub
	name = "Punpun's Pub"
	icon_state = "pun-puns-pub"
	desc = "Depois de tudo que ele passou? Eu também gostaria de estar perto da bebida."
	neon_color = ""

// Hidden signs list below this point

/datum/barsign/hiddensigns
	hidden = TRUE

/datum/barsign/hiddensigns/empbarsign
	name = "EMP'd"
	icon_state = "empbarsign"
	desc = "Algo deu errado."
	rename_area = FALSE

/datum/barsign/hiddensigns/syndibarsign
	name = "Syndi Cat"
	icon_state = "syndibarsign"
	desc = "Sindicar ou morrer."
	neon_color = "#ff0000"

/datum/barsign/hiddensigns/signoff
	name = "Off"
	icon_state = "empty"
	desc = "Este sinal não parece estar ligado."
	rename_area = FALSE
	light_mask = FALSE

// For other locations that aren't in the main bar
/obj/machinery/barsign/all_access
	req_access = null
	disassemble_result = /obj/item/wallframe/barsign/all_access

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/barsign/all_access, 32)

/obj/item/wallframe/barsign
	name = "bar sign frame"
	desc = "Costumava ajudar a atrair a ralé para o seu bar. Alguma reunião necessária."
	icon = 'icons/obj/machines/wallmounts.dmi'
	icon_state = "barsign"
	result_path = /obj/machinery/barsign
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)
	pixel_shift = 32

/obj/item/wallframe/barsign/Initialize(mapload)
	. = ..()
	desc += " Can be registered with a set of [span_bold("station blueprints")] to associate the sign with the area it occupies."

/obj/item/wallframe/barsign/try_build(turf/on_wall, mob/user)
	. = ..()
	if(!.)
		return .

	if(isopenturf(get_step(on_wall, EAST))) //This takes up 2 tiles so we want to make sure we have two tiles to hang it from.
		balloon_alert(user, "Precisa de mais apoio!")
		return FALSE

/obj/item/wallframe/barsign/all_access
	desc = "Costumava ajudar a atrair a ralé para o seu bar. Alguma reunião necessária. Este não tem fechadura de acesso."
	result_path = /obj/machinery/barsign/all_access
