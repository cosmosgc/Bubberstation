/datum/action/changeling/digitalcamo
	name = "Digital Camouflage"
	desc = "Ao evoluir a capacidade de distorcer nossa forma e proporções, derrotamos algoritmos comuns usados para detectar formas de vida em câmeras."
	helptext = "We cannot be tracked by camera or seen by AI units while using this skill. However, humans looking at us will find us... uncanny."
	button_icon_state = "digital_camouflage"
	category = "stealth"
	dna_cost = 1
	active = FALSE

//Prevents AIs tracking you but makes you easily detectable to the human-eye.
/datum/action/changeling/digitalcamo/sting_action(mob/user)
	..()
	if(active)
		to_chat(user, span_notice("Voltamos ao normal."))
		user.RemoveElement(/datum/element/digitalcamo)
	else
		to_chat(user, span_notice("Nós distorcemos nossa forma para nos escondermos da IA."))
		user.AddElement(/datum/element/digitalcamo)
	active = !active
	return TRUE

/datum/action/changeling/digitalcamo/Remove(mob/user)
	user.RemoveElement(/datum/element/digitalcamo)
	..()
