/obj/machinery/wish_granter
	name = "wish granter"
	desc = "Você não tem tanta certeza sobre isso, mais..."
	icon = 'icons/obj/machines/beacon.dmi'
	icon_state = "syndbeacon"

	use_power = NO_POWER_USE
	density = TRUE

	var/charges = 1
	var/insisting = 0

/obj/machinery/wish_granter/attack_hand(mob/living/carbon/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(charges <= 0)
		to_chat(user, span_boldnotice("O Wish Grant está em silêncio."))
		return

	else if(!ishuman(user))
		to_chat(user, span_boldnotice("Você sente um movimento escuro dentro do Wish Grant, algo que você não quer. Seus instintos são melhores que os de qualquer homem."))
		return

	else if(user.is_antag())
		to_chat(user, span_boldnotice("Mesmo para um coração tão escuro quanto o seu, você sabe que nada de bom virá disso. Algo instintivo faz você se afastar."))

	else if (!insisting)
		to_chat(user, span_boldnotice("Seu primeiro toque faz o Wish Grant mexer, ouvindo você. Tem certeza que quer fazer isso?"))
		insisting++

	else
		to_chat(user, span_boldnotice("Você fala.[pick("I want the station to disappear","Humanity is corrupt, mankind must be destroyed","I want to be rich", "I want to rule the world","I want immortality.")]O Wish Grant responde."))
		to_chat(user, span_boldnotice("Sua cabeça bate por um momento, antes de sua visão se dissipar. Você é o avatar do Wish Grant, e seu poder é LIMITADO! E é todo seu. Precisa ter certeza que ninguém pode tirar de você. Ninguém pode saber, primeiro."))

		charges--
		insisting = 0

		user.mind.add_antag_datum(/datum/antagonist/wishgranter)

		to_chat(user, span_warning("Você tem um mau pressentimento sobre isso."))

	return
