/// Turns the user into a chuunibyou.
/obj/item/book/granter/chuunibyou
	starting_title = "I Found a Mysterious Book in the Library That Teaches Me How to Become a Chuunibyou, But It Turns Out It's Actually a Grimoire That Unlocks My Hidden Powers!"
	starting_author = "Anonymous"
	name = "I Found a Mysterious Book in the Library That Teaches Me How to Become a Chuunibyou, But It Turns Out It's Actually a Grimoire That Unlocks My Hidden Powers!"
	desc = "Prefiro ser pego segurando um revólver do sindicato, honestamente."
	icon_state ="chuuni_manga"
	remarks = list(
		"How can anyone believe this stuff?",
		"...Why am I wasting my time on this?",
		"Coming up with the invocations on demand is actually a skill...",
		"I should get a medical eyepatch to complete the look...",
		"According to this manga, my power goes up by 5000% by using invocations...",
		"Who is this \"dark lord\" fellow? Why does he grant all the powers?",
	)

/obj/item/book/granter/chuunibyou/can_learn(mob/living/user)
	if (!isliving(user))
		return
	if (user.GetComponent(/datum/component/chuunibyou))
		to_chat(user, span_warning("Você já é um chuunibyou!"))
		return
	return TRUE

/obj/item/book/granter/chuunibyou/recoil(mob/living/user)
	to_chat(user, span_warning("Você não pode ler isso. Não vale a pena..."))

/obj/item/book/granter/chuunibyou/on_reading_finished(mob/living/user)
	..()
	to_chat(user, span_notice("Você aprendeu a lançar feitiços em um estilo mais \"chuunibyou\"!"))
	user.AddComponent(/datum/component/chuunibyou/no_healing)
