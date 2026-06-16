/*
	Blunt/Bone wounds
*/
// TODO: well, a lot really, but i'd kill to get overlays and a bonebreaking effect like Blitz: The League, similar to electric shock skeletons

/datum/wound_pregen_data/bone
	abstract = TRUE
	required_limb_biostate = BIO_BONE

	required_wounding_type = WOUND_BLUNT

	wound_series = WOUND_SERIES_BONE_BLUNT_BASIC

/datum/wound/blunt/bone
	name = "Blunt (Bone) Wound"
	wound_flags = (ACCEPTS_GAUZE | SPLINT_OVERLAY) // SKYRAT EDIT: MEDICAL -- Makes bone wounds have a splint overlay

	default_scar_file = BONE_SCAR_FILE
	threshold_penalty = 5

	/// Have we been bone gel'd?
	var/gelled
	/// Have we been taped?
	var/taped
	/// If we did the gel + surgical tape healing method for fractures, how many ticks does it take to heal by default
	var/regen_ticks_needed
	/// Our current counter for gel + surgical tape regeneration
	var/regen_ticks_current
	/// If we suffer severe head booboos, we can get brain traumas tied to them
	var/datum/brain_trauma/active_trauma
	/// What brain trauma group, if any, we can draw from for head wounds
	var/brain_trauma_group
	/// If we deal brain traumas, when is the next one due?
	var/next_trauma_cycle
	/// How long do we wait +/- 20% for the next trauma?
	var/trauma_cycle_cooldown
	/// If this is a chest wound and this is set, we have this chance to cough up blood when hit in the chest
	var/internal_bleeding_chance = 0

/*
	Overwriting of base procs
*/
/datum/wound/blunt/bone/wound_injury(datum/wound/old_wound = null, attack_direction = null)
	// hook into gaining/losing gauze so crit bone wounds can re-enable/disable depending if they're slung or not
	if(limb.body_zone == BODY_ZONE_HEAD && brain_trauma_group)
		processes = TRUE
		active_trauma = victim.gain_trauma_type(brain_trauma_group, TRAUMA_RESILIENCE_WOUND)
		next_trauma_cycle = world.time + (rand(100-WOUND_BONE_HEAD_TIME_VARIANCE, 100+WOUND_BONE_HEAD_TIME_VARIANCE) * 0.01 * trauma_cycle_cooldown)

	if(limb.held_index && victim.get_item_for_held_index(limb.held_index) && (disabling || prob(30 * severity)))
		var/obj/item/I = victim.get_item_for_held_index(limb.held_index)
		if(istype(I, /obj/item/offhand))
			I = victim.get_inactive_held_item()

		if(I && victim.dropItemToGround(I))
			victim.visible_message(span_danger("[victim] Gotas [I] Em choque!"), span_warning("<b>A força em seu [limb.plaintext_zone] Faz você cair.[I]!</b>"), vision_distance=COMBAT_MESSAGE_RANGE)

	update_inefficiencies()
	return ..()

/datum/wound/blunt/bone/set_victim(new_victim)

	if (victim)
		UnregisterSignal(victim, list(COMSIG_LIVING_UNARMED_ATTACK, COMSIG_MOB_FIRED_GUN))
	if (new_victim)
		RegisterSignal(new_victim, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(attack_with_hurt_hand))
		RegisterSignal(new_victim, COMSIG_MOB_FIRED_GUN, PROC_REF(firing_with_messed_up_hand))

	return ..()

/datum/wound/blunt/bone/remove_wound(ignore_limb, replaced, destroying)
	limp_slowdown = 0
	limp_chance = 0
	QDEL_NULL(active_trauma)
	return ..()

/datum/wound/blunt/bone/handle_process(seconds_per_tick)
	. = ..()

	if (!victim || HAS_TRAIT(victim, TRAIT_STASIS))
		return

	if(limb.body_zone == BODY_ZONE_HEAD && brain_trauma_group && world.time > next_trauma_cycle)
		if(active_trauma)
			QDEL_NULL(active_trauma)
		else
			active_trauma = victim.gain_trauma_type(brain_trauma_group, TRAUMA_RESILIENCE_WOUND)
		next_trauma_cycle = world.time + (rand(100-WOUND_BONE_HEAD_TIME_VARIANCE, 100+WOUND_BONE_HEAD_TIME_VARIANCE) * 0.01 * trauma_cycle_cooldown)

	var/is_bone_limb = ((limb.biological_state & BIO_BONE) && !(limb.biological_state & (BIO_FLESH|BIO_CHITIN)))
	if(!gelled || (!taped && !is_bone_limb))
		return

	regen_ticks_current++
	if(victim.body_position == LYING_DOWN)
		if(SPT_PROB(30, seconds_per_tick))
			regen_ticks_current += 1
		if(victim.IsSleeping() && SPT_PROB(30, seconds_per_tick))
			regen_ticks_current += 1

	if(!is_bone_limb && SPT_PROB(severity * 1.5, seconds_per_tick))
		victim.take_bodypart_damage(rand(1, severity * 2), wound_bonus=CANT_WOUND)
		victim.adjust_stamina_loss(rand(2, severity * 2.5))
		if(prob(33))
			to_chat(victim, span_danger("Você sente uma dor aguda em seu corpo enquanto seus ossos estão se reformando!"))

	if(regen_ticks_current > regen_ticks_needed)
		if(!victim || !limb)
			qdel(src)
			return
		to_chat(victim, span_green("Sua [limb.plaintext_zone] Se recuperar de sua [LOWER_TEXT(undiagnosed_name || name)]!"))
		remove_wound()

/// If we're a human who's punching something with a broken arm, we might hurt ourselves doing so
/datum/wound/blunt/bone/proc/attack_with_hurt_hand(mob/M, atom/target, proximity)
	SIGNAL_HANDLER

	if(victim.get_active_hand() != limb || !proximity || !victim.combat_mode || !ismob(target) || severity <= WOUND_SEVERITY_MODERATE)
		return NONE

	// With a severe or critical wound, you have a 15% or 30% chance to proc pain on hit
	if(prob((severity - 1) * 15))
		// And you have a 70% or 50% chance to actually land the blow, respectively
		if(HAS_TRAIT(victim, TRAIT_ANALGESIA) || prob(70 - 20 * (severity - 1)))
			if(!HAS_TRAIT(victim, TRAIT_ANALGESIA))
				to_chat(victim, span_danger("A fraternidade em seu [limb.plaintext_zone] Atira com dor entao bate [target]!"))
			victim.apply_damage(rand(1, 5), BRUTE, limb, wound_bonus = CANT_WOUND, wound_clothing = FALSE)
		else
			victim.visible_message(span_danger("[victim] Ataques fracos [target] Com [victim.p_their()] Quebrado.[limb.plaintext_zone], recobrindo um dor!"), 			span_userdanger("Você falhou em atacar.[target] como a fratura em seu [limb.plaintext_zone] Luzes em dor insuportável!"), vision_distance=COMBAT_MESSAGE_RANGE)
			INVOKE_ASYNC(victim, TYPE_PROC_REF(/mob, emote), "scream")
			victim.Stun(0.5 SECONDS)
			victim.apply_damage(rand(3, 7), BRUTE, limb, wound_bonus = CANT_WOUND, wound_clothing = FALSE)
			return COMPONENT_CANCEL_ATTACK_CHAIN

	return NONE

/// If we're a human who's firing a gun with a broken arm, we might hurt ourselves doing so
/datum/wound/blunt/bone/proc/firing_with_messed_up_hand(datum/source, obj/item/gun/gun, atom/firing_at, params, zone, bonus_spread_values)
	SIGNAL_HANDLER

	switch(limb.body_zone)
		if(BODY_ZONE_L_ARM)
			// Heavy guns use both hands so they will always get a penalty
			// (Yes, this means having two broken arms will make heavy weapons SOOO much worse)
			// Otherwise make sure THIS hand is firing THIS gun
			if(gun.weapon_weight <= WEAPON_MEDIUM && !IS_LEFT_INDEX(victim.get_held_index_of_item(gun)))
				return

		if(BODY_ZONE_R_ARM)
			// Ditto but for right arm
			if(gun.weapon_weight <= WEAPON_MEDIUM && !IS_RIGHT_INDEX(victim.get_held_index_of_item(gun)))
				return

		else
			// This is not arm wound, so we don't care
			return

	if(gun.recoil > 0 && severity >= WOUND_SEVERITY_SEVERE && prob(25 * (severity - 1)))
		if(!HAS_TRAIT(victim, TRAIT_ANALGESIA))
			to_chat(victim, span_danger("A fraternidade em seu [limb.plaintext_zone] explode com a dor como [gun] Chuta de volta!"))
		victim.apply_damage(rand(1, 3) * (severity - 1) * gun.weapon_weight, BRUTE, limb, wound_bonus = CANT_WOUND, wound_clothing = FALSE)

	if(!HAS_TRAIT(victim, TRAIT_ANALGESIA))
		bonus_spread_values[MAX_BONUS_SPREAD_INDEX] += (15 * severity * limb.get_splint_factor())

/datum/wound/blunt/bone/receive_damage(wounding_type, wounding_dmg, wound_bonus)
	if(!victim || wounding_dmg < WOUND_MINIMUM_DAMAGE || !victim.can_bleed())
		return

	if(limb.body_zone == BODY_ZONE_CHEST && victim.get_blood_volume() && prob(internal_bleeding_chance + wounding_dmg))
		var/blood_bled = rand(1, wounding_dmg * (severity == WOUND_SEVERITY_CRITICAL ? 2 : 1.5)) // 12 brute toolbox can cause up to 18/24 bleeding with a severe/critical chest wound
		switch(blood_bled)
			if(1 to 6)
				victim.bleed(blood_bled, TRUE)
			if(7 to 13)
				victim.visible_message(
					span_smalldanger("Um fim fluxo de sangue escorre de [victim]'s boca do golpe para [victim.p_their()] Peito."),
					span_danger("Você tosse um pouco de sangue do golpe no peito."),
					vision_distance = COMBAT_MESSAGE_RANGE,
				)
				victim.bleed(blood_bled, TRUE)
			if(14 to 19)
				victim.visible_message(
					span_smalldanger("O sangue jorra [victim]'s boca do golpe para [victim.p_their()] Baú!"),
					span_danger("Você cuspiu uma corda de sangue do golpe no seu peito!"),
					vision_distance = COMBAT_MESSAGE_RANGE,
				)
				victim.create_splatter(victim.dir)
				victim.bleed(blood_bled)
			if(20 to INFINITY)
				victim.visible_message(
					span_danger("Sangue jorrando [victim]'s boca do golpe para [victim.p_their()] Baú!"),
					span_bolddanger("Você engasga com um spray de sangue do golpe no peito!"),
					vision_distance = COMBAT_MESSAGE_RANGE,
				)
				victim.bleed(blood_bled)
				victim.create_splatter(victim.dir)
				victim.add_splatter_floor(get_step(victim.loc, victim.dir))

/datum/wound/blunt/bone/modify_desc_before_span(desc)
	. = ..()

	var/obj/item/stack/medical/wrap/current_gauze = LAZYACCESS(limb.applied_items, LIMB_ITEM_GAUZE)
	if (!current_gauze)
		if(taped)
			. += ", [span_notice("and appears to be reforming itself under some surgical tape!")]"
		else if(gelled)
			. += ", [span_notice("with fizzing flecks of blue bone gel sparking off the bone!")]"

/datum/wound/blunt/get_limb_examine_description()
	return span_warning("Os ossos deste mês estão quebrando.")

/*
	New common procs for /datum/wound/blunt/bone/
*/

/datum/wound/blunt/bone/get_scar_file(obj/item/bodypart/scarred_limb, add_to_scars)
	if (scarred_limb.biological_state & BIO_BONE && (!(scarred_limb.biological_state & BIO_FLESH))) // only bone
		return BONE_SCAR_FILE
	else if (scarred_limb.biological_state & BIO_FLESH && (!(scarred_limb.biological_state & BIO_BONE)))
		return FLESH_SCAR_FILE

	return ..()

/// Joint Dislocation (Moderate Blunt)
/datum/wound/blunt/bone/moderate
	name = "Joint Dislocation"
	undiagnosed_name = "Dislocation"
	a_or_from = "a"
	desc = "O membro do paciente foi desligado da tomada, causando dor e função motora reduzida."
	treat_text = "Aplique Bonsetter no membro afetado. Relocação manual por meio de uma pegada agressiva e um abraço apertado para o membro afetado também pode ser suficiente."
	treat_text_short = "Apply Bonesetter, or manually relocate the limb."
	examine_desc = "Está estranhamente fora do lugar."
	occur_text = "Janks violentamente e fica descalço"
	severity = WOUND_SEVERITY_MODERATE
	interaction_efficiency_penalty = 1.3
	limp_slowdown = 3
	limp_chance = 50
	series_threshold_penalty = 15
	treatable_tools = list(TOOL_BONESET)
	status_effect_type = /datum/status_effect/wound/blunt/bone/moderate
	scar_keyword = "dislocate"

	simple_desc = "O osso do paciente foi deslocado, causando manca ou destino reduzida."
	simple_treat_text = "<b>Enfaixamento</b>A ferida reduzirá seu impacto até ser tratada com um osso. Mais comumente, é tratado por agarrar agressivamente alguém e ajudar a quebrar o membro no lugar, embora haja espaço para má conduta ao fazer isso."
	homemade_treat_text = "Além de bandagem e arrancamento,<b>Setters de ossos</b>pode ser impresso em tornos e usado em si mesmo ao custo de grande dor. Como último recurso,<b>Esmagando</b>O paciente com<b>Firelock.</b>às vezes foi observado para consertar seu membro deslocado."

/datum/wound_pregen_data/bone/dislocate
	abstract = FALSE

	wound_path_to_generate = /datum/wound/blunt/bone/moderate

	required_limb_biostate = BIO_JOINTED

	threshold_minimum = 35

/datum/wound/blunt/bone/moderate/Destroy()
	if(victim)
		UnregisterSignal(victim, COMSIG_LIVING_DOORCRUSHED)
	return ..()

/datum/wound/blunt/bone/moderate/set_victim(new_victim)

	if (victim)
		UnregisterSignal(victim, COMSIG_LIVING_DOORCRUSHED)
	if (new_victim)
		RegisterSignal(new_victim, COMSIG_LIVING_DOORCRUSHED, PROC_REF(door_crush))

	return ..()

/datum/wound/blunt/bone/moderate/get_self_check_description(self_aware)
	return span_warning("Parece deslocado!")

/// Getting smushed in an airlock/firelock is a last-ditch attempt to try relocating your limb
/datum/wound/blunt/bone/moderate/proc/door_crush()
	SIGNAL_HANDLER
	if(prob(40))
		victim.visible_message(span_danger("[victim] Está deslocado.[limb.plaintext_zone] Volta para o lugar!"), span_userdanger("Seu deslocamento [limb.plaintext_zone] Volta para o lugar! Ow!"))
		remove_wound()
		return DOORCRUSH_NO_WOUND
	return NONE

/datum/wound/blunt/bone/moderate/try_handling(mob/living/user)
	if(user.usable_hands <= 0 || user.pulling != victim)
		return FALSE
	if(!isnull(user.hud_used?.screen_objects[HUD_MOB_ZONE_SELECTOR]) && user.zone_selected != limb.body_zone)
		return FALSE

	if(user.grab_state == GRAB_PASSIVE)
		to_chat(user, span_warning("Você deve ter.[victim] em um ataque agressivo para manipular [victim.p_their()] [LOWER_TEXT(undiagnosed_name || name)]!"))
		return TRUE

	if(user.grab_state >= GRAB_AGGRESSIVE)
		user.visible_message(span_danger("[user] Começa a torcer e esticar [victim] Está deslocado.[limb.plaintext_zone]!"), span_notice("Você começa a torcer e forçar [victim] Está deslocado.[limb.plaintext_zone]..."), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] Começa a torcer e forçar o deslocamento.[limb.plaintext_zone]!"))
		if(!user.combat_mode)
			chiropractice(user)
		else
			malpractice(user)
		return TRUE

/// If someone is snapping our dislocated joint back into place by hand with an aggro grab and help intent
/datum/wound/blunt/bone/moderate/proc/chiropractice(mob/living/carbon/human/user)
	var/time = base_treat_time

	if(!do_after(user, time, target=victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return

	if(prob(65))
		user.visible_message(span_danger("[user] Snaps [victim] Está deslocado.[limb.plaintext_zone] De volta ao lugar!"), span_notice("Você estalou.[victim] Está deslocado.[limb.plaintext_zone] De volta ao lugar!"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] Snaps seu deslocado [limb.plaintext_zone] De volta ao lugar!"))
		victim.emote("scream")
		victim.apply_damage(20, BRUTE, limb, wound_bonus = CANT_WOUND)
		qdel(src)
	else
		user.visible_message(span_danger("[user] Chaves [victim] Está deslocado.[limb.plaintext_zone] Em volta dolorosamente!"), span_danger("Sua Chave Inglesa.[victim] Está deslocado.[limb.plaintext_zone] Em volta dolorosamente!"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] Esmaga seu deslocamento.[limb.plaintext_zone] Em volta dolorosamente!"))
		victim.apply_damage(10, BRUTE, limb, wound_bonus = CANT_WOUND)
		chiropractice(user)

/// If someone is snapping our dislocated joint into a fracture by hand with an aggro grab and harm or disarm intent
/datum/wound/blunt/bone/moderate/proc/malpractice(mob/living/carbon/human/user)
	var/time = base_treat_time

	if(!do_after(user, time, target=victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return

	if(prob(65))
		user.visible_message(span_danger("[user] Snaps [victim] Está deslocado.[limb.plaintext_zone] com uma rachadura doentia!"), span_danger("Você estalou.[victim] Está deslocado.[limb.plaintext_zone] com uma rachadura doentia!"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] Snaps seu deslocado [limb.plaintext_zone] com uma rachadura doentia!"))
		victim.emote("scream")
		victim.apply_damage(25, BRUTE, limb, wound_bonus = 30)
	else
		user.visible_message(span_danger("[user] Chaves [victim] Está deslocado.[limb.plaintext_zone] Em volta dolorosamente!"), span_danger("Sua Chave Inglesa.[victim] Está deslocado.[limb.plaintext_zone] Em volta dolorosamente!"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] Esmaga seu deslocamento.[limb.plaintext_zone] Em volta dolorosamente!"))
		victim.apply_damage(10, BRUTE, limb, wound_bonus = CANT_WOUND)
		malpractice(user)

/datum/wound/blunt/bone/moderate/treat(obj/item/tool, mob/user)
	var/scanned = HAS_TRAIT(src, TRAIT_WOUND_SCANNED)
	var/self_penalty_mult = user == victim ? 1.5 : 1
	var/scanned_mult = scanned ? 0.5 : 1
	var/treatment_delay = base_treat_time * self_penalty_mult * scanned_mult

	if(victim == user)
		victim.visible_message(span_danger("[user] Começa[scanned ? "expertly" : ""]Reset [victim.p_their()] [limb.plaintext_zone] Com [tool]."), span_warning("Você começa a redefinir seu [limb.plaintext_zone] Com [tool][scanned ? ", keeping the holo-image's indications in mind" : ""]..."))
	else
		user.visible_message(span_danger("[user] Começa[scanned ? "expertly" : ""]Reset [victim]'s [limb.plaintext_zone] Com [tool]."), span_notice("Você começa a refazer [victim]'s [limb.plaintext_zone] Com [tool][scanned ? ", keeping the holo-image's indications in mind" : ""]..."))

	if(!do_after(user, treatment_delay, target = victim, extra_checks=CALLBACK(src, PROC_REF(still_exists))))
		return

	if(victim == user)
		victim.apply_damage(15, BRUTE, limb, wound_bonus = CANT_WOUND)
		victim.visible_message(span_danger("[user] Termina a redefinição.[victim.p_their()] [limb.plaintext_zone]!"), span_userdanger("Você redefiniu seu [limb.plaintext_zone]!"))
	else
		victim.apply_damage(10, BRUTE, limb, wound_bonus = CANT_WOUND)
		user.visible_message(span_danger("[user] Termina a redefinição.[victim]'s [limb.plaintext_zone]!"), span_nicegreen("Termine de novo.[victim]'s [limb.plaintext_zone]!"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] resets seu [limb.plaintext_zone]!"))

	victim.emote("scream")
	qdel(src)

/*
	Severe (Hairline Fracture)
*/

/datum/wound/blunt/bone/severe
	name = "Hairline Fracture"
	desc = "O osso do paciente sofreu uma rachadura na fundação, causando dor grave e redução da funcionalidade dos membros."
	treat_text = "Consertar cirurgicamente. Em caso de emergência, uma aplicação de gel ósseo sobre a área afetada vai se resolver com o tempo. Uma tala ou funda de gaze médica também pode ser usada para evitar que a fratura piore."
	treat_text_short = "Repair surgically, or apply bone gel. A splint or gauze sling can also be used."
	examine_desc = "Parece grotescamente polegada, Batidas irregulares insinuando chips no osso"
	occur_text = "Sprays lascas de osso e desenvolve uma contusão desagradável"

	severity = WOUND_SEVERITY_SEVERE
	interaction_efficiency_penalty = 2
	limp_slowdown = 6
	limp_chance = 60
	series_threshold_penalty = 30
	treatable_by = list(/obj/item/stack/medical/wrap/sticky_tape/surgical, /obj/item/stack/medical/bone_gel)
	status_effect_type = /datum/status_effect/wound/blunt/bone/severe
	scar_keyword = "bluntsevere"
	brain_trauma_group = BRAIN_TRAUMA_MILD
	trauma_cycle_cooldown = 1.5 MINUTES
	internal_bleeding_chance = 40
	wound_flags = (ACCEPTS_GAUZE | MANGLES_INTERIOR | SPLINT_OVERLAY) // SKYRAT EDIT - MEDICAL (SPLINT_OVERLAY)
	regen_ticks_needed = 120 // ticks every 2 seconds, 240 seconds, so roughly 4 minutes default

	simple_desc = "O osso do paciente quebrou no meio, reduzindo drásticamente a função dos membros."
	simple_treat_text = "<b>Enfaixamento</b>A ferida reduzirá seu impacto até<b>Tratado cirurgicamente</b>com gel ósseo e fita cirúrgica."
	homemade_treat_text = "<b>Gel ósseo e fita cirúrgica.</b>pode ser aplicado diretamente na ferida, embora isso seja muito difícil para a maioria das pessoas fazer isso individualmente a menos que tenham se doado com um ou mais<b>analgésicos.</b>(Morphine e Salva Miner são conhecidos por ajudar)"


/datum/wound_pregen_data/bone/hairline
	abstract = FALSE

	wound_path_to_generate = /datum/wound/blunt/bone/severe

	threshold_minimum = 60

/// Compound Fracture (Critical Blunt)
/datum/wound/blunt/bone/critical
	name = "Compound Fracture"
	undiagnosed_name = null // you can tell it's a compound fracture at a glance because of a skin breakage
	a_or_from = "a"
	desc = "Os ossos do paciente sofreram múltiplas fraturas, com uma ruptura na pele, causando dor significativa e quase inutilidade do membro."
	treat_text = "Amarre imediatamente o membro afetado com gaze ou tala. Consertar cirurgicamente. Em caso de emergência, gel ósseo e fita cirúrgica podem ser aplicados na área afetada para consertar por um longo período de tempo."
	treat_text_short = "Repair surgically, or apply bone gel and surgical tape. A splint or gauze sling should also be used."
	examine_desc = "é completamente pulpado e rachado, expondo fragmentos de osso ao ar livre"
	occur_text = "Quebra, expondo ossos quebrados ao ar livre"

	severity = WOUND_SEVERITY_CRITICAL
	interaction_efficiency_penalty = 2.5
	limp_slowdown = 7
	limp_chance = 70
	sound_effect = 'sound/effects/wounds/crack2.ogg'
	threshold_penalty = 15
	disabling = TRUE
	treatable_by = list(/obj/item/stack/medical/wrap/sticky_tape/surgical, /obj/item/stack/medical/bone_gel)
	status_effect_type = /datum/status_effect/wound/blunt/bone/critical
	scar_keyword = "bluntcritical"
	brain_trauma_group = BRAIN_TRAUMA_SEVERE
	trauma_cycle_cooldown = 2.5 MINUTES
	internal_bleeding_chance = 60
	wound_flags = (ACCEPTS_GAUZE | MANGLES_INTERIOR | SPLINT_OVERLAY) // SKYRAT EDIT - MEDICAL (SPLINT_OVERLAY)
	regen_ticks_needed = 240 // ticks every 2 seconds, 480 seconds, so roughly 8 minutes default
	surgery_states = SURGERY_SKIN_CUT | SURGERY_BONE_SAWED // Bad enough to count as a busted skull/ribcage

	simple_desc = "Os ossos do paciente quebraram completamente, causando imobilização total do membro."
	simple_treat_text = "<b>Enfaixamento</b>A ferida reduzirá seu impacto até<b>Tratado cirurgicamente</b>com gel ósseo e fita cirúrgica."
	homemade_treat_text = "Embora isso seja extremamente difícil e lento para funcionar,<b>Gel ósseo e fita cirúrgica.</b>pode ser aplicado diretamente na ferida, embora isso seja quase impossível para a maioria das pessoas fazer isso individualmente, a menos que tenham se doado com um ou mais<b>analgésicos.</b>(Morphine e Salva Miner são conhecidos por ajudar)"

	/// Tracks if a surgeon has reset the bone (part one of the surgical treatment process)
	VAR_FINAL/reset = FALSE

/datum/wound_pregen_data/bone/compound
	abstract = FALSE

	wound_path_to_generate = /datum/wound/blunt/bone/critical

	threshold_minimum = 115

// doesn't make much sense for "a" bone to stick out of your head
/datum/wound/blunt/bone/critical/apply_wound(obj/item/bodypart/L, silent = FALSE, datum/wound/old_wound = null, smited = FALSE, attack_direction = null, wound_source = "Unknown", replacing = FALSE)
	if(L.body_zone == BODY_ZONE_HEAD)
		occur_text = "Se abre, expondo um crânio nu, rachado através da carne e do sangue"
		examine_desc = "tem um indentação perturbador, com pedaços de crânio cutucando"
	. = ..()

/// if someone is using bone gel on our wound
/datum/wound/blunt/bone/proc/gel(obj/item/stack/medical/bone_gel/I, mob/user)
	// skellies get treated nicer with bone gel since their "reattach dismembered limbs by hand" ability sucks when it's still critically wounded
	if((limb.biological_state & BIO_BONE) && !(limb.biological_state & (BIO_FLESH|BIO_CHITIN)))
		return skelly_gel(I, user)

	if(gelled)
		to_chat(user, span_warning("[user == victim ? "Your" : "[victim]'s"] [limb.plaintext_zone] Já está revestido com gel de osso!"))
		return TRUE

	user.visible_message(span_danger("[user] Começa rapidamente a aplicar [I] Para [victim] S [limb.plaintext_zone]..."), span_warning("Você começa rapidamente a aplicar [I] Para[user == victim ? "your" : "[victim]'s"] [limb.plaintext_zone], desconsiderando o rótulo de aviso ..."))

	if(!do_after(user, base_treat_time * 1.5 * (user == victim ? 1.5 : 1), target = victim, extra_checks=CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	I.use(1)
	victim.emote("scream")
	if(user != victim)
		user.visible_message(span_notice("[user] Termina de aplicar [I] Para [victim]'s [limb.plaintext_zone] Emmitindo um barulho!"), span_notice("Você termina de se inscrever.[I] Para [victim]'s [limb.plaintext_zone]!"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] Termina de aplicar [I] para o seu [limb.plaintext_zone], e você pode sentir os ossos explodindo de dor como eles começam a derreter e reformar!"))
	else
		if(!HAS_TRAIT(victim, TRAIT_ANALGESIA))
			if(prob(25 + (20 * (severity - 2)) - min(victim.get_drunk_amount(), 10))) // 25%/45% chance to fail self-applying with severe and critical wounds, modded by drunkenness
				victim.visible_message(span_danger("[victim] Não consegue terminar de aplicar.[I] Para [victim.p_their()] [limb.plaintext_zone] Desmaiando da dor!"), span_notice("Você desmaia da dor de aplicar [I] para o seu [limb.plaintext_zone] Antes que você possa terminar!"))
				victim.AdjustUnconscious(5 SECONDS)
				return TRUE
		victim.visible_message(span_notice("[victim] Termina de aplicar [I] Para [victim.p_their()] [limb.plaintext_zone] Encarando um dor!"), span_notice("Você termina de se inscrever.[I] para o seu [limb.plaintext_zone] E seus ossos explodem com dor!"))

	victim.apply_damage(25, BRUTE, limb, wound_bonus = CANT_WOUND)
	victim.apply_damage(100, STAMINA)
	gelled = TRUE
	return TRUE

/// skellies are less averse to bone gel, since they're literally all bone
/datum/wound/blunt/bone/proc/skelly_gel(obj/item/stack/medical/bone_gel/I, mob/user)
	if(gelled)
		to_chat(user, span_warning("[user == victim ? "Your" : "[victim]'s"] [limb.plaintext_zone] Já está revestido com gel de osso!"))
		return

	user.visible_message(span_danger("[user] começa a aplicar [I] Para [victim] S [limb.plaintext_zone]..."), span_warning("Você começa a aplicar [I] Para[user == victim ? "your" : "[victim]'s"] [limb.plaintext_zone]..."))

	if(!do_after(user, base_treat_time * (user == victim ? 1.5 : 1), target = victim, extra_checks=CALLBACK(src, PROC_REF(still_exists))))
		return

	I.use(1)
	if(user != victim)
		user.visible_message(span_notice("[user] Termina de aplicar [I] Para [victim]'s [limb.plaintext_zone] Emmitindo um barulho!"), span_notice("Você termina de se inscrever.[I] Para [victim]'s [limb.plaintext_zone]!"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] Termina de aplicar [I] para o seu [limb.plaintext_zone], e você sente umas cócegas engraçadas enquanto eles começam a se reformar!"))
	else
		victim.visible_message(span_notice("[victim] Termina de aplicar [I] Para [victim.p_their()] [limb.plaintext_zone] Emitindo um som engraçado!"), span_notice("Você termina de se inscrever.[I] para o seu [limb.plaintext_zone], e sinta umas cócegas engraçadas enquanto o osso começa a se reformar!"))

	gelled = TRUE
	processes = TRUE
	return TRUE

/// if someone is using surgical tape on our wound
/datum/wound/blunt/bone/proc/tape(obj/item/stack/medical/wrap/sticky_tape/surgical/I, mob/user)
	if(!gelled)
		to_chat(user, span_warning("[user == victim ? "Your" : "[victim]'s"] [limb.plaintext_zone] deve ser revestido com gel ósseo para realizar esta operação de emergência!"))
		return TRUE
	if(taped)
		to_chat(user, span_warning("[user == victim ? "Your" : "[victim]'s"] [limb.plaintext_zone] Já está embrulhado em [I.name] e reformando!"))
		return TRUE

	user.visible_message(span_danger("[user] começa a aplicar [I] Para [victim] S [limb.plaintext_zone]..."), span_warning("Você começa a aplicar [I] Para[user == victim ? "your" : "[victim]'s"] [limb.plaintext_zone]..."))

	if(!do_after(user, base_treat_time * (user == victim ? 1.5 : 1), target = victim, extra_checks=CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	if(victim == user)
		regen_ticks_needed *= 1.5

	I.use(1)
	if(user != victim)
		user.visible_message(span_notice("[user] Termina de aplicar [I] Para [victim]'s [limb.plaintext_zone] Emmitindo um barulho!"), span_notice("Você termina de se inscrever.[I] Para [victim]'s [limb.plaintext_zone]!"), ignored_mobs=victim)
		to_chat(victim, span_green("[user] Termina de aplicar [I] para o seu [limb.plaintext_zone], você imediatamente começa a sentir seus ossos começar a reformar!"))
	else
		victim.visible_message(span_notice("[victim] Termina de aplicar [I] Para [victim.p_their()] [limb.plaintext_zone], !"), span_green("Você termina de se inscrever.[I] para o seu [limb.plaintext_zone], e você imediatamente começa a sentir seus ossos começar a reformar!"))

	taped = TRUE
	processes = TRUE
	return TRUE

/datum/wound/blunt/bone/item_can_treat(obj/item/potential_treater, mob/user)
	// assume that - if working on a ready-to-operate limb - the surgery wants to do the real surgery instead of bone regeneration
	return ..() && !HAS_TRAIT(limb, TRAIT_READY_TO_OPERATE)

/datum/wound/blunt/bone/treat(obj/item/tool, mob/user)
	if(istype(tool, /obj/item/stack/medical/bone_gel))
		gel(tool, user)
	if(istype(tool, /obj/item/stack/medical/wrap/sticky_tape/surgical))
		tape(tool, user)

/datum/wound/blunt/bone/get_scanner_description(mob/user)
	. = ..()

	. += "<div class='ml-3'>"

	if(severity > WOUND_SEVERITY_MODERATE)
		if((limb.biological_state & BIO_BONE) && !(limb.biological_state & (BIO_FLESH|BIO_CHITIN)))
			if(!gelled)
				. += "Recommended Treatment: Apply bone gel directly to injured limb. Creatures of pure bone don't seem to mind bone gel application nearly as much as fleshed individuals. Surgical tape will also be unnecessary.\n"
			else
				. += "[span_notice("Note: Bone regeneration in effect. Bone is [round(regen_ticks_current*100/regen_ticks_needed)]% regenerated.")]\n"
		else
			if(!gelled)
				. += "Alternative Treatment: Apply bone gel directly to injured limb, then apply surgical tape to begin bone regeneration. This is both excruciatingly painful and slow, and only recommended in dire circumstances.\n"
			else if(!taped)
				. += "[span_notice("Continue Alternative Treatment: Apply surgical tape directly to injured limb to begin bone regeneration. Note, this is both excruciatingly painful and slow, though sleep or laying down will speed recovery.")]\n"
			else
				. += "[span_notice("Note: Bone regeneration in effect. Bone is [round(regen_ticks_current*100/regen_ticks_needed)]% regenerated.")]\n"

	if(limb.body_zone == BODY_ZONE_HEAD)
		. += "Cranial Trauma Detected: Patient will suffer random bouts of [severity == WOUND_SEVERITY_SEVERE ? "mild" : "severe"] brain traumas until bone is repaired."
	else if(limb.body_zone == BODY_ZONE_CHEST && CAN_HAVE_BLOOD(victim))
		. += "Ribcage Trauma Detected: Further trauma to chest is likely to worsen internal bleeding until bone is repaired."
	. += "</div>"
