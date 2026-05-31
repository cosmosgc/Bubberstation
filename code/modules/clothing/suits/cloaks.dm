//Cloaks. No, not THAT kind of cloak.

/obj/item/clothing/neck/cloak
	name = "brown cloak"
	desc = "É uma capa que pode ser usada no seu pescoço."
	icon = 'icons/obj/clothing/cloaks.dmi'
	worn_icon = 'icons/mob/clothing/neck.dmi'
	icon_state = "qmcloak"
	inhand_icon_state = null
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDESUITSTORAGE

/obj/item/clothing/neck/cloak/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/surgery_aid, "cloak")

/obj/item/clothing/neck/cloak/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]Está estrangulando[user.p_them()]ego com[src]Parece que...[user.p_theyre()]Tentando cometer suicídio!"))
	return OXYLOSS

/obj/item/clothing/neck/cloak/hos
	name = "head of security's cloak"
	desc = "Usado pelo Securistan, governando a estação com um punho de ferro."
	icon_state = "hoscloak"

/obj/item/clothing/neck/cloak/qm
	name = "quartermaster's cloak"
	desc = "Usado pela Cargonia, fornecendo à estação as ferramentas necessárias para sobreviver."

/obj/item/clothing/neck/cloak/cmo
	name = "chief medical officer's cloak"
	desc = "Usados pela Meditopia, os valentes homens e mulheres mantendo a pestilência longe."
	icon_state = "cmocloak"

/obj/item/clothing/neck/cloak/ce
	name = "chief engineer's cloak"
	desc = "Usado por Engitopia, possíveis de um poder limitado."
	icon_state = "cecloak"
	resistance_flags = FIRE_PROOF

/obj/item/clothing/neck/cloak/rd
	name = "research director's cloak"
	desc = "Usado por Sciencia, taumaturgos e pesquisadores do universo."
	icon_state = "rdcloak"

/obj/item/clothing/neck/cloak/cap
	name = "captain's cloak"
	desc = "Usado pelo comandante da Estação Espacial 13."
	icon_state = "capcloak"

/obj/item/clothing/neck/cloak/hop
	name = "head of personnel's cloak"
	desc = "Usado pelo Chef de Pessoal. Cheira levemente a burocracia."
	icon_state = "hopcloak"

/obj/item/clothing/neck/cloak/skill_reward
	var/associated_skill_path = /datum/skill
	var/element_type = /datum/element/skill_reward
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE

/obj/item/clothing/neck/cloak/skill_reward/Initialize(mapload)
	. = ..()
	AddElement(element_type, associated_skill_path)

/obj/item/clothing/neck/cloak/skill_reward/gaming
	name = "legendary gamer's cloak"
	desc = "Usado pelos jogadores profissionais mais habilidosos da estação, esta capa lendária só é alcançável por alcançar a verdadeira iluminação dos jogos. Este símbolo de status representa o incrível poder de um ser de foco, compromisso e pura vontade. Algo que jogadores casuais nunca vão entender."
	icon_state = "gamercloak"
	associated_skill_path = /datum/skill/gaming

/obj/item/clothing/neck/cloak/skill_reward/cleaning
	name = "legendary cleaner's cloak"
	desc = "Usado pelos guardas mais hábeis, esta capa lendária só é alcançável através da iluminação de limpeza. Este símbolo de status representa um ser não só extensivamente treinado em combate sujo, mas alguém que está disposto a usar todo um arsenal de suprimentos de limpeza em sua extensão para limpar a bunda miserável de Grime fora da face da estação."
	icon_state = "cleanercloak"
	associated_skill_path = /datum/skill/cleaning

/obj/item/clothing/neck/cloak/skill_reward/mining
	name = "legendary miner's cloak"
	desc = "Usado pelos mineiros mais hábeis, esta capa lendária só é alcançável por alcançar a verdadeira iluminação mineral. Este símbolo de status representa um ser que esqueceu mais sobre rochas do que a maioria dos mineiros jamais saberá, um ser que moveu montanhas e vales cheios."
	icon_state = "minercloak"
	associated_skill_path = /datum/skill/mining

/obj/item/clothing/neck/cloak/skill_reward/playing
	name = "legendary veteran's cloak"
	desc = "Usado pelo mais sábio dos empregados veteranos, esta capa lendária só é alcançável mantendo um contrato de trabalho vivo com Nanotrasen para mais<b>Cinco mil horas.</b>Este símbolo de status representa um ser melhor do que você em quase todas as maneiras quantificáveis, simples assim."
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi' //Bubber Addition
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi' //Bubber Addition
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/species/teshari/neck.dmi' //Bubber Addition
	icon_state = "playercloak"
	element_type = /datum/element/skill_reward/veteran
