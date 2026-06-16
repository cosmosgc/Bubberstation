/// Map of names of clown mask types to clown mask icon states
GLOBAL_LIST_INIT(clown_mask_options, list(
	"True Form" = "clown",
	"The Coquette" = "sexyclown",
	"The Madman" = "joker",
	"The Rainbow Color" = "rainbow",
	"The Dealer" = "cards"
))

/obj/item/clothing/mask/gas
	name = "gas mask"
	desc = "Uma máscara que pode ser conectada a um suprimento de ar. Bom para esconder sua identidade e com um filtro para ajudar a remover essas toxinas." //More accurate
	icon_state = "gas_alt"
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS | GAS_FILTERING
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	w_class = WEIGHT_CLASS_NORMAL
	inhand_icon_state = "gas_alt"
	armor_type = /datum/armor/mask_gas
	flags_cover = MASKCOVERSEYES | MASKCOVERSMOUTH | PEPPERPROOF
	resistance_flags = NONE
	voice_filter = "lowpass=f=750,volume=2"
	sound_vary = TRUE
	pickup_sound = SFX_GAS_MASK_PICKUP
	drop_sound = SFX_GAS_MASK_DROP
	equip_sound = SFX_GAS_MASK_EQUIP
	///Max numbers of installable filters
	var/max_filters = 1
	///List to keep track of each filter
	var/list/gas_filters
	///Type of filter that spawns on roundstart
	var/starting_filter_type = /obj/item/gas_filter
	///Cigarette in the mask
	var/obj/item/cigarette/cig
	///How much does this mask affect fishing difficulty
	var/fishing_modifier = 2
	///Applies clothing_dirt component to the pepperproof mask if true
	var/pepper_tint = TRUE
	///icon_state used by clothing_dirt
	var/dirt_state = "gas_dirt"

/datum/armor/mask_gas
	bio = 100

/obj/item/clothing/mask/gas/Initialize(mapload)
	. = ..()

	if((flags_cover & PEPPERPROOF) && pepper_tint)
		AddComponent(/datum/component/clothing_dirt, dirt_state)

	if(fishing_modifier)
		AddElement(/datum/element/adjust_fishing_difficulty, fishing_modifier)

	if(!max_filters || !starting_filter_type)
		return

	for(var/i in 1 to max_filters)
		var/obj/item/gas_filter/inserted_filter = new starting_filter_type(src)
		LAZYADD(gas_filters, inserted_filter)
	has_filter = TRUE

/obj/item/clothing/mask/gas/separate_worn_overlays(mutable_appearance/standing, mutable_appearance/draw_target, isinhands, icon_file)
	. = ..()
	if(!isinhands && cig)
		. += cig.build_worn_icon(default_layer = FACEMASK_LAYER, default_icon_file = 'icons/mob/clothing/mask.dmi')

/obj/item/clothing/mask/gas/Destroy()
	QDEL_LAZYLIST(gas_filters)
	return..()

/obj/item/clothing/mask/gas/equipped(mob/equipee, slot)
	cig?.equipped(equipee, slot)
	return ..()

/obj/item/clothing/mask/gas/adjust_visor(mob/living/user)
	if(!isnull(cig))
		balloon_alert(user, "Cig no caminho!")
		return FALSE
	return ..()

/obj/item/clothing/mask/gas/examine(mob/user)
	. = ..()
	if(cig)
		. += span_notice("Há um [cig.name] Preso no filtro.")
	if(max_filters > 0 && !cig)
		. += span_notice("[src] Tem [max_filters] slot\s para filtros.")
	if(LAZYLEN(gas_filters) > 0)
		. += span_notice("Atualmente lá.[LAZYLEN(gas_filters) == 1 ? "is" : "are"] [LAZYLEN(gas_filters)] filtro com [get_filter_durability()] Percentagem de durabilidade.")
		. += span_notice("Os filtros podem ser removidos clicando com o botão direito com uma mão vazia.[src].")

/obj/item/clothing/mask/gas/Exited(atom/movable/gone)
	. = ..()
	if(gone == cig)
		cig = null
		if(ismob(loc))
			var/mob/wearer = loc
			wearer.update_worn_mask()

/obj/item/clothing/mask/gas/attackby(obj/item/tool, mob/user)
	var/valid_wearer = ismob(loc)
	var/mob/wearer = loc
	if(istype(tool, /obj/item/cigarette))

		if(max_filters <= 0 || cig)
			balloon_alert(user, "Não consigo segurar isso!")
			return ..()

		if(has_filter)
			balloon_alert(user, "Filtros na máscara!")
			return ..()

		cig = tool
		if(valid_wearer)
			cig.equipped(loc, wearer.get_slot_by_item(cig))

		cig.forceMove(src)
		if(valid_wearer)
			wearer.update_worn_mask()
		return TRUE

	if(cig)
		var/cig_attackby = cig.attackby(tool, user)
		if(valid_wearer)
			wearer.update_worn_mask()
		return cig_attackby
	if(!istype(tool, /obj/item/gas_filter))
		return ..()
	if(LAZYLEN(gas_filters) >= max_filters)
		return ..()
	if(!user.transferItemToLoc(tool, src))
		return ..()
	LAZYADD(gas_filters, tool)
	has_filter = TRUE
	return TRUE

/obj/item/clothing/mask/gas/attack_hand_secondary(mob/user, list/modifiers)
	if(cig)
		user.put_in_hands(cig)
		cig = null
		if(ismob(loc))
			var/mob/wearer = loc
			wearer.update_worn_mask()
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(!has_filter || !max_filters)
		return SECONDARY_ATTACK_CONTINUE_CHAIN
	for(var/i in 1 to max_filters)
		var/obj/item/gas_filter/filter = locate() in src
		if(!filter)
			continue
		user.put_in_hands(filter)
		LAZYREMOVE(gas_filters, filter)
	if(LAZYLEN(gas_filters) <= 0)
		has_filter = FALSE
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

///Check _masks.dm for this one
/obj/item/clothing/mask/gas/consume_filter(datum/gas_mixture/breath)
	if(LAZYLEN(gas_filters) <= 0 || max_filters == 0)
		return breath
	var/obj/item/gas_filter/gas_filter = pick(gas_filters)
	var/datum/gas_mixture/filtered_breath = gas_filter.reduce_filter_status(breath)
	if(gas_filter.filter_status <= 0)
		LAZYREMOVE(gas_filters, gas_filter)
		qdel(gas_filter)
	if(LAZYLEN(gas_filters) <= 0)
		has_filter = FALSE
	return filtered_breath

/**
 * Getter for overall filter durability, takes into consideration all filters filter_status
 */
/obj/item/clothing/mask/gas/proc/get_filter_durability()
	var/max_filters_durability = LAZYLEN(gas_filters) * 100
	var/current_filters_durability
	for(var/obj/item/gas_filter/gas_filter as anything in gas_filters)
		current_filters_durability += gas_filter.filter_status
	var/durability = (current_filters_durability / max_filters_durability) * 100
	return durability

/obj/item/clothing/mask/gas/atmos
	name = "atmospheric gas mask"
	desc = "Máscara de gás melhorada usada por técnicos atmosféricos. É à prova de chamas!"
	icon_state = "gas_atmos"
	inhand_icon_state = "gas_atmos"
	armor_type = /datum/armor/gas_atmos
	resistance_flags = FIRE_PROOF
	max_filters = 3

/datum/armor/gas_atmos
	bio = 100
	fire = 20
	acid = 10

/obj/item/clothing/mask/gas/atmos/plasmaman
	starting_filter_type = /obj/item/gas_filter/plasmaman

/obj/item/clothing/mask/gas/atmos/captain
	name = "captain's gas mask"
	desc = "Nanotrasen cortou os cantos e pintou uma máscara de gás atmosférico, mas não conte a ninguém."
	icon_state = "gas_cap"
	inhand_icon_state = "gasmask_captain"
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/mask/gas/atmos/centcom
	name = "\improper CentCom gas mask"
	desc = "Ouro e verde. Chique! Isso deve ajudar enquanto se senta no seu escritório."
	icon = 'icons/obj/clothing/masks.dmi'
	worn_icon = 'icons/mob/clothing/mask.dmi'
	worn_icon_state = "gas_centcom"
	icon_state = "gas_centcom"
	inhand_icon_state = "gas_centcom"
	resistance_flags = FIRE_PROOF | ACID_PROOF

// **** Welding gas mask ****

/obj/item/clothing/mask/gas/welding
	name = "welding mask"
	desc = "Uma máscara de gás com óculos de solda embutidos e um escudo facial. Parece um crânio, claramente desenhado por um nerd."
	icon_state = "weldingmask"
	flash_protect = FLASH_PROTECTION_WELDER
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*2, /datum/material/glass=SHEET_MATERIAL_AMOUNT)
	tint = 2
	toggle_message = "Você puxa o visor para baixo."
	alt_toggle_message = "Você empurra o visor para cima."
	armor_type = /datum/armor/gas_welding
	actions_types = list(/datum/action/item_action/toggle)
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDESNOUT
	flags_cover = MASKCOVERSEYES|MASKCOVERSMOUTH|PEPPERPROOF
	visor_flags_inv = HIDEEYES
	visor_flags_cover = MASKCOVERSEYES|MASKCOVERSMOUTH|PEPPERPROOF
	visor_vars_to_toggle = VISOR_FLASHPROTECT | VISOR_TINT
	resistance_flags = FIRE_PROOF
	clothing_flags = parent_type::clothing_flags | INTERNALS_ADJUST_EXEMPT
	fishing_modifier = 8
	dirt_state = "welding_dirt"

/datum/armor/gas_welding
	melee = 10
	bio = 100
	fire = 100
	acid = 55

/obj/item/clothing/mask/gas/welding/attack_self(mob/user)
	adjust_visor(user)

/obj/item/clothing/mask/gas/welding/adjust_visor(mob/living/user)
	. = ..()
	if(.)
		playsound(src, up ? SFX_VISOR_UP : SFX_VISOR_DOWN, 50, TRUE)
	if(!fishing_modifier)
		return
	if(up)
		RemoveElement(/datum/element/adjust_fishing_difficulty)
	else
		AddElement(/datum/element/adjust_fishing_difficulty, fishing_modifier)

/obj/item/clothing/mask/gas/welding/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)][up ? "up" : ""]"

/obj/item/clothing/mask/gas/welding/up/Initialize(mapload)
	. = ..()
	visor_toggling()

// ********************************************************************

//Plague Dr suit can be found in clothing/suits/bio.dm
/obj/item/clothing/mask/gas/plaguedoctor
	name = "plague doctor mask"
	desc = "Uma versão modernizada do design clássico, esta máscara não só o protegerá da exposição à Pestilência, mas também pode ser conectada a um suprimento de ar."
	icon_state = "plaguedoctor"
	flags_inv = HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	inhand_icon_state = "gas_mask"
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT|MASKINTERNALS
	dirt_state = "plague_dirt"

/obj/item/clothing/mask/gas/syndicate
	name = "syndicate mask"
	desc = "Uma máscara tática que pode ser conectada a um suprimento de ar."
	icon_state = "syndicate"
	inhand_icon_state = "syndicate_gasmask"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	strip_delay = 6 SECONDS
	w_class = WEIGHT_CLASS_SMALL
	fishing_modifier = 0
	pepper_tint = FALSE

/obj/item/clothing/mask/gas/syndicate/plasmaman
	starting_filter_type = /obj/item/gas_filter/plasmaman

/obj/item/clothing/mask/gas/clown_hat
	name = "clown wig and mask"
	desc = "O traje facial de um verdadeiro brincalhão. Um palhaço está incompleto sem peruca e máscara."
	clothing_flags = MASKINTERNALS
	icon_state = "clown"
	inhand_icon_state = "clown_hat"
	lefthand_file = 'icons/mob/inhands/clothing/hats_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/hats_righthand.dmi'
	dye_color = DYE_CLOWN
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = MASKCOVERSEYES
	clothing_traits = list(TRAIT_PERCEIVED_AS_CLOWN)
	resistance_flags = FLAMMABLE
	actions_types = list(/datum/action/item_action/adjust_style)
	dog_fashion = /datum/dog_fashion/head/clown
	var/list/clownmask_designs = list()
	voice_filter = null // performer masks expect to be talked through
	fishing_modifier = 0

/obj/item/clothing/mask/gas/clown_hat/plasmaman
	starting_filter_type = /obj/item/gas_filter/plasmaman

/obj/item/clothing/mask/gas/clown_hat/Initialize(mapload)
	.=..()
	clownmask_designs = list(
		"True Form" = image(icon = src.icon, icon_state = "clown"),
		"The Coquette" = image(icon = src.icon, icon_state = "sexyclown"),
		"The Madman" = image(icon = src.icon, icon_state = "joker"),
		"The Rainbow Color" = image(icon = src.icon, icon_state = "rainbow"),
		"The Dealer" = image(icon = src.icon, icon_state = "cards"),
		)
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_CLOWN, CELL_VIRUS_TABLE_GENERIC, rand(2,3), 0)

/obj/item/clothing/mask/gas/clown_hat/ui_action_click(mob/user)
	if(!istype(user) || user.incapacitated)
		return

	var/choice = show_radial_menu(user,src, clownmask_designs, custom_check = FALSE, radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE

	if(src && choice && !user.incapacitated && in_range(user,src))
		var/list/options = GLOB.clown_mask_options
		icon_state = options[choice]
		user.update_worn_mask()
		update_item_action_buttons()
		to_chat(user, span_notice("Sua máscara de palhaço se transformou em [choice] Todos louvem a Honkmother!"))
		return TRUE

/obj/item/clothing/mask/gas/sexyclown
	name = "sexy-clown wig and mask"
	desc = "Uma máscara de palhaço feminino para travestis ou artistas femininos."
	clothing_flags = MASKINTERNALS
	icon_state = "sexyclown"
	inhand_icon_state = "sexyclown_hat"
	lefthand_file = 'icons/mob/inhands/clothing/hats_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/hats_righthand.dmi'
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE
	fishing_modifier = 0

/obj/item/clothing/mask/gas/jonkler
	name = "gamer's wig and mask"
	desc = "Mas eu sou um jogador, e nenhum homem, um vitupério de homens, e desprezado pelo povo."
	clothing_flags = MASKINTERNALS
	icon_state = "jonkler"
	inhand_icon_state = null
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE

/obj/item/clothing/mask/gas/mime
	name = "mime mask"
	desc = "A máscara de mímica tradicional. Tem uma postura facial assustadora."
	clothing_flags = MASKINTERNALS
	icon_state = "mime"
	inhand_icon_state = null
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE
	actions_types = list(/datum/action/item_action/adjust_style)
	species_exception = list(/datum/species/golem)
	fishing_modifier = 0
	var/list/mimemask_designs = list()

/obj/item/clothing/mask/gas/mime/plasmaman
	starting_filter_type = /obj/item/gas_filter/plasmaman

/obj/item/clothing/mask/gas/mime/Initialize(mapload)
	.=..()
	mimemask_designs = list(
		"Blanc" = image(icon = src.icon, icon_state = "mime"),
		"Excité" = image(icon = src.icon, icon_state = "sexymime"),
		"Triste" = image(icon = src.icon, icon_state = "sadmime"),
		"Effrayé" = image(icon = src.icon, icon_state = "scaredmime")
		)

/obj/item/clothing/mask/gas/mime/ui_action_click(mob/user)
	if(!istype(user) || user.incapacitated)
		return

	var/list/options = list()
	options["Blanc"] = "mime"
	options["Triste"] = "sadmime"
	options["Effrayé"] = "scaredmime"
	options["Excité"] ="sexymime"

	var/choice = show_radial_menu(user,src, mimemask_designs, custom_check = FALSE, radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE

	if(src && choice && !user.incapacitated && in_range(user,src))
		// SKYRAT EDIT ADDITION START - More mask variations
		var/mob/living/carbon/human/human_user = user
		if(human_user.dna.species.mutant_bodyparts[FEATURE_SNOUT])
			icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
			worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask_muzzled.dmi'
			var/list/avian_snouts = list("Beak", "Big Beak", "Corvid Beak")
			if(human_user.dna.species.mutant_bodyparts[FEATURE_SNOUT][MUTANT_INDEX_NAME] in avian_snouts)
				icon_state = "[options[choice]]_b"
		else
			icon = 'icons/obj/clothing/masks.dmi'
			worn_icon = 'icons/mob/clothing/mask.dmi'
			icon_state = options[choice]
		/* SKYRAT EDIT ADDITION END
		icon_state = options[choice]
		*/
		user.update_worn_mask()
		update_item_action_buttons()
		to_chat(user, span_notice("Sua máscara Mime se transformou em [choice]!"))
		return TRUE

/obj/item/clothing/mask/gas/monkeymask
	name = "monkey mask"
	desc = "Uma máscara usada como macaco."
	clothing_flags = MASKINTERNALS
	icon_state = "monkeymask"
	inhand_icon_state = "owl_mask"
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE
	fishing_modifier = 0

/obj/item/clothing/mask/gas/sexymime
	name = "sexy mime mask"
	desc = "Uma máscara tradicional de mímica feminina."
	clothing_flags = MASKINTERNALS
	icon_state = "sexymime"
	inhand_icon_state = null
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE
	species_exception = list(/datum/species/golem)
	fishing_modifier = 0

/obj/item/clothing/mask/gas/cyborg
	name = "cyborg visor"
	desc = "Beep boop."
	icon_state = "death"
	resistance_flags = FLAMMABLE
	flags_cover = MASKCOVERSEYES
	fishing_modifier = 0

/obj/item/clothing/mask/gas/owl_mask
	name = "owl mask"
	desc = "Doisooo!"
	icon_state = "owl"
	inhand_icon_state = "owl_mask"
	clothing_flags = MASKINTERNALS
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE
	fishing_modifier = -2

/obj/item/clothing/mask/gas/carp
	name = "carp mask"
	desc = "Gnash gnash."
	icon_state = "carp_mask"
	inhand_icon_state = null
	flags_cover = MASKCOVERSEYES
	clothing_flags = MASKINTERNALS | CARP_STYLE_FACTOR
	fishing_modifier = -4

/obj/item/clothing/mask/gas/tiki_mask
	name = "tiki mask"
	desc = "Uma máscara de madeira assustadora. Surpreendentemente expressivo para um pedaço de madeira mal esculpida."
	icon_state = "tiki_eyebrow"
	inhand_icon_state = null
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 2)
	resistance_flags = FLAMMABLE
	flags_cover = MASKCOVERSEYES
	max_integrity = 100
	actions_types = list(/datum/action/item_action/adjust_style)
	dog_fashion = null
	fishing_modifier = -4
	var/list/tikimask_designs = list()

/obj/item/clothing/mask/gas/tiki_mask/Initialize(mapload)
	.=..()
	tikimask_designs = list(
		"Original Tiki" = image(icon = src.icon, icon_state = "tiki_eyebrow"),
		"Happy Tiki" = image(icon = src.icon, icon_state = "tiki_happy"),
		"Confused Tiki" = image(icon = src.icon, icon_state = "tiki_confused"),
		"Angry Tiki" = image(icon = src.icon, icon_state = "tiki_angry")
		)

/obj/item/clothing/mask/gas/tiki_mask/ui_action_click(mob/user)
	var/mob/M = usr
	var/list/options = list()
	options["Original Tiki"] = "tiki_eyebrow"
	options["Happy Tiki"] = "tiki_happy"
	options["Confused Tiki"] = "tiki_confused"
	options["Angry Tiki"] ="tiki_angry"

	var/choice = show_radial_menu(user,src, tikimask_designs, custom_check = FALSE, radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE

	if(src && choice && !M.stat && in_range(M,src))
		icon_state = options[choice]
		user.update_worn_mask()
		update_item_action_buttons()
		to_chat(M, span_notice("A Máscara Tiki mudou para [choice] Máscara!"))
		return 1

/obj/item/clothing/mask/gas/tiki_mask/yalp_elor
	icon_state = "tiki_yalp"
	actions_types = list()

/obj/item/clothing/mask/gas/hunter
	name = "bounty hunting mask"
	desc = "Uma máscara tática personalizada com decalques adicionados."
	icon_state = "hunter"
	inhand_icon_state = "gas_atmos"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	flags_inv = HIDEFACIALHAIR|HIDEFACE|HIDEEYES|HIDEEARS|HIDEHAIR|HIDESNOUT
	fishing_modifier = -4
	dirt_state = null

/obj/item/clothing/mask/gas/prop
	name = "prop gas mask"
	desc = "Uma máscara de gás projetada para aparência. Ao contrário de uma máscara de gás normal isso não filtra gases ou protege contra spray de pimenta."
	icon_state = "gas_prop"
	inhand_icon_state = "gas_prop"
	clothing_flags = NONE
	flags_cover = MASKCOVERSMOUTH
	resistance_flags = FLAMMABLE
	fishing_modifier = 0

/obj/item/clothing/mask/gas/atmosprop
	name = "prop atmospheric gas mask"
	desc = "Uma máscara de gás atmosférico projetada para aparência. Ao contrário de uma máscara de gás atmosférico normal isso não filtra gases ou protege contra spray de pimenta."
	worn_icon_state = "gas_prop_atmos"
	icon_state = "gas_atmos"
	inhand_icon_state = "gas_atmos"
	clothing_flags = NONE
	flags_cover = MASKCOVERSMOUTH
	resistance_flags = FLAMMABLE
	fishing_modifier = 0

/obj/item/clothing/mask/gas/driscoll
	name = "driscoll mask"
	desc = "Ótimo para roubos de trem. Funciona como uma máscara de gás normal, mas não esconderá sua identidade."
	icon_state = "driscoll_mask"
	flags_inv = HIDEFACIALHAIR
	flags_cover = MASKCOVERSMOUTH
	w_class = WEIGHT_CLASS_NORMAL
	inhand_icon_state = null
	fishing_modifier = 0
