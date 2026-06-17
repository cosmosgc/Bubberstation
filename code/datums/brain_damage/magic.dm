//Magical traumas, caused by spells and curses.
//Blurs the line between the victim's imagination and reality
//Unlike regular traumas this can affect the victim's body and surroundings

/datum/brain_trauma/magic
	abstract_type = /datum/brain_trauma/magic
	resilience = TRAUMA_RESILIENCE_LOBOTOMY

/datum/brain_trauma/magic/lumiphobia
	name = "Lumiphobia"
	desc = "O paciente tem uma reação adversa inexplicável à luz."
	scan_desc = "hipersensibilidade leve"
	symptoms = "Exhibits extreme discomfort and adverse reactions when exposed to bright light sources, \
		and will go to great lengths to avoid illuminated areas. \
		This sensitivity can lead to skin irritation, similar to that of a severe sunburn."
	gain_text = span_warning("Você sente um desejo de escuridão.")
	lose_text = span_notice("A luz não te incomoda mais.")
	/// Cooldown to prevent warning spam
	COOLDOWN_DECLARE(damage_warning_cooldown)
	var/next_damage_warning = 0

/datum/brain_trauma/magic/lumiphobia/on_life(seconds_per_tick)
	..()
	var/turf/T = owner.loc
	if(!istype(T))
		return

	if(T.get_lumcount() <= SHADOW_SPECIES_LIGHT_THRESHOLD) //if there's enough light, start dying
		return

	if(COOLDOWN_FINISHED(src, damage_warning_cooldown))
		to_chat(owner, span_warning("<b>A luz te queima!</b>"))
		COOLDOWN_START(src, damage_warning_cooldown, 10 SECONDS)
	owner.take_overall_damage(burn = 1.5 * seconds_per_tick)

/datum/brain_trauma/magic/poltergeist
	name = "Poltergeist"
	desc = "O paciente parece ser alvo de uma entidade invisível violenta."
	scan_desc = "Atividade paranormal"
	symptoms = "Experiences frequent and unprovoked physical disturbances in their immediate vicinity, \
		such as objects being thrown or moved without any apparent cause."
	gain_text = span_warning("Você sente uma presença odiosa perto de você.")
	lose_text = span_notice("Você sente a presença odiosa desaparecer.")

/datum/brain_trauma/magic/poltergeist/on_life(seconds_per_tick)
	..()
	if(!SPT_PROB(2, seconds_per_tick))
		return

	var/most_violent = -1 //So it can pick up items with 0 throwforce if there's nothing else
	var/obj/item/throwing
	for(var/obj/item/I in view(5, get_turf(owner)))
		if(I.anchored)
			continue
		if(I.throwforce > most_violent)
			most_violent = I.throwforce
			throwing = I
	if(throwing)
		throwing.throw_at(owner, 8, 2)

/datum/brain_trauma/magic/antimagic
	name = "Athaumasia"
	desc = "O paciente é completamente inerte com forças mágicas."
	scan_desc = "\"taúmica em branco\""
	symptoms = "Exhibits a complete immunity to effects unexplainable by conventional science, \
		such as the abilities demonstrated by members of the Wizard Federation."
	gain_text = span_notice("Percebe que magia não pode ser real.")
	lose_text = span_notice("Você percebe que magia pode ser real.")

/datum/brain_trauma/magic/antimagic/on_gain()
	ADD_TRAIT(owner, TRAIT_ANTIMAGIC, TRAUMA_TRAIT)
	. = ..()

/datum/brain_trauma/magic/antimagic/on_lose()
	REMOVE_TRAIT(owner, TRAIT_ANTIMAGIC, TRAUMA_TRAIT)
	..()

/datum/brain_trauma/magic/stalker
	name = "Stalking Phantom"
	desc = "O paciente é perseguido por um fantasma que só eles podem ver."
	scan_desc = "Paranóia extra-sensorial."
	symptoms = "Feels an unshakable sensation of being watched or pursued by an unseen entity, \
		leading to heightened anxiety, paranoia, and occasional hallucinations of a ghostly figure in their vicinity. \
		Extreme cases may even result in physical harm inflicted upon the patient by a seemingly invisible force."
	gain_text = span_warning("Você sente como se algo quisesse te matar...")
	lose_text = span_notice("Você não sente mais os olhos nas costas.")
	/// Type of stalker that is chasing us
	var/stalker_type = /obj/effect/client_image_holder/stalker_phantom
	/// Reference to the stalker that is chasing us
	var/obj/effect/client_image_holder/stalker_phantom/stalker
	/// Plays a sound when the stalker is near their victim
	var/close_stalker = FALSE

/datum/brain_trauma/magic/stalker/Destroy()
	QDEL_NULL(stalker)
	return ..()

/datum/brain_trauma/magic/stalker/on_gain()
	create_stalker()
	return ..()

/datum/brain_trauma/magic/stalker/proc/create_stalker()
	var/turf/stalker_source = locate(owner.x + pick(-12, 12), owner.y + pick(-12, 12), owner.z) //random corner
	stalker = new stalker_type(stalker_source, owner)

/datum/brain_trauma/magic/stalker/on_lose()
	QDEL_NULL(stalker)
	return ..()

/datum/brain_trauma/magic/stalker/on_life(seconds_per_tick)
	// Dead and unconscious people are not interesting to the psychic stalker.
	if(owner.stat != CONSCIOUS)
		return

	// Not even nullspace will keep it at bay.
	if(!stalker || !stalker.loc || stalker.z != owner.z)
		qdel(stalker)
		create_stalker()

	if(get_dist(owner, stalker) <= 1)
		playsound(owner, 'sound/effects/magic/demon_attack1.ogg', 50)
		owner.visible_message(span_warning("[owner] is torn apart by invisible claws!"), span_userdanger("Garras fantasmagóricas destroem seu corpo!"))
		owner.take_bodypart_damage(rand(20, 45), wound_bonus=CANT_WOUND)
	else if(SPT_PROB(30, seconds_per_tick))
		stalker.forceMove(get_step_towards(stalker, owner))
	if(get_dist(owner, stalker) <= 8)
		if(!close_stalker)
			var/sound/slowbeat = sound('sound/effects/health/slowbeat.ogg', repeat = TRUE)
			owner.playsound_local(owner, slowbeat, 40, 0, channel = CHANNEL_HEARTBEAT, use_reverb = FALSE)
			close_stalker = TRUE
	else
		if(close_stalker)
			owner.stop_sound_channel(CHANNEL_HEARTBEAT)
			close_stalker = FALSE
	..()

/obj/effect/client_image_holder/stalker_phantom
	name = "???"
	desc = "Está se aproximando..."
	image_icon = 'icons/mob/simple/lavaland/lavaland_monsters.dmi'
	image_state = "curseblob"

// Heretic subtype that replaces the ghost guy with a stargazer
/datum/brain_trauma/magic/stalker/cosmic
	stalker_type = /obj/effect/client_image_holder/stalker_phantom/cosmic
	random_gain = FALSE
	known_trauma = FALSE

/obj/effect/client_image_holder/stalker_phantom/cosmic
	image_icon = 'icons/mob/nonhuman-player/96x96eldritch_mobs.dmi'
	image_state = "star_gazer"
