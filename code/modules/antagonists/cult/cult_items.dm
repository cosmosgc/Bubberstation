/obj/item/tome
	name = "arcane tome"
	desc = "Um velho, empoeirado, com bordas desgastadas e uma capa sinistra."
	icon = 'icons/obj/antags/cult/items.dmi'
	icon_state ="tome"
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL

/obj/item/melee/cultblade/dagger
	name = "ritual dagger"
	desc = "Um estranho punhal dito para ser usado por grupos sinistros para\"Preparando\"Um cadáver antes de sacrificá-lo aos seus deuses negros."
	icon = 'icons/obj/weapons/khopesh.dmi'
	icon_state = "render"
	inhand_icon_state = "cultdagger"
	worn_icon = null
	worn_icon_state = "render"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	force = 15
	throwforce = 25
	block_chance = 25
	wound_bonus = -10
	exposed_wound_bonus = 20
	armour_penetration = 35
	block_sound = 'sound/items/weapons/parry.ogg'
	///Reference to a boomerang component we add when a non-cultist throws us.
	var/datum/component/boomerang/boomerang_component

/obj/item/melee/cultblade/dagger/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_IMPACT_ZONE, PROC_REF(on_impact_zone))
	var/image/silicon_image = image(icon = 'icons/effects/blood.dmi' , icon_state = null, loc = src)
	silicon_image.override = TRUE
	add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/silicons, "cult_dagger", silicon_image)

	var/examine_text = {"Allows the scribing of blood runes of the cult of Nar'Sie.
Hitting a cult structure will unanchor or reanchor it. Cult Girders will be destroyed in a single blow.
Can be used to scrape blood runes away, removing any trace of them.
Striking another cultist with it will purge all holy water from them and transform it into unholy water.
Striking a noncultist, however, will tear their flesh."}

	AddComponent(/datum/component/cult_ritual_item, span_cult(examine_text))

/obj/item/melee/cultblade/dagger/Destroy(force)
	QDEL_NULL(boomerang_component)
	return ..()

/obj/item/melee/cultblade/dagger/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	var/block_message = "[owner] parries [attack_text] with [src]"
	if(owner.get_active_held_item() != src)
		block_message = "[owner] Parries [attack_text] com [src] em suas mãos"

	if(IS_CULTIST(owner) && prob(final_block_chance) && (attack_type != PROJECTILE_ATTACK || attack_type != OVERWHELMING_ATTACK))
		new /obj/effect/temp_visual/cult/sparks(get_turf(owner))
		owner.visible_message(span_danger("[block_message]"))
		return TRUE
	else
		return FALSE

/obj/item/melee/cultblade/dagger/on_thrown(mob/living/carbon/user, atom/target)
	. = ..()
	if(!.)
		return
	if(IS_CULTIST(user))
		if(boomerang_component)
			REMOVE_TRAIT(src, TRAIT_UNCATCHABLE, HELD_ITEM_TRAIT)
			QDEL_NULL(boomerang_component)
	else if(isnull(boomerang_component))
		ADD_TRAIT(src, TRAIT_UNCATCHABLE, HELD_ITEM_TRAIT)
		boomerang_component = AddComponent(/datum/component/boomerang, throw_range)

///Called when the dagger is impacting someone, we cancel if the person hit isn't the person who threw us, if we're boomeranging.
/obj/item/melee/cultblade/dagger/proc/on_impact_zone(atom/source, mob/living/hitby, zone, blocked, datum/thrownthing/throwingdatum)
	SIGNAL_HANDLER

	var/mob/living/thrower = throwingdatum?.get_thrower()
	if(!isnull(boomerang_component) && hitby != thrower)
		return MOVABLE_IMPACT_ZONE_OVERRIDE

/obj/item/melee/cultblade
	name = "eldritch longsword"
	desc = "Uma espada murmurando com energia profana. Brilha com uma luz vermelha fraca."
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "cultblade"
	inhand_icon_state = "cultblade"
	worn_icon = 'icons/mob/clothing/back.dmi'
	worn_icon_state = "cultblade"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	obj_flags = CONDUCTS_ELECTRICITY
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_BULKY
	force = 30 // whoever balanced this got beat in the head by a bible too many times good lord
	throwforce = 10
	block_chance = 50 // now it's officially a cult esword
	wound_bonus = -50
	exposed_wound_bonus = 20
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	block_sound = 'sound/items/weapons/parry.ogg'
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "rends")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "rend")
	/// If TRUE, it can be used at will by anyone, non-cultists included
	var/free_use = FALSE
	var/list/alt_continuous = list("stabs", "pierces", "impales")
	var/list/alt_simple = list("stab", "pierce", "impale")

/obj/item/melee/cultblade/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, 		speed = 4 SECONDS, 		effectiveness = 100, 	)
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple, -5)
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)

/obj/item/melee/cultblade/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == OVERWHELMING_ATTACK)
		return FALSE

	if(IS_CULTIST(owner) && prob(final_block_chance))
		new /obj/effect/temp_visual/cult/sparks(get_turf(owner))
		owner.visible_message(span_danger("[owner] Parries [attack_text] com [src]!"))
		return TRUE
	else
		return FALSE

/obj/item/melee/cultblade/attack(mob/living/target, mob/living/carbon/human/user)
	if(!IS_CULTIST(user) && !free_use)
		user.Paralyze(100)
		user.dropItemToGround(src, TRUE)
		user.visible_message(span_warning("Uma força poderosa empurra [user] longe de [target]!"), 				span_cult_large("\"Não devia brincar com coisas afiadas. Você vai arrancar o olho de alguém.\""))
		if(ishuman(user))
			var/mob/living/carbon/human/miscreant = user
			miscreant.apply_damage(rand(force/2, force), BRUTE, pick(GLOB.arm_zones))
		else
			user.adjust_brute_loss(rand(force/2,force))
		return
	..()

#define WIELDER_SPELLS "wielder_spell"
#define SWORD_SPELLS "sword_spell"
#define SWORD_PREFIX "sword_prefix"

/obj/item/melee/cultblade/haunted
	name = "haunted longsword"
	desc = "Uma espada assustadora com uma lâmina menos negra do que \"nada absoluto\". Brilha com energia verde furiosa e contida."
	icon_state = "hauntedblade"
	inhand_icon_state = "hauntedblade"
	worn_icon_state = "hauntedblade"
	force = 30
	throwforce = 25
	block_chance = 55
	wound_bonus = -25
	exposed_wound_bonus = 30
	free_use = TRUE
	light_color = COLOR_HERETIC_GREEN
	light_range = 3
	demolition_mod = 1.5
	/// holder for the actual action when created.
	var/list/datum/action/cooldown/spell/path_sword_actions
	/// holder for the actual action when created.
	var/list/datum/action/cooldown/spell/path_wielder_actions
	var/mob/living/trapped_entity
	/// The heretic path that the variable below uses to index abilities. Assigned when the heretic is ensouled.
	var/heretic_path
	/// If the blade is bound, it cannot utilize its abilities, but neither can its wielder. They must unbind it to use it to its full potential.
	var/bound = TRUE
	/// Nested static list used to index abilities and names.
	var/static/list/heretic_paths_to_haunted_sword_abilities = list(
		// Ash
		PATH_ASH = list(
			WIELDER_SPELLS = list(/datum/action/cooldown/spell/jaunt/ethereal_jaunt/ash),
			SWORD_SPELLS = list(/datum/action/cooldown/spell/pointed/ash_beams),
			SWORD_PREFIX = "ashen",
		),
		// Flesh
		PATH_FLESH = list(
			WIELDER_SPELLS = list(/datum/action/cooldown/spell/pointed/blood_siphon),
			SWORD_SPELLS = list(/datum/action/cooldown/spell/pointed/cleave),
			SWORD_PREFIX = "sanguine",
		),
		// Void
		PATH_VOID = list(
			WIELDER_SPELLS = list(/datum/action/cooldown/spell/pointed/void_phase),
			SWORD_SPELLS = list(/datum/action/cooldown/spell/pointed/void_prison),
			SWORD_PREFIX = "tenebrous",
		),
		// Blade
		PATH_BLADE = list(
			WIELDER_SPELLS = list(/datum/action/cooldown/spell/pointed/projectile/furious_steel/haunted),
			SWORD_SPELLS = list(/datum/action/cooldown/spell/pointed/projectile/furious_steel/solo),
			SWORD_PREFIX = "keen",
		),
		// Rust
		PATH_RUST = list(
			WIELDER_SPELLS = list(/datum/action/cooldown/spell/cone/staggered/entropic_plume),
			SWORD_SPELLS = list(/datum/action/cooldown/spell/aoe/rust_conversion, /datum/action/cooldown/spell/pointed/rust_construction),
			SWORD_PREFIX = "rusted",
		),
		// Cosmic
		PATH_COSMIC = list(
			WIELDER_SPELLS = list(/datum/action/cooldown/spell/conjure/cosmic_expansion),
			SWORD_SPELLS = list(/datum/action/cooldown/spell/pointed/projectile/star_blast),
			SWORD_PREFIX = "astral",
		),
		// Lock
		PATH_LOCK = list(
			WIELDER_SPELLS = list(/datum/action/cooldown/spell/pointed/burglar_finesse),
			SWORD_SPELLS = list(/datum/action/cooldown/spell/pointed/apetra_vulnera),
			SWORD_PREFIX = "incisive",
		),
		// Moon
		PATH_MOON = list(
			WIELDER_SPELLS = list(/datum/action/cooldown/spell/pointed/projectile/moon_parade),
			SWORD_SPELLS = list(/datum/action/cooldown/spell/pointed/mind_gate),
			SWORD_PREFIX = "shimmering",
		),
		// Starter
		PATH_START = list(
			WIELDER_SPELLS = null,
			SWORD_SPELLS = null,
			SWORD_PREFIX = "stillborn", // lol loser
		) ,
	)
	actions_types = list(/datum/action/item_action/haunted_blade)

/obj/item/melee/cultblade/haunted/examine(mob/user)
	. = ..()

	var/examine_text = ""
	if(bound)
		examine_text = "[src]resplandece um sem brilho, doentemente verde, o poder que emana dele claramente ligado pelas runas em sua lâmina. Você poderia desencadeá-lo, e exercer seu poder temível. Mas vale a pena afrouxar as amarras do espírito dentro?"
	else
		examine_text = "[src]flameja uma clara e maliciosa sombra de lima pálida. Alguém libertou o espírito interior, e o poder agora claramente ressoa de dentro da lâmina, mal contido e cheio de fúria. Você pode tentar amarrá-lo mais uma vez, selando o horror, ou tentar aproveitar sua força como uma lâmina."

	. += span_cult(examine_text)

/datum/action/item_action/haunted_blade
	name = "Unseal Spirit" // img is of a chained shade
	button_icon = 'icons/mob/actions/actions_cult.dmi'
	button_icon_state = "spirit_sealed"

/datum/action/item_action/haunted_blade/apply_button_icon(atom/movable/screen/movable/action_button/button, force)
	var/obj/item/melee/cultblade/haunted/blade = target
	if(istype(blade))
		button_icon_state = "spirit_[blade.bound ? "sealed" : "unsealed"]"
		name = "[blade.bound ? "Unseal" : "Seal"] Spirit"

	return ..()

/obj/item/melee/cultblade/haunted/ui_action_click(mob/living/user, actiontype)
	if(DOING_INTERACTION_WITH_TARGET(user, src))
		return // gtfo
	if(bound)
		unbind_blade(user)
		return
	if(user.mind?.holy_role)
		on_priest_handle(user)
	else if(IS_CULTIST_OR_CULTIST_MOB(user))
		on_cultist_handle(user)
	else if(IS_HERETIC_OR_MONSTER(user) || IS_LUNATIC(user))
		on_heresy_handle(user)
	else if(IS_WIZARD(user))
		on_wizard_handle(user)
	else
		on_normie_handle(user)
	return

/obj/item/melee/cultblade/haunted/proc/on_priest_handle(mob/living/user, actiontype)
	user.visible_message(span_cult_bold("Você começa a cantar os hinos sagrados de [GLOB.deity]..."),		span_cult_bold("[user] Começa a cantar enquanto segura [src] Alto..."))
	if(!do_after(user, 6 SECONDS, src))
		to_chat(user, span_notice("Você foi interrompido!"))
		return
	playsound(user, 'sound/effects/pray_chaplain.ogg',60,TRUE)
	return TRUE

/obj/item/melee/cultblade/haunted/proc/on_cultist_handle(mob/living/user, actiontype)
	var/binding_implements = list(/obj/item/melee/cultblade/dagger, /obj/item/melee/sickly_blade/cursed)
	if(!user.is_holding_item_of_types(binding_implements))
		to_chat(user, span_notice("Você precisa segurar um punhal ritual para amarrar [src]!"))
		return

	user.visible_message(span_cult_bold("Você começa a cortar sua mão em cima de [src]..."),		span_cult_bold("[user] Começa a cortar aberto.[user.p_their()] palma em cima de [src]..."))
	if(!do_after(user, 6 SECONDS, src))
		to_chat(user, span_notice("Você foi interrompido!"))
		return
	playsound(user, 'sound/items/weapons/slice.ogg', 30, TRUE)
	return TRUE

/obj/item/melee/cultblade/haunted/proc/on_heresy_handle(mob/living/user, actiontype)
	// todo make the former a subtype of latter
	var/binding_implements = list(/obj/item/clothing/neck/eldritch_amulet, /obj/item/clothing/neck/heretic_focus)
	if(!user.is_holding_item_of_types(binding_implements))
		to_chat(user, span_notice("Você precisa manter o foco para ligar [src]!"))
		return

	user.visible_message(span_cult_bold("Você canaliza o Mansus através de seu foco, capacitando as runas de vedação..."), span_cult_bold("[user] mantém seu foco em cima de Eldritch [src] e começa a se concentrar..."))
	if(!do_after(user, 6 SECONDS, src))
		to_chat(user, span_notice("Você foi interrompido!"))
		return
	return TRUE

/obj/item/melee/cultblade/haunted/proc/on_wizard_handle(mob/living/user, actiontype)
	user.visible_message(span_cult_bold("Você começa rapidamente e rapidamente lançando as runas de vedação."), span_cult_bold("[user] Começa a rastrear as runas anti-luz.[src]..."))
	if(!do_after(user, 3 SECONDS, src))
		to_chat(user, span_notice("Você foi interrompido!"))
		return
	return TRUE

/obj/item/melee/cultblade/haunted/proc/on_normie_handle(mob/living/user, actiontype)
	// todo make the former a subtype of latter
	var/binding_implements = list(/obj/item/book/bible)
	if(!user.is_holding_item_of_types(binding_implements))
		to_chat(user, span_notice("Você precisa usar uma Bíblia para amarrar [src]!"))
		return

	var/passage = "[pick(GLOB.first_names_male)] [rand(1,9)]:[rand(1,25)]" // Space Bibles will have Alejandro 9:21 passages, as part of the Very New Testament.
	user.visible_message(span_cult_bold("Você começa a ler em voz alta a passagem [passage]..."), span_cult_bold("[user] Começa a ler em voz alta a passagem [passage]..."))
	if(!do_after(user, 12 SECONDS, src))
		to_chat(user, span_notice("Você foi interrompido!"))
		return

	rebind_blade(user)

/obj/item/melee/cultblade/haunted/proc/unbind_blade(mob/user)
	var/holup = tgui_alert(user, "Tem certeza de que deseja abrir o espírito interior?", "Sealed Evil In A Jar", list("I need the power!", "Maybe not..."))
	if(holup != "I need the power!")
		return
	to_chat(user, span_cult_bold("Você começa a focar no poder da lâmina, deixando-a guiar seus dedos ao longo das runas inscritas..."))
	if(!do_after(user, 5 SECONDS, src))
		to_chat(user, span_notice("Você foi interrompido!"))
		return
	visible_message(span_danger("[user] não está preso.[src]!"))
	bound = FALSE
	for(var/datum/action/cooldown/spell/sword_spell as anything in path_sword_actions)
		sword_spell.Grant(trapped_entity)
	for(var/datum/action/cooldown/spell/wielder_spell as anything in path_wielder_actions)
		wielder_spell.Grant(user)
	free_use = TRUE
	force += 5
	armour_penetration += 10
	light_range += 3
	trapped_entity.update_mob_action_buttons()

	playsound(src ,'sound/misc/insane_low_laugh.ogg', 200, TRUE) //quiet
	binding_filters_update()

/obj/item/melee/cultblade/haunted/proc/rebind_blade(mob/user)
	visible_message(span_danger("[user] Encaixou.[src]!"))
	bound = TRUE
	force -= 5
	armour_penetration -= 10
	free_use = FALSE // it's a cult blade and you sealed away the other power.
	light_range -= 3
	for(var/datum/action/cooldown/spell/sword_spell as anything in path_sword_actions)
		sword_spell.Remove(trapped_entity)
	for(var/datum/action/cooldown/spell/wielder_spell as anything in path_wielder_actions)
		wielder_spell.Remove(user)
	trapped_entity.update_mob_action_buttons()

	playsound(src ,'sound/effects/hallucinations/wail.ogg', 20, TRUE)	// add BOUND alert and UNBOUND
	binding_filters_update()

/obj/item/melee/cultblade/haunted/Initialize(mapload, mob/soul_to_bind, mob/awakener, do_bind = TRUE)
	. = ..()

	AddElement(/datum/element/heretic_focus)
	add_traits(list(TRAIT_CASTABLE_LOC, TRAIT_SPELLS_TRANSFER_TO_LOC), INNATE_TRAIT)
	if(do_bind && !mapload)
		bind_soul(soul_to_bind, awakener)
	binding_filters_update()
	addtimer(CALLBACK(src, PROC_REF(start_glow_loop)), rand(0.1 SECONDS, 1.9 SECONDS))

/obj/item/melee/cultblade/haunted/proc/bind_soul(mob/soul_to_bind, mob/awakener)

	var/datum/mind/trapped_mind = soul_to_bind?.mind

	if(!trapped_mind)
		return // Can't do anything further down the list

	if(trapped_mind)
		AddComponent(/datum/component/spirit_holding,			soul_to_bind = trapped_mind,			awakener = awakener,			allow_renaming = FALSE,			allow_channeling = FALSE,			allow_exorcism = FALSE,		)

	// Get the heretic's new body and antag datum.
	trapped_entity = trapped_mind?.current
	trapped_entity.PossessByPlayer(trapped_mind?.key)
	var/datum/antagonist/heretic/heretic_holder = GET_HERETIC(trapped_entity)
	if(!heretic_holder)
		stack_trace("[soul_to_bind] in but not a heretic on the heretic soul blade.")

	// Give the spirit a spell that lets them try to fly around.
	var/datum/action/cooldown/spell/pointed/sword_fling/fling_act = 	new /datum/action/cooldown/spell/pointed/sword_fling(trapped_mind, to_fling = src)
	fling_act.Grant(trapped_entity)

	// Set the sword's path for spell selection.
	heretic_path = heretic_holder.heretic_path.route || PATH_START

	// Copy the objectives to keep for roundend, remove the datum as neither us nor the heretic need it anymore
	var/list/copied_objectives = heretic_holder.objectives.Copy()
	trapped_entity.mind.remove_antag_datum(/datum/antagonist/heretic)

	// Add the fallen antag datum, give them a heads-up of what's happening.
	var/datum/antagonist/soultrapped_heretic/bozo = new()
	bozo.objectives |= copied_objectives
	trapped_entity.mind.add_antag_datum(bozo)

	// Assigning the spells to give to the wielder and spirit.
	// Let them cast the given spell.
	ADD_TRAIT(trapped_entity, TRAIT_ALLOW_HERETIC_CASTING, INNATE_TRAIT)

	var/list/path_spells = heretic_paths_to_haunted_sword_abilities[heretic_path]

	var/list/wielder_spells = path_spells[WIELDER_SPELLS]
	var/list/sword_spells = path_spells[SWORD_SPELLS]

	name = "[path_spells [SWORD_PREFIX]] [name]"


	// Creating the path spells.
	// The sword is created bound - so we do not grant it the spells just yet, but we still create and store them.

	if(sword_spells)
		for(var/datum/action/cooldown/spell/sword_spell as anything in sword_spells)
			var/datum/action/cooldown/spell/instanced_spell = new sword_spell(trapped_entity)
			LAZYADD(path_sword_actions, instanced_spell)
			instanced_spell.overlay_icon_state = "bg_cult_border" // for flavor, and also helps distinguish

	if(wielder_spells)
		for(var/datum/action/cooldown/spell/wielder_spell as anything in wielder_spells)
			var/datum/action/cooldown/spell/instanced_spell = new wielder_spell(trapped_entity)
			LAZYADD(path_wielder_actions, instanced_spell)
			instanced_spell.overlay_icon_state = "bg_cult_border"

	binding_filters_update()

/obj/item/melee/cultblade/haunted/equipped(mob/user, slot, initial)
	. = ..()
	if((!(slot & ITEM_SLOT_HANDS)) || bound)
		return
	for(var/datum/action/cooldown/spell/wielder_spell in path_wielder_actions)
		wielder_spell.Grant(user)
	binding_filters_update()

/obj/item/melee/cultblade/haunted/dropped(mob/user, silent)
	. = ..()
	for(var/datum/action/cooldown/spell/wielder_spell in path_wielder_actions)
		wielder_spell.Remove(user)
	binding_filters_update()

/obj/item/melee/cultblade/haunted/proc/binding_filters_update(mob/user)

	var/h_color = heretic_path ? GLOB.heretic_path_to_color[heretic_path] : "#FF00FF"

	// on bound
	if(bound)
		remove_filter("unbound_ray", update = FALSE)
		add_filter("bind_glow", 2, list("type" = "outline", "color" = h_color, "size" = 0.1))
		return

	// on unbound
	// we re-add this every time it's picked up or dropped
	remove_filter("bind_glow", update = FALSE)
	add_filter(name = "unbound_ray", priority = 1, params = list(
		type = "rays",
		size = 16,
		color = COLOR_HERETIC_GREEN, // the sickly green of the heretic leaking through
		density = 16,
	))
	// because otherwise the animations stack and it looks ridiculous
	var/ray_filter = get_filter("unbound_ray")
	animate(ray_filter, offset = 100, time = 2 MINUTES, loop = -1, flags = ANIMATION_PARALLEL) // Absurdly long animate so nobody notices it hitching when it loops
	animate(offset = 0, time = 2 MINUTES) // I sure hope duration of animate doesnt have any performance effect

/obj/item/melee/cultblade/haunted/proc/start_glow_loop()
	var/filter = get_filter("bind_glow")
	if (!filter)
		return

	animate(filter, alpha = 110, time = 1.5 SECONDS, loop = -1)
	animate(alpha = 40, time = 2.5 SECONDS)

#undef WIELDER_SPELLS
#undef SWORD_SPELLS
#undef SWORD_PREFIX

/obj/item/melee/cultblade/ghost
	name = "eldritch sword"
	force = 19 //can't break normal airlocks
	item_flags = NEEDS_PERMIT | DROPDEL
	flags_1 = NONE
	block_chance = 25 //these dweebs don't get full block chance, because they're free cultists
	block_sound = 'sound/items/weapons/parry.ogg'

/obj/item/melee/cultblade/ghost/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CULT_TRAIT)

/obj/item/melee/cultblade/pickup(mob/living/user)
	..()
	if(!IS_CULTIST(user) && !free_use)
		to_chat(user, span_cult_large("\"Eu não aconselharia isso.\""))

/datum/action/innate/dash/cult
	name = "Rend the Veil"
	desc = "Use a espada para abrir o tecido frágil desta realidade e se teletransportar para seu alvo."
	button_icon = 'icons/mob/actions/actions_cult.dmi'
	button_icon_state = "phaseshift"
	dash_sound = 'sound/effects/magic/enter_blood.ogg'
	recharge_sound = 'sound/effects/magic/exit_blood.ogg'
	beam_effect = "sendbeam"
	phasein = /obj/effect/temp_visual/dir_setting/cult/phase
	phaseout = /obj/effect/temp_visual/dir_setting/cult/phase/out

/datum/action/innate/dash/cult/IsAvailable(feedback = FALSE)
	if(IS_CULTIST(owner) && current_charges)
		return TRUE
	else
		return FALSE

/obj/item/restraints/legcuffs/bola/cult
	name = "\improper Nar'Sien bola"
	desc = "Uma bola forte, ligada à magia negra que lhe permite passar inofensivamente através de cultistas Nar'Sien. Jogue para tropeçar e diminua a vítima."
	icon_state = "bola_cult"
	inhand_icon_state = "bola_cult"
	breakouttime = 6 SECONDS
	knockdown = 30

#define CULT_BOLA_PICKUP_STUN (6 SECONDS)
/obj/item/restraints/legcuffs/bola/cult/attack_hand(mob/living/carbon/user, list/modifiers)
	. = ..()

	if(IS_CULTIST(user) || !iscarbon(user))
		return
	var/mob/living/carbon/carbon_user = user
	if(user.num_legs < 2 || carbon_user.legcuffed) //if they can't be ensnared, stun for the same time as it takes to breakout of bola
		to_chat(user, span_cult_large("\"Eu não aconselharia isso.\""))
		user.dropItemToGround(src, TRUE)
		user.Paralyze(CULT_BOLA_PICKUP_STUN)
	else
		to_chat(user, span_warning("A bola parece ter uma vida própria!"))
		ensnare(user)
		user.update_held_items()
#undef CULT_BOLA_PICKUP_STUN


/obj/item/restraints/legcuffs/bola/cult/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	var/mob/hit_mob = hit_atom
	if (istype(hit_mob) && IS_CULTIST(hit_mob))
		return
	. = ..()

/obj/item/sharpener/cult
	name = "eldritch whetstone"
	desc = "Um bloco, fortalecido pela magia negra. Armas afiadas serão reforçadas quando usadas na pedra."
	icon = 'icons/obj/antags/cult/items.dmi'
	icon_state = "cult_sharpener"
	uses = 1
	increment = 5
	max = 40
	prefix = "darkened"

/obj/item/sharpener/cult/update_icon_state()
	icon_state = "cult_sharpener[(uses == 0) ? "_used" : ""]"
	return ..()

/obj/item/reagent_containers/cup/beaker/unholywater
	name = "flask of unholy water"
	desc = "Tóxico para descrentes, revigorante para os fiéis, este frasco pode ser bebido ou jogado."
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "unholyflask"
	inhand_icon_state = "holyflask"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/fuel/unholywater = 50)
	can_lid = FALSE

/obj/item/reagent_containers/cup/beaker/unholywater/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)

///if the max number of shuttle curses are used within this duration, the entire cult gets an achievement
#define SHUTTLE_CURSE_OMFG_TIMESPAN (10 SECONDS)

/obj/item/shuttle_curse
	name = "cursed orb"
	desc = "Você olha dentro desta esfera fumegante e vislumbra destinos terríveis que acontecem na nave de emergência."
	icon = 'icons/obj/antags/cult/items.dmi'
	icon_state = "shuttlecurse"
	///how many times has the shuttle been cursed so far?
	var/static/totalcurses = 0
	///when was the first shuttle curse?
	var/static/first_curse_time
	///curse messages that have already been used
	var/static/list/remaining_curses

/obj/item/shuttle_curse/attack_self(mob/living/user)
	if(!IS_CULTIST(user))
		user.dropItemToGround(src, TRUE)
		user.Paralyze(100)
		to_chat(user, span_warning("Uma força poderosa te afasta [src]!"))
		return
	if(totalcurses >= MAX_SHUTTLE_CURSES)
		to_chat(user, span_warning("Você tenta quebrar a esfera, mas ela permanece sólida como uma rocha!"))
		to_chat(user, span_danger(span_big("Parece que o culto de sangue esgotou sua capacidade de amaldiçoar a nave de fuga de emergência. Seria imprudente criar mais orbes amaldiçoados ou continuar tentando destruir este.")))
		return
	if(locate(/obj/narsie) in SSpoints_of_interest.narsies)
		to_chat(user, span_warning("Nar'Sie já está neste avião, não há atraso no fim de todas as coisas."))
		return

	if(SSshuttle.emergency.mode == SHUTTLE_CALL)
		var/cursetime = 3 MINUTES
		var/timer = SSshuttle.emergency.timeLeft(1) + cursetime
		var/security_num = SSsecurity_level.get_current_level_as_number()
		var/set_coefficient = 1

		if(totalcurses == 0)
			first_curse_time = world.time

		switch(security_num)
			if(SEC_LEVEL_GREEN)
				set_coefficient = 2
			if(SEC_LEVEL_BLUE)
				set_coefficient = 1
			else
				set_coefficient = 0.5
		var/surplus = timer - (SSshuttle.emergency_call_time * set_coefficient)
		SSshuttle.emergency.setTimer(timer)
		if(surplus > 0)
			SSshuttle.block_recall(surplus)
		totalcurses++
		to_chat(user, span_danger("Você quebra a esfera! Uma essência escura entra no ar e desaparece."))
		playsound(user.loc, 'sound/effects/glass/glassbr1.ogg', 50, TRUE)

		if(!remaining_curses)
			remaining_curses = strings(CULT_SHUTTLE_CURSE, "curse_announce")

		var/curse_message = pick_n_take(remaining_curses) || "Something has gone horrendously wrong..."

		curse_message += " The shuttle will be delayed by three minutes."
		priority_announce("[curse_message]", "System Failure", 'sound/announcer/notice/notice1.ogg')
		if(MAX_SHUTTLE_CURSES-totalcurses <= 0)
			to_chat(user, span_danger(span_big("Você sente que a nave de emergência não pode mais ser amaldiçoada. Seria imprudente criar mais orbes amaldiçoados.")))
		else if(MAX_SHUTTLE_CURSES-totalcurses == 1)
			to_chat(user, span_danger(span_big("Você sente que a nave de emergência só pode ser amaldiçoada mais uma vez.")))
		else
			to_chat(user, span_danger(span_big("Você sente que a nave de emergência só pode ser amaldiçoada [MAX_SHUTTLE_CURSES-totalcurses] Mais vezes.")))

		if(totalcurses >= MAX_SHUTTLE_CURSES && (world.time < first_curse_time + SHUTTLE_CURSE_OMFG_TIMESPAN))
			var/omfg_message = pick_list(CULT_SHUTTLE_CURSE, "omfg_announce") || "LEAVE US ALONE!"
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(priority_announce), omfg_message, "Priority Alert", 'sound/announcer/announcement/announce_syndi.ogg', null, "Nanotrasen Department of Transportation: Central Command"), rand(2 SECONDS, 6 SECONDS))
			for(var/mob/iter_player as anything in GLOB.player_list)
				if(IS_CULTIST(iter_player))
					iter_player.client?.give_award(/datum/award/achievement/misc/cult_shuttle_omfg, iter_player)

		qdel(src)

#define GATEWAY_TURF_SCAN_RANGE 40

/obj/item/proteon_orb
	name = "summoning orb"
	desc = "Uma estranha esfera translúcida que se sente incrivelmente leve. Lendas dizem que as órbitas de invocação são criadas a partir de órbitas corrompidas. Se você segurá-lo perto de seus ouvidos, você pode ouvir os gritos dos condenados."
	icon = 'icons/obj/antags/cult/items.dmi'
	icon_state = "summoning_orb"
	light_range = 3
	light_color = COLOR_CULT_RED

/obj/item/proteon_orb/examine(mob/user)
	. = ..()
	if(!IS_CULTIST(user) && isliving(user))
		var/mob/living/living_user = user
		living_user.adjust_organ_loss(ORGAN_SLOT_BRAIN, 5)
		. += span_danger("Dói só de olhar. Melhor ficar longe.")
	else
		. += span_cult("Pode ser usado para criar um portal para o domínio de Nar'Sie, que invocará construções fracas e sencientes ao longo do tempo.")

/obj/item/proteon_orb/attack_self(mob/living/user)

	var/list/turfs_to_scan = detect_room(get_turf(user), max_size = GATEWAY_TURF_SCAN_RANGE)

	if(!IS_CULTIST(user))
		to_chat(user, span_cult_large("\"Quer entrar no meu domínio? Vá em frente.\""))
		turfs_to_scan = null // narsie wants to have some fun and the veil wont stop her

	for(var/turf/hole_candidate as anything in turfs_to_scan)
		if(locate(/obj/structure/spawner/sentient/proteon_spawner) in hole_candidate)
			to_chat(user, span_cult_bold("Há um portal muito perto. O véu ainda não está fraco o suficiente para permitir rasgos tão próximos em seu tecido."))
			return
	to_chat(user, span_cult_bold_italic("Você se concentra em [src] e direcioná-lo para o chão. Estromece..."))

	var/turf/open/hole_spot = get_turf(user)
	if(!istype(hole_spot) || isgroundlessturf(hole_spot))
		to_chat(user, span_notice("Este lugar não é adequado."))
		return

	INVOKE_ASYNC(hole_spot, TYPE_PROC_REF(/turf/open, quake_gateway), user)
	qdel(src)

/**
 * Bespoke proc that happens when a proteon orb is activated, creating a gateway.
 * If activated by a non-cultist, they get an unusual game over.
*/
/turf/open/proc/quake_gateway(mob/living/user)
	Shake(2, 2, 5 SECONDS)
	narsie_act(TRUE, TRUE, 100)
	var/fucked = FALSE
	if(!IS_CULTIST(user))
		fucked = TRUE
		ADD_TRAIT(user, TRAIT_NO_TRANSFORM, REF(src)) // keep em in place
		user.add_atom_colour(COLOR_CULT_RED, TEMPORARY_COLOUR_PRIORITY)
		user.visible_message(span_cult_bold("Os tentáculos escuros aparecem do chão e da raiz.[user] No lugar!"))
	sleep(5 SECONDS) // can we still use these or. i mean its async
	new /obj/structure/spawner/sentient/proteon_spawner(src)
	visible_message(span_cult_bold("Um buraco misterioso aparece do nada!"))
	if(!fucked || QDELETED(user))
		return
	if(get_turf(user) != src) // they get away. for now
		REMOVE_TRAIT(user, TRAIT_NO_TRANSFORM, REF(src))
		return
	user.visible_message(span_cult_bold("[user] é puxado para o portal através de um buraco infinitamente minúsculo, rasgando [user.p_their()] Corpo!"))
	sleep(5 SECONDS)
	user.visible_message(span_cult_italic("Uma construção invulgarmente grande aparece através do portal!"))
	user.gib() // total destruction
	var/mob/living/basic/construct/proteon/hostile/remnant = new(get_step_rand(src))
	remnant.name = "[user]" // no, they do not become it
	remnant.transform *= 1.5

#undef GATEWAY_TURF_SCAN_RANGE

/obj/item/cult_shift
	name = "veil shifter"
	desc = "Esta relíquia teletransporta você instantaneamente, e tudo que você está puxando, para frente por uma distância moderada."
	icon = 'icons/obj/antags/cult/items.dmi'
	icon_state ="shifter"
	///How many uses does the item have before becoming inert
	var/uses = 4

/obj/item/cult_shift/examine(mob/user)
	. = ..()
	if(uses)
		. += span_cult("Tem.[uses] Use o restante.")
	else
		. += span_cult("Parece drenado.")

///Handles teleporting the atom we're pulling along with us when using the shifter
/obj/item/cult_shift/proc/handle_teleport_grab(turf/target_turf, mob/user)
	var/mob/living/carbon/pulling_user = user
	if(pulling_user.pulling)
		var/atom/movable/pulled = pulling_user.pulling
		do_teleport(pulled, target_turf, channel = TELEPORT_CHANNEL_CULT)
		. = pulled

/obj/item/cult_shift/attack_self(mob/user)
	if(!uses || !iscarbon(user))
		to_chat(user, span_warning("\The [src] é chato e imutável em suas mãos."))
		return
	if(!IS_CULTIST(user))
		user.dropItemToGround(src, TRUE)
		step(src, pick(GLOB.alldirs))
		to_chat(user, span_warning("\The [src] Sua conexão com esta dimensão é muito forte!"))
		return

	//The user of the shifter
	var/mob/living/carbon/user_cultist = user
	//Initial teleport location
	var/turf/mobloc = get_turf(user_cultist)
	//Teleport target turf, with some error to spice it up
	var/turf/destination = get_teleport_loc(location = mobloc, target = user_cultist, distance = 9, density_check = TRUE, errorx = 3, errory = 1, eoffsety = 1)
	//The atom the user was pulling when using the shifter; we handle it here before teleporting the user as to not lose their 'pulling' var
	var/atom/movable/pulled = handle_teleport_grab(destination, user_cultist)

	if(!destination || !do_teleport(user_cultist, destination, channel = TELEPORT_CHANNEL_CULT))
		playsound(src, 'sound/items/haunted/ghostitemattack.ogg', 100, TRUE)
		balloon_alert(user, "O teletransporte falhou!")
		return

	uses--
	if(uses <= 0)
		icon_state = "shifter_drained"

	if(pulled)
		user_cultist.start_pulling(pulled) //forcemove (teleporting) resets pulls, so we need to re-pull

	new /obj/effect/temp_visual/dir_setting/cult/phase/out(mobloc, user_cultist.dir)
	new /obj/effect/temp_visual/dir_setting/cult/phase(destination, user_cultist.dir)

	playsound(mobloc, SFX_PORTAL_ENTER, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	playsound(destination, 'sound/effects/phasein.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	playsound(destination, SFX_PORTAL_ENTER, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/obj/item/melee/cultblade/halberd
	name = "bloody halberd"
	desc = "Uma alabarda com um machado volátil feito de sangue cristalizado. Parece ligado ao seu criador. E, admite-se, mais de uma vara do que uma alabarda."
	icon = 'icons/obj/weapons/spear.dmi'
	icon_state = "occultpoleaxe0"
	base_icon_state = "occultpoleaxe"
	inhand_icon_state = "occultpoleaxe0"
	icon_angle = -45
	w_class = WEIGHT_CLASS_HUGE
	force = 17
	throwforce = 40
	throw_speed = 2
	armour_penetration = 30
	block_chance = 30
	slot_flags = null
	attack_verb_continuous = list("attacks", "slices", "shreds", "sunders", "lacerates", "cleaves")
	attack_verb_simple = list("attack", "slice", "shred", "sunder", "lacerate", "cleave")
	sharpness = SHARP_EDGED
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	block_sound = 'sound/items/weapons/parry.ogg'
	var/datum/action/innate/cult/halberd/halberd_act

/obj/item/melee/cultblade/halberd/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, 		speed = 10 SECONDS, 		effectiveness = 90, 	)
	AddComponent(/datum/component/two_handed, 		force_unwielded = 17, 		force_wielded = 24, 	)

/obj/item/melee/cultblade/halberd/update_icon_state()
	icon_state = HAS_TRAIT(src, TRAIT_WIELDED) ? "[base_icon_state]1" : "[base_icon_state]0"
	inhand_icon_state = HAS_TRAIT(src, TRAIT_WIELDED) ? "[base_icon_state]1" : "[base_icon_state]0"
	return ..()

/obj/item/melee/cultblade/halberd/Destroy()
	if(halberd_act)
		QDEL_NULL(halberd_act)
	return ..()

/obj/item/melee/cultblade/halberd/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	var/turf/T = get_turf(hit_atom)
	if(isliving(hit_atom))
		var/mob/living/target = hit_atom

		if(IS_CULTIST(target) && target.put_in_active_hand(src))
			playsound(src, 'sound/items/weapons/throwtap.ogg', 50)
			target.visible_message(span_warning("[target] pega [src] Fora do ar!"))
			return
		if(target.can_block_magic() || IS_CULTIST(target))
			target.visible_message(span_warning("[src] Rebate de [target] Como se repelido por uma força invisível!"))
			return
		if(!..())
			target.Paralyze(50)
			break_halberd(T)
	else
		..()

/obj/item/melee/cultblade/halberd/proc/break_halberd(turf/T)
	if(src)
		if(!T)
			T = get_turf(src)
		if(T)
			T.visible_message(span_warning("[src] Estilhaça e derrete de volta em sangue!"))
			new /obj/effect/temp_visual/cult/sparks(T)
			new /obj/effect/decal/cleanable/blood/splatter(T)
			playsound(T, 'sound/effects/glass/glassbr3.ogg', 100)
	qdel(src)

/obj/item/melee/cultblade/halberd/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == OVERWHELMING_ATTACK)
		return FALSE
	if(HAS_TRAIT(src, TRAIT_WIELDED))
		final_block_chance *= 2
	if(IS_CULTIST(owner) && prob(final_block_chance))
		owner.visible_message(span_danger("[owner] Parries [attack_text] com [src]!"))
		new /obj/effect/temp_visual/cult/sparks(get_turf(owner))
		return TRUE
	else
		return FALSE

/datum/action/innate/cult/halberd
	name = "Bloody Bond"
	desc = "Chame o maldito Halberd de volta para sua mão!"
	background_icon_state = "bg_demon"
	overlay_icon_state = "bg_demon_border"

	button_icon_state = "bloodspear"
	default_button_position = "6:157,4:-2"
	var/obj/item/melee/cultblade/halberd/halberd
	var/cooldown = 0

/datum/action/innate/cult/halberd/Grant(mob/user, obj/blood_halberd)
	. = ..()
	halberd = blood_halberd

/datum/action/innate/cult/halberd/Activate()
	if(owner == halberd.loc || cooldown > world.time)
		return
	var/halberd_location = get_turf(halberd)
	var/owner_location = get_turf(owner)
	if(get_dist(owner_location, halberd_location) > 10)
		to_chat(owner,span_cult("O Halberd está muito longe!"))
	else
		cooldown = world.time + 20
		if(isliving(halberd.loc))
			var/mob/living/current_owner = halberd.loc
			current_owner.dropItemToGround(halberd)
			current_owner.visible_message(span_warning("Uma força invisível puxa o maldito Halberd de [current_owner] Mãos!"))
		halberd.throw_at(owner, 10, 2, owner)


/obj/item/gun/magic/wand/arcane_barrage/blood
	name = "blood bolt barrage"
	desc = "Sangue por sangue."
	color = "#ff0000"
	ammo_type =  /obj/item/ammo_casing/magic/arcane_barrage/blood
	fire_sound = 'sound/effects/magic/wand_teleport.ogg'

/obj/item/ammo_casing/magic/arcane_barrage/blood
	projectile_type = /obj/projectile/magic/arcane_barrage/blood
	firing_effect_type = /obj/effect/temp_visual/cult/sparks

/obj/projectile/magic/arcane_barrage/blood
	name = "blood bolt"
	icon_state = "blood_bolt"
	nondirectional_sprite = TRUE
	damage_type = BRUTE
	impact_effect_type = /obj/effect/temp_visual/dir_setting/bloodsplatter

/obj/projectile/magic/arcane_barrage/blood/Bump(atom/target)
	. = ..()
	var/turf/our_turf = get_turf(target)
	playsound(our_turf , 'sound/effects/splat.ogg', 50, TRUE)
	new /obj/effect/temp_visual/cult/sparks(our_turf)

/obj/projectile/magic/arcane_barrage/blood/prehit_pierce(atom/target)
	. = ..()
	if(!ismob(target))
		return PROJECTILE_PIERCE_NONE

	var/mob/living/our_target = target
	if(!IS_CULTIST(our_target))
		return PROJECTILE_PIERCE_NONE

	if(iscarbon(our_target) && our_target.stat != DEAD)
		var/mob/living/carbon/carbon_cultist = our_target
		carbon_cultist.reagents.add_reagent(/datum/reagent/fuel/unholywater, 4)
	if(isshade(our_target) || isconstruct(our_target))
		var/mob/living/basic/construct/undead_abomination = our_target
		if(undead_abomination.health + 5 < undead_abomination.maxHealth)
			undead_abomination.adjust_health(-5)
	return PROJECTILE_DELETE_WITHOUT_HITTING

/obj/item/blood_beam
	name = "\improper magical aura"
	desc = "Uma aura sinistra que distorce o fluxo da realidade ao seu redor."
	icon = 'icons/obj/weapons/hand.dmi'
	lefthand_file = 'icons/mob/inhands/items/touchspell_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/touchspell_righthand.dmi'
	icon_state = "disintegrate"
	inhand_icon_state = "disintegrate"
	item_flags = ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	throwforce = 0
	throw_range = 0
	throw_speed = 0
	var/charging = FALSE
	var/firing = FALSE
	var/angle

/obj/item/blood_beam/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CULT_TRAIT)

/obj/item/blood_beam/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	return ranged_interact_with_atom(interacting_with, user, modifiers)

/obj/item/blood_beam/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(firing || charging)
		return ITEM_INTERACT_BLOCKING
	if(!ishuman(user))
		return ITEM_INTERACT_BLOCKING
	angle = get_angle(user, interacting_with)
	charging = TRUE
	INVOKE_ASYNC(src, PROC_REF(charge), user)
	if(do_after(user, 9 SECONDS, target = user))
		firing = TRUE
		ADD_TRAIT(user, TRAIT_IMMOBILIZED, CULT_TRAIT)
		var/params = list2params(modifiers)
		INVOKE_ASYNC(src, PROC_REF(pewpew), user, params)
		var/obj/structure/emergency_shield/cult/weak/N = new(user.loc)
		if(do_after(user, 9 SECONDS, target = user))
			user.Paralyze(40)
			to_chat(user, span_cult_italic("Você esgotou o poder deste feitiço!"))
		REMOVE_TRAIT(user, TRAIT_IMMOBILIZED, CULT_TRAIT)
		firing = FALSE
		if(N)
			qdel(N)
		qdel(src)
	charging = FALSE
	return ITEM_INTERACT_SUCCESS

/obj/item/blood_beam/proc/charge(mob/user)
	var/obj/O
	playsound(src, 'sound/effects/magic/lightning_chargeup.ogg', 100, TRUE)
	for(var/i in 1 to 12)
		if(!charging)
			break
		if(i > 1)
			sleep(1.5 SECONDS)
		if(i < 4)
			O = new /obj/effect/temp_visual/cult/rune_spawn/rune1/inner(user.loc, 30, "#ff0000")
		else
			O = new /obj/effect/temp_visual/cult/rune_spawn/rune5(user.loc, 30, "#ff0000")
			new /obj/effect/temp_visual/dir_setting/cult/phase/out(user.loc, user.dir)
	if(O)
		qdel(O)

/obj/item/blood_beam/proc/pewpew(mob/user, proximity_flag)
	var/turf/targets_from = get_turf(src)
	var/spread = 40
	var/second = FALSE
	var/set_angle = angle
	for(var/i in 1 to 12)
		if(second)
			set_angle = angle - spread
			spread -= 8
		else
			sleep(1.5 SECONDS)
			set_angle = angle + spread
		second = !second //Handles beam firing in pairs
		if(!firing)
			break
		playsound(src, 'sound/effects/magic/exit_blood.ogg', 75, TRUE)
		new /obj/effect/temp_visual/dir_setting/cult/phase(user.loc, user.dir)
		var/turf/temp_target = get_turf_in_angle(set_angle, targets_from, 40)
		for(var/turf/T in get_line(targets_from,temp_target))
			if (locate(/obj/effect/blessing, T))
				temp_target = T
				playsound(T, 'sound/effects/parry.ogg', 50, TRUE)
				new /obj/effect/temp_visual/at_shield(T, T)
				break
			T.narsie_act(TRUE, TRUE)
			for(var/mob/living/target in T.contents)
				if(IS_CULTIST(target))
					new /obj/effect/temp_visual/cult/sparks(T)
					if(ishuman(target))
						var/mob/living/carbon/human/H = target
						if(H.stat != DEAD)
							H.reagents.add_reagent(/datum/reagent/fuel/unholywater, 7)
					if(isshade(target) || isconstruct(target))
						var/mob/living/basic/construct/healed_guy = target
						if(healed_guy.health + 15 < healed_guy.maxHealth)
							healed_guy.adjust_health(-15)
						else
							healed_guy.health = healed_guy.maxHealth
				else
					var/mob/living/L = target
					if(L.density)
						L.Paralyze(20)
						L.adjust_brute_loss(45)
						playsound(L, 'sound/effects/hallucinations/wail.ogg', 50, TRUE)
						L.emote("scream")
		user.Beam(temp_target, icon_state="blood_beam", time = 7, beam_type = /obj/effect/ebeam/blood)


/obj/effect/ebeam/blood
	name = "blood beam"

/obj/item/shield/mirror
	name = "mirror shield"
	desc = "Um escudo infame usado por seitas Nar'Sien para confundir e desorientar seus inimigos. Suas bordas são ponderadas para uso como arma de arremesso, capaz de desativar múltiplos inimigos com precisão sobrenatural."
	icon_state = "mirror_shield" // eshield1 for expanded
	inhand_icon_state = "mirror_shield"
	lefthand_file = 'icons/mob/inhands/equipment/shields_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/shields_righthand.dmi'
	force = 5
	throwforce = 15
	throw_speed = 1
	throw_range = 4
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("bumps", "prods")
	attack_verb_simple = list("bump", "prod")
	hitsound = 'sound/items/weapons/smash.ogg'
	block_sound = 'sound/items/weapons/effects/ric5.ogg'
	shield_bash_sound = 'sound/effects/glass/glassknock.ogg'
	var/illusions = 2

/obj/item/shield/mirror/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(!IS_CULTIST(owner))
		if(prob(50))
			var/mob/living/basic/illusion/bizarro = new(owner.loc)
			bizarro.full_setup(owner, target_mob = owner, faction_override = list(FACTION_CULT), life = 10 SECONDS, damage = 20, replicate = 5)

			to_chat(owner, span_bolddanger("Você é traído por\"você mesmo.\"!"))
		return FALSE

	if(attack_type == PROJECTILE_ATTACK)
		if(damage_type == BRUTE || damage_type == BURN)
			if(damage >= 30)
				var/turf/T = get_turf(owner)
				T.visible_message(span_warning("A pura força de [hitby] Quebra o escudo do espelho!"))
				new /obj/effect/temp_visual/cult/sparks(T)
				playsound(T, 'sound/effects/glass/glassbr3.ogg', 100)
				owner.Paralyze(25)
				qdel(src)
				return FALSE
		var/obj/projectile/projectile = hitby
		if(projectile.reflectable)
			return FALSE //To avoid reflection chance double-dipping with block chance

	. = ..()
	if(!.)
		return FALSE

	if(illusions > 0)
		illusions--
		addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/item/shield/mirror, readd)), 45 SECONDS)
		if(prob(60)) // make a potentially slower, but replicable apparation
			var/mob/living/basic/illusion/apparation = new(owner.loc)
			apparation.full_setup(owner, target_mob = null, faction_override = list(FACTION_CULT), life = 7 SECONDS, damage = 10, replicate = 5)
			apparation.cached_multiplicative_slowdown = owner.cached_multiplicative_slowdown
		else // normal apparation designed to escape
			var/mob/living/basic/illusion/escape/decoy = new(owner.loc)
			decoy.full_setup(owner, target_mob = owner, faction_override = list(FACTION_CULT), life = 7 SECONDS, damage = 10) // Damage for retaliation
	return TRUE


/obj/item/shield/mirror/proc/readd()
	illusions++
	if(illusions == initial(illusions) && isliving(loc))
		var/mob/living/holder = loc
		to_chat(holder, span_cult_italic("As ilusões do escudo estão de volta à força total!"))

/obj/item/shield/mirror/IsReflect()
	if(prob(block_chance))
		return TRUE
	return FALSE

/obj/item/shield/mirror/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(isliving(hit_atom))
		var/mob/living/target = hit_atom

		if(target.can_block_magic() || IS_CULTIST(target))
			target.visible_message(span_warning("[src] Rebate de [target] Como se repelido por uma força invisível!"))
			return
		if(IS_CULTIST(target) && target.put_in_active_hand(src))
			playsound(src, 'sound/items/weapons/throwtap.ogg', 50)
			target.visible_message(span_warning("[target] pega [src] Fora do ar!"))
			return
		if(!..())
			target.Paralyze(30)
			new /obj/effect/temp_visual/cult/sparks(target)
			playsound(target, 'sound/effects/glass/glassbr3.ogg', 100)
			qdel(src)
	else
		..()

#undef SHUTTLE_CURSE_OMFG_TIMESPAN
