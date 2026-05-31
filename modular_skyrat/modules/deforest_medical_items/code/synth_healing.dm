// Used to stop synth structural damage
/obj/item/stack/medical/wound_recovery/robofoam
	name = "robotic repair spray"
	singular_name = "Spray de reparo robótico"
	desc = "Uma pistola de espuma de ponta de agulha cheia de uma espuma sintética avançada que rapidamente preenche e estabiliza danos estruturais em sintéticos. A área danificada será vulnerável a danos adicionais enquanto a espuma endurece."
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/stack_items.dmi'
	icon_state = "robofoam"
	inhand_icon_state = "implantcase"
	applicable_wounds = list(
		/datum/wound/blunt/robotic,
	)
	max_amount = 2
	amount = 2
	merge_type = /obj/item/stack/medical/wound_recovery/robofoam
	treatment_sound = 'sound/effects/spray.ogg'
	causes_pain = FALSE

/obj/item/stack/medical/wound_recovery/robofoam/examine(mob/user)
	. = ..()
	. += span_notice("Isto.<b>Mais Barato.</b>A espuma só pode ser usada para encher<b>Estrutural</b>feridas em sintéticos.")
	return .

/obj/item/stack/medical/wound_recovery/robofoam/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/user)
	. = ..()
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/nanite_slurry, 5)
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/coagulant/fabricated, 5)

// Used to cure practically any synthetic wound
/obj/item/stack/medical/wound_recovery/robofoam_super
	name = "premium robotic repair spray"
	singular_name = "Spray de reparo robótico premium"
	desc = "Uma pistola de espuma de ponta de agulha cheia de uma espuma sintética avançada que rapidamente preenche e estabiliza danos estruturais em sintéticos. A área danificada será vulnerável a danos adicionais enquanto a espuma endurece. Este tipo especial de prêmio também pode ser usado para reparar quase qualquer tipo de dano sintético possível."
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/stack_items.dmi'
	icon_state = "robofoam_super"
	inhand_icon_state = "implantcase"
	applicable_wounds = list(
		/datum/wound/blunt/robotic,
		/datum/wound/muscle/robotic,
		/datum/wound/electrical_damage,
		/datum/wound/burn/robotic,
	)
	max_amount = 2
	amount = 2
	merge_type = /obj/item/stack/medical/wound_recovery/robofoam_super
	treatment_sound = 'sound/effects/spray.ogg'
	causes_pain = FALSE

/obj/item/stack/medical/wound_recovery/robofoam_super/examine(mob/user)
	. = ..()
	. += span_notice("Isso é mais.<b>Carol.</b>Espuma pode ser usada para encher<b>Qualquer</b>tipo de ferimento em sintéticos.")
	return .

/obj/item/stack/medical/wound_recovery/robofoam_super/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/user)
	. = ..()
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/coagulant/fabricated, 5)
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/nanite_slurry, 5)
	healed_mob.reagents.add_reagent(/datum/reagent/dinitrogen_plasmide, 5)

// Synth repair patch, gives the synth a small amount of healing chems
/obj/item/reagent_containers/applicator/pill/robotic_patch
	name = "robotic patch"
	desc = "Um adesivo químico para aplicações de toque em sintéticos."
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/stack_items.dmi'
	icon_state = "synth_patch"
	inhand_icon_state = null
	possible_transfer_amounts = list()
	volume = 40
	apply_method = "apply"
	self_delay = 3 SECONDS

/obj/item/reagent_containers/applicator/pill/robotic_patch/attack(mob/living/L, mob/user)
	if(ishuman(L))
		var/obj/item/bodypart/affecting = L.get_bodypart(check_zone(user.zone_selected))
		if(!affecting)
			to_chat(user, span_warning("O membro está faltando!"))
			return
		if(!IS_ROBOTIC_LIMB(affecting))
			to_chat(user, span_notice("Manchas robóticas não funcionam em um membro orgânico!"))
			return
	return ..()

/obj/item/reagent_containers/applicator/pill/robotic_patch/canconsume(mob/eater, mob/user)
	if(!iscarbon(eater))
		return FALSE
	return TRUE

// The actual patch
/obj/item/reagent_containers/applicator/pill/robotic_patch/synth_repair
	name = "robotic repair patch"
	desc = "Um remendo selado com um pequeno enxame de nanites junto com reagentes coagulantes elétricos para reparar pequenas quantidades de danos sintéticos."
	icon_state = "synth_patch"
	list_reagents = list(
		/datum/reagent/medicine/nanite_slurry = 10,
		/datum/reagent/dinitrogen_plasmide = 5,
		/datum/reagent/medicine/coagulant/fabricated = 10,
	)
