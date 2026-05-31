/* Backpacks
 * Contains:
 * Backpack
 * Backpack Types
 * Satchel Types
 */

/*
 * Backpack
 */

/obj/item/storage/backpack
	name = "backpack"
	desc = "Você usa isso nas costas e coloca itens nele."
	icon = 'icons/obj/storage/backpack.dmi'
	worn_icon = 'icons/mob/clothing/back/backpack.dmi'
	icon_state = "backpack"
	inhand_icon_state = "backpack"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK //ERROOOOO
	resistance_flags = NONE
	max_integrity = 300
	storage_type = /datum/storage/backpack
	pickup_sound = 'sound/items/handling/backpack/backpack_pickup1.ogg'
	drop_sound = 'sound/items/handling/backpack/backpack_drop1.ogg'
	equip_sound = 'sound/items/equip/backpack_equip.ogg'
	sound_vary = TRUE

/obj/item/storage/backpack/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/attack_equip)

/*
 * Backpack Types
 */

/obj/item/bag_of_holding_inert
	name = "inert bag of holding"
	desc = "O que atualmente é apenas um bloco de metal com uma fenda pronta para aceitar um núcleo de anomalia do espaço azul."
	icon = 'icons/obj/storage/backpack.dmi'
	worn_icon = 'icons/mob/clothing/back/backpack.dmi'
	icon_state = "bag_of_holding-inert"
	inhand_icon_state = "brokenpack"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FIRE_PROOF
	item_flags = NO_MAT_REDEMPTION

/obj/item/bag_of_holding_inert/Initialize(mapload)
	. = ..()
	var/static/list/recipes = list(/datum/crafting_recipe/boh)
	AddElement(/datum/element/slapcrafting, recipes)

/obj/item/storage/backpack/holding
	name = "bag of holding"
	desc = "Uma mochila que se abre em um bolso localizado de espaço azul."
	icon_state = "bag_of_holding"
	inhand_icon_state = "holdingpack"
	resistance_flags = FIRE_PROOF
	item_flags = NO_MAT_REDEMPTION
	armor_type = /datum/armor/backpack_holding
	storage_type = /datum/storage/bag_of_holding
	pickup_sound = null
	drop_sound = null

/datum/armor/backpack_holding
	fire = 60
	acid = 50

/obj/item/storage/backpack/holding/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]está pulando em[src]! Parece que...[user.p_theyre()]Tentando cometer suicídio."))
	user.dropItemToGround(src, TRUE)
	user.Stun(100, ignore_canstun = TRUE)
	sleep(2 SECONDS)
	playsound(src, SFX_RUSTLE, 50, TRUE, -5)
	user.suicide_log()
	qdel(user)


/obj/item/storage/backpack/santabag
	name = "Santa's Gift Bag"
	desc = "O Papai Noel do Espaço usa isso para entregar presentes para todas as crianças legais no espaço no Natal! Uau, é bem grande!"
	icon_state = "giftbag0"
	inhand_icon_state = "giftbag"
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/backpack/santabag

/obj/item/storage/backpack/santabag/Initialize(mapload)
	. = ..()
	regenerate_presents()

/obj/item/storage/backpack/santabag/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]Lugares[src]Câmbio.[user.p_their()]cabeça e puxa apertado! Parece que...[user.p_they()] [user.p_are()]Não no espírito natalino..."))
	return OXYLOSS

/obj/item/storage/backpack/santabag/proc/regenerate_presents()
	addtimer(CALLBACK(src, PROC_REF(regenerate_presents)), 30 SECONDS)

	var/mob/user = get(loc, /mob)
	if(!istype(user))
		return
	if(HAS_MIND_TRAIT(user, TRAIT_CANNOT_OPEN_PRESENTS))
		var/turf/floor = get_turf(src)
		var/obj/item/thing = new /obj/item/gift/mostly_anything(floor) // BUBBER EDIT - Previous: var/obj/item/thing = new /obj/item/gift/anything(floor)
		if(!atom_storage.attempt_insert(thing, user, override = TRUE, force = STORAGE_SOFT_LOCKED))
			qdel(thing)


/obj/item/storage/backpack/cultpack
	name = "trophy rack"
	desc = "É útil para carregar equipamento extra e orgulhosamente declarar sua loucura."
	icon_state = "backpack-cult"
	inhand_icon_state = "backpack"
	alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER

/obj/item/storage/backpack/clown
	name = "Giggles von Honkerton"
	desc = "É uma mochila feita por Honk! Co."
	icon_state = "backpack-clown"
	inhand_icon_state = "clownpack"

/obj/item/storage/backpack/explorer
	name = "explorer bag"
	desc = "Uma mochila robusta para esconder seu saque."
	icon_state = "backpack-explorer"
	inhand_icon_state = "explorerpack"

/obj/item/storage/backpack/mime
	name = "Parcel Parceaux"
	desc = "Uma mochila silenciosa feita para aqueles trabalhadores silenciosos. Silêncio."
	icon_state = "backpack-mime"
	inhand_icon_state = "mimepack"

/obj/item/storage/backpack/medic
	name = "medical backpack"
	desc = "É uma mochila especialmente projetada para ser usada em um ambiente estéril."
	icon_state = "backpack-medical"
	inhand_icon_state = "medicalpack"

/obj/item/storage/backpack/chief_medic
	name = "chief medical officer's backpack"
	desc = "Uma mochila com bolsos suficientes para carregar o equipamento do médico chefe."
	icon_state = "backpack-chiefmedical"
	inhand_icon_state = "medicalpack"

/obj/item/storage/backpack/coroner
	name = "coroner backpack"
	desc = "É uma mochila especialmente projetada para ser usada em um ambiente morto-vivo."
	icon_state = "backpack-coroner"
	inhand_icon_state = "coronerpack"

/obj/item/storage/backpack/security
	name = "security backpack"
	desc = "É uma mochila muito robusta."
	icon_state = "backpack-security"
	inhand_icon_state = "securitypack"

/obj/item/storage/backpack/captain
	name = "captain's backpack"
	desc = "É uma mochila especial feita exclusivamente para oficiais Nanotrasen."
	icon_state = "backpack-captain"
	inhand_icon_state = "captainpack"

/obj/item/storage/backpack/industrial
	name = "industrial backpack"
	desc = "É uma mochila dura para a vida diária da estação."
	icon_state = "backpack-engineering"
	inhand_icon_state = "engiepack"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/botany
	name = "botany backpack"
	desc = "É uma mochila feita de fibras naturais."
	icon_state = "backpack-hydroponics"
	inhand_icon_state = "botpack"

/obj/item/storage/backpack/chemistry
	name = "chemistry backpack"
	desc = "Uma mochila especialmente projetada para repelir manchas e líquidos perigosos."
	icon_state = "backpack-chemistry"
	inhand_icon_state = "chempack"

/obj/item/storage/backpack/genetics
	name = "genetics backpack"
	desc = "Um saco feito para ser super duro, só para o caso de alguém te atacar."
	icon_state = "backpack-genetics"
	inhand_icon_state = "genepack"

/obj/item/storage/backpack/science
	name = "science backpack"
	desc = "Uma mochila especialmente projetada. É resistente ao fogo e cheira vagamente a plasma."
	icon_state = "backpack-science"
	inhand_icon_state = "scipack"

/obj/item/storage/backpack/virology
	name = "virology backpack"
	desc = "Uma mochila feita de fibras hipoalergênicas. É projetado para ajudar a prevenir a propagação de doenças. Cheira a macaco."
	icon_state = "backpack-virology"
	inhand_icon_state = "viropack"

/obj/item/storage/backpack/floortile
	name = "floortile backpack"
	desc = "É uma mochila especialmente projetada para uso em pisos..."
	icon_state = "floortile_backpack"
	inhand_icon_state = "backpack"

/obj/item/storage/backpack/ert
	name = "emergency response team commander backpack"
	desc = "Uma mochila espaçosa com muitos bolsos, usada pelo Comandante de uma equipe de emergência."
	icon_state = "ert_commander"
	inhand_icon_state = "securitypack"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/ert/security
	name = "emergency response team security backpack"
	desc = "Uma mochila espaçosa com muitos bolsos, usada pelos oficiais de segurança de uma equipe de emergência."
	icon_state = "ert_security"

/obj/item/storage/backpack/ert/medical
	name = "emergency response team medical backpack"
	desc = "Uma mochila espaçosa com muitos bolsos, usada por oficiais médicos de uma equipe de emergência."
	icon_state = "ert_medical"

/obj/item/storage/backpack/ert/engineer
	name = "emergency response team engineer backpack"
	desc = "Uma mochila espaçosa com muitos bolsos, usada pelos engenheiros de uma equipe de emergência."
	icon_state = "ert_engineering"

/obj/item/storage/backpack/ert/janitor
	name = "emergency response team janitor backpack"
	desc = "Uma mochila espaçosa com muitos bolsos, usada por zeladores de uma equipe de emergência."
	icon_state = "ert_janitor"

/obj/item/storage/backpack/ert/clown
	name = "emergency response team clown backpack"
	desc = "Uma mochila espaçosa com muitos bolsos, usada por palhaços de uma equipe de emergência."
	icon_state = "ert_clown"

/obj/item/storage/backpack/saddlepack
	name = "saddlepack"
	desc = "Uma mochila projetada para ser selada em um monte ou carregada em suas costas, e alternar entre os dois na mosca. É bastante espaçoso, ao custo de fazer você se sentir como uma mula literal."
	icon = 'icons/obj/storage/ethereal.dmi'
	worn_icon = 'icons/mob/clothing/back/ethereal.dmi'
	icon_state = "saddlepack"
	storage_type = /datum/storage/backpack/saddle

// MEAT MEAT MEAT MEAT MEAT

/obj/item/storage/backpack/meat
	name = "\improper MEAT"
	desc = "CARNE DE CARNE CARNE CARNE"
	icon_state = "meatmeatmeat"
	inhand_icon_state = "meatmeatmeat"
	force = 15
	throwforce = 15
	material_flags = MATERIAL_EFFECTS | MATERIAL_AFFECT_STATISTICS
	attack_verb_continuous = list("MEATS", "MEAT MEATS")
	attack_verb_simple = list("MEAT", "MEAT MEAT")
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 15) // MEAT
	///Sounds used in the squeak component
	var/list/meat_sounds = list('sound/effects/blob/blobattack.ogg' = 1)
	///Reagents added to the edible component on top of the meat material, ingested when you EAT the MEAT
	var/list/meat_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 15,
	)
	///Eating verbs when consuming the MEAT
	var/list/eatverbs = list("MEAT", "absorb", "gnaw", "consume")

/obj/item/storage/backpack/meat/Initialize(mapload)
	. = ..()
	AddComponentFrom(
		SOURCE_EDIBLE_INNATE, 		/datum/component/edible,		initial_reagents = meat_reagents,		tastes = list("meat" = 1),		eatverbs = eatverbs,	)

	AddComponent(/datum/component/squeak, meat_sounds)

/obj/item/storage/backpack/meat/change_material_strength(datum/material/material, mat_amount, multiplier, remove)
	// Our base 15 force includes the implied meat force
	if (!istype(material, /datum/material/meat))
		return ..()

/*
 * Satchel Types
 */

/obj/item/storage/backpack/satchel
	name = "satchel"
	desc = "Uma bolsa elegante."
	icon_state = "satchel-norm"
	inhand_icon_state = "satchel-norm"

/obj/item/storage/backpack/satchel/leather
	name = "leather satchel"
	desc = "É uma bolsa muito chique feita com couro fino."
	icon_state = "satchel-leather"
	inhand_icon_state = "satchel"

/obj/item/storage/backpack/satchel/leather/withwallet/PopulateContents()
	new /obj/item/storage/wallet/random(src)

/obj/item/storage/backpack/satchel/fireproof
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/satchel/eng
	name = "industrial satchel"
	desc = "Uma bolsa dura com bolsos extras."
	icon_state = "satchel-engineering"
	inhand_icon_state = "satchel-eng"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/satchel/med
	name = "medical satchel"
	desc = "Uma bolsa esterilizada usada nos departamentos médicos."
	icon_state = "satchel-medical"
	inhand_icon_state = "satchel-med"

/obj/item/storage/backpack/satchel/chief_medic
	name = "chief medical officer's satchel"
	desc = "Uma bolsa com poucos bolsos para carregar o equipamento do médico chefe."
	icon_state = "satchel-chiefmedical"
	inhand_icon_state = "satchel-med"

/obj/item/storage/backpack/satchel/vir
	name = "virologist satchel"
	desc = "Uma bolsa estéril com cores virologistas."
	icon_state = "satchel-virology"
	inhand_icon_state = "satchel-vir"

/obj/item/storage/backpack/satchel/chem
	name = "chemist satchel"
	desc = "Uma bolsa estéril com cores químicas."
	icon_state = "satchel-chemistry"
	inhand_icon_state = "satchel-chem"

/obj/item/storage/backpack/satchel/coroner
	name = "coroner satchel"
	desc = "Uma bolsa usada para carregar o que sobrou de corpos humanos."
	icon_state = "satchel-coroner"
	inhand_icon_state = "satchel-coroner"

/obj/item/storage/backpack/satchel/gen
	name = "geneticist satchel"
	desc = "Uma bolsa estéril com cores geneticistas."
	icon_state = "satchel-genetics"
	inhand_icon_state = "satchel-gen"

/obj/item/storage/backpack/satchel/science
	name = "scientist satchel"
	desc = "Útil para manter materiais de pesquisa."
	icon_state = "satchel-science"
	inhand_icon_state = "satchel-sci"

/obj/item/storage/backpack/satchel/hyd
	name = "botanist satchel"
	desc = "Uma bolsa feita de fibras naturais."
	icon_state = "satchel-hydroponics"
	inhand_icon_state = "satchel-hyd"

/obj/item/storage/backpack/satchel/sec
	name = "security satchel"
	desc = "Uma bolsa robusta para necessidades relacionadas à segurança."
	icon_state = "satchel-security"
	inhand_icon_state = "satchel-sec"

/obj/item/storage/backpack/satchel/explorer
	name = "explorer satchel"
	desc = "Uma bolsa robusta para esconder seu saque."
	icon_state = "satchel-explorer"
	inhand_icon_state = "satchel-explorer"

/obj/item/storage/backpack/satchel/cap
	name = "captain's satchel"
	desc = "Uma bolsa exclusiva para oficiais Nanotrasen."
	icon_state = "satchel-captain"
	inhand_icon_state = "satchel-cap"

/obj/item/storage/backpack/satchel/flat
	name = "smuggler's satchel"
	desc = "Uma bolsa muito fina que pode caber facilmente em espaços apertados. Seu conteúdo não pode ser detectado por escaneadores de contrabando."
	icon_state = "satchel-flat"
	inhand_icon_state = "satchel-flat"
	w_class = WEIGHT_CLASS_NORMAL //Can fit in backpacks itself.
	storage_type = /datum/storage/backpack/satchel_flat

/obj/item/storage/backpack/satchel/flat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/undertile, TRAIT_T_RAY_VISIBLE, INVISIBILITY_MAXIMUM, use_anchor = TRUE) // SKYRAT EDIT - Ghosts can't see smuggler's satchels
	ADD_TRAIT(src, TRAIT_CONTRABAND_BLOCKER, INNATE_TRAIT)

/obj/item/storage/backpack/satchel/flat/PopulateContents()
	for(var/items in 1 to 4)
		new /obj/effect/spawner/random/contraband(src)

/obj/item/storage/backpack/satchel/flat/with_tools/PopulateContents()
	new /obj/item/stack/tile/iron/base(src)
	new /obj/item/crowbar(src)

	..()

/obj/item/storage/backpack/satchel/flat/empty/PopulateContents()
	return


/// Messenger Bag Types
/obj/item/storage/backpack/messenger
	name = "messenger bag"
	desc = "Uma bolsa de correio na moda, às vezes conhecida como bolsa de correio. Moda e portátil."
	icon_state = "messenger"
	inhand_icon_state = "messenger"
	icon = 'icons/obj/storage/backpack.dmi'
	worn_icon = 'icons/mob/clothing/back/backpack.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'

/obj/item/storage/backpack/messenger/eng
	name = "industrial messenger bag"
	desc = "Um saco de mensageiro feito de couro tratado para a prova de fogo. Também tem mais bolsos do que de costume."
	icon_state = "messenger_engineering"
	inhand_icon_state = "messenger_engineering"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/messenger/med
	name = "medical messenger bag"
	desc = "Um mensageiro estéril bem amado por médicos por sua portabilidade e perfil elegante."
	icon_state = "messenger_medical"
	inhand_icon_state = "messenger_medical"

/obj/item/storage/backpack/messenger/chief_medic
	name = "chief medical officer's messenger bag"
	desc = "Uma bolsa de recados apreciada por oficiais médicos por ficar fora de seu caminho enquanto trabalham, ao contrário de seus químicos."
	icon_state = "messenger_chiefmedical"
	inhand_icon_state = "messenger_medical"

/obj/item/storage/backpack/messenger/vir
	name = "virologist messenger bag"
	desc = "Um mensageiro estéril com cores virologistas, útil para implantar riscos biológicos em tempos recordes."
	icon_state = "messenger_virology"
	inhand_icon_state = "messenger_virology"

/obj/item/storage/backpack/messenger/chem
	name = "chemist messenger bag"
	desc = "Um saco estérei com cores químicas, bom para chegar aos seus negócios no beco a tempo."
	icon_state = "messenger_chemistry"
	inhand_icon_state = "messenger_chemistry"

/obj/item/storage/backpack/messenger/coroner
	name = "coroner messenger bag"
	desc = "Um mensageiro costumava sair de cemitérios a um bom ritmo."
	icon_state = "messenger_coroner"
	inhand_icon_state = "messenger_coroner"

/obj/item/storage/backpack/messenger/gen
	name = "geneticist messenger bag"
	desc = "Um saco de mensageiro estéril com cores geneticistas, fazendo um acessório incrivelmente bonito para Hulks."
	icon_state = "messenger_genetics"
	inhand_icon_state = "messenger_genetics"

/obj/item/storage/backpack/messenger/science
	name = "scientist messenger bag"
	desc = "Útil para manter materiais de pesquisa, e para acelerar seu caminho para diferentes objetivos de varredura."
	icon_state = "messenger_science"
	inhand_icon_state = "messenger_science"

/obj/item/storage/backpack/messenger/hyd
	name = "botanist messenger bag"
	desc = "Um saco de mensageiro feito de todas as fibras naturais, ótimo para chegar à Sesh a tempo."
	icon_state = "messenger_hydroponics"
	inhand_icon_state = "messenger_hydroponics"

/obj/item/storage/backpack/messenger/sec
	name = "security messenger bag"
	desc = "Um saco de mensageiro robusto para necessidades relacionadas à segurança."
	icon_state = "messenger_security"
	inhand_icon_state = "messenger_security"

/obj/item/storage/backpack/messenger/explorer
	name = "explorer messenger bag"
	desc = "Um saco de mensageiro robusto para esconder seu saque, além de fazer um acessório incrivelmente bonito para sua armadura de Drakebone."
	icon_state = "messenger_explorer"
	inhand_icon_state = "messenger_explorer"

/obj/item/storage/backpack/messenger/cap
	name = "captain's messenger bag"
	desc = "Uma bolsa exclusiva para oficiais Nanotrasen, feita de couro de baleia."
	icon_state = "messenger_captain"
	inhand_icon_state = "messenger_captain"

/obj/item/storage/backpack/messenger/clown
	name = "Giggles von Honkerton Jr."
	desc = "A última tecnologia de armazenamento da Honk Co. Ei, como isso se encaixa tanto com um perfil tão pequeno? O usuário definitivamente nunca lhe dirá."
	icon_state = "messenger_clown"
	inhand_icon_state = "messenger_clown"
