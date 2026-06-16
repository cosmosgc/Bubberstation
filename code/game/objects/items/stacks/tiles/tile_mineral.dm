/obj/item/stack/tile/mineral
	/// Determines what stack is gotten out of us when welded.
	var/mineralType = null

/obj/item/stack/tile/mineral/attackby(obj/item/W, mob/user, list/modifiers, list/attack_modifiers)
	if(W.tool_behaviour == TOOL_WELDER)
		if(get_amount() < 4)
			to_chat(user, span_warning("Você precisa de pelo menos quatro peças para fazer isso!"))
			return
		if(!mineralType)
			to_chat(user, span_warning("Você não pode reformar isso!"))
			stack_trace("A mineral tile of type [type] doesn't have its mineralType set.")
			return
		if(W.use_tool(src, user, 0, volume=40))
			var/sheet_type = text2path("/obj/item/stack/sheet/mineral/[mineralType]")
			var/obj/item/stack/sheet/mineral/new_item = new sheet_type(user.loc)
			user.visible_message(span_notice("[user] Em forma [src] Em [new_item] Com [W]."), 				span_notice("Você moldou [src] Em [new_item] Com [W]."), 				span_hear("Você ouve solda."))
			var/holding = user.is_holding(src)
			use(4)
			if(holding && QDELETED(src))
				user.put_in_hands(new_item)
	else
		return ..()

/obj/item/stack/tile/mineral/plasma
	name = "plasma tile"
	singular_name = "Piso de plasma"
	desc = "Um azulejo feito de plasma altamente inflamável. Isso só pode acabar bem."
	icon_state = "tile_plasma"
	inhand_icon_state = "tile-plasma"
	turf_type = /turf/open/floor/mineral/plasma
	mineralType = "plasma"
	mats_per_unit = list(/datum/material/plasma=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/plasma

/obj/item/stack/tile/mineral/uranium
	name = "uranium tile"
	singular_name = "Piso de urânio"
	desc = "Um azulejo feito de urânio. Você se sente um pouco tonto."
	icon_state = "tile_uranium"
	inhand_icon_state = "tile-uranium"
	turf_type = /turf/open/floor/mineral/uranium
	mineralType = "uranium"
	mats_per_unit = list(/datum/material/uranium=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/uranium

/obj/item/stack/tile/mineral/gold
	name = "gold tile"
	singular_name = "Piso de ouro"
	desc = "Um azulejo feito de ouro, o balanço parece forte aqui."
	icon_state = "tile_gold"
	inhand_icon_state = "tile-gold"
	turf_type = /turf/open/floor/mineral/gold
	mineralType = "gold"
	mats_per_unit = list(/datum/material/gold=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/gold

/obj/item/stack/tile/mineral/silver
	name = "silver tile"
	singular_name = "Azulejo de piso de prata"
	desc = "Um azulejo feito de prata, a luz que brilha dele é ofuscante."
	icon_state = "tile_silver"
	inhand_icon_state = "tile-silver"
	turf_type = /turf/open/floor/mineral/silver
	mineralType = "silver"
	mats_per_unit = list(/datum/material/silver=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/silver

/obj/item/stack/tile/mineral/diamond
	name = "diamond tile"
	singular_name = "Piso de Diamante"
	desc = "Um azulejo feito de diamante. Nossa."
	icon_state = "tile_diamond"
	inhand_icon_state = "tile-diamond"
	turf_type = /turf/open/floor/mineral/diamond
	mineralType = "diamond"
	mats_per_unit = list(/datum/material/diamond=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/diamond

/obj/item/stack/tile/mineral/bananium
	name = "bananium tile"
	singular_name = "telha do chão do banânio"
	desc = "Um azulejo não escorregadio feito de banânio, HOOOOOOOONK!"
	icon_state = "tile_bananium"
	inhand_icon_state = "tile-bananium"
	turf_type = /turf/open/floor/mineral/bananium
	mineralType = "bananium"
	mats_per_unit = list(/datum/material/bananium=SHEET_MATERIAL_AMOUNT*0.25)
	material_flags = NONE //The slippery comp makes it unpractical for good clown decor. The material tiles should still slip.
	merge_type = /obj/item/stack/tile/mineral/bananium

/obj/item/stack/tile/mineral/abductor
	name = "alien floor tile"
	singular_name = "Pisos alienígenas"
	desc = "Um azulejo feito de liga alienígena."
	icon = 'icons/obj/antags/abductor.dmi'
	icon_state = "tile_abductor"
	inhand_icon_state = "tile-abductor"
	mats_per_unit = list(/datum/material/alloy/alien=SHEET_MATERIAL_AMOUNT*0.25)
	turf_type = /turf/open/floor/mineral/abductor
	mineralType = "abductor"
	merge_type = /obj/item/stack/tile/mineral/abductor

/obj/item/stack/tile/mineral/titanium
	name = "titanium tile"
	singular_name = "Titânio piso azulejo"
	desc = "Titânio elegante, usado em ônibus."
	icon_state = "tile_titanium"
	inhand_icon_state = "tile-shuttle"
	turf_type = /turf/open/floor/mineral/titanium
	mineralType = "titanium"
	mats_per_unit = list(/datum/material/titanium=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/titanium
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/titanium,
		/obj/item/stack/tile/mineral/titanium/yellow,
		/obj/item/stack/tile/mineral/titanium/blue,
		/obj/item/stack/tile/mineral/titanium/white,
		/obj/item/stack/tile/mineral/titanium/purple,
		/obj/item/stack/tile/mineral/titanium/tiled,
		/obj/item/stack/tile/mineral/titanium/tiled/yellow,
		/obj/item/stack/tile/mineral/titanium/tiled/blue,
		/obj/item/stack/tile/mineral/titanium/tiled/white,
		/obj/item/stack/tile/mineral/titanium/tiled/purple,
		)

/obj/item/stack/tile/mineral/titanium/yellow
	name = "yellow titanium tile"
	singular_name = "Titânio amarelo piso azulejo"
	desc = "Titânio amarelo azulado, usado para ônibus."
	turf_type = /turf/open/floor/mineral/titanium/yellow
	icon_state = "tile_titanium_yellow"
	merge_type = /obj/item/stack/tile/mineral/titanium/yellow

/obj/item/stack/tile/mineral/titanium/blue
	name = "blue titanium tile"
	singular_name = "azul Titânio piso azul"
	desc = "azulejos azuis de titânio, usados em ônibus."
	turf_type = /turf/open/floor/mineral/titanium/blue
	icon_state = "tile_titanium_blue"
	merge_type = /obj/item/stack/tile/mineral/titanium/blue

/obj/item/stack/tile/mineral/titanium/white
	name = "white titanium tile"
	singular_name = "Titânio branco piso azulejo"
	desc = "Titânio branco elegante, usado em ônibus."
	turf_type = /turf/open/floor/mineral/titanium/white
	icon_state = "tile_titanium_white"
	merge_type = /obj/item/stack/tile/mineral/titanium/white

/obj/item/stack/tile/mineral/titanium/purple
	name = "purple titanium tile"
	singular_name = "Titânio roxo piso azulejo"
	desc = "Tijolos de titânio roxos, usados para ônibus."
	turf_type = /turf/open/floor/mineral/titanium/purple
	icon_state = "tile_titanium_purple"
	merge_type = /obj/item/stack/tile/mineral/titanium/purple

/obj/item/stack/tile/mineral/titanium/tiled
	name = "tiled titanium tile"
	singular_name = "azulejo de titânio piso telha"
	desc = "Titânio azulejos, usados para ônibus."
	turf_type = /turf/open/floor/mineral/titanium/tiled
	icon_state = "tile_titanium_tiled"
	merge_type = /obj/item/stack/tile/mineral/titanium/tiled

/obj/item/stack/tile/mineral/titanium/tiled/yellow
	name = "yellow titanium tile"
	singular_name = "Titânio amarelo piso azulejo"
	desc = "Pisos amarelos de titânio, usados para ônibus."
	turf_type = /turf/open/floor/mineral/titanium/tiled/yellow
	icon_state = "tile_titanium_tiled_yellow"
	merge_type = /obj/item/stack/tile/mineral/titanium/tiled/yellow

/obj/item/stack/tile/mineral/titanium/tiled/blue
	name = "blue titanium tile"
	singular_name = "azul Titânio piso azul"
	desc = "Piso azul de titânio, usado para ônibus."
	turf_type = /turf/open/floor/mineral/titanium/tiled/blue
	icon_state = "tile_titanium_tiled_blue"
	merge_type = /obj/item/stack/tile/mineral/titanium/tiled/blue

/obj/item/stack/tile/mineral/titanium/tiled/white
	name = "white titanium tile"
	singular_name = "Titânio branco piso azulejo"
	desc = "Pisos brancos de titânio, usados para ônibus."
	turf_type = /turf/open/floor/mineral/titanium/tiled/white
	icon_state = "tile_titanium_tiled_white"
	merge_type = /obj/item/stack/tile/mineral/titanium/tiled/white

/obj/item/stack/tile/mineral/titanium/tiled/purple
	name = "purple titanium tile"
	singular_name = "Titânio roxo piso azulejo"
	desc = "Pisos de titânio roxos, usados para ônibus."
	turf_type = /turf/open/floor/mineral/titanium/tiled/purple
	icon_state = "tile_titanium_tiled_purple"
	merge_type = /obj/item/stack/tile/mineral/titanium/tiled/purple

/obj/item/stack/tile/mineral/plastitanium
	name = "plastitanium tile"
	singular_name = "Piso de plastânio"
	desc = "Um azulejo feito de plastânio, usado para naves muito maléficas."
	icon_state = "tile_plastitanium"
	inhand_icon_state = "tile-darkshuttle"
	turf_type = /turf/open/floor/mineral/plastitanium
	mineralType = "plastitanium"
	mats_per_unit = list(/datum/material/alloy/plastitanium=SHEET_MATERIAL_AMOUNT*0.25)
	merge_type = /obj/item/stack/tile/mineral/plastitanium
	tile_reskin_types = list(
		/obj/item/stack/tile/mineral/plastitanium,
		/obj/item/stack/tile/mineral/plastitanium/red,
		)

/obj/item/stack/tile/mineral/plastitanium/red
	name = "red plastitanium tile"
	singular_name = "azulejo vermelho do chão de plastânio"
	desc = "Um azulejo feito de plastificanium, usado para vaivéns muito vermelhos."
	turf_type = /turf/open/floor/mineral/plastitanium/red
	icon_state = "tile_plastitanium_red"
	merge_type = /obj/item/stack/tile/mineral/plastitanium/red

/obj/item/stack/tile/mineral/snow
	name = "snow tile"
	singular_name = "telha de neve"
	desc = "Uma cama de neve."
	icon_state = "tile_snow"
	inhand_icon_state = "tile-silver"
	turf_type = /turf/open/floor/fake_snow
	mineralType = "snow"
	merge_type = /obj/item/stack/tile/mineral/snow
	mats_per_unit = list(/datum/material/snow = HALF_SHEET_MATERIAL_AMOUNT / 2)
