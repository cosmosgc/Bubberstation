
/obj/item/poster/random_abductor
	name = "random abductor poster"
	poster_type = /obj/structure/sign/poster/abductor/random
	icon = 'icons/obj/poster.dmi'
	icon_state = "rolled_abductor"

/obj/structure/sign/poster/abductor
	icon = 'icons/obj/poster.dmi'
	poster_item_name = "abductor poster"
	poster_item_desc = "Uma folha de resina holofiber, com uma perfuração de nanospike na extremidade traseira para máxima adesão."
	poster_item_icon_state = "rolled_abductor"

/obj/structure/sign/poster/abductor/tear_poster(mob/user)
	if(!isabductor(user))
		balloon_alert(user, "Não se mexe!")
		return
	return ..()

/obj/structure/sign/poster/abductor/attackby(obj/item/tool, mob/user, list/modifiers, list/attack_modifiers)
	if(tool.toolspeed >= 0.2)
		balloon_alert(user, "Ferramenta fraca demais!")
		return FALSE
	return ..()

/obj/structure/sign/poster/abductor/random
	name = "random abductor poster"
	icon_state = "random_abductor"
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster/abductor

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/abductor/random, 32)

/obj/structure/sign/poster/abductor/ayylian
	name = "Ayylian"
	desc = "Cara, Ian parece estranho ultimamente."
	icon_state = "ayylian"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/abductor/ayylian, 32)

/obj/structure/sign/poster/abductor/ayy
	name = "Abductor"
	desc = "Isso não é um lagarto!"
	icon_state = "ayy"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/abductor/ayy, 32)

/obj/structure/sign/poster/abductor/ayy_over_tizira
	name = "Abductors Over Tizira"
	desc = "Um pôster para uma adaptação experimental de um filme sobre a guerra Human-Lizard. A produção foi muito prejudicada pela recusa do par principal em falar qualquer linha."
	icon_state = "ayy_over_tizira"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/abductor/ayy_over_tizira, 32)

/obj/structure/sign/poster/abductor/ayy_recruitment
	name = "Abductor Recruitment"
	desc = "Aliste-se na Divisão de Sondagem da Nave Mãe hoje!"
	icon_state = "ayy_recruitment"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/abductor/ayy_recruitment, 32)

/obj/structure/sign/poster/abductor/ayy_cops
	name = "Abductor Cops"
	desc = "Um pôster anunciando a polarização da série 'Abdutora Cops'. Alguns críticos alegaram que isso os atordoou, enquanto outros disseram que os fez dormir."
	icon_state = "ayyce_cops"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/abductor/ayy_cops, 32)

/obj/structure/sign/poster/abductor/ayy_no
	name = "Uayy No"
	desc = "Essa coisa está em japonês, e eles se livraram da garota anime no pôster. Ultrajante."
	icon_state = "ayy_no"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/abductor/ayy_no, 32)

/obj/structure/sign/poster/abductor/ayy_piping
	name = "Safety Abductor - Piping"
	desc = "Safety Raptor não tem nada a dizer. Não porque não pode falar, mas porque os raptores não têm que lidar com coisas do Atmos."
	icon_state = "ayy_piping"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/abductor/ayy_piping, 32)

/obj/structure/sign/poster/abductor/ayy_fancy
	name = "Abductor Fancy"
	desc = "Raptores são os melhores em fazer tudo. Isso inclui estar bonito!"
	icon_state = "ayy_fancy"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/abductor/ayy_fancy, 32)
