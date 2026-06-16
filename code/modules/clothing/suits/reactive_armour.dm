/obj/item/reactive_armor_shell
	name = "reactive armor shell"
	desc = "Uma armadura experimental, aguardando instalação de um núcleo de anomalia."
	icon_state = "reactiveoff"
	icon = 'icons/obj/clothing/suits/armor.dmi'
	w_class = WEIGHT_CLASS_BULKY

/obj/item/reactive_armor_shell/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	var/static/list/anomaly_armour_types = list(
		/obj/effect/anomaly/grav = /obj/item/clothing/suit/armor/reactive/repulse,
		/obj/effect/anomaly/flux = /obj/item/clothing/suit/armor/reactive/tesla,
		/obj/effect/anomaly/bluespace = /obj/item/clothing/suit/armor/reactive/teleport,
		/obj/effect/anomaly/bioscrambler = /obj/item/clothing/suit/armor/reactive/bioscrambling,
		/obj/effect/anomaly/hallucination = /obj/item/clothing/suit/armor/reactive/hallucinating,
		/obj/effect/anomaly/dimensional = /obj/item/clothing/suit/armor/reactive/barricade,
		/obj/effect/anomaly/ectoplasm = /obj/item/clothing/suit/armor/reactive/ectoplasm,
		/obj/effect/anomaly/weather = /obj/item/clothing/suit/armor/reactive/weather,
	)

	if(istype(tool, /obj/item/assembly/signaler/anomaly))
		var/obj/item/assembly/signaler/anomaly/anomaly = tool
		var/armour_path = is_path_in_list(anomaly.anomaly_type, anomaly_armour_types, TRUE)
		if(!armour_path)
			armour_path = /obj/item/clothing/suit/armor/reactive/stealth //Lets not cheat the player if an anomaly type doesnt have its own armour coded
		to_chat(user, span_notice("Você insere [anomaly] Não sei, e a arma suavemente murmura para a vida."))
		new armour_path(get_turf(src))
		qdel(src)
		qdel(anomaly)
		return ITEM_INTERACT_SUCCESS

//Reactive armor
/obj/item/clothing/suit/armor/reactive
	name = "reactive armor"
	desc = "Não parece fazer muito por alguma razão."
	icon_state = "reactiveoff"
	inhand_icon_state = null
	blood_overlay_type = "armor"
	armor_type = /datum/armor/armor_reactive
	actions_types = list(/datum/action/item_action/toggle)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	hit_reaction_chance = 50
	///Whether the armor will try to react to hits (is it on)
	var/active = FALSE
	///This will be true for 30 seconds after an EMP, it makes the reaction effect dangerous to the user.
	var/bad_effect = FALSE
	///Message sent when the armor is emp'd. It is not the message for when the emp effect goes off.
	var/emp_message = span_warning("A armadura reativa foi esvaziada! Droga, agora não vai fazer muito!")
	///Message sent when the armor is still on cooldown, but activates.
	var/cooldown_message = span_danger("A armadura reativa não faz muito, já que está recarregando! De quê? Só a armadura reativa sabe.")
	///Duration of the cooldown specific to reactive armor for when it can activate again.
	var/reactivearmor_cooldown_duration = 10 SECONDS
	///The cooldown itself of the reactive armor for when it can activate again.
	var/reactivearmor_cooldown = 0

/datum/armor/armor_reactive
	fire = 100
	acid = 100

/obj/item/clothing/suit/armor/reactive/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/suit/armor/reactive/update_icon_state()
	. = ..()
	icon_state = "reactive[active ? null : "off"]"

/obj/item/clothing/suit/armor/reactive/attack_self(mob/user)
	active = !active
	to_chat(user, span_notice("[src] é agora[active ? "active" : "inactive"]."))
	update_icon()
	add_fingerprint(user)

/obj/item/clothing/suit/armor/reactive/hit_reaction(owner, hitby, attack_text, final_block_chance, damage, attack_type, damage_type = BRUTE)
	if(!active || !prob(hit_reaction_chance))
		return FALSE
	if(world.time < reactivearmor_cooldown)
		cooldown_activation(owner)
		return FALSE
	if(bad_effect)
		return emp_activation(owner, hitby, attack_text, final_block_chance, damage, attack_type)
	else
		return reactive_activation(owner, hitby, attack_text, final_block_chance, damage, attack_type)

/**
 * A proc for doing cooldown effects (like the sparks on the tesla armor, or the semi-stealth on stealth armor)
 * Called from the suit activating whilst on cooldown.
 * You should be calling ..()
 */
/obj/item/clothing/suit/armor/reactive/proc/cooldown_activation(mob/living/carbon/human/owner)
	owner.visible_message(cooldown_message)

/**
 * A proc for doing reactive armor effects.
 * Called from the suit activating while off cooldown, with no emp.
 * Returning TRUE will block the attack that triggered this
 */
/obj/item/clothing/suit/armor/reactive/proc/reactive_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	owner.visible_message(span_danger("A armadura reativa não faz muito! Nenhuma surpresa aqui."))
	return TRUE

/**
 * A proc for doing owner unfriendly reactive armor effects.
 * Called from the suit activating while off cooldown, while the armor is still suffering from the effect of an EMP.
 * Returning TRUE will block the attack that triggered this
 */
/obj/item/clothing/suit/armor/reactive/proc/emp_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	owner.visible_message(span_danger("A armadura reativa não faz muito, apesar de estar vazia! Além de emitir uma mensagem especial, é claro."))
	return TRUE

/obj/item/clothing/suit/armor/reactive/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF || bad_effect || !active) //didn't get hit or already emp'd, or off
		return
	visible_message(emp_message)
	bad_effect = TRUE
	addtimer(VARSET_CALLBACK(src, bad_effect, FALSE), 30 SECONDS)

//When the wearer gets hit, this armor will teleport the user a short distance away (to safety or to more danger, no one knows. That's the fun of it!)
/obj/item/clothing/suit/armor/reactive/teleport
	name = "reactive teleport armor"
	desc = "Alguém separou nosso diretor de pesquisa de sua própria cabeça!"
	emp_message = span_warning("Os cálculos de teletransporte da armadura reativa começam a gerar erros!")
	cooldown_message = span_danger("O sistema de teletransporte reativo ainda está recarregando! Ele falha em ativar!")
	reactivearmor_cooldown_duration = 10 SECONDS
	var/tele_range = 6

/obj/item/clothing/suit/armor/reactive/teleport/reactive_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	owner.visible_message(span_danger("O sistema de teletransporte se move.[owner] Livre de [attack_text]!"))
	playsound(get_turf(owner),'sound/effects/magic/blink.ogg', 100, TRUE)
	do_teleport(owner, get_turf(owner), tele_range, no_effects = TRUE, channel = TELEPORT_CHANNEL_BLUESPACE)
	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return TRUE

/obj/item/clothing/suit/armor/reactive/teleport/emp_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	owner.visible_message(span_danger("O sistema de teletransporte reativo se solta.[attack_text] Deixando alguém para trás no processo!"))
	owner.dropItemToGround(src, TRUE, TRUE)
	playsound(get_turf(owner),'sound/machines/buzz/buzz-sigh.ogg', 50, TRUE)
	playsound(get_turf(owner),'sound/effects/magic/blink.ogg', 100, TRUE)
	do_teleport(src, get_turf(owner), tele_range, no_effects = TRUE, channel = TELEPORT_CHANNEL_BLUESPACE)
	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return FALSE //you didn't actually evade the attack now did you

//Fire

/obj/item/clothing/suit/armor/reactive/fire
	name = "reactive incendiary armor"
	desc = "Uma armadura experimental com um sensor reativo ligado a um emissor de chama. Para o piromaníaco elegante."
	cooldown_message = span_danger("A armadura incendiária reativa se ativa, mas falha em lançar chamas, pois ainda está recarregando seus jatos de chama!")
	emp_message = span_warning("A armadura incendiária reativa começa a reiniciar...")

/obj/item/clothing/suit/armor/reactive/fire/reactive_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	owner.visible_message(span_danger("[src] Blocos.[attack_text], enviando jatos de chamas!"))
	playsound(get_turf(owner),'sound/effects/magic/fireball.ogg', 100, TRUE)
	for(var/mob/living/carbon/carbon_victim in range(6, get_turf(src)))
		if(carbon_victim != owner)
			carbon_victim.adjust_fire_stacks(8)
			carbon_victim.ignite_mob()
	owner.set_wet_stacks(20)
	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return TRUE

/obj/item/clothing/suit/armor/reactive/fire/emp_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	owner.visible_message(span_danger("[src] Apenas faz [attack_text] Pior jogando morte derretida em [owner]!"))
	playsound(get_turf(owner),'sound/effects/magic/fireball.ogg', 100, TRUE)
	owner.adjust_fire_stacks(12)
	owner.ignite_mob()
	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return FALSE

//Stealth

/obj/item/clothing/suit/armor/reactive/stealth
	name = "reactive stealth armor"
	desc = "Uma armadura experimental que torna o usuário invisível na detecção de danos iminentes, e cria uma isca que foge do dono. Não pode lutar contra o que não pode ver."
	cooldown_message = span_danger("O sistema de camuflagem reativa se ativa, mas não é carregado o suficiente para camuflar completamente!")
	emp_message = span_warning("O sistema de avaliação de ameaças da armadura stealth reativa...")
	///when triggering while on cooldown will only flicker the alpha slightly. this is how much it removes.
	var/cooldown_alpha_removal = 50
	///cooldown alpha flicker- how long it takes to return to the original alpha
	var/cooldown_animation_time = 3 SECONDS
	///how long they will be fully stealthed
	var/stealth_time = 4 SECONDS
	///how long it will animate back the alpha to the original
	var/animation_time = 2 SECONDS
	var/in_stealth = FALSE

/obj/item/clothing/suit/armor/reactive/stealth/cooldown_activation(mob/living/carbon/human/owner)
	if(in_stealth)
		return //we don't want the cooldown message either)
	owner.alpha = max(0, owner.alpha - cooldown_alpha_removal)
	animate(owner, alpha = initial(owner.alpha), time = cooldown_animation_time)
	..()

/obj/item/clothing/suit/armor/reactive/stealth/reactive_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	var/mob/living/basic/illusion/escape/decoy = new(owner.loc)
	decoy.full_setup(
		owner,
		target_mob = owner,
		life = 5 SECONDS,
		hp = owner.health / 4,
		damage = 5,
		replicate = 0,
	)
	owner.alpha = 0
	in_stealth = TRUE
	owner.visible_message(span_danger("[owner] é atingido por [attack_text] Não sei!")) //We pretend to be hit, since blocking it would stop the message otherwise
	addtimer(CALLBACK(src, PROC_REF(end_stealth), owner), stealth_time)
	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return TRUE

/obj/item/clothing/suit/armor/reactive/stealth/proc/end_stealth(mob/living/carbon/human/owner)
	in_stealth = FALSE
	animate(owner, alpha = initial(owner.alpha), time = animation_time)

/obj/item/clothing/suit/armor/reactive/stealth/emp_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(!isliving(hitby))
		return FALSE //it just doesn't activate
	var/mob/living/attacker = hitby
	owner.visible_message(span_danger("[src] Ativa, Camuflando a pessoa errada!"))
	attacker.alpha = 0
	addtimer(VARSET_CALLBACK(attacker, alpha, initial(attacker.alpha)), 4 SECONDS)
	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return FALSE

//Tesla

/obj/item/clothing/suit/armor/reactive/tesla
	name = "reactive tesla armor"
	desc = "Uma armadura experimental com detectores sensíveis conectados a uma grade de capacitores, com emissores saindo dela. Zap."
	siemens_coefficient = -1
	cooldown_message = span_danger("Os capacitores tesla na armadura tesla reativa ainda estão recarregando! A armadura apenas emite algumas faíscas.")
	emp_message = span_warning("Os capacitores de tesla apitam ominosamente por um momento.")
	clothing_traits = list(TRAIT_TESLA_SHOCKIMMUNE)
	/// How strong are the zaps we give off?
	var/zap_power = 2.5e4
	/// How far to the zaps we give off go?
	var/zap_range = 20
	/// What flags do we pass to the zaps we give off?
	var/zap_flags = ZAP_MOB_DAMAGE | ZAP_OBJ_DAMAGE

/obj/item/clothing/suit/armor/reactive/tesla/cooldown_activation(mob/living/carbon/human/owner)
	do_sparks(1, TRUE, src)
	..()

/obj/item/clothing/suit/armor/reactive/tesla/reactive_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	owner.visible_message(span_danger("[src] Blocos.[attack_text], enviando arcos de raios!"))
	tesla_zap(source = owner, zap_range = zap_range, power = zap_power, cutoff = 1e3, zap_flags = zap_flags)
	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return TRUE

/obj/item/clothing/suit/armor/reactive/tesla/emp_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	owner.visible_message(span_danger("[src] Blocos.[attack_text], mas puxa uma carga maciça de energia para [owner] Faça ambiente circundante!"))
	REMOVE_CLOTHING_TRAIT(owner, TRAIT_TESLA_SHOCKIMMUNE) //oops! can't shock without this!
	electrocute_mob(owner, get_area(src), src, 1)
	ADD_CLOTHING_TRAIT(owner, TRAIT_TESLA_SHOCKIMMUNE)
	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return TRUE

//Repulse

/obj/item/clothing/suit/armor/reactive/repulse
	name = "reactive repulse armor"
	desc = "Uma armadura experimental que atira violentamente atacantes de volta."
	cooldown_message = span_danger("O gerador de repulsão ainda está recarregando! Ele não gera uma onda forte o suficiente!")
	emp_message = span_warning("O gerador de repulsão foi reiniciado para configurações padrão...")
	var/repulse_force = MOVE_FORCE_EXTREMELY_STRONG

/obj/item/clothing/suit/armor/reactive/repulse/reactive_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	playsound(get_turf(owner),'sound/effects/magic/repulse.ogg', 100, TRUE)
	owner.visible_message(span_danger("[src] Blocos.[attack_text], convertendo o ataque em uma onda de força!"))
	var/turf/owner_turf = get_turf(owner)
	var/list/thrown_items = list()
	for(var/atom/movable/repulsed in range(owner_turf, 7))
		if(repulsed == owner || repulsed.anchored || thrown_items[repulsed])
			continue
		var/throwtarget = get_edge_target_turf(owner_turf, get_dir(owner_turf, get_step_away(repulsed, owner_turf)))
		repulsed.safe_throw_at(throwtarget, 10, 1, force = repulse_force)
		thrown_items[repulsed] = repulsed

	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return TRUE

/obj/item/clothing/suit/armor/reactive/repulse/emp_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	playsound(get_turf(owner),'sound/effects/magic/repulse.ogg', 100, TRUE)
	owner.visible_message(span_danger("[src] Não bloqueie [attack_text], e em vez disso gera uma força de atração!"))
	var/turf/owner_turf = get_turf(owner)
	var/list/thrown_items = list()
	for(var/atom/movable/repulsed in range(owner_turf, 7))
		if(repulsed == owner || repulsed.anchored || thrown_items[repulsed])
			continue
		repulsed.safe_throw_at(owner, 10, 1, force = repulse_force)
		thrown_items[repulsed] = repulsed

	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return FALSE

/obj/item/clothing/suit/armor/reactive/table
	name = "reactive table armor"
	desc = "Se não pode vencer os memes, abrace-os."
	cooldown_message = span_danger("Os fabricantes de armaduras de mesa reativas ainda estão em resfriamento!")
	emp_message = span_danger("Os fabricantes de armas de minha reação são e som ominosamente por um momento...")
	var/tele_range = 10

/obj/item/clothing/suit/armor/reactive/table/reactive_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	owner.visible_message(span_danger("O sistema de teletransporte se move.[owner] Livre de [attack_text] E bater [owner.p_them()] Em uma mesa fabricada!"))
	owner.visible_message("<font color='red' size='3'>[owner] Vai na Mesa!</font>")
	owner.Knockdown(30)
	owner.apply_damage(10, BRUTE)
	owner.apply_damage(40, STAMINA)
	playsound(owner, 'sound/effects/tableslam.ogg', 90, TRUE)
	owner.add_mood_event("table", /datum/mood_event/table)
	do_teleport(owner, get_turf(owner), tele_range, no_effects = TRUE, channel = TELEPORT_CHANNEL_BLUESPACE)
	new /obj/structure/table(get_turf(owner))
	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return TRUE

/obj/item/clothing/suit/armor/reactive/table/emp_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	owner.visible_message(span_danger("O sistema de teletransporte se move.[owner] Livre de [attack_text] E bater [owner.p_them()] em uma mesa de vidro fabricada!"))
	owner.visible_message("<font color='red' size='3'>[owner] Vai na mesa de vídeo!</font>")
	do_teleport(owner, get_turf(owner), tele_range, no_effects = TRUE, channel = TELEPORT_CHANNEL_BLUESPACE)
	var/obj/structure/table/glass/shattering_table = new /obj/structure/table/glass(get_turf(owner))
	shattering_table.table_shatter(owner)

	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return TRUE

//Hallucinating

/obj/item/clothing/suit/armor/reactive/hallucinating
	name = "reactive hallucinating armor"
	desc = "Uma armadura experimental com detectores sensíveis ligados à mente do usuário, enviando pulsos mentais que causam alucinações ao seu redor."
	cooldown_message = span_danger("A conexão está fora de sincronia... Recalibrando.")
	emp_message = span_warning("Você sente o retorno de um pulso mental.")
	clothing_traits = list(TRAIT_MADNESS_IMMUNE)

/obj/item/clothing/suit/armor/reactive/hallucinating/cooldown_activation(mob/living/carbon/human/owner)
	do_sparks(1, TRUE, src)
	return ..()

/obj/item/clothing/suit/armor/reactive/hallucinating/reactive_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	owner.visible_message(span_danger("[src] Blocos.[attack_text], enviando pulsos mentonais!"))
	visible_hallucination_pulse(
		center = get_turf(owner),
		radius = 3,
		hallucination_duration = 50 SECONDS,
		hallucination_max_duration = 300 SECONDS,
	)
	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return TRUE

/obj/item/clothing/suit/armor/reactive/hallucinating/emp_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	owner.visible_message(span_danger("[src] Blocos.[attack_text], mas puxa uma carga maciça de energia mental em [owner] Faça ambiente circundante!"))
	owner.adjust_hallucinations_up_to(50 SECONDS, 240 SECONDS)
	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return TRUE

//Bioscrambling
/obj/item/clothing/suit/armor/reactive/bioscrambling
	name = "reactive bioscrambling armor"
	desc = "Uma armadura experimental com detectores sensíveis ligada a uma válvula de liberação de risco biológico. Ele mistura os corpos daqueles ao redor."
	cooldown_message = span_danger("A conexão está fora de sincronia... Recalibrando.")
	emp_message = span_warning("Você sente a armadura se contorcer.")
	///Range of the effect.
	var/range = 5
	///Lists for zones and bodyparts to swap and randomize
	var/static/list/zones = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	var/static/list/chests
	var/static/list/heads
	var/static/list/l_arms
	var/static/list/r_arms
	var/static/list/l_legs
	var/static/list/r_legs

/obj/item/clothing/suit/armor/reactive/bioscrambling/Initialize(mapload)
	. = ..()
	if(!chests)
		chests = typesof(/obj/item/bodypart/chest)
	if(!heads)
		heads = typesof(/obj/item/bodypart/head)
	if(!l_arms)
		l_arms = typesof(/obj/item/bodypart/arm/left)
	if(!r_arms)
		r_arms = typesof(/obj/item/bodypart/arm/right)
	if(!l_legs)
		l_legs = typesof(/obj/item/bodypart/leg/left)
	if(!r_legs)
		r_legs = typesof(/obj/item/bodypart/leg/right)

/obj/item/clothing/suit/armor/reactive/bioscrambling/cooldown_activation(mob/living/carbon/human/owner)
	do_sparks(1, TRUE, src)
	..()

/obj/item/clothing/suit/armor/reactive/bioscrambling/reactive_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	owner.visible_message(span_danger("[src] Blocos.[attack_text], corpo de risco biológico liberado!"))
	bioscrambler_pulse(owner, FALSE)
	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return TRUE

/obj/item/clothing/suit/armor/reactive/bioscrambling/emp_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	owner.visible_message(span_danger("[src] Blocos.[attack_text], mas puxa uma carga maciça de material de risco biológico para [owner] Faça ambiente circundante!"))
	bioscrambler_pulse(owner, TRUE)
	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return TRUE

/obj/item/clothing/suit/armor/reactive/bioscrambling/proc/bioscrambler_pulse(mob/living/carbon/human/owner, can_hit_owner = FALSE)
	for(var/mob/living/carbon/nearby in range(range, get_turf(src)))
		if(!can_hit_owner && nearby == owner)
			continue
		nearby.bioscramble(name)

// When the wearer gets hit, this armor will push people nearby and spawn some blocking objects.
/obj/item/clothing/suit/armor/reactive/barricade
	name = "reactive barricade armor"
	desc = "Uma armadura experimental que gera barreiras de outro mundo quando detecta seu portador está em perigo."
	emp_message = span_warning("As coordenadas dimensionais da armadura reativa estão embaralhadas!")
	cooldown_message = span_danger("O sistema de barreira reativa ainda está recarregando! Ele falha em ativar!")
	reactivearmor_cooldown_duration = 10 SECONDS

/obj/item/clothing/suit/armor/reactive/barricade/reactive_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	playsound(get_turf(owner),'sound/effects/magic/repulse.ogg', 100, TRUE)
	owner.visible_message(span_danger("A armadura reativa interpõe matéria de outro mundo entre [src] E [attack_text]!"))
	for (var/atom/movable/target in repulse_targets(owner))
		repulse(target, owner)

	var/datum/armour_dimensional_theme/theme = new()
	theme.apply_random(get_turf(owner), dangerous = FALSE)
	qdel(theme)

	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return TRUE

/**
 * Returns a list of all atoms around the source which can be moved away from it.
 *
 * Arguments
 * * source - Thing to try to move things away from.
 */
/obj/item/clothing/suit/armor/reactive/barricade/proc/repulse_targets(atom/source)
	var/list/push_targets = list()
	for (var/atom/movable/nearby_movable in view(1, source))
		if(nearby_movable == source)
			continue
		if(nearby_movable.anchored)
			continue
		push_targets += nearby_movable
	return push_targets

/**
 * Pushes something one tile away from the source.
 *
 * Arguments
 * * victim - Thing being moved.
 * * source - Thing to move it away from.
 */
/obj/item/clothing/suit/armor/reactive/barricade/proc/repulse(atom/movable/victim, atom/source)
	var/dist_from_caster = get_dist(victim, source)

	if(dist_from_caster == 0)
		return

	if (isliving(victim))
		to_chat(victim, span_userdanger("Você é jogado de volta por uma onda de pressão!"))
	var/turf/throwtarget = get_edge_target_turf(source, get_dir(source, get_step_away(victim, source, 1)))
	victim.safe_throw_at(throwtarget, 1, 1, source, force = MOVE_FORCE_EXTREMELY_STRONG)

/obj/item/clothing/suit/armor/reactive/barricade/emp_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	owner.visible_message(span_danger("A armadura reativa desvia a matéria de uma dimensão instável!"))
	var/datum/armour_dimensional_theme/theme = new()
	theme.apply_random(get_turf(owner), dangerous = TRUE)
	qdel(theme)
	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return FALSE

/obj/item/clothing/suit/armor/reactive/ectoplasm
	name = "reactive possession armor"
	desc = "Uma armadura experimental que anima objetos próximos com uma possessão fantasmagórica."
	emp_message = span_warning("A armadura reativa deixa sair um barulho horrível, e sussurros fantasmas enchem seus ouvidos...")
	cooldown_message = span_danger("Matrix ectoplasmática fora de equilíbrio. Por favor, espere a calibração terminar!")
	reactivearmor_cooldown_duration = 40 SECONDS

/obj/item/clothing/suit/armor/reactive/ectoplasm/reactive_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	playsound(get_turf(owner),'sound/effects/hallucinations/veryfar_noise.ogg', 100, TRUE)
	owner.visible_message(span_danger("O [src] Solta uma explosão de energia de outro mundo!"))

	haunt_outburst(epicenter = get_turf(owner), range = 5, haunt_chance = 85, duration = 30 SECONDS)

	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return TRUE

/obj/item/clothing/suit/armor/reactive/ectoplasm/emp_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	owner.reagents?.add_reagent(/datum/reagent/inverse/helgrasp, 20)

/obj/item/clothing/suit/armor/reactive/weather
	name = "reactive weather armor"
	desc = "Uma armadura experimental que manipula o tempo ao redor do usuário quando em perigo."
	emp_message = span_warning("Uma arma reativa controla o tempo...")
	cooldown_message = span_danger("O sistema meteorológico reativo ainda está recarregando! Ele falha em ativar!")
	reactivearmor_cooldown_duration = 30 SECONDS

/obj/item/clothing/suit/armor/reactive/weather/reactive_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	owner.visible_message(span_danger("Uma arma reativa altera o tempo ao refazer.[owner], protegendo [owner.p_them()] De [attack_text]!"))
	playsound(src, 'sound/effects/magic/lightningshock.ogg', 33, TRUE, extrarange = SHORT_RANGE_SOUND_EXTRARANGE)

	var/datum/effect_system/basic/steam_spread/steam = new(owner.loc, 10, FALSE)
	steam.start()

	var/list/affected_turfs = list()
	for(var/mob/living/attacker in oview(2, owner))
		attacker.adjust_wet_stacks(5)
		attacker.extinguish_mob()
		if((attacker.loc in affected_turfs) || !isopenturf(attacker.loc))
			continue

		for(var/turf/open/to_affect in view(1, attacker.loc))
			affected_turfs += to_affect

		shock_turf_windup(attacker.loc)

	reactivearmor_cooldown = world.time + reactivearmor_cooldown_duration
	return TRUE

/obj/item/clothing/suit/armor/reactive/weather/emp_activation(mob/living/carbon/human/owner, atom/movable/hitby, attack_text, final_block_chance, damage, attack_type)
	owner.visible_message(span_danger("A arma reativa avaria, chamando uma tempestade sobre [owner.p_them()]!"))
	playsound(src, 'sound/effects/magic/lightningshock.ogg', 33, TRUE, extrarange = SHORT_RANGE_SOUND_EXTRARANGE)

	var/datum/effect_system/basic/steam_spread/steam = new(owner.loc, 2, FALSE)
	steam.start()

	owner.adjust_wet_stacks(10)
	owner.extinguish_mob()
	if(!isopenturf(owner.loc))
		return
	shock_turf_windup(owner.loc)

/obj/item/clothing/suit/armor/reactive/weather/proc/shock_turf_windup(turf/target)
	new /obj/effect/temp_visual/telegraphing/thunderbolt(target)
	addtimer(CALLBACK(src, PROC_REF(shock_turf), target), 1 SECONDS)

/obj/item/clothing/suit/armor/reactive/weather/proc/shock_turf(turf/target)
	playsound(target, 'sound/effects/magic/lightningbolt.ogg', 66, TRUE)
	new /obj/effect/temp_visual/thunderbolt(target)
	for(var/turf/open/adjacent_turf in oview(1, target))
		new /obj/effect/temp_visual/electricity(adjacent_turf)

	for(var/mob/living/hit_mob in target)
		if(hit_mob == loc) // avoid hitting the wearer
			continue
		to_chat(hit_mob, span_userdanger("Você foi atingido por um raio!"))
		hit_mob.electrocute_act(30, src, flags = SHOCK_TESLA|SHOCK_NOSTUN)
		hit_mob.Knockdown(2.5 SECONDS, 10 SECONDS)

	for(var/mob/living/nearby_target in oview(1, target))
		if(nearby_target == loc) // avoid hitting the wearer
			continue
		to_chat(nearby_target, span_userdanger("Você foi atingido por um arco de raios!"))
		nearby_target.electrocute_act(10, src, flags = SHOCK_TESLA|SHOCK_NOSTUN)

	for(var/obj/hit_thing in target)
		hit_thing.take_damage(20, BURN, ENERGY, FALSE)

	for(var/obj/nearby_thing in oview(1, target))
		nearby_thing.take_damage(5, BURN, ENERGY, FALSE)
