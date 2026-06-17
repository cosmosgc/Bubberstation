#define SHOWCASE_CONSTRUCTED 1
#define SHOWCASE_SCREWDRIVERED 2

/*Completely generic structures for use by mappers to create fake objects, i.e. display rooms*/
/obj/structure/showcase
	name = "showcase"
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "showcase_1"
	desc = "Um estande com o corpo vazio de um cyborg preso nele."
	density = TRUE
	anchored = TRUE
	var/deconstruction_state = SHOWCASE_CONSTRUCTED

/obj/structure/showcase/fakeid
	name = "\improper CentCom identification console"
	desc = "Você pode usar isso para mudar identidades."
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = "computer"

/obj/structure/showcase/fakeid/Initialize(mapload)
	. = ..()
	add_overlay("id")
	add_overlay("id_key")

/obj/structure/showcase/fakesec
	name = "\improper CentCom security records"
	desc = "Costumava ver e editar registros de segurança do pessoal."
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = "computer"

/obj/structure/showcase/fakesec/update_overlays()
	. = ..()
	. += "security"
	. += "security_key"

/obj/structure/showcase/horrific_experiment
	name = "horrific experiment"
	desc = "Algum tipo de cápsula cheia de sangue e vísceras. Você jura que pode vê-lo se movendo..."
	icon = 'icons/obj/machines/cloning.dmi'
	icon_state = "pod_g" // Please don't delete it and not notice it for months this time.

/obj/structure/showcase/machinery/oldpod
	name = "damaged cryogenic pod"
	desc = "Uma cápsula criogênica danificada há muito tempo perdida, incluindo seu antigo ocupante..."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper-open"

/obj/structure/showcase/machinery/oldpod/used
	name = "opened cryogenic pod"
	desc = "Uma cápsula criogênica que recentemente descarregou seu ocupante. A cápsula não parece funcional."

/obj/structure/showcase/machinery/oldpod/used/psyker
	name = "opened mental energizer"
	desc = "Um energizador mental que recentemente descarregou seu ocupante. A cápsula não parece funcional."
	icon_state = "psykerpod-open"

/obj/structure/showcase/cyborg/old
	name = "Cyborg Statue"
	desc = "Um velho ciborgue desativado. Enquanto uma vez usado ativamente para proteger contra intrusos, ele agora simplesmente os intimida com seu olhar frio e duro."
	icon = 'icons/mob/silicon/robots.dmi'
	icon_state = "robot_old"
	density = FALSE

/obj/structure/showcase/mecha/marauder
	name = "combat mech exhibit"
	desc = "Uma barraca com um velho e vazio Mech de combate da Corporação Nanotrasen. É descrita como a unidade principal usada para defender interesses corporativos e empregados."
	icon = 'icons/mob/rideables/mecha.dmi'
	icon_state = "marauder"

/obj/structure/showcase/mecha/ripley
	name = "construction mech exhibit"
	desc = "Um estande com um mech de construção aposentado preso a ele. As pinças são classificadas em 9300 PSI. Parece que está desmoronando."
	icon = 'icons/mob/rideables/mecha.dmi'
	icon_state = "firefighter"

/obj/structure/showcase/machinery/implanter
	name = "\improper Nanotrasen automated mindshield implanter exhibit"
	desc = "Um modelo frágil de uma máquina de implante automático de escudo mental de Nanotrasen. Com arnês de posicionamento seguro e um injetor cirúrgico robótico, danos cerebrais e outras anomalias médicas graves são agora 60% menos prováveis!"
	icon = 'icons/obj/machines/implant_chair.dmi'
	icon_state = "implantchair"

/obj/structure/showcase/machinery/microwave
	name = "\improper Nanotrasen-brand microwave"
	desc = "O famoso microondas da marca Nanotrasen, o aparelho de cozinha multiuso que toda estação precisa! Este parece ser desenhado para uma caixa de papelão."
	icon = 'icons/obj/machines/microwave.dmi'
	icon_state = "mw_complete"

/obj/structure/showcase/machinery/microwave_engineering
	name = "\improper Nanotrasen Wave(tm) microwave"
	desc = "Quando todos pensaram que Nanotrasen não poderia melhorar em seu famoso microondas, este modelo 2563 apresenta WaveTM! Um exclusivo Nanotrasen, WaveTM permite que seu PDA seja carregado sem fio através de frequências de microondas. Porque nada diz \"futuro\" como carregar seu PDA enquanto cozinhou demais suas sobras. Nanotrasen WaveTM - Multitarefa, redefinida."
	icon = 'icons/obj/machines/microwave.dmi'
	icon_state = "engi_mw_complete"

/obj/structure/showcase/machinery/cloning_pod
	name = "cloning pod exhibit"
	desc = "Descreve um protótipo de uma tentativa falhada de tecnologia de clonagem confiável. A tecnologia foi descartada após relatos de mutações graves, síndrome da orelha e crescimento espontâneo da cauda. A data 11.11.2558 está gravada na base."
	icon = 'icons/obj/machines/cloning.dmi'
	icon_state = "pod_0"

/obj/structure/showcase/perfect_employee
	name = "'Perfect Man' employee exhibit"
	desc = "Um estande com um modelo do perfeito empregado Nanotrasen afugentado. Sinais indicam que é robustamente geneticamente modificado, além de ser cruelmente leal."

/obj/structure/showcase/machinery/tv
	name = "\improper Nanotrasen corporate newsfeed"
	desc = "Uma TV levemente agredida. Vários infomerciais de Nanotrasen tocam em um loop, acompanhado por uma melodia alegre."
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = "television"

/obj/structure/showcase/machinery/signal_decrypter
	name = "subsystem signal decrypter"
	desc = "Uma máquina estranha que supostamente é usada para ajudar a captar e descodificar sinais de onda."
	icon = 'icons/obj/machines/telecomms.dmi'
	icon_state = "processor"

/obj/structure/showcase/wizard
	name = "wizard of yendor showcase"
	desc = "Uma figura histórica de grande importância para a Federação Feiticeira. Passou sua longa vida aprendendo magia, roubando artefatos, e assediando idiotas com espadas. Que descanse para sempre, Rodney."
	icon = 'icons/mob/simple/mob.dmi'
	icon_state = "nim"

/obj/structure/showcase/machinery/rng
	name = "byond random number generator"
	desc = "Uma estranha máquina supostamente de outro mundo. A Federação Mágica tem se intrometido com isso por anos."
	icon = 'icons/obj/machines/telecomms.dmi'
	icon_state = "processor"

/obj/structure/showcase/katana
	name = "seppuku katana"
	desc = "Bem, só há uma maneira de recuperar sua honra."
	density = 0
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "katana"

//Deconstructing
//Showcases can be any sprite, so it makes sense that they can't be constructed.
//However if a player wants to move an existing showcase or remove one, this is for that.

/obj/structure/showcase/screwdriver_act(mob/living/user, obj/item/tool)
	if(anchored)
		return FALSE
	if(deconstruction_state == SHOWCASE_SCREWDRIVERED)
		to_chat(user, span_notice("Você fode os parafusos de volta para a vitrine."))
		tool.play_tool_sound(src, 100)
		deconstruction_state = SHOWCASE_CONSTRUCTED
	else if (deconstruction_state == SHOWCASE_CONSTRUCTED)
		to_chat(user, span_notice("Você desenroscou os parafusos."))
		tool.play_tool_sound(src, 100)
		deconstruction_state = SHOWCASE_SCREWDRIVERED
	return ITEM_INTERACT_SUCCESS

/obj/structure/showcase/crowbar_act(mob/living/user, obj/item/tool)
	if(!tool.use_tool(src, user, 2 SECONDS, volume=100))
		return
	to_chat(user, span_notice("Você começa a se afastar da vitrine..."))
	new /obj/item/stack/sheet/iron(drop_location(), 4)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/structure/showcase/wrench_act(mob/living/user, obj/item/tool)
	if(deconstruction_state != SHOWCASE_CONSTRUCTED)
		return FALSE
	default_unfasten_wrench(user, tool)
	return ITEM_INTERACT_SUCCESS

//Feedback is given in examine because showcases can basically have any sprite assigned to them

/obj/structure/showcase/examine(mob/user)
	. = ..()

	switch(deconstruction_state)
		if(SHOWCASE_CONSTRUCTED)
			. += "It's fully constructed."
		if(SHOWCASE_SCREWDRIVERED)
			. += "It has its screws loosened."
		else
			. += "If you see this, something is wrong."

#undef SHOWCASE_CONSTRUCTED
#undef SHOWCASE_SCREWDRIVERED
