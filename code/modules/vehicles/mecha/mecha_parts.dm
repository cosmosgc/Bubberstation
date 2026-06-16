/////////////////////////
////// Mecha Parts //////
/////////////////////////

/obj/item/mecha_parts
	name = "mecha part"
	icon = 'icons/mob/rideables/mech_construct.dmi'
	icon_state = "blank"
	abstract_type = /obj/item/mecha_parts
	w_class = WEIGHT_CLASS_GIGANTIC
	obj_flags = CONDUCTS_ELECTRICITY
	sound_vary = TRUE
	pickup_sound = SFX_GENERIC_DEVICE_PICKUP
	drop_sound = SFX_GENERIC_DEVICE_DROP

/obj/item/mecha_parts/proc/try_attach_part(mob/user, obj/vehicle/sealed/mecha/M, attach_right = FALSE) //For attaching parts to a finished mech
	if(!user.transferItemToLoc(src, M))
		to_chat(user, span_warning("\The [src] está preso em sua mão, você não pode colocá-lo em\the [M]!"))
		return ITEM_INTERACT_BLOCKING
	user.visible_message(span_notice("[user] APENAS [src] para [M]."), span_notice("Você anexa [src] para [M]."))
	return ITEM_INTERACT_SUCCESS

/obj/item/mecha_parts/part/try_attach_part(mob/user, obj/vehicle/sealed/mecha/M, attach_right = FALSE)
	return ITEM_INTERACT_SUCCESS

/obj/item/mecha_parts/chassis
	name = "Mecha Chassis"
	icon_state = "backbone"
	interaction_flags_item = NONE //Don't pick us up!!
	var/construct_type

/obj/item/mecha_parts/chassis/Initialize(mapload)
	. = ..()
	if(construct_type)
		AddComponent(construct_type)

/////////// Ripley

/obj/item/mecha_parts/chassis/ripley
	name = "\improper Ripley chassis"
	construct_type = /datum/component/construction/unordered/mecha_chassis/ripley

/obj/item/mecha_parts/part/ripley_torso
	name = "\improper Ripley torso"
	desc = "Parte do tronco de Ripley APLU. Contém unidade de energia, núcleo de processamento e sistemas de suporte de vida."
	icon_state = "ripley_harness"

/obj/item/mecha_parts/part/ripley_left_arm
	name = "\improper Ripley left arm"
	desc = "Um braço esquerdo Ripley APLU. Dados e tomadas de energia são compatíveis com a maioria das ferramentas de exosuit."
	icon_state = "ripley_l_arm"

/obj/item/mecha_parts/part/ripley_right_arm
	name = "\improper Ripley right arm"
	desc = "Um braço direito Ripley APLU. Dados e tomadas de energia são compatíveis com a maioria das ferramentas de exosuit."
	icon_state = "ripley_r_arm"

/obj/item/mecha_parts/part/ripley_left_leg
	name = "\improper Ripley left leg"
	desc = "Perna esquerda Ripley APLU. Contém servodrives complexos e sistemas de manutenção de equilíbrio."
	icon_state = "ripley_l_leg"

/obj/item/mecha_parts/part/ripley_right_leg
	name = "\improper Ripley right leg"
	desc = "Uma perna direita Ripley APLU. Contém servodrives complexos e sistemas de manutenção de equilíbrio."
	icon_state = "ripley_r_leg"

///////// Odysseus

/obj/item/mecha_parts/chassis/odysseus
	name = "\improper Odysseus chassis"
	construct_type = /datum/component/construction/unordered/mecha_chassis/odysseus

/obj/item/mecha_parts/part/odysseus_head
	name = "\improper Odysseus head"
	desc = "Uma cabeça de Odisseu. Contém um scanner médico integrado."
	icon_state = "odysseus_head"

/obj/item/mecha_parts/part/odysseus_torso
	name = "\improper Odysseus torso"
	desc="Uma parte do tronco de Odisseu. Contém unidade de energia, núcleo de processamento e sistemas de suporte de vida juntamente com uma porta de ligação para um adormecimento montado."
	icon_state = "odysseus_torso"

/obj/item/mecha_parts/part/odysseus_left_arm
	name = "\improper Odysseus left arm"
	desc = "Um braço esquerdo de Odisseu. Dados e tomadas de energia são compatíveis com equipamentos médicos especializados."
	icon_state = "odysseus_l_arm"

/obj/item/mecha_parts/part/odysseus_right_arm
	name = "\improper Odysseus right arm"
	desc = "Um braço direito de Odisseu. Dados e tomadas de energia são compatíveis com equipamentos médicos especializados."
	icon_state = "odysseus_r_arm"

/obj/item/mecha_parts/part/odysseus_left_leg
	name = "\improper Odysseus left leg"
	desc = "Uma perna esquerda de Odisseu. Contém servodrives complexos e sistemas de manutenção de equilíbrio para manter estabilidade para pacientes críticos."
	icon_state = "odysseus_l_leg"

/obj/item/mecha_parts/part/odysseus_right_leg
	name = "\improper Odysseus right leg"
	desc = "Uma perna direita odisseu. Contém servodrives complexos e sistemas de manutenção de equilíbrio para manter estabilidade para pacientes críticos."
	icon_state = "odysseus_r_leg"

///////// Gygax

/obj/item/mecha_parts/chassis/gygax
	name = "\improper Gygax chassis"
	construct_type = /datum/component/construction/unordered/mecha_chassis/gygax

/obj/item/mecha_parts/part/gygax_torso
	name = "\improper Gygax torso"
	desc = "Uma parte do tronco de Gygax. Contém unidade de energia, núcleo de processamento e sistemas de suporte de vida."
	icon_state = "gygax_harness"

/obj/item/mecha_parts/part/gygax_head
	name = "\improper Gygax head"
	desc = "Uma cabeça de Gygax. Casas de vigilância avançada e sensores de alvo."
	icon_state = "gygax_head"

/obj/item/mecha_parts/part/gygax_left_arm
	name = "\improper Gygax left arm"
	desc = "Um braço esquerdo Gygax. Dados e tomadas de energia são compatíveis com a maioria das ferramentas e armas."
	icon_state = "gygax_l_arm"

/obj/item/mecha_parts/part/gygax_right_arm
	name = "\improper Gygax right arm"
	desc = "Um braço direito Gygax. Dados e tomadas de energia são compatíveis com a maioria das ferramentas e armas."
	icon_state = "gygax_r_arm"

/obj/item/mecha_parts/part/gygax_left_leg
	name = "\improper Gygax left leg"
	desc = "Uma perna esquerda Gygax. Construído com servomecanismos avançados e atuadores para permitir velocidade mais rápida."
	icon_state = "gygax_l_leg"

/obj/item/mecha_parts/part/gygax_right_leg
	name = "\improper Gygax right leg"
	desc = "Uma perna direita Gygax. Construído com servomecanismos avançados e atuadores para permitir velocidade mais rápida."
	icon_state = "gygax_r_leg"

/obj/item/mecha_parts/part/gygax_armor
	gender = PLURAL
	name = "\improper Gygax armor plates"
	desc = "Um conjunto de placas de armadura projetadas para o Gygax. Projetado para desviar danos com uma construção leve."
	icon_state = "gygax_armor"


//////////// Durand

/obj/item/mecha_parts/chassis/durand
	name = "\improper Durand chassis"
	construct_type = /datum/component/construction/unordered/mecha_chassis/durand

/obj/item/mecha_parts/part/durand_torso
	name = "\improper Durand torso"
	desc = "Uma parte do tronco de Durand. Contém unidade de energia, núcleo de processamento e sistemas de suporte de vida dentro de uma estrutura protetora robusta."
	icon_state = "durand_harness"

/obj/item/mecha_parts/part/durand_head
	name = "\improper Durand head"
	desc = "Uma cabeça Durand. Casas de vigilância avançada e sensores de alvo."
	icon_state = "durand_head"

/obj/item/mecha_parts/part/durand_left_arm
	name = "\improper Durand left arm"
	desc = "Um braço esquerdo Durand. Dados e tomadas de energia são compatíveis com a maioria das ferramentas e armas. É um soco muito bom também."
	icon_state = "durand_l_arm"

/obj/item/mecha_parts/part/durand_right_arm
	name = "\improper Durand right arm"
	desc = "Um braço direito Durand. Dados e tomadas de energia são compatíveis com a maioria das ferramentas e armas. É um soco muito bom também."
	icon_state = "durand_r_arm"

/obj/item/mecha_parts/part/durand_left_leg
	name = "\improper Durand left leg"
	desc = "Uma perna esquerda Durand. Construído especialmente resistente para apoiar o peso pesado e necessidades defensivas do Durand."
	icon_state = "durand_l_leg"

/obj/item/mecha_parts/part/durand_right_leg
	name = "\improper Durand right leg"
	desc = "Uma perna direita Durand. Construído especialmente resistente para apoiar o peso pesado e necessidades defensivas do Durand."
	icon_state = "durand_r_leg"

/obj/item/mecha_parts/part/durand_armor
	gender = PLURAL
	name = "\improper Durand armor plates"
	desc = "Um conjunto de placas de armadura para o Durand. Construído pesado para resistir a uma incrível quantidade de força bruta."
	icon_state = "durand_armor"

////////// Clarke

/obj/item/mecha_parts/chassis/clarke
	name = "\improper Clarke chassis"
	construct_type = /datum/component/construction/unordered/mecha_chassis/clarke

/obj/item/mecha_parts/part/clarke_torso
	name = "\improper Clarke torso"
	desc = "Uma parte do torso de Clarke. Contém unidade de energia, núcleo de processamento e sistemas de suporte de vida."
	icon_state = "clarke_harness"

/obj/item/mecha_parts/part/clarke_head
	name = "\improper Clarke head"
	desc = "Uma cabeça Clarke. Contém um scanner de diagnóstico integrado."
	icon_state = "clarke_head"

/obj/item/mecha_parts/part/clarke_left_arm
	name = "\improper Clarke left arm"
	desc = "Um braço esquerdo da Clarke. Dados e tomadas de energia são compatíveis com a maioria das ferramentas de exosuit."
	icon_state = "clarke_l_arm"

/obj/item/mecha_parts/part/clarke_right_arm
	name = "\improper Clarke right arm"
	desc = "Um braço direito da Clarke. Dados e tomadas de energia são compatíveis com a maioria das ferramentas de exosuit."
	icon_state = "clarke_r_arm"

////////// HONK

/obj/item/mecha_parts/chassis/honker
	name = "\improper H.O.N.K chassis"
	construct_type = /datum/component/construction/unordered/mecha_chassis/honker

/obj/item/mecha_parts/part/honker_torso
	name = "\improper H.O.N.K torso"
	desc = "Uma parte do tronco de H.O.N.K. Contém unidade de rímel, núcleo de banânio e sistemas de suporte de buzina."
	icon_state = "honker_harness"

/obj/item/mecha_parts/part/honker_head
	name = "\improper H.O.N.K head"
	desc = "Uma cabeça de H.O.N.K. Parece que falta uma placa facial."
	icon_state = "honker_head"

/obj/item/mecha_parts/part/honker_left_arm
	name = "\improper H.O.N.K left arm"
	desc = "Um braço esquerdo H.O.N.K. Com soquetes únicos que aceitam armas estranhas projetadas por cientistas palhaços."
	icon_state = "honker_l_arm"

/obj/item/mecha_parts/part/honker_right_arm
	name = "\improper H.O.N.K right arm"
	desc = "Um braço direito H.O.N.K. Com soquetes únicos que aceitam armas estranhas projetadas por cientistas palhaços."
	icon_state = "honker_r_arm"

/obj/item/mecha_parts/part/honker_left_leg
	name = "\improper H.O.N.K left leg"
	desc = "Uma perna esquerda H.O.N.K. O pé parece grande o suficiente para acomodar um sapato de palhaço."
	icon_state = "honker_l_leg"

/obj/item/mecha_parts/part/honker_right_leg
	name = "\improper H.O.N.K right leg"
	desc = "Uma perna direita H.O.N.K. O pé parece grande o suficiente para acomodar um sapato de palhaço."
	icon_state = "honker_r_leg"


////////// Phazon

/obj/item/mecha_parts/chassis/phazon
	name = "\improper Phazon chassis"
	construct_type = /datum/component/construction/unordered/mecha_chassis/phazon

/obj/item/mecha_parts/part/phazon_torso
	name="\improper Phazon torso"
	desc="Uma parte do torso de Phazon. O soquete para o núcleo ectoplasmático que alimenta os impulsos de fase únicos do exosuit está localizado no meio."
	icon_state = "phazon_harness"

/obj/item/mecha_parts/part/phazon_head
	name="\improper Phazon head"
	desc="Uma cabeça de Phazon. Seus sensores são cuidadosamente calibrados para fornecer visão e dados, mesmo quando o exosuit é fasing."
	icon_state = "phazon_head"

/obj/item/mecha_parts/part/phazon_left_arm
	name="\improper Phazon left arm"
	desc="Um braço esquerdo de Phazon. Vários conjuntos de microtool estão localizados sob o revestimento da armadura, que pode ser ajustado à situação atual."
	icon_state = "phazon_l_arm"

/obj/item/mecha_parts/part/phazon_right_arm
	name="\improper Phazon right arm"
	desc="Um braço direito de Phazon. Vários conjuntos de microtool estão localizados sob o revestimento da armadura, que pode ser ajustado à situação atual."
	icon_state = "phazon_r_arm"

/obj/item/mecha_parts/part/phazon_left_leg
	name="\improper Phazon left leg"
	desc="Uma perna esquerda de Phazon. Contém as unidades de fase únicas que permitem que o exossuit phase através de matéria sólida quando engajado."
	icon_state = "phazon_l_leg"

/obj/item/mecha_parts/part/phazon_right_leg
	name="\improper Phazon right leg"
	desc="Uma perna direita de Phazon. Contém as unidades de fase únicas que permitem que o exossuit phase através de matéria sólida quando engajado."
	icon_state = "phazon_r_leg"

/obj/item/mecha_parts/part/phazon_armor
	name="Phazon armor"
	desc="Placas de armadura Phazon. São camadas de plasma para proteger o piloto do estresse de fases e têm propriedades incomuns."
	icon_state = "phazon_armor"

// Savannah-Ivanov

/obj/item/mecha_parts/chassis/savannah_ivanov
	name = "\improper Savannah-Ivanov chassis"
	construct_type = /datum/component/construction/unordered/mecha_chassis/savannah_ivanov

/obj/item/mecha_parts/part/savannah_ivanov_torso
	name="\improper Savannah-Ivanov torso"
	desc="Uma parte do tronco de Savannah-Ivanov. Está faltando um enorme pedaço de espaço..."
	icon_state = "savannah_ivanov_harness"

/obj/item/mecha_parts/part/savannah_ivanov_head
	name="\improper Savannah-Ivanov head"
	desc="Uma cabeça de Savannah-Ivanov. Os sensores foram ajustados para suportar pousos graciosos."
	icon_state = "savannah_ivanov_head"

/obj/item/mecha_parts/part/savannah_ivanov_left_arm
	name="\improper Savannah-Ivanov left arm"
	desc="Um braço esquerdo Savannah-Ivanov. Fabricação de foguetes escondidos incluídos nos pulsos."
	icon_state = "savannah_ivanov_l_arm"

/obj/item/mecha_parts/part/savannah_ivanov_right_arm
	name="\improper Savannah-Ivanov right arm"
	desc="Um braço esquerdo Savannah-Ivanov. Fabricação de foguetes escondidos incluídos nos pulsos."
	icon_state = "savannah_ivanov_r_arm"

/obj/item/mecha_parts/part/savannah_ivanov_left_leg
	name="\improper Savannah-Ivanov left leg"
	desc="Uma perna esquerda de Savannah-Ivanov. Na produção eles foram projetados para transportar mais de dois passageiros, então a funcionalidade pulando foi adicionada para não desperdiçar potencial."
	icon_state = "savannah_ivanov_l_leg"

/obj/item/mecha_parts/part/savannah_ivanov_right_leg
	name="\improper Savannah-Ivanov right leg"
	desc="Uma perna esquerda de Savannah-Ivanov. Na produção eles foram projetados para transportar mais de dois passageiros, então a funcionalidade pulando foi adicionada para não desperdiçar potencial."
	icon_state = "savannah_ivanov_r_leg"

/obj/item/mecha_parts/part/savannah_ivanov_armor
	name="Savannah-Ivanov armor"
	desc="Placas de armadura Savannah-Ivanov. Eles são únicos e reforçados para lidar com as tensões de dois pilotos, grandes saltos, e mísseis."
	icon_state = "savannah_ivanov_armor"

///////// Circuitboards

/obj/item/circuitboard/mecha
	name = "exosuit circuit board"
	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	icon_state = "std_mod"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	force = 5
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 0
	throw_speed = 3
	throw_range = 7

/obj/item/circuitboard/mecha/ripley/peripherals
	name = "Ripley Peripherals Control module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/ripley/main
	name = "Ripley Central Control module (Exosuit Board)"
	icon_state = "mainboard"


/obj/item/circuitboard/mecha/gygax/peripherals
	name = "Gygax Peripherals Control module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/gygax/targeting
	name = "Gygax Weapon Control and Targeting module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/gygax/main
	name = "Gygax Central Control module (Exosuit Board)"
	icon_state = "mainboard"

/obj/item/circuitboard/mecha/durand/peripherals
	name = "Durand Peripherals Control module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/durand/targeting
	name = "Durand Weapon Control and Targeting module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/durand/main
	name = "Durand Central Control module (Exosuit Board)"
	icon_state = "mainboard"

/obj/item/circuitboard/mecha/honker/peripherals
	name = "H.O.N.K Peripherals Control module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/honker/targeting
	name = "H.O.N.K Weapon Control and Targeting module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/honker/main
	name = "H.O.N.K Central Control module (Exosuit Board)"
	icon_state = "mainboard"

/obj/item/circuitboard/mecha/odysseus/peripherals
	name = "Odysseus Peripherals Control module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/odysseus/main
	name = "Odysseus Central Control module (Exosuit Board)"
	icon_state = "mainboard"

/obj/item/circuitboard/mecha/phazon/peripherals
	name = "Phazon Peripherals Control module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/phazon/targeting
	name = "Phazon Weapon Control and Targeting module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/phazon/main
	name = "Phazon Central Control module (Exosuit Board)"

/obj/item/circuitboard/mecha/clarke/peripherals
	name = "Clarke Peripherals Control module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/clarke/main
	name = "Clarke Central Control module (Exosuit Board)"
	icon_state = "mainboard"

/obj/item/circuitboard/mecha/savannah_ivanov/peripherals
	name = "Savannah Peripherals Control module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/savannah_ivanov/targeting
	name = "Ivanov Weapon Control and Targeting module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/savannah_ivanov/main
	name = "Savannah-Ivanov Combination Control Lock module (Exosuit Board)"
	icon_state = "mainboard"
