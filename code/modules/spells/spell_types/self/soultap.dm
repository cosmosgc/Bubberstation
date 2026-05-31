
/**
 * SOUL TAP!
 *
 * Trades 20 max health for a refresh on all of your spells.
 * I was considering making it depend on the cooldowns of your spells, but I want to support "Big spell wizard" with this loadout.
 * The two spells that sound most problematic with this is mindswap and lichdom,
 * but soul tap requires clothes for mindswap and lichdom takes your soul.
 */
/datum/action/cooldown/spell/tap
	name = "Soul Tap"
	desc = "Alimente seus feitiços usando sua própria alma!"
	button_icon_state = "soultap"

	// I could see why this wouldn't be necromancy, but messing with souls or whatever. Ectomancy?
	school = SCHOOL_NECROMANCY
	cooldown_time = 1 SECONDS
	invocation = "AT ANY COST!"
	invocation_type = INVOCATION_SHOUT
	spell_max_level = 1

	/// The amount of health we take on tap
	var/tap_health_taken = 20

/datum/action/cooldown/spell/tap/can_cast_spell(feedback = TRUE)
	. = ..()
	if(!.)
		return FALSE

	// We call this here so we can get feedback if they try to cast it when they shouldn't.
	if(!is_valid_target(owner))
		if(feedback)
			to_chat(owner, span_warning("Você não tem alma para entrar!"))
		return FALSE

	return TRUE

/datum/action/cooldown/spell/tap/is_valid_target(atom/cast_on)
	return isliving(cast_on) && !HAS_TRAIT(cast_on, TRAIT_NO_SOUL)

/datum/action/cooldown/spell/tap/cast(mob/living/cast_on)
	. = ..()
	cast_on.maxHealth -= tap_health_taken
	cast_on.health = min(cast_on.health, cast_on.maxHealth)

	for(var/datum/action/cooldown/spell/spell in cast_on.actions)
		spell.reset_spell_cooldown()

	// If the tap took all of our life, we die and lose our soul!
	if(cast_on.maxHealth <= 0)
		to_chat(cast_on, span_userdanger("Sua alma enfraquecida é completamente consumida pela torneira!"))
		ADD_TRAIT(cast_on, TRAIT_NO_SOUL, MAGIC_TRAIT)

		cast_on.visible_message(span_danger("[cast_on]De repente morre!"), ignored_mobs = cast_on)
		cast_on.investigate_log("has been killed by soul tap.", INVESTIGATE_DEATHS)
		cast_on.death()

	// If the next tap will kill us, give us a heads-up
	else if(cast_on.maxHealth - tap_health_taken <= 0)
		to_chat(cast_on, span_bolddanger("Seu corpo se sente incrivelmente drenado, e a queima é difícil de ignorar!"))

	// Otherwise just give them some feedback
	else
		to_chat(cast_on, span_danger("Seu corpo se sente drenado e há uma dor ardente em seu peito."))
