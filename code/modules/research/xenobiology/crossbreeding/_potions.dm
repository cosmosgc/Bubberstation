/*
Slimecrossing Potions
	Potions added by the slimecrossing system.
	Collected here for clarity.
*/

//Extract cloner - Charged Grey
/obj/item/slimepotion/extract_cloner
	name = "extract cloning potion"
	desc = "Uma versão mais poderosa da poção de potenciador de extrato, capaz de clonar extratos regulares de lodo."
	icon_state = "potgold"

/obj/item/slimepotion/extract_cloner/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(istype(interacting_with, /obj/item/slimecross))
		to_chat(user, span_warning("[interacting_with] is too complex for the potion to clone!"))
		return ITEM_INTERACT_BLOCKING
	if(!istype(interacting_with, /obj/item/slime_extract))
		return ITEM_INTERACT_BLOCKING
	var/obj/item/slime_extract/S = interacting_with
	if(S.recurring)
		to_chat(user, span_warning("[interacting_with] is too complex for the potion to clone!"))
		return ITEM_INTERACT_BLOCKING
	var/path = S.type
	var/obj/item/slime_extract/C = new path(get_turf(interacting_with))
	C.extract_uses = S.extract_uses
	to_chat(user, span_notice("You pour the potion onto [interacting_with], and the fluid solidifies into a copy of it!"))
	qdel(src)
	return ITEM_INTERACT_SUCCESS

//Peace potion - Charged Light Pink
/obj/item/slimepotion/peacepotion
	name = "pacification potion"
	desc = "Uma solução rosa leve de produtos químicos, cheirando a paz líquida. E sais de mercúrio."
	icon_state = "potlightpink"

/obj/item/slimepotion/peacepotion/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	var/mob/living/peace_target = interacting_with
	if(!isliving(peace_target) || peace_target.stat == DEAD)
		to_chat(user, span_warning("[src] only works on the living."))
		return ITEM_INTERACT_BLOCKING
	if(ismegafauna(peace_target))
		to_chat(user, span_warning("[src] does not work on beings of pure evil!"))
		return ITEM_INTERACT_BLOCKING
	if(peace_target != user)
		peace_target.visible_message(span_danger("[user] starts to feed [peace_target] [src]!"),
			span_userdanger("[user] starts to feed you [src]!"))
	else
		peace_target.visible_message(span_danger("[user] starts to drink [src]!"),
			span_danger("You start to drink [src]!"))

	if(!do_after(user, 10 SECONDS, target = peace_target))
		return ITEM_INTERACT_BLOCKING
	if(peace_target != user)
		to_chat(user, span_notice("You feed [peace_target] [src]!"))
	else
		to_chat(user, span_warning("You drink [src]!"))
	if(isanimal_or_basicmob(peace_target))
		ADD_TRAIT(peace_target, TRAIT_PACIFISM, MAGIC_TRAIT)
	else if(iscarbon(peace_target))
		var/mob/living/carbon/peaceful_carbon = peace_target
		peaceful_carbon.gain_trauma(/datum/brain_trauma/severe/pacifism, TRAUMA_RESILIENCE_SURGERY)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

//Love potion - Charged Pink
/obj/item/slimepotion/lovepotion
	name = "love potion"
	desc = "Uma mistura química rosa pensada para inspirar sentimentos de amor."
	icon_state = "potpink"

/obj/item/slimepotion/lovepotion/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	var/mob/living/love_target = interacting_with
	if(!isliving(love_target) || love_target.stat == DEAD)
		to_chat(user, span_warning("A poção do amor só funciona em coisas vivas, doente!"))
		return ITEM_INTERACT_BLOCKING
	if(ismegafauna(love_target))
		to_chat(user, span_warning("A poção do amor não funciona em seres de puro mal!"))
		return ITEM_INTERACT_BLOCKING
	if(user == love_target)
		to_chat(user, span_warning("Não pode beber a poção do amor. Você é narcisista?"))
		return ITEM_INTERACT_BLOCKING
	if(love_target.has_status_effect(/datum/status_effect/in_love))
		to_chat(user, span_warning("[love_target] is already lovestruck!"))
		return ITEM_INTERACT_BLOCKING

	love_target.visible_message(span_danger("[user] starts to feed [love_target] a love potion!"),
		span_userdanger("[user] starts to feed you a love potion!"))

	if(!do_after(user, 5 SECONDS, target = love_target))
		return ITEM_INTERACT_BLOCKING
	to_chat(user, span_notice("You feed [love_target] the love potion!"))
	to_chat(love_target, span_notice("You develop feelings for [user], and anyone [user.p_they()] like[user.p_s()]."))
	love_target.add_ally(user)
	love_target.apply_status_effect(/datum/status_effect/in_love, user)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

//Pressure potion - Charged Dark Blue
/obj/item/slimepotion/spaceproof
	name = "slime pressurization potion"
	desc = "Um potente selante químico que tornará qualquer peça de roupa hermética. Tem duas utilidades."
	icon_state = "potblack"
	var/uses = 2

/obj/item/slimepotion/spaceproof/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(uses <= 0)
		qdel(src)
		return ITEM_INTERACT_BLOCKING
	var/obj/item/clothing/clothing = interacting_with
	if(!istype(clothing))
		to_chat(user, span_warning("A poção só pode ser usada em roupas!"))
		return ITEM_INTERACT_BLOCKING
	if(istype(clothing, /obj/item/clothing/suit/space))
		to_chat(user, span_warning("The [interacting_with] is already pressure-resistant!"))
		return ITEM_INTERACT_BLOCKING
	if(clothing.min_cold_protection_temperature == SPACE_SUIT_MIN_TEMP_PROTECT && (clothing.clothing_flags & STOPSPRESSUREDAMAGE))
		to_chat(user, span_warning("The [interacting_with] is already pressure-resistant!"))
		return ITEM_INTERACT_BLOCKING
	to_chat(user, span_notice("You slather the blue gunk over the [clothing], making it airtight."))
	clothing.name = "pressure-resistant [clothing.name]"
	clothing.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	clothing.add_atom_colour(color_transition_filter(COLOR_NAVY, SATURATION_OVERRIDE), FIXED_COLOUR_PRIORITY)
	clothing.min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	clothing.cold_protection = clothing.body_parts_covered
	clothing.clothing_flags |= STOPSPRESSUREDAMAGE
	uses--
	if(uses <= 0)
		qdel(src)
	return ITEM_INTERACT_SUCCESS

//Enhancer potion - Charged Cerulean
/obj/item/slimepotion/enhancer/max
	name = "extract maximizer"
	desc = "Uma mistura química extremamente potente que maximiza os usos de um extrato de lodo."
	icon_state = "potcerulean"

//Lavaproofing potion - Charged Red
/obj/item/slimepotion/lavaproof
	name = "slime lavaproofing potion"
	desc = "Um goo estranho e avermelhado disse para repelir lava como se fosse água, sem reduzir a inflamabilidade. Tem duas utilidades."
	icon_state = "potyellow"
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	var/uses = 2

/obj/item/slimepotion/lavaproof/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(uses <= 0)
		qdel(src)
		return ITEM_INTERACT_BLOCKING
	if(!isitem(interacting_with))
		to_chat(user, span_warning("Você não pode cobrir isso com fluido de lavagem!"))
		return ITEM_INTERACT_BLOCKING

	var/obj/item/clothing = interacting_with
	to_chat(user, span_notice("You slather the red gunk over the [clothing], making it lavaproof."))
	clothing.name = "lavaproof [clothing.name]"
	clothing.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	clothing.add_atom_colour(color_transition_filter(COLOR_MAROON, SATURATION_OVERRIDE), FIXED_COLOUR_PRIORITY)
	clothing.resistance_flags |= LAVA_PROOF
	if (isclothing(clothing))
		var/obj/item/clothing/clothing_real = clothing
		clothing_real.clothing_flags |= LAVAPROTECT
		clothing_real.resistance_flags |= FIRE_PROOF
	uses--
	if(uses <= 0)
		qdel(src)
	return ITEM_INTERACT_SUCCESS

//Revival potion - Charged Grey
/obj/item/slimepotion/slime_reviver
	name = "slime revival potion"
	desc = "Infundido com plasma e gel comprimido, isso traz lodo morto de volta à vida."
	icon_state = "potgrey"

/obj/item/slimepotion/slime_reviver/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	var/mob/living/basic/slime/revive_target = interacting_with
	if(!isslime(revive_target))
		to_chat(user, span_warning("A poção só funciona em lodo!"))
		return ITEM_INTERACT_BLOCKING
	if(revive_target.stat != DEAD)
		to_chat(user, span_warning("O lodo ainda está vivo!"))
		return ITEM_INTERACT_BLOCKING
	if(revive_target.maxHealth <= 0)
		to_chat(user, span_warning("O lodo é muito instável para voltar!"))
		return ITEM_INTERACT_BLOCKING
	user.do_attack_animation(interacting_with)
	revive_target.revive(HEAL_ALL)
	revive_target.set_stat(CONSCIOUS)
	revive_target.visible_message(span_notice("[revive_target] is filled with renewed vigor and blinks awake!"))
	revive_target.maxHealth -= 10 //Revival isn't healthy.
	revive_target.health -= 10
	revive_target.regenerate_icons()
	qdel(src)
	return ITEM_INTERACT_SUCCESS

//Stabilizer potion - Charged Blue
/obj/item/slimepotion/slime/chargedstabilizer
	name = "slime omnistabilizer"
	desc = "Uma mistura química extremamente potente que impedirá um lodo de sofrer uma mutação completa."
	icon_state = "potcyan"

/obj/item/slimepotion/slime/chargedstabilizer/interact_with_slime(mob/living/basic/slime/interacting_slime, mob/living/user, list/modifiers)
	if(interacting_slime.stat)
		to_chat(user, span_warning("O lodo está morto!"))
		return ITEM_INTERACT_BLOCKING
	if(interacting_slime.mutation_chance == 0)
		to_chat(user, span_warning("O lodo já não tem chance de sofrer mutação!"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("Você alimenta o lodo, o onistabilizador. Não vai mudar este ciclo!"))
	interacting_slime.mutation_chance = 0
	qdel(src)
	return ITEM_INTERACT_SUCCESS
