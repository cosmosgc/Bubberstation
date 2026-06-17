/obj/item/etherealballdeployer
	name = "portable ethereal disco ball"
	desc = "Aperte o botão para um envio de uma festa um pouco anti-histórica!"
	icon = 'icons/obj/devices/remote.dmi'
	icon_state = "ethdisco"

/obj/item/etherealballdeployer/attack_self(mob/living/carbon/user)
	.=..()
	to_chat(user, span_notice("Você lança a Ethereal Disco Ball."))
	new /obj/structure/etherealball(user.loc)
	qdel(src)

/obj/structure/etherealball
	name = "ethereal disco ball"
	desc = "A ética desta discoteca é questionável."
	icon = 'icons/obj/machines/floor.dmi'
	icon_state = "ethdisco_head_0"
	anchored = TRUE
	density = TRUE
	var/TurnedOn = FALSE
	var/current_color
	var/TimerID
	var/range = 7
	var/power = 3

/obj/structure/etherealball/Initialize(mapload)
	. = ..()
	update_appearance()
	if(TurnedOn)
		TurnOn()

/obj/structure/etherealball/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(!can_interact(user))
		return

	if(TurnedOn)
		TurnOff()
		to_chat(user, span_notice("Você desliga a bola de discoteca!"))
	else
		TurnOn()
		to_chat(user, span_notice("Você liga a bola de discoteca!"))

/obj/structure/etherealball/click_alt(mob/living/carbon/human/user)
	set_anchored(!anchored)
	to_chat(user, span_notice("You [anchored ? null : "un"]lock the disco ball."))
	return CLICK_ACTION_SUCCESS

/obj/structure/etherealball/proc/TurnOn()
	TurnedOn = TRUE //Same
	DiscoFever()

/obj/structure/etherealball/proc/TurnOff()
	TurnedOn = FALSE
	set_light(0)
	remove_atom_colour(TEMPORARY_COLOUR_PRIORITY)
	update_appearance()
	if(TimerID)
		deltimer(TimerID)

/obj/structure/etherealball/proc/DiscoFever()
	remove_atom_colour(TEMPORARY_COLOUR_PRIORITY)
	current_color = random_color()
	set_light(range, power, "#[current_color]")
	add_atom_colour("#[current_color]", FIXED_COLOUR_PRIORITY)
	update_appearance()
	TimerID = addtimer(CALLBACK(src, PROC_REF(DiscoFever)), 5, TIMER_STOPPABLE)  //Call ourselves every 0.5 seconds to change colors

/obj/structure/etherealball/update_icon_state()
	icon_state = "ethdisco_head_[TurnedOn]"
	return ..()

/obj/structure/etherealball/update_overlays()
	. = ..()
	. += mutable_appearance(icon, "ethdisco_base", appearance_flags = RESET_COLOR|KEEP_APART)
