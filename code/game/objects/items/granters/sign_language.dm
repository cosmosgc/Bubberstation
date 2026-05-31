/// Sign language book adds the sign language component to the reading Human.
/// Grants reader the ability to toggle sign language using a HUD button.
/obj/item/book/granter/sign_language
	name = "Galactic Standard Sign Language"
	desc = "Um guia abrangente para aprender língua de sinais e ortografia."
	remarks = list(
		"Signing comprises a range of techniques...",
		"Words can be spelled out through sequences of signs...",
		"The way your palm faces?",
		"With questions, the eyebrows are lowered...",
		"Cool! Extensive coverage of common phrases!",
		"Communicate just about anything through signing...",
	)

/obj/item/book/granter/sign_language/can_learn(mob/living/user)
	if (!iscarbon(user))
		return
	if (user.GetComponent(/datum/component/sign_language))
		to_chat(user, span_warning("Você já sabe tudo sobre linguagem de sinais!"))
		return
	return TRUE

/obj/item/book/granter/sign_language/recoil(mob/living/user)
	to_chat(user, span_warning("Você não pode ler, as páginas estão muito apagadas e borradas!"))

/// Called when the reading is completely finished. This is where the actual granting should happen.
/obj/item/book/granter/sign_language/on_reading_finished(mob/living/user)
	..()
	user.AddComponent(/datum/component/sign_language)
