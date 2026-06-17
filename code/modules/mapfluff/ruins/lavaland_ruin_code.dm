//If you're looking for spawners like ash walker eggs, check ghost_role_spawners.dm

///Wizard tower item
/obj/item/disk/design_disk/knight_gear
	name = "Magic Disk of Smithing"

/obj/item/disk/design_disk/knight_gear/Initialize(mapload)
	. = ..()
	blueprints += new /datum/design/knight_armour
	blueprints += new /datum/design/knight_helmet

//Free Golems

/obj/item/disk/design_disk/golem_shell
	name = "Golem Creation Disk"
	desc = "Um presente do Libertador."
	icon_state = "datadisk1"

/obj/item/disk/design_disk/golem_shell/Initialize(mapload)
	. = ..()
	blueprints += new /datum/design/golem_shell

/datum/design/golem_shell
	name = "Golem Shell Construction"
	desc = "Permite a construção de uma Shell Golem."
	id = "golem"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*20)
	build_path = /obj/item/golem_shell
	category = list(RND_CATEGORY_IMPORTED)

/obj/item/golem_shell
	name = "incomplete free golem shell"
	icon = 'icons/mob/shells.dmi'
	icon_state = "shell_unfinished"
	desc = "O corpo incompleto de um golem. Adicione dez folhas de certos minerais para terminar."
	w_class = WEIGHT_CLASS_BULKY
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20)
	/// Amount of minerals you need to feed the shell to wake it up
	var/required_stacks = 10
	/// Type of shell to create
	var/shell_type = /obj/effect/mob_spawn/ghost_role/human/golem

/obj/item/golem_shell/attackby(obj/item/potential_food, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(!isstack(potential_food))
		balloon_alert(user, "Não é um mineral!")
		return
	var/obj/item/stack/stack_food = potential_food
	var/stack_type = stack_food.merge_type
	if (!is_path_in_list(stack_type, GLOB.golem_stack_food_directory))
		balloon_alert(user, "Mineral incompatível!")
		return
	if(stack_food.amount < required_stacks)
		balloon_alert(user, "Não há minerais suficientes!")
		return
	if(!do_after(user, delay = 4 SECONDS, target = src))
		return
	if(!stack_food.use(required_stacks))
		balloon_alert(user, "Não há minerais suficientes!")
		return
	new shell_type(get_turf(src), /* creator = */ user, /* made_of = */ stack_type)
	qdel(src)

/obj/item/golem_shell/crowbar_act(mob/living/user, obj/item/tool)
	. = ..()

	to_chat(user, span_notice("Você começa a deslocar pedaços estruturalmente integrais."))
	playsound(src, 'sound/items/tools/crowbar.ogg',  70)
	if(!do_after(user, delay = 1 SECONDS, target = src))
		return
	if(QDELETED(src))
		return
	new /obj/item/stack/sheet/mineral/adamantine(get_turf(src), 1) //Return less than was used to construct the shell
	to_chat(user, span_notice("A concha entra em colapso!"))
	playsound(src, 'sound/effects/rock/rock_break.ogg', 40)
	qdel(src)
	return

///made with xenobiology, the golem obeys its creator
/obj/item/golem_shell/servant
	name = "incomplete servant golem shell"
	shell_type = /obj/effect/mob_spawn/ghost_role/human/golem/servant
	custom_materials = list(/datum/material/adamantine = SHEET_MATERIAL_AMOUNT * 3)
