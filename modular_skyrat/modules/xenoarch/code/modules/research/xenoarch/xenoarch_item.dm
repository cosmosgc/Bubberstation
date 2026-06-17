//useless relics
/obj/item/xenoarch/useless_relic
	name = "useless relic"
	desc = "Uma relíquia inútil que pode ser resgatada por carga ou pontos de pesquisa."
	///Used to spawn the same relic
	var/magnified_number

/obj/item/xenoarch/useless_relic/Initialize(mapload)
	. = ..()
	magnified_number = rand(1,8)
	icon_state = "useless[magnified_number]"

/obj/item/xenoarch/useless_relic/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/glassblowing/magnifying_glass))
		if(istype(src, /obj/item/xenoarch/useless_relic/magnified))
			balloon_alert(user, "Já está ampliado!")
			return

		if(!HAS_TRAIT(user, TRAIT_XENOARCH_QUALIFIED))
			balloon_alert(user, "Precisa de treinamento!") // it was very tempting to replace this with "Questão de habilidade"
			return

		balloon_alert(user, "Começando análise!")
		if(!do_after(user, 5 SECONDS, target = src))
			balloon_alert(user, "Fique parado!")
			return

		loc.balloon_alert(user, "Ampliado!")
		user.mind.adjust_experience(/datum/skill/research, 5)
		spawn_magnified(magnified_number)
		return

	return ..()

#define ANCIENT_URN 1
#define ANCIENT_BOWL 2
#define ANCIENT_CROWN 3
#define ANCIENT_COIL 4
#define ANCIENT_LIGHT 5
#define ANCIENT_CUP 6
#define ANCIENT_UTENSILS 7
#define ANCIENT_R_BOWL 8

/obj/item/xenoarch/useless_relic/proc/spawn_magnified(type_number)
	var/obj/item/xenoarch/useless_relic/magnified/new_item = new(get_turf(src))
	new_item.icon_state = "useless[type_number]"
	switch(type_number)
		if(ANCIENT_URN)
			new_item.name = "ancient urn"
			new_item.desc = "This useless relic is an ancient urn that dates from around [rand(400,600)] years ago. \
			It has made of a ceramic substance and is clearly crumbling at the edges. Perhaps it has ashes \
			of someone from long ago."

		if(ANCIENT_BOWL)
			new_item.name = "ancient bowl"
			new_item.desc = "This useless relic is an ancient bowl that dates from around [rand(400,600)] years ago. \
			It is made of a bronze alloy and is dented, with some scratches along the inside. Perhaps it could \
			have had DNA of someone from long ago."

		if(ANCIENT_CROWN)
			new_item.name = "ancient crown"
			new_item.desc = "This useless relic is an ancient crown that dates from around [rand(900,1100)] years ago. \
			It is made from some unknown alloy, with small inlets that would have been used for jewels. Perhaps if we \
			look around, we could find some of those old jewels."

		if(ANCIENT_COIL)
			new_item.name = "ancient coil"
			new_item.desc = "This useless relic is an ancient coil that dates from around [rand(400,600)] years ago. \
			It is made of iron and copper. It has some burn marks around the iron rod. Perhaps later on, we could \
			use it for some machines."

		if(ANCIENT_LIGHT)
			new_item.name = "ancient light"
			new_item.desc = "This useless relic is an ancient light that dates from around [rand(400,600)] years ago. \
			It is made of iron and has glass shards around it. It has dents on the iron and clear damage from misuse. \
			Perhaps we could research this later on to see how the ancients made lights."

		if(ANCIENT_CUP)
			new_item.name = "ancient cup"
			new_item.desc = "This useless relic is an ancient cup that dates from around [rand(900,1100)] years ago. \
			It is made of hardened stone. There are small cracks all along the surface, as long as chisel marks. \
			Perhaps it will give insight into the ancient's eating and drinking habits."

		if(ANCIENT_UTENSILS)
			new_item.name = "ancient utensils"
			new_item.desc = "These useless relics are ancient utensils that dates from around [rand(900,1100)] years ago. \
			It is made of hardened stone. There are small cracks all along the surface, as long as chisel marks. \
			Perhaps it will give insight into the ancient's eating and drinking habits."

		if(ANCIENT_R_BOWL)
			new_item.name = "ancient rock bowl"
			new_item.desc = "This useless relic is an ancient rock bowl that dates from around [rand(900,1100)] years ago. \
			It is made of hardened stone. There are small cracks all along the surface, as long as chisel marks. \
			Perhaps it will give insight into the ancient's eating and drinking habits."

	new_item.desc += " Whatever use it possibly had in the past, its only use now is either as a museum piece, or being sold off to collectors via the Cargo shuttle."
	qdel(src)

#undef ANCIENT_URN
#undef ANCIENT_BOWL
#undef ANCIENT_CROWN
#undef ANCIENT_COIL
#undef ANCIENT_LIGHT
#undef ANCIENT_CUP
#undef ANCIENT_UTENSILS
#undef ANCIENT_R_BOWL

/obj/item/xenoarch/useless_relic/magnified
	name = "magnified useless relic"
	desc = "Uma relíquia inútil que pode ser exportada através da carga. Foi ampliado."

/datum/export/xenoarch
	abstract_type = /datum/export/xenoarch

/datum/export/xenoarch/useless_relic
	cost = CARGO_CRATE_VALUE * 3 //600
	unit_name = "relíquia inútil"
	export_types = list(/obj/item/xenoarch/useless_relic)
	include_subtypes = FALSE
	k_elasticity = 0

/datum/export/xenoarch/broken_item
	cost = CARGO_CRATE_VALUE*5
	unit_name = "objeto quebrado"
	export_types = list(/obj/item/xenoarch/broken_item)
	include_subtypes = TRUE
	k_elasticity = 0

/datum/export/xenoarch/useless_relic/magnified
	cost = CARGO_CRATE_VALUE * 6 //1200
	unit_name = "Relíquia inútil ampliada"
	export_types = list(/obj/item/xenoarch/useless_relic/magnified)
	include_subtypes = FALSE

//broken items
/obj/item/xenoarch/broken_item
	name = "broken item"
	desc = "Um item que foi danificado, destruído por algum tempo. É possível recuperá-lo."

/obj/item/xenoarch/broken_item/tech
	name = "broken tech"
	icon_state = "recover_tech"

/obj/item/xenoarch/broken_item/weapon
	name = "broken weapon"
	icon_state = "recover_weapon"

/obj/item/xenoarch/broken_item/illegal
	name = "broken unknown object"
	icon_state = "recover_illegal"

/obj/item/xenoarch/broken_item/alien
	name = "broken unknown object"
	icon_state = "recover_illegal"

/obj/item/xenoarch/broken_item/plant
	name = "withered plant"
	desc = "Uma planta que já passou do seu auge. É possível recuperá-lo."
	icon_state = "recover_plant"

/obj/item/xenoarch/broken_item/animal
	name = "preserved animal carcass"
	desc = "Um animal que já passou do seu auge. É possível recuperá-lo. Pode ser coletado para recuperar o DNA do animal original."
	icon_state = "recover_animal"

/obj/item/xenoarch/broken_item/animal/Initialize(mapload)
	. = ..()
	var/pick_celltype = pick(CELL_LINE_TABLE_BEAR,
							CELL_LINE_TABLE_BLOBBERNAUT,
							CELL_LINE_TABLE_BLOBSPORE,
							CELL_LINE_TABLE_CARP,
							CELL_LINE_TABLE_CAT,
							CELL_LINE_TABLE_CHICKEN,
							CELL_LINE_TABLE_COCKROACH,
							CELL_LINE_TABLE_CORGI,
							CELL_LINE_TABLE_COW,
							CELL_LINE_TABLE_MOONICORN,
							CELL_LINE_TABLE_GELATINOUS,
							CELL_LINE_TABLE_GRAPE,
							CELL_LINE_TABLE_MEGACARP,
							CELL_LINE_TABLE_MOUSE,
							CELL_LINE_TABLE_PINE,
							CELL_LINE_TABLE_PUG,
							CELL_LINE_TABLE_SLIME,
							CELL_LINE_TABLE_SNAKE,
							CELL_LINE_TABLE_VATBEAST,
							CELL_LINE_TABLE_NETHER,
							CELL_LINE_TABLE_GLUTTON,
							CELL_LINE_TABLE_FROG,
							CELL_LINE_TABLE_WALKING_MUSHROOM,
							CELL_LINE_TABLE_QUEEN_BEE,
							CELL_LINE_TABLE_MEGA_ARACHNID)
	AddElement(/datum/element/swabable, pick_celltype, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)

/obj/item/xenoarch/broken_item/clothing
	name = "petrified clothing"
	desc = "Uma peça de roupa que perdeu sua beleza."
	icon_state = "recover_clothing"


//circuit boards
/obj/item/circuitboard/machine/xenoarch_machine
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	req_components = list(
		/datum/stock_part/micro_laser = 1,
		/datum/stock_part/matter_bin = 1,
		/obj/item/stack/cable_coil = 2,
		/obj/item/stack/sheet/glass = 2,
	)
	needs_anchored = TRUE

/obj/item/circuitboard/machine/xenoarch_machine/xenoarch_researcher
	name = "Xenoarch Researcher (Machine Board)"
	build_path = /obj/machinery/xenoarch/researcher

/obj/item/circuitboard/machine/xenoarch_machine/xenoarch_scanner
	name = "Xenoarch Scanner (Machine Board)"
	build_path = /obj/machinery/xenoarch/scanner

/obj/item/circuitboard/machine/xenoarch_machine/xenoarch_recoverer
	name = "Xenoarch Recoverer (Machine Board)"
	build_path = /obj/machinery/xenoarch/recoverer

/obj/item/circuitboard/machine/xenoarch_machine/xenoarch_digger
	name = "Xenoarch Digger (Machine Board)"
	build_path = /obj/machinery/xenoarch/digger

/obj/item/paper/fluff/xenoarch_guide
	name = "xenoarchaeology guide - MUST READ"
	default_raw_text = {"<b><center>Guia de Xenoarqueologia</center></b><br> \
Vamos começar do início: o que é Xenoarqueologia?<br> \
Ótima pergunta! Xenoarqueologia é o estudo de antigos corpos estranhos que estão presos dentro de rochas estranhas.<br> \
Seu objetivo como xenoarqueologista é encontrar essas rochas estranhas e descobrir os segredos que estão dentro.<br> \
Descobrirá que essas rochas são abundantes em todos os corpos astronômicos que normalmente orbitamos.<br> \
			<br> \
			<b>Ferramentas do Comércio</b><br> \
			<br> \
Há muitas ferramentas que são necessárias (e algumas apenas para a qualidade de vida para o xenoarqueologista).<br> \
Há os martelos, as escovas, a fita, o cinto, o saco, as máquinas de mão, e as máquinas.<br> \
Nesta linha de trabalho, as escovas e martelos serão o pão e a manteiga.<br> \
Eles permitirão que você desenterre os corpos estranhos mantidos dentro das rochas estranhas.<br> \
Os martelos (com diferentes profundidades) permitem alcançar as profundezas de uma maneira mais rápida do que as escovas.<br> \
As escovas permitem que você descubra os itens dentro das profundidades apropriadas sem danificá-lo.<br> \
A fita permitirá que você marque a estranha rocha com a profundidade atual. Continue examinando a rocha para atualizações.<br> \
O cinto permitirá que você guarde suas ferramentas móveis para fácil acesso.<br> \
A bolsa permitirá que você armazene e recolha automaticamente pedras e relíquias estranhas que encontra deitadas no chão.<br> \
As máquinas de mão permitem que você não tenha que ficar preso nas máquinas. Só há scanners portáteis e recuperadores.<br> \
O Scanner é uma máquina que permite marcar a estranha rocha com sua profundidade máxima e segura.<br> \
O Pesquisador é uma máquina que permite compilar/condenar relíquias e itens em artefatos estranhos maiores.<br> \
O Recuperador é uma máquina que permite recuperar objetos perdidos de itens quebrados.<br> \
			<br> \
			<b>O Processo</b><br> \
			<br> \
Encontre uma rocha estranha no deserto.<br> \
Volte para o laboratório de xenoarqueologia.<br> \
3) Processe a rocha no scanner (ou use o scanner portátil).<br> \
4) Use a fita métrica na rocha.<br> \
5) Subtrair a profundidade segura (SD) da profundidade máxima (MD).<br> \
5a) PERGUNTA:<i>para</i>Quando o médico tem 50 e o SD 16?<br> \
Resposta: 34. Apenas certifique-se de não cavar 34 como haverá profundidade anterior envolvido.<br> \
6) Subtrair a profundidade atual (CD) da resposta para o passo 5.<br> \
7) Use os martelos para cavar a resposta para o passo 6.<br> \
8) Assim que chegar à resposta ao passo 5, use o pincel até revelar o item.<br> \
Aproveite o uso de seu segredo descoberto!<br> \
9a) Se for uma relíquia inútil, venda-a ou use-a no Pesquisador para uma surpresa.<br> \
9b) Se é um item quebrado, vendê-lo ou usá-lo no Recuperador para uma surpresa.<br> \
			<br> \
Espero que isso tenha sido útil e desejo-lhe grande sucesso!<br> \
			<br> \
			<i>- KB</i><br> \
Diretor de Estudos Xenoarqueológicos"}
