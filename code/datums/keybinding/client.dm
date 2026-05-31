/datum/keybinding/client
	category = CATEGORY_CLIENT
	weight = WEIGHT_HIGHEST


/datum/keybinding/client/admin_help
	hotkey_keys = list("F1")
	name = "admin_help"
	full_name = "Ajuda de administração"
	description = "Peça ajuda a um administrador."
	keybind_signal = COMSIG_KB_CLIENT_GETHELP_DOWN

/datum/keybinding/client/admin_help/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	user.adminhelp()
	return TRUE


/datum/keybinding/client/screenshot
	hotkey_keys = list("F2")
	name = "quick screenshot"
	full_name = "Ecrã Rápido"
	description = "Tire uma imagem, que será armazenada na pasta de imagens de BYOND."
	keybind_signal = COMSIG_KB_CLIENT_SCREENSHOT_DOWN
	can_edit = FALSE

/datum/keybinding/client/screenshot/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	to_chat(user, span_notice("Imagem salva na pasta \"BYOND/screenshots\"."))
	//This is dealt by BYOND. Keeping this here in case that ever changes, though this command doesn't actually work when manually called.
	//winset(user, null, "command=.screenshot auto")
	return TRUE

/datum/keybinding/client/screenshot_loc
	hotkey_keys = list("ShiftF2")
	name = "screenshot as"
	full_name = "Salvar imagem como"
	description = "Tire uma imagem e guarde em um local específico."
	keybind_signal = COMSIG_KB_CLIENT_SCREENSHOT_AS_DOWN
	can_edit = FALSE

/datum/keybinding/client/screenshot_loc/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	//This is dealt by BYOND. Keeping this here in case that ever changes.
	//winset(user, null, "command=.screenshot")
	return TRUE

/datum/keybinding/client/toggle_fullscreen
	hotkey_keys = list("F11")
	name = "toggle_fullscreen"
	full_name = "Alternar tela cheia"
	description = "A janela do jogo está cheia."
	keybind_signal = COMSIG_KB_CLIENT_FULLSCREEN_DOWN

/datum/keybinding/client/toggle_fullscreen/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	user.toggle_fullscreen()
	return TRUE

/datum/keybinding/client/minimal_hud
	hotkey_keys = list("F12")
	name = "minimal_hud"
	full_name = "HUD Mínimo"
	description = "Esconder a maioria das características do HUD"
	keybind_signal = COMSIG_KB_CLIENT_MINIMALHUD_DOWN

/datum/keybinding/client/minimal_hud/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	user.mob.button_pressed_F12()
	return TRUE

/datum/keybinding/client/close_every_ui
	hotkey_keys = list("Northwest") // HOME key
	name = "close_every_ui"
	full_name = "Fechar as UI abertas"
	description = "Fecha todas as janelas que você tem abertas."
	keybind_signal = COMSIG_KB_CLIENT_CLOSEUI_DOWN

/datum/keybinding/client/close_every_ui/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	SStgui.close_user_uis(user.mob)
	return TRUE
