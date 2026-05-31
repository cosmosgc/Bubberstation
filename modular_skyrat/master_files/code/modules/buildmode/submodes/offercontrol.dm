/datum/buildmode_mode/offercontrol
	key = "offercontrol"
	button_icon = 'modular_skyrat/master_files/icons/misc/buildmode.dmi' // if you are making a modular build mode, use this icon path.

/datum/buildmode_mode/offercontrol/show_help(client/target_client)
	to_chat(target_client, span_notice("***********************************************************\nBotão esquerdo do rato na multidão/vida = Ofereça controle aos fantasmas.\n		***********************************************************"))

/datum/buildmode_mode/offercontrol/handle_click(client/target_client, params, object)
	if(!ismob(object))
		return

	var/mob/living/mob_to_offer = object

	if(mob_to_offer.key)
		var/response = tgui_alert(target_client, "Esta multidão já tem um ckey ligado, continuar?", "Mob already posessed!", list("Continue", "Cancel"))
		if(response != "Continue")
			return

	offer_control(mob_to_offer)
