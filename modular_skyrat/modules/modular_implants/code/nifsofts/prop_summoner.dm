#define SUMMONED_ITEM_ALPHA 180
#define SUMMONED_ITEM_LIGHT 2

/obj/item/disk/nifsoft_uploader/summoner
	name = "Grimoire Caeruleam"
	loaded_nifsoft = /datum/nifsoft/summoner
	custom_price = PAYCHECK_CREW * 3

/obj/item/disk/nifsoft_uploader/summoner/ghost
	custom_price = 0

/datum/nifsoft/summoner
	name = "Grimoire Caeruleam"
	program_desc = "O Grimoire Caeruleam é um diretório de código aberto, virtual descentralizado de objetos convocáveis originalmente desenvolvido pelo Coven Altspace, um grupo pós-pagão de bruxas digitalizado pela primeira vez em engramas no ano 2544. Essas construções convocáveis, ou \"Icons\", são compostas por padrões delicados de nanomáquinas que servem de estrutura e projetor para a luz dura; o nome \"Caeruleam\" refere-se à luz azul que um ícone lança na mão do chamador. Enquanto o Grimoire serviu milhares até agora, interesses corporativos bloquearam todo o acesso a Ícones capazes de prejudicar seus bens."
	cooldown = TRUE
	activation_cost = 100 // Around 1/10th the energy of a standard NIF
	buying_category = NIFSOFT_CATEGORY_FUN
	ui_icon = "book-open"
	able_to_keep = TRUE // These NIFSofts are mostly for comsetic/fun reasons anyways.

	/// Does the resulting object have a holographic like filter appiled to it?
	var/holographic_filter = TRUE
	/// Is there any special tag added at the begining of the resulting object name?
	var/name_tag = "cerulean "
	purchase_price = 175

	///The list of items that can be summoned from the NIFSoft.
	var/list/summonable_items = list(
		/obj/item/toy/katana/nanite,
		/obj/item/cane/nanite,
		/obj/item/storage/dice/nanite,
		/obj/item/toy/cards/deck/nanite,
		/obj/item/toy/cards/deck/tarot/nanite, //The arcana is the means by which all is revealed
		/obj/item/toy/cards/deck/kotahi/nanite,
		/obj/item/toy/foamblade/nanite,
		/obj/item/cane/white/nanite,
		/obj/item/lighter/nanite,
		/obj/item/holocigarette/nanite,
	)

	///The objects currently summoned by the NIFSoft
	var/list/summoned_items = list()
	///What is the maximum amount of items that can be suummoned?
	var/max_summoned_items = 5

/datum/nifsoft/summoner/activate()
	. = ..()
	if(!.)
		return FALSE

	if(tgui_alert(linked_mob, "Você deseja convocar um novo item ou dissipar um item já existente?", program_name, list("Summon", "Dispel")) == "Dispel")
		refund_activation_cost()
		if(!length(summoned_items))
			linked_mob.balloon_alert(linked_mob, "Você não tem itens convocados!")
			return FALSE

		var/obj/item/choice = tgui_input_list(linked_mob, "Choose an object to desummon.", program_name, summoned_items)

		if(!choice)
			linked_mob.balloon_alert(linked_mob, "Você não escolheu um item!")
			return FALSE

		summoned_items -= choice
		qdel(choice)
		return TRUE

	if(length(summoned_items) >= max_summoned_items)
		linked_mob.balloon_alert(linked_mob, "Você tem a quantidade máxima de itens convocados!")
		refund_activation_cost()
		return FALSE

	var/list/summon_choices = list()
	for(var/obj/item/summon_item as anything in summonable_items)
		var/image/obj_icon = image(icon = initial(summon_item.icon), icon_state = initial(summon_item.icon_state))

		summon_choices[summon_item] = obj_icon

	var/obj/item/choice = show_radial_menu(linked_mob, linked_mob, summon_choices, radius = 42, custom_check = CALLBACK(src, PROC_REF(check_menu), linked_mob))
	if(!choice)
		refund_activation_cost()
		return FALSE

	var/obj/item/new_item = new choice
	new_item.name = name_tag + new_item.name

	if(!linked_mob.put_in_hands(new_item))
		linked_mob.balloon_alert(linked_mob, "[new_item] fails to materialize in your hands!")
		qdel(new_item)
		refund_activation_cost()
		return FALSE

	apply_custom_properties(new_item)
	summoned_items += new_item
	new_item.AddComponent(/datum/component/summoned_item, holographic_filter)

/// This proc is called while an item is being summoned, use this to modifiy aspects of the item that aren't modified by the component.
/datum/nifsoft/summoner/proc/apply_custom_properties(obj/item/target_item)
	if(!target_item)
		return FALSE

	return TRUE

/datum/nifsoft/summoner/Destroy()
	QDEL_LIST(summoned_items)
	return ..()

///Can the person using the NIFSoft summon an item?
/datum/nifsoft/summoner/proc/check_menu(mob/living/carbon/human/user)
	if(!istype(user))
		return FALSE

	return TRUE

/datum/component/summoned_item
	///What items were contained, if any, inside of the summoned item? These are deleted when the item is desummoned.
	var/list/sub_items = list()

/datum/component/summoned_item/Initialize(holographic_filter = TRUE)
	. = ..()
	if(!isobj(parent))
		return COMPONENT_INCOMPATIBLE

	var/obj/item/summoned_item = parent
	if(holographic_filter)
		summoned_item.alpha = SUMMONED_ITEM_ALPHA
		summoned_item.set_light(SUMMONED_ITEM_LIGHT)
		summoned_item.add_atom_colour("#acccff",FIXED_COLOUR_PRIORITY)

		if(istype(summoned_item, /obj/item/storage))
			for(var/obj/item/stored_item as anything in summoned_item)
				stored_item.alpha = SUMMONED_ITEM_ALPHA
				stored_item.set_light(SUMMONED_ITEM_LIGHT)
				stored_item.add_atom_colour("#acccff",FIXED_COLOUR_PRIORITY)
				sub_items += stored_item

		if(istype(summoned_item, /obj/item/toy/cards/deck))
			var/obj/item/toy/cards/deck/summoned_deck = summoned_item
			var/list/cardlist = summoned_deck.fetch_card_atoms()
			if(!cardlist)
				return FALSE

			for(var/obj/item/toy/single_card in cardlist)
				single_card.alpha = SUMMONED_ITEM_ALPHA
				single_card.set_light(SUMMONED_ITEM_LIGHT)
				single_card.add_atom_colour("#acccff",FIXED_COLOUR_PRIORITY)
				sub_items += single_card

/datum/component/summoned_item/Destroy(force, silent)
	for(var/obj/item in sub_items)
		sub_items -= item
		qdel(item)

	return ..()

//Summonable Items
///A somehow wekaer version of the toy katana
/obj/item/toy/katana/nanite
	name = "hexblade"
	special_desc = "Um dos primeiros grupos a contribuir para o repositório de Caeruleam Grimoire foram os Duelistas Malatestan, um grupo de filósofos mercenários que buscavam se tornar mestres indiscutíveis da arte principal de cortar. Originalmente intencionado como um meio de gerar perfeitamente afiado, perfeitamente inquebrável, e perfeitamente capaz da Ação Sancionada: para cortar. No entanto, esses ícones de adereços são apenas uma mera sombra do que os Duelistas originalmente desenvolveram, a única versão do Ícone permitida pela lei interestelar para civis, normalmente visto em andares de convenções ou nas mãos daqueles que desejam lutar sem risco."
	force = 0
	throwforce = 0

/obj/item/storage/dice/nanite
	name = "dice set"
	special_desc = "Uma bela replicação de um lindo conjunto de dados. Estes foram modelados após um conjunto de dados originalmente na posse da Sociedade Seleniana de Wargaming, esculpidos de raros cristais lunares há mais de duzentos anos. Enquanto ninguém além do Primeiro Mestre do Jogo pode rolar até mesmo uma única peça do set original, a Sociedade tem graciosamente doado réplicas virtuais para o repo do Altspace Coven, como um símbolo de sua apreciação pela ajuda em mais formas de ação ao vivo de roleplay."

/obj/item/toy/cards/deck/nanite
	name = "main deck"
	special_desc = "Outra peça de equipamento de jogo graciosamente doada da Sociedade Seleniana de Wargaming, estas cartas empregam um campo localizado de nanites quase invisíveis equipados com software avançado de rastreamento de olhos, para garantir que a exibição nas cartas não permita espiar. Além disso, mais de 500 mil variações do baralho padrão 52 são suportadas, em todas as formas conhecidas de escrita."

/obj/item/toy/cards/deck/tarot/nanite
	name = "tarot deck"
	special_desc = "O baralho de 78 cartas historicamente usado por ocultistas e esoteristas, como as bruxas do clã Altspace. Contendo os maiores segredos da Arcana Maior e os menores segredos da Arcana Menor, o baralho completo é empregado como uma ferramenta chave na caromancia, e diz-se que essas cartas são capazes de obter visão do passado, presente e futuro. As pessoas que os usam para adivinhação perguntam todos os tipos de tópicos, que vão da saúde para questões econômicas, mas o Clã usa para usá-los como um guia para atravessar seu caminho espiritual, alegando que a natureza não física desses cartões digitalmente convocáveis permite aos leitores maior sensibilidade ao próprio destino."

/obj/item/toy/cards/deck/kotahi/nanite
	name = "kotahi deck"
	special_desc = "Kotahi em cargueiros de longo curso! Kotahi em órbita baixa! Kotahi no chão! Kotahi como nunca antes! Por quase seiscentos anos, Kotahi dominou a categoria de jogo de cartas como o primeiro jogo de cartas da galáxia! Mas como levar uma marca amada por milhares de sofonts para o próximo nível? Com a cooperação da Sociedade Seleniana de Wargaming, elevamos Kotahi a um novo campo de jogo: cartões Kotahi digitalmente convocáveis, pelo baixo custo de 200cr, agora sabe por que chamamos de número um."

/obj/item/cane/nanite
	name = "staff"
	special_desc = "Este programa foi contribuído por um grupo de ajuda mútua, a Associação Sapient Rights Recovery, localizada em muitas regiões dos continentes orientais da Terra. As equipes ceruleanas empregam mais nanomáquinas do que hologramas, dando-lhes um núcleo sólido e ponta estável para uso pelos deficientes. Através do uso amplo de pistas sonoras para ajudar os convocadores a navegar no menu, um padrão também foi desenvolvido para indivíduos sem visão tanto por incidente, nascimento e biologia."

	force = 0
	throwforce = 0

/obj/item/cane/white/nanite
	name = "white staff"
	special_desc = "Este programa foi contribuído por um grupo de ajuda mútua, a Associação Sapient Rights Recovery, localizada em muitas regiões dos continentes orientais da Terra. As equipes ceruleanas empregam mais nanomáquinas do que hologramas, dando-lhes um núcleo sólido e ponta estável para uso pelos deficientes. Através do uso amplo de pistas sonoras para ajudar os convocadores a navegar no menu, um padrão também foi desenvolvido para indivíduos sem visão tanto por incidente, nascimento e biologia."

	force = 0
	throwforce = 0

/obj/item/toy/foamblade/nanite
	name = "armblade"
	special_desc = "Este Ícone foi vazado para o Grimoire ilegalmente. Foi originalmente carregado por um membro da Cooperativa Tiger, o texto de download informando o chamador de que este Ícone foi usado pela primeira vez pelos cultistas para usar como \"treinamento para sua Ascensão biológica\" em entidades metamorfosas. Em poucas horas, várias variantes para todos os tipos de configurações de membros sapientes foram bifurcadas e enviadas, esta uma totalmente não letal."

/obj/item/lighter/nanite
	name = "catchflame"
	special_desc = "Uma obra de arte pelos padrões de Ícones normais, esta foi trabalhada por cinco anos contínuos por uma única convocadora, agora conhecida como Neophyte Inverso após a adoção do Ícone pelos poucos membros fisicamente encorpados do Coven Altspace. O trabalho do engram envolve o uso de nanites para inflamar moléculas atmosféricas de hidrogênio, o brilho azul do Ícone que surge da combustão perfeita e completa. Isso permite que o isqueiro funcione exatamente como um zíper normal faria, a descrição de leitura '...útil para acender lareiras, velas e incenso; tente sálvia branca se você puder encomendar algum fora da rede, apenas reze para não dissipar engrams lol.'"

/obj/item/holocigarette/nanite
	name = "cloudstick"
	special_desc = "Uma das muitas tentativas da humanidade de acabar com o legado do Big Tobacco. Fornecido por um engrama totalmente anônimo e bifurcado inúmeras vezes em inúmeras repetições de marcas e sabores, o 'Cloudstick' é mais um gênero do que um único ícone. A maioria dos que podem ser baixados até mesmo permitem que o chamador mude a pixelação da fumaça, para lhes conceder uma experiência mais 'detalhada' da coisa real. Vários convocadores reportam isso para ajudá-los a parar de fumar, outros simplesmente comentam: \"É por isso que eu primeiro baixei o Catchflame.\""


#undef SUMMONED_ITEM_ALPHA
#undef SUMMONED_ITEM_LIGHT
