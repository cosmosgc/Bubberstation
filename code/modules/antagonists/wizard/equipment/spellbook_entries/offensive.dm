#define SPELLBOOK_CATEGORY_OFFENSIVE "Offensive"
// Offensive wizard spells
/datum/spellbook_entry/fireball
	name = "Fireball"
	desc = "Dispara uma bola de fogo explosiva em um alvo. Considerado um clássico entre todos os magos."
	spell_type = /datum/action/cooldown/spell/pointed/projectile/fireball
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/spell_cards
	name = "Spell Cards"
	desc = "Cartas de fogo rápido. Envie seus inimigos para o reino das sombras com seu poder místico!"
	spell_type = /datum/action/cooldown/spell/pointed/projectile/spell_cards
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/rod_form
	name = "Rod Form"
	desc = "Tome a forma de uma vara imóvel, destruindo tudo em seu caminho. Comprar esse feitiço várias vezes também aumentará o dano da haste e o alcance de viagem."
	spell_type = /datum/action/cooldown/spell/rod_form
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/disintegrate
	name = "Smite"
	desc = "Acusa sua mão com uma energia profana que pode ser usada para causar uma vítima tocada a explodir violentamente."
	spell_type = /datum/action/cooldown/spell/touch/smite
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/summon_simians
	name = "Summon Simians"
	desc = "Este feitiço atinge profundamente o plano elementar das bananas (o macaco, não o palhaço), e\
Invoca macacos primitivos e gorilas menores que logo vão pirar e atacar tudo que se vê. Divertido!\
Suas mentes menores e facilmente manipuláveis estarão convencidas de que você é um dos aliados deles, mas só por um minuto. A menos que você também seja um macaco."
	spell_type = /datum/action/cooldown/spell/conjure/simian
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/blind
	name = "Blind"
	desc = "Cega temporariamente um único alvo."
	spell_type = /datum/action/cooldown/spell/pointed/blind
	category = SPELLBOOK_CATEGORY_OFFENSIVE
	cost = 1

/datum/spellbook_entry/tie_shoes
	name = "Tie Shoes"
	desc = "Este feitiço despretensioso primeiro desamarra, depois amarra os sapatos do alvo. Enquanto fraco à primeira vista, cada atualização acalma o feitiço, permitindo que ele desatar sapatos sem rendas e até mesmo chamar sapatos para nó!"
	spell_type = /datum/action/cooldown/spell/pointed/untie_shoes
	category = SPELLBOOK_CATEGORY_OFFENSIVE
	cost = 1

/datum/spellbook_entry/mutate
	name = "Mutate"
	desc = "Faz você se transformar em um Hulk e ganhar visão laser por pouco tempo."
	spell_type = /datum/action/cooldown/spell/apply_mutations/mutate
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/fleshtostone
	name = "Flesh to Stone"
	desc = "Cobra sua mão com o poder de transformar vítimas em estátuas inertes por um longo período de tempo."
	spell_type = /datum/action/cooldown/spell/touch/flesh_to_stone
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/teslablast
	name = "Tesla Blast"
	desc = "Carregue um arco de tesla e solte-o em um alvo aleatório próximo! Você pode se mover livremente enquanto carrega. O arco salta entre os alvos e pode derrubá-los."
	spell_type = /datum/action/cooldown/spell/charged/beam/tesla
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/lightningbolt
	name = "Lightning Bolt"
	desc = "Dispare um raio em seus inimigos! Vai pular entre os alvos, mas não pode derrubá-los."
	spell_type = /datum/action/cooldown/spell/pointed/projectile/lightningbolt
	category = SPELLBOOK_CATEGORY_OFFENSIVE
	cost = 1

/datum/spellbook_entry/infinite_guns
	name = "Lesser Summon Guns"
	desc = "Por que recarregar quando você tem armas infinitas? Invoca um fluxo interminável de rifles de ação que causam pequenos danos, mas derrubarão alvos. Requer as duas mãos livres para usar. Aprender esse feitiço o torna incapaz de aprender Arcane Barrage."
	spell_type = /datum/action/cooldown/spell/conjure_item/infinite_guns/gun
	category = SPELLBOOK_CATEGORY_OFFENSIVE
	cost = 3
	no_coexistence_typecache = list(/datum/action/cooldown/spell/conjure_item/infinite_guns/arcane_barrage)

/datum/spellbook_entry/arcane_barrage
	name = "Arcane Barrage"
	desc = "Dispare uma torrente de energia arcana em seus inimigos com este feitiço. Faz mais estragos que armas de Invocação Menor, mas não derruba alvos. Requer as duas mãos livres para usar. Aprender esse feitiço te faz incapaz de aprender a Invocação de Menores."
	spell_type = /datum/action/cooldown/spell/conjure_item/infinite_guns/arcane_barrage
	category = SPELLBOOK_CATEGORY_OFFENSIVE
	cost = 3
	no_coexistence_typecache = list(/datum/action/cooldown/spell/conjure_item/infinite_guns/gun)

/datum/spellbook_entry/barnyard
	name = "Barnyard Curse"
	desc = "Este feitiço condena uma alma azarada a possuir a fala e atributos faciais de um animal de celeiro."
	spell_type = /datum/action/cooldown/spell/pointed/barnyardcurse
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/splattercasting
	name = "Splattercasting"
	desc = "Dramaticamente reduz o resfriamento em todos os feitiços, mas cada um custará sangue, assim como naturalmente.\
drenando de você ao longo do tempo. Você pode reabastecê-lo de suas vítimas, especificamente seus pescoços."
	spell_type =  /datum/action/cooldown/spell/splattercasting
	category = SPELLBOOK_CATEGORY_OFFENSIVE
	no_coexistence_typecache = list(/datum/action/cooldown/spell/lichdom, /datum/spellbook_entry/ghostliness)

/datum/spellbook_entry/sanguine_strike
	name = "Exsanguinating Strike"
	desc = "Sanguine soletra que encanta sua próxima arma para lidar com mais danos, curar você por danos causados, e encher de sangue."
	spell_type =  /datum/action/cooldown/spell/sanguine_strike
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/scream_for_me
	name = "Scream For Me"
	desc = "Feitiço sangüíneo sádico que inflige vários ferimentos graves de sangue no corpo da vítima."
	spell_type =  /datum/action/cooldown/spell/touch/scream_for_me
	cost = 1
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/item/staffchaos
	name = "Staff of Chaos"
	desc = "Uma ferramenta caprichosa que pode disparar todos os tipos de magia sem qualquer rima ou razão. Usar em pessoas que você gosta não é recomendado."
	item_path = /obj/item/gun/magic/staff/chaos
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/item/staffchange
	name = "Staff of Change"
	desc = "Um artefato que cospe raios de energia que fazem o alvo se remodelar."
	item_path = /obj/item/gun/magic/staff/change
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/item/mjolnir
	name = "Mjolnir"
	desc = "Um poderoso martelo emprestado de Thor, Deus do Trovão. Ele estala com pouco poder contido. Requer empunhar em ambas as mãos para liberar seu verdadeiro potencial."
	item_path = /obj/item/mjollnir
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/item/singularity_hammer
	name = "Singularity Hammer"
	desc = "Um martelo que cria um campo de gravidade intensamente poderoso onde ataca, puxando tudo próximo ao ponto de impacto. Requer empunhar em ambas as mãos para liberar seu verdadeiro potencial."
	item_path = /obj/item/singularityhammer
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/item/spellblade
	name = "Spellblade"
	desc = "Uma espada capaz de disparar explosões de energia que arrancam alvos membro a membro."
	item_path = /obj/item/gun/magic/staff/spellblade
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/item/highfrequencyblade
	name = "High Frequency Blade"
	desc = "Uma lâmina encantada incrivelmente rápida ressoando em uma frequência alta o suficiente para ser capaz de cortar qualquer coisa."
	item_path = /obj/item/highfrequencyblade/wizard
	category = SPELLBOOK_CATEGORY_OFFENSIVE
	cost = 3

/datum/spellbook_entry/item/frog_contract
	name = "Frog Contract"
	desc = "Assine um pacto com os sapos para ter seu próprio guardião destrutivo!"
	item_path = /obj/item/frog_contract
	category = SPELLBOOK_CATEGORY_OFFENSIVE

/datum/spellbook_entry/item/staffshrink
	name = "Staff of Shrinking"
	desc = "Um artefato que pode encolher qualquer coisa por uma duração razoável. Pequenas estruturas podem ser pisadas, e pessoas pequenas são muito vulneráveis (muitas vezes porque sua armadura não se encaixa mais)."
	item_path = /obj/item/gun/magic/staff/shrink
	category = SPELLBOOK_CATEGORY_OFFENSIVE


#undef SPELLBOOK_CATEGORY_OFFENSIVE
