//Rather than assigning a security officer to each department, Skyrat departments get their own allied Guards!
//Most related code is in this file; uniform icons are in the relevant department's .dmi

//SORT ORDER: Sci, Generic, Med, Engi, Cargo, Serv

/*
	UNIFORMS
*/
/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat
	//Effectively the same as TG's blueshirt, including icon. The /skyrat path makes it easier for sorting.
	name = "science guard's uniform"

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/orderly
	name = "orderly uniform"
	desc = "Roupa branca com calças cinza por baixo. Esteja avisado, os usuários deste uniforme só podem aceitar o juramento de Hipócrates como uma sugestão."
	icon_state = "orderly_uniform"
	worn_icon_state = "orderly_uniform"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/medical.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/medical.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/medical_digi.dmi'

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/engineering_guard
	name = "engineering guard uniform"
	desc = "Efetivamente apenas acolchoados hi-vis macacões, eles fazem o truque tanto dentro de, e enquanto mantendo as pessoas fora, uma zona de Hardhat."
	icon_state = "engineering_guard_uniform"
	worn_icon_state = "engineering_guard_uniform"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/engineering.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/engineering.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/engineering_digi.dmi'

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/customs_agent
	name = "customs agent uniform"
	desc = "Uma camisa de manga curta marrom, e shorts de carga em uma cor de carvão. Só para as melhores mãos fortes da FTU."
	icon_state = "customs_uniform"
	worn_icon_state = "customs_uniform"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/cargo.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/cargo.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/cargo_digi.dmi'

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/bouncer
	name = "bouncer uniform"
	desc = "Mangas curtas e jeans, para aquela aura de legal que faz as pessoas bêbadas ouvirem."
	icon_state = "bouncer"
	worn_icon_state = "bouncer"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/civilian.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian_digi.dmi'

/*
	SUITS
*/
/obj/item/clothing/suit/armor/vest/blueshirt/skyrat
	//Effectively the same as TG's blueshirt, including icon. The /skyrat path makes it easier for sorting.
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/guard //Badge-less version of the blueshirt vest
	icon_state = "guard_armor"
	worn_icon_state = "guard_armor"

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/orderly
	name = "armored orderly coat"
	desc = "Um casaco blindado, de azul paramédico. Vai mantê-lo acolchoado enquanto lida com pacientes problemáticos."
	icon_state = "medical_coat"
	worn_icon_state = "medical_coat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/engineering_guard
	name = "armored engineering guard coat"
	desc = "Um casaco blindado cujas tiras de perigo são usadas ao ponto de inutilidade. Vai mantê-lo protegido enquanto limpa zonas de perigo, pelo menos."
	icon_state = "engineering_coat"
	worn_icon_state = "engineering_coat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/customs_agent
	name = "armored customs agent coat"
	desc = "Um casaco blindado, com padrões e detalhes intrincados. Isso deve te ajudar a evitar clientes indisciplinados."
	icon_state = "customs_coat"
	worn_icon_state = "customs_coat"

/*
	HEAD
*/
/obj/item/clothing/head/helmet/blueshirt/skyrat
	//Effectively the same as TG's blueshirt, including icon. The /skyrat path makes it easier for sorting.
	//The base one is used for science guards, and the sprite is unchanged

/obj/item/clothing/head/helmet/blueshirt/skyrat/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/head/helmet/blueshirt/skyrat/guard //Version of the blueshirt helmet without a blue line. Used by all dept guards right now.
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/helmet.dmi'
	icon_state = "mallcop_helm"
	worn_icon_state = "mallcop_helm"

/obj/item/clothing/head/beret/sec/science
	name = "science guard beret"
	desc = "Uma boina robusta com um frasco Erlenmeyer gravado nele. Usa tecido reforçado para oferecer proteção suficiente."
	icon_state = "/obj/item/clothing/head/beret/sec/science"
	post_init_icon_state = "beret_badge"
	greyscale_colors = "#8D008F#F2F2F2"

/obj/item/clothing/head/beret/sec/medical
	name = "medical officer beret"
	desc = "Uma boina robusta com uma insígnia médica. Usa tecido reforçado para oferecer proteção suficiente."
	icon_state = "/obj/item/clothing/head/beret/sec/medical"
	greyscale_colors = "#16313D#F2F2F2" //Paramed blue to (mostly) match their vest (as opposed to medical white)

/obj/item/clothing/head/beret/sec/engineering
	name = "engineer officer beret"
	desc = "Uma boina robusta com um símbolo de perigo gravado nela. Usa tecido reforçado para oferecer proteção suficiente."
	icon_state = "/obj/item/clothing/head/beret/sec/engineering"
	greyscale_colors = "#FFBC30#F2F2F2"

/obj/item/clothing/head/beret/sec/cargo
	name = "cargo officer beret"
	desc = "Uma boina robusta com uma cratera embutida nela. Usa tecido reforçado para oferecer proteção suficiente."
	icon_state = "/obj/item/clothing/head/beret/sec/cargo"
	greyscale_colors = "#c99840#F2F2F2"

/obj/item/clothing/head/beret/sec/service
	name = "bouncer beret"
	desc = "Uma boina robusta com um simples distintivo gravado nela. Usa tecido reforçado para oferecer proteção suficiente."
	icon_state = "/obj/item/clothing/head/beret/sec/service"
	greyscale_colors = "#5E8F2D#F2F2F2"

/*
	LANDMARKS
*/
/obj/effect/landmark/start/science_guard
	name = "Science Guard"
	icon_state = "Science Guard"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

/obj/effect/landmark/start/orderly
	name = "Orderly"
	icon_state = "Orderly"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

/obj/effect/landmark/start/engineering_guard
	name = "Engineering Guard"
	icon_state = "Engineering Guard"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

/obj/effect/landmark/start/customs_agent
	name = "Customs Agent"
	icon_state = "Customs Agent"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

/obj/effect/landmark/start/bouncer
	name = "Bouncer"
	icon_state = "Bouncer"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

/*
	SCIENCE GUARD DATUMS
*/
/datum/job/science_guard
	title = JOB_SCIENCE_GUARD
	rpg_title = "Guarda-Segredos"
	description = "Descobrir por que os e-mails não estão funcionando, ficar de olho nos intelectuais, protegê-los de seus últimos erros."
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = SUPERVISOR_RD
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "SCIENCE_GUARD"

	outfit = /datum/outfit/job/science_guard
	plasmaman_outfit = /datum/outfit/plasmaman/science

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SCI

	display_order = JOB_DISPLAY_ORDER_SCIENCE_GUARD
	bounty_types = CIV_JOB_SCI
	departments_list = list(
		/datum/job_department/science,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec/science)

	mail_goodies = list(
	/obj/item/food/donut/caramel = 10,
	/obj/item/food/donut/matcha = 10,
	/obj/item/food/donut/blumpkin = 5,
	/obj/item/clothing/mask/whistle = 10,
	/obj/item/melee/baton = 5
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN

/datum/outfit/job/science_guard
	name = "Science Guard"
	jobtype = /datum/job/science_guard

	belt = /obj/item/modular_computer/pda/science
	ears = /obj/item/radio/headset/headset_sci
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat
	shoes = /obj/item/clothing/shoes/jackboots
	head =  /obj/item/clothing/head/beret/sec/science
	suit = /obj/item/clothing/suit/armor/vest/alt
	r_pocket = /obj/item/reagent_containers/spray/pepper
	l_pocket = /obj/item/restraints/handcuffs
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded/departmental/science = 1,
		/obj/item/security_voucher/primary = 1,
		/obj/item/holosign_creator/security = 1
	)

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/science
	duffelbag = /obj/item/storage/backpack/duffelbag/science
	messenger = /obj/item/storage/backpack/messenger/science

	id_trim = /datum/id_trim/job/science_guard

/datum/id_trim/job/science_guard
	assignment = "Science Guard"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_calhoun"
	department_color = COLOR_SCIENCE_PINK
	subdepartment_color = COLOR_SCIENCE_PINK
	sechud_icon_state = SECHUD_SCIENCE_GUARD
	extra_access = list(
		ACCESS_AUX_BASE,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_GENETICS,
		ACCESS_MECH_SCIENCE,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_ORDNANCE,
		ACCESS_ORDNANCE_STORAGE,
		ACCESS_RESEARCH,
		ACCESS_ROBOTICS,
		ACCESS_SCIENCE,
		ACCESS_SECURITY,
		ACCESS_TECH_STORAGE,
		ACCESS_WEAPONS,
		ACCESS_XENOBIOLOGY,
	)
	minimal_access = list(
		ACCESS_AUX_BASE,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_GENETICS,
		ACCESS_MECH_SCIENCE,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_ORDNANCE,
		ACCESS_ORDNANCE_STORAGE,
		ACCESS_RESEARCH,
		ACCESS_ROBOTICS,
		ACCESS_SCIENCE,
		ACCESS_SECURITY,
		ACCESS_TECH_STORAGE,
		ACCESS_WEAPONS,
		ACCESS_XENOBIOLOGY,
	)
	template_access = list(ACCESS_CAPTAIN, ACCESS_RD, ACCESS_CHANGE_IDS)
	job = /datum/job/science_guard

/*
	MEDICAL GUARD DATUMS
*/
/datum/job/orderly
	title = JOB_ORDERLY
	rpg_title = "Praetorian"
	description = "Defender o departamento médico, prender idiotas que recusam a vacina, ajudar médicos com preparação e/ou limpeza."
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = SUPERVISOR_CMO
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "ORDERLY"

	outfit = /datum/outfit/job/orderly
	plasmaman_outfit = /datum/outfit/plasmaman/medical

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_MED

	display_order = JOB_DISPLAY_ORDER_ORDERLY
	bounty_types = CIV_JOB_MED
	departments_list = list(
		/datum/job_department/medical,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec/medical)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 10,
		/obj/item/melee/baton = 5
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN

/datum/outfit/job/orderly
	name = "Orderly"
	jobtype = /datum/job/orderly

	belt = /obj/item/modular_computer/pda/medical
	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/orderly
	shoes = /obj/item/clothing/shoes/sneakers/white
	head = /obj/item/clothing/head/beret/sec/medical
	glasses = /obj/item/clothing/glasses/hud/medsechud/sunglasses
	suit = /obj/item/clothing/suit/armor/vest/blueshirt/skyrat/orderly
	r_pocket = /obj/item/reagent_containers/spray/pepper
	l_pocket = /obj/item/restraints/handcuffs
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded/departmental/medical = 1,
		/obj/item/security_voucher/primary = 1,
		/obj/item/holosign_creator/security = 1
	)

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	messenger = /obj/item/storage/backpack/messenger/med
	box = /obj/item/storage/box/survival/medical

	id_trim = /datum/id_trim/job/orderly

/datum/id_trim/job/orderly
	assignment = "Orderly"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_orderly"
	department_color = COLOR_MEDICAL_BLUE
	subdepartment_color = COLOR_MEDICAL_BLUE
	sechud_icon_state = SECHUD_ORDERLY
	extra_access = list(
		ACCESS_BRIG_ENTRANCE,
		ACCESS_MECH_MEDICAL,
		ACCESS_MEDICAL,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MORGUE,
		ACCESS_PARAMEDIC,
		ACCESS_PHARMACY,
		ACCESS_PLUMBING,
		ACCESS_SECURITY,
		ACCESS_SURGERY,
		ACCESS_VIROLOGY,
		ACCESS_WEAPONS,
		ACCESS_MORGUE_SECURE,
		ACCESS_PSYCHOLOGY,
	)
	minimal_access = list(
		ACCESS_BRIG_ENTRANCE,
		ACCESS_MECH_MEDICAL,
		ACCESS_MEDICAL,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MORGUE,
		ACCESS_PARAMEDIC,
		ACCESS_PHARMACY,
		ACCESS_PLUMBING,
		ACCESS_SECURITY,
		ACCESS_SURGERY,
		ACCESS_VIROLOGY,
		ACCESS_WEAPONS,
		ACCESS_MORGUE_SECURE,
		ACCESS_PSYCHOLOGY,
	)
	template_access = list(ACCESS_CAPTAIN, ACCESS_CMO, ACCESS_CHANGE_IDS)
	job = /datum/job/orderly

/*
	ENGINEERING GUARD DATUMS
*/
/datum/job/engineering_guard
	title = JOB_ENGINEERING_GUARD
	rpg_title = "Guardião de Cristal"
	description = "Monitore a supermatéria, vigie a atmosfera, certifique-se de que todos estejam usando equipamentos de proteção adequados."
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = SUPERVISOR_CE
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "ENGINEERING_GUARD"

	outfit = /datum/outfit/job/engineering_guard
	plasmaman_outfit = /datum/outfit/plasmaman/engineering

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_ENG

	display_order = JOB_DISPLAY_ORDER_ENGINEER_GUARD
	bounty_types = CIV_JOB_ENG
	departments_list = list(
		/datum/job_department/engineering,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec/engineering)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 10,
		/obj/item/melee/baton = 5
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN

/datum/outfit/job/engineering_guard
	name = "Engineering Guard"
	jobtype = /datum/job/engineering_guard

	belt = /obj/item/modular_computer/pda/engineering
	ears = /obj/item/radio/headset/headset_eng
	shoes = /obj/item/clothing/shoes/workboots
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/engineering_guard
	head =  /obj/item/clothing/head/beret/sec/engineering
	suit = /obj/item/clothing/suit/armor/vest/blueshirt/skyrat/engineering_guard
	r_pocket = /obj/item/reagent_containers/spray/pepper
	l_pocket = /obj/item/restraints/handcuffs
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded/departmental/engineering = 1,
		/obj/item/security_voucher/primary = 1,
		/obj/item/holosign_creator/security = 1
	)

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	messenger = /obj/item/storage/backpack/messenger/eng
	box = /obj/item/storage/box/survival/engineer

	id_trim = /datum/id_trim/job/engineering_guard

/datum/id_trim/job/engineering_guard
	assignment = "Engineering Guard"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_engiguard"
	department_color = COLOR_ENGINEERING_ORANGE
	subdepartment_color = COLOR_ENGINEERING_ORANGE
	sechud_icon_state = SECHUD_ENGINEERING_GUARD
	extra_access = list(
		ACCESS_ATMOSPHERICS,
		ACCESS_AUX_BASE,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_CONSTRUCTION,
		ACCESS_ENGINEERING,
		ACCESS_ENGINE_EQUIP,
		ACCESS_EXTERNAL_AIRLOCKS,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MECH_ENGINE,
		ACCESS_SECURITY,
		ACCESS_TCOMMS,
		ACCESS_TECH_STORAGE,
		ACCESS_WEAPONS,
	)
	minimal_access = list(
		ACCESS_ATMOSPHERICS,
		ACCESS_AUX_BASE,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_CONSTRUCTION,
		ACCESS_ENGINEERING,
		ACCESS_ENGINE_EQUIP,
		ACCESS_EXTERNAL_AIRLOCKS,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MECH_ENGINE,
		ACCESS_SECURITY,
		ACCESS_TCOMMS,
		ACCESS_TECH_STORAGE,
		ACCESS_WEAPONS,
	)
	template_access = list(ACCESS_CAPTAIN, ACCESS_CE, ACCESS_CHANGE_IDS)
	job = /datum/job/engineering_guard

/*
	CARGO GUARD DATUMS
*/
/datum/job/customs_agent
	title = JOB_CUSTOMS_AGENT
	rpg_title = "Cofre"
	description = "Inspecione os pacotes vindos e vindos da estação, proteja o departamento de carga, espanque pessoas tentando enviar cocaína para a Coalizão Estelar Spinward."
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = SUPERVISOR_QM
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "CUSTOMS_AGENT"

	outfit = /datum/outfit/job/customs_agent
	plasmaman_outfit = /datum/outfit/plasmaman/cargo

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_CAR

	display_order = JOB_DISPLAY_ORDER_CUSTOMS_AGENT
	bounty_types = CIV_JOB_RANDOM
	departments_list = list(
		/datum/job_department/cargo,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec/cargo)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 10,
		/obj/item/melee/baton = 5
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN

/datum/outfit/job/customs_agent
	name = "Customs Agent"
	jobtype = /datum/job/customs_agent

	belt = /obj/item/modular_computer/pda/cargo
	ears = /obj/item/radio/headset/headset_cargo
	shoes = /obj/item/clothing/shoes/sneakers/black
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/customs_agent
	head = /obj/item/clothing/head/beret/sec/cargo
	suit = /obj/item/clothing/suit/armor/vest/blueshirt/skyrat/customs_agent
	glasses = /obj/item/clothing/glasses/hud/gun_permit
	r_pocket = /obj/item/reagent_containers/spray/pepper
	l_pocket = /obj/item/restraints/handcuffs
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded/departmental/cargo = 1,
		/obj/item/security_voucher/primary = 1,
		/obj/item/holosign_creator/security = 1
	)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	messenger = /obj/item/storage/backpack/messenger

	id_trim = /datum/id_trim/job/customs_agent

/datum/id_trim/job/customs_agent
	assignment = "Customs Agent"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_customs"
	department_color = COLOR_CARGO_BROWN
	subdepartment_color = COLOR_CARGO_BROWN
	sechud_icon_state = SECHUD_CUSTOMS_AGENT
	extra_access = list(
		ACCESS_BRIG_ENTRANCE,
		ACCESS_CARGO,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MECH_MINING,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MINING,
		ACCESS_MINING_STATION,
		ACCESS_SECURITY,
		ACCESS_SHIPPING,
		ACCESS_BIT_DEN,
		ACCESS_WEAPONS,
	)
	minimal_access = list(
		ACCESS_BRIG_ENTRANCE,
		ACCESS_CARGO,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MECH_MINING,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MINING,
		ACCESS_MINING_STATION,
		ACCESS_SECURITY,
		ACCESS_SHIPPING,
		ACCESS_BIT_DEN,
		ACCESS_WEAPONS,
	)
	template_access = list(ACCESS_CAPTAIN, ACCESS_QM, ACCESS_CHANGE_IDS)
	job = /datum/job/customs_agent

/*
	SERVICE GUARD DATUMS
*/
/datum/job/bouncer
	title = JOB_BOUNCER
	rpg_title = "Tavern Watch"
	description = "Certifique-se de que as pessoas não pulem o balcão da cozinha, parar o vandalismo da Chapel, verificar as identidades do Bargoer, evitar o temido\"Luta de comida\"."
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = SUPERVISOR_HOP
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "BOUNCER"

	outfit = /datum/outfit/job/bouncer
	plasmaman_outfit = /datum/outfit/plasmaman/party_bouncer

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SRV

	display_order = JOB_DISPLAY_ORDER_BOUNCER
	bounty_types = CIV_JOB_DRINK
	departments_list = list(
		/datum/job_department/service,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec/service)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 10,
		/obj/item/melee/baton = 5
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN

/datum/outfit/job/bouncer
	name = "Bouncer"
	jobtype = /datum/job/bouncer

	belt = /obj/item/modular_computer/pda/bar
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/bouncer
	shoes = /obj/item/clothing/shoes/sneakers/black
	head =  /obj/item/clothing/head/beret/sec/service
	suit = /obj/item/clothing/suit/armor/vest/alt
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/reagent_containers/spray/pepper
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded/departmental/service = 1,
		/obj/item/security_voucher/primary = 1,
		/obj/item/holosign_creator/security = 1
	)
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	messenger = /obj/item/storage/backpack/messenger

	id_trim = /datum/id_trim/job/bouncer

/datum/id_trim/job/bouncer
	assignment = "Bouncer"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_bouncer"
	department_color = COLOR_SERVICE_LIME
	subdepartment_color = COLOR_SERVICE_LIME // Personally speaking I'd have one of these with sec colors but I'm being authentic
	sechud_icon_state = SECHUD_BOUNCER
	extra_access = list(
		ACCESS_BAR,
		ACCESS_SERVICE,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_HYDROPONICS,
		ACCESS_KITCHEN,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MORGUE,
		ACCESS_SECURITY,
		ACCESS_THEATRE,
		ACCESS_WEAPONS,
		ACCESS_JANITOR,
	)
	minimal_access = list(
		ACCESS_BAR,
		ACCESS_SERVICE,
		ACCESS_BRIG_ENTRANCE,
		ACCESS_HYDROPONICS,
		ACCESS_KITCHEN,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MORGUE,
		ACCESS_SECURITY,
		ACCESS_THEATRE,
		ACCESS_WEAPONS,
		ACCESS_JANITOR,
	)
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOP, ACCESS_CHANGE_IDS)
	job = /datum/job/bouncer

/*
	Departmental Batons
*/
/obj/item/melee/baton/security/loaded/departmental
	name = "departmental stun baton"
	desc = "Um bastão de choque equipado com um bloqueio de área do departamento, baseado na planta da estação - fora de seu departamento, ele só tem três usos."
	icon = 'modular_skyrat/modules/goofsec/icons/departmental_batons.dmi'
	icon_state = "prison_baton" // We're abstract anyhow
	base_inhand_state = "stunbaton"
	var/list/valid_areas = list()
	var/emagged = FALSE
	var/non_departmental_uses_left = 4

/obj/item/melee/baton/security/loaded/departmental/pre_attack(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(. || !isliving(target))
		return .

	if(!active)
		return .

	var/area/current_area = get_area(user)
	if(emagged || is_type_in_list(current_area, valid_areas))
		return .

	if(non_departmental_uses_left)
		if(--non_departmental_uses_left)
			say("[non_departmental_uses_left] non-departmental uses left!")
		else
			say("[src] is out of non-departmental uses! Return to your department and reactivate the baton to refresh it!")
		return .

	target.visible_message(span_warning("[user]Golpes.[target]Com[src]Felizmente, foi desligado por estar na área errada."), 						span_warning("[user]Te cutuca com[src]Felizmente, foi desligado por estar na área errada."))
	turn_off()
	balloon_alert(user, "Departamento Erado.")
	return TRUE

/obj/item/melee/baton/security/loaded/departmental/attack_self(mob/user)
	. = ..()
	if(active) // just turned on
		var/area/current_area = get_area(user)
		if(!is_type_in_list(current_area, valid_areas))
			return
		if(non_departmental_uses_left < 4)
			say("Non-departmental uses refreshed!")
			non_departmental_uses_left = 4

/obj/item/melee/baton/security/loaded/departmental/emag_act(mob/user)
	if(!emagged)
		if(user)
			user.visible_message(span_warning("As faíscas voam de[src]!"),
							span_warning("Você se mexe.[src]Fechamento do departamento, permitir que seja usado livre!"),
							span_hear("Você ouve uma fraca faísca elétrica."))
		balloon_alert(user, "emagged")
		playsound(src, SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		obj_flags |= EMAGGED
		emagged = TRUE
		return TRUE
	return FALSE

/obj/item/melee/baton/security/loaded/departmental/medical
	name = "medical stun baton"
	desc = "Um bastão de choque que não funciona fora do departamento médico, baseado na planta da estação. Pode ser usado fora do hospital até três vezes antes de precisar voltar!"
	base_icon_state = "medical_baton"
	valid_areas = list(/area/station/medical, /area/station/maintenance/department/medical, /area/shuttle/escape)

/obj/item/melee/baton/security/loaded/departmental/engineering
	name = "engineering stun baton"
	desc = "Um bastão de choque que não funciona fora do departamento de engenharia, baseado na planta da estação. Pode ser usado fora da Engenharia até três vezes antes de precisar voltar!"
	base_icon_state = "engineering_baton"
	valid_areas = list(/area/station/engineering, /area/station/maintenance/department/engine, /area/shuttle/escape)

/obj/item/melee/baton/security/loaded/departmental/science
	name = "science stun baton"
	desc = "Um bastão de choque que não funciona fora do Departamento de Ciência, baseado na planta da estação. Pode ser usado fora da Ciência até três vezes antes de precisar voltar!"
	base_icon_state = "science_baton"
	valid_areas = list(/area/station/science, /area/station/maintenance/department/science, /area/shuttle/escape)

/obj/item/melee/baton/security/loaded/departmental/cargo
	name = "cargo stun baton"
	desc = "Um bastão de choque que não funciona fora do departamento de carga, baseado no esquema da estação. Pode ser usado fora da carga até três vezes antes de precisar voltar!"
	base_icon_state = "cargo_baton"
	valid_areas = list(/area/station/cargo, /area/station/maintenance/department/cargo, /area/shuttle/escape)

/obj/item/melee/baton/security/loaded/departmental/service
	name = "service stun baton"
	desc = "Um bastão de choque que não funciona fora do Departamento de Serviço, baseado na planta da estação. Pode ser usado fora do Serviço até três vezes antes de precisar voltar!"
	base_icon_state = "service_baton"
	valid_areas = list(/area/station/service, /area/station/hallway/secondary/service, /area/station/maintenance/department/chapel, /area/station/maintenance/department/crew_quarters, /area/shuttle/escape)

/obj/item/melee/baton/security/loaded/departmental/prison
	name = "prison stun baton"
	desc = "Um bastão de choque que não funciona fora da prisão, baseado na planta da estação. Pode ser usado fora da prisão até três vezes antes de precisar voltar!"
	base_icon_state = "prison_baton"
	valid_areas = list(/area/station/security/prison, /area/station/security/processing, /area/shuttle/escape)

/datum/supply_pack/security/baton_prison
	name = "Prison Baton Crate"
	desc = "Contém um bastão extra para agentes penitenciários. Caso odeie a ideia de um bastão normal nas mãos deles."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	access = ACCESS_SECURITY
	contains = list(/obj/item/melee/baton/security/loaded/departmental/prison)

/datum/supply_pack/service/baton_service
	name = "Service Baton Crate"
	desc = "Contém um bastão extra para Guardas de Serviço."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	access = ACCESS_SECURITY
	contains = list(/obj/item/melee/baton/security/loaded/departmental/service)

/datum/supply_pack/medical/baton_medical
	name = "Medical Baton Crate"
	desc = "Contém um bastão extra para Orderlies."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	access = ACCESS_SECURITY
	contains = list(/obj/item/melee/baton/security/loaded/departmental/medical)

/datum/supply_pack/engineering/baton_engineering
	name = "Engineering Baton Crate"
	desc = "Contém um bastão extra para a Guarda de Engenharia."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	access = ACCESS_SECURITY
	contains = list(/obj/item/melee/baton/security/loaded/departmental/engineering)

/datum/supply_pack/science/baton_science
	name = "Science Baton Crate"
	desc = "Contém um bastão extra para a Guarda Científica."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	access = ACCESS_SECURITY
	contains = list(/obj/item/melee/baton/security/loaded/departmental/science)

/datum/supply_pack/misc/baton_cargo
	name = "Cargo Baton Crate"
	desc = "Contém um bastão extra para agentes da alfândega."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	access = ACCESS_SECURITY
	contains = list(/obj/item/melee/baton/security/loaded/departmental/cargo)
/*
* Garment Bags
*/

/obj/item/storage/bag/garment/science_guard
	name = "science guard's garments"
	desc = "Um saco para guardar roupas e sapatos extras. Este pertence ao guarda científico."

/obj/item/storage/bag/garment/science_guard/PopulateContents()
	generate_items_inside(list(
		/obj/item/radio/headset/headset_sci = 2,
		/obj/item/clothing/shoes/sneakers/black = 2,
		/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat = 2,
		/obj/item/clothing/head/helmet/blueshirt/skyrat = 2,
		/obj/item/clothing/head/beret/sec/science = 2,
		/obj/item/clothing/suit/armor/vest/blueshirt/skyrat = 2,
		/obj/item/clothing/suit/toggle/labcoat/technical/science/guard = 1,
		/obj/item/clothing/glasses/hud/security = 2,
	), src)

/obj/item/storage/bag/garment/orderly
	name = "orderly's garments"
	desc = "Um saco para guardar rosas e sapos extras. Esta pertence ao enfermeiro."

/obj/item/storage/bag/garment/orderly/PopulateContents()
	generate_items_inside(list(
		/obj/item/radio/headset/headset_med = 1,
		/obj/item/clothing/shoes/sneakers/white = 1,
		/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/orderly = 1,
		/obj/item/clothing/head/helmet/blueshirt/skyrat/guard = 1,
		/obj/item/clothing/head/beret/sec/medical = 1,
		/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/orderly = 1,
		/obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic = 1,
		/obj/item/clothing/suit/toggle/labcoat/technical/medical/guard = 1,
		/obj/item/clothing/suit/toggle/labcoat/technical/medical/dark/guard = 1,
		/obj/item/clothing/suit/toggle/labcoat/technical/medical/black/guard = 1,
		/obj/item/clothing/under/rank/security/peacekeeper/miniskirt = 1,
		/obj/item/clothing/glasses/hud/medsechud = 1,
	), src)

/obj/item/storage/bag/garment/engineering_guard
	name = "engineering guard's garments"
	desc = "Um saco para guardar rosas e sapos extras. Esta pertence ao guarda de engenharia."

/obj/item/storage/bag/garment/engineering_guard/PopulateContents()
	generate_items_inside(list(
		/obj/item/radio/headset/headset_eng = 2,
		/obj/item/clothing/shoes/workboots = 2,
		/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/engineering_guard = 2,
		/obj/item/clothing/head/helmet/blueshirt/skyrat/guard = 2,
		/obj/item/clothing/head/beret/sec/engineering = 2,
		/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/engineering_guard = 2,
		/obj/item/clothing/suit/toggle/labcoat/technical/engineer/guard = 1,
		/obj/item/clothing/glasses/hud/security = 2,
	), src)

/obj/item/storage/bag/garment/customs_agent
	name = "customs agent's garments"
	desc = "Um saco para guardar roupas e sapatos extras. Este pertence ao agente da alfândega."

/obj/item/storage/bag/garment/customs_agent/PopulateContents()
	generate_items_inside(list(
		/obj/item/radio/headset/headset_cargo = 2,
		/obj/item/clothing/shoes/sneakers/black = 2,
		/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/customs_agent = 2,
		/obj/item/clothing/head/helmet/blueshirt/skyrat/guard = 2,
		/obj/item/clothing/head/beret/sec/cargo = 2,
		/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/customs_agent = 2,
		/obj/item/clothing/suit/toggle/labcoat/technical/cargo/guard = 1,
		/obj/item/clothing/glasses/hud/security = 2,
		/obj/item/clothing/glasses/hud/gun_permit = 2,
	), src)
