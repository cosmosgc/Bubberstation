/// Some defines for items the cult altar can create.
#define ELDRITCH_WHETSTONE "Eldritch Whetstone"
#define CONSTRUCT_SHELL "Construct Shell"
#define UNHOLY_WATER "Flask of Unholy Water"
#define PROTEON_ORB "Portal Summoning Orb"

// Cult altar. Gives out consumable items.
/obj/structure/destructible/cult/item_dispenser/altar
	name = "altar"
	desc = "Um altar manchado de sangue dedicado a Nar'Sie."
	cult_examine_tip = "Can be used to create eldritch whetstones, construct shells, and flasks of unholy water."
	icon_state = "talismanaltar"
	break_message = span_warning("O altar quebra, deixando apenas o lamento dos condenados!")
	mansus_conversion_path = /obj/effect/heretic_rune
	custom_materials = list(/datum/material/runedmetal = SHEET_MATERIAL_AMOUNT * 3)

/obj/structure/destructible/cult/item_dispenser/altar/setup_options()
	var/static/list/altar_items = list(
		ELDRITCH_WHETSTONE = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/antags/cult/items.dmi', icon_state = "cult_sharpener"),
			OUTPUT_ITEMS = list(/obj/item/sharpener/cult),
			RADIAL_DESC = "Fornece\a [/obj/item/sharpener/cult::name]utilizáveis para aumentar os danos de espadas e adagas. Só um uso.",
			),
		CONSTRUCT_SHELL = list(
			PREVIEW_IMAGE = image(icon = 'icons/mob/shells.dmi', icon_state = "construct_cult"),
			OUTPUT_ITEMS = list(/obj/structure/constructshell),
			RADIAL_DESC = "Produz\a [/obj/structure/constructshell::name], que - uma vez fornecido uma sombra através de uma pedra da alma - vai nascer uma construção. Construtos trazem força, agilidade ou utilidade para sua equipe.",
			),
		UNHOLY_WATER = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/drinks/bottles.dmi', icon_state = "unholyflask"),
			OUTPUT_ITEMS = list(/obj/item/reagent_containers/cup/beaker/unholywater),
			RADIAL_DESC = "Fornece\a [/obj/item/reagent_containers/cup/beaker/unholywater::name], que pode ser tomado para curar todos os tipos de danos, incluindo perda de sangue. Também age como um coagulante e estimulante suave (fornecendo resistência simbólica a atordoamentos e danos à resistência).",
			),
	)

	var/extra_item = extra_options()

	options = altar_items
	if(!isnull(extra_item))
		options += extra_item

/obj/structure/destructible/cult/item_dispenser/altar/extra_options()
	if(!cult_team?.unlocked_heretic_items[PROTEON_ORB_UNLOCKED])
		return
	return list(PROTEON_ORB = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/antags/cult/items.dmi', icon_state = "summoning_orb"),
			OUTPUT_ITEMS = list(/obj/item/proteon_orb),
			RADIAL_DESC = "Fornece\a [/obj/item/proteon_orb::name]que pode ser usado para criar um portal, liberando construções menores para a estação."
			),
	)

/obj/structure/destructible/cult/item_dispenser/altar/succcess_message(mob/living/user, obj/item/spawned_item)
	to_chat(user, span_cult_italic("Você se ajoelha diante[src]E sua fé é recompensada com[spawned_item]!"))

#undef ELDRITCH_WHETSTONE
#undef CONSTRUCT_SHELL
#undef UNHOLY_WATER
#undef PROTEON_ORB
