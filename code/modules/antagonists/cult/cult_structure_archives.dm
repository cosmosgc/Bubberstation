/// Some defines for items the cult archives can create.
#define CULT_BLINDFOLD "Zealot's Blindfold"
#define CURSE_ORB "Shuttle Curse"
#define VEIL_WALKER "Veil Walker"
#define CRIMSON_MEDALLION "Crimson Medallion"

// Cult archives. Gives out utility items.
/obj/structure/destructible/cult/item_dispenser/archives
	name = "archives"
	desc = "Uma mesa coberta de manuscritos arcanos e tomos em línguas desconhecidas. Olhar o texto faz sua pele rastejar."
	cult_examine_tip = "Can be used to create zealot's blindfolds, shuttle curse orbs, and veil walker equipment."
	icon_state = "tomealtar"
	light_range = 1.5
	light_color = LIGHT_COLOR_FIRE
	break_message = span_warning("Os livros e tomos dos arquivos queimam em cinzas enquanto a mesa quebra!")
	mansus_conversion_path = /obj/item/codex_cicatrix
	custom_materials = list(/datum/material/runedmetal = SHEET_MATERIAL_AMOUNT * 3)

/obj/structure/destructible/cult/item_dispenser/archives/setup_options()
	var/static/list/archive_items = list(
		CULT_BLINDFOLD = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/clothing/glasses.dmi', icon_state = "blindfold"),
			OUTPUT_ITEMS = list(/obj/item/clothing/glasses/hud/health/night/cultblind),
			RADIAL_DESC = "Cria\a [/obj/item/clothing/glasses/hud/health/night/cultblind::name], uma venda especial que não cega cultistas. Além disso, relata a saúde de amigos e inimigos, oferece visão noturna, e até protege de luzes brilhantes.",
			),
		CURSE_ORB = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/antags/cult/items.dmi', icon_state = "shuttlecurse"),
			OUTPUT_ITEMS = list(/obj/item/shuttle_curse),
			RADIAL_DESC = "Produz um delicado[/obj/item/shuttle_curse::name]que pode ser destruído para amaldiçoar a nave auxiliar se for chamado, atrasando sua chegada por algum tempo. Apenas[MAX_SHUTTLE_CURSES]Pode ser usado.",
			),
		VEIL_WALKER = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/antags/cult/items.dmi', icon_state = "shifter"),
			OUTPUT_ITEMS = list(/obj/item/cult_shift),
			RADIAL_DESC = "Cria\a [/obj/item/cult_shift::name], uma varinha pequena que teleporta o usuário - e qualquer um que o usuário está arrastando - para a frente alguma distância. Tem[/obj/item/cult_shift::uses]usa.",
			),
	)

	var/extra_item = extra_options()

	options = archive_items
	if(!isnull(extra_item))
		options += extra_item

/obj/structure/destructible/cult/item_dispenser/archives/extra_options()
	if(!cult_team?.unlocked_heretic_items[CRIMSON_MEDALLION_UNLOCKED])
		return
	return list(CRIMSON_MEDALLION = list(
			PREVIEW_IMAGE = image(icon = 'icons/obj/clothing/neck.dmi', icon_state = "crimson_medallion"),
			OUTPUT_ITEMS = list(/obj/item/clothing/neck/heretic_focus/crimson_medallion),
			RADIAL_DESC = "Cria um[/obj/item/clothing/neck/heretic_focus/crimson_medallion::name], um artefato poderoso que fornece cura passiva e a capacidade de preparar um feitiço adicional. Também pode ser espremido na mão, consumindo-o para um poderoso efeito de cura.",
			),
	)

/obj/structure/destructible/cult/item_dispenser/archives/succcess_message(mob/living/user, obj/item/spawned_item)
	to_chat(user, span_cult_italic("Você convoca[spawned_item]De[src]!"))

// Preset for the library that doesn't spawn runed metal on destruction, or glow.
/obj/structure/destructible/cult/item_dispenser/archives/library
	icon_state = "tomealtar_off"
	debris = list()

#undef CULT_BLINDFOLD
#undef CURSE_ORB
#undef VEIL_WALKER
#undef CRIMSON_MEDALLION
