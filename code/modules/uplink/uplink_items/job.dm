/datum/uplink_category/role_restricted
	name = "Role-Restricted"
	weight = 1

/datum/uplink_item/role_restricted
	category = /datum/uplink_category/role_restricted
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/role_restricted/haunted_magic_eightball
	name = "Haunted Magic Eightball"
	desc = "A maioria das bolas mágicas são brinquedos com dados dentro. Embora idêntico na aparência aos brinquedos inofensivos, este dispositivo oculto atinge o mundo espiritual para encontrar suas respostas. Esteja avisado, que os espíritos são muitas vezes caprichosos ou apenas pequenos idiotas. Para usar, basta falar sua pergunta em voz alta, e então começar a tremer."
	item = /obj/item/toy/eightball/haunted
	cost = 2
	restricted_roles = list(JOB_CURATOR)
	limited_stock = 1 //please don't spam deadchat
	surplus = 1

/datum/uplink_item/role_restricted/mail_counterfeit_kit
	name = "GLA Brand Mail Counterfeit Kit"
	desc = "Uma caixa contendo cinco dispositivos capazes de falsificar o correio do NT. Pode ser usado para armazenar itens dentro como um meio fácil de contrabando de contrabando. Além disso, você pode escolher\"Braço\"o item dentro, fazendo o item ser usado no momento em que o correio é aberto como se a pessoa tivesse usado na mão. O uso mais comum desta característica é com granadas, como força a granada para prime. Pontos de bônus se a granada for detonada instantaneamente. Vem com um micro-computador integrado para fins de configuração."
	item = /obj/item/storage/box/syndie_kit/mail_counterfeit
	cost = 2
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND
	restricted_roles = list(JOB_CARGO_TECHNICIAN, JOB_QUARTERMASTER)
	surplus = 5

/datum/uplink_item/role_restricted/bureaucratic_error
	name = "Organic Capital Disturbance Virus"
	desc = "Randomiza cargos apresentados a novos contratados. Pode levar a poucos oficiais de segurança e/ou palhaços. Uso único."
	item = ABSTRACT_UPLINK_ITEM
	surplus = 0
	limited_stock = 1
	cost = 2
	restricted = TRUE
	restricted_roles = list(JOB_HEAD_OF_PERSONNEL, JOB_QUARTERMASTER)

/datum/uplink_item/role_restricted/bureaucratic_error/spawn_item(spawn_path, mob/user, datum/uplink_handler/uplink_handler, atom/movable/source)
	force_event(/datum/round_event_control/bureaucratic_error, "a syndicate virus")
	return source

/datum/uplink_item/role_restricted/clumsinessinjector //clown ops can buy this too, but it's in the pointless badassery section for them
	name = "Clumsiness Injector"
	desc = "Injete-se com isso para se tornar tão desajeitado como um palhaço... ou injete em outra pessoa para torná-los tão desajeitados como um palhaço. Útil para palhaços que desejam se reconectar com sua antiga natureza palhaço ou para palhaços que desejam atormentar e brincar com sua presa antes de matá-los."
	item = /obj/item/dnainjector/clumsymut
	cost = 1
	restricted_roles = list(JOB_CLOWN)
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND
	surplus = 25

/datum/uplink_item/role_restricted/banana_slippers
	name = "Banana Slippers"
	desc = "Para o criminoso tentando levar seu jogo de roubar sapatos para o próximo nível. Basta jogar as pernas de uma possível vítima, escorregando garantido ou seu TC de volta! A remoção requer a ajuda de um amigo."
	item = /obj/item/clothing/shoes/banana_slippers
	cost = 4
	restricted_roles = list(JOB_CLOWN)
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/role_restricted/ancient_jumpsuit
	name = "Ancient Jumpsuit"
	desc = "Um macacão velho e esfarrapado que não lhe trará nenhum benefício."
	item = /obj/item/clothing/under/color/grey/ancient
	cost = 20
	restricted_roles = list(JOB_ASSISTANT)
	surplus = 0

/datum/uplink_item/role_restricted/oldtoolboxclean
	name = "Ancient Toolbox"
	desc = "Um icônico design de caixa de ferramentas notório com assistentes em todo lugar. Este projeto foi especialmente feito para se tornar mais robusto o mais telecristais que ele tem dentro dele! Ferramentas e luvas isoladas incluídas."
	item = /obj/item/storage/toolbox/mechanical/old/clean
	cost = 2
	restricted_roles = list(JOB_ASSISTANT)
	surplus = 0

/datum/uplink_item/role_restricted/clownpin
	name = "Ultra Hilarious Firing Pin"
	desc = "Um alfinete que, quando inserido em uma arma, faz com que a arma só seja usada por palhaços e pessoas desajeitados e faz essa arma buzinar sempre que alguém tentar disparar."
	cost = 4
	item = /obj/item/firing_pin/clown/ultra
	restricted_roles = list(JOB_CLOWN)
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND
	surplus = 25

/datum/uplink_item/role_restricted/clownsuperpin
	name = "Super Ultra Hilarious Firing Pin"
	desc = "Como o pino de disparo ultra hilário, exceto que a arma que você coloca esse pino explode quando alguém que não é desajeitado ou um palhaço tenta disparar."
	cost = 7
	item = /obj/item/firing_pin/clown/ultra/selfdestruct
	restricted_roles = list(JOB_CLOWN)
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND
	surplus = 25

/datum/uplink_item/role_restricted/syndimmi
	name = "Syndicate Brand MMI"
	desc = "Um MMI modificado para dar leis cyborgs para servir o Sindicato sem ter sua interface danificada por sequenciadores criptográficos. Isso não vai desbloquear seus módulos escondidos."
	item = /obj/item/mmi/syndie
	cost = 2
	restricted_roles = list(JOB_ROBOTICIST, JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_CORONER, JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER)
	surplus = 0

/datum/uplink_item/role_restricted/explosive_hot_potato
	name = "Exploding Hot Potato"
	desc = "Uma batata com explosivos. Na ativação, um mecanismo especial é ativado que impede que seja derrubado. A única maneira de se livrar dele é atacar alguém com ele, fazendo com que ele se atrapalhe a essa pessoa."
	item = /obj/item/hot_potato/syndicate
	cost = 4
	restricted_roles = list(JOB_COOK, JOB_BOTANIST, JOB_CLOWN, JOB_MIME)

/datum/uplink_item/role_restricted/combat_baking
	name = "Combat Bakery Kit"
	desc = "Um kit de armas clandestinas. Contém uma baguete que um mímico habilidoso poderia usar como espada, um par de croissants, e a receita para fazer mais sob demanda. Assim que o trabalho estiver feito, coma as provas."
	item = /obj/item/storage/box/syndie_kit/combat_baking
	cost = 7
	restricted_roles = list(JOB_COOK, JOB_MIME)

/datum/uplink_item/role_restricted/ez_clean_bundle
	name = "EZ Clean Grenade Bundle"
	desc = "Uma caixa com três granadas limpas usando a fórmula Waffle Corp. Serve como um limpador e causa dano ácido a qualquer um parado perto. O ácido só afeta criaturas à base de carbono."
	item = /obj/item/storage/box/syndie_kit/ez_clean
	cost = 6
	surplus = 20
	restricted_roles = list(JOB_JANITOR)

/datum/uplink_item/role_restricted/reverse_bear_trap
	name = "Reverse Bear Trap"
	desc = "Um engenhoso dispositivo de execução usado na cabeça. Armando-o começa um temporizador de 1 minuto montado na armadilha do urso. Quando explodir, as mandíbulas da armadilha abrirão violentamente, matando instantaneamente qualquer um que a use rasgando suas mandíbulas ao meio. Para armar, ataque alguém com ele enquanto não está usando capacete, e você vai forçá-lo em sua cabeça após três segundos ininterruptamente."
	cost = 5
	item = /obj/item/reverse_bear_trap
	restricted_roles = list(JOB_CLOWN)

/datum/uplink_item/role_restricted/modified_syringe_gun
	name = "Modified Syringe Gun"
	desc = "Uma arma de seringa que dispara injetores de DNA em vez de seringas normais."
	item = /obj/item/gun/syringe/dna
	cost = 14
	restricted_roles = list(JOB_GENETICIST, JOB_RESEARCH_DIRECTOR)

/datum/uplink_item/role_restricted/meathook
	name = "Butcher's Meat Hook"
	desc = "Um cutelo brutal em uma cadeia longa, permite que você arraste as pessoas para sua localização."
	item = /obj/item/gun/magic/hook
	cost = 11
	restricted_roles = list(JOB_COOK)

/datum/uplink_item/role_restricted/moltobeso
	name = "Molt'Obeso Sauce Bottle"
	desc = "Uma garrafa de molho Molt'Obeso. Este molho pode estimular a fome nas pessoas, levando-as a comer mais do que pretendiam. Também aumenta a absorção de calorias dos alimentos consumidos."
	item = /obj/item/storage/box/syndie_kit/moltobeso
	cost = 2
	restricted_roles = list(JOB_COOK)

/datum/uplink_item/role_restricted/turretbox
	name = "Disposable Sentry Gun"
	desc = "Um sistema descartável de implantação de armas de sentinelas disfarçado como uma caixa de ferramentas, aplica chave para a funcionalidade."
	item = /obj/item/storage/toolbox/emergency/turret
	cost = 11
	restricted_roles = list(JOB_STATION_ENGINEER, JOB_CHIEF_ENGINEER)

/datum/uplink_item/role_restricted/rebarxbowsyndie
	name = "Syndicate Rebar Crossbow"
	desc = "Uma versão muito mais profissional da besta pirata do engenheiro. 3 tiros, carregamento mais rápido e munição melhor. Manual de proprietários incluído."
	item = /obj/item/storage/box/syndie_kit/rebarxbowsyndie
	cost = 12
	restricted_roles = list(JOB_STATION_ENGINEER, JOB_CHIEF_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN)

/datum/uplink_item/role_restricted/magillitis_serum
	name = "Magillitis Serum Autoinjector"
	desc = "Um auto-injetor de uso único que contém um soro experimental que causa rápido crescimento muscular em Hominidae. Os efeitos colaterais podem incluir hipertricose, explosões violentas e uma afinidade interminável por bananas. Agora também contém produtos químicos regenerativos para manter os usuários saudáveis enquanto exercitam seus novos músculos."
	item = /obj/item/reagent_containers/hypospray/medipen/magillitis
	cost = 15
	restricted_roles = list(JOB_GENETICIST, JOB_RESEARCH_DIRECTOR)

/datum/uplink_item/role_restricted/gorillacube
	name = "Gorilla Cube"
	desc = "Um cubo de gorila da Waffle Corp. Coma grande para ficar grande. Cuidado, o produto pode se hidratar quando exposto à água."
	item = /obj/item/food/monkeycube/gorilla
	cost = 6
	restricted_roles = list(JOB_GENETICIST, JOB_RESEARCH_DIRECTOR)

/datum/uplink_item/role_restricted/brainwash_disk
	name = "Brainwashing Surgery Program"
	desc = "Um disco contendo o procedimento de lavagem cerebral, permitindo implantar um objetivo em um alvo. Insira em uma Consola de Operações para habilitar o procedimento."
	item = /obj/item/disk/surgery/brainwashing
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_CORONER, JOB_ROBOTICIST)
	cost = 5
	surplus = 50

/datum/uplink_item/role_restricted/advanced_plastic_surgery
	name = "Advanced Plastic Surgery Program"
	desc = "Uma cópia pirata de um item colecionador, este disco contém o procedimento para realizar cirurgia plástica avançada, permitindo que você modele o rosto e a voz de alguém com base em uma foto tirada por uma câmera em seu offhand. Todas as mudanças são superficiais e não mudam a composição genética. Insira em uma Consola de Operações para habilitar o procedimento."
	item = /obj/item/disk/surgery/advanced_plastic_surgery
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_ROBOTICIST)
	cost = 1
	surplus = 50

/datum/uplink_item/role_restricted/springlock_module
	name = "Heavily Modified Springlock MODsuit Module"
	desc = "Um módulo que abrange todo o tamanho da unidade MOD, sentado sob a camada externa. Este exoesqueleto mecânico sai do caminho quando o usuário entra e ajuda na inicialização, mas foi tirado de ternos modernos por causa da tendência do Springlock de\"Snap\"De volta ao lugar quando exposto à umidade. Sabe como é ter um exoesqueleto inteiro entrando em você? Esta versão do módulo foi modificada para permitir a ativação imediata do MODsuit. Útil para ligar/desligar rapidamente seu traje MOD, ou para cuidar de um alvo através de um trágico acidente."
	item = /obj/item/mod/module/springlock/bite_of_87
	restricted_roles = list(JOB_ROBOTICIST, JOB_RESEARCH_DIRECTOR)
	cost = 2
	surplus = 15

/datum/uplink_item/role_restricted/reverse_revolver
	name = "Reverse Revolver"
	desc = "Um revólver que sempre dispara em seu usuário.\"Acidamente.\"Largue sua arma, e veja como os gananciosos porcos da empresa explodem seus próprios cérebros na parede. O revólver em si é real. Só pessoas desajeitados, e palhaços, podem atirar normalmente. Vem em uma caixa de abraços. Honk."
	cost = 14
	item = /obj/item/storage/box/hug/reverse_revolver
	restricted_roles = list(JOB_CLOWN)

/datum/uplink_item/role_restricted/pressure_mod
	name = "Kinetic Accelerator Pressure Mod"
	desc = "Um kit de modificação que permite que os aceleradores cinéticos façam grandes estragos dentro de casa. Ocupa 35% de capacidade mod."
	item = /obj/item/borg/upgrade/modkit/indoors
	cost = 5 //you need two for full damage, so total of 10 for maximum damage
	limited_stock = 2 //you can't use more than two!
	restricted_roles = list("Shaft Miner")
	surplus = 20

/datum/uplink_item/role_restricted/mimery
	name = "Guide to Advanced Mimery Series"
	desc = "A série clássica sobre como melhorar suas habilidades mímicas. Ao estudar a série, o usuário deve ser capaz de fazer 3x1 paredes invisíveis, e atirar balas de seus dedos. Obviamente só funciona para Mimes."
	cost = 12
	item = /obj/item/storage/box/syndie_kit/mimery
	restricted_roles = list(JOB_MIME)
	surplus = 10

/datum/uplink_item/role_restricted/laser_arm
	name = "Laser Arm Implant"
	desc = "Um implante que lhe dá uma arma laser recarregando dentro do seu braço. Fraco para PEM. Vem com um autocirurgião do sindicato para auto-aplicação imediata."
	cost = 10
	item = /obj/item/autosurgeon/syndicate/laser_arm
	restricted_roles = list(JOB_ROBOTICIST, JOB_RESEARCH_DIRECTOR)
	surplus = 20

/datum/uplink_item/role_restricted/chemical_gun
	name = "Reagent Dartgun"
	desc = "Uma arma altamente modificada que é capaz de sintetizar seus próprios dardos químicos usando reagentes de entrada. Pode segurar 90u de reagentes."
	item = /obj/item/gun/chem
	cost = 12
	restricted_roles = list(JOB_CHEMIST, JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_BOTANIST)

/datum/uplink_item/role_restricted/pie_cannon
	name = "Banana Cream Pie Cannon"
	desc = "Um canhão especial para um palhaço especial. Este aparelho pode segurar até 20 tortas e fabricar automaticamente uma a cada dois segundos!"
	cost = 10
	item = /obj/item/pneumatic_cannon/pie/selfcharge
	restricted_roles = list(JOB_CLOWN)

/datum/uplink_item/role_restricted/clown_bomb
	name = "Clown Bomb"
	desc = "A bomba do palhaço é um dispositivo hilário capaz de pegadinhas. Ele tem um temporizador ajustável, com um mínimo de %min BOMB TIMER segundos, e pode ser aparafusado no chão com uma chave inglesa para evitar movimento. A bomba é volumosa e não pode ser movida, ao ordenar este item, um farol menor será transportado para você que irá teletransportar a bomba real para ele após ativação. Note que esta bomba pode ser desativada, e alguns tripulantes podem tentar fazê-lo."
	progression_minimum = 15 MINUTES
	item = /obj/item/sbeacondrop/clownbomb
	cost = 15
	restricted_roles = list(JOB_CLOWN)
	surplus = 10

/datum/uplink_item/role_restricted/clown_bomb/New()
	. = ..()
	desc = replacetext(desc, "TEMOR DE MÍNIMAS", SYNDIEBOMB_MIN_TIMER_SECONDS)

/datum/uplink_item/role_restricted/clowncar
	name = "Clown Car"
	desc = "O carro palhaço é o melhor método de transporte para qualquer palhaço digno! Basta inserir sua moto e entrar, e se preparar para ter o passeio mais engraçado da sua vida! Você pode bater em qualquer homem do espaço que encontrar e colocá-los em seu carro, sequestrá-los e trancá-los dentro até que alguém os salve ou eles conseguem rastejar para fora. Certifique-se de não bater em paredes ou máquinas de venda automática, já que os bancos são muito sensíveis. Agora com nosso mecanismo de defesa de lubrificante incluído que irá protegê-lo contra qualquer merda de curiosidade! Recursos premium podem ser desbloqueados com um sequenciador criptográfico!"
	item = /obj/vehicle/sealed/car/clowncar
	cost = 20
	restricted_roles = list(JOB_CLOWN)
	surplus = 10

/datum/uplink_item/role_restricted/clowncar/spawn_item_for_generic_use(mob/user)
	var/obj/vehicle/sealed/car/clowncar/car = ..()
	car.enforce_clown_role = FALSE
	var/obj/item/key = new car.key_type(user.loc)
	car.visible_message(span_notice("[key]Cai fora.[car]Para o chão."))
	return car

/datum/uplink_item/role_restricted/his_grace
	name = "His Grace"
	desc = "Uma arma incrivelmente perigosa recuperada de uma estação superada pela maré cinzenta. Uma vez ativado, Ele terá sede de sangue e deve ser usado para matar para saciar essa sede. Sua Graça concede regeneração gradual e completa imunidade de atordoamento ao seu mantenedor, mas tenha cuidado: se ele ficar com muita fome, ele se tornará impossível de cair e eventualmente matá-lo se não for alimentado. No entanto, se ficar sozinho por muito tempo, ele voltará a dormir. Para ativar Sua Graça, basta desamarrá-lo."
	lock_other_purchases = TRUE
	cant_discount = TRUE
	item = /obj/item/his_grace
	cost = 500 // BUBBER EDIT
	surplus = 0
	restricted_roles = list(JOB_CHAPLAIN)
	purchasable_from = ~UPLINK_SPY

/datum/uplink_item/role_restricted/concealed_weapon_bay
	name = "Concealed Weapon Bay"
	desc = "Uma modificação para exossuits não-combatentes que lhes permite equipar um equipamento projetado para unidades de combate. Anexar a um exossuit com um equipamento existente para disfarçar a baía como esse equipamento. O equipamento sacrificado será perdido. Alternativamente, você pode anexar a baía a um espaço de equipamento vazio, mas a baía não será escondida. Uma vez que a baía está presa, uma arma de exosuit pode ser instalada dentro."
	item = /obj/item/mecha_parts/mecha_equipment/concealed_weapon_bay
	cost = 3
	restricted_roles = list(JOB_ROBOTICIST, JOB_RESEARCH_DIRECTOR)
	surplus = 15

/* // SKYRAT EDIT REMOVAL START
/datum/uplink_item/role_restricted/spider_injector
	name = "Australicus Slime Mutator"
	desc = "Cara, tem sido uma viagem selvagem do setor Australicus, mas conseguimos algum extrato especial de aranha das aranhas gigantes lá embaixo. Use este injetor em um núcleo de lodo de ouro para criar algumas do mesmo tipo de aranhas que encontramos nos planetas lá. Eles são um pouco mansos até que você também dar-lhes um pouco de sensibilidade embora."
	progression_minimum = 30 MINUTES
	item = /obj/item/reagent_containers/syringe/spider_extract
	population_minimum = TRAITOR_POPULATION_LOWPOP
	cost = 10
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST)
	surplus = 10

*/
// SKYRAT EDIT REMOVAL END
/* /datum/uplink_item/role_restricted/blastcannon - BUBBER REMOVE START
	name = "Blast Cannon"
	desc = "Uma arma altamente especializada, o canhão de explosão é relativamente simples. Ele contém uma fixação para uma válvula de transferência de tanque montada em um tubo angulado especialmente construído suportar extrema pressão e temperaturas, e tem um gatilho mecânico para acionar a válvula de transferência. Essencialmente, transforma a força explosiva de uma bomba em uma onda de explosão de ângulo estreito.\"projétil\"Cientistas aspirantes podem achar isso altamente útil, como forçar a onda de choque de pressão em um ângulo estreito parece ser capaz de contornar qualquer peculiaridade da física impede intervalos explosivos acima de uma certa distância, permitindo que o dispositivo use o rendimento teórico de uma bomba de válvula de transferência, em vez do rendimento factual. Seu design simples torna fácil de esconder."
	progression_minimum = 30 MINUTES
	item = /obj/item/gun/blastcannon
	cost = 14 //High cost because of the potential for extreme damage in the hands of a skilled scientist.
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST)
	surplus = 5
BUBBER REMOVE END*/
/datum/uplink_item/role_restricted/evil_seedling
	name = "Evil Seedling"
	desc = "Uma semente rara que recuperamos que cresce em uma espécie perigosa que vai ajudá-lo com suas tarefas!"
	item = /obj/item/seeds/seedling/evil
	cost = 8
	restricted_roles = list(JOB_BOTANIST)

/datum/uplink_item/role_restricted/bee_smoker
	name = "Bee Smoker"
	desc = "Um dispositivo que funciona com cannabis, transformando-o em um gás que pode hipnotizar abelhas para seguir nossos comandos."
	item = /obj/item/bee_smoker
	cost = 4
	restricted_roles = list(JOB_BOTANIST)
	surplus = 0 //requires too much setup to be worth including in surplus crates

/datum/uplink_item/role_restricted/monkey_agent
	name = "Simian Agent Reinforcements"
	desc = "Chame um agente secreto macaco extremamente bem treinado do nosso Departamento de Banana Syndicate. Eles foram treinados para operar máquinas e podem ler, mas eles não podem falar comum. Por favor, note que são macacos livres que não reagem com Mutadone. Pode conter graves alergias a fenômenos de mudança de espécies."
	item = /obj/item/antag_spawner/loadout/monkey_man
	cost = 6
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_GENETICIST, JOB_ASSISTANT, JOB_MIME, JOB_CLOWN, JOB_PUN_PUN)
	restricted = TRUE
	refundable = TRUE

/datum/uplink_item/role_restricted/monkey_supplies
	name = "Simian Agent Supplies"
	desc = "Às vezes você precisa de mais poder de fogo do que um macaco raivoso. Como um macaco raivoso e armado! Macacos podem desempacotar este kit para receber uma bolsa com uma arma de barganha, munição, e alguns suprimentos diversos."
	item = /obj/item/storage/toolbox/guncase/monkeycase
	cost = 4
	limited_stock = 3
	restricted_roles = list(JOB_ASSISTANT, JOB_MIME, JOB_CLOWN, JOB_PUN_PUN)
	restricted = TRUE
	refundable = FALSE


/datum/uplink_item/role_restricted/reticence
	name = "Reticence Cloaked Assasination exosuit"
	desc = "Um exosuit silencioso, rápido e quase invisível, mas excepcionalmente frágil! totalmente equipado com uma pistola quase silenciosa, e um RCD para suas melhores necessidades de assassínio, não inclui ferramentas, sem reembolsos."
	item = /obj/vehicle/sealed/mecha/reticence/loaded
	cost = 20
	restricted_roles = list(JOB_MIME)
	restricted = TRUE
	refundable = FALSE
	progression_minimum = 30 MINUTES
	purchasable_from = parent_type::purchasable_from & ~UPLINK_SPY

/datum/uplink_item/role_restricted/concussivedisk
	name = "Hyperconcussive Diode Disk"
	desc = "Um disco de configuração de díodos que permite que um emissor atire em lasers explosivos potentes. Por favor, note que isso vai diminuir a taxa de fogo do emissor."
	item = /obj/item/emitter_disk/blast
	cost = 5
	restricted_roles = list(JOB_STATION_ENGINEER, JOB_CHIEF_ENGINEER)

/datum/uplink_item/role_restricted/briefcase_gun
	name = "Briefcase Embedded Firearm Trigger"
	desc = "Uma maleta com um mecanismo de disparo embutido no cabo que se conecta à primeira arma armazenada dentro.\"Apontando e atirando\"A maleta irá ativar o mecanismo de disparo, fazendo com que a arma dispare através de um buraco discreto. Trabalhe com qualquer arma que possa caber dentro."
	item = /obj/item/storage/briefcase/gun
	purchasable_from = UPLINK_TRAITORS
	cant_discount = TRUE // remove this when we get uplink logic to have one discount apply to all items on the same stock key
	cost = 4
	surplus = 0
	uplink_item_flags = NONE
	stock_key = "briefcase_gun"
	restricted_roles = list(
		JOB_HEAD_OF_PERSONNEL,
		JOB_LAWYER,
		JOB_QUARTERMASTER,
	)

/datum/uplink_item/role_restricted/briefcase_gun/with_gun
	name = "Briefcase Embedded Firearm Trigger (Combo Deal)"
	desc = parent_type::desc + "Este acordo vem com uma pistola Makarov pré-carregada! Mas sem revistas extras."
	item = /obj/item/storage/briefcase/gun/preloaded
	purchasable_from = parent_type::purchasable_from | UPLINK_SPY
	cost = 8
	surplus = 50
	progression_minimum = /datum/uplink_item/dangerous/pistol::progression_minimum
	population_minimum = /datum/uplink_item/dangerous/pistol::population_minimum
	relevant_child_items = /datum/uplink_item/dangerous/pistol::relevant_child_items
