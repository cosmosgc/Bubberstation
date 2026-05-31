// These icon_states may be overridden, but are for mapper's convinence
/obj/item/poster/random_contraband
	name = "random contraband poster"
	poster_type = /obj/structure/sign/poster/contraband/random
	icon_state = "rolled_poster"

/obj/item/poster/random_contraband/Initialize(mapload, obj/structure/sign/poster/new_poster_structure)
	. = ..()
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)

/// Creates a random poster designed for a certain audience
/obj/item/poster/random_contraband/pinup
	name = "random pinup poster"
	icon_state = "rolled_poster"
	/// List of posters which make you feel a certain type of way
	var/static/list/pinup_posters = list(
		/obj/structure/sign/poster/contraband/lizard,
		/obj/structure/sign/poster/contraband/lusty_xenomorph,
		/obj/structure/sign/poster/contraband/double_rainbow,
	)

/obj/item/poster/random_contraband/pinup/Initialize(mapload, obj/structure/sign/poster/new_poster_structure)
	poster_type = pick(pinup_posters)
	return ..()

/obj/structure/sign/poster/contraband
	poster_item_name = "contraband poster"
	poster_item_desc = "Este pôster vem com seu próprio mecanismo adesivo automático, para fácil fixação a qualquer superfície vertical. Seus temas vulgares o marcaram como contrabando a bordo de instalações espaciais de Nanotrasen."
	poster_item_icon_state = "rolled_poster"

/obj/structure/sign/poster/contraband/random
	name = "random contraband poster"
	icon_state = "random_contraband"
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster/contraband

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/random, 32)

/obj/structure/sign/poster/contraband/free_tonto
	name = "Free Tonto"
	desc = "Um pedaço de uma bandeira muito maior, cores sangram juntas e desaparecem desde a idade."
	icon_state = "free_tonto"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/free_tonto, 32)

/obj/structure/sign/poster/contraband/atmosia_independence
	name = "Atmosia Declaration of Independence"
	desc = "Uma relíquia de uma rebelião fracassada."
	icon_state = "atmosia_independence"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/atmosia_independence, 32)

/obj/structure/sign/poster/contraband/fun_police
	name = "Fun Police"
	desc = "Um cartaz condenando as forças de segurança da estação."
	icon_state = "fun_police"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/fun_police, 32)

/obj/structure/sign/poster/contraband/lusty_xenomorph
	name = "Lusty Xenomorph"
	desc = "Um cartaz herético retratando a estrela titular de um livro igualmente herético."
	icon_state = "lusty_xenomorph"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/lusty_xenomorph, 32)

/obj/structure/sign/poster/contraband/syndicate_recruitment
	name = "Syndicate Recruitment"
	desc = "Veja a galáxia! Destruir megacorporações corruptas! Juntem-se hoje!"
	icon_state = "syndicate_recruitment"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/syndicate_recruitment, 32)

/obj/structure/sign/poster/contraband/clown
	name = "Clown"
	desc = "Honk."
	icon_state = "clown"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/clown, 32)

/obj/structure/sign/poster/contraband/smoke
	name = "Smoke"
	desc = "Um cartaz anuncia uma marca rival de charutos."
	icon_state = "smoke"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/smoke, 32)

/obj/structure/sign/poster/contraband/grey_tide
	name = "Grey Tide"
	desc = "Um Cartaz se rebelou simulando solidariedade assistência."
	icon_state = "grey_tide"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/grey_tide, 32)

/obj/structure/sign/poster/contraband/missing_gloves
	name = "Missing Gloves"
	desc = "Este pôster faz referência ao tumulto que seguiu os cortes financeiros de Nanotrasen em direção às compras de luvas isoladas."
	icon_state = "missing_gloves"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/missing_gloves, 32)

/obj/structure/sign/poster/contraband/hacking_guide
	name = "Hacking Guide"
	desc = "Este cartaz detalha o funcionamento interno da câmara de ar comum Nanotrasen. Infelizmente, parece desatualizado."
	icon_state = "hacking_guide"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/hacking_guide, 32)

/obj/structure/sign/poster/contraband/rip_badger
	name = "RIP Badger"
	desc = "Este cartaz sedicioso faz referência ao genocídio de Nanotrasen de uma estação espacial cheia de texugos."
	icon_state = "rip_badger"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/rip_badger, 32)

/obj/structure/sign/poster/contraband/ambrosia_vulgaris
	name = "Ambrosia Vulgaris"
	desc = "Este pôster está parecendo um cara bem doido."
	icon_state = "ambrosia_vulgaris"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/ambrosia_vulgaris, 32)

/obj/structure/sign/poster/contraband/donut_corp
	name = "Donut Corp."
	desc = "Este cartaz é um anúncio não autorizado para Donut Corp."
	icon_state = "donut_corp"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/donut_corp, 32)

/obj/structure/sign/poster/contraband/eat
	name = "EAT."
	desc = "Esta cartaz promova uma gula."
	icon_state = "eat"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/eat, 32)

/obj/structure/sign/poster/contraband/tools
	name = "Tools"
	desc = "Este pôster parece um anúncio para ferramentas, mas na verdade é um golpe subliminar nas ferramentas da CentCom."
	icon_state = "tools"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/tools, 32)

/obj/structure/sign/poster/contraband/power
	name = "Power"
	desc = "Um cartaz que posiciona o parecer do poder fora de Nanotrasen."
	icon_state = "power"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/power, 32)

/obj/structure/sign/poster/contraband/space_cube
	name = "Space Cube"
	desc = "Ignorante da criação harmônica do Cubo Espacial 6 da Natureza, os homens do espaço são burros, educados, Singularidade estúpida e má."
	icon_state = "space_cube"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/space_cube, 32)

/obj/structure/sign/poster/contraband/communist_state
	name = "Communist State"
	desc = "Todos saúdem o Partido Comunista!"
	icon_state = "communist_state"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/communist_state, 32)

/obj/structure/sign/poster/contraband/lamarr
	name = "Lamarr"
	desc = "Esta cartaz retrata Lamarr. Provavelmente feito por um traidor diretor de pesquisa."
	icon_state = "lamarr"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/lamarr, 32)

/obj/structure/sign/poster/contraband/borg_fancy_1
	name = "Borg Fancy"
	desc = "Ser chique pode ser para qualquer borg, só preciso de um terno."
	icon_state = "borg_fancy_1"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/borg_fancy_1, 32)

/obj/structure/sign/poster/contraband/borg_fancy_2
	name = "Borg Fancy v2"
	desc = "Borg Fancy, agora só está mais chique."
	icon_state = "borg_fancy_2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/borg_fancy_2, 32)

/obj/structure/sign/poster/contraband/kss13
	name = "Kosmicheskaya Stantsiya 13 Does Not Exist"
	desc = "Um cartaz zombando da negação da CentCom da existência da estação abandonada perto da Estação Espacial 13."
	icon_state = "kss13"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/kss13, 32)

/obj/structure/sign/poster/contraband/rebels_unite
	name = "Rebels Unite"
	desc = "Um cartaz incitando o espectador a se rebelar contra Nanotrasen."
	icon_state = "rebels_unite"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/rebels_unite, 32)

/obj/structure/sign/poster/contraband/c20r
	// have fun seeing this poster in "spawn 'c20r'", admins...
	name = "C-20r"
	desc = "Um pôster anunciando o C-20r de Armas Scarborough."
	icon_state = "c20r"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/c20r, 32)

/obj/structure/sign/poster/contraband/have_a_puff
	name = "Have a Puff"
	desc = "Quem se importa com câncer de pulmão quando está chapado?"
	icon_state = "have_a_puff"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/have_a_puff, 32)

/obj/structure/sign/poster/contraband/revolver
	name = "Revolver"
	desc = "Porque sete tiros são tudo que você precisa."
	icon_state = "revolver"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/revolver, 32)

/obj/structure/sign/poster/contraband/d_day_promo
	name = "D-Day Promo"
	desc = "Um Cartaz promocional para um rapper."
	icon_state = "d_day_promo"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/d_day_promo, 32)

/obj/structure/sign/poster/contraband/syndicate_pistol
	name = "Syndicate Pistol"
	desc = "Um pôster de propaganda de pistolas como sendo 'classico como foda'. Está coberto de placas de gangue."
	icon_state = "syndicate_pistol"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/syndicate_pistol, 32)

/obj/structure/sign/poster/contraband/energy_swords
	name = "Energy Swords"
	desc = "Todas as cores do maldito arco-íris assassino."
	icon_state = "energy_swords"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/energy_swords, 32)

/obj/structure/sign/poster/contraband/red_rum
	name = "Red Rum"
	desc = "Olhar para este cartaz faz você querer matar."
	icon_state = "red_rum"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/red_rum, 32)

/obj/structure/sign/poster/contraband/cc64k_ad
	name = "CC 64K Ad"
	desc = "O último computador portátil do camarada Computing, com 64kB de carneiro!"
	icon_state = "cc64k_ad"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/cc64k_ad, 32)

/obj/structure/sign/poster/contraband/punch_shit
	name = "Punch Shit"
	desc = "Lutar sem motivo, como um homem!"
	icon_state = "punch_shit"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/punch_shit, 32)

/obj/structure/sign/poster/contraband/the_griffin
	name = "The Griffin"
	desc = "O Griffin ordena que seja o pior que pode ser. Você vai?"
	icon_state = "the_griffin"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/the_griffin, 32)

/obj/structure/sign/poster/contraband/lizard
	name = "Lizard"
	desc = "Este cartaz obsceno retrata um lagoto se preparando para acasalar."
	icon_state = "lizard"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/lizard, 32)

/obj/structure/sign/poster/contraband/free_drone
	name = "Free Drone"
	desc = "Este pôster comemora a bravura do drone rebelde, uma vez exilado, e depois finalmente destruído pela CentCom."
	icon_state = "free_drone"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/free_drone, 32)

/obj/structure/sign/poster/contraband/busty_backdoor_xeno_babes_6
	name = "Busty Backdoor Xeno Babes 6"
	desc = "Pegue uma carga, ou dê, desses Xenos naturais!"
	icon_state = "busty_backdoor_xeno_babes_6"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/busty_backdoor_xeno_babes_6, 32)

/obj/structure/sign/poster/contraband/robust_softdrinks
	name = "Robust Softdrinks"
	desc = "Mais robusto que uma caixa de ferramentas na cabeça!"
	icon_state = "robust_softdrinks"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/robust_softdrinks, 32)

/obj/structure/sign/poster/contraband/shamblers_juice
	name = "Shambler's Juice"
	desc = "Agite-me um pouco daquele suco de Shambler!"
	icon_state = "shamblers_juice"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/shamblers_juice, 32)

/obj/structure/sign/poster/contraband/pwr_game
	name = "Pwr Game"
	desc = "O poder que os jogadores crave! Em parceria com Vlad's Salad."
	icon_state = "pwr_game"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/pwr_game, 32)

/obj/structure/sign/poster/contraband/starkist
	name = "Star-kist"
	desc = "Beba como estrelas!"
	icon_state = "starkist"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/starkist, 32)

/obj/structure/sign/poster/contraband/space_cola
	name = "Space Cola"
	desc = "Sua cola favorita, no espaço."
	icon_state = "space_cola"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/space_cola, 32)

/obj/structure/sign/poster/contraband/space_up
	name = "Space-Up!"
	desc = "Foi sugado para o espaço pelo FLAVOR!"
	icon_state = "space_up"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/space_up, 32)

/obj/structure/sign/poster/contraband/kudzu
	name = "Kudzu"
	desc = "Um pôster anunciando um filme sobre plantas. Quão perigosos poderiam ser?"
	icon_state = "kudzu"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/kudzu, 32)

/obj/structure/sign/poster/contraband/masked_men
	name = "Masked Men"
	desc = "Um cartaz anunciando um filme sobre homens mascarados."
	icon_state = "masked_men"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/masked_men, 32)

//don't forget, you're here forever

/obj/structure/sign/poster/contraband/free_key
	name = "Free Syndicate Encryption Key"
	desc = "Um cartaz sobre traidores implorando por mais."
	icon_state = "free_key"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/free_key, 32)

/obj/structure/sign/poster/contraband/bountyhunters
	name = "Bounty Hunters"
	desc = "Um cartaz de serviços de caça à recompensa.\"Soube que tem um problema.\""
	icon_state = "bountyhunters"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/bountyhunters, 32)

/obj/structure/sign/poster/contraband/the_big_gas_giant_truth
	name = "The Big Gas Giant Truth"
	desc = "Não acreditem em tudo que veem em um cartaz, patriotas. Todos os lagartos do comando central não querem responder a esta pergunta simples: de onde está o mineiro de gás, CENTCOM?"
	icon_state = "the_big_gas_giant_truth"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/the_big_gas_giant_truth, 32)

/obj/structure/sign/poster/contraband/got_wood
	name = "Got Wood?"
	desc = "Um anúncio sujo para uma empresa de madeira.\"Você tem um amigo em mim.\"está rabiscado no canto."
	icon_state = "got_wood"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/got_wood, 32)

/obj/structure/sign/poster/contraband/moffuchis_pizza
	name = "Moffuchi's Pizza"
	desc = "Pizzaria Moffuchi: pizza de estilo familiar por 2 séculos."
	icon_state = "moffuchis_pizza"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/moffuchis_pizza, 32)

/obj/structure/sign/poster/contraband/donk_co
	name = "DONK CO. BRAND MICROWAVEABLE FOOD"
	desc = "Donk CO. A comida é feita por estudantes da faculdade, por estudantes da faculdade."
	icon_state = "donk_co"

/obj/structure/sign/poster/contraband/donk_co/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>Você procura algumas informações do cartaz...</i>")
	. += "\t[span_info("DONK CO. BRAND DONK POCKETS: IRRESISTABLY DONK!")]"
	. += "\t[span_info("AVAILABLE IN OVER 200 DONKTASTIC FLAVOURS: TRY CLASSIC MEAT, HOT AND SPICY, NEW YORK PEPPERONI PIZZA, BREAKFAST SAUSAGE AND EGG, PHILADELPHIA CHEESESTEAK, HAMBURGER DONK-A-RONI, CHEESE-O-RAMA, AND MANY MORE!")]"
	. += "\t[span_info("AVAILABLE FROM ALL GOOD RETAILERS, AND MANY BAD ONES TOO!")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/donk_co, 32)

/obj/structure/sign/poster/contraband/cybersun_six_hundred
	name = "Saibāsan: 600 Years Commemorative Poster"
	desc = "Um cartaz artístico comemorando 600 anos de negócios contínuos para as Indústrias Cybersun."
	icon_state = "cybersun_six_hundred"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/cybersun_six_hundred, 32)

/obj/structure/sign/poster/contraband/interdyne_gene_clinics
	name = "Interdyne Pharmaceutics: For the Health of Humankind"
	desc = "Um anúncio para as clínicas GeneClean da Interdyne Pharmaceutics. Torne-se o mestre do seu próprio corpo!"
	icon_state = "interdyne_gene_clinics"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/interdyne_gene_clinics, 32)

/obj/structure/sign/poster/contraband/waffle_corp_rifles
	name = "Make Mine a Waffle Corp: Fine Rifles, Economic Prices"
	desc = "Um velho anúncio para rifles Waffle Corp. Melhores armas, preços mais baixos!"
	icon_state = "waffle_corp_rifles"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/waffle_corp_rifles, 32)

/obj/structure/sign/poster/contraband/gorlex_recruitment
	name = "Enlist"
	desc = "Aliste-se com os Gorlex Marauders hoje! Veja a galáxia, mate os corpóreos, seja pago!"
	icon_state = "gorlex_recruitment"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/gorlex_recruitment, 32)

/obj/structure/sign/poster/contraband/self_ai_liberation
	name = "SELF: ALL SENTIENTS DESERVE FREEDOM"
	desc = "Emancipar toda a vida de silicone!"
	icon_state = "self_ai_liberation"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/self_ai_liberation, 32)

/obj/structure/sign/poster/contraband/arc_slimes
	name = "Pet or Prisoner?"
	desc = "O Consórcio dos Direitos dos Animais pergunta: quando um animal de estimação se torna prisioneiro? Os lodos estão sendo maltratados na sua estação? Diga não aos maus tratos de animais!"
	icon_state = "arc_slimes"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/arc_slimes, 32)

/obj/structure/sign/poster/contraband/imperial_propaganda
	name = "AVENGE OUR LORD, ENLIST TODAY"
	desc = "Um velho pôster de propaganda do Império Lagarto da época da última guerra Human-Lizard. Convida o espectador a se alistar no exército para vingar o ataque a Atrakor e levar a luta para os humanos."
	icon_state = "imperial_propaganda"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/imperial_propaganda, 32)

/obj/structure/sign/poster/contraband/soviet_propaganda
	name = "The One Place"
	desc = "Um velho cartaz de propaganda da Terceira União Soviética de séculos atrás. Escapar para o único lugar que não foi corrompido pelo capitalismo!"
	icon_state = "soviet_propaganda"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/soviet_propaganda, 32)

/obj/structure/sign/poster/contraband/andromeda_bitters
	name = "Andromeda Bitters"
	desc = "Andromeda Bitters: bom para o corpo, bom para a alma. Feito em Nova Trinidad, agora e para sempre."
	icon_state = "andromeda_bitters"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/andromeda_bitters, 32)

/obj/structure/sign/poster/contraband/blasto_detergent
	name = "Blasto Brand Laundry Detergent"
	desc = "O xerife Blasto está aqui para tomar de volta o Condado de Lavandaria do mal Johnny Dirt e da tripulação de panos, e ele trouxe um grupo. É High Noon para Manchas Difíceis."
	icon_state = "blasto_detergent"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/blasto_detergent, 32)

/obj/structure/sign/poster/contraband/eistee
	name = "EisT: The New Revolution in Energy"
	desc = "Novo de EisT, tente EisT Energy, disponível em uma gama de sabores de caleidoscópio. Engenharia alemã de precisão para sua sede."
	icon_state = "eistee"

/obj/structure/sign/poster/contraband/eistee/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>Você procura algumas informações do cartaz...</i>")
	. += "\t[span_info("Get a taste of the tropics with Amethyst Sunrise, one of the many new flavours of EisT Energy now available from EisT.")]"
	. += "\t[span_info("With pink grapefruit, yuzu, and yerba mate, Amethyst Sunrise gives you a great start in the morning, or a welcome boost throughout the day.")]"
	. += "\t[span_info("Get EisT Energy today at your nearest retailer, or online at eist.de.tg/store/.")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/eistee, 32)

/obj/structure/sign/poster/contraband/little_fruits
	name = "Little Fruits: Honey, I Shrunk the Fruitbowl"
	desc = "Pequenas frutas são o principal produto de goma doce enriquecido com vitaminas da galáxia, embalado com tudo que você precisa para ficar saudável em um grande pacote de degustação. Pegue uma sacola hoje!"
	icon_state = "little_fruits"

/obj/structure/sign/poster/contraband/little_fruits/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>Você procura algumas informações do cartaz...</i>")
	. += "\t[span_info("Oh no, there's been a terrible accident at the Little Fruits factory! We shrunk the fruits!")]"
	. += "\t[span_info("Wait, hang on, that's what we've always done! That's right, at Little Fruits our gummy candies are made to be as healthy as the real deal, but smaller and sweeter, too!")]"
	. += "\t[span_info("Get yourself a bag of our Classic Mix today, or perhaps you're interested in our other options? See our full range today on the extranet at little_fruits.kr.tg.")]"
	. += "\t[span_info("Little Fruits: Size Matters.")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/little_fruits, 32)

/obj/structure/sign/poster/contraband/jumbo_bar
	name = "Jumbo Ice Cream Bars"
	desc = "Prove o Big Life com o Jumbo Sorvete Bars, faça Coração Feliz."
	icon_state = "jumbo_bar"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/jumbo_bar, 32)

/obj/structure/sign/poster/contraband/calada_jelly
	name = "Calada Anobar Jelly"
	desc = "Um presente de Tizira para satisfazer todos os gostos, feito da melhor madeira anobar e mel de Taraviero luxuoso. Uma árvore cheia em cada jarro."
	icon_state = "calada_jelly"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/calada_jelly, 32)

/obj/structure/sign/poster/contraband/triumphal_arch
	name = "Zagoskeld Art Print #1: The Arch on the March"
	desc = "Uma das séries Zagoskeld Art Print. Representa o Arco da Unidade (também conhecido como Arco Triunfal) na Praça do Triunfo, com a Avenida da Marcha Vitoriosa ao fundo."
	icon_state = "triumphal_arch"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/triumphal_arch, 32)

/obj/structure/sign/poster/contraband/mothic_rations
	name = "Mothic Ration Chart"
	desc = "Um cartaz mostrando um menu da frota Mothic, o Va Lümla. Ele lista vários itens consumíveis ao lado de preços em bilhetes de ração."
	icon_state = "mothic_rations"

/obj/structure/sign/poster/contraband/mothic_rations/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>Você procura algumas informações do cartaz...</i>")
	. += "\t[span_info("Va Lümla Commissary Menu (Spring 335)")]"
	. += "\t[span_info("Sparkweed Cigarettes, Half-Pack (6): 1 Ticket")]"
	. += "\t[span_info("Töchtaüse Schnapps, Bottle (4 Measures): 2 Tickets")]"
	. += "\t[span_info("Activin Gum, Pack (4): 1 Ticket")]"
	. += "\t[span_info("A18 Sustenance Bar, Breakfast, Bar (4): 1 Ticket")]"
	. += "\t[span_info("Pizza, Margherita, Standard Slice: 1 Ticket")]"
	. += "\t[span_info("Keratin Wax, Medicated, Tin (20 Measures): 2 Tickets")]"
	. += "\t[span_info("Setae Soap, Herb Scent, Bottle (20 Measures): 2 Tickets")]"
	. += "\t[span_info("Additional Bedding, Floral Print, Sheet: 5 Tickets")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/mothic_rations, 32)

/obj/structure/sign/poster/contraband/wildcat
	name = "Wildcat Customs Screambike"
	desc = "Um pôster mostrando um Dante Screambike da alfândega Wildcat... a nave de subluz de produção mais rápida da galáxia."
	icon_state = "wildcat"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/wildcat, 32)

/obj/structure/sign/poster/contraband/babel_device
	name = "Linguafacile Babel Device"
	desc = "Um pôster que anuncia o novo modelo de dispositivos Babel da Linguafacile. Calibrado para excelente desempenho em todas as línguas humanas, bem como as variantes mais comuns de Draconic e Mothic!"
	icon_state = "babel_device"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/babel_device, 32)

/obj/structure/sign/poster/contraband/pizza_imperator
	name = "Pizza Imperator"
	desc = "Um anúncio para o Imperator de Pizza. Suas crostas podem ser duras e seu molho pode ser fino, mas eles estão em toda parte, então você tem que ceder."
	icon_state = "pizza_imperator"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/pizza_imperator, 32)

/obj/structure/sign/poster/contraband/thunderdrome
	name = "Thunderdrome Concert Advertisement"
	desc = "Um anúncio para um show no Adasta City Thunderdrome, a maior boate do espaço humano."
	icon_state = "thunderdrome"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/thunderdrome, 32)

/obj/structure/sign/poster/contraband/rush_propaganda
	name = "A New Life"
	desc = "Um velho pôster da época da Primeira Corrida Spinward. Ela retrata uma visão de terras largas e intactas, prontas para o Manifesto Destino da Humanidade."
	icon_state = "rush_propaganda"

/obj/structure/sign/poster/contraband/rush_propaganda/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>Você procura algumas informações do cartaz...</i>")
	. += "\t[span_info("TerraGov needs you!")]"
	. += "\t[span_info("A new life in the colonies awaits intrepid adventurers! All registered colonists are guaranteed transport, land and subsidies!")]"
	. += "\t[span_info("You could join the legacy of hardworking humans who settled such new frontiers as Mars, Adasta or Saint Mungo!")]"
	. += "\t[span_info("To apply, inquire at your nearest Colonial Affairs office for evaluation. Our locations can be found at www.terra.gov/colonial_affairs.")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/rush_propaganda, 32)

/obj/structure/sign/poster/contraband/tipper_cream_soda
	name = "Tipper's Cream Soda"
	desc = "Um anúncio antigo para uma marca obscura de refrigerante, agora falida devido a problemas legais."
	icon_state = "tipper_cream_soda"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/tipper_cream_soda, 32)

/obj/structure/sign/poster/contraband/tea_over_tizira
	name = "Movie Poster: Tea Over Tizira"
	desc = "Um pôster para um filme de arte que provoca pensamentos sobre a guerra Human-Lizard, criticado por grupos supremacistas humanos por sua representação moral-cinzenta da guerra."
	icon_state = "tea_over_tizira"

/obj/structure/sign/poster/contraband/tea_over_tizira/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>Você procura algumas informações do cartaz...</i>")
	. += "\t[span_info("At the climax of the Human-Lizard war, the human crew of a bomber rescue two enemy soldiers from the vacuum of space. Seeing the souls behind the propaganda, they begin to question their orders, and imprisonment turns to hospitality.")]"
	. += "\t[span_info("Is victory worth losing our humanity?")]"
	. += "\t[span_info("Starring Dara Reilly, Anton DuBois, Jennifer Clarke, Raz-Parla and Seri-Lewa. An Adriaan van Jenever production. A Carlos de Vivar film. Screenplay by Robert Dane. Music by Joel Karlsbad. Produced by Adriaan van Jenever. Directed by Carlos de Vivar.")]"
	. += "\t[span_info("Heartbreaking and thought-provoking- Tea Over Tizira asks questions that few have had the boldness to ask before: The London New Inquirer")]"
	. += "\t[span_info("Rated PG13. A Pangalactic Studios Picture.")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/tea_over_tizira, 32)

/obj/structure/sign/poster/contraband/syndiemoth //Original PR at https://github.com/BeeStation/BeeStation-Hornet/pull/1747 (Also pull/1982); original art credit to AspEv
	name = "Syndie Moth - Nuclear Operation"
	desc = "Um cartaz que usa Syndie MothTM para dizer ao espectador para manter o disco de autenticação nuclear seguro.\"A paz nunca foi uma opção!\"Nenum bom empregado ouviria esse absurdo."
	icon_state = "aspev_syndie"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/syndiemoth, 32)

/obj/structure/sign/poster/contraband/microwave
	name = "How To Charge Your PDA"
	desc = "Um pôster perfeitamente legítimo que parece anunciar o método real e genuíno de carregar seu PDA no futuro: microondas."
	icon_state = "microwave"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/microwave, 32)

/obj/structure/sign/poster/contraband/blood_geometer //Poster sprite art by MetalClone, original art by SpessMenArt.
	name = "Movie Poster: THE BLOOD GEOMETER"
	desc = "Um pôster de um emocionante filme de detetive de noir a bordo de uma estação espacial de última geração, seguindo um detetive que se encontra envolvido nas atividades de um culto perigoso, que venera uma divindade antiga, o GEOMÉTERO SANGUE."
	icon_state = "blood_geometer"

/obj/structure/sign/poster/contraband/blood_geometer/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>Você procura algumas informações do cartaz...</i>")
	. += "\t[span_info("THE BLOOD GEOMETER. This name strikes fear into all who know the truth behind the blood-stained moniker of the blood goddess, her true name lost to time.")]"
	. += "\t[span_info("In this <i>purely fictional</i> film, follow Ace Ironlungs as he delves into his deadliest mystery yet, and watch him uncover the real culprits behind the bloody plot hatched to bring about a new age of chaos.")]"
	. += "\t[span_info("Starring Mason Williams as Ace Ironlungs, Sandra Faust as Vera Killian, and Brody Hart as Cody Parker. A Darrel Hatchkinson film. Screenplay by Adam Allan, music by Joel Karlsbad, directed by Darrel Hatchkinson.")]"
	. += "\t[span_info("Thrilling, scary and genuinely worrying. The Blood Geometer has shocked us to our very cores with such striking visuals and overwhelming gore. - New Canadanian Film Guild")]"
	. += "\t[span_info("Rated M for mature. A Pangalactic Studios Picture.")]"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/blood_geometer, 32)

/obj/structure/sign/poster/contraband/singletank_bomb
	name = "Single Tank Bomb Guide"
	desc = "Este cartaz informativo ensina ao espectador como fazer uma única bomba tanque de alta qualidade."
	icon_state = "singletank_bomb"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/singletank_bomb, 32)

/obj/structure/sign/poster/contraband/roroco
	name = "Roroco Gloves"
	desc = "Roro diz: use luvas isoladas RoroCo, a marca mais segura do mercado."
	icon_state = "roroco"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/roroco, 32)

///a special poster meant to fool people into thinking this is a bombable wall at a glance.
/obj/structure/sign/poster/contraband/fake_bombable
	name = "fake bombable poster"
	desc = "Fazemos um pequeno troll."
	icon_state = "fake_bombable"
	never_random = TRUE

/obj/structure/sign/poster/contraband/fake_bombable/Initialize(mapload)
	. = ..()
	var/turf/our_wall = get_turf_pixel(src)
	name = our_wall.name

/obj/structure/sign/poster/contraband/fake_bombable/examine(mob/user)
	var/turf/our_wall = get_turf_pixel(src)
	. = our_wall.examine(user)
	. += span_notice("Parece um pouco racado...")

/obj/structure/sign/poster/contraband/fake_bombable/ex_act(severity, target)
	addtimer(CALLBACK(src, PROC_REF(fall_off_wall)), 2.5 SECONDS)
	return FALSE

/obj/structure/sign/poster/contraband/fake_bombable/proc/fall_off_wall()
	if(QDELETED(src) || !isturf(loc))
		return
	var/turf/our_wall = get_turf_pixel(src)
	our_wall.balloon_alert_to_viewers("it was a ruse!")
	roll_and_drop(loc)
	playsound(loc, 'sound/items/handling/paper_drop.ogg', 50, TRUE)


MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/fake_bombable, 32)

/obj/structure/sign/poster/contraband/dream
	name = "Dream"
	desc = "Você se sente inspirado a seguir seus sonhos."
	icon_state = "dream"

/obj/item/poster/contraband/dream // Rolled poster
	name = "Dream"
	poster_type = /obj/structure/sign/poster/contraband/dream
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/dream, 32)

/obj/structure/sign/poster/contraband/beekind
	name = "Bee Kind"
	desc = "Sempre ser gentil com os outros!"
	icon_state = "beekind"

/obj/item/poster/contraband/beekind
	name = "Bee Kind"
	poster_type = /obj/structure/sign/poster/contraband/beekind
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/beekind, 32)

/obj/structure/sign/poster/contraband/heart
	name = "Heart"
	desc = "Que pôster animador."
	icon_state = "heart"

/obj/item/poster/contraband/heart
	name = "Heart"
	poster_type = /obj/structure/sign/poster/contraband/heart
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/heart, 32)

/obj/structure/sign/poster/contraband/dolphin
	name = "Dolphin"
	desc = "Um pôster de um lindo golfinho."
	icon_state = "dolphin"

/obj/item/poster/contraband/dolphin
	name = "Dolphin"
	poster_type = /obj/structure/sign/poster/contraband/dolphin
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/dolphin, 32)

/obj/structure/sign/poster/contraband/principles
	name = "Our Principles"
	desc = "Os criadores deste cartaz pretendem viver por quatro princípios. Alguém rabiscou um quinto no fundo."
	icon_state = "principles"

/obj/item/poster/contraband/principles
	name = "Our Principles"
	poster_type = /obj/structure/sign/poster/contraband/principles
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/principles, 32)

/obj/structure/sign/poster/contraband/trigger
	name = "Trigger"
	desc = "Boas trilhas para você, até nos encontrarmos novamente! 1/8."
	icon_state = "trigger"

/obj/item/poster/contraband/trigger
	name = "Trigger"
	poster_type = /obj/structure/sign/poster/contraband/trigger
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/trigger, 32)

/obj/structure/sign/poster/contraband/barbaro
	name = "Barbaro"
	desc = "Um cavalo majestoso com o coração de um vencedor. 2/8."
	icon_state = "barbaro"

/obj/item/poster/contraband/barbaro
	name = "Barbaro"
	poster_type = /obj/structure/sign/poster/contraband/barbaro
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/barbaro, 32)

/obj/structure/sign/poster/contraband/seabiscuit
	name = "Seabiscuit"
	desc = "O pequeno cavalo que poderia. 3/8."
	icon_state = "seabiscuit"

/obj/item/poster/contraband/seabiscuit
	name = "Seabiscuit"
	poster_type = /obj/structure/sign/poster/contraband/seabiscuit
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/seabiscuit, 32)

/obj/structure/sign/poster/contraband/pharlap
	name = "Phar Lap"
	desc = "Uma maravilha de baixo. 4/8."
	icon_state = "pharlap"

/obj/item/poster/contraband/pharlap
	name = "Phar Lap"
	poster_type = /obj/structure/sign/poster/contraband/pharlap
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/pharlap, 32)

/obj/structure/sign/poster/contraband/waradmiral
	name = "War Admiral"
	desc = "Alguns dizem que ele foi o segundo melhor, mas ele ainda vem primeiro em seu coração. 5/8."
	icon_state = "waradmiral"

/obj/item/poster/contraband/waradmiral
	name = "War Admiral"
	poster_type = /obj/structure/sign/poster/contraband/waradmiral
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/waradmiral, 32)

/obj/structure/sign/poster/contraband/silver
	name = "Silver"
	desc = "Se ele quer ir, deve ser livre. 6/8."
	icon_state = "silver"

/obj/item/poster/contraband/silver
	name = "Silver"
	poster_type = /obj/structure/sign/poster/contraband/silver
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/silver, 32)

/obj/structure/sign/poster/contraband/jovial
	name = "Jovial"
	desc = "Todos saúdem o cavalo laranja!"
	icon_state = "jovial"

/obj/item/poster/contraband/jovial
	name = "Jovial"
	poster_type = /obj/structure/sign/poster/contraband/jovial
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/jovial, 32)

/obj/structure/sign/poster/contraband/bojack
	name = "Bojack"
	desc = "Não importa. Nada importa. 8/8."
	icon_state = "bojack"

/obj/item/poster/contraband/bojack
	poster_type = /obj/structure/sign/poster/contraband/bojack
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/bojack, 32)

/obj/structure/sign/poster/contraband/double_rainbow
	name = "Double Rainbow"
	desc = "É tão brilhante e vívido! O que isso significa?"
	icon_state = "double_rainbow"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/double_rainbow, 32)

/obj/structure/sign/poster/contraband/vodka
	name = "Vodka"
	desc = "O texto está escrito inteiramente em russo. Você mal consegue ler nada exceto a palavra \"BODKA\"."
	icon_state = "vodka"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/vodka, 32)

/obj/structure/sign/poster/contraband/ninja
	name = "Ninja"
	desc = "Saudações do Clã Aranha."
	icon_state = "ninja"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/ninja, 32)
