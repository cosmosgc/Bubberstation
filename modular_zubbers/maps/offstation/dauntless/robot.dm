/obj/item/borg/upgrade/syndicate_access
	name = "Syndicate cyborg access override"
	desc = "Faz qualquer modelo de cyborg aparecer como um sindicato de cyborg para sindicar sistemas de alvo, adicionalmente dando-lhes acesso às comportas do sindicato.\
	\n\nManuseie com extremo cuidado para evitar cyborgs desonestos em sua nave/estação designada"

	// It is not module specific
	one_use = TRUE

/obj/item/borg/upgrade/syndicate_access/action(mob/living/silicon/robot/R, user)
	. = ..()
	// Turns out this is all you need for access to the doors. See code\game\machinery\_machinery.dm
	R.add_faction(ROLE_SYNDICATE)
	to_chat(R, span_alert("Acesso adicional detectado! Interface de câmera remota destruída."))
	to_chat(user, span_warning("O cyborg gira um pouco como níveis de acesso adicionais são adicionados, e o módulo de câmera remota corta um fusível."))
	// Remove the camera, much like how the camera is removed for ghost cafe cyborgs
	if(!QDELETED(R.builtInCamera))
		QDEL_NULL(R.builtInCamera)


/obj/item/borg/upgrade/syndicate_access/deactivate(mob/living/silicon/robot/R, user)
	. = ..()
	R.set_faction(initial(faction))

/obj/item/borg/upgrade/syndicate_access/dauntless/examine_more(mob/user)
	. = ..()
	. += span_notice("Este parece incluir um chip de comunicação Interdyne. Que legal!")

/obj/item/borg/upgrade/syndicate_access/dauntless/action(mob/living/silicon/robot/R, user)
	. = ..()

	// Yes, this forces out and removes any other keys. Which it should, in this case.
	R.radio.keyslot = new /obj/item/encryptionkey/headset_syndicate/cybersun(src)
	R.radio.recalculateChannels()
