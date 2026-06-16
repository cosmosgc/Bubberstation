/obj/item/lighter
	name = "\improper Zippo lighter"
	desc = "O zíper."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "zippo"
	inhand_icon_state = "zippo"
	worn_icon_state = "lighter"
	w_class = WEIGHT_CLASS_TINY
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT
	resistance_flags = FIRE_PROOF
	custom_price = PAYCHECK_CREW * 1.1
	light_system = OVERLAY_LIGHT
	light_range = 2
	light_power = 1.3
	light_color = LIGHT_COLOR_FIRE
	light_on = FALSE
	toolspeed = 1.5
	tool_behaviour = TOOL_WELDER
	///The amount of heat a lighter has while it's on. We're using the define to ensure lighters can't do things we don't want them to.
	var/heat_while_on = HIGH_TEMPERATURE_REQUIRED - 100
	///The amount of time the lighter has been on for, for fuel consumption.
	var/burned_fuel_for = 0
	///The max amount of fuel the lighter can hold.
	var/maximum_fuel = 6
	/// Whether the lighter is lit.
	var/lit = FALSE
	/// Whether the lighter is fancy. Fancy lighters have fancier flavortext and won't burn thumbs.
	var/fancy = TRUE
	/// The engraving overlay used by this lighter.
	var/overlay_state
	/// A list of possible engraving overlays.
	var/list/overlay_list = list(
		"plain",
		"dame",
		"thirteen",
		"snake",
	)
	/// Whether the lighter starts with fuel
	var/spawns_with_reagent = TRUE
	/// Lighting middleman, lets us do a flicker effect
	var/datum/light_middleman/middleman

/obj/item/lighter/Initialize(mapload)
	. = ..()
	if(IS_OVERLAY_LIGHT_SYSTEM(light_system))
		middleman = new(src, "flashlight")
		RegisterSignal(middleman, COMSIG_LIGHT_MIDDLEMAN_UPDATED, PROC_REF(light_updated))
		middleman.being_overriding_light()
	create_reagents(maximum_fuel, REFILLABLE | DRAINABLE)
	if(spawns_with_reagent)
		reagents.add_reagent(/datum/reagent/fuel, maximum_fuel)
	if(!overlay_state)
		overlay_state = pick(overlay_list)
	AddComponent(		/datum/component/bullet_intercepting,		block_chance = 0.5,		active_slots = ITEM_SLOT_SUITSTORE,		on_intercepted = CALLBACK(src, PROC_REF(on_intercepted_bullet)),	)
	update_appearance()

/obj/item/lighter/Destroy(force)
	if(!isnull(middleman))
		QDEL_NULL(middleman)
	return ..()

/obj/item/lighter/grind_results()
	return list(/datum/reagent/iron = 1, /datum/reagent/fuel = 5, /datum/reagent/fuel/oil = 5)

/obj/item/lighter/examine(mob/user)
	. = ..()
	if(get_fuel() <= 0)
		. += span_warning("Está sem fluido de isqueiro! Encher com combustível de soldador.")
	else
		. += span_notice("Ele contém [get_fuel()] unidades de combustível fora de [maximum_fuel].")

/obj/item/lighter/proc/light_updated(datum/source)
	SIGNAL_HANDLER
	fire_flicker_middleman(middleman)

/// Destroy the lighter when it's shot by a bullet
/obj/item/lighter/proc/on_intercepted_bullet(mob/living/victim, obj/projectile/bullet)
	victim.visible_message(span_warning("\The [bullet] Estraga tudo.[victim] Está mais leve!"))
	playsound(victim, SFX_RICOCHET, 100, TRUE)
	new /obj/effect/decal/cleanable/blood/oil(get_turf(src))
	do_sparks(1, TRUE, src)
	victim.dropItemToGround(src, force = TRUE, silent = TRUE)
	qdel(src)

/obj/item/lighter/cyborg_unequip(mob/user)
	if(!lit)
		return
	set_lit(FALSE)

/obj/item/lighter/suicide_act(mob/living/carbon/user)
	if (lit)
		user.visible_message(span_suicide("[user] Começa a segurar\the [src]'s chama até [user.p_their()] Cara! Parece que...[user.p_theyre()] Tentando cometer suicídio!"))
		playsound(src, 'sound/items/tools/welder.ogg', 50, TRUE)
		return FIRELOSS
	else
		user.visible_message(span_suicide("[user] Começa a bater [user.p_them()] ego com\the [src]! Parece que...[user.p_theyre()] Tentando cometer suicídio!"))
		return BRUTELOSS

/obj/item/lighter/update_icon_state()
	icon_state = "[initial(icon_state)][lit ? "-on" : ""]"
	return ..()

/obj/item/lighter/update_overlays()
	. = ..()
	. += create_lighter_overlay()

/// Generates an overlay used by this lighter.
/obj/item/lighter/proc/create_lighter_overlay()
	return mutable_appearance(icon, "lighter_overlay_[overlay_state][lit ? "-on" : ""]")

/obj/item/lighter/ignition_effect(atom/A, mob/user)
	if(get_temperature())
		. = span_infoplain(span_rose("Com um único movimento de [user.p_their()] Pulso,[user] Luzes suaves [A] com [src] Droga.[user.p_theyre()] Legal."))

/obj/item/lighter/proc/set_lit(new_lit)
	if(lit == new_lit)
		return

	lit = new_lit
	if(lit)
		force = 5
		damtype = BURN
		hitsound = 'sound/items/tools/welder.ogg'
		attack_verb_continuous = string_list(list("burns", "singes"))
		attack_verb_simple = string_list(list("burn", "singe"))
		heat = heat_while_on
		START_PROCESSING(SSobj, src)
		if(fancy)
			playsound(src.loc , 'sound/items/lighter/zippo_on.ogg', 100, 1)
		else
			playsound(src.loc, 'sound/items/lighter/lighter_on.ogg', 100, 1)
		if(isliving(loc))
			var/mob/living/male_model = loc
			if(male_model.fire_stacks && !(male_model.on_fire))
				male_model.ignite_mob()
	else
		hitsound = SFX_SWING_HIT
		force = 0
		heat = 0
		attack_verb_continuous = null //human_defense.dm takes care of it
		attack_verb_simple = null
		STOP_PROCESSING(SSobj, src)
		if(fancy)
			playsound(src.loc , 'sound/items/lighter/zippo_off.ogg', 100, 1)
		else
			playsound(src.loc , 'sound/items/lighter/lighter_off.ogg', 100, 1)
	set_light_on(lit)
	update_appearance()

/obj/item/lighter/extinguish()
	. = ..()
	set_lit(FALSE)

/obj/item/lighter/attack_self(mob/living/user)
	if(!user.is_holding(src))
		return ..()
	if(lit)
		set_lit(FALSE)
		if(fancy)
			user.visible_message(
				span_notice("Você ouve um clique silencioso, como [user] Desliga.[src] Sem sequer olhar para o que [user.p_theyre()] Fazendo. Uau."),
				span_notice("Você se desligou silenciosamente.[src] Sem olhar para o que está fazendo. Uau.")
			)
		else
			user.visible_message(
				span_notice("[user] Desliga silenciosamente.[src]."),
				span_notice("Você se desligou silenciosamente.[src].")
			)
		return

	if(get_fuel() <= 0)
		return

	set_lit(TRUE)

	if(fancy)
		user.visible_message(
			span_notice("Sem sequer quebrar o passo,[user] Se abre e acende.[src] em um movimento suave."),
			span_notice("Sem sequer quebrar o passo, você se abre e luz [src] em um movimento suave.")
		)
		return

	var/hand_protected = FALSE
	var/mob/living/carbon/human/human_user = user
	if(!istype(human_user) || HAS_TRAIT(human_user, TRAIT_RESISTHEAT) || HAS_TRAIT(human_user, TRAIT_RESISTHEATHANDS))
		hand_protected = TRUE
	else if(!istype(human_user.gloves, /obj/item/clothing/gloves))
		hand_protected = FALSE
	else
		var/obj/item/clothing/gloves/gloves = human_user.gloves
		if(gloves.max_heat_protection_temperature)
			hand_protected = (gloves.max_heat_protection_temperature > 360)

	if(hand_protected || prob(75))
		user.visible_message(
			span_notice("Depois de algumas tentativas,[user] consegue iluminar [src]."),
			span_notice("Depois de algumas tentativas, você consegue acender [src].")
		)
		return

	var/hitzone = user.held_index_to_dir(user.active_hand_index) == "r" ? BODY_ZONE_PRECISE_R_HAND : BODY_ZONE_PRECISE_L_HAND
	user.apply_damage(5, BURN, hitzone)
	user.visible_message(
		span_warning("Depois de algumas tentativas,[user] consegue iluminar [src]- no entanto,[user.p_they()] Queime [user.p_s()] [user.p_their()] Dedo no processo."),
		span_warning("Você se queima enquanto acende o isqueiro!")
	)
	user.add_mood_event("burnt_thumb", /datum/mood_event/burnt_thumb)

/obj/item/lighter/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	if(lit)
		use(0.5)
		if(target_mob.ignite_mob())
			message_admins("[ADMIN_LOOKUPFLW(user)] set [key_name_admin(target_mob)] on fire with [src] at [AREACOORD(user)]")
			log_game("[key_name(user)] set [key_name(target_mob)] on fire with [src] at [AREACOORD(user)]")
	var/obj/item/cigarette/cig = help_light_cig(target_mob)
	if(!lit || !cig || user.combat_mode)
		return ..()

	if(cig.lit)
		to_chat(user, span_warning("\The [cig] Já está acesa!"))
	if(target_mob == user)
		cig.attackby(src, user)
		return

	if(fancy)
		cig.light(span_rose("[user] chicotes\the [src] Para fora e segura-o para [target_mob]. [user.p_Their()] O braço é tão firme quanto a chama incandescente.[user.p_they()] luz [user.p_s()] \the [cig] Com."))
	else
		cig.light(span_notice("[user] Segura.\the [src] Fora para [target_mob], e luzes [target_mob.p_their()] [cig.name]."))

///Checks if the lighter is able to perform a welding task.
/obj/item/lighter/tool_use_check(mob/living/user, amount, heat_required)
	if(!lit)
		to_chat(user, span_warning("[src] Tem que ser para completar esta tarefa!"))
		return FALSE
	if(get_fuel() < amount)
		to_chat(user, span_warning("Você precisa de mais combustível de solda para completar esta tarefa!"))
		return FALSE
	if(heat < heat_required)
		return FALSE
	return TRUE

/obj/item/lighter/process(seconds_per_tick)
	if(lit)
		open_flame(heat)
		burned_fuel_for += seconds_per_tick
		if(burned_fuel_for >= TOOL_FUEL_BURN_INTERVAL)
			use(used = 0.25)

/obj/item/lighter/get_temperature()
	return lit * heat

/// Uses fuel from the lighter.
/obj/item/lighter/use(used = 0)
	if(!lit)
		return FALSE

	if (reagents.spark_act(0, SPARK_ACT_ENCLOSED, banned_reagents = /datum/reagent/fuel) & SPARK_ACT_DESTRUCTIVE)
		qdel(src)
		return FALSE

	if(used > 0)
		burned_fuel_for = 0

	if(get_fuel() >= used)
		reagents.remove_reagent(/datum/reagent/fuel, used)
		if(get_fuel() <= 0)
			set_lit(FALSE)
		return TRUE
	return FALSE

///Returns the amount of fuel
/obj/item/lighter/proc/get_fuel()
	return reagents.get_reagent_amount(/datum/reagent/fuel) + reagents.get_reagent_amount(/datum/reagent/toxin/plasma)

/obj/item/lighter/greyscale
	name = "cheap lighter"
	desc = "Um isqueiro barato."
	icon_state = "lighter"
	maximum_fuel = 3
	fancy = FALSE
	overlay_list = list(
		"transp",
		"tall",
		"matte",
		"zoppo", //u cant stoppo th zoppo
	)

	/// The color of the lighter.
	var/lighter_color
	/// The set of colors this lighter can be autoset as on init.
	var/static/list/color_list = list( //Same 16 color selection as electronic assemblies
		COLOR_ASSEMBLY_BLACK,
		COLOR_FLOORTILE_GRAY,
		COLOR_ASSEMBLY_BGRAY,
		COLOR_ASSEMBLY_WHITE,
		COLOR_ASSEMBLY_RED,
		COLOR_ASSEMBLY_ORANGE,
		COLOR_ASSEMBLY_BEIGE,
		COLOR_ASSEMBLY_BROWN,
		COLOR_ASSEMBLY_GOLD,
		COLOR_ASSEMBLY_YELLOW,
		COLOR_ASSEMBLY_GURKHA,
		COLOR_ASSEMBLY_LGREEN,
		COLOR_ASSEMBLY_GREEN,
		COLOR_ASSEMBLY_LBLUE,
		COLOR_ASSEMBLY_BLUE,
		COLOR_ASSEMBLY_PURPLE
		)

/obj/item/lighter/greyscale/Initialize(mapload)
	. = ..()
	if(!lighter_color)
		lighter_color = pick(color_list)
	update_appearance()

/obj/item/lighter/greyscale/create_lighter_overlay()
	var/mutable_appearance/lighter_overlay = ..()
	lighter_overlay.color = lighter_color
	return lighter_overlay

/obj/item/lighter/greyscale/ignition_effect(atom/A, mob/user)
	if(get_temperature())
		. = span_notice("Depois de algum engano,[user] consegue iluminar [A] com [src].")


/obj/item/lighter/slime
	name = "slime zippo"
	desc = "Um zíper especial feito de lodo e indústria. Tem uma chama muito mais quente que o normal."
	icon_state = "slighter"
	heat_while_on = parent_type::heat_while_on + 1000 //Blue flame is hotter, this means this does act as a welding tool.
	light_color = LIGHT_COLOR_CYAN
	overlay_state = "slime"

/obj/item/lighter/slime/grind_results()
	return list(/datum/reagent/iron = 1, /datum/reagent/fuel = 5, /datum/reagent/medicine/pyroxadone = 5)

/obj/item/lighter/skull
	name = "badass zippo"
	desc = "Um isqueiro de zíper. Olhe para esse crânio!"
	overlay_state = "skull"

/obj/item/lighter/mime
	name = "pale zippo"
	desc = "Em vez de combustível, o espírito performativo pode ser usado para acender cigarros."
	icon_state = "mlighter" //These ones don't show a flame.
	light_color = LIGHT_COLOR_HALOGEN
	heat_while_on = TCMB //I swear it's a real lighter dude you just can't see the flame dude I promise
	overlay_state = "mime"
	light_range = 0
	light_power = 0
	fancy = FALSE

/obj/item/lighter/mime/grind_results()
	return list(/datum/reagent/iron = 1, /datum/reagent/toxin/mutetoxin = 5, /datum/reagent/consumable/nothing = 10)

/obj/item/lighter/mime/ignition_effect(atom/A, mob/user)
	. = span_infoplain("[user] Elevações\the [src] para o [A], que milagrosamente ilumina!")

/obj/item/lighter/bright
	name = "illuminative zippo"
	desc = "Sustenta uma reação química incrivelmente brilhante quando você a acende. Evite olhar diretamente para a ignição quando estiver acesa."
	icon_state = "slighter"
	light_color = LIGHT_COLOR_ELECTRIC_CYAN
	overlay_state = "bright"
	light_range = 8
	light_power = 3 //Irritatingly bright and large enough to cover a small room.
	fancy = FALSE

/obj/item/lighter/bright/grind_results()
	return list(/datum/reagent/iron = 1, /datum/reagent/flash_powder = 10)

/obj/item/lighter/bright/examine(mob/user)
	. = ..()

	if(lit && isliving(user))
		var/mob/living/current_viewer = user
		current_viewer.flash_act(4)

/obj/item/lighter/bright/ignition_effect(atom/A, mob/user)
	if(get_temperature())
		. = span_infoplain(span_rose("[user] Levanta o [src] para o [A], acendendo-o com um brilho brilhante de luz!"))
		var/mob/living/current_viewer = user
		current_viewer.flash_act(4)

/obj/effect/spawner/random/special_lighter
	name = "special lighter spawner"
	icon_state = "lighter"
	loot = list(
		/obj/item/lighter/skull,
		/obj/item/lighter/mime,
		/obj/item/lighter/bright,
	)

/obj/item/lighter/empty
	spawns_with_reagent = FALSE

/obj/item/lighter/greyscale/empty
	spawns_with_reagent = FALSE
