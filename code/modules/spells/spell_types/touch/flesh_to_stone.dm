/datum/action/cooldown/spell/touch/flesh_to_stone
	name = "Flesh to Stone"
	desc = "Este feitiço carrega sua mão com o poder de transformar vítimas em estátuas inertes por um longo período de tempo."
	button_icon_state = "statue"
	sound = 'sound/effects/magic/fleshtostone.ogg'

	school = SCHOOL_TRANSMUTATION
	cooldown_time = 1 MINUTES
	cooldown_reduction_per_rank = 10 SECONDS

	invocation = "STAUN EI!!"

	hand_path = /obj/item/melee/touch_attack/flesh_to_stone

/datum/action/cooldown/spell/touch/flesh_to_stone/on_antimagic_triggered(obj/item/melee/touch_attack/hand, mob/living/victim, mob/living/carbon/caster)
	to_chat(caster, span_warning("The spell can't seem to affect [victim]!"))
	to_chat(victim, span_warning("Você sente sua carne virar pedra por um momento, e então volta atrás!"))

/datum/action/cooldown/spell/touch/flesh_to_stone/cast_on_hand_hit(obj/item/melee/touch_attack/hand, mob/living/victim, mob/living/carbon/caster)
	var/mob/living/living_victim = victim
	if(living_victim.can_block_magic(antimagic_flags))
		return TRUE

	living_victim.Stun(4 SECONDS)
	living_victim.petrify()
	return TRUE

/obj/item/melee/touch_attack/flesh_to_stone
	name = "\improper petrifying touch"
	desc = "Essa é a linha de fundo, porque carne para pedra disse isso!"
	icon = 'icons/obj/weapons/hand.dmi'
	icon_state = "fleshtostone"
	inhand_icon_state = "fleshtostone"
