/// Gives the target fake scars
/datum/smite/scarify
	name = "Scarify"

/datum/smite/scarify/effect(client/user, mob/living/target)
	. = ..()
	if(!iscarbon(target))
		to_chat(user, span_warning("Isso deve ser usado em uma multidão de carbono."), confidential = TRUE)
		return
	var/mob/living/carbon/dude = target
	dude.generate_fake_scars(rand(1, 4))
	to_chat(dude, span_warning("Você sente seu corpo ficar cansado e rasgado..."))
