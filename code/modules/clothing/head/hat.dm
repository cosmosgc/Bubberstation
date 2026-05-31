/obj/item/clothing/head/hats
	icon = 'icons/obj/clothing/head/hats.dmi'
	worn_icon = 'icons/mob/clothing/head/hats.dmi'
	abstract_type = /obj/item/clothing/head/hats

/obj/item/clothing/head/hats/centhat
	name = "\improper CentCom hat"
	icon_state = "centcom"
	desc = "É bom ser imperador."
	inhand_icon_state = "that"
	flags_inv = 0
	armor_type = /datum/armor/hats_centhat
	strip_delay = 8 SECONDS

/datum/armor/hats_centhat
	melee = 30
	bullet = 15
	laser = 30
	energy = 40
	bomb = 25
	fire = 50
	acid = 50

/obj/item/clothing/head/costume/constable
	name = "constable helmet"
	desc = "Um capacete britânico."
	icon_state = "constable"
	inhand_icon_state = null
	custom_price = PAYCHECK_COMMAND * 1.5
	worn_y_offset = 4
	armor_type = /datum/armor/head_helmet
	hair_mask = /datum/hair_mask/standard_hat_middle

/obj/item/clothing/head/costume/spacepolice
	name = "space police cap"
	desc = "Um boné azul para patrulhar a batida diária."
	icon_state = "policecap_families"
	inhand_icon_state = null

/obj/item/clothing/head/costume/canada
	name = "striped red tophat"
	desc = "Cheira a rosquinhas frescas.<i>Eu mandei comme des trous de beignets frais.</i>"
	icon_state = "canada"
	inhand_icon_state = null

/obj/item/clothing/head/costume/redcoat
	name = "redcoat's hat"
	icon_state = "redcoat"
	desc = "<i>Acho que é uma ruiva.</i>"

/obj/item/clothing/head/costume/mailman
	name = "mailman's hat"
	icon_state = "mailman"
	desc = "<i>Bem na hora.</i>Cabeça de correio."
	clothing_traits = list(TRAIT_HATED_BY_DOGS)
	custom_premium_price = PAYCHECK_CREW

/obj/item/clothing/head/bio_hood/plague
	name = "plague doctor's hat"
	desc = "Estes já foram usados por médicos praga. Este chapéu irá protegê-lo apenas ligeiramente da exposição à Pestilência."
	icon_state = "plaguedoctor"
	armor_type = /datum/armor/bio_hood_plague
	flags_inv = HIDEHAIR|HIDEEARS
	clothing_flags = SNUG_FIT
	flags_cover = NONE
	dirt_state = null
	alternate_worn_layer = HAIR_LAYER

/datum/armor/bio_hood_plague
	bio = 100

/obj/item/clothing/head/costume/nursehat
	name = "nurse's hat"
	desc = "Permite a identificação rápida de pessoal médico treinado."
	icon_state = "nursehat"
	dog_fashion = /datum/dog_fashion/head/nurse

/obj/item/clothing/head/hats/bowler
	name = "bowler-hat"
	desc = "Cavalheiros, elite a bordo!"
	icon_state = "bowler"
	inhand_icon_state = null

/obj/item/clothing/head/costume/bearpelt
	name = "bear pelt hat"
	desc = "Fuzzy."
	icon_state = "bearpelt"
	inhand_icon_state = null

/obj/item/clothing/head/costume/bearpelt/equipped(mob/living/user, slot)
	..()
	if(!ishuman(user) || !(slot & ITEM_SLOT_HEAD))
		return

	var/mob/living/carbon/human/human_user = user
	var/obj/item/clothing/suit/costume/bear_suit/our_suit = human_user.wear_suit
	if(!our_suit || !istype(our_suit))
		return

	our_suit.make_friendly(user, src)

/obj/item/clothing/head/flatcap
	name = "flat cap"
	desc = "O boné de um trabalhador."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/flatcap"
	post_init_icon_state = "beret_flat"
	greyscale_config = /datum/greyscale_config/beret
	greyscale_config_worn = /datum/greyscale_config/beret/worn
	greyscale_colors = "#8F7654"
	inhand_icon_state = null

/obj/item/clothing/head/cowboy
	name = "cowboy hat"
	desc = "Ninguém vai enganar o carrasco na minha cidade."
	icon = 'icons/obj/clothing/head/cowboy.dmi'
	worn_icon = 'icons/mob/clothing/head/cowboy.dmi'
	icon_state = "cowboy_hat_brown"
	worn_icon_state = "hunter"
	inhand_icon_state = null
	armor_type = /datum/armor/head_cowboy
	resistance_flags = FIRE_PROOF | ACID_PROOF
	/// Chance that the hat will catch a bullet for you
	var/deflect_chance = 2

/obj/item/clothing/head/cowboy/Initialize(mapload)
	. = ..()
	AddComponent(		/datum/component/bullet_intercepting,		block_chance = deflect_chance,		active_slots = ITEM_SLOT_HEAD,		on_intercepted = CALLBACK(src, PROC_REF(on_intercepted_bullet)),	)

/// When we catch a bullet, fling away
/obj/item/clothing/head/cowboy/proc/on_intercepted_bullet(mob/living/victim, obj/projectile/bullet)
	victim.visible_message(span_warning("\The [bullet]envia[victim]O chapéu está voando!"))
	victim.dropItemToGround(src, force = TRUE, silent = TRUE)
	throw_at(get_edge_target_turf(loc, pick(GLOB.alldirs)), range = 3, speed = 3)
	playsound(victim, SFX_RICOCHET, 100, TRUE)

/datum/armor/head_cowboy
	melee = 5
	bullet = 5
	laser = 5
	energy = 15

/// Bounty hunter's hat, very likely to intercept bullets
/obj/item/clothing/head/cowboy/bounty
	name = "bounty hunting hat"
	desc = "Alcance os céus, parceiro."
	icon_state = "bounty_hunter"
	worn_icon_state = "hunter"
	deflect_chance = 50

/obj/item/clothing/head/cowboy/black
	name = "desperado hat"
	desc = "Pessoas com cordas no pescoço nem sempre penduram."
	icon_state = "cowboy_hat_black"
	worn_icon_state = "cowboy_hat_black"
	inhand_icon_state = "cowboy_hat_black"

/// More likely to intercept bullets, since you're likely to not be wearing your modsuit with this on
/obj/item/clothing/head/cowboy/black/syndicate
	deflect_chance = 25

/obj/item/clothing/head/cowboy/white
	name = "ten-gallon hat"
	desc = "Há dois tipos de pessoas no mundo: aquelas com armas e aquelas que cavam. Entendeu?"
	icon_state = "cowboy_hat_white"
	worn_icon_state = "cowboy_hat_white"
	inhand_icon_state = "cowboy_hat_white"

/obj/item/clothing/head/cowboy/grey
	name = "drifter hat"
	desc = "O chapéu para uma assistente sem nome."
	icon_state = "cowboy_hat_grey"
	worn_icon_state = "cowboy_hat_grey"
	inhand_icon_state = "cowboy_hat_grey"

/obj/item/clothing/head/cowboy/red
	name = "deputy hat"
	desc = "Não se deixe enganar pela coloração. Este chapéu viu coisas terríveis."
	icon_state = "cowboy_hat_red"
	worn_icon_state = "cowboy_hat_red"
	inhand_icon_state = "cowboy_hat_red"

/obj/item/clothing/head/cowboy/brown
	name = "sheriff hat"
	desc = "Alcance os céus, parceiro."
	icon_state = "cowboy_hat_brown"
	worn_icon_state = "cowboy_hat_brown"
	inhand_icon_state = "cowboy_hat_brown"

/obj/item/clothing/head/costume/santa
	name = "santa hat"
	desc = "No primeiro dia de Natal meu patrão me deu!"
	icon_state = "santahatnorm"
	inhand_icon_state = "that"
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	dog_fashion = /datum/dog_fashion/head/santa

/obj/item/clothing/head/costume/santa/gags
	name = "santa hat"
	desc = "No primeiro dia de Natal meu patrão me deu!"
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/costume/santa/gags"
	post_init_icon_state = "santa_hat"
	greyscale_config = /datum/greyscale_config/santa_hat
	greyscale_config_worn = /datum/greyscale_config/santa_hat/worn
	greyscale_colors = "#cc0000#f8f8f8"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/costume/jester
	name = "jester hat"
	desc = "Um chapéu com sinos, para adicionar alguma alegria ao terno."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/costume/jester"
	post_init_icon_state = "jester_map"
	greyscale_config = /datum/greyscale_config/jester_hat
	greyscale_config_worn = /datum/greyscale_config/jester_hat/worn
	greyscale_colors = "#00ff00#ff0000"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/head/costume/jesteralt
	name = "jester hat"
	desc = "Um chapéu com sinos, para adicionar alguma alegria ao terno."
	icon_state = "jester2"

/obj/item/clothing/head/costume/rice_hat
	name = "rice hat"
	desc = "Bem-vindo aos campos de arroz, filho da puta."
	icon_state = "rice_hat"
	base_icon_state = "rice_hat"
	var/reversed = FALSE

/obj/item/clothing/head/costume/rice_hat/click_alt(mob/user)
	reversed = !reversed
	worn_icon_state = "[base_icon_state][reversed ? "_kim" : ""]"
	to_chat(user, span_notice("Você.[reversed ? "lower" : "raise"]O chapéu."))
	update_appearance()

/obj/item/clothing/head/costume/lizard
	name = "lizardskin cloche hat"
	desc = "Quantos lagartos morreram para fazer este chapéu? Não o suficiente."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/costume/lizard"
	post_init_icon_state = "lizard_hat"
	greyscale_config = /datum/greyscale_config/lizard_hat
	greyscale_config_worn = /datum/greyscale_config/lizard_hat/worn
	greyscale_colors = "#859333"

/obj/item/clothing/head/costume/lizard/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	var/obj/item/stack/sheet/animalhide/carbon/lizard/skin = locate() in components
	if (isnull(skin) || !length(skin.skin_color)) // what
		return ..()
	set_greyscale(skin.skin_color)
	return ..()

/obj/item/clothing/head/costume/scarecrow_hat
	name = "scarecrow hat"
	desc = "Um simples chapéu de palha."
	icon_state = "scarecrow_hat"

/obj/item/clothing/head/costume/pharaoh
	name = "pharaoh hat"
	desc = "Ande como um egípcio."
	icon_state = "pharoah_hat"
	inhand_icon_state = null

/obj/item/clothing/head/costume/nemes
	name = "headdress of Nemes"
	desc = "Uma tumba espacial não incluída."
	icon_state = "nemes_headdress"

/obj/item/clothing/head/costume/delinquent
	name = "delinquent hat"
	desc = "Meu Deus."
	icon_state = "delinquent"

/obj/item/clothing/head/hats/intern
	name = "\improper CentCom Head Intern beancap"
	desc = "Uma horripilante mistura de gorro e gorro no verde CentCom. Você teria que estar desesperado por poder sobre seus colegas para concordar em usar isso."
	icon_state = "intern_hat"
	inhand_icon_state = null

/obj/item/clothing/head/hats/coordinator
	name = "coordinator cap"
	desc = "Um boné para um coordenador de festas, elegante!"
	icon_state = "capcap"
	inhand_icon_state = "that"
	armor_type = /datum/armor/hats_coordinator

/datum/armor/hats_coordinator
	melee = 25
	bullet = 15
	laser = 25
	energy = 35
	bomb = 25
	fire = 50
	acid = 50

/obj/item/clothing/head/costume/jackbros
	name = "frosty hat"
	desc = "Hee-ho!"
	icon_state = "JackFrostHat"
	inhand_icon_state = null

/obj/item/clothing/head/costume/weddingveil
	name = "wedding veil"
	desc = "Um véu branco."
	icon_state = "weddingveil"
	inhand_icon_state = null

/obj/item/clothing/head/hats/centcom_cap
	name = "\improper CentCom commander cap"
	icon_state = "centcom_cap"
	desc = "Usado pelos melhores comandantes da CentCom. Duas pequenas iniciais estão dentro do forro da tampa."
	inhand_icon_state = "that"
	flags_inv = 0
	armor_type = /datum/armor/hats_centcom_cap
	strip_delay = 8 SECONDS
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON //SKYRAT EDIT lets anthros wear the hat

/datum/armor/hats_centcom_cap
	melee = 30
	bullet = 15
	laser = 30
	energy = 40
	bomb = 25
	fire = 50
	acid = 50

/obj/item/clothing/head/fedora/human_leather
	name = "human skin hat"
	desc = "Isso vai assustá-los. Todos conhecerão meu poder."
	icon_state = "human_leather"
	inhand_icon_state = null

/obj/item/clothing/head/costume/ushanka
	name = "ushanka"
	desc = "Perfeito para o inverno na Sibéria."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/costume/ushanka"
	post_init_icon_state = "ushanka_gagdown"
	greyscale_config = /datum/greyscale_config/ushanka
	greyscale_config_worn = /datum/greyscale_config/ushanka/worn
	greyscale_colors = "#C7B08B#5A4E44"
	flags_1 = IS_PLAYER_COLORABLE_1
	inhand_icon_state = null
	flags_inv = HIDEEARS //SKYRAT EDIT (Original: HIDEEARS|HIDEHAIR)
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	dog_fashion = /datum/dog_fashion/head/ushanka
	var/earflaps = TRUE
	///Sprite visible when the ushanka flaps are folded up.
	var/upsprite = "ushanka_gagup"
	///Sprite visible when the ushanka flaps are folded down.
	var/downsprite = "ushanka_gagdown"

/obj/item/clothing/head/costume/ushanka/attack_self(mob/user)
	if(earflaps)
		icon_state = upsprite
		inhand_icon_state = upsprite
		to_chat(user, span_notice("Você levanta as orelhas na ushanka."))
	else
		icon_state = downsprite
		inhand_icon_state = downsprite
		to_chat(user, span_notice("Abaixe as orelhas na ushanka."))
	earflaps = !earflaps

/obj/item/clothing/head/costume/ushanka/polar
	name = "bear hunter's ushanka"
	desc = "Feitos na Sibéria de ursos polares de verdade."
	icon_state = "/obj/item/clothing/head/costume/ushanka/polar"
	greyscale_colors = "#FCFCFD#CCCED1"
	flags_1 = null

/obj/item/clothing/head/costume/ushanka/sec
	name = "security ushanka"
	icon_state = "/obj/item/clothing/head/costume/ushanka/sec"
	desc = "Um ushanka quente e confortável, tingido com 'todos os sabores naturais' de acordo com a etiqueta."
	greyscale_colors = "#C7B08B#A52F29"
	armor_type = /datum/armor/cosmetic_sec
	flags_1 = null

/obj/item/clothing/head/costume/nightcap
	abstract_type = /obj/item/clothing/head/costume/nightcap

/obj/item/clothing/head/costume/nightcap/blue
	name = "blue nightcap"
	desc = "Uma bebida azul para todos os sonhadores e sonâmbulos."
	icon_state = "sleep_blue"

/obj/item/clothing/head/costume/nightcap/red
	name = "red nightcap"
	desc = "Uma bebida vermelha para todos os dorminhocos e dorminhocos."
	icon_state = "sleep_red"

/obj/item/clothing/head/costume/paper_hat
	name = "paper hat"
	desc = "Um chapéu frágil feito de papel."
	icon_state = "paper"
	worn_icon_state = "paper"
	dog_fashion = /datum/dog_fashion/head
	custom_materials = list(/datum/material/paper = HALF_SHEET_MATERIAL_AMOUNT / 2)
