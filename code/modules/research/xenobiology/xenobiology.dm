/// Slime Extracts ///

/obj/item/slime_extract
	name = "slime extract"
	desc = "Goo extraído de um lodo. Lendas afirmam que estas têm\"poderes mágicos.\"."
	icon = 'icons/mob/simple/slimes.dmi'
	icon_state = "grey-core"
	force = 0
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	throw_speed = 3
	throw_range = 6
	///Can this extract still be grinded
	var/can_grind = TRUE
	///uses before it goes inert
	var/extract_uses = 1
	///deletion timer, for delayed reactions
	var/qdel_timer = null
	///Which type of crossbred
	var/crossbreed_modification
	///Reagents required for activation
	var/recurring = FALSE

/obj/item/slime_extract/grind_results()
	return can_grind ? list(/datum/reagent/toxin/slimejelly = 20) : list()

/obj/item/slime_extract/examine(mob/user)
	. = ..()
	if(extract_uses > 1)
		. += "It has [extract_uses] uses remaining."

/obj/item/slime_extract/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/slimepotion/enhancer))
		return NONE
	if(extract_uses >= 5 || recurring)
		to_chat(user, span_warning("Você não pode aumentar esse extrato mais!"))
		return ITEM_INTERACT_BLOCKING
	if(istype(tool, /obj/item/slimepotion/enhancer/max))
		to_chat(user, span_notice("Você joga o maximizador no extrato de lodo. Agora pode ser usado um total de 5 vezes!"))
		extract_uses = 5
	else
		to_chat(user, span_notice("Você aplica o intensificador no extrato de lodo. Pode agora ser reutilizado mais uma vez."))
		extract_uses++
	qdel(tool)
	return ITEM_INTERACT_SUCCESS

/obj/item/slime_extract/Initialize(mapload)
	. = ..()
	create_reagents(100, INJECTABLE | DRAWABLE | SEALED_CONTAINER)

/**
* Effect when activated by a Luminescent.
*
* This proc is called whenever a Luminescent consumes a slime extract. Each one is separated into major and minor effects depending on the extract. Cooldown is measured in deciseconds.
*
* * arg1 - The mob absorbing the slime extract.
* * arg2 - The valid species for the absorbtion. Should always be a Luminescent unless something very major has changed.
* * arg3 - Whether or not the activation is major or minor. Major activations have large, complex effects, minor are simple.
*/
/obj/item/slime_extract/proc/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	to_chat(user, span_warning("Nada aconteceu... Este extrato de lodo não pode ser ativado assim."))
	return FALSE

/**
* Core-crossing: Feeding adult slimes extracts to obtain a much more powerful, single extract.
*
* By using a valid core on a living adult slime, then feeding it nine more of the same type, you can mutate it into more useful items. Not every slime type has an implemented core cross.
*/
/obj/item/slime_extract/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/mob/living/basic/slime/target_slime = interacting_with
	if(!istype(target_slime))
		return NONE

	if(target_slime.stat)
		to_chat(user, span_warning("O lodo está morto!"))
		return ITEM_INTERACT_BLOCKING
	if(target_slime.life_stage != SLIME_LIFE_STAGE_ADULT)
		to_chat(user, span_warning("O lodo deve ser um adulto para atravessar seu núcleo!"))
		return ITEM_INTERACT_BLOCKING
	if(target_slime.crossbreed_modification && target_slime.crossbreed_modification != crossbreed_modification)
		to_chat(user, span_warning("O lodo já está sendo cruzado com um extrato diferente!"))
		return ITEM_INTERACT_BLOCKING

	if(!target_slime.crossbreed_modification)
		target_slime.crossbreed_modification = crossbreed_modification

	target_slime.applied_crossbreed_amount++
	qdel(src)
	to_chat(user, span_notice("Você alimenta o lodo[src], [target_slime.applied_crossbreed_amount == 1 ? "starting to mutate its core." : "further mutating its core."]"))
	playsound(target_slime, 'sound/effects/blob/attackblob.ogg', 50, TRUE)

	if(target_slime.applied_crossbreed_amount >= SLIME_EXTRACT_CROSSING_REQUIRED)
		target_slime.spawn_corecross()
	return ITEM_INTERACT_SUCCESS

/**
* Effect when activated by selfsustaining crossbreed or rainbow slime
*
* * arg1 - The reaction being triggered. If null, a random reaction is picked
*/
/obj/item/slime_extract/proc/auto_activate_reaction(datum/chemical_reaction/slime/slime_reaction = null)
	if(QDELETED(src))
		return

	if(isnull(slime_reaction))
		var/list/slime_reactions = GLOB.slime_extract_auto_activate_reactions[type]
		if(isnull(slime_reactions))
			return
		slime_reaction = pick(slime_reactions)

	var/list/required_reagents = slime_reaction.required_reagents
	for(var/datum/reagent/chem as anything in required_reagents)
		reagents.add_reagent(chem, required_reagents[chem])

/// An assoc list of slime extracts to their allowed recipes
GLOBAL_LIST_INIT(slime_extract_auto_activate_reactions, init_slime_auto_activate_reaction_list())

/proc/init_slime_auto_activate_reaction_list()
	var/list/recipe_list = list()

	// Only reactions with these reagent requirements are allowed to auto_activate
	var/list/auto_activate_reagent_whistlist = list(
		/datum/reagent/toxin/plasma,
		/datum/reagent/water,
		/datum/reagent/blood,
		/datum/reagent/water/holywater,
		/datum/reagent/uranium,
		/datum/reagent/uranium/radium,
		/datum/reagent/toxin/slimejelly
	)

	var/list/slime_extract_paths = subtypesof(/obj/item/slime_extract)
	for(var/datum/chemical_reaction/slime/slime_reaction as anything in subtypesof(/datum/chemical_reaction/slime))
		var/recipe_extract_type = slime_reaction.required_container
		if(!(recipe_extract_type in slime_extract_paths))
			continue

		var/skip = FALSE
		for(var/datum/reagent/chem as anything in slime_reaction.required_reagents)
			if(!(chem in auto_activate_reagent_whistlist))
				skip = TRUE
				break
		if(skip)
			continue

		var/list/recipes = recipe_list[recipe_extract_type]
		if(!recipes)
			recipes = list()
			recipe_list[recipe_extract_type] = recipes
		recipes.Add(new slime_reaction())

	return recipe_list


/obj/item/slime_extract/grey
	name = "grey slime extract"
	icon_state = "grey-core"
	crossbreed_modification = "reproductive"

/obj/item/slime_extract/grey/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			var/obj/item/food/monkeycube/M = new
			if(!user.put_in_active_hand(M))
				M.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			to_chat(user, span_notice("Cuspiu um cubo de macaco."))
			return 120
		if(SLIME_ACTIVATE_MAJOR)
			to_chat(user, span_notice("Sua[name]Começa a pulsar..."))
			if(do_after(user, 4 SECONDS, target = user))
				var/mob/living/basic/slime/new_slime = new(get_turf(user), /datum/slime_type/grey)
				playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
				to_chat(user, span_notice("Você cuspiu.[new_slime]."))
				return 350
			else
				return 0

/obj/item/slime_extract/gold
	name = "gold slime extract"
	icon_state = "gold-core"
	crossbreed_modification = "symbiont"



/obj/item/slime_extract/gold/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			user.visible_message(span_warning("[user]Começa a tremer!"),span_notice("Sua[name]Começa a pulsar suavemente..."))
			if(do_after(user, 4 SECONDS, target = user))
				var/mob/living/spawned_mob = create_random_mob(user.drop_location(), FRIENDLY_SPAWN)
				spawned_mob.add_faction(FACTION_NEUTRAL)
				playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
				user.visible_message(span_warning("[user]Cuspindo[spawned_mob]!"), span_notice("Você cuspiu.[spawned_mob]!"))
				return 300

		if(SLIME_ACTIVATE_MAJOR)
			user.visible_message(span_warning("[user]Começa a tremer violentamente!"),span_warning("Sua[name]Começa a pulsar violentamente..."))
			if(do_after(user, 5 SECONDS, target = user))
				var/mob/living/spawned_mob = create_random_mob(user.drop_location(), HOSTILE_SPAWN)
				if(!user.combat_mode)
					spawned_mob.add_faction(FACTION_NEUTRAL)
				else
					spawned_mob.add_faction(FACTION_SLIME)
				playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
				user.visible_message(span_warning("[user]Cuspindo[spawned_mob]!"), span_warning("Você cuspiu.[spawned_mob]!"))
				return 600

/obj/item/slime_extract/silver
	name = "silver slime extract"
	icon_state = "silver-core"
	crossbreed_modification = "consuming"



/obj/item/slime_extract/silver/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			var/food_type = get_random_food()
			var/obj/item/food/food_item = new food_type
			ADD_TRAIT(food_item, TRAIT_FOOD_SILVER, INNATE_TRAIT)
			if(!user.put_in_active_hand(food_item))
				food_item.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			user.visible_message(span_warning("[user]Cuspindo[food_item]!"), span_notice("Você cuspiu.[food_item]!"))
			return 200
		if(SLIME_ACTIVATE_MAJOR)
			var/drink_type = get_random_drink()
			var/obj/O = new drink_type
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			user.visible_message(span_warning("[user]Cuspindo[O]!"), span_notice("Você cuspiu.[O]!"))
			return 200

/obj/item/slime_extract/metal
	name = "metal slime extract"
	icon_state = "metal-core"
	crossbreed_modification = "industrial"

/obj/item/slime_extract/metal/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			var/obj/item/stack/sheet/glass/O = new(null, 5)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			user.visible_message(span_warning("[user]Cuspindo[O]!"), span_notice("Você cuspiu.[O]!"))
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			var/obj/item/stack/sheet/iron/O = new(null, 5)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			user.visible_message(span_warning("[user]Cuspindo[O]!"), span_notice("Você cuspiu.[O]!"))
			return 200

/obj/item/slime_extract/purple
	name = "purple slime extract"
	icon_state = "purple-core"
	crossbreed_modification = "regenerative"

/obj/item/slime_extract/purple/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			user.adjust_nutrition(50)
			user.adjust_blood_volume(50)
			to_chat(user, span_notice("Você ativa.[src]E seu corpo está cheio de geléia fresca!"))
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			to_chat(user, span_notice("Você ativa.[src], e libera produtos químicos regenerativos!"))
			user.reagents.add_reagent(/datum/reagent/medicine/regen_jelly,10)
			return 600

/obj/item/slime_extract/darkpurple
	name = "dark purple slime extract"
	icon_state = "dark-purple-core"
	crossbreed_modification = "self-sustaining"

/obj/item/slime_extract/darkpurple/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			var/obj/item/stack/sheet/mineral/plasma/O = new(null, 1)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			user.visible_message(span_warning("[user]Cuspindo[O]!"), span_notice("Você cuspiu.[O]!"))
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			var/turf/open/T = get_turf(user)
			if(istype(T))
				T.atmos_spawn_air("[GAS_PLASMA]=20")
			to_chat(user, span_warning("Você ativa.[src]E uma nuvem de plasma sai da sua pele!"))
			return 900

/obj/item/slime_extract/orange
	name = "orange slime extract"
	icon_state = "orange-core"
	crossbreed_modification = "burning"

/obj/item/slime_extract/orange/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, span_notice("Você ativa.[src]Você começa a se sentir quente!"))
			user.reagents.add_reagent(/datum/reagent/consumable/capsaicin,10)
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			user.reagents.add_reagent(/datum/reagent/phosphorus,5)//
			user.reagents.add_reagent(/datum/reagent/potassium,5) // = smoke, along with any reagents inside mr. slime
			user.reagents.add_reagent(/datum/reagent/consumable/sugar,5)     //
			to_chat(user, span_warning("Você ativa.[src]E uma nuvem de fumaça sai da sua pele!"))
			return 450

/obj/item/slime_extract/yellow
	name = "yellow slime extract"
	icon_state = "yellow-core"
	crossbreed_modification = "charged"

/obj/item/slime_extract/yellow/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			if(species.glow_intensity != LUMINESCENT_DEFAULT_GLOW)
				to_chat(user, span_warning("Seu brilho já está melhorado!"))
				return
			species.update_glow(user, 5)
			addtimer(CALLBACK(species, TYPE_PROC_REF(/datum/species/jelly/luminescent, update_glow), user, LUMINESCENT_DEFAULT_GLOW), 1 MINUTES)
			to_chat(user, span_notice("Você começa a brilhar mais."))

		if(SLIME_ACTIVATE_MAJOR)
			user.visible_message(span_warning("[user]A pele começa a piscar intermitentemente..."), span_warning("Sua pele começa a piscar intermitentemente..."))
			if(do_after(user, 2.5 SECONDS, target = user))
				empulse(user, 1, 2, emp_source = src)
				user.log_message("triggered EMP using [src] in [AREACOORD(src)]", LOG_GAME)
				user.visible_message(span_warning("[user]A pele brilha!"), span_warning("Sua pele brilha enquanto emite um pulso eletromagnético!"))
				return 600

/obj/item/slime_extract/red
	name = "red slime extract"
	icon_state = "red-core"
	crossbreed_modification = "sanguine"

/obj/item/slime_extract/red/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, span_notice("Você ativa.[src]Você começa a se sentir rápido!"))
			user.reagents.add_reagent(/datum/reagent/medicine/ephedrine,5)
			return 450

		if(SLIME_ACTIVATE_MAJOR)
			user.visible_message(span_warning("[user]A pele fica vermelha por um momento..."), span_warning("Sua pele fica vermelha quando emite feromônios indutores de raiva..."))
			for(var/mob/living/basic/slime/slime in viewers(get_turf(user), null))
				slime.ai_controller?.set_blackboard_key(BB_SLIME_RABID, TRUE)
				slime.visible_message(span_danger("O[slime]é levado a um frenesi!"))
			return 600

/obj/item/slime_extract/blue
	name = "blue slime extract"
	icon_state = "blue-core"
	crossbreed_modification = "stabilized"

/obj/item/slime_extract/blue/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, span_notice("Você ativa.[src]Seu genoma parece mais estável!"))
			user.reagents.add_reagent(/datum/reagent/medicine/mutadone, 10)
			user.reagents.add_reagent(/datum/reagent/medicine/potass_iodide, 10)
			return 250

		if(SLIME_ACTIVATE_MAJOR)
			user.reagents.create_foam(/datum/effect_system/fluid_spread/foam, 20, log = TRUE)
			user.visible_message(span_danger("Espuma vomita de[user]Pele!"), span_warning("Você ativa.[src]E a espuma sai da sua pele!"))
			return 600

/obj/item/slime_extract/darkblue
	name = "dark blue slime extract"
	icon_state = "dark-blue-core"
	crossbreed_modification = "chilling"

/obj/item/slime_extract/darkblue/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, span_notice("Você ativa.[src]Você começa a sentir mais frio!"))
			user.extinguish_mob()
			user.adjust_wet_stacks(20)
			user.reagents.add_reagent(/datum/reagent/consumable/frostoil,6)
			user.reagents.add_reagent(/datum/reagent/medicine/regen_jelly,7)
			return 100

		if(SLIME_ACTIVATE_MAJOR)
			var/turf/open/T = get_turf(user)
			if(istype(T))
				T.atmos_spawn_air("[GAS_N2]=40;[TURF_TEMPERATURE(2.7)]")
			to_chat(user, span_warning("Você ativa.[src]E o ar gelado sai da sua pele!"))
			return 900

/obj/item/slime_extract/pink
	name = "pink slime extract"
	icon_state = "pink-core"
	crossbreed_modification = "gentle"

/obj/item/slime_extract/pink/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			if(user.gender != MALE && user.gender != FEMALE)
				to_chat(user, span_warning("Não pode trocar de sexo!"))
				return

			if(user.gender == MALE)
				user.gender = FEMALE
				user.visible_message(span_boldnotice("[user]De repente parece mais feminino!"), span_boldwarning("De repente você se sente mais feminina!"))
			else
				user.gender = MALE
				user.visible_message(span_boldnotice("[user]De repente parece mais masculino!"), span_boldwarning("Você de repente se sente mais masculino!"))
			return 100

		if(SLIME_ACTIVATE_MAJOR)
			user.visible_message(span_warning("[user]A pele começa a piscar hipnoticamente..."), span_notice("Sua pele começa a formar padrões estranhos, pacificando criaturas ao seu redor."))
			for(var/mob/living/carbon/C in viewers(user, null))
				if(C != user)
					C.reagents.add_reagent(/datum/reagent/pax,2)
			return 600

/obj/item/slime_extract/green
	name = "green slime extract"
	icon_state = "green-core"
	crossbreed_modification = "mutative"

/obj/item/slime_extract/green/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, span_warning("Você se sente voltando à forma humana..."))
			if(do_after(user, 12 SECONDS, target = user))
				to_chat(user, span_warning("Você se sente humano novamente!"))
				user.set_species(/datum/species/human)
				return
			to_chat(user, span_notice("Você para a transformação."))

		if(SLIME_ACTIVATE_MAJOR)
			to_chat(user, span_warning("Você se sente mudando radicalmente seu tipo de lodo..."))
			if(do_after(user, 12 SECONDS, target = user))
				to_chat(user, span_warning("Você se sente diferente!"))
				user.set_species(pick(/datum/species/jelly/slime, /datum/species/jelly/stargazer))
				return
			to_chat(user, span_notice("Você para a transformação."))

/obj/item/slime_extract/lightpink
	name = "light pink slime extract"
	icon_state = "light-pink-core"
	crossbreed_modification = "loyal"

/obj/item/slime_extract/lightpink/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			var/obj/item/slimepotion/renaming/O = new(null, 1)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			user.visible_message(span_warning("[user]Cuspindo[O]!"), span_notice("Você cuspiu.[O]!"))
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			var/obj/item/slimepotion/sentience/O = new(null, 1)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			user.visible_message(span_warning("[user]Cuspindo[O]!"), span_notice("Você cuspiu.[O]!"))
			return 450

/obj/item/slime_extract/black
	name = "black slime extract"
	icon_state = "black-core"
	crossbreed_modification = "transformative"

/obj/item/slime_extract/black/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, span_userdanger("Você sente algo.<i>Errado.</i>dentro de você..."))
			user.ForceContractDisease(new /datum/disease/transformation/slime(), FALSE, TRUE)
			return 100

		if(SLIME_ACTIVATE_MAJOR)
			to_chat(user, span_warning("Você sente sua própria luz ficando escura..."))
			if(do_after(user, 12 SECONDS, target = user))
				to_chat(user, span_warning("Você sente um desejo pela escuridão."))
				user.set_species(pick(/datum/species/shadow))
				return
			to_chat(user, span_notice("Pare de se alimentar.[src]."))

/obj/item/slime_extract/oil
	name = "oil slime extract"
	icon_state = "oil-core"
	crossbreed_modification = "detonating"

/obj/item/slime_extract/oil/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, span_warning("Você vomita óleo escorregadio."))
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			new /obj/effect/decal/cleanable/blood/oil/slippery(get_turf(user))
			return 450

		if(SLIME_ACTIVATE_MAJOR)
			user.visible_message(span_warning("[user]A pele começa a pulsar e a brilhar ameaçadoramente..."), span_userdanger("Você se sente instável..."))
			if(do_after(user, 6 SECONDS, target = user))
				to_chat(user, span_userdanger("Você explode!"))
				explosion(user, devastation_range = 1, heavy_impact_range = 3, light_impact_range = 6, explosion_cause = src)
				user.investigate_log("has been gibbed by an oil slime extract explosion.", INVESTIGATE_DEATHS)
				user.gib(DROP_ALL_REMAINS)
				return
			to_chat(user, span_notice("Pare de se alimentar.[src]E o sentimento passa."))

/obj/item/slime_extract/adamantine
	name = "adamantine slime extract"
	icon_state = "adamantine-core"
	crossbreed_modification = "crystalline"

/obj/item/slime_extract/adamantine/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			if(HAS_TRAIT(user, TRAIT_ADAMANTINE_EXTRACT_ARMOR))
				to_chat(user, span_warning("Sua pele já está endurecida!"))
				return
			ADD_TRAIT(user, TRAIT_ADAMANTINE_EXTRACT_ARMOR, ADAMANTINE_EXTRACT_TRAIT)
			to_chat(user, span_notice("Você sente sua pele endurecer e se tornar mais resistente."))
			user.physiology.damage_resistance += 25
			addtimer(CALLBACK(src, PROC_REF(reset_armor), user), 120 SECONDS)
			return 450

		if(SLIME_ACTIVATE_MAJOR)
			to_chat(user, span_warning("Você sente seu corpo endurecendo rapidamente..."))
			if(do_after(user, 12 SECONDS, target = user))
				to_chat(user, span_warning("Você se sente sólida."))
				user.set_species(/datum/species/golem)
				return
			to_chat(user, span_notice("Pare de se alimentar.[src], e seu corpo retorna ao seu estado viscoso."))

/obj/item/slime_extract/adamantine/proc/reset_armor(mob/living/carbon/human/user)
	REMOVE_TRAIT(user, TRAIT_ADAMANTINE_EXTRACT_ARMOR, ADAMANTINE_EXTRACT_TRAIT)
	user.physiology.damage_resistance -= 25

/obj/item/slime_extract/bluespace
	name = "bluespace slime extract"
	icon_state = "bluespace-core"
	crossbreed_modification = "warping"
	var/teleport_ready = FALSE
	var/teleport_x = 0
	var/teleport_y = 0
	var/teleport_z = 0

/obj/item/slime_extract/bluespace/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			to_chat(user, span_warning("Você sente seu corpo vibrando..."))
			if(do_after(user, 2.5 SECONDS, target = user))
				to_chat(user, span_warning("Você se teletransporta!"))
				do_teleport(user, get_turf(user), 6, asoundin = 'sound/items/weapons/emitter2.ogg', channel = TELEPORT_CHANNEL_BLUESPACE)
				return 300

		if(SLIME_ACTIVATE_MAJOR)
			if(!teleport_ready)
				to_chat(user, span_notice("Você se sente ancorado neste lugar..."))
				var/turf/T = get_turf(user)
				teleport_x = T.x
				teleport_y = T.y
				teleport_z = T.z
				teleport_ready = TRUE
			else
				teleport_ready = FALSE
				if(teleport_x && teleport_y && teleport_z)
					var/turf/T = locate(teleport_x, teleport_y, teleport_z)
					to_chat(user, span_notice("Volte para o seu ponto de ancoragem!"))
					do_teleport(user, T,  asoundin = 'sound/items/weapons/emitter2.ogg', channel = TELEPORT_CHANNEL_BLUESPACE)
					return 450


/obj/item/slime_extract/pyrite
	name = "pyrite slime extract"
	icon_state = "pyrite-core"
	crossbreed_modification = "prismatic"

/obj/item/slime_extract/pyrite/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			var/chosen = pick(difflist(subtypesof(/obj/item/toy/crayon),typesof(/obj/item/toy/crayon/spraycan)))
			var/obj/item/O = new chosen(null)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			user.visible_message(span_warning("[user]Cuspindo[O]!"), span_notice("Você cuspiu.[O]!"))
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			var/blacklisted_cans = list(/obj/item/toy/crayon/spraycan/borg, /obj/item/toy/crayon/spraycan/infinite)
			var/chosen = pick(subtypesof(/obj/item/toy/crayon/spraycan) - blacklisted_cans)
			var/obj/item/O = new chosen(null)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			user.visible_message(span_warning("[user]Cuspindo[O]!"), span_notice("Você cuspiu.[O]!"))
			return 250

/obj/item/slime_extract/cerulean
	name = "cerulean slime extract"
	icon_state = "cerulean-core"
	crossbreed_modification = "recurring"

/obj/item/slime_extract/cerulean/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			user.reagents.add_reagent(/datum/reagent/medicine/salbutamol,15)
			to_chat(user, span_notice("Você sente que não precisa respirar!"))
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			var/turf/open/T = get_turf(user)
			if(istype(T))
				T.atmos_spawn_air("[GAS_O2]=11;[GAS_N2]=41;[TURF_TEMPERATURE(T20C)]")
				to_chat(user, span_warning("Você ativa.[src]E o ar fresco sai da sua pele!"))
				return 600

/obj/item/slime_extract/sepia
	name = "sepia slime extract"
	icon_state = "sepia-core"
	crossbreed_modification = "lengthened"

/obj/item/slime_extract/sepia/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			var/obj/item/camera/O = new(null, 1)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			user.visible_message(span_warning("[user]Cuspindo[O]!"), span_notice("Você cuspiu.[O]!"))
			return 150

		if(SLIME_ACTIVATE_MAJOR)
			to_chat(user, span_warning("Você sente o tempo devagar..."))
			if(do_after(user, 3 SECONDS, target = user))
				new /obj/effect/timestop(get_turf(user), 2, 50, list(user))
				return 900

/obj/item/slime_extract/rainbow
	name = "rainbow slime extract"
	icon_state = "rainbow-core"
	crossbreed_modification = "hyperchromatic"

/obj/item/slime_extract/rainbow/activate(mob/living/carbon/human/user, datum/species/jelly/luminescent/species, activation_type)
	switch(activation_type)
		if(SLIME_ACTIVATE_MINOR)
			user.dna.features[FEATURE_MUTANT_COLOR] = "#[pick("7F", "FF")][pick("7F", "FF")][pick("7F", "FF")]"
			user.dna.update_uf_block(/datum/dna_block/feature/mutant_color)
			user.updateappearance(mutcolor_update=1)
			species.update_glow(user)
			to_chat(user, span_notice("Você se sente diferente..."))
			return 100

		if(SLIME_ACTIVATE_MAJOR)
			var/chosen = pick(subtypesof(/obj/item/slime_extract))
			var/obj/item/O = new chosen(null)
			if(!user.put_in_active_hand(O))
				O.forceMove(user.drop_location())
			playsound(user, 'sound/effects/splat.ogg', 50, TRUE)
			user.visible_message(span_warning("[user]Cuspindo[O]!"), span_notice("Você cuspiu.[O]!"))
			return 150

////Slime-derived potions///

/**
* #Slime potions
*
* Feed slimes potions either by hand or using the slime console.
*
* Slime potions either augment the slime's behavior, its extract output, or its intelligence. These all come either from extract effects or cross cores.
* A few of the more powerful ones can modify someone's equipment or gender.
* New ones should probably be accessible only through cross cores as all the normal core types already have uses. Rule of thumb is 'stronger effects go in cross cores'.
*/

/obj/item/slimepotion
	name = "slime potion"
	desc = "Uma cápsula dura, mas gelatinosa, excretada por um lodo, contendo substâncias misteriosas."
	icon = 'icons/obj/medical/chemical.dmi'
	w_class = WEIGHT_CLASS_TINY

/obj/item/slimepotion/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(is_reagent_container(interacting_with))
		to_chat(user, span_warning("Você não pode transferir.[src]para[interacting_with]! Parece que a poção deve ser dada diretamente a um lodo ou outro objeto para absorver.") )
		return ITEM_INTERACT_BLOCKING
	return NONE

/obj/item/slimepotion/slime/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(isslime(interacting_with))
		return interact_with_slime(interacting_with, user, modifiers)
	else
		to_chat(user, span_warning("Parece[src]deve ser dado diretamente a um lodo para absorver."))
		return NONE

/obj/item/slimepotion/slime/proc/interact_with_slime(mob/living/basic/slime/interacting_slime, mob/living/user, list/modifiers)
	return

/obj/item/slimepotion/slime/docility
	name = "docility potion"
	desc = "Uma potente mistura química que anula a fome de um lodo, fazendo com que ele se torne dócil e manso."
	icon_state = "potsilver"

/obj/item/slimepotion/slime/docility/interact_with_slime(mob/living/basic/slime/interacting_slime, mob/living/user, list/modifiers)
	if(interacting_slime.stat)
		to_chat(user, span_warning("O lodo está morto!"))
		return ITEM_INTERACT_BLOCKING
	if(interacting_slime.ai_controller?.clear_blackboard_key(BB_SLIME_RABID)) //Stops being rabid, but doesn't become truly docile.
		to_chat(interacting_slime, span_warning("Você absorve a poção, e sua fome raivosa finalmente se resolve a um desejo normal de se alimentar."))
		to_chat(user, span_notice("Você alimenta o lodo da poção, acalmando sua raiva."))
		interacting_slime.set_default_behaviour()
		qdel(src)
		return ITEM_INTERACT_SUCCESS
	interacting_slime.set_pacified_behaviour()
	to_chat(interacting_slime, span_warning("Você absorve a poção e sente seu desejo intenso de se alimentar."))
	to_chat(user, span_notice("Você alimenta o lodo da poção, removendo sua fome e acalmando-a."))
	var/newname = sanitize_name(tgui_input_text(user, "Would you like to give the slime a name?", "Name your new pet", "Pet Slime", MAX_NAME_LEN))

	if (!newname)
		newname = "Pet Slime"
	interacting_slime.name = newname
	interacting_slime.real_name = newname
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/slimepotion/sentience
	name = "intelligence potion"
	desc = "Uma mistura química milagrosa que dá inteligência humana a seres vivos."
	icon_state = "potpink"
	/// Are we being offered to a mob, and therefore is a ghost poll currently in progress for the sentient mob?
	var/being_used = FALSE
	var/sentience_type = SENTIENCE_ORGANIC
	/// Reason for offering potion. This will be displayed in the poll alert to ghosts.
	var/potion_reason

/obj/item/slimepotion/sentience/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click para definir a razão da oferta da poção.[potion_reason ? "Current reason: [span_warning(potion_reason)]" : null]")

/obj/item/slimepotion/sentience/Initialize(mapload)
	register_context()
	return ..()

/obj/item/slimepotion/sentience/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	context[SCREENTIP_CONTEXT_ALT_LMB] = "Set potion offer reason"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/slimepotion/sentience/click_alt(mob/living/user)
	potion_reason = tgui_input_text(user, "Enter reason for offering potion", "Intelligence Potion", potion_reason, max_length = MAX_MESSAGE_LEN, multiline = TRUE)
	return CLICK_ACTION_SUCCESS

/obj/item/slimepotion/sentience/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(!isliving(interacting_with))
		return NONE
	var/mob/living/dumb_mob = interacting_with
	if(being_used)
		return ITEM_INTERACT_BLOCKING
	if(dumb_mob.ckey) //only works on animals that aren't player controlled
		balloon_alert(user, "Já senciente!")
		return ITEM_INTERACT_BLOCKING
	if(dumb_mob.stat)
		balloon_alert(user, "está morto!")
		return ITEM_INTERACT_BLOCKING
	if(!dumb_mob.compare_sentience_type(sentience_type)) // Will also return false if not a basic or simple mob, which are the only two we want anyway
		balloon_alert(user, "criatura inválida!")
		return ITEM_INTERACT_BLOCKING
	balloon_alert(user, "offering...")
	being_used = TRUE
	var/mob/chosen_one = SSpolling.poll_ghosts_for_target(
		question = "[span_danger(user.name)] is offering [span_notice(dumb_mob.name)] an intelligence potion![potion_reason ? " Reason: [span_boldnotice(potion_reason)]" : ""]",
		check_jobban = ROLE_SENTIENCE,
		poll_time = 20 SECONDS,
		checked_target = dumb_mob,
		ignore_category = POLL_IGNORE_SENTIENCE_POTION,
		alert_pic = dumb_mob,
		role_name_text = "Poção da inteligência",
		chat_text_border_icon = src,
	)
	on_poll_concluded(user, dumb_mob, chosen_one)
	return ITEM_INTERACT_SUCCESS

/// Assign the chosen ghost to the mob
/obj/item/slimepotion/sentience/proc/on_poll_concluded(mob/user, mob/living/dumb_mob, mob/dead/observer/ghost)
	if(isnull(ghost))
		balloon_alert(user, "Tente novamente mais tarde!")
		being_used = FALSE
		return

	dumb_mob.PossessByPlayer(ghost.key)
	dumb_mob.mind.enslave_mind_to_creator(user)
	SEND_SIGNAL(dumb_mob, COMSIG_SIMPLEMOB_SENTIENCEPOTION, user)

	if(isanimal(dumb_mob))
		var/mob/living/simple_animal/smart_animal = dumb_mob
		smart_animal.sentience_act()

	dumb_mob.mind.add_antag_datum(/datum/antagonist/sentient_creature)
	balloon_alert(user, "success")
	after_success(user, dumb_mob)
	qdel(src)

/obj/item/slimepotion/sentience/proc/after_success(mob/living/user, mob/living/smart_mob)
	return

/obj/item/slimepotion/sentience/nuclear
	name = "syndicate intelligence potion"
	desc = "Uma mistura química milagrosa que dá inteligência humana a seres vivos. Foi modificado com tecnologia Syndicate para também conceder um implante de rádio interno ao alvo e autenticar com sistemas de identificação."

/obj/item/slimepotion/sentience/nuclear/after_success(mob/living/user, mob/living/smart_mob)
	var/obj/item/implant/radio/syndicate/imp = new(src)
	imp.implant(smart_mob, user)
	smart_mob.AddComponent(/datum/component/simple_access, list(ACCESS_SYNDICATE, ACCESS_MAINT_TUNNELS))

/obj/item/slimepotion/sentience/nuclear/dangerous_horse
	name = "dangerous pony potion"
	desc = "Uma mistura química milagrosa que dá inteligência humana a seres pôneis. Ele foi modificado com tecnologia Syndicate para também conceder um implante de rádio interno para o pônei e autenticar com sistemas de identificação"
	sentience_type = SENTIENCE_PONY

/obj/item/slimepotion/transference
	name = "consciousness transference potion"
	desc = "Uma estranha substância química à base de lodo que, quando usada, permite ao usuário transferir sua consciência para um ser menor."
	icon_state = "potorange"
	var/prompted = 0
	var/animal_type = SENTIENCE_ORGANIC

/obj/item/slimepotion/transference/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(!isliving(interacting_with))
		return NONE
	var/mob/living/switchy_mob = interacting_with
	if(prompted)
		return ITEM_INTERACT_BLOCKING
	if(switchy_mob.ckey) //much like sentience, these will not work on something that is already player controlled
		balloon_alert(user, "Já senciente!")
		return ITEM_INTERACT_BLOCKING
	if(switchy_mob.stat)
		balloon_alert(user, "está morto!")
		return ITEM_INTERACT_BLOCKING
	if(!switchy_mob.compare_sentience_type(animal_type))
		balloon_alert(user, "criatura inválida!")
		return ITEM_INTERACT_BLOCKING

	var/job_banned = is_banned_from(user.ckey, ROLE_MIND_TRANSFER)
	if(QDELETED(src) || QDELETED(switchy_mob) || QDELETED(user))
		return ITEM_INTERACT_BLOCKING

	if(job_banned)
		balloon_alert(user, "Você está banido!")
		return ITEM_INTERACT_BLOCKING

	user.do_attack_animation(interacting_with)
	prompted = 1
	if(tgui_alert(usr,"Isso irá transferir permanentemente sua consciência para[switchy_mob]Tem certeza que quer fazer isso?",,list("Yes","No")) != "Yes")
		prompted = 0
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("Você bebe a poção e coloca as mãos[switchy_mob]..."))

	user.mind.transfer_to(switchy_mob)
	SEND_SIGNAL(switchy_mob, COMSIG_SIMPLEMOB_TRANSFERPOTION, user)
	SET_FACTION_AND_ALLIES_FROM( switchy_mob, user)
	switchy_mob.copy_languages(user, LANGUAGE_MIND)
	user.death()
	to_chat(switchy_mob, span_notice("Em um flash rápido, você sente sua consciência fluir para[switchy_mob]!"))
	to_chat(switchy_mob, span_warning("Agora você é.[switchy_mob]Suas lealdades, alianças e papel ainda são as mesmas que eram antes da transferência de consciência!"))
	switchy_mob.name = "[user.real_name]"
	qdel(src)
	if(isanimal(switchy_mob))
		var/mob/living/simple_animal/switchy_animal= switchy_mob
		switchy_animal.sentience_act()
	return ITEM_INTERACT_SUCCESS

/obj/item/slimepotion/slime/steroid
	name = "slime steroid"
	desc = "Uma potente mistura química que fará um bebê gerar mais extrato."
	icon_state = "potred"

/obj/item/slimepotion/slime/steroid/interact_with_slime(mob/living/basic/slime/interacting_slime, mob/living/user, list/modifiers)
	if(interacting_slime.life_stage == SLIME_LIFE_STAGE_ADULT) //Can't steroidify adults
		to_chat(user, span_warning("Só os bebês podem usar esteroides!"))
		return ITEM_INTERACT_BLOCKING
	if(interacting_slime.stat)
		to_chat(user, span_warning("O lodo está morto!"))
		return ITEM_INTERACT_BLOCKING
	if(interacting_slime.cores >= 5)
		to_chat(user, span_warning("O lodo já tem a quantidade máxima de extrato!"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("Você alimenta o lodo do esteróide. Agora produzirá mais um extrato."))
	interacting_slime.cores++
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/slimepotion/enhancer
	name = "extract enhancer"
	desc = "Uma potente mistura química que dará a um extrato de lodo um uso adicional."
	icon_state = "potpurple"

/obj/item/slimepotion/slime/stabilizer
	name = "slime stabilizer"
	desc = "Uma potente mistura química que reduzirá a chance de uma lama mutando."
	icon_state = "potcyan"

/obj/item/slimepotion/slime/stabilizer/interact_with_slime(mob/living/basic/slime/interacting_slime, mob/living/user, list/modifiers)
	if(interacting_slime.stat)
		to_chat(user, span_warning("O lodo está morto!"))
		return ITEM_INTERACT_BLOCKING
	if(interacting_slime.mutation_chance == 0)
		to_chat(user, span_warning("O lodo já não tem chance de sofrer mutação!"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("Você alimenta o lodo do estabilizador. Agora é menos provável que mude."))
	interacting_slime.mutation_chance = clamp(interacting_slime.mutation_chance-15,0,100)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/slimepotion/slime/mutator
	name = "slime mutator"
	desc = "Uma potente mistura química que aumentará a chance de uma lama mutando."
	icon_state = "potgreen"

/obj/item/slimepotion/slime/mutator/interact_with_slime(mob/living/basic/slime/interacting_slime, mob/living/user, list/modifiers)
	if(interacting_slime.stat)
		to_chat(user, span_warning("O lodo está morto!"))
		return ITEM_INTERACT_BLOCKING
	if(interacting_slime.mutator_used)
		to_chat(user, span_warning("Este lodo já consumiu um mutante, mais seria muito instável!"))
		return ITEM_INTERACT_BLOCKING
	if(interacting_slime.mutation_chance == 100)
		to_chat(user, span_warning("O lodo já está garantido para mutar!"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("Você alimenta o lodo do mutante. Agora é mais provável que mude."))
	interacting_slime.mutation_chance = clamp(interacting_slime.mutation_chance+12,0,100)
	interacting_slime.mutator_used = TRUE
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/slimepotion/speed
	name = "slime speed potion"
	desc = "Uma potente mistura química que removerá a desaceleração de qualquer item."
	icon_state = "potred"

/obj/item/slimepotion/speed/interact_with_atom(obj/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(!isobj(interacting_with))
		to_chat(user, span_warning("A poção só pode ser usada em objetos!"))
		return NONE

	if(HAS_TRAIT(interacting_with, TRAIT_SPEED_POTIONED))
		to_chat(user, span_warning("[interacting_with]Não pode ser mais rápido!"))
		return ITEM_INTERACT_BLOCKING

	if(isitem(interacting_with))
		var/obj/item/apply_to = interacting_with
		if(apply_to.slowdown <= 0 || (apply_to.item_flags & IMMUTABLE_SLOW) || HAS_TRAIT(apply_to, TRAIT_NO_SPEED_POTION))
			if(interacting_with.atom_storage)
				return NONE // lets us put the potion in the bag
			to_chat(user, span_warning("[apply_to]Não pode ser mais rápido!"))
			return ITEM_INTERACT_BLOCKING

	if(SEND_SIGNAL(interacting_with, COMSIG_SPEED_POTION_APPLIED, src, user) & SPEED_POTION_STOP)
		return ITEM_INTERACT_SUCCESS

	if(isitem(interacting_with))
		var/obj/item/apply_to = interacting_with
		apply_to.slowdown = 0

	to_chat(user, span_notice("Você desliza o cocô vermelho sobre o[interacting_with], tornando mais rápido."))
	interacting_with.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	interacting_with.add_atom_colour(color_transition_filter(COLOR_RED, SATURATION_OVERRIDE), FIXED_COLOUR_PRIORITY)
	interacting_with.drag_slowdown = 0
	ADD_TRAIT(interacting_with, TRAIT_SPEED_POTIONED, SLIME_POTION_TRAIT)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/slimepotion/fireproof
	name = "slime chill potion"
	desc = "Uma potente mistura química que irá proteger qualquer peça de roupa. Tem três utilidades."
	icon_state = "potblue"
	resistance_flags = FIRE_PROOF
	var/uses = 3

/obj/item/slimepotion/fireproof/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(uses <= 0)
		qdel(src)
		return ITEM_INTERACT_BLOCKING
	var/obj/item/clothing/clothing = interacting_with
	if(!istype(clothing))
		to_chat(user, span_warning("A poção só pode ser usada em roupas!"))
		return NONE
	if(clothing.max_heat_protection_temperature >= FIRE_IMMUNITY_MAX_TEMP_PROTECT)
		to_chat(user, span_warning("O[clothing]Já é à prova de fogo!"))
		return ITEM_INTERACT_BLOCKING
	to_chat(user, span_notice("Você esfrega a gosma azul sobre o[clothing], à prova de fogo."))
	clothing.name = "fireproofed [clothing.name]"
	clothing.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	clothing.add_atom_colour(color_transition_filter(COLOR_NAVY, SATURATION_OVERRIDE), FIXED_COLOUR_PRIORITY)
	clothing.max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	clothing.heat_protection = clothing.body_parts_covered
	clothing.resistance_flags |= FIRE_PROOF
	uses --
	if(uses <= 0)
		qdel(src)
	return ITEM_INTERACT_BLOCKING

/obj/item/slimepotion/genderchange
	name = "gender change potion"
	desc = "Uma mistura química interessante que muda o gênero biológico do que se aplica. Não pode ser usado em coisas sem gênero."
	icon_state = "potrainbow"

/obj/item/slimepotion/genderchange/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(!isliving(interacting_with))
		return NONE
	var/mob/living/living_mob = interacting_with
	if(living_mob.stat == DEAD)
		to_chat(user, span_warning("A poção só pode ser usada em seres vivos!"))
		return ITEM_INTERACT_BLOCKING

	if(living_mob.gender != MALE && living_mob.gender != FEMALE)
		to_chat(user, span_warning("A poção só pode ser usada em coisas de gênero!"))
		return ITEM_INTERACT_BLOCKING

	if(living_mob.gender == MALE)
		living_mob.gender = FEMALE
		living_mob.visible_message(span_boldnotice("[living_mob]De repente parece mais feminino!"), span_boldwarning("De repente você se sente mais feminina!"))
	else
		living_mob.gender = MALE
		living_mob.visible_message(span_boldnotice("[living_mob]De repente parece mais masculino!"), span_boldwarning("Você de repente se sente mais masculino!"))
	living_mob.regenerate_icons()
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/slimepotion/renaming
	name = "renaming potion"
	desc = "Uma poção que permite que um ser autoconsciente mude o nome que subconscientemente apresenta ao mundo."
	icon_state = "potbrown"

	var/being_used = FALSE

/obj/item/slimepotion/renaming/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(!isliving(interacting_with))
		return NONE
	var/mob/living/renaming_mob = interacting_with
	if(being_used)
		return ITEM_INTERACT_BLOCKING
	if(!renaming_mob.ckey) //only works on animals that aren't player controlled
		to_chat(user, span_warning("[renaming_mob]não é consciente de si mesmo, e não pode escolher seu próprio nome."))
		return ITEM_INTERACT_BLOCKING

	being_used = TRUE

	to_chat(user, span_notice("Você oferece[src]para[user]..."))

	var/new_name = sanitize_name(tgui_input_text(renaming_mob, "What would you like your name to be?", "Input a name", renaming_mob.real_name, MAX_NAME_LEN))

	if(!new_name || QDELETED(src) || QDELETED(renaming_mob) || new_name == renaming_mob.real_name || !renaming_mob.Adjacent(user))
		being_used = FALSE
		return ITEM_INTERACT_BLOCKING

	renaming_mob.visible_message(span_notice("[span_name("[renaming_mob]")]tem um novo nome,[span_name("[new_name]")]."), span_notice("Seu antigo nome de[span_name("[renaming_mob.real_name]")]Desaparece, e seu novo nome[span_name("[new_name]")]ancora-se em sua mente."))
	message_admins("[ADMIN_LOOKUPFLW(user)] used [src] on [ADMIN_LOOKUPFLW(renaming_mob)], letting them rename themselves into [new_name].")
	user.log_message("used [src] on [key_name(renaming_mob)], letting them rename themselves into [new_name].", LOG_GAME)

	// pass null as first arg to not update records or ID/PDA
	renaming_mob.fully_replace_character_name(null, new_name)

	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/slimepotion/slimeradio
	name = "bluespace radio potion"
	desc = "Um estranho químico que concede a quem o ingerir a capacidade de transmitir e receber ondas de rádio subscape."
	icon_state = "potbluespace"

/obj/item/slimepotion/slimeradio/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(!isliving(interacting_with))
		return NONE
	if(!isanimal_or_basicmob(interacting_with))
		to_chat(user, span_warning("[interacting_with]É muito complexo para a poção!"))
		return ITEM_INTERACT_BLOCKING
	var/mob/living/radio_head = interacting_with
	if(radio_head.stat)
		to_chat(user, span_warning("[radio_head]Está morto!"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("Você alimenta a poção para[radio_head]."))
	to_chat(radio_head, span_notice("Sua mente treme quando é alimentada com a poção. Você pode ouvir ondas de rádio agora!"))
	var/obj/item/implant/radio/slime/imp = new(src)
	imp.implant(radio_head, user)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

///Definitions for slime products that don't have anywhere else to go (Floor tiles, blueprints).

/obj/item/stack/tile/bluespace
	name = "stabilized bluespace floor tile"
	singular_name = "piso azulejo"
	desc = "Através de uma série de micro-teleports esses azulejos deixam as pessoas se moverem em velocidades incríveis."
	icon_state = "tile_bluespace"
	inhand_icon_state = "tile-bluespace"
	w_class = WEIGHT_CLASS_NORMAL
	force = 6
	mats_per_unit = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*5)
	throwforce = 10
	throw_speed = 3
	throw_range = 7
	obj_flags = CONDUCTS_ELECTRICITY
	max_amount = 60
	turf_type = /turf/open/floor/bluespace
	merge_type = /obj/item/stack/tile/bluespace

/obj/item/stack/tile/sepia
	name = "sepia floor tile"
	singular_name = "piso azulejo"
	desc = "O tempo parece fluir muito lentamente ao redor destes azulejos."
	icon_state = "tile_sepia"
	inhand_icon_state = "tile-sepia"
	w_class = WEIGHT_CLASS_NORMAL
	force = 6
	mats_per_unit = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*5)
	throwforce = 10
	throw_speed = 0.1
	throw_range = 28
	obj_flags = CONDUCTS_ELECTRICITY
	max_amount = 60
	turf_type = /turf/open/floor/sepia
	merge_type = /obj/item/stack/tile/sepia
