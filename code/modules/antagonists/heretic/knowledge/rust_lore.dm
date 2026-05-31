/datum/heretic_knowledge_tree_column/rust
	route = PATH_RUST
	ui_bgr = "node_rust"
	complexity = "Medium"
	complexity_color = COLOR_YELLOW
	icon = list(
		"icon" = 'icons/obj/weapons/khopesh.dmi',
		"state" = "rust_blade",
		"frame" = 1,
		"dir" = SOUTH,
		"moving" = FALSE,
	)
	description = list(
		"The Path of Rust revolves around durability, corruption and brute forcing your way through obstacles.",
		"Pick this path if you enjoy a standing your ground and letting the fight come to you.",
	)
	pros = list(
		"Standing on rusted tiles makes you highly durable; regenerating wounds and removing stuns.",
		"Rusted tiles harm your foes and slow them down.",
		"You are able to destroy walls, objects, mechs, structures and airlocks with ease.",
		"You can instantly obliterate silicons or synthetic crew members with your Mansus Grasp.",
		"You have a high amount of disruption abilities to make it easier to fight in your territory.",
	)
	cons = list(
		"Extremely overt; throws stealth completely out as an option.",
		"If you are not on rusted tiles, you become significantly more vulnerable.",
		"Being locked to a territorial conflict makes it much easier to use destructive tools (like bombs) against you.",
		"Your high amount of defensive power is at the cost of offensive power.",
	)
	tips = list(
		"Your Mansus Grasp will instantly destroy mechs, silicons and androids. Hitting a marked target with your blade will cause heavy disgust and make them vomit, knocking them down briefly.",
		"Your Mansus Grasp and your spells are capable of rusting walls and floors, making them beneficial to you and harmful to the crew and silicons. Spread rust as much as possible.",
		"Rusted turfs will heal you, regulate your blood temperature, make you resistant to batons knockdown, regenerate your stamina and blood and heal your wound and limbs once you level up your passive.",
		"Always fight on your turf. Your opponent entering your turf are at a significant disadvantage.",
		"Your Reassembled Raiment is only empowered while you are on your rusted tiles. If you want the most out of its power, stay on your rusted tiles.",
		"Your ability to destroy objects and walls improves as your passive ugprade increases; eventually you will be able to melt through airlocks, reinforced walls and even titanium walls.",
		"Spreading rust can be fairly slow, especially early on. Consider summoning a few rust walkers to help you expand your domain.",
		"Rusted Construction allows you to produce barriers for cover or escape, or even block off someone else's escape in a pinch. Make the most of it to manipulate the environment to your needs.",
	)

	start = /datum/heretic_knowledge/limited_amount/starting/base_rust
	knowledge_tier1 = /datum/heretic_knowledge/spell/area_conversion
	guaranteed_side_tier1 = /datum/heretic_knowledge/rust_sower
	knowledge_tier2 = /datum/heretic_knowledge/spell/rust_construction
	guaranteed_side_tier2 = /datum/heretic_knowledge/summon/rusty
	robes = /datum/heretic_knowledge/armor/rust
	knowledge_tier3 = /datum/heretic_knowledge/spell/entropic_plume
	guaranteed_side_tier3 = /datum/heretic_knowledge/crucible
	blade = /datum/heretic_knowledge/blade_upgrade/rust
	knowledge_tier4 = /datum/heretic_knowledge/spell/rust_charge
	ascension = /datum/heretic_knowledge/ultimate/rust_final

/datum/heretic_knowledge/limited_amount/starting/base_rust
	name = "Blacksmith's Tale"
	desc = "Abre o caminho da Rust para você. Permite que transmute uma faca com qualquer item de lixo em uma lâmina Rusty. Você só pode criar dois de cada vez."
	gain_text = "\"Deixe-me contar uma história.\", disse o ferreiro, enquanto ele olhava profundamente em sua lâmina enferrujada."
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/trash = 1,
	)
	result_atoms = list(/obj/item/melee/sickly_blade/rust)
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "rust_blade"
	mark_type = /datum/status_effect/eldritch/rust
	eldritch_passive = /datum/status_effect/heretic_passive/rust

/datum/heretic_knowledge/limited_amount/starting/base_rust/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	RegisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK_SECONDARY, PROC_REF(on_secondary_mansus_grasp))
	user.RemoveElement(/datum/element/rust_healing, FALSE, 1.5, 5)

/datum/heretic_knowledge/limited_amount/starting/base_rust/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	UnregisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK_SECONDARY)
	user.AddElement(/datum/element/rust_healing, FALSE, 1.5, 5)

/datum/heretic_knowledge/limited_amount/starting/base_rust/on_mansus_grasp(mob/living/source, mob/living/target)
	. = ..()

	if(iscarbon(target))
		var/mob/living/carbon/carbon_target = target
		for(var/obj/item/bodypart/robotic_limb as anything in carbon_target.get_bodyparts())
			if(IS_ROBOTIC_LIMB(robotic_limb))
				robotic_limb.receive_damage(500)

	if(!issilicon(target) && !(target.mob_biotypes & MOB_ROBOTIC))
		return

	source.do_rust_heretic_act(target)

/datum/heretic_knowledge/limited_amount/starting/base_rust/proc/on_secondary_mansus_grasp(mob/living/source, atom/target)
	SIGNAL_HANDLER

	// Rusting an airlock causes it to lose power, mostly to prevent the airlock from shocking you.
	// This is a bit of a hack, but fixing this would require the entire wire cut/pulse system to be reworked.
	if(istype(target, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/airlock = target
		airlock.loseMainPower()

	source.do_rust_heretic_act(target)
	return COMPONENT_USE_HAND

/datum/heretic_knowledge/spell/rust_charge
	name = "Rust Charge"
	desc = "Uma carga que deve ser iniciada em uma telha enferrujada e destruirá quaisquer objetos enferrujados que você entrar em contato, lidará com altos danos aos outros e enferrujará ao seu redor durante a carga."
	gain_text = "As colinas brilhavam agora, enquanto eu me aproximava deles minha mente começou a vaguear. Rapidamente recuperei minha determinação e avancei, esta última perna seria a mais traiçoeira."

	action_to_add = /datum/action/cooldown/mob_cooldown/charge/rust
	cost = 2
	is_final_knowledge = TRUE

/datum/heretic_knowledge/spell/rust_construction
	name = "Rust Construction"
	desc = "Concede-lhe Rust Construction, um feitiço que permite levantar uma parede de um chão enferrujado. Qualquer um acima da parede será jogado de lado (ou para cima) e manter danos."
	gain_text = "Imagens de estruturas estranhas e sinistros começaram a dançar em minha mente. Cobertos de cabeça aos pés em espessa ferrugem, eles não pareciam mais homens feitos. Ou talvez nunca tenham sido."
	action_to_add = /datum/action/cooldown/spell/pointed/rust_construction
	cost = 2

/datum/heretic_knowledge/armor/rust
	desc = "Permite que transmute uma mesa (ou um terno), uma máscara e qualquer item de lixo para criar um Restos Salvados. Tem armadura extra, resistência e imunidade da seringa enquanto está na ferrugem. Atua como foco enquanto encapuza."
	gain_text = "De baixo de sucata deformada, o ferreiro puxa um tecido antigo.\"Seja lá o que isso já representou está perdido. Então, agora, damos um novo propósito.\""
	result_atoms = list(/obj/item/clothing/suit/hooded/cultrobes/eldritch/rust)
	research_tree_icon_state = "rust_armor"
	required_atoms = list(
		list(/obj/structure/table, /obj/item/clothing/suit) = 1,
		/obj/item/clothing/mask = 1,
		/obj/item/trash = 1,
	)

/datum/heretic_knowledge/spell/area_conversion
	name = "Aggressive Spread"
	desc = "Concede-lhe Agressive Spread, um feitiço que espalha ferrugem para superfícies próximas. Superfícies já enferrujadas são destruídas \ Também melhora as habilidades enferrujadas de não-heréticos ferrugem."
	gain_text = "Todos os sábios sabem bem não visitar as Colinas Rusted... No entanto, o conto do ferreiro foi inspirador."
	action_to_add = /datum/action/cooldown/spell/aoe/rust_conversion
	cost = 2
	research_tree_icon_frame = 5

/datum/heretic_knowledge/blade_upgrade/rust
	name = "Toxic Blade"
	desc = "Sua lâmina Rusty agora enoja inimigos no ataque \ Permite que você enferruje titânio e Plastânio.."
	gain_text = "O ferreiro lhe dá a lâmina.\"A Lâmina te guiará através da carne, se deixar.\"A ferrugem pesada o reduz. Você olha profundamente para ele. As Colinas Rusted chamam por você, agora."
	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "blade_upgrade_rust"

/datum/heretic_knowledge/blade_upgrade/rust/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	if(source == target || !isliving(target))
		return
	target.adjust_disgust(50)

/datum/heretic_knowledge/spell/area_conversion/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()

/datum/heretic_knowledge/spell/entropic_plume
	name = "Entropic Plume"
	desc = "Concede-lhe Plume Entropica, um feitiço que libera uma onda de Rust. Cegos, venenos e inflige Amok a qualquer pagão que acerte, fazendo com que ataquem amigos ou inimigos. Também ferrugem e destrói e superfícies que atinge e melhora as habilidades de ferrugem de hereges não-ferrugem."
	gain_text = "A corrosão era imparável. A ferrugem era desagradável. O ferreiro se foi, e você segura a lâmina deles. Campeões da esperança, o Rustbringer está próximo!"

	action_to_add = /datum/action/cooldown/spell/cone/staggered/entropic_plume
	cost = 2
	drafting_tier = 5

/datum/heretic_knowledge/ultimate/rust_final
	name = "Rustbringer's Oath"
	desc = "O ritual de ascensão do Caminho da Rust. Traga 3 corpos para uma runa de transmutação na ponte da estação para completar o ritual. Quando concluído, o local ritual espalhará infinitamente ferrugem em qualquer superfície, parando por nada. Além disso, você se tornará extremamente resistente à ferrugem, curando ao triplo da taxa e tornando-se imune a muitos efeitos e perigos \ Você será capaz de enferrujar quase tudo ao subir."
	gain_text = "Campeão da ferrugem. Corruptor de aço. Temam a escuridão, pois o RUSTBRINGER chegou! O ferreiro avança! Rusted Hills, chame meu nome! Testemunhe minha ascensão!"

	ascension_achievement = /datum/award/achievement/misc/rust_ascension
	announcement_text = "Medo da decadência, para o Rustbringer, Name subiu! Ninguém escapará da corrosão! SPOOKY"
	announcement_sound = 'sound/music/antag/heretic/ascend_rust.ogg'
	/// If TRUE, then immunities are currently active.
	var/immunities_active = FALSE
	/// A typepath to an area that we must finish the ritual in.
	var/area/ritual_location = /area/station/command/bridge
	/// A static list of traits we give to the heretic when on rust.
	var/static/list/conditional_immunities = list(
		TRAIT_BOMBIMMUNE,
		TRAIT_IGNORESLOWDOWN,
		TRAIT_NO_SLIP_ALL,
		TRAIT_NOBREATH,
		TRAIT_PIERCEIMMUNE,
		TRAIT_PUSHIMMUNE,
		TRAIT_RADIMMUNE,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHEAT,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_SHOCKIMMUNE,
		TRAIT_SLEEPIMMUNE,
		TRAIT_STUNIMMUNE,
	)

/datum/heretic_knowledge/ultimate/rust_final/on_research(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	// This map doesn't have a Bridge, for some reason??
	// Let them complete the ritual anywhere
	if(!GLOB.areas_by_type[ritual_location])
		ritual_location = null

/datum/heretic_knowledge/ultimate/rust_final/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	if(ritual_location)
		var/area/our_area = get_area(loc)
		if(!istype(our_area, ritual_location))
			loc.balloon_alert(user, "ritual falhou, deve estar em[initial(ritual_location.name)]!") // "Deve estar na ponte."
			return FALSE

	return ..()

/datum/heretic_knowledge/ultimate/rust_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	trigger(loc)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))
	RegisterSignal(user, COMSIG_LIVING_LIFE, PROC_REF(on_life))
	user.client?.give_award(/datum/award/achievement/misc/rust_ascension, user)
	var/datum/action/cooldown/spell/aoe/rust_conversion/rust_spread_spell = locate() in user.actions
	rust_spread_spell?.cooldown_time /= 2

// I sure hope this doesn't have performance implications
/datum/heretic_knowledge/ultimate/rust_final/proc/trigger(turf/center)
	var/greatest_dist = 0
	var/list/turfs_to_transform = list()
	for (var/turf/transform_turf as anything in GLOB.station_turfs)
		if (transform_turf.turf_flags & NO_RUST)
			continue
		var/dist = get_dist(center, transform_turf)
		if (dist > greatest_dist)
			greatest_dist = dist
		if (!turfs_to_transform["[dist]"])
			turfs_to_transform["[dist]"] = list()
		turfs_to_transform["[dist]"] += transform_turf

	for (var/iterator in 1 to greatest_dist)
		if(!turfs_to_transform["[iterator]"])
			continue
		addtimer(CALLBACK(src, PROC_REF(transform_area), turfs_to_transform["[iterator]"]), (2 SECONDS) * iterator)

/datum/heretic_knowledge/ultimate/rust_final/proc/transform_area(list/turfs)
	turfs = shuffle(turfs)
	var/numturfs = length(turfs)
	var/first_third = turfs.Copy(1, round(numturfs * 0.33))
	var/second_third = turfs.Copy(round(numturfs * 0.33), round(numturfs * 0.66))
	var/third_third = turfs.Copy(round(numturfs * 0.66), numturfs)
	addtimer(CALLBACK(src, PROC_REF(delay_transform_turfs), first_third), 5 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(delay_transform_turfs), second_third), 5 SECONDS * 0.33)
	addtimer(CALLBACK(src, PROC_REF(delay_transform_turfs), third_third), 5 SECONDS * 0.66)

/datum/heretic_knowledge/ultimate/rust_final/proc/delay_transform_turfs(list/turfs)
	for(var/turf/turf as anything in turfs)
		turf.rust_heretic_act(RUST_RESISTANCE_ORGANIC)
		CHECK_TICK

/**
 * Signal proc for [COMSIG_MOVABLE_MOVED].
 *
 * Gives our heretic ([source]) buffs if they stand on rust.
 */
/datum/heretic_knowledge/ultimate/rust_final/proc/on_move(mob/living/source, atom/old_loc, dir, forced, list/old_locs)
	SIGNAL_HANDLER

	if(source.is_touching_rust())
		if(!immunities_active)
			source.add_traits(conditional_immunities, type)
			source.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
			immunities_active = TRUE
	else // If we're not on a rust turf, and we have given out our traits, nerf our guy
		if(immunities_active)
			source.remove_traits(conditional_immunities, type)
			source.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
			immunities_active = FALSE

/**
 * Signal proc for [COMSIG_LIVING_LIFE].
 *
 * Gradually heals the heretic ([source]) on rust.
 */
/datum/heretic_knowledge/ultimate/rust_final/proc/on_life(mob/living/source, seconds_per_tick)
	SIGNAL_HANDLER

	if(!source.is_touching_rust())
		return

	var/need_mob_update = FALSE
	var/base_heal_amt = 1 * DELTA_WORLD_TIME(SSmobs)
	need_mob_update += source.adjust_brute_loss(-base_heal_amt, updating_health = FALSE)
	need_mob_update += source.adjust_fire_loss(-base_heal_amt, updating_health = FALSE)
	need_mob_update += source.adjust_tox_loss(-base_heal_amt, updating_health = FALSE, forced = TRUE)
	need_mob_update += source.adjust_oxy_loss(-base_heal_amt, updating_health = FALSE)
	need_mob_update += source.adjust_stamina_loss(-base_heal_amt * 4, updating_stamina = FALSE)

	source.adjust_blood_volume(base_heal_amt, maximum = BLOOD_VOLUME_NORMAL)

	if(need_mob_update)
		source.updatehealth()
