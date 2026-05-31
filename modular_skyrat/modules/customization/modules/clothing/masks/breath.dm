/obj/item/clothing/mask/breath/vox
	desc = "Uma máscara que pode ser conectada a um suprimento de ar. Este tem um porto de alimentação de fácil acesso para ser mais adequado para os membros da tripulação Vox."
	name = "vox breath mask"
	actions_types = list()
	flags_cover = NONE
	visor_flags_cover = NONE

/obj/item/clothing/mask/balaclavaadjust
	name = "adjustable balaclava"
	desc = "Olhos mais largos e feitos de um material elástico, este parece que pode contorcer mais."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "balaclava"
	inhand_icon_state = "balaclava"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL
	alternate_worn_layer = LOW_FACEMASK_LAYER //This lets it layer below glasses and headsets - WILL LAYER BELOW HAIR IF HIDEHAIR IS NOT UPDATING CORRECTLY
	var/open = 0 //0 = full, 1 = head only, 2 = face only

/obj/item/clothing/mask/balaclavaadjust/proc/adjust_mask(mob/living/carbon/human/user)
	if(!istype(user))
		return
	if(!user.incapacitated)
		switch(open)
			if (0)
				flags_inv = HIDEHAIR
				icon_state = initial(icon_state) + "_open"
				to_chat(user, "Guarde a balaclava, revelando seu rosto.")
				open = 1
			if (1)
				flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
				icon_state = initial(icon_state) + "_mouth"
				to_chat(user, "Ajuste a balaclava para cobrir a boca.")
				open = 2
			else
				flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDEHAIR
				icon_state = initial(icon_state)
				to_chat(user, "Você puxa a balaclava para cobrir toda a sua cabeça.")
				open = 0
		user.update_body_parts()
		user.update_worn_ears()
		user.update_worn_mask() //Updates mob icons

/obj/item/clothing/mask/balaclavaadjust/attack_self(mob/user)
	adjust_mask(user)

/obj/item/clothing/mask/balaclavaadjust/verb/toggle()
		set category = "Object"
		set name = "Adjust Balaclava"
		set src in usr
		adjust_mask(usr)


/obj/item/clothing/mask/balaclava/threehole
	name = "three hole balaclava"
	desc = "Tiofaidh ar la."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "balaclavam"
	inhand_icon_state = "balaclava"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEHAIR

/obj/item/clothing/mask/balaclava/threehole/green
	name = "three hole green balaclava"
	desc = "Tiofaidh ar la."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "swatclavam"
	inhand_icon_state = "balaclava"

/obj/item/clothing/mask/muzzle/ball
	name = "ballgag"
	desc = "Estou bem longe de estar bem."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "ballgag"

/obj/item/clothing/mask/muzzle/ring
	name = "ring gag"
	desc = "Um envoltório de boca aparentemente projetado para manter a boca aberta."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "ringgag"

/obj/item/clothing/mask/surgical/greyscale
	icon = 'icons/map_icons/clothing/mask.dmi'
	icon_state = "/obj/item/clothing/mask/surgical/greyscale"
	post_init_icon_state = "sterile"
	worn_icon = 'modular_skyrat/modules/GAGS/icons/masks.dmi'
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#AAE4DB"
	greyscale_config = /datum/greyscale_config/sterile_mask
	greyscale_config_worn = /datum/greyscale_config/sterile_mask/worn
	greyscale_config_worn_digi = /datum/greyscale_config/sterile_mask/worn/snouted
	greyscale_config_worn_better_vox = /datum/greyscale_config/sterile_mask/worn/better_vox
	greyscale_config_worn_vox = /datum/greyscale_config/sterile_mask/worn/vox
	greyscale_config_worn_teshari = /datum/greyscale_config/sterile_mask/worn/teshari
