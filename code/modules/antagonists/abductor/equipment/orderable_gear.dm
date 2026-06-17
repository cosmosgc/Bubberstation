GLOBAL_LIST_INIT(abductor_gear, subtypesof(/datum/abductor_gear))

#define CATEGORY_BASIC_GEAR "Basic Gear"
#define CATEGORY_ADVANCED_GEAR "Advanced Gear"
#define CATEGORY_MISC_GEAR "Miscellaneous Gear"

/datum/abductor_gear
	/// Name of the gear
	var/name = "Generic Abductor Gear"
	/// Description of the gear
	var/description = "Generic description."
	/// Unique ID of the gear
	var/id = "abductor_generic"
	/// Credit cost of the gear
	var/cost = 1
	/// Build path of the gear itself
	var/build_path = null
	/// Category of the gear
	var/category = CATEGORY_BASIC_GEAR

/datum/abductor_gear/agent_helmet
	name = "Agent Helmet"
	description = "Raptar com estilo, estilo picante. Evita rastreamento digital."
	id = "agent_helmet"
	build_path = list(/obj/item/clothing/head/helmet/abductor = 1)

/datum/abductor_gear/agent_vest
	name = "Agent Vest"
	description = "Um colete equipado com tecnologia avançada. Tem dois modos: combate e furtividade."
	id = "agent_vest"
	build_path = list(/obj/item/clothing/suit/armor/abductor/vest = 1)

/datum/abductor_gear/radio_silencer
	name = "Radio Silencer"
	description = "Um dispositivo compacto usado para desligar equipamentos de comunicação."
	id = "radio_silencer"
	build_path = list(/obj/item/abductor/silencer = 1)

/datum/abductor_gear/science_tool
	name = "Science Tool"
	description = "Uma ferramenta de modo duplo para recuperar espécimes e escanear aparências. A varredura pode ser feita através de câmeras."
	id = "science_tool"
	build_path = list(/obj/item/abductor/gizmo = 1)

/datum/abductor_gear/advanced_baton
	name = "Advanced Baton"
	description = "Um bastão de quatro modos usado para incapacitação e restrição de espécimes."
	id = "advanced_baton"
	cost = 2
	build_path = list(/obj/item/melee/baton/abductor = 1)

/datum/abductor_gear/superlingual_matrix
	name = "Superlingual Matrix"
	description = "Uma estrutura misteriosa que permite comunicação instantânea entre usuários. Usá-lo em mãos vai ajustá-lo para o canal de sua nave-mãe. Impressionante até precisar comer algo."
	id = "superlingual_matrix"
	build_path = list(/obj/item/organ/tongue/abductor = 1)
	category = CATEGORY_MISC_GEAR

/datum/abductor_gear/mental_interface
	name = "Mental Interface Device"
	description = "Uma ferramenta de modo duplo para se comunicar diretamente com cérebros sencientes. Pode ser usado para enviar uma mensagem direta para um alvo,\
Ou enviar um comando para um sujeito de teste com uma glândula carregada."
	id = "mental_interface"
	cost = 2
	build_path = list(/obj/item/abductor/mind_device = 1)
	category = CATEGORY_ADVANCED_GEAR

/datum/abductor_gear/reagent_synthesizer
	name = "Reagent Synthesizer"
	description = "Sintetiza uma variedade de reagentes usando proto-matéria."
	id = "reagent_synthesizer"
	cost = 2
	build_path = list(/obj/item/abductor_machine_beacon/chem_dispenser = 1)
	category = CATEGORY_ADVANCED_GEAR

/datum/abductor_gear/shrink_ray
	name = "Shrink Ray Blaster"
	description = "Este é um pedaço de tecnologia alienígena assustadora que aumenta a atração magnética de átomos em um espaço localizado para temporariamente fazer um objeto encolher.\
Isso ou é apenas magia espacial. De qualquer forma, encolhe coisas."
	id = "shrink_ray"
	cost = 2
	build_path = list(/obj/item/gun/energy/shrink_ray = 1)
	category = CATEGORY_ADVANCED_GEAR

/datum/abductor_gear/omnitool
	name = "Alien Omnitool"
	description = "Um dispositivo portátil com um número absurdo de ferramentas integradas. Pode ser usado como um substituto conveniente para qualquer papel.\
Clique com o botão direito para trocar entre equipamentos médicos e hacking."
	id = "omnitool"
	cost = 2
	build_path = list(/obj/item/abductor/alien_omnitool = 1)
	category = CATEGORY_ADVANCED_GEAR

/datum/abductor_gear/cow
	name = "Spare Cow"
	description = "Entrega uma amostra de uma operação de sequestro."
	id = "cow"
	build_path = list(/mob/living/basic/cow = 1, /obj/item/food/grown/wheat = 3)
	category = CATEGORY_MISC_GEAR

/datum/abductor_gear/posters
	name = "Decorative Posters"
	description = "Alguns cartazes, para decorar as paredes da nave-mãe (ou até mesmo a estação) com."
	id = "poster"
	build_path = list(/obj/item/poster/random_abductor = 2)
	category = CATEGORY_MISC_GEAR

#undef CATEGORY_BASIC_GEAR
#undef CATEGORY_ADVANCED_GEAR
#undef CATEGORY_MISC_GEAR
