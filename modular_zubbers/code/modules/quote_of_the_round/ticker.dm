/datum/controller/subsystem/ticker
	var/quote_of_the_round_record_start
	var/quote_of_the_round_text
	var/quote_of_the_round_attribution
	var/quote_of_the_round_ckey

/datum/controller/subsystem/ticker/Initialize()
	. = ..()
	quote_of_the_round_record_start = rand(CONFIG_GET(number/quote_of_the_round_time_random_start), CONFIG_GET(number/quote_of_the_round_time_random_end))
	message_admins(
		span_notice("A citação da rodada será escolhida em[DisplayTimeText(quote_of_the_round_record_start,1)].")
	)
	log_runtime("The quote of the round will be chosen in [DisplayTimeText(quote_of_the_round_record_start,1)].")

/datum/controller/subsystem/ticker/declare_completion(force_ending)

	if(quote_of_the_round_text)
		for(var/channel_tag in CONFIG_GET(str_list/channel_announce_new_game))
			send2chat(
				new /datum/tgs_message_content(generate_quote_of_the_round()),
				channel_tag
			)
		to_chat(world, span_notice("Uma citação da rodada foi encontrada, e deveria ter sido enviada para discórdia."))
		log_runtime("A quote of the round was found, and should have been sent to discord.")

	else
		if(world.time <= quote_of_the_round_record_start)
			to_chat(world, span_notice("Uma citação do round não foi encontrada devido ao round ser muito curto."))
			log_runtime("A quote of the round could not be found. The round ended too early.")
		else
			to_chat(world, span_notice("Uma citação da rodada não foi encontrada. Talvez a tripulação deva ser mais memorável."))
			log_runtime("A quote of the round could not be found. Perhaps the filters are too strict?")

	. = ..()

/datum/controller/subsystem/ticker/proc/generate_quote_of_the_round()
	return "The shift has ended. Get ready, a new round on **[SSmap_vote.next_map_config.map_name]** starts soon! <@&[CONFIG_GET(string/game_alert_role_id)]>\n	[pick(strings("quote_of_the_round.json", "workers"))] [pick(strings("quote_of_the_round.json", "action"))] [pick(strings("quote_of_the_round.json", "message"))] that occured during said shift:\n	> *[quote_of_the_round_text]*\n \\- *[quote_of_the_round_attribution]*"
