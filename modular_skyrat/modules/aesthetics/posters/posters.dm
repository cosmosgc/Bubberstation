//Posters//

//Custom Posters Below//
/obj/structure/sign/poster/contraband/syndicate_medical
	name = "Syndicate Medical"
	desc = "Este pôster celebra o renascimento completo e bem sucedido de uma equipe de mineração de seis pessoas, da Syndicate Operatives. Escrito no canto é uma mensagem simples, \"Fique Ganhando\"."
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "poster_sr_syndiemed"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/syndicate_medical, 32)

/obj/structure/sign/poster/contraband/crocin_pool
	name = "SWIM"
	desc = "Esta cartaz disse dramaticamente:\"SWIM\"Parece ser publicidade o uso de Crocin 'recreativamente', em casa, no trabalho, e, o mais sinistro, 'a pizza'. Um logotipo\"Tramsem Mamo.\" está no canto."
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "poster_sr_crocin"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/crocin_pool, 32)

/obj/structure/sign/poster/contraband/icebox_moment
	name = "As above, so below"
	desc = "Este cartaz parece ser instilado que \"O Chefe da Segurança está em cima de uma instalação do sindicato é apenas apropriado. Como acima... tão abaixo."
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "poster_sr_abovebelow"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/icebox_moment, 32)

/obj/structure/sign/poster/contraband/shipstation
	name = "Flight Services - Enlist"
	desc = "Este pôster retrata a longa e desactualizada 'estação' de classe 'Ship' em seu dia de feno. Surpreendentemente, o cartaz parece ser oficial de Nanotrasen, embora com o silêncio que têm sido sobre o assunto..." //A disaster as big as Ship deserves a scandalous coverup.
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "poster_sr_shipstation"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/shipstation, 32)

/obj/structure/sign/poster/contraband/dancing_honk
	name = "DANCE"
	desc = "Este cartaz retrata um mech classe 'HONK' no topo de um palco, ao lado de um poste."
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "poster_sr_honkdance"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/dancing_honk, 32)

/obj/structure/sign/poster/contraband/operative_duffy
	name = "CASH REWARD"
	desc = "Este pôster retrata uma máscara de gás, com detalhes sobre como \"avançar informações\" sobre o paradeiro de quem quer que seja... embora não especifique para quem."
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "poster_sr_duffy"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/operative_duffy, 32)

/obj/structure/sign/poster/contraband/ultra
	name = "ULTRA"
	desc = "Este pôster tem uma palavra nele, \"ULTRA\", que retrata uma pílula sorridente ao lado de um copo. Ominosa."
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "poster_sr_ultra"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/ultra, 32)

/obj/structure/sign/poster/contraband/secborg_vale
	name = "Defaced Valeborg Advertisement"
	desc = "Este cartaz originalmente procurou anunciar a utilidade elegante do valeborg - mas parece ter sido há muito tempo desde desfigurado. Uma palavra está por cima, talvez apropriada, considerando o modelo de segurança mostrado."
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "poster_sr_valeborg"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/secborg_vale, 32)

/obj/structure/sign/poster/contraband/killingjoke // I like Batman :)))
	name = "You don't have to be crazy to work here - but it sure helps!"
	desc = "Um pôster ousadamente afirmando que ser louco abord estações Nanotrasen não é necessário. Mas não dói ter!"
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "poster_sr_killingjoke"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/killingjoke, 32)

/obj/structure/sign/poster/contraband/nri_text
	name = "NRI declaration of sovereignity"
	desc = "Este cartaz faz referência à cópia traduzida da declaração de soberania de Novaya Rossiyskaya Imperiya."
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "nri_texto"

/obj/structure/sign/poster/contraband/nri_text/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>Você procura algumas informações do cartaz...</i>")
	. += "\t[span_info("The First Congress of People's Senators of the NRI...")]"
	. += "\t[span_info("...Testifying respect for the sovereign rights of all peoples belonging to the...")]"
	. += "\t[span_info("...Solemnly proclaims the State sovereignty of the Novaya Rossiyskaya Imperiya over its entire territory and declares its determination to create a monarchic State governed by the rule of law...")]"
	. += "\t[span_info("...This Declaration is the basis for the development of a new Constitution of the NRI, the conclusion of the Imperial Treaty and the improvement of royal legislation.")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/nri_text, 32)

/obj/structure/sign/poster/contraband/nri_rations
	name = "Commonwealth military rations advertisement"
	desc = "Este cartaz provavelmente é um anúncio para rações militares produzidas por uma certa empresa privada como parte da ordem estatal da Defesa Collegia. O braço direito do almirante parece animado."
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "nri_rations"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/nri_rations, 32)

/obj/structure/sign/poster/contraband/nri_voskhod
	name = "VOSKHOD combat armor advertisement"
	desc = "Um cartaz mostrando recentemente desenvolvido armadura de combate VOSKHOD atualmente em uso pelas tropas da Comunidade e infantaria através da fronteira. A palavra 'DRIP' é escrita de cima para baixo do lado esquerdo, presumivelmente se gabando do design superior do terno."
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "nri_voskhod"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/nri_voskhod, 32)

/obj/structure/sign/poster/contraband/nri_pistol
	name = "Szabo-Ivanek service pistol technical poster"
	desc = "Este cartaz parece ser uma documentação técnica para a pistola de serviço Szabo-Ivanek em uso pela maioria das instituições da Commonwealth. Infelizmente, está tudo escrito em Interslavic."
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "nri_pistol"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/nri_pistol, 32)

/obj/structure/sign/poster/contraband/nri_engineer
	name = "Build, Now"
	desc = "Este cartaz mostra um engenheiro de combate imperial olhando para a esquerda do espectador. Como palavras\"Construir, Agora\" estão escritas em cima e em baixo do cartaz."
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "nri_engineer"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/nri_engineer, 32)

/obj/structure/sign/poster/contraband/nri_radar
	name = "Imperial navy enlistment poster"
	desc = "Aliste-se com a marinha imperial hoje! Veja a galáxia, atire em Terrans, pegue PTSD!"
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "nri_radar"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/nri_radar, 32)
