//Service modules for MODsuits

///Bike Horn - Plays a bike horn sound.
/obj/item/mod/module/bikehorn
	name = "MOD bike horn module"
	desc = "Um pedaço montado no ombro de artilharia sônica pesada, este módulo usa a melhor tecnologia de manipulador de femto para\
precisamente entregar um aperto quase letal para... uma buzina de bicicleta, produzindo um som significativamente memorável."
	icon_state = "bikehorn"
	module_type = MODULE_USABLE
	complexity = 1
	use_energy_cost = DEFAULT_CHARGE_DRAIN
	incompatible_modules = list(/obj/item/mod/module/bikehorn)
	cooldown_time = 1 SECONDS

/obj/item/mod/module/bikehorn/on_use(mob/activator)
	playsound(src, 'sound/items/bikehorn.ogg', 100, FALSE)
	drain_power(use_energy_cost)

///Advanced Balloon Blower - Blows a long balloon.
/obj/item/mod/module/balloon/advanced
	name = "MOD advanced balloon blower module"
	desc = "Uma tecnologia relativamente nova desenvolvida pelos melhores engenheiros palhaços para fazer balões longos e animais balões\
a uma taxa apropriada para a festa."
	cooldown_time = 20 SECONDS
	balloon_path = /obj/item/toy/balloon/long
	blowing_time = 15 SECONDS

///Microwave Beam - Microwaves items instantly.
/obj/item/mod/module/microwave_beam
	name = "MOD microwave beam module"
	desc = "Um dispositivo estranhamente doméstico, este módulo está instalado na palma do usuário,\
Ligando-se com scanners culinários localizados no capacete para explodir alimentos com radiação precisa de microondas,\
permitindo-lhes cozinhar comida à distância, com a maior facilidade. Não recomendado para uso contra uvas."
	icon_state = "microwave_beam"
	module_type = MODULE_ACTIVE
	complexity = 1
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 5
	incompatible_modules = list(/obj/item/mod/module/microwave_beam, /obj/item/mod/module/organizer)
	cooldown_time = 4 SECONDS
	required_slots = list(ITEM_SLOT_GLOVES)

/obj/item/mod/module/microwave_beam/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	if(!isitem(target))
		return
	if(!isturf(target.loc))
		balloon_alert(mod.wearer, "Não no depósito!")
		return
	var/obj/item/microwave_target = target
	do_sparks(2, TRUE, mod.wearer)
	mod.wearer.Beam(target,icon_state="lightning[rand(1,12)]", time = 5)
	if(microwave_target.microwave_act(microwaver = mod.wearer) & COMPONENT_MICROWAVE_SUCCESS)
		playsound(src, 'sound/machines/microwave/microwave-end.ogg', 50, FALSE)
	else
		balloon_alert(mod.wearer, "Não pode ser microondas!")
	do_sparks(2, TRUE, microwave_target)
	drain_power(use_energy_cost)

//Waddle - Makes you waddle and squeak.
/obj/item/mod/module/waddle
	name = "MOD waddle module"
	desc = "Algumas das tecnologias mais primitivas em uso pela Honk Co. Este módulo funciona com um sistema automático de intenção,\
Utilizando sua sensibilidade às ondas cerebrais do piloto para ler diretamente seu próximo passo,\
Afetando as botas que estão instaladas. Empregando um drive gravitônico de ligação dupla para criar\
Explosivos etéricos miniaturizados de espaço-tempo sob os pés do usuário, isso lhes permite...\
Para andar por aí, pulando de um lado para o outro com um incentivo em seu passo."
	icon_state = "waddle"
	complexity = 1
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0.2
	incompatible_modules = list(/obj/item/mod/module/waddle)
	required_slots = list(ITEM_SLOT_FEET)

/obj/item/mod/module/waddle/on_part_activation()
	var/obj/item/shoes = mod.get_part_from_slot(ITEM_SLOT_FEET)
	if(shoes)
		shoes.AddComponent(/datum/component/squeak, list('sound/effects/footstep/clownstep1.ogg'=1,'sound/effects/footstep/clownstep2.ogg'=1), 50, falloff_exponent = 20) //die off quick please
	mod.wearer.AddElementTrait(TRAIT_WADDLING, REF(src), /datum/element/waddling)
	if(is_clown_job(mod.wearer.mind?.assigned_role))
		mod.wearer.add_mood_event("clownshoes", /datum/mood_event/clownshoes)

/obj/item/mod/module/waddle/on_part_deactivation(deleting = FALSE)
	var/obj/item/shoes = mod.get_part_from_slot(ITEM_SLOT_FEET)
	if(shoes && !deleting)
		qdel(shoes.GetComponent(/datum/component/squeak))
	REMOVE_TRAIT(mod.wearer, TRAIT_WADDLING, REF(src))
	if(is_clown_job(mod.wearer.mind?.assigned_role))
		mod.wearer.clear_mood_event("clownshoes")

// recharging cleaner spray module
/obj/item/mod/module/mister/cleaner
	name = "MOD janitorial mister module"
	desc = "Um limpador de espaço, capaz de limpar bagunças rapidamente. Sintetiza seu próprio suprimento ao longo do tempo (se ativo)."
	device = /obj/item/reagent_containers/spray/mister/janitor
	volume = 100
	active_power_cost = DEFAULT_CHARGE_DRAIN

/obj/item/mod/module/mister/cleaner/Initialize(mapload)
	. = ..()
	reagents.flags = AMOUNT_VISIBLE
	reagents.add_reagent(/datum/reagent/space_cleaner, volume)

/obj/item/mod/module/mister/cleaner/on_active_process(seconds_per_tick)
	var/refill_add = min(volume - reagents.total_volume, 2 * seconds_per_tick)
	if(refill_add > 0)
		reagents.add_reagent(/datum/reagent/space_cleaner, refill_add)

/obj/item/mod/module/selfcleaner
	name = "MOD perfumer module"
	desc = "Um pequeno spray para se limpar. Tem um cheiro agradável."
	icon_state = "cleaner"
	module_type = MODULE_USABLE
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 5
	complexity = 1
	incompatible_modules = list(/obj/item/mod/module/selfcleaner)
	cooldown_time = 10 SECONDS

/obj/item/mod/module/selfcleaner/on_use(mob/activator)
	activator.wash(CLEAN_WASH)
	drain_power(use_energy_cost)
	playsound(activator, 'sound/effects/spray.ogg', 50, FALSE)
