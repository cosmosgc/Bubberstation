/obj/item/disk/surgery
	name = "surgery procedure disk"
	desc = "Um disco que contém procedimentos cirúrgicos avançados, deve ser carregado em um Console Operacional."
	icon_state = "datadisk1"
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass=SMALL_MATERIAL_AMOUNT)
	/// List of surgical operations contained on this disk
	var/list/surgeries

/obj/item/disk/surgery/debug
	name = "debug surgery disk"
	desc = "Um disco que contém todos os procedimentos cirúrgicos existentes."
	icon_state = "datadisk1"
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass=SMALL_MATERIAL_AMOUNT)

/obj/item/disk/surgery/debug/Initialize(mapload)
	. = ..()
	surgeries = list()
	for(var/datum/surgery_operation/operation as anything in GLOB.operations.get_instances_from(subtypesof(/datum/surgery_operation)))
		surgeries += operation.type

/obj/item/disk/surgery/advanced_plastic_surgery
	name = "advanced plastic surgery disk"
	desc = "Fornece instruções sobre como realizar cirurgias plásticas mais complexas."

	surgeries = list(
		/datum/surgery_operation/limb/add_plastic,
	)

/obj/item/disk/surgery/advanced_plastic_surgery/examine(mob/user)
	. = ..()
	. += span_info("Desbloqueia o<b>[/datum/surgery_operation/limb/add_plastic::name]</b>Cirurgia cirúrgica.")
	. += span_info("Realizando isso antes de um<i>[/datum/surgery_operation/limb/plastic_surgery::name]</i>Melhora a operação, permitindo que você copie a aparência de qualquer indivíduo, desde que tenha uma foto deles em seu corpo durante a cirurgia.")

/obj/item/disk/surgery/advanced_plastic_surgery/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/examine_lore, 		lore = "Most forms of plastic surgery became obsolete due in no small part to advances in genetics technology. 			Very basic methods still remain in use, but scarcely, and primarily to reverse a patient's disfigurements. 			As a consequence, this item became an antique to many collectors - 			though some back alley surgeons still seek one out for its now uncommon knowledge." 	)

/obj/item/disk/surgery/brainwashing
	name = "brainwashing surgery disk"
	desc = "Fornece instruções sobre como imprimir uma ordem em um cérebro, tornando-o o objetivo principal do paciente."
	surgeries = list(
		/datum/surgery_operation/organ/brainwash,
		/datum/surgery_operation/organ/brainwash/mechanic,
	)

/obj/item/disk/surgery/sleeper_protocol
	name = "suspicious surgery disk"
	desc = "Fornece instruções sobre como converter um paciente em um agente adormecido para o Sindicato."
	surgeries = list(
		/datum/surgery_operation/organ/brainwash/sleeper,
		/datum/surgery_operation/organ/brainwash/sleeper/mechanic,
	)
