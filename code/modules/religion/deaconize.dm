/**
 * Deaconize
 * Makes a sentient, non-cult member of the station into a Holy person, able to use bibles & other chap gear.
 * Is a one-time use ability, given to all sects that don't have their own variation of it.
 */
/datum/religion_rites/deaconize
	name = "Deaconize"
	desc = "Converte alguém para sua seita. Devem estar dispostos, então a primeira invocação os levará a se juntarem. Eles vão ganhar as mesmas habilidades sagradas que você, este é um uso único, então certifique-se de que eles são dignos!"
	ritual_length = 30 SECONDS
	ritual_invocations = list(
		"A good, honorable person has been brought here by faith ...",
		"With their hands ready to serve ...",
		"Heart ready to listen ...",
		"And soul ready to follow ...",
		"May we offer our own hand in return ..."
	)
	invoke_msg = "And use them to the best of our abilities."
	rite_flags = RITE_ALLOW_MULTIPLE_PERFORMS | RITE_ONE_TIME_USE

	///The person currently being deaconized.
	var/mob/living/carbon/human/potential_deacon

/datum/religion_rites/deaconize/Destroy()
	potential_deacon = null
	return ..()

/datum/religion_rites/deaconize/perform_rite(mob/living/user, atom/religious_tool)
	if(!ismovable(religious_tool))
		to_chat(user, span_warning("Este rito requer um dispositivo religioso para o qual os indivíduos podem ser presos."))
		return FALSE
	var/atom/movable/movable_reltool = religious_tool
	if(!movable_reltool)
		return FALSE
	var/mob/living/carbon/human/possible_deacon = locate() in movable_reltool.buckled_mobs
	if(!possible_deacon)
		to_chat(user, span_warning("Nada está preso ao [movable_reltool]!"))
		return FALSE
	if(!is_valid_for_deacon(possible_deacon, user))
		return FALSE
	//no one invited or this is not the invited person
	if(!potential_deacon || (possible_deacon != potential_deacon))
		INVOKE_ASYNC(src, PROC_REF(invite_deacon), possible_deacon)
		to_chat(user, span_notice("Ofereceram-lhes a oportunidade de se juntarem às nossas fileiras. Espere que decidam e tentem de novo."))
		return FALSE
	return ..()

/datum/religion_rites/deaconize/invoke_effect(mob/living/carbon/human/user, atom/movable/religious_tool)
	. = ..()
	if(!(potential_deacon in religious_tool.buckled_mobs)) //checks one last time if the right corpse is still buckled
		to_chat(user, span_warning("[potential_deacon] Não está mais no altar!"))
		return FALSE
	if(potential_deacon.stat != CONSCIOUS)
		to_chat(user, span_warning("[potential_deacon] Tem que estar consciente para que o ritual funcione!"))
		return FALSE
	if(!potential_deacon.mind)
		to_chat(user, span_warning("[potential_deacon] Um mente parece estrela em outro lugar!"))
		return FALSE
	if(IS_CULTIST(potential_deacon))//what the fuck?!
		to_chat(user, span_warning("[GLOB.deity] Viu um verdeiro mal escuro em [potential_deacon] O coração, e eles foram feridos!"))
		playsound(get_turf(religious_tool), 'sound/effects/pray.ogg', 50, TRUE)
		potential_deacon.gib(DROP_ORGANS|DROP_BODYPARTS)
		return FALSE
	var/datum/brain_trauma/special/honorbound/honor = user.has_trauma_type(/datum/brain_trauma/special/honorbound)
	if(honor && (potential_deacon in honor.guilty))
		honor.guilty -= potential_deacon
	to_chat(user, span_notice("[GLOB.deity] Encaixou.[potential_deacon] Para o código! Eles agora são um papel sagrado! (embora o nível mais baixo de tais)"))
	potential_deacon.mind.set_holy_role(HOLY_ROLE_DEACON)
	GLOB.religious_sect.on_conversion(potential_deacon)
	playsound(get_turf(religious_tool), 'sound/effects/pray.ogg', 50, TRUE)
	return TRUE

///Helper if the passed possible_deacon is valid to become a deacon or not.
/datum/religion_rites/deaconize/proc/is_valid_for_deacon(mob/living/carbon/human/possible_deacon, mob/living/user)
	if(possible_deacon.stat != CONSCIOUS)
		to_chat(user, span_warning("[possible_deacon] Precisa estar vivo e consciente para se juntar!"))
		return FALSE
	if(possible_deacon.mind && possible_deacon.mind.holy_role)
		to_chat(user, span_warning("[possible_deacon] Já é um membro da religião!"))
		return FALSE
	return TRUE

/**
 * Async proc that waits for a response on joining the sect.
 * If they accept, the deaconize rite can now recruit them instead of just offering more invites.
 */
/datum/religion_rites/deaconize/proc/invite_deacon(mob/living/carbon/human/invited)
	var/ask = tgui_alert(invited, "Junta-se.[GLOB.deity]Você deve seguir a ordem do Capelão.", "Invitation", list("Yes", "No"), 60 SECONDS)
	if(ask != "Yes")
		return
	potential_deacon = invited
