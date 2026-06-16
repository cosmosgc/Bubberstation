/datum/action/cooldown/alien/hide
	name = "Hide"
	desc = "Permite que você se esconda sob mesas e certos objetos."
	button_icon_state = "alien_hide"
	plasma_cost = 0
	/// The layer we are on while hiding
	var/hide_layer = ABOVE_NORMAL_TURF_LAYER

/datum/action/cooldown/alien/hide/Activate(atom/target)
	if(owner.layer == hide_layer)
		owner.layer = initial(owner.layer)
		owner.visible_message(
			span_notice("[owner] Espreita lentamente do chão..."),
			span_noticealien("Pare de se esconder."),
		)
		ADD_TRAIT(owner, TRAIT_IGNORE_ELEVATION, ACTION_TRAIT)

	else
		owner.layer = hide_layer
		owner.visible_message(
			span_name("[owner] Corre para o chão!"),
			span_noticealien("Agora você está se escondendo."),
		)
		REMOVE_TRAIT(owner, TRAIT_IGNORE_ELEVATION, ACTION_TRAIT)

	return TRUE

/datum/action/cooldown/alien/larva_evolve
	name = "Evolve"
	desc = "Evolua para uma casta alienígena superior."
	button_icon_state = "alien_evolve_larva"
	plasma_cost = 0

/datum/action/cooldown/alien/larva_evolve/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return FALSE
	if(!islarva(owner))
		return FALSE

	var/mob/living/carbon/alien/larva/larva = owner
	if(larva.handcuffed || larva.legcuffed) // Cuffing larvas ? Eh ?
		return FALSE
	if(larva.amount_grown < larva.max_grown)
		return FALSE
	if(larva.movement_type & VENTCRAWLING)
		return FALSE

	return TRUE

//SKYRAT EDIT REMOVAL BEGIN - SKYRAT_XENO_REDO - Moved to: modular_skyrat\modules\xenos_skyrat_redo\code\xeno_types\larva.dm
/*
/datum/action/cooldown/alien/larva_evolve/Activate(atom/target)
	var/mob/living/carbon/alien/larva/larva = owner
	var/static/list/caste_options
	if(!caste_options)
		caste_options = list()

		// This can probably be genericized in the future.
		var/mob/hunter_path = /mob/living/carbon/alien/adult/hunter
		var/datum/radial_menu_choice/hunter = new()
		hunter.name = "Hunter"
		hunter.image  = image(icon = initial(hunter_path.icon), icon_state = initial(hunter_path.icon_state))
		hunter.info = span_info("Caçadores são a casta mais ágil, encarregada de caçar hospedeiros. Eles são mais rápidos que um humano e podem até atacar, mas não são muito mais duros que um drone.")

		caste_options["Hunter"] = hunter

		var/mob/sentinel_path = /mob/living/carbon/alien/adult/sentinel
		var/datum/radial_menu_choice/sentinel = new()
		sentinel.name = "Sentinel"
		sentinel.image  = image(icon = initial(sentinel_path.icon), icon_state = initial(sentinel_path.icon_state))
		sentinel.info = span_info("Sentinelas são encarregados de proteger a colmeia. Com seu cuspe variado, invisibilidade, e alta saúde, eles fazem guardiães formidáveis e caçadores aceitáveis de segunda mão.")

		caste_options["Sentinel"] = sentinel

		var/mob/drone_path = /mob/living/carbon/alien/adult/drone
		var/datum/radial_menu_choice/drone = new()
		drone.name = "Drone"
		drone.image  = image(icon = initial(drone_path.icon), icon_state = initial(drone_path.icon_state))
		drone.info = span_info("Os drones são os mais fracos e lentos das castas, mas podem se tornar pretorianos e rainhas se nenhuma rainha existir, e são vitais para manter uma colméia com suas habilidades de secreção de resina.")

		caste_options["Drone"] = drone

	var/alien_caste = show_radial_menu(owner, owner, caste_options, radius = 38, require_near = TRUE, tooltips = TRUE)
	if(QDELETED(src) || QDELETED(owner) || !IsAvailable(feedback = TRUE) || isnull(alien_caste))
		return

	var/mob/living/carbon/alien/adult/new_xeno
	switch(alien_caste)
		if("Hunter")
			new_xeno = new /mob/living/carbon/alien/adult/hunter(larva.loc)
		if("Sentinel")
			new_xeno = new /mob/living/carbon/alien/adult/sentinel(larva.loc)
		if("Drone")
			new_xeno = new /mob/living/carbon/alien/adult/drone(larva.loc)
		else
			CRASH("Alien evolve was given an invalid / incorrect alien cast type. Got: [alien_caste]")

	larva.alien_evolve(new_xeno)
	return TRUE
*/
//SKYRAT EDIT REMOVAL END
