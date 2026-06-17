/datum/quirk/hydra
	name = "Hydra Heads"
	desc = "Você é uma criatura tri-cabeça. Para usar, formate o nome como"
	value = 0
	mob_trait = TRAIT_HYDRA_HEADS
	gain_text = span_notice("Você ouve duas outras vozes dentro da sua cabeça.")
	lose_text = span_danger("Todas as suas mentes se tornam singulares.")
	medical_record_text = "Há várias cabeças e personalidades afixadas em um corpo."
	icon = FA_ICON_HORSE_HEAD
	// remember what the name was before activation
	var/original_name

/datum/quirk/hydra/add(client/client_source)
	var/mob/living/carbon/human/hydra = quirk_holder
	var/datum/action/innate/hydra/spell = new(hydra)
	var/datum/action/innate/hydrareset/resetspell = new(hydra)
	spell.Grant(hydra)
	spell.owner = hydra
	resetspell.Grant(hydra)
	resetspell.owner = hydra

/datum/action/innate/hydra
	name = "Switch head"
	desc = "Troque entre cada uma das cabeças do seu corpo."
	button_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "art_summon"

/datum/action/innate/hydrareset
	name = "Reset Speech"
	desc = "Volte a falar como um todo."
	button_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "art_summon"

/datum/action/innate/hydrareset/Activate()
	var/mob/living/carbon/human/hydra = owner
	var/datum/quirk/hydra/hydra_quirk = hydra.get_quirk(/datum/quirk/hydra)
	if(!hydra_quirk.original_name) // sets the archived 'real' name if not set.
		hydra_quirk.original_name = hydra.real_name
	hydra.real_name = hydra_quirk.original_name
	hydra.visible_message(span_notice("[hydra.name] pushes all three heads forwards; they seem to be talking as a collective."), \
							span_notice("You are now talking as [hydra_quirk.original_name]!"), ignored_mobs=owner)

/datum/action/innate/hydra/Activate() //Oops, all hydra!
	var/mob/living/carbon/human/hydra = owner
	var/datum/quirk/hydra/hydra_quirk = hydra.get_quirk(/datum/quirk/hydra)
	if(!hydra_quirk.original_name) // sets the archived 'real' name if not set.
		hydra_quirk.original_name = hydra.real_name
	var/list/names = splittext(hydra_quirk.original_name,"-")
	var/selhead = input("Com quem gostaria de falar?","Heads:") in names
	hydra.real_name = selhead
	hydra.visible_message(span_notice("[hydra.name] pulls the rest of their heads back; and puts [selhead]'s forward."), \
							span_notice("You are now talking as [selhead]!"), ignored_mobs=owner)
