/obj/item/glassblowing/magnifying_glass
	name = "magnifying glass"
	desc = "Uma ferramenta que, com a ajuda de uma lente de ampliação, permite ver o que é pequeno."
	icon_state = "magnifying_glass"
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT)

/obj/item/glassblowing/magnifying_glass/examine(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_XENOARCH_QUALIFIED))
		. += span_notice("Você pode usar[src]em relíquias inúteis para realizar todo o seu potencial!")

/datum/crafting_recipe/magnifying_glass
	name = "Magnifying Glass"
	result = /obj/item/glassblowing/magnifying_glass
	reqs = list(
		/obj/item/stack/sheet/mineral/wood = 1,
		/obj/item/glassblowing/glass_lens = 1,
	)
	category = CAT_EQUIPMENT
