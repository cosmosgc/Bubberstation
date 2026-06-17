// Species trait debuffs
/datum/mood_event/dry_skin
	description = "Minha pele está muito seca...\n"
	mood_change = -2

// When you get bit by a peculiar plushie
/datum/mood_event/plush_bite
	description = span_warning("Ele me mordeu! OW!\n")
	mood_change = -3
	timeout = 2 MINUTES
