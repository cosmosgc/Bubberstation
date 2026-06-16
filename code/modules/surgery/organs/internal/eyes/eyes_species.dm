/obj/item/organ/eyes/night_vision/mushroom
	name = "fung-eye"
	desc = "Enquanto por fora eles parecem inertes e mortos, os olhos das pessoas cogumelos são realmente muito avançados."
	low_light_cutoff = list(0, 15, 20)
	medium_light_cutoff = list(0, 20, 35)
	high_light_cutoff = list(0, 40, 50)
	pupils_name = "photosensory openings"
	penlight_message = "estão ligados a talos de fungos."

/obj/item/organ/eyes/zombie
	name = "undead eyes"
	desc = "Um pouco contraintuitivamente, esses olhos meio podres têm visão superior aos de um ser humano vivo."
	color_cutoffs = list(25, 35, 5)
	penlight_message = "estão podres e decaídas!"

/obj/item/organ/eyes/zombie/penlight_examine(mob/living/viewer, obj/item/examtool)
	return span_danger("[owner.p_Their()] Olhos.[penlight_message]")

/obj/item/organ/eyes/alien
	name = "alien eyes"
	desc = "Acontece que elees os tinham, final!"
	sight_flags = SEE_MOBS
	color_cutoffs = list(25, 5, 42)

/obj/item/organ/eyes/golem
	name = "resonating crystal"
	desc = "Golems de alguma forma medem níveis de luz externa e detectam minério próximo usando esta sensível rede mineral."
	icon_state = "adamantine_cords"
	eye_icon_state = null
	blink_animation = FALSE
	iris_overlay = null
	color = COLOR_GOLEM_GRAY
	visual = FALSE
	organ_flags = ORGAN_MINERAL
	color_cutoffs = list(10, 15, 5)
	actions_types = list(/datum/action/cooldown/golem_ore_sight)
	penlight_message = "Vislumbre, sua estrutura cristalina refrata luz para dentro"
	pupils_name = "lensing gems" // Given it says these are a "mineral lattice" that collects light i assume they work like artifical ruby laser foci

/// Send an ore detection pulse on a cooldown
/datum/action/cooldown/golem_ore_sight
	name = "Ore Resonance"
	desc = "Causa a vibração dos minérios próximos, revelando sua localização."
	button_icon = 'icons/obj/devices/scanner.dmi'
	button_icon_state = "manual_mining"
	check_flags = AB_CHECK_CONSCIOUS
	cooldown_time = 10 SECONDS

/datum/action/cooldown/golem_ore_sight/Activate(atom/target)
	. = ..()
	mineral_scan_pulse(get_turf(target), scanner = target)

/obj/item/organ/eyes/moth
	name = "moth eyes"
	desc = "Esses olhos parecem ter maior sensibilidade à luz brilhante, sem melhora para visão de baixa luz."
	icon_state = "eyes_moth"
	eye_icon_state = "motheyes"
	blink_animation = FALSE
	iris_overlay = null
	flash_protect = FLASH_PROTECTION_SENSITIVE
	pupils_name = "ommatidia" //yes i know compound eyes have no pupils shut up
	penlight_message = "são bulbosos e insectóides."

/obj/item/organ/eyes/ghost
	name = "ghost eyes"
	desc = "Apesar da falsa pupilas, elas podem ver muito bem."
	icon_state = "eyes-ghost"
	blink_animation = FALSE
	movement_type = PHASING
	organ_flags = parent_type::organ_flags | ORGAN_GHOST

/obj/item/organ/eyes/snail
	name = "snail eyes"
	desc = "Esses olhos parecem ter um grande alcance, mas podem ser pesados com óculos."
	icon_state = "eyes_snail"
	eye_icon_state = "snail_eyes"
	blink_animation = FALSE
	pupils_name = "eyestalks" //many species of snails can retract their eyes into their face! (my lame science excuse for not having better writing here)
	penlight_message = "estão sentados sobre tentáculos retráteis"

/obj/item/organ/eyes/jelly
	name = "jelly eyes"
	desc = "Esses olhos são feitos de uma geléia macia. Ao contrário de todos os outros olhos, há três deles."
	icon_state = "eyes_jelly"
	eye_icon_state = "jelleyes"
	blink_animation = FALSE
	iris_overlay = null
	pupils_name = "lensing bubbles" //imagine a water lens physics demo but with goo. thats how these work.
	penlight_message = "são três bolhas de geléia refração."

/obj/item/organ/eyes/lizard
	name = "reptile eyes"
	desc = "Um par de olhos de répteis com fendas verticais finas para as pupilas."
	icon_state = "lizard_eyes"
	synchronized_blinking = FALSE
	pupils_name = "slit pupils"
	penlight_message = "Cortar verticalmente pupilas e brancos coloridos"

/obj/item/organ/eyes/pod
	name = "pod eyes"
	desc = "A salada mais estranha que já viu."
	icon_state = "eyes_pod"
	// BUBBER EDIT - REMOVAL - START
	/*
	eye_color_left = "#375846"
	eye_color_right = "#375846"
	iris_overlay = null
	*/
	// BUBBER EDIT - REMOVAL - END
	foodtype_flags = PODPERSON_ORGAN_FOODTYPES
	penlight_message = "são verdes e como plantas."

/obj/item/organ/eyes/felinid
	name = "felinid eyes"
	desc = "Um par de olhos altamente reflexivos com pupilas cortadas, como as de um gato."
	pupils_name = "slit pupils"
	penlight_message = "Brilha sob a luz pérola"
