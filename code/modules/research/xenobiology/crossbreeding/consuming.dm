/*
Consuming extracts:
	Can eat food items.
	After consuming enough, produces special cookies.
*/
/obj/item/slimecross/consuming
	name = "consuming extract"
	desc = "Está faminto... por...<i>Mais</i>." //My slimecross has finally decided to eat... my buffet!
	icon_state = "consuming"
	effect = "consuming"
	var/nutriment_eaten = 0
	var/nutriment_required = 10
	var/cooldown = 600 //1 minute.
	var/last_produced = 0
	var/cookies = 5 //Number of cookies to spawn
	var/cookietype = /obj/item/slime_cookie

/obj/item/slimecross/consuming/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!IS_EDIBLE(tool))
		return NONE

	if(last_produced + cooldown > world.time)
		to_chat(user, span_warning("[src] Ainda está digerindo após sua última refeição!"))
		return ITEM_INTERACT_BLOCKING

	var/datum/reagent/nutriments = tool.reagents.has_reagent(/datum/reagent/consumable/nutriment)
	if(!nutriments)
		to_chat(user, span_warning("[src] Burbles infelizmente na oferta."))
		return ITEM_INTERACT_BLOCKING

	nutriment_eaten += nutriments.volume
	to_chat(user, span_notice("[src] abre-se e engole [tool] Inteiro!"))
	qdel(tool)
	playsound(src, 'sound/items/eatfood.ogg', 20, TRUE)

	if(nutriment_eaten < nutriment_required)
		return ITEM_INTERACT_SUCCESS

	nutriment_eaten = 0
	user.visible_message(span_notice("[src] Incha e produz uma pequena pilha de biscoitos!"))
	playsound(src, 'sound/effects/splat.ogg', 40, TRUE)
	last_produced = world.time
	for(var/i in 1 to cookies)
		var/obj/item/cookie = spawncookie()
		cookie.pixel_x = base_pixel_x + rand(-5, 5)
		cookie.pixel_y = base_pixel_y + rand(-5, 5)
	return ITEM_INTERACT_SUCCESS

/obj/item/slimecross/consuming/proc/spawncookie()
	return new cookietype(get_turf(src))

/obj/item/slime_cookie //While this technically acts like food, it's so removed from it that I made it its own type.
	name = "error cookie"
	desc = "Um biscoito estranho. Você não deveria ver isso."
	icon = 'icons/obj/food/slimecookies.dmi'
	var/taste = "error"
	var/nutrition = 5
	icon_state = "base"
	force = 0
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	throw_speed = 3
	throw_range = 6

/obj/item/slime_cookie/proc/do_effect(mob/living/M, mob/user)
	return

/obj/item/slime_cookie/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return NONE
	var/mob/living/living_mob = interacting_with
	var/fed = FALSE
	if(living_mob == user)
		living_mob.visible_message(span_notice("[user] come [src]!"), span_notice("Você come.[src]."))
		fed = TRUE
	else
		living_mob.visible_message(span_danger("[user] Tenta forçar [living_mob] Para comer [src]!"), span_userdanger("[user] Tenta forçá-lo a comer [src]!"))
		if(do_after(user, 2 SECONDS, target = living_mob))
			fed = TRUE
			living_mob.visible_message(span_danger("[user] forças [living_mob] Para comer [src]!"), span_warning("[user] te força a comer.[src]."))
	if(fed)
		if(!HAS_TRAIT(living_mob, TRAIT_AGEUSIA))
			to_chat(living_mob, span_notice("Você pode provar.[taste]."))
		playsound(get_turf(living_mob), 'sound/items/eatfood.ogg', 20, TRUE)
		if(nutrition)
			living_mob.reagents.add_reagent(/datum/reagent/consumable/nutriment, nutrition)
		do_effect(living_mob, user)
		qdel(src)
		return ITEM_INTERACT_SUCCESS
	return ITEM_INTERACT_BLOCKING

/obj/item/slimecross/consuming/grey
	colour = SLIME_TYPE_GREY
	effect_desc = "Cria um biscoito de lodo."
	cookietype = /obj/item/slime_cookie/grey

/obj/item/slime_cookie/grey
	name = "slime cookie"
	desc = "Um biscoito cinza transparente. Nutritivo, provavelmente."
	icon_state = "grey"
	taste = "goo"
	nutrition = 15

/obj/item/slimecross/consuming/orange
	colour = SLIME_TYPE_ORANGE
	effect_desc = "Cria um biscoito que aquece o alvo e dá imunidade fria por pouco tempo."
	cookietype = /obj/item/slime_cookie/orange

/obj/item/slime_cookie/orange
	name = "fiery cookie"
	desc = "Um biscoito laranja com um padrão ardente. Está quente."
	icon_state = "orange"
	taste = "cinnamon and burning"

/obj/item/slime_cookie/orange/do_effect(mob/living/M, mob/user)
	M.apply_status_effect(/datum/status_effect/firecookie)

/obj/item/slimecross/consuming/purple
	colour = SLIME_TYPE_PURPLE
	effect_desc = "Cria um biscoito que cura o alvo de todos os danos."
	cookietype = /obj/item/slime_cookie/purple

/obj/item/slime_cookie/purple
	name = "health cookie"
	desc = "Um biscoito roxo com um padrão cruzado. Calmante."
	icon_state = "purple"
	taste = "fruit jam and cough medicine"

/obj/item/slime_cookie/purple/do_effect(mob/living/M, mob/user)
	var/need_mob_update = FALSE
	need_mob_update += M.adjust_brute_loss(-5, updating_health = FALSE)
	need_mob_update += M.adjust_fire_loss(-5, updating_health = FALSE)
	need_mob_update += M.adjust_tox_loss(-5, updating_health = FALSE, forced = TRUE) //To heal slimepeople.
	need_mob_update += M.adjust_oxy_loss(-5, updating_health = FALSE)
	need_mob_update += M.adjust_organ_loss(ORGAN_SLOT_BRAIN, -5)
	if(need_mob_update)
		M.updatehealth()

/obj/item/slimecross/consuming/blue
	colour = SLIME_TYPE_BLUE
	effect_desc = "Cria um biscoito de lodo que molha o chão ao seu redor e o torna imune à água por escorregar por pouco tempo."
	cookietype = /obj/item/slime_cookie/blue

/obj/item/slime_cookie/blue
	name = "water cookie"
	desc = "Um biscoito azul transparente. Constantemente molhando."
	icon_state = "blue"
	taste = "water"

/obj/item/slime_cookie/blue/do_effect(mob/living/M, mob/user)
	M.apply_status_effect(/datum/status_effect/watercookie)

/obj/item/slimecross/consuming/metal
	colour = SLIME_TYPE_METAL
	effect_desc = "Cria um biscoito de lodo que aumenta a resistência do alvo ao dano bruto."
	cookietype = /obj/item/slime_cookie/metal

/obj/item/slime_cookie/metal
	name = "metallic cookie"
	desc = "Um biscoito cinza brilhante. Difícil de tocar."
	icon_state = "metal"
	taste = "copper"

/obj/item/slime_cookie/metal/do_effect(mob/living/M, mob/user)
	M.apply_status_effect(/datum/status_effect/metalcookie)

/obj/item/slimecross/consuming/yellow
	colour = SLIME_TYPE_YELLOW
	effect_desc = "Cria um biscoito de lodo que torna o alvo imune à eletricidade por pouco tempo."
	cookietype = /obj/item/slime_cookie/yellow

/obj/item/slime_cookie/yellow
	name = "sparking cookie"
	desc = "Um biscoito amarelo com um padrão de relâmpago. Tem uma textura de borracha."
	icon_state = "yellow"
	taste = "lemon cake and rubber gloves"

/obj/item/slime_cookie/yellow/do_effect(mob/living/M, mob/user)
	M.apply_status_effect(/datum/status_effect/sparkcookie)

/obj/item/slimecross/consuming/darkpurple
	colour = SLIME_TYPE_DARK_PURPLE
	effect_desc = "Cria um biscoito de lodo que inverte como o corpo do alvo trata toxinas."
	cookietype = /obj/item/slime_cookie/darkpurple

/obj/item/slime_cookie/darkpurple
	name = "toxic cookie"
	desc = "Um biscoito roxo escuro, fedor de plasma."
	icon_state = "darkpurple"
	taste = "slime jelly and toxins"

/obj/item/slime_cookie/darkpurple/do_effect(mob/living/M, mob/user)
	M.apply_status_effect(/datum/status_effect/toxincookie)

/obj/item/slimecross/consuming/darkblue
	colour = SLIME_TYPE_DARK_BLUE
	effect_desc = "Cria um biscoito de lodo que arrepia o alvo e os apaga."
	cookietype = /obj/item/slime_cookie/darkblue

/obj/item/slime_cookie/darkblue
	name = "frosty cookie"
	desc = "Um biscoito azul escuro com um padrão floco de neve. Está frio."
	icon_state = "darkblue"
	taste = "mint and bitter cold"

/obj/item/slime_cookie/darkblue/do_effect(mob/living/M, mob/user)
	M.adjust_bodytemperature(-110)
	M.extinguish_mob()

/obj/item/slimecross/consuming/silver
	colour = SLIME_TYPE_SILVER
	effect_desc = "Cria um biscoito de lodo que nunca engorda o alvo."
	cookietype = /obj/item/slime_cookie/silver

/obj/item/slime_cookie/silver
	name = "waybread cookie"
	desc = "Um biscoito quente, crocante, prata brilhante na luz. Tem um cheiro maravilhoso."
	icon_state = "silver"
	taste = "masterful elven baking"
	nutrition = 0 //We don't want normal nutriment

/obj/item/slime_cookie/silver/do_effect(mob/living/M, mob/user)
	M.reagents.add_reagent(/datum/reagent/consumable/nutriment/stabilized,10)

/obj/item/slimecross/consuming/bluespace
	colour = SLIME_TYPE_BLUESPACE
	effect_desc = "Cria um biscoito de lodo que teleporta o alvo para um lugar aleatório na área."
	cookietype = /obj/item/slime_cookie/bluespace

/obj/item/slime_cookie/bluespace
	name = "space cookie"
	desc = "Um biscoito branco com gelo verde. Surpreendentemente difícil de segurar."
	icon_state = "bluespace"
	taste = "sugar and starlight"

/obj/item/slime_cookie/bluespace/do_effect(mob/living/eater, mob/user)
	var/list/area_turfs = get_area_turfs(get_area(get_turf(eater)))
	var/turf/target

	while (length(area_turfs))
		var/turf/check_turf = pick_n_take(area_turfs)
		if (is_centcom_level(check_turf.z))
			continue // Probably already filtered out by NOTELEPORT but let's just be careful
		if (check_turf.is_blocked_turf())
			continue
		target = check_turf
		break

	if (isnull(target))
		fail_effect(eater)
		return
	if (!do_teleport(eater, target, 0, asoundin = 'sound/effects/phasein.ogg', channel = TELEPORT_CHANNEL_BLUESPACE))
		fail_effect(eater)
		return
	new /obj/effect/particle_effect/sparks(target)
	playsound(target, SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/obj/item/slime_cookie/bluespace/proc/fail_effect(mob/living/eater)
	eater.visible_message(
		message = span_warning("[eater] briefly vanishes... then slams forcefully into the ground"),
		self_message = span_warning("Você desaparece brevemente... e é devolvido com força ao chão.")
	)
	eater.Knockdown(0.1 SECONDS)
	new /obj/effect/particle_effect/sparks(get_turf(eater))

/obj/item/slimecross/consuming/sepia
	colour = SLIME_TYPE_SEPIA
	effect_desc = "Cria um biscoito de lodo que faz o alvo fazer as coisas um pouco mais rápido."
	cookietype = /obj/item/slime_cookie/sepia

/obj/item/slime_cookie/sepia
	name = "time cookie"
	desc = "Um biscoito marrom claro com um padrão de relógio. Leva algum tempo para mastigar."
	icon_state = "sepia"
	taste = "brown sugar and a metronome"

/obj/item/slime_cookie/sepia/do_effect(mob/living/M, mob/user)
	M.apply_status_effect(/datum/status_effect/timecookie)

/obj/item/slimecross/consuming/cerulean
	colour = SLIME_TYPE_CERULEAN
	effect_desc = "Cria um biscoito de lodo que tem a chance de fazer outro depois de comê-lo."
	cookietype = /obj/item/slime_cookie/cerulean
	cookies = 3 //You're gonna get more.

/obj/item/slime_cookie/cerulean
	name = "duplicookie"
	desc = "Um biscoito ceruleano com proporções estranhas. Parece que pode se separar facilmente."
	icon_state = "cerulean"
	taste = "a sugar cookie"

/obj/item/slime_cookie/cerulean/do_effect(mob/living/M, mob/user)
	if(prob(50))
		to_chat(M, span_notice("Um pedaço de [src] Se rompe enquanto mastiga, e cai no chão."))
		var/obj/item/slime_cookie/cerulean/C = new(get_turf(M))
		C.taste = taste + " and a sugar cookie"

/obj/item/slimecross/consuming/pyrite
	colour = SLIME_TYPE_PYRITE
	effect_desc = "Cria um biscoito de lodo que pinta o alvo aleatoriamente."
	cookietype = /obj/item/slime_cookie/pyrite

/obj/item/slime_cookie/pyrite
	name = "color cookie"
	desc = "Um biscoito amarelo com cobertura de cor arco-íris. Reflete estranhamente a luz."
	icon_state = "pyrite"
	taste = "vanilla and " //Randomly selected color dye.
	var/colour = COLOR_WHITE

/obj/item/slime_cookie/pyrite/Initialize(mapload)
	. = ..()
	var/tastemessage = "paint remover"
	switch(rand(1,7))
		if(1)
			tastemessage = "red dye"
			colour = COLOR_RED
		if(2)
			tastemessage = "orange dye"
			colour = "#FFA500"
		if(3)
			tastemessage = "yellow dye"
			colour = COLOR_YELLOW
		if(4)
			tastemessage = "green dye"
			colour = COLOR_VIBRANT_LIME
		if(5)
			tastemessage = "blue dye"
			colour = COLOR_BLUE
		if(6)
			tastemessage = "indigo dye"
			colour = "#4B0082"
		if(7)
			tastemessage = "violet dye"
			colour = COLOR_MAGENTA
	taste += tastemessage

/obj/item/slime_cookie/pyrite/do_effect(mob/living/M, mob/user)
	M.add_atom_colour(colour,WASHABLE_COLOUR_PRIORITY)

/obj/item/slimecross/consuming/red
	colour = SLIME_TYPE_RED
	effect_desc = "Cria um biscoito de lodo que cria um respingo de sangue no chão, enquanto também restaura um pouco do sangue do alvo."
	cookietype = /obj/item/slime_cookie/red

/obj/item/slime_cookie/red
	name = "blood cookie"
	desc = "Um biscoito vermelho, escorrendo um líquido vermelho espesso. Vampiros podem gostar."
	icon_state = "red"
	taste = "red velvet and iron"

/obj/item/slime_cookie/red/do_effect(mob/living/M, mob/user)
	new /obj/effect/decal/cleanable/blood(get_turf(M))
	playsound(get_turf(M), 'sound/effects/splat.ogg', 10, TRUE)
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		C.adjust_blood_volume(25) //Half a vampire drain.

/obj/item/slimecross/consuming/green
	colour = SLIME_TYPE_GREEN
	effect_desc = "Cria um biscoito de lodo que é absolutamente nojento, faz o alvo vomitar, mas todos os reagentes em seu corpo também são removidos."
	cookietype = /obj/item/slime_cookie/green

/obj/item/slime_cookie/green
	name = "gross cookie"
	desc = "Um biscoito verde nojento, cheio de pus. Você se sente mal só de olhar para ele."
	icon_state = "green"
	taste = "the contents of your stomach"

/obj/item/slime_cookie/green/do_effect(mob/living/M, mob/user)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.vomit(VOMIT_CATEGORY_DEFAULT, lost_nutrition = 25)
	M.reagents.remove_all()

/obj/item/slimecross/consuming/pink
	colour = SLIME_TYPE_PINK
	effect_desc = "Cria um biscoito que faz o alvo espalhar o amor."
	cookietype = /obj/item/slime_cookie/pink

/obj/item/slime_cookie/pink
	name = "love cookie"
	desc = "Um biscoito rosa com um coração de gelo. D'aww."
	icon_state = "pink"
	taste = "love and hugs"

/obj/item/slime_cookie/pink/do_effect(mob/living/M, mob/user)
	M.apply_status_effect(/datum/status_effect/lovecookie)

/obj/item/slimecross/consuming/gold
	colour = SLIME_TYPE_GOLD
	effect_desc = "Cria um biscoito com uma moeda de ouro."
	cookietype = /obj/item/slime_cookie/gold

/obj/item/slime_cookie/gold
	name = "gilded cookie"
	desc = "Um biscoito dourado, mais perto de um pão do que qualquer coisa. Que a boa sorte encontre você."
	icon_state = "gold"
	taste = "sweet cornbread and wealth"

/obj/item/slime_cookie/gold/do_effect(mob/living/M, mob/user)
	var/obj/item/held = M.get_active_held_item() //This should be itself, but just in case...
	M.dropItemToGround(held)
	var/newcoin = /obj/item/coin/gold
	var/obj/item/coin/C = new newcoin(get_turf(M))
	playsound(get_turf(C), 'sound/items/coinflip.ogg', 50, TRUE)
	M.put_in_hand(C)

/obj/item/slimecross/consuming/oil
	colour = SLIME_TYPE_OIL
	effect_desc = "Cria um cookie que atrasa qualquer um ao lado do usuário."
	cookietype = /obj/item/slime_cookie/oil

/obj/item/slime_cookie/oil
	name = "tar cookie"
	desc = "Um biscoito preto oleoso, que gruda em suas mãos. Cheira a chocolate."
	icon_state = "oil"
	taste = "rich molten chocolate and tar"

/obj/item/slime_cookie/oil/do_effect(mob/living/M, mob/user)
	M.apply_status_effect(/datum/status_effect/tarcookie)

/obj/item/slimecross/consuming/black
	colour = SLIME_TYPE_BLACK
	effect_desc = "Cria um biscoito que faz o alvo parecer um esqueleto assustador."
	cookietype = /obj/item/slime_cookie/black

/obj/item/slime_cookie/black
	name = "spooky cookie"
	desc = "Um biscoito preto com um fantasma de gelo na frente. Assustador!"
	icon_state = "black"
	taste = "ghosts and stuff"

/obj/item/slime_cookie/black/do_effect(mob/living/M, mob/user)
	M.apply_status_effect(/datum/status_effect/spookcookie)

/obj/item/slimecross/consuming/lightpink
	colour = SLIME_TYPE_LIGHT_PINK
	effect_desc = "Cria um biscoito de lodo que faz o alvo, e qualquer um próximo ao alvo, pacifista por um pouco de tempo."
	cookietype = /obj/item/slime_cookie/lightpink

/obj/item/slime_cookie/lightpink
	name = "peace cookie"
	desc = "Um biscoito rosa claro com um símbolo de paz na cobertura. Adorável!"
	icon_state = "lightpink"
	taste = "strawberry icing and P.L.U.R" //Literal candy raver.

/obj/item/slime_cookie/lightpink/do_effect(mob/living/M, mob/user)
	M.apply_status_effect(/datum/status_effect/peacecookie)

/obj/item/slimecross/consuming/adamantine
	colour = SLIME_TYPE_ADAMANTINE
	effect_desc = "Cria um biscoito de lodo que aumenta a resistência do alvo a queimar danos."
	cookietype = /obj/item/slime_cookie/adamantine

/obj/item/slime_cookie/adamantine
	name = "crystal cookie"
	desc = "Um doce de rocha translúcido em forma de biscoito. Surpreendentemente mastigável."
	icon_state = "adamantine"
	taste = "crystalline sugar and metal"

/obj/item/slime_cookie/adamantine/do_effect(mob/living/M, mob/user)
	M.apply_status_effect(/datum/status_effect/adamantinecookie)

/obj/item/slimecross/consuming/rainbow
	colour = SLIME_TYPE_RAINBOW
	effect_desc = "Cria um biscoito de lodo que tem o efeito de um biscoito aleatório."

/obj/item/slimecross/consuming/rainbow/spawncookie()
	var/cookie_type = pick(subtypesof(/obj/item/slime_cookie))
	var/obj/item/slime_cookie/S = new cookie_type(get_turf(src))
	S.name = "rainbow cookie"
	S.desc = "A beautiful rainbow cookie, constantly shifting colors in the light."
	S.icon_state = "rainbow"
	return S
