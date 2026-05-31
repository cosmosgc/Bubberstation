// Wintercoat
/obj/item/clothing/suit/hooded/wintercoat
	name = "winter coat"
	desc = "Uma jaqueta pesada feita de peles de animais 'sintéticos'."
	icon = 'icons/obj/clothing/suits/wintercoat.dmi'
	icon_state = "coatwinter"
	worn_icon = 'icons/mob/clothing/suits/wintercoat.dmi'
	inhand_icon_state = "coatwinter"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	allowed = list()
	armor_type = /datum/armor/hooded_wintercoat
	hood_down_overlay_suffix = "_hood"
	/// How snug are we?
	var/zipped = FALSE
	/// Whether alt-clicking this coat zips/unzips it
	var/can_altclick_zip = TRUE

/datum/armor/hooded_wintercoat
	bio = 10

/obj/item/clothing/suit/hooded/wintercoat/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/flashlight,
		/obj/item/lighter,
		/obj/item/modular_computer/pda,
		/obj/item/radio,
		/obj/item/storage/bag/books,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/toy,
	)

/obj/item/clothing/suit/hooded/wintercoat/on_hood_up(obj/item/clothing/head/hooded/hood)
	. = ..()
	zipped = TRUE

/// Called when the hood is hidden
/obj/item/clothing/suit/hooded/wintercoat/on_hood_down(obj/item/clothing/head/hooded/hood)
	. = ..()
	zipped = FALSE

/obj/item/clothing/suit/hooded/wintercoat/examine(mob/user)
	. = ..()
	if(can_altclick_zip)
		. += span_notice("<b>Alt-click</b>Para[zipped ? "un" : ""]Zip.")


/obj/item/clothing/suit/hooded/wintercoat/click_alt(mob/user)
	if(!can_altclick_zip)
		return CLICK_ACTION_BLOCKING
	zipped = !zipped
	playsound(src, 'sound/items/zip/zip_up.ogg', 30, TRUE, -3)
	worn_icon_state = "[initial(post_init_icon_state) || initial(icon_state)][zipped ? "_t" : ""]"
	balloon_alert(user, "[zipped ? "" : "un"]zíper")

	if(ishuman(loc))
		var/mob/living/carbon/human/wearer = loc
		wearer.update_worn_oversuit()
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/head/hooded/winterhood
	name = "winter hood"
	desc = "Um capuz aconchegante preso a uma jaqueta de inverno pesada."
	icon = 'icons/obj/clothing/head/winterhood.dmi'
	icon_state = "hood_winter"
	worn_icon = 'icons/mob/clothing/head/winterhood.dmi'
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEEARS
	hair_mask = /datum/hair_mask/winterhood
	armor_type = /datum/armor/hooded_winterhood

// An coat intended for use for general crew EVA, with values close to those of the space suits found in EVA normally
// Slight extra armor, bulky size, slows you down, can carry a large oxygen tank, won't burn off.
/datum/armor/hooded_winterhood
	bio = 10

/obj/item/clothing/suit/hooded/wintercoat/eva
	name = "\proper Endotherm winter coat"
	desc = "Um casaco de inverno acolchoado para manter o usuário bem isolado, não importa as circunstâncias. Tem um arnês para um tanque de oxigênio maior preso na parte de trás."
	icon_state = "coateva"
	w_class = WEIGHT_CLASS_BULKY
	slowdown = 0.75
	armor_type = /datum/armor/wintercoat_eva
	strip_delay = 6 SECONDS
	equip_delay_other = 6 SECONDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT // Protects very cold.
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT // Protects a little hot.
	clothing_flags = THICKMATERIAL
	resistance_flags = NONE
	hoodtype = /obj/item/clothing/head/hooded/winterhood/eva

/datum/armor/wintercoat_eva
	melee = 10
	laser = 10
	energy = 10
	bio = 50
	fire = 50
	acid = 20

/obj/item/clothing/suit/hooded/wintercoat/eva/Initialize(mapload)
	. = ..()
	allowed += /obj/item/tank/internals

/obj/item/clothing/head/hooded/winterhood/eva
	name = "\proper Endotherm winter hood"
	desc = "Um capuz acolchoado preso a um casaco ainda mais grosso."
	icon_state = "hood_eva"
	armor_type = /datum/armor/winterhood_eva
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	clothing_flags = THICKMATERIAL|SNUG_FIT // Snug fit doesn't really matter, but might as well
	resistance_flags = NONE

// CentCom
/datum/armor/winterhood_eva
	melee = 10
	laser = 10
	energy = 10
	bio = 50
	fire = 50
	acid = 20

/obj/item/clothing/suit/hooded/wintercoat/centcom
	name = "centcom winter coat"
	desc = "Um luxuoso casaco de inverno tecido com cores verdes e douradas do Comando Central. Tem um pequeno pino na forma do logotipo Nanotrasen para um zíper."
	icon_state = "coatcentcom"
	inhand_icon_state = null
	armor_type = /datum/armor/wintercoat_centcom
	hoodtype = /obj/item/clothing/head/hooded/winterhood/centcom

/datum/armor/wintercoat_centcom
	melee = 35
	bullet = 40
	laser = 40
	energy = 50
	bomb = 35
	bio = 10
	fire = 10
	acid = 60

/obj/item/clothing/suit/hooded/wintercoat/centcom/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_wintercoat_allowed

/obj/item/clothing/head/hooded/winterhood/centcom
	icon_state = "hood_centcom"
	armor_type = /datum/armor/winterhood_centcom

// Captain
/datum/armor/winterhood_centcom
	melee = 35
	bullet = 40
	laser = 40
	energy = 50
	bomb = 35
	bio = 10
	fire = 10
	acid = 60

/obj/item/clothing/suit/hooded/wintercoat/captain
	name = "captain's winter coat"
	desc = "Um luxuoso casaco de inverno, recheado com o pássaro Uka em perigo e aparado com zibelina genuína. O tecido é uma microfibra indulgentemente macia, e a cor ultramarina profunda é apenas uma que poderia ser alcançada com minúsculas quantidades de pó cristalino do espaço azul tecido no fio entre os plectrums. Extremamente luxuoso, e extremamente durável."
	icon_state = "coatcaptain"
	inhand_icon_state = "coatcaptain"
	armor_type = /datum/armor/wintercoat_captain
	hoodtype = /obj/item/clothing/head/hooded/winterhood/captain

/datum/armor/wintercoat_captain
	melee = 25
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	acid = 50

/obj/item/clothing/suit/hooded/wintercoat/captain/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_wintercoat_allowed

/obj/item/clothing/head/hooded/winterhood/captain
	icon_state = "hood_captain"
	armor_type = /datum/armor/winterhood_captain

// Head of Personnel
/datum/armor/winterhood_captain
	melee = 25
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	acid = 50

/obj/item/clothing/suit/hooded/wintercoat/hop
	name = "head of personnel's winter coat"
	desc = "Um casaco de inverno aconchegante, coberto de pele grossa. O peito apresenta um Chevron amarelo orgulhoso, lembrando a todos que você é a segunda banana."
	icon_state = "coathop"
	inhand_icon_state = null
	armor_type = /datum/armor/wintercoat_hop
	allowed = list(
		/obj/item/melee/baton/telescopic,
		/obj/item/stamp,
	)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/hop

/datum/armor/wintercoat_hop
	melee = 10
	bullet = 15
	laser = 15
	energy = 25
	bomb = 10
	acid = 35

/obj/item/clothing/suit/hooded/wintercoat/hop/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_wintercoat_allowed

/obj/item/clothing/head/hooded/winterhood/hop
	icon_state = "hood_hop"
	armor_type =/datum/armor/wintercoat_hop

// Botanist
/obj/item/clothing/suit/hooded/wintercoat/hydro
	name = "hydroponics winter coat"
	desc = "Um casaco de inverno verde e azul. A guia do zíper parece a flor de um membro de Rosa Hesperrhodos, uma rosa rosa e branca. As cores se chocam."
	icon_state = "coathydro"
	inhand_icon_state = "coathydro"
	allowed = /obj/item/clothing/suit/apron::allowed
	hoodtype = /obj/item/clothing/head/hooded/winterhood/hydro

/obj/item/clothing/head/hooded/winterhood/hydro
	desc = "Um casaco verde de inverno."
	icon_state = "hood_hydro"

// Janitor
/obj/item/clothing/suit/hooded/wintercoat/janitor
	name = "janitors winter coat"
	desc = "Um casaco de inverno roxo e bege que cheira a limpeza espacial."
	icon_state = "coatjanitor"
	inhand_icon_state = null
	allowed = list(
		/obj/item/access_key,
		/obj/item/grenade/chem_grenade,
		/obj/item/holosign_creator,
		/obj/item/key/janitor,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/spray,
	)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/janitor

/obj/item/clothing/head/hooded/winterhood/janitor
	desc = "Um capuz roxo que cheira a limpador de espaço."
	icon_state = "hood_janitor"

// Security Officer
/obj/item/clothing/suit/hooded/wintercoat/security
	name = "security winter jacket"
	desc = "Um casaco de inverno vermelho e blindado. Brilha com um leve revestimento ablativo e um ar robusto de autoridade. A aba do zíper é um par de algemas que ficam irritantes depois dos primeiros 10 segundos."
	icon_state = "coatsecurity"
	inhand_icon_state = "coatsecurity"
	armor_type = /datum/armor/wintercoat_security
	hoodtype = /obj/item/clothing/head/hooded/winterhood/security

/datum/armor/wintercoat_security
	melee = 25
	bullet = 15
	laser = 30
	energy = 40
	bomb = 25
	acid = 45

/obj/item/clothing/suit/hooded/wintercoat/security/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_wintercoat_allowed

/obj/item/clothing/head/hooded/winterhood/security
	desc = "Um capuz de inverno vermelho e blindado. Definitivamente não é à prova de balas, especialmente a parte em que seu rosto vai."
	icon_state = "hood_security"
	armor_type = /datum/armor/winterhood_security

// Medical Doctor
/datum/armor/winterhood_security
	melee = 25
	bullet = 15
	laser = 30
	energy = 40
	bomb = 25
	acid = 45

/obj/item/clothing/suit/hooded/wintercoat/medical
	name = "medical winter coat"
	desc = "Um casaco branco de inverno ártico com um pequeno caduceu azul em vez de um zíper de plástico. Snazzy."
	icon_state = "coatmedical"
	inhand_icon_state = "coatmedical"
	allowed = list(
		/obj/item/defibrillator/compact,
		/obj/item/flashlight/pen,
		/obj/item/gun/syringe,
		/obj/item/healthanalyzer,
		/obj/item/reagent_containers/applicator,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/syringe,
		/obj/item/sensor_device,
		/obj/item/storage/pill_bottle,
	)
	armor_type = /datum/armor/wintercoat_medical
	hoodtype = /obj/item/clothing/head/hooded/winterhood/medical

/datum/armor/wintercoat_medical
	bio = 40
	fire = 10
	acid = 20

/obj/item/clothing/head/hooded/winterhood/medical
	desc = "Um casaco branco de inverno."
	icon_state = "hood_medical"
	armor_type = /datum/armor/winterhood_medical

/datum/armor/winterhood_medical
	bio = 40
	fire = 10
	acid = 20

// Chief Medical Officer
/obj/item/clothing/suit/hooded/wintercoat/medical/cmo
	name = "chief medical officer's winter coat"
	desc = "Um casaco de inverno em um tom de azul vibrante com um pequeno caduceu de prata em vez de uma guia de fecho de plástico. O revestimento normal é substituído por uma camada excepcionalmente grossa e macia de pele."
	icon_state = "coatcmo"
	inhand_icon_state = null
	armor_type = /datum/armor/medical_cmo
	hoodtype = /obj/item/clothing/head/hooded/winterhood/medical/cmo

/datum/armor/medical_cmo
	bio = 50
	fire = 20
	acid = 30

/obj/item/clothing/suit/hooded/wintercoat/medical/cmo/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/melee/baton/telescopic,
		/obj/item/gun/energy/cell_loaded/medigun, //SKYRAT EDIT MEDIGUNS
	)

/obj/item/clothing/head/hooded/winterhood/medical/cmo
	desc = "Um casaco azul de inverno."
	icon_state = "hood_cmo"
	armor_type = /datum/armor/medical_cmo

// Chemist
/obj/item/clothing/suit/hooded/wintercoat/medical/chemistry
	name = "chemistry winter coat"
	desc = "Um casaco de inverno feito com polímeros resistentes a ácido. Para o químico empreendedor que foi exilado para um deserto congelado em movimento."
	icon_state = "coatchemistry"
	inhand_icon_state = null
	hoodtype = /obj/item/clothing/head/hooded/winterhood/medical/chemistry

/obj/item/clothing/suit/hooded/wintercoat/medical/chemistry/Initialize(mapload)
	. = ..()
	allowed += /obj/item/storage/bag/chemistry

/obj/item/clothing/head/hooded/winterhood/medical/chemistry
	desc = "Um casaco branco de inverno."
	icon_state = "hood_chemistry"

// Coroner
/obj/item/clothing/suit/hooded/wintercoat/medical/coroner
	name = "coroner winter coat"
	desc = "Um casaco de inverno feito com polímeros resistentes ao ácido, usado quando os corpos frios são demais."
	icon_state = "coatcoroner"
	inhand_icon_state = null
	hoodtype = /obj/item/clothing/head/hooded/winterhood/medical/coroner

/obj/item/clothing/suit/hooded/wintercoat/medical/coroner/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/autopsy_scanner,
		/obj/item/scythe,
		/obj/item/shovel,
		/obj/item/shovel/serrated,
		/obj/item/trench_tool,
	)

/obj/item/clothing/head/hooded/winterhood/medical/coroner
	desc = "Um casaco branco de inverno."
	icon_state = "hood_coroner"

// Virologist
/obj/item/clothing/suit/hooded/wintercoat/medical/viro
	name = "virology winter coat"
	desc = "Um casaco branco de inverno com marcas verdes. Quente, mas não vai lutar contra o resfriado comum ou qualquer outra doença. Pode fazer as pessoas ficarem longe de você no corredor. A guia do zíper parece um bacteriófago enorme."
	icon_state = "coatviro"
	inhand_icon_state = null
	hoodtype = /obj/item/clothing/head/hooded/winterhood/medical/viro

/obj/item/clothing/suit/hooded/wintercoat/medical/viro/Initialize(mapload)
	. = ..()
	allowed += /obj/item/storage/bag/bio

/obj/item/clothing/head/hooded/winterhood/medical/viro
	desc = "Um casaco branco de inverno com marcas verdes."
	icon_state = "hood_viro"

// Paramedic
/obj/item/clothing/suit/hooded/wintercoat/medical/paramedic
	name = "paramedic winter coat"
	desc = "Um casaco de inverno com marcas azuis. Quente, mas provavelmente não protegerá de agentes biológicos. Para o médico confortável em movimento."
	icon_state = "coatparamed"
	inhand_icon_state = null
	hoodtype = /obj/item/clothing/head/hooded/winterhood/medical/paramedic

/obj/item/clothing/suit/hooded/wintercoat/medical/paramedic/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -3) //mirrored from jacket
	allowed += /obj/item/crowbar/power/paramedic

/obj/item/clothing/head/hooded/winterhood/medical/paramedic
	desc = "Um capuz branco de casaco de inverno com marcas azuis."
	icon_state = "hood_paramed"

// Scientist
/obj/item/clothing/suit/hooded/wintercoat/science
	name = "science winter coat"
	desc = "Um casaco branco de inverno com um modelo atômico desatualizado em vez de um zíper de plástico."
	icon_state = "coatscience"
	inhand_icon_state = "coatscience"
	allowed = list(
		/obj/item/analyzer,
		/obj/item/dnainjector,
		/obj/item/paper,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/applicator/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/storage/bag/xeno,
		/obj/item/storage/pill_bottle,
	)
	armor_type = /datum/armor/wintercoat_science
	hoodtype = /obj/item/clothing/head/hooded/winterhood/science
	species_exception = list(/datum/species/golem)

/datum/armor/wintercoat_science
	bio = 10
	fire = 20

/obj/item/clothing/head/hooded/winterhood/science
	desc = "Um casaco branco de inverno. Este vai manter seu cérebro aquecido. Tanto quanto os outros, na verdade."
	icon_state = "hood_science"
	armor_type = /datum/armor/winterhood_science

// Research Director
/datum/armor/winterhood_science
	bio = 10
	fire = 20

/obj/item/clothing/suit/hooded/wintercoat/science/rd
	name = "research director's winter coat"
	desc = "Um grosso casaco de inverno ártico com um modelo atômico ultrapassado em vez de uma guia de fecho de plástico. A maioria sabe que o modelo de Bohr do átomo estava ultrapassado na época da década de 1930, quando os modelos Heisenbergian e Schrodinger eram geralmente aceitos como verdadeiros. No entanto, ainda vemos seu uso em anacronismo, roleplaying, e, neste caso, como uma guia de zíper. Pelo menos deve mantê-lo aquecido em seu pilar de marfim."
	icon_state = "coatrd"
	inhand_icon_state = null
	armor_type = /datum/armor/science_rd
	hoodtype = /obj/item/clothing/head/hooded/winterhood/science/rd

/datum/armor/science_rd
	bomb = 20
	fire = 30

/obj/item/clothing/suit/hooded/wintercoat/science/rd/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/melee/baton/telescopic,
	)

/obj/item/clothing/head/hooded/winterhood/science/rd
	desc = "Um casaco branco de inverno. Cheira a gel de cabelo."
	icon_state = "hood_rd"
	armor_type = /datum/armor/science_rd

// Roboticist
/obj/item/clothing/suit/hooded/wintercoat/science/robotics
	name = "robotics winter coat"
	desc = "Um casaco preto de inverno com um crânio robótico flamejante para o zíper. Este tem desenhos vermelhos brilhantes e alguns botões inúteis."
	icon_state = "coatrobotics"
	inhand_icon_state = null
	hoodtype = /obj/item/clothing/head/hooded/winterhood/science/robotics

/obj/item/clothing/head/hooded/winterhood/science/robotics
	desc = "Um casaco preto de inverno. Você pode puxá-lo para baixo sobre seus olhos e fingir que você é uma interpretação ultrapassada, final dos anos 80 de uma força policial futurista mecanizada. Eles vão te consertar. Eles consertam tudo."
	icon_state = "hood_robotics"

// Geneticist
/obj/item/clothing/suit/hooded/wintercoat/science/genetics
	name = "genetics winter coat"
	desc = "Um casaco branco de inverno com uma hélice de DNA para a guia do zíper."
	icon_state = "coatgenetics"
	inhand_icon_state = null
	hoodtype = /obj/item/clothing/head/hooded/winterhood/science/genetics

/obj/item/clothing/suit/hooded/wintercoat/science/genetics/Initialize(mapload)
	. = ..()
	allowed += /obj/item/sequence_scanner

/obj/item/clothing/head/hooded/winterhood/science/genetics
	desc = "Um casaco branco de inverno. Está quente."
	icon_state = "hood_genetics"

// Station Engineer
/obj/item/clothing/suit/hooded/wintercoat/engineering
	name = "engineering winter coat"
	desc = "Um casaco de inverno amarelo surpreendentemente pesado com listras laranjas reflexivas. Ele tem uma pequena chave inglesa para o zíper, e a camada interna é coberta com uma mistura resistente à radiação de nylon prata. Porque você vale a pena."
	icon_state = "coatengineer"
	inhand_icon_state = "coatengineer"
	allowed = list(
		/obj/item/analyzer,
		/obj/item/construction/rcd,
		/obj/item/fireaxe/metal_h2_axe,
		/obj/item/pipe_dispenser,
		/obj/item/storage/bag/construction,
		/obj/item/t_scanner,
		/obj/item/construction/rld,
		/obj/item/construction/rtd,
		/obj/item/gun/ballistic/rifle/rebarxbow,
		/obj/item/storage/bag/rebar_quiver,
	)
	armor_type = /datum/armor/wintercoat_engineering
	hoodtype = /obj/item/clothing/head/hooded/winterhood/engineering

/datum/armor/wintercoat_engineering
	fire = 20

/obj/item/clothing/suit/hooded/wintercoat/engineering/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha, effect_type = EMISSIVE_SPECULAR)

/obj/item/clothing/head/hooded/winterhood/engineering
	desc = "Um casaco amarelo de inverno. Definitivamente não é um substituto para um chapéu duro."
	icon_state = "hood_engineer"
	armor_type = /datum/armor/winterhood_engineering

/datum/armor/winterhood_engineering
	fire = 20

/obj/item/clothing/head/hooded/winterhood/engineering/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha, effect_type = EMISSIVE_SPECULAR)

// Chief Engineer
/obj/item/clothing/suit/hooded/wintercoat/engineering/ce
	name = "chief engineer's winter coat"
	desc = "Um casaco branco de inverno com listras reflexivas verdes e amarelas. Recheado de amianto, tratado com retardador de fogo PBDE, forrado com uma micro folha fina de papel alumínio e encaixado nas medidas do seu corpo. Este bebê está pronto para salvá-lo de qualquer coisa exceto o câncer de tireoide e fibrose sistêmica que você vai ter usando-o. A guia do zíper é uma pequena chave de ouro."
	icon_state = "coatce"
	inhand_icon_state = null
	armor_type = /datum/armor/engineering_ce
	hoodtype = /obj/item/clothing/head/hooded/winterhood/engineering/ce

/datum/armor/engineering_ce
	fire = 30
	acid = 10

/obj/item/clothing/suit/hooded/wintercoat/engineering/ce/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/melee/baton/telescopic,
	)

/obj/item/clothing/head/hooded/winterhood/engineering/ce
	desc = "Um casaco branco de inverno. Parece surpreendentemente pesado. A etiqueta diz que não é seguro para crianças."
	icon_state = "hood_ce"
	armor_type = /datum/armor/engineering_ce

// Atmospherics Technician
/obj/item/clothing/suit/hooded/wintercoat/engineering/atmos
	name = "atmospherics winter coat"
	desc = "Um casaco de inverno amarelo e azul. O zíper é feito para parecer uma máscara de respiração em miniatura."
	icon_state = "coatatmos"
	inhand_icon_state = "coatatmos"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/engineering/atmos

/obj/item/clothing/head/hooded/winterhood/engineering/atmos
	desc = "Um casaco amarelo e azul."
	icon_state = "hood_atmos"

// Cargo Technician
/obj/item/clothing/suit/hooded/wintercoat/cargo
	name = "cargo winter coat"
	desc = "Um casaco de inverno bronzeado e cinza. A guia do zíper é um pequeno pino parecido com um MULE. Enche você do calor de uma feroz independência."
	icon_state = "coatcargo"
	inhand_icon_state = "coatcargo"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/cargo
	allowed = list(
		/obj/item/storage/bag/mail,
		/obj/item/stamp,
		/obj/item/universal_scanner,
	)

/obj/item/clothing/head/hooded/winterhood/cargo
	desc = "Um capuz cinza para um casaco de inverno."
	icon_state = "hood_cargo"

// Quartermaster
/obj/item/clothing/suit/hooded/wintercoat/cargo/qm
	name = "quartermaster's winter coat"
	desc = "Um casaco de inverno marrom escuro que tem um alfinete dourado para seu zíper."
	icon_state = "coatqm"
	inhand_icon_state = null
	hoodtype = /obj/item/clothing/head/hooded/winterhood/cargo/qm

/obj/item/clothing/suit/hooded/wintercoat/cargo/qm/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/melee/baton/telescopic,
	)

/obj/item/clothing/head/hooded/winterhood/cargo/qm
	desc = "Um Capuz de Inverno Marrom Escuro"
	icon_state = "hood_qm"

// Shaft Miner
/obj/item/clothing/suit/hooded/wintercoat/miner
	name = "mining winter coat"
	desc = "Um botão empoeirado no casaco de inverno. O zíper parece uma picareta."
	icon_state = "coatminer"
	inhand_icon_state = "coatminer"
	allowed = list(
		/obj/item/gun/energy/recharge/kinetic_accelerator,
		/obj/item/mining_scanner,
		/obj/item/pickaxe,
		/obj/item/resonator,
		/obj/item/storage/bag/ore,
		/obj/item/t_scanner/adv_mining_scanner,
		/obj/item/tank/internals,
		/obj/item/shovel,
		/obj/item/trench_tool,
	)
	armor_type = /datum/armor/wintercoat_miner
	hoodtype = /obj/item/clothing/head/hooded/winterhood/miner

/datum/armor/wintercoat_miner
	melee = 10

/obj/item/clothing/head/hooded/winterhood/miner
	desc = "Um casaco de inverno empoeirado."
	icon_state = "hood_miner"
	armor_type = /datum/armor/winterhood_miner

/datum/armor/winterhood_miner
	melee = 10

/obj/item/clothing/suit/hooded/wintercoat/custom
	name = "tailored winter coat"
	desc = "Uma jaqueta pesada feita de peles de animais 'sintéticos', com cores personalizadas."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/custom"
	post_init_icon_state = "coatwinter"
	hood_down_overlay_suffix = ""
	greyscale_config = /datum/greyscale_config/winter_coats
	greyscale_config_worn = /datum/greyscale_config/winter_coats/worn
	greyscale_colors = "#ffffff#ffffff#808080#808080#808080#808080"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/custom
	flags_1 = IS_PLAYER_COLORABLE_1

//In case colors are changed after initialization
/obj/item/clothing/suit/hooded/wintercoat/custom/set_greyscale(list/colors, new_config, new_worn_config, new_inhand_left, new_inhand_right)
	. = ..()
	if(!hood)
		return
	var/list/coat_colors = SSgreyscale.ParseColorString(greyscale_colors)
	var/list/new_coat_colors = coat_colors.Copy(1,4)
	hood.set_greyscale(new_coat_colors) //Adopt the suit's grayscale coloring for visual clarity.
	hood.update_slot_icon()

//But also keep old method in case the hood is (re-)created later
/obj/item/clothing/suit/hooded/wintercoat/custom/on_hood_created(obj/item/clothing/head/hooded/hood)
	. = ..()
	var/list/coat_colors = (SSgreyscale.ParseColorString(greyscale_colors))
	var/list/new_coat_colors = coat_colors.Copy(1,4)
	hood.set_greyscale(new_coat_colors) //Adopt the suit's grayscale coloring for visual clarity.

/obj/item/clothing/head/hooded/winterhood/custom
	name = "tailored winter coat hood"
	desc = "Um capuz pesado feito de peles de animais 'sintéticos', com cores personalizadas."
	greyscale_config = /datum/greyscale_config/winter_hoods
	greyscale_config_worn = /datum/greyscale_config/winter_hoods/worn
	flags_1 = NO_NEW_GAGS_PREVIEW_1

/obj/item/clothing/suit/hooded/wintercoat/pullover
	name = "pullover"
	desc = "Um capuz colorido."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/pullover"
	post_init_icon_state = "pullover"
	greyscale_config = /datum/greyscale_config/hoodie_pullover
	greyscale_config_worn = /datum/greyscale_config/hoodie_pullover/worn
	greyscale_colors = "#5f5f5f"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/pullover
	flags_1 = IS_PLAYER_COLORABLE_1
	hood_down_overlay_suffix = ""
	hood_up_affix = "_t"
	can_altclick_zip = FALSE

/obj/item/clothing/suit/hooded/wintercoat/pullover/on_hood_up(obj/item/clothing/head/hooded/hood)
	return

/obj/item/clothing/suit/hooded/wintercoat/pullover/on_hood_down(obj/item/clothing/head/hooded/hood)
	return

/obj/item/clothing/head/hooded/winterhood/pullover
	name = "pullover hood"
	desc = "Um capuz colorido."
	icon_state = "hood_pullover"
	worn_icon_state = "hood_pullover"
	hair_mask = /datum/hair_mask/hoodie
	greyscale_config = /datum/greyscale_config/hoodie_pullover_hood
	greyscale_config_worn = /datum/greyscale_config/hoodie_pullover_hood/worn
	greyscale_colors = "#5f5f5f"
	flags_1 = NO_NEW_GAGS_PREVIEW_1

/obj/item/clothing/suit/hooded/wintercoat/pullover/set_greyscale(list/colors, new_config, new_worn_config, new_inhand_left, new_inhand_right)
	. = ..()
	if(!hood)
		return
	var/list/coat_colors = SSgreyscale.ParseColorString(greyscale_colors)
	hood.set_greyscale(coat_colors)
	hood.update_slot_icon()

/obj/item/clothing/suit/hooded/wintercoat/pullover/on_hood_created(obj/item/clothing/head/hooded/hood)
	. = ..()
	var/list/coat_colors = SSgreyscale.ParseColorString(greyscale_colors)
	hood.set_greyscale(coat_colors)

/obj/item/clothing/suit/hooded/wintercoat/zipup
	name = "zipup"
	desc = "Um capuz colorido."
	icon = 'icons/map_icons/clothing/suit/_suit.dmi'
	icon_state = "/obj/item/clothing/suit/hooded/wintercoat/zipup"
	post_init_icon_state = "zipup"
	greyscale_config = /datum/greyscale_config/hoodie_zipup
	greyscale_config_worn = /datum/greyscale_config/hoodie_zipup/worn
	greyscale_colors = "#5f5f5f"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/zipup
	flags_1 = IS_PLAYER_COLORABLE_1
	hood_down_overlay_suffix = ""
	hood_up_affix = "_t"

/obj/item/clothing/suit/hooded/wintercoat/zipup/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(isinhands || (hood && hood.loc != src))
		return

	var/suffix = (zipped ? "hood_t" : "hood")
	var/state = "[initial(post_init_icon_state) || initial(icon_state)]_[suffix]"
	. += mutable_appearance(icon_file, state, -SUIT_LAYER)

/obj/item/clothing/head/hooded/winterhood/zipup
	name = "zipup hood"
	desc = "Um capuz colorido."
	icon_state = "hood_zipup"
	worn_icon_state = "hood_zipup"
	hair_mask = /datum/hair_mask/hoodie
	greyscale_config = /datum/greyscale_config/hoodie_zipup_hood
	greyscale_config_worn = /datum/greyscale_config/hoodie_zipup_hood/worn
	greyscale_colors = "#5f5f5f"
	flags_1 = NO_NEW_GAGS_PREVIEW_1

/obj/item/clothing/suit/hooded/wintercoat/zipup/set_greyscale(list/colors, new_config, new_worn_config, new_inhand_left, new_inhand_right)
	. = ..()
	if(!hood)
		return
	var/list/coat_colors = SSgreyscale.ParseColorString(greyscale_colors)
	hood.set_greyscale(coat_colors)
	hood.update_slot_icon()

/obj/item/clothing/suit/hooded/wintercoat/zipup/on_hood_created(obj/item/clothing/head/hooded/hood)
	. = ..()
	var/list/coat_colors = SSgreyscale.ParseColorString(greyscale_colors)
	hood.set_greyscale(coat_colors)
