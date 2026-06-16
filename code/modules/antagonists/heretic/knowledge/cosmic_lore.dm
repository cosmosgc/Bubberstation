/datum/heretic_knowledge_tree_column/cosmic
	route = PATH_COSMIC
	ui_bgr = "node_cosmos"
	complexity = "Hard"
	complexity_color = COLOR_RED
	icon = list(
		"icon" = 'icons/obj/weapons/khopesh.dmi',
		"state" = "cosmic_blade",
		"frame" = 1,
		"dir" = SOUTH,
		"moving" = FALSE,
	)
	description = list(
		"The Path of Cosmos revolves around area denial, teleporation, and mastery over space.",
		"Pick this path if you enjoy adapting to your environment and thinking outside (or inside) the box.",
	)
	pros = list(
		"Control the movement of foes with cosmic fields",
		"Move in and around space with ease.",
		"Teleport rapidly across the station.",
		"Confound opponents with barriers upon barriers.",
	)
	cons = list(
		"Requires you spread your star mark to affect opponents with your cosmic fields.",
		"Relatively low damage.",
		"Relatively low direct defense, highly reliant on proper use of abilities.",
	)
	tips = list(
		"Your Mansus Grasp will mark your opponent with a star mark, as well as leave a mark that, when detonated, will teleport your opponent back to the place where the mark was applied and briefly paralyze them.",
		"Your cosmic runes can quickly teleport you from two different locations instantly. Beware, however; non-heretics are also able to travel through them. Be creative and have your opponents teleport right into a trap. They come out star marked!",
		"When standing on top of a cosmic rune, you can click on yourself with a empty hand to activate it.",
		"Star marked opponents cannot cross your cosmic fields willingly. But they can be dragged through!",
		"Star Blast is both a jaunt ability as well as a disabling tool. Use it to catch several people in your cosmic fields at once.",
		"Star Touch will prevent your target from teleporting away. Should they fail to break the tether, they will be put to sleep and then teleport to your feet.",
		"It's Always a good idea to leave one cosmic rune near your ritual rune, it will allow you to quickly kidnap your targets to sacrifice them.",
	)

	start = /datum/heretic_knowledge/limited_amount/starting/base_cosmic
	knowledge_tier1 = /datum/heretic_knowledge/spell/cosmic_runes
	guaranteed_side_tier1 = /datum/heretic_knowledge/eldritch_coin
	knowledge_tier2 = /datum/heretic_knowledge/spell/star_blast
	guaranteed_side_tier2 = /datum/heretic_knowledge/spell/space_phase
	robes = /datum/heretic_knowledge/armor/cosmic
	knowledge_tier3 = /datum/heretic_knowledge/spell/star_touch
	guaranteed_side_tier3 = /datum/heretic_knowledge/essence
	blade = /datum/heretic_knowledge/blade_upgrade/cosmic
	knowledge_tier4 = /datum/heretic_knowledge/spell/cosmic_expansion
	ascension = /datum/heretic_knowledge/ultimate/cosmic_final

/datum/heretic_knowledge/limited_amount/starting/base_cosmic
	name = "Eternal Gate"
	desc = "Abre o Caminho do Cosmos para você. Permite que transmute uma folha de plasma e uma faca em uma lâmina cósmica. Você só pode criar dois de cada vez."
	gain_text = "Uma nebulosa apareceu no céu, seu nascimento infernal brilhou sobre mim. Este foi o início de uma grande transcendência."
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/stack/sheet/mineral/plasma = 1,
	)
	result_atoms = list(/obj/item/melee/sickly_blade/cosmic)
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "cosmic_blade"
	mark_type = /datum/status_effect/eldritch/cosmic
	eldritch_passive = /datum/status_effect/heretic_passive/cosmic

/// Aplies the effect of the mansus grasp when it hits a target.
/datum/heretic_knowledge/limited_amount/starting/base_cosmic/on_mansus_grasp(mob/living/source, mob/living/target)
	. = ..()

	to_chat(target, span_danger("Um anel cósmico apareceu sobre sua cabeça!"))
	target.apply_status_effect(/datum/status_effect/star_mark, source)
	create_cosmic_field(get_turf(source), source)

/datum/heretic_knowledge/spell/cosmic_runes
	name = "Cosmic Runes"
	desc = "Concede a vocês Runas Cósmicas, um feitiço que cria duas runas ligadas uma à outra para fácil teletransporte. Só a entidade ativando a runa será transportada, e pode ser usada por qualquer um sem uma marca de estrela. No entanto, pessoas com uma marca estelar serão transportadas junto com outra pessoa usando a runa."
	gain_text = "As estrelas distantes entraram em meus sonhos, rugindo e gritando sem razão. Eu falei e ouvi minhas próprias palavras ecoando."
	action_to_add = /datum/action/cooldown/spell/cosmic_rune
	cost = 2
	drafting_tier = 5

/datum/heretic_knowledge/spell/star_blast
	name = "Star Blast"
	desc = "Dispara um projétil que se move muito lentamente, levantando uma parede de curta duração de campos cósmicos onde ele vai. Qualquer um atingido pelo projétil receberá dano por queimaduras, um nocaute, e dará às pessoas em uma faixa de três azulejos uma marca de estrela."
	gain_text = "A Besta estava atrás de mim o tempo todo, com cada sacrifício palavras de afirmação cursou através de mim."
	action_to_add = /datum/action/cooldown/spell/pointed/projectile/star_blast
	cost = 2

/datum/heretic_knowledge/armor/cosmic

	desc = "Permite que transmute uma mesa (ou um terno), uma máscara e uma folha de plasma para criar um Starweat Cloak, concede proteção contra os perigos do espaço enquanto concede ao usuário a capacidade de levitar à vontade. Atua como foco enquanto encapuza."
	gain_text = "Como cordas radiantes, as estrelas brilhavam em união através da forma sedosa de uma capa saliente, que ao mesmo tempo faz e não drapeia meus ombros. Os olhos da Besta repousaram sobre mim, e através de mim."
	result_atoms = list(/obj/item/clothing/suit/hooded/cultrobes/eldritch/cosmic)
	research_tree_icon_state = "cosmic_armor"
	required_atoms = list(
		list(/obj/structure/table, /obj/item/clothing/suit) = 1,
		/obj/item/clothing/mask = 1,
		/obj/item/stack/sheet/mineral/plasma = 1,
	)

/datum/heretic_knowledge/spell/star_touch
	name = "Star Touch"
	desc = "Concede-lhe Star Touch, um feitiço que coloca uma marca de estrela em seu alvo e cria um campo cósmico aos seus pés e aos territórios ao seu lado. Alvos que já têm uma marca estelar serão forçados a dormir por 4 segundos. Quando a vítima é atingida também cria um feixe que os queima. O feixe dura um minuto, até que o feixe seja obstruído ou até que um novo alvo seja encontrado."
	gain_text = "Depois de acordar em um suor frio eu senti uma palma no meu couro cabeludo, um selo queimou em mim. Minhas veias agora emitiram um estranho brilho roxo, a Besta sabe que superarei suas expectativas."
	action_to_add = /datum/action/cooldown/spell/touch/star_touch
	cost = 2

/datum/heretic_knowledge/blade_upgrade/cosmic
	name = "Cosmic Blade"
	desc = "Sua lâmina agora marca suas vítimas, e permite que você ataque estrelas pagãs marcadas de mais longe. Seus ataques vão gerar danos bônus em até duas vítimas anteriores. A combinação é reiniciada após dois segundos sem fazer um ataque, ou se você atacar alguém já marcado. Se combinar três ataques, receberá uma trilha cósmica e aumentará seu temporizador para 10 segundos."
	gain_text = "A Besta pegou minhas lâminas em suas mãos, eu me ajoelhei e senti uma dor aguda. As lâminas agora brilhavam com energia fragmentada. Eu caí no chão e chorei aos pés da besta."
	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "blade_upgrade_cosmos"
	/// Storage for the second target.
	var/datum/weakref/second_target
	/// Storage for the third target.
	var/datum/weakref/third_target
	/// When this timer completes we reset our combo.
	var/combo_timer
	/// The active duration of the combo.
	var/combo_duration = 3 SECONDS
	/// The duration of a combo when it starts.
	var/combo_duration_amount = 3 SECONDS
	/// The maximum duration of the combo.
	var/max_combo_duration = 10 SECONDS
	/// The amount the combo duration increases.
	var/increase_amount = 0.5 SECONDS
	/// The hits we have on a mob with a mind.
	var/combo_counter = 0
	/// How much further we can hit people, modified by ascension
	var/max_attack_range = 2

/datum/heretic_knowledge/blade_upgrade/cosmic/on_ranged_eldritch_blade(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	. = ..()
	if(!isliving(target) || get_dist(source, target) > max_attack_range || !target.has_status_effect(/datum/status_effect/star_mark))
		return
	source.changeNext_move(blade.attack_speed)
	return blade.attack(target, source)

/datum/heretic_knowledge/blade_upgrade/cosmic/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	if(source == target || !isliving(target))
		return
	target.apply_status_effect(/datum/status_effect/star_mark, source)
	if(combo_timer)
		deltimer(combo_timer)
	combo_timer = addtimer(CALLBACK(src, PROC_REF(reset_combo), source), combo_duration, TIMER_STOPPABLE)
	var/mob/living/second_target_resolved = second_target?.resolve()
	var/mob/living/third_target_resolved = third_target?.resolve()
	var/need_mob_update = FALSE
	need_mob_update += target.adjust_fire_loss(5, updating_health = FALSE)
	if(need_mob_update)
		target.updatehealth()
	if(target == second_target_resolved || target == third_target_resolved)
		reset_combo(source)
		return
	if(target.mind && target.stat != DEAD)
		combo_counter += 1
	if(second_target_resolved)
		new /obj/effect/temp_visual/cosmic_explosion(get_turf(second_target_resolved))
		playsound(get_turf(second_target_resolved), 'sound/effects/magic/cosmic_energy.ogg', 25, FALSE)
		need_mob_update = FALSE
		need_mob_update += second_target_resolved.adjust_fire_loss(14, updating_health = FALSE)
		if(need_mob_update)
			second_target_resolved.updatehealth()
		if(third_target_resolved)
			new /obj/effect/temp_visual/cosmic_domain(get_turf(third_target_resolved))
			playsound(get_turf(third_target_resolved), 'sound/effects/magic/cosmic_energy.ogg', 50, FALSE)
			need_mob_update = FALSE
			need_mob_update += third_target_resolved.adjust_fire_loss(28, updating_health = FALSE)
			if(need_mob_update)
				third_target_resolved.updatehealth()
			if(combo_counter == 3)
				if(target.mind && target.stat != DEAD)
					increase_combo_duration()
					source.AddElement(cosmic_trail_based_on_passive(source), /obj/effect/forcefield/cosmic_field/fast)
		third_target = second_target
	second_target = WEAKREF(target)

/// Resets the combo.
/datum/heretic_knowledge/blade_upgrade/cosmic/proc/reset_combo(mob/living/source)
	second_target = null
	third_target = null
	source.RemoveElement(cosmic_trail_based_on_passive(source), /obj/effect/forcefield/cosmic_field/fast)
	combo_duration = combo_duration_amount
	combo_counter = 0
	new /obj/effect/temp_visual/cosmic_cloud(get_turf(source))
	if(combo_timer)
		deltimer(combo_timer)

/// Increases the combo duration.
/datum/heretic_knowledge/blade_upgrade/cosmic/proc/increase_combo_duration()
	if(combo_duration < max_combo_duration)
		combo_duration += increase_amount

/datum/heretic_knowledge/spell/cosmic_expansion
	name = "Cosmic Expansion"
	desc = "Concede-lhe Expansão Cósmica, um feitiço que cria uma área 5x5 de campos cósmicos ao seu redor. Seres próximos também receberão uma marca estelar."
	gain_text = "O chão agora tremeu sob mim. A Besta me habitava, e sua voz era intoxicante."
	action_to_add = /datum/action/cooldown/spell/conjure/cosmic_expansion
	cost = 2
	is_final_knowledge = TRUE

/datum/heretic_knowledge/ultimate/cosmic_final
	name = "Creators's Gift"
	desc = "O ritual de ascensão do Caminho do Cosmos. Traga 3 corpos com uma marca de estrela para uma runa de transmutação para completar o ritual. Quando concluído, você se torna o dono de um Star Gazer. Poderá comandar o Star Gazer com Alt+click. Você também pode dar ordens através da fala. O Star Gazer é um forte aliado que pode até quebrar paredes reforçadas. O Star Gazer tem uma aura que vai curar você e danificar oponentes. Star Touch pode agora teletransportar você para o Star Gazer quando ativado em sua mão. Seu feitiço de expansão cósmica e suas lâminas também se tornam muito poderosas."
	gain_text = "A Besta estendeu sua mão, eu segurei e eles me puxaram até eles. Seu corpo era imponente, mas parecia tão pequeno e fraco depois de todas as suas histórias compiladas na minha cabeça. Eu me agarrei a eles, eles me protegeriam, e eu protegeria. Fechei os olhos com a cabeça contra a forma deles. Eu estava segura. Testemunhe minha ascensão!"

	ascension_achievement = /datum/award/achievement/misc/cosmic_ascension
	announcement_text = "Um Star Gazer chegou à estação. Esta estação é o domínio do Cosmos! SPOOKY"
	announcement_sound = 'sound/music/antag/heretic/ascend_cosmic.ogg'
	/// A static list of command we can use with our mob.
	var/static/list/star_gazer_commands = list(
		/datum/pet_command/idle,
		/datum/pet_command/free,
		/datum/pet_command/follow,
		/datum/pet_command/attack/star_gazer
	)
	/// List of traits given once ascended
	var/static/list/ascended_traits = list(TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTHIGHPRESSURE, TRAIT_RESISTCOLD, TRAIT_RESISTHEAT, TRAIT_XRAY_VISION)
	/// List of traits given to our cute lil guy
	var/static/list/stargazer_traits = list(TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTHIGHPRESSURE, TRAIT_RESISTCOLD, TRAIT_RESISTHEAT, TRAIT_BOMBIMMUNE, TRAIT_XRAY_VISION)

/datum/heretic_knowledge/ultimate/cosmic_final/is_valid_sacrifice(mob/living/carbon/human/sacrifice)
	. = ..()
	if(!.)
		return FALSE

	return sacrifice.has_status_effect(/datum/status_effect/star_mark)

/datum/heretic_knowledge/ultimate/cosmic_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	user.add_traits(ascended_traits, type)
	if(ishuman(user))
		var/mob/living/carbon/human/ascended_human = user
		var/obj/item/organ/eyes/heretic_eyes = ascended_human.get_organ_slot(ORGAN_SLOT_EYES)
		ascended_human.update_sight()
		heretic_eyes?.color_cutoffs = list(30, 30, 30)
		ascended_human.update_sight()

	var/mob/living/basic/heretic_summon/star_gazer/star_gazer_mob = new /mob/living/basic/heretic_summon/star_gazer(loc, user)
	star_gazer_mob.maxHealth = INFINITY
	star_gazer_mob.health = INFINITY
	user.AddComponent(/datum/component/death_linked, star_gazer_mob)
	star_gazer_mob.AddComponent(/datum/component/obeys_commands, star_gazer_commands, radial_menu_offset = list(30,0), radial_menu_lifetime = 15 SECONDS, radial_relative_to_user = TRUE)
	star_gazer_mob.befriend(user)
	var/datum/action/cooldown/open_mob_commands/commands_action = new /datum/action/cooldown/open_mob_commands()
	commands_action.Grant(user, star_gazer_mob)
	var/datum/action/cooldown/spell/touch/star_touch/star_touch_spell = locate() in user.actions
	if(star_touch_spell)
		star_touch_spell.set_star_gazer(star_gazer_mob)
		star_touch_spell.ascended = TRUE
	star_gazer_mob.add_traits(stargazer_traits, type)
	star_gazer_mob.leash_to(star_gazer_mob, user)

	var/datum/antagonist/heretic/heretic_datum = user.mind.has_antag_datum(/datum/antagonist/heretic)
	var/datum/heretic_knowledge/blade_upgrade/cosmic/blade_upgrade = heretic_datum.get_knowledge(/datum/heretic_knowledge/blade_upgrade/cosmic)
	blade_upgrade.combo_duration = 10 SECONDS
	blade_upgrade.combo_duration_amount = 10 SECONDS
	blade_upgrade.max_combo_duration = 30 SECONDS
	blade_upgrade.increase_amount = 2 SECONDS
	blade_upgrade.max_attack_range = 3

	var/datum/action/cooldown/spell/conjure/cosmic_expansion/cosmic_expansion_spell = locate() in user.actions
	cosmic_expansion_spell?.ascended = TRUE

	var/datum/action/cooldown/mob_cooldown/replace_star_gazer/replace_gazer = new(src)
	replace_gazer.Grant(user)
	replace_gazer.bad_dog = WEAKREF(star_gazer_mob)

/// Replace an annoying griefer you were paired up to with a different but probably no less annoying player.
/datum/action/cooldown/mob_cooldown/replace_star_gazer
	name = "Reset Star Gazer Consciousness"
	desc = "Substitui a mente de sua convocação com a de um fantasma diferente."
	button_icon = 'icons/mob/simple/mob.dmi'
	button_icon_state = "ghost"
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	check_flags = NONE
	click_to_activate = FALSE
	cooldown_time = 5 SECONDS
	melee_cooldown_time = 0
	shared_cooldown = NONE
	/// Weakref to the stargazer we care about
	var/datum/weakref/bad_dog

/datum/action/cooldown/mob_cooldown/replace_star_gazer/Activate(atom/target)
	StartCooldown(5 MINUTES)

	var/mob/living/to_reset = bad_dog.resolve()

	to_chat(owner, span_hierophant("Você pede [to_reset] Para mudar de lugar.\'personalidade..."))
	var/mob/chosen_one = SSpolling.poll_ghost_candidates("Você quer jogar como[span_danger("[owner.real_name]'s")] [span_notice(to_reset.name)]?", check_jobban = ROLE_PAI, poll_time = 10 SECONDS, alert_pic = to_reset, jump_target = owner, role_name_text = to_reset.name, amount_to_pick = 1)
	if(isnull(chosen_one))
		to_chat(owner, span_hierophant("Seu pedido de mudança.[to_reset] Sua personalidade parece ter sido negada... Parece que você está preso com isso por enquanto."))
		StartCooldown()
		return FALSE
	to_chat(to_reset, span_hierophant("Seu chamador o reiniciou, e seu corpo foi tomado por um fantasma. Parece que eles não estavam felizes com sua performance."))
	to_chat(owner, span_hierophant("A mente de [to_reset] se torceu para se adequar melhor."))
	message_admins("[key_name_admin(chosen_one)] has taken control of ([ADMIN_LOOKUPFLW(to_reset)])")
	to_reset.ghostize(FALSE)
	to_reset.PossessByPlayer(chosen_one.key)
	StartCooldown()
	return TRUE
