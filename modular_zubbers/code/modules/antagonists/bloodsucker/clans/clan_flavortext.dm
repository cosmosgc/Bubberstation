/datum/bloodsucker_clan/gangrel
	name = CLAN_GANGREL
	description = "Mais perto de animais que sanguessugas, conhecidos como lobisomens esperando para acontecer,\n\
Estes são os mais temíveis da Verdadeira Fé, sendo a coisa mais letal que eles já viram na noite.\n\
Luas Cheias não parecem ter efeito, apesar de histórias comuns.\n\
O Ghoul Favorito se transforma num Lobisomem sempre que seu Mestre o faz."
	joinable_clan = FALSE
	blood_drink_type = BLOODSUCKER_DRINK_INHUMANELY

/datum/bloodsucker_clan/gangrel/on_enter_frenzy(datum/antagonist/bloodsucker/source)
	ADD_TRAIT(bloodsuckerdatum.owner.current, TRAIT_STUNIMMUNE, FRENZY_TRAIT)

/datum/bloodsucker_clan/gangrel/on_exit_frenzy(datum/antagonist/bloodsucker/source)
	REMOVE_TRAIT(bloodsuckerdatum.owner.current, TRAIT_STUNIMMUNE, FRENZY_TRAIT)

/datum/bloodsucker_clan/gangrel/handle_clan_life(datum/antagonist/bloodsucker/source, seconds_per_tick, times_fired)
	. = ..()
	var/area/current_area = get_area(bloodsuckerdatum.owner.current)
	if(istype(current_area, /area/station/service/chapel))
		to_chat(bloodsuckerdatum.owner.current, span_warning("Você não pertence a áreas sagradas! A Fé queima você!"))
		bloodsuckerdatum.owner.current.adjust_fire_loss(20)
		bloodsuckerdatum.owner.current.adjust_fire_stacks(2)
		bloodsuckerdatum.owner.current.ignite_mob()

/datum/bloodsucker_clan/toreador
	name = CLAN_TOREADOR
	description = "O Clã mais charmoso de todos, permitindo que se disfarcem facilmente entre a tripulação.\n\
Mais em contato com sua moral, eles sofrem e se beneficiam mais fortemente com o custo ou ganho da humanidade de suas ações.\n\
Conhecidos como \"O tipo mais humano de vampiro\", eles têm uma obsessão com perfeccionismo e beleza.\n\
O Ghoul Favorito ganha a habilidade Mesmerize."
	joinable_clan = FALSE
	blood_drink_type = BLOODSUCKER_DRINK_SNOBBY

/datum/bloodsucker_clan/brujah
	name = CLAN_BRUJAH
	description = "O Clã Brujah provou ser o mais forte em combate melee, com um poderoso soco.\n\
Eles também parecem estar mais calmos do que os outros, entrando em suas \"frênzies\" sempre que querem, mas não parecem muito afetados por eles.\n\
Seja cauteloso, pois eles são temíveis guerreiros, rebeldes e anarquistas, com uma inclinação para Frenzy.\n\
O Ghoul Favorito ganha força e um enorme aumento no dano bruto por socos."
	joinable_clan = FALSE

/datum/bloodsucker_clan/tzimisce
	name = CLAN_TZIMISCE
	description = "O Clã Tzimisce não tem conhecimento sobre isso.\n\
Se vir um, deveria fugir.\n\
O resto da página está cheio de rabiscos indecifráveis..."
	joinable_clan = FALSE
