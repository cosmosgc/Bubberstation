///The maximum level a Ventrue Bloodsucker can be, before they have to level up their ghoul instead.
#define VENTRUE_MAX_POWERS 3

/datum/bloodsucker_clan/ventrue
	name = CLAN_VENTRUE
	description = "O Clã Ventrue é extremamente esnobe com suas refeições, e se recusa a beber sangue das pessoas sem uma mente.\n\
Você pode ter até %MAX POWERS% de poderes, qualquer coisa mais será classificação para gastar em seu Ghoul Favorito através de um Rack Persuasão.\n\
O Ghoul Favorito vai lentamente virar mais vampírico desta forma, até que finalmente percam seus últimos pedaços da Humanidade.\n\
Uma vez que você terminar seu abraço, o vampiro recém-criado se tornará apenas um fantasma, e você será capaz de gerar outro sanguessuga."
	clan_objective = /datum/objective/bloodsucker/embrace
	join_icon_state = "ventrue"
	join_description = "Perder a capacidade de beber de multidões sem cérebro, não pode nivelar ou ganhar novos poderes,\
Em vez disso, você cria um fantasma em um sanguessuga."
	blood_drink_type = BLOODSUCKER_DRINK_SNOBBY
	level_cost = BLOODSUCKER_LEVELUP_PERCENTAGE_VENTRUE

/datum/bloodsucker_clan/ventrue/New(datum/antagonist/bloodsucker/owner_datum)
	. = ..()
	description = replacetext(description, "MAX POWERS", VENTRUE_MAX_POWERS)

/datum/bloodsucker_clan/ventrue/proc/has_enough_abilities()
	var/power_count = 0
	for(var/datum/action/cooldown/bloodsucker/power in bloodsuckerdatum.powers)
		if(!(power.purchase_flags & BLOODSUCKER_DEFAULT_POWER))
			power_count++
	if(power_count >= VENTRUE_MAX_POWERS)
		return TRUE
	return FALSE

/datum/bloodsucker_clan/ventrue/spend_rank(datum/antagonist/bloodsucker/source, cost_rank = TRUE, blood_cost)
	if(has_enough_abilities())
		to_chat(bloodsuckerdatum.owner.current, span_danger("You can only have up to [VENTRUE_MAX_POWERS] powers, anything further must be ranks to spend on your Favorite Ghoul through a Persuasion Rack."))
		return FALSE
	. = ..()

/datum/bloodsucker_clan/ventrue/proc/finish_spend_rank(datum/antagonist/ghoul/ghouldatum, cost_rank, blood_cost)
	finalize_spend_rank(bloodsuckerdatum, cost_rank, blood_cost)
	ghouldatum.LevelUpPowers()

/datum/bloodsucker_clan/ventrue/interact_with_ghoul(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/favorite/ghouldatum)
	. = ..()
	if(.)
		return TRUE
	if(!istype(ghouldatum))
		return FALSE
	to_chat(bloodsuckerdatum.owner.current, span_warning("Do you wish to Rank [ghouldatum.owner.current] up?"))
	to_chat(bloodsuckerdatum.owner.current, span_warning("This will use [bloodsuckerdatum.GetUnspentRank() >= 1 ? "a unspent Rank" : "[bloodsuckerdatum.get_level_cost()] Blood Thickening Points"]!"))

	var/static/list/rank_options = list(
		"Yes" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_yes"),
		"No" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_no"),
	)
	var/rank_response = show_radial_menu(bloodsuckerdatum.owner.current, ghouldatum.owner.current, rank_options, radius = 36, require_near = TRUE)
	if(rank_response == "Yes")
		if(!bloodsuckerdatum.GetUnspentRank() >= 1 && !source.blood_level_gain(FALSE))
			to_chat(bloodsuckerdatum.owner.current, span_danger("You don't have any levels or enough blood thickening points to Rank [ghouldatum.owner.current] up with."))
			return FALSE
		return ghoul_level(ghouldatum)
	return FALSE

/datum/bloodsucker_clan/ventrue/proc/ghoul_level(datum/antagonist/ghoul/favorite/ghouldatum)
	var/list/options = list_available_powers(ghouldatum.bloodsucker_powers)
	var/mob/living/carbon/human/target = ghouldatum.owner.current
	var/datum/action/cooldown/bloodsucker/choice = choose_powers(
		"You have the opportunity to level up your Favorite Ghoul. Select a power you wish them to receive.",
		"A wise master's hand is neccesary",
		options
	)
	if(!choice)
		return FALSE
	var/power_name = initial(choice.name)
	if(!ghouldatum.BuyPower(choice, ghouldatum.bloodsucker_powers))
		bloodsuckerdatum.owner.current.balloon_alert(bloodsuckerdatum.owner.current, "[target] already knows [power_name]!")
		return FALSE
	bloodsuckerdatum.owner.current.balloon_alert(bloodsuckerdatum.owner.current, "taught [power_name]!")
	to_chat(bloodsuckerdatum.owner.current, span_notice("You taught [target] how to use [power_name]!"))

	target.balloon_alert(target, "learned [power_name]!")
	to_chat(target, span_notice("Your master taught you how to use [power_name]!"))

	ghouldatum.ghoul_level++
	finish_spend_rank(ghouldatum, TRUE, FALSE)
	bloodsuckerify(ghouldatum)
	return TRUE

/datum/bloodsucker_clan/ventrue/proc/bloodsuckerify(datum/antagonist/ghoul/favorite/ghouldatum)
	var/mob/living/carbon/human/target = ghouldatum.owner.current
	var/stage = ghouldatum.ghoul_level
	var/list/traits_possible = list(
		list(TRAIT_COLDBLOODED, TRAIT_NOBREATH, TRAIT_AGEUSIA),
		list(TRAIT_NOCRITDAMAGE, TRAIT_NOSOFTCRIT, TRAIT_SLEEPIMMUNE, TRAIT_VIRUSIMMUNE),
		list(TRAIT_NOHARDCRIT, TRAIT_HARDLY_WOUNDED)
	)
	var/traits_to_add = length(traits_possible) >= stage ? traits_possible[stage] : list()
	switch(stage)

		if(1)
			to_chat(target, span_notice("Seu sangue começa a sentir frio, e como um monte de cinzas cai em sua língua, você pára de respirar..."))

		if(2)
			to_chat(target, span_notice("Sente o sangue do seu Mestre te fortalecendo."))
			if(ishuman(target))
				var/mob/living/carbon/human/human_target = target
				human_target.skin_tone = "albino"

		if(3)
			to_chat(target, span_notice("Você se sente capaz de fazer cortes e esfaqueamentos como se não fosse nada."))

		if(4 to INFINITY)
			var/datum/antagonist/bloodsucker/bloodsucker_target = IS_BLOODSUCKER(target)
			if(!bloodsucker_target)
				to_chat(target, span_notice("Você sente seu coração parar de bater pela última vez quando começa a ter sede de sangue, você se sente... morto."))
				// Unfavorites you, so the ventrue isn't stuck with you forever
				var/powers_to_transfer = list()
				// Get rid of the favorite datum and replace with a normal ghoul datum
				if(ghouldatum)
					ghouldatum.silent = TRUE
					for(var/datum/power as anything in ghouldatum.bloodsucker_powers)
						powers_to_transfer += power.type
					target.mind.remove_antag_datum(/datum/antagonist/ghoul/favorite)
				else
					target.remove_traits(assoc_to_values(traits_to_add), GHOUL_TRAIT)


				var/datum/antagonist/bloodsucker/vamp = new()
				vamp.ventrue_sired = bloodsuckerdatum
				bloodsucker_target = target.mind.add_antag_datum(vamp)
				bloodsucker_target.BuyPowers(powers_to_transfer)
				// Check for the recuperate power and remove it if they have it
				bloodsuckerdatum.owner.current.add_mood_event("madevamp", /datum/mood_event/madevamp)


	if(ghouldatum && QDELETED(ghouldatum) && length(traits_to_add))
		target.add_traits(traits_to_add, GHOUL_TRAIT)
		ghouldatum.traits += traits_to_add

/datum/bloodsucker_clan/ventrue/favorite_ghoul_gain(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	to_chat(source.owner.current, span_announce("Agora você pode atualizar seu Ghoul Favorito, colocando-os em uma prateleira de persuasão!"))
	ghouldatum.BuyPower(/datum/action/cooldown/bloodsucker/distress)

/datum/bloodsucker_clan/ventrue/is_valid_ghoul(datum/antagonist/ghoul/ghoul_type)
	. = ..()
	if(!.)
		return FALSE
	var/datum/antagonist/ghoul/favorite = /datum/antagonist/ghoul/favorite
	if(ghoul_type != favorite)
		// no ghoul slots and trying to make a non-favorite ghoul, don't softlock yourself
		if(bloodsuckerdatum.free_ghoul_slots() < 1 && !bloodsuckerdatum.special_ghouls[initial(favorite.special_type)])
			to_chat(bloodsuckerdatum.owner.current, span_danger("Fazer um Ghoul não-favorito irá impedi-lo de nivelar, já que não tem mais vagas!"))
			return FALSE
	return TRUE

#undef VENTRUE_MAX_POWERS
