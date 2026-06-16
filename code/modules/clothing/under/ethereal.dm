/obj/item/clothing/under/ethereal_tunic
	name = "ethereal tunic"
	desc = "Uma simples túnica sem mangas usada sobre uma roupa íntima, brilha no escuro!"
	icon = 'icons/map_icons/clothing/under/_under.dmi'
	worn_icon = 'icons/mob/clothing/under/ethereal.dmi'
	icon_state = "/obj/item/clothing/under/ethereal_tunic"
	post_init_icon_state = "eth_tunic"
	greyscale_colors = "#4e7cc7"
	greyscale_config = /datum/greyscale_config/eth_tunic
	greyscale_config_worn = /datum/greyscale_config/eth_tunic/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	can_adjust = FALSE

/obj/item/clothing/under/ethereal_tunic/Initialize(mapload)
	. = ..()
	update_icon(UPDATE_OVERLAYS)

/obj/item/clothing/under/ethereal_tunic/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance('icons/mob/clothing/under/ethereal.dmi', "eth_tunic_emissive", offset_spokesman = src, alpha = src.alpha)

/obj/item/clothing/under/ethereal_tunic/update_overlays()
	. = ..()
	. += emissive_appearance('icons/obj/clothing/under/ethereal.dmi', "eth_tunic_emissive", offset_spokesman = src, alpha = src.alpha)

/obj/item/clothing/under/ethereal_tunic/trailwarden
	name = "trailwarden tunic"
	desc = "Fazendeiros e peregrinos comumente encontrariam suas roupas permanentemente manchadas de anos andando através da lama e flora bioluminescente de Sprout, eventualmente tornou-se costume pintar roupas para replicar este efeito propositadamente."
	icon_state = "/obj/item/clothing/under/ethereal_tunic/trailwarden"
	greyscale_colors = "#32a87d"

/obj/item/clothing/under/ethereal_tunic/trailwarden/equipped(mob/living/user, slot)
	. = ..()
	if(isethereal(user) && (slot & ITEM_SLOT_ICLOTHING))
		var/mob/living/carbon/human/ethereal = user
		to_chat(ethereal, span_notice("[src] gentilmente treme por um momento enquanto você coloca."))
		set_greyscale(ethereal.dna.species.fixed_mut_color)
		ethereal.update_worn_undersuit()
