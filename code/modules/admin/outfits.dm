GLOBAL_LIST_EMPTY(custom_outfits) //Admin created outfits


/datum/admins/proc/save_outfit(mob/admin, datum/outfit/O)
	O.save_to_file(admin)
	SStgui.update_user_uis(admin)

/datum/admins/proc/delete_outfit(mob/admin, datum/outfit/O)
	GLOB.custom_outfits -= O
	qdel(O)
	to_chat(admin,span_notice("Roupa deletada."))
	SStgui.update_user_uis(admin)

/datum/admins/proc/load_outfit(mob/admin)
	var/outfit_file = input("Escolha o arquivo do Json.", "File") as null|file
	if(!outfit_file)
		return
	var/filedata = file2text(outfit_file)
	var/json = json_decode(filedata)
	if(!json)
		to_chat(admin,span_warning("Erro de decodificação JSON."))
		return
	var/otype = text2path(json["outfit_type"])
	if(!ispath(otype,/datum/outfit))
		to_chat(admin,span_warning("Arquivo deformado/outdated."))
		return
	var/datum/outfit/O = new otype
	if(!O.load_from(json))
		to_chat(admin,span_warning("Arquivo deformado/outdated."))
		return
	GLOB.custom_outfits += O
	SStgui.update_user_uis(admin)

