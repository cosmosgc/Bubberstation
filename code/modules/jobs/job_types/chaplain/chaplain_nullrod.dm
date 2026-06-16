// CHAPLAIN NULLROD AND CUSTOM WEAPONS //

GLOBAL_LIST_INIT(nullrod_variants, init_nullrod_variants())

/proc/init_nullrod_variants()
	var/list/rods = list()
	for(var/obj/item/nullrod/nullrod_type as anything in typesof(/obj/item/nullrod))
		if(!nullrod_type::chaplain_spawnable)
			continue
		rods[nullrod_type] = nullrod_type::menu_description
	//special non-nullrod subtyped shit
	rods[/obj/item/toy/plush/carpplushie/nullrod] = "A plushie dealing a little less damage due to its cute form. 		Capable of blessing one person with the Carp-Sie favor, 		which grants friendship of all wild space carps. Fits in pockets. Can be worn on the belt."
	rods[/obj/item/gun/ballistic/bow/divine] = "A divine bow and 10 quivered holy arrows."
	rods[/obj/item/organ/cyberimp/arm/toolkit/shard/scythe] = "A shard that implants itself into your arm, 		allowing you to conjure forth a vorpal scythe. 		Allows you to behead targets for empowered strikes. 		Harms you if you dismiss the scythe without first causing harm to a creature. 		The shard also causes you to become Morbid, shifting your interests towards the macabre."
	rods[/obj/item/melee/skateboard/holyboard] = "A skateboard that grants you flight and anti-magic abilities while ridden. Fits in your bag."
	rods[/obj/item/storage/belt/sheath/hanzo_katana] = "A sharp katana which provides a low chance of blocking incoming melee attacks. Can be worn on the back or belt, wearing the sheath on belt allows for a swift counterattack."

	for(var/obj/item/melee/energy/sword/nullrod/energy_nullrod_type as anything in typesof(/obj/item/melee/energy/sword/nullrod))
		rods[energy_nullrod_type] = "An energy sword, but with a lower force, no armour penetration and a low chance of blocking. Can be switched on and off. 			Can be stored away easily while off, but impossible while on."
	// BUBBER EDIT ADDITION BEGIN
	rods[/obj/item/dualsaber/chaplain] = "A huge energy blade, it possesses the unique ability to block projectiles, but the unwieldy nature of it 	means that you'll be forced to move carefully while it's on. Fits in pockets, and can be worn on the belt when off."
	// BUBBER EDIT ADDITION END
	return rods

/obj/item/nullrod
	name = "null rod"
	desc = "Uma vara de obsidiana pura, sua própria presença rompe e amortece \"forças mágicas\". É o que diz o guia."
	icon = 'icons/obj/weapons/staff.dmi'
	icon_state = "nullrod"
	inhand_icon_state = "nullrod"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 18
	throw_speed = 3
	throw_range = 4
	throwforce = 10
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_TINY
	obj_flags = UNIQUE_RENAME
	wound_bonus = -10
	/// boolean on whether it's allowed to be picked from the nullrod's transformation ability
	var/chaplain_spawnable = TRUE
	/// Short description of what this item is capable of, for radial menu uses.
	var/menu_description = "A standard chaplain's weapon. Fits in pockets. Can be worn on the belt."
	/// Affects GLOB.holy_weapon_type. Disable to allow null rods to change at will and without affecting the station's type.
	var/station_holy_item = TRUE

/obj/item/nullrod/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/nullrod_core, chaplain_spawnable)

	if((GLOB.holy_weapon_type && station_holy_item) || type != /obj/item/nullrod)
		return
	AddComponent(/datum/component/subtype_picker, GLOB.nullrod_variants, CALLBACK(src, PROC_REF(on_holy_weapon_picked)))

/// Callback for subtype picker, invoked when the chaplain picks a new nullrod
/obj/item/nullrod/proc/on_holy_weapon_picked(obj/item/nullrod/new_holy_weapon, mob/living/picker)
	if(!station_holy_item)
		return
	GLOB.holy_weapon_type = new_holy_weapon.type
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_NULLROD_PICKED)
	SSblackbox.record_feedback("tally", "chaplain_weapon", 1, "[new_holy_weapon.name]")

/obj/item/nullrod/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] está matando [user.p_them()] ego com [src] Parece que...[user.p_theyre()] Tentando chegar mais perto de Deus!"))
	return (BRUTELOSS|FIRELOSS)


/obj/item/nullrod/non_station
	station_holy_item = FALSE
	chaplain_spawnable = FALSE

/// Claymore Variant
/// This subtype possesses a block chance and is sharp.

/obj/item/nullrod/claymore
	name = "holy claymore"
	desc = "Uma arma adequada para uma cruzada!"
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "claymore_gold"
	inhand_icon_state = "claymore_gold"
	worn_icon_state = "claymore_gold"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	block_chance = 30
	block_sound = 'sound/items/weapons/parry.ogg'
	sharpness = SHARP_EDGED
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "cut")
	menu_description = "Um claymore afiado que proporciona uma baixa chance de bloquear ataques melee. Pode ser usado nas costas ou no cinto."
	var/list/alt_continuous = list("stabs", "pierces", "impales")
	var/list/alt_simple = list("stab", "pierce", "impale")

/obj/item/nullrod/claymore/Initialize(mapload)
	. = ..()
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple, -3)

/obj/item/nullrod/claymore/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == PROJECTILE_ATTACK || attack_type == LEAP_ATTACK || attack_type == OVERWHELMING_ATTACK)
		final_block_chance = 0 //Don't bring a sword to a gunfight, and also you aren't going to really block someone full body tackling you with a sword. Or a road roller, if one happened to hit you.
	return ..()

/obj/item/nullrod/claymore/darkblade
	name = "dark blade"
	desc = "Espalhem a glória dos deuses das trevas!"
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "cultblade"
	inhand_icon_state = "cultblade"
	worn_icon_state = "cultblade"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	hitsound = 'sound/effects/hallucinations/growl1.ogg'
	menu_description = "Uma lâmina afiada que proporciona uma baixa chance de bloquear ataques melee. Pode ser usado nas costas ou no cinto."

/obj/item/nullrod/claymore/chainsaw_sword
	name = "sacred chainsaw sword"
	desc = "Não sofra um herege para viver."
	icon_state = "chainswordon"
	inhand_icon_state = "chainswordon"
	worn_icon_state = "chainswordon"
	slot_flags = ITEM_SLOT_BELT
	attack_verb_continuous = list("saws", "tears", "lacerates", "cuts", "chops", "dices")
	attack_verb_simple = list("saw", "tear", "lacerate", "cut", "chop", "dice")
	hitsound = 'sound/items/weapons/chainsawhit.ogg'
	tool_behaviour = TOOL_SAW
	toolspeed = 1.5 //slower than a real saw
	menu_description = "Uma espada cortante que proporciona uma baixa chance de bloquear ataques de melee. Pode ser usado como uma ferramenta de serra mais lenta. Pode ser usado no cinto."

/obj/item/nullrod/claymore/glowing
	name = "force weapon"
	desc = "A lâmina brilha com o poder da fé. Ou possivelmente uma bateria."
	icon_state = "swordon"
	inhand_icon_state = "swordon"
	worn_icon_state = "swordon"
	menu_description = "Uma arma afiada que proporciona baixa chance de bloquear ataques de melee. Pode ser usado nas costas ou no cinto."

/obj/item/nullrod/claymore/katana
	name = "\improper Hanzo steel"
	desc = "Capaz de cortar através de um barro sagrado."
	icon_state = "katana"
	inhand_icon_state = "katana"
	pickup_sound = 'sound/items/unsheath.ogg'
	slot_flags = NONE
	chaplain_spawnable = FALSE

/obj/item/nullrod/claymore/multiverse
	name = "extradimensional blade"
	desc = "Uma vez que o prenúncio de uma guerra interdimensional, sua nitidez flutua selvagemmente."
	icon_state = "multiverse"
	inhand_icon_state = "multiverse"
	worn_icon_state = "multiverse"
	slot_flags = ITEM_SLOT_BACK
	force = 15
	menu_description = "Uma estranha lâmina afiada que proporciona uma baixa chance de bloquear ataques e causar uma quantidade aleatória de danos, que pode variar de quase nada a muito alto. Pode ser usado atrás."

/obj/item/nullrod/claymore/multiverse/pre_attack(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
	SET_ATTACK_FORCE(attack_modifiers, rand(max(force - 15, 1), force + 15))
	return ..()

/obj/item/nullrod/claymore/spellblade
	name = "dormant spellblade"
	desc = "A lâmina dá ao empunhador poder quase ilimitado... se eles podem descobrir como ligá-lo, isto é."
	icon = 'icons/obj/weapons/guns/magic.dmi'
	icon_state = "spellblade"
	inhand_icon_state = "spellblade"
	slot_flags = ITEM_SLOT_BACK
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	worn_icon_state = "spellblade"
	hitsound = 'sound/items/weapons/rapierhit.ogg'
	menu_description = "Uma lâmina afiada que proporciona uma baixa chance de bloquear ataques melee. Pode ser usado atrás."

/obj/item/nullrod/claymore/talking
	name = "possessed blade"
	desc = "Quando a estação cai no caos, é bom ter um amigo ao seu lado."
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "talking_sword"
	inhand_icon_state = "talking_sword"
	slot_flags = ITEM_SLOT_BACK
	icon_angle = 45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	worn_icon_state = "talking_sword"
	attack_verb_continuous = list("chops", "slices", "cuts")
	attack_verb_simple= list("chop", "slice", "cut")
	hitsound = 'sound/items/weapons/rapierhit.ogg'
	menu_description = "Uma lâmina afiada que proporciona uma baixa chance de bloquear ataques melee. Capaz de despertar um espírito amigável para fornecer orientação. Pode ser usado atrás."

/obj/item/nullrod/claymore/talking/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/spirit_holding)

/obj/item/nullrod/claymore/talking/chainsword
	name = "possessed chainsaw sword"
	desc = "Não sofra um herege para viver."
	icon_state = "chainswordon"
	inhand_icon_state = "chainswordon"
	worn_icon_state = "chainswordon"
	force = 30
	slot_flags = ITEM_SLOT_BELT
	attack_verb_continuous = list("saws", "tears", "lacerates", "cuts", "chops", "dices")
	attack_verb_simple = list("saw", "tear", "lacerate", "cut", "chop", "dice")
	hitsound = 'sound/items/weapons/chainsawhit.ogg'
	tool_behaviour = TOOL_SAW
	toolspeed = 0.5 //same speed as an active chainsaw
	chaplain_spawnable = FALSE //prevents being pickable as a chaplain weapon (it has 30 force)

/obj/item/nullrod/claymore/talking/chainsword/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/cuffable_item) //Thanks goodness it cannot be selected by chappies
	AddComponent(
		/datum/component/butchering, 		speed = 7 SECONDS, 		effectiveness = 110, 	)

/obj/item/nullrod/claymore/heretic
	name = "occultist's khopesh"
	desc = "Faz sua mão matar inimigos além da compreensão."
	icon = 'icons/obj/weapons/khopesh.dmi'
	icon_state = "eldritch_blade"
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	inhand_icon_state = "eldritch_blade"
	worn_icon_state = "eldritch_blade"
	menu_description = "Uma lâmina curva afiada que proporciona uma baixa chance de bloquear ataques de melee. Pode ser usado nas costas ou no cinto."

/// Other Variants
/// Not a special category on their own, but usually possess more unique mechanics

// High Frequency Blade - Two-handed, has armor penetration, and can block exosuit attacks relatively easily. Can't block anything else.

/obj/item/nullrod/vibro
	name = "high frequency blade"
	desc = "Más referências são o DNA da alma."
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "hfrequency0"
	inhand_icon_state = "hfrequency0"
	base_icon_state = "hfrequency"
	worn_icon_state = "hfrequency0"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	force = 10
	armour_penetration = 35
	block_chance = 40
	slot_flags = ITEM_SLOT_BACK
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("chops", "slices", "cuts", "zandatsu's")
	attack_verb_simple = list("chop", "slice", "cut", "zandatsu")
	hitsound = 'sound/items/weapons/rapierhit.ogg'
	block_sound = 'sound/items/weapons/parry.ogg'
	menu_description = "Uma lâmina afiada que penetra parcialmente na armadura. Incomum adepto em bloquear ataques melee de exossuits. Muito eficaz em massacrar corpos. Pode ser usado atrás."
	var/list/alt_continuous = list("stabs", "pierces", "impales")
	var/list/alt_simple = list("stab", "pierce", "impale")

/obj/item/nullrod/vibro/Initialize(mapload)
	. = ..()
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple, -3)
	AddComponent(/datum/component/two_handed, 		force_unwielded = 10, 		force_wielded = 18, 	)
	AddComponent(
		/datum/component/butchering, 		speed = 7 SECONDS, 		effectiveness = 110, 	)

/obj/item/nullrod/vibro/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(prob(final_block_chance * (HAS_TRAIT(src, TRAIT_WIELDED) ? 2 : 1)) && attack_type == OVERWHELMING_ATTACK)
		owner.visible_message(span_danger("[owner] Parries [attack_text] Com [src]!"))
		return TRUE
	return FALSE

/obj/item/nullrod/vibro/update_icon_state()
	icon_state = inhand_icon_state = "[base_icon_state][HAS_TRAIT(src, TRAIT_WIELDED)]"
	return ..()

// God Hand - Cannot be dropped. Does burn damage.

/obj/item/nullrod/godhand
	name = "god hand"
	desc = "Essa sua mão brilha com um poder incrível!"
	icon = 'icons/obj/weapons/hand.dmi'
	icon_state = "disintegrate"
	inhand_icon_state = "disintegrate"
	lefthand_file = 'icons/mob/inhands/items/touchspell_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/touchspell_righthand.dmi'
	slot_flags = null
	item_flags = ABSTRACT | DROPDEL
	resistance_flags = FIRE_PROOF|ACID_PROOF
	w_class = WEIGHT_CLASS_HUGE
	hitsound = 'sound/items/weapons/sear.ogg'
	damtype = BURN
	attack_verb_continuous = list("punches", "cross counters", "pummels")
	attack_verb_simple = list(SFX_PUNCH, "cross counter", "pummel")
	menu_description = "Uma mão de Deus indestrutível que lida com danos. Desaparece se o braço que segura for cortado."

/obj/item/nullrod/godhand/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HAND_REPLACEMENT_TRAIT)

// Red/Blue Holy Staff - 50% block chance, almost no damage at all.

/obj/item/nullrod/staff
	name = "red holy staff"
	desc = "Tem uma misteriosa aura protetora."
	icon = 'icons/obj/weapons/staff.dmi'
	icon_state = "godstaff-red"
	inhand_icon_state = "godstaff-red"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	force = 5
	slot_flags = ITEM_SLOT_BACK
	block_chance = 50
	block_sound = 'sound/items/weapons/genhit.ogg'
	menu_description = "Uma equipe vermelha que oferece uma chance média de bloquear ataques por uma aura vermelha protetora em torno de seu usuário, mas causa muito pouco dano. Pode ser usado apenas na parte de trás."
	/// The icon which appears over the mob holding the item
	var/shield_icon = "shield-red"

/obj/item/nullrod/staff/worn_overlays(mutable_appearance/standing, isinhands)
	. = ..()
	if(isinhands)
		. += mutable_appearance('icons/effects/effects.dmi', shield_icon, MOB_SHIELD_LAYER)

/obj/item/nullrod/staff/blue
	name = "blue holy staff"
	icon_state = "godstaff-blue"
	inhand_icon_state = "godstaff-blue"
	shield_icon = "shield-old"
	menu_description = "Uma equipe azul que oferece uma chance média de bloquear ataques por uma aura azul protetora em torno de seu usuário, mas causa muito baixa quantidade de danos. Pode ser usado apenas na parte de trás."

// SORD - It is unspeakably shitty.

/obj/item/nullrod/sord
	name = "\improper UNREAL SORD"
	desc = "Essa coisa é tão indescritivelmente sagrada que você está tendo dificuldade em segurá-la."
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "sord"
	inhand_icon_state = "sord"
	worn_icon_state = "sord"
	icon_angle = -35
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 4.13
	throwforce = 1
	slot_flags = ITEM_SLOT_BELT
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	menu_description = "Um s (w)ord estranho traficando uma quantidade risível de danos. Encaixa nos bolsos. Pode ser usado no cinto."

/obj/item/nullrod/sord/suicide_act(mob/living/user) //a near-exact copy+paste of the actual sord suicide_act()
	user.visible_message(span_suicide("[user] Está tentando empalar [user.p_them()] ego com [src]! Poderia ser uma tentativa de suicídio se não fosse tão santo."), 	span_suicide("Você tenta empalar-se com [src], mas é muito santo ..."))
	return SHAME

// Relic War Hammer - Nothing special.

/obj/item/nullrod/hammer
	name = "relic war hammer"
	desc = "Este martelo de guerra custou 40 mil dólares ao capelão."
	icon = 'icons/obj/weapons/hammer.dmi'
	icon_state = "hammeron"
	inhand_icon_state = "hammeron"
	worn_icon_state = "hammeron"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/hammers_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/hammers_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("smashes", "bashes", "hammers", "crunches")
	attack_verb_simple = list("smash", "bash", "hammer", "crunch")
	menu_description = "Um martelo de guerra. Capaz de bater nos joelhos para medir a saúde cerebral. Pode ser usado no cinto."

/obj/item/nullrod/hammer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/kneejerk)

// Chainsaw Hand - Cannot be dropped.

/obj/item/nullrod/chainsaw
	name = "chainsaw hand"
	desc = "Bom? Ruim? Você é o cara com a motosserra."
	icon = 'icons/obj/weapons/chainsaw.dmi'
	icon_state = "chainsaw_on"
	base_icon_state = "chainsaw_on"
	lefthand_file = 'icons/mob/inhands/weapons/chainsaw_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/chainsaw_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = null
	item_flags = ABSTRACT
	resistance_flags = FIRE_PROOF|ACID_PROOF
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("saws", "tears", "lacerates", "cuts", "chops", "dices")
	attack_verb_simple = list("saw", "tear", "lacerate", "cut", "chop", "dice")
	hitsound = 'sound/items/weapons/chainsawhit.ogg'
	tool_behaviour = TOOL_SAW
	toolspeed = 2 //slower than a real saw
	menu_description = "Uma mão de motosserra afiada. Pode ser usado como uma ferramenta de serra muito lenta. Capaz de matar corpos lentamente. Desaparece se o braço que segura for cortado."

/obj/item/nullrod/chainsaw/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/prosthetic_icon, "mounted", 180)
	AddComponent(/datum/component/butchering, 		speed = 3 SECONDS, 		effectiveness = 100, 		bonus_modifier = 0, 		butcher_sound = hitsound, 	)
	RegisterSignal(src, COMSIG_ITEM_SUBTYPE_PICKER_SELECTED, PROC_REF(on_selected))

/obj/item/nullrod/chainsaw/proc/on_selected(datum/source, obj/item/nullrod/old_weapon, mob/living/picker)
	SIGNAL_HANDLER
	if(!iscarbon(picker))
		return
	to_chat(picker, span_warning("[src] Tome o lugar do seu braço!"))
	var/obj/item/bodypart/active = picker.get_active_hand()
	var/mob/living/carbon/new_hero = picker
	new_hero.make_item_prosthetic(src, active.body_zone)

/obj/item/nullrod/chainsaw/equipped(mob/living/carbon/user, slot, initial)
	. = ..()
	if(!iscarbon(user) || HAS_TRAIT_FROM(src, TRAIT_NODROP, HAND_REPLACEMENT_TRAIT))
		return
	if(!(slot & ITEM_SLOT_HANDS))
		return
	to_chat(user, span_warning("Enquanto você coloca suas mãos [src], ele trava em seu braço!"))
	var/obj/item/bodypart/active = user.get_active_hand()
	user.make_item_prosthetic(src, active.body_zone)

// Clown Dagger - Nothing special, just honks.

/obj/item/nullrod/clown
	name = "clown dagger"
	desc = "Usado para sacrifícios hilários."
	icon = 'icons/obj/weapons/khopesh.dmi'
	icon_state = "clownrender"
	inhand_icon_state = "cultdagger"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	worn_icon_state = "render"
	hitsound = 'sound/items/bikehorn.ogg'
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "cut")
	menu_description = "Uma adaga afiada. Encaixa em bolsos. Pode ser usado no cinto. Honk."

// Pride-struck Hammer - Transfers reagents in your body to those you hit.

#define CHEMICAL_TRANSFER_CHANCE 30

/obj/item/nullrod/pride_hammer
	name = "Pride-struck Hammer"
	desc = "Ressoa uma aura do orgulho."
	icon = 'icons/obj/weapons/hammer.dmi'
	icon_state = "pride"
	inhand_icon_state = "pride"
	worn_icon_state = "pride"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/hammers_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/hammers_righthand.dmi'
	force = 16
	throwforce = 15
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("attacks", "smashes", "crushes", "splatters", "cracks")
	attack_verb_simple = list("attack", "smash", "crush", "splatter", "crack")
	hitsound = 'sound/items/weapons/blade1.ogg'
	menu_description = "Um martelo traficando menos danos devido ao orgulho de seu usuário. Tem poucas chances de transferir alguns reagentes para o alvo. Capaz de bater nos joelhos para medir a saúde cerebral. Pode ser usado atrás."

/obj/item/nullrod/pride_hammer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/kneejerk)
	AddElement(
		/datum/element/chemical_transfer,		span_notice("Seu orgulho reflete em %VICTIM."),		span_userdanger("Você se sente inseguro, assumindo o fardo do Attacker."),		CHEMICAL_TRANSFER_CHANCE	)

#undef CHEMICAL_TRANSFER_CHANCE

// Holy Whip - Does more damage to vampires.

/obj/item/nullrod/whip
	name = "holy whip"
	desc = "Que noite terrível para estar na Estação Espacial 13."
	icon = 'icons/obj/weapons/whip.dmi'
	icon_state = "chain"
	inhand_icon_state = "chain"
	worn_icon_state = "whip"
	icon_angle = -90
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	attack_verb_continuous = list("whips", "lashes")
	attack_verb_simple = list("whip", "lash")
	hitsound = 'sound/items/weapons/chainhit.ogg'
	menu_description = "Um chicote. Dá dano extra a vampiros. Encaixa em bolsos. Pode ser usado no cinto."

// Atheist's Fedora - Wear it on your head. No melee damage, massive throw force.

/obj/item/nullrod/fedora
	name = "atheist's fedora"
	desc = "A borda do chapéu é tão afiada quanto sua inteligência. A borda doeria quase tanto quanto refutar a existência de Deus."
	icon_state = "fedora"
	inhand_icon_state = "fedora"
	slot_flags = ITEM_SLOT_HEAD
	icon = 'icons/obj/clothing/head/hats.dmi'
	worn_icon = 'icons/mob/clothing/head/hats.dmi'
	lefthand_file = 'icons/mob/inhands/clothing/hats_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/hats_righthand.dmi'
	force = 0
	throw_speed = 4
	throw_range = 7
	throwforce = 30
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("enlightens", "redpills")
	attack_verb_simple = list("enlighten", "redpill")
	menu_description = "Um fedora afiada traficando uma grande quantidade de danos, mas nenhum de mime. Encaixa em bolsos. Pode ser usado na cabeça, obviamente."

/obj/item/nullrod/fedora/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] está matando [user.p_them()] ego com [src] Parece que...[user.p_theyre()] Tentando mais longe de Deus!"))
	return (BRUTELOSS|FIRELOSS)

// Dark Blessing - Replaces your arm with an armblade. Cannot be dropped.

/obj/item/nullrod/armblade
	name = "dark blessing"
	desc = "Deidades especialmente distorcidas dão presentes de valor duvidoso."
	icon = 'icons/obj/weapons/changeling_items.dmi'
	icon_state = "arm_blade"
	inhand_icon_state = "arm_blade"
	icon_angle = 180
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	slot_flags = null
	item_flags = ABSTRACT
	resistance_flags = FIRE_PROOF|ACID_PROOF
	w_class = WEIGHT_CLASS_HUGE
	sharpness = SHARP_EDGED
	wound_bonus = -20
	exposed_wound_bonus = 25
	menu_description = "Uma lâmina afiada e sem gota capaz de causar ferimentos profundos. Capaz de um massacre ineficaz de corpos. Desaparece se o braço que segura for cortado."

/obj/item/nullrod/armblade/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HAND_REPLACEMENT_TRAIT)
	AddComponent(/datum/component/butchering, 	speed = 8 SECONDS, 	effectiveness = 70, 	)

// Unholy Blessing - Just a reskinned dark blessing.

/obj/item/nullrod/armblade/tentacle
	name = "unholy blessing"
	icon_state = "tentacle"
	inhand_icon_state = "tentacle"
	menu_description = "Um tentáculo afiado e improvável capaz de causar feridas profundas. Capaz de um massacre ineficaz de corpos. Desaparece se o braço que segura for cortado."

// Carp-sie Plushie - Gives you the carp faction so that you can be friends with carp.

/obj/item/toy/plush/carpplushie/nullrod
	name = "carp-sie plushie"
	desc = "Um adorável brinquedo de pelúcia que se parece com o deus da carpa. Os dentes parecem bem afiados. Ative-o para receber a bênção da Carpa-Sie."
	worn_icon_state = "nullrod"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	force = 15
	obj_flags = parent_type::obj_flags | UNIQUE_RENAME
	offspring_type = /obj/item/toy/plush/carpplushie
	divine = TRUE

/obj/item/toy/plush/carpplushie/nullrod/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/nullrod_core)
	AddComponent(/datum/component/faction_granter, FACTION_CARP, holy_role_required = HOLY_ROLE_PRIEST, grant_message = span_boldnotice("Você é abençoado pela Carp-Sie. A carpa espacial selvagem não vai mais te atacar."))

// Monk's Staff - Good block, two-handed. Great for showing off.

/obj/item/nullrod/bostaff
	name = "monk's staff"
	desc = "Um cajado longo e alto feito de madeira polida. Tradicionalmente usado em artes marciais antigas da Terra, agora é usado para assediar o palhaço."
	force = 10
	block_chance = 40
	block_sound = 'sound/items/weapons/genhit.ogg'
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	hitsound = SFX_SWING_HIT
	attack_verb_continuous = list("smashes", "slams", "whacks", "thwacks")
	attack_verb_simple = list("smash", "slam", "whack", "thwack")
	icon = 'icons/obj/weapons/staff.dmi'
	icon_state = "bostaff0"
	base_icon_state = "bostaff"
	inhand_icon_state = "bostaff0"
	worn_icon_state = "bostaff0"
	icon_angle = -135
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	menu_description = "Uma equipe que oferece uma chance média baixa de bloquear ataques e causar menos danos, a menos que seja dupla. Pode ser usado atrás."

/obj/item/nullrod/bostaff/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, 		force_unwielded = 14, 		force_wielded = 18, 	)

/obj/item/nullrod/bostaff/update_icon_state()
	icon_state = inhand_icon_state = "[base_icon_state][HAS_TRAIT(src, TRAIT_WIELDED)]"
	return ..()

/obj/item/nullrod/bostaff/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == PROJECTILE_ATTACK || attack_type == LEAP_ATTACK || attack_type == OVERWHELMING_ATTACK)
		final_block_chance = 0 //Don't bring a stick to a gunfight, and also you aren't going to really block someone full body tackling you with a stick. Or a road roller, if one happened to hit you.
	return ..()

// Arrhythmic Knife - Lets your walk without rhythm by varying your walk speed. Can't be put away.

/obj/item/nullrod/tribal_knife
	name = "arrhythmic knife"
	desc = "Dizem que o medo é o verdadeiro assassino mental, mas esfaqueá-los também funciona. A honra o obriga a não relembrar uma vez."
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "crysknife"
	inhand_icon_state = "crysknife"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	sharpness = SHARP_EDGED
	slot_flags = null
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "cut")
	item_flags = SLOWS_WHILE_IN_HAND
	menu_description = "Uma faca afiada. Aleatoriamente acelera ou retarda seu usuário em intervalos regulares. Capaz de matar corpos. Não pode ser usado em lugar algum."
	var/list/alt_continuous = list("stabs", "pierces", "impales")
	var/list/alt_simple = list("stab", "pierce", "impale")

/obj/item/nullrod/tribal_knife/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple, -3)
	AddComponent(/datum/component/butchering, 	speed = 5 SECONDS, 	effectiveness = 100, 	)

/obj/item/nullrod/tribal_knife/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/nullrod/tribal_knife/process()
	slowdown = rand(-10, 10)/10
	if(iscarbon(loc))
		var/mob/living/carbon/wielder = loc
		if(wielder.is_holding(src))
			wielder.update_equipment_speed_mods()

// Unholy Pitchfork - Does absolutely nothing special, it is just bigger.

/obj/item/nullrod/pitchfork
	name = "unholy pitchfork"
	desc = "Segurar isso faz você parecer absolutamente diabólico."
	icon = 'icons/obj/weapons/spear.dmi'
	icon_state = "pitchfork0"
	inhand_icon_state = "pitchfork0"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	worn_icon_state = "pitchfork0"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("pokes", "impales", "pierces", "jabs")
	attack_verb_simple = list("poke", "impale", "pierce", "jab")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	menu_description = "Um garfo afiado. Pode ser usado atrás."

// Egyptian Staff - Used as a tool for making mummy wraps.

/obj/item/nullrod/egyptian
	name = "egyptian staff"
	desc = "Um tutorial de mumificação é esculpido na equipe. Você provavelmente poderia preparar os envoltórios se tivesse algum pano."
	icon = 'icons/obj/weapons/guns/magic.dmi'
	icon_state = "pharoah_sceptre"
	inhand_icon_state = "pharoah_sceptre"
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	worn_icon_state = "pharoah_sceptre"
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("bashes", "smacks", "whacks")
	attack_verb_simple = list("bash", "smack", "whack")
	menu_description = "Uma equipe. Pode ser usado como ferramenta para criar itens egípcios exclusivos. Facilmente armazenado. Pode ser usado atrás."

// Hypertool - It does brain damage rather than normal damage.

/obj/item/nullrod/hypertool
	name = "hypertool"
	desc = "Uma ferramenta tão poderosa que nem você pode usá-la perfeitamente."
	icon = 'icons/obj/weapons/club.dmi'
	icon_state = "hypertool"
	inhand_icon_state = "hypertool"
	worn_icon_state = "hypertool"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	damtype = BRAIN
	armour_penetration = 35
	attack_verb_continuous = list("pulses", "mends", "cuts")
	attack_verb_simple = list("pulse", "mend", "cut")
	hitsound = 'sound/effects/sparks/sparks4.ogg'
	menu_description = "Uma ferramenta que lida com danos cerebrais que penetra parcialmente na armadura. Encaixa nos bolsos. Pode ser usado no cinto."

// Ancient Spear - Slight armor penetration, based on the Brass Spear from the Clockcult game mode.

/obj/item/nullrod/spear
	name = "ancient spear"
	desc = "Uma lança antiga feita de bronze, quero dizer ouro, quero dizer bronze. Parece altamente mecânico."
	icon = 'icons/obj/weapons/spear.dmi'
	icon_state = "ratvarian_spear"
	inhand_icon_state = "ratvarian_spear"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/antag/clockwork_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/clockwork_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	armour_penetration = 10
	sharpness = SHARP_POINTY
	w_class = WEIGHT_CLASS_HUGE
	attack_verb_continuous = list("stabs", "pokes", "slashes", "clocks")
	attack_verb_simple = list("stab", "poke", "slash", "clock")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	menu_description = "Uma lança pontuda que penetra um pouco na armadura. Só pode ser usado no cinto."

// Unholy version of above, since the gamemode is dead in the water

/obj/item/brass_spear
	name = "dull brass spear"
	desc = "Uma lança antiga feita de bronze. O ponto parece afiado, mas parece tão chato... que você sente que latão não é bom material não mágico para uma arma."
	icon = 'icons/obj/weapons/spear.dmi'
	icon_state = "ratvarian_spear"
	inhand_icon_state = "ratvarian_spear"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/antag/clockwork_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/clockwork_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 15
	throw_speed = 3
	throw_range = 7
	throwforce = 15
	armour_penetration = 10
	sharpness = SHARP_POINTY
	w_class = WEIGHT_CLASS_HUGE
	attack_verb_continuous = list("stabs", "pokes", "slashes", "clocks")
	attack_verb_simple = list("stab", "poke", "slash", "clock")
	hitsound = 'sound/items/weapons/bladeslice.ogg'

// Nullblade - For when you really want to feel like rolling dice during combat

/obj/item/nullrod/nullblade
	name = "nullblade"
	desc = "Assassinos não são oficialmente reconhecidos pelas crenças coletivas de Nanotrasen. E ainda assim, aqui está você."
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "nullsword"
	inhand_icon_state = "nullsword"
	worn_icon_state = "nullsword"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	force = 12
	wound_bonus = 10
	exposed_wound_bonus = 30
	slot_flags = ITEM_SLOT_BELT
	block_sound = 'sound/items/weapons/parry.ogg'
	sharpness = SHARP_EDGED
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slashes", "slice", "tear", "lacerate", "rip", "dice", "cut")
	menu_description = "Uma lâmina que lida com danos variáveis, mas facilmente inflige ferimentos. Quanto mais forte seu braço oscilante é, mais forte é a lâmina, embora apenas ligeiramente. Contra alvos debilitados, também pode lidar com danos adicionais de ataque com uma grande chance de ferimentos."

	var/list/alt_continuous = list("stabs", "pierces", "impales", "punctures")
	var/list/alt_simple = list("stab", "pierce", "impale", "puncture")

/obj/item/nullrod/nullblade/Initialize(mapload)
	. = ..()
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple)

/obj/item/nullrod/nullblade/pre_attack(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
	//Check for our user's potential 'strength' value. As a baseline, we'll use a default value of 4 for the sake of nonhuman users.
	var/strength_value = 4
	// We can use our human wielder's arm strength to determine their 'strength'. We add unarmed lower and upper, then divide by four.
	// This isn't how strength works in dnd but who fucking cares.
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		var/obj/item/bodypart/wielding_bodypart = human_user.get_active_hand()
		strength_value = round((wielding_bodypart.unarmed_damage_low + wielding_bodypart.unarmed_damage_high) * 0.25, 1)
	// Our force becomes 1d6 + strength + some modifier (based on force - base force) to account for whetstones and other things.
	SET_ATTACK_FORCE(attack_modifiers, roll("1d6") + strength_value + (force - initial(force)))
	return ..()

/obj/item/nullrod/nullblade/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(!isliving(target))
		return

	var/mob/living/living_target = target

	if(user == living_target)
		return

	if(living_target.stat == DEAD || QDELETED(living_target))
		return

	sneak_attack(living_target, user)

/// If our target is incapacitated, unable to protect themselves, or we attack them from behind, we sneak attack!
/obj/item/nullrod/nullblade/proc/sneak_attack(mob/living/living_target, mob/user)
	// Did we successfully meet the criteria for a sneak attack?
	var/successful_sneak_attack = FALSE

	// Did our sneak attack fail due to a special effect?
	var/sneak_attack_fail_message = FALSE

	// The force our sneak attack applies. Starts as 3d6, then changed based on certain factors.
	var/sneak_attack_dice = roll("3d6")

	// Status effects on the target that grant us sneak attacks
	if(living_target.is_blind())
		successful_sneak_attack = TRUE

	else if(living_target.get_timed_status_effect_duration(/datum/status_effect/staggered))
		successful_sneak_attack = TRUE

	else if(living_target.get_timed_status_effect_duration(/datum/status_effect/confusion))
		successful_sneak_attack = TRUE

	// Our target is in some kind of grapple, which prevents them form protecting themselves.
	else if(living_target.pulledby && living_target.pulledby.grab_state >= GRAB_AGGRESSIVE)
		successful_sneak_attack = TRUE

	// blocked hands renders you unable to defend yourself properly from an attack
	else if(HAS_TRAIT(living_target, TRAIT_HANDS_BLOCKED))
		successful_sneak_attack = TRUE

	// Check for various positional outcomes to determine a sneak attack. We want to sneak attack whenever our target is behind.
	else if(check_behind(user, living_target))
		successful_sneak_attack = TRUE

	/// Now we'll check for things that STOP a sneak attack. Why? Because this mechanic isn't complicated enough and I must insert more ivory tower design.

	if(living_target.mob_biotypes & MOB_SLIME) // SLIMES HAVE NO ANATOMY.
		successful_sneak_attack = FALSE
		sneak_attack_fail_message = TRUE

	else if(living_target.incorporeal_move >= 1 && !HAS_TRAIT(living_target, TRAIT_REVENANT_REVEALED)) // WE CAN'T SNEAK ATTACK INCORPOREAL JERKS. BUT WE CAN SNEAK ATTACK REVEALED REVENANTS BECAUSE DUH, NULLROD.
		successful_sneak_attack = FALSE
		sneak_attack_fail_message = TRUE

	else if(HAS_TRAIT(living_target, TRAIT_HERETIC_SUMMON) && prob(50)) // IT IS HARD TO SNEAK ATTACK SOMETHING WITH TOO MANY REDUNDANT EVERYTHINGS.
		successful_sneak_attack = FALSE
		sneak_attack_fail_message = TRUE

	else if(HAS_TRAIT(living_target, TRAIT_STABLEHEART) && prob(50)) // THEIR ANATOMY IS FUCKING WEIRD.
		successful_sneak_attack = FALSE
		sneak_attack_fail_message = TRUE

	else if(HAS_TRAIT(living_target, TRAIT_MIND_READER) && !user.can_block_magic(MAGIC_RESISTANCE_MIND, charge_cost = 0)) // FORESIGHT SAYS 'FUCK YOU' TO SNEAK ATTACKERS. BUT IF YOU HAVE A TIN FOIL HAT, YOU'RE SAFE!
		successful_sneak_attack = FALSE
		sneak_attack_fail_message = TRUE

	else if(user.is_blind()) // YOU CAN'T STAB PRECISELY WHAT YOU CAN'T SEE.
		successful_sneak_attack = FALSE
		sneak_attack_fail_message = TRUE

	/// And so we return here if we are not entitled to a sneak attack.
	if(!successful_sneak_attack)
		if(sneak_attack_fail_message)
			user.balloon_alert(living_target, "Ataque furtivo evitado!")
		return

	/// And now we'll deal with sneak attack damage modifiers.

	// If our target is also unconscious for some reason, we get even more damage. Coup de grace, motherfucker.
	if(HAS_TRAIT(living_target, TRAIT_KNOCKEDOUT))
		sneak_attack_dice += roll("1d6")
		new /obj/effect/temp_visual/crit(get_turf(living_target))

	// If the target is rebuked, we also add some additional damage. It is the closest thing to 'studying' your target, okay?
	if(living_target.has_status_effect(/datum/status_effect/rebuked))
		sneak_attack_dice += 2

	// If we're morbid, and the target has been dissected, we get an extra d6.
	// The chances of this occuring are quite low, as even having this weapon means you're locked out of becoming morbid as a chaplain, but when it does come up...
	// Or the coroner stole this blade to go hunt the recently dead...
	if(HAS_TRAIT(user, TRAIT_MORBID) && HAS_TRAIT(living_target, TRAIT_DISSECTED))
		sneak_attack_dice += roll("1d6")

	// Baton + this weapon might be a little too much fun so we're nerfing this combination outright.
	if(HAS_TRAIT(living_target, TRAIT_IWASBATONED))
		sneak_attack_dice *= 0.5

	// Affecting body part check.
	var/obj/item/bodypart/affecting = living_target.get_bodypart(user.get_random_valid_zone(user.zone_selected))
	// Target's armor value. Accounts for armor penetration even though we have no armour_penetration defined on the parent.
	var/armor_block = living_target.run_armor_check(affecting, MELEE, armour_penetration = armour_penetration)

	// We got a sneak attack!
	living_target.apply_damage(round(sneak_attack_dice, DAMAGE_PRECISION), BRUTE, def_zone = affecting, blocked = armor_block, wound_bonus = exposed_wound_bonus, sharpness = SHARP_EDGED)
	living_target.balloon_alert(user, "Ataque furtivo!")
	playsound(living_target, 'sound/items/weapons/guillotine.ogg', 50, TRUE)
