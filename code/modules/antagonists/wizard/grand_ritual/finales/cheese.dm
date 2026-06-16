/**
 * Gives the wizard a defensive/mood buff and a Wabbajack, a juiced up chaos staff that will surely break something.
 * Everyone but the wizard goes crazy, suffers major brain damage, and is given a vendetta against the wizard.
 * Already insane people are instead cured of their madness, ignoring any other effects as the station around them loses its marbles.
 */
/datum/grand_finale/cheese
	// we don't set name, desc and others, thus we won't appear in the radial choice of a normal finale rune
	dire_warning = TRUE
	minimum_time = 45 MINUTES //i'd imagine speedrunning this would be crummy, but the wizard's average lifespan is barely reaching this point

/datum/grand_finale/cheese/trigger(mob/living/invoker)
	message_admins("[key_name(invoker)] has summoned forth The Wabbajack and cursed the crew with madness!")
	priority_announce("Danger: Extremely potent reality altering object has been summoned on station. Immediate evacuation advised. Brace for impact.", "[command_name()] Higher Dimensional Affairs", 'sound/effects/glass/glassbr1.ogg')

	for (var/mob/living/carbon/human/crewmate as anything in GLOB.human_list)
		if (isnull(crewmate.mind))
			continue
		if (crewmate == invoker) //everyone but the wizard is royally fucked, no matter who they are
			continue
		if (crewmate.has_trauma_type(/datum/brain_trauma/mild/hallucinations)) //for an already insane person, this is retribution
			to_chat(crewmate, span_boldwarning("Seu ambiente de repente se enche de uma cacofonia de risos maníacos e psicodistúrbios..."))
			to_chat(crewmate, span_nicegreen("...mas quando o momento passa, você percebe que qualquer poder de eldritch por trás do evento aconteceu para afetá-lo ressoou dentro das ruínas de sua mente já quebrada, criando uma singularidade de instabilidade mental! Quando ela se desmorona, você se sente... em paz, finalmente."))
			if(crewmate.has_quirk(/datum/quirk/insanity))
				crewmate.remove_quirk(/datum/quirk/insanity)
			else
				crewmate.cure_trauma_type(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)
		else
			//everyone else gets to relish in madness
			//yes killing their mood will also trigger mood hallucinations
			create_vendetta(crewmate.mind, invoker.mind)
			to_chat(crewmate, span_boldwarning("Seu ambiente de repente se enche de uma cacofonia de risadas maníacas e psicodistúrbios.\nVocê sente sua psique interior despedaçar-se em uma miríade de pedaços de vidro irregular de cores desconhecidas do universo, refletindo infinitamente uma luz ofuscante e louca vindo dos mais íntimos santuários de sua mente destruída.\nDepois de uma breve pausa que parecia um milênio, uma frase se recupera incessantemente em sua cabeça, imbuída da falsa esperança de absolvição...\n				<b>[invoker] Deve morrer.</b>"))
			var/datum/brain_trauma/mild/hallucinations/added_trauma = new()
			added_trauma.resilience = TRAUMA_RESILIENCE_ABSOLUTE
			crewmate.adjust_organ_loss(ORGAN_SLOT_BRAIN, BRAIN_DAMAGE_DEATH - 25, BRAIN_DAMAGE_DEATH - 25) //you'd better hope chap didn't pick a hypertool
			crewmate.gain_trauma(added_trauma)
			crewmate.add_mood_event("wizard_ritual_finale", /datum/mood_event/madness_despair)

	//drip our wizard out
	invoker.apply_status_effect(/datum/status_effect/blessing_of_insanity)
	invoker.add_mood_event("wizard_ritual_finale", /datum/mood_event/madness_elation)
	var/obj/item/gun/magic/staff/chaos/true_wabbajack/the_wabbajack = new
	invoker.put_in_active_hand(the_wabbajack)
	to_chat(invoker, span_mind_control("Seu instinto e pensamento racional está gritando com você como [the_wabbajack] aparece em seu aperto firme..."))
