/datum/bloodsucker_clan/tremere
	name = CLAN_TREMERE
	description = "O Clã Tremere é extremamente fraco para a Verdadeira Fé, e queimará ao entrar em áreas consideradas como a Capela.\n\
Além disso, um novo movimento é aprendido, construído com magia de sangue em vez de habilidades de sangue, que são atualizados horas extras.\n\
Mais filas podem ser ganhas por membros da tripulação.\n\
O Ghoul Favorito ganha o feitiço Batform, sendo capaz de se transformar à vontade."
	clan_objective = /datum/objective/bloodsucker/tremere_power
	join_icon_state = "tremere"
	join_description = "Você vai queimar se entrar na Capela, perder todos os poderes padrão,\
Mas ganhar magia de sangue em vez disso, poderes mais fortes você nivelar horas extras."
	buy_power_flags = TREMERE_CAN_BUY|CAN_BUY_OWNED

/datum/bloodsucker_clan/tremere/New(mob/living/carbon/user)
	. = ..()
	bloodsuckerdatum.remove_nondefault_powers(return_levels = TRUE)
	for(var/datum/action/cooldown/bloodsucker/power as anything in bloodsuckerdatum.all_bloodsucker_powers)
		if((initial(power.purchase_flags) & buy_power_flags) && initial(power.level_current) == 1)
			bloodsuckerdatum.BuyPower(power)

/datum/bloodsucker_clan/tremere/Destroy(force)
	for(var/datum/action/cooldown/bloodsucker/power in bloodsuckerdatum.powers)
		if(power.purchase_flags & buy_power_flags)
			bloodsuckerdatum.RemovePower(power)
	return ..()

/datum/bloodsucker_clan/tremere/handle_clan_life(datum/antagonist/bloodsucker/source, seconds_per_tick, times_fired)
	. = ..()
	var/area/current_area = get_area(bloodsuckerdatum.owner.current)
	if(istype(current_area, /area/station/service/chapel))
		to_chat(bloodsuckerdatum.owner.current, span_warning("Você não pertence a áreas sagradas! A Fé te queima!"))
		bloodsuckerdatum.owner.current.adjust_fire_loss(10)
		bloodsuckerdatum.owner.current.adjust_fire_stacks(2)
		bloodsuckerdatum.owner.current.ignite_mob()

/datum/bloodsucker_clan/tremere/level_up_powers(datum/antagonist/bloodsucker/source)
	return

/datum/bloodsucker_clan/tremere/level_message(power_name)
	var/mob/living/carbon/human/human_user = bloodsuckerdatum.owner.current
	human_user.balloon_alert(human_user, "upgraded [power_name]!")
	to_chat(human_user, span_notice("You have upgraded [power_name]!"))

// redefine the default args
/datum/bloodsucker_clan/tremere/list_available_powers(already_known, powers_list)
	already_known = list()
	powers_list = bloodsuckerdatum.powers
	return ..()

/datum/bloodsucker_clan/tremere/purchase_choice(datum/antagonist/bloodsucker/source, datum/action/cooldown/bloodsucker/purchased_power)
	return purchased_power.upgrade_power()

/datum/bloodsucker_clan/tremere/favorite_ghoul_gain(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	var/datum/action/cooldown/spell/shapeshift/bat/batform = new(ghouldatum.owner || ghouldatum.owner.current)
	batform.Grant(ghouldatum.owner.current)

/datum/bloodsucker_clan/tremere/favorite_ghoul_loss(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	var/datum/action/cooldown/spell/shapeshift/bat/batform = locate() in ghouldatum.owner.current.actions
	batform.Remove(ghouldatum.owner.current)

/datum/bloodsucker_clan/tremere/on_ghoul_made(datum/antagonist/bloodsucker/source, mob/living/user, mob/living/target)
	. = ..()
	to_chat(bloodsuckerdatum.owner.current, span_danger("Você ganhou agora uma patente adicional para gastar!"))
	bloodsuckerdatum.AdjustUnspentRank(1)
