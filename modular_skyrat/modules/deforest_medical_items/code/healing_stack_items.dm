#define INSTANT_WOUND_HEAL_STAMINA_DAMAGE 80
#define INSTANT_WOUND_HEAL_LIMB_DAMAGE 25

/obj/item/stack/medical/wound_recovery
	name = "subdermal splint applicator"
	desc = "Um rolo de material flexível pontilhado com milhões de injetores de micro-escala de um lado. Em aplicação a uma parte do corpo com estrutura óssea danificada, nanomáquinas armazenadas dentro desses injetores cercarão a ferida e formarão uma tala subdérmica e auto-curativa. Embora conveniente para manter aparências e cura rápida, as nanomáquinas tendem a deixar seu hospedeiro particularmente vulnerável a novos danos por vários minutos após a aplicação."
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/stack_items.dmi'
	icon_state = "subsplint"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	inhand_icon_state = "sampler"
	gender = PLURAL
	singular_name = "Aplicador de tala subdérmica"
	self_delay = 10 SECONDS
	other_delay = 5 SECONDS
	novariants = TRUE
	max_amount = 3
	amount = 3
	merge_type = /obj/item/stack/medical/wound_recovery
	custom_price = PAYCHECK_COMMAND * 2.5
	/// If this checks for pain, used for synthetic repair foam
	var/causes_pain = TRUE
	/// The types of wounds that we work on, in list format
	var/list/applicable_wounds = list(
		/datum/wound/blunt/bone,
		/datum/wound/muscle,
	)
	/// The sound we play upon successfully treating the wound
	var/treatment_sound = 'sound/items/duct_tape/duct_tape_rip.ogg'

// Ported from Nova: \/
////// Searches for a wound that this item is capable of treating
/obj/item/stack/medical/wound_recovery/proc/find_suitable_wound(obj/item/bodypart/limb)
	for(var/datum/wound/wound as anything in limb.wounds)
		if((wound.wound_flags & ACCEPTS_GAUZE) && is_type_in_list(wound, applicable_wounds))
			return wound

/obj/item/stack/medical/add_item_context(obj/item/source, list/context, atom/target, mob/living/user)
	if(!iscarbon(target))
		return NONE
	context[SCREENTIP_CONTEXT_LMB] = "Heal"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/stack/medical/wound_recovery/try_heal_checks(mob/living/patient, mob/living/user, healed_zone, silent = FALSE)
	var/obj/item/bodypart/limb = patient.get_bodypart(healed_zone)
	if(isnull(limb))
		if(!silent)
			patient.balloon_alert(user, "Não.[parse_zone(healed_zone)]!")
		return FALSE
	if(!LAZYLEN(limb.wounds))
		if(!silent)
			patient.balloon_alert(user, "Sem fermentos!") // good problem to have imo
		return FALSE
	if(patient.has_status_effect(/datum/status_effect/vulnerable_to_damage))
		if(!silent)
			patient.balloon_alert(user, "Ainda se recuperando do último uso!")
		return FALSE
	if(!find_suitable_wound(limb))
		if(!silent)
			patient.balloon_alert(user, "Não posso curá-los!")
		return FALSE
	return TRUE

// This is only relevant for the types of wounds defined, we can't work if there are none
/obj/item/stack/medical/wound_recovery/try_heal(mob/living/patient, mob/user, silent = FALSE, looping = FALSE, auto_change_zone = TRUE, continuous = FALSE)

	var/treatment_delay = (user == patient ? self_delay : other_delay)

	var/obj/item/bodypart/limb = patient.get_bodypart(check_zone(user.zone_selected))

	var/datum/wound/woundies = find_suitable_wound(limb)
// Ported from Nova: ^

	if(HAS_TRAIT(woundies, TRAIT_WOUND_SCANNED))
		treatment_delay *= 0.5
		if(user == patient)
			to_chat(user, span_notice("Você tem em mente as indicações da holo-imagem sobre sua lesão, e habilmente começar a aplicar[src]."))
		else
			user.visible_message(span_warning("[user]Começa habilmente a tratar as feridas em[patient]'s[limb.plaintext_zone]Com[src]..."), span_warning("Você começa a tratar rapidamente as feridas[patient]'s[limb.plaintext_zone]Com[src], mantendo as indicações de holo-imagem em mente ..."))
	else
		user.visible_message(span_warning("[user]Começa a tratar as feridas.[patient]'s[limb.plaintext_zone]Com[src]..."), span_warning("Você começa a tratar as feridas em[user == patient ? "your" : "[patient]'s"] [limb.plaintext_zone]Com[src]..."))

	if(!do_after(user, treatment_delay, target = patient))
		return

	user.visible_message(span_green("[user]Aplicável[src]Para[patient]'s[limb.plaintext_zone]."), span_green("Você trata as feridas.[user == patient ? "your" : "[patient]'s"] [limb.plaintext_zone]."))
	playsound(patient, treatment_sound, 50, TRUE)
	woundies.remove_wound()
	if(!HAS_TRAIT(patient, TRAIT_ANALGESIA) || !causes_pain)
		patient.emote("scream")
		to_chat(patient, span_userdanger("Sua[limb.plaintext_zone]Queima como o inferno quando as feridas são rapidamente curadas, porra!"))
		patient.add_mood_event("severe_surgery", /datum/mood_event/rapid_wound_healing)
	limb.receive_damage(brute = INSTANT_WOUND_HEAL_LIMB_DAMAGE, wound_bonus = CANT_WOUND)
	patient.adjust_stamina_loss(INSTANT_WOUND_HEAL_STAMINA_DAMAGE)
	patient.apply_status_effect(/datum/status_effect/vulnerable_to_damage)
	use(1)

/datum/mood_event/rapid_wound_healing
	description = "A ferida se foi, mas a dor foi insuportável!\n"
	mood_change = -3
	timeout = 5 MINUTES

// Helps recover bleeding
/obj/item/stack/medical/wound_recovery/rapid_coagulant
	name = "rapid coagulant applicator"
	singular_name = "Aplicador de coagulante rápido"
	desc = "Um pequeno dispositivo cheio de um coagulante rápido de algum tipo. Quando usado em uma área de sangramento, quase instantaneamente parará todo o sangramento. Esta ação rápida de coagulação pode resultar em vulnerabilidade temporária a danos adicionais após a aplicação."
	icon_state = "clotter"
	inhand_icon_state = "implantcase"
	applicable_wounds = list(
		/datum/wound/slash/flesh,
		/datum/wound/pierce/bleed,
	)
	merge_type = /obj/item/stack/medical/wound_recovery/rapid_coagulant

/obj/item/stack/medical/wound_recovery/rapid_coagulant/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/user)
	. = ..()
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/coagulant/fabricated, 5)

// Helps recover burn wounds much faster, while not healing much damage directly
/obj/item/stack/medical/ointment/red_sun
	name = "red sun balm"
	singular_name = "Bálsamo de sol vermelho"
	desc = "Uma marca popular de pomada para lidar com qualquer coisa sob o sol vermelho, que tende a ser queimaduras terríveis. Que sol vermelho pode estar se referindo? Nem mesmo os produtores do bálsamo têm certeza."
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/stack_items.dmi'
	icon_state = "balm"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	inhand_icon_state = "bandage"
	gender = PLURAL
	novariants = TRUE
	amount = 12
	max_amount = 12
	self_delay = 4 SECONDS
	other_delay = 2 SECONDS
	heal_burn = 5
	heal_brute = 5
	flesh_regeneration = 5
	sanitization = 3
	merge_type = /obj/item/stack/medical/ointment/red_sun
	custom_price = PAYCHECK_LOWER * 1.5

/obj/item/stack/medical/ointment/red_sun/grind_results()
	return list(/datum/reagent/medicine/oxandrolone = 3)

/obj/item/stack/medical/ointment/red_sun/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/user)
	. = ..()
	healed_mob.reagents.add_reagent(/datum/reagent/medicine/lidocaine, 2)

// Gauze that are especially good at treating burns, but are terrible splints
/obj/item/stack/medical/wrap/gauze/sterilized
	name = "sealed aseptic gauze"
	singular_name = "gaze asséptica selada."
	desc = "Um pequeno rolo de material elástico especialmente tratado para ser totalmente estéril, e selado em plástico só para ter certeza. Estes são um excelente tratamento contra queimaduras, mas devido à sua pequena natureza são inferiores para servir como revestimento de ferida óssea."
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/stack_items.dmi'
	icon_state = "burndaid"
	inhand_icon_state = null
	novariants = TRUE
	max_amount = 6
	amount = 6
	splint_factor = 1.2
	burn_cleanliness_bonus = 0.1
	merge_type = /obj/item/stack/medical/wrap/gauze/sterilized
	custom_price = PAYCHECK_LOWER * 1.5

/obj/item/stack/medical/wrap/gauze/sterilized/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/user)
	. = ..()
	healed_mob.reagents.add_reagent(/datum/reagent/space_cleaner/sterilizine, 5)
	healed_mob.reagents.expose(healed_mob, TOUCH, 1)

// Works great at sealing bleed wounds, but does little to actually heal them
/obj/item/stack/medical/suture/coagulant
	name = "coagulant-F packet"
	singular_name = "Pacote F coagulante"
	desc = "Um pequeno pacote de coagulante fabricado para sangramento. Não tão eficaz quanto outros métodos de coagular feridas, mas é mais eficaz do que suturas simples. As desvantagens? Repara menos do dano real que está lá."
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/stack_items.dmi'
	icon_state = "clotter_slow"
	inhand_icon_state = null
	novariants = TRUE
	amount = 12
	max_amount = 12
	repeating = FALSE
	heal_brute = 0
	stop_bleeding = 2
	merge_type = /obj/item/stack/medical/suture/coagulant
	custom_price = PAYCHECK_LOWER * 1.5

#undef INSTANT_WOUND_HEAL_STAMINA_DAMAGE
#undef INSTANT_WOUND_HEAL_LIMB_DAMAGE
