/datum/martial_art/mushpunch
	name = "Mushroom Punch"
	id = MARTIALART_MUSHPUNCH

/datum/martial_art/mushpunch/harm_act(mob/living/attacker, mob/living/defender)
	INVOKE_ASYNC(src, PROC_REF(charge_up_attack), attacker, defender)
	return MARTIAL_ATTACK_SUCCESS

/datum/martial_art/mushpunch/proc/charge_up_attack(mob/living/attacker, mob/living/defender)

	to_chat(attacker, span_spiderbroodmother("Você começa a acabar com um ataque..."))
	if(!do_after(attacker, 2.5 SECONDS, defender))
		to_chat(attacker, span_spiderbroodmother("<b>Seu ataque foi interrompido!</b>"))
		return

	var/final_damage = rand(15, 30)
	var/atk_verb = pick("punch", "smash", "crack")
	if(defender.check_block(attacker, final_damage, "[attacker]'s [atk_verb]", UNARMED_ATTACK))
		return

	attacker.do_attack_animation(defender, ATTACK_EFFECT_PUNCH)
	defender.visible_message(
		span_danger("[attacker] [atk_verb]Ed[defender]com tanta força desumana que envia[defender.p_them()]Voando para trás!"), 		span_userdanger("Você é[atk_verb]ed por[attacker]Com tanta força desumana que te faz voar para trás!"),
		span_hear("Você ouve um som doentio de carne batendo em carne!"),
		null,
		attacker,
	)
	to_chat(attacker, span_danger("Você.[atk_verb] [defender]com tanta força desumana que envia[defender.p_them()]Voando para trás!"))
	defender.apply_damage(final_damage, attacker.get_attack_type())
	playsound(defender, 'sound/effects/meteorimpact.ogg', 25, TRUE, -1)
	var/throwtarget = get_edge_target_turf(attacker, get_dir(attacker, get_step_away(defender, attacker)))
	defender.throw_at(throwtarget, 4, 2, attacker)//So stuff gets tossed around at the same time.
	defender.Paralyze(2 SECONDS)
	log_combat(attacker, defender, "[atk_verb] (Mushroom Punch)")

/obj/item/mushpunch
	name = "odd mushroom"
	desc = "<I>Sapienza Ophioglossoides</I>Um cogumelo estranho da carne de um cogumelo. Ele aparentemente reteve algum poder inato de seu dono, como ele treme com poder mal contido!"
	icon = 'icons/obj/service/hydroponics/seeds.dmi'
	icon_state = "mycelium-angel"

/obj/item/mushpunch/attack_self(mob/living/user)
	if(!istype(user))
		return
	to_chat(user, span_spiderbroodmother("Você devora.[src]E uma confluência de habilidade e poder do cogumelo aumenta seus socos! Você precisa de um momento para carregar esses socos poderosos."))
	var/datum/martial_art/mushpunch/mush = new(user)
	mush.teach(user)
	visible_message(
		span_warning("[user]devora[src]."),
		span_notice("Você devora.[src]."),
	)

	qdel(src)
