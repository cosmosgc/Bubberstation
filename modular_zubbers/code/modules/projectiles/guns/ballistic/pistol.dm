/obj/item/gun/ballistic/automatic/pistol/ntusp
	name = "\improper NT22-HCS 'Enforcer'"
	desc = "Uma arma compacta do programa de segurança e defesa interna de Nanotrasen."
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "ntusp"
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/recharge/ntusp
	can_suppress = TRUE
	bolt_type = BOLT_TYPE_LOCKING
	vary_fire_sound = FALSE
	fire_sound_volume = 80
	bolt_wording = "slide"
	suppressor_x_offset = 0

/obj/item/gun/ballistic/automatic/pistol/ntusp/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)


/obj/item/gun/ballistic/automatic/pistol/ntusp/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("Você pode." + EXAMINE_HINT("Olhe mais de perto.") + " to learn a little more about [src]."), \
		lore = "O NT22-HCS representa a primeira aplicação bem-sucedida da tecnologia de projeção de luz dura em um formato viável de arma. Informalmente designado 'Enforcer' pelo pessoal da DAP, foi desenvolvido sob o programa Hardlight Application Research Modeling, criado para a Divisão de Proteção de Ativos.<br>\
			<br>\
Em vez de munição convencional, o NT22-HCS dispara balas de luz dura sem caixa .22HL, sintetizadas como o momento de descarga de alta densidade, NT pacotes de bateria patenteados inseridos na revista bem. A arma não produz cápsulas nem material recuperável.<br>\
			<br>\
As balas .22HL são aceleradas a uma velocidade considerável, fornecendo força cinética significativa no ponto de impacto antes de desaparecerem completamente, sem deixar material incorporado. Como efeito secundário, a energia térmica gerada pela velocidade terminal do projétil produz queimaduras de atrito dolorosas no local de contato.<br>\
			<br>\
O NT22-HCS é o instrumento preferido da Divisão de Proteção de Ativos para operações de proteção executiva, controle de acesso e neutralização de ameaças. É classificado como uma arma menos letal. Indivíduos atingidos por .22HL podem esperar uma resposta significativa à dor, desorientação e perda da função motora voluntária. Diretrizes operacionais recomendam a implantação contra indivíduos não conformes onde a dissuasão verbal falhou, e a escalada para resposta letal não é justificada.<br>\
			<br>\
Dados longitudinais sobre exposição cumulativa a .22HL permanecem bastante limitados, resultado da novidade da tecnologia e da circulação extremamente restrita de relatórios médicos pós-incidentes." \
	)

/obj/item/gun/ballistic/automatic/pistol/ntusp/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 15, \
		overlay_y = 13)

/obj/item/gun/ballistic/automatic/pistol/deagle/regal
	desc = "Ao contrário da Águia do Deserto, esta arma parece utilizar algum tipo de sistema avançado de estabilização interna para significativamente\
Reduzir o retrocesso e aumentar a precisão geral, ao custo de usar um calibre menor.\
O menor calibre em questão, no entanto, consiste em balas feitas sob medida de alta potência, o que faz com que toda a afirmação de que usando um calibre menor do que uma Águia Desert completamente inútil.\
Isso permite disparar uma explosão rápida de 2 balas. Usa munição de 10mm."
	projectile_damage_multiplier = 1.0
	custom_materials = list(
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 30,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 25,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 11.5
	)
