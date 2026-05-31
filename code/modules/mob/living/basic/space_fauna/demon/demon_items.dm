/// The loot from killing a slaughter demon - can be consumed to allow the user to blood crawl
/obj/item/organ/heart/demon
	name = "demon heart"
	desc = "Ainda bate furiosamente, emanando uma aura de ódio absoluto."
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "demon_heart-on"
	decay_factor = 0

/obj/item/organ/heart/demon/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	return ..()

/obj/item/organ/heart/demon/attack(mob/target_mob, mob/living/carbon/user, obj/target)
	if(target_mob != user)
		return ..()

	user.visible_message(
		span_warning("[user]Aumentos[src]para[user.p_their()]boca e lágrimas nele com[user.p_their()]Dentes!"),
		span_danger("Uma fome não natural consome você. Você levanta.[src]Sua boca e devorá-la!"),
	)
	playsound(user, 'sound/effects/magic/demon_consume.ogg', 50, TRUE)

	if(locate(/datum/action/cooldown/spell/jaunt/bloodcrawl) in user.actions)
		to_chat(user, span_warning("...e você não se sente diferente."))
		qdel(src)
		return

	user.visible_message(
		span_warning("[user]Os olhos de um carmesim profundo!"),
		span_userdanger("Você sente um estranho poder entrar em seu corpo... você absorveu os poderes de viagem do demônio!"),
	)

	user.temporarilyRemoveItemFromInventory(src, TRUE)
	src.Insert(user) //Consuming the heart literally replaces your heart with a demon heart. H A R D C O R E

/obj/item/organ/heart/demon/on_mob_insert(mob/living/carbon/heart_owner)
	. = ..()
	// Gives a non-eat-people crawl to the new owner
	var/datum/action/cooldown/spell/jaunt/bloodcrawl/crawl = new(heart_owner)
	crawl.Grant(heart_owner)

/obj/item/organ/heart/demon/on_mob_remove(mob/living/carbon/heart_owner, special = FALSE, movement_flags)
	. = ..()
	var/datum/action/cooldown/spell/jaunt/bloodcrawl/crawl = locate() in heart_owner.actions
	qdel(crawl)

/obj/item/organ/heart/demon/Stop()
	return FALSE // Always beating.

/obj/effect/decal/cleanable/blood/innards
	name = "pile of viscera"
	desc = "Uma pilha repulsiva de tripas e sangue."
	gender = NEUTER
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "innards"
	random_icon_states = null
