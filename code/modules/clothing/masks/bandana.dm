/obj/item/clothing/mask/bandana
	name = "bandana"
	desc = "Uma bela bandana com forro nanotécnico."
	icon = 'icons/map_icons/clothing/mask.dmi'
	icon_state = "/obj/item/clothing/mask/bandana"
	post_init_icon_state = "bandana"
	inhand_icon_state = "greyscale_bandana"
	w_class = WEIGHT_CLASS_TINY
	flags_cover = MASKCOVERSMOUTH
	flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_cover = MASKCOVERSMOUTH
	slot_flags = ITEM_SLOT_MASK
	adjusted_flags = ITEM_SLOT_HEAD
	species_exception = list(/datum/species/golem)
	dying_key = DYE_REGISTRY_BANDANA
	flags_1 = IS_PLAYER_COLORABLE_1

	greyscale_config = /datum/greyscale_config/bandana
	greyscale_config_worn = /datum/greyscale_config/bandana/worn
	greyscale_config_inhand_left = /datum/greyscale_config/bandana/inhands_left
	greyscale_config_inhand_right = /datum/greyscale_config/bandana/inhands_right
	greyscale_colors = "#2e2e2e"

/obj/item/clothing/mask/bandana/examine(mob/user)
	. = ..()
	if(up)
		. += "Use in-hand to untie it to wear as a mask!"
		return
	if(slot_flags & ITEM_SLOT_NECK)
		. += "Alt-click to untie it to wear as a mask!"
	else
		. += "Use in-hand to tie it up to wear as a hat!"
		. += "Alt-click to tie it up to wear on your neck!"

/obj/item/clothing/mask/bandana/attack_self(mob/user)
	adjust_visor(user)

/obj/item/clothing/mask/bandana/adjust_visor(mob/living/user)
	if(slot_flags & ITEM_SLOT_NECK)
		to_chat(user, span_warning("You must undo [src] in order to push it into a hat!"))
		return FALSE
	//SKYRAT EDIT ADDITION START: BANDANA HATS FOR MUTANTS
	if(slot_flags & ITEM_SLOT_HEAD)
		supports_variations_flags = NONE
	if(slot_flags & ITEM_SLOT_MASK)
		supports_variations_flags = initial(supports_variations_flags)
	//SKYRAT EDIT ADDITION END
	return ..()

/obj/item/clothing/mask/bandana/visor_toggling()
	. = ..()
	if(up)
		undyeable = TRUE
	else
		undyeable = initial(undyeable)

/obj/item/clothing/mask/bandana/click_alt(mob/user)
	if(!iscarbon(user))
		return NONE

	var/mob/living/carbon/char = user
	var/matrix/widen = matrix()
	if((char.get_item_by_slot(ITEM_SLOT_NECK) == src) || (char.get_item_by_slot(ITEM_SLOT_MASK) == src) || (char.get_item_by_slot(ITEM_SLOT_HEAD) == src))
		to_chat(user, span_warning("You can't tie [src] while wearing it!"))
		return CLICK_ACTION_BLOCKING
	else if(slot_flags & ITEM_SLOT_HEAD)
		to_chat(user, span_warning("You must undo [src] before you can tie it into a neckerchief!"))
		return CLICK_ACTION_BLOCKING
	else if(!user.is_holding(src))
		to_chat(user, span_warning("You must be holding [src] in order to tie it!"))
		return CLICK_ACTION_BLOCKING

	if(slot_flags & ITEM_SLOT_MASK)
		undyeable = TRUE
		slot_flags = ITEM_SLOT_NECK
		worn_y_offset = -3
		widen.Scale(1.25, 1)
		transform = widen
		user.visible_message(span_notice("[user] ties [src] up like a neckerchief."), span_notice("You tie [src] up like a neckerchief."))
		flags_inv = NONE
		flags_cover = NONE
		return CLICK_ACTION_SUCCESS

	undyeable = initial(undyeable)
	slot_flags = initial(slot_flags)
	worn_y_offset = initial(worn_y_offset)
	transform = initial(transform)
	user.visible_message(span_notice("[user] unties the neckercheif."), span_notice("Você desamarra o pescoço."))
	flags_inv = initial(flags_inv)
	flags_cover = initial(flags_cover)
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/mask/bandana/red
	name = "red bandana"
	desc = "Uma bela bandana vermelha com forro nanotécnico."
	icon_state = "/obj/item/clothing/mask/bandana/red"
	greyscale_colors = "#A02525"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/blue
	name = "blue bandana"
	desc = "Uma bela bandana azul com forro nanotech."
	icon_state = "/obj/item/clothing/mask/bandana/blue"
	greyscale_colors = "#294A98"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/purple
	name = "purple bandana"
	desc = "Uma bela bandana roxa com forro nanotech."
	icon_state = "/obj/item/clothing/mask/bandana/purple"
	greyscale_colors = "#9900CC"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/green
	name = "green bandana"
	desc = "Uma bela bandana verde com forro nanotech."
	icon_state = "/obj/item/clothing/mask/bandana/green"
	greyscale_colors = "#3D9829"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/gold
	name = "gold bandana"
	desc = "Uma bandana de ouro com forro nanotécnico."
	icon_state = "/obj/item/clothing/mask/bandana/gold"
	greyscale_colors = "#DAC20E"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/orange
	name = "orange bandana"
	desc = "Uma bela bandana laranja com forro nanotécnico."
	icon_state = "/obj/item/clothing/mask/bandana/orange"
	greyscale_colors = "#da930e"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/black
	name = "black bandana"
	desc = "Uma bela bandana preta com forro nanotécnico."
	greyscale_colors = "#2e2e2e"
	flags_1 = NO_NEW_GAGS_PREVIEW_1 // Same color as the basetype

/obj/item/clothing/mask/bandana/white
	name = "white bandana"
	desc = "Uma bela bandana branca com forro nanotécnico."
	icon_state = "/obj/item/clothing/mask/bandana/white"
	greyscale_colors = "#DCDCDC"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/durathread
	name = "durathread bandana"
	desc = "Uma bandana feita de Durathread, você gostaria que ela fornecesse alguma proteção para seu usuário, mas é muito fina..."
	icon_state = "/obj/item/clothing/mask/bandana/durathread"
	greyscale_colors = "#5c6d80"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/striped
	name = "striped bandana"
	desc = "Uma bela bandana com forro nanotécnico e uma faixa."
	icon = 'icons/map_icons/clothing/mask.dmi'
	icon_state = "/obj/item/clothing/mask/bandana/striped"
	post_init_icon_state = "bandstriped"
	greyscale_config = /datum/greyscale_config/bandana/striped
	greyscale_config_worn = /datum/greyscale_config/bandana/striped/worn
	greyscale_config_inhand_left = /datum/greyscale_config/bandana/striped/inhands_left
	greyscale_config_inhand_right = /datum/greyscale_config/bandana/striped/inhands_right
	greyscale_colors = "#2e2e2e#C6C6C6"
	undyeable = TRUE

/obj/item/clothing/mask/bandana/striped/black
	name = "striped bandana"
	desc = "Uma bela bandana preta e branca com forro nanotécnico e uma faixa."
	flags_1 = NO_NEW_GAGS_PREVIEW_1 // same exact icon/color as the base type

/obj/item/clothing/mask/bandana/striped/security
	name = "striped security bandana"
	desc = "Uma bela bandana com forro nanotécnico, uma faixa e cores de segurança."
	icon_state = "/obj/item/clothing/mask/bandana/striped/security"
	greyscale_colors = "#A02525#2e2e2e"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/striped/science
	name = "striped science bandana"
	desc = "Uma bela bandana com forro nanotécnico, uma faixa e cores científicas."
	icon_state = "/obj/item/clothing/mask/bandana/striped/science"
	greyscale_colors = "#DCDCDC#8019a0"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/striped/engineering
	name = "striped engineering bandana"
	desc = "Uma bela bandana com forro nanotécnico, uma faixa e cores de engenharia."
	icon_state = "/obj/item/clothing/mask/bandana/striped/engineering"
	greyscale_colors = "#dab50e#ec7404"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/striped/medical
	name = "striped medical bandana"
	desc = "Uma bela bandana com forro nanotécnico, uma faixa e cores médicas."
	icon_state = "/obj/item/clothing/mask/bandana/striped/medical"
	greyscale_colors = "#DCDCDC#5995BA"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/striped/cargo
	name = "striped cargo bandana"
	desc = "Uma bela bandana com forro nanotécnico, uma faixa e cores de carga."
	icon_state = "/obj/item/clothing/mask/bandana/striped/cargo"
	greyscale_colors = "#967032#5F350B"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/striped/botany
	name = "striped botany bandana"
	desc = "Uma bela bandana com forro nanotécnico, uma faixa e cores botânicas."
	icon_state = "/obj/item/clothing/mask/bandana/striped/botany"
	greyscale_colors = "#3D9829#294A98"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/skull
	name = "skull bandana"
	desc = "Uma bela bandana com forro nanotécnico e um emblema de crânio."
	icon = 'icons/map_icons/clothing/mask.dmi'
	icon_state = "/obj/item/clothing/mask/bandana/skull"
	post_init_icon_state = "bandskull"
	greyscale_config = /datum/greyscale_config/bandana/skull
	greyscale_config_worn = /datum/greyscale_config/bandana/skull/worn
	greyscale_config_inhand_left = /datum/greyscale_config/bandana/skull/inhands_left
	greyscale_config_inhand_right = /datum/greyscale_config/bandana/skull/inhands_right
	greyscale_colors = "#2e2e2e#C6C6C6"
	undyeable = TRUE

/obj/item/clothing/mask/bandana/skull/black
	desc = "Uma bela bandana preta com revestimento nanotécnico e um emblema de crânio."
	greyscale_colors = "#2e2e2e#C6C6C6"
	flags_1 = NO_NEW_GAGS_PREVIEW_1 // same as the basetype

/obj/item/clothing/mask/facescarf
	name = "facescarf"
	desc = "Cubra seu rosto como nos filmes de cowboy. Também tem tubo de respiração, então você pode usá-lo em todo lugar!"
	actions_types = list(/datum/action/item_action/adjust)
	inhand_icon_state = "greyscale_facescarf"
	alternate_worn_layer = BACK_LAYER
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT|MASKINTERNALS
	flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL
	visor_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	visor_flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	flags_cover = MASKCOVERSMOUTH
	visor_flags_cover = MASKCOVERSMOUTH
	custom_price = PAYCHECK_CREW
	greyscale_colors = "#eeeeee"
	icon = 'icons/map_icons/clothing/mask.dmi'
	icon_state = "/obj/item/clothing/mask/facescarf"
	post_init_icon_state = "facescarf"
	greyscale_config = /datum/greyscale_config/facescarf
	greyscale_config_worn = /datum/greyscale_config/facescarf/worn
	greyscale_config_inhand_left = /datum/greyscale_config/facescarf/inhands_left
	greyscale_config_inhand_right = /datum/greyscale_config/facescarf/inhands_right
	flags_1 = IS_PLAYER_COLORABLE_1
	interaction_flags_click = NEED_DEXTERITY|ALLOW_RESTING

/obj/item/clothing/mask/facescarf/attack_self(mob/user)
	adjust_visor(user)

/obj/item/clothing/mask/facescarf/click_alt(mob/user)
	adjust_visor(user)
	return CLICK_ACTION_SUCCESS


/obj/item/clothing/mask/facescarf/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click [src] to adjust it.")
