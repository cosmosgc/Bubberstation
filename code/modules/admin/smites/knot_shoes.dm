/// Ties the target's shoes
/datum/smite/knot_shoes
	name = "Knot Shoes"

/datum/smite/knot_shoes/effect(client/user, mob/living/target)
	. = ..()
	if (!iscarbon(target))
		to_chat(user, span_warning("Isso deve ser usado em uma multidão de carbono."), confidential = TRUE)
		return
	var/mob/living/carbon/dude = target
	var/obj/item/clothing/shoes/sick_kicks = dude.shoes
	if (!sick_kicks || sick_kicks.fastening_type == SHOES_SLIPON)
		to_chat(user, span_warning("[dude] Não tem sapatos para nós!"), confidential = TRUE)
		return
	sick_kicks.adjust_laces(SHOES_KNOTTED)
