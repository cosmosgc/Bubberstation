/datum/mutation/tongue_spike
	name = "Tongue Spike"
	desc = "Permite que uma criatura atire na língua como uma arma mortal."
	quality = POSITIVE
	text_gain_indication = span_notice("Your feel like you can throw your voice.")
	instability = POSITIVE_INSTABILITY_MINI // worthless. also serves as a bit of a hint that it's not good
	power_path = /datum/action/cooldown/spell/tongue_spike

	energy_coeff = 1
	synchronizer_coeff = 1

/datum/action/cooldown/spell/tongue_spike
	name = "Launch spike"
	desc = "Atire na sua língua na direção que está enfrentando, incorporá-la e causar danos até removê-la."
	button_icon = 'icons/mob/actions/actions_genetic.dmi'
	button_icon_state = "spike"

	cooldown_time = 1 SECONDS
	spell_requirements = SPELL_REQUIRES_HUMAN

	/// The type-path to what projectile we spawn to throw at someone.
	var/spike_path = /obj/item/hardened_spike

/datum/action/cooldown/spell/tongue_spike/is_valid_target(atom/cast_on)
	return iscarbon(cast_on)

/datum/action/cooldown/spell/tongue_spike/cast(mob/living/carbon/cast_on)
	. = ..()
	if(HAS_TRAIT(cast_on, TRAIT_NODISMEMBER))
		to_chat(cast_on, span_notice("Você se concentra muito, mas nada acontece."))
		return

	var/obj/item/organ/tongue/to_fire = locate() in cast_on.organs
	if(!to_fire)
		to_chat(cast_on, span_notice("Você não tem língua para atirar!"))
		return

	to_fire.Remove(cast_on, special = TRUE)
	var/obj/item/hardened_spike/spike = new spike_path(get_turf(cast_on), cast_on)
	to_fire.forceMove(spike)
	spike.throw_at(get_edge_target_turf(cast_on, cast_on.dir), 14, 4, cast_on)

/obj/item/hardened_spike
	name = "biomass spike"
	desc = "Biomassa endurecida, moldada em um espigão. Muito pontudo!"
	icon = 'icons/obj/weapons/thrown.dmi'
	icon_state = "tonguespike"
	icon_angle = 45
	force = 2
	throwforce = 25
	throw_speed = 4
	embed_type = /datum/embedding/tongue_spike
	w_class = WEIGHT_CLASS_SMALL
	sharpness = SHARP_POINTY
	custom_materials = list(/datum/material/biomass = SMALL_MATERIAL_AMOUNT * 5)
	/// What mob "fired" our tongue
	var/datum/weakref/fired_by_ref
	/// if we missed our target
	var/missed = TRUE

/obj/item/hardened_spike/Initialize(mapload, mob/living/carbon/source)
	. = ..()
	src.fired_by_ref = WEAKREF(source)
	addtimer(CALLBACK(src, PROC_REF(check_morph)), 5 SECONDS)

/obj/item/hardened_spike/proc/check_morph()
	// Failed to embed, morph back
	if (!embed_data?.owner)
		morph_back()

/obj/item/hardened_spike/proc/morph_back()
	visible_message(span_warning("[src]rachaduras e torções, mudando de forma!"))
	for(var/obj/tongue as anything in contents)
		tongue.forceMove(get_turf(src))
	qdel(src)

/datum/embedding/tongue_spike
	impact_pain_mult = 0
	pain_mult = 15
	embed_chance = 100
	fall_chance = 0
	ignore_throwspeed_threshold = TRUE

/datum/embedding/tongue_spike/stop_embedding()
	. = ..()
	var/obj/item/hardened_spike/tongue_spike = parent
	if (!QDELETED(tongue_spike)) // This can cause a qdel loop
		tongue_spike.morph_back()

/datum/mutation/tongue_spike/chem
	name = "Chem Spike"
	desc = "Permite que uma criatura lance sua língua como biomassa, permitindo uma transferência de produtos químicos."
	quality = POSITIVE
	text_gain_indication = span_notice("Your feel like you can really connect with people by throwing your voice.")
	instability = POSITIVE_INSTABILITY_MINOR // slightly less worthless. slightly.
	locked = TRUE
	power_path = /datum/action/cooldown/spell/tongue_spike/chem
	energy_coeff = 1
	synchronizer_coeff = 1

/datum/action/cooldown/spell/tongue_spike/chem
	name = "Launch chem spike"
	desc = "Atire na sua língua na direção que está enfrentando, incorporando-a para uma pequena quantidade de danos. Enquanto a outra pessoa tem o espigão embutido, você pode transferir seus produtos químicos para eles."
	button_icon_state = "spikechem"

	spike_path = /obj/item/hardened_spike/chem

/obj/item/hardened_spike/chem
	name = "chem spike"
	desc = "Biomassa resistente, moldada em... Algo."
	icon_state = "tonguespikechem"
	throwforce = 2
	embed_type = /datum/embedding/tongue_spike/chem

/datum/embedding/tongue_spike/chem
	pain_mult = 0
	pain_chance = 0

/datum/embedding/tongue_spike/chem/on_successful_embed(mob/living/carbon/victim, obj/item/bodypart/target_limb)
	var/obj/item/hardened_spike/chem/tongue_spike = parent
	var/mob/living/carbon/fired_by = tongue_spike.fired_by_ref?.resolve()
	if(!istype(fired_by))
		return

	var/datum/action/send_chems/chem_action = new(tongue_spike)
	chem_action.transferred_ref = WEAKREF(victim)
	chem_action.Grant(fired_by)

	to_chat(fired_by, span_notice("Link estabelecido! Use o\"Transferência de Produtos Químicos\"capacidade de enviar seus produtos químicos para o alvo ligado!"))

/datum/embedding/tongue_spike/chem/stop_embedding()
	. = ..()
	var/obj/item/hardened_spike/chem/tongue_spike = parent
	var/mob/living/carbon/fired_by = tongue_spike.fired_by_ref?.resolve()
	if(!istype(fired_by))
		return

	to_chat(fired_by, span_warning("Link Perdido!"))
	var/datum/action/send_chems/chem_action = locate() in fired_by.actions
	qdel(chem_action)

/datum/action/send_chems
	name = "Transfer Chemicals"
	desc = "Envie todos os seus reagentes para quem quer que o espigão esteja embutido. Um uso."
	background_icon_state = "bg_spell"
	button_icon = 'icons/mob/actions/actions_genetic.dmi'
	button_icon_state = "spikechemswap"
	check_flags = AB_CHECK_CONSCIOUS

	/// Weakref to the mob target that we transfer chemicals to on activation
	var/datum/weakref/transferred_ref

/datum/action/send_chems/New(Target)
	. = ..()
	if(!istype(target, /obj/item/hardened_spike/chem))
		qdel(src)

/datum/action/send_chems/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	if(!ishuman(owner) || !owner.reagents)
		return FALSE
	var/mob/living/carbon/human/transferer = owner
	var/mob/living/carbon/human/transferred = transferred_ref?.resolve()
	if(!ishuman(transferred))
		return FALSE

	to_chat(transferred, span_warning("Você sente um pinto minúsculo!"))
	transferer.reagents.trans_to(transferred, transferer.reagents.total_volume, transferred_by = transferer)

	var/obj/item/hardened_spike/chem/chem_spike = target

	// This is where it would deal damage, if it transfers chems it removes itself so no damage
	var/mob/living/carbon/spike_owner = chem_spike.get_embed()?.owner
	// Message first because it'll shift back into a tongue right after moving
	if (istype(spike_owner))
		spike_owner.visible_message(span_notice("[chem_spike]Cai fora.[spike_owner]!"))
	chem_spike.forceMove(get_turf(chem_spike))
	return TRUE
