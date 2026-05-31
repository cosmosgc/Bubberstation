/obj/item/clothing/gloves/ring
	icon = 'modular_skyrat/master_files/icons/obj/ring.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	name = "gold ring"
	desc = "Um pequeno anel de ouro, do tamanho de um dedo."
	gender = NEUTER
	w_class = WEIGHT_CLASS_TINY
	icon_state = "ringgold"
	inhand_icon_state = null
	worn_icon_state = "gring"
	body_parts_covered = 0
	strip_delay = 4 SECONDS
	clothing_traits = list(TRAIT_FINGERPRINT_PASSTHROUGH)

/obj/item/clothing/gloves/ring/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("\[user]é colocar o[src]em[user.p_their()]Boca! Parece que...[user]Está tentando engasgar com o[src]!"))
	return OXYLOSS


/obj/item/clothing/gloves/ring/diamond
	name = "diamond ring"
	desc = "Um anel caro, cravado com um diamante. Culturas têm usado esses anéis no namoro para um milênio."
	icon_state = "ringdiamond"
	worn_icon_state = "dring"

/obj/item/clothing/gloves/ring/diamond/attack_self(mob/user)
	user.visible_message(span_warning("\The [user]fica de joelhos, apresentando\the [src]."),span_warning("Você fica de joelhos, apresentando\the [src]."))

/obj/item/clothing/gloves/ring/silver
	name = "silver ring"
	desc = "Um pequeno anel de prata, do tamanho de um dedo."
	icon_state = "ringsilver"
	worn_icon_state = "sring"
