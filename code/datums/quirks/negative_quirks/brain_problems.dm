	/* A couple of brain tumor stats for anyone curious / looking at this quirk for balancing:
	 * - It takes less 16 minute 40 seconds to die from brain death due to a brain tumor.
	 * - It takes 1 minutes 40 seconds to take 10% (20 organ damage) brain damage.
	 * - 5u mannitol will heal 12.5% (25 organ damage) brain damage
	 */
/datum/quirk/item_quirk/brainproblems
	name = "Brain Tumor"
	desc = "Você tem um amiguinho no seu cérebro que está lentamente destruindo-o. Melhor trazer manitol!"
	icon = FA_ICON_BRAIN
	value = -12
	gain_text = span_danger("Você se sente suave.")
	lose_text = span_notice("Você se sente enrugado novamente.")
	medical_record_text = "O paciente tem um tumor no cérebro que os leva lentamente à morte cerebral."
	hardcore_value = 12
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_PROCESSES
	mail_goodies = list(/obj/item/storage/pill_bottle/mannitol/braintumor)
	no_process_traits = list(TRAIT_TUMOR_SUPPRESSED)

/datum/quirk/item_quirk/brainproblems/add_unique(client/client_source)
	give_item_to_holder(
		/obj/item/storage/pill_bottle/mannitol/braintumor,
		list(
			LOCATION_LPOCKET,
			LOCATION_RPOCKET,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
		),
		flavour_text = "Isso vai mantê-lo vivo até que consiga um suprimento de medicação. Não confie muito neles!",
		notify_player = TRUE,
	)

/datum/quirk/item_quirk/brainproblems/is_species_appropriate(datum/species/mob_species)
	if(ispath(mob_species, /datum/species/dullahan))
		return FALSE
	return ..()

/datum/quirk/item_quirk/brainproblems/process(seconds_per_tick)
	quirk_holder.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.2 * seconds_per_tick)
