	//NASA Voidsuit
/obj/item/clothing/head/helmet/space/nasavoid
	name = "NASA Void Helmet"
	desc = "Um antigo ramo da NASA CentCom projetado, um capacete de terno espacial vermelho escuro."
	icon_state = "void"
	inhand_icon_state = "void_helmet"

/obj/item/clothing/suit/space/nasavoid
	name = "NASA Voidsuit"
	icon_state = "void"
	inhand_icon_state = "void_suit"
	desc = "Um antigo ramo da NASA CentCom projetado, traje espacial vermelho escuro."
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/multitool)

/obj/item/clothing/head/helmet/space/nasavoid/old
	name = "Engineering Void Helmet"
	desc = "Um capacete espacial vermelho escuro da CentCom. Enquanto velho e empoeirado, ainda faz o trabalho."
	icon_state = "void"
	visor_dirt = "void_dirt"

/obj/item/clothing/suit/space/nasavoid/old
	name = "Engineering Voidsuit"
	icon_state = "void"
	inhand_icon_state = "void_suit"
	desc = "Um traje espacial vermelho escuro da CentCom. A idade degrada o terno, dificultando a mudança."
	slowdown = 4
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/multitool)

	//EVA suit
/obj/item/clothing/suit/space/eva
	name = "EVA suit"
	icon_state = "space"
	inhand_icon_state = "s_suit"
	desc = "Um traje espacial leve com a habilidade básica de proteger o usuário do vácuo do espaço durante emergências."
	armor_type = /datum/armor/space_eva

/obj/item/clothing/head/helmet/space/eva
	name = "EVA helmet"
	icon_state = "space"
	inhand_icon_state = "space_helmet"
	desc = "Um capacete espacial leve com a habilidade básica de proteger o usuário do vácuo do espaço durante emergências."
	flash_protect = FLASH_PROTECTION_NONE
	armor_type = /datum/armor/space_eva
	visor_dirt = "space_dirt"

/datum/armor/space_eva
	bio = 100
	fire = 50
	acid = 65

/obj/item/clothing/head/helmet/space/eva/examine(mob/user)
	. = ..()
	. += span_notice("You can start constructing a critter sized mecha with a [span_bold("cyborg leg")].")

/obj/item/clothing/head/helmet/space/eva/attackby(obj/item/attacked_with, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(.)
		return
	if(!istype(attacked_with, /obj/item/bodypart/leg/left/robot) && !istype(attacked_with, /obj/item/bodypart/leg/right/robot))
		return
	if(ismob(loc))
		user.balloon_alert(user, "Largue o capacete primeiro!")
		return
	user.balloon_alert(user, "Perna presa")
	new /obj/item/bot_assembly/vim(loc)
	qdel(attacked_with)
	qdel(src)

	//Emergency suit
/obj/item/clothing/head/helmet/space/fragile
	name = "emergency space helmet"
	desc = "Um capacete volumoso e hermético para proteger o usuário em situações de emergência. Não parece muito durável."
	icon_state = "syndicate-helm-orange"
	inhand_icon_state = "syndicate-helm-orange" //resprite?
	armor_type = /datum/armor/space_fragile
	strip_delay = 6.5 SECONDS

/obj/item/clothing/suit/space/fragile
	name = "emergency space suit"
	desc = "Um terno volumoso e hermético para proteger o usuário em situações de emergência. Não parece muito durável."
	var/torn = FALSE
	icon_state = "syndicate-orange"
	inhand_icon_state = "syndicate-orange"
	slowdown = 2
	armor_type = /datum/armor/space_fragile
	strip_delay = 6.5 SECONDS

/datum/armor/space_fragile
	melee = 5

/obj/item/clothing/suit/space/fragile/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(!torn && prob(50))
		to_chat(owner, span_warning("[src] lágrimas dos danos, quebrando o selo hermético!"))
		clothing_flags &= ~STOPSPRESSUREDAMAGE
		name = "torn [src]."
		desc = "Um terno volumoso para proteger o usuário em situações de emergência, pelo menos até alguém abrir um buraco no terno."
		torn = TRUE
		playsound(loc, 'sound/items/weapons/slashmiss.ogg', 50, TRUE)
		playsound(loc, 'sound/effects/refill.ogg', 50, TRUE)
