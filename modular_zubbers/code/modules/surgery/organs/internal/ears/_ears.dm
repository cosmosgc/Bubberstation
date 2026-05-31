//Copy and paste of monkey's super kitty ears
/obj/item/organ/ears/cat/super
	name = "Super Kitty Ears"
	desc = "Um par de orelhas de gatinho que colhem a verdadeira energia dos gatos. Srow!"
	icon = 'modular_zubbers/icons/obj/clothing/head/costume.dmi'
	icon_state = "superkitty"
	decay_factor = 0
	damage_multiplier = 0.5 // SUPER
	organ_flags = ORGAN_HIDDEN
	/// The instance of kitty form spell given to the user.
	/// The spell will be initialized using the initial typepath.
	var/datum/action/cooldown/spell/shapeshift/kitty/kitty_spell = /datum/action/cooldown/spell/shapeshift/kitty

/obj/item/organ/ears/cat/super/Initialize(mapload)
	if(ispath(kitty_spell))
		kitty_spell = new kitty_spell(src)
	else
		stack_trace("kitty_spell is invalid typepath ([kitty_spell || "null"])")
	return ..()

/obj/item/organ/ears/cat/super/Destroy()
	QDEL_NULL(kitty_spell)
	return ..()

/obj/item/organ/ears/cat/super/attack(mob/target_mob, mob/living/carbon/user, obj/target)
	if(target_mob != user || !implant_on_use(user))
		return ..()

/obj/item/organ/ears/cat/super/attack_self(mob/user, modifiers)
	implant_on_use(user)
	return ..()

/obj/item/organ/ears/cat/super/on_mob_insert(mob/living/carbon/ear_owner)
	. = ..()
	kitty_spell.Grant(ear_owner)

/obj/item/organ/ears/cat/super/on_mob_remove(mob/living/carbon/ear_owner, special = FALSE)
	. = ..()
	kitty_spell.Remove(ear_owner)

// Stole this from demon heart hard, but hey it works
/obj/item/organ/ears/cat/super/proc/implant_on_use(mob/living/carbon/user)
	if(!iscarbon(user) || !user.is_holding(src))
		return FALSE
	user.visible_message(
		span_warning("[user]Aumentos\the [src]para[user.p_their()]cabeça e gentilmente coloca em[user.p_their()]Cabeça!"),
		span_danger("Um estranho felino vem sobre você. Seu lugar.\the [src]Na sua cabeça!"),
	)
	playsound(user, 'sound/effects/meow1.ogg', 50, TRUE)

	user.visible_message(
		span_warning("\The [src]Derreter em[user]A cabeça!"),
		span_userdanger("Tudo é muito mais alto!"),
	)

	user.temporarilyRemoveItemFromInventory(src, force = TRUE)
	Insert(user)
	return TRUE

// Super syndi kitty ears!
/obj/item/organ/ears/cat/super/syndie
	kitty_spell = /datum/action/cooldown/spell/shapeshift/kitty/syndie
