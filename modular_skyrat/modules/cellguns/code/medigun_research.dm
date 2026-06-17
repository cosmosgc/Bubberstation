#define RND_SUBCATEGORY_WEAPONS_MEDICALAMMO "/Medical Ammunition"
#define RND_MEDICALAMMO_UTILITY " (Utility)"

//Upgrade Kit//
/datum/design/medigun_speedkit
	name = "VeyMedical CWM-479 upgrade kit"
	desc = "Um kit de atualização para o VeyMedical CWM-479 para ter uma célula interna de maior capacidade, com aumento da taxa de recarga."
	id = "medigun_speed"
	build_type = PROTOLATHE | AWAY_LATHE
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL
	materials = list(
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
	)
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_EQUIPMENT_MEDICAL,
	)
	build_path = /obj/item/device/custom_kit/medigun_fastcharge

/datum/design/medicell
	name = "Base Medicell Design"
	desc = "Não deveria ver isso. Tipo... em tudo."
	build_type = PROTOLATHE | AWAY_LATHE
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_MEDICALAMMO,
	)

//Tier 2 Medicells//

/datum/design/medicell/brute2
	name = "Brute II Medicell"
	desc = "Dá mediguns carregados de células melhorou a funcionalidade de cura de danos brutos."
	id = "brute2medicell"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/weaponcell/medical/brute/tier_2

/datum/design/medicell/burn2
	name = "Burn II Medicell"
	desc = "Dá mediguns carregados com células melhorou a funcionalidade de cura de danos."
	id = "burn2medicell"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/weaponcell/medical/burn/tier_2

/datum/design/medicell/toxin2
	name = "Toxin II Medicell"
	desc = "Dá mediguns carregados com células melhorou a funcionalidade de cura de danos nas toxinas."
	id = "toxin2medicell"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/weaponcell/medical/toxin/tier_2

/datum/design/medicell/oxy2
	name = "Oxygen II Medicell"
	desc = "Dá mediguns carregados de células melhorou a funcionalidade de cura da privação de oxigênio."
	id = "oxy2medicell"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/weaponcell/medical/oxygen/tier_2

//Tier 3 Medicells//

/datum/design/medicell/brute3
	name = "Brute III Medicell"
	desc = "Dá mediguns carregados de células avançado dano bruto cura funcionalidade."
	id = "brute3medicell"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/diamond = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/weaponcell/medical/brute/tier_3

/datum/design/medicell/burn3
	name = "Burn III Medicell"
	desc = "Dá mediguns carregados com células avançadas de dano à queimadura."
	id = "burn3medicell"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/diamond = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/weaponcell/medical/burn/tier_3

/datum/design/medicell/toxin3
	name = "Toxin III Medicell"
	desc = "Dá mediguns carregadas com células, toxina avançada, funcionalidade de cura de danos."
	id = "toxin3medicell"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/diamond = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/weaponcell/medical/toxin/tier_3

/datum/design/medicell/oxy3
	name = "Oxygen III Medicell"
	desc = "Dá mediguns carregados de células, funcionalidade avançada de cura da privação de oxigênio."
	id = "oxy3medicell"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/diamond = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/weaponcell/medical/oxygen/tier_3

//Utility Medicells

/datum/design/medicell/utility
	name = "Utility Medicell"
	category = list(
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_MEDICALAMMO + RND_MEDICALAMMO_UTILITY,
	)

/datum/design/medicell/utility/clot
	name = "Clotting Medicell"
	desc = "Dá funcionalidade de coagulação baseada em projéteis."
	id = "clotmedicell"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/weaponcell/medical/utility/clotting

/datum/design/medicell/utility/temp
	name = "Temperature Adjustment Medicell"
	desc = "Dá funcionalidade de regulação de temperatura corporal baseada em projéteis."
	id = "tempmedicell"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/weaponcell/medical/utility/temperature

/datum/design/medicell/utility/gown
	name = "Hardlight Gown Medicell"
	desc = "Dá funcionalidade de implantação de trajes de luz dura baseados em projéteis."
	id = "gownmedicell"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/weaponcell/medical/utility/hardlight_gown

/datum/design/medicell/utility/bed
	name = "Hardlight Roller Bed Medicell"
	desc = "Dá funcionalidade de implantação de leitos de rolos de luz dura baseados em projéteis. Melhor usado em pacientes já horizontais."
	id = "bedmedicell"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/weaponcell/medical/utility/bed

/datum/design/medicell/utility/salve
	name = "Empty Salve Medicell"
	desc = "Um médico incompleto que requer uma folha de aloé para perceber seu potencial para fornecer a funcionalidade de cura baseada em projéteis."
	id = "salvemedicell"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/device/custom_kit/empty_cell

/datum/design/medicell/utility/body
	name = "Empty Body Teleporter Medicell"
	desc = "Um medicell incompleto que requer um extrato de lodo do espaço azul para fornecer a funcionalidade de recuperação de corpos baseada em projéteis."
	id = "bodymedicell"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/device/custom_kit/empty_cell/body_teleporter

/datum/design/medicell/utility/relocation
	name = "Oppressive Force Relocation Medicell"
	desc = "Dá a funcionalidade de realocação baseada em projéteis com mediguns carregados de células, jogando-os no lobby do Medbay através de manipulação de auto-estado. Só funciona em Medbay quando demitido por usuários autorizados."
	id = "relocatemedicell"
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 3,
	)
	build_path = /obj/item/weaponcell/medical/utility/relocation

#undef RND_SUBCATEGORY_WEAPONS_MEDICALAMMO
#undef RND_MEDICALAMMO_UTILITY
