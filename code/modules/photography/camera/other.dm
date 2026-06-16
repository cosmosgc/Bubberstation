/obj/item/camera/spooky
	name = "camera obscura"
	desc = "Uma câmera polaróide, alguns dizem que pode ver fantasmas!"
	see_ghosts = CAMERA_SEE_GHOSTS_BASIC

/obj/item/camera/spooky/steal_souls(list/victims)
	for(var/mob/living/target in victims)
		if(!(target.mob_biotypes & MOB_SPIRIT))
			continue

		// time to steal your soul
		if(istype(target, /mob/living/basic/revenant))
			var/mob/living/basic/revenant/peek_a_boo = target
			peek_a_boo.apply_status_effect(/datum/status_effect/revenant/revealed, 2 SECONDS) // no hiding
			peek_a_boo.apply_status_effect(/datum/status_effect/incapacitating/paralyzed/revenant, 2 SECONDS)

		target.visible_message(
			span_warning("[target] violentamente hesita!"),
			span_revendanger("Você sente sua essência drenando de ter sua foto tirada!"),
		)
		target.apply_damage(rand(10, 15))

/obj/item/camera/spooky/badmin
	desc = "Uma câmera polaróide, alguns dizem que pode ver fantasmas! Parece ter uma lupa extra no final."
	see_ghosts = CAMERA_SEE_GHOSTS_ORBIT

/obj/item/camera/detective
	name = "detective's camera"
	desc = "Uma câmera polaróide silenciosa com capacidade extra para investigações criminais."
	flash_enabled = FALSE
	silent = TRUE
	pictures_max = 30
	pictures_left = 30

/obj/item/camera/detective/after_picture(mob/user, datum/picture/picture)
	. = ..()
	user.playsound_local(get_turf(src), SFX_POLAROID, 35, TRUE)
