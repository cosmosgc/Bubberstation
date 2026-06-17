/datum/uplink_category/device_tools
	name = "Misc. Gadgets"
	weight = 3

/datum/uplink_item/device_tools
	category = /datum/uplink_category/device_tools

/datum/uplink_item/device_tools/soap
	name = "Syndicate Soap"
	desc = "Um surfactante sinistro usado para limpar manchas de sangue para esconder assassinatos e evitar análises de DNA.\
Você também pode deixá-lo debaixo dos pés para deslizar as pessoas."
	item = /obj/item/soap/syndie
	cost = 1
	surplus = 50
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/device_tools/duffelbag
	name = "Suspicous Duffel Bag"
	desc = "Um saco grande para guardar suprimentos extras. Contém um zíper de plastitânio oleado para zíper tático de velocidade máxima,\
E é mais equilibrado nas costas do que um saco normal. Pode segurar dois itens volumosos!"
	item = /obj/item/storage/backpack/duffelbag/syndie
	cost = 2
	surplus = 50

/datum/uplink_item/device_tools/tactical_medkit
	name = "combat first aid kit"
	desc = "Um kit médico para apoio de combate, contém. Duas suturas e malhas medicadas, Gauze, analisador avançado de saúde, e como último remédio de atropina"
	item = /obj/item/storage/medkit/tactical_lite
	cost = 3
	surplus = 72
	purchasable_from = UPLINK_TRAITORS

/datum/uplink_item/device_tools/surgery_syndie
	name = "Full Syndicate Surgery Medkit"
	desc = "O kit médico é um kit de ferramentas contendo todas as ferramentas cirúrgicas, cortinas cirúrgicas,\
Uma seringa e alguns sedativos."
	item = /obj/item/storage/medkit/surgery_syndie
	cost = 3
	surplus = 66

/datum/uplink_item/device_tools/encryptionkey
	name = "Syndicate Encryption Key"
	desc = "Uma chave que, quando inserida em um headset de rádio, permite que você ouça todos os canais do departamento da estação\
bem como falar em um canal criptografado com outros agentes que têm a mesma chave. Além disso, esta chave também protege\
Seu fone de ouvido dos bloqueadores de rádio."
	item = /obj/item/encryptionkey/syndicate
	cost = 2
	surplus = 75
	restricted = TRUE

/datum/uplink_item/device_tools/syndietome
	name = "Syndicate Tome"
	desc = "Usando artefatos raros adquiridos a grande custo, o Sindicato tem engenharia reversa\
os livros aparentemente mágicos de um certo culto. Embora sem as habilidades esotéricas\
dos originais, estas cópias inferiores ainda são bastante úteis.\
Muitas vezes usado por agentes para se proteger contra inimigos que dependem de magia enquanto é realizada.\
Embora, ele pode ser usado para curar e prejudicar outras pessoas com eficácia decente muito como uma bíblia regular.\
Também pode ser usado em mãos para \"clamá-lo\", concedendo-lhe habilidades como padre - nenhum treinamento necessário!"
	item = /obj/item/book/bible/syndicate
	cost = 5

/datum/uplink_item/device_tools/tram_remote
	name = "Tram Remote Control"
	desc = "Quando ligado a um bonde a bordo de sistemas de computador, este dispositivo permite ao usuário manipular os controles remotamente.\
Inclui mudança de direção e um modo rápido para contornar as verificações de segurança da porta e sinais de cruzamento.\
Perfeito para atropelar alguém em nome de um defeito de bonde!"
	item = /obj/item/assembly/control/transport/remote
	cost = 2

/datum/uplink_item/device_tools/thermal
	name = "Thermal Imaging Glasses"
	desc = "Estes óculos podem ser transformados em óculos comuns encontrados em toda a estação.\
Eles permitem que você veja organismos através de paredes capturando a parte superior do espectro de luz infravermelha,\
emitido como calor e luz por objetos. Objetos mais quentes, como corpos quentes, organismos cibernéticos.\
e núcleos de inteligência artificial emitem mais dessa luz do que objetos mais frios como paredes e comportas de ar."
	item = /obj/item/clothing/glasses/thermal/syndi
	cost = 4

/datum/uplink_item/device_tools/cutouts
	name = "Adaptive Cardboard Cutouts"
	desc = "Estes recortes de papelão são revestidos com um material fino que evita a descoloração e faz com que as imagens neles pareçam mais realistas.\
Este pacote contém três, bem como um lápis de cor para mudar suas aparências."
	item = /obj/item/storage/box/syndie_kit/cutouts
	cost = 1
	surplus = 20

//Bubber Edit start - This is normally removed on skyrat upstream
/datum/uplink_item/device_tools/briefcase_launchpad
	name = "Briefcase Launchpad"
	desc = "Uma pasta contendo uma plataforma de lançamento, um dispositivo capaz de teletransportar itens e pessoas de e para alvos até oito peças longe da pasta.\
Também inclui um controle remoto, disfarçado como uma pasta comum. Toque a maleta com o controle remoto para ligá-la."
	surplus = 0
	item = /obj/item/storage/briefcase/launchpad
	cost = 6
	progression_minimum = 50 MINUTES //Normally this is not there but it exist to delay you just buying it and getting into everywhere before sec is prepared
/* //Bubber edit - Moves the comment to keep the syndicate teleport commented out. Skyrat commented this out.
/datum/uplink_item/device_tools/syndicate_teleporter
	name = "Experimental Syndicate Teleporter"
	desc = "Um dispositivo portátil que teleporta o usuário 4-8 metros para frente.\
Cuidado, teletransportar-se para uma parede vai desencadear um teletransporte de emergência paralelo;\
No entanto, se isso falhar, talvez precisem ser costurados novamente.\
Vem com 4 cargas, recarrega aleatoriamente. Garantia nula e vazia se exposta a um pulso eletromagnético."
	item = /obj/item/storage/box/syndie_kit/syndicate_teleporter
	cost = 8
*/ //END SKYRAT EDIT

/datum/uplink_item/device_tools/camera_app
	name = "SyndEye Program"
	desc = "Um disco de dados contendo um aplicativo único que permite assistir câmeras e rastrear membros da tripulação."
	item = /obj/item/disk/computer/syndicate/camera_app
	cost = 1
	surplus = 90
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/device_tools/military_belt
	name = "Chest Rig"
	desc = "Um robusto conjunto de sete faixas de correias que é capaz de manter todo tipo de equipamento tático."
	item = /obj/item/storage/belt/military
	cost = 1

/datum/uplink_item/device_tools/doorjack
	name = "Airlock Authentication Override Card"
	desc = "Um sequenciador criptográfico especializado projetado especificamente para substituir os códigos de acesso da estação.\
Depois de hackear um certo número de comportas, o dispositivo precisará de algum tempo para recarregar."
	item = /obj/item/card/emag/doorjack
	cost = 3

/datum/uplink_item/device_tools/fakenucleardisk
	name = "Decoy Nuclear Authentication Disk"
	desc = "É só um disco normal. Visualmente é idêntico ao negócio real, mas não vai aguentar sob um escrutínio mais profundo pelo Capitão.\
Não tente nos dar isso para completar seu objetivo, nós sabemos melhor!"
	item = /obj/item/disk/nuclear/fake
	cost = 1
	surplus = 1
	uplink_item_flags = NONE

/datum/uplink_item/device_tools/frame
	name = "F.R.A.M.E. disk"
	desc = "Quando inserido em um tablet, este cartucho lhe dá cinco vírus mensageiros que\
quando usado fazer com que o tablet alvo se torne um novo uplink com zero CTs, e imediatamente ficar desbloqueado.\
Você receberá o código de desbloqueio ao ativar o vírus, e o novo uplink pode ser carregado com\
Telecristais normalmente."
	item = /obj/item/disk/computer/virus/frame
	cost = 4
	restricted = TRUE
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/device_tools/frame/spawn_item(spawn_path, mob/user, datum/uplink_handler/uplink_handler, atom/movable/source)
	. = ..()
	var/obj/item/disk/computer/virus/frame/target = .
	if(!target)
		return
	target.current_progression = uplink_handler.progression_points

/datum/uplink_item/device_tools/failsafe
	name = "Failsafe Uplink Code"
	desc = "Quando entrar no uplink vai se auto-destruir imediatamente."
	item = ABSTRACT_UPLINK_ITEM
	cost = 1
	surplus = 0
	restricted = TRUE
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/device_tools/failsafe/spawn_item(spawn_path, mob/user, datum/uplink_handler/uplink_handler, atom/movable/source)
	var/datum/component/uplink/uplink = source.GetComponent(/datum/component/uplink)
	if(!uplink)
		return
	if(!uplink.unlock_note) //no note means it can't be locked (typically due to being an implant.)
		to_chat(user, span_warning("Este dispositivo não suporta a entrada de código!"))
		return

	uplink.failsafe_code = uplink.generate_code()
	var/code = "[islist(uplink.failsafe_code) ? english_list(uplink.failsafe_code) : uplink.failsafe_code]"
	var/datum/antagonist/traitor/traitor_datum = user.mind?.has_antag_datum(/datum/antagonist/traitor)
	if(traitor_datum)
		traitor_datum.antag_memory += "<b>Uplink Failsafe Code:</b> [code]" + "<br>"
		traitor_datum.update_static_data_for_all_viewers()
	to_chat(user, span_warning("The new failsafe code for this uplink is now: [code].[traitor_datum ? " You may check your antagonist info to recall this." : null]"))
	return source //For log icon

/datum/uplink_item/device_tools/toolbox
	name = "Full Syndicate Toolbox"
	desc = "A caixa de ferramentas do Sindicato é um suspeito preto e vermelho. Ele vem carregado com um conjunto completo de ferramentas incluindo um\
Multitool e luvas de combate resistentes a choques e calor."
	item = /obj/item/storage/toolbox/syndicate
	cost = 1
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/device_tools/rad_laser
	name = "Radioactive Microlaser"
	desc = "Um microlaser radioativo disfarçado de analisador padrão de saúde Nanotrasen. Quando usado, emite um\
poderosa explosão de radiação, que, após um curto atraso, pode incapacitar todos, menos os mais protegidos\
de humanóides. Tem duas configurações: intensidade, que controla o poder da radiação,\
e comprimento de onda, que controla o atraso antes do efeito começar."
	item = /obj/item/healthanalyzer/rad_laser
	cost = 3
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/device_tools/suspiciousphone
	name = "Protocol CRAB-17 Phone"
	desc = "O protocolo CRAB-17 Telefone, um telefone emprestado de um terceiro desconhecido, pode ser usado para invadir o mercado espacial, canalizando as perdas da tripulação para sua conta bancária.\
A tripulação pode mover seus fundos para um novo site bancário, a menos que eles HODL, nesse caso eles merecem."
	item = /obj/item/suspiciousphone
	restricted = TRUE
	cost = 7
	limited_stock = 1

/datum/uplink_item/device_tools/binary
	name = "Binary Translator Key"
	desc = "Uma chave que, quando inserida em um fone de rádio, permite ouvir e falar com formas de vida baseadas em silício,\
tais como unidades de IA e ciborgues, através de seu canal binário privado. Cuidado deve\
sejam levados enquanto fazem isso, como se não fossem aliados a vocês, eles estão programados para relatar tais intrusões."
	item = /obj/item/encryptionkey/binary
	cost = 5
	surplus = 75
	restricted = TRUE

/datum/uplink_item/device_tools/emag
	name = "Cryptographic Sequencer"
	desc = "O sequenciador criptográfico, cartão eletromagnético, ou emag, é um pequeno cartão que desbloqueia funções ocultas.\
em dispositivos eletrônicos, subverte funções pretendidas, e quebra facilmente os mecanismos de segurança. Não pode ser usado para abrir comportas."
	item = /obj/item/card/emag
	cost = 4

/datum/uplink_item/device_tools/stimpack
	name = "Stimpack"
	desc = "Stimpacks, a ferramenta de muitos grandes heróis, torná-lo quase imune a atordoamentos e nocautes para cerca de\
5 minutos após a injeção."
	item = /obj/item/reagent_containers/hypospray/medipen/stimulants
	cost = 5
	surplus = 90

/datum/uplink_item/device_tools/super_pointy_tape
	name = "Super Pointy Tape"
	desc = "Um rolo de fita super pontudo. A fita é construída com centenas de pequenas agulhas de metal, o rolo vem com em 5 pedaços. Quando adicionado aos itens o\
O item que foi gravado será incorporado quando jogado nas pessoas. Gravar a boca das pessoas com ela vai machucá-las se for puxado por outra pessoa."
	item = /obj/item/stack/medical/wrap/sticky_tape/pointy/super
	cost = 1

/datum/uplink_item/device_tools/hacked_module
	name = "Hacked AI Law Upload Module"
	desc = "Quando usado com um console de upload, este módulo permite carregar leis prioritárias para uma inteligência artificial.\
Cuidado com o texto, pois inteligências artificiais podem procurar brechas para explorar."
	progression_minimum = 30 MINUTES
	item = /obj/item/ai_module/syndicate
	cost = 4

/datum/uplink_item/device_tools/hypnotic_flash
	name = "Hypnotic Flash"
	desc = "Um flash modificado capaz de hipnotizar alvos. Se o alvo não estiver em um estado mentalmente vulnerável, só os confundirá e os pacificará temporariamente."
	item = /obj/item/assembly/flash/hypnotic
	cost = 7

/datum/uplink_item/device_tools/hypnotic_grenade
	name = "Hypnotic Grenade"
	desc = "Uma granada modificada capaz de hipnotizar alvos. A parte sonora do flashbang causa alucinações, e permitirá que o flash induza um transe hipnótico para os espectadores."
	item = /obj/item/grenade/hypnotic
	cost = 12

/datum/uplink_item/device_tools/singularity_beacon
	name = "Power Beacon"
	desc = "Quando aparafusado para fiação ligado a uma rede elétrica e ativado, este grande dispositivo puxa qualquer\
singularidades gravitacionais ativas ou bolas de tesla em direção a ela. Isso não vai funcionar quando o motor estiver parado.\
em contenção. Por causa de seu tamanho, não pode ser carregado. Ordenando isso.\
envia um pequeno farol que teleportará o farol maior para sua localização após ativação."
	progression_minimum = 20 MINUTES
	item = /obj/item/sbeacondrop
	cost = 4
	surplus = 0 // not while there isnt one on any station
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/device_tools/powersink
	name = "Power Sink"
	desc = "Quando aparafusado para fiação ligado a uma rede de energia e ativado, este grande dispositivo se acende e coloca excessivo\
Carga na grade, causando um apagão na estação. A pia é grande e não pode ser armazenada na maioria.\
Sacos e caixas tradicionais. Cuidado, explodirá se a rede de energia conter energia suficiente."
	progression_minimum = 20 MINUTES
	item = /obj/item/powersink
	cost = 11
	limited_stock = 1

/datum/uplink_item/device_tools/syndicate_contacts
	name = "Polarized Contact Lenses"
	desc = "Lentes de contato de alta tecnologia que se ligam diretamente com a superfície de seus olhos para dar-lhes imunidade aos flashes e\
Luzes brilhantes. Eficaz, acessível e quase indetectável."
	item = /obj/item/syndicate_contacts
	cost = 3

/datum/uplink_item/device_tools/syndicate_climbing_hook
	name = "Syndicate Climbing Hook"
	desc = "Corda de alta tecnologia, uma estrutura de gancho refinado, o pico da tecnologia de escalada. Apenas útil para escalar buracos, desde que o local de operação tenha algum."
	item = /obj/item/climbing_hook/syndicate
	cost = 1
