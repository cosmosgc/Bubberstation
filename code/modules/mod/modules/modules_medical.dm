//Medical modules for MODsuits

#define HEALTH_SCAN "Health"
#define WOUND_SCAN "Wound"
#define CHEM_SCAN "Chemical"

///Health Analyzer - Gives the user a ranged health analyzer and their health status in the panel.
/obj/item/mod/module/health_analyzer
	name = "MOD health analyzer module"
	desc = "Um módulo instalado na luva do terno. Esta é uma suíte de varredura biológica de alta tecnologia, permitindo ao usuário informações detalhadas sobre os sinais vitais e lesões de outros, mesmo à distância, tudo com o movimento do pulso. Os dados são exibidos em um pacote conveniente, mas cabe a você fazer algo com ele."
	icon_state = "health"
	module_type = MODULE_ACTIVE
	complexity = 1
	use_energy_cost = DEFAULT_CHARGE_DRAIN
	incompatible_modules = list(/obj/item/mod/module/health_analyzer)
	cooldown_time = 0.5 SECONDS
	tgui_id = "health_analyzer"
	required_slots = list(ITEM_SLOT_GLOVES)
	/// Scanning mode, changes how we scan something.
	var/mode = HEALTH_SCAN

	/// List of all scanning modes.
	var/static/list/modes = list(HEALTH_SCAN, WOUND_SCAN, CHEM_SCAN)

/obj/item/mod/module/health_analyzer/add_ui_data()
	. = ..()
	.["health"] = mod.wearer?.health || 0
	.["health_max"] = mod.wearer?.getMaxHealth() || 0
	.["loss_brute"] = mod.wearer?.get_brute_loss() || 0
	.["loss_fire"] = mod.wearer?.get_fire_loss() || 0
	.["loss_tox"] = mod.wearer?.get_tox_loss() || 0
	.["loss_oxy"] = mod.wearer?.get_oxy_loss() || 0

	return .

/obj/item/mod/module/health_analyzer/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	if(!isliving(target) || !mod.wearer.can_read(src))
		return
	switch(mode)
		if(HEALTH_SCAN)
			healthscan(mod.wearer, target)
		if(WOUND_SCAN)
			woundscan(mod.wearer, target)
		if(CHEM_SCAN)
			chemscan(mod.wearer, target)
	drain_power(use_energy_cost)

/obj/item/mod/module/health_analyzer/get_configuration()
	. = ..()
	.["mode"] = add_ui_configuration("Scan Mode", "list", mode, modes)

/obj/item/mod/module/health_analyzer/configure_edit(key, value)
	switch(key)
		if("mode")
			mode = value

#undef HEALTH_SCAN
#undef WOUND_SCAN
#undef CHEM_SCAN

///Quick Carry - Lets the user carry bodies quicker.
/obj/item/mod/module/quick_carry
	name = "MOD quick carry module"
	desc = "Um conjunto de servos avançados, redirecionando energia dos braços do terno para ajudar a carregar os feridos, ou simplesmente por diversão. No entanto, Nanotrasen bloqueou a capacidade do módulo de ajudar em combate corpo a corpo."
	icon_state = "carry"
	complexity = 1
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	incompatible_modules = list(/obj/item/mod/module/quick_carry, /obj/item/mod/module/constructor)
	required_slots = list(ITEM_SLOT_GLOVES)
	var/quick_carry_trait = TRAIT_QUICK_CARRY

/obj/item/mod/module/quick_carry/on_part_activation()
	. = ..()
	ADD_TRAIT(mod.wearer, TRAIT_FASTMED, REF(src))
	ADD_TRAIT(mod.wearer, quick_carry_trait, REF(src))

/obj/item/mod/module/quick_carry/on_part_deactivation(deleting = FALSE)
	. = ..()
	REMOVE_TRAIT(mod.wearer, TRAIT_FASTMED, REF(src))
	REMOVE_TRAIT(mod.wearer, quick_carry_trait, REF(src))

/obj/item/mod/module/quick_carry/advanced
	name = "MOD advanced quick carry module"
	removable = FALSE
	complexity = 0
	quick_carry_trait = TRAIT_QUICKER_CARRY

///Injector - Gives the suit an extendable large-capacity piercing syringe.
/obj/item/mod/module/injector
	name = "MOD injector module"
	desc = "Um módulo instalado no pulso do terno, funciona como uma seringa de alta capacidade, com uma ponta fina o suficiente para localizar as portas de injeção de emergência em qualquer armadura, penetrando-a com facilidade. Até o seu."
	icon_state = "injector"
	module_type = MODULE_ACTIVE
	complexity = 1
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	device = /obj/item/reagent_containers/syringe/mod
	incompatible_modules = list(/obj/item/mod/module/injector)
	cooldown_time = 0.5 SECONDS
	required_slots = list(ITEM_SLOT_GLOVES)

/obj/item/reagent_containers/syringe/mod
	name = "MOD injector syringe"
	desc = "Uma seringa de alta capacidade, com uma ponta fina o suficiente para localizar as portas de injeção de emergência em qualquer armadura, penetrando com facilidade. Até o seu."
	icon_state = "mod_0"
	base_icon_state = "mod"
	amount_per_transfer_from_this = 30
	possible_transfer_amounts = list(5, 10, 15, 20, 30)
	volume = 30
	inject_flags = INJECT_CHECK_PENETRATE_THICK

/obj/item/reagent_containers/syringe/mod/update_reagent_overlay()
	if(reagents?.total_volume)
		var/mutable_appearance/filling_overlay = mutable_appearance('icons/obj/medical/reagent_fillings.dmi', "mod[get_rounded_vol()]")
		filling_overlay.color = mix_color_from_reagents(reagents.reagent_list)
		. += filling_overlay

///Organizer - Lets you shoot organs, immediately replacing them if the target has the organ manipulation surgery.
/obj/item/mod/module/organizer
	name = "MOD organizer module"
	desc = "Um dispositivo recuperado de uma nave da Interdyne Pharmaceuticals, este módulo foi descoberto para o bem ou para o mal. É um dispositivo montado no braço que utiliza tecnologia semelhante a dispositivos modernos de troca rápida de partes, capaz de substituir instantaneamente até 5 órgãos de uma vez na cirurgia sem a necessidade de removê-los primeiro, mesmo fora do alcance. É recomendado pela DeForest Medical Corporation para não informar os pacientes que foi usado."
	icon_state = "organizer"
	module_type = MODULE_ACTIVE
	complexity = 2
	use_energy_cost = DEFAULT_CHARGE_DRAIN
	incompatible_modules = list(/obj/item/mod/module/organizer, /obj/item/mod/module/microwave_beam)
	cooldown_time = 0.5 SECONDS
	required_slots = list(ITEM_SLOT_GLOVES)
	/// How many organs the module can hold.
	var/max_organs = 5
	/// A list of all our organs.
	var/organ_list = list()

/obj/item/mod/module/organizer/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/wearer_human = mod.wearer
	if(isorgan(target))
		if(!wearer_human.Adjacent(target))
			return
		var/atom/movable/organ = target
		if(length(organ_list) >= max_organs)
			balloon_alert(mod.wearer, "Muitos órgãos!")
			return
		organ_list += organ
		organ.forceMove(src)
		balloon_alert(mod.wearer, "Peguei.[organ]")
		playsound(src, 'sound/vehicles/mecha/hydraulic.ogg', 25, TRUE)
		drain_power(use_energy_cost)
		return
	if(!length(organ_list))
		return
	var/atom/movable/fired_organ = pop(organ_list)
	var/obj/projectile/organ/projectile = new /obj/projectile/organ(mod.wearer.loc, fired_organ)
	projectile.aim_projectile(target, mod.wearer)
	projectile.firer = mod.wearer
	playsound(src, 'sound/vehicles/mecha/hydraulic.ogg', 25, TRUE)
	INVOKE_ASYNC(projectile, TYPE_PROC_REF(/obj/projectile, fire))
	drain_power(use_energy_cost)

/obj/projectile/organ
	name = "organ"
	damage = 0
	hitsound = 'sound/effects/blob/attackblob.ogg'
	hitsound_wall = 'sound/effects/blob/attackblob.ogg'
	/// A reference to the organ we "are".
	var/obj/item/organ/organ

/obj/projectile/organ/Initialize(mapload, obj/item/stored_organ)
	. = ..()
	if(!stored_organ)
		return INITIALIZE_HINT_QDEL
	appearance = stored_organ.appearance
	stored_organ.forceMove(src)
	organ = stored_organ

/obj/projectile/organ/Destroy()
	organ = null
	return ..()

/obj/projectile/organ/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == organ)
		organ = null

/obj/projectile/organ/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(!isliving(target) || (organ.organ_flags & ORGAN_UNUSABLE))
		organ.forceMove(drop_location())
		return
	var/mob/living/organ_receiver = target
	// bodyparts actually *do* hit a specific bodypart, but random variance would make this projectile unusable
	// so we just fake it, and assume the organ always hits the place it needs to go
	var/obj/item/bodypart/fake_hit_part = organ_receiver.get_bodypart(length(organ.valid_zones) ? pick(organ.valid_zones) : deprecise_zone(organ.zone))
	if(!LIMB_HAS_SURGERY_STATE(fake_hit_part, SURGERY_SKIN_OPEN|SURGERY_ORGANS_CUT|SURGERY_BONE_SAWED))
		organ.forceMove(drop_location())
		return

	// handles swapping any existing organ out for us
	organ.Insert(target)

///Patrient Transport - Generates hardlight bags you can put people in.
/obj/item/mod/module/criminalcapture/patienttransport
	name = "MOD patient transport module"
	desc = "Um módulo construído no antebraço do terno. Inúmeras ondas de equipes de mineração quase perdidas sendo enviadas para indecifrias e outros locais perigosos ensinaram à Companhia Médica DeForest muitas lições. Bodybags físicos são difíceis de armazenar, difíceis de implantar, e ainda pior para manter intacto em cenários difíceis. Entre na bolsa de transporte. Invocável com apenas um gesto, sem peso, e imunizado contra qualquer cenário extremo que o usuário possa pensar, este saco é perfeitamente projetado para transporte de qualquer corpo em qualquer ambiente, a qualquer momento."
	icon_state = "patient_transport"
	bodybag_type = /obj/structure/closet/body_bag/environmental/hardlight
	capture_time = 1.5 SECONDS
	packup_time = 0.5 SECONDS

///Defibrillator - Gives the suit an extendable pair of shock paddles.
/obj/item/mod/module/defibrillator
	name = "MOD defibrillator module"
	desc = "Um módulo construído nas luvas do terno, conhecido como \"Mãos Curadoras\" por profissionais médicos. O usuário coloca as mãos acima do paciente. Computadores de bordo no terno calculam a voltagem necessária, e um computador de alvo modificado determina a melhor posição para o usuário empurrar. Vinte e cinco quilos de força são aplicados na pele do paciente. Choques viajam das luvas do terno e contra-chocam o coração, e o usuário volta para o médico como um herói. Nem pense em usá-la como arma, regulamentos sobre fabricação e travas de software expressamente proíbem."
	icon_state = "defibrillator"
	module_type = MODULE_ACTIVE
	complexity = 2
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 25
	device = /obj/item/shockpaddles/mod
	overlay_state_inactive = "module_defibrillator"
	overlay_state_active = "module_defibrillator_active"
	incompatible_modules = list(/obj/item/mod/module/defibrillator)
	cooldown_time = 0.5 SECONDS
	required_slots = list(ITEM_SLOT_GLOVES)
	var/defib_cooldown = 5 SECONDS

/obj/item/mod/module/defibrillator/Initialize(mapload)
	. = ..()
	RegisterSignal(device, COMSIG_DEFIBRILLATOR_SUCCESS, PROC_REF(on_defib_success))

/obj/item/mod/module/defibrillator/proc/on_defib_success(obj/item/shockpaddles/source)
	drain_power(use_energy_cost)
	source.recharge(defib_cooldown)
	return COMPONENT_DEFIB_STOP

/obj/item/shockpaddles/mod
	name = "MOD defibrillator gauntlets"
	req_defib = FALSE
	icon_state = "defibgauntlets0"
	inhand_icon_state = "defibgauntlets0"
	base_icon_state = "defibgauntlets"

/obj/item/mod/module/defibrillator/combat
	name = "MOD combat defibrillator module"
	desc = "Um módulo construído nas luvas do terno, conhecido como \"Mãos Curadoras\" por profissionais médicos. O usuário coloca as mãos acima do paciente. Computadores de bordo no terno calculam a voltagem necessária, e um computador de alvo modificado determina a melhor posição para o usuário empurrar. Vinte e cinco quilos de força são aplicados na pele do paciente. Choques viajam das luvas do terno e contra-chocam o coração, e o usuário volta para o médico como um herói. A Interdyne Pharmaceutics comercializava a versão doméstica das Mãos Curadoras como infalível e inutilizável como uma arma. Mas quando chegou a hora de fornecer aos seus agentes equipamentos médicos utilizáveis, eles não hesitaram em remover esses cofres embutidos. Os agentes no campo podem se beneficiar do que chamam de \"Luvas de Sol\", capazes de aplicar choques direto em um coração das vítimas para desativá-los, ou talvez até mesmo parar seu coração com energia suficiente."
	complexity = 1
	module_type = MODULE_ACTIVE
	overlay_state_inactive = "module_defibrillator_combat"
	overlay_state_active = "module_defibrillator_combat_active"
	device = /obj/item/shockpaddles/syndicate/mod
	defib_cooldown = 2.5 SECONDS

/obj/item/shockpaddles/syndicate/mod
	name = "MOD combat defibrillator gauntlets"
	req_defib = FALSE
	icon_state = "syndiegauntlets0"
	inhand_icon_state = "syndiegauntlets0"
	base_icon_state = "syndiegauntlets"

///Thread Ripper - Temporarily rips apart clothing to make it not cover the body.
/obj/item/mod/module/thread_ripper
	name = "MOD thread ripper module"
	desc = "Um módulo personalizado integrado com o pulso do terno. O estripador de fios é construído a partir de tecnologia recente que remonta ao início de 2562, após uma tentativa de um pesquisador conhecido de Nanotrasen para expandir a tecnologia de cauda rápida encontrada em Autodrobes. Em vez de ser capaz de criar qualquer padrão de tecido sob os sóis, o estripador de fios é capaz de desmontar rapidamente deles. Qualquer coisa desde kevlar-weave, ao couro, ao durathread pode ser rapidamente puxado aberto à especificação do usuário e costurado de volta juntos, um desenvolvimento comumente utilizado por trabalhadores médicos para obter fácil acesso para cirurgia, desfibrilação, ou injeção de produtos químicos para facilitar os pacientes a não se preocupar com sua marca de moda sendo marred."
	icon_state = "thread_ripper"
	module_type = MODULE_ACTIVE
	complexity = 2
	use_energy_cost = DEFAULT_CHARGE_DRAIN
	incompatible_modules = list(/obj/item/mod/module/thread_ripper)
	cooldown_time = 1.5 SECONDS
	overlay_state_inactive = "module_threadripper"
	required_slots = list(ITEM_SLOT_GLOVES)
	/// An associated list of ripped clothing and the body part covering slots they covered before
	var/list/ripped_clothing = list()

/obj/item/mod/module/thread_ripper/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	if(!mod.wearer.Adjacent(target) || !iscarbon(target) || target == mod.wearer)
		balloon_alert(mod.wearer, "alvo inválido!")
		return
	var/mob/living/carbon/carbon_target = target
	if(length(ripped_clothing))
		balloon_alert(mod.wearer, "Já estourou!")
		return
	balloon_alert(mod.wearer, "rasgar roupas...")
	playsound(src, 'sound/items/zip/zip.ogg', 25, TRUE, frequency = -1)
	if(!do_after(mod.wearer, 1.5 SECONDS, target = carbon_target))
		balloon_alert(mod.wearer, "Interrompido!")
		return
	var/target_zones = body_zone2cover_flags(mod.wearer.zone_selected)
	for(var/obj/item/clothing as anything in carbon_target.get_equipped_items())
		if(!clothing)
			continue
		var/shared_flags = target_zones & clothing.body_parts_covered
		if(shared_flags)
			ripped_clothing[clothing] = shared_flags
			clothing.body_parts_covered &= ~shared_flags

/obj/item/mod/module/thread_ripper/on_process(seconds_per_tick)
	. = ..()
	if(!.)
		return
	if(!length(ripped_clothing))
		return
	var/zipped = FALSE
	for(var/obj/item/clothing as anything in ripped_clothing)
		if(QDELETED(clothing))
			ripped_clothing -= clothing
			continue
		var/mob/living/carbon/clothing_wearer = clothing.loc
		if(istype(clothing_wearer) && mod.wearer.Adjacent(clothing_wearer) && !clothing_wearer.is_holding(clothing))
			continue
		zipped = TRUE
		clothing.body_parts_covered |= ripped_clothing[clothing]
		ripped_clothing -= clothing
	if(zipped)
		playsound(src, 'sound/items/zip/zip.ogg', 25, TRUE)
		balloon_alert(mod.wearer, "Roupas consertadas")

/obj/item/mod/module/thread_ripper/on_part_deactivation(deleting = FALSE)
	if(!length(ripped_clothing))
		return
	for(var/obj/item/clothing as anything in ripped_clothing)
		if(QDELETED(clothing))
			ripped_clothing -= clothing
			continue
		clothing.body_parts_covered |= ripped_clothing[clothing]
	ripped_clothing = list()
	if(!deleting)
		playsound(src, 'sound/items/zip/zip.ogg', 25, TRUE)

///Surgical Processor - Lets you do advanced surgeries portably.
/obj/item/mod/module/surgical_processor
	name = "MOD surgical processor module"
	desc = "Um módulo usando um computador cirúrgico que pode ser conectado a outros computadores para baixar e realizar cirurgias avançadas em movimento."
	icon_state = "surgical_processor"
	module_type = MODULE_ACTIVE
	complexity = 2
	active_power_cost = DEFAULT_CHARGE_DRAIN
	device = /obj/item/surgical_processor/mod
	incompatible_modules = list(/obj/item/mod/module/surgical_processor)
	cooldown_time = 0.5 SECONDS

/obj/item/surgical_processor/mod
	name = "MOD surgical processor"

/obj/item/mod/module/surgical_processor/preloaded
	desc = "Um módulo usando um computador cirúrgico que pode ser conectado a outros computadores para baixar e realizar cirurgias avançadas em movimento. Este veio com cirurgias avançadas."
	device = /obj/item/surgical_processor/mod/preloaded

/obj/item/surgical_processor/mod/preloaded
	loaded_surgeries = list(
		/datum/surgery_operation/basic/tend_wounds/combo/upgraded/master,
		/datum/surgery_operation/limb/bioware/cortex_folding,
		/datum/surgery_operation/limb/bioware/cortex_folding/mechanic,
		/datum/surgery_operation/limb/bioware/cortex_imprint,
		/datum/surgery_operation/limb/bioware/cortex_imprint/mechanic,
		/datum/surgery_operation/limb/bioware/ligament_hook,
		/datum/surgery_operation/limb/bioware/ligament_hook/mechanic,
		/datum/surgery_operation/limb/bioware/ligament_reinforcement,
		/datum/surgery_operation/limb/bioware/ligament_reinforcement/mechanic,
		/datum/surgery_operation/limb/bioware/muscled_veins,
		/datum/surgery_operation/limb/bioware/muscled_veins/mechanic,
		/datum/surgery_operation/limb/bioware/nerve_grounding,
		/datum/surgery_operation/limb/bioware/nerve_grounding/mechanic,
		/datum/surgery_operation/limb/bioware/nerve_splicing,
		/datum/surgery_operation/limb/bioware/nerve_splicing/mechanic,
		/datum/surgery_operation/limb/bioware/vein_threading,
		/datum/surgery_operation/limb/bioware/vein_threading/mechanic,
		/datum/surgery_operation/organ/brainwash,
		/datum/surgery_operation/organ/brainwash/mechanic,
		/datum/surgery_operation/organ/pacify,
		/datum/surgery_operation/organ/pacify/mechanic,
	)

/obj/item/mod/module/surgical_processor/emergency
	desc = "Um módulo usando um computador cirúrgico que pode ser conectado a outros computadores para baixar e realizar cirurgias avançadas em movimento. Este veio pré-carregado com algumas cirurgias de emergência."
	device = /obj/item/surgical_processor/mod/emergency

/obj/item/surgical_processor/mod/emergency
	loaded_surgeries = list(
		/datum/surgery_operation/basic/tend_wounds/combo/upgraded/master,
		/datum/surgery_operation/organ/fix_wings,
	)
