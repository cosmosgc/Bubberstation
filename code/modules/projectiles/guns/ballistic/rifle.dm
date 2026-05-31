/obj/item/gun/ballistic/rifle
	name = "Bolt Rifle"
	desc = "Algum tipo de rifle de ação. Você sente que não deveria ter isso."
	icon = 'icons/obj/weapons/guns/wide_guns.dmi'
	icon_state = "sakhno"
	w_class = WEIGHT_CLASS_BULKY
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction
	bolt_wording = "bolt"
	bolt_type = BOLT_TYPE_LOCKING
	semi_auto = FALSE
	internal_magazine = TRUE
	fire_sound = 'sound/items/weapons/gun/rifle/shot_heavy.ogg'
	fire_sound_volume = 90
	rack_sound = 'sound/items/weapons/gun/rifle/bolt_out.ogg'
	bolt_drop_sound = 'sound/items/weapons/gun/rifle/bolt_in.ogg'
	drop_sound = 'sound/items/handling/gun/ballistics/rifle/rifle_drop1.ogg'
	pickup_sound = 'sound/items/handling/gun/ballistics/rifle/rifle_pickup1.ogg'
	tac_reloads = FALSE
	/// Does the bolt need to be open to interact with the gun (e.g. magazine interactions)?
	var/need_bolt_lock_to_interact = FALSE

/obj/item/gun/ballistic/rifle/rack(mob/user = null)
	if (bolt_locked == FALSE)
		balloon_alert(user, "Bolso aberto")
		playsound(src, rack_sound, rack_sound_volume, rack_sound_vary)
		process_chamber(FALSE, FALSE, FALSE)
		bolt_locked = TRUE
		update_appearance()
		return
	drop_bolt(user)


/obj/item/gun/ballistic/rifle/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(need_bolt_lock_to_interact && !bolt_locked && !istype(tool, /obj/item/knife))
		balloon_alert(user, "Fechado!")
		return

	return ..()

/obj/item/gun/ballistic/rifle/can_shoot()
	if (bolt_locked)
		return FALSE
	return ..()

/obj/item/gun/ballistic/rifle/examine(mob/user)
	. = ..()
	. += "The bolt is [bolt_locked ? "open" : "closed"]."

///////////////////////
// BOLT ACTION RIFLE //
///////////////////////

/obj/item/gun/ballistic/rifle/boltaction
	name = "\improper Sakhno Precision Rifle"
	desc = "Um Rifle de Precisão Sakhno, uma arma de ação de parafusos que era (e certamente ainda é) popular entre homens de fronteiras, cargueiros, forças de segurança privadas, exploradores, e outros tipos desagradáveis. Este padrão particular do rifle remonta a 2440."
	sawn_desc = "Um rifle de precisão de Sakhno, popularmente conhecido como\"Obrez.\"Provavelmente havia uma razão para não ter sido fabricado tão curto. Apesar da terrível natureza da modificação, a arma parece estar em boas condições."

	icon_state = "sakhno"
	inhand_icon_state = "sakhno"
	worn_icon_state = "sakhno"

	slot_flags = ITEM_SLOT_BACK
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction
	can_be_sawn_off = TRUE
	weapon_weight = WEAPON_HEAVY
	need_bolt_lock_to_interact = TRUE
	var/jamming_chance = 20
	var/unjam_chance = 10
	var/jamming_increment = 5
	var/jammed = FALSE
	var/can_jam = FALSE

	SET_BASE_PIXEL(-8, 0)

/obj/item/gun/ballistic/rifle/boltaction/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable, offset_x = 41, offset_y = 14, bayonet_overlay = "bayonet_thin")

/obj/item/gun/ballistic/rifle/boltaction/sawoff(mob/user)
	. = ..()
	if(.)
		spread = 36
		SET_BASE_PIXEL(0, 0)
		update_appearance()

/obj/item/gun/ballistic/rifle/boltaction/attack_self(mob/user)
	if(jammed)
		if(prob(unjam_chance))
			jammed = FALSE
			unjam_chance = initial(unjam_chance)
		else
			unjam_chance += 10
			balloon_alert(user, "Encravado!")
			playsound(user,'sound/items/weapons/jammed.ogg', 75, TRUE)
			return FALSE
	return ..()

/obj/item/gun/ballistic/rifle/boltaction/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)
	if(can_jam)
		if(chambered.loaded_projectile)
			if(prob(jamming_chance))
				jammed = TRUE
			jamming_chance += jamming_increment
			jamming_chance = clamp (jamming_chance, 0, 100)
	return ..()

/obj/item/gun/ballistic/rifle/boltaction/blow_up(mob/user)
	. = FALSE
	if(chambered?.loaded_projectile)
		process_fire(user, user, FALSE)
		. = TRUE

/obj/item/gun/ballistic/rifle/boltaction/harpoon
	name = "ballistic harpoon gun"
	desc = "Uma arma favorecida por caçadores de carpas, mas também infamemente empregada por agentes do Consórcio dos Direitos dos Animais contra agressores humanos. Porque é irônico."
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "speargun"
	inhand_icon_state = "speargun"
	worn_icon_state = "speargun"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/harpoon
	fire_sound = 'sound/items/weapons/gun/sniper/shot.ogg'
	can_be_sawn_off = FALSE

	SET_BASE_PIXEL(0, 0)

/obj/item/gun/ballistic/rifle/boltaction/surplus
	name = "\improper Sakhno M2442 Army"
	desc = "Uma modificação do rifle de precisão Sakhno,\"Exército Sakhno M2442\"está estampado no lado. Não se sabe para que exército esse padrão de rifle foi feito ou se foi usado por um exército de qualquer tipo. O que você pode discernir, no entanto, é que seu proprietário anterior não tratou bem a arma. Por alguma razão, há umidade por todo o interior."
	sawn_desc = "Um rifle de precisão de Sakhno, popularmente conhecido como\"Obrez.\". 		\"Exército Sakhno M2442\"está estampado no lado dele. Havia provavelmente uma razão para não ter sido fabricado tão curto. Cortar a arma parece não ter ajudado com o problema da umidade."
	icon_state = "sakhno_tactifucked"
	inhand_icon_state = "slopno"
	worn_icon_state = "slopno"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/surplus
	can_jam = TRUE

/obj/item/gun/ballistic/rifle/boltaction/surplus/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable, offset_x = 41, offset_y = 14, bayonet_overlay = "bayonet_thin_surplus")

/obj/item/gun/ballistic/rifle/boltaction/prime
	name = "\improper Sakhno-Zhihao Sporting Rifle"
	desc = "Uma atualização e modernização do rifle Sakhno original, feito com tais maravilhas como materiais modernos, um escopo, e outros avanços tecnológicos impressionantes que, para ser honesto, já estavam por perto quando a arma original foi projetada. Surpreendentemente para um rifle deste tipo, o escopo realmente tem ampliação, em vez de ser decorativo."
	icon_state = "zhihao"
	inhand_icon_state = "zhihao"
	worn_icon_state = "zhihao"
	can_be_sawn_off = TRUE
	sawn_desc = "Um Sakhno-Zhihao Sporting Rifle... Fazer isso foi pecado, espero que esteja feliz. Você agora é provavelmente uma das poucas pessoas no universo a ter um\"Obrez Moderna\"Tudo que você tinha que fazer era pegar uma chave inglesa para tirar. Mas não, você só tinha que ir para a serra."
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/phasic

/obj/item/gun/ballistic/rifle/boltaction/prime/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1.5)

/obj/item/gun/ballistic/rifle/boltaction/prime/sawoff(mob/user)
	. = ..()
	if(.)
		name = "\improper Obrez Moderna" // wear it loud and proud

/obj/item/gun/ballistic/rifle/boltaction/donkrifle
	name = "\improper Donk Co. Jezail"
	desc = "Um rifle esportivo fabricado em massa com um cano bem longo. Poderoso o suficiente para derrubar um urso espacial de mil passos. O barril alongado dá-lhe boa precisão e poder, mesmo ao alcance."
	w_class = WEIGHT_CLASS_HUGE
	lefthand_file = 'icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'icons/mob/inhands/weapons/64x_guns_right.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	icon_state = "jezail"
	inhand_icon_state = "jezail"
	worn_icon_state = "jezail"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/jezail
	can_be_sawn_off = TRUE
	sawn_desc = "Um rifle esportivo fabricado em massa com um cano bem longo. Poderoso o suficiente para derrubar um urso espacial de mil passos. Seu barril foi cortado, então sua potência e precisão foram prejudicadas."

/obj/item/gun/ballistic/rifle/boltaction/donkrifle/sawoff(mob/user) //the heavy price one pays for fitting this in a backpack
	. = ..()
	if(.)
		projectile_damage_multiplier = 0.75
		spread = 50

/obj/item/gun/ballistic/rifle/rebarxbow
	name = "heated rebar crossbow"
	desc = "Uma besta artesanal. Além das hastes de ferro afiadas convencionais, ele também pode disparar munição especial feita do cristalizador de atmos - zaukerite, hidrogênio metálico, e varas de hearium todos funcionam. Muito lento para recarregar - você pode fazer a besta com um pé de cabra para afrouxar a barra transversal, mas arriscar um erro de fogo, ou pior..."
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "rebarxbow"
	inhand_icon_state = "rebarxbow"
	worn_icon_state = "rebarxbow"
	rack_sound = 'sound/items/weapons/gun/sniper/rack.ogg'
	mag_display = FALSE
	empty_indicator = TRUE
	bolt_type = BOLT_TYPE_OPEN
	semi_auto = FALSE
	internal_magazine = TRUE
	can_modify_ammo = FALSE
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_SUITSTORE
	bolt_wording = "bowstring"
	magazine_wording = "rod"
	cartridge_wording = "rod"
	weapon_weight = WEAPON_HEAVY
	initial_caliber = CALIBER_REBAR
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/rebarxbow/normal
	fire_sound = 'sound/items/xbow_lock.ogg'
	can_be_sawn_off = FALSE
	tac_reloads = FALSE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3.1, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 1.2)
	var/draw_time = 3 SECONDS
	SET_BASE_PIXEL(0, 0)

/obj/item/gun/ballistic/rifle/rebarxbow/rack(mob/user = null)
	if (bolt_locked)
		drop_bolt(user)
		return
	balloon_alert(user, "Fio de arco solto.")
	playsound(src, rack_sound, rack_sound_volume, rack_sound_vary)
	handle_chamber(empty_chamber =  FALSE, from_firing = FALSE, chamber_next_round = FALSE)
	bolt_locked = TRUE
	update_appearance()

/obj/item/gun/ballistic/rifle/rebarxbow/drop_bolt(mob/user = null)
	if(!do_after(user, draw_time, target = src))
		return
	playsound(src, bolt_drop_sound, bolt_drop_sound_volume, FALSE)
	balloon_alert(user, "Fio de arco desenhado")
	chamber_round()
	bolt_locked = FALSE
	update_appearance()

/obj/item/gun/ballistic/rifle/rebarxbow/shoot_live_shot(mob/living/user)
	..()
	rack()

/obj/item/gun/ballistic/rifle/rebarxbow/can_shoot()
	if (bolt_locked)
		return FALSE
	return ..()

/obj/item/gun/ballistic/rifle/rebarxbow/shoot_with_empty_chamber(mob/living/user)
	if(chambered || !magazine || !length(magazine.contents))
		return ..()
	drop_bolt(user)

/obj/item/gun/ballistic/rifle/rebarxbow/examine(mob/user)
	. = ..()
	. += "The crossbow is [bolt_locked ? "not ready" : "ready"] to fire."

/obj/item/gun/ballistic/rifle/rebarxbow/update_overlays()
	. = ..()
	if(!magazine)
		. += "[initial(icon_state)]" + "_empty"
	if(!bolt_locked)
		. += "[initial(icon_state)]" + "_bolt_locked"

/obj/item/gun/ballistic/rifle/rebarxbow/forced
	name = "stressed rebar crossbow"
	desc = "Algum idiota decidiu que arriscaria atirar na cara se isso significasse que eles poderiam ter um desenho desta besta um pouco mais rápido. Espero que tenha valido a pena."
	// Feel free to add a recipe to allow you to change it back if you would like, I just wasn't sure if you could have two recipes for the same thing.
	can_misfire = TRUE
	draw_time = 1.5
	misfire_probability = 25
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/rebarxbow/force

/obj/item/gun/ballistic/rifle/rebarxbow/syndie
	name = "syndicate rebar crossbow"
	desc = "O sindicato gostou dos engenheiros de arco-arco bootleg da NT, então eles mostraram o que poderia ser se devidamente desenvolvido. Segura três tiros sem chance de explodir, e possui um escopo construído. Compatível com toda munição conhecida."
	icon_state = "rebarxbowsyndie"
	inhand_icon_state = "rebarxbowsyndie"
	worn_icon_state = "rebarxbowsyndie"
	w_class = WEIGHT_CLASS_NORMAL
	initial_caliber = CALIBER_REBAR
	draw_time = 1
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/rebarxbow/syndie

/obj/item/gun/ballistic/rifle/rebarxbow/syndie/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 2) //enough range to at least be useful for stealth

/// PIPE GUNS ///

/obj/item/gun/ballistic/rifle/boltaction/pipegun
	name = "pipegun"
	desc = "Um símbolo de que os verdadeiros mestres deste lugar não são aqueles que apenas o habitam, mas aquele disposto a torcê-lo para uma intenção de matar."
	icon_state = "pipegun"
	inhand_icon_state = "pipegun"
	worn_icon_state = "pipegun"
	fire_sound = 'sound/items/weapons/gun/sniper/shot.ogg'
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 8, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 8, /datum/material/cardboard = SHEET_MATERIAL_AMOUNT)
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/pipegun

	projectile_damage_multiplier = 1.35
	obj_flags = UNIQUE_RENAME
	can_be_sawn_off = FALSE
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL
	pb_knockback = 3

	SET_BASE_PIXEL(-8, 0)

/obj/item/gun/ballistic/rifle/boltaction/pipegun/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/examine_lore, 		lore_hint = span_notice("Você pode.[EXAMINE_HINT("look closer")]para recordar uma história sobre[src]."), 		lore = "<b>Você foi contada esta história, em tons silenciosos, de um homem wizened em um macacão cinza ...</b><br><br>Dizem que o primeiro assassinato cometido em uma estação espacial Nanotrasen foi por um assistente.<br><br>Que esse ato, feito pela caixa de ferramentas, talvez a lança, foi o que entregou a sua espécie a uma vida de miséria, rejeição e violência.<br><br>Eles carregam o peso deste ato visivelmente, o macacão cinza. Respirando ar profundamente filtrado. E com mãos amarelas encharcadas em punhos.<br><br>Olhos afiados e esperando. Caçadores no escuro.<br><br>Eventualmente, esses espíritos assassinos procuraram reivindicar as tumbas de metal onde estavam presos. Rejeitando o status deles. Determinado a ser algo mais.<br><br>Esta arma é uma dessas ferramentas. E é realmente sombrio. Viciado em sucata, retirado das paredes e pisos da estação e os pregos segurando-o juntos.<br>		<br>É um símbolo que os verdadeiros mestres deste lugar não são aqueles que apenas habitam. Mas aquele disposto a torcê-lo para uma intenção de matar." 	)

/obj/item/gun/ballistic/rifle/boltaction/pipegun/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable, offset_x = 35, offset_y = 10)

/obj/item/gun/ballistic/rifle/boltaction/pipegun/handle_chamber(empty_chamber = TRUE, from_firing = TRUE, chamber_next_round = TRUE)
	. = ..()
	do_sparks(1, TRUE, src)

/obj/item/gun/ballistic/rifle/boltaction/pipegun/pistol
	name = "pipe pistol"
	desc = "É tolice pensar que alguém usando o cinza é incapaz de te machucar, simplesmente porque eles não estão arrancando os dentes."
	icon_state = "pipepistol"
	inhand_icon_state = "pipepistol"
	worn_icon_state = "gun"
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 4, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 7, /datum/material/cardboard = SHEET_MATERIAL_AMOUNT)
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/pipegun/pistol
	projectile_damage_multiplier = 0.50
	spread = 15 //kinda inaccurate
	burst_size = 3 //but it empties the entire magazine when it fires
	burst_delay = 0.3 // and by empties, I mean it does it all at once
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	semi_auto = TRUE

	SET_BASE_PIXEL(0, 0)

/obj/item/gun/ballistic/rifle/boltaction/pipegun/pistol/add_bayonet_point()
	return

/obj/item/gun/ballistic/rifle/boltaction/pipegun/prime
	name = "regal pipegun"
	desc = "Chamar isso de\"Regal\" é uma ironia cruel. Pois a única qualidade notável da nobreza é em como é usada para matar. Todos os monarcas merecem ser coroados. Mas ninguém se lembrará do tirano morto pela mancha vermelha que deixaram no tapete."
	icon_state = "regal_pipegun"
	inhand_icon_state = "regal_pipegun"
	worn_icon_state = "regal_pipegun"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/pipegun/prime
	projectile_damage_multiplier = 2
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 9.15,
		/datum/material/wood = SHEET_MATERIAL_AMOUNT *8,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.15,
		/datum/material/cardboard = SHEET_MATERIAL_AMOUNT,
	)

/obj/item/gun/ballistic/rifle/boltaction/pipegun/pistol/prime
	name = "regal pipe pistol"
	desc = "Que valor há em honestidade para com os desonestos? Para que possam torcer o braço e cortar o pulso? A palma aberta não é sinal de fraqueza, é para afastar os olhos da outra mão, esperando."
	icon_state = "regal_pipepistol"
	inhand_icon_state = "regal_pipepistol"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/pipegun/pistol/prime
	projectile_damage_multiplier = 1
	burst_size = 6 // WHOLE CLIP
	spread = 0

/// MAGICAL BOLT ACTIONS ///

/obj/item/gun/ballistic/rifle/enchanted
	name = "enchanted bolt action rifle"
	desc = "Cuidado para não perder a cabeça."
	icon_state = "enchanted_rifle"
	inhand_icon_state = "enchanted"
	worn_icon_state = "enchanted_rifle"
	slot_flags = ITEM_SLOT_BACK
	var/guns_left = 30
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/enchanted
	can_be_sawn_off = FALSE

	SET_BASE_PIXEL(-8, 0)

/obj/item/gun/ballistic/rifle/enchanted/dropped()
	. = ..()
	guns_left = 0
	magazine = null
	chambered = null

/obj/item/gun/ballistic/rifle/enchanted/proc/discard_gun(mob/living/user)
	user.throw_item(pick(oview(7,get_turf(user))))

/obj/item/gun/ballistic/rifle/enchanted/attack_self()
	return

/obj/item/gun/ballistic/rifle/enchanted/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	. = ..()
	if(!.)
		return
	if(guns_left)
		var/obj/item/gun/ballistic/rifle/enchanted/gun = new type
		gun.guns_left = guns_left - 1
		discard_gun(user)
		user.swap_hand()
		user.put_in_hands(gun)
	else
		user.dropItemToGround(src, TRUE)

// SNIPER //

/obj/item/gun/ballistic/rifle/sniper_rifle
	name = "anti-materiel sniper rifle"
	desc = "Um rifle anti-materiel, usando cartuchos de 50 BMG. Embora tecnicamente ultrapassado nos mercados modernos de armas, ainda funciona excepcionalmente bem como um rifle antipessoal. Em particular, o emprego de modernos trajes blindados usando blindagem avançada deu a esta arma uma nova casa no campo de batalha. Ele também é capaz de ser suprimido... de alguma forma."
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "sniper"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	weapon_weight = WEAPON_HEAVY
	inhand_icon_state = "sniper"
	worn_icon_state = null
	fire_sound = 'sound/items/weapons/gun/sniper/shot.ogg'
	fire_sound_volume = 90
	load_sound = 'sound/items/weapons/gun/sniper/mag_insert.ogg'
	rack_sound = 'sound/items/weapons/gun/sniper/rack.ogg'
	suppressed_sound = 'sound/items/weapons/gun/general/heavy_shot_suppressed.ogg'
	recoil = 2
	accepted_magazine_type = /obj/item/ammo_box/magazine/sniper_rounds
	internal_magazine = FALSE
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BACK
	mag_display = TRUE
	tac_reloads = TRUE
	rack_delay = 1 SECONDS
	can_suppress = TRUE
	can_unsuppress = TRUE
	suppressor_x_offset = 3
	suppressor_y_offset = 3

/obj/item/gun/ballistic/rifle/sniper_rifle/examine(mob/user)
	. = ..()
	. += span_warning("<b>Parece ter um rótulo de aviso:</b>Não, sob nenhuma circunstância, tente \"rápido\"Com este rifle.")

/obj/item/gun/ballistic/rifle/sniper_rifle/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 4) //enough range to at least make extremely good use of the penetrator rounds

/obj/item/gun/ballistic/rifle/sniper_rifle/reset_fire_cd()
	. = ..()
	if(suppressed)
		playsound(src, 'sound/machines/eject.ogg', 25, TRUE, ignore_walls = FALSE, extrarange = SILENCED_SOUND_EXTRARANGE, falloff_distance = 0)
	else
		playsound(src, 'sound/machines/eject.ogg', 50, TRUE)

/obj/item/gun/ballistic/rifle/sniper_rifle/syndicate
	desc = "Um rifle anti-materiel, usando cartuchos de 50 BMG. Embora tecnicamente ultrapassado nos mercados modernos de armas, ainda funciona excepcionalmente bem como um rifle antipessoal. Em particular, o emprego de modernos trajes blindados usando blindagem avançada deu a esta arma uma nova casa no campo de batalha. Ele também é capaz de ser suprimido... de alguma forma. Este parece ter uma pequena foto de alguém em um traje vermelho-sangue estanciou sobre ele, apontando para um disquete verde. Quem sabe o que isso pode significar."
	pin = /obj/item/firing_pin/implant/pindicate

// SKS semi-automatic rifle //

/obj/item/gun/ballistic/rifle/sks
	name = "\improper Sakhno SKS semi-automatic rifle"
	desc = "Um reavivamento do antigo rifle semi-automático SKS, redesenhado para utilizar balas Strilka .310. Produzido para celebrar o estabelecimento da Terceira União Soviética no Setor Spinward. Na esteira do colapso do sindicato, estas armas agora têm um lugar único na história entre a população do setor. No entanto, eles são estranhamente mais raros que o exército de Sakhno M2442. Os colonos da fronteira são conhecidos por possuir um desses para fins de caça. Ou lutando contra cobradores irritantes."
	icon = 'icons/obj/weapons/guns/wide_guns.dmi'
	icon_state = "sks"
	worn_icon_state = "sks"
	inhand_icon_state = "sks"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/sks
	need_bolt_lock_to_interact = TRUE
	semi_auto = TRUE
	slot_flags = ITEM_SLOT_BACK
	projectile_damage_multiplier = 0.5
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 8, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 5.5, /datum/material/cardboard = SHEET_MATERIAL_AMOUNT)

	SET_BASE_PIXEL(-8, 0)

/obj/item/gun/ballistic/rifle/sks/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable, offset_x = 38, offset_y = 12)

/obj/item/gun/ballistic/rifle/sks/chekhov
	name = "\improper Chekhov's SKS semi-automatic rifle"
	desc = "Um reavivamento do antigo rifle semi-automático SKS, redesenhado para utilizar balas Strilka .310. O nome 'Chekhov' está gravado no lado do estoque. Você sente que isso teve algum significado em um ponto, mas você não pode ter certeza do que poderia ter sido. Ou se esse verdadeiro significado ainda não se revelou."

/obj/item/gun/ballistic/rifle/sks/empty
	spawn_magazine_type = /obj/item/ammo_box/magazine/internal/sks/empty

// lahti-l39 anti material rifle //

/obj/item/gun/ballistic/automatic/lahti
	name = "\improper Lahti L-39"
	desc = "O Lahti L-39, agora fabricado no espaço com melhores materiais tornando-o mais portátil e confiável, ainda carregado no mesmo cartucho maciço, esta coisa foi feita para atravessar um tanque e sair do outro lado. Imagine o que poderia fazer com um exosuit, há também uma visão completamente inútil que é totalmente obstruída pela revista."
	icon = 'icons/obj/weapons/guns/lahtil39.dmi'
	icon_state = "lahtil"
	inhand_icon_state = "sniper"
	worn_icon_state = "sniper"
	fire_sound = 'sound/items/weapons/gun/sniper/shot.ogg'
	fire_sound_volume = 90
	load_sound = 'sound/items/weapons/gun/sniper/mag_insert.ogg'
	rack_sound = 'sound/items/weapons/gun/sniper/rack.ogg'
	suppressed_sound = 'sound/items/weapons/gun/general/heavy_shot_suppressed.ogg'
	mag_display = FALSE
	recoil = 15
	w_class = WEIGHT_CLASS_BULKY
	accepted_magazine_type = /obj/item/ammo_box/magazine/lahtimagazine
	fire_delay = 8 SECONDS
	slowdown = 2
	burst_size = 1
	slot_flags = ITEM_SLOT_BACK
	actions_types = list()
	suppressor_x_offset = 3
	suppressor_y_offset = 3
