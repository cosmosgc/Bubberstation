/mob/living/silicon/ai/examine(mob/user)
	. = list("<span class='info'>This is [icon2html(src, user)] <EM>[src]</EM>!", EXAMINE_SECTION_BREAK) //SKYRAT EDIT CHANGE
	if(stat == DEAD)
		. += span_warning("[p_They()]Aparecer[p_s()]ser não funcional.")
	. += span_notice("[p_Their()]piso<b>parafusos</b>são[is_anchored ? "tightened" : "loose"].")
	if(is_anchored)
		if(!opened)
			if(!emagged)
				. += span_notice("[p_Their()]painel de acesso é[stat == DEAD ? "damaged" : "closed and locked"], mas poderia ser<b>Invadido</b>Abra.")
			else
				. += span_warning("[p_Their()]O painel de acesso está piscando, a tampa pode ser<b>Invadido</b>Abra.")
		else
			. += span_notice("[p_Their()]A conexão da rede neural pode ser<b>Corta.</b>A tampa do painel de acesso pode ser<b>Invadido</b>De volta ao lugar.")
	if(stat != DEAD)
		if (get_brute_loss())
			if (get_brute_loss() < 30)
				. += span_warning("[p_They()]Veja.[p_s()]levemente amassado.")
			else
				. += span_warning("<B>[p_They()]Veja.[p_s()]Muito amassado!</B>")
		if (get_fire_loss())
			if (get_fire_loss() < 30)
				. += span_warning("[p_They()]Veja.[p_s()]levemente carbonizado.")
			else
				. += span_warning("<B>[p_Their()]A cápsula está derretida e aquecida!</B>")
		if(deployed_shell)
			. += "The wireless networking light is blinking."
		else if (!shunted && !client)
			. += "[src]Core.exe has stopped responding! NTOS is searching for a solution to the problem..."
	//SKYRAT EDIT ADDITION BEGIN - CUSTOMIZATION
	. += get_silicon_flavortext()
	//SKYRAT EDIT ADDITION END
	. += "</span>"

	. += ..()
