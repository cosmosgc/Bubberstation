// Pen basetype where the icon is gotten from
/obj/item/reagent_containers/hypospray/medipen/deforest
	name = "non-functional Deforest autoinjector"
	desc = "Um autoinjetor de Deforest marcado, embora este pareça vazio e não funcional."
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/injectors.dmi'
	icon_state = "default"
	volume = 25
	list_reagents = list()
	custom_price = PAYCHECK_COMMAND
	/// If this pen has a timer for injecting others with, just for safety with some of the drugs in these
	var/inject_others_time = 1.5 SECONDS

/obj/item/reagent_containers/hypospray/medipen/deforest/Initialize(mapload)
	. = ..()
	amount_per_transfer_from_this = volume

/obj/item/reagent_containers/hypospray/medipen/deforest/inject(mob/living/affected_mob, mob/user)
	if(!reagents.total_volume)
		to_chat(user, span_warning("[src]Está vazio!"))
		return FALSE
	if(!iscarbon(affected_mob))
		return FALSE

	//Always log attemped injects for admins
	var/list/injected = list()
	for(var/datum/reagent/injected_reagent in reagents.reagent_list)
		injected += injected_reagent.name
	var/contained = english_list(injected)
	log_combat(user, affected_mob, "attempted to inject", src, "([contained])")

	if((affected_mob != user) && inject_others_time)
		affected_mob.visible_message(span_danger("[user]Está tentando injetar.[affected_mob]!"), 				span_userdanger("[user]Está tentando injetar algo em você!"))
		if(!do_after(user, CHEM_INTERACT_DELAY(inject_others_time, user), affected_mob))
			return FALSE

	if(reagents.total_volume && (ignore_flags || affected_mob.try_inject(user, injection_flags = INJECT_TRY_SHOW_ERROR_MESSAGE))) // Ignore flag should be checked first or there will be an error message.
		to_chat(affected_mob, span_warning("Você sente um pinto minúsculo!"))
		to_chat(user, span_notice("Você injeta.[affected_mob]Com[src]."))
		if(!stealthy)
			playsound(affected_mob, 'sound/items/hypospray.ogg', 50, TRUE)
		var/fraction = min(amount_per_transfer_from_this/reagents.total_volume, 1)

		if(affected_mob.reagents)
			var/trans = 0
			if(!infinite)
				trans = reagents.trans_to(affected_mob, amount_per_transfer_from_this, transferred_by = user, methods = INJECT)
			else
				reagents.expose(affected_mob, INJECT, fraction)
				trans = reagents.trans_to(affected_mob, amount_per_transfer_from_this, copy_only = TRUE)
			to_chat(user, span_notice("[trans]Unidade injetada.[reagents.total_volume]Unidade permanente em[src]."))
			log_combat(user, affected_mob, "injected", src, "([contained])")
		return TRUE
	return FALSE

// Sensory restoration, heals eyes and ears with a bit of impurity
/obj/item/reagent_containers/hypospray/medipen/deforest/occuisate
	name = "occuisate sensory restoration injector"
	desc = "Um autoinjetor de marca Deforest, carregado com uma mistura de reagentes para restaurar sua visão e audição."
	base_icon_state = "occuisate"
	icon_state = "occuisate"
	list_reagents = list(
		/datum/reagent/medicine/inacusiate = 7,
		/datum/reagent/medicine/oculine = 7,
		/datum/reagent/impurity/inacusiate = 3,
		/datum/reagent/inverse/oculine = 3,
		/datum/reagent/toxin/lipolicide = 5,
	)

// Adrenaline, fills you with determination (and also stimulants)
/obj/item/reagent_containers/hypospray/medipen/deforest/adrenaline
	name = "adrenaline injector"
	desc = "Um autoinjetor de marca Deforest, carregado com uma mistura de reagentes para se dar intencionalmente luta ou fuga sob demanda."
	base_icon_state = "adrenaline"
	icon_state = "adrenaline"
	list_reagents = list(
		/datum/reagent/medicine/synaptizine = 5,
		/datum/reagent/medicine/inaprovaline = 5,
		/datum/reagent/determination = 10,
		/datum/reagent/toxin/histamine = 5,
	)

// Morpital, heals a small amount of damage and kills pain for a bit
/obj/item/reagent_containers/hypospray/medipen/deforest/morpital
	name = "morpital regenerative stimulant injector"
	desc = "Um autoinjetor de marca Deforest, carregado com uma mistura de reagentes para dormência e reparação de pequenas quantidades de danos físicos."
	base_icon_state = "morpital"
	icon_state = "morpital"
	list_reagents = list(
		/datum/reagent/medicine/morphine = 5,
		/datum/reagent/medicine/omnizine/protozine = 15,
		/datum/reagent/toxin/staminatoxin = 5,
	)

// Lipital, heals more damage than morpital but doesnt work much at higher damages
/obj/item/reagent_containers/hypospray/medipen/deforest/lipital
	name = "lipital regenerative stimulant injector"
	desc = "Um autoinjetor de marca Deforest, carregado com uma mistura de reagentes para dormência e reparação de pequenas quantidades de danos físicos. Funciona de forma mais eficaz contra danos causados por ataques brutais."
	base_icon_state = "lipital"
	icon_state = "lipital"
	list_reagents = list(
		/datum/reagent/medicine/lidocaine = 5,
		/datum/reagent/medicine/omnizine = 5,
		/datum/reagent/medicine/c2/probital = 10,
	)

// Anti-poisoning injector, with a little bit of radiation healing as a treat
/obj/item/reagent_containers/hypospray/medipen/deforest/meridine
	name = "meridine antidote injector"
	desc = "Um autoinjetor de marca Deforest, carregado com uma mistura de reagentes para servir como antídoto para a maioria das toxinas galácticas. Um adesivo avisa que não deve ser usado se o paciente estiver fisicamente danificado, pois pode causar complicações."
	base_icon_state = "meridine"
	icon_state = "meridine"
	list_reagents = list(
		/datum/reagent/medicine/ammoniated_mercury = 9,
		/datum/reagent/medicine/potass_iodide = 10,
		/datum/reagent/nitrous_oxide = 5,
	)

// Epinephrine and helps a little bit against stuns and stamina damage
/obj/item/reagent_containers/hypospray/medipen/deforest/synephrine
	name = "synephrine emergency stimulant injector"
	desc = "Um autoinjetor de marca Deforest, carregado com uma mistura de reagentes para estabilizar a condição crítica e se recuperar de déficits de resistência."
	base_icon_state = "synephrine"
	icon_state = "synephrine"
	list_reagents = list(
		/datum/reagent/medicine/epinephrine = 10,
		/datum/reagent/medicine/synaptizine = 5,
		/datum/reagent/medicine/synaphydramine = 5,
	)
	custom_price = PAYCHECK_COMMAND * 2.5

// Critical condition stabilizer
/obj/item/reagent_containers/hypospray/medipen/deforest/calopine
	name = "calopine emergency stabilizant injector"
	desc = "Um autoinjetor de marca Deforest, carregado com uma mistura estabilizadora de reagentes para reparar condições críticas."
	base_icon_state = "calopine"
	icon_state = "calopine"
	list_reagents = list(
		/datum/reagent/medicine/atropine = 10,
		/datum/reagent/medicine/coagulant/fabricated = 5,
		/datum/reagent/medicine/salbutamol = 5,
		/datum/reagent/toxin/staminatoxin = 5,
	)

// Coagulant, really not a whole lot more
/obj/item/reagent_containers/hypospray/medipen/deforest/coagulants
	name = "coagulant-S injector"
	desc = "Um autoinjetor marca Deforest, carregado com uma mistura de coagulantes para prevenir e parar o sangramento."
	base_icon_state = "coagulant"
	icon_state = "coagulant"
	list_reagents = list(
		/datum/reagent/medicine/coagulant = 5,
		/datum/reagent/medicine/salglu_solution = 15,
		/datum/reagent/impurity = 5,
	)

// Stimulant centered around ondansetron
/obj/item/reagent_containers/hypospray/medipen/deforest/krotozine
	name = "krotozine manipulative stimulant injector"
	desc = "Um autoinjetor de Deforest marcado, carregado com uma mistura de estimulantes e agentes curativos fracos."
	base_icon_state = "krotozine"
	icon_state = "krotozine"
	list_reagents = list(
		/datum/reagent/medicine/ondansetron = 5,
		/datum/reagent/drug/kronkaine = 5,
		/datum/reagent/medicine/omnizine/protozine = 10,
		/datum/reagent/drug/maint/tar = 5,
	)
	custom_price = PAYCHECK_COMMAND * 2.5

// Stuff really good at healing burn stuff and stabilizing temps
/obj/item/reagent_containers/hypospray/medipen/deforest/lepoturi
	name = "lepoturi burn treatment injector"
	desc = "Um autoinjetor de marca Deforest, carregado com uma mistura de medicamentos para tratar rapidamente queimaduras."
	base_icon_state = "lepoturi"
	icon_state = "lepoturi"
	list_reagents = list(
		/datum/reagent/medicine/mine_salve = 5,
		/datum/reagent/medicine/leporazine = 5,
		/datum/reagent/medicine/c2/lenturi = 10,
		/datum/reagent/toxin/staminatoxin = 5,
	)

// Stabilizes a lot of stats like drowsiness, sanity, dizziness, so on
/obj/item/reagent_containers/hypospray/medipen/deforest/psifinil
	name = "psifinil personal recovery injector"
	desc = "Um autoinjetor de Deforest marcado, carregado com uma mistura de medicamentos para remediar muitas doenças comuns, como sonolência, dor, instabilidade, coisas assim."
	base_icon_state = "psifinil"
	icon_state = "psifinil"
	list_reagents = list(
		/datum/reagent/medicine/modafinil = 10,
		/datum/reagent/medicine/psicodine = 10,
		/datum/reagent/medicine/leporazine = 5,
	)

// Helps with liver failure and some drugs, also alcohol
/obj/item/reagent_containers/hypospray/medipen/deforest/halobinin
	name = "halobinin soberant injector"
	desc = "Um autoinjetor de marca Deforest, carregado com uma mistura de medicamentos para remediar os efeitos da insuficiência hepática e drogas comuns."
	base_icon_state = "halobinin"
	icon_state = "halobinin"
	list_reagents = list(
		/datum/reagent/medicine/haloperidol = 5,
		/datum/reagent/medicine/antihol = 5,
		/datum/reagent/medicine/higadrite = 5,
		/datum/reagent/medicine/silibinin = 5,
	)

// Medpen for robots that fixes toxin damage and purges synth chems but slows them down for a bit
/obj/item/reagent_containers/hypospray/medipen/deforest/robot_system_cleaner
	name = "synthetic cleaner autoinjector"
	desc = "Um autoinjetor de marca Deforest, carregado com limpador de sistema para purgar sintéticos de reagentes."
	base_icon_state = "robor"
	icon_state = "robor"
	list_reagents = list(
		/datum/reagent/medicine/system_cleaner = 15,
		/datum/reagent/dinitrogen_plasmide = 5,
	)

// Medpen for robots that fixes brain damage but slows them down for a bit
/obj/item/reagent_containers/hypospray/medipen/deforest/robot_liquid_solder
	name = "synthetic smart-solder autoinjector"
	desc = "Um autoinjetor de marca Deforest, carregado com solda líquida para reparar danos no núcleo do processador sintético."
	base_icon_state = "robor_brain"
	icon_state = "robor_brain"
	list_reagents = list(
		/datum/reagent/medicine/liquid_solder = 15,
		/datum/reagent/dinitrogen_plasmide = 5,
	)
