/obj/item/pai_card/attack_ghost(mob/user)
	. = ..()
	ghost_activate(user)

/**
 * Checks if the user is allowed to be a pAI, and if so, creates a new pAI mob.
 * Assuming the pAI card itself is empty of a personality.
 */
/obj/item/pai_card/proc/ghost_activate(mob/user)
	if(!SSticker.HasRoundStarted())
		return
	if(pai)
		return
	var/pai_ask = tgui_alert(user, "Tornar-se um parceiro? (Aviso, você não pode mais ser revivido, e todas as vidas passadas serão esquecidas!)", "Confirm", list("Yes","No"))
	if(pai_ask != "Yes" || QDELETED(src))
		return
	var/pai_ckey = user.ckey
	if(!user.client || !isobserver(user) || is_banned_from(pai_ckey, ROLE_PAI))
		return
	if(!SSpai.candidates[pai_ckey])
		to_chat(user, span_warning("Matriz de Personalidade Corrompida! Por favor, recarregue o arquivo de Personalidade (Abra a janela de envio do PAI e clique no botão de carga antes de tentar novamente)"))
		return
	var/datum/pai_candidate/candidate = SSpai.candidates[pai_ckey]
	var/mob/living/silicon/pai/ghost_pai = new(src)
	ghost_pai.name = candidate.name || pick(GLOB.ninja_names)
	ghost_pai.real_name = ghost_pai.name
	ghost_pai.key = candidate.ckey
	set_personality(ghost_pai)
	SSpai.candidates -= pai_ckey
	return
