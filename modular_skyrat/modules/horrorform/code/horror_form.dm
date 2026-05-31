/datum/action/changeling/horror_form //Horror Form: turns the changeling into a terrifying abomination
	name = "Horror Form"
	desc = "Rasgamos nosso disfarce humano, revelando nossa verdadeira forma."
	helptext = "We will become an unstoppable force of destruction. If we die in this form, we will reach equilibrium and explode into a shower of gore! We require the absorption of at least one other human, and 15 extracts of DNA."
	button_icon = 'modular_skyrat/modules/horrorform/icons/actions_changeling.dmi'
	button_icon_state = "horror_form"
	background_icon_state = "bg_changeling"

	chemical_cost = 50
	dna_cost = 4 //Tier 4
	req_dna = 15
	req_absorbs = 1
	req_human = TRUE
	req_stat = UNCONSCIOUS

/datum/action/changeling/horror_form/sting_action(mob/living/carbon/human/user)
	..()
	if(!user || HAS_TRAIT(user, TRAIT_NO_TRANSFORM))
		return FALSE

	user.visible_message(
		span_warning("[user]contorce e contorce, seu corpo se expandindo para proporções desumanas!"), 		span_danger("Começamos nossa transformação em nossa verdadeira forma!")
	)

	if(!do_after(user, 3 SECONDS, target = user, timed_action_flags = IGNORE_HELD_ITEM))
		user.visible_message(
			span_warning("[user]A transformação se reverte abruptamente!"), 			span_warning("Nossa transformação foi interrompida!")
		)
		return FALSE

	user.visible_message(
		span_warning("[user]Cresce em uma abominação e deixa sair um grito terrível!"), 		span_userdanger("Tiramos nossa concha e entramos em nossa verdadeira forma!")
	)

	if(user.handcuffed)
		qdel(user.get_item_by_slot(ITEM_SLOT_HANDCUFFED))
	if(user.legcuffed)
		qdel(user.get_item_by_slot(ITEM_SLOT_LEGCUFFED))
	if(user.wear_suit?.breakouttime)
		qdel(user.get_item_by_slot(ITEM_SLOT_OCLOTHING))

	if(istype(user.loc, /obj/structure/closet))
		var/obj/structure/closet/closet = user.loc
		closet.visible_message(span_warning("[closet]A porta abre!"))
		new /obj/effect/decal/cleanable/greenglow(closet.drop_location())
		closet.welded = FALSE
		closet.locked = FALSE
		closet.broken = TRUE
		closet.open()

	var/mob/living/simple_animal/hostile/true_changeling/new_mob = new(get_turf(user))

	//Currently this is a thing as changeling ID's are not longer a thing
	//Feel free to re-add them whomever wants to -Azarak
	var/changeling_name
	if(user.gender == FEMALE)
		changeling_name = "Ms. "
	else if(user.gender == MALE)
		changeling_name = "Mr. "
	else
		changeling_name = "Mx. "
	changeling_name += pick(GLOB.greek_letters)

	new_mob.real_name = changeling_name
	new_mob.name = new_mob.real_name
	new_mob.stored_changeling = user

	user.loc = new_mob
	ADD_TRAIT(user, TRAIT_GODMODE, INNATE_TRAIT)
	user.mind.transfer_to(new_mob)
	user.spawn_gibs()

	qdel(src)

	return TRUE
