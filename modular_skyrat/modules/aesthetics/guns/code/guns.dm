/obj/item/ammo_casing
	custom_materials = AMMO_MATS_BASIC

/obj/item/ammo_box
	/// When inserted into an ammo workbench, does this ammo box check for parent ammunition to search for subtypes of? Relevant for surplus clips, multi-sprite magazines.
	/// Maybe don't enable this for shotgun ammo boxes.
	var/multitype = TRUE


///GUN SPRITE OVERWRITES
/obj/item/gun/energy/ionrifle
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/energy.dmi'
	lefthand_file = 'modular_skyrat/modules/aesthetics/guns/icons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/aesthetics/guns/icons/guns_righthand.dmi'

/obj/item/gun/energy/ionrifle/carbine
	icon = 'icons/obj/weapons/guns/energy.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'

/obj/item/gun/ballistic/shotgun/riot
	name = "woodstock shotgun"
	desc = "Uma espingarda resistente com uma revista mais longa e um estoque tático fixo projetado para controle não letal de motins. Muitas vezes encontrado na mão de um caçador de lavalândia. Vagamente lembra você de caçar em Sol, não é?"
	fire_delay = 6 //We slighly bump this up because thats a good idea
	sawn_desc = "Venha comigo se quiser viver."

/obj/item/gun/ballistic/shotgun/automatic/combat
	name = "\improper Peacekeeper combat shotgun"
	desc = "Uma espingarda semi-automática Nanotrasen Peacekeeper com mobiliário tático e internos pesados destinados a fogo contínuo. Falta um barril."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/guns48x.dmi'
	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_worn.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/carwo_defense_systems/guns_righthand.dmi'
	inhand_icon_state = "shotgun_combat"
	inhand_x_dimension = 32
	inhand_y_dimension = 32

/obj/item/gun/ballistic/shotgun/automatic/combat/compact
	name = "\improper Peacekeeper compact combat shotgun"
	desc = "Uma variante tática da espingarda de combate de pacificador usada pela NT Raiding Partys e Marines Espaciais. Tem um estabilizador giroscópico, deixando você atirar com uma mão."
	inhand_icon_state = "shotgun_combat_compact"
	weapon_weight = WEAPON_MEDIUM

/obj/item/gun/grenadelauncher
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns.dmi'
	lefthand_file = 'modular_skyrat/modules/aesthetics/guns/icons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/aesthetics/guns/icons/guns_righthand.dmi'

/obj/item/gun/ballistic/automatic/pistol/m1911
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns.dmi'
	inhand_icon_state = "colt"
	lefthand_file = 'modular_skyrat/modules/aesthetics/guns/icons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/aesthetics/guns/icons/guns_righthand.dmi'

/obj/item/gun/ballistic/automatic/c20r
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns.dmi'

/obj/item/gun/ballistic/automatic/m90
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns.dmi'
/obj/item/gun/ballistic/revolver/c38/detective
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns.dmi'

/obj/item/gun/ballistic/automatic/pistol/aps
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns.dmi'

/obj/item/gun/ballistic/automatic/pistol
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns.dmi'

/obj/item/gun/ballistic/automatic/pistol/doorhickey
	icon = 'icons/obj/weapons/guns/ballistic.dmi'

/obj/item/gun/ballistic/automatic/pistol/deagle/regal
	icon = 'icons/obj/weapons/guns/ballistic.dmi'

/obj/item/gun/energy/e_gun/nuclear
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/nucgun.dmi'
	ammo_x_offset = 2
	lefthand_file = 'modular_skyrat/modules/aesthetics/guns/icons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/aesthetics/guns/icons/guns_righthand.dmi'
	worn_icon_state = "gun"
	worn_icon = null

/obj/item/gun/energy/e_gun/nuclear/rainbow
	name = "fantastic energy gun"
	desc = "Uma arma de energia com um reator nuclear experimental miniaturizado que carrega automaticamente a célula de energia interna. Este parece bem chique!"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/rainbow, /obj/item/ammo_casing/energy/disabler/rainbow)

/obj/item/ammo_casing/energy/laser/rainbow
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/nucgun.dmi'
	icon_state = "laser"
	select_name = "kill"
	projectile_type = /obj/projectile/beam/laser/rainbow

/obj/projectile/beam/laser/rainbow
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/nucgun.dmi'
	icon_state = "laser"

/obj/item/ammo_casing/energy/disabler/rainbow
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/nucgun.dmi'
	icon_state = "laser"
	select_name = "disable"
	projectile_type = /obj/projectile/beam/disabler/rainbow

/obj/projectile/beam/disabler/rainbow
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/nucgun.dmi'
	icon_state = "laser"

/obj/item/gun/energy/e_gun/nuclear/emag_act(mob/user, obj/item/card/emag/E)
	. = ..()
	if(obj_flags & EMAGGED)
		return FALSE
	if(pin)
		to_chat(user, span_warning("Você provavelmente quer fazer isso com uma arma nova!"))
		return FALSE
	to_chat(user, "<font color='#ff2700'>T</font><font color='#ff4e00'>H</font><font color='#ff7500'>E</font> <font color='#ffc400'>G</font><font color='#ffeb00'>U</font><font color='#ebff00'>n</font> <font color='#9cff00'>S</font><font color='#75ff00'>U</font><font color='#4eff00'>D</font><font color='#27ff00'>D</font><font color='#00ff00'>E</font><font color='#00ff27'>n</font><font color='#00ff4e'>L</font><font color='#00ff75'>Sim.</font> <font color='#00ffc4'>F</font><font color='#00ffeb'>E</font><font color='#00ebff'>E</font><font color='#00c4ff'>L</font><font color='#009cff'>S</font> <font color='#004eff'>q</font><font color='#0027ff'>U</font><font color='#0000ff'>I</font><font color='#2700ff'>T</font><font color='#4e00ff'>E</font> <font color='#9c00ff'>F</font><font color='#c400ff'>a</font><font color='#eb00ff'>n</font><font color='#ff00eb'>T</font><font color='#ff00c4'>a</font><font color='#ff009c'>S</font><font color='#ff0075'>T</font><font color='#ff004e'>I</font><font color='#ff0027'>c</font><font color='#ff0000'>!</font>")
	new /obj/item/gun/energy/e_gun/nuclear/rainbow(get_turf(user))
	obj_flags |= EMAGGED
	qdel(src)
	return TRUE

/obj/item/gun/energy/e_gun/nuclear/rainbow/update_overlays()
	. = ..()
	. += "[icon_state]_emagged"

/obj/item/gun/energy/e_gun/nuclear/rainbow/emag_act(mob/user, obj/item/card/emag/E)
	return FALSE

//BEAM SOUNDS
/obj/item/ammo_casing/energy
	fire_sound = 'modular_skyrat/modules/aesthetics/guns/sound/laser.ogg'

/obj/item/ammo_casing/energy/laser/pulse
	fire_sound = 'modular_skyrat/modules/aesthetics/guns/sound/pulse.ogg'

/obj/item/gun/energy/xray
	fire_sound_volume = 100

/obj/item/ammo_casing/energy/xray
	fire_sound = 'modular_skyrat/modules/aesthetics/guns/sound/xray_laser.ogg'

/obj/item/ammo_casing/energy/laser/accelerator
	fire_sound = 'modular_skyrat/modules/aesthetics/guns/sound/laser_cannon_fire.ogg'

/obj/item/gun/ballistic/automatic/sniper_rifle
	name = "sniper rifle"
	desc = "Uma arma de longo alcance que causa danos significativos. Não, não pode."
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns_gubman2.dmi'
	icon_state = "sniper"
	w_class = WEIGHT_CLASS_BULKY
	inhand_icon_state = "sniper"
	worn_icon_state = null
	fire_sound = 'sound/items/weapons/gun/sniper/shot.ogg'
	fire_sound_volume = 90
	load_sound = 'sound/items/weapons/gun/sniper/mag_insert.ogg'
	rack_sound = 'sound/items/weapons/gun/sniper/rack.ogg'
	suppressed_sound = 'sound/items/weapons/gun/general/heavy_shot_suppressed.ogg'
	recoil = 2
	weapon_weight = WEAPON_HEAVY
	accepted_magazine_type = /obj/item/ammo_box/magazine/sniper_rounds
	fire_delay = 6 SECONDS
	burst_size = 1
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BACK
	actions_types = list()
	mag_display = TRUE
	suppressor_x_offset = 3
	suppressor_y_offset = 3

/obj/item/gun/ballistic/automatic/sniper_rifle/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 2)

/obj/item/gun/ballistic/automatic/sniper_rifle/reset_fire_cd()
	. = ..()
	if(suppressed)
		playsound(src, 'sound/machines/eject.ogg', 25, TRUE, ignore_walls = FALSE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_distance = 0)
	else
		playsound(src, 'sound/machines/eject.ogg', 50, TRUE)

/obj/item/gun/ballistic/automatic/sniper_rifle/syndicate
	name = "syndicate sniper rifle"
	desc = "Um rifle de calibre 50 com compatibilidade de supressão. O reconhecimento ainda não funciona."
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns_gubman2.dmi'
	icon_state = "sniper2"
	worn_icon_state = "sniper"
	fire_delay = 5.5 SECONDS
	can_suppress = TRUE
	can_unsuppress = TRUE
	pin = /obj/item/firing_pin/implant/pindicate

/obj/item/gun/ballistic/automatic/sniper_rifle/modular
	name = "AUS-107 anti-materiel rifle"
	desc = "Um devastador rifle pesado Aussec Arsenal, equipado com uma mira moderna."
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns_gubman2.dmi'
	icon_state = "sniper"
	worn_icon_state = "sniper"
	fire_sound = 'modular_skyrat/modules/aesthetics/guns/sound/sniperrifle.ogg'
	suppressed_sound = 'modular_skyrat/modules/aesthetics/guns/sound/sniperrifle_s.ogg'
	w_class = WEIGHT_CLASS_BULKY
	can_suppress = FALSE

/obj/item/gun/ballistic/automatic/sniper_rifle/modular/syndicate
	name = "'Caracal' anti-materiel rifle"  //we flop out
	desc = "Um leve e elegante rifle .416 Sniper Stabilis com um barril alternativo, apelidado de Caracal por Scarborough Arms. Suas peças dobráveis compactas o tornam capaz de caber em uma mochila, e seu barril modular pode ter um supressor instalado dentro dela em vez de como uma extensão focinho. Seu escopo avançado é responsável por todas as imprecisões balísticas de um barril alternativo."
	icon_state = "sysniper"
	fire_sound = 'modular_skyrat/modules/aesthetics/guns/sound/sniperrifle.ogg'
	suppressed_sound = 'modular_skyrat/modules/aesthetics/guns/sound/sniperrifle_s.ogg'
	fire_delay = 4 SECONDS //Delay reduced thanks to recoil absorption
	burst_size = 0.5
	recoil = 1
	can_suppress = TRUE
	can_unsuppress = TRUE
	weapon_weight = WEAPON_LIGHT

/obj/item/gun/ballistic/automatic/sniper_rifle/modular/syndicate/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SCARBOROUGH)

/obj/item/gun/ballistic/automatic/sniper_rifle/modular/blackmarket  //Normal sniper but epic
	name = "SA-107 anti-materiel rifle"
	desc = "Uma entrega ilegal de armas Scarborough de um rifle Aussec Armory. Este foi equipado com um escopo pesado, um estoque mais resistente, e tem um freio de focinho removível que permite fácil fixação de supressores."
	icon_state = "sniper2"
	fire_sound = 'modular_skyrat/modules/aesthetics/guns/sound/sniperrifle.ogg'
	suppressed_sound = 'modular_skyrat/modules/aesthetics/guns/sound/sniperrifle_s.ogg'
	fire_sound_volume = 90
	vary_fire_sound = FALSE
	load_sound = 'sound/items/weapons/gun/sniper/mag_insert.ogg'
	rack_sound = 'sound/items/weapons/gun/sniper/rack.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	can_suppress = TRUE
	can_unsuppress = TRUE
	recoil = 1.8
	weapon_weight = WEAPON_HEAVY
	accepted_magazine_type = /obj/item/ammo_box/magazine/sniper_rounds
	fire_delay = 55 //Slightly smaller than standard sniper
	burst_size = 1
	slot_flags = ITEM_SLOT_BACK
	mag_display = TRUE

/obj/item/gun/ballistic/automatic/ar/modular
	name = "\improper NT ARG-63"
	desc = "A principal opção balística de Nanotrasen baseada no projeto Stoner, equipado com uma moldura de polímero leve e outros móveis táticos, e alojado em .277 Aestus - apelidado de \"Boarder\" por equipes de Operações Especiais."
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns_gubman2.dmi'
	icon_state = "arg"
	inhand_icon_state = "arg"
	can_suppress = FALSE

// GUBMAN3 - FULL BULLET RENAME
// i loathe the above

// overrides for 10mm ammo in modular_skyrat\modules\sec_haul\code\guns\bullets.dm

// overrides for .310 Strilka-derived ammo, e.g. lionhunter ammo, because you don't want to give security the ability to print infinite wallhack ammo, right?
/obj/item/ammo_casing/strilka310/lionhunter
	name = "hunter's rifle round"
	can_be_printed = FALSE // trust me bro you dont wanna give security homing wallhack Better Rubbers

/obj/item/ammo_casing/strilka310/enchanted
	name = "enchanted rifle round"
	can_be_printed = FALSE // these are Really Really Better Rubbers

// overrides for tgcode's .223 (formerly 5.56), used in the M90-gl - renamed to .277 Aestus
/obj/item/ammo_casing/a223
	name = ".277 Aestus casing"
	desc = "Uma bala .277."

/obj/item/ammo_casing/a223/phasic
	name = ".277 Aestus phasic casing"
	desc = "Um cartucho de bala Aestus .277.<br><br>	<i>Ignora todas as superfícies exceto matéria orgânica.</i>"
	advanced_print_req = TRUE
	custom_materials = AMMO_MATS_PHASIC

// shotgun ammo overrides moved to modular_skyrat\modules\shotgunrebalance\code\shotgun.dm

// overrides for tgcode .50cal, used in their sniper/anti-materiel rifles
/obj/item/ammo_casing/p50
	name = ".416 Stabilis casing"
	desc = "Uma cápsula de bala .416."
	advanced_print_req = TRUE // you are NOT printing more ammo for this without effort.
	// then again the offstations with ammo printers and sniper rifles come with an ammo disk anyway, so

/obj/item/ammo_casing/p50/surplus
	name = ".416 Stabilis surplus casing"
	desc = "Uma cápsula de bala .416. Intencionalmente sobrecarregado, mas ainda muito doloroso para ser baleado.<br><br>	<i>Falta capacidade de penetração de armaduras, contato com tubulação ou desmembramento inato. Ainda é muito doloroso ser atingido.</i>"
	projectile_type = /obj/projectile/bullet/p50/surplus

/obj/item/ammo_casing/p50/disruptor
	name = ".416 Stabilis disruptor casing"
	desc = "Uma cápsula de bala .416. Especializa-se em mandar o alvo dormir em vez do inferno, a menos que sejam sintéticos. Provavelmente vão para o inferno.<br><br>	<i>Força alvos humanóides a dormir, causa danos pesados contra cyborgs, EMPs atingiu alvos.</i>"

/obj/item/ammo_casing/p50/incendiary
	name = ".416 Stabilis precision incendiary casing"
	desc = "Uma cápsula de bala .416. Feito com uma ponta de plasma agitado, para fazer as pessoas se arrependerem de estar vivas.<br><br>	<i>Falta habilidade inata de desmembramento e contato, sofre contra armadura mecanizada. Põe as pessoas em chamas.</i>"
	projectile_type = /obj/projectile/bullet/p50/incendiary

/obj/item/ammo_casing/p50/penetrator
	name = ".416 Stabilis penetrator sabot casing"
	desc = "Uma cápsula de bala .416. Carregado com um sabot endurecido e embalado com propelente extra. Projetado para passar por basicamente tudo. Um rótulo avisa sobre o risco de sobrepressão, e não usar a bala se uma determinada arma não puder lidar com pressões maiores que 85000 PSI.<br><br>	<i>Passa basicamente por tudo. Falta habilidade inata de desmembramento e capacidade de contato.</i>"

/obj/item/ammo_casing/p50/marksman
	name = ".416 Stabilis marksman hyperkinetic casing"
	desc = "Uma cápsula de bala .416. Carregado com uma bala hipercinética que ignora coisas mundanas como\"Tempo de viagem\"e uma quantidade relativa de propulsor experimental. Um rótulo avisa sobre risco de sobrepressão, e para não usar a bala se uma determinada arma não pode lidar com pressões superiores a 95000 PSI.<br><br>	<i>Balas têm<b>Não.</b>Tempo de viagem, e pode ricochetear uma vez. Faz menos estragos, falta desmembramento inato e capacidade de contato.</i>"
	projectile_type = /obj/projectile/bullet/p50/marksman

// overrides for tgcode 4.6x30mm, used in the WT-550
/obj/item/ammo_casing/c46x30mm
	name = "8mm Usurpator bullet casing"
	desc = "Um cartucho de 8mm."

/obj/item/ammo_casing/c46x30mm/ap
	name = "8mm Usurpator armor-piercing bullet casing"
	desc = "Um cartucho de 8mm perfurante.<br><br>	<i>Maior capacidade de perfuração de armaduras. O que esperava?</i>"
	custom_materials = AMMO_MATS_AP
	advanced_print_req = TRUE

/obj/item/ammo_casing/c46x30mm/inc
	name = "8mm Usurpator incendiary bullet casing"
	desc = "Um cartucho incendiário de 8mm.<br><br>	<i>Deixa uma trilha de fogo quando atira, põe alvos em chamas.</i>"
	custom_materials = AMMO_MATS_TEMP
	advanced_print_req = TRUE

// overrides for tgcode .45, used in the M1911 and C20-r
/obj/item/ammo_casing/c45
	name = ".460 Ceres bullet casing"
	desc = "Uma bala .460."

/obj/item/ammo_casing/c45/ap
	name = ".460 Ceres armor-piercing bullet casing"
	desc = "Uma cápsula de bala 460 perfurante.<br><br>	<i>Maior capacidade de perfuração de armaduras. O que esperava?</i>"
	custom_materials = AMMO_MATS_AP
	advanced_print_req = TRUE

/obj/item/ammo_casing/c45/inc
	name = ".460 Ceres incendiary bullet casing"
	desc = "Um cartucho incendiário .460.<br><br>	<i>Deixa uma trilha de fogo quando atira, põe alvos em chamas.</i>"
	custom_materials = AMMO_MATS_TEMP
	advanced_print_req = TRUE

// overrides for .50AE, used in the deagle
/obj/item/ammo_casing/a50ae
	name = ".454 Trucidator bullet casing"
	desc = "Um cartucho de bala Trucidator 454. Extremamente poderoso.<br><br>	<i>Disparado de uma arma, causa danos desproporcionalmente grandes.</i>"

// overrides for .357, used in the .357 revolver
/obj/item/ammo_casing/a357    //We can keep the Magnum classic.
	name = ".357 bullet casing"
	desc = "Uma bala .357.<br><br>	<i>Disparado de uma arma, causa danos desproporcionalmente grandes.</i>"

/obj/item/ammo_casing/a357/match
	desc = "Uma cápsula de bala .357, fabricada com padrões extremamente elevados.<br><br>	<i>Ricochetes por toda parte. Como louco.</i>"

/obj/item/ammo_casing/a357/phasic
	desc = "Uma cápsula de bala .357.<br><br>	<i>Ignora todas as superfícies exceto matéria orgânica.</i>"
	advanced_print_req = TRUE
	custom_materials = AMMO_MATS_PHASIC

/obj/item/ammo_casing/a357/heartseeker
	desc = "Um cartucho de bala 357.<br><br>	<i>Tem capacidade de localização, metodologia desconhecida.</i>"
	advanced_print_req = TRUE
	custom_materials = AMMO_MATS_HOMING // meme ammo. meme print cost

// overrides for .38 Special, used in the .38 revolvers, including the det's
/obj/item/ammo_box/speedloader/c38
	caliber = CALIBER_38

/obj/item/ammo_casing/c38/trac
	custom_materials = AMMO_MATS_TRAC
	advanced_print_req = TRUE

/obj/item/ammo_casing/c38/dumdum
	advanced_print_req = TRUE

/obj/item/ammo_casing/c38/hotshot
	custom_materials = AMMO_MATS_TEMP
	advanced_print_req = TRUE

/obj/item/ammo_casing/c38/iceblox
	custom_materials = AMMO_MATS_TEMP // plasma's wack.
	advanced_print_req = TRUE

// The ones above are the casings for the ammo, whereas the ones below are the actual projectiles that give you feedback when you're shot

/obj/projectile/bullet/a223
	name = ".277 Aestus bullet"

/obj/projectile/bullet/a223/phasic
	name = ".277 phasic bullet"

/obj/projectile/bullet/c9mm
	name = "9x25mm bullet"

/obj/projectile/bullet/c9mm/ap
	name = "9x25mm armor-piercing bullet"

/obj/projectile/bullet/c9mm/hp
	name = "9x25mm fragmenting bullet"

/obj/projectile/bullet/incendiary/c9mm
	name = "9x25mm incendiary bullet"

/obj/projectile/bullet/c45
	name = ".460 bullet"

/obj/projectile/bullet/c45/ap
	name = ".460 armor-piercing bullet"

/obj/projectile/bullet/incendiary/c45
	name = ".460 incendiary bullet"

/obj/projectile/bullet/c46x30mm
	name = "8mm Usurpator bullet"

/obj/projectile/bullet/c46x30mm/ap
	name = "8mm armor-piercing bullet"

/obj/projectile/bullet/incendiary/c46x30mm
	name = "8mm incendiary bullet"

/obj/projectile/bullet/p50
	name = ".416 Stabilis bullet"

/obj/projectile/bullet/p50/disruptor
	name = ".416 disruptor bullet"

/obj/projectile/bullet/p50/penetrator
	name = ".416 penetrator bullet"

/obj/projectile/bullet/a50ae
	name = ".454 Trucidator bullet"


// MAGAZINES UPDATED TO MATCH STUFF

/obj/item/ammo_box/magazine/wt550m9
	name = "\improper WT-550 magazine"
	desc = "Uma revista Usurpator de 8mm com 20 balas que se encaixa perfeitamente na WT-550."

/obj/item/ammo_box/magazine/wt550m9/wtap
	name = "\improper WT-550 AP magazine"

/obj/item/ammo_box/magazine/wt550m9/wtic
	name = "\improper WT-550 IND magazine"

/obj/item/ammo_box/magazine/smgm45
	name = ".460 Ceres SMG magazine"
	desc = "Uma revista com .460 era para caber em metralhadoras."

/obj/item/ammo_box/magazine/smgm45/ap
	name = ".460 Ceres AP SMG magazine"

/obj/item/ammo_box/magazine/smgm45/incen
	name = ".460 Ceres IND SMG magazine"

/obj/item/ammo_box/magazine/tommygunm45
	name = "\improper Tommy Gun .460 Ceres drum"
	desc = "Uma revista de discos com câmara para 460 Ceres."

/obj/item/ammo_box/magazine/m556
	name = ".277 Aestus toploading magazine"
	desc = "Uma revista de recarga de .277 Aestus."

/obj/item/ammo_box/magazine/m556/phasic
	name = ".277 PHASE toploading magazine"

/obj/item/ammo_box/magazine/sniper_rounds
	name = "anti-materiel rifle magazine"
	desc = "Uma revista pesada alojada para .416 Estabilis."

/obj/item/ammo_box/magazine/sniper_rounds/soporific
	desc = "Uma revista com munição 416 Stabilis, projetada para dias felizes e noites tranquilas."

/obj/item/ammo_box/magazine/sniper_rounds/penetrator
	name = "anti-materiel rifle ++P magazine"
	desc = "Uma revista pesada com sobreposição, sobrepressurizada, e, francamente, sobre o topo .416 munição penetrante."

/obj/item/ammo_box/magazine/m50
	name = ".454 Trucidator handcannon magazine"
	desc = "Uma revista absurdamente THICK possivelmente significava para uma pistola pesada, se você pode chamá-lo assim."
