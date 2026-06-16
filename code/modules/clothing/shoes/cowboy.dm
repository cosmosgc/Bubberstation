/obj/item/clothing/shoes/cowboy
	name = "cowboy boots"
	desc = "Um pequeno adesivo mostra que foram inspecionados para cobras, não está claro há quanto tempo a inspeção aconteceu..."
	icon_state = "cowboy_brown"
	armor_type = /datum/armor/shoes_cowboy
	custom_price = PAYCHECK_CREW
	fastening_type = SHOES_SLIPON
	interaction_flags_mouse_drop = NEED_HANDS | NEED_DEXTERITY

	var/max_occupants = 4
	/// Do these boots have spur sounds?
	var/has_spurs = FALSE
	/// The jingle jangle jingle of our spurs
	var/list/spur_sound = list('sound/effects/footstep/spurs1.ogg'=1,'sound/effects/footstep/spurs2.ogg'=1,'sound/effects/footstep/spurs3.ogg'=1)

/datum/armor/shoes_cowboy
	bio = 90

/obj/item/clothing/shoes/cowboy/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/shoes)
	if(prob(2)) //There's a snake in my boot
		new /mob/living/basic/snake(src)
	if(has_spurs)
		LoadComponent(/datum/component/squeak, spur_sound, 50, falloff_exponent = 20)
	AddElement(/datum/element/ignites_matches)

/obj/item/clothing/shoes/cowboy/equipped(mob/living/carbon/user, slot)
	. = ..()
	RegisterSignal(user, COMSIG_LIVING_SLAM_TABLE, PROC_REF(table_slam), override = TRUE)
	if(slot & ITEM_SLOT_FEET)
		for(var/mob/living/occupant in contents)
			var/target_zone = user.get_random_valid_zone(blacklisted_parts = list(BODY_ZONE_CHEST, BODY_ZONE_HEAD, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM), even_weights = TRUE, bypass_warning = TRUE)
			if(!target_zone) //we broke their legs right on off!
				break
			occupant.forceMove(user.drop_location())
			user.visible_message(span_warning("[user] Recua como algo que sai de [src]."), span_userdanger("Você sente uma dor súbita no seu[pick("foot", "toe", "ankle")]!"))
			user.Knockdown(20) //Is one second paralyze better here? I feel you would fall on your ass in some fashion.
			occupant.UnarmedAttack(user, proximity_flag = TRUE)

/obj/item/clothing/shoes/cowboy/dropped(mob/living/user)
	. = ..()
	UnregisterSignal(user, COMSIG_LIVING_SLAM_TABLE)

/obj/item/clothing/shoes/cowboy/proc/table_slam(mob/living/source, obj/structure/table/the_table)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(handle_table_slam), source)

/obj/item/clothing/shoes/cowboy/proc/handle_table_slam(mob/living/user)
	user.say(pick("Droga!", "Hoo-wee!", "Got-dang!"), spans = list(SPAN_YELL), forced=TRUE)
	user.client?.give_award(/datum/award/achievement/misc/hot_damn, user)

/obj/item/clothing/shoes/cowboy/mouse_drop_receive(mob/living/target, mob/living/user, params)
	. = ..()
	if(!(user.mobility_flags & MOBILITY_USE) || !isliving(target))
		return
	if(contents.len >= max_occupants)
		to_chat(user, span_warning("[src] Estão cheios!"))
		return
	if(istype(target, /mob/living/basic/snake) || istype(target, /mob/living/basic/headslug) || islarva(target))
		target.forceMove(src)
		to_chat(user, span_notice("[target] Desliza para dentro [src]."))

/obj/item/clothing/shoes/cowboy/container_resist_act(mob/living/user)
	if(!do_after(user, 1 SECONDS, target = user))
		return
	user.forceMove(drop_location())

/obj/item/clothing/shoes/cowboy/white
	name = "white cowboy boots"
	icon_state = "cowboy_white"

/obj/item/clothing/shoes/cowboy/black
	name = "black cowboy boots"
	desc = "Você acha que alguém pode ter sido enforcado com essas botas."
	icon_state = "cowboy_black"

/obj/item/clothing/shoes/cowboy/fancy
	name = "bilton wrangler boots"
	desc = "Um par de botas de alta costura autênticas do Japão. Você duvida que eles já estiveram perto de gado."
	icon_state = "cowboy_fancy"
	armor_type = /datum/armor/cowboy_fancy

/datum/armor/cowboy_fancy
	bio = 95

/obj/item/clothing/shoes/cowboy/lizard
	name = "lizardskin boots"
	desc = "Você pode ouvir um sibilo fraco de dentro das botas, você espera que seja apenas um fantasma triste."
	icon = 'icons/map_icons/clothing/shoes.dmi'
	icon_state = "/obj/item/clothing/shoes/cowboy/lizard"
	post_init_icon_state = "lizardboots"
	greyscale_config = /datum/greyscale_config/lizard_shoes
	greyscale_config_worn = /datum/greyscale_config/lizard_shoes/worn
	greyscale_colors = "#859333"
	armor_type = /datum/armor/cowboy_lizard

/datum/armor/cowboy_lizard
	bio = 90
	fire = 40

/obj/item/clothing/shoes/cowboy/lizard/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	var/obj/item/stack/sheet/animalhide/carbon/lizard/skin = locate() in components
	if (isnull(skin) || !length(skin.skin_color)) // what
		return ..()
	set_greyscale(skin.skin_color)
	return ..()

/obj/item/clothing/shoes/cowboy/lizard/masterwork
	name = "\improper Hugs-The-Feet lizardskin boots"
	desc = "Um par de botas de pele de lagarto. Finalmente uma boa aplicação para os habitantes mais incomodados da estação."
	greyscale_colors = "#3e76a7"

/// Shoes for the nuke-ops cowboy fit
/obj/item/clothing/shoes/cowboy/black/syndicate
	name = "black spurred cowboy boots"
	desc = "E eles cantam, não está feliz por ser solteiro? E essa música não está muito longe de ser errada."
	armor_type = /datum/armor/shoes_combat
	has_spurs = TRUE
	body_parts_covered = FEET|LEGS

// Laced variants for loadout
/obj/item/clothing/shoes/cowboy/laced
	fastening_type = SHOES_LACED

/obj/item/clothing/shoes/cowboy/white/laced
	fastening_type = SHOES_LACED

/obj/item/clothing/shoes/cowboy/black/laced
	fastening_type = SHOES_LACED
