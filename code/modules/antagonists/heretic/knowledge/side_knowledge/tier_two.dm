/*!
 * Tier 2 knowledge: Defensive tools and curses
 */

/**
 * Codex Morbus, an upgrade to the base codex
 * Functionally an upgraded version of the codex, but it also has the ability to cast curses by right clicking at a rune.
 * Requires you to have the blood of your victim in your off-hand
 */
/datum/heretic_knowledge/codex_morbus
	name = "Codex Morbus"
	desc = "Permite que você combine uma cicatrix códice, e um corpo em um Códice Morbus.\
Ele desenha runas e suga essências um pouco mais rápido.\
Clique em uma runa para amaldiçoar membros da tripulação, o sangue do alvo é exigido em sua mão para que uma maldição faça efeito."
	gain_text = "A espinha desse couro range com um suspiro terrivelmente doloroso.\
Para ply page do lugar faz um esforço considerável, e eu não ouso demorar nas sugestões que o livro faz por mais tempo do que o necessário.\
Fala de pragas vindouras, de suplicantes de deuses mortos e esquecidos, e a ruína da espécie mortal.\
Ele fala de agulhas para descascar a pele do mundo de volta e deixá-la apodrecer. E me fala pelo nome."
	required_atoms = list(
		/obj/item/codex_cicatrix = 1,
		/mob/living/carbon/human = 1,
	)
	result_atoms = list(/obj/item/codex_cicatrix/morbus)
	cost = 2
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "book_morbus"
	drafting_tier = 2

/datum/heretic_knowledge/codex_morbus/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	var/mob/living/carbon/human/to_fuck_up = locate() in selected_atoms
	for(var/_limb in to_fuck_up.get_bodyparts())
		var/obj/item/bodypart/limb = _limb
		limb.force_wound_upwards(/datum/wound/slash/flesh/critical)
	for(var/obj/item/bodypart/limb as anything in to_fuck_up.get_bodyparts())
		to_fuck_up.cause_wound_of_type_and_severity(WOUND_BLUNT, limb, WOUND_SEVERITY_CRITICAL)
	return TRUE

/datum/heretic_knowledge/greaves_of_the_prophet
	name = "Greaves Of The Prophet"
	desc = "Permite combinar um par de sapatos e duas folhas de titânio ou prata em um par de Greaves blindados, eles conferem ao usuário imunidade total para escorregar."
	gain_text = " \
Gristle gira em conjunto, um pop, e o tolo torce um pé preto do\
mandíbulas de outro. Em seu jogo por séculos, esta árvore mutilada de membros torce,\
Derrubando armadilhas enterradas em gengivas roncando, procurando rasgar o peso do enxertado\
Vizinhos. Pesado por pés lacerados, este dossel de idiotas rançosos sempre procura\
A ruína de seus próprios laços. Eu temo a idéia de andar em seu caminho, mas\
Eu devo pressionar do mesmo jeito. Seus ritmos mantêm a rixa fresca com indiferença\
à barreira ou fronteira. Colocando mais em seu tumulto enquanto valsa."
	required_atoms = list(
		/obj/item/clothing/shoes = 1,
		list(/obj/item/stack/sheet/mineral/titanium, /obj/item/stack/sheet/mineral/silver) = 2,
	)
	result_atoms = list(/obj/item/clothing/shoes/greaves_of_the_prophet)
	cost = 2
	research_tree_icon_path = 'icons/obj/clothing/shoes.dmi'
	research_tree_icon_state = "hereticgreaves"
	drafting_tier = 2

/datum/heretic_knowledge/spell/opening_blast
	name = "Wave Of Desperation"
	desc = "Concede-lhe Onda de Desparação, um feitiço que só pode ser lançado enquanto está contido.\
Ele remove suas amarras, repele e derruba pessoas adjacentes, e aplica o Mansus Grasp em tudo próximo."
	gain_text = "Minhas algemas desfeitas em fúria escura, suas amarras fracas se desfazem diante do meu poder."

	action_to_add = /datum/action/cooldown/spell/aoe/wave_of_desperation
	cost = 2
	drafting_tier = 2

/datum/heretic_knowledge/rune_carver
	name = "Carving Knife"
	desc = "Permite que transmute uma faca, um pedaço de vidro, e um pedaço de papel para criar uma faca esculpida.\
A Faca de Esculpir permite que você etch difícil de ver armadilhas que desencadeiam pagãos que andam acima.\
Também é uma arma de atirar."
	gain_text = "Esculpida, esculpida... Eterna. Há poder escondido em tudo. Eu posso revelar!\
Posso esculpir o monólito para revelar as correntes!"
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/shard = 1,
		/obj/item/paper = 1,
	)
	result_atoms = list(/obj/item/melee/rune_carver)
	cost = 2
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "rune_carver"
	drafting_tier = 2

/datum/heretic_knowledge/ether
	name = "Ether Of The Newborn"
	desc = "Transmuta uma poça de vômito e um caco em uma poção de uso único, bebendo-a irá remover qualquer tipo de anormalidade do seu corpo, incluindo doenças, traumas e implantes.\
além de restaurá-lo à plena saúde, ao custo de perder a consciência por um minuto inteiro."
	gain_text = "A visão e o pensamento ficam nebulosos à medida que os vapores desse ichor giram para me encontrar.\
Através da neblina, eu me encontro olhando para trás em alívio, ou algo grosseiramente parecido com minha aparência.\
É essa coisa miserável que eu conferi ao meu destino, e de quem eu arrebato através da névoa dos sonhos. Tolos que somos."
	required_atoms = list(
		/obj/item/shard = 1,
		/obj/effect/decal/cleanable/vomit = 1,
	)
	result_atoms = list(/obj/item/ether)
	cost = 2
	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "poison_flask"
	drafting_tier = 2

/datum/heretic_knowledge/painting
	name = "Unsealed Arts"
	desc = "Permite que transmute uma tela e um item adicional para criar uma pintura.\
Cada pintura tem um efeito único e receita. Possíveis pinturas:\
A irmã e aquele que chorou requer um par de olhos. Limpa sua mente, e amaldiçoa não hereges com alucinações.\
A Festa do Desejo requer um membro cortado. Fornece órgãos aleatórios, e amaldiçoa não hereges com fome de carne.\
Grande Chaparral Over Rolling Hills requer qualquer produto vegetal. Espalha kudzu quando colocado, e lhe fornece papoulas e lebres.\
Requer qualquer par de luvas. Limpa suas mutações, muta não hereges e as amaldiçoa com arranhões.\
Mestre da Montanha Rusted requer um pedaço de Lixo. Malditos não hereges para enferrujar o chão em que andam."
	gain_text = "Um vento de inspiração sopra através de mim. Além do véu e depois do portão existem grandes obras, ainda para serem pintadas.\
Eles anseiam por olhos mortais, então lhes darei uma audiência."
	required_atoms = list(/obj/item/canvas = 1)
	result_atoms = list(/obj/item/canvas)
	cost = 2
	research_tree_icon_path = 'icons/obj/signs.dmi'
	research_tree_icon_state = "eldritch_painting_weeping"
	drafting_tier = 2

/datum/heretic_knowledge/painting/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	if(locate(/obj/item/organ/eyes) in atoms)
		src.result_atoms = list(/obj/item/wallframe/painting/eldritch/weeping)
		src.required_atoms = list(
			/obj/item/canvas = 1,
			/obj/item/organ/eyes = 1,
		)
		return TRUE

	if(locate(/obj/item/bodypart) in atoms)
		src.result_atoms = list(/obj/item/wallframe/painting/eldritch/desire)
		src.required_atoms = list(
			/obj/item/canvas = 1,
			/obj/item/bodypart = 1,
		)
		return TRUE

	if(locate(/obj/item/food/grown) in atoms)
		src.result_atoms = list(/obj/item/wallframe/painting/eldritch/vines)
		src.required_atoms = list(
			/obj/item/canvas = 1,
			/obj/item/food/grown = 1,
		)
		return TRUE

	if(locate(/obj/item/clothing/gloves) in atoms)
		src.result_atoms = list(/obj/item/wallframe/painting/eldritch/beauty)
		src.required_atoms = list(
			/obj/item/canvas = 1,
			/obj/item/clothing/gloves = 1,
		)
		return TRUE

	if(locate(/obj/item/trash) in atoms)
		src.result_atoms = list(/obj/item/wallframe/painting/eldritch/rust)
		src.required_atoms = list(
			/obj/item/canvas = 1,
			/obj/item/trash = 1,
		)
		return TRUE

	user.balloon_alert(user, "Nenhum átomo adicional presente!")
	return FALSE
