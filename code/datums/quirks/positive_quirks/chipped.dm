/datum/quirk/chipped
	name = "Chipped"
	desc = "Você ficou preso na mania do chip há alguns anos, e teve um dos chips comercialmente disponíveis implantados em si mesmo."
	icon = FA_ICON_MICROCHIP
	value = 2
	gain_text = span_notice("Você de repente se sente lascado.")
	lose_text = span_danger("Você não se sente mais tão lascado.")
	medical_record_text = "O paciente explicou como eles foram pegos na 'perseguição de chips' recentemente, e agora eles têm algum chip inútil na cabeça. Imbecil."
	mail_goodies = list(
		/obj/item/skillchip/matrix_taunt,
		/obj/item/skillchip/big_pointer,
		/obj/item/skillchip/acrobatics,
	)
	/// Variable that holds the chip, used on removal.
	var/obj/item/skillchip/installed_chip

/datum/quirk_constant_data/chipped
	associated_typepath = /datum/quirk/chipped
	customization_options = list(/datum/preference/choiced/chipped)

/datum/quirk/chipped/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique = TRUE, announce = FALSE)
	var/chip_pref = client_source?.prefs?.read_preference(/datum/preference/choiced/chipped)

	if(isnull(chip_pref))
		return ..()
	installed_chip = GLOB.quirk_chipped_choice[chip_pref] || GLOB.quirk_chipped_choice[pick(GLOB.quirk_chipped_choice)]
	gain_text = span_notice("The [installed_chip::name] in your head buzzes with knowledge.")
	lose_text = span_notice("Pare de sentir o chip dentro da sua cabeça.")
	return ..()

/datum/quirk/chipped/add_unique(client/client_source)
	if(!iscarbon(quirk_holder))
		return

	var/mob/living/carbon/quirk_holder_carbon = quirk_holder
	installed_chip = new installed_chip()
	quirk_holder_carbon.implant_skillchip(installed_chip, force = TRUE)
	installed_chip.try_activate_skillchip(silent = FALSE, force = TRUE)

/datum/quirk/chipped/remove()
	QDEL_NULL(installed_chip)
	return ..()
