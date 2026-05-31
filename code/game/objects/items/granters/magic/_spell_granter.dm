/obj/item/book/granter/action/spell

/obj/item/book/granter/action/spell/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_MAGICALLY_CHARGED, PROC_REF(on_magic_charge))

/**
 * Signal proc for [COMSIG_ITEM_MAGICALLY_CHARGED]
 *
 * Refreshes uses on our spell granter, or make it quicker to read if it's already infinite use
 */
/obj/item/book/granter/action/spell/proc/on_magic_charge(datum/source, datum/action/cooldown/spell/spell, mob/living/caster)
	SIGNAL_HANDLER

	// What're the odds someone uses 2000 uses of an infinite use book?
	if(uses >= INFINITY - 2000)
		to_chat(caster, span_notice("Este livro é de uso infinito e não pode ser recarregado, mas a magia o melhorou de alguma forma..."))
		pages_to_mastery = max(pages_to_mastery - 1, 1)
		return COMPONENT_ITEM_CHARGED|COMPONENT_ITEM_BURNT_OUT

	if(prob(80))
		caster.dropItemToGround(src, TRUE)
		visible_message(span_warning("[src]Pega fogo e queima em cinzas!"))
		new /obj/effect/decal/cleanable/ash(drop_location())
		qdel(src)
		return COMPONENT_ITEM_BURNT_OUT

	uses++
	return COMPONENT_ITEM_CHARGED

/obj/item/book/granter/action/spell/can_learn(mob/living/user)
	if(!granted_action)
		CRASH("Someone attempted to learn [type], which did not have a spell set.")
	if(locate(granted_action) in user.actions)
		if(HAS_MIND_TRAIT(user, TRAIT_MAGICALLY_GIFTED))
			to_chat(user, span_warning("Você já é muito mais versado no feitiço.[action_name]do que esse livro de como fornecer!"))
		else
			to_chat(user, span_warning("Você já sabe o feitiço.[action_name]!"))
		return FALSE
	return TRUE

/obj/item/book/granter/action/spell/on_reading_start(mob/living/user)
	to_chat(user, span_notice("Você começa a ler sobre elenco[action_name]..."))
	return TRUE

/obj/item/book/granter/action/spell/on_reading_finished(mob/living/user)
	to_chat(user, span_notice("Você sente que já experimentou o suficiente para lançar[action_name]!"))
	var/datum/action/cooldown/spell/new_spell = new granted_action(user.mind || user)
	new_spell.Grant(user)
	user.log_message("learned the spell [action_name] ([new_spell])", LOG_ATTACK, color = "orange")
	if(uses <= 0)
		user.visible_message(span_warning("[src]brilha escuro por um segundo!"))

/obj/item/book/granter/action/spell/recoil(mob/living/user)
	user.visible_message(span_warning("[src]brilha em uma luz negra!"))

/// Simple granter that's replaced with a random spell granter on Initialize.
/obj/item/book/granter/action/spell/random
	icon_state = "random_book"

/obj/item/book/granter/action/spell/random/Initialize(mapload)
	. = ..()
	var/static/list/banned_spells = list(
		/obj/item/book/granter/action/spell/true_random,
	) + typesof(/obj/item/book/granter/action/spell/mime)

	var/real_type = pick(subtypesof(/obj/item/book/granter/action/spell) - banned_spells)
	new real_type(loc)

	return INITIALIZE_HINT_QDEL

/// A more volatile granter that can potentially have any spell within. Use wisely.
/obj/item/book/granter/action/spell/true_random
	icon_state = "random_book"
	desc = "Você sente como se algo pudesse ser ganho com este livro."
	/// A list of schools we probably shouldn't grab, for various reasons
	var/static/list/blacklisted_schools = list(SCHOOL_UNSET, SCHOOL_HOLY, SCHOOL_MIME)

/obj/item/book/granter/action/spell/true_random/Initialize(mapload)
	. = ..()

	var/static/list/spell_options
	if(!spell_options)
		spell_options = subtypesof(/datum/action/cooldown/spell)
		for(var/datum/action/cooldown/spell/spell as anything in spell_options)
			if(initial(spell.school) in blacklisted_schools)
				spell_options -= spell
			if(initial(spell.name) == "Spell") // Abstract types
				spell_options -= spell

	granted_action = pick(spell_options)
	action_name = LOWER_TEXT(initial(granted_action.name))
