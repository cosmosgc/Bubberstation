/obj/item/organ/cyberimp/brain/anti_sleep
	name = "CNS jumpstarter"
	desc = "Este implante automaticamente tentará sacudi-lo acordado quando detectar que você caiu inconsciente fora dos ciclos de sono REM. Tem um curto esfriamento. Conflitos com o reinício do CNS, tornando-os incompatíveis um com o outro."
	icon_state = "brain_implant_rebooter"
	slot = ORGAN_SLOT_BRAIN_CNS //One or the other, not both.
	var/cooldown

/obj/item/organ/cyberimp/brain/anti_sleep/on_life(seconds_per_tick, times_fired)
	if(timeleft(cooldown))
		return

	var/mob/living/carbon/human/human_owner = owner
	if(human_owner.stat != UNCONSCIOUS)
		return

	human_owner.AdjustUnconscious(-50 * seconds_per_tick, FALSE)
	human_owner.AdjustSleeping(-50 * seconds_per_tick, FALSE)
	to_chat(owner, span_notice("Você sente um curso de energia através de seu corpo!"))
	cooldown = addtimer(CALLBACK(src, PROC_REF(sleepytimerend)), 5 SECONDS, TIMER_UNIQUE | TIMER_OVERRIDE | TIMER_STOPPABLE | TIMER_DELETE_ME)
	. = ..()

/obj/item/organ/cyberimp/brain/anti_sleep/proc/sleepytimerend()
	to_chat(owner, span_notice("Você ouve um pequeno bip na sua cabeça quando o seu CNS Jumpstarter termina de recarregar."))
	cooldown = null

/obj/item/organ/cyberimp/brain/anti_sleep/emp_act(severity)
	. = ..()
	var/mob/living/carbon/human/human_owner = owner
	if((organ_flags & ORGAN_FAILING) || . & EMP_PROTECT_SELF)
		return
	organ_flags |= ORGAN_FAILING
	human_owner.AdjustUnconscious(200)
	cooldown = addtimer(CALLBACK(src, PROC_REF(reboot)), (9 SECONDS / severity), TIMER_UNIQUE | TIMER_OVERRIDE | TIMER_STOPPABLE | TIMER_DELETE_ME)

/obj/item/organ/cyberimp/brain/anti_sleep/proc/reboot()
	organ_flags &= ~ORGAN_FAILING
