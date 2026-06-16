/*!
 * Tier 3 knowledge: Summons
 */

/datum/heretic_knowledge/summon/rusty
	name = "Rusted Ritual"
	desc = "Permite que transmute uma piscina de vômito, bobina de cabo, e 10 folhas de ferro em um Rust Walker. A Rust Walkers é excelente em espalhar ferrugem e é moderadamente forte em combate."
	gain_text = "Combinei meu conhecimento da criação com meu desejo de corrupção. O delegado sabia meu nome, e as Colinas Rusted ecoaram."
	required_atoms = list(
		/obj/effect/decal/cleanable/vomit = 1,
		/obj/item/stack/sheet/iron = 10,
		/obj/item/stack/cable_coil = 15,
	)
	mob_to_summon = /mob/living/basic/heretic_summon/rust_walker
	cost = 2
	poll_ignore_define = POLL_IGNORE_RUST_SPIRIT
	drafting_tier = 3

/datum/heretic_knowledge/summon/maid_in_mirror
	name = "Maid in the Mirror"
	desc = "Permite que transmute cinco folhas de vidro, qualquer terno, e um par de pulmões para criar uma empregada no espelho. Maid in the Mirrors são combatentes decentes que podem se tornar incorpóreos, entrando e saindo do reino do espelho, servindo como poderosos batedores e emboscadas. Seus ataques também aplicam uma pilha de frio vazio."
	gain_text = "Dentro de cada reflexão, encontra-se um portal para um mundo inimaginável de cores nunca vistas e as pessoas nunca se encontraram. A subida é de vidro, e as paredes são facas. Cada passo é sangue, se você não tiver um guia."

	required_atoms = list(
		/obj/item/stack/sheet/glass = 5,
		/obj/item/clothing/suit = 1,
		/obj/item/organ/lungs = 1,
	)
	cost = 2

	mob_to_summon = /mob/living/basic/heretic_summon/maid_in_the_mirror
	poll_ignore_define = POLL_IGNORE_MAID_IN_MIRROR
	drafting_tier = 3

/datum/heretic_knowledge/summon/ashy
	name = "Ashen Ritual"
	desc = "Permite que transmute uma fogueira e um livro para criar um Espírito Ash. Espíritos Cinzas têm uma curta distância e a capacidade de causar sangramento em inimigos ao alcance. Eles também têm a capacidade de criar um anel de fogo em torno de si mesmos por um período de tempo. Eles têm pouca saúde, mas vão se recuperar passivamente, dado tempo suficiente para isso."
	gain_text = "Combinei meu princípio de fome com meu desejo de destruição. O delegado sabia meu nome, e o Observador da Noite olhou."
	required_atoms = list(
		/obj/effect/decal/cleanable/ash = 1,
		/obj/item/book = 1,
		/obj/structure/bonfire = 1,
		)
	mob_to_summon = /mob/living/basic/heretic_summon/ash_spirit
	cost = 2

	poll_ignore_define = POLL_IGNORE_ASH_SPIRIT
	drafting_tier = 3

/// The max health given to Shattered Risen
#define RISEN_MAX_HEALTH 125

/datum/heretic_knowledge/limited_amount/risen_corpse
	name = "Shattered Ritual"
	desc = "Permite que transmute um cadáver com uma alma, um par de luvas de látex ou nitrilo, e qualquer roupa de exosuit (como armadura) para criar um Shattered Risen. Shattered Risen são fortes ghouls que têm 125 saúde, mas não pode segurar itens, em vez de ter duas armas brutais para as mãos. Você só pode criar um de cada vez."
	gain_text = "Eu testemunhei uma força fria arrastando este cadáver de volta para a vida próxima. Quando se move, ele trinca como vidro quebrado. Suas mãos não são mais reconhecíveis como humanos - cada punho fechado contém um ninho brutal de pedaços de ossos afiados."

	required_atoms = list(
		/obj/item/clothing/suit = 1,
		/obj/item/clothing/gloves/latex = 1,
	)
	limit = 1
	cost = 2
	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "ghoul_shattered"
	drafting_tier = 3

/datum/heretic_knowledge/limited_amount/risen_corpse/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/body in atoms)
		if(body.stat != DEAD)
			continue
		if(!IS_VALID_GHOUL_MOB(body) || HAS_TRAIT(body, TRAIT_HUSK))
			to_chat(user, span_hierophant_warning("[body] Não está em um estado válido para ser transformado em um fantasma."))
			continue
		if(!body.mind)
			to_chat(user, span_hierophant_warning("[body] é descuidado e não pode ser transformado em um fantasma."))
			continue
		if(!body.client && !body.mind.get_ghost(ghosts_with_clients = TRUE))
			to_chat(user, span_hierophant_warning("[body] é sem alma e não pode ser transformado em um fantasma."))
			continue

		// We will only accept valid bodies with a mind, or with a ghost connected that used to control the body
		selected_atoms += body
		return TRUE

	loc.balloon_alert(user, "ritual falhou, sem corpo válido!")
	return FALSE

/datum/heretic_knowledge/limited_amount/risen_corpse/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/mob/living/carbon/human/soon_to_be_ghoul = locate() in selected_atoms
	if(QDELETED(soon_to_be_ghoul)) // No body? No ritual
		stack_trace("[type] reached on_finished_recipe without a human in selected_atoms to make a ghoul out of.")
		loc.balloon_alert(user, "ritual falhou, sem corpo válido!")
		return FALSE

	soon_to_be_ghoul.grab_ghost()
	if(!soon_to_be_ghoul.mind || !soon_to_be_ghoul.client)
		stack_trace("[type] reached on_finished_recipe without a minded / cliented human in selected_atoms to make a ghoul out of.")
		loc.balloon_alert(user, "ritual falhou, sem corpo válido!")
		return FALSE

	selected_atoms -= soon_to_be_ghoul
	make_risen(user, soon_to_be_ghoul)
	return TRUE

/// Make [victim] into a shattered risen ghoul.
/datum/heretic_knowledge/limited_amount/risen_corpse/proc/make_risen(mob/living/user, mob/living/carbon/human/victim)
	user.log_message("created a shattered risen out of [key_name(victim)].", LOG_GAME)
	victim.log_message("became a shattered risen of [key_name(user)]'s.", LOG_VICTIM, log_globally = FALSE)
	message_admins("[ADMIN_LOOKUPFLW(user)] created a shattered risen, [ADMIN_LOOKUPFLW(victim)].")

	victim.apply_status_effect(
		/datum/status_effect/ghoul,
		RISEN_MAX_HEALTH,
		user.mind,
		CALLBACK(src, PROC_REF(apply_to_risen)),
		CALLBACK(src, PROC_REF(remove_from_risen)),
	)

/// Callback for the ghoul status effect - what effects are applied to the ghoul.
/datum/heretic_knowledge/limited_amount/risen_corpse/proc/apply_to_risen(mob/living/risen)
	LAZYADD(created_items, WEAKREF(risen))
	risen.AddComponent(/datum/component/mutant_hands, mutant_hand_path = /obj/item/mutant_hand/shattered_risen)

/// Callback for the ghoul status effect - cleaning up effects after the ghoul status is removed.
/datum/heretic_knowledge/limited_amount/risen_corpse/proc/remove_from_risen(mob/living/risen)
	LAZYREMOVE(created_items, WEAKREF(risen))
	qdel(risen.GetComponent(/datum/component/mutant_hands))

#undef RISEN_MAX_HEALTH

/// The "hand" "weapon" used by shattered risen
/obj/item/mutant_hand/shattered_risen
	name = "bone-shards"
	desc = "O que parecia ser um punho humano normal, agora segura um ninho de ossos afiados."
	color = "#001aff"
	hitsound = SFX_SHATTER
	force = 16
	wound_bonus = -30
	exposed_wound_bonus = 15
	demolition_mod = 1.5
	sharpness = SHARP_EDGED

/datum/heretic_knowledge/summon/fire_shark
	name = "Scorching Shark"
	desc = "Permite que transmute uma poça de cinzas, um fígado e uma folha de plasma em um tubarão de fogo. Tubarões de Fogo são rápidos e fortes em grupos, mas morrem rapidamente. Eles também são altamente resistentes contra ataques de fogo. Tubarões de Fogo injetam flogistom em suas vítimas e geram plasma quando morrem."
	gain_text = "O berço da nebulosa estava frio, mas não morto. A luz e o calor voam até através da escuridão mais profunda, e são caçados por seus próprios predadores."

	required_atoms = list(
		/obj/effect/decal/cleanable/ash = 1,
		/obj/item/organ/liver = 1,
		/obj/item/stack/sheet/mineral/plasma = 1,
	)
	mob_to_summon = /mob/living/basic/heretic_summon/fire_shark
	cost = 2

	poll_ignore_define = POLL_IGNORE_FIRE_SHARK

	research_tree_icon_dir = EAST
	drafting_tier = 3
