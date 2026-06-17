/obj/structure/ore_vein
	name = "ore vein"
	desc = "Uma veia de minério que pode ser minada."
	icon = 'modular_skyrat/modules/stone/icons/ore.dmi'
	icon_state = "stone1"
	base_icon_state = "stone"
	density = TRUE
	anchored = TRUE
	/// When we start mining, what do we tell the user they're mining?
	var/ore_descriptor = "stone"
	/// What type of ore do we drop?
	var/ore_type = /obj/item/stack/stone
	/// How much ore do we drop?
	var/ore_amount = 5
	/// If the ore vein has been recently mined. If so, we cannot mine and must wait for it to regenerate.
	var/depleted = FALSE
	/// How long it takes for the ore to 'respawn' after being mined.
	var/regeneration_time = 3 MINUTES
	/// How long it takes for a tool to mine the ore vein.
	var/mining_time = 10 SECONDS
	/// How many unique sprites for ore we have, we will pick them at random.
	var/unique_sprites = 3
	/// If we should pick a random sprite for the ore vein or not.
	var/random_sprite = TRUE
	/// Our original description to hold. We'll revert to this when switching between the ore vein being depleted and not.
	var/base_desc = ""

/obj/structure/ore_vein/Initialize(mapload)
	. = ..()
	base_desc = desc
	if(random_sprite)
		base_icon_state += "[rand(1, (unique_sprites))]"

	icon_state = base_icon_state

/obj/structure/ore_vein/update_icon_state()
	icon_state = "[base_icon_state][depleted ? "_depleted" : ""]"

	return ..()

/obj/structure/ore_vein/examine()
	. = ..()
	. += "[depleted ? "The ore vein is exhausted." : ""]"

/obj/structure/ore_vein/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour != TOOL_MINING)
		to_chat(user, span_notice("Você precisa de uma picareta para minar isso."))
		return FALSE
	if(!ore_type)
		to_chat(user, span_notice("Não há minério para o meu!"))
		return FALSE
	if(!ore_amount)
		to_chat(user, span_notice("The [src] is too low quality to yield any useful amount of [ore_descriptor]."))
		return FALSE
	if(depleted == TRUE)
		to_chat(user, span_notice("Esta veia de minério está exausta."))
		return FALSE
	// Our early return checks to tell the user what went wrong.
	to_chat(user, span_notice("You start mining the [ore_descriptor]..."))
	if(W.use_tool(src, user, src.mining_time, volume=50))
		to_chat(user, span_notice("You mine the [ore_descriptor]."))
		if(ore_type && ore_amount && depleted == FALSE)
			new ore_type(loc, ore_amount)
		SSblackbox.record_feedback("tally", "pick_used_mining", 1, W.type)
		depleted = TRUE
		update_icon_state()
		addtimer(CALLBACK(src, PROC_REF(regenerate_ore)), regeneration_time)

/// After the ore vein finishes its wait, we make the ore 'respawn' and return the ore to its original post-Initialize() icon_state.
/obj/structure/ore_vein/proc/regenerate_ore()
	depleted = FALSE
	update_icon_state()

/obj/structure/ore_vein/stone
	name = "large rocks"
	desc = "Vários tipos de pedra de alta qualidade que provavelmente poderia fazer um bom material de construção se desenterrado e refinado."

/obj/structure/ore_vein/iron
	name = "rusted rocks"
	desc = "A cor marrom enferrujada nestas rochas dá o fato de que elas estão cheias de ferro!"
	icon_state = "iron1"
	base_icon_state = "iron"
	ore_descriptor = "iron"
	ore_type = /obj/item/stack/ore/iron

/obj/structure/ore_vein/silver
	name = "silvery-blue rocks"
	desc = "Essas pedras têm o olhar azulado de prata crua."
	icon_state = "silver1"
	base_icon_state = "silver"
	ore_descriptor = "silver"
	ore_type = /obj/item/stack/ore/silver

/obj/structure/ore_vein/gold
	name = "gold streaked rocks"
	desc = "Pedras de aparência bastante normal... além das raias de ouro brilhante correndo através de algumas delas!"
	icon_state = "gold1"
	base_icon_state = "gold"
	ore_descriptor = "gold"
	ore_type = /obj/item/stack/ore/gold

/obj/structure/ore_vein/plasma
	name = "plasma rich rocks"
	desc = "Pedras com plasma não refinado visíveis no exterior de vários... Tenha cuidado com as chamas abertas perto disso."
	icon_state = "plasma1"
	base_icon_state = "plasma"
	ore_descriptor = "plasma"
	ore_type = /obj/item/stack/ore/plasma

/obj/structure/ore_vein/diamond
	name = "diamond studded rocks"
	desc = "Embora não seja tão raro como você pensa, os diamantes que guardam essas pedras ainda são úteis e valiosos."
	icon_state = "diamond1"
	base_icon_state = "diamond"
	ore_descriptor = "diamond"
	ore_type = /obj/item/stack/ore/diamond
