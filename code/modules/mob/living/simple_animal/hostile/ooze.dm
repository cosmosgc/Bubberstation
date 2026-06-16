///Oozes are slime-esque creatures, they are highly gluttonous creatures primarily intended for player controll.
/mob/living/simple_animal/hostile/ooze
	name = "Ooze"
	icon = 'icons/mob/vatgrowing.dmi'
	icon_state = "gelatinous"
	icon_living = "gelatinous"
	icon_dead = "gelatinous_dead"
	mob_biotypes = MOB_ORGANIC
	pass_flags = PASSTABLE | PASSGRILLE
	gender = NEUTER
	emote_see = list("jiggles", "bounces in place")
	speak_emote = list("blorbles")
	atmos_requirements = null
	hud_type = /datum/hud/ooze
	minbodytemp = 250
	maxbodytemp = INFINITY
	faction = list(FACTION_SLIME)
	melee_damage_lower = 10
	melee_damage_upper = 10
	health = 200
	maxHealth = 200
	attack_verb_continuous = "slimes"
	attack_verb_simple = "slime"
	attack_sound = 'sound/effects/blob/blobattack.ogg'
	combat_mode = TRUE
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	mob_size = MOB_SIZE_LARGE
	initial_language_holder = /datum/language_holder/slime
	footstep_type = FOOTSTEP_MOB_SLIME
	///Oozes have their own nutrition. Changes based on them eating
	var/ooze_nutrition = 50
	var/ooze_nutrition_loss = -0.15
	var/ooze_metabolism_modifier = 2
	///Bitfield of edible food types
	var/edible_food_types = MEAT

/mob/living/simple_animal/hostile/ooze/Initialize(mapload)
	. = ..()
	create_reagents(300)
	add_cell_sample()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	AddElement(/datum/element/content_barfer)

	grant_actions_by_list(get_innate_actions())

/mob/living/simple_animal/hostile/ooze/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(eat_atom(tool, TRUE))
		return ITEM_INTERACT_SUCCESS
	return ..()

/mob/living/simple_animal/hostile/ooze/resolve_unarmed_attack(atom/attack_target, list/modifiers)
	if(eat_atom(attack_target))
		return ITEM_INTERACT_SUCCESS
	return ..()

///Handles nutrition gain/loss of mob and also makes it take damage if it's too low on nutrition, only happens for sentient mobs.
/mob/living/simple_animal/hostile/ooze/Life(seconds_per_tick = SSMOBS_DT)
	. = ..()

	if(!.) //dead or deleted
		return

	if(!mind && stat != DEAD)//no mind no change
		return

	var/nutrition_change = ooze_nutrition_loss

	//Eat a bit of all the reagents we have. Gaining nutrition for actual nutritional ones.
	for(var/i in reagents?.reagent_list)
		var/datum/reagent/reagent = i
		var/consumption_amount = min(reagents.get_reagent_amount(reagent.type), ooze_metabolism_modifier * REAGENTS_METABOLISM * seconds_per_tick)
		if(istype(reagent, /datum/reagent/consumable))
			var/datum/reagent/consumable/consumable = reagent
			nutrition_change += consumption_amount * consumable.get_nutriment_factor(src)
		reagents.remove_reagent(reagent.type, consumption_amount)
	adjust_ooze_nutrition(nutrition_change)

	if(ooze_nutrition <= 0)
		adjust_brute_loss(0.25 * seconds_per_tick)

/// Returns an applicable list of actions to grant to the mob. Will return a list or null.
/mob/living/simple_animal/hostile/ooze/proc/get_innate_actions()
	return null

///Does ooze_nutrition + supplied amount and clamps it within 0 and 500
/mob/living/simple_animal/hostile/ooze/proc/adjust_ooze_nutrition(amount)
	ooze_nutrition = clamp(ooze_nutrition + amount, 0, 500)
	hud_used?.screen_objects[HUD_OOZE_NUTRITION_DISPLAY]?.maptext = MAPTEXT( 		"<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='green'>[round(ooze_nutrition)]</font></div>" 	)

///Tries to transfer the atoms reagents then delete it
/mob/living/simple_animal/hostile/ooze/proc/eat_atom(atom/eat_target, silent)
	if(isnull(eat_target))
		return FALSE
	if(SEND_SIGNAL(eat_target, COMSIG_OOZE_EAT_ATOM, src, edible_food_types) & COMPONENT_ATOM_EATEN)
		return TRUE
	if(silent || !isitem(eat_target)) //Don't bother reporting it for everything
		return FALSE
	to_chat(src, span_warning("[eat_target] Não pode ser comido!"))
	return FALSE

///* Gelatinious Ooze code below *\\\

///Its good stats and high mobility makes this a good assasin type creature. It's vulnerabilites against cold, shotguns and
/mob/living/simple_animal/hostile/ooze/gelatinous
	name = "Gelatinous Cube"
	desc = "Uma mancha cúbica nativa de Sholus VII.\nDesde o advento da viagem espacial esta espécie se estabeleceu nas instalações de tratamento de resíduos de várias colônias espaciais.\nÉ frequentemente considerada a terceira espécie invasora mais infame devido à sua natureza altamente agressiva e predadora."
	speed = 1
	damage_coeff = list(BRUTE = 1, BURN = 0.6, TOX = 0.5, STAMINA = 0, OXY = 1)
	melee_damage_lower = 20
	melee_damage_upper = 20
	armour_penetration = 15
	obj_damage = 20
	death_message = "Cai em uma pilha de gosma!"
	///The ability to consume mobs
	var/datum/action/consume/consume

///Initializes the mobs abilities and gives them to the mob
/mob/living/simple_animal/hostile/ooze/gelatinous/Initialize(mapload)
	. = ..()
	consume = new
	consume.Grant(src)

/mob/living/simple_animal/hostile/ooze/gelatinous/get_innate_actions()
	var/static/list/innate_actions = list(
		/datum/action/cooldown/metabolicboost,
	)
	return innate_actions

///If this mob gets resisted by something, its trying to escape consumption.
/mob/living/simple_animal/hostile/ooze/gelatinous/container_resist_act(mob/living/user)
	. = ..()
	if(!do_after(user, 6 SECONDS)) //6 second struggle
		return FALSE
	consume.stop_consuming()

/mob/living/simple_animal/hostile/ooze/gelatinous/add_cell_sample()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_GELATINOUS, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)

///This ability lets the gelatinious ooze speed up for a little bit
/datum/action/cooldown/metabolicboost
	name = "Metabolic boost"
	desc = "Ganhar um aumento de velocidade temporário. Custa 10 nutrientes e lentamente aumenta sua temperatura."
	background_icon_state = "bg_hive"
	overlay_icon_state = "bg_hive_border"
	button_icon = 'icons/mob/actions/actions_slime.dmi'
	button_icon_state = "metabolic_boost"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_IMMOBILE
	cooldown_time = 24 SECONDS
	var/nutrition_cost = 10
	var/active = FALSE


///Mob needs to have enough nutrition
/datum/action/cooldown/metabolicboost/IsAvailable(feedback = FALSE)
	. = ..()
	var/mob/living/simple_animal/hostile/ooze/ooze = owner
	if(!.)
		return FALSE
	return (ooze.ooze_nutrition >= nutrition_cost && !active)

///Give the mob a speed boost, heat it up every second, and end the ability in 6 seconds
/datum/action/cooldown/metabolicboost/Activate(atom/target)
	StartCooldown(10 SECONDS)
	trigger_boost()
	StartCooldown()
	return TRUE

/*
 * Actually trigger the boost.
 */
/datum/action/cooldown/metabolicboost/proc/trigger_boost()
	var/mob/living/simple_animal/hostile/ooze/ooze = owner
	ooze.add_movespeed_modifier(/datum/movespeed_modifier/metabolicboost)
	var/timerid = addtimer(CALLBACK(src, PROC_REF(HeatUp)), 1 SECONDS, TIMER_STOPPABLE | TIMER_LOOP) //Heat up every second
	addtimer(CALLBACK(src, PROC_REF(FinishSpeedup), timerid), 6 SECONDS)
	to_chat(ooze, span_notice("Você começa a se sentir muito mais rápido."))
	active = TRUE
	ooze.adjust_ooze_nutrition(-10)

///Heat up the mob a little
/datum/action/cooldown/metabolicboost/proc/HeatUp()
	var/mob/living/simple_animal/hostile/ooze/ooze = owner
	ooze.adjust_bodytemperature(50)

///Remove the speed modifier and delete the timer for heating up
/datum/action/cooldown/metabolicboost/proc/FinishSpeedup(timerid)
	var/mob/living/simple_animal/hostile/ooze/ooze = owner
	ooze.remove_movespeed_modifier(/datum/movespeed_modifier/metabolicboost)
	to_chat(ooze, span_notice("Você começa a desacelerar novamente."))
	deltimer(timerid)
	active = FALSE
	StartCooldown()


///This action lets you consume the mob you're currently pulling. I'M GONNA CONSUUUUUME (this is considered one of the funny memes in the 2019-2020 era)
/datum/action/consume
	name = "Consume"
	desc = "Consuma uma multidão que você está arrastando para obter nutrição deles."
	background_icon_state = "bg_hive"
	overlay_icon_state = "bg_hive_border"
	button_icon = 'icons/mob/actions/actions_slime.dmi'
	button_icon_state = "consume"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_IMMOBILE|AB_CHECK_INCAPACITATED
	/// What do we call devouring something
	var/devour_verb = "devour"
	/// how much time to eat someone
	var/devour_time = 1.5 SECONDS
	///The mob thats being consumed by this creature
	var/mob/living/vored_mob

///Register for owner death
/datum/action/consume/New(Target)
	. = ..()
	RegisterSignal(owner, COMSIG_LIVING_DEATH, PROC_REF(stop_consuming))

///Try to consume the pulled mob
/datum/action/consume/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	var/mob/living/simple_animal/hostile/ooze/gelatinous/ooze = owner
	if(vored_mob) //one happy meal at a time, buddy
		stop_consuming()
		return FALSE
	if(!isliving(ooze.pulling))
		to_chat(src, span_warning("Você precisa estar puxando uma criatura para que isso funcione!"))
		return FALSE
	var/mob/living/eat_target = ooze.pulling
	owner.visible_message(span_warning("[ooze] Começa a tentar [devour_verb] [eat_target]!"), span_notice("Você começa a tentar [devour_verb] [eat_target]."))
	if(!do_after(ooze, devour_time, eat_target))
		return FALSE

	if(!(eat_target.mob_biotypes & MOB_ORGANIC) || eat_target.stat == DEAD)
		to_chat(src, span_warning("Esta criatura não é do meu gosto!"))
		return FALSE
	start_consuming(eat_target)

///Start allowing this datum to process to handle the damage done to  this mob.
/datum/action/consume/proc/start_consuming(mob/living/target)
	vored_mob = target
	vored_mob.forceMove(owner) ///AAAAAAAAAAAAAAAAAAAAAAHHH!!!
	RegisterSignal(vored_mob, COMSIG_QDELETING, PROC_REF(stop_consuming))
	playsound(owner,'sound/items/eatfood.ogg', rand(30,50), TRUE)
	owner.visible_message(span_warning("[owner] [devour_verb] S [target]!"), span_notice("Você.[devour_verb] [target]."))
	START_PROCESSING(SSprocessing, src)
	build_all_button_icons(UPDATE_BUTTON_NAME|UPDATE_BUTTON_ICON)

///Stop consuming the mob; dump them on the floor
/datum/action/consume/proc/stop_consuming()
	SIGNAL_HANDLER
	STOP_PROCESSING(SSprocessing, src)
	if (isnull(vored_mob))
		return
	vored_mob.forceMove(get_turf(owner))
	playsound(get_turf(owner), 'sound/effects/splat.ogg', 50, TRUE)
	owner.visible_message(span_warning("[owner] Vomite.[vored_mob]!"), span_notice("Você vomita.[vored_mob]."))
	UnregisterSignal(vored_mob, COMSIG_QDELETING)
	vored_mob = null
	build_all_button_icons(UPDATE_BUTTON_NAME|UPDATE_BUTTON_ICON)

///Gain health for the consumption and dump some brute loss on the target.
/datum/action/consume/process()
	var/mob/living/simple_animal/hostile/ooze/gelatinous/ooze = owner
	vored_mob.adjust_brute_loss(5)
	ooze.heal_ordered_damage((ooze.maxHealth * 0.03), list(BRUTE, BURN, OXY)) ///Heal 6% of these specific damage types each process
	if(istype(ooze))
		ooze.adjust_ooze_nutrition(3)

	///Dump 'em if they're dead.
	if(vored_mob.stat == DEAD)
		stop_consuming()

/datum/action/consume/Remove(mob/remove_from)
	stop_consuming()
	return ..()

/datum/action/consume/update_button_name(atom/movable/screen/movable/action_button/button, force)
	if(vored_mob)
		name = "Eject Mob"
		desc = "Ejete a multidão que está consumindo."
	else
		name = "Consume"
		desc = "Consuma uma multidão que você está arrastando para obter nutrição deles."
	return ..()

/datum/action/consume/apply_button_icon(atom/movable/screen/movable/action_button/current_button, force)
	button_icon_state = vored_mob ? "eject" : "consume"
	return ..()

///* Gelatinious Grapes code below *\\\
///Child of the ooze mob which is orientated at being a healer type creature.
/mob/living/simple_animal/hostile/ooze/grapes
	name = "Sholean grapes"
	desc = "Uma gosma botrioidal de Sholus VII.\nXenobiologistas consideram que é uma das espécies mais calmas e agradáveis do planeta, mas até agora pouco se sabe sobre seu comportamento na natureza.\nOndula de forma reconfortante."
	icon_state = "grapes"
	icon_living = "grapes"
	icon_dead = "grapes_dead"
	speed = 1
	health = 200
	maxHealth = 200
	damage_coeff = list(BRUTE = 1, BURN = 0.8, TOX = 0.5, STAMINA = 0, OXY = 1)
	melee_damage_lower = 12
	melee_damage_upper = 12
	obj_damage = 15
	death_message = "Deflata e derrama seus sucos vitais!"
	edible_food_types = MEAT | VEGETABLES
	ghost_controllable = TRUE //SKYRAT EDIT ADDITION - These guys can be helpful... maybe players will be helpful.

/mob/living/simple_animal/hostile/ooze/grapes/get_innate_actions()
	var/static/list/innate_actions = list(
		/datum/action/cooldown/globules,
		/datum/action/cooldown/gel_cocoon,
	)
	return innate_actions

/mob/living/simple_animal/hostile/ooze/grapes/add_cell_sample()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_GRAPE, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)

///Ability that allows the owner to fire healing globules at mobs, targeting specific limbs.
/datum/action/cooldown/globules
	name = "Fire Mending globule"
	desc = "Dispara um glóbulo em alguém, curando um membro específico deles."
	background_icon_state = "bg_hive"
	overlay_icon_state = "bg_hive_border"
	button_icon = 'icons/mob/actions/actions_slime.dmi'
	button_icon_state = "globules"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_INCAPACITATED
	cooldown_time = 5 SECONDS
	click_to_activate = TRUE

/datum/action/cooldown/globules/set_click_ability(mob/on_who)
	. = ..()
	if(!.)
		return

	to_chat(on_who, span_notice("Prepare-se para lançar um globule reparador.<B>Click esquerdo para atirar em um alvo!</B>"))

/datum/action/cooldown/globules/unset_click_ability(mob/on_who, refund_cooldown = TRUE)
	. = ..()
	if(!.)
		return

	if(refund_cooldown)
		to_chat(on_who, span_notice("Pare de preparar seus globules."))

/datum/action/cooldown/globules/Activate(atom/target)
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/simple_animal/hostile/ooze/oozy_owner = owner
	if(istype(oozy_owner))
		if(oozy_owner.ooze_nutrition < 5)
			to_chat(oozy_owner, span_warning("Você precisa de pelo menos 5 nutrição para lançar um globule reparador."))
			return FALSE

	return TRUE

/datum/action/cooldown/globules/InterceptClickOn(mob/living/clicker, params, atom/target)
	. = ..()
	if(!.)
		return FALSE

	// Why is this in InterceptClickOn() and not Activate()?
	// Well, we need to use the params of the click intercept
	// for passing into aim_projectile, so we'll handle it here instead.
	// We just need to make sure Pre-activate and Activate return TRUE so we make it this far
	clicker.visible_message(
		span_nicegreen("[clicker] Lança um globule remendador!"),
		span_notice("Você lança um globule reparador."),
	)

	var/mob/living/simple_animal/hostile/ooze/oozy = clicker
	if(istype(oozy))
		oozy.adjust_ooze_nutrition(-5)

	var/modifiers = params2list(params)
	var/obj/projectile/globule/globule = new(clicker.loc)
	globule.aim_projectile(target, clicker, modifiers)
	globule.def_zone = clicker.zone_selected
	globule.fire()

	StartCooldown()

	return TRUE

// Needs to return TRUE otherwise PreActivate() will fail, see above
/datum/action/cooldown/globules/Activate(atom/target)
	return TRUE

///This projectile embeds into mobs and heals them over time.
/obj/projectile/globule
	name = "mending globule"
	icon_state = "glob_projectile"
	shrapnel_type = /obj/item/mending_globule
	embed_type = /datum/embedding/mending_globule
	damage = 0

///This item is what is embedded into the mob
/obj/item/mending_globule
	name = "mending globule"
	desc = "De alguma forma, cura aqueles que o tocam."
	icon = 'icons/obj/science/vatgrowing.dmi'
	icon_state = "globule"
	var/heals_left = 35

/datum/embedding/mending_globule
	embed_chance = 100
	ignore_throwspeed_threshold = TRUE
	pain_mult = 0
	jostle_pain_mult = 0
	fall_chance = 0.5

// This already processes, zero logic to add additional tracking to the item
/datum/embedding/mending_globule/process(seconds_per_tick)
	. = ..()
	var/obj/item/mending_globule/globule = parent
	owner_limb.heal_damage(0.5 * seconds_per_tick, 0.5 * seconds_per_tick)
	globule.heals_left--
	if(globule.heals_left <= 0)
		qdel(globule)

///This action lets you put a mob inside of a cacoon that will inject it with some chemicals.
/datum/action/cooldown/gel_cocoon
	name = "Gel Cocoon"
	desc = "Coloca uma multidão dentro de um casulo, permitindo que ele se cure lentamente."
	background_icon_state = "bg_hive"
	overlay_icon_state = "bg_hive_border"
	button_icon = 'icons/mob/actions/actions_slime.dmi'
	button_icon_state = "gel_cocoon"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_IMMOBILE|AB_CHECK_INCAPACITATED
	cooldown_time = 10 SECONDS

/datum/action/cooldown/gel_cocoon/Activate(atom/target)
	StartCooldown(10 SECONDS)
	gel_cocoon()
	StartCooldown()

///Try to put the pulled mob in a cocoon
/datum/action/cooldown/gel_cocoon/proc/gel_cocoon()
	var/mob/living/simple_animal/hostile/ooze/grapes/ooze = owner
	if(!iscarbon(ooze.pulling))
		to_chat(src, span_warning("Você precisa estar puxando uma criatura inteligente o suficiente para ajudá-lo com um casulo!"))
		return FALSE
	owner.visible_message(span_nicegreen("[ooze] Começa a tentar colocar [target] em um casulo de gel!"), span_notice("Você começa a tentar colocar [target] em um casulo de gel."))
	if(!do_after(ooze, 1.5 SECONDS, target = ooze.pulling))
		return FALSE

	put_in_cocoon(ooze.pulling)
	ooze.adjust_ooze_nutrition(-30)

///Mob needs to have enough nutrition
/datum/action/cooldown/gel_cocoon/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return
	var/mob/living/simple_animal/hostile/ooze/ooze = owner
	return ooze.ooze_nutrition >= 30

///Puts the mob in the new cocoon
/datum/action/cooldown/gel_cocoon/proc/put_in_cocoon(mob/living/carbon/target)
	var/obj/structure/gel_cocoon/cocoon = new /obj/structure/gel_cocoon(get_turf(target))
	cocoon.insert_target(target)
	owner.visible_message(span_nicegreen("[owner] Tem colocado [target] em um casulo de gel!"), span_notice("Você colocou [target] em um casulo de gel."))

/obj/structure/gel_cocoon
	name = "gel cocoon"
	desc = "Parece nojento, mas útil."
	icon = 'icons/obj/science/vatgrowing.dmi'
	icon_state = "gel_cocoon"
	max_integrity = 50
	var/mob/living/carbon/inhabitant

/obj/structure/gel_cocoon/Destroy()
	if(inhabitant)
		dump_inhabitant(FALSE)
	return ..()

/obj/structure/gel_cocoon/container_resist_act(mob/living/user)
	. = ..()
	user.visible_message(span_notice("Viu?[user] Fugindo de [src]!"), 		span_notice("Você começa a rasgar o tecido mole do casulo de gel"))
	if(!do_after(user, 1.5 SECONDS, target = src))
		return FALSE
	dump_inhabitant()

///This proc handles the insertion of a person into the cocoon
/obj/structure/gel_cocoon/proc/insert_target(target)
	inhabitant = target
	inhabitant.forceMove(src)
	START_PROCESSING(SSobj, src)

///This proc dumps the mob and handles associated audiovisual feedback
/obj/structure/gel_cocoon/proc/dump_inhabitant(destroy_after = TRUE)
	inhabitant.forceMove(get_turf(src))
	playsound(get_turf(inhabitant), 'sound/effects/splat.ogg', 50, TRUE)
	inhabitant.Paralyze(10)
	inhabitant.visible_message(span_warning("[inhabitant] Cai fora.[src]!"), span_notice("Você cai fora [src]."))
	if(destroy_after)
		qdel(src)


/obj/structure/gel_cocoon/process()
	if(inhabitant.reagents.get_reagent_amount(/datum/reagent/medicine/atropine) < 5)
		inhabitant.reagents.add_reagent(/datum/reagent/medicine/atropine, 0.5)

	if(inhabitant.reagents.get_reagent_amount(/datum/reagent/medicine/salglu_solution) < 15)
		inhabitant.reagents.add_reagent(/datum/reagent/medicine/salglu_solution, 1.5)

	if(inhabitant.reagents.get_reagent_amount(/datum/reagent/consumable/milk) < 20)
		inhabitant.reagents.add_reagent(/datum/reagent/consumable/milk, 2)
