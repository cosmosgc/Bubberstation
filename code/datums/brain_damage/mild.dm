//Mild traumas are the most common; they are generally minor annoyances.
//They can be cured with mannitol and patience, although brain surgery still works.
//Most of the old brain damage effects have been transferred to the dumbness trauma.

/datum/brain_trauma/mild
	abstract_type = /datum/brain_trauma/mild

/datum/brain_trauma/mild/hallucinations
	name = "Hallucinations"
	desc = "O paciente sofre alucinações constantes."
	scan_desc = "schizophrenia"
	symptoms = "Experiences frequent hallucinations (either visual or auditory) or delusions 		which subside on being administered Mindbreaker Toxin."
	gain_text = span_warning("Você sente seu aperto na realidade escorregando...")
	lose_text = span_notice("Você se sente mais de castigo.")
	/// Whether the hallucinations we give are uncapped, ie all the wacky ones
	var/uncapped = FALSE

/datum/brain_trauma/mild/hallucinations/on_life(seconds_per_tick)
	if(owner.stat >= UNCONSCIOUS)
		return
	if(HAS_TRAIT(owner, TRAIT_RDS_SUPPRESSED))
		owner.remove_language(/datum/language/aphasia, source = LANGUAGE_APHASIA)
		owner.adjust_hallucinations(-10 SECONDS * seconds_per_tick)
		return

	owner.grant_language(/datum/language/aphasia, source = LANGUAGE_APHASIA)
	owner.adjust_hallucinations_up_to(((uncapped ? 12 SECONDS : 5 SECONDS) * seconds_per_tick), (uncapped ? 240 SECONDS : 60 SECONDS))

/datum/brain_trauma/mild/hallucinations/on_lose()
	owner.remove_status_effect(/datum/status_effect/hallucination)
	if(!QDELING(owner))
		owner.remove_language(/datum/language/aphasia, source = LANGUAGE_APHASIA)
	return ..()

/datum/brain_trauma/mild/stuttering
	name = "Stuttering"
	desc = "O paciente não pode falar direito."
	scan_desc = "coordenação oral reduzida"
	symptoms = "Has difficulty speaking fluently, often repeating or prolonging sounds or syllables."
	gain_text = span_warning("Falar claramente está ficando mais difícil.")
	lose_text = span_notice("Você se sente no controle do seu discurso.")

/datum/brain_trauma/mild/stuttering/on_life(seconds_per_tick)
	owner.adjust_stutter_up_to(5 SECONDS * seconds_per_tick, 50 SECONDS)

/datum/brain_trauma/mild/stuttering/on_lose()
	owner.remove_status_effect(/datum/status_effect/speech/stutter)
	return ..()

/datum/brain_trauma/mild/dumbness
	name = "Dumbness"
	desc = "O paciente reduziu a atividade cerebral, tornando-os menos inteligentes."
	symptoms = "Exhibits a noticeable decline in cognitive functions, including speech, memory, motorics, and problem-solving abilities."
	scan_desc = "atividade cerebral reduzida"
	gain_text = span_warning("Você se sente mais idiota.")
	lose_text = span_notice("Você se sente inteligente de novo.")

/datum/brain_trauma/mild/dumbness/on_gain()
	ADD_TRAIT(owner, TRAIT_DUMB, TRAUMA_TRAIT)
	owner.add_mood_event("dumb", /datum/mood_event/oblivious)
	return ..()

/datum/brain_trauma/mild/dumbness/on_life(seconds_per_tick)
	owner.adjust_derpspeech_up_to(5 SECONDS * seconds_per_tick, 50 SECONDS)
	if(SPT_PROB(1.5, seconds_per_tick))
		owner.emote("drool")
	else if(owner.stat == CONSCIOUS && SPT_PROB(1.5, seconds_per_tick))
		owner.say(pick_list_replacements(BRAIN_DAMAGE_FILE, "brain_damage"), forced = "brain damage", filterproof = TRUE)

/datum/brain_trauma/mild/dumbness/on_lose()
	REMOVE_TRAIT(owner, TRAIT_DUMB, TRAUMA_TRAIT)
	owner.remove_status_effect(/datum/status_effect/speech/stutter/derpspeech)
	owner.clear_mood_event("dumb")
	return ..()

/datum/brain_trauma/mild/speech_impediment
	name = "Speech Impediment"
	desc = "O paciente é incapaz de formar frases coerentes."
	scan_desc = "Transtorno de comunicação"
	symptoms = "Struggles to articulate thoughts into coherent speech, often resulting in jumbled or nonsensical sentences."
	gain_text = span_danger("Você não consegue formar pensamentos coerentes!")
	lose_text = span_danger("Sua mente parece mais clara.")

/datum/brain_trauma/mild/speech_impediment/on_gain()
	ADD_TRAIT(owner, TRAIT_UNINTELLIGIBLE_SPEECH, TRAUMA_TRAIT)
	. = ..()

/datum/brain_trauma/mild/speech_impediment/on_lose()
	REMOVE_TRAIT(owner, TRAIT_UNINTELLIGIBLE_SPEECH, TRAUMA_TRAIT)
	..()

/datum/brain_trauma/mild/concussion
	name = "Concussion"
	desc = "O cérebro do paciente está contuso."
	symptoms = "Experiences headaches, dizziness, nausea, confusion, and occasional loss of consciousness."
	scan_desc = "concussion"
	gain_text = span_warning("Sua cabeça dói!")
	lose_text = span_notice("A pressão dentro da sua cabeça começa a desaparecer.")

/datum/brain_trauma/mild/concussion/on_life(seconds_per_tick)
	if(SPT_PROB(2.5, seconds_per_tick))
		switch(rand(1,11))
			if(1)
				owner.vomit(VOMIT_CATEGORY_DEFAULT)
			if(2,3)
				owner.adjust_dizzy(20 SECONDS)
			if(4,5)
				owner.adjust_confusion(10 SECONDS)
				owner.set_eye_blur_if_lower(20 SECONDS)
			if(6 to 9)
				owner.adjust_slurring(1 MINUTES)
			if(10)
				to_chat(owner, span_notice("Esqueceu por um momento o que estava fazendo."))
				owner.Stun(20)
			if(11)
				to_chat(owner, span_warning("Você desmaiou."))
				owner.Unconscious(80)

	..()

/datum/brain_trauma/mild/healthy
	name = "Anosognosia"
	desc = "O paciente sempre se sente saudável, independente de sua condição."
	scan_desc = "déficit de autoconsciência"
	symptoms = "Exhibits a lack of awareness or denial of their own medical conditions, 		often insisting they are perfectly healthy despite clear evidence to the contrary."
	gain_text = span_notice("Você se sente ótimo!")
	lose_text = span_warning("Você não se sente mais perfeitamente saudável.")

/datum/brain_trauma/mild/healthy/on_gain()
	owner.apply_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)
	return ..()

/datum/brain_trauma/mild/healthy/on_life(seconds_per_tick)
	owner.adjust_stamina_loss(-6 * seconds_per_tick) //no pain, no fatigue

/datum/brain_trauma/mild/healthy/on_lose()
	owner.remove_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)
	return ..()

/datum/brain_trauma/mild/muscle_weakness
	name = "Muscle Weakness"
	desc = "O paciente experimenta ocasionalmente ataques de fraqueza muscular."
	scan_desc = "Sinal fraco do nervo motor"
	symptoms = "Experiences sudden episodes of muscle weakness, resulting in weak grip strength, difficulty moving, and occasional falls."
	gain_text = span_warning("Seus músculos estão estranhamente fracos.")
	lose_text = span_notice("Você se sente no controle de seus músculos novamente.")

/datum/brain_trauma/mild/muscle_weakness/on_life(seconds_per_tick)
	var/fall_chance = 1
	if(owner.move_intent == MOVE_INTENT_RUN)
		fall_chance += 2
	if(SPT_PROB(0.5 * fall_chance, seconds_per_tick) && owner.body_position == STANDING_UP)
		to_chat(owner, span_warning("Sua perna se desfaz!"))
		owner.Paralyze(35)

	else if(owner.get_active_held_item())
		var/drop_chance = 1
		var/obj/item/I = owner.get_active_held_item()
		drop_chance += I.w_class
		if(SPT_PROB(0.5 * drop_chance, seconds_per_tick) && owner.dropItemToGround(I))
			to_chat(owner, span_warning("Você caiu.[I]!"))

	else if(SPT_PROB(1.5, seconds_per_tick))
		to_chat(owner, span_warning("Você sente uma fraqueza repentina em seus músculos!"))
		owner.adjust_stamina_loss(50)
	..()

/datum/brain_trauma/mild/muscle_spasms
	name = "Muscle Spasms"
	desc = "O paciente tem espasmos musculares ocasionais, fazendo com que se movam sem querer."
	scan_desc = "nervosos se encaixam."
	symptoms = "Experiences involuntary muscle contractions leading to sudden, brief movements or twitches, which can interfere with normal motor functions."
	gain_text = span_warning("Seus músculos estão estranhamente fracos.")
	lose_text = span_notice("Você se sente no controle de seus músculos novamente.")

/datum/brain_trauma/mild/muscle_spasms/on_gain()
	owner.apply_status_effect(/datum/status_effect/spasms)
	. = ..()

/datum/brain_trauma/mild/muscle_spasms/on_lose()
	owner.remove_status_effect(/datum/status_effect/spasms)
	..()

/datum/brain_trauma/mild/nervous_cough
	name = "Nervous Cough"
	desc = "O paciente sente uma constante necessidade de tosse."
	scan_desc = "tosse nervosa"
	symptoms = "Experiences a persistent, uncontrollable urge to cough, which may disrupt normal activities and social interactions."
	gain_text = span_warning("Sua garganta coça incessantemente...")
	lose_text = span_notice("Sua garganta pára de coçar.")

/datum/brain_trauma/mild/nervous_cough/on_life(seconds_per_tick)
	if(SPT_PROB(6, seconds_per_tick) && !HAS_TRAIT(owner, TRAIT_SOOTHED_THROAT))
		if(prob(5))
			to_chat(owner, span_warning("[pick("You have a coughing fit!", "You can't stop coughing!")]"))
			owner.Immobilize(20)
			owner.emote("cough")
			addtimer(CALLBACK(owner, TYPE_PROC_REF(/mob/, emote), "cough"), 0.6 SECONDS)
			addtimer(CALLBACK(owner, TYPE_PROC_REF(/mob/, emote), "cough"), 1.2 SECONDS)
		owner.emote("cough")
	..()

/datum/brain_trauma/mild/expressive_aphasia
	name = "Expressive Aphasia"
	desc = "O paciente é afetado por perda parcial de fala levando a um vocabulário reduzido."
	scan_desc = "Incapacidade de formar frases complexas"
	symptoms = "Struggles to express thoughts verbally, often substituting complex words with simpler alternatives or nonsensical sounds."
	gain_text = span_warning("Você perde o controle sobre palavras complexas.")
	lose_text = span_notice("Você sente seu vocabulário voltando ao normal novamente.")

/datum/brain_trauma/mild/expressive_aphasia/handle_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message)
		var/list/message_split = splittext(message, " ")
		var/list/new_message = list()

		for(var/word in message_split)
			var/suffix = ""
			var/suffix_foundon = 0
			for(var/potential_suffix in list("." , "," , ";" , "!" , ":" , "?"))
				suffix_foundon = findtext(word, potential_suffix, -length(potential_suffix))
				if(suffix_foundon)
					suffix = potential_suffix
					break

			if(suffix_foundon)
				word = copytext(word, 1, suffix_foundon)
			word = html_decode(word)

			if(GLOB.most_common_words_alphabetical[LOWER_TEXT(word)])
				new_message += word + suffix
			else
				if(prob(30) && message_split.len > 2)
					new_message += pick("uh","erm")
					break
				else
					var/list/charlist = text2charlist(word)
					charlist.len = round(charlist.len * 0.5, 1)
					shuffle_inplace(charlist)
					new_message += jointext(charlist, "") + suffix

		message = jointext(new_message, " ")

	speech_args[SPEECH_MESSAGE] = trim(message)

/datum/brain_trauma/mild/mind_echo
	name = "Mind Echo"
	desc = "Os neurônios da linguagem do paciente não terminam corretamente, fazendo com que os padrões de fala anteriores reapareçam espontaneamente."
	scan_desc = "fazendo loop no padrão neural."
	symptoms = "Experiences involuntary repetition of previously heard or spoken phrases, leading to persistent moments of déjà vu in both hearing and speech."
	gain_text = span_warning("Você sente um eco fraco de seus pensamentos...")
	lose_text = span_notice("O eco fraco desaparece.")
	var/list/hear_dejavu = list()
	var/list/speak_dejavu = list()

/datum/brain_trauma/mild/mind_echo/handle_hearing(datum/source, list/hearing_args)
	if(HAS_TRAIT(owner, TRAIT_DEAF) || owner == hearing_args[HEARING_SPEAKER])
		return

	if(hear_dejavu.len >= 5)
		if(prob(25))
			var/deja_vu = pick_n_take(hear_dejavu)
			var/static/regex/quoted_spoken_message = regex("\".+\"", "gi")
			hearing_args[HEARING_RAW_MESSAGE] = quoted_spoken_message.Replace(hearing_args[HEARING_RAW_MESSAGE], "\"[deja_vu]\"") //Quotes included to avoid cases where someone says part of their name
			return
	if(hear_dejavu.len >= 15)
		if(prob(50))
			popleft(hear_dejavu) //Remove the oldest
			hear_dejavu += hearing_args[HEARING_RAW_MESSAGE]
	else
		hear_dejavu += hearing_args[HEARING_RAW_MESSAGE]

/datum/brain_trauma/mild/mind_echo/handle_speech(datum/source, list/speech_args)
	if(speak_dejavu.len >= 5)
		if(prob(25))
			var/deja_vu = pick_n_take(speak_dejavu)
			speech_args[SPEECH_MESSAGE] = deja_vu
			return
	if(speak_dejavu.len >= 15)
		if(prob(50))
			popleft(speak_dejavu) //Remove the oldest
			speak_dejavu += speech_args[SPEECH_MESSAGE]
	else
		speak_dejavu += speech_args[SPEECH_MESSAGE]

/datum/brain_trauma/mild/color_blindness
	name = "Achromatopsia"
	desc = "O lobo occipital do paciente é incapaz de reconhecer e interpretar a cor, tornando o paciente completamente cego."
	scan_desc = "colorblindness"
	symptoms = "Exhibits a complete inability to perceive colors, seeing the world in shades of gray, black, and white."
	gain_text = span_warning("O mundo ao seu redor parece perder sua cor.")
	lose_text = span_notice("O mundo parece brilhante e colorido novamente.")

/datum/brain_trauma/mild/color_blindness/on_gain()
	owner.add_client_colour(/datum/client_colour/monochrome, TRAUMA_TRAIT)
	return ..()

/datum/brain_trauma/mild/color_blindness/on_lose(silent)
	owner.remove_client_colour(TRAUMA_TRAIT)
	return ..()

/datum/brain_trauma/mild/possessive
	name = "Possessive"
	desc = "O paciente é extremamente possessivo de seus pertences."
	scan_desc = "possessiveness"
	symptoms = "Exhibits an overwhelming need to keep personal belongings close, 		often resulting in an intense grip on held items that persists even when forced to let go."
	gain_text = span_warning("Você começa a se preocupar com seus pertences.")
	lose_text = span_notice("Você se preocupa menos com seus pertences.")

/datum/brain_trauma/mild/possessive/on_lose(silent)
	. = ..()
	for(var/obj/item/thing in owner.held_items)
		clear_trait(thing)

/datum/brain_trauma/mild/possessive/on_life(seconds_per_tick)
	if(!SPT_PROB(5, seconds_per_tick))
		return

	var/obj/item/my_thing = pick(owner.held_items) // can pick null, that's fine
	if(isnull(my_thing) || HAS_TRAIT(my_thing, TRAIT_NODROP) || (my_thing.item_flags & (HAND_ITEM|ABSTRACT)))
		return

	ADD_TRAIT(my_thing, TRAIT_NODROP, TRAUMA_TRAIT)
	RegisterSignals(my_thing, list(COMSIG_ITEM_DROPPED, COMSIG_MOVABLE_MOVED), PROC_REF(clear_trait))
	to_chat(owner, span_warning("Você sente a necessidade de manter[my_thing]Feche..."))
	addtimer(CALLBACK(src, PROC_REF(relax), my_thing), rand(30 SECONDS, 3 MINUTES), TIMER_DELETE_ME)

/datum/brain_trauma/mild/possessive/proc/relax(obj/item/my_thing)
	if(QDELETED(my_thing))
		return
	if(HAS_TRAIT_FROM_ONLY(my_thing, TRAIT_NODROP, TRAUMA_TRAIT)) // in case something else adds nodrop, somehow?
		to_chat(owner, span_notice("Você se sente mais confortável deixando ir[my_thing]."))
	clear_trait(my_thing)

/datum/brain_trauma/mild/possessive/proc/clear_trait(obj/item/my_thing, ...)
	SIGNAL_HANDLER

	REMOVE_TRAIT(my_thing, TRAIT_NODROP, TRAUMA_TRAIT)
	UnregisterSignal(my_thing, list(COMSIG_ITEM_DROPPED, COMSIG_MOVABLE_MOVED))
