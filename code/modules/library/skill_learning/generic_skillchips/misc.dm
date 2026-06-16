//Contains generic skillchips that are fairly short and simple

/obj/item/skillchip/wine_taster
	name = "WINE skillchip"
	desc = "Vinho. É. Não. Versão igual 5."
	auto_traits = list(TRAIT_WINE_TASTER)
	skill_name = "Wine Tasting"
	skill_description = "Reconheça vinho vintage do gosto sozinho. Nunca mais falta uma opinião quando se apresenta com uma bebida desconhecida."
	skill_icon = "wine-bottle"
	activate_message = span_notice("Você se lembra do gosto do vinho.")
	deactivate_message = span_notice("Suas memórias de vinho evaporam.")

/obj/item/skillchip/bonsai
	name = "Hedge 3 skillchip"
	desc = "\"Aprenda como cortar sebes e plantas em vasos em novas formas. Terceira edição.\""
	auto_traits = list(TRAIT_BONSAI)
	skill_name = "Hedgetrimming"
	skill_description = "Aparar sebes e plantas em vasos em novas formas maravilhosas com qualquer faca velha. Não aplicável a plantas plásticas."
	skill_icon = "spa"
	activate_message = span_notice("Sua mente está cheia de arranjos de plantas.")
	deactivate_message = span_notice("Não se lembra mais como é uma cerca viva.")

/obj/item/skillchip/useless_adapter
	name = "Skillchip adapter"
	desc = "Cara, ouvi que você gosta de chips de habilidade então colocamos um chip de habilidade em seu chip de habilidade para que você possa..."
	skill_name = "Useless adapter"
	skill_description = "Permite inserir outro chip de habilidade neste adaptador depois de inserido em seu cérebro..."
	skill_icon = "plug"
	activate_message = span_notice("Agora você pode ativar outro chip através deste adaptador, mas não tem certeza por que fez isso...")
	deactivate_message = span_notice("Você não tem mais o adaptador inútil.")
	skillchip_flags = SKILLCHIP_ALLOWS_MULTIPLE
	// Literally does nothing.
	complexity = 0
	slot_use = 0

/obj/item/skillchip/light_remover
	name = "N16H7M4R3 skillchip"
	desc = "Um chip de habilidade sobre remoção segura de lâmpadas. Quem inventou esse nome horrível deveria ser demitido."
	auto_traits = list(TRAIT_LIGHTBULB_REMOVER)
	skill_name = "Lightbulb Removing"
	skill_description = "Pare de tirar lâmpadas hoje, sem luvas!"
	skill_icon = "lightbulb"
	activate_message = span_notice("Seus receptores de dor são menos sensíveis a objetos quentes.")
	deactivate_message = span_notice("Você sente que objetos quentes podem te parar de novo...")

/obj/item/skillchip/disk_verifier
	name = "K33P-TH4T-D15K skillchip"
	desc = "Um chip de habilidade com uma pequena impressão de um disco de autenticação nuclear estampado nele."
	auto_traits = list(TRAIT_DISK_VERIFIER)
	skill_name = "Nuclear Disk Verification"
	skill_description = "Discos de autenticação nuclear têm um número de série extremamente longo para verificação. Este chip de habilidade armazena esse número, que permite ao usuário detectar falsificações automaticamente."
	skill_icon = "save"
	activate_message = span_notice("Você sente sua mente automaticamente verificando longos números de série em objetos em forma de disco.")
	deactivate_message = span_notice("O reconhecimento inato de números de série de disco absurdamente longos desaparece da sua mente.")

/obj/item/skillchip/entrails_reader
	name = "3NTR41LS skillchip"
	auto_traits = list(TRAIT_ENTRAILS_READER)
	skill_name = "Entrails Reader"
	skill_description = "Ser capaz de aprender sobre a vida de uma pessoa, olhando para seus órgãos internos. Não se confunda com olhar para o futuro."
	skill_icon = "lungs"
	activate_message = span_notice("Você sente que sabe muito sobre interpretar órgãos.")
	deactivate_message = span_notice("O conhecimento dos danos no fígado, tensão no coração e cicatrizes nos pulmões desaparece da sua mente.")

/obj/item/skillchip/appraiser
	name = "GENUINE ID Appraisal Now! skillchip"
	desc = "O nome não poderia ser mais desesperado e auto-explicativo, por padrões de nomes de chips."
	auto_traits = list(TRAIT_ID_APPRAISER)
	skill_name = "ID Appraisal"
	skill_description = "Avaliar uma identificação e ver se é emitida do Centcom, ou apenas uma estação de merda impressa."
	skill_icon = "magnifying-glass"
	activate_message = span_notice("Você acha que pode reconhecer detalhes especiais em cartões de identidade.")
	deactivate_message = span_notice("Havia Algo Especial em Certas Identidades?")

/obj/item/skillchip/sabrage
	name = "Le S48R4G3 skillchip"
	desc = "Um chip de habilidade cheirando a álcool. Melhor usado em conjugação com um sabre ou uma lâmina afiada."
	auto_traits = list(TRAIT_SABRAGE_PRO)
	skill_name = "Sabrage Proficiency"
	skill_description = "Dá ao usuário conhecimento da estrutura complexa da fraqueza estrutural de uma garrafa de champanhe no pescoço, melhorando sua proficiência em ser um exibicionista em festas de oficiais."
	skill_icon = "bottle-droplet"
	activate_message = span_notice("Você sente uma nova compreensão de garrafas de champanhe e métodos sobre como remover suas rolhas.")
	deactivate_message = span_notice("O conhecimento da física sutil que reside dentro de garrafas de champanhe desaparece da sua mente.")

/obj/item/skillchip/brainwashing
	name = "suspicious skillchip"
	auto_traits = list(TRAIT_BRAINWASHING)
	skill_name = "Brainwashing"
	skill_description = "A integridade deste chip está comprometida. Por favor, descarte este chip de habilidade."
	skill_icon = "soap"
	activate_message = span_notice("Mas tudo de uma vez só... algo que envolve colocar um cérebro em uma máquina de lavar?")
	deactivate_message = span_warning("Todo o conhecimento da técnica secreta de lavagem cerebral se foi.")

/obj/item/skillchip/brainwashing/examine(mob/user)
	. = ..()
	. += span_warning("Parece que foi corroído com o tempo, colocar isso na sua cabeça pode não ser a melhor idéia...")

/obj/item/skillchip/brainwashing/on_activate(mob/living/carbon/user, silent = FALSE)
	to_chat(user, span_danger("Você tem uma dor de cabeça forte quando o chip envia memórias corruptas para sua cabeça!"))
	user.adjust_organ_loss(ORGAN_SLOT_BRAIN, 20)
	. = ..()

/obj/item/skillchip/chefs_kiss
	name = "K1SS skillchip"
	desc = "Este chip de habilidade cheira levemente a torta de maçã, que adorável. Consulte um nutricionista antes de usar."
	auto_traits = list(TRAIT_CHEF_KISS)
	skill_name = "Chef's Kiss"
	skill_description = "Permite beijar comida que criou para fazer com amor."
	skill_icon = "cookie"
	activate_message = span_notice("Você se lembra de aprender com sua avó como eles fizeram seus biscoitos com amor.")
	deactivate_message = span_notice("Esquece todas as lembranças que sua avó lhe transmitiu. Eles eram sua avó de verdade?")

/obj/item/skillchip/intj
	name = "Integrated Intuitive Thinking and Judging skillchip"
	auto_traits = list(TRAIT_REMOTE_TASTING)
	skill_name = "Mental Flavour Calculus"
	skill_description = "Ao examinar comida, você pode experimentar os sabores tão bem quanto se você estivesse comendo."
	skill_icon = FA_ICON_DRUMSTICK_BITE
	activate_message = span_notice("Você pensa em sua comida favorita e percebe que pode girar seu sabor em sua mente.")
	deactivate_message = span_notice("Você sente seu palácio mental se desmoronando...")

/obj/item/skillchip/drunken_brawler
	name = "F0RC3 4DD1CT10N skillchip"
	desc = "Um chip de habilidade cheirando a álcool, disse para melhorar a habilidade de lutar enquanto inebriado, como se isso o salvaria da cirrose hepática."
	auto_traits = list(TRAIT_DRUNKEN_BRAWLER)
	skill_name = "Drunken Unarmed Proficiency"
	skill_description = "Quando intoxicado, você ganha maior eficácia desarmado."
	skill_icon = "wine-bottle"
	activate_message = span_notice("Honestamente, você precisa de uma bebida. Nunca se sabe quando alguém pode tentar pular por aqui.")
	deactivate_message = span_notice("Você de repente se sente mais seguro andando pela estação sóbrio...")

/obj/item/skillchip/master_angler
	name = "Mast-Angl-Er skillchip"
	desc = "Um chip cheio de trechos enciclopédicos e factóides sobre pesca e peixes."
	auto_traits = list(TRAIT_REVEAL_FISH, TRAIT_EXAMINE_FISHING_SPOT, TRAIT_EXAMINE_FISH, TRAIT_EXAMINE_DEEPER_FISH)
	skill_name = "Fisherman's Discernment"
	skill_description = "Lista peixes ao examinar um local de pesca, dá uma pista de qualquer coisa que está mordendo o anzol e muito mais."
	skill_icon = "fish"
	activate_message = span_notice("Você sente o conhecimento e a paixão de vários pescadores ensolarados e experientes ardem dentro de você.")
	deactivate_message = span_notice("Você não tem mais vontade de lançar uma vara de pesca perto do rio ensolarado.")

	actions_types = list(/datum/action/cooldown/fishing_tip)

/datum/action/cooldown/fishing_tip
	name = "Dispense Fishing Tip"
	desc = "Lembre-se de uma pérola de sabedoria sobre a pesca."
	button_icon = 'icons/hud/radial_fishing.dmi'
	button_icon_state = "river"
	background_icon_state = "bg_default"
	overlay_icon_state = "bg_default_border"
	cooldown_time = 2.5 SECONDS //enough time to skim through tips.

/datum/action/cooldown/fishing_tip/Activate(atom/target_atom)
	. = ..()
	send_tip_of_the_round(owner, pick(GLOB.fishing_tips), source = "Ancient fishing wisdom")
