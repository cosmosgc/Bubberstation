#define SPELLBOOK_CATEGORY_MOBILITY "Mobility"
// Wizard spells that aid mobiilty(or stealth?)
/datum/spellbook_entry/mindswap
	name = "Mindswap"
	desc = "Permite trocar de corpo com um alvo ao seu lado. Vocês dois dormirão quando isso acontecer, e será bem óbvio que você é o corpo do alvo se alguém assistir você fazer isso."
	spell_type = /datum/action/cooldown/spell/pointed/mind_transfer
	category = SPELLBOOK_CATEGORY_MOBILITY

/datum/spellbook_entry/knock
	name = "Knock"
	desc = "Abre portas e armários próximos."
	spell_type = /datum/action/cooldown/spell/aoe/knock
	category = SPELLBOOK_CATEGORY_MOBILITY
	cost = 1

/datum/spellbook_entry/blink
	name = "Blink"
	desc = "Teletransporta-o aleatoriamente a uma curta distância."
	spell_type = /datum/action/cooldown/spell/teleport/radius_turf/blink
	category = SPELLBOOK_CATEGORY_MOBILITY

/datum/spellbook_entry/teleport
	name = "Teleport"
	desc = "Teletransporta você para uma área de sua seleção."
	spell_type = /datum/action/cooldown/spell/teleport/area_teleport/wizard
	category = SPELLBOOK_CATEGORY_MOBILITY

/datum/spellbook_entry/jaunt
	name = "Ethereal Jaunt"
	desc = "Torna sua forma etérea, temporariamente tornando-a invisível e capaz de atravessar paredes."
	spell_type = /datum/action/cooldown/spell/jaunt/ethereal_jaunt
	category = SPELLBOOK_CATEGORY_MOBILITY

/datum/spellbook_entry/swap
	name = "Swap"
	desc = "Troque de lugar com qualquer alvo vivo dentro de nove peças. Clique direito para marcar um alvo secundário. Você sempre vai trocar para o seu alvo principal."
	spell_type = /datum/action/cooldown/spell/pointed/swap
	category = SPELLBOOK_CATEGORY_MOBILITY
	cost = 1

/datum/spellbook_entry/item/warpwhistle
	name = "Warp Whistle"
	desc = "Um estranho apito que o levará para um lugar seguro distante na estação. Há uma janela de vulnerabilidade no início de cada uso."
	item_path = /obj/item/warp_whistle
	category = SPELLBOOK_CATEGORY_MOBILITY
	cost = 1

/datum/spellbook_entry/item/staffdoor
	name = "Staff of Door Creation"
	desc = "Uma equipe em particular que pode moldar paredes sólidas em portas ornamentadas. Útil para se locomover na ausência de outro transporte. Não funciona com vidro."
	item_path = /obj/item/gun/magic/staff/door
	cost = 1
	category = SPELLBOOK_CATEGORY_MOBILITY

/datum/spellbook_entry/item/teleport_rod
	name = /obj/item/teleport_rod::name
	desc = /obj/item/teleport_rod::desc
	item_path = /obj/item/teleport_rod
	cost = 2 // Puts it at 3 cost if you go for safety instant summons, but teleporting anywhere on screen is pretty good.
	category = SPELLBOOK_CATEGORY_MOBILITY

/datum/spellbook_entry/ghostliness
	name = "Forsake Body"
	desc = "Um feitiço necromântico que separa permanentemente sua alma de seu corpo, e parcialmente o ancora no plano material.\
Neste estado, você pode entrar em um estado de incorporidade, permitindo que você passe por matéria sólida. Isso, no entanto, inclui\
A maioria dessas coisas em ou dentro de você."
	spell_type = /datum/action/cooldown/spell/ghostliness
	category = SPELLBOOK_CATEGORY_MOBILITY
	no_coexistence_typecache = list(/datum/spellbook_entry/lichdom, /datum/spellbook_entry/splattercasting)

#undef SPELLBOOK_CATEGORY_MOBILITY
