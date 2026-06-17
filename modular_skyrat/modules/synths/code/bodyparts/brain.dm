/obj/item/organ/brain/synth
	name = "compact positronic brain"
	slot = ORGAN_SLOT_BRAIN
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_ROBOTIC | ORGAN_SYNTHETIC_FROM_SPECIES
	maxHealth = 2 * STANDARD_ORGAN_THRESHOLD
	desc = "Um cubo de metal brilhante, quatro polegadas para um lado e coberto de sulcos rasos. Tem um número de série IPC gravado no topo. Geralmente é colocado no peito de tripulantes sintéticos."
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "posibrain-ipc"
	/// The last time (in ticks) a message about brain damage was sent. Don't touch.
	var/last_message_time = 0
	organ_traits = list(TRAIT_SILICON_EMOTES_ALLOWED)

/obj/item/organ/brain/synth/on_mob_insert(mob/living/carbon/brain_owner, special, movement_flags = NO_ID_TRANSFER)
	. = ..()

	if(brain_owner.stat != DEAD || !ishuman(brain_owner))
		return

	var/mob/living/carbon/human/user_human = brain_owner
	if(HAS_TRAIT(user_human, TRAIT_REVIVES_BY_HEALING) && user_human.health > SYNTH_BRAIN_WAKE_THRESHOLD)
		user_human.revive(FALSE)

/obj/item/organ/brain/synth/emp_act(severity) // EMP act against the posi, keep the cap far below the organ health
	. = ..()

	if(!owner || . & EMP_PROTECT_SELF)
		return

	if(COOLDOWN_FINISHED(src, severe_cooldown)) //So we cant just spam emp to kill people.
		COOLDOWN_START(src, severe_cooldown, 10 SECONDS)
		switch(severity)
			if(EMP_HEAVY)
				to_chat(owner, span_warning("01001001 00100111 01101101 00100000 01100110 01110101 01100011 01101011 01100101 01100100 00101110"))
				apply_organ_damage(SYNTH_ORGAN_HEAVY_EMP_DAMAGE, SYNTH_EMP_BRAIN_DAMAGE_MAXIMUM, required_organ_flag = ORGAN_ROBOTIC)
			if(EMP_LIGHT)
				to_chat(owner, span_warning("Dano eletromagnético na unidade central de processamento. Código de erro: 401-YT"))
				apply_organ_damage(SYNTH_ORGAN_LIGHT_EMP_DAMAGE, SYNTH_EMP_BRAIN_DAMAGE_MAXIMUM, required_organ_flag = ORGAN_ROBOTIC)

/obj/item/organ/brain/synth/apply_organ_damage(damage_amount, maximum = maxHealth, required_organ_flag = NONE)
	. = ..()

	if(owner && damage > 0 && (world.time - last_message_time) > SYNTH_BRAIN_DAMAGE_MESSAGE_INTERVAL)
		last_message_time = world.time

		if(damage > BRAIN_DAMAGE_SEVERE)
			to_chat(owner, span_warning("Alre: re oumtnin ilir tocorr:pa ni ne:cnrrpiioruloomatt cisingode: P1 1- H."))
			return

		if(damage > BRAIN_DAMAGE_MILD)
			to_chat(owner, span_warning("Alerta: pequena corrupção na unidade central de processamento. Código de erro: 001-HP"))

/obj/item/organ/brain/synth/circuit
	name = "compact AI circuit"
	desc = "Um circuito compacto e extremamente complexo, perfeitamente dimensionado para caber no mesmo espaço que um cérebro positrônico sintético compatível. Geralmente é colocado no peito de tripulantes sintéticos."
	icon = 'modular_skyrat/master_files/icons/obj/alt_silicon_brains.dmi'
	icon_state = "circuit-occupied"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'

/obj/item/organ/brain/synth/mmi
	name = "compact man-machine interface"
	desc = "Uma interface homem-máquina compacta, perfeitamente dimensionada para caber no mesmo espaço que um cérebro positrônico sintético-compatível. Infelizmente, o cérebro parece estar permanentemente ligado aos circuitos, e parece relativamente sensível ao seu ambiente. Geralmente é colocado no peito de tripulantes sintéticos."
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "mmi-ipc"
