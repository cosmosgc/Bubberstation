//Necropolis Tendrils, which spawn lavaland monsters and break into a chasm when killed
/obj/structure/spawner/lavaland
	name = "necropolis tendril"
	desc = "Um vil tendil de corrupção, originando-se no subsolo. Monstros terríveis estão saindo disso."

	icon = 'icons/mob/simple/lavaland/nest.dmi'
	icon_state = "tendril"

	faction = list(FACTION_MINING, FACTION_ASHWALKER)
	max_mobs = 3
	max_integrity = 250
	mob_types = list(/mob/living/basic/mining/watcher)

	move_resist=INFINITY // just killing it tears a massive hole in the ground, let's not move it
	anchored = TRUE
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	var/obj/effect/light_emitter/tendril/emitted_light
	scanner_taggable = TRUE
	mob_gps_id = "WT"
	spawner_gps_id = "Necropolis Tendril"

/obj/structure/spawner/lavaland/goliath
	mob_types = list(/mob/living/basic/mining/goliath)
	mob_gps_id = "GL"

/obj/structure/spawner/lavaland/legion
	mob_types = list(/mob/living/basic/mining/legion/spawner_made)
	mob_gps_id = "LG"

/obj/structure/spawner/lavaland/icewatcher
	mob_types = list(/mob/living/basic/mining/watcher/icewing)
	mob_gps_id = "WT|I" // icewing

GLOBAL_LIST_INIT(tendrils, list())
/obj/structure/spawner/lavaland/Initialize(mapload)
	. = ..()
	emitted_light = new(loc)
	for(var/F in RANGE_TURFS(1, src))
		if(ismineralturf(F))
			var/turf/closed/mineral/M = F
			M.ScrapeAway(null, CHANGETURF_IGNORE_AIR)
	AddComponent(/datum/component/gps, "Eerie Signal")
	GLOB.tendrils += src

/obj/structure/spawner/lavaland/atom_deconstruct(disassembled)
	new /obj/effect/collapse(loc)

/obj/structure/spawner/lavaland/examine(mob/user)
	var/list/examine_messages = ..()
	examine_messages += span_notice("Uma vez que isso dói o suficiente, isso desencadeia uma retaliação final violenta.")
	examine_messages += span_notice("Você só terá alguns minutos para correr para cima, pegar algum saque com uma mão aberta, e sair com ele.")
	return examine_messages

/obj/structure/spawner/lavaland/Destroy()
	var/last_tendril = TRUE
	if(GLOB.tendrils.len>1)
		last_tendril = FALSE

	if(last_tendril && !(flags_1 & ADMIN_SPAWNED_1))
		if(SSachievements.achievements_enabled)
			for(var/mob/living/L in view(7,src))
				if(L.stat || !L.client)
					continue
				L.client.give_award(/datum/award/achievement/boss/tendril_exterminator, L)
				L.client.give_award(/datum/award/score/tendril_score, L) //Progresses score by one
	GLOB.tendrils -= src
	QDEL_NULL(emitted_light)
	return ..()

/obj/effect/light_emitter/tendril
	set_luminosity = 4
	set_cap = 2.5
	light_color = LIGHT_COLOR_LAVA

/obj/effect/collapse
	name = "collapsing necropolis tendril"
	desc = "Pegem seu dinheiro e saiam!"
	layer = TABLE_LAYER
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	icon_state = "tendril"
	anchored = TRUE
	density = TRUE
	/// weakref list of which mobs have gotten their loot from this effect.
	var/list/collected = list()
	/// a bit of light as to make less unfair deaths from the chasm
	var/obj/effect/light_emitter/tendril/emitted_light

/obj/effect/collapse/Initialize(mapload)
	. = ..()
	emitted_light = new(loc)
	visible_message(span_bolddanger("Os tentáculos se contorcem em fúria enquanto a terra ao redor começa a rachar e quebrar! Para trás!"))
	balloon_alert_to_viewers("interact to grab loot before collapse!", vision_distance = 7)
	playsound(loc,'sound/effects/tendril_destroyed.ogg', 200, FALSE, 50, TRUE, TRUE)
	addtimer(CALLBACK(src, PROC_REF(collapse)), 5 SECONDS)

/obj/effect/collapse/examine(mob/user)
	var/list/examine_messages = ..()
	if(isliving(user))
		if(has_collected(user))
			examine_messages += span_boldnotice("Você pegou o que podia, agora saia!")
		else
			examine_messages += span_boldnotice("Você pode ter algum tempo para pegar algumas guloseimas com uma mão aberta antes que ela caia!")
	return examine_messages

/obj/effect/collapse/attack_hand(mob/living/collector, list/modifiers)
	. = ..()
	if(has_collected(collector))
		to_chat(collector, span_danger("Você já conseguiu algum saque, saia daí com isso!"))
		return
	visible_message(span_warning("Algo cai livre do tentáculo!"))
	var/obj/structure/closet/crate/necropolis/tendril/loot = new /obj/structure/closet/crate/necropolis/tendril(loc)
	collector.start_pulling(loot)
	collected += WEAKREF(collector)

/obj/effect/collapse/Destroy()
	collected.Cut()
	QDEL_NULL(emitted_light)
	return ..()

///Helper proc that resolves weakrefs to determine if collector is in collected list, returning a boolean.
/obj/effect/collapse/proc/has_collected(mob/collector)
	for(var/datum/weakref/weakref as anything in collected)
		var/mob/living/resolved = weakref.resolve()
		//it could have been collector, it could not have been, we don't care
		if(!resolved)
			continue
		if(resolved == collector)
			return TRUE
	return FALSE

/obj/effect/collapse/proc/collapse()
	for(var/mob/M in range(7,src))
		shake_camera(M, 15, 1)
	playsound(get_turf(src),'sound/effects/explosion/explosionfar.ogg', 200, TRUE)
	visible_message(span_bolddanger("O tentáculo cai para dentro, o chão ao seu redor se expandindo em um abismo bocejante!"))
	for(var/turf/T in RANGE_TURFS(2,src))
		if(HAS_TRAIT(T, TRAIT_NO_TERRAFORM))
			continue
		if(!T.density)
			T.TerraformTurf(/turf/open/chasm/lavaland, /turf/open/chasm/lavaland, flags = CHANGETURF_INHERIT_AIR)
	qdel(src)
