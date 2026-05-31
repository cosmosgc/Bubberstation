/datum/uplink_item/species_restricted/lycan_booster
	name = "Lycanthropy Booster"
	desc = "Uma mistura altamente avançada de nanomáquinas e vibes ruins gerais que aumentará significativamente o desempenho de combate de sua forma Lycan, concedendo resistência a danos significativos, resistência a bastão, regeneração, e afiando ainda mais suas garras. Além disso, lhe concede aptidão especializada."
	cost = 10
	item = /obj/item/lycan_booster
	restricted_species = list(SPECIES_CURSEKIN)
	surplus = 0

/obj/item/lycan_booster
	name = "lycanthropy booster"
	desc = "Uma mistura altamente avançada de nanomáquinas e vibrações ruins gerais que aumentarão significativamente o desempenho de combate de sua forma Lycan, concedendo resistência significativa a danos, resistência a bastão, regeneração, e afiando ainda mais suas garras, ao longo de outras melhorias. Além disso, lhe concede aptidão especializada."
	icon = 'icons/obj/medical/syringe.dmi'
	icon_state = "dnainjector"
	inhand_icon_state = "dnainjector"
	worn_icon_state = "pen"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_TINY

/obj/item/lycan_booster/attack_self(mob/user, modifiers)
	. = ..()

	if (!ishuman(user))
		return

	var/mob/living/carbon/human/human_user = user

	if (!istype(human_user.dna?.species, /datum/species/human/cursekin))
		to_chat(human_user, span_warning("Você tem a sensação de que sua fisiologia atual não apoiaria esse reforço."))
		return

	ADD_TRAIT(human_user, TRAIT_GAIAN_PHYSIQUE, SPECIES_TRAIT)

	balloon_alert(human_user, "Forma lycan impulsionada")
	to_chat(human_user, span_bolddanger("Quando se injeta o soro, começa a se sentir mais em sintonia com sua maldição lycan do que nunca. Suas garras afiam, seus dentes alongam..."))
	to_chat(human_user, span_boldnotice("Sua forma de lycan agora é resistente a danos, bastões e imune a danos. Além disso, seus ataques desarmados são muito mais mortíferos, e ridiculamente fortes em oponentes agarrados. Considere encontrar luvas de garras."))
	human_user.emote("growl")

	human_user.mind?.adjust_experience(/datum/skill/athletics, SKILL_EXP_MASTER, FALSE)

	qdel(src)
