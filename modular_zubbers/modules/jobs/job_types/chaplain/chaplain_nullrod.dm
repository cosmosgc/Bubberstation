/obj/item/nullrod/sylvanstaff
	name = "Sylvan Staff"
	desc = "Dryads e druidas usam varas como esta como foco para melhorar a sintonia com a natureza."
	icon = 'icons/obj/weapons/guns/magic.dmi'
	icon_state = "staffofdoor"
	inhand_icon_state = "staffofdoor"
	icon_angle = -45
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/staves_righthand.dmi'
	damtype = BURN
	force = 16
	throwforce = 15
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("bashes", "smacks", "whacks")
	attack_verb_simple = list("bash", "smack", "whack")
	menu_description = "Uma equipe fortemente sintonizada com a natureza. Não bate tão forte, mas causa dano à queimadura, também tem a chance de transferir seus reagentes para o alvo. Usado lá atrás."

// Pride hammer reagent transfer effect.

#define CHEMICAL_TRANSFER_CHANCE 30

/obj/item/nullrod/sylvanstaff/Initialize(mapload)
	. = ..()
	AddElement(
		/datum/element/chemical_transfer,\
		span_notice("Você sente seu corpo sendo limpo"),\
		span_userdanger("Você sente a transferência de impurezas dentro de você."),\
		CHEMICAL_TRANSFER_CHANCE\
	)

#undef CHEMICAL_TRANSFER_CHANCE
