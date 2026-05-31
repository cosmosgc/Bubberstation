// *************************************
// Hydroponics Tools
// *************************************

/obj/item/reagent_containers/spray/weedspray // -- Skie
	desc = "É uma mistura tóxica, em forma de spray, para matar ervas daninhas pequenas."
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	name = "weed spray"
	icon_state = "weedspray"
	inhand_icon_state = "spraycan"
	worn_icon_state = "spraycan"
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	volume = 100
	list_reagents = list(/datum/reagent/toxin/plantbgone/weedkiller = 100)

/obj/item/reagent_containers/spray/weedspray/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]Está ofegante[src]! Parece que...[user.p_theyre()]Tentando cometer suicídio!"))
	return TOXLOSS

/obj/item/reagent_containers/spray/pestspray // -- Skie
	desc = "É um spray para eliminar pragas!<I>Não inale!</I>"
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	name = "pest spray"
	icon_state = "pestspray"
	inhand_icon_state = "plantbgone"
	worn_icon_state = "spraycan"
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	volume = 100
	list_reagents = list(/datum/reagent/toxin/pestkiller = 100)

/obj/item/reagent_containers/spray/pestspray/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]Está ofegante[src]! Parece que...[user.p_theyre()]Tentando cometer suicídio!"))
	return TOXLOSS

/obj/item/cultivator
	name = "cultivator"
	desc = "É usado para remover ervas daninhas ou coçar suas costas."
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "cultivator"
	inhand_icon_state = "cultivator"
	icon_angle = -135
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	force = 5
	throwforce = 7
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*0.5)
	attack_verb_continuous = list("slashes", "slices", "cuts", "claws")
	attack_verb_simple = list("slash", "slice", "cut", "claw")
	hitsound = 'sound/items/weapons/bladeslice.ogg'

/obj/item/cultivator/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]Está coçando.[user.p_their()]De volta tão forte quanto[user.p_they()]Pode com\the [src]! Parece que...[user.p_theyre()]Tentando cometer suicídio!"))
	return BRUTELOSS

/obj/item/cultivator/rake
	name = "rake"
	icon_state = "rake"
	icon_angle = -45
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("slashes", "slices", "bashes", "claws")
	attack_verb_simple = list("slash", "slice", "bash", "claw")
	hitsound = null
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 5)
	resistance_flags = FLAMMABLE
	flags_1 = NONE

/obj/item/cultivator/rake/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/item/cultivator/rake/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(!ishuman(AM))
		return
	var/mob/living/carbon/human/H = AM
	if(has_gravity(loc) && HAS_TRAIT(H, TRAIT_CLUMSY) && !H.resting)
		H.set_confusion_if_lower(10 SECONDS)
		H.Stun(20)
		playsound(src, 'sound/items/weapons/punch4.ogg', 50, TRUE)
		H.visible_message(span_warning("[H]Vamos lá.[src]fazendo o cabo bater[H.p_them()]bem na cara!"), 						  span_userdanger("Você pisa[src]fazendo com que o cabo te acertasse na cara!"))

/obj/item/cultivator/cyborg
	name = "cyborg cultivator"
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "sili_cultivator"
	icon_angle = 0

/obj/item/hatchet
	name = "hatchet"
	desc = "Uma lâmina de machado muito afiada em um cabo de fibra de metal curto. Tem uma longa história de cortar coisas, mas agora é usado para cortar madeira."
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "hatchet"
	inhand_icon_state = "hatchet"
	icon_angle = -135
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	force = 12
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 15
	throw_speed = 4
	throw_range = 7
	embed_type = /datum/embedding/hatchet
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*7.5)
	attack_verb_continuous = list("chops", "tears", "lacerates", "cuts")
	attack_verb_simple = list("chop", "tear", "lacerate", "cut")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED

/datum/embedding/hatchet
	pain_mult = 4
	embed_chance = 35
	fall_chance = 10

/obj/item/hatchet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, 	speed = 7 SECONDS, 	effectiveness = 100, 	)

/obj/item/hatchet/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]Está cortando em[user.p_them()]ego com[src]! Parece que...[user.p_theyre()]Tentando cometer suicídio!"))
	playsound(src, 'sound/items/weapons/bladeslice.ogg', 50, TRUE, -1)
	return BRUTELOSS

/obj/item/hatchet/wooden
	desc = "Uma lâmina de machado em um cabo de madeira curto."
	icon_state = "woodhatchet"
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 1)
	resistance_flags = FLAMMABLE
	flags_1 = NONE

/obj/item/hatchet/cyborg
	name = "cyborg hatchet"
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "sili_hatchet"
	icon_angle = 0

/* Skyrat Edit Start - Modularization and New Scythes
/obj/item/scythe
	name = "scythe"
	desc = "Uma lâmina afiada e curva em um cabo de fibra de metal longo, esta ferramenta torna fácil colher o que você semeia."
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "scythe0"
	inhand_icon_state = "scythe0"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	force = 15
	throwforce = 5
	throw_speed = 2
	throw_range = 3
	w_class = WEIGHT_CLASS_BULKY
	obj_flags = CONDUCTS_ELECTRICITY
	armour_penetration = 20
	wound_bonus = 10
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("chops", "slices", "cuts", "reaps")
	attack_verb_simple = list("chop", "slice", "cut", "reap")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	item_flags = CRUEL_IMPLEMENT //maybe they want to use it in surgery
	var/swiping = FALSE

/obj/item/scythe/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, 	speed = 9 SECONDS, 	effectiveness = 105, 	)
	AddElement(/datum/element/bane, mob_biotypes = MOB_PLANT, damage_multiplier = 0.5, requires_combat_mode = FALSE)

/obj/item/scythe/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]Está decapitando.[user.p_them()]ego com[src]! Parece que...[user.p_theyre()]Tentando cometer suicídio!"))
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		var/obj/item/bodypart/BP = C.get_bodypart(BODY_ZONE_HEAD)
		if(BP)
			BP.drop_limb()
			playsound(src, SFX_DESECRATION ,50, TRUE, -1)
	return BRUTELOSS

/obj/item/scythe/pre_attack(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
	if(!istype(target, /obj/structure/alien/resin/flower_bud) && !istype(target, /obj/structure/spacevine))
		return ..()
	if(swiping || get_turf(target) == get_turf(user))
		return ..()
	var/turf/user_turf = get_turf(user)
	var/dir_to_target = get_dir(user_turf, get_turf(target))
	swiping = TRUE
	var/static/list/scythe_slash_angles = list(0, 45, 90, -45, -90)
	for(var/i in scythe_slash_angles)
		var/turf/adjacent_turf = get_step(user_turf, turn(dir_to_target, i))
		for(var/obj/structure/spacevine/vine in adjacent_turf)
			if(user.Adjacent(vine))
				melee_attack_chain(user, vine)
		for(var/obj/structure/alien/resin/flower_bud/flower in adjacent_turf)
			if(user.Adjacent(flower))
				melee_attack_chain(user, flower)
	swiping = FALSE
	return TRUE
*/

/obj/item/secateurs
	name = "secateurs"
	desc = "É uma ferramenta para cortar enxertos de plantas ou mudar de aparência."
	desc_controls = "Right-click to stylize podperson hair or other plant features!"
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "secateurs"
	inhand_icon_state = null
	worn_icon_state = "cutters"
	icon_angle = -135
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	force = 5
	throwforce = 6
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	custom_materials = list(/datum/material/iron= SHEET_MATERIAL_AMOUNT*2)
	attack_verb_continuous = list("slashes", "slices", "cuts", "claws")
	attack_verb_simple = list("slash", "slice", "cut", "claw")
	hitsound = 'sound/items/weapons/bladeslice.ogg'

///Catch right clicks so we can stylize!
/obj/item/secateurs/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(user.combat_mode)
		return NONE

	restyle(interacting_with, user)
	return ITEM_INTERACT_SUCCESS

///Send a signal to whatever we clicked and ask them if they wanna be PLANT RESTYLED YEAAAAAAAH
/obj/item/secateurs/proc/restyle(atom/target, mob/living/user)
	SEND_SIGNAL(target, COMSIG_ATOM_RESTYLE, user, target, user.zone_selected, EXTERNAL_RESTYLE_PLANT, 6 SECONDS)

/obj/item/secateurs/cyborg
	name = "cyborg secateurs"
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "sili_secateur"
	icon_angle = 0

/obj/item/geneshears
	name = "botanogenetic plant shears"
	desc = "Um par de tesouras de plantas de alta fidelidade, capaz de cortar traços genéticos de uma planta."
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "genesheers"
	inhand_icon_state = null
	worn_icon_state = "cutters"
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	force = 10
	throwforce = 8
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2, /datum/material/uranium=HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/gold=SMALL_MATERIAL_AMOUNT*5)
	attack_verb_continuous = list("slashes", "slices", "cuts")
	attack_verb_simple = list("slash", "slice", "cut")
	hitsound = 'sound/items/weapons/bladeslice.ogg'

// *************************************
// Nutrient defines for hydroponics
// *************************************


/obj/item/reagent_containers/cup/bottle/nutrient
	name = "bottle of nutrient"
	volume = 50
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(1,2,5,10,15,25,50)

/obj/item/reagent_containers/cup/bottle/nutrient/Initialize(mapload)
	. = ..()
	pixel_x = base_pixel_x + rand(-5, 5)
	pixel_y = base_pixel_y + rand(-5, 5)


/obj/item/reagent_containers/cup/bottle/nutrient/ez
	name = "bottle of E-Z-Nutrient"
	desc = "Contém um fertilizante que causa mutações leves e crescimento gradual das plantas em cada colheita."
	list_reagents = list(/datum/reagent/plantnutriment/eznutriment = 50)

/obj/item/reagent_containers/cup/bottle/nutrient/l4z
	name = "bottle of Left 4 Zed"
	desc = "Contém um fertilizante que cura levemente a planta, mas causa mutações significativas nas plantas ao longo de gerações."
	list_reagents = list(/datum/reagent/plantnutriment/left4zednutriment = 50)

/obj/item/reagent_containers/cup/bottle/nutrient/rh
	name = "bottle of Robust Harvest"
	desc = "Contém um fertilizante que aumenta o rendimento de uma planta enquanto gradualmente evita mutações."
	list_reagents = list(/datum/reagent/plantnutriment/robustharvestnutriment = 50)

/obj/item/reagent_containers/cup/bottle/nutrient/empty
	name = "bottle"

/obj/item/reagent_containers/cup/bottle/killer
	volume = 30
	amount_per_transfer_from_this = 1
	possible_transfer_amounts = list(1,2,5)

/obj/item/reagent_containers/cup/bottle/killer/weedkiller
	name = "bottle of weed killer"
	desc = "Contém um herbicida."
	list_reagents = list(/datum/reagent/toxin/plantbgone/weedkiller = 30)

/obj/item/reagent_containers/cup/bottle/killer/pestkiller
	name = "bottle of pest spray"
	desc = "Contém um pesticida."
	list_reagents = list(/datum/reagent/toxin/pestkiller = 30)
