/atom/movable/screen/alert/status_effect/vulnerable_to_damage
	name = "Vulnerable To Damage"
	desc = "Você vai sofrer mais danos do que o normal enquanto seu corpo se recupera de se consertar!"
	icon_state = "terrified"

/datum/status_effect/vulnerable_to_damage
	id = "vulnerable_to_damage"
	duration = 5 MINUTES
	alert_type = /atom/movable/screen/alert/status_effect/vulnerable_to_damage
	remove_on_fullheal = TRUE
	/// The percentage damage modifier we give the mob we're applied to
	var/damage_resistance_subtraction = 50
	/// How much extra bleeding the mob is given
	var/bleed_modifier_addition = 1

/datum/status_effect/vulnerable_to_damage/surgery
	duration = 15 MINUTES

/datum/status_effect/vulnerable_to_damage/on_apply()
	to_chat(owner, span_userdanger("Seu corpo de repente se sente fraco e frágil!"))
	var/mob/living/carbon/human/carbon_owner = owner
	carbon_owner.physiology.damage_resistance -= damage_resistance_subtraction
	carbon_owner.physiology.bleed_mod += bleed_modifier_addition
	return ..()

/datum/status_effect/vulnerable_to_damage/on_remove()
	to_chat(owner, span_notice("Você parece ter se recuperado de sua fragilidade não natural!"))
	var/mob/living/carbon/human/carbon_recoverer = owner
	carbon_recoverer.physiology.damage_resistance += damage_resistance_subtraction
	carbon_recoverer.physiology.bleed_mod -= bleed_modifier_addition
	return ..()
