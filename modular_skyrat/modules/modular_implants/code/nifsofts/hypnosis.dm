/obj/item/disk/nifsoft_uploader/dorms/hypnosis
	name = "Purpura Eye"
	loaded_nifsoft = /datum/nifsoft/action_granter/hypnosis

/datum/nifsoft/action_granter/hypnosis
	name = "Libidine Eye"
	program_desc = "Baseado no equipamento hipnótico fornecido pelo vendedor LustWish, a Libidina Eye NIFSoft permite que o usuário enlace outros em transe hipnótico. (Isto é destinado como uma ferramenta para ERP, não use isso por razões de jogo.)"
	buying_category = NIFSOFT_CATEGORY_FUN
	lewd_nifsoft = TRUE
	purchase_price = 150
	able_to_keep = TRUE
	active_cost = 0.1
	ui_icon = "eye"
	action_to_grant = /datum/action/innate/nif_hypnotize

/datum/action/innate/nif_hypnotize
	name = "Hypnotize"
	background_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'
	button_icon_state = "hypnotize"

/datum/action/innate/nif_hypnotize/Activate()
	var/mob/living/carbon/human/user = owner
	if(!istype(user))
		return FALSE

	var/mob/living/carbon/human/target_human = user.pulling
	if(!istype(target_human) || user.grab_state < GRAB_AGGRESSIVE)
		to_chat(user, span_warning("Precisa pegar alguém agressivamente para hipnotizá-los."))
		return FALSE

	if(!target_human.client?.prefs?.read_preference(/datum/preference/toggle/erp/hypnosis))
		to_chat(user, span_warning("[target_human]Não quer ser hipnotizado."))
		return FALSE

	to_chat(user, span_notice("Você começa a colocar[target_human]em um transe hipnótico."))

	if(!do_after(user, 12 SECONDS, target_human))
		return FALSE

	var/choice = tgui_alert(target_human, "Acredita em hipnose? (Isso permitirá[user]para dar sugestões hipnóticas.", "Hypnosis", list("Yes", "No"))
	if(choice != "Yes")
		to_chat(user, span_warning("[target_human]A atenção se rompe apesar de seus esforços. Eles claramente não parecem interessados!"))
		to_chat(target_human, span_warning("Sua atenção quebra quando percebe que não quer ouvir[user]São sugestões."))
		return FALSE

	user.visible_message(span_purple("[target_human]cai em um sono profundo e hipnótico bem no estalo de seus dedos."), span_purple("Você de repente fica mancando no estalo de[user]Dedos."))
	user.emote("snap")
	target_human.SetSleeping(60 SECONDS)
	target_human.log_message("[target_human] was placed into a hypnotic sleep by [user].", LOG_GAME)

	var/secondary_choice = tgui_alert(user, "Gostaria de dar[target_human]Uma sugestão hipnótica ou liberá-los?", "Hypnosis", list("Suggestion", "Release"))
	while(secondary_choice == "Suggestion" && target_human.IsSleeping())
		if(!in_range(user, target_human))
			to_chat(user, span_warning("Você deve estar em alcance de sussurros para[target_human]para dar sugestões hipnóticas."))
			target_human.SetSleeping(0)
			return FALSE

		var/input_text = tgui_input_text(user, "What would you like to suggest?", "Hypnotic Suggestion")
		to_chat(user, span_purple("Você sussurra em[target_human]É uma voz calmante."))
		to_chat(target_human, span_hypnophrase("[input_text]"))
		secondary_choice = tgui_alert(user, "Would you like to give [target_human] an additional hypnotic suggestion or release them?", "Hypnosis", list("Suggestion", "Release"))

	user.visible_message(span_purple("Você acorda de seu sono profundo e hipnótico. As sugestões de[user]Agora se acomodou em sua mente."), span_purple("[target_human]Acorda de seu sono."))
	target_human.SetSleeping(0)
