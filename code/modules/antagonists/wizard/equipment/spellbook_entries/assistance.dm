#define SPELLBOOK_CATEGORY_ASSISTANCE "Assistance"
// Wizard spells that assist the caster in some way
/datum/spellbook_entry/summonitem
	name = "Summon Item"
	desc = "Lembra um item previamente marcado para sua mão de qualquer lugar do universo."
	spell_type = /datum/action/cooldown/spell/summonitem
	category = SPELLBOOK_CATEGORY_ASSISTANCE
	cost = 1

/datum/spellbook_entry/charge
	name = "Charge"
	desc = "Este feitiço pode ser usado para recarregar várias coisas em suas mãos, de artefatos mágicos a componentes elétricos. Um mago criativo pode até usá-lo para dar poder mágico a outro usuário mágico."
	spell_type = /datum/action/cooldown/spell/charge
	category = SPELLBOOK_CATEGORY_ASSISTANCE
	cost = 1

/datum/spellbook_entry/shapeshift
	name = "Wild Shapeshift"
	desc = "Tome a forma de outro por um tempo para usar suas habilidades naturais. Uma vez que você fez sua escolha não pode ser mudado."
	spell_type = /datum/action/cooldown/spell/shapeshift/wizard
	category = SPELLBOOK_CATEGORY_ASSISTANCE
	cost = 1

/datum/spellbook_entry/tap
	name = "Soul Tap"
	desc = "Alimente seus feitiços usando sua própria alma!"
	spell_type = /datum/action/cooldown/spell/tap
	category = SPELLBOOK_CATEGORY_ASSISTANCE
	cost = 1

/datum/spellbook_entry/item/staffanimation
	name = "Staff of Animation"
	desc = "Um bastão arcano capaz de atirar raios de energia de eldritch que fazem com que objetos inanimados ganhem vida. Essa magia não afeta máquinas."
	item_path = /obj/item/gun/magic/staff/animate
	category = SPELLBOOK_CATEGORY_ASSISTANCE

/datum/spellbook_entry/item/soulstones
	name = "Soulstone Shard Kit"
	desc = "Soul Stone Shards são ferramentas antigas capazes de capturar e aproveitar os espíritos dos mortos e morrendo. O Artificador de feitiços permite criar máquinas arcanas para as almas capturadas pilotarem."
	item_path = /obj/item/storage/belt/soulstone/full
	category = SPELLBOOK_CATEGORY_ASSISTANCE

/datum/spellbook_entry/item/soulstones/try_equip_item(mob/living/carbon/human/user, obj/item/to_equip)
	var/was_equipped = user.equip_to_slot_if_possible(to_equip, ITEM_SLOT_BELT, disable_warning = TRUE)
	to_chat(user, span_notice("\A [to_equip.name] Foi convocado.[was_equipped ? "on your waist" : "at your feet"]."))

/datum/spellbook_entry/item/soulstones/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy = TRUE)
	. =..()
	if(!.)
		return

	var/datum/action/cooldown/spell/conjure/construct/bonus_spell = new(user.mind || user)
	bonus_spell.Grant(user)

/datum/spellbook_entry/item/necrostone
	name = "A Necromantic Stone"
	desc = "Uma pedra Necromântica é capaz de ressuscitar três indivíduos mortos como thralls esqueléticos para você comandar."
	item_path = /obj/item/necromantic_stone
	category = SPELLBOOK_CATEGORY_ASSISTANCE

/datum/spellbook_entry/item/contract
	name = "Contract of Apprenticeship"
	desc = "Um contrato mágico ligando um assistente aprendiz ao seu serviço, usando-o os convocará para o seu lado."
	item_path = /obj/item/antag_spawner/contract
	category = SPELLBOOK_CATEGORY_ASSISTANCE
	refundable = TRUE

/datum/spellbook_entry/item/guardian
	name = "Guardian Deck"
	desc = "Um baralho de cartas de tarô guardião, capaz de ligar um guardião pessoal ao seu corpo. Existem vários tipos de guardiões disponíveis, mas todos eles transferirão algum dano para você. Seria sábio evitar comprar isso com qualquer coisa capaz de fazer você trocar corpos com outros."
	item_path = /obj/item/guardian_creator/wizard
	category = SPELLBOOK_CATEGORY_ASSISTANCE

/datum/spellbook_entry/item/bloodbottle
	name = "Bottle of Blood"
	desc = "Uma garrafa de sangue magicamente infundido, cujo cheiro atrairá seres extradimensionais quando quebrados. Cuidado, porém, os tipos de criaturas convocadas pela magia do sangue são indiscriminadas em sua matança, e você mesmo pode se tornar uma vítima."
	item_path = /obj/item/antag_spawner/slaughter_demon
	limit = 3
	category = SPELLBOOK_CATEGORY_ASSISTANCE
	refundable = TRUE

/datum/spellbook_entry/item/hugbottle
	name = "Bottle of Tickles"
	desc = "Uma garrafa de diversão mágica, cujo cheiro atrairá adoráveis seres extradimensionais quando quebrados. Esses seres são semelhantes ao massacre de demônios, mas eles não matam permanentemente suas vítimas, em vez de colocá-los em um espaço de abraços extradimensional, para serem liberados na morte do demônio. Caótica, mas não prejudicial. A reação da tripulação à outra mão pode ser muito destrutiva."
	item_path = /obj/item/antag_spawner/slaughter_demon/laughter
	cost = 1 //non-destructive; it's just a jape, sibling!
	limit = 3
	category = SPELLBOOK_CATEGORY_ASSISTANCE
	refundable = TRUE

/datum/spellbook_entry/item/vendormancer
	name = "Scepter of Vendormancy"
	desc = "Um cetro contendo o poder da Fornecedormancia Rúnica. Pode reunir até 3 fornecedores runicos que decaem com o tempo, mas podem ser jogados para esmagar oponentes ou serem detonados diretamente. Quando fora das cargas um longo canal irá restaurar as cargas."
	item_path = /obj/item/runic_vendor_scepter
	category = SPELLBOOK_CATEGORY_ASSISTANCE

#undef SPELLBOOK_CATEGORY_ASSISTANCE
