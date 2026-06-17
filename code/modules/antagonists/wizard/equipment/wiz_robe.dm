/obj/item/clothing/head/wizard
	name = "wizard hat"
	desc = "Chapéu estranho que certamente pertence a um verdadeiro usuário de magia."
	icon = 'icons/obj/clothing/head/wizard.dmi'
	worn_icon = 'icons/mob/clothing/head/wizard.dmi'
	icon_state = "wizard"
	inhand_icon_state = "wizhat"
	armor_type = /datum/armor/head_wizard
	strip_delay = 5 SECONDS
	equip_delay_other = 5 SECONDS
	clothing_flags = SNUG_FIT | CASTING_CLOTHES
	resistance_flags = FIRE_PROOF | ACID_PROOF
	dog_fashion = /datum/dog_fashion/head/blue_wizard
	///How much this hat affects fishing difficulty
	var/fishing_modifier = -6

/obj/item/clothing/head/wizard/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, fishing_modifier) //A wizard always practices his casting (ba dum tsh)

/datum/armor/head_wizard
	melee = 30
	bullet = 20
	laser = 20
	energy = 30
	bomb = 20
	bio = 100
	fire = 100
	acid = 100
	wound = 20

/obj/item/clothing/head/wizard/red
	name = "red wizard hat"
	desc = "Uma roupa vermelha estranha que certamente pertence a um verdadeiro usuário de magia."
	icon_state = "redwizard"
	dog_fashion = /datum/dog_fashion/head/red_wizard

/obj/item/clothing/head/wizard/yellow
	name = "yellow wizard hat"
	desc = "Uma roupa amarela estranha que certamente pertence a um poderoso usuário de magia."
	icon_state = "yellowwizard"
	dog_fashion = null

/obj/item/clothing/head/wizard/black
	name = "black wizard hat"
	desc = "Um chapéu preto estranho que certamente pertence a um esqueleto de verdade. Assustador."
	icon_state = "blackwizard"
	dog_fashion = null

/obj/item/clothing/head/wizard/fake
	name = "wizard hat"
	desc = "Tem WIZZARD escrito em lantejoulas. Vem com uma barba legal."
	icon_state = "wizard-fake"
	armor_type = /datum/armor/none
	resistance_flags = FLAMMABLE
	dog_fashion = /datum/dog_fashion/head/blue_wizard
	fishing_modifier = -2

/obj/item/clothing/head/wizard/chanterelle
	name = "chanterelle hat"
	desc = "Uma cantora enorme com espaço vazio para caber uma cabeça. Parece um chapéu de mago."
	icon_state = "chanterelle"
	inhand_icon_state = "chanterellehat"
	armor_type = /datum/armor/none
	resistance_flags = FLAMMABLE

/obj/item/clothing/head/wizard/chanterelle/fr
	resistance_flags = FIRE_PROOF

/obj/item/clothing/head/wizard/marisa
	name = "witch hat"
	desc = "Vestido de chapéu estranho. Faz você querer lançar bolas de fogo."
	icon = 'icons/map_icons/clothing/head/_head.dmi'
	icon_state = "/obj/item/clothing/head/wizard/marisa"
	post_init_icon_state = "witch_hat"
	greyscale_config = /datum/greyscale_config/witch_hat
	greyscale_config_worn = /datum/greyscale_config/witch_hat/worn
	greyscale_colors = "#343640#e0cab8#e0cab8"
	flags_1 = IS_PLAYER_COLORABLE_1
	dog_fashion = null

/obj/item/clothing/head/wizard/tape
	name = "tape hat"
	desc = "Um chapéu magicamente afinado feito exclusivamente de fita adesiva. Você mal consegue ver."
	icon_state = "tapehat"
	inhand_icon_state = "tapehat"
	dog_fashion = null
	worn_y_offset = 6
	body_parts_covered = HEAD //this used to also cover HAIR, but that was never valid code as HAIR is not actually a body_part define!
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/head/wizard/magus
	name = "\improper Magus helm"
	icon_state = "magus"
	desc = "Um misterioso capacete que canta com um poder sobrenatural."
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDEEARS|HIDEEYES|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	inhand_icon_state = null
	dog_fashion = null

/obj/item/clothing/head/wizard/santa
	name = "Santa's hat"
	desc = "Ho ho ho. Merrry X-mas!"
	icon_state = "santahat"
	inhand_icon_state = "santahat"
	flags_inv = HIDEHAIR|HIDEFACIALHAIR
	dog_fashion = null

/obj/item/clothing/head/wizard/hood
	name = "wizard hood"
	icon_state = "wizhood"

/obj/item/clothing/suit/wizrobe
	name = "wizard robe"
	desc = "Um roupão magnífico e forrado que parece irradiar poder."
	icon = 'icons/obj/clothing/suits/wizard.dmi'
	icon_state = "wizard"
	worn_icon = 'icons/mob/clothing/suits/wizard.dmi'
	inhand_icon_state = "wizrobe"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	armor_type = /datum/armor/suit_wizrobe
	allowed = list(/obj/item/highfrequencyblade/wizard, /obj/item/storage/belt/wand_bandolier, /obj/item/teleportation_scroll)
	flags_inv = HIDEJUMPSUIT
	strip_delay = 5 SECONDS
	equip_delay_other = 5 SECONDS
	clothing_flags = CASTING_CLOTHES
	resistance_flags = FIRE_PROOF | ACID_PROOF
	///How much this robe affects fishing difficulty
	var/fishing_modifier = -7

/obj/item/clothing/suit/wizrobe/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, fishing_modifier) //A wizard always practices his casting (ba dum tsh)

/datum/armor/suit_wizrobe
	melee = 30
	bullet = 20
	laser = 20
	energy = 30
	bomb = 20
	bio = 100
	fire = 100
	acid = 100
	wound = 20

/obj/item/clothing/suit/wizrobe/red
	name = "red wizard robe"
	desc = "Um roupão vermelho magnífico que parece irradiar poder."
	icon_state = "redwizard"
	inhand_icon_state = null

/obj/item/clothing/suit/wizrobe/yellow
	name = "yellow wizard robe"
	desc = "Um roupão amarelo magnífico que parece irradiar poder."
	icon_state = "yellowwizard"
	inhand_icon_state = null

/obj/item/clothing/suit/wizrobe/black
	name = "black wizard robe"
	desc = "Uma túnica negra enervante que cheira a morte e decadência."
	icon_state = "blackwizard"
	inhand_icon_state = null

/obj/item/clothing/suit/wizrobe/marisa
	name = "witch robe"
	desc = "Magia é tudo sobre o poder do feitiço, ZE!"
	icon_state = "marisa"
	inhand_icon_state = null

/obj/item/clothing/suit/wizrobe/tape
	name = "tape robe"
	desc = "Um belo roupão feito com fita adesiva mágicamente afinada."
	icon_state = "taperobe"
	inhand_icon_state = "taperobe"

/obj/item/clothing/suit/wizrobe/magusblue
	name = "\improper Magus robe"
	desc = "Um conjunto de vestes blindadas que parecem irradiar um poder negro."
	icon_state = "magusblue"
	inhand_icon_state = null
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT

/obj/item/clothing/suit/wizrobe/magusred
	name = "\improper Magus robe"
	desc = "Um conjunto de vestes blindadas que parecem irradiar um poder negro."
	icon_state = "magusred"
	inhand_icon_state = null
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT

/obj/item/clothing/suit/wizrobe/santa
	name = "Santa's suit"
	desc = "Festivo!"
	icon_state = "santa"
	inhand_icon_state = "santa"

/obj/item/clothing/suit/wizrobe/fake
	name = "wizard robe"
	desc = "Um roupão azul um tanto monótono para imitar vestes mágicas."
	icon_state = "wizard-fake"
	inhand_icon_state = "wizrobe"
	armor_type = /datum/armor/none
	resistance_flags = FLAMMABLE
	fishing_modifier = -3

/obj/item/clothing/head/wizard/marisa/fake
	name = "witch hat"
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1
	armor_type = /datum/armor/none
	resistance_flags = FLAMMABLE
	fishing_modifier = -2

/obj/item/clothing/head/wizard/tape/fake
	name = "tape hat"
	desc = "Um chapéu projetado exclusivamente a partir de fita adesiva. Você mal consegue ver."
	armor_type = /datum/armor/none
	resistance_flags = FLAMMABLE
	fishing_modifier = -2

/obj/item/clothing/suit/wizrobe/marisa/fake
	name = "witch robe"
	desc = "Magia é tudo sobre o poder do feitiço, ZE!"
	icon_state = "marisa"
	inhand_icon_state = null
	armor_type = /datum/armor/none
	resistance_flags = FLAMMABLE
	fishing_modifier = -3

/obj/item/clothing/suit/wizrobe/tape/fake
	name = "tape robe"
	desc = "Uma roupa projetada exclusivamente a partir de fita adesiva. Foi difícil de colocar."
	armor_type = /datum/armor/none
	resistance_flags = FLAMMABLE
	fishing_modifier = -3

/obj/item/clothing/suit/wizrobe/durathread
	name = "durathread robe"
	desc = "Um robe de Durathread um tanto monótono, não tão protetor como uma armadura adequada, mas muito mais elegante."
	icon_state = "durathread-fake"
	inhand_icon_state = null
	armor_type = /datum/armor/robe_durathread
	allowed = /obj/item/clothing/suit/apron::allowed
	fishing_modifier = -6

/datum/armor/robe_durathread
	melee = 15
	bullet = 5
	laser = 25
	energy = 30
	bomb = 10
	fire = 30
	acid = 40

/obj/item/clothing/suit/wizrobe/durathread/fire
	name = "pyromancer robe"
	desc = "Um manto de Durathread um tanto chato, não tão protetor quanto armadura tecida, mas muito mais elegante."
	icon_state = "durathread-fire"

/obj/item/clothing/suit/wizrobe/durathread/ice
	name = "pyromancer robe"
	desc = "Um manto de Durathread um tanto chato, não tão protetor quanto armadura tecida, mas muito mais elegante."
	icon_state = "durathread-ice"

/obj/item/clothing/suit/wizrobe/durathread/electric
	name = "electromancer robe"
	desc = "Na verdade, não conduta ou isole da eletricidade. Embora tenha alguma durabilidade por ser feita de Durathread."
	icon_state = "durathread-electric"

/obj/item/clothing/suit/wizrobe/durathread/earth
	name = "geomancer robe"
	desc = "Um manto de Durathread um tanto chato, não tão protetor quanto armadura tecida, mas muito mais elegante."
	icon_state = "durathread-earth"

/obj/item/clothing/suit/wizrobe/durathread/necro
	name = "necromancer robe"
	desc = "Um manto de Durathread um tanto chato, não tão protetor quanto armadura tecida, mas muito mais elegante."
	icon_state = "durathread-necro"

/obj/item/clothing/suit/wizrobe/paper
	name = "papier-mache robe" // no non-latin characters!
	desc = "Um manto unido por vários pedaços de fita clara e pasta."
	icon_state = "wizard-paper"
	inhand_icon_state = null
	COOLDOWN_DECLARE(summoning_cooldown)
	actions_types = list(/datum/action/item_action/stickmen)

/obj/item/clothing/suit/wizrobe/paper/ui_action_click(mob/user, action)
	if(!ishuman(user))
		return

	if(!COOLDOWN_FINISHED(src, summoning_cooldown))
		user.balloon_alert(user, "roupão recarregando!")
		return

	conjure_stickmen(user)

/obj/item/clothing/suit/wizrobe/paper/proc/conjure_stickmen(mob/living/carbon/human/summoner)
	summoner.force_say()
	summoner.say("Rise, my creation! Off your page into this realm!", forced = "stickman summoning")
	playsound(src, 'sound/effects/magic/summon_magic.ogg', 50, TRUE, TRUE)

	var/mob/living/stickman = new /mob/living/basic/stickman/lesser(get_turf(summoner))
	stickman.remove_faction(FACTION_NEUTRAL) //These bad boys shouldn't inherit the neutral faction from the crew

	COOLDOWN_START(src, summoning_cooldown, 3 SECONDS)
