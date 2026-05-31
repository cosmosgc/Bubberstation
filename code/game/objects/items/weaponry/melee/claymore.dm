/obj/item/claymore
	name = "claymore"
	desc = "Por que está olhando para isso? Comecem a matar!"
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "claymore"
	inhand_icon_state = "claymore"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	force = 40
	throwforce = 10
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "cut")
	block_chance = 50
	block_sound = 'sound/items/weapons/parry.ogg'
	sharpness = SHARP_EDGED
	max_integrity = 200
	armor_type = /datum/armor/item_claymore
	resistance_flags = FIRE_PROOF
	var/list/alt_continuous = list("stabs", "pierces", "impales")
	var/list/alt_simple = list("stab", "pierce", "impale")

/datum/armor/item_claymore
	fire = 100
	acid = 50

/obj/item/claymore/Initialize(mapload)
	. = ..()
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	make_stabby()
	AddComponent(/datum/component/butchering, 	speed = 4 SECONDS, 	effectiveness = 105, 	)

// Applies alt sharpness component, for overrides
/obj/item/claymore/proc/make_stabby()
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple, -15)

/obj/item/claymore/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]está caindo sobre[src]Parece que...[user.p_theyre()]Tentando cometer suicídio!"))
	return BRUTELOSS

/obj/item/claymore/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == PROJECTILE_ATTACK || attack_type == LEAP_ATTACK || attack_type == OVERWHELMING_ATTACK)
		final_block_chance = 0 //Don't bring a sword to a gunfight, and also you aren't going to really block someone full body tackling you with a sword. Or a road roller, if one happened to hit you.
	return ..()

//statistically similar to e-cutlasses
/obj/item/claymore/cutlass
	name = "cutlass"
	desc = "Uma espada pirata usada por buckaneers para\"Negociar\"a transferência do tesouro."
	icon_state = "cutlass"
	inhand_icon_state = "cutlass"
	worn_icon_state = "cutlass"
	slot_flags = ITEM_SLOT_BACK
	force = 30
	throwforce = 20
	throw_speed = 3
	throw_range = 5
	armour_penetration = 35

/obj/item/claymore/cutlass/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/cuffable_item) //closed sword guard

/obj/item/claymore/cutlass/old
	name = "old cutlass"
	desc = parent_type::desc + "Este parece um pouco velho."
	force = 24
	throwforce = 17
	armour_penetration = 20
	block_chance = 30

/obj/item/claymore/carrot
	name = "carrot sword"
	desc = "Uma espada de cenoura. Com certeza.<b>Não.</b>Bom para os olhos, não mais."
	icon_state = "carrot_sword"
	inhand_icon_state = "carrot_sword"
	worn_icon_state = "carrot_sword"
	flags_1 = NONE
	force = 19
	throwforce = 7
	throw_speed = 3
	throw_range = 7
	armour_penetration = 5
	block_chance = 10
	resistance_flags = NONE

//bootleg claymore
/obj/item/claymore/shortsword
	name = "shortsword"
	desc = "A espada de um mercenário, lascada e usada de batalhas há muito tempo. Pode-se dizer que é a espada curta de um espadachim."
	icon_state = "shortsword"
	inhand_icon_state = "shortsword"
	worn_icon_state = "shortsword"
	slot_flags = ITEM_SLOT_BELT
	force = 20
	demolition_mod = 0.75
	block_chance = 30

/obj/item/claymore/highlander //ALL COMMENTS MADE REGARDING THIS SWORD MUST BE MADE IN ALL CAPS
	desc = "<b><i>Só pode haver um, e será você!</i></b>\nAtive na sua mão para apontar para a vítima mais próxima."
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = DROPDEL //WOW BRO YOU LOST AN ARM, GUESS WHAT YOU DONT GET YOUR SWORD ANYMORE //I CANT BELIEVE SPOOKYDONUT WOULD BREAK THE REQUIREMENTS
	slot_flags = null
	block_chance = 0 //RNG WON'T HELP YOU NOW, PANSY
	light_range = 3
	attack_verb_continuous = list("brutalizes", "eviscerates", "disembowels", "hacks", "carves", "cleaves") //ONLY THE MOST VISCERAL ATTACK VERBS
	attack_verb_simple = list("brutalize", "eviscerate", "disembowel", "hack", "carve", "cleave")
	var/notches = 0 //HOW MANY PEOPLE HAVE BEEN SLAIN WITH THIS BLADE
	var/obj/item/disk/nuclear/nuke_disk //OUR STORED NUKE DISK

/obj/item/claymore/highlander/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HIGHLANDER_TRAIT)
	START_PROCESSING(SSobj, src)

/obj/item/claymore/highlander/Destroy()
	if(nuke_disk)
		nuke_disk.forceMove(get_turf(src))
		nuke_disk.visible_message(span_warning("O disco nuclear está vulnerável!"))
		nuke_disk = null
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/claymore/highlander/process()
	if(ishuman(loc))
		var/mob/living/carbon/human/holder = loc
		holder.layer = ABOVE_ALL_MOB_LAYER //NO HIDING BEHIND PLANTS FOR YOU, DICKWEED (HA GET IT, BECAUSE WEEDS ARE PLANTS)
		ADD_TRAIT(holder, TRAIT_NOBLOOD, HIGHLANDER_TRAIT) //AND WE WON'T BLEED OUT LIKE COWARDS
	else
		if(!(flags_1 & ADMIN_SPAWNED_1))
			qdel(src)


/obj/item/claymore/highlander/pickup(mob/living/user)
	. = ..()
	to_chat(user, span_notice("O poder da Escócia protege você! Você está protegido de todos os choques e nocautes."))
	user.ignore_slowdown(HIGHLANDER_TRAIT)
	user.add_stun_absorption(
		source = HIGHLANDER_TRAIT,
		message = span_warning("%EFFECT_OWNER is protected by the power of Scotland!"),
		self_message = span_boldwarning("O poder da Escócia absorve o atordoamento!"),
		examine_message = span_warning("EFEITO DO CAMPO Protegido pelo poder da Escócia!"),
	)

/obj/item/claymore/highlander/dropped(mob/living/user)
	. = ..()
	user.unignore_slowdown(HIGHLANDER_TRAIT)
	user.remove_stun_absorption(HIGHLANDER_TRAIT)

/obj/item/claymore/highlander/examine(mob/user)
	. = ..()
	. += "It has [!notches ? "nothing" : "[notches] notches"] scratched into the blade."
	if(nuke_disk)
		. += span_boldwarning("Está segurando o disco da bomba!")

/obj/item/claymore/highlander/attack(mob/living/target, mob/living/user)
	. = ..()
	if(!QDELETED(target) && target.stat == DEAD && target.mind?.has_antag_datum(/datum/antagonist/highlander))
		user.fully_heal() //STEAL THE LIFE OF OUR FALLEN FOES
		add_notch(user)
		target.visible_message(span_warning("[target]Desfaz-se ao pó abaixo[user]É uma droga!"), span_userdanger("Enquanto você cai, seu corpo desmorona em pó!"))
		target.investigate_log("has been dusted by a highlander claymore.", INVESTIGATE_DEATHS)
		target.dust()

/obj/item/claymore/highlander/attack_self(mob/living/user)
	var/closest_victim
	var/closest_distance = 255
	for(var/mob/living/carbon/human/scot in GLOB.player_list - user)
		if(scot.mind?.has_antag_datum(/datum/antagonist/highlander) && (!closest_victim || get_dist(user, closest_victim) < closest_distance))
			closest_victim = scot
	for(var/mob/living/silicon/robot/siliscot in GLOB.player_list - user)
		if(siliscot.mind?.has_antag_datum(/datum/antagonist/highlander) && (!closest_victim || get_dist(user, closest_victim) < closest_distance))
			closest_victim = siliscot

	if(!closest_victim)
		to_chat(user, span_warning("[src]Bate por um momento e fica escuro. Talvez não haja ninguém por perto."))
		return
	to_chat(user, span_danger("[src]thrums e pontos para o o[dir2text(get_dir(user, closest_victim))]."))

/obj/item/claymore/highlander/IsReflect()
	return 1 //YOU THINK YOUR PUNY LASERS CAN STOP ME?

/obj/item/claymore/highlander/proc/add_notch(mob/living/user) //DYNAMIC CLAYMORE PROGRESSION SYSTEM - THIS IS THE FUTURE
	notches++
	force++
	var/new_name = name
	switch(notches)
		if(1)
			to_chat(user, span_notice("Sua primeira morte - espero que uma de muitas. Você arranha um entalhe em[src]A lâmina."))
			to_chat(user, span_warning("Você sente a alma do seu inimigo caído entrando em sua lâmina, restaurando suas feridas!"))
			new_name = "notched claymore"
		if(2)
			to_chat(user, span_notice("Outra queda antes de você. Outra alma se funde com a sua. Outro entalhe na lâmina."))
			new_name = "double-notched claymore"
			add_atom_colour(rgb(255, 235, 235), ADMIN_COLOUR_PRIORITY)
		if(3)
			to_chat(user, span_notice("Você está começando a</span> <span class='danger'><b>Alegria</b>O<b>Emoção</b>De<b>Batalha.</b>"))
			new_name = "triple-notched claymore"
			add_atom_colour(rgb(255, 215, 215), ADMIN_COLOUR_PRIORITY)
		if(4)
			to_chat(user, span_notice("Você perdeu a conta de</span> <span class='bolddanger'>Quantos você matou."))
			new_name = "many-notched claymore"
			add_atom_colour(rgb(255, 195, 195), ADMIN_COLOUR_PRIORITY)
		if(5)
			to_chat(user, span_bolddanger("Cinco vozes agora ecoam em sua mente, aplaudindo o massacre."))
			new_name = "battle-tested claymore"
			add_atom_colour(rgb(255, 175, 175), ADMIN_COLOUR_PRIORITY)
		if(6)
			to_chat(user, span_bolddanger("É assim que os Vikings se sentiam? Visões de glória enchem sua cabeça enquanto mata seu sexto inimigo."))
			new_name = "battle-scarred claymore"
			add_atom_colour(rgb(255, 155, 155), ADMIN_COLOUR_PRIORITY)
		if(7)
			to_chat(user, span_bolddanger("Matar. Açougueiro.<i>Conquistar.</i>"))
			new_name = "vicious claymore"
			add_atom_colour(rgb(255, 135, 135), ADMIN_COLOUR_PRIORITY)
		if(8)
			to_chat(user, span_userdanger("Nunca fica velho. O<i>Gritando.</i>O.<i>SANGUE</i>Como ele<i>SPRAYS</i>Cruze o seu<i>Cara.</i>"))
			new_name = "bloodthirsty claymore"
			add_atom_colour(rgb(255, 115, 115), ADMIN_COLOUR_PRIORITY)
		if(9)
			to_chat(user, span_userdanger("Outro cai para seus sopros. Outro fraco para viver."))
			new_name = "gore-stained claymore"
			add_atom_colour(rgb(255, 95, 95), ADMIN_COLOUR_PRIORITY)
		if(10)
			user.visible_message(span_warning("[user]Os olhos brilham com nevoeiro vingativo!"), 			span_userdanger("Você sente o poder de Valhalla fluindo através de você!<i>Só pode haver um!</i>"))
			new_name = "GORE-DRENCHED CLAYMORE OF [pick("THE WHIMSICAL SLAUGHTER", "A THOUSAND SLAUGHTERED CATTLE", "GLORY AND VALHALLA", "ANNIHILATION", "OBLITERATION")]"
			icon_state = "claymore_gold"
			inhand_icon_state = "cultblade"
			lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
			righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
			remove_atom_colour(ADMIN_COLOUR_PRIORITY)
			user.update_held_items()

	name = new_name
	playsound(user, 'sound/items/tools/screwdriver2.ogg', 50, TRUE)

/obj/item/claymore/highlander/robot //BLOODTHIRSTY BORGS NOW COME IN PLAID
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "claymore_cyborg"

/obj/item/claymore/highlander/robot/Initialize(mapload)
	. = ..()
	if(!iscyborg(loc))
		return INITIALIZE_HINT_QDEL

/obj/item/claymore/highlander/robot/process()
	loc.layer = ABOVE_ALL_MOB_LAYER

/obj/item/claymore/gladius
	name = "gladius"
	desc = "Uma espada curta, mas formidável, favorecida por guerreiros antigos recentemente reanimados."
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "gladius"
	inhand_icon_state = "gladius"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	sharpness = SHARP_POINTY
	attack_verb_continuous = list("stabs", "cuts")
	attack_verb_simple = list("stab", "cut")
	slot_flags = null
	sound_vary = TRUE
	block_sound = 'sound/items/weapons/parry.ogg'
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	pickup_sound = SFX_KNIFE_PICKUP
	drop_sound = SFX_KNIFE_DROP
