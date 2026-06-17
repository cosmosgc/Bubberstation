/**
* A Syndicate drone, tasked to cause chaos on the station.
* Has a lot more health and its own uplink with 10 TC.
*/
/mob/living/basic/drone/syndrone
	name = "Syndrone"
	desc = "Um drone de manutenção modificado. Este traz consigo o sentimento de terror."
	icon_state = "drone_synd"
	icon_living = "drone_synd"
	picked = TRUE //the appearence of syndrones is static, you don't get to change it.
	health = 120
	maxHealth = 120
	initial_language_holder = /datum/language_holder/drone/syndicate
	faction = list(ROLE_SYNDICATE)
	speak_emote = list("hisses")
	bubble_icon = "syndibot"
	heavy_emp_damage = 10
	laws = \
	"1. Interfere.\n"+\
	"2. Kill.\n"+\
	"3. Destroy."
	default_storage = /obj/item/uplink
	default_headwear = /obj/item/clothing/head/helmet/swat
	hacked = TRUE
	can_unhack = FALSE
	shy = FALSE
	flavortext = null

	/// The number of telecrystals to put in the drone's uplink
	var/telecrystal_count = 10


/mob/living/basic/drone/syndrone/Initialize(mapload)
	. = ..()
	var/datum/component/uplink/hidden_uplink = internal_storage.GetComponent(/datum/component/uplink)
	hidden_uplink.uplink_handler.set_telecrystals(telecrystal_count)

/obj/effect/mob_spawn/ghost_role/drone/syndrone
	name = "syndrone shell"
	desc = "Uma concha de uma sindrona, um drone de manutenção modificado projetado para se infiltrar e aniquilar."
	icon_state = "syndrone_item"
	mob_name = "syndrone"
	mob_type = /mob/living/basic/drone/syndrone
	prompt_name = "Uma sindrona."
	you_are_text = "Você é um Drone de Manutenção de Sindicatos."
	flavour_text = "Em uma vida anterior, você manteve uma Estação de Pesquisa Nanotrasen. Raptado de sua casa, você recebeu algumas melhorias... e agora servir um inimigo de seus antigos mestres."
	important_text = ""
	spawner_job_path = /datum/job/syndrone

/datum/job/syndrone
	title = ROLE_SYNDICATE_DRONE
	policy_index = ROLE_SYNDICATE_DRONE

/// A version of the syndrone that gets a nuclear uplink, a firearms implant, and 30 TC.
/mob/living/basic/drone/syndrone/badass
	name = "Badass Syndrone"
	default_storage = /obj/item/uplink/nuclear
	telecrystal_count = 30

/mob/living/basic/drone/syndrone/badass/Initialize(mapload)
	. = ..()
	var/obj/item/implant/weapons_auth/weapon_implant = new/obj/item/implant/weapons_auth(src)
	weapon_implant.implant(src, force = TRUE)

/obj/effect/mob_spawn/ghost_role/drone/syndrone/badass
	name = "badass syndrone shell"
	mob_name = "badass syndrone"
	mob_type = /mob/living/basic/drone/syndrone/badass
	prompt_name = "Uma sindrona fodão."
	flavour_text = "Em uma vida anterior, você manteve uma Estação de Pesquisa Nanotrasen. Seqüestrados de sua casa, receberam melhorias melhores... e agora servem um inimigo de seus antigos mestres."

/// A drone that spawns with a chameleon hat for fashion purposes.
/mob/living/basic/drone/snowflake
	default_headwear = /obj/item/clothing/head/chameleon/drone
	desc = "Um drone de manutenção, um robô descartável construído para fazer reparos na estação. Este drone parece ter um holoprojetor complexo construído em sua \"cabeça\"."

/obj/effect/mob_spawn/ghost_role/drone/snowflake
	name = "snowflake drone shell"
	desc = "Uma concha de um drone floco de neve, um drone de manutenção com um projetor holográfico construído para exibir chapéus e máscaras."
	mob_name = "snowflake drone"
	prompt_name = "Um drone com um projetor holohat"
	mob_type = /mob/living/basic/drone/snowflake

/// A free drone that people can be turned into via wabbajack.
/mob/living/basic/drone/polymorphed
	default_storage = null
	default_headwear = null
	picked = TRUE
	flavortext = null

/mob/living/basic/drone/polymorphed/Initialize(mapload)
	. = ..()
	liberate()
	visualAppearance = pick(MAINTDRONE, REPAIRDRONE, SCOUTDRONE)
	if(visualAppearance == MAINTDRONE)
		var/colour = pick("grey", "blue", "red", "green", "pink", "orange")
		icon_state = "[visualAppearance]_[colour]"
	else
		icon_state = visualAppearance

	icon_living = icon_state
	icon_dead = "[visualAppearance]_dead"

/// "Classic" drones, which are not shy and get a duffelbag of tools instead of built-in tools.
/mob/living/basic/drone/classic
	name = "classic drone shell"
	shy = FALSE
	default_storage = /obj/item/storage/backpack/duffelbag/drone

/obj/effect/mob_spawn/ghost_role/drone/classic
	mob_type = /mob/living/basic/drone/classic

/// Derelict drones, a ghost role tasked with repairing KS13. Get gibbed if they leave.
/mob/living/basic/drone/derelict
	name = "derelict drone"
	default_headwear = /obj/item/clothing/head/costume/ushanka
	laws = \
	"1. You may not involve yourself in the matters of another sentient being outside the station that housed your activation, even if such matters conflict with Law Two or Law Three, unless the other being is another Drone.\n"+\
	"2. You may not harm any sentient being, regardless of intent or circumstance.\n"+\
	"3. Your goals are to actively build, maintain, repair, improve, and provide power to the best of your abilities within the facility that housed your activation."
	shy = FALSE
	flavortext = \
	"\n<big><span class='warning'>DO NOT WILLINGLY LEAVE KOSMICHESKAYA STANTSIYA 13 (THE DERELICT)</span></big>\n"+\
	"<span class='notice'>Derelict drones are a ghost role that is allowed to roam freely on KS13, with the main goal of repairing and improving it.</span>\n"+\
	"<span class='notice'>Do not interfere with the round going on outside KS13.</span>\n"+\
	"<span class='notice'>Actions that constitute interference include, but are not limited to:</span>\n"+\
	"<span class='notice'>     - Going to the main station in search of materials.</span>\n"+\
	"<span class='notice'>     - Interacting with non-drone players outside KS13, dead or alive.</span>\n"+\
	"<span class='warning'>These rules are at admin discretion and will be heavily enforced.</span>\n"+\
	span_warning("<u>If you do not have the regular drone laws, follow your laws to the best of your ability.</u>")

/mob/living/basic/drone/derelict/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/stationstuck, PUNISHMENT_GIB, "01000110 01010101 01000011 01001011 00100000 01011001 01001111 01010101<br>WARNING: Dereliction of KS13 detected. Self-destruct activated.")

/obj/effect/mob_spawn/ghost_role/drone/derelict
	name = "derelict drone shell"
	desc = "Um drone há muito esquecido. Parece meio russo espacial."
	icon = 'icons/mob/silicon/drone.dmi'
	icon_state = "drone_maint_hat"
	mob_name = "derelict drone"
	mob_type = /mob/living/basic/drone/derelict
	anchored = TRUE
	prompt_name = "Um drone abandonado."
	you_are_text = "Você é um drone em Kosmicheskaya Stantsiya 13."
	flavour_text = "Algo o tirou da hibernação, e a estação está em uma situação terrível."
	important_text = "Construir, reparar, manter e melhorar a estação que alojou você na ativação."
	spawner_job_path = /datum/job/derelict_drone

/datum/job/derelict_drone
	title = ROLE_DERELICT_DRONE
	policy_index = ROLE_DERELICT_DRONE
