
/obj/item/rbmk_upgrade
	name = "\improper RB-MK2 software upgrade disk"
	desc = "Parece estar vazio. Bom trabalho, programadores."
	icon = 'icons/obj/devices/floppy_disks.dmi'
	icon_state = "datadisk2"

/obj/item/rbmk_upgrade/proc/apply_upgrade(obj/machinery/power/rbmk2/machine)
	return TRUE

/obj/item/rbmk_upgrade/proc/can_upgrade(obj/machinery/power/rbmk2/machine)
	return TRUE

//machine handles it.
/obj/machinery/power/rbmk2/item_interaction(mob/living/user, obj/item/tool, list/modifiers)

	if(istype(tool,/obj/item/rbmk_upgrade))
		var/obj/item/rbmk_upgrade/upgrade_disk = tool
		if(upgrade_disk.can_upgrade(src))
			upgrade_disk.apply_upgrade(src)
			balloon_alert(user, "Atualizado!")
		else
			balloon_alert(user, "Não posso atualizar!")
		return TRUE


	. = ..()


//Auto Vent
/obj/item/rbmk_upgrade/auto_vent
	name = "\improper RB-MK2 software upgrade disk - auto vent"
	desc = "Um disco que permite instalar uma atualização no RB-MK que controla automaticamente o uso da ventilação para maximizar o ganho de energia em todas as configurações de temperatura."

/obj/item/rbmk_upgrade/auto_vent/apply_upgrade(obj/machinery/power/rbmk2/machine)
	machine.auto_vent_upgrade = TRUE
	return TRUE

/obj/item/rbmk_upgrade/auto_vent/can_upgrade(obj/machinery/power/rbmk2/machine)
	return !machine.auto_vent_upgrade

//Safeties
/obj/item/rbmk_upgrade/safeties
	name = "\improper RB-MK2 software upgrade disk - safeties optimization"
	desc = "Um disco que permite instalar uma atualização no RB-MK que efetivamente diminui o limiar de segurança de 75% para 95%, evitando ejeção prematura."

/obj/item/rbmk_upgrade/safeties/apply_upgrade(obj/machinery/power/rbmk2/machine)
	machine.safeties_upgrade = TRUE
	machine.RefreshParts()
	return TRUE

/obj/item/rbmk_upgrade/safeties/can_upgrade(obj/machinery/power/rbmk2/machine)
	return !machine.safeties_upgrade

//Overclock
/obj/item/rbmk_upgrade/overclock
	name = "\improper RB-MK2 software upgrade disk - overclock"
	desc = "Um disco que permite instalar uma atualização no RB-MK que permite bloquear o reator."

/obj/item/rbmk_upgrade/overclock/apply_upgrade(obj/machinery/power/rbmk2/machine)
	machine.overclocked_upgrade = TRUE
	return TRUE

/obj/item/rbmk_upgrade/overclock/can_upgrade(obj/machinery/power/rbmk2/machine)
	return !machine.overclocked_upgrade




