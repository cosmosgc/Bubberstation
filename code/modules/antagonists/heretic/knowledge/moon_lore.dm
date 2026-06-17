/datum/heretic_knowledge_tree_column/moon
	route = PATH_MOON
	ui_bgr = "node_moon"
	complexity = "Hard"
	complexity_color = COLOR_RED
	icon = list(
		"icon" = 'icons/obj/weapons/khopesh.dmi',
		"state" = "moon_blade",
		"frame" = 1,
		"dir" = SOUTH,
		"moving" = FALSE,
	)
	description = list(
		"The Path of Moon revolves around sanity, sowing confusion and discord, and skirting the conventional rules of combat.",
		"Play this path if you are already experienced with Heretic and want to try something highly unconventional, or simply if you desire to play a pacifist Heretic (Yes, really!)."
	)
	pros = list(
		"High amount of tools to confound foes.",
		"Sows chaos through the station via lunatics.",
		"Practically immune to disabling effects while wearing the Resplendent Regalia."
	)
	cons = list(
		"No mobility.",
		"No direct tools to damage your opponents.",
		"Reliant on misdirection and confusion.",
		"Lunatics can become liabilities.",
		"Fairly fragile despite their unique protection mechanics.",
		"Death while wearing the Resplendent Regalia results in a gorey end.",
	)
	tips = list(
		"Your Mansus Grasp will make your victim briefly hallucinate and apply a mark that, when triggered by your moon blade, will apply confusion and pacify them (the latter will get removed if the victim receives too much damage at once).",
		"Your moon blade is special compared to the other heretic blades. It can be used even if you are pacified.",
		"Your passive makes you completely impervious to brain traumas and slowly regenerates your brain health. Makes sure to upgrade it to bolster the regeneration effect.",
		"Your Resplendent Regalia utterly changes the rules of combat for you and your opponents; You become fully immune to disabling effect, and all damage received (lethal or non lethal) will be converted into brain damage. However. the robes themselves have no armor, and prevent you from using guns as well as pacifying you (you can still use your moon blade).",
		"Your moon amulette allows you to channel its effects through your moon blade. When toggled on, your Moon blade will no longer do lethal damage, but do sanity damage and become unblockable, this also allows you to use it while wearing your robes!",
		"Your moon amulette is a vital part of your kit, as it allows your passive to regenerate double the brain health while worn.",
		"If the sanity of your opponents goes below  a certain threshold, they'll become a lunatic. Lunatics are prompted to start attacking everyone (including you). Should you want to sacrifice them (or to get them to leave you be), hit them again with your moon blade to put them to sleep.",
		"Ringleader's Rise summons an army of clones. They do barely any damage, but should they be attacked by non-heretics, they will explode and cause sanity and brain damage to those around them.",
		"Your ascension will grant you an aura that converts nearby people to loyal lunatics. However, if they have a mindshield implant, their heads will instead detonate after a time.",
	)

	start = /datum/heretic_knowledge/limited_amount/starting/base_moon
	knowledge_tier1 = /datum/heretic_knowledge/spell/mind_gate
	guaranteed_side_tier1 = /datum/heretic_knowledge/phylactery
	knowledge_tier2 = /datum/heretic_knowledge/moon_amulet
	guaranteed_side_tier2 = /datum/heretic_knowledge/codex_morbus
	robes = /datum/heretic_knowledge/armor/moon
	knowledge_tier3 = /datum/heretic_knowledge/spell/moon_parade
	guaranteed_side_tier3 = /datum/heretic_knowledge/unfathomable_curio
	blade = /datum/heretic_knowledge/blade_upgrade/moon
	knowledge_tier4 = /datum/heretic_knowledge/spell/moon_ringleader
	ascension = /datum/heretic_knowledge/ultimate/moon_final

/datum/heretic_knowledge/limited_amount/starting/base_moon
	name = "Moonlight Troupe"
	desc = "Abre o Caminho da Lua para você.\
Permite que transmute 2 folhas de vidro e uma faca em uma lâmina lunar.\
Você só pode criar dois de cada vez."
	gain_text = "Sob a luz da lua o riso ecoa."
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/stack/sheet/glass = 2,
	)
	result_atoms = list(/obj/item/melee/sickly_blade/moon)
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "moon_blade"
	mark_type = /datum/status_effect/eldritch/moon
	eldritch_passive = /datum/status_effect/heretic_passive/moon

/datum/heretic_knowledge/limited_amount/starting/base_moon/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	user.AddComponentFrom(REF(src), /datum/component/empathy, seen_it = TRUE, visible_info = ALL, self_empath = FALSE, sense_dead = FALSE, sense_whisper = TRUE, smite_target = FALSE)

/datum/heretic_knowledge/limited_amount/starting/base_moon/on_mansus_grasp(mob/living/source, mob/living/target)
	. = ..()

	if(target.can_block_magic(MAGIC_RESISTANCE_MOON))
		to_chat(target, span_danger("Você ouve risos ecoando de cima mas é chato e distante."))
		return

	source.apply_status_effect(/datum/status_effect/moon_grasp_hide)

	if(!iscarbon(target))
		return
	var/mob/living/carbon/carbon_target = target
	to_chat(carbon_target, span_danger("Você ouve risos ecoando de cima"))
	carbon_target.cause_hallucination(/datum/hallucination/delusion/preset/moon, "delusion/preset/moon hallucination caused by mansus grasp")
	carbon_target.mob_mood.adjust_sanity(-30)

/datum/heretic_knowledge/spell/mind_gate
	name = "Mind Gate"
	desc = "Concede-lhe Mental Gate, um feitiço que silencia, ensurdece, cega, inflige alucinações,\
Confusão, perda de oxigênio e dano cerebral em seu alvo em 10 segundos.\
O caster leva 20 danos cerebrais por uso."
	gain_text = "Minha mente se abre como um portão, e sua visão me deixará perceber a verdade."

	action_to_add = /datum/action/cooldown/spell/pointed/mind_gate
	cost = 2

/datum/heretic_knowledge/moon_amulet
	name = "Moonlight Amulet"
	desc = "Permite que transmute 2 folhas de vidro, um coração e uma gravata para criar um amuleto Moonlight.\
Se o item é usado em alguém com baixa sanidade, eles ficam furiosos atacando todos,\
Se sua sanidade não é baixa o suficiente, diminui seu humor.\
Usar isso lhe dará a habilidade de ver pagãos através de paredes e tornar suas lâminas inofensivas, eles atacarão diretamente sua mente.\
Proporciona visão térmica e dobra o cérebro de um herege lunar quando usado."
	gain_text = "À frente do desfile ele estava, a lua condensada em uma massa, um reflexo da alma."

	required_atoms = list(
		/obj/item/organ/heart = 1,
		/obj/item/stack/sheet/glass = 2,
		/obj/item/clothing/neck/tie = 1,
	)
	result_atoms = list(/obj/item/clothing/neck/heretic_focus/moon_amulet)
	cost = 2

	research_tree_icon_path = 'icons/obj/antags/eldritch.dmi'
	research_tree_icon_state = "moon_amulette"
	research_tree_icon_frame = 9

/datum/heretic_knowledge/armor/moon
	desc = "Permite que transmute uma mesa (ou um terno), uma máscara e duas folhas de vidro para criar uma Regalia Resplendant.\
Este roupão tornará o usuário totalmente imune aos efeitos incapacitantes e converterá todas as formas de danos em danos cerebrais, enquanto pacificando o usuário e tornando-os incapazes de usar armas variadas.\
Um amuleto Moonlight será necessário para usar lâminas enquanto o usa."
	gain_text = "Trilhas de luz e alegria fluiram de cada braço deste traje magnífico.\
A trupe girava em cascatas irresponsáveis, deslumbrantes espectadores com a verdade que buscavam.\
Eu observei, aproveitando-me da luz, para me encontrar."
	result_atoms = list(/obj/item/clothing/suit/hooded/cultrobes/eldritch/moon)
	research_tree_icon_state = "moon_armor"
	required_atoms = list(
		list(/obj/structure/table, /obj/item/clothing/suit) = 1,
		/obj/item/clothing/mask = 1,
		/obj/item/stack/sheet/glass = 2,
	)

/datum/heretic_knowledge/spell/moon_parade
	name = "Lunar Parade"
	desc = "Concede-lhe Desfile Lunar, um feitiço que - após uma carga curta - envia um carnaval para a frente\
Quando batem em alguém, são forçados a entrar no desfile e sofrer alucinações."
	gain_text = "A música como um reflexo da alma os compeliu, como mariposas a uma chama que seguiam."
	action_to_add = /datum/action/cooldown/spell/pointed/projectile/moon_parade
	cost = 2
	drafting_tier = 5

/datum/heretic_knowledge/blade_upgrade/moon
	name = "Moonlight Blade"
	desc = "Sua lâmina agora causa danos cerebrais, causa alucinações aleatórias e causa danos à sanidade.\
Dá mais dano cerebral se a vítima está louca ou inconsciente."
	gain_text = "Sua inteligência era afiada como uma lâmina, cortando a mentira para nos trazer alegria."

	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "blade_upgrade_moon"

/datum/heretic_knowledge/blade_upgrade/moon/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	if(source == target || !isliving(target))
		return

	if(target.can_block_magic(MAGIC_RESISTANCE_MOON))
		return

	target.cause_hallucination( \
			get_random_valid_hallucination_subtype(/datum/hallucination/body), \
			"upgraded path of moon blades", \
		)
	target.emote(pick("giggle", "laugh"))
	target.mob_mood?.adjust_sanity(-10)
	if(target.stat == CONSCIOUS && target.mob_mood?.sanity >= SANITY_NEUTRAL)
		target.adjust_organ_loss(ORGAN_SLOT_BRAIN, 10)
		return
	target.adjust_organ_loss(ORGAN_SLOT_BRAIN, 25)

/datum/heretic_knowledge/spell/moon_ringleader
	name = "Ringleaders Rise"
	desc = "Concede a vocês Ringleaders Rise, um feitiço AoE que causa mais danos cerebrais quanto menor a sanidade de todos na AoE\
e causa alucinações, com aqueles que têm menos sanidade ficando mais.\
Se a sanidade deles é baixa o suficiente isso os torna loucos, o feitiço então diminui sua sanidade."
	gain_text = "Agarrei a mão dele e nos levantamos. Aqueles que viram a verdade se levantaram conosco.\
O líder apontou e a luz fraca da verdade nos iluminou ainda mais."

	action_to_add = /datum/action/cooldown/spell/aoe/moon_ringleader
	cost = 2

	research_tree_icon_frame = 5
	is_final_knowledge = TRUE

/datum/heretic_knowledge/ultimate/moon_final
	name = "The Last Act"
	desc = "O ritual de ascensão do Caminho da Lua.\
Traga 3 corpos com mais de 50 danos cerebrais para uma runa de transmutação para completar o ritual.\
Quando concluído, você se torna um prenúncio de loucura ganhando e aura de diminuição passiva da sanidade,\
Membros com pouca sanidade serão convertidos em acólitos.\
1/5 da tripulação vai se transformar em acólitos e seguir seu comando, todos eles receberão amuletos da lua."
	gain_text = "Nós mergulhamos para baixo em direção à multidão, sua alma se separa em busca de maior aventura\
Para onde o líder do ringue começou o desfile, eu vou continuar até o fim dos sóis.\
Testemunhe minha ascensão, a lua sorri cada vez mais."

	ascension_achievement = /datum/award/achievement/misc/moon_ascension
	announcement_text = "Rir, para o líder Name subiu!\
A verdade deve finalmente devorar a mentira! SPOOKY"
	announcement_sound = 'sound/music/antag/heretic/ascend_moon.ogg'

/datum/heretic_knowledge/ultimate/moon_final/is_valid_sacrifice(mob/living/sacrifice)

	var/brain_damage = sacrifice.get_organ_loss(ORGAN_SLOT_BRAIN)
	// Checks if our target has enough brain damage
	if(brain_damage < 50)
		return FALSE

	return ..()

/datum/heretic_knowledge/ultimate/moon_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	ADD_TRAIT(user, TRAIT_MADNESS_IMMUNE, type)
	user.mind.add_antag_datum(/datum/antagonist/lunatic/master)
	RegisterSignal(user, COMSIG_LIVING_LIFE, PROC_REF(on_life))

	var/amount_of_lunatics = 0
	var/list/lunatic_candidates = list()
	for(var/mob/living/carbon/human/crewmate as anything in shuffle(GLOB.human_list))
		if(QDELETED(crewmate) || isnull(crewmate.client) || isnull(crewmate.mind) || crewmate.stat != CONSCIOUS || crewmate.can_block_magic(MAGIC_RESISTANCE_MIND))
			continue
		var/turf/crewmate_turf = get_turf(crewmate)
		var/crewmate_z = crewmate_turf?.z
		if(!is_station_level(crewmate_z))
			continue
		lunatic_candidates += crewmate

	// Roughly 1/5th of the station will rise up as lunatics to the heretic.
	// We use either the (locked) manifest for the maximum, or the amount of candidates, whichever is larger.
	// If there's more eligible humans than crew, more power to them I guess.
	var/max_lunatics = ceil(max(length(GLOB.manifest.locked), length(lunatic_candidates)) * 0.2)

	for(var/mob/living/carbon/human/crewmate as anything in lunatic_candidates)
		if(amount_of_lunatics > max_lunatics)
			to_chat(crewmate, span_boldwarning("Você se sente desconfortável, como se por um breve momento algo estivesse olhando para você."))
			continue
		if(attempt_conversion(crewmate, user))
			amount_of_lunatics++

/datum/heretic_knowledge/ultimate/moon_final/proc/attempt_conversion(mob/living/carbon/convertee, mob/user)
	// Heretics, lunatics and monsters shouldn't become lunatics because they either have a master or have a mansus grasp
	if(IS_HERETIC_OR_MONSTER(convertee))
		to_chat(convertee, span_boldwarning("[user]'s rise is influencing those who are weak willed. Their minds shall rend." ))
		return FALSE
	// Mindshielded and anti-magic folks are immune against this effect because this is a magical mind effect
	if(HAS_MIND_TRAIT(convertee, TRAIT_UNCONVERTABLE) || convertee.can_block_magic(MAGIC_RESISTANCE))
		to_chat(convertee, span_boldwarning("Você se sente protegido de algo." ))
		return FALSE

	if(!convertee.mind)
		return FALSE

	var/datum/antagonist/lunatic/lunatic = convertee.mind.add_antag_datum(/datum/antagonist/lunatic)
	lunatic.set_master(user.mind, user)
	var/obj/item/clothing/neck/heretic_focus/moon_amulet/amulet = new(convertee.drop_location())
	var/static/list/slots = list(
		LOCATION_NECK,
		LOCATION_HANDS,
		LOCATION_RPOCKET,
		LOCATION_LPOCKET,
		LOCATION_BACKPACK,
	)
	convertee.equip_in_one_of_slots(amulet, slots, qdel_on_fail = FALSE)
	INVOKE_ASYNC(convertee, TYPE_PROC_REF(/mob, emote), "laugh")
	return TRUE

/datum/heretic_knowledge/ultimate/moon_final/proc/on_life(mob/living/source, seconds_per_tick)
	SIGNAL_HANDLER
	visible_hallucination_pulse(
		center = get_turf(source),
		radius = 7,
		hallucination_duration = 60 SECONDS
	)

	for(var/mob/living/carbon/carbon_view in range(7, source))
		var/carbon_sanity = carbon_view.mob_mood.sanity
		if(carbon_view.stat != CONSCIOUS)
			continue
		if(IS_HERETIC_OR_MONSTER(carbon_view))
			continue
		if(carbon_view.can_block_magic(MAGIC_RESISTANCE_MOON)) //Somehow a shitty piece of tinfoil is STILL able to hold out against the power of an ascended heretic.
			continue
		new /obj/effect/temp_visual/moon_ringleader(get_turf(carbon_view))
		if(carbon_view.has_status_effect(/datum/status_effect/confusion))
			to_chat(carbon_view, span_big(span_hypnophrase("Sua cabeça ratreia com milhares de vozes unidas em uma cacofonia de som e música. Cada arquivo seu diz 'correr'.")))
		carbon_view.adjust_confusion(2 SECONDS)
		carbon_view.mob_mood.adjust_sanity(-20)

		if(carbon_sanity >= 10)
			continue
		// So our sanity is dead, time to fuck em up
		if(SPT_PROB(20, seconds_per_tick))
			to_chat(carbon_view, span_warning("ecoa através de você!"))
		visible_hallucination_pulse(
			center = get_turf(carbon_view),
			radius = 7,
			hallucination_duration = 50 SECONDS
		)
		carbon_view.adjust_temp_blindness(5 SECONDS)
		if(should_mind_explode(carbon_view))
			to_chat(carbon_view, span_boldbig(span_red(\
				"Seu senso de Reel como sua mente está envolvida por outra força tentando reescrever seu próprio ser.\
Você não pode nem começar a gritar antes que seu implante ative seu protótipo de segurança psicológica, levando sua cabeça com ele.")))
			var/obj/item/bodypart/head/head = carbon_view.get_bodypart(BODY_ZONE_HEAD)
			if(!head?.dismember())
				carbon_view.gib(DROP_ALL_REMAINS)
			var/datum/effect_system/reagents_explosion/explosion = new(get_turf(carbon_view), 1, 1, 1)
			explosion.start(src)
		else
			attempt_conversion(carbon_view, source)


/datum/heretic_knowledge/ultimate/moon_final/proc/should_mind_explode(mob/living/carbon/target)
	if(HAS_TRAIT(target, TRAIT_MINDSHIELD))
		return TRUE
	if(IS_CULTIST_OR_CULTIST_MOB(target))
		return TRUE
	return FALSE
