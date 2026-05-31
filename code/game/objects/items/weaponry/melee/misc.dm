// Deprecated, you do not need to use this type for melee weapons.
/obj/item/melee
	abstract_type = /obj/item/melee
	item_flags = NEEDS_PERMIT

/obj/item/melee/synthetic_arm_blade
	name = "synthetic arm blade"
	desc = "Uma lâmina grotesca que em inspeção mais próxima parece ser feita de carne sintética, ainda parece que machucaria muito como uma arma."
	icon = 'icons/obj/weapons/changeling_items.dmi'
	icon_state = "arm_blade"
	inhand_icon_state = "arm_blade"
	icon_angle = 180
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	force = 20
	throwforce = 10
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED
	var/list/alt_continuous = list("stabs", "pierces", "impales")
	var/list/alt_simple = list("stab", "pierce", "impale")

/obj/item/melee/synthetic_arm_blade/Initialize(mapload)
	. = ..()
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple, -5)
	AddComponent(/datum/component/butchering, 	speed = 6 SECONDS, 	effectiveness = 80, 	)
	//very imprecise

/obj/item/melee/beesword
	name = "The Stinger"
	desc = "Tirado de uma abelha gigante e dobrado mais de mil vezes em mel puro. Pode ser qualquer coisa."
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "beesword"
	inhand_icon_state = "stinger"
	worn_icon_state = "stinger"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 5
	w_class = WEIGHT_CLASS_BULKY
	sharpness = SHARP_EDGED
	throwforce = 10
	attack_speed = CLICK_CD_RAPID
	block_chance = 20
	armour_penetration = 65
	attack_verb_continuous = list("slashes", "stings", "prickles", "pokes")
	attack_verb_simple = list("slash", "sting", "prickle", "poke")
	hitsound = 'sound/items/weapons/rapierhit.ogg'
	block_sound = 'sound/items/weapons/parry.ogg'

/obj/item/melee/beesword/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == PROJECTILE_ATTACK || attack_type == LEAP_ATTACK || attack_type == OVERWHELMING_ATTACK)
		final_block_chance = 0 //Don't bring a sword to a gunfight, and also you aren't going to really block someone full body tackling you with a sword. Or a road roller, if one happened to hit you.
	return ..()

/obj/item/melee/beesword/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(iscarbon(target) && !QDELETED(target))
		var/mob/living/carbon/carbon_target = target
		carbon_target.reagents.add_reagent(/datum/reagent/toxin, 4)

/obj/item/melee/beesword/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]Está esfaqueando.[user.p_them()]Ego na gigante com[src]Parece que...[user.p_theyre()]Tentando cometer suicídio!"))
	playsound(get_turf(src), hitsound, 75, TRUE, -1)
	return TOXLOSS

/obj/item/melee/curator_whip
	name = "curator's whip"
	desc = "Um pouco excêntrico e ultrapassado, ainda dói para ser atingido."
	icon = 'icons/obj/weapons/whip.dmi'
	icon_state = "whip"
	inhand_icon_state = "chain"
	icon_angle = -90
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	worn_icon_state = "whip"
	slot_flags = ITEM_SLOT_BELT
	force = 15
	demolition_mod = 0.25
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("flogs", "whips", "lashes", "disciplines")
	attack_verb_simple = list("flog", "whip", "lash", "discipline")
	hitsound = 'sound/items/weapons/whip.ogg'

/obj/item/melee/curator_whip/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		human_target.drop_all_held_items()
		human_target.visible_message(span_danger("[user]Desarmar.[human_target]!"), span_userdanger("[user]Desarmei você!"))

/obj/item/melee/roastingstick
	name = "advanced roasting stick"
	desc = "Um bastão de torrefação telescópica com um gerador de escudo miniatura projetado para garantir a entrada em vários fornos de cozinha de alta tecnologia blindados e fogueiras."
	icon = 'icons/obj/service/kitchen.dmi'
	icon_state = "roastingstick"
	inhand_icon_state = null
	worn_icon_state = "tele_baton"
	icon_angle = -45
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	item_flags = NONE
	force = 0
	attack_verb_continuous = list("hits", "pokes")
	attack_verb_simple = list("hit", "poke")
	/// The sausage attatched to our stick.
	var/obj/item/food/sausage/held_sausage
	/// Static list of things our roasting stick can interact with.
	var/static/list/ovens
	/// The beam that links to the oven we use
	var/datum/beam/beam

/obj/item/melee/roastingstick/Initialize(mapload)
	. = ..()
	if (!ovens)
		ovens = typecacheof(list(/obj/singularity, /obj/energy_ball, /obj/machinery/power/supermatter_crystal, /obj/structure/bonfire))
	AddComponent( 		/datum/component/transforming, 		hitsound_on = hitsound, 		clumsy_check = FALSE, 		inhand_icon_change = FALSE, 	)
	RegisterSignal(src, COMSIG_TRANSFORMING_PRE_TRANSFORM, PROC_REF(attempt_transform))
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/*
 * Signal proc for [COMSIG_TRANSFORMING_PRE_TRANSFORM].
 *
 * If there is a sausage attached, returns COMPONENT_BLOCK_TRANSFORM.
 */
/obj/item/melee/roastingstick/proc/attempt_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	if(held_sausage)
		to_chat(user, span_warning("Você não pode se retratar.[src]entanto[held_sausage]Está preso!"))
		return COMPONENT_BLOCK_TRANSFORM

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Gives feedback on stick extension.
 */
/obj/item/melee/roastingstick/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	inhand_icon_state = active ? "nullrod" : null
	if(user)
		balloon_alert(user, "[active ? "extended" : "collapsed"] [src]")
	playsound(src, 'sound/items/weapons/batonextend.ogg', 50, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/melee/roastingstick/attackby(atom/target, mob/user)
	..()
	if (istype(target, /obj/item/food/sausage))
		if (!HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
			to_chat(user, span_warning("Você deve estender[src]Para prender qualquer coisa a ele!"))
			return
		if (held_sausage)
			to_chat(user, span_warning("[held_sausage]Já está ligado a[src]!"))
			return
		if (user.transferItemToLoc(target, src))
			held_sausage = target
		else
			to_chat(user, span_warning("[target]Não parece querer entrar[src]!"))
	update_appearance()

/obj/item/melee/roastingstick/attack_hand(mob/user, list/modifiers)
	..()
	if (held_sausage)
		user.put_in_hands(held_sausage)

/obj/item/melee/roastingstick/update_overlays()
	. = ..()
	if(held_sausage)
		. += mutable_appearance(icon, "roastingstick_sausage")

/obj/item/melee/roastingstick/Exited(atom/movable/gone, direction)
	. = ..()
	if (gone == held_sausage)
		held_sausage = null
		update_appearance()

/obj/item/melee/roastingstick/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if (!HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		return NONE
	if (!is_type_in_typecache(interacting_with, ovens))
		return NONE
	if (istype(interacting_with, /obj/singularity) || istype(interacting_with, /obj/energy_ball) && get_dist(user, interacting_with) < 10)
		to_chat(user, span_notice("Você manda[held_sausage]em direção[interacting_with]."))
		playsound(src, 'sound/items/tools/rped.ogg', 50, TRUE)
		beam = user.Beam(interacting_with, icon_state = "rped_upgrade", time = 10 SECONDS)
		finish_roasting(user, interacting_with)
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/item/melee/roastingstick/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if (!HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		return NONE
	if (!is_type_in_typecache(interacting_with, ovens))
		return NONE
	to_chat(user, span_notice("Você se estende.[src]em direção[interacting_with]."))
	playsound(src, 'sound/items/weapons/batonextend.ogg', 50, TRUE)
	finish_roasting(user, interacting_with)
	return ITEM_INTERACT_SUCCESS

/obj/item/melee/roastingstick/proc/finish_roasting(user, atom/target)
	if(do_after(user, 10 SECONDS, target = user))
		to_chat(user, span_notice("Você termina de assar[held_sausage]."))
		playsound(src, 'sound/items/tools/welder2.ogg', 50, TRUE)
		held_sausage.add_atom_colour(rgb(103, 63, 24), FIXED_COLOUR_PRIORITY)
		held_sausage.name = "[target.name]-roasted [held_sausage.name]"
		held_sausage.desc = "[held_sausage.desc] It has been cooked to perfection on \a [target]."
		update_appearance()
	else
		QDEL_NULL(beam)
		playsound(src, 'sound/items/weapons/batonextend.ogg', 50, TRUE)
		to_chat(user, span_notice("Você colocou[src]Vamos."))

/obj/item/melee/cleric_mace
	name = "cleric mace"
	desc = "O neto do clube, ainda o avô do taco de beisebol. Mais notavelmente usado por ordens sagradas em dias passados."
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/melee/cleric_mace"
	post_init_icon_state = "default"
	inhand_icon_state = "default"
	worn_icon_state = "default_worn"
	icon_angle = -45

	greyscale_config = /datum/greyscale_config/cleric_mace
	greyscale_config_inhand_left = /datum/greyscale_config/cleric_mace_lefthand
	greyscale_config_inhand_right = /datum/greyscale_config/cleric_mace_righthand
	greyscale_config_worn = /datum/greyscale_config/cleric_mace
	greyscale_colors = COLOR_WHITE + COLOR_BROWN

	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_AFFECT_STATISTICS
	// Defaults to an iron head, wooden handle mace
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4.5, /datum/material/wood = SHEET_MATERIAL_AMOUNT * 1.5)
	material_slots = list(/datum/material_slot/weapon_head/mace = /datum/material/iron, /datum/material_slot/handle = /datum/material/wood)
	slot_flags = ITEM_SLOT_BELT
	force = 16
	w_class = WEIGHT_CLASS_BULKY
	throwforce = 8
	block_chance = 10
	block_sound = 'sound/items/weapons/genhit.ogg'
	armour_penetration = 50
	attack_verb_continuous = list("smacks", "strikes", "cracks", "beats")
	attack_verb_simple = list("smack", "strike", "crack", "beat")

// It only inherits the name of the main material it's made of. The secondary is in the description.
/obj/item/melee/cleric_mace/get_material_prefixes(list/materials)
	var/datum/material/material = get_material_from_slot(/datum/material_slot/weapon_head)
	return material?.name

/obj/item/melee/cleric_mace/finalize_material_effects(list/materials)
	. = ..()
	var/datum/material/material = get_material_from_slot(/datum/material_slot/handle)
	if (material)
		desc = "[initial(desc)]Sua alça é feita de[material.name]."

/obj/item/melee/cleric_mace/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	// Don't bring a...mace to a gunfight, and also you aren't going to really block someone full body tackling you with a mace.
	// Or a road roller, if one happened to hit you.
	if(attack_type == PROJECTILE_ATTACK || attack_type == LEAP_ATTACK || attack_type == OVERWHELMING_ATTACK)
		final_block_chance = 0
	return ..()

/datum/material_slot/weapon_head/mace
	name = "mace head"
	material_amount = 3

/obj/item/sord
	name = "\improper SORD"
	desc = "Essa coisa é tão indescritivelmente uma merda que você está tendo dificuldade em segurá-la."
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "sord"
	inhand_icon_state = "sord"
	icon_angle = -35
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 2
	throwforce = 1
	w_class = WEIGHT_CLASS_NORMAL
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")

/obj/item/sord/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]Está tentando empalar[user.p_them()]ego com[src]! Seria uma tentativa de suicídio se não fosse tão ruim."), 	span_suicide("Você tenta empalar-se com[src], mas é inútil ..."))
	return SHAME

/obj/item/carpenter_hammer
	name = "carpenter hammer"
	icon = 'icons/obj/weapons/hammer.dmi'
	icon_state = "carpenter_hammer"
	inhand_icon_state = "carpenter_hammer"
	worn_icon_state = "clawhammer" //plaecholder
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/hammers_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/hammers_righthand.dmi'
	desc = "Martelo incrível."
	force = 17
	throwforce = 14
	throw_range = 4
	w_class = WEIGHT_CLASS_NORMAL
	wound_bonus = 20
	demolition_mod = 1.15
	slot_flags = ITEM_SLOT_BELT

/obj/item/carpenter_hammer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/kneejerk)
	AddComponent(/datum/component/item_killsound, 	allowed_mobs = list(/mob/living/carbon/human), 	killsound = 'sound/items/weapons/hammer_death_scream.ogg', 	replace_default_death_sound = TRUE, 	)

/obj/item/carpenter_hammer/examine(mob/user)
	. = ..()
	. += ""
	. += "Real World Tip:"
	. += pick(
		"Every building, from hospitals to homes, has a room that serves as the heart of the building 		and carries blood and nutrients to its extremities. Try to find the heart of your home!",
		"All the food you've tried is rotten. You've never eaten fresh food.",
		"Viruses do not exist. Illness is simply your body punishing you for what you have done wrong.",
		"Space stations must have at least 50 mammalian teeth embedded in the north walls for structural safety reasons.",
		"Queen dragonfly sleeps and smiles.",
	)

/obj/item/phone
	name = "red phone"
	desc = "Se algo der errado..."
	icon = 'icons/obj/devices/voice.dmi'
	icon_state = "red_phone"
	force = 3
	throwforce = 2
	throw_speed = 3
	throw_range = 4
	w_class = WEIGHT_CLASS_SMALL
	attack_verb_continuous = list("calls", "rings")
	attack_verb_simple = list("call", "ring")
	hitsound = 'sound/items/weapons/ring.ogg'

/obj/item/phone/suicide_act(mob/living/user)
	if(locate(/obj/structure/chair/stool) in user.loc)
		user.visible_message(span_suicide("[user]começa a amarrar uma corda com[src]Cordão! Parece que...[user.p_theyre()]Tentando cometer suicídio!"))
	else
		user.visible_message(span_suicide("[user]Está estrangulando[user.p_them()]ego com[src]Cordão! Parece que...[user.p_theyre()]Tentando cometer suicídio!"))
	return OXYLOSS

/obj/item/bambostaff
	name = "bamboo staff"
	desc = "Um longo bastão de bambu com pontas de aço. Dizem que os iniciados do Clã Aranha treinam com eles antes de aprender a usar uma katana."
	force = 10
	block_chance = 45
	block_sound = 'sound/items/weapons/genhit.ogg'
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	hitsound = SFX_SWING_HIT
	attack_verb_continuous = list("smashes", "slams", "whacks", "thwacks")
	attack_verb_simple = list("smash", "slam", "whack", "thwack")
	icon = 'icons/obj/weapons/staff.dmi'
	icon_state = "bambostaff0"
	base_icon_state = "bambostaff"
	inhand_icon_state = "bambostaff0"
	worn_icon_state = "bambostaff0"
	icon_angle = -135
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	custom_materials = list(/datum/material/bamboo = SHEET_MATERIAL_AMOUNT * 4)

/obj/item/bambostaff/Initialize(mapload)
	. = ..()
	// there are too many puns to choose from. ('Bo' is the 'real' name for this kind of weapon.)
	name = pick("bamboo staff", "bambo staff", "bam-Bo staff", "bam boo staff", "bam-boo staff", "bam Bo", "bambo", "bam-Bo", "bamboo-Bo")
	AddComponent(/datum/component/two_handed, 		force_unwielded = 10, 		force_wielded = 14, 	)

/obj/item/bambostaff/update_icon_state()
	icon_state = inhand_icon_state = "[base_icon_state][HAS_TRAIT(src, TRAIT_WIELDED)]"
	return ..()

/obj/item/bambostaff/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == PROJECTILE_ATTACK || attack_type == LEAP_ATTACK || attack_type == OVERWHELMING_ATTACK)
		final_block_chance = 0 //Don't bring a staff to a gunfight, and also you aren't going to really block someone full body tackling you with a staff. Or a road roller, if one happened to hit you.
	return ..()

/obj/item/staff
	name = "wizard staff"
	desc = "Aparentemente um bastão usado pelo mago."
	icon = 'icons/obj/weapons/guns/magic.dmi'
	icon_state = "staff"
	inhand_icon_state = "staff"
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	force = 3
	throwforce = 5
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	armour_penetration = 100
	attack_verb_continuous = list("bludgeons", "whacks", "disciplines")
	attack_verb_simple = list("bludgeon", "whack", "discipline")
	resistance_flags = FLAMMABLE

/obj/item/staff/broom
	name = "broom"
	desc = "Usado para varrer, e voar pela noite enquanto cacareja. Gato preto não incluído."
	icon_state = "broom"
	inhand_icon_state = "broom"
	resistance_flags = FLAMMABLE

/obj/item/staff/tape
	name = "tape staff"
	desc = "Um rolo de fita grudada em um pau."
	icon_state = "tapestaff"
	inhand_icon_state = "tapestaff"
	resistance_flags = FLAMMABLE

/obj/item/staff/stick
	name = "stick"
	desc = "Uma ótima ferramenta para arrastar as bebidas de outra pessoa pelo bar."
	icon = 'icons/obj/weapons/staff.dmi'
	icon_state = "cane"
	inhand_icon_state = "stick"
	icon_angle = 135
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 3
	throwforce = 5
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL

/obj/item/tailclub
	name = "tail club"
	desc = "Pelo espancamento de lagartos com suas próprias caudas."
	icon = 'icons/obj/weapons/club.dmi'
	icon_state = "tailclub"
	icon_angle = -25
	force = 14
	throwforce = 1 // why are you throwing a club do you even weapon
	throw_speed = 1
	throw_range = 1
	attack_verb_continuous = list("clubs", "bludgeons")
	attack_verb_simple = list("club", "bludgeon")
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)

/obj/item/melee/flyswatter
	name = "flyswatter"
	desc = "Útil para matar pragas de todos os tamanhos."
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "flyswatter"
	inhand_icon_state = "flyswatter"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 1
	throwforce = 1
	attack_verb_continuous = list("swats", "smacks")
	attack_verb_simple = list("swat", "smack")
	hitsound = 'sound/effects/snap.ogg'
	w_class = WEIGHT_CLASS_SMALL
	/// Things in this list will be instantly splatted.  Flyman weakness is handled in the flyman species weakness proc.
	var/static/list/splattable

/obj/item/melee/flyswatter/Initialize(mapload)
	. = ..()
	if (isnull(splattable))
		splattable = typecacheof(list(
			/mob/living/basic/ant,
			/mob/living/basic/butterfly,
			/mob/living/basic/cockroach,
			/mob/living/basic/cockroach/bloodroach,
			/mob/living/basic/spider/growing/spiderling,
			/mob/living/basic/bee,
			/obj/effect/decal/cleanable/ants,
			/obj/item/queen_bee,
		))
	AddElement(/datum/element/bane, mob_biotypes = MOB_BUG,  target_type = /mob/living/basic, damage_multiplier = 0, added_damage = 24, requires_combat_mode = FALSE)

/obj/item/melee/flyswatter/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(is_type_in_typecache(target, splattable))
		to_chat(user, span_warning("Você facilmente escorregou[target]."))
		if(QDELETED(target))
			return
		if(isliving(target))
			new /obj/effect/decal/cleanable/insectguts(target.drop_location())
			var/mob/living/bug = target
			bug.investigate_log("has been splatted by a flyswatter.", INVESTIGATE_DEATHS)
			bug.gib(DROP_ALL_REMAINS)
		else
			qdel(target)

/obj/item/proc/can_trigger_gun(mob/living/user, akimbo_usage)
	if(!user.can_use_guns(src))
		return FALSE
	return TRUE

/obj/item/gohei
	name = "gohei"
	desc = "Uma vara de madeira com serpentinas brancas no final. Originalmente usado por donzelas de santuário para purificar as coisas. Agora usado pelos valiosos Weeaboos da estação."
	resistance_flags = FLAMMABLE
	force = 5
	throwforce = 5
	hitsound = SFX_SWING_HIT
	attack_verb_continuous = list("whacks", "thwacks", "wallops", "socks")
	attack_verb_simple = list("whack", "thwack", "wallop", "sock")
	icon = 'icons/obj/weapons/club.dmi'
	icon_state = "gohei"
	inhand_icon_state = "gohei"
	icon_angle = -65
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'

/obj/item/melee/moonlight_greatsword
	name = "moonlight greatsword"
	desc = "Não diga a ninguém que colocou pontos no Dex."
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "swordon"
	inhand_icon_state = "swordon"
	worn_icon_state = "swordon"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	block_chance = 20
	block_sound = 'sound/items/weapons/parry.ogg'
	sharpness = SHARP_EDGED
	force = 14
	throwforce = 12
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "cut")
	var/list/alt_continuous = list("stabs", "pierces", "impales")
	var/list/alt_simple = list("stab", "pierce", "impale")

/obj/item/melee/moonlight_greatsword/Initialize(mapload)
	. = ..()
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple)
