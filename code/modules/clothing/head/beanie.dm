
//BeanieStation13 Redux

//Plus a bobble hat, lets be inclusive!!

/obj/item/clothing/head/beanie
	name = "beanie"
	desc = "Um gorro elegante. O acessório de inverno perfeito para aqueles com um senso de moda afiado, e aqueles que não conseguem lidar com uma brisa fria em suas cabeças."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	worn_icon = 'icons/mob/clothing/head/beanie.dmi'
	icon_state = "/obj/item/clothing/head/beanie"
	post_init_icon_state = "beanie"
	custom_price = PAYCHECK_CREW * 1.2
	greyscale_config = /datum/greyscale_config/beanie
	greyscale_config_worn = /datum/greyscale_config/beanie/worn
	greyscale_colors = "#EEEEEE#EEEEEE"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/beanie/black
	name = "black beanie"
	icon_state = "/obj/item/clothing/head/beanie/black"
	greyscale_colors = "#4A4A4B#4A4A4B"

/obj/item/clothing/head/beanie/red
	name = "red beanie"
	icon_state = "/obj/item/clothing/head/beanie/red"
	greyscale_colors = "#D91414#D91414"

/obj/item/clothing/head/beanie/darkblue
	name = "dark blue beanie"
	icon_state = "/obj/item/clothing/head/beanie/darkblue"
	greyscale_colors = "#1E85BC#1E85BC"

/obj/item/clothing/head/beanie/yellow
	name = "yellow beanie"
	icon_state = "/obj/item/clothing/head/beanie/yellow"
	greyscale_colors = "#E0C14F#E0C14F"

/obj/item/clothing/head/beanie/orange
	name = "orange beanie"
	icon_state = "/obj/item/clothing/head/beanie/orange"
	greyscale_colors = "#C67A4B#C67A4B"

/obj/item/clothing/head/beanie/christmas
	name = "christmas beanie"
	icon_state = "/obj/item/clothing/head/beanie/christmas"
	greyscale_colors = "#038000#960000"

/obj/item/clothing/head/beanie/durathread
	name = "durathread beanie"
	desc = "Um gorro feito de Durathread. Suas fibras resistentes fornecem alguma proteção ao usuário."
	icon_state = "/obj/item/clothing/head/beanie/durathread"
	greyscale_colors = "#8291A1#8291A1"
	armor_type = /datum/armor/beanie_durathread

/obj/item/clothing/head/rasta
	name = "rastacap"
	desc = "Perfeito para colocar esses dreadlocks."
	icon = 'icons/obj/clothing/head/beanie.dmi'
	worn_icon = 'icons/mob/clothing/head/beanie.dmi'
	icon_state = "beanierasta"

/obj/item/clothing/head/waldo
	name = "red striped bobble hat"
	desc = "Se você está indo em uma caminhada mundial, você vai precisar de alguma proteção fria."
	icon = 'icons/obj/clothing/head/beanie.dmi'
	worn_icon = 'icons/mob/clothing/head/beanie.dmi'
	icon_state = "waldo_hat"

//No dog fashion sprites yet :(  poor Ian can't be dope like the rest of us yet

/obj/item/clothing/head/beanie/black/dboy
	name = "test subject beanie"
	desc = "Um gorro preto dingedo e rasgado. Isso é lama ou graxa?"
	/// Used for the extra flavor text the d-boy himself sees
	var/datum/weakref/beanie_owner = null

/datum/armor/beanie_durathread
	melee = 15
	bullet = 5
	laser = 15
	energy = 25
	bomb = 10
	fire = 30
	acid = 5

/obj/item/clothing/head/beanie/black/dboy/equipped(mob/user, slot)
	. = ..()
	if(iscarbon(user) && !beanie_owner)
		beanie_owner = WEAKREF(user)

/obj/item/clothing/head/beanie/black/dboy/examine(mob/user)
	. = ..()
	if(IS_WEAKREF_OF(user, beanie_owner))
		. += span_purple("Está coberto de escombros de outro mundo só seus olhos foram arruinados o suficiente para ver.")
