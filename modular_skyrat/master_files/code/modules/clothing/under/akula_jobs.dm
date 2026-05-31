/// The DMI containing the tail overlay sprites
#define TAIL_OVERLAY_DMI 'modular_skyrat/master_files/icons/mob/clothing/under/akula.dmi'
/// The proper layer to render the tail overlays onto
#define TAIL_OVERLAY_LAYER 5.9

/obj/item/clothing/under/akula_wetsuit
	name = "Shoredress wetsuit"
	desc = "O padrão \"Trabalho molhado.\" Shoredress usado pela maioria dos Akula, completo com sistemas de circulação de água e painéis luminescentes de alta visibilidade para sinalização. Vem em muitas variações."
	icon_state = "default"
	base_icon_state = "default"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/akula.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/akula.dmi'
	armor_type = /datum/armor/clothing_under/wetsuit
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	can_adjust = FALSE
	female_sprite_flags = NO_FEMALE_UNIFORM
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	/// If an akula tail accessory is present, we can overlay an additional icon
	var/tail_overlay


/obj/item/clothing/under/akula_wetsuit/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wetsuit)
	update_appearance()

/obj/item/clothing/under/akula_wetsuit/Destroy()
	var/mob/user = loc
	if(!istype(user))
		return ..()

	if(tail_overlay)
		user.cut_overlay(tail_overlay)
		tail_overlay = null

	qdel(GetComponent(/datum/component/wetsuit))
	. = ..()

/obj/item/clothing/under/akula_wetsuit/equipped(mob/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_ICLOTHING)
		return

	check_physique(user)
	add_tail_overlay(user)
	update_appearance()

/obj/item/clothing/under/akula_wetsuit/dropped(mob/user)
	. = ..()
	if(tail_overlay)
		user.cut_overlay(tail_overlay)
		tail_overlay = null

	update_appearance()

/// This will check the wearer's bodytype and change the wetsuit worn sprite according to if its male/female
/obj/item/clothing/under/akula_wetsuit/proc/check_physique(mob/living/carbon/human/user)
	icon_state = base_icon_state
	if(user.physique == FEMALE)
		icon_state = "[icon_state]_f"
	return TRUE

/// If the wearer has a compatible tail for the `tail_overlay` variable, render it
/obj/item/clothing/under/akula_wetsuit/proc/add_tail_overlay(mob/living/carbon/human/user)
	if(!user.dna.species.mutant_bodyparts[FEATURE_TAIL_GENERIC])
		return

	var/tail = user.dna.species.mutant_bodyparts[FEATURE_TAIL_GENERIC][MUTANT_INDEX_NAME]
	switch(tail)
		if("Akula")
			tail_overlay = mutable_appearance(TAIL_OVERLAY_DMI, "overlay_akula", -(TAIL_OVERLAY_LAYER))
		if("Shark")
			tail_overlay = mutable_appearance(TAIL_OVERLAY_DMI, "overlay_shark", -(TAIL_OVERLAY_LAYER))
		if("Shark (No Fin)")
			tail_overlay = mutable_appearance(TAIL_OVERLAY_DMI, "overlay_shark_no_fin", -(TAIL_OVERLAY_LAYER))
		if("Fish")
			tail_overlay = mutable_appearance(TAIL_OVERLAY_DMI, "overlay_fish", -(TAIL_OVERLAY_LAYER))
		else
			tail_overlay = null

	if(tail_overlay)
		user.add_overlay(tail_overlay)
		worn_icon_state = "[icon_state]_tail"

	/// Suit armor
/datum/armor/clothing_under/wetsuit
	bio = 10

/obj/item/clothing/under/akula_wetsuit/job
	/// Our large examine text
	var/extended_desc = "The 'Wetworks'-pattern Shoredress worn by most Akula, complete with water circulation systems and high-visibility luminescent panels for signalling. Comes in many variations."

/obj/item/clothing/under/akula_wetsuit/job/examine(mob/user)
	. = ..()
	. += span_notice("Este item pode ser examinado mais...")

/obj/item/clothing/under/akula_wetsuit/job/examine_more(mob/user)
	. = ..()
	. += extended_desc

/obj/item/clothing/under/akula_wetsuit/job/engineering
	name = "engineer Shoredress wetsuit"
	desc = "O padrão de engenharia do traje de banho Akula Shoredress, alterado para ser mais resistente ao calor e química. No entanto, não o protegerá da maioria dos perigos por si só."
	icon_state = "engi"
	base_icon_state = "engi"
	armor_type = /datum/armor/clothing_under/wetsuit/engineering

/datum/armor/clothing_under/wetsuit/engineering
	fire = 95
	acid = 95

/obj/item/clothing/under/akula_wetsuit/job/cargo
	name = "cargo Shoredress wetsuit"
	desc = "O padrão de carga da roupa de banho Akula Shoredress. A filosofia de design deste traje parece ter incluído grandes quantidades de estofamento para conforto."
	icon_state = "cargo"
	base_icon_state = "cargo"
	armor_type = /datum/armor/clothing_under/wetsuit/cargo

/datum/armor/clothing_under/wetsuit/cargo
	fire = 40

/obj/item/clothing/under/akula_wetsuit/job/science
	name = "science Shoredress wetsuit"
	desc = "O padrão científico do traje de banho Akula Shoredress, focado principalmente em proteções ambientais. Destinado a ser usado em tangentes com proteções reais, não irá protegê-lo sozinho."
	icon_state = "sci"
	base_icon_state = "sci"
	armor_type = /datum/armor/clothing_under/wetsuit/science

/datum/armor/clothing_under/wetsuit/science
	bomb = 40
	acid = 95

/obj/item/clothing/under/akula_wetsuit/job/medical
	name = "medical Shoredress wetsuit"
	desc = "O padrão médico do traje de banho Akula Shoredress. Incorpora tecnologia de esterilização rudimentar, para manter o usuário limpo durante as longas horas na sala de cirurgia."
	icon_state = "medical"
	base_icon_state = "medical"
	armor_type = /datum/armor/clothing_under/wetsuit/medical

/datum/armor/clothing_under/wetsuit/medical
	acid = 95
	bio = 95

/obj/item/clothing/under/akula_wetsuit/job/security
	name = "security Shoredress wetsuit"
	desc = "O padrão de segurança do traje de banho Akula Shoredress. Proporciona um nível de conforto ao lidar com ameaças ao seu posto, melhor usado sob armadura."
	icon_state = "sec"
	base_icon_state = "sec"
	armor_type = /datum/armor/clothing_under/rank_security

/obj/item/clothing/under/akula_wetsuit/job/command
	name = "command Shoredress wetsuit"
	desc = "O padrão de comando do fato de banho Akula Shoredress. Conforto máximo, estética máxima, para o elegante comandante Akula. Vem com um bloco dedicado para adicionar medalhas sem perfurar o traje."
	icon_state = "command"
	base_icon_state = "command"
	armor_type = /datum/armor/clothing_under/rank_security


/obj/item/clothing/head/helmet/space/akula_wetsuit
	name = "\improper Shoredress helm"
	desc = "O Capacete em uma roupa de banho Akula Shoredress, muitas vezes chamado de\"Vidro\". Cheio de água, vem em muitas cores, nenhuma das quais você tem acesso. Muitas vezes chamado de \"Peixe.\"."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/akula.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/akula.dmi'
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SNUG_FIT | STACKABLE_HELMET_EXEMPT | HEADINTERNALS
	icon_state = "helmet"
	inhand_icon_state = "helmet"
	strip_delay = 6 SECONDS
	armor_type = /datum/armor/wetsuit_helmet
	resistance_flags = FIRE_PROOF
	/// Variable for storing hats which are worn inside the bubble helmet
	var/obj/item/clothing/head/attached_hat
	flags_inv = null
	flags_cover = HEADCOVERSMOUTH | PEPPERPROOF

	/// Helmet armor
/datum/armor/wetsuit_helmet
	bio = 100
	fire = 100

/obj/item/clothing/head/helmet/space/akula_wetsuit/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wetsuit)
	update_appearance()

/obj/item/clothing/head/helmet/space/akula_wetsuit/Destroy()
	var/mob/user = loc
	if(attached_hat)
		attached_hat.forceMove(drop_location())

	if(!istype(user))
		return ..()

	qdel(GetComponent(/datum/component/wetsuit))
	. = ..()

// Wearing hats inside the wetworks helmet
/obj/item/clothing/head/helmet/space/akula_wetsuit/examine()
	. = ..()
	if(attached_hat)
		. += span_notice("Tem.[attached_hat]Colocado sem capacete.")
		. += span_bold("Clique com o botão direito para removê-lo.")
	else
		. += span_notice("Não há nada no capacete.")

/obj/item/clothing/head/helmet/space/akula_wetsuit/attackby(obj/item/hitting_item, mob/living/user)
	. = ..()
	if(!istype(hitting_item, /obj/item/clothing/head))
		return
	var/obj/item/clothing/hitting_hat = hitting_item
	if(hitting_hat.clothing_flags & STACKABLE_HELMET_EXEMPT)
		balloon_alert(user, "não cabe!")
		return
	if(attached_hat)
		balloon_alert(user, "Já tem algo dentro!")
		return

	attached_hat = hitting_hat
	balloon_alert(user, "[hitting_hat]colocar dentro")
	hitting_hat.forceMove(src)
	icon_state = "empty"
	update_appearance()

/obj/item/clothing/head/helmet/space/akula_wetsuit/worn_overlays(mutable_appearance/standing, isinhands)
	. = ..()
	if(!attached_hat || isinhands)
		return

	var/mutable_appearance/attached_hat_appearance = mutable_appearance(attached_hat.worn_icon, attached_hat.icon_state, -(HEAD_LAYER-0.1))
	attached_hat_appearance.add_overlay(mutable_appearance(worn_icon, "helmet", -HEAD_LAYER))
	. += attached_hat_appearance


/obj/item/clothing/head/helmet/space/akula_wetsuit/attack_hand_secondary(mob/user)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(!attached_hat)
		return

	user.put_in_active_hand(attached_hat)
	balloon_alert(user, "[attached_hat]Removido")
	attached_hat = null
	icon_state = "helmet"
	update_appearance()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

#undef TAIL_OVERLAY_DMI
#undef TAIL_OVERLAY_LAYER
