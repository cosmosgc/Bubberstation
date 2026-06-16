/datum/skill/gaming
	name = "Gaming"
	title = "Gamer"
	desc = "Minha proficiência como jogador. Isso me ajuda a vencer os chefes com facilidade, o powergame em Orion Trail, e me faz querer um pouco de combustível para jogadores."
	modifiers = list(SKILL_PROBS_MODIFIER = list(0, 5, 10, 15, 15, 20, 25),
				SKILL_RANDS_MODIFIER = list(0, 1, 2, 3, 4, 5, 7))
	skill_item_path = /obj/item/clothing/neck/cloak/skill_reward/gaming

/datum/skill/gaming/New()
	. = ..()
	levelUpMessages[1] = span_nicegreen("Estou começando a entender os controles desses jogos...")
	levelUpMessages[4] = span_nicegreen("Estou começando a pegar o meta desses jogos de arcade. Se eu fosse para minmax a estratégia ideal e acentuar meu estilo de jogo em torno de tecnologia bem refinado ...")
	levelUpMessages[6] = span_nicegreen("Através de incrível determinação e esforço, atingi o auge da minha [name] Habilidades. Me pergunto como posso me tornar mais poderoso... Talvez o combustível do jogador me ajude a jogar melhor?")
