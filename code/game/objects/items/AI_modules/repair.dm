/* CONTAINS:
 * /obj/item/ai_module/remove
 * /obj/item/ai_module/reset
 * /obj/item/ai_module/reset/purge
**/

/obj/item/ai_module/remove
	name = "\improper 'Remove Law' AI module"
	desc = "Um Módulo de IA para remover leis únicas."
	bypass_law_amt_check = TRUE
	var/lawpos = 1

/obj/item/ai_module/remove/attack_self(mob/user)
	lawpos = tgui_input_number(user, "Law to delete", "Law Removal", lawpos, 50)
	if(!lawpos || QDELETED(user) || QDELETED(src) || !usr.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return
	to_chat(user, span_notice("Lei.[lawpos] Selecionado."))
	..()

/obj/item/ai_module/remove/install(datum/ai_laws/law_datum, mob/user)
	if(lawpos > law_datum.get_law_amount(list(LAW_INHERENT, LAW_SUPPLIED)))
		to_chat(user, span_warning("Não há lei.[lawpos] Para apagar!"))
		return
	..()

/obj/item/ai_module/remove/transmitInstructions(datum/ai_laws/law_datum, mob/sender, overflow)
	..()
	if(law_datum.owner)
		law_datum.owner.remove_law(lawpos)
	else
		law_datum.remove_law(lawpos)

/obj/item/ai_module/reset
	name = "\improper 'Reset' AI module"
	var/targetName = "name"
	desc = "Um módulo IA para remover todas as leis não essenciais."
	bypass_law_amt_check = TRUE

/obj/item/ai_module/reset/handle_unique_ai()
	return

/obj/item/ai_module/reset/transmitInstructions(datum/ai_laws/law_datum, mob/sender, overflow)
	..()
	if(law_datum.owner)
		law_datum.owner.clear_supplied_laws()
		law_datum.owner.clear_ion_laws()
		law_datum.owner.clear_hacked_laws()
	else
		law_datum.clear_supplied_laws()
		law_datum.clear_ion_laws()
		law_datum.clear_hacked_laws()

/obj/item/ai_module/reset/purge
	name = "'Purge' AI Module"
	desc = "Um Módulo IA para purgar todas as leis programadas."

/obj/item/ai_module/reset/purge/transmitInstructions(datum/ai_laws/law_datum, mob/sender, overflow)
	..()
	if(law_datum.owner)
		law_datum.owner.clear_inherent_laws()
		law_datum.owner.clear_zeroth_law(0)
	else
		law_datum.clear_inherent_laws()
		law_datum.clear_zeroth_law(0)
