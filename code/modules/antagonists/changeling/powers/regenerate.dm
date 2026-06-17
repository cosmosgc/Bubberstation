/datum/action/changeling/regenerate
	name = "Regenerate"
	desc = "Permite-nos refazer e restaurar membros externos desaparecidos e órgãos internos vitais, bem como remover estilhaços, curar grandes feridas, e restaurar o volume de sangue. Custa 10 produtos químicos."
	helptext = "Will alert nearby crew if any external limbs are regenerated. Can be used while unconscious."
	button_icon_state = "regenerate"
	chemical_cost = 10
	dna_cost = CHANGELING_POWER_INNATE
	req_stat = HARD_CRIT

/datum/action/changeling/regenerate/sting_action(mob/living/user)
	if(!iscarbon(user))
		user.balloon_alert(user, "Nada faltando!")
		return FALSE

	..()
	to_chat(user, span_notice("Você sente uma coceira, dentro e fora, enquanto seus tecidos tricotam e retricotam."))
	var/mob/living/carbon/carbon_user = user
	var/got_limbs_back = length(carbon_user.get_missing_limbs()) >= 1
	carbon_user.fully_heal(HEAL_BODY)
	// Occurs after fully heal so the ling themselves can hear the sound effects (if deaf prior)
	if(got_limbs_back)
		playsound(user, 'sound/effects/magic/demon_consume.ogg', 50, TRUE)
		carbon_user.visible_message(
			span_warning("[user]'s missing limbs reform, making a loud, grotesque sound!"),
			span_userdanger("Seus membros cresceram, fazendo um som alto, crocante e dando-lhe uma grande dor!"),
			span_hear("Você ouve matéria orgânica rasgando e rasgando!"),
		)
		carbon_user.emote("scream")

	return TRUE
