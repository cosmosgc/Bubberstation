/*!
 * Tier 1 knowledge: Stealth and general utility
 */

/datum/heretic_knowledge/void_cloak
	name = "Void Cloak"
	desc = "Permite que transmute um pedaço de vidro, um lençol, e qualquer item de roupa exterior (como armadura ou jaqueta de terno)\
Para criar um Vazio. Enquanto o capô está para baixo, a capa funciona como foco e protege você do espaço.\
Enquanto o capuz está levantado, o manto é completamente invisível. Também fornece uma armadura decente e\
tem bolsos que podem segurar uma de suas lâminas, vários componentes rituais (como órgãos) e pequenas bugigangas heréticas."
	gain_text = "O Coruja é o guardião das coisas que não estão na prática, mas em teoria estão. Muitas coisas são."
	required_atoms = list(
		/obj/item/shard = 1,
		/obj/item/clothing/suit = 1,
		/obj/item/bedsheet = 1,
	)
	result_atoms = list(/obj/item/clothing/suit/hooded/cultrobes/void)
	cost = 1
	research_tree_icon_path = 'icons/obj/clothing/suits/armor.dmi'
	research_tree_icon_state = "void_cloak"
	drafting_tier = 1

/datum/heretic_knowledge/medallion
	name = "Ashen Eyes"
	desc = "Permite que transmute um par de olhos, uma vela, e um caco de vidro em um medalhão de Eldritch.\
O Medalhão Eldritch lhe concede visão térmica enquanto é usado, e também funciona como foco."
	gain_text = "Olhos penetrantes os guiaram através do mundano. Nem a escuridão nem o terror poderiam detê-los."
	required_atoms = list(
		/obj/item/organ/eyes = 1,
		/obj/item/shard = 1,
		/obj/item/flashlight/flare/candle = 1,
	)
	result_atoms = list(/obj/item/clothing/neck/eldritch_amulet)
	cost = 1
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "eye_medalion"
	drafting_tier = 1

/datum/heretic_knowledge/essence // AKA Eldritch Flask
	name = "Priest's Ritual"
	desc = "Permite que transmute um tanque de água e um pedaço de vidro em um Flask de Eldritch Essence.\
Eldritch Essence pode ser consumido por uma cura potente, ou dado a pagãos por envenenamento mortal."
	gain_text = "Esta é uma receita antiga. A Coruja sussurrou para mim.\
Criado pelo padre, o líquido que ambos eram e não são."
	required_atoms = list(
		/obj/structure/reagent_dispensers/watertank = 1,
		/obj/item/shard = 1,
	)
	result_atoms = list(/obj/item/reagent_containers/cup/beaker/eldritch)
	cost = 1
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "eldritch_flask"
	drafting_tier = 1

/datum/heretic_knowledge/phylactery
	name = "Phylactery of Damnation"
	desc = "Permite transmutar uma folha de vidro e uma papoula para uma filactaria que pode tirar sangue instantaneamente, mesmo de longas distâncias.\
Esteja avisado, seu alvo ainda pode sentir um pau."
	gain_text = "Uma tintura torcida na forma de um verme sanguessuga.\
Se ele escolheu a forma para si mesmo, ou este é o humor da mente doente que conjurou este implemento vil em ser é algo melhor não ponderado."
	required_atoms = list(
		/obj/item/stack/sheet/glass = 1,
		/obj/item/food/grown/poppy = 1,
	)
	result_atoms = list(/obj/item/reagent_containers/cup/phylactery)
	cost = 1
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "phylactery_2"
	drafting_tier = 1

/datum/heretic_knowledge/crucible
	name = "Mawed Crucible"
	desc = "Permite que transmute um tanque de água portátil e uma mesa para criar um Crucible Mawed.\
O Crucible Mawed pode fazer poções poderosas para combate e utilidade, mas deve ser alimentado com partes do corpo e órgãos entre usos."
	gain_text = "Isso é pura agonia. Não pude invocar a figura do Aristocrata.\
Mas com a atenção do padre encontrei uma receita diferente..."
	required_atoms = list(
		/obj/structure/reagent_dispensers/watertank = 1,
		/obj/structure/table = 1,
	)
	result_atoms = list(/obj/structure/destructible/eldritch_crucible)
	cost = 1
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "crucible"
	drafting_tier = 1

/datum/heretic_knowledge/eldritch_coin
	name = "Eldritch Coin"
	desc = "Permite que transmute uma folha de plasma e um diamante para criar uma moeda Eldritch.\
A moeda abrirá ou fechará portas próximas quando pousarem em cabeças e trocarem seus parafusos.\
Quando aterrissamos em caudas. Se você inserir a moeda em uma câmara de ar, ela será consumida.\
para fritar seus eletrônicos, abrindo a câmara de ar permanentemente, a menos que seja aparafusado."
	gain_text = "O Mansus é um lugar de todos os tipos de pecados. Mas a ganância tinha um papel especial."
	required_atoms = list(
		/obj/item/stack/sheet/mineral/diamond = 1,
		/obj/item/stack/sheet/mineral/plasma = 1,
	)
	result_atoms = list(/obj/item/coin/eldritch)
	cost = 1
	research_tree_icon_path = 'icons/obj/economy.dmi'
	research_tree_icon_state = "coin_heretic"
	drafting_tier = 1

/**
 * This allows heretics to choose if they want to rush all the influences and take them stealthily, or
 * Construct a codex and take what's left with more points.
 * Another downside to having the book is strip searches, which means that it's not just a free nab, at least until you get exposed - and when you do, you'll probably need the faster drawing speed.
 * Overall, it's a tradeoff between speed and stealth or power.
 */
/datum/heretic_knowledge/codex_cicatrix
	name = "Codex Cicatrix"
	desc = "Permite transmutar um livro, qualquer caneta, e sua picareta de qualquer carcaça (animal ou humana), couro, ou se esconder para criar um Códice Cicatrix.\
O Codex Cicatrix pode ser usado quando drena influências para obter mais conhecimento, mas corre maior risco de ser notado.\
Ele também pode ser usado para desenhar e remover runas de transmutação mais fácil, e como um foco de feitiço em uma pitada."
	gain_text = "O oculto deixa fragmentos de conhecimento e poder em qualquer lugar e em todo lugar. O Códice Cicatrix é um exemplo.\
Dentro dos rostos de couro e páginas antigas, um caminho para o Mansus é revelado."
	required_atoms = list(
		list(/obj/item/toy/eldritch_book, /obj/item/book) = 1,
		/obj/item/pen = 1,
		list(/mob/living, /obj/item/stack/sheet/leather, /obj/item/stack/sheet/animalhide, /obj/item/food/deadmouse) = 1,
	)
	result_atoms = list(/obj/item/codex_cicatrix)
	cost = 1
	priority = MAX_KNOWLEDGE_PRIORITY - 4
	drafting_tier = 1
	is_shop_only = TRUE
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "book"

	var/static/list/non_mob_bindings = typecacheof(list(
		/obj/item/stack/sheet/leather,
		/obj/item/stack/sheet/animalhide,
		/obj/item/food/deadmouse,
	))

/datum/heretic_knowledge/codex_cicatrix/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	if(!.)
		return FALSE

	for(var/thingy in atoms)
		if(is_type_in_typecache(thingy, non_mob_bindings))
			selected_atoms += thingy
			return TRUE
		else if(isliving(thingy))
			var/mob/living/body = thingy
			if(body.stat != DEAD)
				continue
			selected_atoms += body
			return TRUE
	return FALSE

/datum/heretic_knowledge/codex_cicatrix/cleanup_atoms(list/selected_atoms)
	var/mob/living/body = locate() in selected_atoms
	if(!body)
		return ..()
	// A golem or an android doesn't have skin!
	var/exterior_text = "skin"
	// If carbon, it's the limb. If not, it's the body.
	var/atom/movable/ripped_thing = body

	// We will check if it's a carbon's body.
	// If it is, we will damage a random bodypart, and check that bodypart for its body type, to select between 'skin' or 'exterior'.
	if(iscarbon(body))
		var/mob/living/carbon/carbody = body
		var/obj/item/bodypart/bodypart = pick(carbody.get_bodyparts())
		ripped_thing = bodypart

		carbody.apply_damage(25, BRUTE, bodypart, sharpness = SHARP_EDGED)
		if(!(bodypart.bodytype & BODYTYPE_ORGANIC))
			exterior_text = "exterior"
	else
		body.apply_damage(25, BRUTE, sharpness = SHARP_EDGED)
		// If it is not a carbon mob, we will just check biotypes and damage it directly.
		if(body.mob_biotypes & (MOB_MINERAL|MOB_ROBOTIC))
			exterior_text = "exterior"

	// Procure book for flavor text. This is why we call parent at the end.
	var/obj/item/book/le_book = locate() in selected_atoms
	if(!le_book)
		stack_trace("Somehow, no book in codex cicatrix selected atoms! [english_list(selected_atoms)]")
	playsound(body, 'sound/items/poster/poster_ripped.ogg', 100, TRUE)
	body.do_jitter_animation()
	body.visible_message(span_danger("An awful ripping sound is heard as [ripped_thing]'s [exterior_text] is ripped straight out, wrapping around [le_book || "the book"], turning into an eldritch shade of blue!"))
	return ..()

/**
 * Warren King's Welcome
 * Offers an alternative way besides stealing an ID or visiting the HoP to gain access to maintenance
 * Additionally changes all nearby airlock's access's to ACCESS_HERETIC
 */
/datum/heretic_knowledge/bookworm
	name = "Warren King's Welcome"
	desc = "Permite que transmute 10 peças de cabo, um pedaço de papel, e uma multitool para marcar cartões de identificação e comportas.\
Cartões de identificação marcados terão acesso à manutenção, câmaras de ar externas, bem como câmaras de ar marcadas.\
As câmaras de ar de marca só serão acessíveis por aqueles com um cartão de identificação."
	gain_text = "Torcido em ossos dedos manchados de víveres, meu triste convite tira minha mente enjoada e turva em direção à porta pesada.\
Lentamente, a luz dança entre uma escuridão rastejante, cobrindo o passeio fétido com infinitas maquinações.\
Mas o Rei em breve levará seu quilo de carne. Mesmo aqui, o fiscal pega a parte deles. Pois há milhares de bocas para alimentar."
	required_atoms = list(
		/obj/item/stack/cable_coil = 10,
		/obj/item/paper = 1,
		/obj/item/multitool = 1,
	)
	cost = 1
	priority = MAX_KNOWLEDGE_PRIORITY - 3
	drafting_tier = 1
	research_tree_icon_path = 'icons/obj/card.dmi'
	research_tree_icon_state = "eldritch"

/datum/heretic_knowledge/bookworm/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	for(var/obj/item/card/id/used_id in atoms)
		selected_atoms += used_id
	var/obj/item/card/user_card = user.get_idcard(hand_first = TRUE)
	if(user_card)
		selected_atoms += user_card

/datum/heretic_knowledge/bookworm/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	for(var/obj/item/card/id/improved_id in selected_atoms)
		improved_id.add_access(list(ACCESS_MAINT_TUNNELS, ACCESS_EXTERNAL_AIRLOCKS, ACCESS_HERETIC), mode = FORCE_ADD_ALL)
		selected_atoms -= improved_id
	for(var/obj/machinery/door/airlock/door in view(7, loc))
		door.req_one_access = null
		door.req_access = list(ACCESS_HERETIC)
		door.wires?.cut(WIRE_AI)
		new /obj/effect/temp_visual/eldritch_sparks(door.loc)
		var/obj/effect/light_emitter/light = new(door.loc)
		light.set_light(1.75, 1.5, COLOR_PUCE)
		QDEL_IN(light, 1 SECONDS)
		playsound(door, 'sound/effects/magic.ogg', 20, vary = TRUE, extrarange = SILENCED_SOUND_EXTRARANGE, ignore_walls = FALSE)
		playsound(door, SFX_SPARKS, 33, vary = TRUE, extrarange = SILENCED_SOUND_EXTRARANGE, ignore_walls = FALSE)

	return TRUE
