/obj/item/seeds/banana/spider_banana
	name = "leggy banana seed pack"
	desc = "São sementes que crescem em bananeiras. No entanto, essas bananas podem estar vivas."
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-spibanana"
	species = "spibanana"
	growing_icon = 'modular_skyrat/master_files/icons/obj/hydroponics/growing.dmi'
	icon_grow = "spibanana-grow"
	icon_dead = "spibanana-dead"
	icon_harvest = "spibanana-harvest"
	plantname = "Leggy Banana Tree"
	product = /obj/item/food/grown/banana/banana_spider_spawnable
	genes = list(/datum/plant_gene/trait/slip)

/obj/item/food/grown/banana/banana_spider_spawnable
	name = "banana spider"
	desc = "Você não sabe o que é, mas pode apostar que o palhaço adoraria."
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/harvest.dmi'
	icon_state = "spibanana"
	foodtypes = GORE | MEAT | RAW | FRUIT
	var/awakening = FALSE

/obj/item/food/grown/banana/banana_spider_spawnable/attack_self(mob/user)
	if(awakening || isspaceturf(user.loc))
		return
	to_chat(user, span_notice("Você decide acordar a aranha banana..."))
	awakening = TRUE
	addtimer(CALLBACK(src, PROC_REF(spawnspider)), 8 SECONDS)

/obj/item/food/grown/banana/banana_spider_spawnable/proc/spawnspider()
	if(!QDELETED(src))
		var/mob/living/basic/banana_spider/banana_spider = new(get_turf(loc))
		banana_spider.visible_message(span_notice("A aranha de banana chitters enquanto estica suas pernas"))
		qdel(src)

