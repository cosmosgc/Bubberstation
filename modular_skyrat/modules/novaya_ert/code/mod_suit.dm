/datum/mod_theme/frontline
	name = "frontline"
	desc = "Um traje de proteção contra Collegia da Defesa Pan-eslava, projetado para operações de posições fortificadas e ajuda humanitária."
	extended_desc = "Uma substituição mais barata e versátil da datada armadura de poder VOSKHOD, projetada pela então Novaya Rossiyskaya Imperiya Inovações Collegia em\
Colaboração com pesquisadores Agurkrral. Em vez de placas de poliureia revestidas de plasteel forrado, utiliza placas finas de titânio com suporte de Kevlar, tornando-o mais leve e compacto.\
ao deixar o lugar para outros módulos, ainda devido à sua falta de sistemas de dissipação de energia, tornando seu usuário mais vulnerável contra armas de laser convencionais.\
A trajetória de projéteis embutidos e o computador de assistência de munição informa o operador de melhores lugares para mirar, bem como as munições restantes para\
A arma e suas revistas. Esta função é bastante desgastante na célula de energia, e como tal, este processo raramente é visto fora das posições fortificadas ou missões humanitárias;\
tornando-se o sinal de que pouca hospitalidade e assistência os militares podem fornecer. No entanto, muitas pessoas que tiveram uma experiência com este MOD descrevê-lo como\"Muito desconfortável.\", \
principalmente devido à sua falta de sistemas adequados de regulação ambiental. Mas por causa de suas capacidades de proteção, extrema produção em massa e preço barato, tornou-se facilmente o principal sistema de blindagem do PSC DC."
	default_skin = "frontline"
	armor_type = /datum/armor/mod_theme_frontline
	complexity_max = DEFAULT_MAX_COMPLEXITY
	charge_drain = DEFAULT_CHARGE_DRAIN * 1.5
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/knife/combat,
		/obj/item/shield/riot,
		/obj/item/gun,
	)
	variants = list(
		"frontline" = list(
			MOD_ICON_OVERRIDE = 'modular_skyrat/modules/novaya_ert/icons/mod.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_skyrat/modules/novaya_ert/icons/wornmod.dmi',
		/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = HEAD_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY =  HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT|HIDETAIL,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/armor/mod_theme_frontline
	melee = 50
	bullet = 60
	laser = 40
	energy = 50
	bomb = 60
	bio = 100
	fire = 50
	acid = 80
	wound = 25

/obj/item/mod/control/pre_equipped/frontline
	theme = /datum/mod_theme/frontline
	applied_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/flashlight,
	)

/obj/item/mod/control/pre_equipped/frontline/ert
	applied_cell = /obj/item/stock_parts/power_store/cell/hyper
	applied_modules = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/auto_doc,
		/obj/item/mod/module/visor/thermal,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/magboot/advanced,
	)
	default_pins = list(
		/obj/item/mod/module/visor/thermal,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/magboot/advanced,
	)


/datum/mod_theme/frontline/surplus
	name = "frontline surplus"
	activation_step_time = MOD_ACTIVATION_STEP_TIME + 3
	desc = "Um traje protetor Pan-Eslavo da Defesa da Commonwealth, projetado para operações de posições fortificadas e ajuda humanitária, este parece um tanto velho e desgastado."
	extended_desc = "Um traje de proteção contra Collegia da Defesa Pan-eslava, projetado para operações de posições fortificadas e ajuda humanitária.\
Este foi comprado em leilão, os módulos de combate foram removidos, mas...\
Ainda estaria em casa a serviço de traficantes de armas e forças de segurança privadas.\
No entanto, seus sistemas internos se degradaram, e alguns dos revestimentos ablativos foram removidos."
	armor_type = /datum/armor/mod_theme_frontline/surplus

/datum/mod_theme/frontline/surplus/set_skin(obj/item/mod/control/mod, skin)
	. = ..()
	mod.set_mod_color("#888888", FIXED_COLOUR_PRIORITY)

/datum/armor/mod_theme_frontline/surplus
	melee = 30
	bullet = 40
	laser = 15
	energy = 15
	bomb = 30
	wound = 10

/datum/mod_theme/frontline/surplus/New()
	allowed_suit_storage -= /obj/item/shield/riot
	. = ..()

/obj/item/mod/control/pre_equipped/frontline/surplus
	theme = /datum/mod_theme/frontline/surplus

/datum/supply_pack/imports/surplus_nri_modsuit
	name = "Surplus Combat MODsuit Crate"
	desc = "Uma caixa contendo um único excesso MODsuit,\
Projetado para uso pela Pan-Slavic Commonwealth Defesa Collegia.\
Este foi despojado de seus módulos de combate, mas ainda é um bom terno para aqueles que precisam de proteção e mobilidade.\
Notavelmente, não usa ou requer um módulo de armadura."
	cost = CARGO_CRATE_VALUE * 22
	contains = list(/obj/item/mod/control/pre_equipped/frontline/surplus)
	order_flags = ORDER_CONTRABAND

/datum/mod_theme/policing
	name = "policing"
	desc = "Um traje de proteção para fins gerais da Comunidade Pan-Eslava, projetado para patrulhas do núcleo mundial."
	extended_desc = "Uma Apadyne Technologies terceirizada, modificada para uso fronteiriço pela delegacia de polícia imperial, modelo MODsuit,\
Projetado para tranquilizar civis em pânico do que participar de combate ativo. A armadura fina do terno é durável contra o ambiente e projéteis.\
e vem com um sistema de redistribuição de energia em miniatura para proteger contra armas de energia, embora ineficazmente.\
Graças às modificações da polícia local, armamento adicional foi adicionado às suas pernas e braços, ao custo de um aumento da carga do sistema."
	default_skin = "policing"
	armor_type = /datum/armor/mod_theme_policing
	complexity_max = DEFAULT_MAX_COMPLEXITY - 1
	charge_drain = DEFAULT_CHARGE_DRAIN * 1.25
	slowdown_deployed = 0.5
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/knife/combat,
		/obj/item/shield/riot,
		/obj/item/gun,
	)
	variants = list(
		"policing" = list(
			MOD_ICON_OVERRIDE = 'modular_skyrat/modules/novaya_ert/icons/mod.dmi',
			MOD_WORN_ICON_OVERRIDE = 'modular_skyrat/modules/novaya_ert/icons/wornmod.dmi',
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = HEAD_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY =  HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT|HIDETAIL,
				UNSEALED_MESSAGE = CHESTPLATE_UNSEAL_MESSAGE,
				SEALED_MESSAGE = CHESTPLATE_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = GAUNTLET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = GAUNTLET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)

/datum/armor/mod_theme_policing
	melee = 40
	bullet = 50
	laser = 30
	energy = 30
	bomb = 60
	bio = 100
	fire = 75
	acid = 75
	wound = 20

/obj/item/mod/control/pre_equipped/policing
	theme = /datum/mod_theme/policing
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/thermal_regulator,
		/obj/item/mod/module/status_readout/operational,
		/obj/item/mod/module/tether,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/paper_dispenser,
		/obj/item/mod/module/magnetic_harness
	)
	default_pins = list(
		/obj/item/mod/module/tether,
		/obj/item/mod/module/magboot,
	)

///Unrelated-to-Spider-Clan version of the module.
/obj/item/mod/module/status_readout/operational
	name = "MOD operational status readout module"
	desc = "Um módulo uma vez comum, esta tecnologia infelizmente saiu da moda nas regiões mais seguras do espaço;\
No entanto, permaneceu em uso em todos os outros lugares. Esta unidade em particular prende a espinha do terno,\
capaz de capturar e exibir todos os possíveis dados biométricos do usuário; sono, nutrição, aptidão, impressões digitais,\
e até informações úteis, como sua saúde e bem-estar. O monitor de sinais vitais também vem com um alto-falante, alto o suficiente.\
para alertar qualquer um por perto que alguém, na verdade, morreu. Esta unidade específica tem um relógio e identificação operacional."
	display_time = TRUE
	death_sound = 'modular_skyrat/modules/novaya_ert/sound/flatline.ogg'

///Blatant copy of the adrenaline boost module.
/obj/item/mod/module/auto_doc
	name = "MOD automatic paramedical module"
	desc = "O sistema de assistência médica de engenharia reversa e redesenhado, anteriormente usado pela armadura de combate VOSKHOD desativada.\
A tecnologia que ele usa é muito semelhante à do Clã Aranha, mas Inovações e Defesa Collegium rejeitam qualquer semelhança.\
Usando um armazenamento incorporado de compostos químicos e misturador químico em miniatura, é capaz de injetar em seu usuário analgésicos simples e coagulantes,\
Ajudando-os com sua restauração, contanto que eles não se sobreponham. No entanto, este sistema depende fortemente de alguns compostos químicos raramente disponíveis para combate para preparar suas injeções,\
principalmente Criptobiolina, que aparecem na corrente sanguínea do usuário de tempos em tempos, e seus triviais sistemas de avaliação de danos são inadequados para fins de restauração completa."
	icon_state = "adrenaline_boost"
	module_type = MODULE_TOGGLE
	incompatible_modules = list(/obj/item/mod/module/adrenaline_boost, /obj/item/mod/module/auto_doc)
	cooldown_time = null
	complexity = 4
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 20
	/// What reagent we need to refill?
	var/reagent_required = /datum/reagent/cryptobiolin
	/// How much of a reagent we need to refill a single boost.
	var/reagent_required_amount = 20
	/// Maximum amount of reagents this module can hold.
	var/reagent_max_amount = 120
	/// Health threshold above which the module won't heal.
	var/health_threshold = 80
	/// Cooldown betwen each treatment.
	var/heal_cooldown = 30 SECONDS

	/// Timer for the cooldown.
	COOLDOWN_DECLARE(heal_timer)

/// Creates chemical container for chemicals and fills it with chemicals. Chemception.
/obj/item/mod/module/auto_doc/Initialize(mapload)
	. = ..()
	create_reagents(reagent_max_amount)
	reagents.add_reagent(reagent_required, reagent_max_amount)

/obj/item/mod/module/auto_doc/on_activation()
	. = ..()
	if(!.)
		return
	RegisterSignal(mod.wearer, COMSIG_LIVING_HEALTH_UPDATE, PROC_REF(on_use))
	drain_power(use_energy_cost)

///	Heals damage (in fact, injects chems) based on the damage received and certain other variables (a single one), i.e. having more than X amount of health, not having enough needed chemicals or so on.
/obj/item/mod/module/auto_doc/on_use()
	if(!COOLDOWN_FINISHED(src, heal_timer))
		return FALSE

	if(!check_power(use_energy_cost))
		balloon_alert(mod.wearer, "Não há carga suficiente!")
		SEND_SIGNAL(src, COMSIG_MODULE_DEACTIVATED)
		return FALSE

	if(!(allow_flags & MODULE_ALLOW_PHASEOUT) && istype(mod.wearer.loc, /obj/effect/dummy/phased_mob))
		to_chat(mod.wearer, span_warning("Você não pode ativar isso agora."))
		return FALSE

	if(SEND_SIGNAL(src, COMSIG_MODULE_TRIGGERED) & MOD_ABORT_USE)
		return FALSE

	if(!reagents.has_reagent(reagent_required, reagent_required_amount))
		balloon_alert(mod.wearer, "Chems não suficientes!")
		SEND_SIGNAL(src, COMSIG_MODULE_DEACTIVATED)
		return FALSE

	if(mod.wearer.health > health_threshold)
		return

	var/new_bruteloss = mod.wearer.get_brute_loss()
	var/new_fireloss = mod.wearer.get_fire_loss()
	var/new_toxloss = mod.wearer.get_tox_loss()
	var/new_stamloss = mod.wearer.get_stamina_loss()
	playsound(mod.wearer, 'modular_skyrat/modules/hev_suit/sound/hev/hiss.ogg', 100)

	if(new_bruteloss)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/mine_salve, 10)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/sal_acid, 5)
		to_chat(mod.wearer, span_warning("Tratamento brutal administrado. Riscos de overdose presentes em uso, consulte seu analisador de primeiros socorros."))

	if(new_fireloss)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/mine_salve, 10)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/oxandrolone, 5)
		to_chat(mod.wearer, span_warning("Tratamento de queimadura administrado. Riscos de overdose presentes em uso, consulte seu analisador de primeiros socorros."))

	if(new_toxloss)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/mine_salve, 10)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/pen_acid, 5)
		to_chat(mod.wearer, span_warning("Tratamento de toxina administrado. Riscos de overdose presentes em uso, consulte seu analisador de primeiros socorros."))

	if(new_stamloss)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/mine_salve, 10)
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/stimulants, 10)
		to_chat(mod.wearer, span_warning("Estimulantes de combate administrados. Riscos de overdose presentes em uso, consulte seu analisador de primeiros socorros."))

	mod.wearer.reagents.add_reagent(/datum/reagent/medicine/coagulant, 5)
	reagents.remove_reagent(reagent_required, reagent_required_amount)
	drain_power(use_energy_cost*10)

	///Debuff so it's "balanced", as well as a cooldown.
	addtimer(CALLBACK(src, PROC_REF(boost_aftereffects), mod.wearer), 45 SECONDS)
	COOLDOWN_START(src, heal_timer, heal_cooldown)

/// Refills MODsuit module with the needed chemicals. That's all it does.
/obj/item/mod/module/auto_doc/proc/charge_boost(obj/item/attacking_item, mob/user)
/// Oh, and it also doesn't work if it's (the chemical container) closed.
	if(!attacking_item.is_open_container())
		return FALSE
/// And if it's already full (:flushed:)
	if(reagents.has_reagent(reagent_required, reagent_max_amount))
		balloon_alert(mod.wearer, "Já está cheio!")
		return FALSE
/// And if the reagent's wrong.
	if(!attacking_item.reagents.trans_to(src, reagent_required_amount, target_id = reagent_required))
		return FALSE
/// And if you got to that point without screwing up then it awards you with being refilled.
	balloon_alert(mod.wearer, "Carga recarregada.")
	return TRUE

/obj/item/mod/module/auto_doc/on_deactivation(display_message = TRUE, deleting = FALSE)
	. = ..()
	UnregisterSignal(mod.wearer, COMSIG_LIVING_HEALTH_UPDATE)

/obj/item/mod/module/auto_doc/on_install()
	. = ..()
	RegisterSignal(mod, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(on_item_interact))

/obj/item/mod/module/auto_doc/on_uninstall(deleting)
	. = ..()
	UnregisterSignal(mod, COMSIG_ATOM_ATTACKBY)

/obj/item/mod/module/auto_doc/attackby(obj/item/attacking_item, mob/user, params)
	if(charge_boost(attacking_item, user))
		return TRUE
	return ..()

/obj/item/mod/module/auto_doc/proc/on_item_interact(datum/source, mob/user, obj/item/thing, params)
	SIGNAL_HANDLER

	if(charge_boost(thing, user))
		return COMPONENT_NO_AFTERATTACK

	return NONE

/// Drawbacks to make this module less self-sufficient and so it feels "balanced" (there's no balance).
/obj/item/mod/module/auto_doc/proc/boost_aftereffects(mob/affected_mob)
	if(!affected_mob)
		return

	mod.wearer.reagents.add_reagent(/datum/reagent/cryptobiolin, 10)
	mod.wearer.reagents.add_reagent(/datum/reagent/drug/maint/sludge, 5)
	to_chat(affected_mob, span_danger("Sua cabeça começa a girar ligeiramente, e seu peito dói."))

/// Not exactly a MODsuit thing but it's needed for the refills huh?
/obj/item/reagent_containers/cup/glass/waterbottle/large/cryptobiolin
	name = "bottle of cryptobiolin"
	desc = "Nada grita cortes de orçamento como fluido de terno engarrafado."
	list_reagents = list(/datum/reagent/cryptobiolin = 100)
