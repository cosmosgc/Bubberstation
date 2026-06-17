/obj/item/statuebust
	name = "bust"
	desc = "Um precioso busto de mármore antigo, do tipo que pertence a um museu." //or you can hit people with it
	icon = 'icons/obj/art/statue.dmi'
	icon_state = "bust"
	force = 15
	throwforce = 10
	throw_speed = 5
	throw_range = 2
	attack_verb_continuous = list("busts")
	attack_verb_simple = list("bust")
	var/impressiveness = 45

/obj/item/statuebust/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/art, impressiveness)
	AddElement(/datum/element/beauty, 1000)

/obj/item/statuebust/hippocratic
	name = "hippocrates bust"
	desc = "Um busto do famoso médico grego Hipócrates de Kos, muitas vezes referido como o pai da medicina ocidental."
	icon_state = "hippocratic"
	impressiveness = 50
	// If it hits the prob(reference_chance) chance, this is set to TRUE. Adds medical HUD when wielded, but has a 10% slower attack speed and is too bloody to make an oath with.
	var/reference = FALSE
	// Chance for above.
	var/reference_chance = 1
	// Minimum time inbetween oaths.
	COOLDOWN_DECLARE(oath_cd)

/obj/item/statuebust/hippocratic/evil
	reference_chance = 100

/obj/item/statuebust/hippocratic/Initialize(mapload)
	. = ..()
	if(prob(reference_chance))
		name = "Solemn Vow"
		desc = "Os amantes da arte apreciarão o busto de Hipócrates, comemorando uma época em que médicos ainda pensavam que não fazer mal era uma boa ideia."
		attack_speed = CLICK_CD_SLOW
		reference = TRUE

/obj/item/statuebust/hippocratic/examine(mob/user)
	. = ..()
	if(reference)
		. += span_notice("Você poderia ativar o busto para jurar ou renunciar a um juramento de Hipócrates... mas parece que alguém decidiu que era mais uma sugestão de Hipócrates. Esta coisa está cheia de pedaços de sangue e sangue.")
		return
	. += span_notice("Você pode ativar o busto para jurar ou renunciar a um juramento de Hipócrates! Isso não tem efeitos exceto pacifismo ou direitos de se gabar. Não remove outras fontes de pacifismo. Não coma.")

/obj/item/statuebust/hippocratic/equipped(mob/living/carbon/human/user, slot)
	..()
	if(!(slot & ITEM_SLOT_HANDS))
		return
	ADD_TRAIT(user, TRAIT_MEDICAL_HUD, type)

/obj/item/statuebust/hippocratic/dropped(mob/living/carbon/human/user)
	..()
	if(HAS_TRAIT_NOT_FROM(user, TRAIT_MEDICAL_HUD, type))
		return
	REMOVE_TRAIT(user, TRAIT_MEDICAL_HUD, type)

/obj/item/statuebust/hippocratic/attack_self(mob/user)
	if(!iscarbon(user))
		to_chat(user, span_warning("Lembra-se de como o juramento de Hipócrates especifica \"meus semelhantes seres humanos\" e percebe que é completamente sem sentido para você."))
		return

	if(reference)
		to_chat(user, span_warning("Enquanto você se prepara para jurar o juramento, você percebe que fazer isso em um busto de sangue provavelmente não é uma boa ideia."))
		return

	if(!COOLDOWN_FINISHED(src, oath_cd))
		to_chat(user, span_warning("Você jurou ou renunciou a um juramento muito recentemente para desfazer suas decisões. O busto olha para você com nojo."))
		return

	COOLDOWN_START(src, oath_cd, 5 MINUTES)

	if(HAS_TRAIT_FROM(user, TRAIT_PACIFISM, type))
		to_chat(user, span_warning("Você já fez um voto. Você começa a se preparar para rescindir..."))
		if(do_after(user, 5 SECONDS, target = user))
			user.say("Yeah this Hippopotamus thing isn't working out. I quit!", forced = "hippocratic hippocrisy")
			REMOVE_TRAIT(user, TRAIT_PACIFISM, type)

	// they can still do it for rp purposes
	if(HAS_TRAIT_NOT_FROM(user, TRAIT_PACIFISM, type))
		to_chat(user, span_warning("Você já não quer machucar as pessoas, isso não vai fazer nada!"))


	to_chat(user, span_notice("Você se lembra do conteúdo do Juramento de Hipócrates e se prepara para jurar..."))
	if(do_after(user, 4 SECONDS, target = user))
		user.say("I swear to fulfill, to the best of my ability and judgment, this covenant:", forced = "hippocratic oath")
	else
		return fuck_it_up(user)
	if(do_after(user, 2 SECONDS, target = user))
		user.say("I will apply, for the benefit of the sick, all measures that are required, avoiding those twin traps of overtreatment and therapeutic nihilism.", forced = "hippocratic oath")
	else
		return fuck_it_up(user)
	if(do_after(user, 3 SECONDS, target = user))
		user.say("I will remember that I remain a member of society, with special obligations to all my fellow human beings, those sound of mind and body as well as the infirm.", forced = "hippocratic oath")
	else

		return fuck_it_up(user)
	if(do_after(user, 3 SECONDS, target = user))
		user.say("If I do not violate this oath, may I enjoy life and art, respected while I live and remembered with affection thereafter. May I always act so as to preserve the finest traditions of my calling and may I long experience the joy of healing those who seek my help.", forced = "hippocratic oath")
	else
		return fuck_it_up(user)

	to_chat(user, span_notice("O contentamento, a compreensão e o propósito lavam sobre você enquanto termina o juramento. Considere por um segundo o conceito de dano e tremor."))
	ADD_TRAIT(user, TRAIT_PACIFISM, type)

// Bully the guy for fucking up.
/obj/item/statuebust/hippocratic/proc/fuck_it_up(mob/living/carbon/user)
	to_chat(user, span_warning("Você esquece o que vem depois como um idiota. O busto dos Hipócrates olha para você, desapontado."))
	user.adjust_organ_loss(ORGAN_SLOT_BRAIN, 2)
	COOLDOWN_RESET(src, oath_cd)

/obj/item/maneki_neko
	name = "Maneki-Neko"
	desc = "Uma estatueta de um gato segurando uma moeda, disse para trazer fortuna e riqueza, e permanentemente mover sua pata em um gesto acenando."
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "maneki-neko"
	w_class = WEIGHT_CLASS_SMALL
	force = 5
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	attack_verb_continuous = list("bashes", "beckons", "hit")
	attack_verb_simple = list("bash", "beckon", "hit")

/obj/item/maneki_neko/Initialize(mapload)
	. = ..()
	//Not compatible with greyscale configs because it's animated.
	add_atom_colour(pick_weight(list(COLOR_WHITE = 3, COLOR_GOLD = 2, COLOR_DARK = 1)), FIXED_COLOUR_PRIORITY)
	var/mutable_appearance/neko_overlay = mutable_appearance(icon, "maneki-neko-overlay", appearance_flags = RESET_COLOR|KEEP_APART)
	add_overlay(neko_overlay)
	AddElement(/datum/element/art, GOOD_ART)
	AddElement(/datum/element/beauty, 800)
