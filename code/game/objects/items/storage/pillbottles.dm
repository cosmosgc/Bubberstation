
/*
 * Pill Bottles
 */
/obj/item/storage/pill_bottle
	name = "pill bottle"
	desc = "É um recipiente hermético para armazenar medicamentos."
	icon_state = "pill_canister"
	icon = 'icons/obj/medical/chemical.dmi'
	inhand_icon_state = "contsolid"
	worn_icon_state = "nothing"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	pickup_sound = 'sound/items/handling/pill_bottle_pickup.ogg'
	drop_sound = 'sound/items/handling/pill_bottle_place.ogg'
	storage_type = /datum/storage/pillbottle

	///Number of pills to spawn
	VAR_PROTECTED/spawn_count
	///Pill type to spawn
	VAR_PROTECTED/obj/item/reagent_containers/applicator/pill/spawn_type

/obj/item/storage/pill_bottle/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] is trying to get the cap off [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	return TOXLOSS

/obj/item/storage/pill_bottle/PopulateContents()
	SHOULD_NOT_OVERRIDE(TRUE)

	if(!spawn_count)
		return

	for(var/i in 1 to spawn_count)
		new spawn_type(src)

/obj/item/storage/pill_bottle/multiver
	name = "bottle of multiver pills"
	desc = "Contém pílulas usadas para combater toxinas."
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/multiver

/obj/item/storage/pill_bottle/multiver/less
	spawn_count = 3

/obj/item/storage/pill_bottle/epinephrine
	name = "bottle of epinephrine pills"
	desc = "Contém pílulas usadas para estabilizar pacientes."
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/epinephrine

/obj/item/storage/pill_bottle/mutadone
	name = "bottle of mutadone pills"
	desc = "Contém pílulas usadas para tratar anomalias genéticas."
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/mutadone

/obj/item/storage/pill_bottle/potassiodide
	name = "bottle of potassium iodide pills"
	desc = "Contém pílulas usadas para reduzir danos à radiação."
	spawn_count = 3
	spawn_type = /obj/item/reagent_containers/applicator/pill/potassiodide

/obj/item/storage/pill_bottle/probital
	name = "bottle of probital pills"
	desc = "Contém pílulas usadas para tratar danos brutos. A etiqueta na garrafa diz \"Comer antes de ingerir, pode causar fadiga\"."
	spawn_count = 4
	spawn_type = /obj/item/reagent_containers/applicator/pill/probital

/obj/item/storage/pill_bottle/iron
	name = "bottle of iron pills"
	desc = "Contém pílulas usadas para reduzir a perda de sangue lentamente. A etiqueta na garrafa diz: \"Só pegue um a cada cinco minutos\"."
	spawn_count = 4
	spawn_type = /obj/item/reagent_containers/applicator/pill/iron

/obj/item/storage/pill_bottle/mannitol
	name = "bottle of mannitol pills"
	desc = "Contém pílulas usadas para tratar danos cerebrais."
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/mannitol

//Contains 4 pills instead of 7, and 5u pills instead of 50u (50u pills heal 250 brain damage, 5u pills heal 25)
/obj/item/storage/pill_bottle/mannitol/braintumor
	desc = "Contém pílulas diluídas usadas para tratar sintomas de tumor cerebral. Tome um quando estiver tonto."
	spawn_count = 4
	spawn_type = /obj/item/reagent_containers/applicator/pill/mannitol/braintumor

/obj/item/storage/pill_bottle/stimulant
	name = "bottle of stimulant pills"
	desc = "Garantido para lhe dar aquela explosão extra de energia durante um longo turno!"
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/stimulant

/obj/item/storage/pill_bottle/sansufentanyl
	name = "bottle of experimental medication"
	desc = "Um frasco de pílulas desenvolvido pela Interdyne Pharmaceuticals. Eles são usados para tratar a doença do Manifold Hereditário."
	spawn_count = 6
	spawn_type = /obj/item/reagent_containers/applicator/pill/sansufentanyl

/obj/item/storage/pill_bottle/mining
	name = "bottle of patches"
	desc = "Contém patches usados para tratar danos brutos e queimados."
	spawn_count = 3
	spawn_type = /obj/item/reagent_containers/applicator/patch/libital

/obj/item/storage/pill_bottle/zoom
	name = "suspicious pill bottle"
	desc = "O rótulo é muito velho e quase ilegível, você reconhece alguns compostos químicos."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/zoom

/obj/item/storage/pill_bottle/happy
	name = "suspicious pill bottle"
	desc = "Tem um sorriso no topo."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/happy

/obj/item/storage/pill_bottle/lsd
	name = "suspicious pill bottle"
	desc = "Há um desenho bruto que pode ser um cogumelo, ou uma lua deformada."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/lsd

/obj/item/storage/pill_bottle/aranesp
	name = "suspicious pill bottle"
	desc = "O rótulo tem 'deficientes de merda' rapidamente rabiscaram em marcador preto."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/aranesp

/obj/item/storage/pill_bottle/psicodine
	name = "bottle of psicodine pills"
	desc = "Contém pílulas usadas para tratar sofrimento mental e traumas."
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/psicodine

/obj/item/storage/pill_bottle/penacid
	name = "bottle of pentetic acid pills"
	desc = "Contém pílulas para eliminar radiação e toxinas."
	spawn_count = 3
	spawn_type = /obj/item/reagent_containers/applicator/pill/penacid

/obj/item/storage/pill_bottle/neurine
	name = "bottle of neurine pills"
	desc = "Contém pílulas para tratar traumas mentais não graves."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/neurine

/obj/item/storage/pill_bottle/maintenance_pill
	name = "bottle of maintenance pills"
	desc = "Um velho frasco de pílulas. Cheira a mofo."
	spawn_type = /obj/item/reagent_containers/applicator/pill/maintenance

/obj/item/storage/pill_bottle/maintenance_pill/Initialize(mapload)
	if(!spawn_count)
		spawn_count = rand(1,7)
	. = ..()
	var/obj/item/reagent_containers/applicator/pill/P = locate() in src
	name = "bottle of [P.name]s"

/obj/item/storage/pill_bottle/maintenance_pill/full
	spawn_count = 7

///////////////////////////////////////// Psychologist inventory pillbottles
/obj/item/storage/pill_bottle/happinesspsych
	name = "happiness pills"
	desc = "Contém pílulas usadas como último recurso para estabilizar temporariamente a depressão e ansiedade. ATENÇÃO: efeitos colaterais podem incluir fala suja, baba e dependência grave."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/happinesspsych

/obj/item/storage/pill_bottle/lsdpsych
	name = "mindbreaker toxin pills"
	desc = "Só para uso terapêutico! Contém pílulas usadas para aliviar os sintomas da Síndrome de Dissociação Real."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/lsdpsych

/obj/item/storage/pill_bottle/paxpsych
	name = "pax pills"
	desc = "Contém pílulas usadas para pacificar temporariamente pacientes que são considerados um dano para si mesmos ou para os outros."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/paxpsych

/obj/item/storage/pill_bottle/naturalbait
	name = "freshness jar"
	desc = "Cheio de isca de peixe natural."
	spawn_count = 7
	spawn_type = /obj/item/food/bait/natural

/obj/item/storage/pill_bottle/ondansetron
	name = "ondansetron patches"
	desc = "Uma garrafa contendo manchas de ondansetron, uma droga usada para tratar náuseas e vômitos. Pode causar sonolência."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/patch/ondansetron

/obj/item/storage/pill_bottle/immunodeficiency
	name = "bottle of immune boosters"
	desc = "Contém reforço do sistema imunológico, usado para controlar imunodeficiência crônica."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/spaceacillin

/obj/item/storage/pill_bottle/prescription_stimulant
	name = "bottle of prescribed stimulant pills"
	desc = "Uma garrafa de estimulantes suaves e medicamente aprovados para evitar sonolência.\n\
A lista de substâncias diz: contém 3u modafinil, 5u sinaptizina e 5u glicose.\n\
Um rótulo de aviso diz:<b>Tome com moderação.</b>."
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/prescription_stimulant
