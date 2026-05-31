/datum/heretic_knowledge_tree_column/void
	route = PATH_VOID
	ui_bgr = "node_void"
	complexity = "Easy"
	complexity_color = COLOR_GREEN
	icon = list(
		"icon" = 'icons/obj/weapons/khopesh.dmi',
		"state" = "void_blade",
		"frame" = 1,
		"dir" = SOUTH,
		"moving" = FALSE,
	)
	description = list(
		"The Path of Void focuses on stealth, freezing cold, mobility and depressurization.",
		"Pick this path if you enjoy being a highly mobile assassin who leaves their foes struggling to catch up.",
	)
	pros = list(
		"Protection from the hazards of space.",
		"Your spells apply a stacking debuff that chills and slows targets.",
		"High amount of mobility spells.",
		"Highly stealthy.",
	)
	cons = list(
		"Though protected from space, you are not nearly as mobile in it as you are on foot.",
		"Has a difficult time fighting opponents immune to cold effects.",
		"Has a difficult time with silicon-based lifeforms.",
	)
	tips = list(
		"Your Mansus Grasp allows you to mute your targets, making it ideal for silent assassinations (keep in mind that it won't short circuit their suit sensors, make sure you turn them off after you kill them). Yhe grasp also applies a mark that when triggered by the void blade will apply the maximum amount of stacks of void chill to your target, slowing them down to a crawl.",
		"Void Cloak can be used to hide one of your blades and a Codex Cicatrix when the hood is down,  while acting as a focus when it's up.",
		"Void chill is a debuff applied by your spells, your grasp, your mark and your blade once you unlock the upgrade. Each stack slows your target movement speed by 10% and make them gradually colder, up to a maximum of 5 stacks.",
		"At 5 stacks void chill will also prevent your target from heating up.",
		"You are immune to low pressure and cold damage at the start of the shift. Upgrade your passive to level 2 to no longer need to breathe. Use this to your advantage.",
		"Void prison can put a target in stasis for 10 seconds. Ideal if you are fighting multiple opponents and need to isolate one target at a time.",
		"Void Conduit is your signature ability. It slowly destroys windows and airlocks around its area of effect. Use it to depressurize the station and expand your domain.",
	)

	start = /datum/heretic_knowledge/limited_amount/starting/base_void
	knowledge_tier1 = /datum/heretic_knowledge/spell/void_phase
	guaranteed_side_tier1 = /datum/heretic_knowledge/void_cloak
	knowledge_tier2 = /datum/heretic_knowledge/spell/void_prison
	guaranteed_side_tier2 = /datum/heretic_knowledge/ether
	robes = /datum/heretic_knowledge/armor/void
	knowledge_tier3 = /datum/heretic_knowledge/spell/void_pull
	guaranteed_side_tier3 = /datum/heretic_knowledge/summon/maid_in_mirror
	blade = /datum/heretic_knowledge/blade_upgrade/void
	knowledge_tier4 = /datum/heretic_knowledge/spell/void_conduit
	ascension = /datum/heretic_knowledge/ultimate/void_final

/datum/heretic_knowledge/limited_amount/starting/base_void
	name = "Glimmer of Winter"
	desc = "Abre o Caminho do Vazio para você. Permite que transmute uma faca em temperaturas abaixo de zero em uma Lâmina Vazio. Você só pode criar cinco de cada vez." //SKYRAT EDIT two to five
	gain_text = "Eu sinto um brilho no ar, o ar ao meu redor fica mais frio. Começo a perceber o vazio da existência. Algo está me observando."
	required_atoms = list(/obj/item/knife = 1)
	result_atoms = list(/obj/item/melee/sickly_blade/void)
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "void_blade"
	mark_type = /datum/status_effect/eldritch/void
	eldritch_passive = /datum/status_effect/heretic_passive/void

/datum/heretic_knowledge/limited_amount/starting/base_void/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	if(!isopenturf(loc))
		loc.balloon_alert(user, "ritual falhou, localização inválida!")
		return FALSE

	var/turf/open/our_turf = loc
	if(our_turf.GetTemperature() > T0C)
		loc.balloon_alert(user, "O ritual falhou, não o suficiente!")
		return FALSE

	return ..()

/datum/heretic_knowledge/limited_amount/starting/base_void/on_mansus_grasp(mob/living/source, mob/living/target)
	. = ..()

	if(!iscarbon(target))
		return

	var/mob/living/carbon/carbon_target = target
	carbon_target.adjust_silence(10 SECONDS)
	carbon_target.apply_status_effect(/datum/status_effect/void_chill, 2)

/datum/heretic_knowledge/spell/void_phase
	name = "Void Phase"
	desc = "Concede Fase Vazio, um feitiço de teletransporte de longo alcance. Além disso, causa danos aos pagãos ao redor do seu destino original e alvo."
	gain_text = "A entidade se chama Aristocrata. Eles caminham sem esforço pelo ar como nada - deixando uma brisa dura e fria em seu rastro. Eles desaparecem, e eu fico na nevasca."
	action_to_add = /datum/action/cooldown/spell/pointed/void_phase
	cost = 2
	research_tree_icon_frame = 7

/datum/heretic_knowledge/spell/void_prison
	name = "Void Prison"
	desc = "Concede-lhe a Prisão Vazio, um feitiço que coloca sua vítima em uma bola, tornando-os incapazes de fazer qualquer coisa ou falar. Aplica frio vazio depois."
	gain_text = "No começo, eu me vejo, andando por uma rua cheia de neve. Eu tento gritar, pegar esse idiota e dizer-lhes para correr. Mas as únicas manchas feitas são por conta própria. Meu rosto sorridente se volta para me olhar, refletindo de volta em olhos vidrados o caminho vazio que eu tenho sido conduzido para baixo."

	action_to_add = /datum/action/cooldown/spell/pointed/void_prison
	cost = 2
	drafting_tier = 5

/datum/heretic_knowledge/armor/void
	name = "Hollow Weave"
	desc = "Permite que transmute uma mesa (ou um terno) e uma máscara em temperaturas abaixo de zero para criar uma Teia Oca, esta armadura irá periodicamente anular ataques e lhe conceder uma curta camuflagem furtiva para se reposicionar. Atua como foco enquanto encapuza."
	gain_text = "Passando pelo ar frio, estou chocado com uma nova sensação. Milhares de fios quase imperceptíveis se agarram à minha forma. Estou à deriva a cada passo. Mesmo ouvindo o barulho da neve enquanto planto meu pé no chão, não sinto nada."
	result_atoms = list(/obj/item/clothing/suit/hooded/cultrobes/eldritch/void)
	research_tree_icon_state = "void_armor"
	required_atoms = list(
		list(/obj/structure/table, /obj/item/clothing/suit) = 1,
		/obj/item/clothing/mask = 1,
	)

/datum/heretic_knowledge/armor/void/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	if(!isopenturf(loc))
		loc.balloon_alert(user, "ritual falhou, localização inválida!")
		return FALSE

	var/turf/open/our_turf = loc
	if(our_turf.GetTemperature() > T0C)
		loc.balloon_alert(user, "O ritual falhou, não o suficiente!")
		return FALSE

	return ..()

/datum/heretic_knowledge/spell/void_pull
	name = "Void Pull"
	desc = "Concede-lhe Pull Vazio, um feitiço que puxa todos os pagãos próximos em sua direção, atordoando-os brevemente."
	gain_text = "Tudo é passageiro, mas o que mais fica? Estou perto de terminar o que começou. O Aristocrata se revela para mim novamente. Dizem que estou atrasado. Sua atração é imensa, não posso voltar atrás."

	action_to_add = /datum/action/cooldown/spell/aoe/void_pull
	cost = 2
	research_tree_icon_frame = 6

/datum/heretic_knowledge/blade_upgrade/void
	name = "Seeking Blade"
	desc = "Sua lâmina agora congela inimigos. Além disso, agora você pode atacar alvos distantes marcados com sua Lâmina Vazio, teletransportando diretamente ao lado deles."
	gain_text = "Memórias fugazes, pés fugazes. Eu marco meu caminho com sangue congelado na neve. Coberto e esquecido."


	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "blade_upgrade_void"

/datum/heretic_knowledge/blade_upgrade/void/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	if(source == target || !isliving(target))
		return

	target.apply_status_effect(/datum/status_effect/void_chill, 2)

/datum/heretic_knowledge/blade_upgrade/void/do_ranged_effects(mob/living/user, mob/living/target, obj/item/melee/sickly_blade/blade)
	if(!target.has_status_effect(/datum/status_effect/eldritch))
		return

	var/dir = angle2dir(dir2angle(get_dir(user, target)) + 180)
	user.forceMove(get_step(target, dir))

	INVOKE_ASYNC(src, PROC_REF(follow_up_attack), user, target, blade)

/datum/heretic_knowledge/blade_upgrade/void/proc/follow_up_attack(mob/living/user, mob/living/target, obj/item/melee/sickly_blade/blade)
	blade.melee_attack_chain(user, target)

/datum/heretic_knowledge/spell/void_conduit
	name = "Void Conduit"
	desc = "Concede-lhe Vazio Conduit, um feitiço que invoca um portal pulsante para o próprio Vazio. Todos os pulsos quebram janelas e comportas, enquanto afligem os Heathens com um frio de eldritch e protegem os hereges contra baixa pressão."
	gain_text = "O zumbido no ar frio se transforma em um chocalho cacofônico. Sobre o barulho, não há distinção para o barulho das janelas e o conhecimento bocejante que ricocheteia através do meu crânio. As portas não fecham. Não posso manter o frio fora agora."
	action_to_add = /datum/action/cooldown/spell/conjure/void_conduit
	cost = 2
	is_final_knowledge = TRUE

/datum/heretic_knowledge/ultimate/void_final
	name = "Waltz at the End of Time"
	desc = "O ritual de ascensão do Caminho do Vazio. Traga 3 corpos para uma runa de transmutação em temperaturas abaixo de zero para completar o ritual. Quando concluída, causa uma violenta tempestade de neve vazia para atacar a estação, congelando e prejudicando pagãos. Os próximos serão silenciados e congelados ainda mais rápido. Além disso, você ficará imune aos efeitos do espaço."
	gain_text = "O mundo cai na escuridão. Estou em um avião vazio, pequenos flocos de gelo caem do céu. O Aristocrata está diante de mim, acenando. Tocaremos uma valsa aos sussurros da realidade moribunda, enquanto o mundo é destruído diante de nossos olhos. O vazio voltará ao nada, testemunhe minha ascensão!"

	ascension_achievement = /datum/award/achievement/misc/void_ascension
	announcement_text = "O nobre do vazio chegou, pisando ao longo da valsa que termina mundos! SPOOKY"
	announcement_sound = 'sound/music/antag/heretic/ascend_void.ogg'
	///soundloop for the void theme
	var/datum/looping_sound/void_loop/sound_loop
	///Reference to the ongoing voidstrom that surrounds the heretic
	var/datum/weather/void_storm/storm
	///The storm where there are actual effects
	var/datum/proximity_monitor/advanced/void_storm/heavy_storm

/datum/heretic_knowledge/ultimate/void_final/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	if(!isopenturf(loc))
		loc.balloon_alert(user, "ritual falhou, localização inválida!")
		return FALSE

	var/turf/open/our_turf = loc
	if(our_turf.GetTemperature() > T0C)
		loc.balloon_alert(user, "O ritual falhou, não o suficiente!")
		return FALSE

	return ..()

/datum/heretic_knowledge/ultimate/void_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	user.add_traits(list(TRAIT_RESISTLOWPRESSURE, TRAIT_NEGATES_GRAVITY, TRAIT_MOVE_FLYING, TRAIT_FREE_HYPERSPACE_MOVEMENT), type)

	// Let's get this show on the road!
	sound_loop = new(user, TRUE, TRUE)
	RegisterSignal(user, COMSIG_LIVING_LIFE, PROC_REF(on_life))
	RegisterSignal(user, COMSIG_ATOM_PRE_BULLET_ACT, PROC_REF(hit_by_projectile))
	RegisterSignals(user, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING), PROC_REF(on_death))
	heavy_storm = new(user, 10)
	if(ishuman(user))
		var/mob/living/carbon/human/ascended_human = user
		var/obj/item/organ/eyes/heretic_eyes = ascended_human.get_organ_slot(ORGAN_SLOT_EYES)
		heretic_eyes?.color_cutoffs = list(30, 30, 30)
		ascended_human.update_sight()

/datum/heretic_knowledge/ultimate/void_final/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	on_death() // Losing is pretty much dying. I think

/**
 * Signal proc for [COMSIG_LIVING_LIFE].
 *
 * Any non-heretics nearby the heretic ([source])
 * are constantly silenced and battered by the storm.
 *
 * Also starts storms in any area that doesn't have one.
 */
/datum/heretic_knowledge/ultimate/void_final/proc/on_life(mob/living/source, seconds_per_tick)
	SIGNAL_HANDLER

	for(var/atom/thing_in_range as anything in range(10, source))
		if(iscarbon(thing_in_range))
			var/mob/living/carbon/close_carbon = thing_in_range
			if(close_carbon.can_block_magic())
				continue
			if(IS_HERETIC_OR_MONSTER(close_carbon))
				close_carbon.apply_status_effect(/datum/status_effect/void_conduit)
				continue
			close_carbon.adjust_silence_up_to(2 SECONDS, 20 SECONDS)
			close_carbon.apply_status_effect(/datum/status_effect/void_chill, 1)
			close_carbon.adjust_eye_blur(rand(0 SECONDS, 2 SECONDS))
			close_carbon.adjust_bodytemperature(-30 * TEMPERATURE_DAMAGE_COEFFICIENT)

		if(istype(thing_in_range, /obj/machinery/door) || istype(thing_in_range, /obj/structure/door_assembly))
			var/obj/affected_door = thing_in_range
			affected_door.take_damage(rand(60, 80))

		if(istype(thing_in_range, /obj/structure/window) || istype(thing_in_range, /obj/structure/grille))
			var/obj/structure/affected_structure = thing_in_range
			affected_structure.take_damage(rand(20, 40))

		if(isturf(thing_in_range))
			var/turf/affected_turf = thing_in_range
			var/datum/gas_mixture/environment = affected_turf.return_air()
			environment.temperature *= 0.9

	// Telegraph the storm in every area on the station.
	var/list/station_levels = SSmapping.levels_by_trait(ZTRAIT_STATION)
	if(!storm)
		storm = new /datum/weather/void_storm(station_levels)
		storm.telegraph()

/**
 * Signal proc for [COMSIG_LIVING_DEATH].
 *
 * Stop the storm when the heretic passes away.
 */
/datum/heretic_knowledge/ultimate/void_final/proc/on_death(datum/source)
	SIGNAL_HANDLER

	if(sound_loop)
		sound_loop.stop()
	if(storm)
		storm.end()
		QDEL_NULL(storm)
	if(heavy_storm)
		QDEL_NULL(heavy_storm)
	UnregisterSignal(source, list(COMSIG_LIVING_LIFE, COMSIG_ATOM_PRE_BULLET_ACT, COMSIG_LIVING_DEATH, COMSIG_QDELETING))

///Few checks to determine if we can deflect bullets
/datum/heretic_knowledge/ultimate/void_final/proc/can_deflect(mob/living/ascended_heretic)
	if(!(ascended_heretic.mobility_flags & MOBILITY_USE))
		return FALSE
	if(!isturf(ascended_heretic.loc))
		return FALSE
	return TRUE

/datum/heretic_knowledge/ultimate/void_final/proc/hit_by_projectile(mob/living/ascended_heretic, obj/projectile/hitting_projectile, def_zone)
	SIGNAL_HANDLER

	if(!can_deflect(ascended_heretic))
		return NONE

	ascended_heretic.visible_message(
		span_danger("A tempestade vazia ao redor[ascended_heretic]Desvios[hitting_projectile]!"),
		span_userdanger("A tempestade vazia te protege de[hitting_projectile]!"),
	)
	playsound(ascended_heretic, SFX_VOID_DEFLECT, 75, TRUE)
	hitting_projectile.firer = ascended_heretic
	if(prob(75))
		hitting_projectile.set_angle(get_angle(hitting_projectile.firer, hitting_projectile.fired_from))
	else
		hitting_projectile.set_angle(rand(0, 360))//SHING
	return COMPONENT_BULLET_PIERCED
