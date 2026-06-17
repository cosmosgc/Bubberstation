/obj/item/organ/cyberimp/chest/scanner
	name = "internal health analyzer"
	desc = "Um implante avançado de analisador de saúde, projetado para interagir diretamente com o corpo de um hospedeiro e retransmitir informações de varredura para o cérebro sob comando."
	slot = ORGAN_SLOT_SCANNER
	icon = 'modular_skyrat/modules/implants/icons/internal_HA.dmi'
	icon_state = "internal_HA"
	actions_types = list(/datum/action/item_action/organ_action/use/internal_analyzer)
	w_class = WEIGHT_CLASS_SMALL

/datum/action/item_action/organ_action/use/internal_analyzer
	desc = "Exame de saúde. Sondagem química. Requer um analisador implantado para não falhar devido a PEMs ou outras causas. Não presta assistência ao tratamento."

/datum/action/item_action/organ_action/use/internal_analyzer/Trigger(trigger_flags)
	. = ..()
	var/obj/item/organ/cyberimp/chest/scanner/our_scanner = target
	if(our_scanner.organ_flags & ORGAN_FAILING)
		to_chat(owner, span_warning("Seu analisador de saúde retransmite um erro! Ele não pode interagir com seu corpo em sua condição atual!"))
		return
	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		chemscan(owner, owner)
	else
		healthscan(owner, owner, SCANNER_VERBOSE, TRUE)
