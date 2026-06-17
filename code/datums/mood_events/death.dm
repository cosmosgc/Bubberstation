// Defines for priority levels of various conditional death moodlets.
// These are defines so it's easier to get an overview of all priority levels in one place and tweak them all in some synchronous manner

#define DESENSITIZED_PRIORITY 10
#define PET_PRIORITY 30
#define XENO_PRIORITY 35
#define DONTCARE_PRIORITY 40
#define ASHWALKER_PRIORITY 50
#define GAMER_PRIORITY 80
#define REVOLUTIONARY_PRIORITY 85
#define CULT_PRIORITY 90
#define NAIVE_PRIORITY 100

/datum/mood_event/conditional/see_death
	mood_change = -8
	timeout = 5 MINUTES

/datum/mood_event/conditional/see_death/can_effect_mob(datum/mood/home, mob/living/who, mob/dead_mob, dusted, gibbed)
	if(isnull(dead_mob))
		stack_trace("Death mood event being applied with null dead_mob")
		return FALSE

	return ..()

/datum/mood_event/conditional/see_death/condition_fulfilled(mob/living/who, mob/dead_mob, dusted, gibbed)
	return TRUE

/datum/mood_event/conditional/see_death/add_effects(mob/dead_mob, dusted, gibbed)
	update_effect(dead_mob, dusted, gibbed)

	if(HAS_TRAIT(dead_mob, TRAIT_SPAWNED_MOB))
		mood_change *= 0.25
		timeout *= 0.2

	if(mood_change < 0)
		mood_change = ceil(mood_change * max(DESENSITIZED_MINIMUM, owner.mind?.desensitized_level || 1.0))

		if(HAS_PERSONALITY(owner, /datum/personality/compassionate))
			mood_change *= 1.5
			timeout *= 1.5

	if(gibbed || dusted)
		mood_change *= 1.2
		timeout *= 1.5

	if(!description)
		if(gibbed)
			description = "Acabou de explodir na minha frente!"
		else if(dusted)
			description = "Foi vaporizado na minha frente!"
		else
			description = "Acabei de ver a mãe morrer. Que horrível..."

	description = capitalize(replacetext(description, "DEAD MOB", get_descriptor(dead_mob)))

/// Blank proc which allows conditional effects to modify mood, timeout, or description before the main effect is applied
/datum/mood_event/conditional/see_death/proc/update_effect(mob/dead_mob, dusted, gibbed)
	return

/// Checks if the dead mob is a pet
/datum/mood_event/conditional/see_death/proc/is_pet(mob/dead_mob)
	return istype(dead_mob, /mob/living/basic/pet) || ismonkey(dead_mob)

/datum/mood_event/conditional/see_death/be_refreshed(datum/mood/home, mob/dead_mob, dusted, gibbed)
	if(can_stack_effect(dead_mob))
		mood_change *= 1.5
	return ..()

/datum/mood_event/conditional/see_death/be_replaced(datum/mood/home, datum/mood_event/new_event, mob/dead_mob, dusted, gibbed)
	. = ..()
	// when blocking a new mood event (because it's lower priority), refresh ourselves instead
	if(. == BLOCK_NEW_MOOD)
		return be_refreshed(home, dead_mob, dusted, gibbed)

/// Checks if our mood can get worse by seeing another death (or better if we're weird like that)
/datum/mood_event/conditional/see_death/proc/can_stack_effect(mob/dead_mob)
	// if we're desensitized, don't stack unless it's a buff
	if(IS_DESENSITIZED(owner) && mood_change < 0)
		return FALSE
	// if we're seeing a spawned mob die, don't stack
	if(HAS_TRAIT(dead_mob, TRAIT_SPAWNED_MOB))
		return FALSE
	return TRUE

/// Changes "I saw Joe x" to "I saw the engineer x"
/datum/mood_event/conditional/see_death/proc/get_descriptor(mob/dead_mob)
	if(is_pet(dead_mob))
		return "[dead_mob]"
	if(dead_mob.name != "Unknown" && dead_mob.mind?.assigned_role?.job_flags & JOB_CREW_MEMBER)
		return "the [LOWER_TEXT(dead_mob.mind?.assigned_role.title)]"
	return "someone"

/// Highest priority: Clown naivety about death
/datum/mood_event/conditional/see_death/naive
	priority = NAIVE_PRIORITY
	mood_change = 0

/datum/mood_event/conditional/see_death/naive/condition_fulfilled(mob/living/who, mob/dead_mob, dusted, gibbed)
	return HAS_MIND_TRAIT(who, TRAIT_NAIVE) && !dusted && !gibbed

/datum/mood_event/conditional/see_death/naive/update_effect(mob/dead_mob, dusted, gibbed)
	description = "Have a good nap, [get_descriptor(dead_mob)]."

/// Cultists are super brainwashed so they get buffs instead
/datum/mood_event/conditional/see_death/cult
	priority = CULT_PRIORITY
	description = "Mais almas para o Geômetro!"
	mood_change = parent_type::mood_change * -0.5

/datum/mood_event/conditional/see_death/cult/condition_fulfilled(mob/living/who, mob/dead_mob, dusted, gibbed)
	if(!HAS_TRAIT(who, TRAIT_CULT_HALO))
		return FALSE
	if(HAS_TRAIT(dead_mob, TRAIT_CULT_HALO))
		return FALSE
	return TRUE

/// Revs are also brainwashed but less so
/datum/mood_event/conditional/see_death/revolutionary
	priority = REVOLUTIONARY_PRIORITY
	mood_change = parent_type::mood_change * -0.5

/datum/mood_event/conditional/see_death/revolutionary/condition_fulfilled(mob/living/who, mob/dead_mob, dusted, gibbed)
	return IS_REVOLUTIONARY(who) && (dead_mob.mind?.assigned_role.job_flags & JOB_HEAD_OF_STAFF)

/datum/mood_event/conditional/see_death/revolutionary/update_effect(mob/dead_mob, dusted, gibbed)
	var/datum/job/possible_head_job = dead_mob.mind?.assigned_role
	description = "[possible_head_job.title ? "The [LOWER_TEXT(possible_head_job.title)]" : "Another head of staff"] is dead! Long live the revolution!"

/// Then gamers
/datum/mood_event/conditional/see_death/gamer
	priority = GAMER_PRIORITY
	description = "Outro morde a poeira!"
	mood_change = parent_type::mood_change * -0.5

/datum/mood_event/conditional/see_death/gamer/condition_fulfilled(mob/living/who, mob/dead_mob, dusted, gibbed)
	return istype(who.mind?.assigned_role, /datum/job/bitrunning_glitch) || istype(who.mind?.assigned_role, /datum/job/bit_avatar)

/// People who just don't gaf
/datum/mood_event/conditional/see_death/dontcare
	priority = DONTCARE_PRIORITY
	mood_change = 0
	timeout = parent_type::timeout * 0.5

/datum/mood_event/conditional/see_death/dontcare/condition_fulfilled(mob/living/who, mob/dead_mob, dusted, gibbed)
	if(HAS_PERSONALITY(who, /datum/personality/callous))
		return TRUE
	if(HAS_PERSONALITY(who, /datum/personality/animal_disliker) && is_pet(dead_mob))
		return TRUE
	return FALSE

/datum/mood_event/conditional/see_death/dontcare/update_effect(mob/dead_mob, dusted, gibbed)
	if(gibbed)
		description = "Oh, DEAD % MOB % explodiu. Agora tenho que pegar o esfregão."
	else if(dusted)
		description = "Oh, dead mob% foi vaporizado. Agora tenho que pegar a pá."
	else
		description = "A mãe morreu. Vergonha, eu acho."

/// Ashwalkers get a small boost from sacrificing people to the necropolis spire, and don't care otherwise
/datum/mood_event/conditional/see_death/ashwalker
	priority = ASHWALKER_PRIORITY
	mood_change = 0

/datum/mood_event/conditional/see_death/ashwalker/condition_fulfilled(mob/living/who, mob/dead_mob, dusted, gibbed)
	return HAS_TRAIT(who, TRAIT_NECROPOLIS_WORSHIP) && !HAS_TRAIT(dead_mob, TRAIT_NECROPOLIS_WORSHIP)

/datum/mood_event/conditional/see_death/ashwalker/update_effect(mob/dead_mob, dusted, gibbed)
	if(gibbed)
		description = "Foi arrancado, glória para a Necrópole!"
		mood_change = /datum/mood_event/conditional/see_death::mood_change * -0.5
	else if(dusted)
		description = "Oh, meu Deus!"
	else
		description = "A mãe morreu. Ssshame, eu acho."

/// Pets take priority over normal death moodlets
/datum/mood_event/conditional/see_death/pet
	priority = PET_PRIORITY

/datum/mood_event/conditional/see_death/pet/condition_fulfilled(mob/living/who, mob/dead_mob, dusted, gibbed)
	return is_pet(dead_mob)

/datum/mood_event/conditional/see_death/pet/update_effect(mob/dead_mob, dusted, gibbed)
	if(gibbed)
		description = "Acabou de explodir!"
	else if(dusted)
		description = "Acabou de vaporizar!"
	else
		description = "Acabou de morrer!"

	// future todo : make the hop care about ian, cmo runtime, etc.
	if(HAS_PERSONALITY(owner, /datum/personality/animal_friend))
		mood_change *= 1.5
		timeout *= 1.25
	else if(!HAS_PERSONALITY(owner, /datum/personality/compassionate))
		mood_change *= 0.25
		timeout *= 0.5

/// Small boost if you see a xenomorph die
/datum/mood_event/conditional/see_death/xeno
	priority = XENO_PRIORITY

/// Check if the passed mob is any kind of xenomorph (covering for both carbon and basic types)
/datum/mood_event/conditional/see_death/xeno/proc/is_any_xenomorph(mob/target)
	return isalien(target) || isalienadult(target) // latter proc should have coverage for basic mbos

/datum/mood_event/conditional/see_death/xeno/condition_fulfilled(mob/living/who, mob/dead_mob, dusted, gibbed)
	if(is_any_xenomorph(who))
		return FALSE

	if(HAS_TRAIT(who, TRAIT_XENO_HOST))
		return TRUE

	return is_any_xenomorph(dead_mob)

// Give buffs based on the type of xenomorph dying
/datum/mood_event/conditional/see_death/xeno/update_effect(mob/dead_mob, dusted, gibbed)
	// following values are in absolute value form, we make it have a positive effect later
	var/change_modifier = 0
	var/timeout_modifier = 0

	if(HAS_TRAIT(owner, TRAIT_XENO_HOST))
		handle_embryo_carrier(dead_mob)
		return

	if(islarva(dead_mob))
		change_modifier = 0.1
		timeout_modifier = 0.1
		description = "Belo dia quando as lesmas são esmagadas."

	if(isalienadult(dead_mob))
		change_modifier = 0.25
		timeout_modifier = 0.25
		description = "Aquele xenomorfo mordeu a poeira! Claro que sim!"
		if(gibbed || dusted)
			change_modifier += 0.1
			timeout_modifier += 0.1
			description = "Aquece meu coração ver xenomorfos explodirem em pedaços!"

	if(isalienroyal(dead_mob) || istype(dead_mob, /mob/living/basic/alien/queen))
		change_modifier = 0.5
		timeout_modifier = 0.5
		description = "A rainha caiu! A galáxia vive outro dia! Espero que todos esses bastardos apodreçam no inferno!"
		if(gibbed || dusted)
			change_modifier += 0.25
			timeout_modifier += 0.25
			description = "Ver a rainha xenomorfa explodida em pedaços me enche de extrema alegria!"


	mood_change = initial(mood_change) * -change_modifier
	timeout = initial(timeout) * timeout_modifier

/// Separate proc that handles cases where the viewer is carrying a xenomorph embryo
/datum/mood_event/conditional/see_death/xeno/proc/handle_embryo_carrier(mob/dead_mob)
	if(!HAS_TRAIT(owner, TRAIT_XENO_HOST))
		return

	var/obj/item/organ/body_egg/alien_embryo/embryo = owner.get_organ_by_type(/obj/item/organ/body_egg/alien_embryo)
	if(isnull(embryo))
		stack_trace("Xeno Host [owner] missing embryo organ despite having XENO_HOST trait. What the fuck?")
		return

	if(owner.stat != CONSCIOUS) // if the carrier is sleeping then presumably the embryo's hivemind isn't affected
		return

	// You feel a lot worse if you're conscious and see a xenomorph die while implanted because the hivemind feels the loss of their sister
	var/embryo_stage_multiplier = 1 + (embryo.stage / 10)
	mood_change *= embryo_stage_multiplier
	timeout *= embryo_stage_multiplier
	description = "Tem algo dentro de mim mexendo depois que vi o xenomorfo morrer."
	RegisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_XENO_HOST), PROC_REF(on_embryo_removal))

/// Handles cleanup once the embryo carrier dies
/datum/mood_event/conditional/see_death/xeno/proc/on_embryo_removal(datum/source)
	SIGNAL_HANDLER
	qdel(src)

/// Desensitized brings up the rear
/datum/mood_event/conditional/see_death/desensitized
	priority = DESENSITIZED_PRIORITY
	timeout = parent_type::timeout * 0.5

/datum/mood_event/conditional/see_death/desensitized/condition_fulfilled(mob/living/who, mob/dead_mob, dusted, gibbed)
	return IS_DESENSITIZED(who)

/datum/mood_event/conditional/see_death/desensitized/update_effect(mob/dead_mob, dusted, gibbed)
	if(gibbed)
		description = "Eu vi o DEAD MOB explodir."
	else if(dusted)
		description = "Eu vi o DEAD MOB% ser vaporizado."
	else
		description = "Eu vi a mãe morrer."


#undef DESENSITIZED_PRIORITY
#undef PET_PRIORITY
#undef XENO_PRIORITY
#undef DONTCARE_PRIORITY
#undef ASHWALKER_PRIORITY
#undef GAMER_PRIORITY
#undef REVOLUTIONARY_PRIORITY
#undef CULT_PRIORITY
#undef NAIVE_PRIORITY
