
/*
	Piercing wounds
*/
/datum/wound/pierce
	undiagnosed_name = "Puncture"
	threshold_penalty = 5

/datum/wound/pierce/get_self_check_description(self_aware)
	if(!limb.can_bleed())
		return ..()

	switch(severity)
		if(WOUND_SEVERITY_TRIVIAL)
			return span_danger("Está vazando sangue de um pequeno [LOWER_TEXT(undiagnosed_name || name)].")
		if(WOUND_SEVERITY_MODERATE)
			return span_warning("Está vazando sangue de [LOWER_TEXT(undiagnosed_name || name)].")
		if(WOUND_SEVERITY_SEVERE)
			return span_boldwarning("Está vazando sangue de um sério [LOWER_TEXT(undiagnosed_name || name)]!")
		if(WOUND_SEVERITY_CRITICAL)
			return span_boldwarning("Está vazando sangue de um major.[LOWER_TEXT(undiagnosed_name || name)]!!")

/datum/wound/pierce/bleed
	name = "Piercing Wound"
	sound_effect = 'sound/items/weapons/slice.ogg'
	processes = TRUE
	treatable_tools = list(TOOL_CAUTERY)
	base_treat_time = 3 SECONDS
	wound_flags = (ACCEPTS_GAUZE | CAN_BE_GRASPED)

	default_scar_file = FLESH_SCAR_FILE

	/// How much blood we start losing when this wound is first applied
	var/initial_flow
	/// How much our blood_flow will naturally decrease per second, even without gauze
	var/clot_rate
	/// If gauzed, what percent of the internal bleeding actually clots of the total absorption rate
	var/gauzed_clot_rate

	/// When hit on this bodypart, we have this chance of losing some blood + the incoming damage
	var/internal_bleeding_chance
	/// If we let off blood when hit, the max blood lost is this * the incoming damage
	var/internal_bleeding_coefficient
	/// If TRUE we are ready to be mended in surgery
	VAR_FINAL/mend_state = FALSE

/datum/wound/pierce/bleed/wound_injury(datum/wound/old_wound = null, attack_direction = null)
	set_blood_flow(initial_flow)
	if(limb.can_bleed() && attack_direction && victim.get_blood_volume() > BLOOD_VOLUME_OKAY)
		victim.spray_blood(attack_direction, severity)

	return ..()

/datum/wound/pierce/bleed/receive_damage(wounding_type, wounding_dmg, wound_bonus)
	if(victim.stat == DEAD || (wounding_dmg < 5) || !limb.can_bleed() || !victim.get_blood_volume() || !prob(internal_bleeding_chance + wounding_dmg))
		return
	var/blood_bled = rand(1, limb.get_splint_factor() * internal_bleeding_coefficient) // 12 brute toolbox can cause up to 15/18/21 bloodloss on mod/sev/crit
	switch(blood_bled)
		if(1 to 6)
			victim.bleed(blood_bled, TRUE)
		if(7 to 13)
			victim.visible_message(
				span_smalldanger("Gotas de sangue voam do buraco [victim]'s [limb.plaintext_zone]."),
				span_danger("Você tossiu um pouco de sangue do golpe para o seu [limb.plaintext_zone]."),
				vision_distance = COMBAT_MESSAGE_RANGE,
			)
			victim.bleed(blood_bled, TRUE)
		if(14 to 19)
			victim.visible_message(
				span_smalldanger("Um pequeno fluxo de sangue jorra do buraco dentro [victim]'s [limb.plaintext_zone]!"),
				span_danger("Você cuspiu uma corda de sangue do golpe para o seu [limb.plaintext_zone]!"),
				vision_distance = COMBAT_MESSAGE_RANGE,
			)
			victim.create_splatter(victim.dir)
			victim.bleed(blood_bled)
		if(20 to INFINITY)
			victim.visible_message(
				span_danger("Um borrifo de correntes de sangue do corte.[victim]'s [limb.plaintext_zone]!"),
				span_bolddanger("Você engasga com um spray de sangue do golpe para o seu [limb.plaintext_zone]!"),
				vision_distance = COMBAT_MESSAGE_RANGE,
			)
			victim.bleed(blood_bled)
			victim.create_splatter(victim.dir)
			victim.add_splatter_floor(get_step(victim.loc, victim.dir))

/datum/wound/pierce/bleed/get_bleed_rate_of_change()
	//basically if a species doesn't bleed, the wound is stagnant and will not heal on its own (nor get worse)
	if(!limb.can_bleed())
		return BLOOD_FLOW_STEADY
	if(HAS_TRAIT(victim, TRAIT_BLOOD_FOUNTAIN))
		return BLOOD_FLOW_INCREASING
	if(LAZYACCESS(limb.applied_items, LIMB_ITEM_GAUZE) || clot_rate > 0)
		return BLOOD_FLOW_DECREASING
	if(clot_rate < 0)
		return BLOOD_FLOW_INCREASING
	return BLOOD_FLOW_STEADY

/datum/wound/pierce/bleed/handle_process(seconds_per_tick)
	if (!victim || HAS_TRAIT(victim, TRAIT_STASIS))
		return


	if(limb.can_bleed())
		if(victim.bodytemperature < (BODYTEMP_NORMAL - 10))
			adjust_blood_flow(-0.1 * seconds_per_tick)
			if(QDELETED(src))
				return
			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(victim, span_notice("Você sente o [LOWER_TEXT(undiagnosed_name || name)] em seu [limb.plaintext_zone] se firmando do frio!"))

		if(HAS_TRAIT(victim, TRAIT_BLOOD_FOUNTAIN))
			adjust_blood_flow(0.25 * seconds_per_tick) // old heparin used to just add +2 bleed stacks per tick, this adds 0.5 bleed flow to all open cuts which is probably even stronger as long as you can cut them first

	//gauze always reduces blood flow, even for non bleeders
	var/obj/item/stack/medical/wrap/current_gauze = LAZYACCESS(limb.applied_items, LIMB_ITEM_GAUZE)
	if(current_gauze?.absorption_rate)
		var/gauze_power = current_gauze.absorption_rate
		limb.seep_gauze(gauze_power * seconds_per_tick)
		adjust_blood_flow((-clot_rate * seconds_per_tick) + (-gauze_power * gauzed_clot_rate * seconds_per_tick))
	//otherwise, only clot if it's a bleeder
	else if(limb.can_bleed())
		adjust_blood_flow(-clot_rate * seconds_per_tick)

/datum/wound/pierce/bleed/adjust_blood_flow(adjust_by, minimum)
	. = ..()
	if(blood_flow > WOUND_MAX_BLOODFLOW)
		blood_flow = WOUND_MAX_BLOODFLOW
	if(blood_flow <= 0 && !QDELETED(src))
		to_chat(victim, span_green("Os buracos no seu [limb.plaintext_zone] ter[!limb.can_bleed() ? "healed up" : "stopped bleeding"]!"))
		qdel(src)

/datum/wound/pierce/bleed/check_grab_treatments(obj/item/tool, mob/user)
	// if we're using something hot but not a cautery, we need to be aggro grabbing them first,
	// so we don't try treating someone we're eswording
	return tool.get_temperature() >= FIRE_MINIMUM_TEMPERATURE_TO_EXIST

/datum/wound/pierce/bleed/treat(obj/item/tool, mob/user)
	if(tool.tool_behaviour == TOOL_CAUTERY || tool.get_temperature() >= FIRE_MINIMUM_TEMPERATURE_TO_EXIST)
		tool_cauterize(tool, user)

/datum/wound/pierce/bleed/on_xadone(power)
	. = ..()

	if (limb) // parent can cause us to be removed, so its reasonable to check if we're still applied
		adjust_blood_flow(-0.03 * power) // i think it's like a minimum of 3 power, so .09 blood_flow reduction per tick is pretty good for 0 effort

/datum/wound/pierce/bleed/on_synthflesh(reac_volume)
	. = ..()
	adjust_blood_flow(-0.025 * reac_volume) // 20u * 0.05 = -1 blood flow, less than with slashes but still good considering smaller bleed rates

/// If someone is using either a cautery tool or something with heat to cauterize this pierce
/datum/wound/pierce/bleed/proc/tool_cauterize(obj/item/I, mob/user)

	var/improv_penalty_mult = (I.tool_behaviour == TOOL_CAUTERY ? 1 : 1.25) // 25% longer and less effective if you don't use a real cautery
	var/self_penalty_mult = (user == victim ? 1.5 : 1) // 50% longer and less effective if you do it to yourself

	var/treatment_delay = base_treat_time * self_penalty_mult * improv_penalty_mult

	if(HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		treatment_delay *= 0.5
		user.visible_message(span_danger("[user] Começa a cauterizar [victim]'s [limb.plaintext_zone] com [I]..."), span_warning("Você começa a cauterizar[user == victim ? "your" : "[victim]'s"] [limb.plaintext_zone] com [I], mantendo as indicações de holo-imagem em mente ..."))
	else
		user.visible_message(span_danger("[user] Começa a cauterizar [victim]'s [limb.plaintext_zone] com [I]..."), span_warning("Você começa a cauterizar[user == victim ? "your" : "[victim]'s"] [limb.plaintext_zone] com [I]..."))

	playsound(user, 'sound/items/handling/surgery/cautery1.ogg', 75, TRUE)

	if(!do_after(user, treatment_delay, target = victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	playsound(user, 'sound/items/handling/surgery/cautery2.ogg', 75, TRUE)

	var/bleeding_wording = (!limb.can_bleed() ? "holes" : "bleeding")
	user.visible_message(span_green("[user] Cauteriza alguns dos [bleeding_wording] Vamos.[victim]."), span_green("Você cauteriza alguns dos [bleeding_wording] Vamos.[victim]."))
	victim.apply_damage(2 + severity, BURN, limb, wound_bonus = CANT_WOUND)
	if(prob(30))
		victim.emote("scream")
	var/blood_cauterized = (0.6 / (self_penalty_mult * improv_penalty_mult))
	adjust_blood_flow(-blood_cauterized)

	if(blood_flow > 0)
		try_treating(I, user)

/datum/wound_pregen_data/flesh_pierce
	abstract = TRUE

	required_limb_biostate = BIO_FLESH
	required_wounding_type = WOUND_PIERCE

	wound_series = WOUND_SERIES_FLESH_PUNCTURE_BLEED

/datum/wound/pierce/get_limb_examine_description()
	return span_warning("A carne neste membro parece muito perfurada.")

/datum/wound/pierce/bleed/moderate
	name = "Minor Skin Breakage"
	desc = "A pele do paciente foi quebrada, causando hematomas graves e sangramento interno na área afetada."
	treat_text = "Aplicar bandagem ou sutura na ferida, fazer uso de agentes de coagulação sanguínea, cauterização, ou em circunstâncias extremas, exposição a frio extremo ou vácuo. Siga com comida e um período de descanso."
	treat_text_short = "Apply bandaging or suturing."
	examine_desc = "tem um pequeno buraco rasgado, suavemente sangrando"
	occur_text = "jorra um fino fluxo de sangue."
	sound_effect = 'sound/effects/wounds/pierce1.ogg'
	severity = WOUND_SEVERITY_MODERATE
	initial_flow = 1.25
	gauzed_clot_rate = 0.75
	clot_rate = 0.03
	internal_bleeding_chance = 30
	internal_bleeding_coefficient = 1.25
	series_threshold_penalty = 20
	status_effect_type = /datum/status_effect/wound/pierce/moderate
	scar_keyword = "piercemoderate"

	simple_treat_text = "<b>Enfaixamento</b>A ferida reduzirá a perda de sangue, ajudará a ferida a se fechar mais rápido e acelerará o período de recuperação do sangue. A ferida em si pode ser lenta<b>Suturado.</b>Cale-se."
	homemade_treat_text = "<b>Chá.</b>estimula os sistemas naturais de cura do corpo, fixando levemente a coagulação. A ferida pode ser lavada em uma pia ou chuveiro também. Outros remédios são desnecessários."

/datum/wound/pierce/bleed/moderate/update_descriptions()
	if(!limb.can_bleed())
		examine_desc = "tem um pequeno buraco rasgado"
		occur_text = "Abre um pequeno buraco"

/datum/wound_pregen_data/flesh_pierce/breakage
	abstract = FALSE

	wound_path_to_generate = /datum/wound/pierce/bleed/moderate

	threshold_minimum = 30

/datum/wound_pregen_data/flesh_pierce/breakage/get_weight(obj/item/bodypart/limb, woundtype, damage, attack_direction, damage_source)
	if (isprojectile(damage_source))
		return 0
	return weight

/datum/wound/pierce/bleed/moderate/needle_fail //for blood testamajig
	name = "Pinprick Pierce"
	desc = "A pele do paciente foi profundamente perfurada, causando sangramento leve."
	treat_text_short = "Apply bandaging or suturing."
	examine_desc = "tem uma pequena picada vermelha, suavemente sangrando."
	initial_flow = 0.5 //very minor, mostly there as fluff and "dont do that idiot" reminder
	gauzed_clot_rate = 0.1
	clot_rate = 0.03 // will close quickly on its own
	internal_bleeding_chance = 0
	internal_bleeding_coefficient = 1
	threshold_penalty = 5

/datum/wound_pregen_data/flesh_pierce/open_puncture/pinprick
	wound_path_to_generate = /datum/wound/pierce/bleed/moderate/needle_fail
	can_be_randomly_generated = FALSE
	abstract = FALSE

/datum/wound/pierce/bleed/moderate/projectile
	name = "Minor Skin Penetration"
	desc = "A pele do paciente foi perfurada, causando hematomas graves e sangramento interno na área afetada."
	treat_text = "Aplicar bandagem ou sutura na ferida, fazer uso de agentes de coagulação sanguínea, cauterização, ou em circunstâncias extremas, exposição a frio extremo ou vácuo. Siga com comida e um período de descanso."
	examine_desc = "tem um pequeno buraco circular, suavemente sangrando."
	clot_rate = 0

/datum/wound/pierce/bleed/moderate/projectile/update_descriptions()
	if(!limb.can_bleed())
		examine_desc = "tem um pequeno buraco circular"
		occur_text = "Abre um pequeno buraco"

/datum/wound_pregen_data/flesh_pierce/breakage/projectile
	wound_path_to_generate = /datum/wound/pierce/bleed/moderate/projectile

/datum/wound_pregen_data/flesh_pierce/breakage/projectile/get_weight(obj/item/bodypart/limb, woundtype, damage, attack_direction, damage_source)
	if (!isprojectile(damage_source))
		return 0
	return weight

/datum/wound/pierce/bleed/severe
	name = "Open Stab Puncture"
	desc = "O tecido interno do paciente foi penetrado, causando sangramento interno e redução da estabilidade dos membros."
	treat_text = "Aplique rapidamente bandagem ou sutura na ferida, faça uso de agentes de coagulação sanguínea ou solução salina, cauterização, ou em circunstâncias extremas, exposição a frio extremo ou vácuo. Siga com suplementos de ferro e um período de descanso."
	treat_text_short = "Apply bandaging, suturing, clotting agents, or cauterization."
	examine_desc = "é perfurado através, com pedaços de tecido obscurecendo o buraco aberto"
	occur_text = "solta um violento spray de sangue, revelando uma ferida perfurada."
	sound_effect = 'sound/effects/wounds/pierce2.ogg'
	severity = WOUND_SEVERITY_SEVERE
	initial_flow = 2
	gauzed_clot_rate = 0.5
	clot_rate = 0.02
	internal_bleeding_chance = 60
	internal_bleeding_coefficient = 1.5
	series_threshold_penalty = 35
	status_effect_type = /datum/status_effect/wound/pierce/severe
	scar_keyword = "piercesevere"

	simple_treat_text = "<b>Enfaixamento</b>A ferida é essencial, e reduzirá a perda de sangue. Depois, a ferida pode ser<b>Suturado.</b>Fechado, de preferência enquanto o paciente descansa e/ou agarra a ferida."
	homemade_treat_text = "Lençóis podem ser rasgados para fazer<b>gaze improvisada</b>. <b>Farinha, sal de mesa ou sal misturado com água</b>Pode ser aplicado diretamente para parar o fluxo, embora o sal não misturado irrite a pele e piore a cura natural. Descansar e agarrar sua ferida também reduzirá o sangramento."

/datum/wound/pierce/bleed/severe/update_descriptions()
	if(!limb.can_bleed())
		occur_text = "Faz um buraco aberto"

/datum/wound_pregen_data/flesh_pierce/open_puncture
	abstract = FALSE

	wound_path_to_generate = /datum/wound/pierce/bleed/severe

	threshold_minimum = 50

/datum/wound_pregen_data/flesh_pierce/open_puncture/get_weight(obj/item/bodypart/limb, woundtype, damage, attack_direction, damage_source)
	if (isprojectile(damage_source))
		return 0
	return weight

/datum/wound/pierce/bleed/severe/projectile
	name = "Open Bullet Puncture"
	examine_desc = "é perfurado através, com pedaços de tecido obscurecendo o buraco limpo rasgado"
	clot_rate = 0

/datum/wound_pregen_data/flesh_pierce/open_puncture/projectile
	wound_path_to_generate = /datum/wound/pierce/bleed/severe/projectile

/datum/wound_pregen_data/flesh_pierce/open_puncture/projectile/get_weight(obj/item/bodypart/limb, woundtype, damage, attack_direction, damage_source)
	if (!isprojectile(damage_source))
		return 0
	return weight

/datum/wound/pierce/bleed/severe/eye
	name = "Eyeball Puncture"
	desc = "O olho do paciente sofreu danos extremos, causando sangramento grave na cavidade ocular."
	occur_text = "solta um violento respingo de sangue, revelando um olho esmagado"
	var/right_side = FALSE

/datum/wound/pierce/bleed/severe/eye/apply_wound(obj/item/bodypart/limb, silent, datum/wound/old_wound, smited, attack_direction, wound_source, replacing, right_side)
	var/obj/item/organ/eyes/eyes = locate() in limb
	if (!istype(eyes))
		return FALSE
	. = ..()
	src.right_side = right_side
	examine_desc = "tem o seu[right_side ? "right" : "left"]Olho perfurado, sangue jorrando da cavidade"
	RegisterSignal(limb, COMSIG_BODYPART_UPDATE_WOUND_OVERLAY, PROC_REF(wound_overlay))
	limb.update_part_wound_overlay()

/datum/wound/pierce/bleed/severe/eye/remove_wound(ignore_limb, replaced, destroying)
	if (!isnull(limb))
		UnregisterSignal(limb, COMSIG_BODYPART_UPDATE_WOUND_OVERLAY)
	return ..()

/datum/wound/pierce/bleed/severe/eye/proc/wound_overlay(obj/item/bodypart/source, limb_bleed_rate)
	SIGNAL_HANDLER

	if (limb_bleed_rate <= BLEED_OVERLAY_LOW || limb_bleed_rate > BLEED_OVERLAY_GUSH)
		return

	if (blood_flow <= BLEED_OVERLAY_LOW)
		return

	source.bleed_overlay_icon = right_side ? "r_eye" : "l_eye"
	return COMPONENT_PREVENT_WOUND_OVERLAY_UPDATE

/datum/wound_pregen_data/flesh_pierce/open_puncture/eye
	wound_path_to_generate = /datum/wound/pierce/bleed/severe/eye
	viable_zones = list(BODY_ZONE_HEAD)
	can_be_randomly_generated = FALSE

/datum/wound_pregen_data/flesh_pierce/open_puncture/eye/can_be_applied_to(obj/item/bodypart/limb, list/suggested_wounding_types, datum/wound/old_wound, random_roll, duplicates_allowed, care_about_existing_wounds)
	if (isnull(locate(/obj/item/organ/eyes) in limb))
		return FALSE
	return ..()

/datum/wound/pierce/bleed/severe/magicalearpain //what happens if you try to listen to the heartbeat of a corrupt heart while not a heretic
	name = "Bleeding Ears"
	desc = "Os ouvidos do paciente estão sangrando muito enquanto o sangue escorre através da carne interior do ouvido através de alguns meios desconhecidos."
	examine_desc = "está coberto de sangue, líquido roxo negro fluindo de suas orelhas"
	occur_text = "é embebido como dois jorros de spray líquido preto de suas orelhas"
	internal_bleeding_chance = 0 // just your ears

/datum/wound_pregen_data/flesh_pierce/open_puncture/magicalearpain
	wound_path_to_generate = /datum/wound/pierce/bleed/severe/magicalearpain
	viable_zones = list(BODY_ZONE_HEAD)
	can_be_randomly_generated = FALSE

/datum/wound/pierce/bleed/severe/magicalearpain/apply_wound(obj/item/bodypart/limb, silent, datum/wound/old_wound, smited, attack_direction, wound_source, replacing)
	var/obj/item/organ/ears/ears = locate() in limb
	if (!istype(ears))
		return FALSE
	. = ..()

/datum/wound/pierce/bleed/critical
	name = "Ruptured Cavity"
	desc = "O tecido interno e o sistema circulatório do paciente estão rasgados, causando sangramento interno e danos nos órgãos internos."
	treat_text = "Imediatamente aplique bandagem ou sutura na ferida, faça uso de agentes de coagulação sanguínea ou solução salina-glucose, cauterização, ou em circunstâncias extremas, exposição ao frio extremo ou vácuo. Siga com ressangramento supervisionado."
	treat_text_short = "Apply bandaging, suturing, clotting agents, or cauterization."
	examine_desc = "é rasgado completamente, mal mantido junto por ossos expostos"
	occur_text = "Explode, enviando pedaços de vísceras voando em todas as direções."
	sound_effect = 'sound/effects/wounds/pierce3.ogg'
	severity = WOUND_SEVERITY_CRITICAL
	initial_flow = 2.5
	gauzed_clot_rate = 0.3
	internal_bleeding_chance = 80
	internal_bleeding_coefficient = 1.75
	threshold_penalty = 15
	status_effect_type = /datum/status_effect/wound/pierce/critical
	scar_keyword = "piercecritical"
	surgery_states = SURGERY_SKIN_CUT | SURGERY_VESSELS_UNCLAMPED // Bad enough to count
	wound_flags = (ACCEPTS_GAUZE | MANGLES_EXTERIOR | CAN_BE_GRASPED)

	simple_treat_text = "<b>Enfaixamento</b>A ferida é de extrema importância, assim como procurar assistência médica direta.<b>Morte</b>Vai acontecer se o tratamento for atrasado, com falta de<b>oxigênio</b>Matando o paciente, assim<b>Comida, Ferro e solução salina.</b>é sempre recomendado após o tratamento. Esta ferida não selará naturalmente."
	homemade_treat_text = "Lençóis podem ser rasgados para fazer<b>gaze improvisada</b>. <b>Farinha, sal e água salgada</b>Aplicada topicamente vai ajudar. Cair no chão e agarrar sua ferida reduzirá o fluxo sanguíneo."

/datum/wound_pregen_data/flesh_pierce/cavity
	abstract = FALSE

	wound_path_to_generate = /datum/wound/pierce/bleed/critical

	threshold_minimum = 100
