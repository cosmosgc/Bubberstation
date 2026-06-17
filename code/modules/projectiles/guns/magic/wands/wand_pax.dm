/**
 * Pax wand is a minor heal which applies temporary pacifism, gives you time to talk it out?
 */
/obj/item/gun/magic/wand/pax
	name = "rod of compassion"
	desc = "Uma varinha que liga sobrenaturalmente vítima e alvo, o que torna ambos incapazes de lutar e os faz sentir um pouco melhor."
	school = SCHOOL_RESTORATION
	ammo_type = /obj/item/ammo_casing/magic/pax
	icon_state = "peacewand"
	base_icon_state = "peacewand"
	fire_sound = 'sound/effects/emotes/kiss.ogg'
	max_charges = 12

/obj/item/gun/magic/wand/pax/fire_gun(atom/target, mob/living/user, flag, params)
	. = ..()
	if (!.)
		return
	user.apply_status_effect(/datum/status_effect/pacify/visible, 30 SECONDS) // Don't miss!
	user.adjust_brute_loss(-30)

/obj/item/gun/magic/wand/pax/zap_self(mob/living/user, suicide = FALSE)
	if (!suicide)
		user.visible_message(span_notice("[user] tenderly kisses [user.p_their()] own wand."))

/obj/item/gun/magic/wand/pax/do_suicide(mob/living/user)
	. = ..()
	user.visible_message(span_suicide("...but [user] can't bring [user.p_themselves()] to hurt anyone!"))
	return SHAME

/obj/item/ammo_casing/magic/pax
	projectile_type = /obj/projectile/magic/pax
	harmful = FALSE

/obj/projectile/magic/pax
	name = "bolt of compassion"
	icon = 'icons/mob/simple/animal.dmi'
	icon_state = "heart"

/obj/projectile/magic/pax/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	var/mob/living/victim = target
	if (!istype(victim))
		return

	victim.apply_status_effect(/datum/status_effect/pacify/visible, 30 SECONDS)
	victim.adjust_brute_loss(-30)

// Default pacify status effect has no screen alert but I think this should have one
/datum/status_effect/pacify/visible
	alert_type = /atom/movable/screen/alert/status_effect/pacified

/datum/status_effect/pacify/visible/on_apply()
	if (!HAS_TRAIT(owner, TRAIT_PACIFISM))
		owner.visible_message(span_notice("[owner] seems to relax."), span_notice("Você sente seus músculos afrouxando e sua vontade de lutar derretendo."))
	return ..()

/datum/status_effect/pacify/visible/on_remove()
	. = ..()
	// Might have it from somewhere else
	if (HAS_TRAIT(owner, TRAIT_PACIFISM))
		return
	owner.visible_message(span_warning("[owner] suddenly tenses up."), span_notice("Você se lembra que violência é uma opção."))

/atom/movable/screen/alert/status_effect/pacified
	name = "Pacified"
	desc = "Você se acha temporariamente incapaz de violência."
	icon_state = "in_love"
