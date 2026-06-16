#define SPELLBOOK_CATEGORY_DEFENSIVE "Defensive"
// Defensive wizard spells
/datum/spellbook_entry/magicm
	name = "Magic Missile"
	desc = "Dispara vários projéteis mágicos em alvos próximos."
	spell_type = /datum/action/cooldown/spell/aoe/magic_missile
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/disabletech
	name = "Disable Tech"
	desc = "Desativa todas as armas, câmeras e a maioria das outras tecnologias ao alcance."
	spell_type = /datum/action/cooldown/spell/emp/disable_tech
	category = SPELLBOOK_CATEGORY_DEFENSIVE
	cost = 1

/datum/spellbook_entry/repulse
	name = "Repulse"
	desc = "Joga tudo ao redor do usuário."
	spell_type = /datum/action/cooldown/spell/aoe/repulse/wizard
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/lightning_packet
	name = "Thrown Lightning"
	desc = "Forjado de energias de Eldrich, um pacote de poder puro, conhecido como pacote de feitiços aparecerá em sua mão, que quando lançado irá atordoar o alvo."
	spell_type = /datum/action/cooldown/spell/conjure_item/spellpacket
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/timestop
	name = "Time Stop"
	desc = "Para o tempo de todos, exceto você, permitindo que você se mova livremente enquanto seus inimigos e até projéteis estão congelados."
	spell_type = /datum/action/cooldown/spell/timestop
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/smoke
	name = "Smoke"
	desc = "Espalha uma nuvem de fumaça sufocante em sua localização."
	spell_type = /datum/action/cooldown/spell/smoke
	category = SPELLBOOK_CATEGORY_DEFENSIVE
	cost = 1

/datum/spellbook_entry/forcewall
	name = "Force Wall"
	desc = "Criar uma barreira mágica que só você pode passar."
	spell_type = /datum/action/cooldown/spell/forcewall
	category = SPELLBOOK_CATEGORY_DEFENSIVE
	cost = 1

/datum/spellbook_entry/lichdom
	name = "Bind Soul"
	desc = "Um pacto negro e necromântico que pode unir sua alma para sempre a um item de sua escolha, transformando você em um Lich imortal. Enquanto o item permanecer intacto, você reviverá da morte, não importa as circunstâncias. Seja cauteloso - com cada reavivamento, seu corpo ficará mais fraco, e será mais fácil para os outros encontrar seu item de poder."
	spell_type =  /datum/action/cooldown/spell/lichdom
	category = SPELLBOOK_CATEGORY_DEFENSIVE
	no_coexistence_typecache = list(/datum/action/cooldown/spell/splattercasting, /datum/spellbook_entry/perks/wormborn)

/datum/spellbook_entry/chuunibyou
	name = "Chuuni Invocations"
	desc = "Faz seus feitiços gritarem invocações, e as invocações se tornam... estúpidas. Você se cura ligeiramente depois de lançar um feitiço."
	spell_type =  /datum/action/cooldown/spell/chuuni_invocations
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/spacetime_dist
	name = "Spacetime Distortion"
	desc = "Envolva as cordas do espaço-tempo em uma área ao seu redor, randomizando o layout e tornando impossível o movimento adequado. As cordas vibram..."
	spell_type = /datum/action/cooldown/spell/spacetime_dist
	category = SPELLBOOK_CATEGORY_DEFENSIVE
	cost = 1

/datum/spellbook_entry/the_traps
	name = "The Traps!"
	desc = "Chame várias armadilhas ao seu redor. Eles danificam e enfurecem os inimigos que pisam neles."
	spell_type = /datum/action/cooldown/spell/conjure/the_traps
	category = SPELLBOOK_CATEGORY_DEFENSIVE
	cost = 1

/datum/spellbook_entry/bees
	name = "Lesser Summon Bees"
	desc = "Este feitiço magicamente chuta uma colmeia transdimensional, instantaneamente convocando um enxame de abelhas para sua localização. Essas abelhas não são amigáveis para ninguém."
	spell_type = /datum/action/cooldown/spell/conjure/bee
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/duffelbag
	name = "Bestow Cursed Duffel Bag"
	desc = "Uma maldição que prende firmemente uma mochila demoníaca às costas do alvo. A mochila fará com que a pessoa que está presa sofra danos periódicos se não for alimentada regularmente, e independentemente de ter ou não sido alimentada, irá atrasar significativamente a pessoa que a usa."
	spell_type = /datum/action/cooldown/spell/touch/duffelbag
	category = SPELLBOOK_CATEGORY_DEFENSIVE
	cost = 1

/datum/spellbook_entry/item/staffhealing
	name = "Staff of Healing"
	desc = "Uma equipe altruísta que pode curar os coxos e ressuscitar os mortos."
	item_path = /obj/item/gun/magic/staff/healing
	cost = 1
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/item/lockerstaff
	name = "Staff of the Locker"
	desc = "Uma equipe que atira em armários. Ele come qualquer um que bate em seu caminho, deixando um armário soldado com suas vítimas para trás."
	item_path = /obj/item/gun/magic/staff/locker
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/item/scryingorb
	name = "Scrying Orb"
	desc = "Uma esfera incandescente de energia crepitante. Usando-o permitirá que liberte seu fantasma vivo, permitindo que espione a estação e fale com o falecido. Além disso, comprá-lo lhe concederá permanentemente visão de raio-X."
	item_path = /obj/item/scrying
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/item/wands
	name = "Wand Assortment"
	desc = "Uma coleção de varinhas que permitem uma grande variedade de utilidades. Varinhas têm um número limitado de acusações, então seja conservador com seu uso. Vem em um cinto útil."
	item_path = /obj/item/storage/belt/wands/full
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/item/wands/try_equip_item(mob/living/carbon/human/user, obj/item/to_equip)
	var/was_equipped = user.equip_to_slot_if_possible(to_equip, ITEM_SLOT_BELT, disable_warning = TRUE)
	to_chat(user, span_notice("\A [to_equip.name] Foi convocado.[was_equipped ? "on your waist" : "at your feet"]."))

/datum/spellbook_entry/item/armor
	name = "Mastercrafted Armor Set"
	desc = "Uma armadura de artefato que permite lançar feitiços enquanto fornece mais proteção contra ataques e o vazio do espaço. Também concede um escudo de guerra."
	item_path = /obj/item/mod/control/pre_equipped/enchanted
	category = SPELLBOOK_CATEGORY_DEFENSIVE

/datum/spellbook_entry/item/armor/try_equip_item(mob/living/carbon/human/user, obj/item/to_equip)
	var/obj/item/mod/control/mod = to_equip
	var/obj/item/mod/module/storage/storage = locate() in mod.modules
	var/obj/item/back = user.back
	if(back)
		if(!user.dropItemToGround(back))
			return
		for(var/obj/item/item as anything in back.contents)
			item.forceMove(storage)
	if(!user.equip_to_slot_if_possible(mod, mod.slot_flags, qdel_on_fail = FALSE, disable_warning = TRUE))
		return
	if(!user.dropItemToGround(user.wear_suit) || !user.dropItemToGround(user.head))
		return
	mod.quick_activation()
	var/obj/item/mod/module/eradication_lock/lock_module = locate() in mod.modules
	lock_module.used()

#undef SPELLBOOK_CATEGORY_DEFENSIVE
