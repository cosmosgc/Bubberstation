/datum/component/obeys_commands/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE_MORE, PROC_REF(on_examine_more))

/datum/component/obeys_commands/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, COMSIG_ATOM_EXAMINE_MORE)

/datum/component/obeys_commands/on_examine(mob/living/source, mob/user, list/examine_list)
	. = ..()
	examine_list += span_notice("Você pode clicar[source.p_them()]Quando adjacente para ver comandos disponíveis.")
	examine_list += span_notice("Você também pode examinar.[source.p_them()]De perto para verificar[source.p_their()]Feridas. Muitos companheiros podem ser curados com suturas ou cremes!")

/datum/component/obeys_commands/proc/on_examine_more(mob/living/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if (IS_DEAD_OR_INCAP(source))
		return
	if (!(user in source.ai_controller?.blackboard[BB_FRIENDS_LIST]))
		return

	if (source.health < source.maxHealth*0.2)
		examine_list += span_bolddanger("[source.p_They()]Veja.[source.p_s()]gravemente ferido.")
	else if (source.health < source.maxHealth*0.5)
		examine_list += span_danger("[source.p_They()]Veja.[source.p_s()]moderadamente ferido.")
	else if (source.health < source.maxHealth*0.8)
		examine_list += span_warning("[source.p_They()]Veja.[source.p_s()]levemente ferido.")
	else
		examine_list += span_notice("[source.p_They()]Veja.[source.p_s()]Estar em boas condições.")
