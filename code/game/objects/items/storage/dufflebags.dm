/obj/item/storage/backpack/duffelbag
	name = "duffel bag"
	desc = "Um saco grande para segurar coisas extras."
	icon_state = "duffel"
	inhand_icon_state = "duffel"
	actions_types = list(/datum/action/item_action/zipper)
	storage_type = /datum/storage/duffel
	// How much to slow you down if your bag isn't zipped up
	var/zip_slowdown = 1
	/// If this bag is zipped (contents hidden) up or not
	/// Starts enabled so you're forced to interact with it to "get" it
	var/zipped_up = TRUE
	// How much time it takes to zip up (close) the duffelbag
	var/zip_up_duration = 0.5 SECONDS
	// Audio played during zipup
	var/zip_up_sfx = 'sound/items/zip/zip_up.ogg'
	// How much time it takes to unzip the duffel
	var/unzip_duration = 2.1 SECONDS
	// Audio played during unzip
	var/unzip_sfx = 'sound/items/zip/un_zip.ogg'

/obj/item/storage/backpack/duffelbag/Initialize(mapload)
	. = ..()
	slowdown += zip_slowdown
	set_zipper(TRUE)
	RegisterSignal(src, COMSIG_SPEED_POTION_APPLIED, PROC_REF(on_speed_potioned))

/obj/item/storage/backpack/duffelbag/examine(mob/user)
	. = ..()
	. += "[zipped_up ? "It's zipped up, preventing you from accessing its contents." : "It's unzipped, and harder to move in."]"

/obj/item/storage/backpack/duffelbag/attack_self(mob/user, modifiers)
	if(loc != user) // God fuck TK
		return ..()
	if(zipped_up)
		return attack_hand(user, modifiers)
	else
		return attack_hand_secondary(user, modifiers)

/obj/item/storage/backpack/duffelbag/attack_self_secondary(mob/user, modifiers)
	attack_self(user, modifiers)
	return ..()

// If we're zipped, click to unzip
/obj/item/storage/backpack/duffelbag/attack_hand(mob/user, list/modifiers)
	if(loc != user)
		// Hacky, but please don't be cringe yeah?
		atom_storage.silent = TRUE
		. = ..()
		atom_storage.silent = initial(atom_storage.silent)
		return
	if(!zipped_up)
		return ..()

	balloon_alert(user, "unzipping...")
	playsound(src, unzip_sfx, 100, FALSE)
	var/datum/callback/can_unzip = CALLBACK(src, PROC_REF(zipper_matches), TRUE)
	if(!do_after(user, unzip_duration, src, extra_checks = can_unzip))
		user.balloon_alert(user, "A abertura falhou!")
		return
	balloon_alert(user, "unzipped")
	set_zipper(FALSE)
	return TRUE

// Vis versa
/obj/item/storage/backpack/duffelbag/attack_hand_secondary(mob/user, list/modifiers)
	if(loc != user)
		return ..()
	if(zipped_up)
		return SECONDARY_ATTACK_CALL_NORMAL

	balloon_alert(user, "zipping...")
	playsound(src, zip_up_sfx, 100, FALSE)
	var/datum/callback/can_zip = CALLBACK(src, PROC_REF(zipper_matches), FALSE)
	if(!do_after(user, zip_up_duration, src, extra_checks = can_zip))
		user.balloon_alert(user, "O zíper falhou!")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	balloon_alert(user, "zipped")
	set_zipper(TRUE)
	return SECONDARY_ATTACK_CONTINUE_CHAIN

/// Checks to see if the zipper matches the passed in state
/// Returns true if so, false otherwise
/obj/item/storage/backpack/duffelbag/proc/zipper_matches(matching_value)
	return zipped_up == matching_value

/obj/item/storage/backpack/duffelbag/proc/set_zipper(new_zip)
	zipped_up = new_zip
	SEND_SIGNAL(src, COMSIG_DUFFEL_ZIP_CHANGE, new_zip)
	if(zipped_up)
		slowdown -= zip_slowdown
		atom_storage.set_locked(STORAGE_SOFT_LOCKED)
		atom_storage.display_contents = FALSE
	else
		slowdown += zip_slowdown
		atom_storage.set_locked(STORAGE_NOT_LOCKED)
		atom_storage.display_contents = TRUE

	if(isliving(loc))
		var/mob/living/wearer = loc
		wearer.update_equipment_speed_mods()

/// Signal handler for [COMSIG_SPEED_POTION_APPLIED]. Speed potion removes the unzipped slowdown
/obj/item/storage/backpack/duffelbag/proc/on_speed_potioned(datum/source)
	SIGNAL_HANDLER
	// Don't need to touch the actual slowdown here, since the speed potion does it for us
	zip_slowdown = 0

/obj/item/storage/backpack/duffelbag/cursed
	name = "living duffel bag"
	desc = "Um saco de palhaço amaldiçoado que tem fome de comida de qualquer tipo. Uma etiqueta de aviso sugere que ele come comida lá dentro. Se essa comida for uma bagunça horrivelmente arruinada ou o chef descartado do microondas, ou envenenado de alguma forma, então pode ter efeitos negativos no saco..."
	icon_state = "duffel-curse"
	inhand_icon_state = "duffel-curse"
	zip_slowdown = 2
	max_integrity = 100

/obj/item/storage/backpack/duffelbag/cursed/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/curse_of_hunger, add_dropdel = TRUE)

/obj/item/storage/backpack/duffelbag/captain
	name = "captain's duffel bag"
	desc = "Uma bolsa grande para guardar mercadorias extra."
	icon_state = "duffel-captain"
	inhand_icon_state = "duffel-captain"

/obj/item/storage/backpack/duffelbag/med
	name = "medical duffel bag"
	desc = "Um saco grande para guardar suprimentos médicos extras."
	icon_state = "duffel-medical"
	inhand_icon_state = "duffel-med"

/obj/item/storage/backpack/duffelbag/chief_medic
	name = "chief medical officer's duffel bag"
	desc = "Um saco grande para lidar com os deveres de todo o departamento médico imediatamente."
	icon_state = "duffel-chiefmedical"
	inhand_icon_state = "duffel-med"

/obj/item/storage/backpack/duffelbag/coroner
	name = "coroner duffel bag"
	desc = "Uma bolsa grande para segurar grandes quantidades de órgãos ao mesmo tempo."
	icon_state = "duffel-coroner"
	inhand_icon_state = "duffel-coroner"

/obj/item/storage/backpack/duffelbag/explorer
	name = "explorer duffel bag"
	desc = "Um saco grande para guardar tesouros exóticos."
	icon_state = "duffel-explorer"
	inhand_icon_state = "duffel-explorer"

/obj/item/storage/backpack/duffelbag/hydroponics
	name = "hydroponic's duffel bag"
	desc = "Um saco grande para guardar ferramentas de jardinagem extra."
	icon_state = "duffel-hydroponics"
	inhand_icon_state = "duffel-hydroponics"

/obj/item/storage/backpack/duffelbag/chemistry
	name = "chemistry duffel bag"
	desc = "Um saco grande para segurar substâncias químicas extras."
	icon_state = "duffel-chemistry"
	inhand_icon_state = "duffel-chemistry"

/obj/item/storage/backpack/duffelbag/genetics
	name = "geneticist's duffel bag"
	desc = "Um saco grande para segurar mutações genéticas extras."
	icon_state = "duffel-genetics"
	inhand_icon_state = "duffel-genetics"

/obj/item/storage/backpack/duffelbag/science
	name = "scientist's duffel bag"
	desc = "Um saco grande para segurar componentes científicos extras."
	icon_state = "duffel-science"
	inhand_icon_state = "duffel-sci"

/obj/item/storage/backpack/duffelbag/virology
	name = "virologist's duffel bag"
	desc = "Um saco grande para segurar garrafas virais."
	icon_state = "duffel-virology"
	inhand_icon_state = "duffel-virology"

/obj/item/storage/backpack/duffelbag/sec
	name = "security duffel bag"
	desc = "Uma bolsa grande para guardar suprimentos de segurança e munição."
	icon_state = "duffel-security"
	inhand_icon_state = "duffel-sec"

/obj/item/storage/backpack/duffelbag/sec/surgery
	name = "surgical duffel bag"
	desc = "Um saco grande para segurar suprimentos extras. Este tem um material com espaço para várias ferramentas afiadas."

/obj/item/storage/backpack/duffelbag/sec/surgery/PopulateContents()
	new /obj/item/scalpel(src)
	new /obj/item/hemostat(src)
	new /obj/item/retractor(src)
	new /obj/item/circular_saw(src)
	new /obj/item/bonesetter(src)
	new /obj/item/surgicaldrill(src)
	new /obj/item/cautery(src)
	new /obj/item/surgical_drapes(src)
	new /obj/item/clothing/suit/toggle/labcoat/hospitalgown(src)	//SKYRAT EDIT ADDITION
	new /obj/item/clothing/mask/surgical(src)
	new /obj/item/blood_filter(src)

/obj/item/storage/backpack/duffelbag/engineering
	name = "industrial duffel bag"
	desc = "Um saco grande para guardar ferramentas e suprimentos extras."
	icon_state = "duffel-engineering"
	inhand_icon_state = "duffel-eng"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/duffelbag/drone
	name = "drone duffel bag"
	desc = "Um saco grande para segurar ferramentas e chapéus."
	icon_state = "duffel-drone"
	inhand_icon_state = "duffel-drone"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/duffelbag/drone/PopulateContents()
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool(src)
	new /obj/item/crowbar(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/wirecutters(src)
	new /obj/item/multitool(src)

/obj/item/storage/backpack/duffelbag/clown
	name = "clown's duffel bag"
	desc = "Um saco grande para guardar muitas piadas engraçadas!"
	icon_state = "duffel-clown"
	inhand_icon_state = "duffel-clown"

/obj/item/storage/backpack/duffelbag/clown/cream_pie/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/food/pie/cream(src)

/obj/item/storage/backpack/fireproof
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/duffelbag/syndie
	name = "tactical duffel bag" // BUBBER EDIT CHANGE: Just a normal bag. Original: name = "suspicious looking duffel bag"
	desc = "Um saco grande para guardar suprimentos extras." // BUBBER EDIT CHANGE: Just a normal bag. Original: desc = "Um saco grande para guardar suprimentos extras. Contém um zíper de plastânio oleado para zíper tático de velocidade máxima, e é mais equilibrado nas costas do que uma bolsa média. Pode segurar dois itens volumosos!"
	icon_state = "duffel-syndie"
	inhand_icon_state = "duffel-syndieammo"
	storage_type = /datum/storage/duffel/syndicate
	resistance_flags = FIRE_PROOF
	// Less slowdown while unzipped. Still bulky, but it won't halve your movement speed in an active combat situation.
	zip_slowdown = 0.3
	// Faster unzipping. Utilizes the same noise as zipping up to fit the unzip duration.
	unzip_duration = 0.5 SECONDS
	unzip_sfx = 'sound/items/zip/zip_up.ogg'

	// BUBBER EDIT ADDITION BEGIN: Just a normal bag.
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "Essa mochila tem o logotipo do Sindicato escrito por dentro. Parece ser feito de materiais mais leves, mas mais resistentes, e apresenta um zíper de plastânio oleado para zíper tático de velocidade máxima."
	// BUBBER EDIT ADDITION END: Just a normal bag.

/obj/item/storage/backpack/duffelbag/syndie/hitman
	desc = "Um saco grande para segurar coisas extras. Há um logotipo Nanotrasen atrás."
	icon_state = "duffel-syndieammo"
	inhand_icon_state = "duffel-syndieammo"

/obj/item/storage/backpack/duffelbag/syndie/hitman/PopulateContents()
	new /obj/item/clothing/under/costume/buttondown/slacks/service(src)
	new /obj/item/clothing/neck/tie/red/hitman(src)
	new /obj/item/clothing/accessory/waistcoat(src)
	new /obj/item/clothing/suit/toggle/lawyer/black(src)
	new /obj/item/clothing/shoes/laceup(src)
	new /obj/item/clothing/gloves/color/black(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clothing/head/fedora(src)

/obj/item/storage/backpack/duffelbag/syndie/med
	name = "medical duffel bag"
	desc = "Uma bolsa grande para ter suprimentos médicos extra táticos."
	icon_state = "duffel-syndiemed"
	inhand_icon_state = "duffel-syndiemed"

/obj/item/storage/backpack/duffelbag/syndie/surgery
	name = "surgery duffel bag"
	desc = "Um saco grande para segurar suprimentos extras. Este tem um material com espaço para várias ferramentas afiadas." // BUBBER EDIT CHANGE: Just a normal bag. Original: desc = "Uma mochila suspeita para segurar ferramentas de cirurgia."
	icon_state = "duffel-syndiemed"
	inhand_icon_state = "duffel-syndiemed"

	// BUBBER EDIT ADDITION BEGIN: Just a normal bag.
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "Essa mochila tem o logotipo do Sindicato escrito por dentro. Parece ser feito de materiais mais leves e mais resistentes."
	// BUBBER EDIT ADDITION END: Just a normal bag.

/obj/item/storage/backpack/duffelbag/syndie/surgery/PopulateContents()
	new /obj/item/scalpel/advanced(src)
	new /obj/item/retractor/advanced(src)
	new /obj/item/cautery/advanced(src)
	new /obj/item/surgical_drapes(src)
	new /obj/item/reagent_containers/medigel/sterilizine(src)
	new /obj/item/bonesetter(src)
	new /obj/item/blood_filter(src)
	new /obj/item/stack/medical/bone_gel(src)
	new /obj/item/stack/medical/wrap/sticky_tape/surgical(src)
	new /obj/item/emergency_bed(src)
	new /obj/item/clothing/suit/jacket/straight_jacket(src)
	new /obj/item/clothing/mask/muzzle(src)
	new /obj/item/mmi/syndie(src)

/obj/item/storage/backpack/duffelbag/syndie/ammo
	name = "ammunition duffel bag"
	desc = "Um saco grande para guardar munição e suprimentos extras."
	icon_state = "duffel-syndieammo"
	inhand_icon_state = "duffel-syndieammo"

/obj/item/storage/backpack/duffelbag/syndie/ammo/darkgygax
	name = "\improper Dark Gygax ammunition duffel bag"
	desc = "Um saco grande, cheio de munição para a arma de exossuit. Equipado para equipar a carga padrão de um Gygax Negro."

/obj/item/storage/backpack/duffelbag/syndie/ammo/darkgygax/PopulateContents()
	new /obj/item/mecha_ammo/scattershot(src)
	new /obj/item/mecha_ammo/scattershot(src)
	new /obj/item/mecha_ammo/scattershot(src)
	new /obj/item/mecha_ammo/scattershot(src)
	new /obj/item/mecha_ammo/scattershot(src)
	new /obj/item/mecha_ammo/scattershot(src)
	new /obj/item/storage/belt/utility/syndicate(src)

/obj/item/storage/backpack/duffelbag/syndie/ammo/mauler
	name = "\improper Mauler ammunition duffel bag"
	desc = "Uma bolsa grande, cheia de várias munições de exossuit. Equipado para equipar a carga padrão de um Gygax Negro."

/obj/item/storage/backpack/duffelbag/syndie/ammo/mauler/PopulateContents()
	new /obj/item/mecha_ammo/lmg(src)
	new /obj/item/mecha_ammo/lmg(src)
	new /obj/item/mecha_ammo/lmg(src)
	new /obj/item/mecha_ammo/missiles_srm(src)
	new /obj/item/mecha_ammo/missiles_srm(src)
	new /obj/item/mecha_ammo/missiles_srm(src)
	new /obj/item/storage/belt/utility/syndicate(src)

/obj/item/storage/backpack/duffelbag/syndie/med/medicalbundle
	desc = "Uma bolsa grande contendo um equipamento médico, um LMG Donksoft, uma grande caixa de dardos de choque, e um módulo Magboot MODsuit."

/obj/item/storage/backpack/duffelbag/syndie/med/medicalbundle/PopulateContents()
	new /obj/item/mod/module/magboot(src)
	new /obj/item/storage/medkit/tactical/premium(src)
	new /obj/item/gun/ballistic/automatic/l6_saw/toy(src)
	new /obj/item/ammo_box/foambox/riot(src)

/obj/item/storage/backpack/duffelbag/syndie/med/bioterrorbundle
	desc = "Uma bolsa grande contendo substâncias químicas mortais, um pulverizador portátil, granada de espuma de bioterror, um rifle de assalto Donksoft, uma caixa de dardos de grau motim, uma pistola de dardos e uma caixa de seringas."

/obj/item/storage/backpack/duffelbag/syndie/med/bioterrorbundle/PopulateContents()
	new /obj/item/reagent_containers/spray/chemsprayer/bioterror(src)
	new /obj/item/storage/box/syndie_kit/chemical(src)
	new /obj/item/gun/syringe/syndicate(src)
	new /obj/item/gun/ballistic/automatic/c20r/toy(src)
	new /obj/item/storage/box/syringes(src)
	new /obj/item/ammo_box/foambox/riot(src)
	new /obj/item/grenade/chem_grenade/bioterrorfoam(src)
	if(prob(5))
		new /obj/item/food/pizza/pineapple(src)

/obj/item/storage/backpack/duffelbag/syndie/c4/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/grenade/c4(src)

/obj/item/storage/backpack/duffelbag/syndie/x4/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/grenade/c4/x4(src)

/obj/item/storage/backpack/duffelbag/syndie/firestarter
	desc = "Um saco grande contendo um novo pulverizador de mochilas de piro, Elite MODsuit, uma pistola Stechkin APS, minibomba, munição e outros equipamentos."

/obj/item/storage/backpack/duffelbag/syndie/firestarter/PopulateContents()
	new /obj/item/clothing/under/syndicate/soviet(src)
	new /obj/item/mod/control/pre_equipped/elite/flamethrower(src)
	new /obj/item/gun/ballistic/automatic/pistol/aps(src)
	new /obj/item/ammo_box/magazine/m9mm_aps/fire(src)
	new /obj/item/ammo_box/magazine/m9mm_aps/fire(src)
	new /obj/item/reagent_containers/cup/glass/bottle/vodka/badminka(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimulants(src)
	new /obj/item/grenade/syndieminibomb(src)

// For ClownOps.
/obj/item/storage/backpack/duffelbag/clown/syndie
	storage_type = /datum/storage/duffel/syndicate

/obj/item/storage/backpack/duffelbag/clown/syndie/PopulateContents()
	new /obj/item/modular_computer/pda/clown(src)
	new /obj/item/clothing/under/rank/civilian/clown(src)
	new /obj/item/clothing/shoes/clown_shoes(src)
	new /obj/item/clothing/mask/gas/clown_hat(src)
	new /obj/item/bikehorn(src)
	new /obj/item/implanter/sad_trombone(src)

/obj/item/storage/backpack/henchmen
	name = "wings"
	desc = "Concedido aos capangas que merecem. Isso provavelmente não inclui você."
	icon_state = "henchmen"
	inhand_icon_state = null

/obj/item/storage/backpack/duffelbag/cops
	name = "police bag"
	desc = "Uma mochila grande para segurar equipamento policial extra."

/obj/item/storage/backpack/duffelbag/mining_conscript
	name = "mining conscription kit"
	desc = "Uma mochila contendo tudo que um tripulante precisa para apoiar um mineiro no campo."
	icon_state = "duffel-explorer"
	inhand_icon_state = "duffel-explorer"

/obj/item/storage/backpack/duffelbag/mining_conscript/PopulateContents()
	new /obj/item/clothing/glasses/meson(src)
	new /obj/item/t_scanner/adv_mining_scanner/lesser(src)
	new /obj/item/storage/bag/ore(src)
	new /obj/item/clothing/suit/hooded/explorer(src)
	new /obj/item/encryptionkey/headset_mining(src)
	new /obj/item/clothing/mask/gas/explorer(src)
	new /obj/item/card/id/advanced/mining(src)
	new /obj/item/gun/energy/recharge/kinetic_accelerator(src)
	new /obj/item/knife/combat/survival(src)
	new /obj/item/flashlight/seclite(src)
