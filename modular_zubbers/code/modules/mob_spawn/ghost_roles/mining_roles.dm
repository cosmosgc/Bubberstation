/obj/effect/mob_spawn/ghost_role/human/lavaland_gasstation
	name = "Gas Station Attendant"
	desc = "Parece que tem alguém lá dentro, dormindo pacificamente."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "um trabalhador de posto de gasolina"
	you_are_text = "Você é um trabalhador em uma estação de gás Lizard perto de uma mina."
	flavour_text = "Seu patrão, no entanto, não percebeu que há megafauna hostil e tribos na área, então certifique-se de que você pode se defender. Também vender coisas para as pessoas, ocasionalmente."
	important_text = "Não deixe seu trabalho ser danificado! Não abandone também!"
	quirks_enabled = TRUE
	random_appearance = FALSE
	loadout_enabled = TRUE
	outfit = /datum/outfit/lavaland_gasstation
	allow_custom_character = ALL

/datum/outfit/lavaland_gasstation
	name = "Lizard Gas Station Attendant"
	uniform = /obj/item/clothing/under/costume/lizardgas
	shoes = /obj/item/clothing/shoes/sneakers/black
	ears = /obj/item/instrument/piano_synth/headphones
	gloves = /obj/item/clothing/gloves/fingerless
	head = /obj/item/clothing/head/soft/purple
	l_pocket = /obj/item/modular_computer/pda
	id = /obj/item/card/id/advanced/lizardgas

/datum/outfit/lavaland_gasstation/post_equip(mob/living/carbon/human/clerk, visualsOnly = FALSE)
	var/obj/item/card/id/id_card = clerk.wear_id
	if(istype(id_card))
		id_card.registered_name = clerk.real_name
		id_card.update_label()
		id_card.update_icon()
	handlebank(clerk)
	return ..()

/datum/outfit/hermit
	backpack_contents = list(/obj/item/research_paper = 1)

/datum/outfit/hermit/post_equip(mob/living/carbon/human/hermit, visualsOnly)
	. = ..()
	if(visualsOnly)
		return
	hermit.mind?.teach_crafting_recipe(/datum/crafting_recipe/research_paper)
	to_chat(hermit, span_notice("Você aprende a receita para o<b>Papel de pesquisa</b>, dando-lhe a capacidade de criar tudo do nada."))
