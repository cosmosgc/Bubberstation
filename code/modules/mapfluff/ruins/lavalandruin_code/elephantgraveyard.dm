//******Decoration objects
//***Bone statues and giant skeleton parts.
/obj/structure/statue/bone
	anchored = TRUE
	max_integrity = 120
	impressiveness = 18 // Carved from the bones of a massive creature, it's going to be a specticle to say the least
	layer = ABOVE_ALL_MOB_LAYER
	plane = ABOVE_GAME_PLANE
	custom_materials = list(/datum/material/bone= SHEET_MATERIAL_AMOUNT * 5)
	abstract_type = /obj/structure/statue/bone

/obj/structure/statue/bone/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/seethrough, SEE_THROUGH_MAP_DEFAULT)

/obj/structure/statue/bone/rib
	name = "colossal rib"
	desc = "É impressionante pensar que algo tão grande poderia ter vivido, quanto mais morrido."
	custom_materials = list(/datum/material/bone=SHEET_MATERIAL_AMOUNT * 10)
	icon = 'icons/obj/art/statuelarge.dmi'
	icon_state = "rib"
	icon_preview = 'icons/obj/fluff/previews.dmi'
	icon_state_preview = "rib"

/obj/structure/statue/bone/skull
	name = "colossal skull"
	desc = "O vazio de um monstro morto e titânico."
	custom_materials = list(/datum/material/bone=SHEET_MATERIAL_AMOUNT * 6)
	icon = 'icons/obj/art/statuelarge.dmi'
	icon_state = "skull"
	icon_preview = 'icons/obj/fluff/previews.dmi'
	icon_state_preview = "skull"

/obj/structure/statue/bone/skull/half
	desc = "O vazio de um monstro morto e titânico. Este está rachado ao meio."
	custom_materials = list(/datum/material/bone=SHEET_MATERIAL_AMOUNT * 3)
	icon = 'icons/obj/art/statuelarge.dmi'
	icon_state = "skull-half"
	icon_preview = 'icons/obj/fluff/previews.dmi'
	icon_state_preview = "halfskull"

//***Wasteland floor and rock turfs here.
/turf/open/misc/asteroid/basalt/wasteland //Like a more fun version of living in Arizona.
	name = "cracked earth"
	icon = 'icons/turf/floors.dmi'
	icon_state = "wasteland"
	base_icon_state = "wasteland"
	baseturfs = /turf/open/misc/asteroid/basalt/wasteland
	dig_result = /obj/item/stack/ore/glass/basalt
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	slowdown = 0.5
	floor_variance = 30

/turf/open/misc/asteroid/basalt/wasteland/break_tile()
	return

/turf/open/misc/asteroid/basalt/wasteland/Initialize(mapload)
	.=..()
	if(prob(floor_variance))
		icon_state = "[base_icon_state][rand(0,6)]"

/turf/open/misc/asteroid/basalt/wasteland/basin
	icon_state = "wasteland_dug"
	base_icon_state = "wasteland_dug"
	floor_variance = 0
	dug = TRUE

/turf/closed/mineral/strong/wasteland
	name = "ancient dry rock"
	color = "#B5651D"
	turf_type = /turf/open/misc/asteroid/basalt/wasteland
	baseturfs = /turf/open/misc/asteroid/basalt/wasteland
	icon = 'icons/turf/walls/rock_wall.dmi'
	base_icon_state = "rock_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER

/turf/closed/mineral/strong/wasteland/drop_ores()
	if(prob(10))
		new /obj/item/stack/ore/iron(src)
		new /obj/item/stack/ore/glass(src)
		new /obj/effect/decal/remains/human(src, 1)
	else
		new /obj/item/stack/sheet/bone(src)

//***Oil well puddles.
/obj/structure/sink/oil_well //You're not going to enjoy bathing in this...
	name = "oil well"
	desc = "Uma piscina borbulhante de óleo. Isso provavelmente seria valioso, se a tecnologia do espaço azul não tivesse destruído a necessidade de combustíveis fósseis há 200 anos."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "puddle-oil"
	capacity = 20
	dispensedreagent = /datum/reagent/fuel/oil

/obj/structure/sink/oil_well/Initialize(mapload)
	. = ..()
	//I'm pretty much aware that, because how oil wells and sinks work, attackby() won't work unless in combat mode.
	//Thankfully, the user can cast the line from a distance.
	AddComponent(/datum/component/fishing_spot, /datum/fish_source/oil_well)

/obj/structure/sink/oil_well/find_and_mount_on_atom(mark_for_late_init, late_init)
	///Oil wells exist indepent of any wall structure
	return FALSE

/obj/structure/sink/oil_well/attack_hand(mob/user, list/modifiers)
	flick("puddle-oil-splash",src)
	reagents.expose(user, TOUCH, 20) //Covers target in 20u of oil.
	to_chat(user, span_notice("Você toca na piscina de óleo, só para sujar o óleo. Seria sábio lavar isso com água."))

/obj/structure/sink/oil_well/wrench_act(mob/living/user, obj/item/tool)
	//we deconstruct with a shovel
	return NONE

/obj/structure/sink/oil_well/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	flick("puddle-oil-splash",src)
	if(tool.tool_behaviour == TOOL_SHOVEL) //attempt to deconstruct the puddle with a shovel
		to_chat(user, "Você enche o poço de óleo com solo.")
		tool.play_tool_sound(src)
		deconstruct(TRUE)
		return ITEM_INTERACT_SUCCESS

	return ..()

/obj/structure/sink/oil_well/atom_deconstruct(dissambled = TRUE)
	new /obj/effect/decal/cleanable/blood/oil(loc)

//***Grave mounds.
/// has no items inside unless you use the filled subtype
/obj/structure/closet/crate/grave
	name = "burial mound"
	desc = "Uma mancha marcada de solo, mostrando sinais de um enterro há muito tempo. Você não perturbaria uma sepultura, certo?"
	icon = 'icons/obj/storage/crates.dmi'
	icon_state = "grave"
	base_icon_state = "grave"
	density = FALSE
	material_drop = /obj/item/stack/ore/glass/basalt
	material_drop_amount = 5
	anchorable = FALSE
	anchored = TRUE
	divable = FALSE //As funny as it may be, it would make little sense how you got yourself inside it in first place.
	breakout_time = 2 MINUTES
	open_sound = 'sound/effects/shovel_dig.ogg'
	close_sound = 'sound/effects/shovel_dig.ogg'
	can_install_electronics = FALSE
	can_weld_shut = FALSE
	cutting_tool = null
	paint_jobs = null
	elevation = 4 //It's a small mound.
	elevation_open = 0

	/// will this grave give you nightmares when opened
	var/lead_tomb = FALSE
	/// was this grave opened for the first time
	var/first_open = FALSE
	/// was a shovel used to close this grave
	var/dug_closed = FALSE
	/// do we have a mood effect tied to accessing this type of grave?
	var/affect_mood = FALSE

/obj/structure/closet/crate/grave/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(isnull(held_item))
		return NONE

	if(held_item.tool_behaviour == TOOL_SHOVEL)
		context[SCREENTIP_CONTEXT_RMB] = opened ? "Cover up" : "Dig open"
		return CONTEXTUAL_SCREENTIP_SET

	return NONE

/obj/structure/closet/crate/grave/close(mob/living/user)
	. = ..()
	// So that graves stay undense
	set_density(FALSE)

/obj/structure/closet/crate/grave/examine(mob/user)
	. = ..()
	. += span_notice("Pode ser.[EXAMINE_HINT((opened ? "closed" : "dug open"))]com uma pá.")

/obj/structure/closet/crate/grave/filled
	affect_mood = TRUE

/obj/structure/closet/crate/grave/filled/PopulateContents()  //GRAVEROBBING IS NOW A FEATURE
	..()
	new /obj/effect/decal/remains/human(src)
	switch(rand(1,8))
		if(1)
			new /obj/item/coin/gold(src)
			new /obj/item/storage/wallet(src)
		if(2)
			new /obj/item/clothing/glasses/meson(src)
		if(3)
			new /obj/item/coin/silver(src)
			new /obj/item/shovel/spade(src)
		if(4)
			new /obj/item/book/bible/booze(src)
		if(5)
			new /obj/item/clothing/neck/stethoscope(src)
			new /obj/item/scalpel(src)
			new /obj/item/hemostat(src)

		if(6)
			new /obj/item/reagent_containers/cup/beaker(src)
			new /obj/item/clothing/glasses/science(src)
		if(7)
			new /obj/item/clothing/glasses/sunglasses/big(src)
			new /obj/item/cigarette/rollie(src)
		else
			//empty grave
			return

/obj/structure/closet/crate/grave/closet_update_overlays(list/new_overlays)
	return

/obj/structure/closet/crate/grave/before_open(mob/living/user, force)
	. = ..()
	if(!.)
		return FALSE

	if(!force)
		to_chat(user, span_notice("O chão aqui é muito difícil de cavar com suas próprias mãos. Vai precisar de uma pá."))
		return FALSE

	return TRUE

/obj/structure/closet/crate/grave/before_close(mob/living/user)
	. = ..()
	if(!.)
		return FALSE

	if(!dug_closed)
		to_chat(user, span_notice("Vai precisar de uma pá para cobrir."))
		return FALSE

	dug_closed = FALSE
	return TRUE

/obj/structure/closet/crate/grave/tool_interact(obj/item/weapon, mob/living/carbon/user)
	//anything that isn't a shovel does normal stuff to the grave[like putting stuff in]
	if(weapon.tool_behaviour != TOOL_SHOVEL)
		return ..()

	//player is attempting to open/close the grave with a shovel
	if(!user.combat_mode)
		user.visible_message(
			span_notice("[user]Está tentando[opened ? "close" : "dig open"] [src]."),
			span_notice("Você começa.[opened ? "closing" : "digging open"] [src]."),
		)
		if(!weapon.use_tool(src, user, delay = 15, volume = 40))
			return TRUE

		var/is_chill_with_robbing = HAS_MIND_TRAIT(user, TRAIT_MORBID) || HAS_PERSONALITY(user, /datum/personality/callous) || HAS_PERSONALITY(user, /datum/personality/misanthropic)
		if(opened)
			dug_closed = TRUE
			close(user)
		else if(open(user, force = TRUE) && affect_mood)
			user.add_mood_event("graverobbing", is_chill_with_robbing ? /datum/mood_event/morbid_graverobbing : /datum/mood_event/graverobbing)
			if(lead_tomb && first_open)
				if(is_chill_with_robbing)
					to_chat(user, span_notice("Alguém disse alguma coisa? Tenho certeza que não foi nada."))
				else
					user.gain_trauma(/datum/brain_trauma/magic/stalker)
					to_chat(user, span_boldwarning("Não, não, não, eles estão em todos os lugares! Cada um deles está em todos os lugares!"))
				first_open = FALSE

		return TRUE

	//player is attempting to destroy the open grave with a shovel
	else
		if(!opened)
			return TRUE

		user.visible_message(
			span_notice("[user]Está tentando remover[src]."),
			span_notice("Você começa a remover[src]."),
		)
		if(!weapon.use_tool(src, user, delay = 15, volume = 40) || !opened)
			return TRUE

		to_chat(user, span_notice("Você tira.\the [src]Completamente."))
		user.add_mood_event("graverobbing", /datum/mood_event/graverobbing)
		deconstruct(TRUE)
		return TRUE

/obj/structure/closet/crate/grave/container_resist_act(mob/living/user, loc_required = TRUE)
	if(opened)
		return
	// The player is trying to dig themselves out of an early grave
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	user.visible_message(
		span_warning("[src]A sujeira começa a mudar e a rugir!"),
		span_notice("Você desesperadamente começa a arranhar a sujeira em torno de você, tentando forçar-se para cima através do solo...[DisplayTimeText(breakout_time)].)"),
		span_hear("Você ouve o som de mover sujeira de[src]."),
	)
	if(do_after(user, breakout_time, target = src))
		if(opened)
			return
		user.visible_message(
			span_danger("[user]emerge de[src]Espalhando sujeira por toda parte!"),
			span_notice("Você triunfante superfície para fora[src], espalhando terra ao redor do túmulo!"),
		)
		bust_open()
	else
		if(user.loc == src)
			to_chat(user, span_warning("Você não consegue se retirar.[src]!"))

/obj/structure/closet/crate/grave/fresh
	name = "makeshift grave"
	desc = "Um túmulo apressado. Com certeza não tem dois metros de profundidade, mas vai segurar um corpo."
	icon = 'icons/obj/storage/crates.dmi'
	icon_state = "grave_fresh"
	base_icon_state = "grave_fresh"
	material_drop_amount = 0

/obj/structure/closet/crate/grave/filled/lead_researcher
	name = "ominous burial mound"
	desc = "Mesmo em um lugar cheio de túmulos, este mostra um nível de preparação e planejamento que enche você de medo."
	icon = 'icons/obj/storage/crates.dmi'
	icon_state = "grave_lead"
	lead_tomb = TRUE
	first_open = TRUE

/obj/structure/closet/crate/grave/filled/lead_researcher/PopulateContents()  //ADVANCED GRAVEROBBING
	..()
	new /obj/effect/decal/cleanable/blood/gibs/old(src)
	new /obj/item/book/granter/crafting_recipe/boneyard_notes(src)

/obj/structure/closet/crate/grave/skeleton
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	affect_mood = TRUE

/obj/structure/closet/crate/grave/skeleton/PopulateContents()
	. = ..()
	new /mob/living/carbon/human/species/skeleton(src)

//***Fluff items for lore/intrigue
/obj/item/paper/crumpled/muddy/fluff/elephant_graveyard
	name = "posted warning"
	desc = "Parece estar manchado de lama e óleo?"
	default_raw_text = "<B>A quem possa interessar</B><BR><BR>Esta área é propriedade da Divisão de Mineração Nanotrasen.<BR><BR>Invadir nesta área é ilegal, altamente perigoso, e sujeito a várias NDAs.<br><br>Por favor, volte agora, sob lei intergaláctica seção 48-R."

/obj/item/paper/crumpled/muddy/fluff/elephant_graveyard/rnd_notes
	name = "Research Findings: Day 26"
	desc = "Esta página parece que foi arrancada de um livro completo. Que estranho."
	icon_state = "docs_part"
	default_raw_text = "<b>Nome do pesquisador:</b>B-*--* J--*s.<BR><BR>Achados detalhados:<i>Hoje a condição do acampamento está... O cinzeiro--ms nos impede de deixar a mesa de suprimentos m-re, e é lo-king como se estivéssemos sem pl*sma para p-wer o ge-erat*r. Não dá pra estudar sem... A empresa nos deixou aqui, mas eu continuo dizendo a ele para parar de entrar nessas malditas sepulturas. Nós, arqueólogos, mas temos que ter a certeza de que estes grav-s são novos.</i><BR><BR><b>O resto da página é apenas semântica sobre métodos de datação por carbono.</b>"

/obj/item/paper/crumpled/muddy/fluff/elephant_graveyard/mutiny
	name = "hastily scribbled note"
	desc = "Parece que alguém estava com pressa."
	default_raw_text = "Todos sabemos que o filho da puta está fazendo isso para nos manter satisfeitos. Quem diabos ele pensa que é, tomando rações extras? Estamos sem comida, Carl. Amanhã ao meio-dia, vamos tentar pegar a nave à força. Ele tem que estar mentindo sobre o motor esfriando. Ele tem que ser. Estou dizendo, com este implante que tirei da última nave de suprimentos, consegui a inteligência para nos tirar dessa merda. Mantenha sua faca à mão, Carl."

/obj/item/paper/fluff/ruins/elephant_graveyard/hypothesis
	name = "research document"
	desc = "Tipo padrão Nanotrasen para documentos de pesquisa importantes."
	default_raw_text = "<b>Dia 9: Conclusões Tenativas</b><BR><BR>Embora a área pareça ser de significativa importância cultural para a corrida de lagartos, fora de algum contato de luta com a vida selvagem nativa, ainda não encontramos qualquer razão exata para a natureza deste fenômeno. Parece que a vida orgânica é popularmente atraída para este planeta como se funcionasse como um lugar de descanso final para a vida inteligente. De acordo com as diretrizes da empresa, este site receberá a seguinte classificação:<BR><BR><u>Lista compilada de descobertas de artefatos</u><BR>Fragmentos de lâmina de culto: x8<BR>Amostra multiplicativa de latão: x105<BR>Sindicate Revolutionary Leader Implant (Broken) x1<BR>Extinto Cortical Borer Tissue Sample x1<BR>Carpa Espacial Fóssil x3"

/obj/item/paper/fluff/ruins/elephant_graveyard/final_message
	name = "important-looking note"
	desc = "Este bilhete está bem escrito, e parece ter sido colocado aqui para que você o encontrasse."
	default_raw_text = "Se encontrar isso... não precisa saber quem eu sou.<BR><BR>Precisa sair daqui. Não sei o que fizeram comigo aqui, mas acho que não vou sair daqui.<BR><BR>Este lugar... desgasta sua psique. Os outros pesquisadores riram, mas... Eles foram os primeiros a ir.<BR><BR>Um por um começaram a se virar uns contra os outros. Quanto mais descobrem, mais brigam e discutem...<BR>Enquanto eu falava agora, eu tinha que... Acabei tendo que matar a maioria dos meus homens. Eu sei o que tinha que fazer, e sei que não há como eu viver comigo mesmo.<BR>Se alguém encontrar isso, não toque nos túmulos.<BR><BR>Não. Não seja idiota, como todos nós."
