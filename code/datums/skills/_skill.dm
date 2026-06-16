GLOBAL_LIST_INIT(skill_types, subtypesof(/datum/skill))

/datum/skill
	var/name = "Skilling"
	var/title = "Skiller"
	var/desc = "the art of doing things"
	///Dictionary of modifier type - list of modifiers (indexed by level). 7 entries in each list for all 7 skill levels.
	var/modifiers = list(SKILL_SPEED_MODIFIER = list(1, 1, 1, 1, 1, 1, 1)) //Dictionary of modifier type - list of modifiers (indexed by level). 7 entries in each list for all 7 skill levels.
	///List Path pointing to the skill item reward that will appear when a user finishes leveling up a skill
	var/skill_item_path
	///List associating different messages that appear on level up with different levels
	var/list/levelUpMessages = list()
	///List associating different messages that appear on level up with different levels
	var/list/levelDownMessages = list()

/datum/skill/proc/get_skill_modifier(modifier, level)
	return modifiers[modifier][level] //Levels range from 1 (None) to 7 (Legendary)
/**
 * new: sets up some lists.
 *
 *Can't happen in the datum's definition because these lists are not constant expressions
 */
/datum/skill/New()
	. = ..()
	levelUpMessages = list(span_nicegreen("What the hell is [name]? Tell an admin if you see this message."), //This first index shouldn't ever really be used
	span_nicegreen("Estou começando a descobrir o que [name] Realmente é!"),
	span_nicegreen("Estou ficando um pouco melhor em [name]!"),
	span_nicegreen("Esto ficando muito melhor em [name]!"),
	span_nicegreen("SINTO QUE ME ROUTEI BESTANTE EFICIENTE EM [name]!"),
	span_nicegreen("Depois de muita prática, comecei a entender as complexidades e profundidades surpreendentes atrás.[name] Agora eu considero um mestre.[title]."),
	span_nicegreen("Através de incrível determinação e esforço, atingi o auge da minha [name] Habilidades. Finalmente posso me considerar uma lendária [title]!") )
	levelDownMessages = list(span_nicegreen("I have somehow completely lost all understanding of [name]. Please tell an admin if you see this."),
	span_nicegreen("Estou começando a esquecer o que [name] Realmente é. Preciso de mais prática..."),
	span_nicegreen("Estou ficando um pouco pior.[name] Preciso continuar praticando para melhorar..."),
	span_nicegreen("Estou ficando um pouco pior.[name]..."),
	span_nicegreen("Estou pedendo meu [name] Perícia..."),
	span_nicegreen("Sinto que estou perdendo meu domínio [name]."),
	span_nicegreen("Eu me sinto como se fosse meu lendário [name] Como as habilidades se deterioraram. Precisarei de mais treinamento para recuperar minhas habilidades.") )

/**
 * level_gained: Gives skill levelup messages to the user
 *
 * Only fires if the xp gain isn't silent, so only really useful for messages.
 * Arguments:
 * * mind - The mind that you'll want to send messages
 * * new_level - The newly gained level. Can check the actual level to give different messages at different levels, see defines in skills.dm
 * * old_level - Similar to the above, but the level you had before levelling up.
 * * silent - Silences the announcement if TRUE
 */
/datum/skill/proc/level_gained(datum/mind/mind, new_level, old_level, silent)
	if(silent)
		return
	to_chat(mind.current, levelUpMessages[new_level]) //new_level will be a value from 1 to 6, so we get appropriate message from the 6-element levelUpMessages list
/**
 * level_lost: See level_gained, same idea but fires on skill level-down
 */
/datum/skill/proc/level_lost(datum/mind/mind, new_level, old_level, silent)
	if(silent)
		return
	to_chat(mind.current, levelDownMessages[old_level]) //old_level will be a value from 1 to 6, so we get appropriate message from the 6-element levelUpMessages list

/**
 * try_skill_reward: Checks to see if a user is eligable for a tangible reward for reaching a certain skill level
 *
 * Currently gives the user a special cloak when they reach a legendary level at any given skill
 * Arguments:
 * * mind - The mind that you'll want to send messages and rewards to
 * * new_level - The current level of the user. Used to check if it meets the requirements for a reward
 */
/datum/skill/proc/try_skill_reward(datum/mind/mind, new_level)
	if (new_level != SKILL_LEVEL_LEGENDARY)
		return
	if (!ispath(skill_item_path))
		to_chat(mind.current, span_nicegreen("Meu lendário.[name] A habilidade é bastante impressionante, embora pareça o Profissional [title] Associação não tem nenhum símbolo de status para comemorar minhas habilidades. Eu deveria avisar o Centcom sobre essa farsa, talvez eles possam fazer algo a respeito."))
		return
	if (LAZYFIND(mind.skills_rewarded, src.type))
		to_chat(mind.current, span_nicegreen("Parece que o Profissional [title] Associação não me enviará outro símbolo de status."))
		return
	podspawn(list(
		"target" = get_turf(mind.current),
		"style" = /datum/pod_style/advanced,
		"spawn" = skill_item_path,
		"delays" = list(POD_TRANSIT = 150, POD_FALLING = 4, POD_OPENING = 30, POD_LEAVING = 30)
	))
	to_chat(mind.current, span_nicegreen("Minha lendária habilidade atraiu a atenção do Profissional [title] Associação. Parece que estão me enviando um símbolo de status para comemorar minhas habilidades."))
	LAZYADD(mind.skills_rewarded, src.type)
