/obj/item/gun/energy/laser/musket
	name = "laser musket"
	desc = "Uma arma laser feita à mão, tem uma manivela na lateral para carregar."
	icon_state = "musket"
	inhand_icon_state = "musket"
	worn_icon_state = "las_musket"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/musket)
	slot_flags = ITEM_SLOT_BACK
	obj_flags = UNIQUE_RENAME
	weapon_weight = WEAPON_HEAVY
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 8, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.2, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.2)
	light_color = COLOR_PURPLE

/obj/item/gun/energy/laser/musket/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable, offset_x = 22, offset_y = 11)

/obj/item/gun/energy/laser/musket/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/crank_recharge, \
		charging_cell = get_cell(), \
		charge_amount = STANDARD_CELL_CHARGE * 0.5, \
		cooldown_time = 2 SECONDS, \
		charge_sound = 'sound/items/weapons/laser_crank.ogg', \
		charge_sound_cooldown_time = 1.8 SECONDS, \
		charge_move = IGNORE_USER_LOC_CHANGE, \
	)

/obj/item/gun/energy/laser/musket/update_icon_state()
	inhand_icon_state = "[initial(inhand_icon_state)][(get_charge_ratio() == 4 ? "charged" : "")]"
	return ..()

/obj/item/gun/energy/laser/musket/prime
	name = "heroic laser musket"
	desc = "Uma arma laser bem projetada e carregada à mão. Seus capacitores sussurram com potencial."
	icon_state = "musket_prime"
	inhand_icon_state = "musket_prime"
	worn_icon_state = "las_musket_prime"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/musket/prime)
	custom_materials = list(
		/datum/material/wood = SHEET_MATERIAL_AMOUNT * 8,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.4,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.35,
		/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 2,
	)


/obj/item/gun/energy/disabler/smoothbore
	name = "smoothbore disabler"
	desc = "Um desativador artesanal, usando uma batida dura em uma célula de energia para disparar o laser atordoador. A falta de concentração adequada significa que não tem precisão."
	icon_state = "smoothbore"
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/smoothbore)
	shaded_charge = 1
	charge_sections = 1
	spread = 22.5
	obj_flags = UNIQUE_RENAME
	custom_materials = list(
		/datum/material/wood = SHEET_MATERIAL_AMOUNT * 8,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.25,
		/datum/material/cardboard = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 1.2,
	)

/obj/item/gun/energy/disabler/smoothbore/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/crank_recharge, \
		charging_cell = get_cell(), \
		charge_amount = STANDARD_CELL_CHARGE, \
		cooldown_time = 2 SECONDS, \
		charge_sound = 'sound/items/weapons/laser_crank.ogg', \
		charge_sound_cooldown_time = 1.8 SECONDS, \
		charge_move = IGNORE_USER_LOC_CHANGE, \
	)

/obj/item/gun/energy/disabler/smoothbore/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 18, \
		overlay_y = 12, \
	) //i swear 1812 being the overlay numbers was accidental

/obj/item/gun/energy/disabler/smoothbore/prime //much stronger than the other prime variants, so dont just put this in as maint loot
	name = "elite smoothbore disabler"
	desc = "Uma versão melhorada da pistola desativadora. Óptica melhorada e tipo celular resultam em boa precisão e capacidade de atirar duas vezes.\
Os parafusos também não se dissipam com impacto com armadura, ao contrário do modelo anterior."
	icon_state = "smoothbore_prime"
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/smoothbore/prime)
	charge_sections = 2
	spread = 0 //could be like 5, but having just very tiny spread kinda feels like bullshit
	custom_materials = list(
		/datum/material/wood = SHEET_MATERIAL_AMOUNT * 8,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.25,
		/datum/material/cardboard = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 5.2)

//Inferno and Cryo Pistols

/obj/item/gun/energy/laser/thermal //the common parent of these guns, it just shoots hard bullets, somoene might like that?
	name = "nanite pistol"
	desc = "Um canhão modificado com uma reserva metamórfica de nanites desarmados. Cuspir bandos de robôs furiosos nos bandidos."
	icon_state = "infernopistol"
	inhand_icon_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/nanite)
	shaded_charge = TRUE
	ammo_x_offset = 1
	obj_flags = UNIQUE_RENAME
	w_class = WEIGHT_CLASS_NORMAL
	dual_wield_spread = 5 //as intended by the coders

/obj/item/gun/energy/laser/thermal/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable, offset_x = 19, offset_y = 13)

/obj/item/gun/energy/laser/thermal/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_SELF|EMP_PROTECT_CONTENTS)
	AddComponent( \
		/datum/component/crank_recharge, \
		charging_cell = get_cell(), \
		spin_to_win = TRUE, \
		charge_amount = LASER_SHOTS(8, STANDARD_CELL_CHARGE), \
		cooldown_time = 0.8 SECONDS, \
		charge_sound = 'sound/items/weapons/kinetic_reload.ogg', \
		charge_sound_cooldown_time = 0.8 SECONDS, \
	)

/obj/item/gun/energy/laser/thermal/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 15, \
		overlay_y = 9)

/obj/item/gun/energy/laser/thermal/inferno //the magma gun
	name = "inferno pistol"
	desc = "Um canhão modificado com uma reserva metamórfica de nanites desarmados. Cuspir bandos de robôs irritados derretidos nos bandidos.\
Embora não manipule a temperatura em si mesma, causa uma erupção violenta em quem está severamente frio. Capaz de gerar\
munição girando manualmente o recipiente de nanite da arma."
	icon_state = "infernopistol"
	light_color = COLOR_RED
	ammo_type = list(/obj/item/ammo_casing/energy/nanite/inferno)

/obj/item/gun/energy/laser/thermal/cryo //the ice gun
	name = "cryo pistol"
	desc = "Um canhão modificado com uma reserva metamórfica de nanites desarmados. Cuspir pedaços de robôs com raiva congelados nos bandidos.\
Embora não manipule a temperatura em si mesma, causa uma explosão interna em quem está muito quente. Capaz de gerar\
munição girando manualmente o recipiente de nanite da arma."
	icon_state = "cryopistol"
	light_color = COLOR_BLUE
	ammo_type = list(/obj/item/ammo_casing/energy/nanite/cryo)

/obj/item/gun/energy/laser/musket/repeater
	name = "iconoclast's repeater"
	desc = "Uma arma de massa incrível, este repetidor de ratos foi permanentemente cortado de seu suporte para ser carregado à mão. Cumbersome, sim - mas poderoso."
	icon_state = "repeater"
	inhand_icon_state = "repeater"
	slowdown = 1
	burst_size = 2
	fire_delay = 0.5
	w_class = WEIGHT_CLASS_HUGE
	ammo_type = list(/obj/item/ammo_casing/energy/laser/musket/repeater/handheld)
	spread = 20
	charge_sections = 1
	item_flags = SLOWS_WHILE_IN_HAND | IMMUTABLE_SLOW
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5.25,
		/datum/material/bronze = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.29
	)

/obj/item/gun/energy/laser/musket/repeater/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/crank_recharge, \
		charging_cell = get_cell(), \
		charge_amount = LASER_SHOTS(6, STANDARD_CELL_CHARGE), \
		cooldown_time = 0.4 SECONDS, \
		charge_sound = 'sound/machines/clockcult/integration_cog_install.ogg', \
		charge_sound_cooldown_time = 3 SECONDS, \
	)
	AddComponent(/datum/component/automatic_fire, 0.5 SECONDS)

/obj/item/gun/energy/laser/musket/repeater/add_deep_lore()
	return

// The Deep Lore //

// Laser Musket

/obj/item/gun/energy/laser/musket/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("think carefully")] to learn a little more about [src]."), \
		lore = "Os primeiros exemplos de mosquetes laser surgiram recentemente, mesmo que as armas improvisadas tiveram\
uma rica história em toda a história humana, Mothic e Tiziran.<br>\
		<br>\
Os mosquetes laser muitas vezes começaram a surgir quando armas ou munições convencionais começaram a ficar escassas, e a quantidade\
de sucata eletrônica e materiais superou a velocidade em que as equipes de engenharia poderia reparar defesas estruturais e\
Infraestrutura. São consideradas como armas de desespero extremo, mas também de grit incomparável diante de uma situação sem esperança.<br>\
		<br>\
Construir um desses é às vezes visto como um ritual de passagem entre grupos de milícias e forças rebeldes. Cada um como único\
como o próximo.<br>\
		<br>\
Qual será o nome deste? Que história escreverá? O tempo certamente dirá." \
	)

// Thermal Pistols

/obj/item/gun/energy/laser/thermal/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "Uma arma sem nome, mais um padrão de design. Exemplos de pistolas térmicas variam muito com base no\
fabricante ou artesão. No entanto, o inventor original da pistola térmica está nublado em mistério.\
Replica versões da pistola estavam circulando muito antes nanites armados foram banidos pelo\
Terragov Acordo de Armas Subdérmicas, e têm continuado a existir como um meio de eliminar os estoques auto-replicantes\
de nanites armados.<br>\
		<br>\
Este é um exemplo do modelo Viper Classic de Nanotrasen, baseado em modelos anteriores da arma na aparência, mas usando\
Câmaras de reprodução de nanites que respondem à articulação do usuário. Isto é, as armas podem ser carregadas com um vigoroso\
Shake. Embora a maioria dos usuários prefira usar a proteção de gatilho personalizada para virá-los em seus dedos. Principalmente para o espetáculo.<br>\
		<br>\
Devido a vários filmes e programas de televisão, ou talvez lendas espaçadas de fantasia, as armas são frequentemente associadas com o\
\"Rangers Espaciais\" que vagam pela periferia e regiões Australicus do espaço. Contos polarizantes de caças de armas roaming\
do posto avançado ao posto avançado, deixando justiça, morte ou apenas uma grande quantidade de nuvens nanitas zumbindo em seu rastro.\
Barões ladrões, advogados fronteiriços. Até mesmo um detetive cozido. Essas armas às vezes são associadas.\
com imagens culturais em torno de individualismo robusto, tenacidade e não conformidade, bem como uma era passada de nobres guerreiros e\
Vilões cruéis. Usar estas armas hoje é visto em grande parte como uma maneira de evocar esta imagem, mesmo que se depare com\
levemente brega.<br>\
		<br>\
Não está totalmente compreendido quem começou a prática de \"parecer\" as pistolas, embora o costume tenha permanecido tanto tempo quanto\
Memória viva. Cada pistola térmica tem um parceiro, e é considerada má sorte separá-los propositadamente." \
	)
