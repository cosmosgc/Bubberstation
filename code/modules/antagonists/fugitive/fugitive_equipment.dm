/obj/item/implant/camouflage
	name = "experimental camouflage implant"
	desc = "Permite que seu dono se misture com seus arredores. Beleza!"
	actions_types = list(/datum/action/item_action/camouflage)

/obj/item/implant/camouflage/emp_act(severity)
	. = ..()

	if(prob(15 * severity))
		visible_message(span_warning("Os sistemas de camuflagem dentro do seu implante começam a sobrecarregar!"), blind_message = span_hear("Você ouve uma falha, e as faíscas."))
		for(var/datum/action/item_action/camouflage/cloaking_ability in actions)
			cloaking_ability.remove_cloaking()

/datum/action/item_action/camouflage
	name = "Activate Camouflage"
	desc = "Ative seu implante camuflado, e misture-se em seu entorno..."
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "deploy_box"
	/// The alpha we move to when activating this action.
	var/camouflage_alpha = 35
	/// Are we currently cloaking ourself?
	var/cloaking = FALSE

/datum/action/item_action/camouflage/Remove(mob/living/remove_from)
	if(owner)
		remove_cloaking()

	return ..()

/datum/action/item_action/camouflage/do_effect(trigger_flags)
	. = ..()
	if(!.)
		return

	if(cloaking)
		remove_cloaking()
	else
		owner.alpha = camouflage_alpha
		to_chat(owner, span_notice("Você ativa sua camuflagem e se mistura ao seu redor..."))
		cloaking = TRUE

/**
 * Returns the owner's alpha value to its initial value,
 *
 * Disables cloaking and flashes sparks. Used when toggling the ability, as well as to
 * make sure the action properly resets its owner when removed.
 */

/datum/action/item_action/camouflage/proc/remove_cloaking()
	do_sparks(2, FALSE, owner)
	owner.alpha = initial(owner.alpha)
	to_chat(owner, span_notice("Você desativa sua camuflagem, e fica visível mais uma vez."))
	cloaking = FALSE

/obj/item/reagent_containers/hypospray/medipen/invisibility
	name = "invisibility autoinjector"
	desc = "Um autoinjector contendo um composto Saturn-X estabilizado. Produzido para uso em operações táticas furtivas, por agentes que provavelmente estavam confortáveis com nudez."
	icon_state = "invispen"
	base_icon_state = "invispen"
	volume = 20 //By my estimate this will last you about 10-ish mintues
	amount_per_transfer_from_this = 20
	list_reagents = list(/datum/reagent/drug/saturnx/stable = 20)
	label_examine = FALSE
