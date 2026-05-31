//copy pasta of the space piano, don't hurt me -Pete
/obj/item/instrument
	name = "generic instrument"
	force = 10
	max_integrity = 100
	resistance_flags = FLAMMABLE
	icon = 'icons/obj/art/musician.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/instruments_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/instruments_righthand.dmi'
	abstract_type = /obj/item/instrument
	/// Our song datum.
	var/datum/song/handheld/song
	/// Our allowed list of instrument ids. This is nulled on initialize.
	var/list/allowed_instrument_ids
	/// How far away our song datum can be heard.
	var/instrument_range = 15

/obj/item/instrument/Initialize(mapload)
	. = ..()
	song = new(src, allowed_instrument_ids, instrument_range)
	allowed_instrument_ids = null //We don't need this clogging memory after its used.

/obj/item/instrument/Destroy()
	QDEL_NULL(song)
	return ..()

/obj/item/instrument/proc/can_play(atom/music_player)
	if(!ismob(music_player))
		return FALSE
	var/mob/user = music_player
	if(user.incapacitated)
		return FALSE
	if(!Adjacent(user))
		return FALSE
	return TRUE

/obj/item/instrument/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]Começa a tocar 'Gloomy Sunday'! Parece que...[user.p_theyre()]Tentando cometer suicídio!"))
	return BRUTELOSS

/obj/item/instrument/ui_interact(mob/user, datum/tgui/ui)
	return song.ui_interact(user)

/obj/item/instrument/violin
	name = "space violin"
	desc = "Um instrumento musical de madeira com quatro cordas e um arco.\"O diabo foi para o espaço, ele estava procurando um assistente para o luto.\""
	icon_state = "violin"
	inhand_icon_state = "violin"
	hitsound = SFX_SWING_HIT
	allowed_instrument_ids = "violin"
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 4, /datum/material/iron = SHEET_MATERIAL_AMOUNT)

/obj/item/instrument/violin/golden
	name = "golden violin"
	desc = "Um instrumento musical dourado com quatro cordas e um arco.\"O diabo foi para o espaço, ele estava procurando um assistente para o luto.\""
	icon_state = "golden_violin"
	inhand_icon_state = "golden_violin"
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 4, /datum/material/iron = SHEET_MATERIAL_AMOUNT)

/obj/item/instrument/banjo
	name = "banjo"
	desc = "Um banjo da marca 'Mura'. É basicamente um tambor com pescoço e cordas."
	icon_state = "banjo"
	inhand_icon_state = "banjo"
	attack_verb_continuous = list("scruggs-styles", "hum-diggitys", "shin-digs", "clawhammers")
	attack_verb_simple = list("scruggs-style", "hum-diggity", "shin-dig", "clawhammer")
	hitsound = 'sound/items/weapons/banjoslap.ogg'
	allowed_instrument_ids = "banjo"

/obj/item/instrument/guitar
	name = "guitar"
	desc = "É feito de madeira e tem cordas de bronze."
	icon_state = "guitar"
	inhand_icon_state = "guitar"
	attack_verb_continuous = list("plays metal on", "serenades", "crashes", "smashes")
	attack_verb_simple = list("play metal on", "serenade", "crash", "smash")
	hitsound = 'sound/items/weapons/stringsmash.ogg'
	allowed_instrument_ids = list("guitar","csteelgt","cnylongt", "ccleangt", "cmutedgt")

/obj/item/instrument/eguitar
	name = "electric guitar"
	desc = "Torna possível todas as suas necessidades de trituração."
	icon_state = "eguitar"
	inhand_icon_state = "eguitar"
	force = 12
	attack_verb_continuous = list("plays metal on", "shreds", "crashes", "smashes")
	attack_verb_simple = list("play metal on", "shred", "crash", "smash")
	hitsound = 'sound/items/weapons/stringsmash.ogg'
	allowed_instrument_ids = "eguitar"

/obj/item/instrument/glockenspiel
	name = "glockenspiel"
	desc = "Barras de metal lisas perfeitas para qualquer banda."
	icon_state = "glockenspiel"
	allowed_instrument_ids = list("glockenspiel","crvibr", "sgmmbox", "r3celeste")
	inhand_icon_state = "glockenspiel"

/obj/item/instrument/accordion
	name = "accordion"
	desc = "Pun-Pun não incluído."
	icon_state = "accordion"
	allowed_instrument_ids = list("crack", "crtango", "accordion")
	inhand_icon_state = "accordion"

/obj/item/instrument/trumpet
	name = "trumpet"
	desc = "Para anunciar a Chegada do Rei!"
	icon_state = "trumpet"
	allowed_instrument_ids = "crtrumpet"
	inhand_icon_state = "trumpet"

/obj/item/instrument/trumpet/spectral
	name = "spectral trumpet"
	desc = "As coisas estão prestes a ficar assustadoras!"
	icon_state = "spectral_trumpet"
	inhand_icon_state = "spectral_trumpet"
	force = 0
	attack_verb_continuous = list("plays", "jazzes", "trumpets", "mourns", "doots", "spooks")
	attack_verb_simple = list("play", "jazz", "trumpet", "mourn", "doot", "spook")
	var/single_use = FALSE

/obj/item/instrument/trumpet/spectral/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/spooky, too_spooky = !single_use, single_use = single_use)

/obj/item/instrument/trumpet/spectral/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	playsound(src, 'sound/runtime/instruments/trombone/En4.mid', 1000, 1, -1)
	return ..()

/obj/item/instrument/trumpet/spectral/one_doot
	single_use = TRUE

/obj/item/instrument/saxophone
	name = "saxophone"
	desc = "Este som calmante deixará seu público em lágrimas."
	icon_state = "saxophone"
	allowed_instrument_ids = "saxophone"
	inhand_icon_state = "saxophone"

/obj/item/instrument/saxophone/spectral
	name = "spectral saxophone"
	desc = "Este som assustador certamente deixará mortais nos ossos."
	icon_state = "saxophone"
	inhand_icon_state = "saxophone"
	force = 0
	attack_verb_continuous = list("plays", "jazzes", "saxxes", "mourns", "doots", "spooks")
	attack_verb_simple = list("play", "jazz", "sax", "mourn", "doot", "spook")
	var/single_use = FALSE

/obj/item/instrument/saxophone/spectral/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/spooky, too_spooky = !single_use, single_use = single_use)

/obj/item/instrument/saxophone/spectral/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	playsound(src, 'sound/runtime/instruments/trombone/En4.mid', 1000, 1, -1)
	return ..()

/obj/item/instrument/saxophone/spectral/one_doot
	single_use = TRUE

/obj/item/instrument/trombone
	name = "trombone"
	desc = "Como uma mesa de bilhar pode querer competir?"
	icon_state = "trombone"
	allowed_instrument_ids = list("crtrombone", "crbrass", "trombone")
	inhand_icon_state = "trombone"

/obj/item/instrument/trombone/spectral
	name = "spectral trombone"
	desc = "O instrumento favorito de um esqueleto. Aplicar diretamente nos mortais."
	icon_state = "trombone"
	inhand_icon_state = "trombone"
	force = 0
	attack_verb_continuous = list("plays", "jazzes", "trombones", "mourns", "doots", "spooks")
	attack_verb_simple = list("play", "jazz", "trombone", "mourn", "doot", "spook")
	var/single_use = FALSE

/obj/item/instrument/trombone/spectral/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/spooky, too_spooky = !single_use, single_use = single_use)

/obj/item/instrument/trombone/spectral/one_doot
	single_use = TRUE

/obj/item/instrument/trombone/spectral/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	playsound(src, 'sound/runtime/instruments/trombone/Cn4.mid', 1000, 1, -1)
	return ..()

/obj/item/instrument/recorder
	name = "recorder"
	desc = "Como na escola, jogando habilidade e tudo mais."
	force = 5
	icon_state = "recorder"
	allowed_instrument_ids = "recorder"
	inhand_icon_state = "recorder"

/obj/item/instrument/harmonica
	name = "harmonica"
	desc = "Para quando você tiver um caso ruim de blues espaciais."
	icon_state = "harmonica"
	allowed_instrument_ids = list("crharmony", "harmonica")
	inhand_icon_state = "harmonica"
	slot_flags = ITEM_SLOT_MASK
	force = 5
	w_class = WEIGHT_CLASS_SMALL
	actions_types = list(/datum/action/item_action/instrument)
	action_slots = ALL

/obj/item/instrument/harmonica/equipped(mob/user, slot, initial = FALSE)
	. = ..()
	if(!(slot & slot_flags))
		return
	RegisterSignal(user, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/obj/item/instrument/harmonica/dropped(mob/user, silent = FALSE)
	. = ..()
	UnregisterSignal(user, COMSIG_MOB_SAY)

/obj/item/instrument/harmonica/proc/handle_speech(datum/source, list/speech_args)
	SIGNAL_HANDLER
	if(!song.playing)
		return
	if(!ismob(loc))
		CRASH("[src] was still registered to listen in on [source] but was not found to be on their mob.")
	to_chat(loc, span_warning("Pare de tocar passea para falar..."))
	song.playing = FALSE

/datum/action/item_action/instrument
	name = "Use Instrument"
	desc = "Use o instrumento especificado."

/datum/action/item_action/instrument/do_effect(trigger_flags)
	if(!istype(target, /obj/item/instrument))
		return FALSE
	var/obj/item/instrument/instrument = target
	instrument.interact(usr)
	return TRUE

/obj/item/instrument/bikehorn
	name = "gilded bike horn"
	desc = "Uma corneta de bicicleta finamente decorada, capaz de buzinar em uma variedade de notas."
	icon_state = "bike_horn"
	inhand_icon_state = "bike_horn"
	lefthand_file = 'icons/mob/inhands/equipment/horns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/horns_righthand.dmi'
	allowed_instrument_ids = list("bikehorn", "honk")
	attack_verb_continuous = list("beautifully honks")
	attack_verb_simple = list("beautifully honk")
	w_class = WEIGHT_CLASS_TINY
	force = 0
	throw_speed = 3
	throw_range = 15
	hitsound = 'sound/items/bikehorn.ogg'

/obj/item/instrument/musicalmoth
	name = "musical moth"
	desc = "Apesar de sua popularidade, este controverso brinquedo musical foi eventualmente banido devido aos seus sons antiético amostrados de mariposas gritando em agonia."
	icon_state = "mothsician"
	allowed_instrument_ids = "mothscream"
	attack_verb_continuous = list("flutters", "flaps")
	attack_verb_simple = list("flutter", "flap")
	w_class = WEIGHT_CLASS_TINY
	force = 0
	hitsound = 'sound/mobs/humanoids/moth/scream_moth.ogg'
	custom_price = PAYCHECK_COMMAND * 2.37
	custom_premium_price = PAYCHECK_COMMAND * 2.37
