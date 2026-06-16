// Ritual spells which affect the station at large
/// How much threat we need to let these rituals happen on dynamic
#define MINIMUM_THREAT_FOR_RITUALS 98

/datum/spellbook_entry/summon/ghosts
	name = "Summon Ghosts"
	desc = "Assustaram a tripulação fazendo-os ver pessoas mortas. Seja avisado, fantasmas são caprichosos e ocasionalmente vingativos, e alguns usarão suas habilidades incrivelmente menores para frustrar você."
	cost = 0

/datum/spellbook_entry/summon/ghosts/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy = TRUE)
	summon_ghosts(user)
	playsound(get_turf(user), 'sound/effects/ghost2.ogg', 50, TRUE)
	return ..()

/datum/spellbook_entry/summon/guns
	name = "Summon Guns"
	desc = "Nada poderia dar errado em armar uma equipe de lunáticos só querendo uma desculpa para matá-lo. Há uma boa chance de eles atirarem um no outro primeiro."

/datum/spellbook_entry/summon/guns/can_be_purchased()
	// Must be a high chaos round + Also must be config enabled
	return !CONFIG_GET(flag/no_summon_guns) // BUBBER EDIT CHANGE - Storyteller - ORIGINAL: return SSdynamic.current_tier.tier == DYNAMIC_TIER_HIGH && !CONFIG_GET(flag/no_summon_guns)

/datum/spellbook_entry/summon/guns/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy = TRUE)
	summon_guns(user, 10)
	playsound(get_turf(user), 'sound/effects/magic/castsummon.ogg', 50, TRUE)
	return ..()

/datum/spellbook_entry/summon/magic
	name = "Summon Magic"
	desc = "Compartilhe as maravilhas da magia com a tripulação e mostre a eles por que não são confiáveis ao mesmo tempo."

/datum/spellbook_entry/summon/magic/can_be_purchased()
	// Must be a high chaos round + Also must be config enabled
	return !CONFIG_GET(flag/no_summon_magic) // BUBBER EDIT CHANGE - Storyteller - ORIGINAL: return SSdynamic.current_tier.tier == DYNAMIC_TIER_HIGH && !CONFIG_GET(flag/no_summon_magic)

/datum/spellbook_entry/summon/magic/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy = TRUE)
	summon_magic(user, 10)
	playsound(get_turf(user), 'sound/effects/magic/castsummon.ogg', 50, TRUE)
	return ..()

/datum/spellbook_entry/summon/events
	name = "Summon Events"
	desc = "Dê à lei de Murphy um empurrãozinho e substitua todos os eventos por magos especiais que confundirão e confundirão todos. Múltiplos lançamentos aumentam a taxa desses eventos."
	cost = 2
	limit = 5 // Each purchase can intensify it.

/datum/spellbook_entry/summon/events/can_be_purchased()
	// Must be a high chaos round + Also must be config enabled
	return !CONFIG_GET(flag/no_summon_events) // BUBBER EDIT CHANGE - Storyteller - ORIGINAL: return SSdynamic.current_tier.tier == DYNAMIC_TIER_HIGH && !CONFIG_GET(flag/no_summon_events)

/datum/spellbook_entry/summon/events/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy = TRUE)
	summon_events(user)
	playsound(get_turf(user), 'sound/effects/magic/castsummon.ogg', 50, TRUE)
	return ..()

/datum/spellbook_entry/summon/curse_of_madness
	name = "Curse of Madness"
	desc = "Amaldiçoa a estação, distorcendo as mentes de todos dentro, causando traumas duradouros. Aviso: este feitiço pode afetá-lo se não for lançado de uma distância segura."
	cost = 4

/datum/spellbook_entry/summon/curse_of_madness/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy = TRUE)
	var/message = tgui_input_text(user, "Whisper a secret truth to drive your victims to madness", "Whispers of Madness", max_length = MAX_MESSAGE_LEN)
	if(!message || QDELETED(user) || QDELETED(book) || !can_buy(user, book))
		return FALSE
	curse_of_madness(user, message)
	playsound(user, 'sound/effects/magic/mandswap.ogg', 50, TRUE)
	return ..()

/// A wizard ritual that allows the wizard to teach a specific spellbook enty to everyone on the station.
/// This includes item entries (which will be given to everyone) but disincludes other rituals like itself
/datum/spellbook_entry/summon/specific_spell
	name = "Mass Wizard Teaching"
	desc = "Ensine um feitiço específico (ou dê um item específico) para todos na estação. O custo disto é aumentado pelo custo do feitiço que você escolhe. E não se preocupe - você também, vai aprender o feitiço!"
	cost = 3 // cheapest is 4 cost, most expensive is 7 cost
	limit = 1

/datum/spellbook_entry/summon/specific_spell/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy = TRUE)
	var/list/spell_options = list()
	for(var/datum/spellbook_entry/entry as anything in book.entries)
		if(istype(entry, /datum/spellbook_entry/summon))
			continue
		if(!entry.can_be_purchased())
			continue

		spell_options[entry.name] = entry

	sortTim(spell_options, GLOBAL_PROC_REF(cmp_text_asc))
	var/chosen_spell_name = tgui_input_list(user, "Choose a spell (or item) to grant to everyone...", "Wizardly Teaching", spell_options)
	if(isnull(chosen_spell_name) || QDELETED(user) || QDELETED(book))
		return FALSE
	if(GLOB.mass_teaching)
		tgui_alert(user, "Alguém já está no elenco.[name]!", "Wizardly Teaching", list("Shame"))
		return FALSE

	var/datum/spellbook_entry/chosen_entry = spell_options[chosen_spell_name]
	if(cost + chosen_entry.cost > book.uses)
		tgui_alert(user, "Você não pode conceder a todos.[chosen_spell_name]! ([cost]Pontos necessários)", "Wizardly Teaching", list("Shame"))
		return FALSE

	cost += chosen_entry.cost
	if(!can_buy(user, book))
		cost = initial(cost)
		return FALSE

	GLOB.mass_teaching = new(chosen_entry.type)
	GLOB.mass_teaching.equip_all_affected()

	var/item_entry = istype(chosen_entry, /datum/spellbook_entry/item)
	to_chat(user, span_hypnophrase("Você tem[item_entry ? "granted everyone the power" : "taught everyone the ways"]De [chosen_spell_name]!"))
	message_admins("[ADMIN_LOOKUPFLW(user)] gave everyone the [item_entry ? "item" : "spell"] \"[chosen_spell_name]\"!")
	user.log_message("has gave everyone the [item_entry ? "item" : "spell"] \"[chosen_spell_name]\"!", LOG_GAME)

	name = "[name]: [chosen_spell_name]"
	return ..()

/datum/spellbook_entry/summon/specific_spell/can_buy(mob/living/carbon/human/user, obj/item/spellbook/book)
	if(GLOB.mass_teaching)
		return FALSE
	return ..()

/datum/spellbook_entry/summon/specific_spell/can_be_purchased()
	/* BUBBER EDIT REMOVAL BEGIN - Storyteller
	if(SSdynamic.current_tier.tier != DYNAMIC_TIER_HIGH)
		return FALSE
	*/// BUBBER EDIT REMOVAL END - Storyteller
	if(GLOB.mass_teaching)
		return FALSE
	return ..()

#undef MINIMUM_THREAT_FOR_RITUALS
