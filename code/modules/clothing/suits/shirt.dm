/obj/item/clothing/suit/costume/wellworn_shirt
	name = "well-worn shirt"
	desc = "Uma camiseta desgastada, curiosamente confortável. Você não iria tão longe para dizer que parece como ser abraçado quando você usá-lo, mas é muito perto. Bom para dormir."
	inhand_icon_state = null
	icon = 'icons/map_icons/clothing/suit/costume.dmi'
	icon_state = "/obj/item/clothing/suit/costume/wellworn_shirt"
	post_init_icon_state = "wellworn_shirt"
	greyscale_config = /datum/greyscale_config/wellworn_shirt
	greyscale_config_worn = /datum/greyscale_config/wellworn_shirt/worn
	greyscale_colors = COLOR_WHITE
	species_exception = list(/datum/species/golem)
	flags_1 = IS_PLAYER_COLORABLE_1
	///How many times has this shirt been washed? (In an ideal world this is just the determinant of the transform matrix.)
	var/wash_count = 0

/obj/item/clothing/suit/costume/wellworn_shirt/machine_wash(obj/machinery/washing_machine/washer)
	. = ..()
	if(wash_count <= 5)
		transform *= TRANSFORM_USING_VARIABLE(0.8, 1)
		washer.visible_message("[src] appears to have shrunken after being washed.")
		wash_count += 1
	else
		washer.visible_message("[src] implodes due to repeated washing.")
		qdel(src)

/obj/item/clothing/suit/costume/wellworn_shirt/skub
	name = "pro-skub shirt"
	desc = "Uma camiseta desgastada, curiosamente confortável, proclamando sua postura pró-skub. Foda-se esses anti-skubbies."
	greyscale_colors = "#FFFF4D"
	icon_state = "/obj/item/clothing/suit/costume/wellworn_shirt/skub"
	post_init_icon_state = "wellworn_shirt_pro_skub"
	greyscale_config = /datum/greyscale_config/wellworn_shirt_skub
	greyscale_config_worn = /datum/greyscale_config/wellworn_shirt_skub/worn

/obj/item/clothing/suit/costume/wellworn_shirt/skub/anti
	name = "anti-skub shirt"
	desc = "Uma camiseta desgastada, curiosamente confortável, proclamando sua postura anti-skub. Fodam-se esses pró-skubbies."
	icon_state = "/obj/item/clothing/suit/costume/wellworn_shirt/skub/anti"
	post_init_icon_state = "wellworn_shirt_anti_skub"

/obj/item/clothing/suit/costume/wellworn_shirt/graphic
	name = "well-worn graphic shirt"
	desc = "Uma camiseta desgastada, curiosamente confortável, com um personagem de Fanic, o Weasel, na frente. Ele acrescenta alguns pontos de charme para si mesmo e para o usuário, e lembra-lhe de quando a série ainda era boa, de volta em 2500."
	greyscale_colors = "#FFFFFF#46B45B"
	icon_state = "/obj/item/clothing/suit/costume/wellworn_shirt/graphic"
	post_init_icon_state = "wellworn_shirt_gamer"
	greyscale_config = /datum/greyscale_config/wellworn_shirt_graphic
	greyscale_config_worn = /datum/greyscale_config/wellworn_shirt_graphic/worn

/obj/item/clothing/suit/costume/wellworn_shirt/graphic/ian
	name = "well-worn ian shirt"
	desc = "Uma camiseta desgastada e curiosamente confortável com uma foto de Ian Corgi. Você não iria tão longe para dizer que parece como ser abraçado quando você usá-lo, mas é muito perto. Bom para dormir."
	icon_state = "/obj/item/clothing/suit/costume/wellworn_shirt/graphic/ian"
	post_init_icon_state = "wellworn_shirt_ian"
	greyscale_colors = "#FFFFFF#E1B26C"

/obj/item/clothing/suit/costume/wellworn_shirt/wornout
	name = "worn-out shirt"
	desc = "Uma camiseta bem suja, mas ainda confortável. Você tem dormido nessa por muito tempo."
	icon_state = "/obj/item/clothing/suit/costume/wellworn_shirt/wornout"
	post_init_icon_state = "wornout_shirt"

/obj/item/clothing/suit/costume/wellworn_shirt/wornout/graphic
	name = "worn-out graphic shirt"
	desc = "Uma camiseta bem suja, mas ainda confortável com um personagem de Phanic, o Doninha, na frente. A natureza um pouco raggedy lembra que um título horrível onde eles o fizeram um vampiro. Você deveria ter cheevos por dormir nele tantos dias seguidos."
	greyscale_colors = "#FFFFFF#46B45B"
	icon_state = "/obj/item/clothing/suit/costume/wellworn_shirt/wornout/graphic"
	post_init_icon_state = "wornout_shirt_gamer"
	greyscale_config = /datum/greyscale_config/wornout_shirt_graphic
	greyscale_config_worn = /datum/greyscale_config/wornout_shirt_graphic/worn

/obj/item/clothing/suit/costume/wellworn_shirt/wornout/graphic/ian
	name = "worn-out ian shirt"
	desc = "Uma camiseta bem suja, mas ainda confortável com uma foto do Ian Corgi. Passou do \"um pouco desgastado\" para \"bem amado\", excelente para usar como pijama."
	icon_state = "/obj/item/clothing/suit/costume/wellworn_shirt/wornout/graphic/ian"
	post_init_icon_state = "wornout_shirt_ian"
	greyscale_colors = "#FFFFFF#E1B26C"

/obj/item/clothing/suit/costume/wellworn_shirt/messy
	name = "messy worn-out shirt"
	desc = "Essa camiseta desgastada e confortável chegou a uma compreensão mais completa da sujeira, talvez o fato de ainda não ter sido lavada possa funcionar como uma espécie de camuflagem?"
	icon_state = "/obj/item/clothing/suit/costume/wellworn_shirt/messy"
	post_init_icon_state = "messyworn_shirt"

/obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic
	name = "messy graphic shirt"
	desc = "Essa camiseta desgastada e confortável chegou a uma compreensão mais completa da sujeira. Normies nunca entenderá que este é um item de colecionador, e seu senso de moda é absolutamente deles. Phanic Phorever."
	icon_state = "/obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic"
	post_init_icon_state = "messyworn_shirt_gamer"
	greyscale_config = /datum/greyscale_config/messyworn_shirt_graphic
	greyscale_config_worn = /datum/greyscale_config/messyworn_shirt_graphic/worn
	greyscale_colors = "#FFFFFF#46B45B"

/obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic/ian
	name = "messy ian shirt"
	desc = "Essa camiseta desgastada e confortável chegou a uma compreensão mais completa da sujeira. Você tem a sensação de entender como é ser um cachorro perdido, mas o rosto de Ian ainda te conforta."
	icon_state = "/obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic/ian"
	post_init_icon_state = "messyworn_shirt_ian"
	greyscale_colors = "#FFFFFF#E1B26C"

/obj/item/clothing/suit/costume/wellworn_shirt/messy/graphic/gamer
	name = "gamer shirt"
	desc = "Uma camisa larga, extremamente bem usada com o personagem de jogo antigo Phanic, o Weasel, muito ousado, exibido no peito. Sua mente não pode esperar suportar o ataque de lembrar do Phanic Phanart que você viu, muito menos o fedor deste topo."
