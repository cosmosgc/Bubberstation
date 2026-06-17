#define RND_SUBCATEGORY_MACHINE_XENOARCH "/Xenoarchaeology Machinery"
#define RND_SUBCATEGORY_EQUIPMENT_XENOARCH "/Xenoarchaeology Equipment"
#define RND_SUBCATEGORY_TOOLS_XENOARCH "/Xenoarchaeology Tools"
#define RND_SUBCATEGORY_TOOLS_XENOARCH_ADVANCED "/Xenoarchaeology Tools (Advanced)"

/datum/design/xenoarch
	build_type = PROTOLATHE | AWAY_LATHE
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
	)

/datum/design/xenoarch/tool
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_XENOARCH,
	)

/datum/design/xenoarch/tool/hammer
	desc = "Um martelo que pode lentamente remover detritos em rochas estranhas."

/datum/design/xenoarch/tool/hammer/cm1
	name = "Hammer (cm 1)"
	id = "hammer_cm1"
	build_path = /obj/item/xenoarch/hammer/cm1

/datum/design/xenoarch/tool/hammer/cm2
	name = "Hammer (cm 2)"
	id = "hammer_cm2"
	build_path = /obj/item/xenoarch/hammer/cm2

/datum/design/xenoarch/tool/hammer/cm3
	name = "Hammer (cm 3)"
	id = "hammer_cm3"
	build_path = /obj/item/xenoarch/hammer/cm3

/datum/design/xenoarch/tool/hammer/cm4
	name = "Hammer (cm 4)"
	id = "hammer_cm4"
	build_path = /obj/item/xenoarch/hammer/cm4

/datum/design/xenoarch/tool/hammer/cm5
	name = "Hammer (cm 5)"
	id = "hammer_cm5"
	build_path = /obj/item/xenoarch/hammer/cm5

/datum/design/xenoarch/tool/hammer/cm6
	name = "Hammer (cm 6)"
	id = "hammer_cm6"
	build_path = /obj/item/xenoarch/hammer/cm6

/datum/design/xenoarch/tool/hammer/cm10
	name = "Hammer (cm 10)"
	id = "hammer_cm10"
	build_path = /obj/item/xenoarch/hammer/cm10

/datum/design/xenoarch/tool/brush
	name = "Brush"
	desc = "Um pincel que pode lentamente remover detritos em uma rocha estranha."
	id = "xenoarch_brush"
	build_path = /obj/item/xenoarch/brush

/datum/design/xenoarch/tool/xeno_tape
	name = "Xenoarch Tape Measure"
	desc = "Uma fita métrica usada para medir a profundidade escavada de rochas estranhas."
	id = "xenoarch_tapemeasure"
	build_path = /obj/item/xenoarch/tape_measure

/datum/design/xenoarch/tool/scanner
	name = "Xenoarch Handheld Scanner"
	desc = "Um scanner portátil para rochas estranhas, capaz de marcar um\"Seguro.\"profundidade e profundidade máxima."
	id = "xenoarch_handscanner"
	build_path = /obj/item/xenoarch/handheld_scanner

/datum/design/xenoarch/tool/advanced
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
	)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_XENOARCH_ADVANCED,
	)


/datum/design/xenoarch/tool/advanced/scanner
	name = "Xenoarch Advanced Handheld Scanner"
	id = "xenoarch_handscanner_adv"
	build_path = /obj/item/xenoarch/handheld_scanner/advanced

/datum/design/xenoarch/tool/advanced/recoverer
	name = "Xenoarch Handheld Recoverer"
	desc = "Um dispositivo com capacidade de recuperar itens perdidos devido ao tempo."
	id = "xenoarch_handrecoverer"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
	)
	// rebalance material req after first repath/categorization?
	build_path = /obj/item/xenoarch/handheld_recoverer

/datum/design/xenoarch/tool/advanced/adv_hammer
	name = "Advanced Hammer"
	desc = "Um martelo que pode rapidamente remover detritos em uma estranha rocha e mudar profundidades de escavação."
	id = "xenoarch_adv_hammer"
	build_path = /obj/item/xenoarch/hammer/adv

/datum/design/xenoarch/tool/advanced/adv_brush
	name = "Advanced Brush"
	desc = "Um pincel que pode remover rapidamente detritos em uma rocha estranha."
	id = "xenoarch_adv_brush"
	build_path = /obj/item/xenoarch/brush/adv

/datum/design/xenoarch/equipment
	// everything under this except the adv bag feels redundant because cloth/leather are there too
	// but i guess we'll burn that bridge another time
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_XENOARCH,
	)

/datum/design/xenoarch/equipment/bag
	name = "Xenoarchaeology Bag"
	desc = "Um saco que pode segurar 25 pedras ou relíquias estranhas."
	id = "xenoarch_bag"
	build_path = /obj/item/storage/bag/xenoarch

/datum/design/xenoarch/equipment/belt
	name = "Xenoarchaeology Belt"
	desc = "Um cinto que pode segurar todas as ferramentas essenciais para xenoarqueologia."
	id = "xenoarch_belt"
	build_path = /obj/item/storage/belt/utility/xenoarch

/datum/design/xenoarch/equipment/bag_adv
	name = "Advanced Xenoarch Bag"
	desc = "Um saco que pode segurar cerca de 50 pedras estranhas ou relíquias."
	id = "xenoarch_bag_adv"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
	)
	// i kinda hate how this requires diamond, but this is supposed to be a fix pr, burn the gbp on it later
	build_path = /obj/item/storage/bag/xenoarch/adv

/datum/design/board/xenoarch
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_XENOARCH,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/xenoarch/researcher
	name = "Machine Design (Xenoarch Researcher)"
	desc = "Permite a construção de placas de circuito usadas para construir um novo pesquisador xenoarco."
	id = "xeno_researcher"
	build_path = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_researcher

/datum/design/board/xenoarch/scanner
	name = "Machine Design (Xenoarch Scanner)"
	desc = "Permite a construção de placas de circuito usadas para construir um novo scanner xenoarch."
	id = "xeno_scanner"
	build_path = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_scanner

/datum/design/board/xenoarch/recoverer
	name = "Machine Design (Xenoarch Recoverer)"
	desc = "Permite a construção de placas de circuito usadas para construir um novo recuperador de xenoarque."
	id = "xeno_recoverer"
	build_path = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_recoverer

/datum/design/board/xenoarch/digger
	name = "Machine Design (Xenoarch Digger)"
	desc = "Permite a construção de placas de circuito usadas para construir uma nova escavadora xenoarca."
	id = "xeno_digger"
	build_path = /obj/item/circuitboard/machine/xenoarch_machine/xenoarch_digger

/datum/techweb_node/basic_xenoarch
	id = "basic_xenoarch"
	starting_node = TRUE
	display_name = "Xenoarqueologia básica"
	description = "Os desenhos básicos da xenoarqueologia."
	design_ids = list(
		"hammer_cm1",
		"hammer_cm2",
		"hammer_cm3",
		"hammer_cm4",
		"hammer_cm5",
		"hammer_cm6",
		"hammer_cm10",
		"xenoarch_brush",
		"xenoarch_tapemeasure",
		"xenoarch_handscanner",
	)

/datum/techweb_node/xenoarch_storage
	id = TECHWEB_NODE_XENOARCH_STORAGE
	display_name = "Armazém de Xenoarqueologia"
	description = "Quando se lida com xenoarqueologia, pode-se precisar de armazenamento."
	prereq_ids = list(TECHWEB_NODE_XENOARCH_BASIC)
	design_ids = list(
		"xenoarch_belt",
		"xenoarch_bag",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)

/datum/techweb_node/xenoarch_machines
	id = TECHWEB_NODE_XENOARCH_MACHINES
	display_name = "Máquinas de Xenoarqueologia"
	description = "Às vezes, a xenoarqueologia pode consumir tempo, talvez as máquinas possam ajudar?"
	prereq_ids = list(TECHWEB_NODE_XENOARCH_BASIC)
	design_ids = list(
		"xeno_researcher",
		"xeno_scanner",
		"xeno_recoverer",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)

/datum/techweb_node/adv_xenoarch
	id = TECHWEB_NODE_XENOARCH_ADVANCED
	display_name = "Xenoarqueologia avançada"
	description = "Depois de algum tempo, as ferramentas que usamos tornaram-se antiquadas. Precisamos de uma atualização."
	prereq_ids = list(TECHWEB_NODE_XENOARCH_BASIC, TECHWEB_NODE_XENOARCH_MACHINES, TECHWEB_NODE_XENOARCH_STORAGE)
	design_ids = list(
		"xenoarch_adv_hammer",
		"xenoarch_adv_brush",
		"xenoarch_bag_adv",
		"xenoarch_handscanner_adv",
		"xenoarch_handrecoverer",
		"xeno_digger",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	required_experiments = list(/datum/experiment/scanning/points/xenoarch)

/datum/experiment/scanning/points/xenoarch
	name = "Advanced Xenoarchaeology Tools"
	description = "É possível criar ferramentas ainda mais avançadas para xenoarchaeoloy."
	required_points = 10
	required_atoms = list(
		/obj/item/xenoarch/useless_relic = 1,
		/obj/item/xenoarch/broken_item = 2,
	)

#undef RND_SUBCATEGORY_MACHINE_XENOARCH
#undef RND_SUBCATEGORY_EQUIPMENT_XENOARCH
#undef RND_SUBCATEGORY_TOOLS_XENOARCH
#undef RND_SUBCATEGORY_TOOLS_XENOARCH_ADVANCED
