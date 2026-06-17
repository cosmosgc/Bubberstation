#define BEAST_FORM_EXPOSITION_LINK "beast_form_exposition_link"

/datum/status_effect/beast_form
	id = "lycan_beast_form"
	alert_type = null // TODO - maybe add an alert??
	var/datum/species/initial_species

/datum/status_effect/beast_form/on_apply()
	. = ..()
	if (!.)
		return FALSE

	var/mob/living/carbon/human_owner = owner
	if (!istype(human_owner))
		return FALSE

	var/obj/item/organ/brain/lycan/lycan_brain = human_owner.get_organ_by_type(/obj/item/organ/brain/lycan)
	if (!istype(lycan_brain))
		return FALSE

	initial_species = human_owner.dna.species

	var/datum/species/human/cursekin/current_wolf = human_owner.dna.species
	if(!istype(current_wolf))
		return FALSE

	human_owner.visible_message(span_warning("[human_owner] turns [human_owner.p_their()] head to the sky and howls, rapidly growing and transforming into a horrible beast!"))

	var/client/target_client = human_owner.client
	if (!isnull(target_client))
		var/name = human_owner.real_name
		var/slot = target_client.prefs.read_preference(/datum/preference/numeric/cursekin_char_slot)
		var/transfer = TRUE
		if (isnull(lycan_brain.last_slot))
			lycan_brain.last_slot = target_client.prefs.savefile.get_entry("default_slot")
		target_client.prefs.load_character(slot)
		if (!ispath(target_client.prefs.read_preference(/datum.preference/choiced/species), current_wolf.lycanthropy_species))
			to_chat(human_owner, span_warning("Seu espaço escolhido não é um lycan! Presumindo simplesmente mudar sua espécie..."))
			target_client.prefs.load_character(lycan_brain.last_slot)
			human_owner.set_species(current_wolf.lycanthropy_species, TRUE, TRUE, FALSE)
			lycan_brain.last_slot = null // allows for easier switching in later procs
			transfer = FALSE

		if (transfer)
			target_client.prefs.safe_transfer_prefs_to_with_damage(human_owner)
			human_owner.real_name = name
			human_owner.name = name
			SSquirks.OverrideQuirks(human_owner, target_client, spawn_items = FALSE)
			human_owner.dna.update_dna_identity()

			target_client.prefs.load_character(lycan_brain.last_slot)

	ADD_TRAIT(human_owner, TRAIT_BEAST_FORM, SPECIES_TRAIT)
	playsound(human_owner, 'modular_zubbers/code/modules/customization/species/lycans/transform.ogg', 50)

/datum/status_effect/beast_form/on_remove()
	. = ..()

	var/mob/living/carbon/human_owner = owner
	if (!istype(human_owner))
		return

	var/obj/item/organ/brain/lycan/lycan_brain = human_owner.get_organ_by_type(/obj/item/organ/brain/lycan)
	if (!istype(lycan_brain))
		return

	human_owner.visible_message(span_warning("[human_owner] shrinks down, their fur receding!"))

	if (lycan_brain.last_slot)
		var/client/target_client = human_owner.client
		if (isnull(target_client))
			human_owner.set_species(initial_species, TRUE, TRUE, FALSE)
		else
			target_client.prefs.load_character(lycan_brain.last_slot)
			target_client.prefs.safe_transfer_prefs_to_with_damage(human_owner)
			SSquirks.OverrideQuirks(human_owner, target_client, spawn_items = FALSE)
			human_owner.dna.update_dna_identity()
	else
		human_owner.set_species(initial_species, TRUE, TRUE, FALSE)

	REMOVE_TRAIT(human_owner, TRAIT_BEAST_FORM, SPECIES_TRAIT)
	playsound(human_owner, 'modular_zubbers/code/modules/customization/species/lycans/transform.ogg', 50)

/datum/status_effect/beast_form/tick(seconds_between_ticks)
	. = ..()

	var/mob/living/carbon/human_owner = owner
	if (!istype(human_owner))
		qdel(src)
		return

	if (human_owner.stat >= HARD_CRIT || human_owner.dna.species.id != SPECIES_LYCAN)
		qdel(src)
		return

/datum/status_effect/beast_form/get_examine_text()
	return span_notice("The NT employee manual has a entry on this species... <a href='byond://?src=[REF(src)];[BEAST_FORM_EXPOSITION_LINK]=1'>Recall what you read?</a>")

/datum/status_effect/beast_form/Topic(href, list/href_list)
	. = ..()

	if (href_list[BEAST_FORM_EXPOSITION_LINK])
		print_exposition(usr)

/datum/status_effect/beast_form/proc/print_exposition(mob/user)
	var/list/render_list = list()

	render_list += "Legends of lycanthropy and animalistic shapeshifters have always existed, but were not confirmed until a century ago when the Cursekin species was \
	officially recognized by most polities across the orion arm. The origin for their curse may vary by Cursekin - some from a god, some from genetics - but each \
	has the ability to transform into a terrifying beast with claws like razors."
	render_list += "<hr>"
	render_list += span_notice("Lycans e parentes podem vir em várias formas, mas cada um tem semelhanças em como funcionam.")
	render_list += span_notice("\nLycans possess [EXAMINE_HINT("exceptionally strong claws")], about as strong as a [EXAMINE_HINT("circular saw")] without the armor penetration.")
	render_list += span_notice("\nLycans also have [EXAMINE_HINT("significant damage resistance")] to brute, and to a lesser extent, burn.")
	render_list += span_notice("\nHowever, Lycans [EXAMINE_HINT("cannot wear any clothes")] and cannot have synthetic organs.")
	render_list += span_notice("\nAdditionally, each Lycan possesses a [EXAMINE_HINT("marked weakness to silver")], taking [EXAMINE_HINT("increased damage")] from weapons comprised of it.")
	render_list += span_notice("\nFinally, Lycans [EXAMINE_HINT("cannot use batons")] nor [EXAMINE_HINT("most firearms")] due to the size of their fingers.")
	render_list += span_notice("\nThe Lycan form can be [EXAMINE_HINT("toggled at will")], or [EXAMINE_HINT("forcefully removed")] by [EXAMINE_HINT("knocking them into hard-crit")].")
	render_list += "<hr>"
	render_list += span_warning("While mostly docile, tamed, and relatively weak, it is rumored that some Lycans harbor a [EXAMINE_HINT("exceptionally capable")] form of the curse. Keep an eye out for any of the following:")
	render_list += span_warning("\nGarras extremamente poderosas")
	render_list += span_warning("\nRegeneração agressiva da saúde")
	render_list += span_warning("\nImunidade aos empurrões e resistência à dor/estume")
	render_list += span_warning("\n* A habilidade de dar de ombros qualquer quantidade de dor e continuar correndo")
	render_list += span_warning("\n* A capacidade de quebrar comportas e janelas com suas garras")
	render_list += span_boldwarning("\nSe você se encontrar enfrentando um Lycan com essas características, tome essas precauções.")
	render_list += span_warning("\n* Evite armas físicas e armas de resistência - sua regeneração cura rapidamente o ralo bruto e a resistência")
	render_list += span_warning("\nUsem armas prateadas.")
	render_list += span_warning("\n* Use prata aerossol - eles não podem usar internos e vão queimar em contato com ele")
	render_list += span_warning("\n* Pacifique o lycan - eles não podem quebrar janelas ou câmaras de ar enquanto pacificado")

	var/output = jointext(render_list, "")

	to_chat(user, custom_boxed_message("blue_box", output), trailing_newline = FALSE, type = MESSAGE_TYPE_INFO)

#undef BEAST_FORM_EXPOSITION_LINK
