/obj/item/organ/tongue/copy_traits_from(obj/item/organ/tongue/old_tongue, copy_actions = FALSE)
	. = ..()
	// make sure we get food preferences too, because those are now tied to tongues for some reason
	liked_foodtypes = old_tongue.liked_foodtypes
	disliked_foodtypes = old_tongue.disliked_foodtypes
	toxic_foodtypes = old_tongue.toxic_foodtypes

/obj/item/organ/tongue/dog
	name = "long tongue"
	desc = "Uma língua longa e molhada. Parece saltar quando se chama bom, estranhamente."
	say_mod = "woofs"
	icon_state = "tongue"
	modifies_speech = TRUE

/obj/item/organ/tongue/dog/on_mob_insert(mob/living/carbon/signer, special = FALSE, movement_flags = DELETE_IF_REPLACED)
	. = ..()
	signer.verb_ask = "arfs"
	signer.verb_exclaim = "wans"
	signer.verb_whisper = "whimpers"
	signer.verb_yell = "barks"

/obj/item/organ/tongue/dog/on_mob_remove(mob/living/carbon/speaker, special = FALSE, movement_flags)
	. = ..()
	speaker.verb_ask = initial(verb_ask)
	speaker.verb_exclaim = initial(verb_exclaim)
	speaker.verb_whisper = initial(verb_whisper)
	speaker.verb_sing = initial(verb_sing)
	speaker.verb_yell = initial(verb_yell)

/obj/item/organ/tongue/cat/on_mob_insert(mob/living/carbon/signer, special = FALSE, movement_flags = DELETE_IF_REPLACED)
	. = ..()
	signer.verb_ask = "mrrps"
	signer.verb_exclaim = "mrrowls"
	signer.verb_whisper = "purrs"
	signer.verb_yell = "yowls"

/obj/item/organ/tongue/cat/on_mob_remove(mob/living/carbon/speaker, special = FALSE, movement_flags)
	. = ..()
	speaker.verb_ask = initial(verb_ask)
	speaker.verb_exclaim = initial(verb_exclaim)
	speaker.verb_whisper = initial(verb_whisper)
	speaker.verb_yell = initial(verb_yell)

/obj/item/organ/tongue/avian
	name = "avian tongue"
	desc = "Uma língua baixinha que deseja sementes."
	say_mod = "chirps"
	icon_state = "tongue"
	modifies_speech = TRUE

/obj/item/organ/tongue/avian/on_mob_insert(mob/living/carbon/signer, special = FALSE, movement_flags = DELETE_IF_REPLACED)
	. = ..()
	signer.verb_ask = "peeps"
	signer.verb_exclaim = "squawks"
	signer.verb_whisper = "murmurs"
	signer.verb_yell = "shrieks"

/obj/item/organ/tongue/avian/on_mob_remove(mob/living/carbon/speaker, special = FALSE, movement_flags)
	. = ..()
	speaker.verb_ask = initial(verb_ask)
	speaker.verb_exclaim = initial(verb_exclaim)
	speaker.verb_whisper = initial(verb_whisper)
	speaker.verb_sing = initial(verb_sing)
	speaker.verb_yell = initial(verb_yell)

/obj/item/organ/tongue/bovine
	name = "bovine tongue"
	desc = "Uma língua longa e larga que anseia por grama."
	say_mod = "moos"
	icon_state = "tongue"
	modifies_speech = TRUE

/obj/item/organ/tongue/bovine/on_mob_insert(mob/living/carbon/signer, special = FALSE, movement_flags = DELETE_IF_REPLACED)
	. = ..()
	signer.verb_ask = "lows"
	signer.verb_exclaim = "huffs"
	signer.verb_whisper = "hums"
	signer.verb_yell = "brays"

/obj/item/organ/tongue/bovine/on_mob_remove(mob/living/carbon/speaker, special = FALSE, movement_flags)
	. = ..()
	speaker.verb_ask = initial(verb_ask)
	speaker.verb_exclaim = initial(verb_exclaim)
	speaker.verb_whisper = initial(verb_whisper)
	speaker.verb_sing = initial(verb_sing)
	speaker.verb_yell = initial(verb_yell)

/obj/item/organ/tongue/mouse
	name = "murid tongue"
	desc = "Uma língua curta e áspera coberta de solavancos."
	say_mod = "squeaks"
	icon_state = "tongue"
	modifies_speech = TRUE

/obj/item/organ/tongue/mouse/modify_speech(datum/source, list/speech_args)
	. = ..()
	var/message = LOWER_TEXT(speech_args[SPEECH_MESSAGE])
	if(message == "hi" || message == "hi.")
		speech_args[SPEECH_MESSAGE] = "Cheesed to meet you!"
	if(message == "hi?")
		speech_args[SPEECH_MESSAGE] = "Um... cheesed to meet you?"

/obj/item/organ/tongue/mouse/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/speechmod, replacements = strings("mouse_replacement.json", "mouse")) // This is prepawsterous! ...Or something like that.

/obj/item/organ/tongue/mouse/on_mob_insert(mob/living/carbon/tongue_owner, special, movement_flags)
	. = ..()
	RegisterSignal(tongue_owner, COMSIG_LIVING_ITEM_GIVEN, PROC_REF(its_on_the_mouse))

/obj/item/organ/tongue/mouse/on_mob_remove(mob/living/carbon/tongue_owner)
	. = ..()
	UnregisterSignal(tongue_owner, COMSIG_LIVING_ITEM_GIVEN)

/obj/item/organ/tongue/mouse/proc/on_item_given(mob/living/carbon/offerer, mob/living/taker, obj/item/given)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(its_on_the_mouse), offerer, taker)

/obj/item/organ/tongue/mouse/proc/its_on_the_mouse(mob/living/carbon/offerer, mob/living/taker)
	offerer.say("For you, it's on the mouse.")
	taker.add_mood_event("it_was_on_the_mouse", /datum/mood_event/it_was_on_the_mouse)

/// This "human" tongue is only used in Character Preferences / Augmentation menu.
/// The base tongue class lacked a say_mod. With say_mod included it makes a non-Human user sound like a Human.
/obj/item/organ/tongue/human
	say_mod = "says"

/obj/item/organ/tongue/lizard/robot
	name = "robotic lizard voicebox"
	desc = "Um sintetizador de voz tipo lagarto que pode interagir com formas de vida orgânicas."
	organ_flags = ORGAN_ROBOTIC
	icon_state = "tonguerobot"
	say_mod = "hizzes"
	attack_verb_continuous = list("beeps", "boops")
	attack_verb_simple = list("beep", "boop")
	modifies_speech = TRUE
	taste_sensitivity = 25 // not as good as an organic tongue
	voice_filter = "alimiter=0.9,acompressor=threshold=0.2:ratio=20:attack=10:release=50:makeup=2,highpass=f=1000"

/obj/item/organ/tongue/lizard/robot/can_speak_language(language)
	return TRUE // THE MAGIC OF ELECTRONICS

/obj/item/organ/tongue/lizard/robot/modify_speech(datum/source, list/speech_args)
	. = ..()
	speech_args[SPEECH_SPANS] |= SPAN_ROBOT

/obj/item/organ/tongue/lizard/cybernetic
	name = "forked cybernetic tongue"
	icon = 'modular_skyrat/modules/organs/icons/cyber_tongue.dmi'
	icon_state = "cybertongue-lizard"
	desc =  "Uma língua sintética bifurcada totalmente funcional, envolto em silicone macio. As características incluem vocais de alta resolução e receptores de sabor."
	organ_flags = ORGAN_ROBOTIC
	// Not as good as organic tongues, not as bad as the robotic voicebox.
	taste_sensitivity = 20
	modifies_speech = TRUE

/obj/item/organ/tongue/cybernetic
	name = "cybernetic tongue"
	icon = 'modular_skyrat/modules/organs/icons/cyber_tongue.dmi'
	icon_state = "cybertongue"
	desc =  "Uma língua sintética totalmente funcional, envolto em silicone macio. As características incluem vocais de alta resolução e receptores de sabor."
	organ_flags = ORGAN_ROBOTIC
	say_mod = "says"
	// Not as good as organic tongues, not as bad as the robotic voicebox.
	taste_sensitivity = 20

/obj/item/organ/tongue/vox
	name = "vox tongue"
	desc = "Um músculo carnudo usado principalmente para skreeing."
	say_mod = "skrees"
	liked_foodtypes = MEAT | FRIED

/obj/item/organ/tongue/dwarven
	name = "dwarven tongue"
	desc = "Um músculo carnudo usado para gritar."
	say_mod = "bellows"
	liked_foodtypes = ALCOHOL | MEAT | DAIRY //Dwarves like alcohol, meat, and dairy products.
	disliked_foodtypes = JUNKFOOD | FRIED | CLOTH //Dwarves hate foods that have no nutrition other than alcohol.

/obj/item/organ/tongue/ghoul
	name = "ghoulish tongue"
	desc = "Um músculo carnudo usado para raspar."
	say_mod = "rasps"
	liked_foodtypes = RAW | MEAT
	disliked_foodtypes = VEGETABLES | FRUIT | CLOTH
	toxic_foodtypes = DAIRY | PINEAPPLE

/obj/item/organ/tongue/insect
	name = "insect tongue"
	desc = "Um músculo carnudo usado para chittering."
	say_mod = "chitters"
	liked_foodtypes = GROSS | RAW | TOXIC | GORE
	disliked_foodtypes = CLOTH | GRAIN | FRIED
	toxic_foodtypes = DAIRY

/obj/item/organ/tongue/xeno_hybrid
	name = "alien tongue"
	desc = "De acordo com os principais xenobiologistas o benefício evolutivo de ter uma segunda boca em sua boca é\"Que parece foda.\"."
	icon_state = "tonguexeno"
	say_mod = "hisses"
	taste_sensitivity = 10
	liked_foodtypes = MEAT

/obj/item/organ/tongue/xeno_hybrid/Initialize(mapload)
	. = ..()
	var/obj/item/organ/tongue/alien/alien_tongue_type = /obj/item/organ/tongue/alien
	voice_filter = initial(alien_tongue_type.voice_filter)

/obj/item/organ/tongue/skrell
	name = "skrell tongue"
	desc = "Um músculo carnudo usado principalmente para ondulação."
	say_mod = "warbles"
