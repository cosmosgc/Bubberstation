/*
Regenerative extracts:
	Work like a legion regenerative core.
	Has a unique additional effect.
*/
/obj/item/slimecross/regenerative
	name = "regenerative extract"
	desc = "Está cheio de uma substância leitosa, e pulsa como um batimento cardíaco."
	effect = "regenerative"
	icon_state = "regenerative"
	effect_desc = "Cura completamente seus ferimentos, sem efeitos extras."

/obj/item/slimecross/regenerative/proc/core_effect(mob/living/carbon/human/target, mob/user)
	return
/obj/item/slimecross/regenerative/proc/core_effect_before(mob/living/carbon/human/target, mob/user)
	return

/obj/item/slimecross/regenerative/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return
	var/mob/living/H = interacting_with
	if(H.stat == DEAD)
		to_chat(user, span_warning("[src] will not work on the dead!"))
		return ITEM_INTERACT_BLOCKING
	if(H != user)
		user.visible_message(span_notice("[user] crushes [src] over [H], the milky goo quickly regenerating all of [H.p_their()] injuries!"),
			span_notice("You squeeze [src], and it bursts over [H], the milky goo regenerating [H.p_their()] injuries."))
	else
		user.visible_message(span_notice("[user] crushes [src] over [user.p_them()]self, the milky goo quickly regenerating all of [user.p_their()] injuries!"),
			span_notice("You squeeze [src], and it bursts in your hand, splashing you with milky goo which quickly regenerates your injuries!"))
	core_effect_before(H, user)
	user.do_attack_animation(interacting_with)
	H.revive(HEAL_ALL & ~HEAL_REFRESH_ORGANS)
	core_effect(H, user)
	playsound(H, 'sound/effects/splat.ogg', 40, TRUE)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/slimecross/regenerative/grey
	colour = SLIME_TYPE_GREY //Has no bonus effect.
	effect_desc = "Cura completamente o alvo e não faz mais nada."

/obj/item/slimecross/regenerative/orange
	colour = SLIME_TYPE_ORANGE

/obj/item/slimecross/regenerative/orange/core_effect_before(mob/living/target, mob/user)
	target.visible_message(span_warning("The [src] boils over!"))
	for(var/turf/targetturf in RANGE_TURFS(1,target))
		if(!locate(/obj/effect/hotspot) in targetturf)
			new /obj/effect/hotspot(targetturf)

/obj/item/slimecross/regenerative/purple
	colour = SLIME_TYPE_PURPLE
	effect_desc = "Cura o alvo e injeta geléia regen."

/obj/item/slimecross/regenerative/purple/core_effect(mob/living/target, mob/user)
	target.reagents.add_reagent(/datum/reagent/medicine/regen_jelly,10)

/obj/item/slimecross/regenerative/blue
	colour = SLIME_TYPE_BLUE
	effect_desc = "Cura completamente o alvo e molha o chão."

/obj/item/slimecross/regenerative/blue/core_effect(mob/living/target, mob/user)
	if(isturf(target.loc))
		var/turf/open/T = get_turf(target)
		T.MakeSlippery(TURF_WET_WATER, min_wet_time = 10, wet_time_to_add = 5)
		target.visible_message(span_warning("A gosma leitosa no extrato fica por todo o chão!"))

/obj/item/slimecross/regenerative/metal
	colour = SLIME_TYPE_METAL
	effect_desc = "Cura completamente o alvo e encerra o alvo em um armário."

/obj/item/slimecross/regenerative/metal/core_effect(mob/living/target, mob/user)
	target.visible_message(span_warning("The milky goo hardens and reshapes itself, encasing [target]!"))
	var/obj/structure/closet/C = new /obj/structure/closet(target.loc)
	C.name = "slimy closet"
	C.desc = "Looking closer, it seems to be made of a sort of solid, opaque, metal-like goo."
	if(target.mob_size > C.max_mob_size) //Prevents capturing megafauna or other large mobs in the closets
		C.bust_open()
		C.visible_message(span_warning("[target] is too big, and immediately breaks \the [C.name] open!"))
	else //This can't be allowed to actually happen to the too-big mobs or it breaks some actions
		target.forceMove(C)

/obj/item/slimecross/regenerative/yellow
	colour = SLIME_TYPE_YELLOW
	effect_desc = "Cura completamente o alvo e recarrega um único item no alvo."

/obj/item/slimecross/regenerative/yellow/core_effect(mob/living/target, mob/user)
	var/list/batteries = list()
	for(var/obj/item/stock_parts/power_store/cell in assoc_to_values(target.get_all_cells()))
		if(cell.charge < cell.maxcharge)
			batteries += cell
	if(batteries.len)
		var/obj/item/stock_parts/power_store/ToCharge = pick(batteries)
		ToCharge.charge = ToCharge.maxcharge
		to_chat(target, span_notice("Você sente um pulso elétrico estranho, e um de seus itens elétricos foi recarregado."))

/obj/item/slimecross/regenerative/darkpurple
	colour = SLIME_TYPE_DARK_PURPLE
	effect_desc = "Cura completamente o alvo e lhes dá roupas roxas se estiverem nuas."

/obj/item/slimecross/regenerative/darkpurple/core_effect(mob/living/target, mob/user)
	var/equipped = 0
	equipped += target.equip_to_slot_or_del(new /obj/item/clothing/shoes/sneakers/purple(null), ITEM_SLOT_FEET)
	equipped += target.equip_to_slot_or_del(new /obj/item/clothing/under/color/lightpurple(null), ITEM_SLOT_ICLOTHING)
	equipped += target.equip_to_slot_or_del(new /obj/item/clothing/gloves/color/purple(null), ITEM_SLOT_GLOVES)
	equipped += target.equip_to_slot_or_del(new /obj/item/clothing/head/soft/purple(null), ITEM_SLOT_HEAD)
	if(equipped > 0)
		target.visible_message(span_notice("A gosma leitosa se veste!"))

/obj/item/slimecross/regenerative/darkblue
	colour = SLIME_TYPE_DARK_BLUE
	effect_desc = "Cura completamente o alvo e protege suas roupas."

/obj/item/slimecross/regenerative/darkblue/core_effect(mob/living/target, mob/user)
	if(!ishuman(target))
		return
	var/mob/living/carbon/human/H = target
	var/fireproofed = FALSE
	if(H.get_item_by_slot(ITEM_SLOT_OCLOTHING))
		fireproofed = TRUE
		var/obj/item/clothing/C = H.get_item_by_slot(ITEM_SLOT_OCLOTHING)
		fireproof(C)
	if(H.get_item_by_slot(ITEM_SLOT_HEAD))
		fireproofed = TRUE
		var/obj/item/clothing/C = H.get_item_by_slot(ITEM_SLOT_HEAD)
		fireproof(C)
	if(fireproofed)
		target.visible_message(span_notice("Some of [target]'s clothing gets coated in the goo, and turns blue!"))

/obj/item/slimecross/regenerative/darkblue/proc/fireproof(obj/item/clothing/clothing_piece)
	clothing_piece.name = "fireproofed [clothing_piece.name]"
	clothing_piece.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	clothing_piece.add_atom_colour(color_transition_filter(COLOR_NAVY, SATURATION_OVERRIDE), FIXED_COLOUR_PRIORITY)
	clothing_piece.max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	clothing_piece.heat_protection = clothing_piece.body_parts_covered
	clothing_piece.resistance_flags |= FIRE_PROOF

/obj/item/slimecross/regenerative/silver
	colour = SLIME_TYPE_SILVER
	effect_desc = "Cura completamente o alvo e faz sua barriga se sentir redonda e cheia."

/obj/item/slimecross/regenerative/silver/core_effect(mob/living/target, mob/user)
	target.set_nutrition(NUTRITION_LEVEL_FULL - 1)
	to_chat(target, span_notice("Você se sente saciado."))

/obj/item/slimecross/regenerative/bluespace
	colour = SLIME_TYPE_BLUESPACE
	effect_desc = "Cura completamente o alvo e os teleporta para onde esse núcleo foi criado."
	var/turf/open/T

/obj/item/slimecross/regenerative/bluespace/core_effect(mob/living/target, mob/user)
	var/turf/old_location = get_turf(target)
	if(do_teleport(target, T, channel = TELEPORT_CHANNEL_QUANTUM)) //despite being named a bluespace teleportation method the quantum channel is used to preserve precision teleporting with a bag of holding
		old_location.visible_message(span_warning("[target] disappears in a shower of sparks!"))
		to_chat(target, span_danger("O goo leitoso te teletransporta para algum lugar que se lembre!"))

	if(HAS_TRAIT(target, TRAIT_NO_TELEPORT))
		old_location.visible_message(span_warning("[target] sparks briefly, but is prevented from teleporting!"))

/obj/item/slimecross/regenerative/bluespace/Initialize(mapload)
	. = ..()
	T = get_turf(src)

/obj/item/slimecross/regenerative/sepia
	colour = SLIME_TYPE_SEPIA
	effect_desc = "Cura completamente o alvo. Após 10 segundos, recoloque o alvo para a posição inicial que o núcleo foi usado com seu estado de saúde anterior."

/obj/item/slimecross/regenerative/sepia/core_effect_before(mob/living/target, mob/user)
	to_chat(target, span_notice("Você tenta esquecer como se sente."))
	target.AddComponent(/datum/component/dejavu)

/obj/item/slimecross/regenerative/cerulean
	colour = SLIME_TYPE_CERULEAN
	effect_desc = "Cura completamente o alvo e faz um segundo núcleo regenerativo sem efeitos especiais."

/obj/item/slimecross/regenerative/cerulean/core_effect(mob/living/target, mob/user)
	src.forceMove(user.loc)
	var/obj/item/slimecross/X = new /obj/item/slimecross/regenerative(user.loc)
	X.name = name
	X.desc = desc
	user.put_in_active_hand(X)
	to_chat(user, span_notice("Algumas das gosmas na sua mão!"))

/obj/item/slimecross/regenerative/pyrite
	colour = SLIME_TYPE_PYRITE
	effect_desc = "Cura completamente e aleatoriamente colore o alvo."

/obj/item/slimecross/regenerative/pyrite/core_effect(mob/living/target, mob/user)
	target.visible_message(span_warning("The milky goo coating [target] leaves [target.p_them()] a different color!"))
	target.add_atom_colour(color_transition_filter(rgb(rand(0,255), rand(0,255), rand(0,255)), SATURATION_OVERRIDE), WASHABLE_COLOUR_PRIORITY)

/obj/item/slimecross/regenerative/red
	colour = SLIME_TYPE_RED
	effect_desc = "Cura completamente o alvo e injeta efedrina."

/obj/item/slimecross/regenerative/red/core_effect(mob/living/target, mob/user)
	to_chat(target, span_notice("Você se sente...<i>Mais rápido.</i>"))
	target.reagents.add_reagent(/datum/reagent/medicine/ephedrine,3)

/obj/item/slimecross/regenerative/green
	colour = SLIME_TYPE_GREEN
	effect_desc = "Cura completamente o alvo e muda a espécie ou cor de um lodo ou geleia."

/obj/item/slimecross/regenerative/green/core_effect(mob/living/target, mob/user)
	if(isslime(target))
		target.visible_message(span_warning("The [target] suddenly changes color!"))
		var/mob/living/basic/slime/target_slime = target
		target_slime.set_slime_type()
	if(isjellyperson(target))
		target.reagents.add_reagent(/datum/reagent/mutationtoxin/jelly,5)

/obj/item/slimecross/regenerative/pink
	colour = SLIME_TYPE_PINK
	effect_desc = "Cura completamente o alvo e injeta um pouco de krokodil."

/obj/item/slimecross/regenerative/pink/core_effect(mob/living/target, mob/user)
	to_chat(target, span_notice("Você se sente mais calmo."))
	target.reagents.add_reagent(/datum/reagent/drug/krokodil,4)

/obj/item/slimecross/regenerative/gold
	colour = SLIME_TYPE_GOLD
	effect_desc = "Cura completamente o alvo e produz uma moeda aleatória."

/obj/item/slimecross/regenerative/gold/core_effect(mob/living/target, mob/user)
	var/newcoin = get_random_coin()
	var/obj/item/coin/C = new newcoin(target.loc)
	playsound(C, 'sound/items/coinflip.ogg', 50, TRUE)
	target.put_in_hand(C)

/obj/item/slimecross/regenerative/oil
	colour = SLIME_TYPE_OIL
	effect_desc = "Cura completamente o alvo e pisca todos à vista."

/obj/item/slimecross/regenerative/oil/core_effect(mob/living/target, mob/user)
	playsound(src, 'sound/items/weapons/flash.ogg', 100, TRUE)
	for(var/mob/living/L in view(user,7))
		L.flash_act()

/obj/item/slimecross/regenerative/black
	colour = SLIME_TYPE_BLACK
	effect_desc = "Cura completamente o alvo e cria uma duplicata imperfeita deles feita de lodo, que simula sua morte."

/obj/item/slimecross/regenerative/black/core_effect_before(mob/living/target, mob/user)
	var/dummytype = target.type
	if(target.mob_biotypes & MOB_SPECIAL) //Prevents megafauna and voidwalker duping in a lame way
		dummytype = /mob/living/basic/slime
		to_chat(user, span_warning("The milky goo flows over [target], falling into a weak puddle."))
	var/mob/living/dummy = new dummytype(target.loc)
	to_chat(target, span_notice("A gosma leitosa flui de sua pele, formando uma cópia imperfeita de você."))
	if(iscarbon(target) && iscarbon(dummy))
		var/mob/living/carbon/carbon_target = target
		var/mob/living/carbon/carbon_dummy = dummy
		carbon_dummy.real_name = carbon_target.real_name
		carbon_target.dna.copy_dna(carbon_dummy.dna, COPY_DNA_SE|COPY_DNA_SPECIES)
		carbon_dummy.updateappearance(mutcolor_update = TRUE)
	dummy.adjust_brute_loss(target.get_brute_loss())
	dummy.adjust_fire_loss(target.get_fire_loss())
	dummy.adjust_tox_loss(target.get_tox_loss())
	dummy.death()

/obj/item/slimecross/regenerative/lightpink
	colour = SLIME_TYPE_LIGHT_PINK
	effect_desc = "Cura completamente o alvo e também cura o usuário."

/obj/item/slimecross/regenerative/lightpink/core_effect(mob/living/target, mob/user)
	if(!isliving(user))
		return
	if(target == user)
		return
	var/mob/living/U = user
	U.revive(HEAL_ALL & ~HEAL_REFRESH_ORGANS)
	to_chat(U, span_notice("Alguns dos sprays de gosma leitosa em você, também!"))

/obj/item/slimecross/regenerative/adamantine
	colour = SLIME_TYPE_ADAMANTINE
	effect_desc = "Cura completamente o alvo e aumenta sua armadura."

/obj/item/slimecross/regenerative/adamantine/core_effect(mob/living/target, mob/user) //WIP - Find out why this doesn't work.
	target.apply_status_effect(/datum/status_effect/slimeskin)

/obj/item/slimecross/regenerative/rainbow
	colour = SLIME_TYPE_RAINBOW
	effect_desc = "Cura completamente o alvo e temporariamente os torna imortais, mas pacifistas."

/obj/item/slimecross/regenerative/rainbow/core_effect(mob/living/target, mob/user)
	target.apply_status_effect(/datum/status_effect/rainbow_protection)
