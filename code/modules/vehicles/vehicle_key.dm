/obj/item/key
	name = "key"
	desc = "Uma Pequena Chave Cinza."
	icon = 'icons/mob/rideables/vehicles.dmi'
	icon_state = "key"
	w_class = WEIGHT_CLASS_TINY

/obj/item/key/atv
	name = "ATV key"
	desc = "Uma pequena chave cinza para iniciar e operar ATVs."

/obj/item/key/security
	desc = "Um chaveiro com uma pequena chave de aço, e um acessório de bastão de borracha."
	icon_state = "keysec"

/obj/item/key/security/suicide_act(mob/living/carbon/user)
	if(!user.emote("spin")) //In the off chance that someone attempts this suicide while under the effects of mime's bane they deserve the silliness.
		user.visible_message(span_suicide("[user]está colocando\the [src]Em[user.p_their()]Ouvir e começar[user.p_their()]Motor! Parece que...[user.p_theyre()]Tentando cometer suicídio... Mas[user.p_they()]Sputters e stalls para fora!"))
		playsound(src, 'sound/misc/sadtrombone.ogg', 50, TRUE, -1)
		return SHAME
	user.visible_message(span_suicide("[user]está colocando\the [src]Em[user.p_their()]Ouvir e começar[user.p_their()]Motor! Parece que...[user.p_theyre()]Tentando cometer suicídio!"))
	user.say("Vroom vroom!!", forced="secway key suicide") //Not doing a shamestate here, because even if they fail to speak they're spinning.
	addtimer(CALLBACK(user, TYPE_PROC_REF(/mob/living/, gib)), 2 SECONDS)
	return MANUAL_SUICIDE

/obj/item/key/janitor
	desc = "Um chaveiro com uma pequena chave de aço, e uma leitura rosa fob\"Vagabunda.\"."
	icon_state = "keyjanitor"
	icon_angle = 90
	force = 2
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 9
	hitsound = SFX_SWING_HIT
	attack_verb_continuous = list("stubs", "pokes")
	attack_verb_simple = list("stub", "poke")
	sharpness = SHARP_EDGED
	embed_type = /datum/embedding/janicart_key
	wound_bonus = -1
	exposed_wound_bonus = 2

/datum/embedding/janicart_key
	pain_mult = 1
	embed_chance = 30
	fall_chance = 70

/obj/item/key/janitor/suicide_act(mob/living/carbon/user)
	switch(user.mind?.get_skill_level(/datum/skill/cleaning))
		if(SKILL_LEVEL_NONE to SKILL_LEVEL_NOVICE) //Their mind is too weak to ascend as a janny
			user.visible_message(span_suicide("[user]está colocando\the [src]Em[user.p_their()]boca e está tentando se tornar um com o janicart, mas não tem idéia por onde começar! Parece que...[user.p_theyre()]Tentando cometer suicídio!"))
			user.gib(DROP_ALL_REMAINS)
			return MANUAL_SUICIDE
		if(SKILL_LEVEL_APPRENTICE to SKILL_LEVEL_JOURNEYMAN) //At least they tried
			user.visible_message(span_suicide("[user]está colocando\the [src]Em[user.p_their()]boca e ineficientemente se tornou um com o janicart! Parece que...[user.p_theyre()]Tentando cometer suicídio!"))
			user.AddElement(/datum/element/cleaning)
			addtimer(CALLBACK(src, PROC_REF(manual_suicide), user), 5.1 SECONDS)
			return MANUAL_SUICIDE
		if(SKILL_LEVEL_EXPERT to SKILL_LEVEL_MASTER) //They are worthy enough, but can it go even further beyond?
			user.visible_message(span_suicide("[user]está colocando\the [src]Em[user.p_their()]boca e habilmente se tornou um com o janicart! Parece que...[user.p_theyre()]Tentando cometer suicídio!"))
			user.AddElement(/datum/element/cleaning)
			for(var/i in 1 to 100)
				addtimer(CALLBACK(user, TYPE_PROC_REF(/atom, add_atom_colour), (i % 2)? "#a245bb" : "#7a7d82", ADMIN_COLOUR_PRIORITY), i)
			addtimer(CALLBACK(src, PROC_REF(manual_suicide), user), 101)
			return MANUAL_SUICIDE
		if(SKILL_LEVEL_LEGENDARY to INFINITY) //Holy shit, look at that janny go!
			user.visible_message(span_suicide("[user]está colocando\the [src]Em[user.p_their()]boca e épicamente tornou-se um com o janicart, e eles estão mesmo em modo overdrive! Parece que...[user.p_theyre()]Tentando cometer suicídio!"))
			user.AddElement(/datum/element/cleaning)
			playsound(src, 'sound/effects/magic/lightning_chargeup.ogg', 50, TRUE, -1)
			user.reagents.add_reagent(/datum/reagent/drug/methamphetamine, 10) //Gotta go fast!
			for(var/i in 1 to 150)
				addtimer(CALLBACK(user, TYPE_PROC_REF(/atom, add_atom_colour), (i % 2)? "#a245bb" : "#7a7d82", ADMIN_COLOUR_PRIORITY), i)
			addtimer(CALLBACK(src, PROC_REF(manual_suicide), user), 151)
			return MANUAL_SUICIDE

/obj/item/key/proc/manual_suicide(mob/living/user)
	if(user)
		user.remove_atom_colour(ADMIN_COLOUR_PRIORITY)
		user.visible_message(span_suicide("[user]Esqueci.[user.p_they()]Não é realmente um janicart! Isso é um paddlin!"))
		if(user.mind?.get_skill_level(/datum/skill/cleaning) >= SKILL_LEVEL_LEGENDARY) //Janny janny janny janny janny
			playsound(src, 'sound/effects/adminhelp.ogg', 50, TRUE, -1)
		user.adjust_oxy_loss(200)
		user.death(FALSE)

/obj/item/key/lasso
	name = "bone lasso"
	desc = "A ferramenta perfeita para dirigir um Golias! Se isso os fizesse se moverem mais rápido..."
	force = 12
	icon_state = "lasso"
	inhand_icon_state = "chain"
	worn_icon_state = "whip"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	attack_verb_continuous = list("flogs", "whips", "lashes", "disciplines")
	attack_verb_simple = list("flog", "whip", "lash", "discipline")
	hitsound = 'sound/items/weapons/whip.ogg'
	slot_flags = ITEM_SLOT_BELT
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)
