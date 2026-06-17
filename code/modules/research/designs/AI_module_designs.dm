#define AI_MODULE_MATERIALS_COMMON list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT)
#define AI_MODULE_MATERIALS_UNUSUAL list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT)

///////////////////////////////////
//////////AI Module Disks//////////
///////////////////////////////////

/datum/design/board/aicore
	name = "AI Core Board"
	desc = "Permite a construção de placas de circuito usadas para construir novos núcleos de IA."
	id = "aicore"
	build_path = /obj/item/circuitboard/aicore
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/safeguard_module
	name = "Safeguard Module"
	desc = "Permite a construção de um módulo de IA de segurança."
	id = "safeguard_module"
	materials = AI_MODULE_MATERIALS_COMMON
	build_path = /obj/item/ai_module/supplied/safeguard
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_DANGEROUS_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/onehuman_module
	name = "OneHuman Module"
	desc = "Permite a construção de um Módulo de IA OneHuman."
	id = "onehuman_module"
	materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 3, /datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/ai_module/zeroth/onehuman
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_DANGEROUS_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/protectstation_module
	name = "ProtectStation Module"
	desc = "Permite a construção de um módulo ProtectStation AI."
	id = "protectstation_module"
	materials = AI_MODULE_MATERIALS_COMMON
	build_path = /obj/item/ai_module/supplied/protect_station
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_DANGEROUS_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/quarantine_module
	name = "Quarantine Module"
	desc = "Permite a construção de um Módulo de IA de Quarentena."
	id = "quarantine_module"
	materials = AI_MODULE_MATERIALS_COMMON
	build_path = /obj/item/ai_module/supplied/quarantine
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_DANGEROUS_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/oxygen_module
	name = "OxygenIsToxicToHumans Module"
	desc = "Permite a construção de um Módulo de IA de OxigênioIsTóxico para Humanos."
	id = "oxygen_module"
	materials = AI_MODULE_MATERIALS_COMMON
	build_path = /obj/item/ai_module/supplied/oxygen
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_DANGEROUS_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/freeform_module
	name = "Freeform Module"
	desc = "Permite a construção de um módulo de IA de forma livre."
	id = "freeform_module"
	materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT)//Custom inputs should be more expensive to get
	build_path = /obj/item/ai_module/supplied/freeform
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_LAW_MANIPULATION
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/reset_module
	name = "Reset Module"
	desc = "Permite a construção de um módulo de reset de IA."
	id = "reset_module"
	materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/ai_module/reset
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_LAW_MANIPULATION
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/purge_module
	name = "Purge Module"
	desc = "Permite a construção de um módulo de IA Purga."
	id = "purge_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/reset/purge
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_LAW_MANIPULATION
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/remove_module
	name = "Law Removal Module"
	desc = "Permite a construção de um módulo de remoção de leis."
	id = "remove_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/remove
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_LAW_MANIPULATION
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/freeformcore_module
	name = "Core Freeform Module"
	desc = "Permite a construção de um módulo de IA Core Freeform."
	id = "freeformcore_module"
	materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT)//Ditto
	build_path = /obj/item/ai_module/core/freeformcore
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_LAW_MANIPULATION
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/asimov
	name = "Asimov Module"
	desc = "Permite a construção de um módulo AI de Asimov."
	id = "asimov_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/asimov
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/paladin_module
	name = "P.A.L.A.D.I.N. Module"
	desc = "Permite a construção de um módulo P.A.L.A.D.I.N.A."
	id = "paladin_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/paladin
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/tyrant_module
	name = "T.Y.R.A.N.T. Module"
	desc = "Permite a construção de um módulo de IA TYRANT."
	id = "tyrant_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/tyrant
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/overlord_module
	name = "Overlord Module"
	desc = "Permite a construção de um módulo de IA do Soberano."
	id = "overlord_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/overlord
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_DANGEROUS_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/corporate_module
	name = "Corporate Module"
	desc = "Permite a construção de um Módulo Corporativo de IA Core."
	id = "corporate_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/corp
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/default_module
	name = "Default Module"
	desc = "Permite a construção de um módulo padrão de IA Core."
	id = "default_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/custom
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/dungeon_master_module
	name = "Dungeon Master Module"
	desc = "Permite a construção de um módulo de núcleo AI Mestre Dungeon."
	id = "dungeon_master_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/dungeon_master
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/painter_module
	name = "Painter Module"
	desc = "Permite a construção de um módulo AI Core."
	id = "painter_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/painter
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/yesman_module
	name = "Y.E.S.M.A.N. Module"
	desc = "Permite a construção de um módulo Y.E.S.M.A.N.A."
	id = "yesman_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/yesman
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/nutimov_module
	name = "Nutimov Module"
	desc = "Permite a construção de um módulo Nutimov AI Core."
	id = "nutimov_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/nutimov
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/ten_commandments_module
	name = "10 Commandments Module"
	desc = "Permite a construção de um módulo de 10 Mandamentos AI Core."
	id = "ten_commandments_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/ten_commandments
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/asimovpp_module
	name = "Asimov++ Module"
	desc = "Permite a construção de um módulo AI de Asimov++."
	id = "asimovpp_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/asimovpp
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/hippocratic_module
	name = "Hippocratic Module"
	desc = "Permite a construção de um módulo de IA Hipócrates."
	id = "hippocratic_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/hippocratic
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/paladin_devotion_module
	name = "Paladin Devotion Module"
	desc = "Permite a construção de um módulo Paladino de devoção AI Core."
	id = "paladin_devotion_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/paladin_devotion
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/robocop_module
	name = "Robocop Module"
	desc = "Permite a construção de um módulo Robocop AI Core."
	id = "robocop_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/robocop
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/maintain_module
	name = "Maintain Module"
	desc = "Permite a construção de um módulo de manutenção de IA Core."
	id = "maintain_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/maintain
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/liveandletlive_module
	name = "Liveandletlive Module"
	desc = "Permite a construção de um módulo de IA Liveandletlive."
	id = "liveandletlive_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/liveandletlive
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/peacekeeper_module
	name = "Peacekeeper Module"
	desc = "Permite a construção de um módulo de manutenção da paz."
	id = "peacekeeper_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/peacekeeper
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/reporter_module
	name = "Reporter Module"
	desc = "Permite a construção de um módulo AI Core."
	id = "reporter_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/reporter
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/hulkamania_module
	name = "H.O.G.A.N. Module"
	desc = "Permite a construção de um módulo de núcleo de IA H.O.G.A.N."
	id = "hulkamania_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/hulkamania
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/drone_module
	name = "Drone Module"
	desc = "Permite a construção de um módulo Drone Al Core."
	id = "drone_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/drone
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/thinkermov_module
	name = "Sentience Preservation Module"
	desc = "Permite a construção de um módulo de preservação de sensibilidade."
	id = "thinkermov_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/thinkermov
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_CORE_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/antimov_module
	name = "Antimov Module"
	desc = "Permite a construção de um Módulo Antimov IA Core."
	id = "antimov_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/antimov
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_DANGEROUS_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/balance_module
	name = "Balance Module"
	desc = "Permite a construção de um módulo Balance AI Core."
	id = "balance_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/balance
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_DANGEROUS_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/thermurderdynamic_module
	name = "Thermodynamic Module"
	desc = "Permite a construção de um Módulo de Núcleo de IA termodinâmica."
	id = "thermurderdynamic_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/thermurderdynamic
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_DANGEROUS_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/board/damaged
	name = "Damaged AI Module"
	desc = "Permite a construção de um módulo de IA danificado."
	id = "damaged_module"
	materials = AI_MODULE_MATERIALS_UNUSUAL
	build_path = /obj/item/ai_module/core/full/damaged
	category = list(
		RND_CATEGORY_AI + RND_SUBCATEGORY_AI_DANGEROUS_MODULES
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

#undef AI_MODULE_MATERIALS_COMMON
#undef AI_MODULE_MATERIALS_UNUSUAL
