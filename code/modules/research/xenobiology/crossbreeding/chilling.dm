/*
Chilling extracts:
	Have a unique, primarily defensive effect when
	filled with 10u plasma and activated in-hand.
*/
/obj/item/slimecross/chilling
	name = "chilling extract"
	desc = "Está frio ao toque, como se estivesse congelado."
	effect = "chilling"
	icon_state = "chilling"

/obj/item/slimecross/chilling/Initialize(mapload)
	. = ..()
	create_reagents(10, INJECTABLE | DRAWABLE)

/obj/item/slimecross/chilling/attack_self(mob/user)
	if(!reagents.has_reagent(/datum/reagent/toxin/plasma, 10))
		to_chat(user, span_warning("Este extrato precisa estar cheio de plasma para ativar!"))
		return
	reagents.remove_reagent(/datum/reagent/toxin/plasma, 10)
	to_chat(user, span_notice("Você aperta o extrato, e ele absorve o plasma!"))
	playsound(src, 'sound/effects/bubbles/bubbles.ogg', 50, TRUE)
	playsound(src, 'sound/effects/glass/glassbr1.ogg', 50, TRUE)
	do_effect(user)

/obj/item/slimecross/chilling/proc/do_effect(mob/user) //If, for whatever reason, you don't want to delete the extract, don't do ..()
	qdel(src)
	return

/obj/item/slimecross/chilling/grey
	colour = SLIME_TYPE_GREY
	effect_desc = "Cria alguns cubos de barreira de lodo. Quando usados, criam barricadas viscosas."

/obj/item/slimecross/chilling/grey/do_effect(mob/user)
	user.visible_message(span_notice("[src] produz alguns pequenos cubos de cinza"))
	for(var/i in 1 to 3)
		new /obj/item/barriercube(get_turf(user))
	..()

/obj/item/slimecross/chilling/orange
	colour = SLIME_TYPE_ORANGE
	effect_desc = "Cria um anel de fogo um azulejo longe do usuário."

/obj/item/slimecross/chilling/orange/do_effect(mob/user)
	user.visible_message(span_danger("[src] Estilhaça, e solta um jato de calor!"))
	for(var/turf/T in orange(get_turf(user),2))
		if(get_dist(get_turf(user), T) > 1)
			new /obj/effect/hotspot(T)
	..()

/obj/item/slimecross/chilling/purple
	colour = SLIME_TYPE_PURPLE
	effect_desc = "Injeta geleia regenerativa em todos na área."

/obj/item/slimecross/chilling/purple/do_effect(mob/user)
	var/area/user_area = get_area(user)
	if(user_area.outdoors)
		to_chat(user, span_warning("[src] Não pode afetar uma área tão grande."))
		return
	user.visible_message(span_notice("[src] Estilhaços, e uma aura curativa preenche a sala brevemente."))
	for (var/list/zlevel_turfs as anything in user_area.get_zlevel_turf_lists())
		for(var/turf/area_turf as anything in zlevel_turfs)
			for(var/mob/living/carbon/nearby in area_turf)
				nearby.reagents?.add_reagent(/datum/reagent/medicine/regen_jelly,10)
	..()

/obj/item/slimecross/chilling/blue
	colour = SLIME_TYPE_BLUE
	effect_desc = "Cria um respirador, uma máscara sem tanque."

/obj/item/slimecross/chilling/blue/do_effect(mob/user)
	user.visible_message(span_notice("[src] racha, e derrama uma gosma líquida, que se transforma em uma máscara!"))
	new /obj/item/clothing/mask/nobreath(get_turf(user))
	..()

/obj/item/slimecross/chilling/metal
	colour = SLIME_TYPE_METAL
	effect_desc = "Temporariamente cerca o usuário de paredes inquebráveis."

/obj/item/slimecross/chilling/metal/do_effect(mob/user)
	user.visible_message(span_danger("[src] derrete como prata rápida, e cerca [user] Em uma parede!"))
	for(var/turf/T in orange(get_turf(user),1))
		if(get_dist(get_turf(user), T) > 0)
			new /obj/effect/forcefield/slimewall(T)
	..()

/obj/item/slimecross/chilling/yellow
	colour = SLIME_TYPE_YELLOW
	effect_desc = "Recarrega o APC do quarto em 50%."

/obj/item/slimecross/chilling/yellow/do_effect(mob/user)
	var/area/user_area = get_area(user)
	if(isnull(user_area.apc?.cell))
		user.visible_message(span_notice("[src] Estilhaços, mas o ar ao seu redor parece normal."))
		return

	var/obj/machinery/power/apc/area_apc = user_area.apc
	area_apc.cell.charge = min(area_apc.cell.charge + area_apc.cell.maxcharge / 2, area_apc.cell.maxcharge)
	user.visible_message(span_notice("[src] Estilhaços, e o ar de repente se sente carregado por um momento."))
	..()

/obj/item/slimecross/chilling/darkpurple
	colour = SLIME_TYPE_DARK_PURPLE
	effect_desc = "Remove todos os gases de plasma na área."

/obj/item/slimecross/chilling/darkpurple/do_effect(mob/user)
	var/area/A = get_area(get_turf(user))
	if(A.outdoors)
		to_chat(user, span_warning("[src] Não pode afetar uma área tão grande."))
		return
	var/filtered = FALSE
	for(var/turf/open/T in A.get_turfs_from_all_zlevels())
		var/datum/gas_mixture/G = T.air
		if(istype(G))
			G.assert_gas(/datum/gas/plasma)
			G.gases[/datum/gas/plasma][MOLES] = 0
			filtered = TRUE
			G.garbage_collect()
			T.air_update_turf(FALSE, FALSE)
	if(filtered)
		user.visible_message(span_notice("Rachaduras espalhadas por toda parte [src] E um pouco de ar é sugado!"))
	else
		user.visible_message(span_notice("[src] Quebras, mas nada acontece."))
	..()

/obj/item/slimecross/chilling/darkblue
	colour = SLIME_TYPE_DARK_BLUE
	effect_desc = "Sela o usuário em um bloco de gelo protetor."

/obj/item/slimecross/chilling/darkblue/do_effect(mob/user)
	if(isliving(user))
		user.visible_message(span_notice("[src] congela sobre [user] O corpo inteiro!"))
		var/mob/living/M = user
		M.apply_status_effect(/datum/status_effect/frozenstasis)
	..()

/obj/item/slimecross/chilling/silver
	colour = SLIME_TYPE_SILVER
	effect_desc = "Cria vários pacotes de ração."

/obj/item/slimecross/chilling/silver/do_effect(mob/user)
	user.visible_message(span_notice("[src] Se desfaz em pó gelado, deixando para trás vários suprimentos de comida de emergência!"))
	var/amount = rand(5, 10)
	for(var/i in 1 to amount)
		new /obj/item/food/rationpack(get_turf(user))
	..()

/obj/item/slimecross/chilling/bluespace
	colour = SLIME_TYPE_BLUESPACE
	effect_desc = "Tocar as pessoas com esse extrato as adiciona a uma lista, quando é ativada teletransporta todos nessa lista para o usuário."
	var/list/slimepals = list()
	var/active = FALSE

/obj/item/slimecross/chilling/bluespace/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with) || active)
		return NONE
	user.do_attack_animation(interacting_with)
	if(HAS_TRAIT(interacting_with, TRAIT_NO_TELEPORT))
		to_chat(user, span_warning("[interacting_with] resiste a estar ligado com [src]!"))
		return ITEM_INTERACT_BLOCKING
	if(interacting_with in slimepals)
		slimepals -= interacting_with
		to_chat(user, span_notice("Você desvincular [src] com [interacting_with]."))
	else
		slimepals += interacting_with
		to_chat(user, span_notice("Você liga.[src] com [interacting_with]."))
	return ITEM_INTERACT_SUCCESS

/obj/item/slimecross/chilling/bluespace/do_effect(mob/user)
	if(slimepals.len <= 0)
		to_chat(user, span_warning("[src] Não está ligado a ninguém!"))
		return
	to_chat(user, span_notice("Você sente [src] Pulso quando começa a carregar energias do espaço azul..."))
	active = TRUE
	for(var/mob/living/M in slimepals)
		var/datum/status_effect/slimerecall/S = M.apply_status_effect(/datum/status_effect/slimerecall)
		S.target = user
	if(do_after(user, 10 SECONDS, target=src))
		to_chat(user, span_notice("[src] Estilhaça enquanto faz um buraco na realidade, arrebatando os indivíduos ligados do vazio!"))
		for(var/mob/living/M in slimepals)
			var/datum/status_effect/slimerecall/S = M.has_status_effect(/datum/status_effect/slimerecall)
			M.remove_status_effect(S)
	else
		to_chat(user, span_warning("[src] Fica escuro, dissolvendo-se em nada enquanto as energias desaparecem."))
		for(var/mob/living/M in slimepals)
			var/datum/status_effect/slimerecall/S = M.has_status_effect(/datum/status_effect/slimerecall)
			if(istype(S))
				S.interrupted = TRUE
				M.remove_status_effect(S)
	..()

/obj/item/slimecross/chilling/sepia
	colour = SLIME_TYPE_SEPIA
	effect_desc = "Tocar em alguém com isso adiciona/tira de uma lista. Ativar o extrato para o tempo por 30 segundos, e todos na lista são imunes, exceto o usuário."
	var/list/slimepals = list()

/obj/item/slimecross/chilling/sepia/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return NONE
	user.do_attack_animation(interacting_with)
	if(interacting_with in slimepals)
		slimepals -= interacting_with
		to_chat(user, span_notice("Você desvincular [src] com [interacting_with]."))
	else
		slimepals += interacting_with
		to_chat(user, span_notice("Você liga.[src] com [interacting_with]."))
	return ITEM_INTERACT_SUCCESS

/obj/item/slimecross/chilling/sepia/do_effect(mob/user)
	user.visible_message(span_warning("[src] Quebras, tempo de congelamento em si!"))
	slimepals -= user //support class
	new /obj/effect/timestop(get_turf(user), 2, 300, slimepals)
	..()

/obj/item/slimecross/chilling/cerulean
	colour = SLIME_TYPE_CERULEAN
	effect_desc = "Cria uma cópia fraca do usuário, que eles controlam."

/obj/item/slimecross/chilling/cerulean/do_effect(mob/user)
	if(isliving(user))
		user.visible_message(span_warning("[src] Range e se transforma em um clone de [user]!"))
		var/mob/living/M = user
		M.apply_status_effect(/datum/status_effect/slime_clone)
	..()

/obj/item/slimecross/chilling/pyrite
	colour = SLIME_TYPE_PYRITE
	effect_desc = "Cria um par de óculos Prism, que permitem que o usuário coloque cristais de luz coloridos."

/obj/item/slimecross/chilling/pyrite/do_effect(mob/user)
	user.visible_message(span_notice("[src] cristaliza em um par de óculos!"))
	new /obj/item/clothing/glasses/prism_glasses(get_turf(user))
	..()

/obj/item/slimecross/chilling/red
	colour = SLIME_TYPE_RED
	effect_desc = "Apazigua cada lodo em sua vacinidade."

/obj/item/slimecross/chilling/red/do_effect(mob/user)
	var/slimesfound = FALSE
	for(var/mob/living/basic/slime/slime_in_view in view(get_turf(user), 7))
		slimesfound = TRUE
		slime_in_view.set_pacified_behaviour()
	if(slimesfound)
		user.visible_message(span_notice("[src] deixa sair um anel de paz enquanto ele quebra, e próximo slimes parecem calmos."))
	else
		user.visible_message(span_notice("[src] deixa sair um anel pacífico enquanto ele quebra, mas nada acontece..."))
	return ..()

/obj/item/slimecross/chilling/green
	colour = SLIME_TYPE_GREEN
	effect_desc = "Cria uma arma de osso na mão usada, que usa sangue como munição."

/obj/item/slimecross/chilling/green/do_effect(mob/user)
	var/mob/living/L = user
	if(!istype(user))
		return
	var/obj/item/held = L.get_active_held_item() //This should be itself, but just in case...
	L.dropItemToGround(held)
	var/obj/item/gun/magic/bloodchill/gun = new(user)
	if(!L.put_in_hands(gun))
		qdel(gun)
		user.visible_message(span_warning("[src] Flash-congela [user] O braço, quebrando a carne horrivelmente!"))
	else
		user.visible_message(span_danger("[src] Arrepios e estalos na frente do osso [user] O braço, deixando para trás uma estranha estrutura de armas!"))
	user.emote("scream")
	L.apply_damage(30, BURN, L.get_active_hand())
	..()

/obj/item/slimecross/chilling/pink
	colour = SLIME_TYPE_PINK
	effect_desc = "Cria um filhote de cachorro."

/obj/item/slimecross/chilling/pink/do_effect(mob/user)
	user.visible_message(span_notice("[src] racha como um ovo, e um filhote de cachorro adorável vem caindo!"))
	new /mob/living/basic/pet/dog/corgi/puppy/slime(get_turf(user))
	..()

/obj/item/slimecross/chilling/gold
	colour = SLIME_TYPE_GOLD
	effect_desc = "Produz um dispositivo de captura dourado."

/obj/item/slimecross/chilling/gold/do_effect(mob/user)
	user.visible_message(span_notice("[src] Sai da luz dourada enquanto derrete e se transforma em um dispositivo semelhante a um ovo!"))
	new /obj/item/capturedevice(get_turf(user))
	..()

/obj/item/slimecross/chilling/oil
	colour = SLIME_TYPE_OIL
	effect_desc = "Cria uma explosão fraca, mas de amplo alcance."

/obj/item/slimecross/chilling/oil/do_effect(mob/user)
	user.visible_message(span_danger("[src] Começa a tremer com intensidade muda!"))
	addtimer(CALLBACK(src, PROC_REF(boom)), 5 SECONDS)

/obj/item/slimecross/chilling/oil/proc/boom()
	explosion(src, devastation_range = -1, heavy_impact_range = -1, light_impact_range = 10, explosion_cause = src) //Large radius, but mostly light damage, and no flash.
	qdel(src)

/obj/item/slimecross/chilling/black
	colour = SLIME_TYPE_BLACK
	effect_desc = "Transforma o usuário em um golem."

/obj/item/slimecross/chilling/black/do_effect(mob/user)
	if(ishuman(user))
		user.visible_message(span_notice("[src] cristaliza junto [user] A pele, transformando-se em pedra sólida!"))
		var/mob/living/carbon/human/H = user
		H.set_species(/datum/species/golem)
	..()

/obj/item/slimecross/chilling/lightpink
	colour = SLIME_TYPE_LIGHT_PINK
	effect_desc = "Cria um Bud Heroína, uma flor especial que pacifica quem usar na cabeça. Eles não poderão tirá-lo sem ajuda."

/obj/item/slimecross/chilling/lightpink/do_effect(mob/user)
	user.visible_message(span_notice("[src] Floresce em uma linda flor!"))
	new /obj/item/clothing/head/peaceflower(get_turf(user))
	..()

/obj/item/slimecross/chilling/adamantine
	colour = SLIME_TYPE_ADAMANTINE
	effect_desc = "Solidifica-se em uma armadura adamantina."

/obj/item/slimecross/chilling/adamantine/do_effect(mob/user)
	user.visible_message(span_notice("[src] Range e quebra quando se transforma em um pesado conjunto de armaduras!"))
	new /obj/item/clothing/suit/armor/heavy/adamantine(get_turf(user))
	..()

/obj/item/slimecross/chilling/rainbow
	colour = SLIME_TYPE_RAINBOW
	effect_desc = "Faz uma parede intransponível em todas as portas da área."

/obj/item/slimecross/chilling/rainbow/do_effect(mob/user)
	var/area/area = get_area(user)
	if(area.outdoors)
		to_chat(user, span_warning("[src] Não pode afetar uma área tão grande."))
		return
	user.visible_message(span_warning("[src] reflete uma variedade de cores deslumbrantes e luz, energia correndo para as portas próximas!"))
	for (var/list/zlevel_turfs as anything in area.get_zlevel_turf_lists())
		for(var/turf/area_turf as anything in zlevel_turfs)
			for(var/obj/machinery/door/airlock/door in area_turf)
				new /obj/effect/forcefield/slimewall/rainbow(door.loc)
	return ..()
