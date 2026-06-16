/datum/quirk/glass_jaw
	name = "Glass Jaw"
	desc = "Você tem uma mandíbula muito frágil. Qualquer golpe suficientemente forte na sua cabeça pode te derrubar."
	icon = FA_ICON_HAND_FIST
	value = -4
	gain_text = span_danger("Sua mandíbula está solta.")
	lose_text = span_notice("Sua mandíbula está se encaixando de novo.")
	medical_record_text = "O paciente é absurdamente fácil de nocautear. Não os deixe perto de um ringue de boxe."
	hardcore_value = 4
	mail_goodies = list(
		/obj/item/clothing/gloves/boxing,
		/obj/item/clothing/mask/luchador/rudos,
	)

/datum/quirk/glass_jaw/New()
	. = ..()
	//randomly picks between blue or red equipment for goodies
	if(prob(50))
		mail_goodies = list(
			/obj/item/clothing/gloves/boxing,
			/obj/item/clothing/mask/luchador/rudos,
		)
	else
		mail_goodies = list(
			/obj/item/clothing/gloves/boxing/blue,
			/obj/item/clothing/mask/luchador/tecnicos,
		)

/datum/quirk/glass_jaw/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(punch_out))

/datum/quirk/glass_jaw/remove()
	UnregisterSignal(quirk_holder, COMSIG_MOB_APPLY_DAMAGE)

/datum/quirk/glass_jaw/proc/punch_out(mob/living/carbon/source, damage, damagetype, def_zone, blocked, wound_bonus, exposed_wound_bonus, sharpness, attack_direction, attacking_item)
	SIGNAL_HANDLER

	if(isbodypart(def_zone))
		var/obj/item/bodypart/hitting = def_zone
		def_zone = hitting.body_zone
	if(damagetype != BRUTE || def_zone != BODY_ZONE_HEAD)
		return
	if(damage < 5)
		return
	//blunt items are more likely to knock out, but sharp ones are still capable of doing it
	if(prob(CEILING(damage * (sharpness & (SHARP_EDGED|SHARP_POINTY) ? 0.65 : 1), 1)))
		//don't display the message if little mac is already KO'd
		if(!source.IsUnconscious())
			source.visible_message(
				span_warning("[source] É nocauteado!"),
				span_userdanger("Você é nocauteado!"),
				vision_distance = COMBAT_MESSAGE_RANGE,
		)
		source.Unconscious(3 SECONDS)
