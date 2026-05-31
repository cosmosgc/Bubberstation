/datum/action/cooldown/spell/shapeshift/wolf
	name = "Wolf Form"
	desc = "Tome a forma de um lobo."
	invocation = span_danger("<b>%CASTER</b> lets out a mighty growl!")
	invocation_self_message = span_danger("Você soltou um rosnado poderoso!")
	invocation_type = INVOCATION_EMOTE
	spell_requirements = NONE

	possible_shapes = list(/mob/living/basic/mining/wolf)

/obj/item/clothing/neck/cloak/wolf_coat
	name = "wolf pelt cloak"
	desc = "Uma capa feita de peles de lobo muito vivas, parece quente para tocar."
	icon_state = "icecloak"
	icon = 'icons/obj/clothing/cloaks.dmi'
	worn_icon = 'icons/mob/clothing/neck.dmi'
	inhand_icon_state = "icecloak"
	lefthand_file = 'icons/mob/inhands/clothing/neck_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/neck_righthand.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	resistance_flags = FIRE_PROOF | FREEZE_PROOF

	/// Reference to hood object, if it exists
	var/obj/item/clothing/head/hooded/hood

/obj/item/clothing/neck/cloak/wolf_coat/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_attached_clothing,		deployable_type = /obj/item/clothing/head/hooded/wolf_coat_hoodie,		equipped_slot = ITEM_SLOT_HEAD,		action_name = "Toggle Hood",		on_created = CALLBACK(src, PROC_REF(on_hood_created)),	)

/obj/item/clothing/neck/cloak/wolf_coat/Destroy()
	hood = null
	return ..()

/// Called when the hood is instantiated
/obj/item/clothing/neck/cloak/wolf_coat/proc/on_hood_created(obj/item/clothing/head/hooded/hood)
	SHOULD_CALL_PARENT(TRUE)
	src.hood = hood
	RegisterSignal(hood, COMSIG_QDELETING, PROC_REF(on_hood_deleted))

/// Called when hood is deleted
/obj/item/clothing/neck/cloak/wolf_coat/proc/on_hood_deleted()
	SIGNAL_HANDLER
	SHOULD_CALL_PARENT(TRUE)
	hood = null

///The hoodie, made by the cloak, which gives the action button (making it required to wear the hoodie to use it)
/obj/item/clothing/head/hooded/wolf_coat_hoodie
	name = "wolf pelt hood"
	desc = "Um capuz feito de pêlo de lobo."
	icon = 'icons/obj/clothing/head/winterhood.dmi'
	worn_icon = 'icons/mob/clothing/head/winterhood.dmi'
	icon_state = "icecloak_hood"
	actions_types = list(/datum/action/cooldown/spell/shapeshift/wolf)
	flags_inv = HIDEHAIR|HIDEEARS
	resistance_flags = FIRE_PROOF | FREEZE_PROOF

