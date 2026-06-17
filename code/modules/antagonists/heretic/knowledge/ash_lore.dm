/datum/heretic_knowledge_tree_column/ash
	route = PATH_ASH
	ui_bgr = "node_ash"
	complexity = "Easy"
	complexity_color = COLOR_GREEN
	icon = list(
		"icon" = 'icons/obj/weapons/khopesh.dmi',
		"state" = "ash_blade",
		"frame" = 1,
		"dir" = SOUTH,
		"moving" = FALSE,
	)
	description = list(
		"The Path of Ash revolves around fire, mobility and brutal crowd control against single opponents.",
		"Play this path if you are new to Heretic, or really enjoy hit and run playstyles.",
	)
	pros = list(
		"Very potent even from the beginning of the path.",
		"Easy access to a mobility spells and expanded vision.",
		"Very powerful mark effect.",
	)
	cons = list(
		"Has less power than most heretics beyond their starting abilities.",
		"Lacks durability in long conflicts.",
		"Reliant on hitting fast and hard before their opponents can mount proper countermeasures.",
	)
	tips = list(
		"Your Mansus Grasp applies a short blind and a mark that puts your opponent into stamina crit when triggered by your blade. The mark can spread to nearby opponents.",
		"Selecting this path makes you immune to high temperature damage. Remember, however, that your clothes can still burn! If you want to protect yourself from your own fire, wear a Scorched Mantle.",
		"Your Scorched Mantle will cause you to generate firestacks on your own body (Make sure you toggle the effect!). Upon reaching 5 fire stacks, your ashen spells will be  empowered (indicated by your spells being highlighted in green).",
		"Your Ashen passage is a short cooldown jaunt capable of removing restraints. If empowered, it gains a longer jaunt time, and also will remove stuns and stamina crit.",
		"Volcano blast can make short work of your enemies, should they be foolish enough to stick close to each other. If empowered, it will have no cast time and generate twice the amount of firestacks. Burn the heathens to ashes!",
		"Do not neglect the Mask of Madness. It will slowly sap the stamina of your enemies and make them hallucinate.",
		"Make sure to set as many enemies on fire as you possibly can! Nightwatcher's Rebirth will heal you and have its cooldown reduced based on how many mobs you siphon.",
		"Your ascension grants you complete immunity to environmental hazards, including bombs! But you are still vulnerable to more conventional weaponry. Do not become overconfident.",
	)

	start = /datum/heretic_knowledge/limited_amount/starting/base_ash
	knowledge_tier1 = /datum/heretic_knowledge/spell/ash_passage
	guaranteed_side_tier1 = /datum/heretic_knowledge/medallion
	knowledge_tier2 = /datum/heretic_knowledge/spell/fire_blast
	guaranteed_side_tier2 = /datum/heretic_knowledge/rifle
	robes = /datum/heretic_knowledge/armor/ash
	knowledge_tier3 = /datum/heretic_knowledge/mad_mask
	guaranteed_side_tier3 = /datum/heretic_knowledge/summon/ashy
	blade = /datum/heretic_knowledge/blade_upgrade/ash
	knowledge_tier4 = /datum/heretic_knowledge/spell/flame_birth
	ascension = /datum/heretic_knowledge/ultimate/ash_final

/datum/heretic_knowledge/limited_amount/starting/base_ash
	name = "Nightwatcher's Secret"
	desc = "Abre o Caminho de Ash para você.\
Permite que transmute um fósforo e uma faca em uma lâmina de Ashen.\
Você só pode criar cinco de cada vez." //SKYRAT EDIT two to five
	gain_text = "A Guarda da Cidade conhece seu relógio. Se você perguntar à noite, eles podem falar sobre a lanterna cinza."
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/match = 1,
	)
	result_atoms = list(/obj/item/melee/sickly_blade/ash)
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "ash_blade"
	mark_type = /datum/status_effect/eldritch/ash
	eldritch_passive = /datum/status_effect/heretic_passive/ash

/datum/heretic_knowledge/limited_amount/starting/base_ash/on_mansus_grasp(mob/living/source, mob/living/target)
	. = ..()

	if(target.is_blind())
		return

	if(!target.get_organ_slot(ORGAN_SLOT_EYES))
		return

	to_chat(target, span_danger("Uma luz verde brilhante queima seus olhos horrivelmente!"))
	target.adjust_organ_loss(ORGAN_SLOT_EYES, 15)
	target.set_eye_blur_if_lower(20 SECONDS)

/datum/heretic_knowledge/limited_amount/starting/base_ash/trigger_mark(mob/living/source, mob/living/target)
	. = ..()
	if(!.)
		return

	// Also refunds 75% of charge!
	var/datum/action/cooldown/spell/touch/mansus_grasp/grasp = locate() in source.actions
	if(grasp)
		grasp.next_use_time -= round(grasp.cooldown_time*0.75)
		grasp.build_all_button_icons()

/datum/heretic_knowledge/spell/ash_passage
	name = "Ashen Passage"
	desc = "Concede-lhe Ashen Passage, um feitiço que te deixa sair da realidade, permitindo que você atravesse uma curta distância, passando por qualquer parede.\
Quando for poderoso, ele vai tirá-lo de qualquer atordoamento e restrições, e terá um alcance mais longo."
	gain_text = "Ele sabia andar entre os aviões."

	action_to_add = /datum/action/cooldown/spell/jaunt/ethereal_jaunt/ash
	cost = 2
	// drafting_tier = 5 BUBBER REMOVAL

/datum/heretic_knowledge/spell/fire_blast
	name = "Volcano Blast"
	desc = "Concede-lhe Explosão de Vulcão, um feitiço que - após uma carga curta - dispara um feixe de energia\
em um inimigo próximo, colocando fogo neles e queimando-os. Se eles não se extinguirem,\
O feixe continuará para outro alvo.\
Quando for poderoso, tem tempo de lançamento instantâneo e explode inimigos com mais chamas."
	gain_text = "Nenhum fogo era quente o suficiente para reacendê-los. Nenhum fogo era brilhante o suficiente para salvá-los. Nenhum fogo é eterno."
	action_to_add = /datum/action/cooldown/spell/charged/beam/fire_blast
	cost = 2
	research_tree_icon_frame = 7

/datum/heretic_knowledge/armor/ash
	desc = "Permite que transmute uma mesa (ou um terno), uma máscara e um fósforo para criar um manto queimado.\
Ele fornece proteção completa contra o fogo, e é capaz de produzir mais chamas passivamente.\
Quando tiver fogo suficiente, pode lançar versões poderosas de seus feitiços de cinzas.\
Atua como foco enquanto encapuza."
	gain_text = "A Sentinela permanece enquanto eles caem, desmoronando longe da vista.\
No entanto, os ventos soprando através da cidade chamá-los de volta ao serviço, poeira chutado para o ar, uma silhueta à deriva dos caídos."
	result_atoms = list(/obj/item/clothing/suit/hooded/cultrobes/eldritch/ash)
	research_tree_icon_state = "ash_armor"
	required_atoms = list(
		list(/obj/structure/table, /obj/item/clothing/suit) = 1,
		/obj/item/clothing/mask = 1,
		/obj/item/match = 1,
	)

/datum/heretic_knowledge/mad_mask
	name = "Mask of Madness"
	desc = "Permite transmutar qualquer máscara, quatro velas, um bastão de choque, e um fígado para criar uma Máscara de Loucura.\
A máscara infunde medo em pagãos que testemunham, causando danos à resistência, alucinações e insanidade.\
Também pode ser forçado a um pagão, para fazê-los incapazes de tirá-lo..."
	gain_text = "O Observador da Noite estava perdido. Isso é o que o Relógio acreditava. Ainda assim, ele andou pelo mundo, despercebido pelas massas."
	required_atoms = list(
		/obj/item/organ/liver = 1,
		/obj/item/melee/baton/security = 1,  // Technically means a cattleprod is valid
		/obj/item/clothing/mask = 1,
		/obj/item/flashlight/flare/candle = 4,
	)
	result_atoms = list(/obj/item/clothing/mask/madness_mask)
	cost = 2
	research_tree_icon_path = 'icons/obj/clothing/masks.dmi'
	research_tree_icon_state = "mad_mask"

/datum/heretic_knowledge/blade_upgrade/ash
	name = "Fiery Blade"
	desc = "Sua lâmina agora ilumina inimigos em chamas no ataque."
	gain_text = "Ele voltou, lâmina na mão, ele balançou e balançou enquanto as cinzas caíam dos céus.\
A cidade dele, as pessoas que ele jurou vigiar... e ver como ele fazia, como todos eles queimados em cinzas."


	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "blade_upgrade_ash"

/datum/heretic_knowledge/blade_upgrade/ash/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	if(source == target || !isliving(target))
		return

	target.adjust_fire_stacks(1)
	target.ignite_mob()

/datum/heretic_knowledge/spell/flame_birth
	name = "Nightwatcher's Rebirth"
	desc = "Te concede o Renascimento do Observador Noturno, um feitiço que te extingui e\
Queima todos os pagãos próximos que estão em chamas, curando você para cada vítima afligida.\
Se as vítimas estão em estado crítico, elas também morrerão instantaneamente."
	gain_text = "O fogo era inevitável, e ainda assim, a vida permaneceu em seu corpo carbonizado.\
O Observador da Noite era um homem em particular, sempre observando."
	action_to_add = /datum/action/cooldown/spell/aoe/fiery_rebirth
	cost = 2
	research_tree_icon_frame = 5
	is_final_knowledge = TRUE

/datum/heretic_knowledge/ultimate/ash_final
	name = "Ashlord's Rite"
	desc = "O ritual de ascensão do Caminho de Ash.\
Traga 3 corpos queimados ou descascados para uma runa de transmutação para completar o ritual.\
Quando concluído, você se torna um prenúncio de chamas, ganhando dois abilites.\
Cascata, que causa um enorme e crescente anel de fogo ao seu redor,\
e Juramento de Chama, fazendo você criar passivamente um anel de chamas enquanto caminha.\
Alguns feitiços de Ashen que você já sabia também serão poderosos.\
Você também se tornará imune a chamas, espaço e riscos ambientais similares."
	gain_text = "O Relógio está morto, o Observador da Noite queimou com ele. No entanto, seu fogo queima cada vez mais,\
Para o Observador da Noite trouxe o rito à humanidade! Seu olhar continua, como agora estou com as chamas,\
TESTEMUNHA MINHA ASCENSÃO, OS BLAZES LANTERNAIS MAIS UMA VEZ!"

	ascension_achievement = /datum/award/achievement/misc/ash_ascension
	announcement_text = "Tema o fogo, para o Ashlord, que subiu! As chamas consumirão tudo! SPOOKY"
	announcement_sound = 'sound/music/antag/heretic/ascend_ash.ogg'
	/// A static list of all traits we apply on ascension.
	var/static/list/traits_to_apply = list(
		TRAIT_BOMBIMMUNE,
		TRAIT_NOBREATH,
		TRAIT_NOFIRE,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHEAT,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
	)

/datum/heretic_knowledge/ultimate/ash_final/is_valid_sacrifice(mob/living/carbon/human/sacrifice)
	. = ..()
	if(!.)
		return

	if(sacrifice.on_fire)
		return TRUE
	if(HAS_TRAIT_FROM(sacrifice, TRAIT_HUSK, BURN))
		return TRUE
	return FALSE

/datum/heretic_knowledge/ultimate/ash_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	var/datum/action/cooldown/spell/fire_sworn/circle_spell = new(user.mind)
	circle_spell.Grant(user)

	var/datum/action/cooldown/spell/fire_cascade/big/screen_wide_fire_spell = new(user.mind)
	screen_wide_fire_spell.Grant(user)

	var/datum/action/cooldown/spell/charged/beam/fire_blast/existing_beam_spell = locate() in user.actions
	if(existing_beam_spell)
		existing_beam_spell.max_beam_bounces *= 2 // Double beams
		existing_beam_spell.beam_duration *= 0.66 // Faster beams
		existing_beam_spell.cooldown_time *= 0.66 // Lower cooldown

	var/datum/action/cooldown/spell/aoe/fiery_rebirth/fiery_rebirth = locate() in user.actions
	fiery_rebirth?.cooldown_time *= 0.16

	user.add_traits(traits_to_apply, type)
