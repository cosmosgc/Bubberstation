/**************SKYRAT REWARDS**************/
//SUITS
/obj/item/clothing/suit/hooded/wintercoat/colourable
	name = "custom winter coat"
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/colourable"
	post_init_icon_state = "winter_coat"
	worn_icon_state = null
	hoodtype = /obj/item/clothing/head/hooded/winterhood/colourable
	greyscale_config = /datum/greyscale_config/winter_coat
	greyscale_config_worn = /datum/greyscale_config/winter_coat_worn
	greyscale_colors = "#666666#CCBBAA#0000FF"
	flags_1 = IS_PLAYER_COLORABLE_1
	hood_down_overlay_suffix = ""
	/// Whether the hood is flipped up
	var/hood_up = FALSE

/// Called when the hood is worn
/obj/item/clothing/suit/hooded/wintercoat/colourable/on_hood_up(obj/item/clothing/head/hooded/hood)
	hood_up = TRUE

/// Called when the hood is hidden
/obj/item/clothing/suit/hooded/wintercoat/colourable/on_hood_down(obj/item/clothing/head/hooded/hood)
	hood_up = FALSE

//In case colors are changed after initialization
/obj/item/clothing/suit/hooded/wintercoat/colourable/set_greyscale(list/colors, new_config, new_worn_config, new_inhand_left, new_inhand_right)
	. = ..()

	if(!hood)
		return

	var/list/coat_colors = SSgreyscale.ParseColorString(greyscale_colors)
	var/list/new_coat_colors = coat_colors.Copy(1,3)
	hood.set_greyscale(new_coat_colors) //Adopt the suit's grayscale coloring for visual clarity.

//But also keep old method in case the hood is (re-)created later
/obj/item/clothing/suit/hooded/wintercoat/colourable/on_hood_created(obj/item/clothing/head/hooded/hood)
	. = ..()
	var/list/coat_colors = (SSgreyscale.ParseColorString(greyscale_colors))
	var/list/new_coat_colors = coat_colors.Copy(1,3)
	hood.set_greyscale(new_coat_colors) //Adopt the suit's grayscale coloring for visual clarity.

/obj/item/clothing/head/hooded/winterhood/colourable
	icon_state = "hood_winter"
	greyscale_config = /datum/greyscale_config/winter_hood
	greyscale_config_worn = /datum/greyscale_config/winter_hood/worn

// NECK

/obj/item/clothing/neck/cloak/colourable
	name = "colourable cloak"
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/cloak/colourable"
	post_init_icon_state = "gags_cloak"
	greyscale_config = /datum/greyscale_config/cloak
	greyscale_config_worn = /datum/greyscale_config/cloak/worn
	greyscale_colors = "#917A57#4e412e#4e412e"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/neck/cloak/colourable/veil
	name = "colourable veil"
	icon_state = "/obj/item/clothing/neck/cloak/colourable/veil"
	post_init_icon_state = "gags_veil"
	greyscale_config = /datum/greyscale_config/cloak/veil
	greyscale_config_worn = /datum/greyscale_config/cloak/veil/worn

/obj/item/clothing/neck/cloak/colourable/boat
	name = "colourable boatcloak"
	icon_state = "/obj/item/clothing/neck/cloak/colourable/boat"
	post_init_icon_state = "gags_boat"
	greyscale_config = /datum/greyscale_config/cloak/boat
	greyscale_config_worn = /datum/greyscale_config/cloak/boat/worn

/obj/item/clothing/neck/cloak/colourable/shroud
	name = "colourable shroud"
	icon_state = "/obj/item/clothing/neck/cloak/colourable/shroud"
	post_init_icon_state = "gags_shroud"
	greyscale_config = /datum/greyscale_config/cloak/shroud
	greyscale_config_worn = /datum/greyscale_config/cloak/shroud/worn

/**************CKEY EXCLUSIVES*************/

// Donation reward for Grunnyyy
/obj/item/clothing/suit/jacket/ryddid
	name = "Ryddid"
	desc = "Uma velha peça desgastada de roupa pertencente a um certo pequeno demônio."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "darkcoat"
	inhand_icon_state = "greatcoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

// Donation reward for Grunnyyy
/obj/item/clothing/neck/cloak/grunnyyy
	name = "black and red cloak"
	desc = "O design disso parece um pouco familiar."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	icon_state = "infcloak"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	supports_variations_flags = NONE

// Donation reward for Thedragmeme
// might make it have some flavour functionality in future, a'la rewritable piece of paper - JOKES ON YOU I'M MAKING IT DRAW
/obj/item/canvas/drawingtablet
	name = "drawing tablet"
	desc = "Um tablet portátil que permite desenhar. Lendas dizem que isso pode ganhar uma fortuna para o dono em alguns setores do espaço."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	icon_state = "drawingtablet"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	inhand_icon_state = "electronic"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_TINY
	actions_types = list(/datum/action/item_action/dtselectcolor,/datum/action/item_action/dtcolormenu,/datum/action/item_action/dtcleargrid)
	pixel_x = 0
	pixel_y = 0
	width = 28
	height = 26
	nooverlayupdates = TRUE
	var/currentcolor = "#ffffff"
	var/list/colors = list("Eraser" = "#ffffff")

/obj/item/canvas/drawingtablet/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/dtselectcolor))
		currentcolor = tgui_color_picker(user, "", "Choose Color", currentcolor)
	else if(istype(action, /datum/action/item_action/dtcolormenu))
		var/list/selects = colors.Copy()
		selects["Save"] = "Save"
		selects["Delete"] = "Delete"
		var/selection = input(user, "", "Menu Cor", currentcolor) as null|anything in selects
		if(QDELETED(src) || !user.can_perform_action(src))
			return
		switch(selection)
			if("Save")
				var/name = input(user, "", "Diga a cor!", "Pastel Purple") as text|null
				if(name)
					colors[name] = currentcolor
			if("Delete")
				var/delet = input(user, "", "Menu Cor", currentcolor) as null|anything in colors
				if(delet)
					colors.Remove(delet)
			if(null)
				return
			else
				currentcolor = colors[selection]
	else if(istype(action, /datum/action/item_action/dtcleargrid))
		var/yesnomaybe = tgui_alert(user, "Tem certeza que quer limpar a tela?", "", list("Yes", "No", "Maybe"))
		if(QDELETED(src) || !user.can_perform_action(src))
			return
		switch(yesnomaybe)
			if("Yes")
				workspace = new(width,
					height,
					color_mode = SPRITE_EDITOR_COLOR_MODE_RGB,
					config_flags = NONE,
					tool_flags = SPRITE_EDITOR_TOOL_PENCIL | SPRITE_EDITOR_TOOL_BUCKET,
					initial_layer_color = "[canvas_color]ff" // To avoid needing to handle strings of mixed lengths, sprite editor workspaces always use the alpha channel
				)
				SStgui.update_uis(src)
			if("No")
				return
			if("Maybe")
				playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 50, FALSE)
				audible_message(span_warning("O[src]Buzzes!"))
				return

/obj/item/canvas/drawingtablet/get_paint_tool_color()
	return currentcolor

/obj/item/canvas/drawingtablet/finalize()
	return // no finalizing this piece

/obj/structure/sign/painting/frame_canvas(mob/user,obj/item/canvas/new_canvas)
	if(istype(new_canvas, /obj/item/canvas/drawingtablet)) // NO FINALIZING THIS BITCH.
		return FALSE
	else
		return ..()

/obj/item/canvas/var/nooverlayupdates = FALSE

/obj/item/canvas/update_overlays()
	if(nooverlayupdates)
		return
	. = ..()

/datum/action/item_action/dtselectcolor
	name = "Change Color"
	desc = "Mude sua cor."
	button_icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	button_icon_state = "drawingtablet"

/datum/action/item_action/dtcolormenu
	name = "Color Menu"
	desc = "Selecione, salve ou apague uma cor no menu de cores do seu tablet!"
	button_icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	button_icon_state = "drawingtablet"

/datum/action/item_action/dtcleargrid
	name = "Clear Canvas"
	desc = "Limpe a tela do seu tablet de desenho."
	button_icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	button_icon_state = "drawingtablet"

// Donation reward for Thedragmeme
/obj/item/clothing/suit/furcoat
	name = "leather coat"
	desc = "Um casaco de couro grosso e confortável. Tem pele macia no colarinho e mangas."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "furcoat"
	inhand_icon_state = "hostrench"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	supports_variations_flags = NONE

// Donation reward for Thedragmeme
/obj/item/clothing/under/syndicate/tacticool/black
	name = "black turtleneck"
	desc = "Tacticool como fug. Confortável também."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "black_turtleneck"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	supports_variations_flags = NONE
	armor_type = /datum/armor/clothing_under
	can_adjust = FALSE //There wasnt an adjustable sprite anyways
	has_sensor = HAS_SENSORS	//Actually has sensors, to balance the new lack of armor

// Donation reward for Bloodrite
/obj/item/clothing/shoes/clown_shoes/britches
	desc = "Os sapatos de palhaço padrão do brincalhão. Eles parecem extraordinariamente bonitos. Ctrl-click para alternar amortecedores."
	name = "Britches' shoes"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/feet.dmi'
	icon_state = "clown_shoes_cute"
	supports_variations_flags = NONE
	resistance_flags = FIRE_PROOF

// Donation reward for Bloodrite
/obj/item/clothing/under/rank/civilian/clown/britches
	name = "Britches' dress"
	desc = "<i>HONK!</i>"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "clowndress"
	supports_variations_flags = NONE
	resistance_flags = FIRE_PROOF

// Donation reward for Bloodrite
/obj/item/clothing/mask/gas/britches
	name = "Britches' mask"
	desc = "O traje facial de um verdadeiro brincalhão. Bonito."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask.dmi'
	icon_state = "cute_mask"
	inhand_icon_state = null
	dye_color = "clown"
	supports_variations_flags = NONE
	clothing_flags = MASKINTERNALS
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = MASKCOVERSEYES
	resistance_flags = FIRE_PROOF

/******CALIGRA DONATIONS******/
// NOTE: Caligram is being renamed to Blacktide Mercenary Fleet. I'll be reflavoring them to that, with the Molerats/Dustworld stuff coming in its own unique PR later

// Donation reward for Farsighted Nightlight
/obj/item/clothing/mask/gas/nightlight
	name = "\improper BT-36 respirator"
	desc = "Um respirador de combate projetado por Blacktide para seu contingente original de recrutas humanóides. Sujo e preto."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask.dmi'
	icon_state = "fir36"
	actions_types = list(/datum/action/item_action/adjust)
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS //same flags as actual sec hailer gas mask
	flags_inv = HIDESNOUT
	flags_cover = NONE
	visor_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	visor_flags_inv = HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL
	tint = 0
	interaction_flags_click = NEED_DEXTERITY

/obj/item/clothing/mask/gas/nightlight/attack_self(mob/user)
	adjust_visor(user)

/obj/item/clothing/mask/gas/nightlight/click_alt(mob/user)
	adjust_visor(user)
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/mask/gas/nightlight/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click[src]para ajustar.")

/obj/item/clothing/mask/gas/nightlight/alldono //different itempath so regular donators can have it, too

// Donation reward for Farsighted Nightlight
/obj/item/clothing/mask/gas/nightlight/fir22
	name = "\improper BT-22 extended respirator"
	desc = "Uma variante no respirador BT-36 com um visor estendido, desenvolvido para caber em recrutas Blacktide com focinhos mais longos. Tão elegante e negro quanto seu irmão mais velho."
	icon_state = "fir22"

// Donation reward for Raxraus
/obj/item/clothing/head/caligram_cap_tan
	name = "\improper Blacktide softcap"
	desc = "Um softcap, feito para Blacktide para operar em todos os ambientes, vem em bronzeado e uma variante azul de bom gosto."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "caligram_cap_tan"

/obj/item/clothing/head/caligram_cap_tan/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/caligram_cap)

/datum/atom_skin/caligram_cap
	abstract_type = /datum/atom_skin/caligram_cap

/datum/atom_skin/caligram_cap/tan
	preview_name = "Tan Variant"
	new_icon_state = "caligram_cap_tan"

/datum/atom_skin/caligram_cap/blue
	preview_name = "Blue Variant"
	new_icon_state = "caligram_cap_blue"

// Donation reward for Raxraus
/obj/item/clothing/under/jumpsuit/caligram_fatigues_tan
	name = "\improper Blacktide fatigues"
	desc = "Um conjunto de fadigas desenvolvido por Blacktide para seus operadores, projetado para todos os ambientes. Vem em uma variante marrom e azul de bom gosto."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	icon_state = "caligram_fatigues_tan"
	worn_icon_state = "caligram_fatigues_tan"

/obj/item/clothing/under/jumpsuit/caligram_fatigues_tan/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/caligram_fatigues)

/datum/atom_skin/caligram_fatigues
	abstract_type = /datum/atom_skin/caligram_fatigues

/datum/atom_skin/caligram_fatigues/tan
	preview_name = "Tan Variant"
	new_icon_state = "caligram_fatigues_tan"

/datum/atom_skin/caligram_fatigues/blue
	preview_name = "Blue Variant"
	new_icon_state = "caligram_fatigues_blue"

// Donation reward for Raxraus
/obj/item/clothing/suit/jacket/caligram_parka_tan
	name = "\improper Blacktide coat"
	desc = "Um casaco com faixa preta e \"Blacktide Mercenary Corps\" costurado na braçadeira. Vem em variantes azul, azul e azul."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "caligram_parka_tan"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS|HANDS

/obj/item/clothing/suit/jacket/caligram_parka_tan/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/caligram_parka)

/datum/atom_skin/caligram_parka
	abstract_type = /datum/atom_skin/caligram_parka

/datum/atom_skin/caligram_parka/tan
	preview_name = "Tan Variant"
	new_icon_state = "caligram_parka_tan"

/datum/atom_skin/caligram_parka/blue
	preview_name = "Blue Variant"
	new_icon_state = "caligram_parka_blue"

/datum/atom_skin/caligram_parka/blue_patchless
	preview_name = "Blue Patchless Variant"
	new_icon_state = "caligram_parka_patchless_blue"

// Donation reward for Raxraus
/obj/item/clothing/suit/armor/vest/caligram_parka_vest_tan
	name = "\improper Blacktide armored coat"
	desc = "Um casaco com faixa preta, um colete levemente blindado e '/Blacktide Mercenary Corps/' costurado em sua braçadeira. Vem em variantes azul e bronzeada."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "caligram_parka_vest_tan"
	inhand_icon_state = "armor"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS|HANDS

/obj/item/clothing/suit/armor/vest/caligram_parka_vest_tan/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/caligram_parka_vest)

/datum/atom_skin/caligram_parka_vest
	abstract_type = /datum/atom_skin/caligram_parka_vest

/datum/atom_skin/caligram_parka_vest/tan
	preview_name = "Tan Variant"
	new_icon_state = "caligram_parka_vest_tan"

/datum/atom_skin/caligram_parka_vest/blue
	preview_name = "Blue Variant"
	new_icon_state = "caligram_parka_vest_blue"

// Donation reward for ChillyLobster
/obj/item/clothing/suit/jacket/brasspriest
	name = "brasspriest coat"
	desc = "Um casaco avermelhado com partes de latão embutidas no mesmo casaco. Você pode ouvir o barulho fraco de algumas engrenagens girando de vez em quando dentro."
	icon_state = "brasspriest"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS

// Donation reward for ChillyLobster
/obj/item/clothing/suit/jacket/hydrogenrobes
	name = "metallic-hydrogen robes"
	desc = "Um vestido incrivelmente brilhante que parece estar coberto com uma fina folha de hidrogênio metálico em todos os tecidos. Não é muito protetor."
	icon_state = "hydrogenrobes"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'

// Donation reward for ChillyLobster

/obj/item/clothing/under/wetsuit_norm
	name = "fitted wetsuit"
	desc = "Um traje de mergulho para prender no calor e na água. Protege contra elementos externos sempre tão leves."
	icon_state = "wetsuit"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	armor_type = /datum/armor/clothing_under/wetsuit
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	can_adjust = FALSE
	female_sprite_flags = NO_FEMALE_UNIFORM
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

// Donation reward for TheOOZ
/obj/item/clothing/mask/animal/wolf
	name = "wolf mask"
	desc = "Uma máscara escura na forma da cabeça de um lobo."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/masks.dmi'
	icon_state = "kindle"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask.dmi'
	inhand_icon_state = "gasmask_captain"
	animal_type = "wolf"
	unique_death = 'modular_skyrat/master_files/sound/effects/wolfhead_curse.ogg'
	visor_flags_inv = HIDEFACIALHAIR | HIDESNOUT
	flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	visor_flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	clothing_flags = VOICEBOX_DISABLED | MASKINTERNALS | BLOCK_GAS_SMOKE_EFFECT | GAS_FILTERING
	alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER
	use_radio_beeps_tts = TRUE

/obj/item/clothing/mask/animal/wolf/Initialize(mapload)
	. = ..()
	var/obj/item/clothing/mask/gas/sechailer/sechailer_type = /obj/item/clothing/mask/gas/sechailer
	voice_filter = initial(sechailer_type.voice_filter)

// Donation reward for Random516
/obj/item/clothing/head/drake_skull
	name = "skull of an ashdrake"
	desc = "Como conseguiram isso?"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	icon_state = "drake_skull"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/large-worn-icons/32x64/head.dmi'
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	supports_variations_flags = NONE

// Donation reward for Random516
/obj/item/clothing/gloves/fingerless/blutigen_wraps
	name = "Blutigen wraps"
	desc = "Aquele que usa isso tinha tudo e ainda assim perdeu tudo..."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/gloves.dmi'
	icon_state = "blutigen_wraps"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/hands.dmi'

// Donation reward for Random516
/obj/item/clothing/suit/blutigen_kimono
	name = "Blutigen kimono"
	desc = "Pois os olhos concedidos a isso procurarão aventura..."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	icon_state = "blutigen_kimono"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = NONE

// Donation reward for Random516
/obj/item/clothing/under/custom/blutigen_undergarment
	name = "Dragon undergarments"
	desc = "O Dragão usa o sexy?"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "blutigen_undergarment"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	supports_variations_flags = NONE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/gloves/ring/hypno
	var/list/spans = list()
	actions_types = list(/datum/action/item_action/hypno_whisper)

// Donation reward for CoffeePot
/obj/item/clothing/gloves/ring/hypno/coffeepot
	name = "hypnodemon's ring"
	desc = "Um anel de ouro pálido e levemente dessaturado que não parece pertencer. É difícil colocar o dedo em porque ele se sente em desacordo com o mundo ao redor dele - o brilho saindo parece que pode ser um descompasso com a iluminação na sala, ou pode ser que ele parece brilhar e brilhar ocasionalmente quando não há nenhuma razão óbvia para isso - embora só quando você não está realmente olhando."
	spans = list("velvet")

// Donation reward for Bippys
/obj/item/clothing/gloves/ring/hypno/bippys
	name = "hypnobot hexnut"
	desc = "Um componente de parafusos de prata que já pertenceu a um IPC muito peculiar. É grande o suficiente para ser usado como um anel em quase qualquer dedo, e diz-se que amplifica a voz de uma mente para outra na suavidade de um Sussurro..."
	icon_state = "ringsilver"
	worn_icon_state = "sring"
	spans = list("hexnut")

/datum/action/item_action/hypno_whisper
	name = "Hypnotic Whisper"

/obj/item/clothing/gloves/ring/hypno/ui_action_click(mob/living/user, action)
	if(!isliving(user) || !can_use(user))
		return
	var/message = input(user, "Fale com um sussurro hipnótico", "Whisper")
	if(QDELETED(src) || QDELETED(user) || !message || !user.can_speak())
		return
	user.whisper(message, spans = spans)

// Donation reward for SlippyJoe
/obj/item/clothing/head/avipilot
	name = "smuggler's flying cap"
	desc = "Chocantemente, apesar dos ventos espaciais, e da falta de prática, este boné de piloto parece estar bastante bem de pé, há uma cabeça de coelho aparentemente estampada no lado dele."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "avipilotup"
	inhand_icon_state = "rus_ushanka"
	flags_inv = HIDEHAIR
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT //about as warm as an ushanka
	actions_types = list(/datum/action/item_action/adjust)
	supports_variations_flags = NONE
	var/goggles = FALSE

/obj/item/clothing/head/avipilot/proc/adjust_goggles(mob/living/carbon/user)
	if(user?.incapacitated)
		return
	if(goggles)
		icon_state = "avipilotup"
		to_chat(user, span_notice("Você se esforçou para puxar os óculos."))
	else
		icon_state = "avipilotdown"
		to_chat(user, span_notice("Concentre toda sua força de vontade para colocar os óculos em seus olhos."))
	goggles = !goggles
	if(user)
		user.update_worn_head()
		user.update_mob_action_buttons()

/obj/item/clothing/head/avipilot/ui_action_click(mob/living/carbon/user, action)
	adjust_goggles(user)

/obj/item/clothing/head/avipilot/attack_self(mob/living/carbon/user)
	adjust_goggles(user)

// Donation reward for NetraKyram - public use allowed via the command vendor
/obj/item/clothing/under/rank/captain/dress
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	name = "captain's dress"
	desc = "É um vestido azul com algumas marcas de ouro desgastadas denotando a patente de\"Capitão.\"."
	icon_state = "dress_cap_s"
	worn_icon_state = "dress_cap_s"
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE

// Donation reward for NetraKyram
/obj/item/clothing/under/rank/blueshield/netra
	name = "black and silver armored dress"
	desc = "Um vestido preto e prateado de tornozelo, feito de material sintético brilhante com cacos de kevlar embutidos e reforços prateados, um anel de prata envolve o colarinho, e não parece ter um zíper... Como alguém coloca essa coisa?"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "silver_dress"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = null
	supports_variations_flags = NONE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

// Donation reward for NetraKyram
/obj/item/clothing/gloves/netra
	name = "black and silver gloves"
	desc = "Luvas pretas com reforços prateados, feitas de material sintético brilhante."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/gloves.dmi'
	icon_state = "silver_dress_gloves"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/hands.dmi'

// Donation reward for NetraKyram
/obj/item/clothing/shoes/jackboots/netra
	name = "polished jackboots"
	desc = "Algumas botas de borracha padrão, com um brilho reflexivo, causando o cheiro de esmalte de silicone."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/shoes.dmi'
	icon_state = "silver_dress_boots"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/feet.dmi'
	supports_variations_flags = NONE


/****************LEGACY REWARDS***************/
// Donation reward for inferno707
/obj/item/clothing/neck/cloak/inferno
	name = "Kiara's cloak"
	desc = "O design disso parece um pouco familiar."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	icon_state = "infcloak"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN|LEGS|ARMS

// Donation reward for inferno707
/obj/item/clothing/neck/inferno_collar
	name = "Kiara's collar"
	desc = "Um colarinho preto macio que parece se esticar para caber em quem o usa."
	icon_state = "infcollar"
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	alternate_worn_layer = UNDER_SUIT_LAYER
	kink_collar = TRUE
	/// What's the name on the tag, if any?
	var/tagname = null
	/// What treat item spawns inside the collar?
	var/treat_path = /obj/item/food/cookie

/obj/item/clothing/neck/inferno_collar/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/small/collar)
	if(treat_path)
		new treat_path(src)

/obj/item/clothing/neck/inferno_collar/attack_self(mob/user)
	tagname = stripped_input(user, "Would you like to change the name on the tag?", "Name your new pet", "Kiara", MAX_NAME_LEN)
	if(tagname)
		name = "[initial(name)] - [tagname]"

// Donation reward for inferno707
/obj/item/clothing/accessory/medal/steele
	name = "Insignia Of Steele"
	desc = "Um pendente intrincado dado a quem ajuda um membro chave da Steele Corporation."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	icon_state = "steele"
	medaltype = "medal-silver"

// Donation reward for inferno707
/obj/item/toy/darksabre
	name = "Kiara's sabre"
	desc = "Esta lâmina parece tão perigosa quanto seu dono."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	icon_state = "darksabre"
	lefthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_right.dmi'

/obj/item/toy/darksabre/get_belt_overlay()
	return mutable_appearance('modular_skyrat/master_files/icons/donator/obj/custom.dmi', "darksheath-darksabre")

// Donation reward for inferno707
/obj/item/storage/belt/sheath/sabre/darksabre
	name = "ornate sheathe"
	desc = "Um ornamentado e bastante sinistro olhando sabre sheathe."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	icon_state = "sheath"
	worn_icon_state = "sheath"
	stored_blade = /obj/item/toy/darksabre

/obj/item/storage/belt/sheath/sabre/darksabre/Initialize(mapload)
	. = ..()
	atom_storage.set_holdable(list(
		/obj/item/toy/darksabre
		))

// Donation reward for inferno707
/obj/item/clothing/suit/armor/vest/darkcarapace
	name = "dark armor"
	desc = "Uma armadura escura, não-funcional, com acabamento vermelho e preto."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	icon_state = "darkcarapace"
	blood_overlay_type = "armor"
	dog_fashion = /datum/dog_fashion/back
	supports_variations_flags = NONE
	armor_type = /datum/armor/none

// Donation reward for inferno707
/obj/item/clothing/mask/hheart
	name = "Hollow Heart"
	desc = "É uma máscara de cerâmica estranha. No lado interno estão vários eletrônicos suspeitos marcados pela Steele Tech."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/masks.dmi'
	icon_state = "hheart"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask.dmi'
	var/c_color_index = 1
	var/list/possible_colors = list("off", "blue", "red")
	actions_types = list(/datum/action/item_action/hheart)
	supports_variations_flags = NONE

/obj/item/clothing/mask/hheart/Initialize(mapload)
	. = ..()
	update_icon()

/obj/item/clothing/mask/hheart/update_icon()
	. = ..()
	icon_state = "hheart-[possible_colors[c_color_index]]"

/datum/action/item_action/hheart
	name = "Toggle Mode"
	desc = "Alternar a cor do coração oco."

/obj/item/clothing/mask/hheart/ui_action_click(mob/user, action)
	. = ..()
	if(istype(action, /datum/action/item_action/hheart))
		if(!isliving(user))
			return
		var/mob/living/ooser = user
		var/the = possible_colors.len
		var/index = 0
		if(c_color_index >= the)
			index = 1
		else
			index = c_color_index + 1
		c_color_index = index
		update_icon()
		ooser.update_worn_mask()
		ooser.update_mob_action_buttons()
		to_chat(ooser, span_notice("Você muda o[src]para[possible_colors[c_color_index]]."))

// Donation reward for asky / Zulie
/obj/item/clothing/suit/hooded/cloak/zuliecloak
	name = "Project: Zul-E"
	desc = "Uma versão padrão de um protótipo de camuflagem dada por Nanotrasen. É surpreendentemente grosso e pesado para uma capa apesar de ter a maior parte da tecnologia despida. Ele também vem com uma bugiganga do espaço azul que chama de chapéu acompanhando o usuário. Uma inscrição desgastada no interior da capa diz 'Fleuret' ... o resto está desaparecido."
	icon_state = "zuliecloak"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/cloaks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/neck.dmi'
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/zuliecloak
	body_parts_covered = CHEST|GROIN|ARMS
	slot_flags = ITEM_SLOT_OCLOTHING | ITEM_SLOT_NECK //it's a cloak. it's cosmetic. so why the hell not? what could possibly go wrong?
	supports_variations_flags = NONE

/obj/item/clothing/head/hooded/cloakhood/zuliecloak
	name = "NT special issue"
	desc = "Este chapéu é inquestionavelmente o melhor, azul espaçado para e da CentCom. Cheira a peixe e chá com uma pitada de antagonismo."
	icon_state = "zuliecap"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/cloaks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/neck.dmi'
	flags_inv = null
	supports_variations_flags = NONE

// Donation reward for Lyricalpaws
/obj/item/clothing/neck/cloak/healercloak
	name = "legendary healer's cloak"
	desc = "Usado pelos médicos profissionais mais qualificados da estação, esta capa lendária só é alcançável tornando-se o ápice da cura. Este símbolo representa que o usuário passou anos aperfeiçoando sua habilidade de ajudar os doentes e feridos."
	icon_state = "healercloak"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/cloaks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/neck.dmi'

// Donation reward for Kathrin Bailey / Floof Ball
/obj/item/clothing/under/custom/lannese
	name = "Lannese dress"
	desc = "Uma roupa cultural alienígena para mulheres, vindo de um planeta distante chamado Cantalan."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "lannese"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	inhand_icon_state = "firefighter"
	can_adjust = TRUE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN|LEGS|FEET

/obj/item/clothing/under/custom/lannese/vambrace
	desc = "Uma roupa cultural alienígena para mulheres, vindo de um planeta distante chamado Cantalan. Vagabundos brilhantes incluídos!"
	icon_state = "lannese_vambrace"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|FEET

// Donation reward for Hacker T.Dog
/obj/item/clothing/suit/scraparmour
	name = "scrap armour"
	desc = "Uma peça de armadura bem trabalhada. Não traz benefício além de ser desajeitado."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	icon_state = "scraparmor"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	worn_icon_state = "scraparmor"
	body_parts_covered = CHEST

// Donation reward for Enzoman
/obj/item/clothing/mask/luchador/enzo
	name = "mask of El Red Templar"
	desc = "Uma máscara pertencente a El Templário Vermelho, um guerreiro de lucha. Tirar dele não é recomendado."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask.dmi'
	icon_state = "luchador"
	worn_icon_state = "luchador"
	clothing_flags = MASKINTERNALS
	supports_variations_flags = NONE

// Donation Reward for Grand Vegeta
/obj/item/clothing/under/mikubikini
	name = "starlight singer bikini"
	desc = " "
	icon_state = "mikubikini"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_state = "mikubikini"
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

// Donation Reward for Grand Vegeta
/obj/item/clothing/suit/mikujacket
	name = "starlight singer jacket"
	desc = " "
	icon_state = "mikujacket"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	worn_icon_state = "mikujacket"

// Donation Reward for Grand Vegeta
/obj/item/clothing/head/mikuhair
	name = "starlight singer hair"
	desc = " "
	icon_state = "mikuhair"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	worn_icon_state = "mikuhair"
	flags_inv = HIDEHAIR

// Donation Reward for Grand Vegeta
/obj/item/clothing/gloves/mikugloves
	name = "starlight singer gloves"
	desc = " "
	icon_state = "mikugloves"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/hands.dmi'
	worn_icon_state = "mikugloves"

// Donation Reward for Grand Vegeta
/obj/item/clothing/shoes/sneakers/mikuleggings
	name = "starlight singer leggings"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	desc = " "
	icon_state = "mikuleggings"
	post_init_icon_state = null
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/feet.dmi'
	worn_icon_state = "mikuleggings"

// Donation reward for CandleJax
/obj/item/clothing/head/helmet/space/plasmaman/candlejax
	name = "emission's helmet"
	desc = "Um capacete de contenção especial projetado para uso pesado. Vários dings e entalhes estão nessa."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "emissionhelm"
	visor_icon = "emissionhelm-envisor"

// Donation reward for CandleJax
/obj/item/clothing/head/helmet/space/plasmaman/candlejax2
	name = "azulean's environment helmet"
	desc = "Um Enviro-Helmet feito azuleano, ajustado para a forma única do crânio típica da espécie. Juntamente com as características padrão, inclui uma gravação do Crest Azuliano na parte de trás do capacete."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "anahead"
	visor_icon = "anahead-envisor"

// Donation reward for CandleJax
/obj/item/clothing/under/plasmaman/candlejax
	name = "emission's containment suit"
	desc = "Um ambiente modificado com um esquema de cores reservado."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'
	icon_state = "emissionsuit"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

// Donation reward for CandleJax
/obj/item/clothing/under/plasmaman/candlejax2
	name = "azulean's environment suit"
	desc = "Um Enviro-Suit feito azuleano. Ajustado à forma azuleana, ele tem tecido de contenção excedente projetado para dar a massa solidificada de plasma que já foi uma cauda alguma sala de respiração."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "ana_envirosuit"

// Donation reward for CandleJax
/obj/item/clothing/under/plasmaman/jax2
	name = "xuracorp hazard underfitting"
	desc = "Um traje de perigo equipado com fibras biorresistentes. Utiliza bombas autoesterilizantes instaladas na parte de trás."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'
	icon_state = "plasmaman_jax"

// Donation reward for Raxraus
/obj/item/clothing/shoes/jackboots/peacekeeper/armadyne/rax
	name = "tactical boots"
	desc = "Tático e elegante. Este modelo parece ser do Armadyne."

// Donation reward for Raxraus
/obj/item/clothing/suit/armor/vest/warden/rax
	name = "peacekeeper jacket"
	desc = "Uma jaqueta azul-marinho blindada com designações de ombro azul."

// Donation reward for Raxraus
/obj/item/clothing/under/rank/security/rax
	name = "banded uniform"
	desc = "Personalizado e adaptado para caber, este uniforme é projetado para proteger sem comprometer sua elegância."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	icon_state = "hos_black"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

// Donation reward for DeltaTri
/obj/item/clothing/suit/jacket/delta
	name = "grey winter hoodie"
	desc = "Um casaco cinza. Tem um sopro por dentro, e um pêlo de animal corta em torno de metade do capô."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "greycoat"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

// Donation reward for Cherno_00
/obj/item/clothing/suit/jacket/cherno
	name = "silver-buttoned coat"
	desc = "Um casaco azul confortável. Parece um pouco chique, com botões de prata brilhantes e alguns cintos!"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "chernocoat"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

// Donation reward for GoldenAlpharex
/obj/item/clothing/glasses/welding/steampunk_goggles
	name = "steampunk goggles"
	desc = "Isso realmente parece algo que se espera ver sentado em cima da cabeça de um certo gengibre... Eles têm um corte de latão bastante chique em torno das lentes."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/eyes.dmi'
	icon_state = "goldengoggles"
	slot_flags = ITEM_SLOT_EYES | ITEM_SLOT_HEAD // Making it fit in both first just so it can properly fit on the head slot in the loadout
	flash_protect = FLASH_PROTECTION_NONE
	flags_cover = GLASSESCOVERSEYES
	custom_materials = null // Don't want that to go in the autolathe
	visor_vars_to_toggle = 0
	tint = 0

	/// Was welding protection added yet?
	var/welding_upgraded = FALSE
	/// Was welding protection toggled on, if welding_upgraded is TRUE?
	var/welding_protection = FALSE
	/// The sound played when toggling the shutters.
	var/shutters_sound = 'sound/effects/clock_tick.ogg'

/obj/item/clothing/glasses/welding/steampunk_goggles/Initialize(mapload)
	. = ..()
	visor_toggling()

/obj/item/clothing/glasses/welding/steampunk_goggles/examine(mob/user)
	. = ..()
	if(welding_upgraded)
		. += "It has been upgraded with welding shutters, which are currently [welding_protection ? "closed" : "opened"]."

/obj/item/clothing/glasses/welding/steampunk_goggles/item_action_slot_check(slot, mob/user)
	. = ..()
	if(. && (slot & ITEM_SLOT_HEAD))
		return FALSE

/obj/item/clothing/glasses/welding/steampunk_goggles/attack_self(mob/user)
	if(user.get_item_by_slot(ITEM_SLOT_HEAD) == src)
		to_chat(user, span_warning("Você não consegue deslizá-los do topo da cabeça!"))
		return
	. = ..()

/obj/item/clothing/glasses/welding/steampunk_goggles/visor_toggling()
	. = ..()
	slot_flags = up ? ITEM_SLOT_EYES | ITEM_SLOT_HEAD : ITEM_SLOT_EYES
	toggle_vision_effects()

/obj/item/clothing/glasses/welding/steampunk_goggles/adjust_visor(mob/user)
	. = ..()
	handle_sight_updating(user)

/obj/item/clothing/glasses/welding/steampunk_goggles/attackby(obj/item/attacking_item, mob/living/user, params)
	if(!istype(attacking_item, /obj/item/clothing/glasses/welding))
		return ..()

	if(welding_upgraded)
		to_chat(user, span_warning("\The [src]Já foi atualizado para ter proteção de soldagem!"))
		return
	qdel(attacking_item)
	welding_upgraded = TRUE
	to_chat(user, span_notice("Você se atualiza.\the [src]com alguns obturadores de solda, oferecendo-lhe a capacidade de alternar proteção de solda!"))
	actions += new /datum/action/item_action/toggle_steampunk_goggles_welding_protection(src)

/// Proc that handles the whole toggling the welding protection on and off, with user feedback.
/obj/item/clothing/glasses/welding/steampunk_goggles/proc/toggle_shutters(mob/user)
	if(!can_use(user) || !user)
		return FALSE
	if(!toggle_welding_protection(user))
		return FALSE

	to_chat(user, span_notice("Você desliza.\the [src]'s soldando persianas deslizantes,[welding_protection ? "closing" : "opening"]Eles."))
	playsound(user, shutters_sound, 100, TRUE)
	if(iscarbon(user))
		var/mob/living/carbon/carbon_user = user
		carbon_user.update_worn_head()
	update_item_action_buttons()
	return TRUE

/// This is the proc that handles toggling the welding protection, while also making sure to update the sight of a mob wearing it.
/obj/item/clothing/glasses/welding/steampunk_goggles/proc/toggle_welding_protection(mob/user)
	if(!welding_upgraded)
		return FALSE
	welding_protection = !welding_protection

	visor_vars_to_toggle = welding_protection ? VISOR_FLASHPROTECT | VISOR_TINT : initial(visor_vars_to_toggle)
	toggle_vision_effects()
	// We also need to make sure the user has their vision modified. We already checked that there was a user, so this is safe.
	handle_sight_updating(user)
	return TRUE

/// Proc handling changing the flash protection and the tint of the goggles.
/obj/item/clothing/glasses/welding/steampunk_goggles/proc/toggle_vision_effects()
	if(welding_protection)
		if(visor_vars_to_toggle & VISOR_FLASHPROTECT)
			flash_protect = up ? FLASH_PROTECTION_NONE : FLASH_PROTECTION_WELDER
	else
		flash_protect = FLASH_PROTECTION_NONE
	tint = flash_protect

/// Proc handling to update the sight of the user, while forcing an update_tint() call every time, due to how the welding protection toggle works.
/obj/item/clothing/glasses/welding/steampunk_goggles/proc/handle_sight_updating(mob/user)
	if(user && (user.get_item_by_slot(ITEM_SLOT_HEAD) == src || user.get_item_by_slot(ITEM_SLOT_EYES) == src))
		user.update_sight()
		if(iscarbon(user))
			var/mob/living/carbon/carbon_user = user
			carbon_user.update_tint()
			carbon_user.update_worn_head()

/obj/item/clothing/glasses/welding/steampunk_goggles/ui_action_click(mob/user, actiontype, is_welding_toggle = FALSE)
	if(!is_welding_toggle)
		return ..()
	else
		toggle_shutters(user)

/// Action button for toggling the welding shutters (aka, welding protection) on or off.
/datum/action/item_action/toggle_steampunk_goggles_welding_protection
	name = "Toggle Welding Shutters"

/// We need to do a bit of code duplication here to ensure that we do the right kind of ui_action_click(), while keeping it modular.
/datum/action/item_action/toggle_steampunk_goggles_welding_protection/Trigger(trigger_flags)
	if(!..())
		return FALSE
	if(!target || !istype(target, /obj/item/clothing/glasses/welding/steampunk_goggles))
		return FALSE

	var/obj/item/clothing/glasses/welding/steampunk_goggles/goggles = target
	goggles.ui_action_click(owner, src, is_welding_toggle = TRUE)
	return TRUE

// End of the code for GoldenAlpharex's donator item :^)

// Donation reward for MyGuy49
/obj/item/clothing/suit/cloak/ashencloak
	name = "ashen wastewalker cloak"
	desc = "Um manto de marca avançada. Claramente além do que os Ashwalkers são capazes, provavelmente foi retirado de um navio abatido ou algo assim. Parece ter sido reforçada com couro golias e tenacidade, e o capuz foi arrancado."
	icon_state = "ashencloak"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	body_parts_covered = CHEST|LEGS|ARMS
	supports_variations_flags = NONE

//Donation reward for Hacker T.Dog
/obj/item/clothing/head/nanotrasen_consultant/hubert
	name = "CC ensign's cap"
	desc = "Um alfaiate fez um boné alto, denotando o posto de alferes."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "CCofficerhat"

//Donation reward for Hacker T.Dog
/obj/item/clothing/suit/armor/vest/nanotrasen_consultant/hubert
	name = "CC ensign's armoured vest"
	desc = "Um alfaiate fez o colete blindado do Alferes, proporcionando a mesma proteção, mas de uma forma mais elegante."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "CCvest"

//Donation reward for Hacker T.Dog
/obj/item/clothing/under/rank/nanotrasen_consultant/hubert
	name = "CC ensign's uniform"
	desc = "Um uniforme de alferes feito sob medida, várias medalhas e correntes pendem dele."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'
	icon_state = "CCofficer"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

// Donation reward for Cherno_00
/obj/item/clothing/head/costume/ushanka/frosty
	name = "blue ushanka"
	desc = "Um ushanka azul escuro com um floco de neve costurado à mão na frente. Tranquilo ao toque."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "fushankadown"
	upsprite = "fushankaup"
	downsprite = "fushankadown"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null

// Donation reward for M97screwsyourparents
/obj/item/clothing/neck/cross
	name = "silver cross"
	desc = "Uma cruz de prata para ser usada em uma corrente ao redor do seu pescoço. Certeza de trazer favores de cima."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/necklaces.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/neck.dmi'
	icon_state = "cross"

// Donation reward for gamerguy14948
/obj/item/storage/belt/fannypack/occult
	name = "trinket belt"
	desc = "Um cinto coberto de várias bugigangas coletadas através do tempo. Parece que não há muito espaço para mais nada hoje em dia."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/belt.dmi'
	icon_state = "occultfannypack"
	worn_icon_state = "occultfannypack"

// Donation reward for gamerguy14948
/obj/item/clothing/under/occult
	name = "occult collector's outfit"
	desc = "Roupas adequadas para alguém elegante que não tem medo de se sujar."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "occultoutfit"
	supports_variations_flags = NONE

// Donation reward for gamerguy14948
/obj/item/clothing/head/hooded/occult
	name = "hood"
	desc = "Certamente faz você parecer mais ameaçador."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "occulthood"
	supports_variations_flags = NONE

// Donation reward for gamerguy14948
/obj/item/clothing/suit/hooded/occult
	name = "occult collector's coat"
	desc = "Um grande casaco revestido de couro e pano de marfim, adornado com um capuz. Parece empoeirado."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "occultcoat"
	hoodtype = /obj/item/clothing/head/hooded/occult
	supports_variations_flags = NONE

// Donation reward for Octus
/obj/item/clothing/mask/breath/vox/octus
	name = "sinister visor"
	desc = "Skrektastic."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask.dmi'
	worn_icon_vox = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask_vox.dmi'
	icon_state = "death"

// Donation reward for 1ceres
/obj/item/clothing/glasses/rosecolored
	name = "rose-colored glasses"
	desc = "Óculos em forma de óculos que parecem ter uma alimentação tipo HUD em um roteiro baseado em linhas estranhas. Não parece que eles foram feitos pelo NT."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/eyes.dmi'
	icon_state = "rose"

// Donation reward for Fuzlet
/obj/item/card/fuzzy_license
	name = "license to hug"
	desc = "Uma licença muito oficial. Não realmente endossado por Nanotrasen."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	icon_state = "license"

	var/possible_types = list(
		"hug",
		"snuggle",
		"cuddle",
		"kiss",
		"spoil friends",
		"hold hands",
		"have this license",
		"squeak",
		"cute",
		"pat",
		"administer plushies",
		"distribute cookies",
		"sex",
		"weh")

/obj/item/card/fuzzy_license/attack_self(mob/user)
	if(Adjacent(user))
		user.visible_message(span_notice("[user]mostra-lhe:[icon2html(src, viewers(user))] [src.name]."), span_notice("Você mostra\the [src.name]."))
	add_fingerprint(user)

/obj/item/card/fuzzy_license/attackby(obj/item/used, mob/living/user, params)
	if(user.ckey != "fuzlet")
		return

	if(istype(used, /obj/item/pen) || istype(used, /obj/item/toy/crayon))
		var/choice = input(user, "Selecione o tipo de licença.", "Selecção do Tipo de Licença") as null|anything in possible_types
		if(!isnull(choice))
			name = "license to [choice]"

// Donation reward for 1ceres
/obj/item/clothing/suit/jacket/gorlex_harness
	name = "engine technician harness"
	desc = "Um equipamento de engenharia vermelho-sangue. Você não consegue descobrir um uso para isso, mas parece selar magneticamente em alguns lugares."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "gorlexharness"

// Donation reward for 1ceres
/obj/item/poster/korpstech
	name = "Korps Genetics poster"
	poster_type = /obj/structure/sign/poster/contraband/korpstech
	icon_state = "rolled_poster"

/obj/structure/sign/poster/contraband/korpstech
	name = "Korps Genetics"
	desc = "Este pôster tem uma enorme hélice rosa nela, com texto menor por baixo que diz 'O Instituto Korps, avançando o campo de genética desde 2423!'"
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "korpsposter"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/korpstech, 32)

// Donation reward for Kay-Nite
/obj/item/clothing/glasses/eyepatch/rosecolored
	name = "rose-colored eyepatch"
	desc = "Um eyepatch personalizado com um HUD rosa brilhante flutuando na frente dele. Parece que há mais do que um tapa-olho, considerando o material que é feito."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/eyes.dmi'
	icon_state = "rosepatch_R"
	base_icon_state = "rosepatch"

// Donation reward for Cimika
/obj/item/clothing/suit/toggle/labcoat/skyrat/tenrai
	name = "Tenrai labcoat"
	desc = "Um jaleco feito de uma variedade de materiais puros, costurado junto com uma quantidade assustadora de habilidade. O tecido é duro, suave como a seda, e excepcionalmente agradável ao toque. As listras douradas são visíveis no escuro, trabalhando como farol para os feridos. Um pequeno rótulo no interior dele lê\"Tenrai Kitsunes Supremacy\"."
	base_icon_state = "tenraicoat"
	icon_state = "tenraicoat"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/toggle/labcoat/skyrat/tenrai/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)

//Donation reward for RealWinterFrost
/obj/item/clothing/neck/cloak/fluffycloak
	name = "Cloak of the Fluffy One"
	desc = "Abraços e beijos é apenas o que este sabe, que seus abraços sejam para todos e não para seus próprios\"Só para uso fútil\"."
	icon_state = "fluffycloak"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/cloaks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/neck.dmi'

/obj/item/clothing/neck/cloak/fluffycloak/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)


/obj/item/clothing/mask/gas/larpswat
	name = "Foam Force SWAT Mask"
	desc = "O que parece ser uma máscara SWAT no início, é na verdade uma máscara de gás que tem partes réplica de uma máscara SWAT feita de plástico barato. Pelo menos parece bom se você gosta de parecer um ladrão de segurança."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask.dmi'
	icon_state = "larpswat"
	supports_variations_flags = NONE

// Donation reward for Cimika, on behalf of tf4
/obj/item/clothing/neck/fishpendant
	name = "fish necklace"
	desc = "Um simples colar de prata com um pingente de atum azul.\n\"L. Alazawi\"Está inscrito no verso. Você tem a sensação que ficaria bem com batatas e feijão verde."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/necklaces.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/neck.dmi'
	icon_state = "fishpendant"

// Donation reward for Weredoggo
/obj/item/hairbrush/tactical
	name = "tactical hairbrush"
	desc = "Às vezes, depois de uma briga com a morte, uma boa arrumação é a coisa certa para o alívio do estresse tático."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_right.dmi'
	icon_state = "tacticalbrush"
	inhand_icon_state = "tacticalbrush"

// Donation reward for ultimarifox
/obj/item/clothing/under/rank/security/head_of_security/alt/roselia
	name = "black and red turtleneck"
	desc = "Uma gola rolê preta com um livery vermelho preso. Lembra um tempo antes da cor azul. Parece acolchoado para o inferno e de volta também."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "hosaltred"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'

/obj/item/clothing/glasses/hud/security/sunglasses/gars/giga/roselia
	name = "red-tinted giga HUD gar glasses"
	desc = "GIGA GAR óculos com um hud segurança implantado na lente. Lembra um tempo antes da cor azul."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/glasses.dmi'
	icon_state = "supergarsred"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/eyes.dmi'

//Donation reward for Konstyantyn
/obj/item/clothing/accessory/badge/holo/jade
	name = "jade holobadge"
	desc = "Um estranho holobadge verde. O tenente Uriah está estampado nele, acima das letras JS."
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	icon_state = "greenbadge"

// Donation reward for Dudewithatude
/obj/item/clothing/suit/toggle/rainbowcoat
	name = "rainbow coat"
	desc = "Um casaco maravilhosamente brilhante que mostra a cor do arco-íris!"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "rainbowcoat"
	base_icon_state = "rainbowcoat"

// Donation reward for M97screwsyourparents
/obj/item/clothing/head/recruiter_cap
	name = "recruiter cap"
	desc = "Ei, faculdade grátis!"
	icon_state = "officerhat"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	worn_icon_state = "officerhat"

// Donation reward for M97screwsyourparents
/obj/item/clothing/suit/toggle/recruiter_jacket
	name = "recruiter jacket"
	desc = "Ei, faculdade grátis!"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "officerjacket"
	base_icon_state = "officerjacket"

// Donation reward for M97screwsyourparents
/obj/item/clothing/under/recruiter_uniform
	name = "recruiter uniform"
	desc = "Ei, faculdade grátis!"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "oldmarine_whites"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = null

//Donation reward for Tetrako
/obj/item/clothing/under/nt_idol_skirt
	name = "\improper NT Idol's suitskirt"
	desc = "Essa roupa se parece muito com a de outros oficiais da NT, mas vem com certos sinos e assobios, como frescuras ao redor do vestido, pequenos sopros ao redor dos ombros e, mais importante, várias fivelas douradas para acentuar o verde! A única coisa adequada para os próprios ídolos do NT usarem!"
	icon = 'icons/obj/clothing/under/centcom.dmi'
	worn_icon = 'icons/mob/clothing/under/centcom.dmi'
	icon_state = "centcom_skirt"
	inhand_icon_state = "dg_suit"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

// Donation reward for SlippyJoe
/obj/item/clothing/accessory/hypno_watch
	name = "cracked pocket watch"
	desc = "Um relógio de bolso brilhante, lançado em ouro e gravado com redemoinhos metálicos que quase parecem ametistas sob a luz certa... Há um botão na parte superior para abrir o painel frontal, embora tudo o que está dentro é uma camada de vidro rachado, as mãos árgentes presas apontando para 7:07 PM. A prata escovada destas flechas quase parece girar se o olhar de alguém permanece por muito tempo. Apesar de sua aparência inerte, o som mecânico assustador de engrenagens girando e clicando no lugar parece silenciosamente soar para fora do artefato. Nas mãos certas..."
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
/obj/item/clothing/accessory/hypno_watch/ui_action_click(mob/living/user, action)
	if(!isliving(user) || !can_use(user))
		return
	var/message = input(user, "Fale com um sussurro hipnótico", "Whisper")
	if(QDELETED(src) || QDELETED(user) || !message || !user.can_speak())
		return
	user.whisper(message, spans = spans)

/obj/item/clothing/accessory/hypno_watch/examine()
	. = ..()
	. += span_boldwarning("Quem sabe para que poderia ser usado?")

// Donation reward for BoisterousBeebz

/obj/item/clothing/under/bubbly_clown/skirt
	name = "bubbly clown dress"
	desc = "Um vestido de palhaço brilhante e alegre, buzine!"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "bubbly_clown_dress"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

// Donation reward for Sweetsoulbrother
/obj/item/coin/donator/marsoc
	name = "MARSOC Challenge Coin"
	desc = "Esta é uma moeda de desafio dada a todos os membros do MARSOC após a honrosa separação do Corpo. A moeda tem a insígnia do Comando de Operações Especiais da Marinha de um lado, e o logotipo do Corpo de Fuzileiros Navais do governo terrestre do outro. Este tem uma gravação no lado do logotipo da Marinha, gravada em um círculo em torno dele:\"Ao Sargento Henry Rockwell, por seu serviço exemplar à comunidade de Operações Especiais e sua notável fibra moral e brilhante exemplo aos valores centrais do Corpo de Fuzileiros Navais do Governo Terrano.\""
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	sideslist = list("MARSOC", "SFMC")

// Donation reward for Kay-Nite
/obj/item/clothing/under/tactichill
	name = "tactichill jacket"
	desc = "A variante mais brilhante da roupa tática, para quando você quiser parecer ainda mais legal que o normal e ainda operar ao mesmo tempo."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'
	icon_state = "tactichill"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

// Donation reward for thedragmeme
/obj/item/clothing/shoes/fancy_heels/drag
	desc = "Um par chique de saltos altos. Clack clack clack... definitivamente virando muitas cabeças."

/obj/item/clothing/shoes/fancy_heels/drag/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_zubbers/sound/effects/footstep/highheel1.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel2.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel3.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel4.ogg' = 1), 70)

// Donation reward for Razurath

/obj/item/clothing/under/bimpcap
	name = "Formal Matte Black Captain Uniform"
	desc = "Um uniforme preto fosco profissional, acolchoado com medalhas de serviço distintivo e valor, usado apenas pelos mais altos funcionários da estação."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "bimpcap"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

// Donation reward for Nikohyena
/obj/item/clothing/glasses/gold_aviators
	name = "purple and gold aviators"
	desc = "Um par redondo de óculos aviadores dourados, as lentes tendo sido aplicadas com um tom roxo."
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/eyes.dmi'
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/glasses.dmi'
	icon_state = "goldaviator"

// Donation reward for Thedragmeme
/obj/item/clothing/under/caged_dress/skirt
	name = "Caged Purple Dress"
	desc = "Um vestido roxo sedoso com uma crinolina parcialmente exposta por baixo."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	icon_state = "caged_dress"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'

// Donation reward for Thedragmeme
/obj/item/clothing/suit/short_coat
	name = "Short Purple Coat"
	desc = "Um casaco preto e roxo curto, usado principalmente para astéticos e isolando a pessoa que o usa."
	icon_state = "short_coat"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

// Donation reward for Thedragmeme
/obj/item/clothing/neck/flower_collar
	name = "Flower Collar"
	desc = "Um colar roxo com uma flor vermelha delicada presa ao lado direito do item."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/necklaces.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/neck.dmi'
	icon_state = "flower_collar"
	kink_collar = TRUE

// Donation reward for Sigmar Alkahest
/obj/item/clothing/under/costume/skyrat/kimono/sigmar
	name = "short-sleeved kimono"
	desc = "Um tradicional quimono japonês da Terra antiga. É branco com um corte dourado e um padrão de hera dourada polida."
	icon_state = "kimono-gold"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_teshari.dmi'
	gets_cropped_on_taurs = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

// Donation reward for Sigmar Alkahest
/obj/item/clothing/head/hooded/sigmarcoat
	name = "black raincoat hood"
	desc = "Certamente faz você parecer mais ameaçador."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "long-coat-hood"
	supports_variations_flags = NONE

// Donation reward for Sigmar Alkahest
/obj/item/clothing/suit/hooded/sigmarcoat
	name = "black open-faced raincoat"
	desc = "Uma capa preta clara. Você nem sabia que eram feitos dessa cor."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "long-coat"
	hoodtype = /obj/item/clothing/head/hooded/sigmarcoat
	supports_variations_flags = NONE

// Donation reward for The Sharkenning

/obj/item/clothing/gloves/ring/hypno/sharkenning
	name = "suspiciously glossy ring"
	desc = "Este anel escorre com uma borda assertiva enquanto a luz afiada se dobra ao longo do bronze liso e preto. Como o dedo que o usa, uma quantidade excepcional de polonês repele quase toda a luz que olha ao longo de sua superfície. Se olhar mais de perto, uma leve tonalidade dourada indica os metais preciosos dentro da liga."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/hands.dmi'
	icon_state = "ringblack"
	worn_icon_state = "ringblack"
	lefthand_file = null
	righthand_file = null
	spans = list("glossy")

/obj/item/clothing/ears/kinky_headphones/sharkenning
	name = "suspiciously glossy headphones"
	desc = "Auscultadores metálicos pretos com acabamento brilhante. As almofadas de borracha macias são comfortoráveis e forma montagem"
	icon_state = "kinkphones_black_off"
	base_icon_state = "kinkphones"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/ears.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/ears.dmi'
	inhand_icon_state = null
	current_kinkphones_color = "black"
	color_changed = TRUE

//reward for SomeRandomOwl
/obj/item/clothing/head/costume/strigihat
	name = "starry witch hat"
	desc = "Um chapéu de bruxa bonito normalmente usado por um teshari como uma coruja."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/donator/mob/clothing/head_teshari.dmi'
	icon_state = "strigihat"

//Donation reward for Razurath
/obj/item/clothing/head/razurathhat
	name = "Golden Nanotrasen Officer Cap"
	desc = "Um boné de Nanotrasen. Agora mais escuro, mais dourado e mais frio!"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "razurath_hat"

//Donation reward for Razurath
/obj/item/clothing/suit/razurathcoat
	name = "Golden Nanotrasen Officer Coat"
	desc = "Um casaco de Nanotrasen. Agora mais escuro, mais dourado e mais frio do que nunca!"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "razurath_coat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

// Donation reward for MaSvedish
/obj/item/holocigarette/masvedishcigar
	name = "holocigar"
	desc = "Um aparelho que, usando tecnologia holodeck, reproduz um charuto de queima lenta. Agora com tecnologia de menos choque. Tem uma pequena inscrição de \"MG\" no rótulo dourado."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/mask.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_right.dmi'
	inhand_icon_state = "masvedishcigar_off"
	worn_icon_state = "masvedishcigar_off"
	icon_state = "masvedishcigar_off"
	icon_on = "masvedishcigar_on"
	icon_off = "masvedishcigar_off"

// Donation reward for LT3
/obj/item/clothing/suit/armor/skyy
	name = "silver jacket mk II"
	desc = "Uma jaqueta para aqueles com presença de comando. Feito de tecido sintético, está entrelaçado com uma liga especial que fornece proteção e estilo extra."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "lt3_jacket"
	inhand_icon_state = "syndicate-black"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/jacket/skyy
	name = "silver jacket"
	desc = "Uma jaqueta para aqueles com presença de comando. Feito de tecido sintético, está entrelaçado com uma liga especial que fornece proteção e estilo extra."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "lt3_jacket"
	inhand_icon_state = "syndicate-black"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/pants/skyy
	name = "silver jeans"
	desc = "Um par de jeans para aqueles com presença de comando. Feito de denim de prata brilhante, está entrelaçado com uma liga especial que fornece proteção extra e estilo."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_right.dmi'
	icon_state = "lt3_jeans"
	inhand_icon_state = "lt3_jeans"

/obj/item/clothing/gloves/skyy
	name = "charcoal fingerless gloves"
	desc = "Valorizando a forma sobre a função, estas luvas mal cobrem mais do que a palma da sua mão."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/hands.dmi'
	icon_state = "lt3_gloves"

// Donation reward for Lolpopomg101
/obj/item/clothing/suit/hooded/colorblockhoodie
	name = "color-block hoodie"
	desc = "Um moletom macio de uma marca irreconhecível."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "colorblockhoodie"
	hoodtype = /obj/item/clothing/head/hooded/colorblockhoodie
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hooded/colorblockhoodie
	name = "hood"
	desc = "Muito suave por dentro!"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "colorblockhood"
	flags_inv = HIDEHAIR

/obj/item/clothing/suit/toggle/digicoat
	toggle_noun = "holo-display"
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

//Public donation reward for Razurath
/obj/item/clothing/suit/toggle/digicoat/glitched
	name = "hacked digicoat"
	desc = "Imagens viscosas exibidas por trás. Beleza!"
	base_icon_state = "digicoat_glitched"
	icon_state = "digicoat_glitched"

/obj/item/clothing/suit/toggle/digicoat/nanotrasen
	name = "nanotrasen digicoat"
	desc = "Uma jaqueta da empresa de design popular."
	base_icon_state = "digicoat_nt"
	icon_state = "digicoat_nt"

/obj/item/clothing/suit/toggle/digicoat/interdyne
	name = "interdyne digicoat"
	desc = "Uma jaqueta de cor sinistra de uma empresa familiar."
	base_icon_state = "digicoat_interdyne"
	icon_state = "digicoat_interdyne"

/obj/item/clothing/suit/armor/hos/elofy
	name = "anime admiral coat"
	desc = "Este casaco é uma réplica quase perfeita do usado pelo Almirante Yi Sun-Sin, personagem principal de\"Heróis do Conflito Galáctico\"Um drama de guerra animado entre o Sindicato Planetário Livre e o Segundo Império Galáctico. Foi uma peça sensacional entre aqueles que apreciam desenhos animados e dramas de guerra de período, mas não se espalhou muito fora do governo terráqueo."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "coat_blackred"
	inhand_icon_state = "hostrench"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	supports_variations_flags = NONE

/obj/item/clothing/suit/armor/hos/elofy/examine_more(mob/user)
	. = ..()
	. += "It seems particularly soft and has subtle ballistic fibers intwined with the soft fabric that is perfectedly tailored to the body that wears it. Each golden engraving seems to reflect against your eyes with a slightly blinding flare. This is part of a full set of Luna Wolves Legion battle garb."


/obj/item/clothing/head/hats/hos/elofy
	name = "anime admiral hat"
	desc = "Este chapéu é uma réplica quase perfeita do usado pelo Almirante Yi Sun-Sin, personagem principal de\"Heróis do Conflito Galáctico\"Um drama de guerra animado entre o Sindicato Planetário Livre e o Segundo Império Galáctico. Foi uma peça sensacional entre aqueles que apreciam desenhos animados e dramas de guerra de período, mas não se espalhou muito fora do governo terráqueo."
	icon ='modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	icon_state = "hat_black"

/obj/item/clothing/gloves/elofy
	name = "anime admiral gloves"
	desc = "Estas luvas são uma réplica quase perfeita daqueles usados pelo Almirante Yi Sun-Sin, personagem principal de\"Heróis do Conflito Galáctico\"Um drama de guerra animado entre o Sindicato Planetário Livre e o Segundo Império Galáctico. Foi uma peça sensacional entre aqueles que apreciam desenhos animados e dramas de guerra de período, mas não se espalhou muito fora do governo terráqueo."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/hands.dmi'
	icon_state = "gloves_black"

/obj/item/clothing/shoes/jackboots/elofy
	name = "anime admiral boots"
	desc = "Estas botas são uma réplica quase perfeita daqueles usados pelo Almirante Yi Sun-Sin, personagem principal de\"Heróis do Conflito Galáctico\"Um drama de guerra animado entre o Sindicato Planetário Livre e o Segundo Império Galáctico. Foi uma peça sensacional entre aqueles que apreciam desenhos animados e dramas de guerra de período, mas não se espalhou muito fora do governo terráqueo."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/feet.dmi'
	icon_state = "boots_blackred"

// Donation reward for grasshand
/obj/item/clothing/under/rank/civilian/chaplain/divine_archer/noble
	name = "noble gambeson"
	desc = "Essas roupas fazem você se sentir mais perto do espaço."
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/civilian_digi.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/under/civilian_teshari.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/shoes/jackboots/noble
	name = "noble boots"
	desc = "Essas botas fazem você sentir que pode andar no espaço."
	icon_state = "archerboots"
	inhand_icon_state = "archerboots"

// Donation reward for nikotheguydude
/obj/item/clothing/suit/toggle/labcoat/vic_dresscoat_donator
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/suit.dmi'
	icon_state = "vickyred"
	name = "nobility dresscoat"
	desc = "Um casaco elaborado composto de um material sedoso mas firme. O tecido é bem fino, e proporciona proteção ou isolamento insignificante, mas é agradável na pele.\nEmbora extremamente bem feito, parece bastante frágil, e em vez disso<i>caro.</i>Você tem a sensação de que pode não<b>Sobreviver a uma máquina de lavar</b>Sem tratamento especializado."
	special_desc = "Os botões são pressionados com algum tipo de sigil - que, para aqueles conhecedores em Tiziran política ou nobreza, seria reconhecível como o<b>Emblema de Kor'Yesh</b>, um relativamente<i>Casa menor de nobreza</i>dentro<i>Tizira.</i>.\n\nNuma inspeção mais próxima, parece que o interior é modificado com material protetor e pontos de montagem mais encontrados em batas médicas."
	limb_integrity = 100 // note that this is usually disabled by having it set to 0, so this is just strictly worse
	body_parts_covered = CHEST|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/toggle/labcoat/vic_dresscoat_donator/Initialize(mapload)
	. = ..()

	qdel(GetComponent(/datum/component/toggle_icon)) // we dont have a toggle icon

#define NOBILITY_DRESSCOAT_WASHING_CREDITS_NEEDED 2500

// this is based on an in-joke with the character whom inspires this donator item, where they need a fuckton of money to wash their coat. this takes it literally
/obj/item/clothing/suit/toggle/labcoat/vic_dresscoat_donator/machine_wash(obj/machinery/washing_machine/washer)

	var/total_credits = 0
	var/list/obj/item/money_to_delete = list()
	for (var/obj/item/holochip/chip in washer)
		total_credits += chip.get_item_credit_value()
		money_to_delete += chip
		if (total_credits >= NOBILITY_DRESSCOAT_WASHING_CREDITS_NEEDED)
			break
	if (total_credits < NOBILITY_DRESSCOAT_WASHING_CREDITS_NEEDED)
		for (var/obj/item/stack/spacecash/cash in washer)
			total_credits += cash.get_item_credit_value()
			money_to_delete += cash
			if (total_credits >= NOBILITY_DRESSCOAT_WASHING_CREDITS_NEEDED)
				break

	var/message
	var/sound_effect_path
	var/sound_effect_volume
	if (total_credits >= NOBILITY_DRESSCOAT_WASHING_CREDITS_NEEDED) // all is well
		message = span_notice("[src] seems to absorb the raw capital from its surroundings, and is successfully washed!")
		sound_effect_path = 'sound/effects/whirthunk.ogg'
		sound_effect_volume = 40
		for (var/obj/item/entry_to_delete as anything in money_to_delete)
			qdel(entry_to_delete)
	else // IT COSTS ME A THOUSAND CREDITS TO WASH THIS!! HALF MY BUDGET IS DRY CLEANING
		message = span_warning("[src]'s delicate fabric is shredded by [washer]! How terrible!")
		sound_effect_path = 'sound/effects/cloth_rip.ogg'
		sound_effect_volume = 30
		for (var/zone in cover_flags2body_zones(body_parts_covered))
			take_damage_zone(zone, limb_integrity * 1.1, BRUTE) // fucking shreds it

	var/turf/our_turf = get_turf(src)
	our_turf.visible_message(message)
	playsound(src, sound_effect_path, sound_effect_volume, FALSE)

	return ..()

/obj/item/clothing/under/costume/dragon_maid
	name = "dragon maid uniform"
	desc = "Um uniforme para uma empregada de cozinha, estilizado para ter detalhes dracônicos."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	icon_state = "dragon_maid"
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	can_adjust = FALSE

#undef NOBILITY_DRESSCOAT_WASHING_CREDITS_NEEDED

//  Donation reward for vexcint
/obj/item/clothing/head/anubite
	name = "\improper Anubite headpiece"
	desc = "Uma cabeça de cor escura com sotaques dourados. Suas características parecem reminiscências do deus Anubis."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/hats.dmi'
	icon_state = "anubite_headpiece"
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/head.dmi'
	worn_y_offset = 4

//Donation reward for Jasohavents
/obj/item/clothing/under/rank/cargo/qm/skirt/old
	name = "quartermaster's jumpskirt"
	desc = "Parece que alguém manteve alguns uniformes antiquados. Cheiram a Rum e Smoke."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'

//Donation reward for Jasohavents
/obj/item/food/griddle_toast/toaster_implant
	name = "toast"
	desc = "Pão grosso, torrado à perfeição."
	food_reagents = list(/datum/reagent/consumable/nutriment = 1)
//it's meant to be practically non-functional in terms of giving any ingame advantage, but it seems food needs to have *something* in it to be edible
//it *can* be a whole thing with a "gridle" that only accepts bread from the user's hand but I can't be assed to implement it for a one-off gimmick donator item

#define TOASTER_IMPLANT_COOLDOWN (3 MINUTES)
/obj/item/implant/toaster
	name = "toaster implant"
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "griddle_toast"
	COOLDOWN_DECLARE(toast_cooldown)

/obj/item/implant/toaster/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Toaster-O brand toaster module<BR>
				<b>Implant Details:</b> <BR>
				<b>Function:</b> Serves you a delicious toasted slice of bread."}
	return dat

/obj/item/implant/toaster/activate()
	. = ..()
	if(!COOLDOWN_FINISHED(src, toast_cooldown))
		imp_in.show_message(span_notice("Ainda não está pronto para fazer outro brinde."))
		return

	var/obj/item/food/griddle_toast/toaster_implant/toast = new(get_turf(imp_in))
	var/adjective = pick("crispy", "delicious", "fresh")
	imp_in.visible_message(span_notice("[imp_in]Ejeta um[adjective]Brinde!"), span_notice("Com o familiar\"ding\", a torradeira ejeta um[adjective]Torrada."))

	playsound(imp_in, 'sound/machines/ding.ogg', vol = 75, vary = FALSE, pressure_affected = FALSE, use_reverb = FALSE)
	toast.throw_at(get_turf(imp_in), 2, 3)
	COOLDOWN_START(src, toast_cooldown, TOASTER_IMPLANT_COOLDOWN)

/obj/item/implanter/toaster
	name = "implanter (toaster)"
	imp_type = /obj/item/implant/toaster

/obj/item/implantcase/toaster
	name = "implant case - 'Toaster'"
	desc = "Uma caixa de vidro contendo um implante de torradeira. Doce."
	imp_type = /obj/item/implant/toaster

#undef TOASTER_IMPLANT_COOLDOWN
