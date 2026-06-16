/obj/item/gun/energy/ionrifle // SKYRAT EDIT - ICON OVERRIDDEN IN AESTHETICS MODULE
	name = "ion rifle"
	desc = "Uma arma anti-arma portátil projetada para desativar ameaças mecânicas ao alcance."
	icon_state = "ionrifle"
	inhand_icon_state = null //so the human update icon uses the icon_state instead.
	worn_icon_state = null
	shaded_charge = TRUE
	w_class = WEIGHT_CLASS_HUGE
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BACK
	ammo_type = list(/obj/item/ammo_casing/energy/ion)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 3, /datum/material/uranium = SHEET_MATERIAL_AMOUNT)
	light_color = LIGHT_COLOR_BLUE

/obj/item/gun/energy/ionrifle/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_ALL)

/obj/item/gun/energy/ionrifle/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, 		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', 		light_overlay = "flight", 		overlay_x = 17, 		overlay_y = 9)

/obj/item/gun/energy/ionrifle/carbine
	name = "ion carbine"
	desc = "O Protótipo MKII Ion Projector é uma versão leve da carabina do rifle de íons maior, construída para ser ergonômica e eficiente."
	icon_state = "ioncarbine"
	worn_icon_state = "gun"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BELT

/obj/item/gun/energy/ionrifle/carbine/add_seclight_point()
	. = ..()
	// We use the same overlay as the parent, so we can just let the component inherit the correct offsets here
	AddComponent(/datum/component/seclite_attachable, overlay_x = 18, overlay_y = 11)

/obj/item/gun/energy/floragun
	name = "floral somatoray"
	desc = "Uma ferramenta que descarrega radiação controlada que induz mutação em células vegetais."
	icon_state = "flora"
	inhand_icon_state = "gun"
	ammo_type = list(/obj/item/ammo_casing/energy/flora/yield, /obj/item/ammo_casing/energy/flora/mut, /obj/item/ammo_casing/energy/flora/revolution)
	modifystate = 1
	ammo_x_offset = 1
	selfcharge = 1
	gun_flags = NOT_A_REAL_GUN

/obj/item/gun/energy/meteorgun
	name = "meteor gun"
	desc = "Pelo amor de Deus, certifique-se de que está apontando para o caminho certo!"
	icon_state = "meteor_gun"
	inhand_icon_state = "c20r"
	w_class = WEIGHT_CLASS_BULKY
	ammo_type = list(/obj/item/ammo_casing/energy/meteor)
	cell_type = /obj/item/stock_parts/power_store/cell/potato
	clumsy_check = 0 //Admin spawn only, might as well let clowns use it.
	selfcharge = 1
	automatic_charge_overlays = FALSE

/obj/item/gun/energy/meteorgun/pen
	name = "meteor pen"
	desc = "A caneta é mais poderosa que a espada."
	icon = 'icons/obj/service/bureaucracy.dmi'
	icon_state = "pen"
	inhand_icon_state = "pen"
	worn_icon_state = "pen"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	automatic_charge_overlays = FALSE

/obj/item/gun/energy/mindflayer
	name = "\improper Mind Flayer"
	desc = "Uma arma protótipo recuperada das ruínas da Estação de Pesquisa Epsilon."
	icon_state = "xray"
	w_class = WEIGHT_CLASS_BULKY
	inhand_icon_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/mindflayer)
	ammo_x_offset = 2

/// amount of charge used up to start action (multiplied by amount) and per progress_flash_divisor ticks of welding
#define PLASMA_CUTTER_CHARGE_WELD (0.025 * STANDARD_CELL_CHARGE)

/obj/item/gun/energy/plasmacutter
	name = "plasma cutter"
	desc = "Uma ferramenta de mineração capaz de expulsar explosões de plasma concentradas. Você poderia usá-lo para cortar membros de xenos! Ou, você sabe, minhas coisas."
	icon_state = "plasmacutter"
	inhand_icon_state = "plasmacutter"
	ammo_type = list(/obj/item/ammo_casing/energy/plasma)
	obj_flags = CONDUCTS_ELECTRICITY
	attack_verb_continuous = list("attacks", "slashes", "cuts", "slices")
	attack_verb_simple = list("attack", "slash", "cut", "slice")
	force = 12
	sharpness = SHARP_EDGED
	can_charge = FALSE
	gun_flags = NOT_A_REAL_GUN
	heat = 3800
	usesound = list('sound/items/tools/welder.ogg', 'sound/items/tools/welder2.ogg')
	tool_behaviour = TOOL_WELDER
	toolspeed = 0.7 //plasmacutters can be used as welders, and are faster than standard welders

/obj/item/gun/energy/plasmacutter/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	. = ..()
	AddComponent(/datum/component/butchering, 		speed = 2.5 SECONDS, 		effectiveness = 105, 		bonus_modifier = 0, 		butcher_sound = 'sound/items/weapons/plasma_cutter.ogg', 	)
	AddElement(/datum/element/tool_flash, 1)

/obj/item/gun/energy/plasmacutter/examine(mob/user)
	. = ..()
	if(cell)
		. += span_notice("[src] É [round(cell.percent())] Está carregado.")

/obj/item/gun/energy/plasmacutter/attackby(obj/item/I, mob/user)
	var/charge_multiplier = 0 //2 = Refined stack, 1 = Ore
	if(istype(I, /obj/item/stack/sheet/mineral/plasma))
		charge_multiplier = 2
	if(istype(I, /obj/item/stack/ore/plasma))
		charge_multiplier = 1
	if(charge_multiplier)
		if(cell.charge == cell.maxcharge)
			balloon_alert(user, "Já está carregada!")
			return
		I.use(1)
		cell.give(0.5 * STANDARD_CELL_CHARGE * charge_multiplier)
		balloon_alert(user, "célula recarregada.")
	else
		..()

/obj/item/gun/energy/plasmacutter/emp_act(severity)
	. = ..()
	if(isliving(loc))
		var/mob/living/user = loc
		user.visible_message(span_danger("Descargas de plasma concentradas de [src] em frente [user] Queimá-los!"), span_userdanger("[src] Mau funcionamento, cuspindo plasma concentrado em você! Queima!"))
		user.adjust_fire_stacks(4)
		user.ignite_mob()

// Can we weld? Plasma cutter does not use charge continuously.
// Amount cannot be defaulted to 1: most of the code specifies 0 in the call.
/obj/item/gun/energy/plasmacutter/tool_use_check(mob/living/user, amount, heat_required)
	if(QDELETED(cell))
		balloon_alert(user, "Nenhuma célula inserida!")
		return FALSE
	// Amount cannot be used if drain is made continuous, e.g. amount = 5, charge_weld = 25
	// Then it'll drain 125 at first and 25 periodically, but fail if charge dips below 125 even though it still can finish action
	// Alternately it'll need to drain amount*charge_weld every period, which is either obscene or makes it free for other uses
	if(amount ? cell.charge < PLASMA_CUTTER_CHARGE_WELD * amount : cell.charge < PLASMA_CUTTER_CHARGE_WELD)
		balloon_alert(user, "Insuficiência de carga!")
		return FALSE
	if(heat < heat_required)
		to_chat(user, span_warning("[src] Não é quente o suficiente para completar esta tarefa!"))
		return FALSE

	return TRUE

/obj/item/gun/energy/plasmacutter/use(used)
	return (!QDELETED(cell) && cell.use(used ? used * PLASMA_CUTTER_CHARGE_WELD : PLASMA_CUTTER_CHARGE_WELD))

/obj/item/gun/energy/plasmacutter/use_tool(atom/target, mob/living/user, delay, amount=1, volume=0, datum/callback/extra_checks)

	if(amount)
		var/mutable_appearance/sparks = mutable_appearance('icons/effects/welding_effect.dmi', "welding_sparks", GASFIRE_LAYER, src, ABOVE_LIGHTING_PLANE)
		target.add_overlay(sparks)
		LAZYADD(update_overlays_on_z, sparks)
		. = ..()
		LAZYREMOVE(update_overlays_on_z, sparks)
		target.cut_overlay(sparks)
	else
		. = ..(amount=1)

/obj/item/gun/energy/plasmacutter/try_fire_gun(atom/target, mob/living/user, params)
	return fire_gun(target, user, user.Adjacent(target) && !isturf(target), params)

#undef PLASMA_CUTTER_CHARGE_WELD

/obj/item/gun/energy/plasmacutter/adv
	name = "advanced plasma cutter"
	icon_state = "adv_plasmacutter"
	inhand_icon_state = "adv_plasmacutter"
	force = 15
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/adv)

#define AMMO_SELECT_BLUE 1
#define AMMO_SELECT_ORANGE 2

/obj/item/gun/energy/wormhole_projector
	name = "bluespace wormhole projector"
	desc = "Um projetor que emite feixes de espaço azul quânticos de alta densidade. Requer um núcleo de anomalia do espaço azul para funcionar. Encaixa em um saco."
	ammo_type = list(/obj/item/ammo_casing/energy/wormhole, /obj/item/ammo_casing/energy/wormhole/orange)
	can_select = FALSE // left-click for blue, right-click for orange.
	w_class = WEIGHT_CLASS_NORMAL
	inhand_icon_state = null
	icon_state = "wormhole_projector"
	base_icon_state = "wormhole_projector"
	automatic_charge_overlays = FALSE
	var/obj/effect/portal/p_blue
	var/obj/effect/portal/p_orange
	var/firing_core = FALSE
	gun_flags = NOT_A_REAL_GUN

/obj/item/gun/energy/wormhole_projector/examine(mob/user)
	. = ..()
	. += span_notice("<b>Botão esquerdo</b>para disparar buracos de minhoca azuis e<b><font color=orange>botão direito</font></b>para disparar buracos de minhoca laranjas.")

/obj/item/gun/energy/wormhole_projector/attackby(obj/item/C, mob/user)
	if(istype(C, /obj/item/assembly/signaler/anomaly/bluespace))
		to_chat(user, span_notice("Você insere [C] no projetor do buraco de minhoca e a arma suavemente sussurra para a vida."))
		firing_core = TRUE
		playsound(src.loc, 'sound/machines/click.ogg', 50, TRUE)
		qdel(C)
		return

/obj/item/gun/energy/wormhole_projector/can_shoot()
	if(!firing_core)
		return FALSE
	return ..()

/obj/item/gun/energy/wormhole_projector/shoot_with_empty_chamber(mob/living/user)
	. = ..()
	to_chat(user, span_danger("O visor diz, \"nenhum núcleo instalado\"."))

/obj/item/gun/energy/wormhole_projector/update_icon_state()
	. = ..()
	icon_state = inhand_icon_state = "[base_icon_state][select]"

/obj/item/gun/energy/wormhole_projector/update_ammo_types()
	. = ..()
	for(var/i in 1 to ammo_type.len)
		var/obj/item/ammo_casing/energy/wormhole/W = ammo_type[i]
		if(istype(W))
			W.gun = WEAKREF(src)
			var/obj/projectile/beam/wormhole/WH = W.loaded_projectile
			if(istype(WH))
				WH.gun = WEAKREF(src)

/obj/item/gun/energy/wormhole_projector/try_fire_gun(atom/target, mob/living/user, params)
	if(LAZYACCESS(params2list(params), RIGHT_CLICK))
		if(select == AMMO_SELECT_BLUE) //Last fired in left click mode. Switch to orange wormhole (right click).
			select_fire()
	else
		if(select == AMMO_SELECT_ORANGE) //Last fired in right click mode. Switch to blue wormhole (left click).
			select_fire()
	return ..()

/obj/item/gun/energy/wormhole_projector/proc/on_portal_destroy(obj/effect/portal/P)
	SIGNAL_HANDLER
	if(P == p_blue)
		p_blue = null
	else if(P == p_orange)
		p_orange = null

/obj/item/gun/energy/wormhole_projector/proc/has_blue_portal()
	if(istype(p_blue) && !QDELETED(p_blue))
		return TRUE
	return FALSE

/obj/item/gun/energy/wormhole_projector/proc/has_orange_portal()
	if(istype(p_orange) && !QDELETED(p_orange))
		return TRUE
	return FALSE

/obj/item/gun/energy/wormhole_projector/proc/crosslink()
	if(!has_blue_portal() && !has_orange_portal())
		return
	if(!has_blue_portal() && has_orange_portal())
		p_orange.link_portal(null)
		return
	if(!has_orange_portal() && has_blue_portal())
		p_blue.link_portal(null)
		return
	p_orange.link_portal(p_blue)
	p_blue.link_portal(p_orange)

/obj/item/gun/energy/wormhole_projector/proc/create_portal(obj/projectile/beam/wormhole/wormhole_beam, turf/target)
	var/obj/effect/portal/new_portal = new /obj/effect/portal(target, 300, null, FALSE, null)
	RegisterSignal(new_portal, COMSIG_QDELETING, PROC_REF(on_portal_destroy))
	if(istype(wormhole_beam, /obj/projectile/beam/wormhole/orange))
		qdel(p_orange)
		p_orange = new_portal
		new_portal.icon_state = "portal1"
		new_portal.set_light_color(COLOR_MOSTLY_PURE_ORANGE)
		new_portal.update_light()
	else
		qdel(p_blue)
		p_blue = new_portal
	crosslink()
	playsound(new_portal, SFX_PORTAL_CREATED, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/obj/item/gun/energy/wormhole_projector/core_inserted
	firing_core = TRUE

#undef AMMO_SELECT_BLUE
#undef AMMO_SELECT_ORANGE

/* 3d printer 'pseudo guns' for borgs */

/obj/item/gun/energy/printer
	name = "cyborg lmg"
	desc = "Uma LMG que dispara flechettes impressas em 3D. Eles são lentamente reabastecidos usando a fonte de energia interna do cyborg."
	icon_state = "l6_cyborg"
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	cell_type = /obj/item/stock_parts/power_store/cell/secborg
	ammo_type = list(/obj/item/ammo_casing/energy/c3dbullet)
	can_charge = FALSE
	use_cyborg_cell = TRUE

/obj/item/gun/energy/printer/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.3 SECONDS)
	AddElement(/datum/element/empprotection, EMP_PROTECT_ALL)

/obj/item/gun/energy/temperature
	name = "temperature gun"
	icon_state = "freezegun"
	desc = "Uma arma que muda de temperatura. Vem com um estoque dobrável."
	w_class = WEIGHT_CLASS_NORMAL
	ammo_type = list(/obj/item/ammo_casing/energy/temp, /obj/item/ammo_casing/energy/temp/hot)
	cell_type = /obj/item/stock_parts/power_store/cell/high
	pin = null
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3.5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/gun/energy/temperature/security
	name = "security temperature gun"
	desc = "Uma arma que só pode ser usada com todo o seu potencial pelos verdadeiramente robustos."
	pin = /obj/item/firing_pin

/obj/item/gun/energy/temperature/freeze
	name = "cryogenic temperature gun"
	desc = "Uma arma que reduz as temperaturas. Só para aqueles com gelo nas veias."
	pin = /obj/item/firing_pin
	ammo_type = list(/obj/item/ammo_casing/energy/temp)

/obj/item/gun/energy/gravity_gun
	name = "one-point gravitational manipulator"
	desc = "Um dispositivo experimental multimodo que dispara parafusos de energia de ponto zero, causando distorções locais na gravidade. Requer um núcleo de anomalia gravitacional para funcionar."
	w_class = WEIGHT_CLASS_BULKY
	ammo_type = list(/obj/item/ammo_casing/energy/gravity/repulse, /obj/item/ammo_casing/energy/gravity/attract, /obj/item/ammo_casing/energy/gravity/chaos)
	inhand_icon_state = "gravity_gun"
	icon_state = "gravity_gun"
	automatic_charge_overlays = FALSE
	var/power = 4
	var/firing_core = FALSE
	gun_flags = NOT_A_REAL_GUN

/obj/item/gun/energy/gravity_gun/attackby(obj/item/C, mob/user)
	if(istype(C, /obj/item/assembly/signaler/anomaly/grav))
		to_chat(user, span_notice("Você insere [C] no manipulador gravitacional e a arma suavemente sussurra para a vida."))
		firing_core = TRUE
		playsound(src.loc, 'sound/machines/click.ogg', 50, TRUE)
		qdel(C)
		return
	return ..()

/obj/item/gun/energy/gravity_gun/can_shoot()
	if(!firing_core)
		return FALSE
	return ..()

/**
-----------------Tesla Cannon--------------------------------

An advanced weapon that provides extremely high dps output at pinpoint accuracy due to its hitscan nature.

Due to its normal w_class when folded it is suitable as a heavy reinforcement weapon, since the cell drains very quickly when firing.

The power level is somewhat tempered by several drawbacks such as research requirements, anomalock, two handed firing requirement, and insultation providing damage reduction.

it is often confused with the mech weapon of the same name, since it is a bit more obscure despite being very powerful. Formerly called the tesla revolver.
**/
/obj/item/gun/energy/tesla_cannon
	name = "tesla cannon"
	icon = 'icons/obj/weapons/guns/wide_guns.dmi'
	icon_state = "tesla"
	lefthand_file = 'icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'icons/mob/inhands/weapons/64x_guns_right.dmi'
	inhand_icon_state = null //null so we build the correct inhand.
	desc = "Um protótipo de projetor de fluxo de alta tensão criado usando os últimos avanços na ciência da anomalia.\n\nA natureza anômala do núcleo de fluxo permite que o arco tesla seja guiado do eletrodo para o alvo sem ser desviado para condutores perdidos fora do campo alvo."
	SET_BASE_VISUAL_PIXEL(-8, 0)
	ammo_type = list(/obj/item/ammo_casing/energy/tesla_cannon)
	inhand_x_dimension = 64
	shaded_charge = TRUE
	charge_sections = 2
	display_empty =  FALSE
	weapon_weight = WEAPON_HEAVY
	w_class = WEIGHT_CLASS_BULKY
	///if our stpck is extended and we are ready to fire.
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 5)
	var/ready_to_fire = FALSE

/obj/item/gun/energy/tesla_cannon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, autofire_shot_delay =  100 MILLISECONDS, firing_sound_loop = /datum/looping_sound/tesla_cannon)

/obj/item/gun/energy/tesla_cannon/can_trigger_gun(mob/living/user, akimbo_usage)
	if(ready_to_fire)
		return ..()
	//If we have charge, but the stock is folded, do sparks.
	if(can_shoot())
		balloon_alert(user, "A eletricidade está crescendo para estoque!")

		if(prob(75)) //fake sparks to cut on spark spam
			playsound(user, 'sound/effects/sparks/sparks1.ogg', 50, TRUE)
		else
			do_sparks(3, FALSE, user)
	return FALSE

/obj/item/gun/energy/tesla_cannon/attack_self(mob/living/user)
	. = ..()
	if(ready_to_fire)
		w_class = WEIGHT_CLASS_NORMAL
		ready_to_fire = FALSE
		icon_state = "tesla"
		playsound(user, 'sound/items/weapons/gun/tesla/squeak_latch.ogg', 100)

	else
		playsound(user, 'sound/items/weapons/gun/tesla/click_creak.ogg', 100)
		if(!do_after(user, 1.5 SECONDS))
			return
		w_class = WEIGHT_CLASS_BULKY
		ready_to_fire = TRUE
		icon_state = "tesla_unfolded"
		playsound(user, 'sound/items/weapons/gun/tesla/squeak_latch.ogg', 100)

	update_appearance()
	balloon_alert_to_viewers("[ready_to_fire ? "unfolded" : "folded"] stock")

/obj/item/gun/energy/marksman_revolver
	name = "marksman revolver"
	desc = "Usa pulsos elétricos para disparar pedaços microscópicos de metal em velocidades incrivelmente altas. Fogo alternativo lança uma moeda que pode ser alvo de poder de fogo extra."
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "revolver"
	ammo_type = list(/obj/item/ammo_casing/energy/marksman)
	fire_sound = 'sound/items/weapons/gun/revolver/shot_alt.ogg'
	automatic_charge_overlays = FALSE
	/// How many coins we can have at a time. Set to 0 for infinite
	var/max_coins = 4
	/// How many coins we currently have available
	var/coin_count = 0
	/// How long it takes to regen a coin
	var/coin_regen_rate = 2 SECONDS
	/// The cooldown for regenning coins
	COOLDOWN_DECLARE(coin_regen_cd)

/obj/item/gun/energy/marksman_revolver/Initialize(mapload)
	. = ..()
	coin_count = max_coins

/obj/item/gun/energy/marksman_revolver/examine(mob/user)
	. = ..()
	if(max_coins)
		. += "It currently has [coin_count] out of [max_coins] coins, and takes [coin_regen_rate/10] seconds to recharge each one."
	else
		. += "It has infinite coins available for use."

/obj/item/gun/energy/marksman_revolver/process(seconds_per_tick)
	if(!max_coins || coin_count >= max_coins)
		STOP_PROCESSING(SSobj, src)
		return

	if(COOLDOWN_FINISHED(src, coin_regen_cd))
		if(ismob(loc))
			var/mob/owner = loc
			owner.playsound_local(owner, 'sound/machines/ding.ogg', 20)
		coin_count++
		COOLDOWN_START(src, coin_regen_cd, coin_regen_rate)

/obj/item/gun/energy/marksman_revolver/try_fire_gun(atom/target, mob/living/user, params)
	if(!LAZYACCESS(params2list(params), RIGHT_CLICK))
		return ..()
	if(!CAN_THEY_SEE(target, user))
		return ITEM_INTERACT_BLOCKING

	if(max_coins && coin_count <= 0)
		to_chat(user, span_warning("Você não tem moedas agora!"))
		return ITEM_INTERACT_BLOCKING

	if(max_coins)
		START_PROCESSING(SSobj, src)
		coin_count = max(0, coin_count - 1)

	var/turf/target_turf = get_offset_target_turf(target, rand(-1, 1), rand(-1, 1)) // choose a random tile adjacent to the clicked one
	playsound(user.loc, 'sound/effects/coin2.ogg', 50, TRUE)
	user.visible_message(span_warning("[user] lança uma moeda em direção [target]!"), span_danger("Você joga uma moeda em direção [target]!"))
	var/obj/projectile/bullet/coin/new_coin = new(get_turf(user), target_turf, user)
	new_coin.aim_projectile(target_turf, user)
	new_coin.fire()
	return ITEM_INTERACT_SUCCESS

/obj/item/gun/energy/photon
	name = "photon cannon"
	desc = "Um design competitivo para o canhão Tesla, que em vez de carregar elétrons latentes, libera energia em fótons. A proteção ocular é recomendada."
	icon_state = "photon"
	inhand_icon_state = "tesla"
	fire_sound = 'sound/items/weapons/lasercannonfire.ogg'
	ammo_type = list(/obj/item/ammo_casing/energy/photon)
	shaded_charge = TRUE
	weapon_weight = WEAPON_HEAVY
	light_color = LIGHT_COLOR_DEFAULT
	light_system = OVERLAY_LIGHT
	light_power = 2
	light_range = 1
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 7, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/gun/energy/photon/Initialize(mapload)
	. = ..()
	set_light_on(TRUE) // The gun quite literally shoots mini-suns.
