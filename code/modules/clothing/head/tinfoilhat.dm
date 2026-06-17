/obj/item/clothing/head/costume/foilhat
	name = "tinfoil hat"
	desc = "Raios de controle de pensamento, varredura psicotrônica. Não se preocupe, estou protegido porque fiz este chapéu."
	icon_state = "foilhat"
	inhand_icon_state = null
	armor_type = /datum/armor/costume_foilhat
	equip_delay_other = 14 SECONDS
	clothing_flags = ANTI_TINFOIL_MANEUVER
	// var/datum/brain_trauma/mild/phobia/conspiracies/paranoia BUBBERSTATION CHANGE, REMOVES PARANOIA
	var/warped = FALSE
	interaction_flags_mouse_drop = NEED_HANDS

/datum/armor/costume_foilhat
	laser = -5
	energy = -15

/obj/item/clothing/head/costume/foilhat/Initialize(mapload)
	. = ..()
	if(warped)
		warp_up()
		return

	AddComponent(
		/datum/component/anti_magic, \
		antimagic_flags = MAGIC_RESISTANCE_MIND, \
		inventory_flags = ITEM_SLOT_HEAD, \
		charges = 6, \
		block_magic = CALLBACK(src, PROC_REF(drain_antimagic)), \
		expiration = CALLBACK(src, PROC_REF(warp_up)) \
	) //BUBBERSTATION CHANGE: NEAR-INFINITE CHARGES (6 TO 1000)


/obj/item/clothing/head/costume/foilhat/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_HEAD) || warped)
		return
	/* BUBBERSTATION CHANGE START: REMOVES PARANOIA
	if(paranoia)
		QDEL_NULL(paranoia)
	paranoia = new()
	BUBBERSTATION CHANGE END: REMOVES PARANOIA */

	RegisterSignal(user, COMSIG_HUMAN_SUICIDE_ACT, PROC_REF(call_suicide))

	// user.gain_trauma(paranoia, TRAUMA_RESILIENCE_MAGIC ) BUBBERSTATION CHANGE: REMOVES PARANOIA
	to_chat(user, span_warning("Enquanto você usa o chapéu desfeito, um mundo inteiro de teorias de conspiração e idéias aparentemente insanas de repente entra em sua mente. O que você achou inacreditável de repente parece inegável. Tudo está conectado e nada acontece por acidente. Você sabe demais e agora eles querem te pegar."))

/obj/item/clothing/head/costume/foilhat/mouse_drop_dragged(atom/over_object, mob/user)
	//God Im sorry
	if(!warped && iscarbon(user))
		var/mob/living/carbon/C = user
		if(src == C.head)
			to_chat(C, span_userdanger("Por que quer tirar isso? Você quer que eles entrem em sua mente?"))
			return
	return ..()

/obj/item/clothing/head/costume/foilhat/dropped(mob/user)
	. = ..()
	/* BUBBERSTATION CHANGE START: REMOVES PARANOIA
	if(paranoia)
		QDEL_NULL(paranoia)
	*/
	UnregisterSignal(user, COMSIG_HUMAN_SUICIDE_ACT)

/// When the foilhat is drained an anti-magic charge.
/obj/item/clothing/head/costume/foilhat/proc/drain_antimagic(mob/user)
	to_chat(user, span_warning("[src] crumples slightly. Something is trying to get inside your mind!"))

/obj/item/clothing/head/costume/foilhat/proc/warp_up()
	name = "scorched tinfoil hat"
	desc = "Um chapéu muito torcido. Muito improvável que isso ainda funcione contra qualquer um dos perigos ficcionais ou reais que costumava fazer."
	warped = TRUE
	clothing_flags &= ~ANTI_TINFOIL_MANEUVER
	if(!isliving(loc)) //BUBBERSTATION CHANGE, REMOVES PARANOIA
		return
	var/mob/living/target = loc
	UnregisterSignal(target, COMSIG_HUMAN_SUICIDE_ACT)
	if(target.get_item_by_slot(ITEM_SLOT_HEAD) != src)
		return
	// QDEL_NULL(paranoia) BUBBERSTATION CHANGE, REMOVES PARANOIA
	if(target.stat < UNCONSCIOUS)
		to_chat(target, span_warning("Seu zeloso conspiracionismo rapidamente se dissipa enquanto o chapéu enfeitiçado se transforma em uma bagunça arruinada. Todas essas teorias começam a soar como uma fanfarra ridícula."))

/obj/item/clothing/head/costume/foilhat/attack_hand(mob/user, list/modifiers)
	if(!warped && iscarbon(user))
		var/mob/living/carbon/wearer = user
		if(src == wearer.head)
			to_chat(user, span_userdanger("Por que quer tirar isso? Você quer que eles entrem em sua mente?"))
			return
	return ..()

/obj/item/clothing/head/costume/foilhat/microwave_act(obj/machinery/microwave/microwave_source, mob/microwaver, randomize_pixel_offset)
	. = ..()
	if(warped)
		return

	warp_up()
	return . | COMPONENT_MICROWAVE_SUCCESS

/obj/item/clothing/head/costume/foilhat/proc/call_suicide(datum/source)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(suicide_act), source) //SIGNAL_HANDLER doesn't like things waiting; INVOKE_ASYNC bypasses that
	return OXYLOSS

/obj/item/clothing/head/costume/foilhat/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] gets a crazed look in [user.p_their()] eyes! [capitalize(user.p_they())] [user.p_have()] witnessed the truth, and try to commit suicide!"))
	var/static/list/conspiracy_line = list(
		";THEY'RE HIDING CAMERAS IN THE CEILINGS! THEY WITNESS EVERYTHING WE DO!!",
		";HOW CAN I LIVE IN A WORLD WHERE MY FATE AND EXISTENCE IS DECIDED BY A GROUP OF INDIVIDUALS?!!",
		";THEY'RE TOYING WITH ALL OF YOUR MINDS AND TREATING YOU AS EXPERIMENTS!!",
		";THEY HIRE ASSISTANTS WITHOUT DOING BACKGROUND CHECKS!!",
		";WE LIVE IN A ZOO AND WE ARE THE ONES BEING OBSERVED!!",
		";WE REPEAT OUR LIVES DAILY WITHOUT FURTHER QUESTIONS!!"
	)
	user.say(pick(conspiracy_line), forced=type)
	var/obj/item/organ/brain/brain = user.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(brain)
		brain.set_organ_damage(BRAIN_DAMAGE_DEATH)
	return OXYLOSS
