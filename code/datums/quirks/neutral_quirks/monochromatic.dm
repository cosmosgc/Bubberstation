/datum/quirk/monochromatic
	name = "Monochromacy"
	desc = "Você sofre de total cegueira da cor, e percebe quase todo o mundo em pretos e brancos."
	icon = FA_ICON_ADJUST
	value = 0
	medical_record_text = "O paciente está com cegueira de cor quase completa."
	mail_goodies = list( // Noir detective wannabe
		/obj/item/clothing/suit/toggle/jacket/det_trench/noir,
		/obj/item/clothing/suit/jacket/det_suit/noir,
		/obj/item/clothing/head/fedora/beige,
		/obj/item/clothing/head/fedora/white,
	)

/datum/quirk/monochromatic/add(client/client_source)
	quirk_holder.add_client_colour(/datum/client_colour/monochrome, QUIRK_TRAIT)

/datum/quirk/monochromatic/post_add()
	if(is_detective_job(quirk_holder.mind.assigned_role))
		to_chat(quirk_holder, span_bolddanger("Mmm. Nunca há nada claro nesta estação. São todos tons de cinza..."))
		quirk_holder.playsound_local(quirk_holder, 'sound/ambience/security/ambidet1.ogg', 50, FALSE)

/datum/quirk/monochromatic/remove()
	quirk_holder.remove_client_colour(QUIRK_TRAIT)
