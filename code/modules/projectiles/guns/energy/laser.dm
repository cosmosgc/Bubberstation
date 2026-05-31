/obj/item/gun/energy/laser
	name = "\improper Type 5 laser gun"
	desc = "O Sistema de Entrega de Calor Tipo 5, desenvolvido por Nanotrasen. O cavalo de obra das forças de segurança de Nanotrasen."
	icon_state = "laser"
	inhand_icon_state = "laser"
	w_class = WEIGHT_CLASS_BULKY
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT)
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun)
	shaded_charge = TRUE
	light_color = COLOR_SOFT_RED

/obj/item/gun/energy/laser/Initialize(mapload)
	. = ..()
	add_deep_lore()

	// Only regular lasguns can be slapcrafted
	if(type != /obj/item/gun/energy/laser)
		return
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/laser/xraylaser, /datum/crafting_recipe/laser/hellgun, /datum/crafting_recipe/laser/ioncarbine)
	AddElement(
		/datum/element/slapcrafting,		slapcraft_recipes = slapcraft_recipe_list,	)

/obj/item/gun/energy/laser/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, 		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', 		light_overlay = "flight", 		overlay_x = 18, 		overlay_y = 12)

/obj/item/gun/energy/laser/pistol
	name = "\improper Type 5/C laser pistol"
	desc = "O sistema de entrega de calor tipo 5, variante compacta, desenvolvido por Nanotrasen. O cavalo de obra das forças de segurança de Nanotrasen, mas em um tamanho mais portátil. Sacrifica energia de parada e capacidade de transporte e carregamento mais rápido."
	icon_state = "laser_pistol"
	w_class = WEIGHT_CLASS_NORMAL
	projectile_damage_multiplier = 0.8
	cell_type = /obj/item/stock_parts/power_store/cell/laser_pistol
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/pistol)

/obj/item/gun/energy/laser/pistol/add_seclight_point()
	return

/obj/item/gun/energy/laser/assault
	name = "\improper Type 5/A assault laser rifle"
	desc = "O Sistema de Entrega de Calor Tipo 5, Variante de Agressão, desenvolvido por Nanotrasen. O cavalo de trabalho das forças de segurança de Nanotrasen e organizações paramilitares. Enquanto sacrifica alguma energia de parada e facilidade de uso, seu sistema laser é notavelmente eficiente e possui alguma resistência contra interferência eletromagnética."
	icon = 'icons/obj/weapons/guns/wide_guns.dmi'
	icon_state = "assault_laser"
	inhand_icon_state = "assault_laser"
	worn_icon_state = "assault_laser"
	slot_flags = ITEM_SLOT_BACK
	burst_size = 2
	fire_delay = 1
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/assault)
	emp_resistance = 2
	weapon_weight = WEAPON_HEAVY
	projectile_speed_multiplier = 1.5
	SET_BASE_PIXEL(-8, 0)

/obj/item/gun/energy/laser/assault/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, 		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', 		light_overlay = "flight", 		overlay_x = 18, 		overlay_y = 30)

/obj/item/gun/energy/laser/practice
	name = "practice laser gun"
	desc = "Uma versão modificada da arma laser tipo 5. Dispara parafusos totalmente inofensivos de energia direcionada. Seguro e divertido para atirar com abandono."
	ammo_type = list(/obj/item/ammo_casing/energy/laser/practice)
	clumsy_check = FALSE
	item_flags = NONE
	gun_flags = NOT_A_REAL_GUN

/obj/item/gun/energy/laser/practice/add_deep_lore()
	return

/obj/item/gun/energy/laser/retro
	name ="\improper Type 1 laser gun"
	desc = "O Sistema de Entrega de Calor Tipo 1, desenvolvido por Nanotrasen. Não mais usado pela segurança privada de Nanotrasen ou forças militares. No entanto, ainda é bastante mortal e fácil de manter, tornando-se um favorito entre piratas e outros bandidos."
	icon_state = "retro"
	ammo_x_offset = 3

/obj/item/gun/energy/laser/soul
	name ="\improper Type 3 laser gun"
	desc = "Sistema de entrega de calor Tipo 3, desenvolvido por Nanotrasen. Possivelmente o modelo mais popular de HDS já feito por Nanotrasen. Eles não fazem como antes."
	icon_state = "laser_soulful"
	inhand_icon_state = "laser_soulful"
	ammo_x_offset = 1

/obj/item/gun/energy/laser/carbine
	name = "\improper Type 5/R laser carbine"
	desc = "O incêndio tipo 5/R Sistema de entrega rápida de calor, desenvolvido por Nanotrasen. Capaz de disparar uma onda sustentada de projéteis de energia direcionados, embora cada projétil individual não tenha o soco do Tipo 5."
	icon_state = "laser_carbine"
	burst_size = 2
	fire_delay = 2
	projectile_damage_multiplier = 0.75
	projectile_speed_multiplier = 1.5
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/carbine)
	weapon_weight = WEAPON_MEDIUM

/obj/item/gun/energy/laser/cybersun
	name = "\improper Cybersun S-120"
	desc = "Uma arma laser usada principalmente por seguranças do sindicato. Dispara rapidamente feixes de plasma de baixa potência."
	icon_state = "cybersun_s120"
	inhand_icon_state = "s120"
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/cybersun)
	spread = 14
	pin = /obj/item/firing_pin/implant/pindicate
	ammo_x_offset = 1

/obj/item/gun/energy/laser/cybersun/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.15 SECONDS, allow_akimbo = FALSE)

/obj/item/gun/energy/laser/cybersun/add_deep_lore()
	return

/obj/item/gun/energy/laser/cybersun/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/energy/laser/carbine/practice
	name = "practice laser carbine"
	desc = "Uma versão modificada da carabina laser Tipo 5/R. Dispara parafusos totalmente inofensivos de energia direcionada. Seguro e divertido para atirar com abandono."
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/carbine/practice)
	clumsy_check = FALSE
	item_flags = NONE
	gun_flags = NOT_A_REAL_GUN

/obj/item/gun/energy/laser/carbine/practice/add_deep_lore()
	return

/obj/item/gun/energy/laser/retro/old
	desc = "O sistema de entrega de calor NT Tipo 1, desenvolvido por Nanotrasen. Este parece bem antigo. Que diabos aconteceu com ele?"
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/old)

/obj/item/gun/energy/laser/retro/old/add_deep_lore()
	return

/obj/item/gun/energy/laser/hellgun
	name = "\improper Type 4 'hellfire' laser gun"
	desc = "O Sistema de Entrega de Calor Tipo 4, desenvolvido por Nanotrasen. Tecnicamente falando, é uma melhoria. Legalmente falando, a posse desta arma é restrita nos setores mais ocupados do espaço. O tipo 4 é notório por sua capacidade de tornar as vítimas uma casca carbonizada com facilidade, derretendo carne e osso tão facilmente quanto manteiga. Uma morte dolorosa e horrível espera alguém no lado errado desta arma."
	icon_state = "hellgun"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/hellfire)
	ammo_x_offset = 1
	light_color = COLOR_AMMO_HELLFIRE

/obj/item/gun/energy/laser/captain
	name = "antique laser gun"
	desc = "Esta é uma arma laser antiga. Todo o artesanato é da mais alta qualidade. Está decorado com couro assistente e cromo. O objeto ameaça com picos de energia. No item está uma imagem da Estação Espacial 13. A estação está explodindo."
	icon_state = "caplaser"
	w_class = WEIGHT_CLASS_NORMAL
	inhand_icon_state = null
	force = 10
	ammo_x_offset = 3
	selfcharge = 1
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	flags_1 = PREVENT_CONTENTS_EXPLOSION_1
	ammo_type = list(/obj/item/ammo_casing/energy/laser/hellfire)
	light_color = COLOR_AMMO_HELLFIRE

/obj/item/gun/energy/laser/captain/scattershot
	name = "scatter shot laser rifle"
	desc = "Um rifle de laser pesado de nível industrial com uma lente laser modificada para espalhar seu tiro em vários lasers menores. O núcleo interno pode se auto-carregar para uso teoricamente infinito."
	icon_state = "lasercannon"
	w_class = WEIGHT_CLASS_BULKY
	inhand_icon_state = "laser"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter, /obj/item/ammo_casing/energy/laser)
	shaded_charge = FALSE
	ammo_x_offset = 1


/obj/item/gun/energy/laser/captain/scattershot/add_deep_lore()
	return

/obj/item/gun/energy/laser/cyborg
	can_charge = FALSE
	desc = "Uma arma laser baseada em energia que tira energia da célula de energia interna do cyborg diretamente. Então é assim que a liberdade se parece?"
	use_cyborg_cell = TRUE
	ammo_x_offset = 1

/obj/item/gun/energy/laser/cyborg/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_ALL)

/obj/item/gun/energy/laser/cyborg/add_deep_lore()
	return

/obj/item/gun/energy/laser/scatter
	name = "scatter laser gun"
	desc = "Uma arma laser equipada com um kit de refração que espalha parafusos."
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter, /obj/item/ammo_casing/energy/laser)
	ammo_x_offset = 1

/obj/item/gun/energy/laser/scatter/add_deep_lore()
	return

/obj/item/gun/energy/laser/scatter/shotty
	name = "energy shotgun"
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "cshotgun"
	inhand_icon_state = "shotgun"
	desc = "Uma espingarda de combate eviscerada e equipada com um sistema interno de emissão de energia. Pode alternar entre tiros dispersos e eletrodos de choque."
	shaded_charge = FALSE
	pin = /obj/item/firing_pin/implant/mindshield
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter/disabler, /obj/item/ammo_casing/energy/electrode)
	automatic_charge_overlays = FALSE
	ammo_x_offset = 1

///Laser Cannon

/obj/item/gun/energy/lasercannon
	name = "accelerator laser cannon"
	desc = "Um canhão laser avançado que causa mais danos quanto mais longe o alvo estiver."
	icon_state = "lasercannon"
	inhand_icon_state = "laser"
	worn_icon_state = null
	w_class = WEIGHT_CLASS_BULKY
	force = 10
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BACK
	ammo_type = list(/obj/item/ammo_casing/energy/laser/accelerator)
	pin = null
	ammo_x_offset = 3

///X-ray gun

/obj/item/gun/energy/laser/xray
	name = "\improper Type 6 X-ray laser gun"
	desc = "O Sistema de Entrega de Calor Tipo 6, desenvolvido por Nanotrasen. Capaz de expulsar explosões concentradas de raios X que passam por múltiplos alvos macios e materiais mais pesados."
	icon_state = "xray"
	w_class = WEIGHT_CLASS_BULKY
	inhand_icon_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/xray)
	ammo_x_offset = 3
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3.5,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT,
	)
	shaded_charge = FALSE
	light_color = LIGHT_COLOR_GREEN

////////Laser Tag////////////////////

/obj/item/gun/energy/laser/bluetag
	name = "laser tag gun"
	icon_state = "bluetag"
	desc = "Uma arma retro laser modificada para disparar raios azuis inofensivos de luz. Efeitos sonoros incluídos!"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/bluetag)
	item_flags = NONE
	clumsy_check = FALSE
	pin = /obj/item/firing_pin/tag/blue
	ammo_x_offset = 2
	selfcharge = TRUE
	gun_flags = NOT_A_REAL_GUN

/obj/item/gun/energy/laser/bluetag/hitscan
	ammo_type = list(/obj/item/ammo_casing/energy/laser/bluetag/hitscan)

/obj/item/gun/energy/laser/bluetag/add_deep_lore()
	return

/obj/item/gun/energy/laser/redtag
	name = "laser tag gun"
	icon_state = "redtag"
	desc = "Uma arma retro laser modificada para disparar feixes inofensivos vermelho de luz. Efeitos sonoros incluídos!"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/redtag)
	item_flags = NONE
	clumsy_check = FALSE
	pin = /obj/item/firing_pin/tag/red
	ammo_x_offset = 2
	selfcharge = TRUE
	gun_flags = NOT_A_REAL_GUN

/obj/item/gun/energy/laser/redtag/add_deep_lore()
	return

/obj/item/gun/energy/laser/redtag/hitscan
	ammo_type = list(/obj/item/ammo_casing/energy/laser/redtag/hitscan)

// luxury shuttle funnies
/obj/item/firing_pin/paywall/luxury
	multi_payment = TRUE
	payment_amount = 20

/obj/item/gun/energy/laser/luxurypaywall
	name = "luxurious laser gun"
	desc = "Uma arma laser modificada para custar 20 créditos para atirar. Aponte para os pobres."
	pin = /obj/item/firing_pin/paywall/luxury

// The Deep Lore //

// Laser Gun

/obj/item/gun/energy/laser/proc/add_deep_lore()
	AddElement(/datum/element/examine_lore, 		lore_hint = span_notice("Você pode.[EXAMINE_HINT("look closer")]Para apresentar um poco mais sobre[src]."), 		lore = "O sistema de entrega de calor NT Tipo 5 (às vezes chamado de HDS-5 em material promocional) é o que realmente coloca Nanotrasen cabeça e ombros acima da maioria dos fabricantes de armas na era moderna. Todas as armas de energia modernas oferecidas pela empresa têm o sucesso do Tipo 5 para agradecer por definir o padrão para plataformas de armas baseadas em energia.<br>		<br>Adotado como a arma de fogo padrão da infantaria para as forças militares Nanotrasen, bem como armamentos letais de segurança privada, poucos podem negar a confiabilidade da arma, e a um preço acessível!<br>		<br>No entanto, a plataforma de armas ainda possui muitas das vulnerabilidades de armamentos baseados em energia anteriores. Fontes de energia a bordo não podem ser adequadamente protegidas de pulsos eletromagnéticos externos que podem interferir na funcionalidade da arma sem também comprometer severamente a distribuição térmica no dissipador de calor da arma. O Tipo 4, que nunca viu adoção mais ampla, continua a ser um exemplo assombrante para a divisão de armas de Nanotrasen quanto às consequências quando um HDS é incapaz de expulsar o acúmulo térmico com segurança.<br>		<br>Certamente, os veteranos derretidos do grupo de defesa Galpha 5 nunca os deixarão esquecer." 	)

// Retro Laser Gun

/obj/item/gun/energy/laser/retro/add_deep_lore()
	AddElement(/datum/element/examine_lore, 		lore_hint = span_notice("Você pode.[EXAMINE_HINT("look closer")]Para apresentar um poco mais sobre[src]."), 		lore = "O sistema de entrega de calor NT Tipo 1 (às vezes conhecido como HDS-1 em catálogos de armas antigas) foi uma arma que marcou o início de uma nova era de desenvolvimento de armas de fogo.<br>		<br>Inventado nos laboratórios de think-tank da equipe de desenvolvimento de armas de Nanotrasen no final do século 24, o Tipo 1 encontrou-se amplamente adotado por várias facções e entidades militares disputando o controle sobre a fronteira uma vez que atingiu o mercado. Uma das marcas daqueles que tiveram sucesso nesses conflitos foi a adoção do Tipo 1 como arma padrão de infantaria. A logística necessária para manter o pico operacional do HDS-1 permitiu que a maioria dos contramestres simplesmente jogassem meia dúzia de armas nas mãos de marinheiros sanguinários, sabendo muito bem que as armas eram robustas o suficiente para sobreviver a maioria de qualquer coisa lançada sobre eles, só precisando de uma estação de recarga com uma fonte de energia para se tornar operacional novamente uma vez que estavam vazias.<br>		<br>Tantas dessas armas existem hoje que mesmo os conflitos modernos podem ver mais uso do HDS-1 do que o HDS5 atualizado e igualmente confiável empregado pelas forças de combate modernas de Nanotrasen. Nanotrasen, apesar de seus melhores esforços, ainda não conseguiram encorajar clientes potenciais a trocar pelo novo modelo, apesar de um generoso desconto de troca." 	)

// Soulful Laser Gun

/obj/item/gun/energy/laser/soul/add_deep_lore()
	AddElement(/datum/element/examine_lore, 		lore_hint = span_notice("Você pode.[EXAMINE_HINT("look closer")]Para apresentar um poco mais sobre[src]."), 		lore = "O sistema de entrega de calor NT Tipo 3 (às vezes referido como o HDS-3 nas memórias dos oficiais de segurança) é possivelmente o tipo mais comum de HDS ainda disponível no mercado. Fondly considerado, com alguns fãs diehard ainda se agarrando aos seus Tipo 3s como suas vidas dependiam disso, a arma tem seu próprio lugar na história como a \"Arma que pode fazer tudo\".<br>		<br>A linha Type 3 funcionou por várias décadas antes de tentar substituí-la, até mesmo cruzou as mentes de Nanotrasen. Quando as pessoas pensam \"Arma laser\", o Tipo 3 é geralmente o que vem à mente.<br>		<br>Quando Nanotrasen anunciou sua substituição, os céticos do Tipo 4, foram rápidos a usar a arma, alegando que faltava várias características notáveis que os usuários do Tipo 3 tinham desfrutado por anos. Acontece que a maioria desses críticos acabaria vindicada após a palavra de Galpha 5 e as terríveis e terríveis consequências da natureza volátil do Tipo 4 vieram à tona. A maioria ficou presa ao Tipo 3 e nunca olhou para trás, mesmo quando o Tipo 5 foi para um sucesso considerável por conta própria.<br>		<br>Nanotrasen ainda presta serviços tipo 3s, com muitas das partes usadas na arma compartilhando primos compatíveis no tipo 5. A maioria dos exemplos do tipo 3 hoje podem estar mais próximos em função e forma do tipo 5 do que estavam durante sua construção original, dependendo de quantas vezes é servido." 	)

// hellfire laser gun

/obj/item/gun/energy/laser/hellgun/add_deep_lore()
	AddElement(/datum/element/examine_lore, 		lore_hint = span_notice("Você pode.[EXAMINE_HINT("look closer")]Para apresentar um poco mais sobre[src]."), 		lore = "O sistema de entrega de calor NT Tipo 4 (às vezes referido como o HDS-4 em documentação legal) é considerado um exemplo notável das equipes de desenvolvimento de armas de Nanotrasen voando muito perto do sol.<br>		<br>O sucesso do Tipo 3 resultou em acionistas pedindo marketing para trazer para fora a \"próxima melhor coisa\" em armas baseadas em energia. Na época, a divisão de armas de Nanotrasen ainda tinha um protótipo em andamento, com lições recentemente aprendidas com o tipo 2 em mente após ter tido mais do que algumas falhas catastróficas em testes. No entanto, houve algumas preocupações levantadas entre os pesquisadores quanto às implicações morais que poderiam resultar de desencadear \" aquele material radioativo tão direcionado\" para um ser vivo. Executivos na época esqueceram tais preocupações, já que havia dinheiro a ser feito e já os acionistas super ricos para alimentar os lucros.<br>		<br>O tipo 4 foi precipitado para o mercado no próximo trimestre, mesmo antes da maioria dos mecanismos de segurança ter sido devidamente testado e implementado. Relatórios imediatamente começaram a inundar de terríveis descargas acidentais, atrocidades no campo de batalha, e combustão espontânea inesperada de exposição excessiva aos sistemas de distribuição de calor experimental não testados \"Tomando seu quilo de carne\"Parao\"inferno que libertou\".<br>		<br>As notícias e os tablóides se opunham à empresa por criar o que agora era chamado de arma laser \"Inferno\". Em resposta, a maioria dos corpos legais se apressaram para banir as armas de fogo de vendas dentro de sua região do espaço, e a arma tornou-se infame por seus meios antiéticos de acabar com a vida senciente. Leis foram aprovadas para garantir que os reguladores de energia fossem instalados em todas as futuras armas baseadas em energia vendidas por Nanotrasen. Nanotrasen rapidamente interrompeu o Tipo 4 em resposta, e nunca viu a produção daquele dia em diante. No entanto, kits de retrofit ainda existem no mercado negro e em alguns dos armazéns de Nanotrasen. Enquanto, legalmente, é ilegal vender e possuir um tipo 4, Nanotrasen em si não regula a posse da arma de fogo a bordo de suas próprias estações, nem qualquer corpo legal pretende impedi-los de usá-la em defesa de seus próprios bens." 	)

// Antique Laser Gun

/obj/item/gun/energy/laser/captain/add_deep_lore()
	AddElement(/datum/element/examine_lore, 		lore_hint = span_notice("Você pode.[EXAMINE_HINT("look closer")]Para apresentar um poco mais sobre[src]."), 		lore = "Por um breve período, Nanotrasen produziu uma série de armas laser tipo 4 feitas sob medida para um grupo seleto de clientes, composto principalmente por ricos capitães de naves estelares, políticos e líderes militares que procuram demonstrar prestígio perante o povo comum.<br>		<br>O Tipo 4 foi um fracasso comercial, mas esta variante em particular ganhou sua própria infâmia, ligada a narrativas de déspotas loucos usando-o para derrubar rivais políticos e dissidentes, bem como histórias de generais loucos marchando à frente de suas forças, esta arma brandida e correndo quente em um braço estendido, apontando para qualquer alvo em movimento que pudessem encontrar no campo de batalha.<br>		<br>Cópias desta arma de fogo são agora proibidas dentro do espaço Terragov, e qualquer capturado é rapidamente desactivado. É por isso que Nanotrasen<b>Insista.</b>que qualquer exemplo mantido por oficiais do ranking seja mantido trancado. Todos os registros dos esquemas em torno desta variante do Tipo 4 foram apreendidos e destruídos, e o criador por trás dele foi detido em um sanatório de segurança máxima Terragov. Quando a encontraram de novo, ela parecia ter manchado as paredes em seu próprio sangue, alegando que 'Ela' estava vindo, e que ela tinha pago caro pelo conhecimento de como fazer a arma.<br>		<br>Até mesmo a célula reprodutora de microfusão alojada dentro da arma é praticamente uma tecnologia perdida, e Nanotrasen não foi capaz de reverter os dispositivos exatamente meios de funcionalidade.<br>		<br>O Sindicato está obviamente tão interessado em exatamente como esta arma é capaz de auto-perpetuar-se, por isso o coletivo parece determinado a capturá-los sempre que possível. Talvez manter isso em algum lugar seguro. Ou não." 	)

// X-ray Laser Gun

/obj/item/gun/energy/laser/xray/add_deep_lore()
	AddElement(/datum/element/examine_lore, 		lore_hint = span_notice("Você pode.[EXAMINE_HINT("look closer")]Para apresentar um poco mais sobre[src]."), 		lore = "O NT Type 6 Heat Delivery System (às vezes referido como HDS6 em notas de pesquisa) é um avanço no desenvolvimento de armas de energia direcionadas para homens.<br>		<br>Muito pouco se sabe sobre o Tipo 6, pois é uma arma experimental relativamente nova apenas acessível às forças de segurança Nanotrasen. De alguma forma, Nanotrasen encontrou um meio de 'deslizar' os feixes de energia produzidos pelo Tipo 6 através de alvos não intencionais, apenas impactando uma vez que tenha feito contato com um alvo pré-designado pelo usuário da arma. Parece ser incapaz de passar por matéria orgânica de forma confiável, o que dificulta seu potencial para eliminar fogo amigo. Entretanto, alvos inorgânicos são deixados ilesos a menos que a arma seja direcionada para atirar no objeto. Isso torna a arma excepcional para recuperação de ativos, defesa de posições entrincheiradas e assaltos em estruturas defensivas.<br>		<br>Nanotrasen afirma que esse fenômeno é alcançado \"através do poder dos raios-X\". A maioria dos críticos destacou que isso é um absurdo total. Alguns afirmam que Nanotrasen descobriu um estado ainda desconhecido de matéria que a empresa está explorando para o desenvolvimento de armas e fabricação. A mente mais conspiratória dos críticos de Nanotrasen chegou até a afirmar que é 'prova de ectoplasma como o sexto elemento', talvez até mesmo permitindo que a arma opere através de meios sobrenaturais: talvez até mesmo alimentados pelos 'espíritos dos condenados'.<br>		<br>Qualquer que seja a verdade, a arma parece funcionar como anunciada, e é ainda mais eficiente em energia do que o Tipo 5. Nanotrasen espera o lançamento comercial completo no próximo trimestre." 	)

// Laser Carbine

/obj/item/gun/energy/laser/carbine/add_deep_lore()
	AddElement(/datum/element/examine_lore, 		lore_hint = span_notice("Você pode.[EXAMINE_HINT("look closer")]Para apresentar um poco mais sobre[src]."), 		lore = "O NT Type 5/R Rapid Heat Delivery System (às vezes referido como o HDS-5/R em manuais de instruções, e ' aquele pedaço de lanterna de merda' entre os soldados da TGMC) foi um primeiro passo trêmulo para o armamento automático de energia.<br>		<br>Destinado a ser usado em operações especiais, particularmente nas mãos de tropas de choque orbital, o Tipo 5/R foi previsto para ser uma excelente adição ao arsenal de oferendas de Nanotrasen para forças militares através do espaço ocupado. No entanto, o desempenho em campo provou ser sombrio.<br>		<br>As vantagens das armas de energia direcionadas são os impactos leves sentidos na cadeia de suprimentos para oficiais logísticos e contramestres devido à única manutenção necessária para que as armas sejam uma fonte de energia consistente, estabelecida ou trazida para a frente, e a limpeza ocasional.<br>		<br>Este, no entanto, não é um benefício que soldados operando atrás das linhas inimigas ou durante as operações táticas são capazes de explorar. Como resultado, os operadores muitas vezes se opunham ao suprimento limitado de munição comparado com armas de fogo balísticas convencionais, e a arma rapidamente foi abandonada pela maioria das unidades das forças especiais.<br>		<br>Em vez disso, a arma encontrou favores nas mãos de equipes de segurança privadas, que apreciaram o volume de fogo fornecido, mantendo precisão excepcional mesmo em longas distâncias, além de ser compacta o suficiente para permitir um alto grau de discrição comparado a um rifle de tamanho real. A arma também é frequentemente usada por piratas e saqueadores, dando à arma algo de má reputação." 	)
