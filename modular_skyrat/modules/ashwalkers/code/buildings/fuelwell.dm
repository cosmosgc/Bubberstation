//CODE CREDIT TO JJPARK-KB
//Infinite welding fuel source, lets ashwalkers have infinite fuel without needing high-tech welders.

/obj/structure/sink/fuel_well
	name = "fuel well"
	desc = "Uma piscina borbulhante de combustível. Isso provavelmente seria valioso, se a tecnologia do espaço azul não tivesse destruído a necessidade de combustíveis fósseis há 200 anos."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "puddle-oil"
	dispensedreagent = /datum/reagent/fuel
	color = "#742912"	//Gives it a weldingfuel hue

/obj/structure/sink/fuel_well/Initialize(mapload)
	.=..()
	create_reagents(20)
	reagents.add_reagent(dispensedreagent, 20)

/obj/structure/sink/fuel_well/attack_hand(mob/user, list/modifiers)
	flick("puddle-oil-splash",src)
	reagents.expose(user, TOUCH, 20) //Covers target in 20u of fuel.
	to_chat(user, span_notice("Você toca na piscina de combustível, só para se encher de combustível. Seria sábio lavar isso com água."))

/obj/structure/sink/fuel_well/attackby(obj/item/O, mob/living/user, params)
	flick("puddle-oil-splash",src)
	if(O.tool_behaviour == TOOL_SHOVEL) //attempt to deconstruct the puddle with a shovel //attempt to deconstruct the puddle with a shovel
		to_chat(user, "Você enche o combustível com solo.")
		O.play_tool_sound(src)
		deconstruct()
		return 1
	if(istype(O, /obj/item/reagent_containers)) //Refilling bottles with oil
		var/obj/item/reagent_containers/RG = O
		if(RG.is_refillable())
			if(!RG.reagents.holder_full())
				RG.reagents.add_reagent(dispensedreagent, min(RG.volume - RG.reagents.total_volume, RG.amount_per_transfer_from_this))
				to_chat(user, span_notice("Você enche.[RG]De[src]."))
				return TRUE
			to_chat(user, span_notice("\The [RG]Está cheio."))
			return FALSE
	if(O.tool_behaviour == TOOL_WELDER)
		if(!reagents.has_reagent(/datum/reagent/fuel))
			to_chat(user, span_warning("[src]Está sem combustível!"))
			return
		var/obj/item/weldingtool/W = O
		if(istype(W) && !W.welding)
			if(W.reagents.has_reagent(/datum/reagent/fuel, W.max_fuel))
				to_chat(user, span_warning("Sua[W.name]Já está cheio!"))
				return
			reagents.trans_to(W, W.max_fuel, transferred_by = user)
			user.visible_message(span_notice("[user]Recheios[user.p_their()] [W.name]."), span_notice("Você enche.[W]."))
			playsound(src, 'sound/effects/refill.ogg', 50, TRUE)
			W.update_appearance()
		return
	else
		return ..()
