/obj/item/clothing/accessory/pocketwatch
	name = "pocket watch"
	desc = "Um relógio de bolso de ouro, inspirado na popular marca Uair de Carota. Abra-me, seu tolo. Abra a luz e me convoque e receba minha majestade."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_right.dmi'
	worn_icon_state = "pocketwatch"
	icon_state = "pocketwatch"
	inhand_icon_state = "pocketwatch"
	var/list/spans = list("velvet")
	actions_types = list(/datum/action/item_action/hypno_whisper)

//TODO: make a component for all that various hypno stuff instead of adding it to items individually
/obj/item/clothing/accessory/pocketwatch/ui_action_click(mob/living/user, action)
	if(!isliving(user) || !can_use(user))
		return
	var/message = input(user, "Fale com um sussurro hipnótico", "Whisper")
	if(QDELETED(src) || QDELETED(user) || !message || !user.can_speak())
		return
	user.whisper(message, spans = spans)


/obj/item/clothing/accessory/pocketwatch/examine(mob/user)
	. = ..()
	. += span_info("A hora atual do CST (local) é:[station_time_timestamp()].")
	. += span_info("O tempo atual do TCT (galáctico) é:[time2text(world.realtime, "hh:mm:ss")].")

/obj/item/storage/backpack/kanken //Donor item for LT3
	name = "kånken backpack"
	desc = "Design sueco clássico em tecido de vinil duro com um zip que abre todo o compartimento principal. Com um pequeno bolso dianteiro, simples alças e alças no topo, é feito para uma vida inteira de uso."
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/storage.dmi'
	lefthand_file = 'modular_skyrat/modules/deforest_medical_items/icons/inhands/cases_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/deforest_medical_items/icons/inhands/cases_righthand.dmi'
	worn_icon = 'modular_skyrat/modules/deforest_medical_items/icons/worn/worn.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/deforest_medical_items/icons/worn/worn_teshari.dmi'
	icon_state = "technician"
	inhand_icon_state = "technician"

/obj/item/clothing/accessory/fake/medal
	name = "plastic medal"
	desc = "Boa tentativa, amigo. Eles não vão gravar este. Especialmente porque diz \"Você é Winnar!\"Alt-Click para reskin!"

/obj/item/clothing/accessory/fake/medal/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/medal)

/datum/atom_skin/medal
	abstract_type = /datum/atom_skin/medal

/datum/atom_skin/medal/bronze
	preview_name = "Bronze"
	new_icon_state = "bronze"

/datum/atom_skin/medal/bronze_heart
	preview_name = "Bronze Heart"
	new_icon_state = "bronze_heart"

/datum/atom_skin/medal/silver
	preview_name = "Silver"
	new_icon_state = "silver"

/datum/atom_skin/medal/gold
	preview_name = "Gold"
	new_icon_state = "gold"

/datum/atom_skin/medal/plasma
	preview_name = "Plasma"
	new_icon_state = "plasma"

/datum/atom_skin/medal/cargo
	preview_name = "Cargo"
	new_icon_state = "cargo"

/datum/atom_skin/medal/paperwork
	preview_name = "Paperwork"
	new_icon_state = "medal_paperwork"

/datum/atom_skin/medal/medical_second_class
	preview_name = "Medical Second Class"
	new_icon_state = "med_medal"

/datum/atom_skin/medal/medical_first_class
	preview_name = "Medical First Class"
	new_icon_state = "med_medal2"

/datum/atom_skin/medal/atmosian
	preview_name = "Atmosian"
	new_icon_state = "elderatmosian"

/datum/atom_skin/medal/emergency_general
	preview_name = "Emergency Service - General"
	new_icon_state = "emergencyservices"

/datum/atom_skin/medal/emergency_engineering
	preview_name = "Emergency Service - Engineering"
	new_icon_state = "emergencyservices_engi"

/datum/atom_skin/medal/emergency_medical
	preview_name = "Emergency Service - Medical"
	new_icon_state = "emergencyservices_med"

// Pride Pin Over-ride
/obj/item/clothing/accessory/pride
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'

/obj/item/clothing/accessory/pride/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/pride)

/datum/atom_skin/pride
	abstract_type = /datum/atom_skin/pride

/datum/atom_skin/pride/rainbow
	preview_name = "Rainbow Pride"
	new_icon_state = "pride"

/datum/atom_skin/pride/bisexual
	preview_name = "Bisexual Pride"
	new_icon_state = "pride_bi"

/datum/atom_skin/pride/pansexual
	preview_name = "Pansexual Pride"
	new_icon_state = "pride_pan"

/datum/atom_skin/pride/asexual
	preview_name = "Asexual Pride"
	new_icon_state = "pride_ace"

/datum/atom_skin/pride/nonbinary
	preview_name = "Non-binary Pride"
	new_icon_state = "pride_enby"

/datum/atom_skin/pride/transgender
	preview_name = "Transgender Pride"
	new_icon_state = "pride_trans"

/datum/atom_skin/pride/intersex
	preview_name = "Intersex Pride"
	new_icon_state = "pride_intersex"

/datum/atom_skin/pride/lesbian
	preview_name = "Lesbian Pride"
	new_icon_state = "pride_lesbian"

/datum/atom_skin/pride/mlm
	preview_name = "Man-Loving-Man / Gay Pride"
	new_icon_state = "pride_mlm"

/datum/atom_skin/pride/genderfluid
	preview_name = "Genderfluid Pride"
	new_icon_state = "pride_genderfluid"

/datum/atom_skin/pride/genderqueer
	preview_name = "Genderqueer Pride"
	new_icon_state = "pride_genderqueer"

/datum/atom_skin/pride/aromantic
	preview_name = "Aromantic Pride"
	new_icon_state = "pride_aromantic"

// Dogtags
/obj/item/clothing/accessory/dogtags
	name = "Dogtags"
	desc = "Duas pequenas etiquetas de metal, conectadas com uma fina corrente que contém informações importantes sobre saúde. E tudo necessário para uma lápide..."
	icon = 'modular_zubbers/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/accessories.dmi'
	icon_state = "dogtags"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FIRE_PROOF // its metal, and funny to leave behind when you dust.
	attachment_slot = NONE
	above_suit = TRUE


/*
Greyscaled Medals

Highly modular and customizable spriteset.
Just a note - the .jsons will NOT agree with having different amounts of components per icon.
Use the 'blank' icon to keep the medals all sorted in their correct file,
even if they have different numbers of components.

Potential future ideas:
- Tie to job hours
- Unlock in Loadout when a requirement is met (i.e. job hours, as above)
- Department medals (adding to TG's existing medal lockboxes)
*/

/*
// AWARDABLE MEDALS
// These can be pinned onto others to 'award' them, appearing in the round-end screen
*/
/obj/item/clothing/accessory/medal/bubber
	name = "medal of robustness"
	desc = "Uma medalha dedicada a quem demonstra robustez em muitos campos."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/medal/bubber"
	post_init_icon_state = "medal_robust"
	greyscale_config = /datum/greyscale_config/medals/syndicate
	greyscale_config_worn = /datum/greyscale_config/medals/syndicate/worn
	greyscale_colors = "#ffff66#990000#ffff66#990000#ffffff"
	minimize_when_attached = TRUE
	attachment_slot = NONE
	flags_1 = IS_PLAYER_COLORABLE_1

// DS-2/Syndicate Medals
/obj/item/clothing/accessory/medal/bubber/syndicate
	name = "syndicate medal of robustness"
	desc = "Uma medalha dedicada a agentes verdadeiros especiais por robustez em muitos campos."
	icon_state = "/obj/item/clothing/accessory/medal/bubber/syndicate"
	post_init_icon_state = "medal_robust"

/obj/item/clothing/accessory/medal/bubber/syndicate/espionage
	name = "syndicate medal of espionage"
	desc = "Uma medalha dedicada a quem provou ser capaz de operações secretas."
	icon_state = "/obj/item/clothing/accessory/medal/bubber/syndicate/espionage"
	post_init_icon_state = "medal_espi"

/obj/item/clothing/accessory/medal/bubber/syndicate/interrogation
	name = "syndicate medal of interrogation"
	desc = "Uma medalha dedicada àqueles que se provaram capazes de interrogar até mesmo os membros mais resilientes de uma corporação inimiga."
	icon_state = "/obj/item/clothing/accessory/medal/bubber/syndicate/interrogation"
	post_init_icon_state = "medal_inter"

/obj/item/clothing/accessory/medal/bubber/syndicate/intelligence
	name = "syndicate medal of intelligence"
	desc = "Uma medalha dedicada a agentes de talento particular, tanto na coleta de informações sobre concorrentes (de formas sutis e evidentes) quanto na proteção da confidencialidade de seus próprios empregadores."
	icon_state = "/obj/item/clothing/accessory/medal/bubber/syndicate/intelligence"
	post_init_icon_state = "medal_intel"

/obj/item/clothing/accessory/medal/bubber/syndicate/diligence
	name = "syndicate medal of diligence"
	desc = "Uma medalha dedicada a um agente mais raro, que não se apressa, isto é para agentes que, através da observação paciente e estratégia, aproveitam o momento perfeito para agir. Como nossa cobra emblemática, eles esperam para atacar até que o inimigo mostre sua garganta, e entregar o golpe de morte perfeito."
	icon_state = "/obj/item/clothing/accessory/medal/bubber/syndicate/diligence"
	post_init_icon_state = "medal_dili"

/obj/item/clothing/accessory/medal/bubber/syndicate/communications
	name = "syndicate medal of communication"
	desc = "Uma medalha dedicada àqueles que provaram ser especialistas em contra-comunicação."
	icon_state = "/obj/item/clothing/accessory/medal/bubber/syndicate/communications"
	post_init_icon_state = "medal_comms"

/*
// ACCESSORY MEDALS
// These ones are purely cosmetic attachments
*/

/obj/item/clothing/accessory/bubber/acc_medal
	name = "circle medal"
	desc = "Você não deveria ter isso, faça um relatório de insetos!"
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal"
	post_init_icon_state = "medal_alt"
	greyscale_config = /datum/greyscale_config/medals/circle
	greyscale_config_worn = /datum/greyscale_config/medals/circle/worn
	greyscale_colors = "#9900cc#ffffff#9900cc#ff99ff#ffffff"
	minimize_when_attached = TRUE
	attachment_slot = NONE
	flags_1 = IS_PLAYER_COLORABLE_1

/*
// Circle Medals
// The default acc_medal is already the 'alt_circle' and defines our configs
*/
/obj/item/clothing/accessory/bubber/acc_medal/circle
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/circle"
	post_init_icon_state = "medal"

/obj/item/clothing/accessory/bubber/acc_medal/circle/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/circle/bar_ribbon"
	post_init_icon_state = "medal_bar_ribbon"

/obj/item/clothing/accessory/bubber/acc_medal/circle/hollow
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/circle/hollow"
	post_init_icon_state = "medal_hollow"

/obj/item/clothing/accessory/bubber/acc_medal/circle/hollow/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/circle/hollow/bar_ribbon"
	post_init_icon_state = "medal_hollow_bar_ribbon"

/*
// Shield Medals
*/
/obj/item/clothing/accessory/bubber/acc_medal/shield
	name = "shield medal"
	desc = "Uma medalha diária."
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/shield"
	post_init_icon_state = "medal"
	greyscale_config = /datum/greyscale_config/medals/shield
	greyscale_config_worn = /datum/greyscale_config/medals/shield/worn

/obj/item/clothing/accessory/bubber/acc_medal/shield/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/shield/bar_ribbon"
	post_init_icon_state = "medal_bar_ribbon"

/obj/item/clothing/accessory/bubber/acc_medal/shield/hollow
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/shield/hollow"
	post_init_icon_state = "medal_hollow"

/*
// Bar Medals
*/
/obj/item/clothing/accessory/bubber/acc_medal/bar
	name = "bar medal"
	desc = "Uma medalha diária."
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/bar"
	post_init_icon_state = "medal"
	greyscale_config = /datum/greyscale_config/medals/bar
	greyscale_config_worn = /datum/greyscale_config/medals/bar/worn

/obj/item/clothing/accessory/bubber/acc_medal/bar/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/bar/bar_ribbon"
	post_init_icon_state = "medal_bar_ribbon"

/obj/item/clothing/accessory/bubber/acc_medal/bar/hollow
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/bar/hollow"
	post_init_icon_state = "medal_hollow"

/*
// Heart Medals
*/
/obj/item/clothing/accessory/bubber/acc_medal/heart
	name = "heart medal"
	desc = "Uma medalha diária."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/heart"
	post_init_icon_state = "medal"
	greyscale_config = /datum/greyscale_config/medals/heart
	greyscale_config_worn = /datum/greyscale_config/medals/heart/worn

/obj/item/clothing/accessory/bubber/acc_medal/heart/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/heart/bar_ribbon"
	post_init_icon_state = "medal_bar_ribbon"

/obj/item/clothing/accessory/bubber/acc_medal/heart/special
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/heart/special"
	post_init_icon_state = "medal_special"

/obj/item/clothing/accessory/bubber/acc_medal/heart/special/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/heart/special/bar_ribbon"
	post_init_icon_state = "medal_special_bar_ribbon"

/*
// Crown Medals
*/
/obj/item/clothing/accessory/bubber/acc_medal/crown
	name = "crown medal"
	desc = "Uma medalha diária."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/crown"
	post_init_icon_state = "medal"
	greyscale_config = /datum/greyscale_config/medals/crown
	greyscale_config_worn = /datum/greyscale_config/medals/crown/worn

/obj/item/clothing/accessory/bubber/acc_medal/crown/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/crown/bar_ribbon"
	post_init_icon_state = "medal_bar_ribbon"

/obj/item/clothing/accessory/bubber/acc_medal/crown/hollow
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/crown/hollow"
	post_init_icon_state = "medal_hollow"

/obj/item/clothing/accessory/bubber/acc_medal/crown/hollow/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/crown/hollow/bar_ribbon"
	post_init_icon_state = "medal_hollow_bar_ribbon"

/*
// Special Medals
*/
/obj/item/clothing/accessory/bubber/acc_medal/glowcrystal
	name = "glowcrystal necklace"
	desc = "Uma pedra brilhante pendurada de um colar, um símbolo de gratidão semelhante a uma medalha."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/glowcrystal"
	post_init_icon_state = "necklace_crystal"
	greyscale_config = /datum/greyscale_config/medals/glow
	greyscale_config_worn = /datum/greyscale_config/medals/glow/worn
	greyscale_colors = "#7effff"

/obj/item/clothing/accessory/bubber/acc_medal/glowcrystal/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/glowcrystal)

/datum/atom_skin/glowcrystal
	abstract_type = /datum/atom_skin/glowcrystal

/datum/atom_skin/glowcrystal/crystal
	preview_name = "Crystal"
	new_icon_state = "necklace_crystal"

/datum/atom_skin/glowcrystal/bar
	preview_name = "Bar"
	new_icon_state = "necklace_bar"

/datum/atom_skin/glowcrystal/bar_hollow
	preview_name = "Hollow Bar"
	new_icon_state = "necklace_bar_hollow"

/datum/atom_skin/glowcrystal/diamond
	preview_name = "Diamond"
	new_icon_state = "necklace_diamond"

/datum/atom_skin/glowcrystal/diamond_hollow
	preview_name = "Hollow Diamond"
	new_icon_state = "necklace_diamond_hollow"

/datum/atom_skin/glowcrystal/shard
	preview_name = "Shard"
	new_icon_state = "necklace_shard"

/datum/atom_skin/glowcrystal/shard_hollow
	preview_name = "Hollow Shard"
	new_icon_state = "necklace_shard_hollow"

/datum/atom_skin/glowcrystal/triangle
	preview_name = "Triangle"
	new_icon_state = "necklace_triangle"

/datum/atom_skin/glowcrystal/triangle_hollow
	preview_name = "Hollow Triangle"
	new_icon_state = "necklace_triangle_hollow"

/datum/atom_skin/glowcrystal/circle
	preview_name = "Circle"
	new_icon_state = "necklace_circle"

/*
// Rank pins
*/
/obj/item/clothing/accessory/bubber/acc_medal/rankpin
	name = "rank pin"
	desc = "Um alfinete usado para mostrar realizações, avanços, ou de outra forma ganhou reconhecimento."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/rankpin"
	post_init_icon_state = "star"
	greyscale_config = /datum/greyscale_config/medals/rank_pins
	greyscale_config_worn = /datum/greyscale_config/medals/rank_pins/worn
	greyscale_colors = "#FFFFFF"

/obj/item/clothing/accessory/bubber/acc_medal/rankpin/bar
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/rankpin/bar"
	post_init_icon_state = "bar"

/obj/item/clothing/accessory/bubber/acc_medal/rankpin/two_bar
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/rankpin/two_bar"
	post_init_icon_state = "two_bar"

/*
// Neckpins
*/
/obj/item/clothing/accessory/bubber/acc_medal/neckpin
	name = "\improper NT company neckpin"
	desc = "Um broche especialmente dedicado a mostrar lealdade à sua empresa!"
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin"
	post_init_icon_state = "ntpin"
	greyscale_config = /datum/greyscale_config/medals/neckpins
	greyscale_config_worn = /datum/greyscale_config/medals/neckpins/worn
	greyscale_colors = "#FFFFFF#CCCED1"

/obj/item/clothing/accessory/bubber/acc_medal/neckpin/centcom
	name = "\improper Central Command neckpin"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin/centcom"
	post_init_icon_state = "ccpin"

/obj/item/clothing/accessory/bubber/acc_medal/neckpin/galfed
	name = "\improper GalFed neckpin"
	desc = "Um broche especialmente dedicado a mostrar lealdade à sua federação!"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin/galfed"
	post_init_icon_state = "sfpin"

/obj/item/clothing/accessory/bubber/acc_medal/neckpin/galfed911
	name = "\improper GalFed 911 neckpin"
	desc = "Um broche especialmente dedicado a mostrar lealdade à sua federação!"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin/galfed911"
	post_init_icon_state = "911pin"

/obj/item/clothing/accessory/bubber/acc_medal/neckpin/galfed811
	name = "\improper GalFed 811 neckpin"
	desc = "Um broche especialmente dedicado a mostrar lealdade à sua federação!"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin/galfed811"
	post_init_icon_state = "811pin"

/obj/item/clothing/accessory/bubber/acc_medal/neckpin/syndicate
	name = "\improper Syndicate neckpin"
	desc = "Um broche especialmente dedicado a mostrar lealdade ao Sindicato!"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin/syndicate"
	post_init_icon_state = "syndipin"
	greyscale_colors = "#262626#9c0000"

/obj/item/clothing/accessory/bubber/acc_medal/neckpin/interdyne
	name = "\improper Interdyne neckpin"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin/interdyne"
	post_init_icon_state = "ippin"
	greyscale_colors = "#FFFFFF#3aba1e"

/obj/item/clothing/accessory/bubber/acc_medal/neckpin/porttarkon
	name = "\improper Port Tarkon neckpin"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin/porttarkon"
	post_init_icon_state = "ptpin"

/*
// Military Bar Ribbons
*/
/obj/item/clothing/accessory/bubber/military_ribbon
	name = "military ribbon"
	desc = "Uma fita militar média."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/military_ribbon"
	post_init_icon_state = "ribbon1"
	greyscale_config = /datum/greyscale_config/medals/military_ribbon
	greyscale_config_worn = /datum/greyscale_config/medals/military_ribbon/worn
	greyscale_colors = "#ff0000#04ff00#0008ff"
	minimize_when_attached = TRUE
	attachment_slot = NONE
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/accessory/bubber/military_ribbon/two
	icon_state = "/obj/item/clothing/accessory/bubber/military_ribbon/two"
	post_init_icon_state = "ribbon2"

/obj/item/clothing/accessory/bubber/military_ribbon/three
	icon_state = "/obj/item/clothing/accessory/bubber/military_ribbon/three"
	post_init_icon_state = "ribbon3"

/*
// Ribbons
*/
/obj/item/clothing/accessory/bubber/ribbon
	name = "ribbon"
	desc = "Uma coisa normal."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/ribbon"
	post_init_icon_state = "ribbon1"
	greyscale_config = /datum/greyscale_config/medals/color_ribbon
	greyscale_config_worn = /datum/greyscale_config/medals/color_ribbon/worn
	greyscale_colors = "#ffffff#664200#fff700"
	minimize_when_attached = TRUE
	attachment_slot = NONE
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/accessory/bubber/ribbon/ribbon_slash
	icon_state = "/obj/item/clothing/accessory/bubber/ribbon/ribbon_slash"
	post_init_icon_state = "ribbon2"

/obj/item/clothing/accessory/bubber/ribbon/ribbon_arrup
	icon_state = "/obj/item/clothing/accessory/bubber/ribbon/ribbon_arrup"
	post_init_icon_state = "ribbon3"

/obj/item/clothing/accessory/bubber/ribbon/ribbon_line
	icon_state = "/obj/item/clothing/accessory/bubber/ribbon/ribbon_line"
	post_init_icon_state = "ribbon4"

/obj/item/clothing/accessory/bubber/ribbon/ribbon_dual
	icon_state = "/obj/item/clothing/accessory/bubber/ribbon/ribbon_dual"
	post_init_icon_state = "ribbon5"

/obj/item/clothing/accessory/bubber/ribbon/ribbon_flat
	icon_state = "/obj/item/clothing/accessory/bubber/ribbon/ribbon_flat"
	post_init_icon_state = "ribbon6"

/obj/item/clothing/accessory/bubber/ribbon/ribbon_twotone
	icon_state = "/obj/item/clothing/accessory/bubber/ribbon/ribbon_twotone"
	post_init_icon_state = "ribbon7"

/// GalFed Accessories
/obj/item/clothing/accessory/bubber/galfedribbon
	name = "\improper GalFed rank ribbon"
	desc = "Uma fita militar média."
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon"
	post_init_icon_state = "star_arr_ribbon_1"
	greyscale_colors = "#FFD700"
	greyscale_config = /datum/greyscale_config/galfedribbons
	greyscale_config_worn = /datum/greyscale_config/galfedribbons/worn
	minimize_when_attached = TRUE

/obj/item/clothing/accessory/bubber/galfedribbon/rank2
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank2"
	post_init_icon_state = "star_arr_ribbon_2"

/obj/item/clothing/accessory/bubber/galfedribbon/rank3
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank3"
	post_init_icon_state = "star_sw_ribbon_1"

/obj/item/clothing/accessory/bubber/galfedribbon/rank4
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank4"
	post_init_icon_state = "star_sw_ribbon_2"

/obj/item/clothing/accessory/bubber/galfedribbon/rank5
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank5"
	post_init_icon_state = "star_ribbon_1"

/obj/item/clothing/accessory/bubber/galfedribbon/rank6
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank6"
	post_init_icon_state = "star_ribbon_2"

/obj/item/clothing/accessory/bubber/galfedribbon/rank7
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank7"
	post_init_icon_state = "star_ribbon_3"

/obj/item/clothing/accessory/bubber/galfedribbon/rank8
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank8"
	post_init_icon_state = "arr_ribbon_1"

/obj/item/clothing/accessory/bubber/galfedribbon/rank9
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank8"
	post_init_icon_state = "arr_ribbon_2"

/obj/item/clothing/accessory/bubber/galfedribbon/rank10
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank9"
	post_init_icon_state = "arr_ribbon_3"

/obj/item/clothing/accessory/bubber/galfedribbon/rank11
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank10"
	post_init_icon_state = "sw_ribbon_1"

/obj/item/clothing/accessory/bubber/galfedribbon/rank12
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank11"
	post_init_icon_state = "sw_ribbon_2"

/obj/item/clothing/accessory/bubber/galfedribbon/rank13
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank12"
	post_init_icon_state = "sw_ribbon_3"

/obj/item/clothing/accessory/nova/acc_medal/neckpin/galfed/official
	name = "\improper GalFed Official neckpin"
	desc = "Um gancho especial para mostrar lealdade à Federação."
	greyscale_colors = "#ffff66#0099ff"
