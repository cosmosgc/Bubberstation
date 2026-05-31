//Not to be confused with /obj/item/reagent_containers/cup/glass/bottle

/obj/item/reagent_containers/cup/bottle
	name = "bottle"
	desc = "Uma garrafa pequena."
	icon_state = "bottle"
	fill_icon_state = "bottle"
	inhand_icon_state = "atoxinbottle"
	worn_icon_state = "bottle"
	obj_flags = UNIQUE_RENAME | RENAME_NO_DESC
	possible_transfer_amounts = list(5, 10, 15, 25, 50)
	volume = 50
	fill_icon_thresholds = list(0, 1, 20, 40, 60, 80, 100)
	can_lid = TRUE
	assembly_pixel_y = 4

/obj/item/reagent_containers/cup/bottle/Initialize(mapload)
	. = ..()
	if(!icon_state)
		icon_state = "bottle"
	update_appearance()

/obj/item/reagent_containers/cup/bottle/epinephrine
	name = "epinephrine bottle"
	desc = "Uma garrafa pequena. Contém epinefrina usada para estabilizar os pacientes."
	list_reagents = list(/datum/reagent/medicine/epinephrine = 30)

/obj/item/reagent_containers/cup/bottle/toxin
	name = "toxin bottle"
	desc = "Uma pequena garrafa de toxinas. Não beba, é venenoso."
	list_reagents = list(/datum/reagent/toxin = 30)

/obj/item/reagent_containers/cup/bottle/cyanide
	name = "cyanide bottle"
	desc = "Uma pequena garrafa de cianeto. Amêndoas amargas?"
	list_reagents = list(/datum/reagent/toxin/cyanide = 30)

/obj/item/reagent_containers/cup/bottle/anacea
	name = "anacea bottle"
	desc = "Uma pequena garrafa de Anacea."
	list_reagents = list(/datum/reagent/toxin/anacea = 30)

/obj/item/reagent_containers/cup/bottle/spewium
	name = "spewium bottle"
	desc = "Uma pequena garrafa de spewium."
	list_reagents = list(/datum/reagent/toxin/spewium = 30)

/obj/item/reagent_containers/cup/bottle/syndol
	name = "syndol bottle"
	desc = "Uma pequena garrafa de sindol."
	list_reagents = list(/datum/reagent/drug/syndol = 30)

/obj/item/reagent_containers/cup/bottle/morphine
	name = "morphine bottle"
	desc = "Uma pequena garrafa de morfina."
	icon = 'icons/obj/medical/chemical.dmi'
	list_reagents = list(/datum/reagent/medicine/morphine = 30)

/obj/item/reagent_containers/cup/bottle/chloralhydrate
	name = "chloral hydrate bottle"
	desc = "Uma pequena garrafa de coral Hydrate. Mickey's Favorite!"
	icon_state = "bottle20"
	list_reagents = list(/datum/reagent/toxin/chloralhydrate = 15)

/obj/item/reagent_containers/cup/bottle/mannitol
	name = "mannitol bottle"
	desc = "Uma pequena garrafa de manitol. Útil para curar danos cerebrais."
	list_reagents = list(/datum/reagent/medicine/mannitol = 30)

/obj/item/reagent_containers/cup/bottle/multiver
	name = "multiver bottle"
	desc = "Uma pequena garrafa de multiver, que remove toxinas e outros produtos químicos da corrente sanguínea, mas causa falta de ar. Todos os efeitos escalam com a quantidade de reagentes no paciente."
	list_reagents = list(/datum/reagent/medicine/c2/multiver = 30)

/obj/item/reagent_containers/cup/bottle/calomel
	name = "calomel bottle"
	desc = "Uma pequena garrafa de calomel, uma droga tóxica que rapidamente remove substâncias químicas da corrente sanguínea. Não causa danos adicionais em pessoas gravemente feridas."
	list_reagents = list(/datum/reagent/medicine/calomel = 30)

/obj/item/reagent_containers/cup/bottle/phlogiston
	name = "Phlogiston bottle"
	desc = "Uma pequena garrafa de Phlogiston, que vai incendiá-lo se usado."
	list_reagents = list(/datum/reagent/phlogiston = 30)

/obj/item/reagent_containers/cup/bottle/ammoniated_mercury
	name = "ammoniated mercury bottle"
	desc = "Expurga rapidamente o corpo de produtos químicos tóxicos. Ferimento da toxina quando em boas condições alguém não tem nenhum dano bruto e fogo. Quando ferido com dano bruto ou fogo, pode causar uma grande quantidade de dano toxina. Quando não há toxinas presentes, começa lentamente a se purgar."
	list_reagents = list(/datum/reagent/medicine/ammoniated_mercury = 30)

/obj/item/reagent_containers/cup/bottle/syriniver
	name = "syriniver bottle"
	desc = "Uma Pequena Garrafa de Syriniver."
	list_reagents = list(/datum/reagent/medicine/c2/syriniver = 30)

/obj/item/reagent_containers/cup/bottle/mutagen
	name = "unstable mutagen bottle"
	desc = "Uma pequena garrafa de mutagênico instável. Muda aleatoriamente a estrutura de DNA de quem entra em contato."
	list_reagents = list(/datum/reagent/toxin/mutagen = 30)

/obj/item/reagent_containers/cup/bottle/plasma
	name = "liquid plasma bottle"
	desc = "Uma pequena garrafa de plasma líquido. Extremamente tóxico e reage com micro-organismos dentro do sangue."
	list_reagents = list(/datum/reagent/toxin/plasma = 30)

/obj/item/reagent_containers/cup/bottle/synaptizine
	name = "synaptizine bottle"
	desc = "Uma pequena garrafa de sinaptizina."
	list_reagents = list(/datum/reagent/medicine/synaptizine = 30)

/obj/item/reagent_containers/cup/bottle/ammonia
	name = "ammonia bottle"
	desc = "Uma pequena garrafa de amônia."
	list_reagents = list(/datum/reagent/ammonia = 30)

/obj/item/reagent_containers/cup/bottle/diethylamine
	name = "diethylamine bottle"
	desc = "Um pequeno frasco de dietilamina."
	list_reagents = list(/datum/reagent/diethylamine = 30)

/obj/item/reagent_containers/cup/bottle/facid
	name = "Fluorosulfuric Acid Bottle"
	desc = "Uma garrafa pequena. Contém uma pequena quantidade de ácido fluorossulfúrico."
	list_reagents = list(/datum/reagent/toxin/acid/fluacid = 30)

/obj/item/reagent_containers/cup/bottle/adminordrazine
	name = "Adminordrazine Bottle"
	desc = "Uma garrafa pequena. Contém a essência líquida dos deuses."
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "holyflask"
	inhand_icon_state = "holyflask"
	list_reagents = list(/datum/reagent/medicine/adminordrazine = 30)

/obj/item/reagent_containers/cup/bottle/capsaicin
	name = "Capsaicin Bottle"
	desc = "Uma garrafa pequena. Contém molho picante."
	list_reagents = list(/datum/reagent/consumable/capsaicin = 30)

/obj/item/reagent_containers/cup/bottle/frostoil
	name = "Frost Oil Bottle"
	desc = "Uma garrafa pequena. Contém molho frio."
	list_reagents = list(/datum/reagent/consumable/frostoil = 30)

/obj/item/reagent_containers/cup/bottle/strange_reagent
	name = "Strange Reagent Bottle"
	desc = "Uma garrafa pequena. Pode ser usado para reviver as pessoas."
	list_reagents = list(/datum/reagent/medicine/strange_reagent = 30)

/obj/item/reagent_containers/cup/bottle/fishy_reagent
	name = "Fishy Reagent Bottle"
	desc = "Uma garrafa pequena. Pode ser usado para reviver peixes."
	list_reagents = list(/datum/reagent/medicine/strange_reagent/fishy_reagent = 30)

/obj/item/reagent_containers/cup/bottle/traitor
	name = "syndicate bottle"
	desc = "Uma garrafa pequena. Contém um químico desagradável aleatório."
	icon = 'icons/obj/medical/chemical.dmi'
	var/extra_reagent = null

/obj/item/reagent_containers/cup/bottle/traitor/Initialize(mapload)
	. = ..()
	extra_reagent = pick(/datum/reagent/toxin/polonium, /datum/reagent/toxin/histamine, /datum/reagent/toxin/formaldehyde, /datum/reagent/toxin/venom, /datum/reagent/toxin/fentanyl, /datum/reagent/toxin/cyanide)
	reagents.add_reagent(extra_reagent, 3)

/obj/item/reagent_containers/cup/bottle/polonium
	name = "polonium bottle"
	desc = "Uma garrafa pequena. Contém Polônio."
	list_reagents = list(/datum/reagent/toxin/polonium = 30)

/obj/item/reagent_containers/cup/bottle/magillitis
	name = "magillitis bottle"
	desc = "Uma garrafa pequena. Contém um soro conhecido apenas como \"magilite\"."
	list_reagents = list(/datum/reagent/magillitis = 5)

/obj/item/reagent_containers/cup/bottle/venom
	name = "venom bottle"
	desc = "Uma garrafa pequena. Contém Venom."
	list_reagents = list(/datum/reagent/toxin/venom = 30)

/obj/item/reagent_containers/cup/bottle/fentanyl
	name = "fentanyl bottle"
	desc = "Uma garrafa pequena. Contém Fentanyl."
	list_reagents = list(/datum/reagent/toxin/fentanyl = 30)

/obj/item/reagent_containers/cup/bottle/formaldehyde
	name = "formaldehyde bottle"
	desc = "Uma garrafa pequena. Contém formaldeído, um produto químico que previne a decomposição dos órgãos."
	list_reagents = list(/datum/reagent/toxin/formaldehyde = 30)

/obj/item/reagent_containers/cup/bottle/initropidril
	name = "initropidril bottle"
	desc = "Uma garrafa pequena. Contém initropidril."
	list_reagents = list(/datum/reagent/toxin/initropidril = 30)

/obj/item/reagent_containers/cup/bottle/pancuronium
	name = "pancuronium bottle"
	desc = "Uma garrafa pequena. Contém pancurônio."
	list_reagents = list(/datum/reagent/toxin/pancuronium = 30)

/obj/item/reagent_containers/cup/bottle/sodium_thiopental
	name = "sodium thiopental bottle"
	desc = "Uma garrafa pequena. Contém tiopental sódico."
	list_reagents = list(/datum/reagent/toxin/sodium_thiopental = 30)

/obj/item/reagent_containers/cup/bottle/coniine
	name = "coniine bottle"
	desc = "Uma garrafa pequena. Contém coniine."
	list_reagents = list(/datum/reagent/toxin/coniine = 30)

/obj/item/reagent_containers/cup/bottle/curare
	name = "curare bottle"
	desc = "Uma garrafa pequena. Contém curare."
	list_reagents = list(/datum/reagent/toxin/curare = 30)

/obj/item/reagent_containers/cup/bottle/amanitin
	name = "amanitin bottle"
	desc = "Uma garrafa pequena. Contém amanitina."
	list_reagents = list(/datum/reagent/toxin/amanitin = 30)

/obj/item/reagent_containers/cup/bottle/histamine
	name = "histamine bottle"
	desc = "Uma garrafa pequena. Contém histamina."
	list_reagents = list(/datum/reagent/toxin/histamine = 30)

/obj/item/reagent_containers/cup/bottle/diphenhydramine
	name = "antihistamine bottle"
	desc = "Uma pequena garrafa de difenidramina."
	list_reagents = list(/datum/reagent/medicine/diphenhydramine = 30)

/obj/item/reagent_containers/cup/bottle/potass_iodide
	name = "anti-radiation bottle"
	desc = "Uma pequena garrafa de iodeto de potássio."
	list_reagents = list(/datum/reagent/medicine/potass_iodide = 30)

/obj/item/reagent_containers/cup/bottle/salglu_solution
	name = "saline-glucose solution bottle"
	desc = "Um pequeno frasco de solução salina."
	list_reagents = list(/datum/reagent/medicine/salglu_solution = 30)

/obj/item/reagent_containers/cup/bottle/atropine
	name = "atropine bottle"
	desc = "Uma pequena garrafa de atropina."
	list_reagents = list(/datum/reagent/medicine/atropine = 30)

/obj/item/reagent_containers/cup/bottle/random_buffer
	name = "Buffer bottle"
	desc = "Uma pequena garrafa de tampão químico."

/obj/item/reagent_containers/cup/bottle/random_buffer/Initialize(mapload)
	. = ..()
	if(prob(50))
		name = "Acidic buffer bottle"
		desc = "Uma pequena garrafa de tampão ácido."
		reagents.add_reagent(/datum/reagent/reaction_agent/acidic_buffer, 30)
	else
		name = "Basic buffer bottle"
		desc = "Uma pequena garrafa de tampão básico."
		reagents.add_reagent(/datum/reagent/reaction_agent/basic_buffer, 30)

/obj/item/reagent_containers/cup/bottle/acidic_buffer
	name = "Acidic buffer bottle"
	desc = "Uma pequena garrafa de tampão ácido."
	list_reagents = list(/datum/reagent/reaction_agent/acidic_buffer = 30)

/obj/item/reagent_containers/cup/bottle/basic_buffer
	name = "Basic buffer bottle"
	desc = "Uma pequena garrafa de tampão básico."
	list_reagents = list(/datum/reagent/reaction_agent/basic_buffer = 30)

/obj/item/reagent_containers/cup/bottle/inversing_buffer
	name = "Chiral inversing buffer bottle"
	desc = "Uma pequena garrafa de tampão de inserção quiral."
	list_reagents = list(/datum/reagent/reaction_agent/inversing_buffer = 30)

/obj/item/reagent_containers/cup/bottle/romerol
	name = "romerol bottle"
	desc = "Uma pequena garrafa de Romerol. O pó de zumbi real."
	list_reagents = list(/datum/reagent/romerol = 30)

/obj/item/reagent_containers/cup/bottle/moltobeso
	name = "Molt'Obeso bottle"
	desc = "O novo molho revolucionário dos especialistas em culinária do Syndicate, projetado para remodelar instantaneamente sua figura! A chave para a eficácia deste produto está em sua formulação única, que combina ingredientes cuidadosamente selecionados para estimular o apetite e aumentar a absorção de calorias."
	list_reagents = list(/datum/reagent/consumable/moltobeso = 50)

/obj/item/reagent_containers/cup/bottle/random_virus
	name = "Experimental disease culture bottle"
	desc = "Uma garrafa pequena. Contém uma cultura viral não testada em meio sintético."
	spawned_disease = /datum/disease/advance/random

/obj/item/reagent_containers/cup/bottle/pierrot_throat
	name = "Pierrot's Throat culture bottle"
	desc = "Uma garrafa pequena. Contém cultura de virion H0NI<42 em meio sintético."
	spawned_disease = /datum/disease/pierrot_throat

/obj/item/reagent_containers/cup/bottle/cold
	name = "Rhinovirus culture bottle"
	desc = "Uma garrafa pequena. Contém cultura XY-rhinovirus em meio sintético."
	spawned_disease = /datum/disease/advance/cold

/obj/item/reagent_containers/cup/bottle/flu_virion
	name = "Flu virion culture bottle"
	desc = "Uma garrafa pequena. Contém cultura de vírus da gripe H13N1 em meio sintético."
	spawned_disease = /datum/disease/advance/flu

/obj/item/reagent_containers/cup/bottle/retrovirus
	name = "Retrovirus culture bottle"
	desc = "Uma garrafa pequena. Contém uma cultura de retrovírus em um meio de sangue sintético."
	spawned_disease = /datum/disease/dna_retrovirus

/obj/item/reagent_containers/cup/bottle/gbs
	name = "GBS culture bottle"
	desc = "Uma garrafa pequena. Contém cultura Bipotencial Gravitocinética SADS+ em meio sintético."//Or simply - General BullShit
	amount_per_transfer_from_this = 5
	spawned_disease = /datum/disease/gbs

/obj/item/reagent_containers/cup/bottle/fake_gbs
	name = "GBS culture bottle"
	desc = "Uma garrafa pequena. Contém cultura biopotencial gravitocinética SADS em meio sanguíneo sintético."//Or simply - General BullShit
	spawned_disease = /datum/disease/fake_gbs

/obj/item/reagent_containers/cup/bottle/brainrot
	name = "Brainrot culture bottle"
	desc = "Uma garrafa pequena. Contém Cryptococcus Cosmosis em meio sintético."
	icon_state = "bottle3"
	spawned_disease = /datum/disease/brainrot

/obj/item/reagent_containers/cup/bottle/magnitis
	name = "Magnitis culture bottle"
	desc = "Uma garrafa pequena. Contém uma pequena dose de Fukkos Miracos."
	spawned_disease = /datum/disease/magnitis

/obj/item/reagent_containers/cup/bottle/wizarditis
	name = "Wizarditis culture bottle"
	desc = "Uma garrafa pequena. Contém uma amostra de Rincewindus Vulgaris."
	spawned_disease = /datum/disease/wizarditis

/obj/item/reagent_containers/cup/bottle/anxiety
	name = "Severe Anxiety culture bottle"
	desc = "Uma garrafa pequena. Contém uma amostra de Lepidoptidides."
	spawned_disease = /datum/disease/anxiety

/obj/item/reagent_containers/cup/bottle/beesease
	name = "Beesease culture bottle"
	desc = "Uma garrafa pequena. Contém uma amostra de Apidae invasivo."
	spawned_disease = /datum/disease/beesease

/obj/item/reagent_containers/cup/bottle/fluspanish
	name = "Spanish flu culture bottle"
	desc = "Uma garrafa pequena. Contém uma amostra de Inquisitius."
	spawned_disease = /datum/disease/fluspanish

/obj/item/reagent_containers/cup/bottle/tuberculosis
	name = "Fungal Tuberculosis culture bottle"
	desc = "Uma garrafa pequena. Contém uma amostra de Bacilo Tubercular Fungal."
	spawned_disease = /datum/disease/tuberculosis

/obj/item/reagent_containers/cup/bottle/tuberculosiscure
	name = "BVAK bottle"
	desc = "Uma pequena garrafa contendo Bio vírus Antidote Kit."
	list_reagents = list(/datum/reagent/vaccine/fungal_tb = 30)

//Oldstation.dmm chemical storage bottles

/obj/item/reagent_containers/cup/bottle/hydrogen
	name = "hydrogen bottle"
	list_reagents = list(/datum/reagent/hydrogen = 30)

/obj/item/reagent_containers/cup/bottle/lithium
	name = "lithium bottle"
	list_reagents = list(/datum/reagent/lithium = 30)

/obj/item/reagent_containers/cup/bottle/carbon
	name = "carbon bottle"
	list_reagents = list(/datum/reagent/carbon = 30)

/obj/item/reagent_containers/cup/bottle/nitrogen
	name = "nitrogen bottle"
	list_reagents = list(/datum/reagent/nitrogen = 30)

/obj/item/reagent_containers/cup/bottle/oxygen
	name = "oxygen bottle"
	list_reagents = list(/datum/reagent/oxygen = 30)

/obj/item/reagent_containers/cup/bottle/fluorine
	name = "fluorine bottle"
	list_reagents = list(/datum/reagent/fluorine = 30)

/obj/item/reagent_containers/cup/bottle/sodium
	name = "sodium bottle"
	list_reagents = list(/datum/reagent/sodium = 30)

/obj/item/reagent_containers/cup/bottle/aluminium
	name = "aluminium bottle"
	list_reagents = list(/datum/reagent/aluminium = 30)

/obj/item/reagent_containers/cup/bottle/silicon
	name = "silicon bottle"
	list_reagents = list(/datum/reagent/silicon = 30)

/obj/item/reagent_containers/cup/bottle/phosphorus
	name = "phosphorus bottle"
	list_reagents = list(/datum/reagent/phosphorus = 30)

/obj/item/reagent_containers/cup/bottle/sulfur
	name = "sulfur bottle"
	list_reagents = list(/datum/reagent/sulfur = 30)

/obj/item/reagent_containers/cup/bottle/chlorine
	name = "chlorine bottle"
	list_reagents = list(/datum/reagent/chlorine = 30)

/obj/item/reagent_containers/cup/bottle/potassium
	name = "potassium bottle"
	list_reagents = list(/datum/reagent/potassium = 30)

/obj/item/reagent_containers/cup/bottle/iron
	name = "iron bottle"
	list_reagents = list(/datum/reagent/iron = 30)

/obj/item/reagent_containers/cup/bottle/copper
	name = "copper bottle"
	list_reagents = list(/datum/reagent/copper = 30)

/obj/item/reagent_containers/cup/bottle/mercury
	name = "mercury bottle"
	list_reagents = list(/datum/reagent/mercury = 30)

/obj/item/reagent_containers/cup/bottle/radium
	name = "radium bottle"
	list_reagents = list(/datum/reagent/uranium/radium = 30)

/obj/item/reagent_containers/cup/bottle/water
	name = "water bottle"
	list_reagents = list(/datum/reagent/water = 30)

/obj/item/reagent_containers/cup/bottle/ethanol
	name = "ethanol bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol = 30)

/obj/item/reagent_containers/cup/bottle/sugar
	name = "sugar bottle"
	list_reagents = list(/datum/reagent/consumable/sugar = 30)

/obj/item/reagent_containers/cup/bottle/sacid
	name = "sulfuric acid bottle"
	list_reagents = list(/datum/reagent/toxin/acid = 30)

/obj/item/reagent_containers/cup/bottle/welding_fuel
	name = "welding fuel bottle"
	list_reagents = list(/datum/reagent/fuel = 30)

/obj/item/reagent_containers/cup/bottle/silver
	name = "silver bottle"
	list_reagents = list(/datum/reagent/silver = 30)

/obj/item/reagent_containers/cup/bottle/iodine
	name = "iodine bottle"
	list_reagents = list(/datum/reagent/iodine = 30)

/obj/item/reagent_containers/cup/bottle/bromine
	name = "bromine bottle"
	list_reagents = list(/datum/reagent/bromine = 30)

/obj/item/reagent_containers/cup/bottle/thermite
	name = "thermite bottle"
	list_reagents = list(/datum/reagent/thermite = 50)

// Bottles for mail goodies.

/obj/item/reagent_containers/cup/bottle/clownstears
	name = "bottle of distilled clown misery"
	desc = "Uma garrafa pequena. Contém um líquido mítico usado por bartenders sublimes, feito da infelicidade dos palhaços."
	list_reagents = list(/datum/reagent/consumable/nutriment/soup/clown_tears = 30)

/obj/item/reagent_containers/cup/bottle/saltpetre
	name = "saltpetre bottle"
	desc = "Uma garrafa pequena. Contém salitre."
	list_reagents = list(/datum/reagent/saltpetre = 30)

/obj/item/reagent_containers/cup/bottle/flash_powder
	name = "flash powder bottle"
	desc = "Uma garrafa pequena. Contém pó de flash."
	list_reagents = list(/datum/reagent/flash_powder = 30)

/obj/item/reagent_containers/cup/bottle/exotic_stabilizer
	name = "exotic stabilizer bottle"
	desc = "Uma garrafa pequena. Contém estabilizador exótico."
	list_reagents = list(/datum/reagent/exotic_stabilizer = 30)

/obj/item/reagent_containers/cup/bottle/leadacetate
	name = "lead acetate bottle"
	desc = "Uma garrafa pequena. Contém acetato de chumbo."
	list_reagents = list(/datum/reagent/toxin/leadacetate = 30)

/obj/item/reagent_containers/cup/bottle/caramel
	name = "bottle of caramel"
	desc = "Uma garrafa contendo açúcar caramelizado, também conhecido como caramelo. Não lamba."
	list_reagents = list(/datum/reagent/consumable/caramel = 30)

/*
 *	Syrup bottles, basically a unspillable cup that transfers reagents upon clicking on it with a cup
 */

/obj/item/reagent_containers/cup/bottle/syrup_bottle
	name = "syrup bottle"
	desc = "Uma garrafa com uma bomba de xarope para distribuir a deliciosa substância diretamente em sua xícara de café."
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "syrup"
	fill_icon_state = "syrup"
	fill_icon_thresholds = list(0, 20, 40, 60, 80, 100)
	possible_transfer_amounts = list(5, 10)
	amount_per_transfer_from_this = 5
	can_lid = FALSE

/obj/item/reagent_containers/cup/bottle/syrup_bottle/Initialize(mapload)
	. = ..()
	register_context()
	// this is not done via initial_reagent_flags because it represents state
	update_container_flags(SEALED_CONTAINER | TRANSPARENT)

/obj/item/reagent_containers/cup/bottle/syrup_bottle/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click para alternar a tampa da bomba.")
	. += span_notice("Use uma caneta para renomeá-la.")

/obj/item/reagent_containers/cup/bottle/syrup_bottle/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	. = ..()

	context[SCREENTIP_CONTEXT_ALT_LMB] = (is_open_container() ? "Add Pump Cap" : "Remove Pump Cap")
	if(IS_WRITING_UTENSIL(held_item))
		context[SCREENTIP_CONTEXT_LMB] = "Write Label"
	else if(is_open_container() && held_item?.is_refillable())
		context[SCREENTIP_CONTEXT_LMB] = "Use Pump"

	return CONTEXTUAL_SCREENTIP_SET

//when you attack the syrup bottle with a container it refills it
/obj/item/reagent_containers/cup/bottle/syrup_bottle/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(is_open_container() && tool.is_refillable())
		return refillable_act(user, tool)
	return ..()

/obj/item/reagent_containers/cup/bottle/syrup_bottle/nameformat(input, user)
	playsound(src, SFX_WRITING_PEN, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, SOUND_FALLOFF_EXPONENT + 3, ignore_walls = FALSE)
	return "[input? "[input] " : null]bottle"


/obj/item/reagent_containers/cup/bottle/syrup_bottle/proc/refillable_act(mob/user, obj/item/tool)
	if(!reagents.total_volume)
		balloon_alert(user, "Garrafa vazia!")
		return ITEM_INTERACT_BLOCKING
	if(tool.reagents.holder_full())
		balloon_alert(user, "Contêiner cheio!")
		return ITEM_INTERACT_BLOCKING

	var/transfer_amount = round(reagents.trans_to(tool, amount_per_transfer_from_this, transferred_by = user), CHEMICAL_VOLUME_ROUNDING)
	if(transfer_amount)
		balloon_alert(user, "Transferido.[transfer_amount]Unidade")
	flick("syrup_anim",src)
	tool.update_appearance()
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/item/reagent_containers/cup/bottle/syrup_bottle/update_icon_state()
	. = ..()
	if(is_open_container())
		icon_state = "syrup_open"
	else
		icon_state = "syrup"

/obj/item/reagent_containers/cup/bottle/syrup_bottle/click_alt(mob/user)
	if(is_open_container())
		balloon_alert(user, "Coloque tampa de bomba.")
		update_container_flags(SEALED_CONTAINER | TRANSPARENT)
	else
		balloon_alert(user, "Tampa de bomba removida")
		reset_container_flags()

	update_appearance()
	return CLICK_ACTION_SUCCESS

//types of syrups

/obj/item/reagent_containers/cup/bottle/syrup_bottle/caramel
	name = "bottle of caramel syrup"
	desc = "Uma garrafa de bomba contendo açúcar caramelizado, também conhecido como caramelo. Não lamba."
	list_reagents = list(/datum/reagent/consumable/caramel = 50)

/obj/item/reagent_containers/cup/bottle/syrup_bottle/liqueur
	name = "bottle of coffee liqueur syrup"
	desc = "Uma garrafa de bomba contendo xarope de licor sabor café mexicano. Em produção desde 1936, HONK."
	list_reagents = list(/datum/reagent/consumable/ethanol/kahlua = 50)

/obj/item/reagent_containers/cup/bottle/syrup_bottle/korta_nectar
	name = "bottle of korta syrup"
	desc = "Uma garrafa de bomba contendo xarope korta. Uma substância doce e açucarada feita de nozes de korta."
	list_reagents = list(/datum/reagent/consumable/korta_nectar = 50)

//secret syrup
/obj/item/reagent_containers/cup/bottle/syrup_bottle/laughsyrup
	name = "bottle of laugh syrup"
	desc = "Uma garrafa de bomba contendo xarope de riso. O produto de juicin' Peas. Fizzy, e parece mudar o sabor baseado no que é usado!"
	list_reagents = list(/datum/reagent/consumable/laughsyrup = 50)
