
/datum/mutation/breathless
	name = "Breathless"
	desc = "Uma mutação na pele que permite filtrar e absorver oxigênio da pele."
	text_gain_indication = span_notice("Your lungs feel great.")
	text_lose_indication = span_warning("Your lungs feel normal again.")
	locked = TRUE

/datum/mutation/breathless/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	ADD_TRAIT(acquirer, TRAIT_NOBREATH, GENETIC_MUTATION)

/datum/mutation/breathless/on_losing(mob/living/carbon/human/owner)//this shouldnt happen under normal condition but just to be sure
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_NOBREATH, GENETIC_MUTATION)

/datum/mutation/quick
	name = "Quick"
	desc = "Uma mutação dentro dos músculos da perna que permite operar 20% a mais do que a capacidade habitual."
	text_gain_indication = span_notice("Your legs feel faster and stronger.")
	text_lose_indication = span_warning("Your legs feel weaker and slower.")
	locked = TRUE

/datum/mutation/quick/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	acquirer.add_movespeed_modifier(/datum/movespeed_modifier/dna_vault_speedup)

/datum/mutation/quick/on_losing(mob/living/carbon/human/owner)
	. = ..()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/dna_vault_speedup)

/datum/mutation/tough
	name = "Tough"
	desc = "Uma mutação dentro da epiderme que a torna mais resistente ao rasgo."
	text_gain_indication = span_notice("Your skin feels tougher.")
	text_lose_indication = span_warning("Your skin feels weaker.")
	locked = TRUE

/datum/mutation/tough/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	acquirer.physiology.brute_mod *= 0.7
	ADD_TRAIT(acquirer, TRAIT_PIERCEIMMUNE, GENETIC_MUTATION)

/datum/mutation/tough/on_losing(mob/living/carbon/human/owner)
	. = ..()
	owner.physiology.brute_mod /= 0.7
	REMOVE_TRAIT(owner, TRAIT_PIERCEIMMUNE, GENETIC_MUTATION)

/datum/mutation/dextrous
	name = "Dextrous"
	desc = "Uma mutação dentro do sistema nervoso que permite uma ação mais ágil e rápida."
	text_gain_indication = span_notice("Your limbs feel more dextrous and responsive.")
	text_lose_indication = span_warning("Your limbs feel less dextrous and responsive.")
	locked = TRUE

/datum/mutation/dextrous/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	acquirer.next_move_modifier *= 0.5

/datum/mutation/dextrous/on_losing(mob/living/carbon/human/owner)
	. = ..()
	owner.next_move_modifier /= 0.5

/datum/mutation/fire_immunity
	name = "Fire Immunity"
	desc = "Uma mutação dentro do corpo que permite que ele se torne não inflamável e suporte temperatura mais alta."
	text_gain_indication = span_notice("Your body feels like it can withstand fire.")
	text_lose_indication = span_warning("Your body feels vulnerable to fire again.")
	locked = TRUE

/datum/mutation/fire_immunity/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	acquirer.physiology.burn_mod *= 0.5
	acquirer.add_traits(list(TRAIT_RESISTHEAT, TRAIT_NOFIRE), GENETIC_MUTATION)

/datum/mutation/fire_immunity/on_losing(mob/living/carbon/human/owner)
	. = ..()
	owner.physiology.burn_mod /= 0.5
	owner.remove_traits(list(TRAIT_RESISTHEAT, TRAIT_NOFIRE), GENETIC_MUTATION)

/datum/mutation/quick_recovery
	name = "Quick Recovery"
	desc = "Uma mutação dentro do sistema nervoso que permite que ele se recupere de ser derrubado."
	text_gain_indication = span_notice("You feel like you can recover from a fall easier.")
	text_lose_indication = span_warning("You feel like recovering from a fall is a challenge again.")
	locked = TRUE

/datum/mutation/quick_recovery/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	acquirer.physiology.stun_mod *= 0.5

/datum/mutation/quick_recovery/on_losing(mob/living/carbon/human/owner)
	. = ..()
	owner.physiology.stun_mod /= 0.5

/datum/mutation/plasmocile
	name = "Plasmocile"
	desc = "Uma mutação nos pulmões que lhe dá imunidade à natureza tóxica do plasma."
	text_gain_indication = span_notice("Your lungs feel resistant to airborne contaminant.")
	text_lose_indication = span_warning("Your lungs feel vulnerable to airborne contaminant again.")
	locked = TRUE

/datum/mutation/plasmocile/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	var/obj/item/organ/lungs/improved_lungs = acquirer.get_organ_slot(ORGAN_SLOT_LUNGS)
	ADD_TRAIT(owner, TRAIT_VIRUSIMMUNE, GENETIC_MUTATION)
	if(improved_lungs)
		apply_buff(improved_lungs)
	RegisterSignal(acquirer, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(remove_modification))
	RegisterSignal(acquirer, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(reapply_modification))

/datum/mutation/plasmocile/on_losing(mob/living/carbon/human/owner)
	. = ..()
	var/obj/item/organ/lungs/improved_lungs = owner.get_organ_slot(ORGAN_SLOT_LUNGS)
	REMOVE_TRAIT(owner, TRAIT_VIRUSIMMUNE, GENETIC_MUTATION)
	UnregisterSignal(owner, COMSIG_CARBON_LOSE_ORGAN)
	UnregisterSignal(owner, COMSIG_CARBON_GAIN_ORGAN)
	if(improved_lungs)
		remove_buff(improved_lungs)

/datum/mutation/plasmocile/proc/remove_modification(mob/source, obj/item/organ/old_organ)
	SIGNAL_HANDLER

	if(istype(old_organ, /obj/item/organ/lungs))
		remove_buff(old_organ)

/datum/mutation/plasmocile/proc/reapply_modification(mob/source, obj/item/organ/new_organ)
	SIGNAL_HANDLER

	if(istype(new_organ, /obj/item/organ/lungs))
		apply_buff(new_organ)

/datum/mutation/plasmocile/proc/apply_buff(obj/item/organ/lungs/our_lungs)
	our_lungs.plas_breath_dam_min *= 0
	our_lungs.plas_breath_dam_max *= 0

/datum/mutation/plasmocile/proc/remove_buff(obj/item/organ/lungs/our_lungs)
	our_lungs.plas_breath_dam_min = initial(our_lungs.plas_breath_dam_min)
	our_lungs.plas_breath_dam_max = initial(our_lungs.plas_breath_dam_max)
