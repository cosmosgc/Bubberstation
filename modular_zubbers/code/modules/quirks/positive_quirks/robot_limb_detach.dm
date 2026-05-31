/datum/quirk/robot_limb_detach
	name = "Cybernetic Limb Mounts"
	desc = "Você é capaz de separar e recolocar qualquer membro robótico instalado com muito pouco esforço, contanto que eles estejam em boas condições. Clique em si mesmo enquanto mira em um membro para removê-lo."
	gain_text = span_notice("Os sensores internos reportam que os protocolos estão prontos e esperando.")
	lose_text = span_notice("ERRO: PROTOCOLOS DE DESENGAGAMENTO DE LIMB OFFLINE.")
	medical_record_text = "O paciente tem acesso rápido e liberação de cibernética articular."
	value = 4
	mob_trait = TRAIT_ROBOTIC_LIMBATTACHMENT
	icon = FA_ICON_HANDSHAKE_SIMPLE_SLASH
	quirk_flags = QUIRK_HUMAN_ONLY

/datum/quirk/robot_limb_detach/add(client/client_source)
	quirk_holder.AddElement(/datum/element/robot_self_amputation)

/datum/quirk/robot_limb_detach/remove()
	quirk_holder.RemoveElement(/datum/element/robot_self_amputation)

/// Give to a human to allow them to self amputate their mechanical limbs
/datum/element/robot_self_amputation

/datum/element/robot_self_amputation/Attach(datum/target)
	. = ..()

	if(!iscarbon(target))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_MOB_ATTACK_HAND, PROC_REF(pre_self_amputate))


/datum/element/robot_self_amputation/Detach(datum/source, ...)
	UnregisterSignal(source, COMSIG_MOB_ATTACK_HAND)
	. = ..()

/datum/element/robot_self_amputation/proc/pre_self_amputate(mob/living/carbon/amputee, mob/amputee_again, mob/living/target, datum/martial_art/attacker_style, modifiers)
	SIGNAL_HANDLER

	if(target != amputee)
		return

	if(!LAZYACCESS(modifiers, RIGHT_CLICK))
		return

	var/obj/item/bodypart/targeted_limb = amputee.get_bodypart(check_zone(amputee.zone_selected))

	if(!targeted_limb)
		return

	// Chest removal Fail
	if (targeted_limb.body_zone == BODY_ZONE_CHEST)
		return

	// Head removal fail for people who can't live without one
	if (targeted_limb.body_zone == BODY_ZONE_HEAD && !issynthetic(amputee))
		return

	// Organic Limb Fail
	if (IS_ORGANIC_LIMB(targeted_limb))
		return

	if(HAS_TRAIT(amputee, TRAIT_NODISMEMBER))
		to_chat(amputee, span_warning("ERRO: PROTOCOLOS DE DESENGAGAMENTO DE LIMB OFFLINE. Procure um técnico de manutenção."))
		return

	if (amputee.handcuffed)
		to_chat(amputee, span_alert("Você não consegue segurar bem as mãos."))
		return

	if (length(targeted_limb.wounds) >= 1)
		amputee.balloon_alert(amputee, "Não podemos separar membros feridos!")
		playsound(amputee, 'sound/machines/buzz/buzz-sigh.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		return

	INVOKE_ASYNC(src, PROC_REF(self_amputate), amputee, targeted_limb)

/datum/element/robot_self_amputation/proc/self_amputate(mob/living/carbon/amputee, obj/item/bodypart/targeted_limb)
	amputee.balloon_alert(amputee, "Tirando o membro...")
	playsound(amputee, 'sound/items/tools/rped.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	amputee.visible_message(span_notice("[amputee]Embaralha.[amputee.p_their()] [targeted_limb.name]para a frente, atuadores assobiando e sussurrando como[amputee.p_they()]desengatar[amputee.p_s()]o membro de sua montagem..."))

	if(!do_after(amputee, 10 SECONDS))
		amputee.balloon_alert(amputee, "Interrompido!")
		return
	if(amputee.handcuffed) //Prevents removing your arms if you get handcuffed part way through
		return

	playsound(amputee, 'sound/machines/buzz/buzz-sigh.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	amputee.visible_message(span_notice("Com um toque suave,[amputee]Finalmente as empresas[amputee.p_their()] [targeted_limb.name]livre de sua tomada."))
	targeted_limb.drop_limb()
	amputee.put_in_hands(targeted_limb)
	amputee.balloon_alert(amputee, "membro afastado!")
	if(prob(5))
		playsound(amputee, 'sound/items/champagne_pop.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	else
		playsound(amputee, 'sound/items/deconstruct.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
