/// Turns the user into a puzzgrid
/datum/smite/puzzgrid
	name = "Puzzgrid"

	var/timer
	var/gib_on_loss

/datum/smite/puzzgrid/configure(client/user)
	var/timer = input(user, "Quanto tempo outras pessoas terão que resolver a grade? 0 dá tempo infinito.", "Puzzgrid", 0) as num | null
	if (isnull(timer))
		return FALSE

	var/gib_on_loss = tgui_alert(user, "O que deve acontecer com eles quando perderem?", "Puzzgrid", list("Gib", "New puzzle")) == "Gib"

	src.gib_on_loss = gib_on_loss
	src.timer = timer == 0 ? null : (timer * 1 SECONDS)

	return TRUE

/datum/smite/puzzgrid/effect(client/user, mob/living/target)
	. = ..()

	var/datum/puzzgrid/puzzgrid = create_random_puzzgrid()
	if (isnull(puzzgrid))
		to_chat(user, span_warning("Não podia criar um enxerido! Talvez a configuração não esteja configurada?"))
		return

	var/obj/structure/puzzgrid_effect/puzzgrid_effect = new(target.loc, target, puzzgrid, timer, gib_on_loss)
	target.forceMove(puzzgrid_effect)
	puzzgrid_effect.visible_message(span_warning("[target]de repente se transformou em um enigma diabólico!"))

	playsound(puzzgrid_effect, 'sound/effects/magic.ogg', 70)

/obj/structure/puzzgrid_effect
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE
	icon = 'icons/effects/effects.dmi'
	icon_state = "shield2"

	var/mob/living/victim
	var/timer
	var/gib_on_loss

/obj/structure/puzzgrid_effect/Initialize(mapload, mob/living/victim, datum/puzzgrid/puzzgrid, timer, gib_on_loss)
	. = ..()

	if (isnull(victim))
		return

	src.victim = victim
	src.timer = timer
	src.gib_on_loss = gib_on_loss

	name = "[victim]'s fiendish curse"

	victim.add_traits(list(TRAIT_HANDS_BLOCKED, TRAIT_IMMOBILIZED), "[type]")

	add_puzzgrid_component(puzzgrid)

/obj/structure/puzzgrid_effect/Destroy()
	QDEL_NULL(victim)
	return ..()

/obj/structure/puzzgrid_effect/proc/add_puzzgrid_component(datum/puzzgrid/puzzgrid)
	AddComponent( 		/datum/component/puzzgrid, 		puzzgrid = puzzgrid, 		timer = timer, 		on_victory_callback = CALLBACK(src, PROC_REF(on_victory)), 		on_fail_callback = CALLBACK(src, gib_on_loss ? PROC_REF(loss_gib) : PROC_REF(loss_restart)), 	)

/obj/structure/puzzgrid_effect/proc/on_victory()
	victim.forceMove(loc)
	victim.Paralyze(5 SECONDS)
	victim.visible_message(
		span_notice("[victim]está livre de sua maldita prisão!"),
		span_notice("Você está livre de sua maldita prisão!"),
	)

	victim.remove_traits(list(TRAIT_HANDS_BLOCKED, TRAIT_IMMOBILIZED), "[type]")

	victim = null

	qdel(src)

/obj/structure/puzzgrid_effect/proc/loss_gib()
	victim.forceMove(loc)
	victim.visible_message(
		span_bolddanger("Você foi incapaz de libertar[victim]De sua prisão demoníaca, deixando-os como nada mais do que um lamaçal!"),
		span_bolddanger("Seus compatriotas foram incapazes de libertá-lo de sua prisão demoníaca, deixando-o como nada mais do que um golpe de lama!"),
	)
	victim.gib(DROP_ALL_REMAINS)
	victim = null

	qdel(src)

/obj/structure/puzzgrid_effect/proc/loss_restart()
	var/datum/puzzgrid/puzzgrid = create_random_puzzgrid()
	if (isnull(puzzgrid))
		victim.forceMove(loc)
		victim.Paralyze(5 SECONDS)
		victim.visible_message(span_bolddanger("Apesar de falhar completamente no quebra-cabeça, através de sorte inacreditável,[victim]Ele consegue fugir de qualquer maneira!"))
		victim.remove_traits(list(TRAIT_HANDS_BLOCKED, TRAIT_IMMOBILIZED), "[type]")
		qdel(src)
		victim = null
		return

	visible_message(span_danger("O enigma demoníaco se transforma em um quebra-cabeça diferente, igualmente desafiador!"))

	// Defer until after the fail proc finishes, since that will qdel the component.
	addtimer(CALLBACK(src, PROC_REF(add_puzzgrid_component), puzzgrid), 0)
