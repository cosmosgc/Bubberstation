/*
*	BIMBO
*/

/datum/brain_trauma
	///Whether the trauma will be displayed on a scanner or kiosk
	var/display_scanner = TRUE

/datum/brain_trauma/very_special
	abstract_type = /datum/brain_trauma/very_special

/datum/brain_trauma/very_special/bimbo
	name = "Permanent hormonal disruption"
	desc = "O paciente perdeu completamente a capacidade de formar a fala e parece extremamente excitado."
	scan_desc = "Perturbação hormonal permanente"
	gain_text = span_purple("Seus pensamentos ficam nublados, mas isso te excita como o inferno.")
	lose_text = span_warning("Um frescor agradável se espalha por todo o seu corpo, você está pensando claramente novamente.")
	//people need to be able to gain it through the chemical OD
	can_gain = TRUE
	//people should not be able to randomly get this trauma
	random_gain = FALSE
	//we don't want this to be displayed on a scanner
	display_scanner = FALSE
	resilience = TRAUMA_RESILIENCE_LOBOTOMY
	///how satisfied the person is, gained through climaxing
	//max is 300, min is 0
	var/satisfaction = 300
	///how stressed the person is, gained through zero satisfaction
	//max is 300, min is 0
	var/stress = 0

	COOLDOWN_DECLARE(desire_cooldown)
	///The time between each desire message within company
	var/desire_cooldown_number = 30 SECONDS
	///The list of manual emotes that will be done when unsatisfied
	var/static/list/lust_emotes = list(
		"pants as their body trembles lightly.",
		"lightly touches themselves up and down, feeling every inch.",
		"puts their finger in their mouth and slightly bites down.",
		"places their hands on their hip as they slowly gyrate.",
		"moans, their head tilted slightly."
	)

/**
 * If we are not satisfied, this will be ran through
 */
/datum/brain_trauma/very_special/bimbo/proc/try_unsatisfied()
	var/mob/living/carbon/human/human_owner = owner
	//we definitely need an owner; but if you are satisfied, just return
	if(satisfaction || !human_owner)
		return FALSE
	//we need to feel consequences for being unsatisfied
	//the message that will be sent to the owner at the end
	var/lust_message = "Your breath begins to feel warm..."
	//we are using if statements so that it slowly becomes more and more to the person
	human_owner.manual_emote(pick(lust_emotes))
	if(stress >= 60)
		human_owner.set_jitter_if_lower(40 SECONDS)
		lust_message = "Você sente uma sensação estática em toda sua pele..."
	if(stress >= 120)
		human_owner.set_eye_blur_if_lower(20 SECONDS)
		lust_message = "Sua visão começa a borrar, o calor começa a subir..."
	if(stress >= 180)
		owner.adjust_hallucinations(60 SECONDS)
		lust_message = "Você começa a fantasiar do que poderia fazer com alguém..."
	if(stress >= 240)
		human_owner.adjust_stamina_loss(30)
		lust_message = "Seu corpo se sente tão quente, quase sem vontade de cooperar..."
	if(stress >= 300)
		human_owner.adjust_oxy_loss(40)
		lust_message = "Sente seu pescoço apertando, forçando..."
	to_chat(human_owner, span_purple(lust_message))
	return TRUE

/**
 * If we have climaxed, return true
 */
/datum/brain_trauma/very_special/bimbo/proc/check_climaxed()
	if(owner.has_status_effect(/datum/status_effect/climax))
		stress = 0
		satisfaction = 300
		return TRUE
	return FALSE

/datum/brain_trauma/very_special/bimbo/on_life()
	var/mob/living/carbon/human/human_owner = owner

	//Check if we climaxed, if so, just stop for now
	if(check_climaxed())
		return
	//if we are satisfied, slowly lower satisfaction as well as stress
	if(satisfaction)
		satisfaction = clamp(satisfaction - 1, 0, 300)
		stress = clamp(stress - 1, 0, 300)
	//since we are not satisfied, increase our stress
	else
		stress = clamp(stress + 1, 0, 300)

	human_owner.adjust_arousal(10)
	if(human_owner.pleasure < 80)
		human_owner.adjust_pleasure(5)

	//Anything beyond this obeys a cooldown system because we don't want to spam it
	if(!COOLDOWN_FINISHED(src, desire_cooldown))
		return
	COOLDOWN_START(src, desire_cooldown, desire_cooldown_number)

	//if we are unsatisfied, do this code block and then stop
	if(try_unsatisfied())
		return

	//Anything beyond this requires company
	if(!in_company())
		//since you aren't within company, you won't be satisfied
		satisfaction = clamp(satisfaction - 1, 0, 1000)
		to_chat(human_owner, span_purple("Você se sente tão sozinha sem alguém..."))
		return

	switch(satisfaction)
		if(0 to 100)
			to_chat(human_owner, span_purple("Você não pode suportar, você precisa de um parceiro agora!"))
		if(101 to 150)
			to_chat(human_owner, span_purple("Você acertaria isso. Sim. Isso é pelo menos um seis."))
		if(151 to 200)
			to_chat(human_owner, span_purple("Suas roupas estão apertadas."))
		if(201 to 250)
			to_chat(human_owner, span_purple("Desejo embaça suas decisões."))
		if(251 to 1000)
			to_chat(human_owner, span_purple("Nossa, está quente aqui."))

/**
 * If we have another human in view, return true
 */
/datum/brain_trauma/very_special/bimbo/proc/in_company()
	for(var/mob/living/carbon/human/human_check in oview(owner, 4))
		if(!istype(human_check))
			continue
		return TRUE
	return FALSE

/datum/brain_trauma/very_special/bimbo/handle_speech(datum/source, list/speech_args)
	if(!HAS_TRAIT(owner, TRAIT_BIMBO)) //You have the trauma but not the trait, go ahead and fail here
		return ..()
	var/message = speech_args[SPEECH_MESSAGE]
	var/list/split_message = splittext(message, " ") //List each word in the message
	for (var/i in 1 to length(split_message))
		if(findtext(split_message[i], "*") || findtext(split_message[i], ";") || findtext(split_message[i], ":"))
			continue
		if(prob(10))
			var/insert_muffle = pick("... Mmmph...", "... Hmmphh...", "... Gmmmh...", "... Fmmmmph...")
			split_message[i] = split_message[i] + insert_muffle

	message = jointext(split_message, " ")
	speech_args[SPEECH_MESSAGE] = message

/datum/brain_trauma/very_special/bimbo/on_gain()
	. = ..()
	owner.add_mood_event("bimbo", /datum/mood_event/bimbo)
	if(!HAS_TRAIT_FROM(owner, TRAIT_BIMBO, TRAIT_LEWDCHEM))
		ADD_TRAIT(owner, TRAIT_BIMBO, TRAIT_LEWDCHEM)
	RegisterSignal(owner, COMSIG_MOB_SAY, PROC_REF(handle_speech), override=TRUE)
	if(!HAS_TRAIT_FROM(owner, TRAIT_MASOCHISM, TRAIT_APHRO))
		ADD_TRAIT(owner, TRAIT_MASOCHISM, TRAIT_APHRO)

/datum/brain_trauma/very_special/bimbo/on_lose()
	. = ..()
	owner.clear_mood_event("bimbo")
	if(HAS_TRAIT_FROM(owner, TRAIT_BIMBO, TRAIT_LEWDCHEM))
		REMOVE_TRAIT(owner, TRAIT_BIMBO, TRAIT_LEWDCHEM)
	UnregisterSignal(owner, COMSIG_MOB_SAY)
	if(HAS_TRAIT_FROM(owner, TRAIT_MASOCHISM, TRAIT_APHRO))
		REMOVE_TRAIT(owner, TRAIT_MASOCHISM, TRAIT_APHRO)

//Mood boost
/datum/mood_event/bimbo
	description = span_purple("So-o... socorro... menos... amor!\n")

/*
*	MASOCHISM
*/

/datum/quirk
	/// Is this a quirk disabled by disabling the ERP config?
	var/erp_quirk = FALSE

/datum/quirk/masochism
	name = "Masochism"
	desc = "A dor lhe traz um prazer indescritível."
	value = 0 //ERP Traits don't have price. They are priceless. Ba-dum-tss
	mob_trait = TRAIT_MASOCHISM
	gain_text = span_danger("Você tem um desejo súbito de dor...")
	lose_text = span_notice("Ouch! A dor é... Doloroso de novo! Ou-ou-ouch!")
	medical_record_text = "O sujeito tem masoquismo."
	icon = FA_ICON_HEART_BROKEN
	erp_quirk = TRUE

/datum/quirk/masochism/post_add()
	. = ..()
	var/mob/living/carbon/human/affected_human = quirk_holder
	ADD_TRAIT(affected_human, TRAIT_MASOCHISM, TRAIT_LEWDQUIRK)
	affected_human.pain_limit = 60

/datum/quirk/masochism/remove()
	. = ..()
	var/mob/living/carbon/human/affected_human = quirk_holder
	REMOVE_TRAIT(affected_human, TRAIT_MASOCHISM, TRAIT_LEWDQUIRK)
	affected_human.pain_limit = 0

/*
*	NEVERBONER
*/

/datum/brain_trauma/very_special/neverboner
	name = "Loss of libido"
	desc = "O paciente perdeu completamente o interesse sexual."
	scan_desc = "falta de libido."
	gain_text = span_notice("Você não sente mais tesão.")
	lose_text = span_notice("Um calor agradável se espalha sobre seu corpo.")
	random_gain = FALSE
	resilience = TRAUMA_RESILIENCE_ABSOLUTE

/datum/brain_trauma/very_special/neverboner/on_gain()
	. = ..()
	var/mob/living/carbon/human/affected_human = owner
	ADD_TRAIT(affected_human, TRAIT_NEVERBONER, TRAIT_APHRO)

/datum/brain_trauma/very_special/neverboner/on_lose()
	. = ..()
	var/mob/living/carbon/human/affected_human = owner
	REMOVE_TRAIT(affected_human, TRAIT_NEVERBONER, TRAIT_APHRO)

/*
*	SADISM
*/

/datum/quirk/sadism
	name = "Sadism"
	desc = "Você sente prazer quando vê alguém em agonia."
	value = 0 //ERP Traits don't have price. They are priceless. Ba-dum-tss
	mob_trait = TRAIT_SADISM
	gain_text = span_danger("Você sente um desejo repentino de infligir dor.")
	lose_text = span_notice("A dor dos outros não te satisfaz mais.")
	medical_record_text = "O sujeito tem sadismo."
	icon = FA_ICON_HAMMER
	erp_quirk = TRUE

/datum/quirk/sadism/post_add()
	. = ..()
	var/mob/living/carbon/human/affected_human = quirk_holder
	affected_human.gain_trauma(/datum/brain_trauma/very_special/sadism, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/sadism/remove()
	. = ..()
	var/mob/living/carbon/human/affected_human = quirk_holder
	affected_human?.cure_trauma_type(/datum/brain_trauma/very_special/sadism, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/brain_trauma/very_special/sadism
	name = "Sadism"
	desc = "Os centros de prazer cerebral do sujeito são mais ativos quando alguém está sofrendo."
	scan_desc = "tendências sádicas"
	gain_text = span_purple("Você sente o desejo de machucar alguém.")
	lose_text = span_notice("Você sente compaixão de novo.")
	can_gain = TRUE
	random_gain = FALSE
	resilience = TRAUMA_RESILIENCE_ABSOLUTE

/datum/brain_trauma/very_special/sadism/on_life(seconds_per_tick, times_fired)
	var/mob/living/carbon/human/affected_mob = owner
	if(!owner.has_status_effect(/datum/status_effect/climax_cooldown) && affected_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp) && someone_suffering())
		affected_mob.adjust_arousal(2)
		owner.add_mood_event("sadistic", /datum/mood_event/sadistic)
	else
		owner.clear_mood_event("sadistic")

/datum/brain_trauma/very_special/sadism/proc/someone_suffering()
	if(owner.is_blind())
		return FALSE
	for(var/mob/living/carbon/human/iterated_mob in oview(owner, 4))
		if(!isliving(iterated_mob)) //ghosts ain't people
			continue
		if(!istype(iterated_mob)) //only count mobs of type mob/living/human/...
			continue
		if(iterated_mob.stat == DEAD) //don't count dead targets either
			continue
		if(iterated_mob.pain >= 10)
			return TRUE
	return FALSE

//Shibari update quirks: Rope bunny and rigger. One have additional mood bonus (0) and exist for same reason as ananas affinity, other one can faster tie ropes on character because why not.
//Rope bunny code
/datum/quirk/ropebunny
	name = "Rope bunny"
	desc = "Você adora ser amarrada."
	value = 0 //ERP Traits don't have price. They are priceless. Ba-dum-tss
	mob_trait = TRAIT_ROPEBUNNY
	medical_record_text = "O sujeito gosta de restrições."
	gain_text = span_danger("Você realmente quer ser contido por alguma razão.")
	lose_text = span_notice("Ser contido não te desperta mais.")
	icon = FA_ICON_HANDCUFFS
	erp_quirk = TRUE

/datum/quirk/ropebunny/post_add()
	. = ..()
	var/mob/living/carbon/human/affected_mob = quirk_holder
	ADD_TRAIT(affected_mob, TRAIT_ROPEBUNNY, TRAIT_LEWDQUIRK)

/datum/quirk/ropebunny/remove()
	. = ..()
	var/mob/living/carbon/human/affected_mob = quirk_holder
	REMOVE_TRAIT(affected_mob, TRAIT_ROPEBUNNY, TRAIT_LEWDQUIRK)

//Rigger code
/datum/quirk/rigger
	name = "Rigger"
	desc = "Você acha maravilhosa a tecelagem de nós de corda no corpo."
	value = 0 //ERP Traits don't have price. They are priceless. Ba-dum-tss
	mob_trait = TRAIT_RIGGER
	medical_record_text = "O sujeito tem um aumento de destreza ao dar nós."
	gain_text = span_danger("De repente você entende corda tecendo muito melhor do que antes.")
	lose_text = span_notice("Os nós de corda parecem complicados de novo.")
	icon = FA_ICON_CHAIN_BROKEN
	erp_quirk = TRUE

/datum/quirk/rigger/post_add()
	. = ..()
	var/mob/living/carbon/human/affected_mob = quirk_holder
	ADD_TRAIT(affected_mob, TRAIT_RIGGER, TRAIT_LEWDQUIRK)

/datum/quirk/rigger/remove()
	. = ..()
	var/mob/living/carbon/human/affected_mob = quirk_holder
	REMOVE_TRAIT(affected_mob, TRAIT_RIGGER, TRAIT_LEWDQUIRK)
/datum/mood_event/sadistic
	description = span_purple("O sofrimento dos outros me faz mais feliz.\n")

/*
*	EMPATH BONUS
*/

/// Used in the empathy component
/mob/living/carbon/human/proc/get_arousal_info()
	switch(arousal)
		if(AROUSAL_MINIMUM_DETECTABLE to AROUSAL_LOW)
			return span_purple("[p_they()] [p_are()] slightly blushed.")
		if(AROUSAL_LOW to AROUSAL_MEDIUM)
			return span_purple("[p_they()] [p_are()] quite aroused and seems to be stirring up lewd thoughts in [p_their()] head.")
		if(AROUSAL_HIGH to AROUSAL_AUTO_CLIMAX_THRESHOLD)
			return span_purple("[p_they()] [p_are()] aroused as hell.")
		if(AROUSAL_AUTO_CLIMAX_THRESHOLD to INFINITY)
			return span_purple("[p_they()] [p_are()] extremely excited, exhausting from intolerable desire.")
