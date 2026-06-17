
#define CLIENT_ORGAN_MULT 10

/datum/export/organ
	abstract_type = /datum/export/organ
	include_subtypes = FALSE //CentCom doesn't need organs from non-humans.

/datum/export/organ/get_base_cost(obj/exported_item)
	// Multiply value for organs that started in a player
	// Unaffected by price elasticity as there's a limited amount of these in play
	return round(..() * HAS_TRAIT(exported_item, TRAIT_CLIENT_STARTING_ORGAN) ? CLIENT_ORGAN_MULT : 1)

/datum/export/organ/heart
	cost = CARGO_CRATE_VALUE * 0.2 //For the man who has everything and nothing.
	unit_name = "Coração humanóide"
	export_types = list(/obj/item/organ/heart)

/datum/export/organ/eyes
	cost = CARGO_CRATE_VALUE * 0.1
	unit_name = "Olhos humanóides"
	export_types = list(/obj/item/organ/eyes)

/datum/export/organ/ears
	cost = CARGO_CRATE_VALUE * 0.1
	unit_name = "Orelhas humanóides"
	export_types = list(/obj/item/organ/ears)

/datum/export/organ/liver
	cost = CARGO_CRATE_VALUE * 0.1
	unit_name = "Fígado humanóide"
	export_types = list(/obj/item/organ/liver)

/datum/export/organ/lungs
	cost = CARGO_CRATE_VALUE * 0.1
	unit_name = "Pulmões humanóides"
	export_types = list(/obj/item/organ/lungs)

/datum/export/organ/stomach
	cost = CARGO_CRATE_VALUE * 0.1
	unit_name = "estomago humanóide"
	export_types = list(/obj/item/organ/stomach)

/datum/export/organ/tongue
	cost = CARGO_CRATE_VALUE * 0.1
	unit_name = "Língua humanóide"
	export_types = list(/obj/item/organ/tongue)

/datum/export/organ/lizard_tail
	cost = CARGO_CRATE_VALUE * 1.25
	unit_name = "cauda de lagarto"
	export_types = list(/obj/item/organ/tail/lizard)

/datum/export/organ/cat_tail
	cost = CARGO_CRATE_VALUE * 1.5
	unit_name = "cauda de gato"
	export_types = list(/obj/item/organ/tail/cat)

/datum/export/organ/cat_ears
	cost = CARGO_CRATE_VALUE
	unit_name = "Orelhas de gato"
	export_types = list(/obj/item/organ/ears/cat)


#undef CLIENT_ORGAN_MULT
