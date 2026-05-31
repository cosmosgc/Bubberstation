#define CLIMAX_VAGINA "Vagina"
#define CLIMAX_PENIS "Penis"
#define CLIMAX_BOTH "Both"

#define CLIMAX_ON_FLOOR "On the floor"
#define CLIMAX_IN_OR_ON "Climax in or on someone"
#define CLIMAX_OPEN_CONTAINER "Fill reagent container"
#define CLIMAX_PORTAL "Through the portal"

// both of these are pretty much arbitrary
#define MIN_CUM_THRESHOLD 5
#define MIN_VAGINA_WETNESS_THRESHOLD 3.33

/mob/living/carbon/human
	/// Used to prevent nightmare scenarios.
	var/refractory_period

/mob/living/carbon/human/proc/climax(manual = TRUE)
	if (CONFIG_GET(flag/disable_erp_preferences))
		return

	if(!client?.prefs?.read_preference(/datum/preference/toggle/erp/autocum) && !manual)
		return
	if(refractory_period > REALTIMEOFDAY)
		return
	refractory_period = REALTIMEOFDAY + 30 SECONDS
	if(has_status_effect(/datum/status_effect/climax_cooldown) || !client?.prefs?.read_preference(/datum/preference/toggle/erp))
		return

	if(HAS_TRAIT(src, TRAIT_NEVERBONER) || has_status_effect(/datum/status_effect/climax_cooldown) || (!has_vagina() && !has_penis()))
		visible_message(span_purple("[src]Treme, tentando gozar, mas sem resultado."), 			span_purple("Você não pode ter um orgasmo!"))
		return TRUE

	// Reduce pop-ups and make it slightly more frictionless (lewd).
	var/climax_choice = has_penis() ? CLIMAX_PENIS : CLIMAX_VAGINA

	if(manual)
		var/list/genitals = list()
		if(has_vagina())
			genitals.Add(CLIMAX_VAGINA)
			if(has_penis())
				genitals.Add(CLIMAX_PENIS)
				genitals.Add(CLIMAX_BOTH)
		else if(has_penis())
			genitals.Add(CLIMAX_PENIS)
		climax_choice = tgui_alert(src, "You are climaxing, choose which genitalia to climax with.", "Genitalia Preference!", genitals)

	switch(gender)
		if(MALE)
			conditional_pref_sound(get_turf(src), pick('modular_skyrat/modules/modular_items/lewd_items/sounds/final_m1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m3.ogg'), 50, TRUE, pref_to_check = /datum/preference/toggle/erp/sounds)
		if(FEMALE)
			conditional_pref_sound(get_turf(src), pick('modular_skyrat/modules/modular_items/lewd_items/sounds/final_f1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f3.ogg'), 50, TRUE, pref_to_check = /datum/preference/toggle/erp/sounds)

	var/self_orgasm = FALSE
	var/self_their = p_their()

	var/obj/item/organ/genital/testicles/testicles = get_organ_slot(ORGAN_SLOT_TESTICLES)
	testicles?.calculate_cumshot()

	if(climax_choice == CLIMAX_PENIS || climax_choice == CLIMAX_BOTH)
		var/obj/item/organ/genital/penis/penis = get_organ_slot(ORGAN_SLOT_PENIS)
		if(!testicles || testicles.reagents.total_volume < MIN_CUM_THRESHOLD) //If we have no god damn balls, we can't cum anywhere... GET BALLS! , OR theres so little in your balls that nothing comes out...
			visible_message(span_userlove("[src]orgasmos, mas nada sai de[self_their]Pênis!"), 				span_userlove("Seu orgasmo é ótimo, mas nada sai do seu pênis!"))

		else if(is_wearing_condom())
			var/obj/item/clothing/sextoy/condom/condom = src.penis // bruh 💀⚰️💀⚰️💀⚰️💀⚰️💀
			condom.condom_use() // condoms probably should become reagent containers at some point
			visible_message(span_userlove("[src]Atira[self_their]Carregar na[condom]Enchendo!"), 				span_userlove("Você atira sua carga grossa no[condom]E pega tudo!"))
			testicles.reagents.remove_all(testicles.cumshot_size)

		else if(!is_bottomless() && penis.visibility_preference != GENITAL_ALWAYS_SHOW)
			visible_message(span_userlove("[src]Cums dentro[self_their]Roupas!"), 				span_userlove("Você atira na sua carga, mas não estava nua, então você estraga suas roupas!"))
			self_orgasm = TRUE
			testicles.reagents.remove_all(testicles.cumshot_size)

		else
			var/list/interactable_inrange_humans = list()
			// monkey see, monkey do
			var/list/interactable_inrange_open_containers = list()

			// Unfortunately prefs can't be checked here, because byond/tgstation moment.
			for(var/mob/living/carbon/human/iterating_human in (view(1, src) - src))
				interactable_inrange_humans[iterating_human.name] = iterating_human

			// this should be making a list of cups(?)
			for(var/obj/item/reagent_containers/cup/iterating_open_container in (view(1, src) - src))
				interactable_inrange_open_containers[iterating_open_container.name] = iterating_open_container

			var/list/buttons = list(CLIMAX_ON_FLOOR)
			if(interactable_inrange_humans.len)
				buttons += CLIMAX_IN_OR_ON

			if(interactable_inrange_open_containers.len)
				buttons += CLIMAX_OPEN_CONTAINER

			// If your using a LustWish portal lets you cum through it
			var/obj/structure/lewd_portal/portal = src.buckled
			if(istype(portal, /obj/structure/lewd_portal))
				buttons += CLIMAX_PORTAL

			var/penis_climax_choice = tgui_alert(src, "Escolha onde atirar.", "Load preference!", buttons)

			var/create_cum_decal = FALSE

			if(!penis_climax_choice || penis_climax_choice == CLIMAX_ON_FLOOR)
				create_cum_decal = TRUE
				visible_message(span_userlove("[src]Atira[self_their]Carga pegajosa no chão!"), 					span_userlove("Você atira fio após fio de esperma quente, batendo no chão!"))
				testicles.reagents.remove_all(testicles.cumshot_size)

			else if(penis_climax_choice == CLIMAX_OPEN_CONTAINER)
				var/target_choice = tgui_input_list(src, "Choose a container to cum into.", "Choose target!", interactable_inrange_open_containers)
				if(!target_choice)
					create_cum_decal = TRUE
					visible_message(span_userlove("[src]Atira[self_their]Carga pegajosa no chão!"), 						span_userlove("Você atira fio após fio de esperma quente, batendo no chão!"))
					testicles.reagents.remove_all(testicles.cumshot_size)
				else
					var/obj/item/reagent_containers/cup/target_open_container = interactable_inrange_open_containers[target_choice]
					if(target_open_container.is_refillable() && target_open_container.is_drainable())
						// here's where we actually do the cumming(?)
						var/cum_volume = testicles.cumshot_size
						var/total_volume_w_cum = cum_volume + target_open_container.reagents.total_volume
						conditional_pref_sound(get_turf(src), SFX_DESECRATION, 50, TRUE, pref_to_check = /datum/preference/toggle/erp/sounds)
						if(target_open_container.reagents.holder_full())
							// its full already
							add_cum_splatter_floor(get_turf(target_open_container))
							visible_message(span_userlove("[src]Tenta gozar no[target_open_container]Mas já está cheio, derramando sua carga quente no chão!"), 								span_userlove("Você tenta gozar no[target_open_container], mas já está cheio, então tudo bate no chão em vez disso!"))
						else
							testicles.reagents.trans_to(target_open_container, testicles.cumshot_size, transferred_by = src)
							if(total_volume_w_cum > target_open_container.volume)
								// overflow, make the decal
								add_cum_splatter_floor(get_turf(target_open_container))
								visible_message(span_userlove("[src]Atira[self_their]carga pegajosa na[target_open_container]Está tão cheio que transborda!"), 									span_userlove("Você atira fio após fio de esperma quente no[target_open_container]Fazendo transbordar!"))
							else
								visible_message(span_userlove("[src]Atira[self_their]carga pegajosa na[target_open_container]!"), 									span_userlove("Você atira fio após fio de esperma quente no[target_open_container]!"))
					else
						// cum fail
						create_cum_decal = TRUE
						visible_message(span_userlove("[src]Atira[self_their]Carga pegajosa no chão!"), 							span_userlove("Você atira fio após fio de esperma quente, batendo no chão!"))
						testicles.reagents.remove_all(testicles.cumshot_size)

			else if(penis_climax_choice == CLIMAX_PORTAL)
				to_chat(src, "Você atira fio após fio de esperma quente, batendo o que estiver do outro lado!")
				portal.relayed_body.visible_message("[portal.relayed_body]Atira sua carga pegajosa no chão!")
				add_cum_splatter_floor(get_turf(portal.relayed_body))

			else
				var/target_choice = tgui_input_list(src, "Choose a person to cum in or on.", "Choose target!", interactable_inrange_humans)
				if(!target_choice)
					create_cum_decal = TRUE
					visible_message(span_userlove("[src]Atira[self_their]Carga pegajosa no chão!"), 						span_userlove("Você atira fio após fio de esperma quente, batendo no chão!"))
				else
					var/mob/living/carbon/human/target_human = interactable_inrange_humans[target_choice]
					var/target_human_them = target_human.p_them()

					var/list/target_buttons = list()

					if(!target_human.wear_mask)
						target_buttons += "mouth"
					if(target_human.has_vagina(REQUIRE_GENITAL_EXPOSED))
						target_buttons += ORGAN_SLOT_VAGINA
					if(target_human.has_anus(REQUIRE_GENITAL_EXPOSED))
						target_buttons += "asshole"
					if(target_human.has_penis(REQUIRE_GENITAL_EXPOSED))
						var/obj/item/organ/genital/penis/other_penis = target_human.get_organ_slot(ORGAN_SLOT_PENIS)
						if(other_penis.sheath != "None")
							target_buttons += "sheath"
					target_buttons += "On [target_human_them]"

					var/climax_into_choice = tgui_input_list(src, "Where on or in [target_human] do you wish to cum?", "Final frontier!", target_buttons)

					if(!climax_into_choice)
						create_cum_decal = TRUE
						visible_message(span_userlove("[src]Atira sua carga pegajosa no chão!"), 							span_userlove("Você atira fio após fio de esperma quente, batendo no chão!"))
					else if(climax_into_choice == "On [target_human_them]")
						create_cum_decal = TRUE
						visible_message(span_userlove("[src]Atira sua carga pegajosa sobre[target_human]!"), 							span_userlove("Você atira fio após fio de esperma quente em[target_human]!"))
					else
						visible_message(
							span_userlove("[src]Hilts[self_their]Pisc em[target_human]'s[climax_into_choice], atirando esperma em[target_human_them]!"),
							span_userlove("Você segura seu pau[target_human]'s[climax_into_choice], atirando esperma em[target_human_them]!"))
						to_chat(target_human, span_userlove("Sua[climax_into_choice]enche-se de esperma quente como[src]Atira[self_their]Carregar nele."))

						if(climax_into_choice == "mouth")
							testicles.reagents.trans_to(target_human, testicles.cumshot_size, transferred_by = src, methods = INGEST)

					// if someone wanted to, they could add code for actually putting cum inside of a vagina since it's a reagent container now...
					// would need to change up the fluid_generation.dm and tweak the organ itself for it to make sense though
					// same for other organs

			if(create_cum_decal)
				add_cum_splatter_floor(get_turf(src))

		try_lewd_autoemote("moan")
		if(climax_choice == CLIMAX_PENIS)
			apply_status_effect(/datum/status_effect/climax)
			apply_status_effect(/datum/status_effect/climax_cooldown)
			if(self_orgasm)
				add_mood_event("orgasm", /datum/mood_event/climaxself)
			return TRUE

	if(climax_choice == CLIMAX_VAGINA || climax_choice == CLIMAX_BOTH)
		var/obj/item/organ/genital/vagina/vagina = get_organ_slot(ORGAN_SLOT_VAGINA)
		if(is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
			visible_message(
				span_userlove("[src]Treme e geme como[p_they()]clímax de sua vagina!"),
				span_userlove("Você se contorce e geme como um clímax de sua vagina!"))
			if(vagina.reagents.total_volume >= MIN_VAGINA_WETNESS_THRESHOLD)
				add_cum_splatter_floor(get_turf(src), female = TRUE)
		else
			if(vagina.reagents.total_volume >= MIN_VAGINA_WETNESS_THRESHOLD)
				visible_message(
					span_userlove("[src]Esporra dentro[self_their]Cueca de[self_their]Vagina!"),
					span_userlove("Você goza de cueca da sua vagina! Eca."))
				self_orgasm = TRUE
			else
				visible_message(
					span_userlove("[src]Esporra dentro[self_their]Cueca de[self_their]Vagina!"),
					span_userlove("Você goza de cueca da vagina, mas não está molhada o suficiente para estragar tudo."))

	apply_status_effect(/datum/status_effect/climax)
	apply_status_effect(/datum/status_effect/climax_cooldown)
	if(self_orgasm)
		add_mood_event("orgasm", /datum/mood_event/climaxself)
	return TRUE

#undef CLIMAX_VAGINA
#undef CLIMAX_PENIS
#undef CLIMAX_BOTH
#undef CLIMAX_ON_FLOOR
#undef CLIMAX_IN_OR_ON
#undef CLIMAX_OPEN_CONTAINER

#undef MIN_CUM_THRESHOLD
#undef MIN_VAGINA_WETNESS_THRESHOLD
#undef CLIMAX_PORTAL
