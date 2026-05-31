/datum/antagonist/survivalist
	name = "\improper Survivalist"
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = TRUE
	suicide_cry = "FOR MYSELF!!"
	/// What do we display when you gain the antag datum?
	var/greet_message = ""
	/// Should we immediately print the objectives?
	var/announce_objectives = TRUE

/datum/antagonist/survivalist/forge_objectives()
	var/datum/objective/survive/survive = new
	survive.owner = owner
	objectives += survive

/datum/antagonist/survivalist/on_gain()
	forge_objectives()
	. = ..()

/datum/antagonist/survivalist/greet()
	. = ..()
	to_chat(owner, "<B>[greet_message]</B>")
	if (announce_objectives)
		owner.announce_objectives()

/datum/antagonist/survivalist/guns
	greet_message = "Sua própria segurança importa acima de tudo, e a única maneira de garantir sua segurança é estocar armas! Pegue o máximo de armas possível, por qualquer meio necessário. Mate qualquer um que ficar no seu caminho."
	hardcore_random_bonus = TRUE

/datum/antagonist/survivalist/guns/forge_objectives()
	var/datum/objective/steal_n_of_type/summon_guns/guns = new
	guns.owner = owner
	objectives += guns
	..()

/datum/antagonist/survivalist/magic
	name = "Amateur Magician"
	greet_message = "Cresça seu novo talento! Pegue tantos artefatos mágicos quanto possível, por qualquer meio necessário. Mate qualquer um que ficar no seu caminho."
	hardcore_random_bonus = TRUE

/datum/antagonist/survivalist/magic/greet()
	. = ..()
	to_chat(owner, span_notice("Como um mágico maravilhoso, lembre-se que livros de feitiço não significam nada se forem usados."))

/datum/antagonist/survivalist/magic/forge_objectives()
	var/datum/objective/steal_n_of_type/summon_magic/magic = new
	magic.owner = owner
	objectives += magic
	..()

/datum/antagonist/survivalist/magic/on_gain()
	. = ..()
	owner.add_traits(list(TRAIT_MAGICALLY_GIFTED, TRAIT_SEE_BLESSED_TILES), REF(src))
	for(var/datum/atom_hud/alternate_appearance/basic/blessed_aware/blessed_hud in GLOB.active_alternate_appearances)
		blessed_hud.check_hud(owner.current)

/datum/antagonist/survivalist/magic/on_removal()
	owner.remove_traits(list(TRAIT_MAGICALLY_GIFTED, TRAIT_SEE_BLESSED_TILES), REF(src))
	return ..()

/// Applied by the battle royale objective
/datum/antagonist/survivalist/battle_royale
	name = "Battle Royale Contestant"
	greet_message = "Tem que haver algum jeito de você sair dessa vivo..."
	announce_objectives = FALSE

/datum/antagonist/survivalist/battle_royale/on_gain()
	. = ..()
	if (isnull(owner.current))
		return
	RegisterSignals(owner.current, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING), PROC_REF(on_died))

/datum/antagonist/survivalist/battle_royale/greet()
	to_chat(owner, span_warning("[span_bold("You hear a tinny voice in your ear: ")] 		Welcome contestant to Rumble Royale, the galaxy's greatest show! \n		You may have already heard our announcement, but we're glad to tell you that you are on live TV! \n		Your objective in this contest is simple: Within ten minutes be the last contestant left alive, to win a fabulous prize! \n		Your fellow contestants will be hearing this too, so you should grab a GPS quick and get hunting! \n		Noncompliance and removal of this implant is not recommended, and remember to smile for the cameras!"))

	return ..()

/datum/antagonist/survivalist/battle_royale/on_removal()
	if (isnull(owner.current))
		return ..()
	UnregisterSignal(owner.current, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING))
	if (owner.current.stat == DEAD)
		return ..()
	to_chat(owner, span_notice("Seu corpo está inundado de alívio. Contra todas as probabilidades, você saiu vivo."))
	owner.current?.add_mood_event("battle_royale", /datum/mood_event/royale_survivor)
	return ..()

/// Add an objective to go to a specific place.
/datum/antagonist/survivalist/battle_royale/proc/set_target_area(target_area_name)
	var/datum/objective/custom/travel = new
	travel.owner = owner
	travel.explanation_text = "Reach the [target_area_name] before time runs out."
	objectives.Insert(1, travel)
	owner.announce_objectives()

/// Called if you fail to survive.
/datum/antagonist/survivalist/battle_royale/proc/on_died()
	SIGNAL_HANDLER
	owner.remove_antag_datum(type)

/datum/mood_event/royale_survivor
	description = "Consegui sair de Rumble Royale com minha vida."
	mood_change = 4
