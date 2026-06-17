/// The message displayed in the hemophage's chat when they enter their dormant state.
#define DORMANT_STATE_START_MESSAGE "You feel your tumor's pulse slowing down, as it enters a dormant state. You suddenly feel incredibly weak and vulnerable to everything, and exercise has become even more difficult, as only your most vital bodily functions remain."
/// The message displayed in the hemophage's chat when they leave their dormant state.
#define DORMANT_STATE_END_MESSAGE "You feel a rush through your veins, as you can tell your tumor is pulsating at a regular pace once again. You no longer feel incredibly vulnerable, and exercise isn't as difficult anymore."


/datum/action/cooldown/hemophage
	cooldown_time = 3 SECONDS
	button_icon_state = null


/datum/action/cooldown/hemophage/New(Target)
	. = ..()

	if(target && isnull(button_icon_state))
		AddComponent(/datum/component/action_item_overlay, target)


/datum/action/cooldown/hemophage/toggle_dormant_state
	name = "Enter Dormant State"
	desc = "Faz o tumor entrar em um estado de dormência, fazendo com que precise de uma quantidade mínima de sangue para sobreviver. No entanto, como o tumor que vive em seu corpo é a única coisa que o mantém ainda vivo, tornando-o latente corta tanto ele quanto você para apenas as funções essenciais para continuar de pé. Não consertará mais seu corpo nem mesmo na escuridão, e a falta de sangue pulsando através de você terá você o mais fraco que você já sentiu, e deixá-lo dificilmente capaz de correr. Não está em um interruptor, e levará algum tempo para acordar."
	cooldown_time = 3 MINUTES
	background_icon = 'modular_zubbers/icons/mob/actions/bloodsucker.dmi'
	active_background_icon_state = "vamp_power_on"
	background_icon_state = "vamp_power_off"


/datum/action/cooldown/hemophage/toggle_dormant_state/Activate(atom/action_target)
	if(!owner || !ishuman(owner) || !target)
		return

	var/obj/item/organ/heart/hemophage/tumor = target
	if(!tumor || !istype(tumor)) // This shouldn't happen, but you can never be too careful.
		return

	owner.balloon_alert(owner, "[tumor.is_dormant ? "leaving" : "entering"] dormant state")

	if(!do_after(owner, 3 SECONDS))
		owner.balloon_alert(owner, "mudança de estado cancelada")
		return

	to_chat(owner, span_notice("[tumor.is_dormant ? DORMANT_STATE_END_MESSAGE : DORMANT_STATE_START_MESSAGE]"))

	StartCooldown()

	tumor.toggle_dormant_state()
	tumor.toggle_dormant_tumor_vulnerabilities(owner)

	if(tumor.is_dormant)
		name = "Exit Dormant State"
		desc =  "Faz com que a massa negra viva dentro de você para despertar, permitindo que sua circulação retorne e sangue para bombear livremente novamente. Enche suas pernas para deixar você correr novamente, e anseia pela escuridão como antes. Você começa a sentir força ao invés da fraqueza que sentiu antes. No entanto, o tumor lhe dando vida não está em um interruptor, e levará algum tempo para dominá-lo novamente."
	else
		name = initial(name)
		desc = initial(desc)


#undef DORMANT_STATE_START_MESSAGE
#undef DORMANT_STATE_END_MESSAGE
