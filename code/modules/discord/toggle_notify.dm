// Verb to toggle restart notifications
/client/verb/notify_restart()
	set category = "OOC"
	set name = "Notify Restart"
	set desc = "Notifies you on Discord when the server restarts."

	// Safety checks
	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(src, span_warning("Esse recurso requer que a infraestrutura SQL esteja funcionando."))
		return

	if(!SSdiscord) // SS is still starting
		to_chat(src, span_notice("O servidor ainda está funcionando. Por favor, espere antes de tentar ligar sua conta."))
		return

	if(!SSdiscord.enabled)
		to_chat(src, span_warning("Este recurso requer que o servidor esteja rodando no kit de ferramentas TGS."))
		return

	var/stored_id = SSdiscord.lookup_id(usr.ckey)
	if(!stored_id) // Account is not linked
		to_chat(src, span_warning("Isso requer que você ligue sua conta de Discórdia com o\"Conta de Discórdia Link\"Verbo."))
		return

	var/stored_mention = "<@[stored_id]>"
	for(var/member in SSdiscord.notify_members) // If they are in the list, take them out
		if(member == stored_mention)
			SSdiscord.notify_members -= stored_mention 
			to_chat(src, span_notice("Você não será mais notificado quando o servidor reiniciar."))
			return // This is necassary so it doesnt get added again, as it relies on the for loop being unsuccessful to tell us if they are in the list or not

	// If we got here, they arent in the list. Chuck 'em in!
	to_chat(src, span_notice("Você será notificado quando o servidor reiniciar."))
	SSdiscord.notify_members += "[stored_mention]" 
