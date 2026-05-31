
//roles found on away missions, if you can remember to put them here.

//undead that protect a zlevel

/obj/effect/mob_spawn/ghost_role/human/skeleton
	name = "skeletal remains"
	icon = 'icons/effects/blood.dmi'
	icon_state = "remains"
	mob_name = "skeleton"
	prompt_name = "Um guardião esquelético"
	mob_species = /datum/species/skeleton
	you_are_text = "Por poderes desconhecidos, seus restos foram reanimados!"
	flavour_text = "Caminhe neste plano mortal e aterrorizar todos os aventureiros vivos que se atrevem a cruzar seu caminho."
	spawner_job_path = /datum/job/skeleton

/obj/effect/mob_spawn/ghost_role/human/skeleton/special(mob/living/new_spawn, mob/mob_possessor, apply_prefs)
	. = ..()
	to_chat(new_spawn, "<b>Você tem essa sensação horrível de que sua ligação a este mundo falhará se abandonar esta zona... Você foi reanimado para proteger algo?</b>")
	new_spawn.AddComponent(/datum/component/stationstuck, PUNISHMENT_MURDER, "You experience a feeling like a stressed twine being pulled until it snaps. Then, merciful nothing.")

/obj/effect/mob_spawn/ghost_role/human/zombie
	name = "rotting corpse"
	icon = 'icons/effects/blood.dmi'
	icon_state = "remains"
	mob_name = "zombie"
	prompt_name = "Um guardião morto-vivo."
	mob_species = /datum/species/zombie
	spawner_job_path = /datum/job/zombie
	you_are_text = "Por poderes desconhecidos, seus restos foram ressuscitados!"
	flavour_text = "Caminhe neste plano mortal e aterrorizar todos os aventureiros vivos que se atrevem a cruzar seu caminho."

/obj/effect/mob_spawn/ghost_role/human/zombie/special(mob/living/new_spawn, mob/mob_possessor, apply_prefs)
	. = ..()
	to_chat(new_spawn, "<b>Você tem essa sensação horrível de que sua ligação a este mundo falhará se abandonar esta zona... Você foi reanimado para proteger algo?</b>")
	new_spawn.AddComponent(/datum/component/stationstuck, PUNISHMENT_MURDER, "You experience a feeling like a stressed twine being pulled until it snaps. Then, merciful nothing.")
