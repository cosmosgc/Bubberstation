/obj/effect/mob_spawn/ghost_role/borer_egg
	name = "borer egg"
	desc = "Um ovo de criatura que se sabe rastejar dentro de você, tenha cuidado."
	icon = 'modular_skyrat/modules/cortical_borer/icons/animal.dmi'
	icon_state = "brainegg"
	layer = BELOW_MOB_LAYER
	density = FALSE
	mob_name = "cortical borer"
	///Type of mob that will be spawned
	mob_type = /mob/living/basic/cortical_borer
	role_ban = ROLE_ALIEN
	show_flavor = FALSE
	prompt_name = "Buraco cortical"
	you_are_text = "Você é um Cortical Borer."
	flavour_text = "Você é um furo cortical! Você pode temer alguém para fazê-los parar de se mover, mas certifique-se de habitá-los!\
Você só cresce/cura/fala quando dentro de um hospedeiro!"
	important_text = "Como um chato, você tem a opção de ser amigável ou não.\
Note que como você age determinará como um hospedeiro responde.\
Não recorra sem palavras à mecânica dentro de um hospedeiro.\
Você pode falar com outros furadores usando; e seu anfitrião apenas falando normalmente.\
Você é incapaz de falar fora de um hospedeiro, mas é capaz de emocionar."
	///what the generation of the borer egg is
	var/generation = 1
	///the egg that is attached to this mob spawn
	var/obj/item/borer_egg/host_egg = /obj/item/borer_egg

/obj/effect/mob_spawn/ghost_role/borer_egg/Destroy()
	host_egg = null
	return ..()

/obj/effect/mob_spawn/ghost_role/borer_egg/special(mob/living/spawned_mob, mob/mob_possessor)
	. = ..()
	spawned_mob.mind.add_antag_datum(/datum/antagonist/cortical_borer)
	spawned_mob.name = "cortical borer ([generation]-[rand(100,999)])"
	QDEL_NULL(host_egg)

/obj/effect/mob_spawn/ghost_role/borer_egg/Initialize(mapload, datum/team/cortical_borers/borer_team)
	. = ..()
	host_egg = new host_egg(get_turf(src))
	host_egg.host_spawner = src
	forceMove(host_egg)
	var/area/src_area = get_area(src)
	if(src_area)
		notify_ghosts("A cortical borer egg has been laid in \the [src_area.name].",
			source = src,
			notify_flags = NOTIFY_CATEGORY_NOFLASH & ~GHOST_NOTIFY_NOTIFY_SUICIDERS,
			click_interact = TRUE,
			ignore_key = POLL_IGNORE_DRONE,
		)

/obj/item/borer_egg
	name = "borer egg"
	desc = "Um ovo de criatura que se sabe rastejar dentro de você, tenha cuidado."
	icon = 'modular_skyrat/modules/cortical_borer/icons/animal.dmi'
	icon_state = "brainegg"
	layer = BELOW_MOB_LAYER
	///the spawner that is attached to this item
	var/obj/effect/mob_spawn/ghost_role/borer_egg/host_spawner

/obj/item/borer_egg/attack_ghost(mob/user)
	if(host_spawner)
		host_spawner.attack_ghost(user)
	return ..()

/obj/item/borer_egg/attack_self(mob/user, modifiers)
	to_chat(user, span_notice("You crush [src] within your grasp."))
	new /obj/effect/decal/cleanable/food/egg_smudge(get_turf(user))
	if(host_spawner)
		QDEL_NULL(host_spawner)
	qdel(src)

/obj/item/borer_egg/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if (..()) // was it caught by a mob?
		return

	var/turf/hit_turf = get_turf(hit_atom)
	new /obj/effect/decal/cleanable/food/egg_smudge(hit_turf)
	QDEL_NULL(host_spawner)
	qdel(src)

/obj/item/borer_egg/empowered
	name = "empowered borer egg"
	icon_state = "empowered_brainegg"

/obj/effect/mob_spawn/ghost_role/borer_egg/traitor
	prompt_name = "Borracha cortical (traidor gerado)"

/obj/effect/mob_spawn/ghost_role/borer_egg/opfor
	prompt_name = "Borracha cortical (OPFOR desovada)"

/obj/effect/mob_spawn/ghost_role/borer_egg/empowered
	name = "empowered borer egg"
	desc = "Um ovo de uma criatura que saiu rastejando de alguém em vez de dentro dela."
	mob_type = /mob/living/basic/cortical_borer/empowered
	host_egg = /obj/item/borer_egg/empowered
