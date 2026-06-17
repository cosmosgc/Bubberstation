/* This file contains standalone items for debug purposes. */
/obj/item/debug
	abstract_type = /obj/item/debug

/obj/item/debug/human_spawner
	name = "human spawner"
	desc = "Espalhou um humano mirando em um território e clicando. Use na mão para mudar de tipo."
	icon = 'icons/obj/weapons/guns/magic.dmi'
	icon_state = "nothingwand"
	inhand_icon_state = "wand"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/datum/species/selected_species
	var/valid_species = list()

/obj/item/debug/human_spawner/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	return interact_with_atom(interacting_with, user, modifiers)

/obj/item/debug/human_spawner/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(isturf(interacting_with))
		var/mob/living/carbon/human/H = new /mob/living/carbon/human(interacting_with)
		if(selected_species)
			H.set_species(selected_species)
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/item/debug/human_spawner/attack_self(mob/user)
	..()
	var/choice = input("Selecione uma espécie.", "Spawner humano", null) in sortTim(GLOB.species_list, GLOBAL_PROC_REF(cmp_text_asc))
	selected_species = GLOB.species_list[choice]

/obj/item/debug/omnitool
	name = "omnitool"
	desc = "O hipertool original, nascido antes de todos eles. Use-o na mão para liberar seu verdadeiro poder."
	icon = 'icons/obj/weapons/club.dmi'
	icon_state = "hypertool"
	inhand_icon_state = "hypertool"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	toolspeed = 0.1
	tool_behaviour = null

/obj/item/debug/omnitool/examine()
	. = ..()
	. += " The mode is: [tool_behaviour]"

/obj/item/debug/omnitool/proc/check_menu(mob/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated || !user.Adjacent(src))
		return FALSE
	return TRUE

/obj/item/debug/omnitool/get_all_tool_behaviours()
	return GLOB.all_tool_behaviours

/obj/item/debug/omnitool/attack_self(mob/user)
	if(!user)
		return
	var/tool_result = show_radial_menu(user, src, GLOB.tool_to_image, custom_check = CALLBACK(src, PROC_REF(check_menu), user), require_near = TRUE, tooltips = TRUE)
	if(!check_menu(user))
		return
	tool_behaviour = tool_result

/obj/item/debug/omnitool/item_spawner
	name = "spawntool"
	color = COLOR_ADMIN_PINK

/obj/item/debug/omnitool/item_spawner/attack_self(mob/user)
	if(!user || !user.client)
		return
	var/path = text2path(tgui_input_text(user, "Insert an item typepath to spawn", "ADMINS ONLY. FUCK AROUND AND FIND OUT."))
	if(!path)
		return
	var/choice = tgui_alert(user, "Apenas subtipos?",, list("Yes", "No"))
	if(!choice)
		return
	if(!user.client.holder)
		if(!isliving(user))
			return
		var/mob/living/living_user = user
		to_chat(user, span_warning("As you try to use [src], you hear strange tearing sounds, as if the coder gods were attempting to reach out and choke you themselves."))
		playsound(src, 'sound/effects/dimensional_rend.ogg')
		sleep(4 SECONDS)
		var/confirmation = tgui_alert(user, "Tem certeza que quer fazer isso?", "Admins Only. Last Chance.", list("Yes", "No"))
		if(!confirmation || confirmation == ("No"))
			return
		if(!user.client.holder) //safety if the admin readmined to save their ass lol.
			to_chat(user, span_reallybig("Você não deveria ter feito isso..."))
			playsound(src, 'sound/mobs/non-humanoids/cyborg/borg_deathsound.ogg')
			sleep(3 SECONDS)
			living_user.investigate_log("has been gibbed by [src].", INVESTIGATE_DEATHS)
			living_user.gib(DROP_ALL_REMAINS)
			return
	var/turf/loc_turf = get_turf(src)
	for(var/spawn_atom in (choice == "No" ? typesof(path) : subtypesof(path)))
		new spawn_atom(loc_turf)
