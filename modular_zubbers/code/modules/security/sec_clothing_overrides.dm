/*
*	Security clothing reskins and such.
*/


/*
* BELTS
*/
/obj/item/storage/belt/security
	icon = 'icons/obj/clothing/belts.dmi'
	worn_icon = 'icons/mob/clothing/belt.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/security_teshari.dmi'
	icon_state = "security"
	worn_icon_state = "security"

///Enables you to quickdraw weapons from security holsters
/datum/storage/security/open_storage(datum/source, mob/user)
	var/atom/resolve_parent = parent
	if(!resolve_parent)
		return
	if(isobserver(user))
		show_contents(user)
		return

	if(!resolve_parent.IsReachableBy(user))
		resolve_parent.balloon_alert(user, "não alcança!")
		return FALSE

	if(!isliving(user) || user.incapacitated)
		return FALSE

	var/obj/item/gun/gun_to_draw = locate() in real_location
	if(!gun_to_draw)
		return ..()
	resolve_parent.add_fingerprint(user)
	attempt_remove(gun_to_draw, get_turf(user))
	playsound(resolve_parent, 'modular_skyrat/modules/sec_haul/sound/holsterout.ogg', 50, TRUE, -5)
	INVOKE_ASYNC(user, TYPE_PROC_REF(/mob, put_in_hands), gun_to_draw)
	user.visible_message(span_warning("[user]\"Desejos\"[gun_to_draw]De[resolve_parent]!"), span_notice("Você desenha.[gun_to_draw]De[resolve_parent]."))

/*
* GLASSES
*/
/obj/item/clothing/glasses/hud/security
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "securityhud"
	glass_colour_type = /datum/client_colour/glass_colour/lightred

/obj/item/clothing/glasses/hud/security/sunglasses
	icon_state = "sunhudsec"
	glass_colour_type = /datum/client_colour/glass_colour/red

/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch
	icon_state = "hudpatch"
	base_icon_state = "hudpatch"

/obj/item/clothing/glasses/hud/eyepatch/sec/blindfold
	name = "sec blindfold HUD"
	desc = "Uma venda falsa com um HUD de segurança dentro, te ajuda a parecer justiça cega. Isso não fornecerá a mesma proteção que você teria dos óculos de sol."
	icon_state =  "secfold"
	base_icon_state =  "secfold"

/obj/item/clothing/glasses/hud/eyepatch/sec/blindfold/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/glasses/hud/security/night
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'

/obj/item/clothing/glasses/hud/security/night/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/glasses/hud/security/sunglasses/gars/giga/roselia

/obj/item/clothing/glasses/hud/security/sunglasses/gars/giga/roselia/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/*
* HEAD
*/

//Standard helmet
/obj/item/clothing/head/helmet/sec
	icon = 'icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'icons/mob/clothing/head/helmet.dmi'
	icon_state = "helmet"
	base_icon_state = "helmet"
	clothing_flags = SNUG_FIT | STACKABLE_HELMET_EXEMPT
	dog_fashion = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/helmet/sec/click_alt(mob/user)
	flipped_visor = !flipped_visor
	balloon_alert(user, "Viseira Virada")
	// base_icon_state is modified for seclight attachment component
	base_icon_state = "[initial(base_icon_state)][flipped_visor ? "-novisor" : ""]"
	icon_state = base_icon_state
	if (flipped_visor)
		flags_cover &= ~HEADCOVERSEYES | PEPPERPROOF
	else
		flags_cover |= HEADCOVERSEYES | PEPPERPROOF
	update_appearance()
	return CLICK_ACTION_SUCCESS


/obj/item/clothing/head/helmet/sec/futuristic
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/helmet.dmi'
	icon_state = "security_helmet_future_red"
	base_icon_state = "security_helmet_future_red"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/helmet/sec/futuristic/click_alt(mob/user)
	flipped_visor = !flipped_visor
	balloon_alert(user, "Viseira Virada")
	// base_icon_state is modified for seclight attachment component
	base_icon_state = "[initial(base_icon_state)][flipped_visor ? "-novisor" : ""]"
	icon_state = base_icon_state
	if (flipped_visor)
		flags_cover &= ~HEADCOVERSEYES | PEPPERPROOF
	else
		flags_cover |= HEADCOVERSEYES | PEPPERPROOF
	update_appearance()
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/head/hats/warden
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "wardenhat"

/obj/item/clothing/head/hats/warden/red

/obj/item/clothing/head/hats/warden/red/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/head/hats/warden/drill

/obj/item/clothing/head/hats/warden/drill/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/*
* NECK
*/
/obj/item/clothing/neck/cloak/hos
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "hoscloak"

//Not technically an override but oh well
/obj/item/clothing/neck/security_cape
	name = "security cape"
	desc = "Uma capa elegante usada por seguranças."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "cape_red"
	inhand_icon_state = "" //no unique inhands
	///Decides the shoulder it lays on, false = RIGHT, TRUE = LEFT
	var/swapped = FALSE

/obj/item/clothing/neck/security_cape/armplate
	name = "security gauntlet"
	desc = "Uma luva de braço cheio usada por seguranças. A luva em si é feita de plástico, e não fornece proteção, mas parece legal como o inferno."
	icon_state = "armplate_red"

/obj/item/clothing/neck/security_cape/click_alt(mob/user)
	swapped = !swapped
	to_chat(user, span_notice("Você troca qual braço[src]Deite-se."))
	update_appearance()
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/neck/security_cape/update_appearance(updates)
	. = ..()
	if(swapped)
		worn_icon_state = icon_state
	else
		worn_icon_state = "[icon_state]_left"

	usr.update_worn_neck()

/*
* GLOVES
*/
/obj/item/clothing/gloves/color/black/security
	name = "security gloves"
	desc = "Um par de luvas de segurança."
	icon = 'icons/obj/clothing/gloves.dmi'
	worn_icon = 'icons/mob/clothing/hands.dmi'
	icon_state = "sec"

/obj/item/clothing/gloves/tackler/security	//Can't just overwrite tackler, as there's a ton of subtypes that we'd then need to account for. This is easier. MUCH easier.
	icon = 'icons/obj/clothing/gloves.dmi'
	worn_icon = 'icons/mob/clothing/hands.dmi'
	icon_state = "gorilla"

/obj/item/clothing/gloves/tackler/combat
	icon = 'icons/obj/clothing/gloves.dmi'
	worn_icon = 'icons/mob/clothing/hands.dmi'
	icon_state = "gorilla"

/obj/item/clothing/gloves/kaza_ruk/sec
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "fightgloves"

/*
* SUITS
*/
/obj/item/clothing/suit/armor/vest/alt/sec
	name = "armored security vest"
	desc = "Um colete blindado tipo II-AD-P que fornece proteção decente contra a maioria dos danos."
	icon = 'icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'icons/mob/clothing/suits/armor.dmi'
	icon_state = "armor_sec"

/obj/item/clothing/suit/armor/hos
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/hos/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hos_armor)

/datum/atom_skin/hos_armor
	abstract_type = /datum/atom_skin/hos_armor

/datum/atom_skin/hos_armor/greatcoat
	preview_name = "Greatcoat"
	new_icon = 'icons/obj/clothing/suits/armor.dmi'
	new_worn_icon = 'icons/mob/clothing/suits/armor.dmi'
	new_icon_state = "hos"

/datum/atom_skin/hos_armor/trenchcoat
	preview_name = "Trenchcoat"
	new_icon = 'icons/obj/clothing/suits/armor.dmi'
	new_worn_icon = 'icons/mob/clothing/suits/armor.dmi'
	new_icon_state = "hostrench"

/datum/atom_skin/hos_armor/trenchcloak
	preview_name = "Trenchcloak"
	new_icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	new_worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	new_icon_state = "trenchcloak"

/obj/item/clothing/suit/armor/hos/trenchcoat/winter

/obj/item/clothing/suit/armor/hos/trenchcoat/winter/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

//Standard Bulletproof Vest
/obj/item/clothing/suit/armor/bulletproof
	desc = "Um colete pesado à prova de balas tipo III-AD-P que se destaca em proteger o usuário contra armas de projéteis e explosivos tradicionais em menor escala."
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

//Riot Armor
/obj/item/clothing/suit/armor/riot
	icon_state = "riot_ad" //replaces the NT on the back
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'

/obj/item/clothing/suit/armor/riot/knight //This needs to be sent back to its original .dmis
	icon = 'icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'icons/mob/clothing/suits/armor.dmi'

//DETECTIVE

/obj/item/clothing/suit/cowboyvest
	name = "blonde cowboy vest"
	desc = "Um colete de creme branco forrado com... pele, de todas as coisas, para o tempo do deserto. Há um pequeno logotipo de cabeça de veado costurado no colete."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "cowboy_vest"
	body_parts_covered = CHEST|ARMS
	cold_protection = CHEST|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	heat_protection = CHEST|ARMS

/obj/item/clothing/suit/jacket/det_suit/cowboyvest
	name = "blonde cowboy vest"
	desc = "Um colete de creme branco forrado com... pele, de todas as coisas, para o tempo do deserto. Há um pequeno logotipo de cabeça de veado costurado no colete."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "cowboy_vest"
	body_parts_covered = CHEST|ARMS
	cold_protection = CHEST|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	heat_protection = CHEST|ARMS

/obj/item/clothing/suit/armor/vest/warden/alt //un-overrides this since its sprite is TG
	icon = 'icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'icons/mob/clothing/suits/armor.dmi'

/obj/item/clothing/suit/armor/vest/warden/alt/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/suit/armor/hos/hos_formal
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "hosformal_blue"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/armor/hos/hos_formal/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/*
* UNDER
*/
//Officer
/obj/item/clothing/under/rank/security/officer
	desc = "Um uniforme de segurança tático para oficiais, completo com uma fivela de cinto Lopland."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "rsecurity"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/officer/formal

/obj/item/clothing/under/rank/security/officer/formal/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/officer/skirt
	alt_covers_chest = FALSE
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "secskirt"
	alt_covers_chest = TRUE

// DETECTIVE
/obj/item/clothing/under/rank/security/detective/cowboy
	name = "blonde cowboy uniform"
	desc = "Camisa azul e jeans escuros, com um par de botas de cowboy."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'	//Donator item-ish? See the /armorless one below it
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	icon_state = "cowboy_uniform"
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/detective/cowboy/armorless //Donator variant, just uses the sprite.
	armor_type = /datum/armor/clothing_under

/obj/item/clothing/under/rank/security/detective/runner
	name = "runner sweater"
	desc = "<i>\"Você parece solitário.\"</i>"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "runner"
	can_adjust = FALSE

//Warden
/obj/item/clothing/under/rank/security/warden
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "rwarden"

/obj/item/clothing/under/rank/security/warden/formal

/obj/item/clothing/under/rank/security/warden/formal/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

//HoS
/obj/item/clothing/under/rank/security/head_of_security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "rhos"

/obj/item/clothing/under/rank/security/head_of_security/parade
	icon_state = "hos_parade_male"

/obj/item/clothing/under/rank/security/head_of_security/parade/female
	icon_state = "hos_parade_fem"

/obj/item/clothing/under/rank/security/head_of_security/alt
	icon_state = "hosalt"

/obj/item/clothing/under/rank/security/head_of_security/alt/skirt
	icon_state = "hosalt_skirt"

/obj/item/clothing/under/rank/security/head_of_security/peacekeeper

/obj/item/clothing/under/rank/security/head_of_security/peacekeeper/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/head_of_security/bunnysuit

/obj/item/clothing/under/rank/security/head_of_security/bunnysuit/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/head_of_security/alt/roselia

/obj/item/clothing/under/rank/security/head_of_security/alt/roselia/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/head_of_security/grey

/obj/item/clothing/under/rank/security/head_of_security/grey/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/// PRISONER
/obj/item/clothing/under/rank/prisoner/protcust
	name = "protective custody prisoner jumpsuit"
	desc = "Um macacão da prisão de cor mostarda, usado por ex-membros da segurança, informantes e ex-funcionários da CentCom. Seus sensores de terno estão presos no\"Totalmente ligado.\"Posição."
	icon_state = "/obj/item/clothing/under/rank/prisoner/protcust"
	greyscale_colors = "#FFB600"

/obj/item/clothing/under/rank/prisoner/skirt/protcust
	name = "protective custody prisoner jumpskirt"
	desc = "Uma saia preta da prisão, usada por ex-membros da segurança, informantes e ex-funcionários da CentCom. Seus sensores de terno estão presos no\"Totalmente ligado.\"Posição."
	icon_state = "/obj/item/clothing/under/rank/prisoner/skirt/protcust"
	greyscale_colors = "#FFB600"

/obj/item/clothing/under/rank/prisoner/lowsec
	name = "low security prisoner jumpsuit"
	desc = "Um macacão de prisão pálido, quase cremoso, este denota um prisioneiro de baixa segurança, coisas como fraude e colarinho branco. Seus sensores de terno estão presos no\"Totalmente ligado.\"Posição."
	icon_state = "/obj/item/clothing/under/rank/prisoner/lowsec"
	greyscale_colors = "#AB9278"

/obj/item/clothing/under/rank/prisoner/skirt/lowsec
	name = "low security prisoner jumpskirt"
	desc = "Uma saia pálida, quase cremosa, denota um prisioneiro de baixa segurança, coisas como fraude e colarinho branco. Seus sensores de terno estão presos no\"Totalmente ligado.\"Posição."
	icon_state = "/obj/item/clothing/under/rank/prisoner/skirt/lowsec"
	greyscale_colors = "#AB9278"

/obj/item/clothing/under/rank/prisoner/highsec
	name = "high risk prisoner jumpsuit"
	desc = "Um macacão vermelho, dependendo de quem o veja, um distintivo de honra ou um sinal para evitar. Seus sensores de terno estão presos no\"Totalmente ligado.\"Posição."
	icon_state = "/obj/item/clothing/under/rank/prisoner/highsec"
	greyscale_colors = "#FF3400"

/obj/item/clothing/under/rank/prisoner/skirt/highsec
	name = "high risk prisoner jumpskirt"
	desc = "Uma saia vermelha brilhante, dependendo de quem a veja, ou um distintivo de honra ou um sinal para evitar. Seus sensores de terno estão presos no\"Totalmente ligado.\"Posição."
	icon_state = "/obj/item/clothing/under/rank/prisoner/skirt/highsec"
	greyscale_colors = "#FF3400"

/obj/item/clothing/under/rank/prisoner/supermax
	name = "supermax prisoner jumpsuit"
	desc = "Um macacão vermelho escuro, para o pior dos piores, ou o palhaço. Seus sensores de terno estão presos no\"Totalmente ligado.\"Posição."
	icon_state = "/obj/item/clothing/under/rank/prisoner/supermax"
	greyscale_colors = "#992300"

/obj/item/clothing/under/rank/prisoner/skirt/supermax
	name = "supermax prisoner jumpskirt"
	desc = "Uma saia preta vermelha da prisão, para o pior dos piores, ou o palhaço. Seus sensores de terno estão presos no\"Totalmente ligado.\"Posição."
	icon_state = "/obj/item/clothing/under/rank/prisoner/skirt/supermax"
	greyscale_colors = "#992300"

/obj/item/clothing/under/rank/prisoner/classic
	name = "classic prisoner jumpsuit"
	desc = "Um macacão listrado preto e branco, como algo saído de um filme."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/costume.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/costume_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/uniform.dmi'
	icon_state = "prisonerclassic"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/prisoner/syndicate
	name = "syndicate prisoner jumpsuit"
	desc = "Um macacão vermelho vermelho usado por prisioneiros do sindicato. Seus sensores estão curtos."
	icon_state = "/obj/item/clothing/under/rank/prisoner/syndicate"
	greyscale_colors = "#992300"
	has_sensor = FALSE

/obj/item/clothing/under/rank/prisoner/skirt/syndicate
	name = "syndicate prisoner jumpskirt"
	desc = "Uma saia vermelha vermelha usada por prisioneiros do sindicato. Seus sensores estão curtos."
	icon_state = "/obj/item/clothing/under/rank/prisoner/skirt/syndicate"
	greyscale_colors = "#992300"
	has_sensor = FALSE

/obj/item/clothing/under/rank/prisoner/syndicate/station
	name = "syndicate prisoner jumpsuit"
	desc = "Um macacão vermelho de sangue escuro, para os prisioneiros conhecidos do Sindicato, alvos valiosos para a CentCom e interrogatório. Seus sensores de terno estão presos no\"Totalmente ligado.\"Posição."
	icon_state = "/obj/item/clothing/under/rank/prisoner/syndicate/station"
	greyscale_colors = "#5c0000ff"

/*
* FEET
*/
//Adds reskins and special footstep noises
/obj/item/clothing/shoes/jackboots/sec
	name = "security jackboots"
	desc = "Botas de combate de segurança para cenários de combate ou situações de combate. Todo combate, o tempo todo."
	icon_state = "jackboots_sec"
	icon = 'icons/obj/clothing/shoes.dmi'
	worn_icon = 'icons/mob/clothing/feet.dmi'
	clothing_traits = list(TRAIT_SILENT_FOOTSTEPS) // We have other footsteps.

/obj/item/clothing/shoes/jackboots/sec/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_skyrat/master_files/sound/effects/footstep1.ogg' = 1, 'modular_skyrat/master_files/sound/effects/footstep2.ogg' = 1, 'modular_skyrat/master_files/sound/effects/footstep3.ogg' = 1), 100)

/*
*	A bunch of re-overrides so that admins can keep using some redsec stuff; not all of them have this though!
*/

/*
*	EYES
*/

/obj/item/clothing/glasses/hud/security/redsec
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "securityhud"
	glass_colour_type = /datum/client_colour/glass_colour/red

/obj/item/clothing/glasses/hud/security/redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/glasses/hud/security/sunglasses/redsec
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "sunhudsec"
	glass_colour_type = /datum/client_colour/glass_colour/darkred

/obj/item/clothing/glasses/hud/security/sunglasses/redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch/redsec
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "hudpatch"
	base_icon_state = "hudpatch"

/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch/redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/glasses/hud/security/night/redsec
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "securityhudnight"

/obj/item/clothing/glasses/hud/security/night/redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/*
*	NECK
*/

/obj/item/clothing/neck/cloak/hos/redsec
	icon = 'icons/obj/clothing/cloaks.dmi'
	worn_icon = 'icons/mob/clothing/neck.dmi'
	icon_state = "hoscloak"

/obj/item/clothing/neck/cloak/hos/redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/*
*	BACK
*/

// /obj/item/storage/backpack/security/Initialize(mapload)
// 	. = ..()
// 	if(type != /obj/item/storage/backpack/security)
// 		return
// 	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
// 	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
// 		qdel(reskin_component)

// /obj/item/storage/backpack/satchel/sec/Initialize(mapload)
// 	. = ..()
// 	if(type != /obj/item/storage/backpack/satchel/sec)
// 		return
// 	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
// 	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
// 		qdel(reskin_component)

// /obj/item/storage/backpack/duffelbag/sec/Initialize(mapload)
// 	. = ..()
// 	if(type != /obj/item/storage/backpack/duffelbag/sec)
// 		return
// 	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
// 	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
// 		qdel(reskin_component)

/*
*	BELT + HOLSTERS
*/

/obj/item/storage/belt/security/redsec
	icon = 'icons/obj/clothing/belts.dmi'
	worn_icon = 'icons/mob/clothing/belt.dmi'
	icon_state = "security"
	inhand_icon_state = "security"
	worn_icon_state = "security"

/obj/item/storage/belt/security/redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/storage/belt/holster
	desc = "Um coldre bastante simples mas ainda legal que pode segurar uma arma, e alguma munição."

/datum/storage/holster
	max_slots = 3
	max_total_storage = 16

/datum/storage/holster/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound, list/holdables)
	if(length(holdables))
		return ..()

	holdables = list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/ammo_box/magazine, // Just magazine, because the sec-belt can hold these aswell
		/obj/item/gun/ballistic/revolver,
		/obj/item/ammo_box/speedloader, // Speedloaders, which includes stripper clips on a technicality.
		/obj/item/gun/energy/e_gun/mini,
		/obj/item/gun/energy/disabler,
		/obj/item/gun/energy/laser/pistol,
		/obj/item/food/grown/banana,
		/obj/item/gun/energy/dueling,
		/obj/item/gun/energy/laser/thermal,
		/obj/item/gun/ballistic/rifle/boltaction, //fits if you make it an obrez
		/obj/item/gun/energy/laser/captain,
		/obj/item/gun/energy/e_gun/hos,
	)

	return ..()

/obj/item/storage/belt/holster/detective
	name = "detective's holster"
	desc = "Um coldre capaz de carregar armas e munição extra, graças a uma bolsa costurada à mão adicional. ATENÇÃO: só badass."

/datum/storage/holster/detective
	max_slots = 4

/datum/storage/holster/detective/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound, list/holdables)
	if(length(holdables))
		return ..()

	holdables = list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/ammo_box/magazine, // Just magazine, because the sec-belt can hold these aswell
		/obj/item/gun/ballistic/revolver,
		/obj/item/ammo_box/speedloader, // Speedloaders, which includes stripper clips on a technicality.
		/obj/item/gun/energy/e_gun/mini,
		/obj/item/gun/energy/disabler,
		/obj/item/gun/energy/laser/pistol,
		/obj/item/food/grown/banana,
		/obj/item/gun/energy/dueling,
		/obj/item/gun/energy/laser/thermal,
		/obj/item/gun/ballistic/rifle/boltaction, //fits if you make it an obrez
		/obj/item/gun/energy/laser/captain,
		/obj/item/gun/energy/e_gun/hos,
	)

	return ..()

/datum/storage/holster/energy
	max_specific_storage = WEIGHT_CLASS_NORMAL

/datum/storage/holster/energy/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound, list/holdables)
	if(length(holdables))
		return ..()

	holdables = list(
		/obj/item/gun/energy/e_gun/mini,
		/obj/item/gun/energy/disabler,
		/obj/item/gun/energy/dueling,
		/obj/item/food/grown/banana,
		/obj/item/gun/energy/laser/thermal,
		/obj/item/gun/energy/recharge/ebow,
		/obj/item/gun/energy/laser/captain,
		/obj/item/gun/energy/e_gun/hos,
		/obj/item/gun/ballistic/automatic/pistol/plasma_marksman,
		/obj/item/gun/ballistic/automatic/pistol/plasma_thrower,
		/obj/item/ammo_box/magazine/recharge/plasma_battery,
	)

	return ..()

/*
*	HEAD
*/

/obj/item/clothing/head/helmet/sec/redsec
	icon = 'icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'icons/mob/clothing/head/helmet.dmi'
	icon_state = "helmet"
	base_icon_state = "helmet"
	actions_types = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEHAIR

/obj/item/clothing/head/hats/hos/cap/red
	icon = 'icons/obj/clothing/head/hats.dmi'
	worn_icon = 'icons/mob/clothing/head/hats.dmi'
	icon_state = "hoscap"
	base_icon_state = "hoscap"

/obj/item/clothing/head/hats/hos/cap/red/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/*
*	UNIFORM
*/

/obj/item/clothing/under/rank/security/officer/redsec
	icon_state = "rsecurity"

/obj/item/clothing/under/rank/security/officer/redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/officer/skirt/redsec
	icon_state = "secskirt"

/obj/item/clothing/under/rank/security/officer/skirt/redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/warden/redsec
	icon_state = "rwarden"

/obj/item/clothing/under/rank/security/warden/redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/warden/skirt/redsec
	icon_state = "rwarden_skirt"

/obj/item/clothing/under/rank/security/warden/skirt/redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/head_of_security/redsec
	icon_state = "rhos"

/obj/item/clothing/under/rank/security/head_of_security/redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/head_of_security/skirt/redsec
	icon_state = "rhos_skirt"

/obj/item/clothing/under/rank/security/head_of_security/skirt/redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/head_of_security/parade/redsec
	icon_state = "hos_parade_male"

/obj/item/clothing/under/rank/security/head_of_security/parade/redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/head_of_security/parade/female/redsec
	icon_state = "hos_parade_fem"

/obj/item/clothing/under/rank/security/head_of_security/parade/female/redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/head_of_security/alt/redsec
	icon_state = "hosalt"

/obj/item/clothing/under/rank/security/head_of_security/alt/redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/head_of_security/alt/skirt/redsec
	icon_state = "hosalt_skirt"

/obj/item/clothing/under/rank/security/head_of_security/alt/skirt/redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/*
*	WINTER COAT
*/

// turning one of the duplicate security winter jackets into a wintercoat
/obj/item/clothing/suit/hooded/wintercoat/security/redsec
	name = "security winter coat"
	desc = "Um casaco de inverno com um colete blindado em cima, perfeito para as noites frias de Freyja."
	icon_state = "coatsecurity_winter"
	icon = 'modular_zubbers/icons/obj/clothing/suits/wintercoat.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/wintercoat.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/suits/wintercoat_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/wintercoat_teshari.dmi'
	hoodtype = /obj/item/clothing/head/hooded/winterhood/security/redsec

/obj/item/clothing/head/hooded/winterhood/security/redsec
	name = "security winter hood"
	desc = "Um capuz de inverno vermelho e blindado. Definitivamente não é à prova de balas, especialmente a parte em que seu rosto vai."
	icon = 'modular_zubbers/icons/obj/clothing/head/winterhood.dmi'
	icon_state = "winterhood_security"
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/winterhood.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/head/winterhood_teshari.dmi'

/*
*	ARMOR
*/

/obj/item/clothing/suit/armor/vest/alt/sec/redsec
	desc = "Um colete blindado tipo I que fornece proteção decente contra a maioria dos danos."
	icon = 'icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'icons/mob/clothing/suits/armor.dmi'
	icon_state = "armor_sec"

/obj/item/clothing/suit/armor/vest/alt/sec/redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/suit/armor/hos/hos_formal/redsec
	icon = 'icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'icons/mob/clothing/suits/armor.dmi'
	icon_state = "hosformal"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/armor/hos/hos_formal/redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/*
*	FEET
*/
/obj/item/clothing/shoes/jackboots/sec/redsec
	name = "jackboots"
	desc = "Botas de combate de segurança para cenários de combate ou situações de combate. Todo combate, o tempo todo."
	icon_state = "jackboots_sec"
	icon = 'icons/obj/clothing/shoes.dmi'
	worn_icon = 'icons/mob/clothing/feet.dmi'

/obj/item/clothing/shoes/jackboots/sec/redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

//Finally, a few description changes for items that couldn't get a resprite.
/obj/item/clothing/head/bio_hood/security
	desc = "Um capuz que protege a cabeça e o rosto de contaminantes biológicos. Este é um modelo um pouco desatualizado da Nanotrasen Securities - você mal consegue ver através do visor de nevoeiro envelhecendo vermelho. Espero que ainda esteja à altura..."

/obj/item/clothing/suit/bio_suit/security
	desc = "Um processo que protege contra contaminação biológica. Este é um modelo ligeiramente desatualizado da Nanotrasen Securities, usando seu esquema de cor vermelha e até mesmo etiqueta desatualizada. Espero que ainda esteja à altura..."
