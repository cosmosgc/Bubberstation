/datum/wound/blunt/robotic/moderate
	name = "Loosened Screws"
	desc = "Vários instrumentos de fixação semi-externos se soltaram, causando componentes para mexer, inibindo o controle dos membros."
	treat_text = "Recomendo o reabastecimento tópico de instrumentos com uma chave de fenda, embora a manutenção percussiva por meio de golpes de baixa força possa ser suficiente, embora em risco de piorar a lesão."
	examine_desc = "Parece estar facilmente seguro."
	occur_text = "E parece desapertar um pouco."
	severity = WOUND_SEVERITY_MODERATE
	simple_treat_text = "<b>Enfaixamento</b>A ferida reduzirá o impacto até que<b>Os parafusos estão seguros.</b>- Que é<b>Mais rápido.</b>Se feito por<b>Outra pessoa.</b>, a<b>Roboticista</b>, um<b>engenheiro</b>, ou com um<b>HUD diagnóstico</b>."
	homemade_treat_text = "Em um aperto,<b>Manutenção percussiva</b>pode reiniciar os parafusos - cuja chance é aumentada se feito por<b>Outra pessoa.</b>ou com um<b>HUD diagnóstico</b>!"
	status_effect_type = /datum/status_effect/wound/blunt/robotic/moderate
	treat_text_short = "Apply screwdriver or percussive maintenance"
	treatable_tools = list(TOOL_SCREWDRIVER)
	interaction_efficiency_penalty = 1.2
	limp_slowdown = 2.5
	limp_chance = 30
	threshold_penalty = 20
	can_scar = FALSE
	a_or_from = "from"

/datum/wound_pregen_data/blunt_metal/loose_screws
	abstract = FALSE
	wound_path_to_generate = /datum/wound/blunt/robotic/moderate
	viable_zones = list(BODY_ZONE_CHEST, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	threshold_minimum = 30

/datum/wound/blunt/robotic/moderate/uses_percussive_maintenance()
	return TRUE

/datum/wound/blunt/robotic/moderate/treat(obj/item/potential_treater, mob/user)
	if (potential_treater.tool_behaviour == TOOL_SCREWDRIVER)
		fasten_screws(potential_treater, user)
		return TRUE

	return ..()

/// The main treatment for T1 blunt. Uses a screwdriver, guaranteed to always work, better with a diag hud. Removes the wound.
/datum/wound/blunt/robotic/moderate/proc/fasten_screws(obj/item/screwdriver_tool, mob/user)
	if (!screwdriver_tool.tool_start_check())
		return

	var/delay_mult = 1

	if (user == victim)
		delay_mult *= 2

	if (HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
		delay_mult *= 0.5

	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.5

	var/their_or_other = (user == victim ? "[user.p_their()]" : "[victim]'s")
	var/your_or_other = (user == victim ? "your" : "[victim]'s")
	victim.visible_message(span_notice("[user]começa a apertar os parafusos de[their_or_other] [limb.plaintext_zone]..."), 		span_notice("Você começa a apertar os parafusos de[your_or_other] [limb.plaintext_zone]..."))

	if (!screwdriver_tool.use_tool(target = victim, user = user, delay = (6 SECONDS * delay_mult), volume = 50, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return

	victim.visible_message(span_green("[user]acabamentos apertando[their_or_other] [limb.plaintext_zone]!"), 		span_green("Você termina de apertar[your_or_other] [limb.plaintext_zone]!"))

	remove_wound()
