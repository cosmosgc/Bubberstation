/obj/item/reagent_containers/hypospray
	name = "hypospray"
	desc = "A DeForest Medical Corporation hipospray é um autoinjetor estéril para administração rápida de drogas a pacientes."
	icon = 'icons/obj/medical/syringe.dmi'
	inhand_icon_state = "hypo"
	worn_icon_state = "hypo"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	icon_state = "hypo"
	amount_per_transfer_from_this = 5
	volume = 30
	possible_transfer_amounts = list(5)
	resistance_flags = ACID_PROOF
	initial_reagent_flags = OPENCONTAINER | NO_SPLASH
	slot_flags = ITEM_SLOT_BELT
	var/ignore_flags = NONE
	var/infinite = FALSE
	/// If TRUE, won't play a noise when injecting.
	var/stealthy = FALSE
	/// If TRUE, the hypospray will be permanently unusable.
	var/used_up = FALSE
	// BUBBER EDIT CHANGE: for pen_medipens, allows for medipens without the warning label
	var/no_sticker = FALSE

/obj/item/reagent_containers/hypospray/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/item/reagent_containers/hypospray/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return NONE
	return inject(interacting_with, user) ? ITEM_INTERACT_SUCCESS : ITEM_INTERACT_BLOCKING

/obj/item/reagent_containers/hypospray/interact_with_atom_secondary(atom/target, mob/living/user, list/modifiers)
	if (!target.reagents)
		return NONE

	if(isliving(target))
		to_chat(user, span_warning("[src] can't be used to draw blood!"))
		return ITEM_INTERACT_BLOCKING

	if(reagents.holder_full())
		to_chat(user, span_notice("[src] is full."))
		return ITEM_INTERACT_BLOCKING

	if(!target.reagents.total_volume)
		to_chat(user, span_warning("[target] is empty!"))
		return ITEM_INTERACT_BLOCKING

	if(!target.is_drawable(user))
		to_chat(user, span_warning("You cannot directly remove reagents from [target]!"))
		return ITEM_INTERACT_BLOCKING

	var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this, transferred_by = user)
	if(trans)
		to_chat(user, span_notice("You fill [src] with [trans] units of the solution. It now contains [reagents.total_volume] units."))
	return ITEM_INTERACT_SUCCESS

///Handles all injection checks, injection and logging.
/obj/item/reagent_containers/hypospray/proc/inject(mob/living/affected_mob, mob/user)
	if(used_up)
		to_chat(user, span_warning("[src] A ponta está quebrada e agora é inutilizável!"))
		return FALSE
	if(!iscarbon(affected_mob))
		return FALSE

	//Always log attemped injects for admins
	var/list/injected = list()
	for(var/datum/reagent/injected_reagent in reagents.reagent_list)
		injected += injected_reagent.name
	var/contained = english_list(injected)
	log_combat(user, affected_mob, "attempted to inject", src, "([contained])")
	user.changeNext_move(CLICK_CD_MELEE)

	if(!used_up && (ignore_flags || affected_mob.try_inject(user, injection_flags = INJECT_TRY_SHOW_ERROR_MESSAGE))) // Ignore flag should be checked first or there will be an error message.
		to_chat(affected_mob, span_warning("Você sente um pinto minúsculo!"))
		to_chat(user, span_notice("Você injeta.[affected_mob] com [src]."))
		if(!stealthy)
			playsound(affected_mob, 'sound/items/hypospray.ogg', 50, TRUE)
		var/fraction = min(amount_per_transfer_from_this/reagents.total_volume, 1)


		if(affected_mob.reagents)
			var/trans = 0
			if(!infinite)
				trans = reagents.trans_to(affected_mob, amount_per_transfer_from_this, transferred_by = user, methods = INJECT)
			else
				reagents.expose(affected_mob, INJECT, fraction)
				trans = reagents.trans_to(affected_mob, amount_per_transfer_from_this, methods = INJECT, copy_only = TRUE)
			to_chat(user, span_notice("[trans] Unidade injetada.[reagents.total_volume] Unidade permanecendo em [src]."))
			log_combat(user, affected_mob, "injected", src, "([contained])")
		return TRUE
	return FALSE


/obj/item/reagent_containers/hypospray/cmo
	volume = 60
	possible_transfer_amounts = list(1,3,5)
	list_reagents = list(/datum/reagent/medicine/omnizine = 30)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

//combat

/obj/item/reagent_containers/hypospray/combat
	name = "combat stimulant injector"
	desc = "Um autoinjetor de agulha de ar modificado, usado por agentes de apoio para curar lesões em combate."
	amount_per_transfer_from_this = 10
	inhand_icon_state = "combat_hypo"
	icon_state = "combat_hypo"
	volume = 90
	possible_transfer_amounts = list(5,10)
	ignore_flags = 1 // So they can heal their comrades.
	list_reagents = list(/datum/reagent/medicine/epinephrine = 30, /datum/reagent/medicine/omnizine = 30, /datum/reagent/medicine/leporazine = 15, /datum/reagent/medicine/atropine = 15)

/obj/item/reagent_containers/hypospray/combat/empty
	list_reagents = null

/obj/item/reagent_containers/hypospray/combat/nanites
	name = "experimental combat stimulant injector"
	desc = "Um autoinjetor de agulha de ar modificado para uso em situações de combate. Preenchido com nanites médicos experimentais e um estimulante para uma cura rápida e um impulso de combate."
	inhand_icon_state = "nanite_hypo"
	icon_state = "nanite_hypo"
	base_icon_state = "nanite_hypo"
	volume = 100
	list_reagents = list(/datum/reagent/medicine/adminordrazine/quantum_heal = 80, /datum/reagent/medicine/synaptizine = 20)

/obj/item/reagent_containers/hypospray/combat/nanites/update_icon_state()
	icon_state = "[base_icon_state][(reagents.total_volume > 0) ? null : 0]"
	return ..()

/obj/item/reagent_containers/hypospray/combat/heresypurge
	name = "holy water piercing injector"
	desc = "Um autoinjetor de agulha de ar modificado para uso em situações de combate. Preenchido com 5 doses de água benta e mistura de chupeta. Não para usar em seus companheiros de equipe."
	inhand_icon_state = "holy_hypo"
	icon_state = "holy_hypo"
	volume = 250
	possible_transfer_amounts = list(25,50)
	list_reagents = list(/datum/reagent/water/holywater = 150, /datum/reagent/peaceborg/tire = 50, /datum/reagent/peaceborg/confuse = 50)
	amount_per_transfer_from_this = 50

//MediPens

/obj/item/reagent_containers/hypospray/medipen
	name = "epinephrine medipen"
	desc = "Uma maneira rápida e segura de estabilizar pacientes em estado crítico para pessoal sem conhecimento médico avançado. Contém um poderoso conservante que pode atrasar a decomposição quando aplicado a um corpo morto, e parar a produção de histamina durante uma reação alérgica."
	icon_state = "medipen"
	inhand_icon_state = "medipen"
	worn_icon_state = "medipen"
	base_icon_state = "medipen"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	amount_per_transfer_from_this = 15
	has_variable_transfer_amount = FALSE
	volume = 15
	ignore_flags = 1 //so you can medipen through spacesuits
	initial_reagent_flags = NONE
	flags_1 = null
	list_reagents = list(/datum/reagent/medicine/epinephrine = 10, /datum/reagent/toxin/formaldehyde = 3, /datum/reagent/medicine/coagulant = 2)
	custom_price = PAYCHECK_CREW
	custom_premium_price = PAYCHECK_COMMAND
	var/label_examine = TRUE
	var/label_text

/obj/item/reagent_containers/hypospray/medipen/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user] Começa a engasgar-se.\the [src]! Parece que...[user.p_theyre()] Tentando cometer suicídio!"))
	return OXYLOSS//ironic. he could save others from oxyloss, but not himself.

/obj/item/reagent_containers/hypospray/medipen/inject(mob/living/affected_mob, mob/user)
	. = ..()
	if(. && !reagents.total_volume)
		used_up = TRUE //Makes them useless afterwards
		reagents.flags = NONE
		update_appearance()

/obj/item/reagent_containers/hypospray/medipen/attack_self(mob/user)
	if(user.can_perform_action(src, FORBID_TELEKINESIS_REACH|ALLOW_RESTING))
		inject(user, user)

/obj/item/reagent_containers/hypospray/medipen/update_icon_state()
	icon_state = "[base_icon_state][(reagents.total_volume > 0) ? null : 0]"
	return ..()

/obj/item/reagent_containers/hypospray/medipen/Initialize(mapload)
	. = ..()
	if(!no_sticker) // BUBBER EDIT CHANGE: for pen_medipens, allows for medipens without the warning label
		label_text = span_notice("Há um adesivo colado no lado que diz:[pretty_string_from_reagent_list(reagents.reagent_list, names_only = TRUE, join_text = ", ", final_and = TRUE, capitalize_names = TRUE)], não usar se alérgico a qualquer produto químico listado.")

/obj/item/reagent_containers/hypospray/medipen/examine()
	. = ..()
	if (label_examine)
		. += label_text
	if(length(reagents?.reagent_list))
		. += span_notice("Está carregada.")
	else
		. += span_notice("Está gasto.")

/obj/item/reagent_containers/hypospray/medipen/stimpack //goliath kiting
	name = "stimpack medipen"
	desc = "Uma maneira rápida de estimular a adrenalina do seu corpo, permitindo um movimento mais livre em armadura restritiva."
	icon_state = "stimpen"
	inhand_icon_state = "stimpen"
	base_icon_state = "stimpen"
	volume = 20
	amount_per_transfer_from_this = 20
	list_reagents = list(/datum/reagent/medicine/ephedrine = 10, /datum/reagent/consumable/coffee = 10)

/obj/item/reagent_containers/hypospray/medipen/stimpack/traitor
	desc = "Um autoinjetor de estimulantes modificado para uso em situações de combate. Tem um leve efeito cicatrizante."
	list_reagents = list(/datum/reagent/medicine/stimulants = 10, /datum/reagent/medicine/omnizine = 10)
	volume = 20

/obj/item/reagent_containers/hypospray/medipen/stimulants
	name = "stimulant medipen"
	desc = "Contém uma quantidade muito grande de um estimulante incrivelmente poderoso, aumentando imensamente sua velocidade de movimento e reduzindo os atordoamentos em uma quantidade muito grande por cerca de cinco minutos. Não tome se estiver grávida."
	icon_state = "syndipen"
	inhand_icon_state = "tbpen"
	base_icon_state = "syndipen"
	volume = 50
	amount_per_transfer_from_this = 50
	list_reagents = list(/datum/reagent/medicine/stimulants = 50)

/obj/item/reagent_containers/hypospray/medipen/methamphetamine
	name = "methamphetamine medipen"
	volume = 24
	amount_per_transfer_from_this = 24
	desc = "Contém uma quantidade relativamente segura de metanfetamina, juntamente com manitol para garantir que os danos cerebrais sejam mantidos no mínimo."
	list_reagents = list(/datum/reagent/drug/methamphetamine = 10, /datum/reagent/medicine/mannitol = 14)

/obj/item/reagent_containers/hypospray/medipen/morphine
	name = "morphine medipen"
	desc = "Uma maneira rápida de tirá-lo de uma situação apertada e rápido! Mas vai se sentir sonolento."
	icon_state = "morphen"
	inhand_icon_state = "morphen"
	base_icon_state = "morphen"
	list_reagents = list(/datum/reagent/medicine/morphine = 10)
	volume = 10

/obj/item/reagent_containers/hypospray/medipen/oxandrolone
	name = "oxandrolone medipen"
	desc = "Um autoinjector contendo oxandrolona, usado para tratar queimaduras graves."
	icon_state = "oxapen"
	inhand_icon_state = "oxapen"
	base_icon_state = "oxapen"
	list_reagents = list(/datum/reagent/medicine/oxandrolone = 10)
	volume = 10

/obj/item/reagent_containers/hypospray/medipen/penacid
	name = "pentetic acid medipen"
	desc = "Um autoinjector contendo ácido pentético, usado para reduzir altos níveis de radiação e toxinas moderadas."
	icon_state = "penacid"
	inhand_icon_state = "penacid"
	base_icon_state = "penacid"
	list_reagents = list(/datum/reagent/medicine/pen_acid = 10)
	volume = 10

/obj/item/reagent_containers/hypospray/medipen/salacid
	name = "salicylic acid medipen"
	desc = "Um autoinjector contendo ácido salicílico, usado para tratar danos graves."
	icon_state = "salacid"
	inhand_icon_state = "salacid"
	base_icon_state = "salacid"
	list_reagents = list(/datum/reagent/medicine/sal_acid = 10)
	volume = 10

/obj/item/reagent_containers/hypospray/medipen/salbutamol
	name = "salbutamol medipen"
	desc = "Um autoinjector contendo salbutamol, usado para curar danos de oxigênio rapidamente."
	icon_state = "salpen"
	inhand_icon_state = "salpen"
	base_icon_state = "salpen"
	list_reagents = list(/datum/reagent/medicine/salbutamol = 10)
	volume = 10

/obj/item/reagent_containers/hypospray/medipen/tuberculosiscure
	name = "BVAK autoinjector"
	desc = "Auto-injetor do Bio Virus Antidote Kit. Tem um sistema de dois usos para você e outra pessoa. Injete quando estiver infectado."
	icon_state = "tbpen"
	inhand_icon_state = "tbpen"
	base_icon_state = "tbpen"
	volume = 20
	amount_per_transfer_from_this = 10
	list_reagents = list(/datum/reagent/vaccine/fungal_tb = 20)

/obj/item/reagent_containers/hypospray/medipen/tuberculosiscure/update_icon_state()
	. = ..()
	if(reagents.total_volume >= volume)
		icon_state = base_icon_state
		return
	icon_state = "[base_icon_state][(reagents.total_volume > 0) ? 1 : 0]"

/obj/item/reagent_containers/hypospray/medipen/survival
	name = "survival emergency medipen"
	desc = "Um remédio para sobreviver nos ambientes severos, cura as fontes de danos mais comuns. Pode causar danos nos órgãos."
	icon_state = "stimpen"
	inhand_icon_state = "stimpen"
	base_icon_state = "stimpen"
	volume = 30
	amount_per_transfer_from_this = 30
	list_reagents = list( /datum/reagent/medicine/epinephrine = 8, /datum/reagent/medicine/c2/aiuri = 8, /datum/reagent/medicine/c2/libital = 8, /datum/reagent/medicine/leporazine = 6)

/obj/item/reagent_containers/hypospray/medipen/survival/inject(mob/living/affected_mob, mob/user)
	if(lavaland_equipment_pressure_check(get_turf(user)))
		amount_per_transfer_from_this = initial(amount_per_transfer_from_this)
		return ..()

	if(DOING_INTERACTION(user, DOAFTER_SOURCE_SURVIVALPEN))
		to_chat(user,span_notice("Você está muito ocupado para usar\the [src]!"))
		return

	to_chat(user,span_notice("Você começa a liberar manualmente o medidor de baixa pressão..."))
	if(!do_after(user, 10 SECONDS, affected_mob, interaction_key = DOAFTER_SOURCE_SURVIVALPEN))
		return

	amount_per_transfer_from_this = initial(amount_per_transfer_from_this) * 0.5
	return ..()


/obj/item/reagent_containers/hypospray/medipen/survival/luxury
	name = "luxury medipen"
	desc = "Tecnologia do espaço azul de ponta permitiu que Nanotrasen compactasse 60u de volume em um único medipen. Contém químicos raros e poderosos usados para ajudar na exploração de ambientes muito difíceis. Aviso: não misture com epinefrina ou atropina."
	icon_state = "luxpen"
	inhand_icon_state = "atropen"
	base_icon_state = "luxpen"
	volume = 60
	amount_per_transfer_from_this = 60
	list_reagents = list(/datum/reagent/medicine/salbutamol = 10, /datum/reagent/medicine/c2/penthrite = 10, /datum/reagent/medicine/oxandrolone = 10, /datum/reagent/medicine/sal_acid = 10 ,/datum/reagent/medicine/omnizine = 10 ,/datum/reagent/medicine/leporazine = 10)

/obj/item/reagent_containers/hypospray/medipen/atropine
	name = "atropine autoinjector"
	desc = "Uma maneira rápida de salvar uma pessoa de um estado crítico de lesão! Além disso, contém um poderoso coagulante para evitar perda de sangue."
	icon_state = "atropen"
	inhand_icon_state = "atropen"
	base_icon_state = "atropen"
	list_reagents = list(/datum/reagent/medicine/atropine = 10, /datum/reagent/medicine/coagulant = 2)
	volume = 12

/obj/item/reagent_containers/hypospray/medipen/snail
	name = "snail shot"
	desc = "Medicina para caracol! Não use em nada!"
	icon_state = "snail"
	inhand_icon_state = "snail"
	base_icon_state = "snail"
	list_reagents = list(/datum/reagent/snail = 10)
	label_examine = FALSE
	volume = 10

/obj/item/reagent_containers/hypospray/medipen/magillitis
	name = "experimental autoinjector"
	desc = "Um injetor de agulha personalizado com um pequeno reservatório de uso único, contendo um soro experimental. Ao contrário do quadro mais comum de medipen, ele não pode perfurar através de armadura protetora ou trajes espaciais, nem o químico dentro pode ser extraído."
	icon_state = "gorillapen"
	inhand_icon_state = "gorillapen"
	base_icon_state = "gorillapen"
	volume = 5
	ignore_flags = 0
	list_reagents = list(/datum/reagent/magillitis = 5)

/obj/item/reagent_containers/hypospray/medipen/pumpup
	name = "maintenance pump-up"
	desc = "Um auto-injetor do gueto cheio de adrenalina barata... Ótimo para dar de ombros os efeitos dos choques."
	volume = 15
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/drug/pumpup = 15)
	icon_state = "maintenance"
	base_icon_state = "maintenance"
	label_examine = FALSE

/obj/item/reagent_containers/hypospray/medipen/ekit
	name = "emergency first-aid autoinjector"
	desc = "Um remédio de epinefrina com coagulante extra e antibióticos para ajudar a estabilizar cortes ruins e queimaduras."
	icon_state = "firstaid"
	base_icon_state = "firstaid"
	volume = 15
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/medicine/epinephrine = 12, /datum/reagent/medicine/coagulant = 2.5, /datum/reagent/medicine/spaceacillin = 0.5)

/obj/item/reagent_containers/hypospray/medipen/blood_loss
	name = "hypovolemic-response autoinjector"
	desc = "Um remédio projetado para estabilizar e reverter rapidamente severa perda de sangue."
	icon_state = "hypovolemic"
	base_icon_state = "hypovolemic"
	volume = 15
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/medicine/epinephrine = 5, /datum/reagent/medicine/coagulant = 2.5, /datum/reagent/iron = 3.5, /datum/reagent/medicine/salglu_solution = 4)

/obj/item/reagent_containers/hypospray/medipen/mutadone
	name = "mutadone autoinjector"
	desc = "Um medipen mutadona para ajudar na cura de erros genéticos em um único injetor."
	icon_state = "penacid"
	inhand_icon_state = "penacid"
	base_icon_state = "penacid"
	volume = 15
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/medicine/mutadone = 15)

/obj/item/reagent_containers/hypospray/medipen/penthrite
	name = "penthrite autoinjector"
	desc = "Remédio experimental para o coração."
	icon_state = "atropen"
	inhand_icon_state = "atropen"
	base_icon_state = "atropen"
	list_reagents = list(/datum/reagent/medicine/c2/penthrite = 10)
	volume = 10
