//His Grace is a very special weapon granted only to traitor chaplains.
//When awakened, He thirsts for blood and begins ticking a "bloodthirst" counter.
//The wielder of His Grace is immune to stuns and gradually heals.
//If the wielder fails to feed His Grace in time, He will devour them and become incredibly aggressive.
//Leaving His Grace alone for some time will reset His thirst and put Him to sleep.
//Using His Grace effectively requires extreme speed and care.
/obj/item/his_grace
	name = "artistic toolbox"
	desc = "Uma caixa de ferramentas pintada de verde brilhante. Olhar para ele te deixa desconfortável."
	icon = 'icons/obj/storage/toolbox.dmi'
	icon_state = "green"
	inhand_icon_state = "toolbox_green"
	lefthand_file = 'icons/mob/inhands/equipment/toolbox_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/toolbox_righthand.dmi'
	w_class = WEIGHT_CLASS_GIGANTIC
	force = 12
	demolition_mod = 1.25
	attack_verb_continuous = list("robusts")
	attack_verb_simple = list("robust")
	hitsound = 'sound/items/weapons/smash.ogg'
	drop_sound = 'sound/items/handling/toolbox/toolbox_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbox/toolbox_pickup.ogg'
	gender = MALE
	var/awakened = FALSE
	var/bloodthirst = HIS_GRACE_SATIATED
	var/prev_bloodthirst = HIS_GRACE_SATIATED
	var/force_bonus = 0
	var/ascended = FALSE
	var/victims_needed = 25
	var/ascend_bonus = 15

/obj/item/his_grace/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool,/obj/item/slimepotion/genderchange))
		var/turf/T = get_turf(src)
		var/mob/living/holder
		if(istype(loc, /mob/living))
			holder = loc
		if(gender == MALE)
			gender = FEMALE
			if(awakened)
				name = "Her Grace"
			else if (!ascended)
				desc = "Uma caixa de ferramentas pintada de rosa brilhante. Olhar para ele te deixa desconfortável."
			icon_state = "pink"
			inhand_icon_state = "toolbox_pink"
			T.visible_message(span_boldwarning("[src] Começa a parecer um pouco... feminina?"))
		else if(gender == FEMALE)
			gender = MALE
			if(awakened)
				name = "His Grace"
			else if (!ascended)
				desc = "Uma caixa de ferramentas pintada de verde brilhante. Olhar para ele te deixa desconfortável."
			icon_state = "green"
			inhand_icon_state = "toolbox_green"
			T.visible_message(span_boldwarning("[src] Começa a parecer um pouco mais... viril?"))
		if(holder)
			holder.remove_status_effect(/datum/status_effect/his_grace)
		qdel(tool)
		return ITEM_INTERACT_SUCCESS
	return NONE
/obj/item/his_grace/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSprocessing, src)
	SSpoints_of_interest.make_point_of_interest(src)
	RegisterSignal(src, COMSIG_MOVABLE_POST_THROW, PROC_REF(move_gracefully))
	update_appearance()

/obj/item/his_grace/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	for(var/mob/living/L in src)
		L.forceMove(get_turf(src))
	return ..()

/obj/item/his_grace/update_icon_state()
	if(ascended)
		icon_state = "gold"
		inhand_icon_state = "toolbox_gold"
	else if(gender == MALE)
		icon_state = "green"
		inhand_icon_state = "toolbox_green"
	else if(gender == FEMALE)
		icon_state = "pink"
		inhand_icon_state = "toolbox_pink"
	return ..()

/obj/item/his_grace/update_overlays()
	. = ..()
	if(ascended)
		. += "triple_latch"
	else if(awakened)
		. += "single_latch_open"
	else
		. += "single_latch"

/obj/item/his_grace/attack_self(mob/living/user)
	if(!awakened)
		INVOKE_ASYNC(src, PROC_REF(awaken), user)

/obj/item/his_grace/attack(mob/living/M, mob/user)
	if(awakened && M.stat)
		if(gender == FEMALE)
			var/dx = M.x - user.x
			var/dy = M.y - user.y
			if(dx && dy)
				var/obj/item/reagent_containers/spray/chemsprayer/party/party_popper = new /obj/item/reagent_containers/spray/chemsprayer/party(get_turf(user))
				dx = dx / abs(dx)
				dy = dy / abs(dy)
				party_popper.spray(locate(M.x + dx * 2, M.y + dy * 2, M.z), user)
				qdel(party_popper)
		consume(M)
	else
		..()

/obj/item/his_grace/item_ctrl_click(mob/user)
	//you can't pull his grace
	return NONE

/obj/item/his_grace/examine(mob/user)
	. = ..()
	if(awakened)
		switch(bloodthirst)
			if(HIS_GRACE_SATIATED to HIS_GRACE_PECKISH)
				. += span_his_grace("[src] Não está com muita fome. Ainda não.")
			if(HIS_GRACE_PECKISH to HIS_GRACE_HUNGRY)
				. += span_his_grace("[src] Gostaria de um lanche.")
			if(HIS_GRACE_HUNGRY to HIS_GRACE_FAMISHED)
				. += span_his_grace("[src] Está com muita fome agora.")
			if(HIS_GRACE_FAMISHED to HIS_GRACE_STARVING)
				. += span_his_grace("[src] está salivando abertamente ao vê-lo. Tenha cuidado.")
			if(HIS_GRACE_STARVING to HIS_GRACE_CONSUME_OWNER)
				. += "<span class='his_grace bold'>You walk a fine line. [src] is very close to devouring you.</span>"
			if(HIS_GRACE_CONSUME_OWNER to HIS_GRACE_FALL_ASLEEP)
				. += "<span class='his_grace bold'>[src] is shaking violently and staring directly at you.</span>"
	else
		. += span_his_grace("[src] Está fechado.")

/obj/item/his_grace/relaymove(mob/living/user, direction) //Allows changelings, etc. to climb out of Him after they revive, provided He isn't active
	if(!awakened)
		user.forceMove(get_turf(src))
		user.visible_message(span_warning("[user] Mexidos para fora [src]!"), span_notice("Você sai [src]!"))

/obj/item/his_grace/process(seconds_per_tick)
	if(!bloodthirst)
		drowse()
		return
	if(bloodthirst < HIS_GRACE_CONSUME_OWNER && !ascended)
		adjust_bloodthirst((1 + FLOOR(LAZYLEN(contents) * 0.5, 1)) * seconds_per_tick) //Maybe adjust this?
	else
		adjust_bloodthirst(1 * seconds_per_tick) //don't cool off rapidly once we're at the point where His Grace consumes all.
	var/mob/living/master = get_atom_on_turf(src, /mob/living)
	if(!isnull(master) && (src in master.held_items))
		switch(bloodthirst)
			if(HIS_GRACE_CONSUME_OWNER to HIS_GRACE_FALL_ASLEEP)
				master.visible_message(span_boldwarning("[src] Liga.[master]!"), "<span class='his_grace big bold'>[src] Se vira contra você!</span>")
				do_attack_animation(master, null, src)
				master.emote("scream")
				master.remove_status_effect(/datum/status_effect/his_grace)
				REMOVE_TRAIT(src, TRAIT_NODROP, HIS_GRACE_TRAIT)
				master.Paralyze(60)
				master.adjust_brute_loss(master.maxHealth)
				playsound(master, 'sound/effects/splat.ogg', 100, FALSE)
			else
				master.apply_status_effect(/datum/status_effect/his_grace,gender)
		return
	forceMove(get_turf(src)) //no you can't put His Grace in a locker you just have to deal with Him
	if(bloodthirst < HIS_GRACE_CONSUME_OWNER)
		return
	if(bloodthirst >= HIS_GRACE_FALL_ASLEEP)
		drowse()
		return
	var/list/targets = list()
	for(var/mob/living/L in oview(2, src))
		targets += L
	if(!LAZYLEN(targets))
		return
	var/mob/living/L = pick(targets)
	step_to(src, L)
	if(Adjacent(L))
		if(!L.stat)
			L.visible_message(span_warning("[src] Pulmões em [L]!"), "<span class='his_grace big bold'>[src] Pulgas em você!</span>")
			do_attack_animation(L, null, src)
			playsound(L, 'sound/items/weapons/smash.ogg', 50, TRUE)
			playsound(L, 'sound/effects/desecration/desecration-01.ogg', 50, TRUE)
			L.adjust_brute_loss(force)
			adjust_bloodthirst(-5) //Don't stop attacking they're right there!
		else
			consume(L)

/obj/item/his_grace/proc/awaken(mob/user) //Good morning, Mr. Grace.
	if(awakened)
		return
	awakened = TRUE
	user.visible_message(span_boldwarning("[src] Começa a chocalhar.[p_They()] sedes."), span_his_grace("Você filma [src] Está travado. Você espera que isso seja uma boa ideia."))
	name = p_Their() + " Grace"
	desc = "Um artefato sanguinário criado por um rito profano."
	adjust_bloodthirst(1)
	force_bonus = HIS_GRACE_FORCE_BONUS * LAZYLEN(contents)
	notify_ghosts(
		"[user.real_name] has awoken [src]!",
		source = src,
		header = "Salve[src]!",
	)
	playsound(user, 'sound/effects/pope_entry.ogg', 100)
	update_appearance()
	move_gracefully()

/obj/item/his_grace/proc/move_gracefully()
	SIGNAL_HANDLER

	if(!awakened)
		return

	spasm_animation()

/obj/item/his_grace/proc/drowse() //Good night, Mr. Grace.
	if(!awakened || ascended)
		return
	var/turf/T = get_turf(src)
	T.visible_message(span_boldwarning("[src] lentamente pára de bater e cai ainda,[p_Their()] Fechando o fecho."))
	playsound(loc, 'sound/items/weapons/batonextend.ogg', 100, TRUE)
	name = initial(name)
	if(gender == MALE)
		desc = "Uma caixa de ferramentas pintada de verde brilhante. Olhar para ele te deixa desconfortável."
	else if (gender == FEMALE)
		desc = "Uma caixa de ferramentas pintada de rosa brilhante. Olhar para ele te deixa desconfortável."
	animate(src, transform=matrix())
	force = initial(force)
	force_bonus = initial(force_bonus)
	awakened = FALSE
	bloodthirst = 0
	update_appearance()

/obj/item/his_grace/proc/consume(mob/living/meal) //Here's your dinner, Mr. Grace.
	if(!meal)
		return
	var/victims = 0
	meal.visible_message(span_warning("[src] Balance e devora [meal]!"), "<span class='his_grace big bold'>[src] Te consome!</span>")
	meal.adjust_brute_loss(200)
	playsound(meal, 'sound/effects/desecration/desecration-02.ogg', 75, TRUE)
	playsound(src, 'sound/items/eatfood.ogg', 100, TRUE)
	meal.forceMove(src)
	force_bonus += HIS_GRACE_FORCE_BONUS
	prev_bloodthirst = bloodthirst
	if(prev_bloodthirst < HIS_GRACE_CONSUME_OWNER)
		bloodthirst = max(LAZYLEN(contents), 1) //Never fully sated, and His hunger will only grow.
	else
		bloodthirst = HIS_GRACE_CONSUME_OWNER
	for(var/mob/living/C in contents)
		if(C.mind)
			victims++
	if(victims >= victims_needed)
		ascend()
	update_stats()

/obj/item/his_grace/proc/adjust_bloodthirst(amt)
	prev_bloodthirst = bloodthirst
	if(prev_bloodthirst < HIS_GRACE_CONSUME_OWNER && !ascended)
		bloodthirst = clamp(bloodthirst + amt, HIS_GRACE_SATIATED, HIS_GRACE_CONSUME_OWNER)
	else if(!ascended)
		bloodthirst = clamp(bloodthirst + amt, HIS_GRACE_CONSUME_OWNER, HIS_GRACE_FALL_ASLEEP)
	update_stats()

/obj/item/his_grace/proc/update_stats()
	REMOVE_TRAIT(src, TRAIT_NODROP, HIS_GRACE_TRAIT)
	var/mob/living/master = get_atom_on_turf(src, /mob/living)
	if (isnull(master))
		return
	switch(bloodthirst)
		if(HIS_GRACE_CONSUME_OWNER to HIS_GRACE_FALL_ASLEEP)
			if(HIS_GRACE_CONSUME_OWNER > prev_bloodthirst)
				master.visible_message(span_userdanger("[src] Entra em um frenesi!"))
		if(HIS_GRACE_STARVING to HIS_GRACE_CONSUME_OWNER)
			ADD_TRAIT(src, TRAIT_NODROP, HIS_GRACE_TRAIT)
			if(HIS_GRACE_STARVING > prev_bloodthirst)
				master.visible_message(span_boldwarning("[src] Está faminto!"), "<span class='his_grace big'>[src] A sede de sangue te vence.[src] deve ser alimentado, ou você vai se tornar [p_Their()] Refeição.[force_bonus < 15 ? " And still, [p_Their()] power grows.":""]</span>")
				force_bonus = max(force_bonus, 15)
		if(HIS_GRACE_FAMISHED to HIS_GRACE_STARVING)
			ADD_TRAIT(src, TRAIT_NODROP, HIS_GRACE_TRAIT)
			if(HIS_GRACE_FAMISHED > prev_bloodthirst)
				master.visible_message(span_warning("[src] Está com muita fome!"), "<span class='his_grace big'>Espinhos afundam em sua mão.[src] Deve se alimentar imediatamente.[force_bonus < 10 ? " [p_Their()] power grows.":""]</span>")
				force_bonus = max(force_bonus, 10)
			if(prev_bloodthirst >= HIS_GRACE_STARVING)
				master.visible_message(span_warning("[src] Agora só tem muita fome!"), "<span class='his_grace big'>Sua sede de sangue diminui.</span>")
		if(HIS_GRACE_HUNGRY to HIS_GRACE_FAMISHED)
			if(HIS_GRACE_HUNGRY > prev_bloodthirst)
				master.visible_message(span_warning("[src] está ficando com fome."), "<span class='his_grace big'>Você sente [src] Está com fome dentro de você.[force_bonus < 5 ? " [p_Their()] power grows.":""]</span>")
				force_bonus = max(force_bonus, 5)
			if(prev_bloodthirst >= HIS_GRACE_FAMISHED)
				master.visible_message(span_warning("[src] está agora apenas um pouco faminto."), span_his_grace("[src] A fome diminui um pouco..."))
		if(HIS_GRACE_PECKISH to HIS_GRACE_HUNGRY)
			if(HIS_GRACE_PECKISH > prev_bloodthirst)
				master.visible_message(span_warning("[src] está se sentindo como um lanche."), span_his_grace("[src] começa a fome."))
			if(prev_bloodthirst >= HIS_GRACE_HUNGRY)
				master.visible_message(span_warning("[src] Agora está com um pouco de fome."), "<span class='his_grace big'>[src] A fome diminui um pouco...</span>")
		if(HIS_GRACE_SATIATED to HIS_GRACE_PECKISH)
			if(prev_bloodthirst >= HIS_GRACE_PECKISH)
				master.visible_message(span_warning("[src] Está saciado."), "<span class='his_grace big'>[src] A fome diminui...</span>")
	force = initial(force) + force_bonus

/obj/item/his_grace/proc/ascend()
	if(ascended)
		return
	var/mob/living/carbon/human/master = loc
	force_bonus += ascend_bonus
	desc = "Uma lendária caixa de ferramentas e um artefato distante da Era dos Três Poderes. Em suas três travas gravadas estão as palavras\"O Sol\", \"A Lua\", e\"As Estrelas\"Toda a caixa de ferramentas tem as palavras\"O Mundo\"gravado em seus lados."
	ascended = TRUE
	update_appearance()
	playsound(src, 'sound/effects/his_grace/his_grace_ascend.ogg', 100)
	if(istype(master))
		master.update_held_items()
		master.visible_message("<span class='his_grace big bold'>Os deuses estarão observando.</span>")
		name = "[master]'s mythical toolbox of three powers"
		master.client?.give_award(/datum/award/achievement/misc/ascension, master)
