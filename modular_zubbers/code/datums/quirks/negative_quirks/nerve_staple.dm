/datum/quirk/equipping/nerve_staple
	name = "Nerve Stapled"
	desc = "Você é pacifista. Não porque queira, mas por causa do dispositivo grampeado em seu olho."
	value = -10 // pacifism = -8, losing eye slots = -2
	gain_text = span_danger("Você de repente não pode levantar a mão para machucar os outros!")
	lose_text = span_notice("Acha que pode se defender de novo.")
	medical_record_text = "O paciente tem o nervo grampeado e é incapaz de prejudicar os outros."
	icon = FA_ICON_FACE_ANGRY
	forced_items = list(/obj/item/clothing/glasses/nerve_staple = list(ITEM_SLOT_EYES))
	/// The nerve staple attached to the quirk
	var/obj/item/clothing/glasses/nerve_staple/staple

/datum/quirk/equipping/nerve_staple/on_equip_item(obj/item/equipped, successful)
	if (!istype(equipped, /obj/item/clothing/glasses/nerve_staple))
		return
	staple = equipped

/datum/quirk/equipping/nerve_staple/remove()
	. = ..()
	if (!staple || staple != quirk_holder.get_item_by_slot(ITEM_SLOT_EYES))
		return
	to_chat(quirk_holder, span_warning("O grampo nervoso de repente cai do seu rosto e derrete.[istype(quirk_holder.loc, /turf/open/floor) ? " on the floor" : ""]!"))
	qdel(staple)
