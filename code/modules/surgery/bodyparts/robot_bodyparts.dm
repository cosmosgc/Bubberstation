
#define ROBOTIC_LIGHT_BRUTE_MSG "marred"
#define ROBOTIC_MEDIUM_BRUTE_MSG "dented"
#define ROBOTIC_HEAVY_BRUTE_MSG "like its falling apart"

#define ROBOTIC_LIGHT_BURN_MSG "scorched"
#define ROBOTIC_MEDIUM_BURN_MSG "charred"
#define ROBOTIC_HEAVY_BURN_MSG "smoldering"

//For ye whom may venture here, split up arm / hand sprites are formatted as "l_hand" & "l_arm".
//The complete sprite (displayed when the limb is on the ground) should be named "borg_l_arm".
//Failure to follow this pattern will cause the hand's icons to be missing due to the way get_limb_icon() works to generate the mob's icons using the aux_zone var.

/obj/item/bodypart/arm/left/robot
	name = "cyborg left arm"
	desc = "Um membro esquelético embrulhado em pseudomúsculos, com um caso de baixa condutividade."
	limb_id = BODYPART_ID_ROBOTIC
	attack_verb_simple = list("slapped", "punched")
	inhand_icon_state = "buildpipe"
	icon = 'icons/mob/augmentation/augments.dmi'
	icon_static = 'icons/mob/augmentation/augments.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	icon_state = "borg_l_arm"
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodytype = BODYTYPE_ROBOTIC
	bodyshape = BODYSHAPE_HUMANOID
	change_exempt_flags = BP_BLOCK_CHANGE_SPECIES
	dmg_overlay_type = "robotic"

	brute_modifier = 0.8
	burn_modifier = 0.8

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	biological_state = (BIO_ROBOTIC|BIO_JOINTED)

	damage_examines = list(BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT, BURN = ROBOTIC_BURN_EXAMINE_TEXT)
	disabling_threshold_percentage = 1
	bodypart_flags = BODYPART_UNHUSKABLE
	butcher_replacement = null

/obj/item/bodypart/arm/right/robot
	name = "cyborg right arm"
	desc = "Um membro esquelético embrulhado em pseudomúsculos, com um caso de baixa condutividade."
	attack_verb_simple = list("slapped", "punched")
	inhand_icon_state = "buildpipe"
	icon_static = 'icons/mob/augmentation/augments.dmi'
	icon = 'icons/mob/augmentation/augments.dmi'
	limb_id = BODYPART_ID_ROBOTIC
	obj_flags = CONDUCTS_ELECTRICITY
	icon_state = "borg_r_arm"
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodytype = BODYTYPE_ROBOTIC
	bodyshape = BODYSHAPE_HUMANOID
	change_exempt_flags = BP_BLOCK_CHANGE_SPECIES
	dmg_overlay_type = "robotic"

	brute_modifier = 0.8
	burn_modifier = 0.8

	disabling_threshold_percentage = 1

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	biological_state = (BIO_ROBOTIC|BIO_JOINTED)

	damage_examines = list(BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT, BURN = ROBOTIC_BURN_EXAMINE_TEXT)
	bodypart_flags = BODYPART_UNHUSKABLE
	butcher_replacement = null

/obj/item/bodypart/leg/left/robot
	name = "cyborg left leg"
	desc = "Um membro esquelético embrulhado em pseudomúsculos, com um caso de baixa condutividade."
	attack_verb_simple = list("kicked", "stomped")
	inhand_icon_state = "buildpipe"
	icon_static = 'icons/mob/augmentation/augments.dmi'
	icon = 'icons/mob/augmentation/augments.dmi'
	limb_id = BODYPART_ID_ROBOTIC
	obj_flags = CONDUCTS_ELECTRICITY
	icon_state = "borg_l_leg"
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodytype = BODYTYPE_ROBOTIC
	bodyshape = BODYSHAPE_HUMANOID
	change_exempt_flags = BP_BLOCK_CHANGE_SPECIES
	dmg_overlay_type = "robotic"

	brute_modifier = 0.8
	burn_modifier = 0.8

	disabling_threshold_percentage = 1

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	biological_state = (BIO_ROBOTIC|BIO_JOINTED)

	damage_examines = list(BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT, BURN = ROBOTIC_BURN_EXAMINE_TEXT)
	bodypart_flags = BODYPART_UNHUSKABLE
	butcher_replacement = null

/obj/item/bodypart/leg/left/robot/emp_effect(severity, protection)
	. = ..()
	if(!. || isnull(owner))
		return

	var/knockdown_time = AUGGED_LEG_EMP_KNOCKDOWN_TIME
	if (severity == EMP_HEAVY)
		knockdown_time *= 2
	owner.Knockdown(knockdown_time)
	if(INCAPACITATED_IGNORING(owner, INCAPABLE_RESTRAINTS|INCAPABLE_GRAB)) // So the message isn't duplicated. If they were stunned beforehand by something else, then the message not showing makes more sense anyways.
		return
	to_chat(owner, span_danger("Como seu [plaintext_zone] Inesperadamente avarias, faz você cair no chão!"))
	return

/obj/item/bodypart/leg/right/robot
	name = "cyborg right leg"
	desc = "Um membro esquelético embrulhado em pseudomúsculos, com um caso de baixa condutividade."
	attack_verb_simple = list("kicked", "stomped")
	inhand_icon_state = "buildpipe"
	icon_static =  'icons/mob/augmentation/augments.dmi'
	icon = 'icons/mob/augmentation/augments.dmi'
	limb_id = BODYPART_ID_ROBOTIC
	obj_flags = CONDUCTS_ELECTRICITY
	icon_state = "borg_r_leg"
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodytype = BODYTYPE_ROBOTIC
	bodyshape = BODYSHAPE_HUMANOID
	change_exempt_flags = BP_BLOCK_CHANGE_SPECIES
	dmg_overlay_type = "robotic"

	brute_modifier = 0.8
	burn_modifier = 0.8

	disabling_threshold_percentage = 1

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	biological_state = (BIO_ROBOTIC|BIO_JOINTED)

	damage_examines = list(BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT, BURN = ROBOTIC_BURN_EXAMINE_TEXT)
	bodypart_flags = BODYPART_UNHUSKABLE
	butcher_replacement = null

/obj/item/bodypart/leg/right/robot/emp_effect(severity, protection)
	. = ..()
	if(!. || isnull(owner))
		return

	var/knockdown_time = AUGGED_LEG_EMP_KNOCKDOWN_TIME
	if (severity == EMP_HEAVY)
		knockdown_time *= 2
	owner.Knockdown(knockdown_time)
	if(INCAPACITATED_IGNORING(owner, INCAPABLE_RESTRAINTS|INCAPABLE_GRAB)) // So the message isn't duplicated. If they were stunned beforehand by something else, then the message not showing makes more sense anyways.
		return
	to_chat(owner, span_danger("Como seu [plaintext_zone] Inesperadamente avarias, faz você cair no chão!"))
	return

/obj/item/bodypart/chest/robot
	name = "cyborg torso"
	desc = "Uma caixa fortemente reforçada contendo placas lógicas cyborg, com espaço para uma célula de energia padrão."
	inhand_icon_state = "buildpipe"
	icon_static =  'icons/mob/augmentation/augments.dmi'
	icon = 'icons/mob/augmentation/augments.dmi'
	limb_id = BODYPART_ID_ROBOTIC
	obj_flags = CONDUCTS_ELECTRICITY
	icon_state = "borg_chest"
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodytype = BODYTYPE_ROBOTIC
	bodyshape = BODYSHAPE_HUMANOID
	change_exempt_flags = BP_BLOCK_CHANGE_SPECIES
	dmg_overlay_type = "robotic"

	brute_modifier = 0.8
	burn_modifier = 0.8

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	biological_state = (BIO_ROBOTIC)

	damage_examines = list(BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT, BURN = ROBOTIC_BURN_EXAMINE_TEXT)
	bodypart_flags = BODYPART_UNHUSKABLE
	butcher_replacement = null

	robotic_emp_paralyze_damage_percent_threshold = 0.6

	wing_types = list(/obj/item/organ/wings/functional/robotic)

	var/wired = FALSE
	var/obj/item/stock_parts/power_store/cell = null

/obj/item/bodypart/chest/robot/emp_effect(severity, protection)
	. = ..()
	if(!. || isnull(owner))
		return

	var/stun_time = 0
	var/shift_x = 3
	var/shift_y = 0
	var/shake_duration = AUGGED_CHEST_EMP_SHAKE_TIME

	if(severity == EMP_HEAVY)
		stun_time = AUGGED_CHEST_EMP_STUN_TIME

		shift_x = 5
		shift_y = 2

	var/damage_percent_to_max = (get_damage() / max_damage)
	if (stun_time && (damage_percent_to_max >= robotic_emp_paralyze_damage_percent_threshold))
		to_chat(owner, span_danger("Sua [plaintext_zone] As placas lógicas temporariamente não respondem!"))
		owner.Stun(stun_time)
	owner.Shake(pixelshiftx = shift_x, pixelshifty = shift_y, duration = shake_duration)
	return

/obj/item/bodypart/chest/robot/get_cell()
	return cell

/obj/item/bodypart/chest/robot/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == cell)
		cell = null

/obj/item/bodypart/chest/robot/Destroy()
	QDEL_NULL(cell)
	UnregisterSignal(src, COMSIG_BODYPART_ATTACHED)
	return ..()

/obj/item/bodypart/chest/robot/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_BODYPART_ATTACHED, PROC_REF(on_attached))
	RegisterSignal(src, COMSIG_BODYPART_REMOVED, PROC_REF(on_detached))

/obj/item/bodypart/chest/robot/proc/on_attached(obj/item/bodypart/chest/robot/this_bodypart, mob/living/carbon/human/new_owner)
	SIGNAL_HANDLER

	RegisterSignals(new_owner, list(COMSIG_CARBON_POST_ATTACH_LIMB, COMSIG_CARBON_POST_REMOVE_LIMB), PROC_REF(check_limbs))

/obj/item/bodypart/chest/robot/proc/on_detached(obj/item/bodypart/chest/robot/this_bodypart, mob/living/carbon/human/old_owner)
	SIGNAL_HANDLER

	UnregisterSignal(old_owner, list(COMSIG_CARBON_POST_ATTACH_LIMB, COMSIG_CARBON_POST_REMOVE_LIMB))

/obj/item/bodypart/chest/robot/proc/check_limbs()
	SIGNAL_HANDLER

	var/all_robotic = TRUE
	for(var/obj/item/bodypart/part as anything in owner.get_bodyparts())
		all_robotic = all_robotic && IS_ROBOTIC_LIMB(part)

	if(all_robotic)
		owner.add_traits(list(
			/* SKYRAT EDIT REMOVAL BEGIN - Synths are not immune to temperature
			TRAIT_RESISTCOLD,
			TRAIT_RESISTHEAT,
			SKYRAT EDIT REMOVAL END */
			TRAIT_RESISTLOWPRESSURE,
			TRAIT_RESISTHIGHPRESSURE,
			), AUGMENTATION_TRAIT)
	else
		owner.remove_traits(list(
			/* SKYRAT EDIT REMOVAL BEGIN - Synths are not immune to temperature
			TRAIT_RESISTCOLD,
			TRAIT_RESISTHEAT,
			SKYRAT EDIT REMOVAL END */
			TRAIT_RESISTLOWPRESSURE,
			TRAIT_RESISTHIGHPRESSURE,
			), AUGMENTATION_TRAIT)

/obj/item/bodypart/chest/robot/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/stock_parts/power_store/cell))
		if(cell)
			to_chat(user, span_warning("Uma célula já está presente em [src]!"))
			return ITEM_INTERACT_BLOCKING
		if(!user.transferItemToLoc(tool, src))
			return ITEM_INTERACT_BLOCKING
		cell = tool
		to_chat(user, span_notice("Você insere [cell] em [src]."))
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/stack/cable_coil))
		if(wired)
			to_chat(user, span_warning("[src] Já está ligado!"))
			return ITEM_INTERACT_BLOCKING
		var/obj/item/stack/cable_coil/coil = tool
		if (!coil.use(1))
			to_chat(user, span_warning("Você precisa de uma bobina para enfiá-lo!"))
			return ITEM_INTERACT_BLOCKING
		wired = TRUE
		to_chat(user, span_notice("Você liga a célula dentro de [src]."))
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/item/bodypart/chest/robot/wirecutter_act(mob/living/user, obj/item/cutter)
	. = ..()
	if(!wired)
		return
	. = TRUE
	cutter.play_tool_sound(src)
	to_chat(user, span_notice("Você cortou os fios [src]."))
	new /obj/item/stack/cable_coil(drop_location(), 1)
	wired = FALSE

/obj/item/bodypart/chest/robot/screwdriver_act(mob/living/user, obj/item/screwtool)
	..()
	. = TRUE
	if(!cell)
		to_chat(user, span_warning("Não há nenhuma célula de energia instalada.[src]!"))
		return
	screwtool.play_tool_sound(src)
	to_chat(user, span_notice("Remover [cell] De [src]."))
	cell.forceMove(drop_location())

/obj/item/bodypart/chest/robot/examine(mob/user)
	. = ..()
	if(cell)
		. += {"It has a [cell] inserted.\n
		[span_info("Você pode usar um<b>Chave de fenda</b>Para remover [cell].")]"}
	else
		. += span_info("Tem um porto vazio para um<b>Célula de energia</b>.")
	if(wired)
		. += "Está tudo ligado.[cell ? " and ready for usage" : ""].\n"+		span_info("Você pode usar<b>Cortadores de arame</b>para remover a fiação.")
	else
		. += span_info("Tem alguns pontos que ainda precisam ser<b>com fio</b>.")

/obj/item/bodypart/chest/robot/drop_organs(mob/user, violent_removal)
	var/atom/drop_loc = drop_location()
	if(wired)
		new /obj/item/stack/cable_coil(drop_loc, 1)
		wired = FALSE
	cell?.forceMove(drop_loc)
	return ..()

/obj/item/bodypart/head/robot
	name = "cyborg head"
	desc = "Uma caixa cerebral padrão reforçada, com encaixe neural com a coluna e gimbals sensores."
	inhand_icon_state = "buildpipe"
	icon_static = 'icons/mob/augmentation/augments.dmi'
	icon = 'icons/mob/augmentation/augments.dmi'
	limb_id = BODYPART_ID_ROBOTIC
	obj_flags = CONDUCTS_ELECTRICITY
	icon_state = "borg_head"
	is_dimorphic = FALSE
	should_draw_greyscale = FALSE
	bodytype = BODYTYPE_ROBOTIC
	bodyshape = BODYSHAPE_HUMANOID
	change_exempt_flags = BP_BLOCK_CHANGE_SPECIES
	dmg_overlay_type = "robotic"

	brute_modifier = 0.8
	burn_modifier = 0.8

	light_brute_msg = ROBOTIC_LIGHT_BRUTE_MSG
	medium_brute_msg = ROBOTIC_MEDIUM_BRUTE_MSG
	heavy_brute_msg = ROBOTIC_HEAVY_BRUTE_MSG

	light_burn_msg = ROBOTIC_LIGHT_BURN_MSG
	medium_burn_msg = ROBOTIC_MEDIUM_BURN_MSG
	heavy_burn_msg = ROBOTIC_HEAVY_BURN_MSG

	biological_state = (BIO_ROBOTIC)

	damage_examines = list(BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT, BURN = ROBOTIC_BURN_EXAMINE_TEXT)

	head_flags = HEAD_EYESPRITES
	bodypart_flags = BODYPART_UNHUSKABLE
	butcher_replacement = null

	var/obj/item/assembly/flash/handheld/flash1 = null
	var/obj/item/assembly/flash/handheld/flash2 = null

#define EMP_GLITCH "EMP_GLITCH"

/obj/item/bodypart/head/robot/emp_effect(severity, protection)
	. = ..()
	if(!. || isnull(owner))
		return

	to_chat(owner, span_danger("Sua [plaintext_zone] Os transmissores ópticos falham e falham!"))

	var/glitch_duration = AUGGED_HEAD_EMP_GLITCH_DURATION
	if (severity == EMP_HEAVY)
		glitch_duration *= 2

	QDEL_IN(owner.add_client_colour(/datum/client_colour/malfunction, HEAD_TRAIT), glitch_duration)

#undef EMP_GLITCH

/obj/item/bodypart/head/robot/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == flash1)
		flash1 = null
	if(gone == flash2)
		flash2 = null

/obj/item/bodypart/head/robot/Destroy()
	QDEL_NULL(flash1)
	QDEL_NULL(flash2)
	return ..()

/obj/item/bodypart/head/robot/examine(mob/user)
	. = ..()
	if(!flash1 && !flash2)
		. += span_info("Tem duas cavidades oculares vazias para<b>flashes</b>.")
	else
		var/single_flash = FALSE
		if(!flash1 || !flash2)
			single_flash = TRUE
			. += {"One of its eye sockets is currently occupied by a flash.\n
			[span_info("Tem um olho vazio para outro.<b>flash</b>.")]"}
		else
			. += "It has two eye sockets occupied by flashes."
		. += span_notice("Você pode remover o flash sentado.[single_flash ? "":"es"]com um<b>Pé de cabra.</b>.")

/obj/item/bodypart/head/robot/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/assembly/flash/handheld))
		return NONE

	var/obj/item/assembly/flash/handheld/flash = tool
	if(flash1 && flash2)
		to_chat(user, span_warning("[src] Já tem os dois olhos presentes!"))
		return ITEM_INTERACT_BLOCKING

	if(flash.burnt_out)
		to_chat(user, span_warning("Você não pode usar um flash quebrado!"))
		return ITEM_INTERACT_BLOCKING

	if(!user.transferItemToLoc(flash, src))
		return ITEM_INTERACT_BLOCKING

	if(flash1)
		flash2 = flash
	else
		flash1 = flash
	to_chat(user, span_notice("Você insere o flash na cavidade ocular."))
	return ITEM_INTERACT_SUCCESS

/obj/item/bodypart/head/robot/crowbar_act(mob/living/user, obj/item/prytool)
	..()
	if(flash1 || flash2)
		prytool.play_tool_sound(src)
		to_chat(user, span_notice("Você remove o flash de [src]."))
		flash1?.forceMove(drop_location())
		flash2?.forceMove(drop_location())
	else
		to_chat(user, span_warning("Não há nenhum flash para remover [src]."))
	return TRUE

/obj/item/bodypart/head/robot/drop_organs(mob/user, violent_removal)
	var/atom/drop_loc = drop_location()
	flash1?.forceMove(drop_loc)
	flash2?.forceMove(drop_loc)
	return ..()

// Prosthetics - Cheap, mediocre, and worse than organic limbs
// Actively make you less healthy by being on your body, contributing a whopping 250% to overall health at only 20 max health
// They also suck to punch with.

/obj/item/bodypart/arm/left/robot/surplus
	name = "surplus prosthetic left arm"
	desc = "Um membro esquelético, robótico. Fora de moda e frágil, mas ainda é melhor do que nada."
	icon_static = 'icons/mob/augmentation/surplus_augments.dmi'
	icon = 'icons/mob/augmentation/surplus_augments.dmi'
	burn_modifier = 1
	brute_modifier = 1
	unarmed_damage_low = 1
	unarmed_damage_high = 5
	unarmed_effectiveness = 0 //Bro, you look huge.
	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/arm/right/robot/surplus
	name = "surplus prosthetic right arm"
	desc = "Um membro esquelético, robótico. Fora de moda e frágil, mas ainda é melhor do que nada."
	icon_static = 'icons/mob/augmentation/surplus_augments.dmi'
	icon = 'icons/mob/augmentation/surplus_augments.dmi'
	burn_modifier = 1
	brute_modifier = 1
	unarmed_damage_low = 1
	unarmed_damage_high = 5
	unarmed_effectiveness = 0
	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/left/robot/surplus
	name = "surplus prosthetic left leg"
	desc = "Um membro esquelético, robótico. Fora de moda e frágil, mas ainda é melhor do que nada."
	icon_static = 'icons/mob/augmentation/surplus_augments.dmi'
	icon = 'icons/mob/augmentation/surplus_augments.dmi'
	brute_modifier = 1
	burn_modifier = 1
	unarmed_damage_low = 2
	unarmed_damage_high = 10
	unarmed_effectiveness = 0
	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/right/robot/surplus
	name = "surplus prosthetic right leg"
	desc = "Um membro esquelético, robótico. Fora de moda e frágil, mas ainda é melhor do que nada."
	icon_static = 'icons/mob/augmentation/surplus_augments.dmi'
	icon = 'icons/mob/augmentation/surplus_augments.dmi'
	brute_modifier = 1
	burn_modifier = 1
	unarmed_damage_low = 2
	unarmed_damage_high = 10
	unarmed_effectiveness = 0
	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

// Advanced Limbs: More durable, high punching force

/obj/item/bodypart/arm/left/robot/advanced
	name = "advanced robotic left arm"
	desc = "Um braço cibernético avançado, capaz de maiores feitos de força e durabilidade."
	icon_static = 'icons/mob/augmentation/advanced_augments.dmi'
	icon = 'icons/mob/augmentation/advanced_augments.dmi'
	unarmed_damage_low = 5
	unarmed_damage_high = 13
	unarmed_effectiveness = 20
	max_damage = LIMB_MAX_HP_ADVANCED
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_ADVANCED
	is_emissive = TRUE

/obj/item/bodypart/arm/right/robot/advanced
	name = "advanced robotic right arm"
	desc = "Um braço cibernético avançado, capaz de maiores feitos de força e durabilidade."
	icon_static = 'icons/mob/augmentation/advanced_augments.dmi'
	icon = 'icons/mob/augmentation/advanced_augments.dmi'
	unarmed_damage_low = 5
	unarmed_damage_high = 13
	unarmed_effectiveness = 20
	max_damage = LIMB_MAX_HP_ADVANCED
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_ADVANCED
	is_emissive = TRUE

/obj/item/bodypart/leg/left/robot/advanced
	name = "advanced robotic left leg"
	desc = "Uma perna cibernética avançada, capaz de maiores feitos de força e durabilidade."
	icon_static = 'icons/mob/augmentation/advanced_augments.dmi'
	icon = 'icons/mob/augmentation/advanced_augments.dmi'
	unarmed_damage_low = 7
	unarmed_damage_high = 17
	unarmed_effectiveness = 20
	max_damage = LIMB_MAX_HP_ADVANCED
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_ADVANCED
	is_emissive = TRUE

/obj/item/bodypart/leg/right/robot/advanced
	name = "advanced robotic right leg"
	desc = "Uma perna cibernética avançada, capaz de maiores feitos de força e durabilidade."
	icon_static = 'icons/mob/augmentation/advanced_augments.dmi'
	icon = 'icons/mob/augmentation/advanced_augments.dmi'
	unarmed_damage_low = 7
	unarmed_damage_high = 17
	unarmed_effectiveness = 20
	max_damage = LIMB_MAX_HP_ADVANCED
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_ADVANCED
	is_emissive = TRUE

#undef ROBOTIC_LIGHT_BRUTE_MSG
#undef ROBOTIC_MEDIUM_BRUTE_MSG
#undef ROBOTIC_HEAVY_BRUTE_MSG

#undef ROBOTIC_LIGHT_BURN_MSG
#undef ROBOTIC_MEDIUM_BURN_MSG
#undef ROBOTIC_HEAVY_BURN_MSG
