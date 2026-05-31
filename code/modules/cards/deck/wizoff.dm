//It's Wiz-Off, the wizard themed card game! It's modular too, in case you might want to make it Syndie, Sec and Clown themed or something stupid like that.
/obj/item/toy/cards/deck/wizoff
	name = "\improper Wiz-Off deck"
	desc = "Um convés Wiz-Off. Lute uma batalha arcana pelo destino do universo. Jogue 5! Melhor de 5! Um cartão de regras está anexado."
	cardgame_desc = "Jogo Wiz-Off"
	icon_state = "deck_wizoff_full"
	deckstyle = "wizoff"

/obj/item/toy/cards/deck/wizoff/initialize_cards()
	var/card_list = strings("wizoff.json", "wizard")
	initial_cards += new /datum/deck_card/of_type(/obj/item/toy/singlecard/wizoff_ruleset) // ruleset should be the top card
	for(var/card in card_list)
		initial_cards += card

/obj/item/toy/singlecard/wizoff_ruleset
	desc = "Um conjunto de regras para o jogo Wiz-Off."
	cardname = "Wizoff Ruleset"
	deckstyle = "black"
	has_unique_card_icons = FALSE
	icon_state = "singlecard_down_black"

/obj/item/toy/singlecard/wizoff_ruleset/examine(mob/living/carbon/human/user)
	. = ..()
	. += span_notice("Lembre-se das regras de Wiz-Off!")
	. += span_info("Cada jogador tira 5 cartas.")
	. += span_info("Há cinco tiros. Cada rodada, um jogador seleciona uma carta para jogar, e o vencedor é selecionado com base nas seguintes regras:")
	. += span_info("Defensivo vence ofensivo!")
	. += span_info("Ofensivo vence o utilitário!")
	. += span_info("Utilidade vence Defesa!")
	. += span_info("Se os dois jogadores jogarem o mesmo tipo de feitiço, o maior número ganha!")
	. += span_info("O jogador que ganha a maioria dos 5 rounds ganha o jogo!")
	. += span_notice("Agora prepare-se para lutar pelo destino do universo:")
