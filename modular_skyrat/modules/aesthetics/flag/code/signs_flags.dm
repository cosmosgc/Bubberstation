/obj/structure/sign/flag
	name = "blank flag"
	desc = "A bandeira de nada. Não tem nada nele. Magnífico."
	icon = 'modular_skyrat/modules/aesthetics/flag/icons/flags.dmi'
	icon_state = "flag_coder"
	buildable_sign = FALSE
	custom_materials = null
	var/item_flag = /obj/item/sign/flag

/obj/structure/sign/flag/wrench_act(mob/living/user, obj/item/wrench/I)
	return

/obj/structure/sign/flag/welder_act(mob/living/user, obj/item/I)
	return

/obj/structure/sign/flag/mouse_drop_dragged(atom/over, mob/user, src_location, over_location, params)
	if(over == user && Adjacent(user))
		if(!item_flag || src.obj_flags & NO_DEBRIS_AFTER_DECONSTRUCTION)
			return
		if(!user.can_perform_action(src, NEED_DEXTERITY))
			return
		user.visible_message(span_notice("[user]Pega e dobra\the [src.name]."), span_notice("Você agarra e dobra\the [src.name]."))
		var/obj/item/flag_item = new item_flag(loc)
		TransferComponents(flag_item)
		user.put_in_hands(flag_item)
		qdel(src)

/obj/structure/sign/flag/ssc
	name = "flag of the Akula Democratic Union"
	desc = "A bandeira da União Democrática de Akula. Uma bandeira voada por um povo orgulhoso, representando os oceanos de onde vieram, e voltará."
	icon_state = "flag_agurk"
	item_flag = /obj/item/sign/flag/ssc

/obj/structure/sign/flag/nanotrasen
	name = "flag of Nanotrasen"
	desc = "A bandeira corporativa oficial de Nanotrasen. A maioria voou como uma peça cerimonial, ou para marcar a terra em uma nova fronteira."
	icon_state = "flag_nt"
	item_flag = /obj/item/sign/flag/nanotrasen

/obj/structure/sign/flag/tizira
	name = "flag of the Republic of Northern Moghes"
	desc = "A bandeira da Grande República de Moghes do Norte. Dependendo de quem perguntar, representa força ou ser uma formiga na colméia."
	icon_state = "flag_tizira"
	item_flag = /obj/item/sign/flag/tizira

/obj/structure/sign/flag/mothic
	name = "flag of the Grand Nomad Fleet"
	desc = "A bandeira da frota Mothic Grand Nomad. Um clássico alferes naval, seu uso superou a velha bandeira nacional que pode ser vista em seu cantão."
	icon_state = "flag_mothic"
	item_flag = /obj/item/sign/flag/mothic

/obj/structure/sign/flag/mars
	name = "flag of the Teshari League for Self-Determination"
	desc = "A bandeira da Liga Teshari para a Auto-Determinação. Originalmente uma bandeira revolucionária durante o tempo da República da Pena de Ouro, desde então tem sido adotada como a bandeira oficial do planeta, como um lembrete de como Teshari lutou por representação e independência."
	icon_state = "flag_mars"
	item_flag = /obj/item/sign/flag/mars

/obj/structure/sign/flag/terragov
	name = "flag of Terran Government"
	desc = "A bandeira do Governo Terrano. É um símbolo da humanidade, não importa aonde vão, ou o quanto gostariam que não fosse."
	icon_state = "flag_terragov"
	item_flag = /obj/item/sign/flag/terragov

/obj/structure/sign/flag/nri
	name = "flag of the Pan-Slavic Commonwealth"
	desc = "A bandeira da Comunidade Pan-eslava. Como núcleos pan-eslavas, azul, branco e vermelho, como definido em 1848 na Terra."
	icon_state = "flag_nri"
	item_flag = /obj/item/sign/flag/nri

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/nri, 32)

/obj/structure/sign/flag/azulea
	name = "banner of the Akula Democratic Union"
	desc = "Um cartaz muitas vezes pendurado orgulhosamente por Akula com um grande amor de seu povo. Muitas vezes pendurado em pares em locais de comando."
	icon_state = "flag_azulea"
	item_flag = /obj/item/sign/flag/azulea

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/azulea, 32)

/// Please, for the love of God, use this in Black Mesa ONLY. NOWHERE ELSE. It's the only reason it was allowed in the game.
/obj/structure/sign/flag/usa
	name = "flag of the United States of America"
	desc = "\"Estrelas e Listras\", a bandeira dos Estados Unidos da América. Sua cor vermelha representa resistência e valor, azul mostra diligência, vigilância e justiça, e o branco mostra pureza. Suas treze listras vermelhas e brancas mostram as primeiras treze colônias fundadoras, e cinquenta estrelas designam os atuais cinquenta estados."
	icon_state = "flag_usa"
	item_flag = /obj/item/sign/flag/usa

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/usa, 32)

/obj/structure/sign/flag/syndicate
	name = "flag of the Syndicate"
	desc = "A bandeira do Sindicato Sothran. Anteriormente usado pelo povo Sothran como uma forma de declarar oposição contra os Nanotrasen, agora tornou-se um símbolo intergaláctico do mesmo, ainda mais distorcido propósito, como mais grupos de interesse se juntaram ao lado da rebelião para seu próprio ganho."
	icon_state = "flag_syndi"
	item_flag = /obj/item/sign/flag/syndicate

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/syndicate, 32)

/obj/item/sign/flag
	name = "folded blank flag"
	desc = "A bandeira dobrada de nada. Não tem nada nele. Lindo."
	icon = 'modular_skyrat/modules/aesthetics/flag/icons/flags.dmi'
	icon_state = "folded_coder"
	sign_path = /obj/structure/sign/flag
	is_editable = FALSE
	custom_materials = null

///Since all of the signs rotate themselves on initialisation, this made folded flags look ugly (and more importantly rotated).
///And thus, it gets removed to make them aesthetically pleasing once again.
/obj/item/sign/flag/Initialize(mapload)
	. = ..()
	var/matrix/rotation_reset = matrix()
	rotation_reset.Turn(0)
	transform = rotation_reset

/obj/item/sign/flag/welder_act(mob/living/user, obj/item/I)
	return

/obj/item/sign/flag/nanotrasen
	name = "folded flag of the Nanotrasen"
	desc = "A bandeira dobrada do Nanotrasen."
	icon_state = "folded_nt"
	sign_path = /obj/structure/sign/flag/nanotrasen

/obj/item/sign/flag/ssc
	name = "folded flag of the Akula Democratic Union"
	desc = "A bandeira dobrada da União Democrática de Akula."
	icon_state = "folded_agurk"
	sign_path = /obj/structure/sign/flag/ssc

/obj/item/sign/flag/terragov
	name = "folded flag of the Terran Government"
	desc = "A bandeira dobrada do Governo Terrano."
	icon_state = "folded_terragov"
	sign_path = /obj/structure/sign/flag/terragov

/obj/item/sign/flag/tizira
	name = "folded flag of the Republic of Northern Moghes"
	desc = "A bandeira dobrada da República de Moghes do Norte."
	icon_state = "folded_tizira"
	sign_path = /obj/structure/sign/flag/tizira

/obj/item/sign/flag/mothic
	name = "folded flag of the Grand Nomad Fleet"
	desc = "A bandeira dobrada da espuma Grand Nomad."
	icon_state = "folded_mothic"
	sign_path = /obj/structure/sign/flag/mothic

/obj/item/sign/flag/mars
	name = "folded flag of the Teshari League for Self-Determination"
	desc = "A bandeira dobrada da Liga Teshari para Auto-Determinação."
	icon_state = "folded_mars"
	sign_path = /obj/structure/sign/flag/mars

/obj/item/sign/flag/nri
	name = "folded flag of the Pan-Slavic Commonwealth"
	desc = "A bandeira dobrada da Comunidade Pan-eslava."
	icon_state = "folded_nri"
	sign_path = /obj/structure/sign/flag/nri

/obj/item/sign/flag/azulea
	name = "folded banner of the Akula Democratic Union"
	desc = "A bandeira dobrada da União Democrática de Akula."
	icon_state = "folded_azulea"
	sign_path = /obj/structure/sign/flag/azulea

/// Please, for the love of God, use this in Black Mesa ONLY. NOWHERE ELSE. It's the only reason it was allowed in the game.
/obj/item/sign/flag/usa
	name = "folded flag of the United States of America"
	desc = "A bandeira dobrada dos EUA."
	icon_state = "folded_usa"
	sign_path = /obj/structure/sign/flag/usa

/obj/item/sign/flag/syndicate
	name = "folded flag of the Syndicate"
	desc = "A bandeira dobrada do Sindicato Sothran."
	icon_state = "folded_syndi"
	sign_path = /obj/structure/sign/flag/syndicate
