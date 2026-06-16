/*
Burning extracts:
	Have a unique, primarily offensive effect when
	filled with 10u plasma and activated in-hand.
*/
/obj/item/slimecross/burning
	name = "burning extract"
	desc = "Está fervendo com energia mal contida."
	effect = "burning"
	icon_state = "burning"

/obj/item/slimecross/burning/Initialize(mapload)
	. = ..()
	create_reagents(10, INJECTABLE | DRAWABLE)

/obj/item/slimecross/burning/attack_self(mob/user)
	if(!reagents.has_reagent(/datum/reagent/toxin/plasma, 10))
		to_chat(user, span_warning("Este extrato precisa estar cheio de plasma para ativar!"))
		return
	reagents.remove_reagent(/datum/reagent/toxin/plasma, 10)
	to_chat(user, span_notice("Você aperta o extrato, e ele absorve o plasma!"))
	playsound(src, 'sound/effects/bubbles/bubbles.ogg', 50, TRUE)
	playsound(src, 'sound/effects/magic/fireball.ogg', 50, TRUE)
	do_effect(user)

/obj/item/slimecross/burning/proc/do_effect(mob/user) //If, for whatever reason, you don't want to delete the extract, don't do ..()
	qdel(src)
	return

/obj/item/slimecross/burning/grey
	colour = SLIME_TYPE_GREY
	effect_desc = "Cria um lodo faminto e rápido que te amará para sempre."

/obj/item/slimecross/burning/grey/do_effect(mob/user)
	var/mob/living/basic/slime/new_slime = new(get_turf(user),/datum/slime_type/grey)
	new_slime.visible_message(span_danger("Um bebê gosma emerge de [src], e ele amassa [user] Antes de arrotar com fome!"))
	new_slime.befriend(user) //Gas, gas, gas
	new_slime.bodytemperature = T0C + 400 //We gonna step on the gas.
	new_slime.set_nutrition(SLIME_HUNGER_NUTRITION) //Tonight, we fight!
	..()

/obj/item/slimecross/burning/orange
	colour = SLIME_TYPE_ORANGE
	effect_desc = "Expulsa spray de pimenta em um raio quando ativado."

/obj/item/slimecross/burning/orange/do_effect(mob/user)
	user.visible_message(span_danger("[src] ferve com um gás cáustico!"))
	do_chem_smoke(7, user, get_turf(user), /datum/reagent/consumable/condensedcapsaicin, 100, log = TRUE)
	..()

/obj/item/slimecross/burning/purple
	colour = SLIME_TYPE_PURPLE
	effect_desc = "Cria gel revigorante, tem propriedades curativas e faz você se sentir bem."

/obj/item/slimecross/burning/purple/do_effect(mob/user)
	user.visible_message(span_notice("[src] Enche com um líquido borbulhante!"))
	new /obj/item/slimecrossbeaker/autoinjector/slimestimulant(get_turf(user))
	..()

/obj/item/slimecross/burning/blue
	colour = SLIME_TYPE_BLUE
	effect_desc = "Congela o chão ao seu redor e arrepia as pessoas próximas."

/obj/item/slimecross/burning/blue/do_effect(mob/user)
	user.visible_message(span_danger("[src] O flash congela a área!"))
	for(var/turf/open/T in range(3, get_turf(user)))
		T.MakeSlippery(TURF_WET_PERMAFROST, min_wet_time = 10, wet_time_to_add = 5)
	for(var/mob/living/carbon/M in range(5, get_turf(user)))
		if(M != user)
			M.bodytemperature = BODYTEMP_COLD_DAMAGE_LIMIT + 10 //Not quite cold enough to hurt.
			to_chat(M, span_danger("Você sente um frio escorrendo pela espinha, e o chão parece um pouco escorregadio com geada..."))
	..()

/obj/item/slimecross/burning/metal
	colour = SLIME_TYPE_METAL
	effect_desc = "Destrui instantaneamente paredes ao seu redor."

/obj/item/slimecross/burning/metal/do_effect(mob/user)
	for(var/turf/closed/wall/W in range(1,get_turf(user)))
		W.dismantle_wall(1)
		playsound(W, 'sound/effects/break_stone.ogg', 50, TRUE)
	user.visible_message(span_danger("[src] pulsa violentamente, e quebra as paredes ao redor!"))
	..()

/obj/item/slimecross/burning/yellow
	colour = SLIME_TYPE_YELLOW
	effect_desc = "Eletrocuta pessoas perto de você."

/obj/item/slimecross/burning/yellow/do_effect(mob/user)
	user.visible_message(span_danger("[src] explode em um campo elétrico!"))
	playsound(get_turf(src), 'sound/items/weapons/zapbang.ogg', 50, TRUE)
	for(var/mob/living/M in range(4,get_turf(user)))
		if(M != user)
			var/mob/living/carbon/C = M
			if(istype(C))
				C.electrocute_act(25,src)
			else
				M.adjust_fire_loss(25)
			to_chat(M, span_danger("Você sente um pulso elétrico afiado!"))
	..()

/obj/item/slimecross/burning/darkpurple
	colour = SLIME_TYPE_DARK_PURPLE
	effect_desc = "Cria uma nuvem de plasma."

/obj/item/slimecross/burning/darkpurple/do_effect(mob/user)
	user.visible_message(span_danger("[src] Sublima em uma nuvem de plasma!"))
	var/turf/T = get_turf(user)
	T.atmos_spawn_air("[GAS_PLASMA]=60")
	return ..()

/obj/item/slimecross/burning/darkblue
	colour = SLIME_TYPE_DARK_BLUE
	effect_desc = "Expulsa uma explosão de fumaça gelada enquanto enche você de geleia regenerativa."

/obj/item/slimecross/burning/darkblue/do_effect(mob/user)
	user.visible_message(span_danger("[src] Libera uma explosão de fumaça fria!"))
	user.reagents.add_reagent(/datum/reagent/medicine/regen_jelly, 10)
	do_chem_smoke(7, user, get_turf(user), /datum/reagent/consumable/frostoil, 40, log = TRUE)
	..()

/obj/item/slimecross/burning/silver
	colour = SLIME_TYPE_SILVER
	effect_desc = "Cria alguns pedaços de geléia."

/obj/item/slimecross/burning/silver/do_effect(mob/user)
	var/amount = rand(3,6)
	var/list/turfs = list()
	for(var/turf/open/T in range(1,get_turf(user)))
		turfs += T
	for(var/i in 1 to amount)
		var/path = get_random_food()
		var/obj/item/food/food = new path(pick(turfs))
		food.reagents.add_reagent(/datum/reagent/toxin/slimejelly,5) //Oh god it burns
		ADD_TRAIT(food, TRAIT_FOOD_SILVER, INNATE_TRAIT)
		if(prob(50))
			food.desc += " It smells strange..."
	user.visible_message(span_danger("[src] produz alguns pedaços de comida!"))
	..()

/obj/item/slimecross/burning/bluespace
	colour = SLIME_TYPE_BLUESPACE
	effect_desc = "Teletransporta qualquer um ao seu lado."

/obj/item/slimecross/burning/bluespace/do_effect(mob/user)
	user.visible_message(span_danger("[src] faíscas, e solta uma onda de choque de energia do espaço azul!"))
	for(var/mob/living/L in range(1, get_turf(user)))
		if(L != user)
			do_teleport(L, get_turf(L), 6, asoundin = 'sound/effects/phasein.ogg', channel = TELEPORT_CHANNEL_BLUESPACE) //Somewhere between the effectiveness of fake and real BS crystal
			new /obj/effect/particle_effect/sparks(get_turf(L))
			playsound(get_turf(L), SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	..()

/obj/item/slimecross/burning/sepia
	colour = SLIME_TYPE_SEPIA
	effect_desc = "Torna-se uma câmera especial que rebobina o tempo quando usado."

/obj/item/slimecross/burning/sepia/do_effect(mob/user)
	user.visible_message(span_notice("[src] Forma-se em uma câmera!"))
	new /obj/item/camera/rewind(get_turf(user))
	..()

/obj/item/slimecross/burning/cerulean
	colour = SLIME_TYPE_CERULEAN
	effect_desc = "Produz uma poção de clonagem de extrato, que copia um extrato, bem como seus usos extras."

/obj/item/slimecross/burning/cerulean/do_effect(mob/user)
	user.visible_message(span_notice("[src] produz uma poção!"))
	new /obj/item/slimepotion/extract_cloner(get_turf(user))
	..()

/obj/item/slimecross/burning/pyrite
	colour = SLIME_TYPE_PYRITE
	effect_desc = "Destrui todas as luzes na sala atual."

/obj/item/slimecross/burning/pyrite/do_effect(mob/user)
	var/area/user_area = get_area(user)
	if(isnull(user_area.apc))
		user.visible_message(span_danger("[src] libera uma onda colorida de energia, mas nada parece acontecer."))
		return

	user_area.apc.break_lights()
	user.visible_message(span_danger("[src] libera uma onda colorida de energia, que quebra as luzes!"))
	..()

/obj/item/slimecross/burning/red
	colour = SLIME_TYPE_RED
	effect_desc = "Ficam raivosos e atacam seus amigos."

/obj/item/slimecross/burning/red/do_effect(mob/user)
	user.visible_message(span_danger("[src] pulsa uma aura vermelha nebulosa por um momento, que envolve [user]!"))
	for(var/mob/living/basic/slime/slime_in_view in view(7, get_turf(user)))
		var/list/mob/living/friends = slime_in_view.ai_controller?.blackboard[BB_FRIENDS_LIST] - user
		for(var/list/mob/living/ex_friend in friends)
			slime_in_view.unfriend(ex_friend)
		slime_in_view.set_enraged_behaviour()
		slime_in_view.visible_message(span_danger("O [slime_in_view] é levado a um frenesi perigoso!"))
	..()

/obj/item/slimecross/burning/green
	colour = SLIME_TYPE_GREEN
	effect_desc = "O usuário tem uma lâmina de braço maçante na mão onde é usado."

/obj/item/slimecross/burning/green/do_effect(mob/user)
	var/mob/living/L = user
	if(!istype(user))
		return
	var/obj/item/held = L.get_active_held_item() //This should be itself, but just in case...
	L.dropItemToGround(held)
	var/obj/item/melee/arm_blade/slime/blade = new(user)
	if(!L.put_in_hands(blade))
		qdel(blade)
		user.visible_message(span_warning("[src] Derrete sobre [user] O braço, fervendo a carne horrivelmente!"))
	else
		user.visible_message(span_danger("[src] Sublima a carne ao redor [user] O braço, transformando o osso em uma lâmina horrível!"))
	user.emote("scream")
	L.apply_damage(30, BURN, L.get_active_hand())
	..()

/obj/item/slimecross/burning/pink
	colour = SLIME_TYPE_PINK
	effect_desc = "Cria um copo de Synthpax."

/obj/item/slimecross/burning/pink/do_effect(mob/user)
	user.visible_message(span_notice("[src] encolhe em uma pequena, gel-cheia pastilha!"))
	new /obj/item/slimecrossbeaker/pax(get_turf(user))
	..()

/obj/item/slimecross/burning/gold
	colour = SLIME_TYPE_GOLD
	effect_desc = "Cria um esquadrão de monstros amigáveis ao usuário."

/obj/item/slimecross/burning/gold/do_effect(mob/user)
	user.visible_message(span_danger("[src] Estremece violentamente, e convoca um exército para [user]!"))
	for(var/i in 1 to 3) //Less than gold normally does, since it's safer and faster.
		var/mob/living/spawned_mob = create_random_mob(get_turf(user), HOSTILE_SPAWN)
		spawned_mob.add_ally(user)
		if(prob(50))
			for(var/j in 1 to rand(1, 3))
				step(spawned_mob, pick(NORTH,SOUTH,EAST,WEST))
	..()

/obj/item/slimecross/burning/oil
	colour = SLIME_TYPE_OIL
	effect_desc = "Cria uma explosão após alguns segundos."

/obj/item/slimecross/burning/oil/do_effect(mob/user)
	user.visible_message(span_warning("[user] Ativa [src] Vai explodir!"), span_danger("Você ativa.[src] Ele estala em antecipação"))
	addtimer(CALLBACK(src, PROC_REF(boom)), 5 SECONDS)

/// Inflicts a blastwave upon every mob within a small radius.
/obj/item/slimecross/burning/oil/proc/boom()
	var/turf/T = get_turf(src)
	playsound(T, 'sound/effects/explosion/explosion2.ogg', 200, TRUE)
	for(var/mob/living/target in range(2, T))
		new /obj/effect/temp_visual/explosion(get_turf(target))
		SSexplosions.med_mov_atom += target
	qdel(src)

/obj/item/slimecross/burning/black
	colour = SLIME_TYPE_BLACK
	effect_desc = "Transforma o usuário em um lodo. Eles podem se transformar à vontade e não perder nenhum item."

/obj/item/slimecross/burning/black/do_effect(mob/user)
	if(!isliving(user))
		return
	user.visible_message(span_danger("[src] absorve [user], transformando [user.p_them()] Em uma lama!"))
	var/datum/action/cooldown/spell/shapeshift/slime_form/transform = new(user.mind || user)
	transform.remove_on_restore = TRUE
	transform.Grant(user)
	transform.Activate(user)
	return ..()

/obj/item/slimecross/burning/lightpink
	colour = SLIME_TYPE_LIGHT_PINK
	effect_desc = "Paxes todos à vista."

/obj/item/slimecross/burning/lightpink/do_effect(mob/user)
	user.visible_message(span_danger("[src] Deixa um brilho rosa hipnotizante!"))
	for(var/mob/living/carbon/C in view(7, get_turf(user)))
		C.reagents.add_reagent(/datum/reagent/pax,5)
	..()

/obj/item/slimecross/burning/adamantine
	colour = SLIME_TYPE_ADAMANTINE
	effect_desc = "Cria um poderoso escudo adamantino."

/obj/item/slimecross/burning/adamantine/do_effect(mob/user)
	user.visible_message(span_notice("[src] cristaliza-se em um grande escudo!"))
	new /obj/item/shield/adamantineshield(get_turf(user))
	..()

/obj/item/slimecross/burning/rainbow
	colour = SLIME_TYPE_RAINBOW
	effect_desc = "Cria a faca Rainbow, uma faca de cozinha que causa danos aleatórios."

/obj/item/slimecross/burning/rainbow/do_effect(mob/user)
	user.visible_message(span_notice("[src] Se achata em uma brilhante lâmina arco-íris."))
	new /obj/item/knife/rainbowknife(get_turf(user))
	..()
