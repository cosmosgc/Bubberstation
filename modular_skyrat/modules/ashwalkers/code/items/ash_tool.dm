//ASH TOOL
/obj/item/screwdriver/ashwalker
	name = "primitive screwdriver"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "screwdriver"
	post_init_icon_state = null
	random_color = FALSE
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_belt = null

/datum/crafting_recipe/ash_recipe/ash_screwdriver
	name = "Ash Screwdriver"
	result = /obj/item/screwdriver/ashwalker

/obj/item/wirecutters/ashwalker
	name = "primitive wirecutters"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "cutters"
	random_color = FALSE
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_belt = null

/datum/crafting_recipe/ash_recipe/ash_cutters
	name = "Ash Wirecutters"
	result = /obj/item/wirecutters/ashwalker

/obj/item/wrench/ashwalker
	name = "primitive wrench"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "wrench"
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null

/datum/crafting_recipe/ash_recipe/ash_wrench
	name = "Ash Wrench"
	result = /obj/item/wrench/ashwalker

/obj/item/crowbar/ashwalker
	name = "primitive crowbar"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "crowbar"
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null

/datum/crafting_recipe/ash_recipe/ash_crowbar
	name = "Ash Crowbar"
	result = /obj/item/crowbar/ashwalker

/obj/item/cursed_dagger
	name = "cursed ash dagger"
	desc = "Uma adaga embotada que faz as sombras tremerem."
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "crysknife"
	inhand_icon_state = "crysknife"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'

/obj/item/cursed_dagger/examine(mob/user)
	. = ..()
	. += span_notice("Para ser usado em tentáculos. Mudará visualmente o tentáculo para indicar se foi amaldiçoado ou não.")

/obj/item/tendril_seed
	name = "tendril seed"
	desc = "Uma massa carnuda horrível que pulsa com uma energia escura."
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "tendril_seed"

/obj/item/tendril_seed/examine(mob/user)
	. = ..()
	. += span_notice("Para ser plantado, é necessário estar no nível de mineração, bem como no basalto.")

/obj/item/tendril_seed/attack_self(mob/user, modifiers)
	. = ..()
	var/turf/src_turf = get_turf(src)
	if(!is_mining_level(src_turf.z) || !istype(src_turf, /turf/open/misc/asteroid/basalt))
		return
	if(!isliving(user))
		return
	var/mob/living/living_user = user
	to_chat(living_user, span_warning("Você começa a apertar[src]..."))
	if(!do_after(living_user, 4 SECONDS, target = src))
		return
	to_chat(living_user, span_warning("[src]Começa a rastejar entre os apêndices da sua mão, rastejando pelo seu braço..."))
	living_user.adjust_brute_loss(35)
	if(!do_after(living_user, 4 SECONDS, target = src))
		return
	to_chat(living_user, span_warning("[src]envolve-se em torno de seu peito e começa a apertar, causando uma estranha sensação de agulha..."))
	living_user.adjust_brute_loss(35)
	if(!do_after(living_user, 4 SECONDS, target = src))
		return
	to_chat(living_user, span_warning("[src]Salta de você satisfeito e começa a se reunir grosseiramente!"))
	var/type = pick(/obj/structure/spawner/lavaland, /obj/structure/spawner/lavaland/goliath, /obj/structure/spawner/lavaland/legion)
	new type(user.loc)
	playsound(get_turf(src), 'sound/effects/magic/demon_attack1.ogg', 50, TRUE)
	qdel(src)
