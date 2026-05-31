/obj/structure/grandfatherclock
	name = "grandfather clock"
	icon = 'modular_skyrat/modules/officestuff/icons/cowboyobh.dmi'
	icon_state = "grandfather_clock"
	desc = "Tic, tic, tic, tic. Ele fica alto e assustador, alto e ameaçador tiquetaque, mas as mãos estão presas perto da meia-noite, quanto mais perto você chegar, mais alto um sussurro fraco torna-se um grito, um apelo, alguma coisa, mas o que quer que seja, ele diz 'Eu sou o Mestre, e você vai me obedecer.'"
	var/datum/looping_sound/grandfatherclock/soundloop

// stolen from the wall clock
/obj/structure/grandfatherclock/examine(mob/user)
	. = ..()
	. += span_info("A hora atual do CST (local) é:[station_time_timestamp()].")
	. += span_info("O tempo atual do TCT (galáctico) é:[time2text(world.realtime, "hh:mm:ss")].")
	if(soundloop)
		. += span_notice("As mãos do relógio estão correndo livremente. Poderiam ser.<b>Está ferrado.</b>Abaixe-se.")
	else
		. += span_notice("As mãos do relógio foram<b>Está ferrado.</b>apertado.")


// . += span_notice("The <b>screws</b> on the clock hands are loose, freely ticking away.")
// door_status" = density ? "closed" : "open",
/datum/looping_sound/grandfatherclock
	mid_sounds = list('modular_skyrat/modules/officestuff/sound/clock_ticking.ogg' = 1)
	mid_length = 12 SECONDS
	volume = 10
	ignore_walls = FALSE

/obj/structure/grandfatherclock/Initialize(mapload)
	. = ..()
	soundloop = new(src, TRUE)

/obj/structure/grandfatherclock/Destroy()
	QDEL_NULL(soundloop)
	return ..()

/obj/structure/grandfatherclock/screwdriver_act(mob/living/user, obj/item/tool)
	if(!soundloop)
		balloon_alert(user, "Desenroscando as mãos...")
		if(do_after(user, 2 SECONDS, src))
			soundloop = new(src, TRUE)
			balloon_alert(user, "Mãos soltas!")
			return ITEM_INTERACT_SUCCESS
		return ..()

	balloon_alert(user, "Transando com as mãos...")
	if(do_after(user, 2 SECONDS, src))
		QDEL_NULL(soundloop)
		balloon_alert(user, "Mãos apertadas!")
		return ITEM_INTERACT_SUCCESS
	return ..()
/obj/structure/sign/painting/meat
	name = "Figure With Meat"
	desc = "Uma pintura de uma figura distorcida, sentada entre uma vaca cortada ao meio."
	icon = 'modular_skyrat/modules/officestuff/icons/cowboyobh.dmi'
	icon_state = "meat"
	sign_change_name = "Painting - Meat"
	is_editable = TRUE

/obj/structure/sign/painting/parting
	name = "Parting Waves"
	desc = "Uma pintura de um mar partido, o sol vermelho lava sobre o oceano azul."
	icon = 'modular_skyrat/modules/officestuff/icons/cowboyobh.dmi'
	icon_state = "jmwt4"
	is_editable = TRUE
	sign_change_name = "Painting - Waves"


/obj/structure/sign/paint
	name = "painting"
	desc = "Você não deveria estar vendo isso."
	icon = 'modular_skyrat/modules/officestuff/icons/cowboyobh.dmi'
	icon_state = "gravestone"


