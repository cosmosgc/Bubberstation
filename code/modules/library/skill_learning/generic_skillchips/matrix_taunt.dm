#define TAUNT_STAMINA_COST 19

/obj/item/skillchip/matrix_taunt
	name = "BULLET_DODGER skillchip"
	desc = "Overclock, sobreponha e sobrecarregue seus sentidos cinestésicos, propriocepção e reflexos por uma pequena janela de tempo para escapar automaticamente de projéteis disparados. Ativado por uma provocação."
	skill_name = "Taunt 2 Dodge"
	skill_description = "À custa da resistência, suas provocações também podem ser usadas para evitar projéteis."
	skill_icon = FA_ICON_SPINNER
	activate_message = span_notice("Você sente o desejo de provocar cênicamente como se fosse o Escolhido.")
	deactivate_message = span_notice("O desejo de provocar desaparece.")

/obj/item/skillchip/matrix_taunt/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	RegisterSignal(user, COMSIG_MOB_EMOTED("taunt"), PROC_REF(on_taunt))
	RegisterSignal(user, COMSIG_MOB_PRE_EMOTED, PROC_REF(check_if_we_can_taunt))

/obj/item/skillchip/matrix_taunt/on_deactivate(mob/living/carbon/user, silent=FALSE)
	UnregisterSignal(user, list(COMSIG_MOB_EMOTED("taunt"), COMSIG_MOB_PRE_EMOTED))
	return ..()

///Prevent players from stamcritting from INTENTIONAL flips. 1.4s of bullet immunity isn't worth several secs of stun.
/obj/item/skillchip/matrix_taunt/proc/check_if_we_can_taunt(mob/living/source, key, params, type_override, intentional, datum/emote/emote)
	SIGNAL_HANDLER
	if(key != "taunt" || !intentional)
		return
	if((source.maxHealth - (source.get_stamina_loss() + TAUNT_STAMINA_COST)) <= source.crit_threshold)
		source.balloon_alert(source, "Muito cansado!")
		return COMPONENT_CANT_EMOTE

/obj/item/skillchip/matrix_taunt/proc/on_taunt(mob/living/source)
	SIGNAL_HANDLER
	if(HAS_TRAIT_FROM(source, TRAIT_UNHITTABLE_BY_PROJECTILES, SKILLCHIP_TRAIT))
		return
	ADD_TRAIT(source, TRAIT_UNHITTABLE_BY_PROJECTILES, SKILLCHIP_TRAIT)
	source.adjust_stamina_loss(TAUNT_STAMINA_COST)
	addtimer(TRAIT_CALLBACK_REMOVE(source, TRAIT_UNHITTABLE_BY_PROJECTILES, SKILLCHIP_TRAIT), TAUNT_EMOTE_DURATION * 1.5)

#undef TAUNT_STAMINA_COST
