/datum/bloodsucker_clan/nosferatu
	name = CLAN_NOSFERATU
	description = "O clã Nosferatu é incapaz de se misturar com a tripulação, sem habilidades como Masquerade e Veil.\n\
Além disso, tem uma dor permanente nas costas e parece um sanguessuga em um simples exame, e seu rosto está desfigurado.\n\
Eles podem caber na ventilação.\n\
O Ghoul Favorito também está permanentemente desfigurado, e também pode ventrawl, mas apenas enquanto completamente nu.\n\
Eles também têm visão noturna, sabem o que cada fio faz, e têm passos silenciosos."
	clan_objective = /datum/objective/bloodsucker/kindred
	join_icon_state = "nosferatu"
	join_description = "Você está permanentemente desfigurado, parece um sanguessuga para todos que te examinam,\
perder sua habilidade de mascarado, mas ganhar a habilidade de Ventcrawl mesmo quando vestido."
	blood_drink_type = BLOODSUCKER_DRINK_INHUMANELY
	var/ventcrawl_time = 10 SECONDS

/datum/bloodsucker_clan/nosferatu/New(datum/antagonist/bloodsucker/owner_datum)
	. = ..()
	for(var/datum/action/cooldown/bloodsucker/power as anything in bloodsuckerdatum.powers)
		if(istype(power, /datum/action/cooldown/bloodsucker/masquerade) || istype(power, /datum/action/cooldown/bloodsucker/veil))
			bloodsuckerdatum.RemovePower(power)
	var/mob/living/mob = bloodsuckerdatum.owner.current
	if(!mob.has_quirk(/datum/quirk/badback))
		mob.add_quirk(/datum/quirk/badback)

	mob.add_traits(list(TRAIT_DISFIGURED, TRAIT_VENTCRAWLER_NUDE), BLOODSUCKER_TRAIT)

	RegisterSignal(bloodsuckerdatum, COMSIG_BLOODSUCKER_EXAMINE, PROC_REF(on_mob_examine))
	RegisterSignal(mob, COMSIG_CAN_VENTCRAWL, PROC_REF(can_ventcrawl))
	RegisterSignal(mob, COMISG_VENTCRAWL_PRE_ENTER, PROC_REF(on_ventcrawl_enter))
	RegisterSignal(mob, COMSIG_VENTCRAWL_PRE_EXIT, PROC_REF(on_ventcrawl_pre_exit))
	RegisterSignal(mob, COMSIG_VENTCRAWL_EXIT, PROC_REF(on_ventcrawl_exit))
	RegisterSignal(mob, COMSIG_VENTCRAWL_PRE_CANCEL, PROC_REF(on_ventcrawl_cancel))

/datum/bloodsucker_clan/nosferatu/proc/get_ventcrawl_time()
	return max(ventcrawl_time - bloodsuckerdatum.GetRank() SECONDS, 2 SECONDS)

/datum/bloodsucker_clan/nosferatu/proc/can_ventcrawl(mob/living/carbon/human/owner_mob, atom/vent, provide_feedback)
	SIGNAL_HANDLER
	for(var/item in owner_mob.held_items)
		if(isnull(item))
			continue
		if(provide_feedback)
			to_chat(owner_mob, span_warning("Você não pode ventrawl enquanto guarda itens!"))
		return FALSE
	return TRUE

/datum/bloodsucker_clan/nosferatu/proc/on_ventcrawl_cancel(mob/living/carbon/human/owner_mob, obj/machinery/atmospherics/components/ventcrawl_target)
	SIGNAL_HANDLER
	animate(ventcrawl_target)

/datum/bloodsucker_clan/nosferatu/proc/on_ventcrawl_enter(mob/living/carbon/human/owner_mob, obj/machinery/atmospherics/components/ventcrawl_target)
	SIGNAL_HANDLER
	var/crawl_time = get_ventcrawl_time()
	ventcrawl_target.Shake(pixelshiftx = 1, pixelshifty = 1, duration = crawl_time, shake_interval = 0.3 SECONDS)
	return crawl_time

/datum/bloodsucker_clan/nosferatu/proc/on_ventcrawl_pre_exit(mob/living/carbon/human/owner_mob, obj/machinery/atmospherics/components/ventcrawl_target)
	SIGNAL_HANDLER
	var/crawl_time = get_ventcrawl_time()
	playsound(ventcrawl_target, 'sound/effects/bang.ogg', 25)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), crawl_time, 'sound/effects/bang.ogg', 25), ventcrawl_time * 0.6)
	ventcrawl_target.Shake(pixelshiftx = 1, pixelshifty = 1, duration = crawl_time, shake_interval = 0.3 SECONDS)
	return crawl_time

/datum/bloodsucker_clan/nosferatu/proc/on_ventcrawl_exit(mob/living/carbon/human/owner_mob, obj/machinery/atmospherics/components/ventcrawl_target)
	SIGNAL_HANDLER
	// cooldown all non-inherent abilities on exit to prevent instant ambushes
	for(var/datum/action/cooldown/bloodsucker/power as anything in bloodsuckerdatum.powers)
		if(power.purchase_flags & BLOODSUCKER_DEFAULT_POWER)
			continue
		power.StartCooldown()

/datum/bloodsucker_clan/nosferatu/proc/on_mob_examine(datum/antagonist/bloodsucker/owner_datum, datum/source, mob/examiner, examine_text)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/ogled = owner_datum.owner.current
	var/mob/living/ogler = examiner
	if(isliving(examiner) && examiner != ogled && !ogler.mob_mood.has_mood_of_category("nosferatu_examine"))
		ogler.add_mood_event("nosferatu_examine", /datum/mood_event/nosferatu_examined, ogled, owner_datum.GetRank())
		ogler.adjust_disgust(owner_datum.GetRank() * 10)
	// show that they are dangerous nosferatu, as if you're gazing upon them with fear, without mentioning the clan name/antagonist name, describe their appearance
	examine_text += span_danger("[ogled.p_They()] look[ogled.p_s()] like a pale, grotesque hunchback, with a mouth full of jagged yellowy teeth, and breath that reeks of fresh blood. You feel both afraid and disgusted as you gaze upon [ogled.p_them()].")
	examine_text += span_userdanger("[ogled.p_They()] [ogled.p_are()] clearly a BLOODSUCKER!")

/datum/bloodsucker_clan/nosferatu/Destroy(force)
	var/datum/action/cooldown/bloodsucker/feed/suck = locate() in bloodsuckerdatum.powers
	if(suck)
		bloodsuckerdatum.RemovePower(suck)
	bloodsuckerdatum.give_starting_powers()
	bloodsuckerdatum.owner.current.remove_quirk(/datum/quirk/badback)
	bloodsuckerdatum.owner.current.remove_traits(list(TRAIT_VENTCRAWLER_NUDE, TRAIT_DISFIGURED), BLOODSUCKER_TRAIT)
	UnregisterSignal(bloodsuckerdatum, list(COMSIG_BLOODSUCKER_EXAMINE, COMSIG_CAN_VENTCRAWL, COMISG_VENTCRAWL_PRE_ENTER, COMSIG_VENTCRAWL_PRE_EXIT, COMSIG_VENTCRAWL_EXIT))
	return ..()

/datum/bloodsucker_clan/nosferatu/favorite_ghoul_gain(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	var/list/traits_to_add = list(TRAIT_VENTCRAWLER_NUDE, TRAIT_DISFIGURED, TRAIT_TRUE_NIGHT_VISION, TRAIT_KNOW_ENGI_WIRES, TRAIT_SILENT_FOOTSTEPS)
	ghouldatum.owner.current.add_traits(traits_to_add, GHOUL_TRAIT)
	ghouldatum.traits += traits_to_add
	ghouldatum.owner.current.update_sight()
	to_chat(ghouldatum.owner.current, span_notice("Além disso, agora você pode desabafar enquanto está nua, e está permanentemente desfigurada. Você também tem visão noturna, sabe como cortar fios, e tem passos silenciosos."))

/datum/bloodsucker_clan/nosferatu/favorite_ghoul_loss(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	ghouldatum.owner.current.update_sight()
