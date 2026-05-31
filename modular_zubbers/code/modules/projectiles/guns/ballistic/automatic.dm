/obj/item/gun/ballistic/automatic/wt550
	can_suppress = FALSE

/obj/item/gun/ballistic/automatic/wt550/add_bayonet_point()
	return

/obj/item/gun/ballistic/automatic/wt550/security
	name = "\improper WT-551 Autorifle"
	desc = "Uma variante automática mais pesada e volumosa do WT-550, e agora com 99% menos desbobulação! Voltou, querida. Usa balas 4,6x30mm. Recomendado para segurar com duas mãos."
	icon = 'modular_zubbers/icons/obj/weapons/guns/wt551.dmi'
	fire_sound = 'modular_zubbers/sound/weapons/gun/wt551/shot.ogg'
	w_class = WEIGHT_CLASS_BULKY
	fire_delay = 3
	//18 damage per 0.3 seconds = 60 DPS
	//Reference: Laser Gun 22 damage per 0.4 seconds = 55DPS

/obj/item/gun/ballistic/automatic/ntmp5
	burst_size = 1
	actions_types = list()
	name = "\improper NT22-HCS-MP 'Lancer'"
	desc = "Uma variante de submetralhadora para confrontos não letais. Tem um estoque retrátil incluído em seu projeto, permitindo uma ocultação mais fácil. Sem o estoque, seu recuo é forte o suficiente para que precise de duas mãos para usar eficazmente."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ntmp5.dmi'
	icon_state = "ntmp5"
	base_icon_state = "ntmp5"
	inhand_icon_state = "arg"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BELT
	accepted_magazine_type = /obj/item/ammo_box/magazine/recharge/ntusp
	bolt_type = BOLT_TYPE_STANDARD
	bolt_wording = "cocking handle"
	fire_delay = 0.15 SECONDS
	recoil = 1
	spread = 5
	mag_display = FALSE
	can_suppress = TRUE
	vary_fire_sound = FALSE
	fire_sound_volume = 80
	spawn_magazine_type = /obj/item/ammo_box/magazine/recharge/ntmp5
	show_bolt_icon = FALSE
	var/stock_retracted = TRUE
	var/extended_icon_state = "ntmp5-stock"
	var/retracted_icon_state = "ntmp5"
	var/weapon_charge_overlay_state
	var/suppressor_overlay_state
	var/seclite_overlay_x = 25
	var/seclite_overlay_y = 11
	var/datum/component/automatic_fire/autofire_component

/obj/item/gun/ballistic/automatic/ntmp5/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)

/obj/item/gun/ballistic/automatic/ntmp5/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_CLICK_CTRL, PROC_REF(on_ctrl_click_stock_toggle))
	autofire_component = AddComponent(/datum/component/automatic_fire, fire_delay, allow_akimbo = FALSE)
	AddElement(/datum/element/examine_lore, 		lore_hint = span_notice("Você pode." + EXAMINE_HINT("Olhe mais de preto.") + "Para apresentar um poco mais sobre[src]."), 			lore = "Uma adaptação do NT22-HCS, o NT22-HCS-MP, também conhecido como Lancer, é um Pistol de Máquina refinado para cenários de engajamento sustentado. Esta variante foi projetada para operações que requerem aplicação rápida e repetitiva em vários assuntos, como supressão de multidões, negação de acesso, controle de tumultos e \"resoluções de disputa de trabalho\".<br>			<br>Mantendo total compatibilidade com as baterias .22HL do Forçador, o NT22-HCS-MP integra uma arquitetura de ciclagem de energia expandida capaz de sustentar fogo automático. Cada projétil é sintetizado em tempo real. Recarregando segue uma sequência simples, projetada para estar familiarizado com aqueles treinados com armamento balístico regular. O parafuso é retraído e travado, a bateria é inserida e o parafuso é então liberado, tipicamente com a característica 'lap'.<br>			<br>As balas .22HL são aceleradas a uma velocidade considerável, que fornecem força cinética significativa no ponto de impacto, dissipando-se instantaneamente, sem deixar material incorporado. O aumento da taxa de fogo vem ao custo de balas ligeiramente menos eficazes produzidas pela arma. No entanto, os sujeitos atingidos por .22HL sofrerão significativa resposta à dor, exaustão e perda da função motora voluntária.<br>			<br>O NT22-HCS-MP apresenta um estoque dobrável, reduzindo seu tamanho e permitindo que ele seja discretamente escondido sob jaquetas ou bolsas. Diretrizes operacionais recomendam a implantação contra indivíduos não conformes onde a dissuasão verbal falhou, e a escalada para resposta letal não é justificada. No entanto, dados longitudinais sobre exposição cumulativa de .22HL permanecem limitados, uma consequência da circulação particularmente restrita de relatórios pós-incidentes." 	)
	update_fire_delay_state()
	update_stock_state()

/obj/item/gun/ballistic/automatic/ntmp5/examine(mob/user)
	. = ..()
	. += span_notice("O estoque está atualmente[stock_retracted ? "retracted" : "extended"]Ctrl-click para comutá-lo.")

/obj/item/gun/ballistic/automatic/ntmp5/proc/on_ctrl_click_stock_toggle(datum/source, mob/user)
	SIGNAL_HANDLER
	stock_retracted = !stock_retracted
	balloon_alert(user, stock_retracted ? "Ações retiradas." : "Estoque estendido")
	playsound(src, 'sound/items/weapons/batonextend.ogg', 50, TRUE)
	update_stock_state()
	return CLICK_ACTION_SUCCESS
/obj/item/gun/ballistic/automatic/ntmp5/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, 		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', 		light_overlay = "flight", 		overlay_x = seclite_overlay_x, 		overlay_y = seclite_overlay_y)

/obj/item/gun/ballistic/automatic/ntmp5/update_icon_state()
	base_icon_state = stock_retracted ? retracted_icon_state : extended_icon_state
	return ..()

/obj/item/gun/ballistic/automatic/ntmp5/proc/update_overlay_states()
	weapon_charge_overlay_state = null
	suppressor_overlay_state = null

	if(magazine)
		var/current_ammo = magazine.ammo_count()
		if(current_ammo <= 0 || magazine.max_ammo <= 0)
			weapon_charge_overlay_state = "ntmp5-empty"
		else
			var/ammo_percent = current_ammo / magazine.max_ammo
			weapon_charge_overlay_state = "ntmp5-full"
			if(ammo_percent < 0.5)
				weapon_charge_overlay_state = "ntmp5-half"

	if(suppressed)
		suppressor_overlay_state = "ntmp5-suppressor"

/obj/item/gun/ballistic/automatic/ntmp5/proc/update_fire_delay_state()
	if(istype(magazine, /obj/item/ammo_box/magazine/recharge/ntmp5/laser) || magazine?.type == /obj/item/ammo_box/magazine/recharge/ntusp)
		fire_delay = 0.25 SECONDS
	else
		fire_delay = 0.15 SECONDS

	if(autofire_component)
		autofire_component.autofire_shot_delay = fire_delay

/obj/item/gun/ballistic/automatic/ntmp5/insert_magazine(mob/user, obj/item/ammo_box/magazine/AM, display_message)
	. = ..()
	if(.)
		update_fire_delay_state()

/obj/item/gun/ballistic/automatic/ntmp5/eject_magazine(mob/user, display_message, obj/item/ammo_box/magazine/tac_load)
	. = ..()
	update_fire_delay_state()

/obj/item/gun/ballistic/automatic/ntmp5/update_overlays()
	var/previous_can_unsuppress = can_unsuppress
	can_unsuppress = FALSE
	. = ..()
	can_unsuppress = previous_can_unsuppress

	update_overlay_states()

	if(suppressor_overlay_state)
		. += suppressor_overlay_state
	if(weapon_charge_overlay_state)
		. += weapon_charge_overlay_state


/obj/item/gun/ballistic/automatic/ntmp5/proc/update_stock_state()
	if(stock_retracted)
		update_weight_class(WEIGHT_CLASS_NORMAL)
		weapon_weight = WEAPON_HEAVY
		recoil = 1
		spread = 12
	else
		update_weight_class(WEIGHT_CLASS_BULKY)
		weapon_weight = WEAPON_MEDIUM
		recoil = 0
		spread = 5
	update_appearance()
