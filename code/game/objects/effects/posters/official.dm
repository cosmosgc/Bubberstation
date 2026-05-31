/obj/item/poster/random_official
	name = "random official poster"
	poster_type = /obj/structure/sign/poster/official/random
	icon_state = "rolled_legit"

/obj/structure/sign/poster/official
	poster_item_name = "motivational poster"
	poster_item_desc = "Um cartaz oficial de Nanotrasen para promover uma força de trabalho obediente e obediente. Vem com suporte adesivo de última geração, para fácil fixação em qualquer superfície vertical."
	poster_item_icon_state = "rolled_legit"
	printable = TRUE

/obj/structure/sign/poster/official/random
	name = "Random Official Poster (ROP)"
	random_basetype = /obj/structure/sign/poster/official
	icon_state = "random_official"
	never_random = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/random, 32)
//This is being hardcoded here to ensure we don't print directionals from the library management computer because they act wierd as a poster item
/obj/structure/sign/poster/official/random/directional
	printable = FALSE

/obj/structure/sign/poster/official/here_for_your_safety
	name = "Here For Your Safety"
	desc = "Um cartaz glorificando a força de segurança da estação."
	icon_state = "here_for_your_safety"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/here_for_your_safety, 32)

/obj/structure/sign/poster/official/nanotrasen_logo
	name = "\improper Nanotrasen logo"
	desc = "Um pôster retratando o logotipo Nanotrasen."
	icon_state = "nanotrasen_logo"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/nanotrasen_logo, 32)

/obj/structure/sign/poster/official/cleanliness
	name = "Cleanliness"
	desc = "Um aviso dos perigos da má higiene."
	icon_state = "cleanliness"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/cleanliness, 32)

/obj/structure/sign/poster/official/help_others
	name = "Help Others"
	desc = "Um pôster encorajando vocês a ajudar os tripulantes."
	icon_state = "help_others"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/help_others, 32)

/obj/structure/sign/poster/official/build
	name = "Build"
	desc = "Um cartaz glorificando a equipe de engenharia."
	icon_state = "build"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/build, 32)

/obj/structure/sign/poster/official/bless_this_spess
	name = "Bless This Spess"
	desc = "Um cartaz abençoando esta área."
	icon_state = "bless_this_spess"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/bless_this_spess, 32)

/obj/structure/sign/poster/official/science
	name = "Science"
	desc = "Um cartaz retratando um átomo."
	icon_state = "science"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/science, 32)

/obj/structure/sign/poster/official/ian
	name = "Ian"
	desc = "Arf arf. Sim."
	icon_state = "ian"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/ian, 32)

/obj/structure/sign/poster/official/obey
	name = "Obey"
	desc = "Um cartaz instruindo o espectador a obedecer à autoridade."
	icon_state = "obey"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/obey, 32)

/obj/structure/sign/poster/official/walk
	name = "Walk"
	desc = "Um cartaz instruindo o espectador a andar em vez de correr."
	icon_state = "walk"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/walk, 32)

/obj/structure/sign/poster/official/state_laws
	name = "State Laws"
	desc = "Um cartaz instruindo os ciborgues a declarar suas leis."
	icon_state = "state_laws"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/state_laws, 32)

/obj/structure/sign/poster/official/love_ian
	name = "Love Ian"
	desc = "Ian é amor, Ian é vida."
	icon_state = "love_ian"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/love_ian, 32)

/obj/structure/sign/poster/official/space_cops
	name = "Space Cops."
	desc = "Um pôster anunciando o programa de TV Space Cops."
	icon_state = "space_cops"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/space_cops, 32)

/obj/structure/sign/poster/official/ue_no
	name = "Ue No."
	desc = "Está tudo em japonês."
	icon_state = "ue_no"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/ue_no, 32)

/obj/structure/sign/poster/official/get_your_legs
	name = "Get Your LEGS"
	desc = "Liderança, experiência, gênio, subordinação."
	icon_state = "get_your_legs"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/get_your_legs, 32)

/obj/structure/sign/poster/official/do_not_question
	name = "Do Not Question"
	desc = "Um cartaz instruindo o espectador a não perguntar sobre coisas que não deveriam saber."
	icon_state = "do_not_question"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/do_not_question, 32)

/obj/structure/sign/poster/official/work_for_a_future
	name = "Work For A Future"
	desc = "Um cartaz encorajando você a trabalhar para o seu futuro."
	icon_state = "work_for_a_future"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/work_for_a_future, 32)

/obj/structure/sign/poster/official/soft_cap_pop_art
	name = "Soft Cap Pop Art"
	desc = "Um pôster de uma arte pop barata."
	icon_state = "soft_cap_pop_art"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/soft_cap_pop_art, 32)

/obj/structure/sign/poster/official/safety_internals
	name = "Safety: Internals"
	desc = "Um pôster instruindo o espectador a usar roupas internas em ambientes raros onde não há oxigênio ou o ar ficou tóxico."
	icon_state = "safety_internals"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/safety_internals, 32)

/obj/structure/sign/poster/official/safety_eye_protection
	name = "Safety: Eye Protection"
	desc = "Um cartaz instruindo o espectador a usar proteção ocular ao lidar com produtos químicos, fumaça ou luzes brilhantes."
	icon_state = "safety_eye_protection"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/safety_eye_protection, 32)

/obj/structure/sign/poster/official/safety_report
	name = "Safety: Report"
	desc = "Um pôster instruindo o espectador a relatar atividade suspeita à força de segurança."
	icon_state = "safety_report"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/safety_report, 32)

/obj/structure/sign/poster/official/report_crimes
	name = "Report Crimes"
	desc = "Um cartaz encorajando a rápida denúncia de crime ou comportamento sedicioso à segurança da estação."
	icon_state = "report_crimes"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/report_crimes, 32)

/obj/structure/sign/poster/official/ion_rifle
	name = "Ion Rifle"
	desc = "Um pôster mostrando um rifle iônico."
	icon_state = "ion_rifle"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/ion_rifle, 32)

/obj/structure/sign/poster/official/foam_force_ad
	name = "Foam Force Ad"
	desc = "Força de espuma, é espuma ou ser espumada!"
	icon_state = "foam_force_ad"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/foam_force_ad, 32)

/obj/structure/sign/poster/official/cohiba_robusto_ad
	name = "Cohiba Robusto Ad"
	desc = "Cohiba Robusto, o charuto elegante."
	icon_state = "cohiba_robusto_ad"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/cohiba_robusto_ad, 32)

/obj/structure/sign/poster/official/anniversary_vintage_reprint
	name = "50th Anniversary Vintage Reprint"
	desc = "Uma reimpressão de um pôster de 2505, comemorando o 50o aniversário da Nanoposters Manufacturing, uma subsidiária da Nanotrasen."
	icon_state = "anniversary_vintage_reprint"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/anniversary_vintage_reprint, 32)

/obj/structure/sign/poster/official/fruit_bowl
	name = "Fruit Bowl"
	desc = "Simples, mas inspirador."
	icon_state = "fruit_bowl"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/fruit_bowl, 32)

/obj/structure/sign/poster/official/pda_ad
	name = "PDA Ad"
	desc = "Um pôster anunciando o mais recente PDA de fornecedores Nanotrasen."
	icon_state = "pda_ad"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/pda_ad, 32)

/obj/structure/sign/poster/official/enlist
	name = "Enlist" // but I thought deathsquad was never acknowledged
	desc = "Aliste-se nas reservas de Nanotrasen Deathsquadron hoje!"
	icon_state = "enlist"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/enlist, 32)

/obj/structure/sign/poster/official/nanomichi_ad
	name = "Nanomichi Ad"
	desc = "Um pôster anunciando cassetes de áudio da marca Nanomichi."
	icon_state = "nanomichi_ad"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/nanomichi_ad, 32)

/obj/structure/sign/poster/official/twelve_gauge
	name = "12 Gauge"
	desc = "Um pôster se gabando da superioridade das balas de 12 calibres."
	icon_state = "twelve_gauge"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/twelve_gauge, 32)

/obj/structure/sign/poster/official/high_class_martini
	name = "High-Class Martini"
	desc = "Eu disse para abanar, sem agitação."
	icon_state = "high_class_martini"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/high_class_martini, 32)

/obj/structure/sign/poster/official/the_owl
	name = "The Owl"
	desc = "A Coruja faria o possível para proteger a estação. Você vai?"
	icon_state = "the_owl"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/the_owl, 32)

/obj/structure/sign/poster/official/no_erp
	name = "No ERP"
	desc = "Este cartaz lembra à tripulação que o planejamento de recursos corporativos não é permitido pela política da empresa, de acordo com os regulamentos governamentais de Spinward sobre megacorporações."
	icon_state = "no_erp"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/no_erp, 32)

/obj/structure/sign/poster/official/wtf_is_co2
	name = "Carbon Dioxide"
	desc = "Este cartaz informativo ensina ao espectador o que é dióxido de carbono."
	icon_state = "wtf_is_co2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/wtf_is_co2, 32)

/obj/structure/sign/poster/official/dick_gum
	name = "Dick Gumshue"
	desc = "Um pôster anunciando as escapadas de Dick Gumshue, detetive rato. Encorajando a tripulação a trazer o poder da justiça para baixo sobre sabotadores de arame."
	icon_state = "dick_gum"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/dick_gum, 32)

/obj/structure/sign/poster/official/there_is_no_gas_giant
	name = "There Is No Gas Giant"
	desc = "Nanotrasen emitiu cartazes, como este, para todas as estações lembrando que rumores de um gigante gasoso são falsos."
	// And yet people still believe...
	icon_state = "there_is_no_gas_giant"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/there_is_no_gas_giant, 32)

/obj/structure/sign/poster/official/periodic_table
	name = "Periodic Table of the Elements"
	desc = "Uma tabela periódica dos elementos, de Hidrogênio a Oganesson, e tudo no meio."
	icon_state = "periodic_table"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/periodic_table, 32)

/obj/structure/sign/poster/official/plasma_effects
	name = "Plasma and the Body"
	desc = "Este cartaz informacional fornece informações sobre os efeitos da exposição ao plasma no cérebro."
	icon_state = "plasma_effects"

/obj/structure/sign/poster/official/plasma_effects/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>Você procura algumas informações do cartaz...</i>")
	. += "\t[span_info("Plasma (scientific name Amenthium) is classified by TerraGov as a Grade 1 Health Hazard, and has significant risks to health associated with chronic exposure.")]"
	. += "\t[span_info("Plasma is known to cross the blood/brain barrier and bioaccumulate in brain tissue, where it begins to result in degradation of brain function. The mechanism for attack is not yet fully known, and as such no concrete preventative advice is available barring proper use of PPE (gloves + protective jumpsuit + respirator).")]"
	. += "\t[span_info("In small doses, plasma induces confusion, short-term amnesia, and heightened aggression. These effects persist with continual exposure.")]"
	. += "\t[span_info("In individuals with chronic exposure, severe effects have been noted. Further heightened aggression, long-term amnesia, Alzheimer's symptoms, schizophrenia, macular degeneration, aneurysms, heightened risk of stroke, and Parkinsons symptoms have all been noted.")]"
	. += "\t[span_info("It is recommended that all individuals in unprotected contact with raw plasma regularly check with company health officials.")]"
	. += "\t[span_info("For more information, please check with TerraGov's extranet site on Amenthium: www.terra.gov/health_and_safety/amenthium/, or our internal risk-assessment documents (document numbers #47582-b (Plasma safety data sheets) and #64210 through #64225 (PPE regulations for working with Plasma), available via NanoDoc to all employees).")]"
	. += "\t[span_info("Nanotrasen: Always looking after your health.")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/plasma_effects, 32)

/obj/structure/sign/poster/official/terragov
	name = "TerraGov: United for Humanity"
	desc = "Um pôster retratando o logotipo e lema de Terragov, lembrando aos espectadores quem está cuidando da humanidade."
	icon_state = "terragov"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/terragov, 32)

/obj/structure/sign/poster/official/corporate_perks_vacation
	name = "Nanotrasen Corporate Perks: Vacation"
	desc = "Este pôster informacional fornece informações sobre alguns dos prêmios disponíveis através do programa NT Corporate Perks, incluindo duas semanas de férias para dois no mundo resort Idyllus."
	icon_state = "corporate_perks_vacation"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/corporate_perks_vacation, 32)

/obj/structure/sign/poster/official/jim_nortons
	name = "Jim Norton's Québécois Coffee"
	desc = "An advertisement for Jim Norton's, the Québécois coffee joint that's taken the galaxy by storm."
	icon_state = "jim_nortons"

/obj/structure/sign/poster/official/jim_nortons/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>Você procura algumas informações do cartaz...</i>")
	. += "\t[span_info("From our roots in Trois-Rivières, we've worked to bring you the best coffee money can buy since 1965.")]"
	. += "\t[span_info("So stop by Jim's today- have a hot cup of coffee and a donut, and live like the Québécois do.")]"
	. += "\t[span_info("Jim Norton's Québécois Coffee: Toujours Le Bienvenu.")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/jim_nortons, 32)

/obj/structure/sign/poster/official/twenty_four_seven
	name = "24-Seven Supermarkets"
	desc = "Um anúncio para 24-sete supermercados, anunciando suas novas 24 paradas como parte de sua parceria com Nanotrasen."
	icon_state = "twenty_four_seven"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/twenty_four_seven, 32)

/obj/structure/sign/poster/official/tactical_game_cards
	name = "Nanotrasen Tactical Game Cards"
	desc = "Um anúncio para os cartões de TCG de Nanotrasen:"
	icon_state = "tactical_game_cards"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/tactical_game_cards, 32)

/obj/structure/sign/poster/official/midtown_slice
	name = "Midtown Slice Pizza"
	desc = "Um anúncio para Midtown Slice Pizza, a parceira oficial de pizzaria de Nanotrasen. Midtown Slice: como uma fatia de casa, não importa onde você esteja."
	icon_state = "midtown_slice"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/midtown_slice, 32)

//SafetyMoth Original PR at https://github.com/BeeStation/BeeStation-Hornet/pull/1747 (Also pull/1982)
//SafetyMoth art credit goes to AspEv
/obj/structure/sign/poster/official/moth_hardhat
	name = "Safety Moth - Hardhats"
	desc = "Este pôster informacional usa Safety MothTM para dizer ao espectador para usar chapéus rígidos em áreas cautelosas.\"É como uma lâmpada para sua cabeça!\""
	icon_state = "aspev_hardhat"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/moth_hardhat, 32)

/obj/structure/sign/poster/official/moth_piping
	name = "Safety Moth - Piping"
	desc = "Este pôster informacional usa o Safety MothTM para dizer aos técnicos atmosféricos tipos corretos de tubulação para serem usados.\"Tubos, não bombas! A colocação adequada dos canos impede o desempenho ruim!\""
	icon_state = "aspev_piping"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/moth_piping, 32)

/obj/structure/sign/poster/official/moth_meth
	name = "Safety Moth - Methamphetamine"
	desc = "Este pôster informacional usa o Safety MothTM para dizer ao espectador para procurar aprovação antes de cozinhar metanfetamina.\"Fique perto da temperatura alvo, e nunca mais passe!\"Você nunca deveria estar fazendo isso."
	icon_state = "aspev_meth"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/moth_meth, 32)

/obj/structure/sign/poster/official/moth_epi
	name = "Safety Moth - Epinephrine"
	desc = "Este cartaz informativo usa o Safety MothTM para informar o espectador para ajudar tripulantes feridos/falecidos com seus injetores de epinefrina.\"Evitar apodrecer órgãos com este simples truque!\""
	icon_state = "aspev_epi"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/moth_epi, 32)

/obj/structure/sign/poster/official/moth_delam
	name = "Safety Moth - Delamination Safety Precautions"
	desc = "Este pôster informacional usa o Safety MothTM para dizer ao espectador para se esconder nos armários quando o cristal de supermatéria foi apagado, para evitar alucinações. Evacuar pode ser uma estratégia melhor."
	icon_state = "aspev_delam"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/moth_delam, 32)

//End of AspEv posters

/obj/structure/sign/poster/fluff/lizards_gas_payment
	name = "Please Pay"
	desc = "Um cartaz feito de forma grosseira pedindo ao leitor para, por favor, pagar por qualquer item que eles queiram deixar a estação."
	icon_state = "gas_payment"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/fluff/lizards_gas_payment, 32)

/obj/structure/sign/poster/fluff/lizards_gas_power
	name = "Conserve Power"
	desc = "Um cartaz feito de forma grosseira pedindo ao leitor para desligar a energia antes de partir. Espero que esteja ligado para reabrirem."
	icon_state = "gas_power"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/fluff/lizards_gas_power, 32)

/obj/structure/sign/poster/official/festive
	name = "Festive Notice Poster"
	desc = "Um cartaz que informa sobre feriados ativos. Nenhum é hoje, então você deve voltar ao trabalho."
	icon_state = "holiday_none"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/festive, 32)

/obj/structure/sign/poster/official/boombox
	name = "Boombox"
	desc = "Um pôster desatualizado contendo uma lista de supostos \"palavras mortas\" e frases de código. O cartaz alega que corporações rivais usam isso para desativar remotamente seus agentes."
	icon_state = "boombox"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/boombox, 32)

/obj/structure/sign/poster/official/download
	name = "You Wouldn't Download A Gun"
	desc = "Um cartaz lembrando à equipe que segredos corporativos devem ficar no local de trabalho."
	icon_state = "download_gun"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/download, 32)

/obj/structure/sign/poster/official/mining
	name = "Undiscovered Species"
	desc = "Um cartaz mostrando uma das espécies de Ash Walker. Nós ainda sabemos muito pouco sobre eles, ser um pioneiro! Quando as pessoas lerem este pôster elas se sentirão melhor!"
	icon_state = "ashwalkers"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/mining, 32)
