#define RESKIN_CHARCOAL "Charcoal"
#define RESKIN_NT "NT Blue"
#define RESKIN_SYNDIE "Syndicate Red"

/obj/item/clothing/under/syndicate
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/syndicate_digi.dmi' // Anything that was in the syndicate.dmi, should be in the syndicate_digi.dmi

/obj/item/clothing/under/syndicate/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/syndicate.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/syndicate.dmi'
	//These are pre-set for ease and reference, as syndie under items SHOULDNT have sensors and should have similar stats; also its better to start with adjust = false
	has_sensor = NO_SENSORS
	can_adjust = FALSE

//Related files:
// modular_skyrat\modules\syndie_edits\code\syndie_edits.dm (this has the Overalls and non-Uniforms)
// modular_skyrat\modules\novaya_ert\code\uniform.dm (NRI uniform(s))

/*
*	TACTICOOL
*/

//This is an overwrite, not a fully new item, but still fits best here.

/obj/item/clothing/under/syndicate/tacticool //Overwrites the 'fake' one. Zero armor, sensors, and default blue. More Balanced to make station-available.
	name = "tacticool turtleneck"
	desc = "Uma gola alta confortável, em fabuloso azul Nanotrasen. Só de olhar para ele faz você querer comprar um café com certificado de NT, ir para o escritório, e trabalhar."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/syndicate.dmi' //Since its an overwrite it needs new icon linking. Woe.
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/syndicate.dmi'
	icon_state = "tactifool_blue"
	inhand_icon_state = "b_suit"
	can_adjust = TRUE
	has_sensor = HAS_SENSORS
	armor_type = /datum/armor/clothing_under
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	resistance_flags = FLAMMABLE

/obj/item/clothing/under/syndicate/tacticool/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/tacticool_turtleneck)
	RegisterSignal(src, COMSIG_OBJ_RESKIN, PROC_REF(on_reskin))

/datum/atom_skin/tacticool_turtleneck
	abstract_type = /datum/atom_skin/tacticool_turtleneck

/datum/atom_skin/tacticool_turtleneck/nt
	preview_name = RESKIN_NT
	new_icon_state = "tactifool_blue"

/datum/atom_skin/tacticool_turtleneck/charcoal
	preview_name = RESKIN_CHARCOAL
	new_icon_state = "tactifool"

/obj/item/clothing/under/syndicate/tacticool/proc/on_reskin()
	SIGNAL_HANDLER
	if(icon_state == "tactifool")
		desc = "Só de olhar para ele faz você querer comprar um SKS, ir para a floresta, e - operar-."
		inhand_icon_state = "bl_suit"

/obj/item/clothing/under/syndicate/tacticool/skirt //Overwrites the 'fake' one. Zero armor, sensors, and default blue. More Balanced to make station-available.
	name = "tacticool skirtleneck"
	desc = "Uma saia confortável, em fabuloso azul Nanotrasen. Só de olhar para ele faz você querer comprar um café com certificado de NT, ir para o escritório, e trabalhar."
	icon_state = "tactifool_blue_skirt"
	armor_type = /datum/armor/clothing_under
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	dying_key = DYE_REGISTRY_JUMPSKIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/syndicate/tacticool/skirt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/tacticool_skirtleneck)

/datum/atom_skin/tacticool_skirtleneck
	abstract_type = /datum/atom_skin/tacticool_skirtleneck

/datum/atom_skin/tacticool_skirtleneck/nt
	preview_name = RESKIN_NT
	new_icon_state = "tactifool_blue_skirt"

/datum/atom_skin/tacticool_skirtleneck/charcoal
	preview_name = RESKIN_CHARCOAL
	new_icon_state = "tactifool_skirt"

/obj/item/clothing/under/syndicate/bloodred/sleepytime/sensors //Halloween-only
	has_sensor = HAS_SENSORS
	armor_type = /datum/armor/clothing_under
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/skyrat/baseball
	name = "syndicate baseball tee"
	desc = "As cobras do Sindicato estão prontas para um dos homeruns nucleares. Vamos mostrar a esses corpóreos um bom tempo." //NT pitches their plasma/bluespace(something)
	icon_state = "syndicate_baseball"

/*
*	TACTICAL (Real)
*/
//The red alts, for BLATANTLY syndicate stuff (Like DS2)
// (Multiple non-syndicate things use the base tactical turtleneck, they cant have it red nor reskinnable. OUR version, however, can be.)
/obj/item/clothing/under/syndicate/skyrat/tactical
	name = "tactical turtleneck"
	desc = "Uma gola rola vermelha com calças pretas. Boa sorte discutindo lealdade com isso."
	icon_state = "syndicate_red"
	inhand_icon_state = "r_suit"
	can_adjust = TRUE
	alt_covers_chest = TRUE
	armor_type = /datum/armor/clothing_under/syndicate
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/skyrat/tactical/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/tactical_turtleneck)
	RegisterSignal(src, COMSIG_OBJ_RESKIN, PROC_REF(on_reskin))

/datum/atom_skin/tactical_turtleneck
	abstract_type = /datum/atom_skin/tactical_turtleneck

/datum/atom_skin/tactical_turtleneck/syndie
	preview_name = RESKIN_SYNDIE
	new_icon_state = "syndicate_red"

/datum/atom_skin/tactical_turtleneck/charcoal
	preview_name = RESKIN_CHARCOAL
	new_icon_state = "syndicate"

/obj/item/clothing/under/syndicate/skyrat/tactical/proc/on_reskin()
	SIGNAL_HANDLER
	if(icon_state == "syndicate")
		desc = "Uma gola alta e um pouco suspeita com camuflagem digital."
		inhand_icon_state = "bl_suit"

/obj/item/clothing/under/syndicate/skyrat/tactical/skirt
	name = "tactical skirtleneck"
	desc = "Uma saia vermelha e confortável com uma saia preta. Boa sorte discutindo lealdade com isso."
	icon_state = "syndicate_red_skirt"
	inhand_icon_state = "r_suit"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	dying_key = DYE_REGISTRY_JUMPSKIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/syndicate/skyrat/tactical/skirt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/tactical_skirtleneck)

/datum/atom_skin/tactical_skirtleneck
	abstract_type = /datum/atom_skin/tactical_skirtleneck

/datum/atom_skin/tactical_skirtleneck/syndie
	preview_name = RESKIN_SYNDIE
	new_icon_state = "syndicate_red_skirt"

/datum/atom_skin/tactical_skirtleneck/charcoal
	preview_name = RESKIN_CHARCOAL
	new_icon_state = "syndicate_skirt"

/obj/item/clothing/under/syndicate/skyrat/tactical/skirt/on_reskin()
	. = ..()
	if(icon_state == "syndicate_skirt")
		desc = "Um não-descrito e um pouco suspeito, marginal."
		inhand_icon_state = "bl_suit"

/*
*	ENCLAVE
*/
/obj/item/clothing/under/syndicate/skyrat/enclave
	name = "neo-American sergeant uniform"
	desc = "Através das estrelas, rumores de cientistas loucos e sargentos furiosos correm desenfreados, de criaturas de armadura negra como a noite, sendo lideradas por homens ou mulheres vestindo este uniforme. Eles compartilham uma coisa: um profundo zelo natonalista do sonho da América."
	icon_state = "enclave"
	can_adjust = TRUE
	armor_type = /datum/armor/clothing_under

/obj/item/clothing/under/syndicate/skyrat/enclave/officer
	name = "neo-American officer uniform"
	icon_state = "enclaveo"

/obj/item/clothing/under/syndicate/skyrat/enclave/real
	armor_type = /datum/armor/clothing_under/syndicate

/obj/item/clothing/under/syndicate/skyrat/enclave/real/officer
	name = "neo-American officer uniform"
	icon_state = "enclaveo"

#undef RESKIN_CHARCOAL
#undef RESKIN_NT
#undef RESKIN_SYNDIE
