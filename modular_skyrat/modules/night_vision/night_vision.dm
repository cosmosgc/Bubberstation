/datum/quirk/night_vision
	name = "Night Vision"
	desc = "Você pode ver um pouco mais claramente em plena escuridão do que a maioria das pessoas."
	icon = FA_ICON_MOON
	value = 4
	mob_trait = TRAIT_NIGHT_VISION
	gain_text = span_notice("As sombras parecem menos escuras.")
	lose_text = span_danger("Tudo parece um pouco mais escuro.")
	medical_record_text = "Os olhos do paciente mostram aclimatação acima da média para a escuridão."
	mail_goodies = list(
		/obj/item/flashlight/flashdark,
		/obj/item/food/grown/mushroom/glowshroom/shadowshroom,
		/obj/item/skillchip/light_remover,
	)

/datum/quirk/night_vision/add(client/client_source)
	refresh_quirk_holder_eyes()

/datum/quirk/night_vision/remove()
	refresh_quirk_holder_eyes()

/datum/quirk/night_vision/proc/refresh_quirk_holder_eyes()
	var/mob/living/carbon/human/human_quirk_holder = quirk_holder
	var/obj/item/organ/eyes/eyes = human_quirk_holder.get_organ_by_type(/obj/item/organ/eyes)
	if(!eyes)
		return
	// We've either added or removed TRAIT_NIGHT_VISION before calling this proc. Just refresh the eyes.
	eyes.refresh()
