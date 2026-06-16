
///////////////////////////////////////////////Condiments
//Notes by Darem: The condiments food-subtype is for stuff you don't actually eat but you use to modify existing food. They all
// leave empty containers when used up and can be filled/re-filled with other items. Formatting for first section is identical
// to mixed-drinks code. If you want an object that starts pre-loaded, you need to make it in addition to the other code.

//Food items that aren't eaten normally and leave an empty container behind.
/obj/item/reagent_containers/condiment
	name = "condiment bottle"
	desc = "Só uma garrafa de condimento normal."
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "bottle"
	inhand_icon_state = "beer" //Generic held-item sprite until unique ones are made.
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	initial_reagent_flags = OPENCONTAINER
	obj_flags = UNIQUE_RENAME
	possible_transfer_amounts = list(1, 5, 10, 15, 20, 25, 30, 50)
	volume = 50
	fill_icon_thresholds = list(0, 10, 25, 50, 75, 100)
	/// Icon (icon_state) to be used when container becomes empty (no change if falsy)
	var/icon_empty
	/// Holder for original icon_state value if it was overwritten by icon_emty to change back to
	var/icon_preempty

/obj/item/reagent_containers/condiment/update_icon_state()
	. = ..()
	if(length(reagents.reagent_list)) // BUBBER EDIT CHANGE - FIXES A RUNTIME I LITERALLY CANNOT FIGURE OUT IM SORRY - ORIGINAL: reagents.reagent_list.len
		if(icon_preempty)
			icon_state = icon_preempty
			icon_preempty = null
		return ..()

	if(icon_empty && !icon_preempty)
		icon_preempty = icon_state
		icon_state = icon_empty
	return ..()

/obj/item/reagent_containers/condiment/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user] está tentando comer todo o [src] Parece que...[user.p_they()] Esqueci como a comida funcional!"))
	return OXYLOSS

/obj/item/reagent_containers/condiment/proc/try_eat(atom/target, mob/living/user)
	if(!canconsume(target, user))
		return ITEM_INTERACT_BLOCKING

	user.changeNext_move(CLICK_CD_MELEE)
	if(target == user)
		user.visible_message(
			span_notice("[user] engole um pouco do conteúdo de\the [src]."),
			span_notice("Você engoliu um pouco do conteúdo de\the [src]."),
		)
	else
		target.visible_message(
			span_warning("[user] Tentativas de se alimentar [target] De [src]."),
			span_warning("[user] Tentamos alimentá-lo.[src]."),
		)
		if(!do_after(user, 3 SECONDS, target))
			return ITEM_INTERACT_BLOCKING
		if(!reagents || !reagents.total_volume)
			return ITEM_INTERACT_BLOCKING // The condiment might be empty after the delay.
		target.visible_message(
			span_warning("[user] Alimentado.[target] De [src]."),
			span_warning("[user] Alimentá-lo de [src]."),
		)
		log_combat(user, target, "fed", reagents.get_reagent_log_string())

	SEND_SIGNAL(target, COMSIG_GLASS_DRANK, src, user) // SKYRAT EDIT ADDITION - Hemophages can't casually drink what's not going to regenerate their blood
	reagents.trans_to(target, 10, transferred_by = user, methods = INGEST)
	playsound(target, 'sound/items/drink.ogg', rand(10, 50), TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/item/reagent_containers/condiment/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	if(!is_open_container())
		return NONE

	//Something like a glass or a food item. Player probably wants to transfer TO it.
	if(target.is_refillable() || IS_EDIBLE(target))
		return try_refill(target, user)
	//A dispenser. Transfer FROM it TO us.
	if(target.is_drainable())
		return try_drain(target, user)
	//Eating directly from the ketchup packet
	if(isliving(target))
		return try_eat(target, user)

	return NONE


/obj/item/reagent_containers/condiment/interact_with_atom_secondary(atom/target, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(!is_open_container())
		return NONE
	//A dispenser. Transfer FROM it TO us.
	if(target.is_drainable())
		return try_drain(target, user)

	return NONE

/obj/item/reagent_containers/condiment/enzyme
	name = "universal enzyme"
	desc = "Usado em cozinhar vários pratos."
	icon_state = "enzyme"
	list_reagents = list(/datum/reagent/consumable/enzyme = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/enzyme/examine(mob/user)
	. = ..()
	var/datum/chemical_reaction/recipe = GLOB.chemical_reactions_list[/datum/chemical_reaction/food/cheesewheel]
	var/milk_required = recipe.required_reagents[/datum/reagent/consumable/milk]
	var/enzyme_required = recipe.required_catalysts[/datum/reagent/consumable/enzyme]
	. += span_notice("[milk_required] Leite,[enzyme_required] Enzima e queijo.")
	. += span_warning("Lembre-se, a enzima não está gasta, então devolva para a garrafa, Dingus!")

/obj/item/reagent_containers/condiment/sugar
	name = "sugar sack"
	desc = "Doce Saboroso!"
	icon_state = "sugar"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/sugar = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/sugar/examine(mob/user)
	. = ..()
	var/datum/chemical_reaction/standard_recipe = GLOB.chemical_reactions_list[/datum/chemical_reaction/food/cakebatter]
	var/datum/chemical_reaction/alt_recipe = GLOB.chemical_reactions_list[/datum/chemical_reaction/food/cakebatter/vegan]
	var/flour_required = standard_recipe.required_reagents[/datum/reagent/consumable/flour]
	var/eggyolk_required = standard_recipe.required_reagents[/datum/reagent/consumable/eggyolk]
	var/eggwhite_required = standard_recipe.required_reagents[/datum/reagent/consumable/eggwhite]
	var/sugar_required = standard_recipe.required_reagents[/datum/reagent/consumable/sugar]
	var/soymilk_required = alt_recipe.required_reagents[/datum/reagent/consumable/soymilk]
	. += span_notice("[flour_required] Farinha,[sugar_required] açúcar, e qualquer um [eggyolk_required] Gema de ovo [eggwhite_required] Clara de ovo ou [soymilk_required] Leite de soja produz uma massa de bolo. Você pode fazer massa de torta com isso.")

/obj/item/reagent_containers/condiment/saltshaker //Separate from above since it's a small shaker rather then
	name = "salt shaker" // a large one.
	desc = "Sal. Dos oceanos espaciais, presumível."
	icon_state = "saltshakersmall"
	icon_empty = "emptyshaker"
	inhand_icon_state = ""
	possible_transfer_amounts = list(1,20) //for clown turning the lid off
	amount_per_transfer_from_this = 1
	volume = 20
	list_reagents = list(/datum/reagent/consumable/salt = 20)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/saltshaker/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] Começa a trocar formulários com o saleiro! Parece que...[user.p_theyre()] Tentando cometer suicídio!"))
	var/newname = "[name]"
	name = "[user.name]"
	user.name = newname
	user.real_name = newname
	desc = "Sal. Da tripulação morta, presumivelmente."
	return TOXLOSS

/obj/item/reagent_containers/condiment/saltshaker/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(isturf(target))
		if(!reagents.has_reagent(/datum/reagent/consumable/salt, 2))
			to_chat(user, span_warning("Você não tem sal suficiente para fazer uma pilha!"))
			return
		user.visible_message(span_notice("[user] Agita um pouco de sal.[target]."), span_notice("Você agita um pouco de sal [target]."))
		reagents.remove_reagent(/datum/reagent/consumable/salt, 2)
		new/obj/effect/decal/cleanable/food/salt(target)
		return ITEM_INTERACT_SUCCESS
	return .

/obj/item/reagent_containers/condiment/peppermill
	name = "pepper mill"
	desc = "Frequentemente usado para sabotar comida ou faz as pessoas espirrarem."
	icon_state = "peppermillsmall"
	icon_empty = "emptyshaker"
	inhand_icon_state = ""
	possible_transfer_amounts = list(1,20) //for clown turning the lid off
	amount_per_transfer_from_this = 1
	volume = 20
	list_reagents = list(/datum/reagent/consumable/blackpepper = 20)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/milk
	name = "space milk"
	desc = "É leite. Bondade branca e nutritiva!"
	icon_state = "milk"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/milk = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/milk/examine(mob/user)
	. = ..()
	var/datum/chemical_reaction/recipe = GLOB.chemical_reactions_list[/datum/chemical_reaction/food/cheesewheel]
	var/milk_required = recipe.required_reagents[/datum/reagent/consumable/milk]
	var/enzyme_required = recipe.required_catalysts[/datum/reagent/consumable/enzyme]
	. += span_notice("[milk_required] Leite,[enzyme_required] Enzima e queijo.")
	. += span_warning("Lembre-se, a enzima não está gasta, então devolva para a garrafa, Dingus!")

/obj/item/reagent_containers/condiment/flour
	name = "flour sack"
	desc = "Um grande saco de farinha. Bom para cozinhar!"
	icon_state = "flour"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/flour = 30)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/flour/examine(mob/user)
	. = ..()
	var/datum/chemical_reaction/recipe_dough = GLOB.chemical_reactions_list[/datum/chemical_reaction/food/dough]
	var/datum/chemical_reaction/recipe_cakebatter = GLOB.chemical_reactions_list[/datum/chemical_reaction/food/cakebatter]
	var/dough_flour_required = recipe_dough.required_reagents[/datum/reagent/consumable/flour]
	var/dough_water_required = recipe_dough.required_reagents[/datum/reagent/water]
	var/cakebatter_flour_required = recipe_cakebatter.required_reagents[/datum/reagent/consumable/flour]
	var/cakebatter_eggyolk_required = recipe_cakebatter.required_reagents[/datum/reagent/consumable/eggyolk]
	var/cakebatter_sugar_required = recipe_cakebatter.required_reagents[/datum/reagent/consumable/sugar]
	. += "<b><i>You retreat inward and recall the teachings of... Making Dough...</i></b>"
	. += span_notice("[dough_flour_required] Farinha,[dough_water_required] A água faz massa normal. Você pode ganhar dinheiro com isso.")
	. += span_notice("[cakebatter_flour_required] Farinha,[cakebatter_eggyolk_required] Gema de ovo (ou leite de soja),[cakebatter_sugar_required] O açúcar faz massa de bolo. Você pode fazer massa de torta com isso.")

/obj/item/reagent_containers/condiment/soymilk
	name = "soy milk"
	desc = "É leite de soja. Bondade branca e nutritiva!"
	icon_state = "soymilk"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/soymilk = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/rice
	name = "rice sack"
	desc = "Um grande saco de arroz. Bom para cozinhar!"
	icon_state = "rice"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/rice = 30)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/cornmeal
	name = "cornmeal box"
	desc = "Uma grande caixa de farinha de milho. Ótimo para cozinhar estilo sulista."
	icon_state = "cornmeal"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/cornmeal = 30)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/bbqsauce
	name = "bbq sauce"
	desc = "Toalhitas não incluídas."
	icon_state = "bbqsauce"
	list_reagents = list(/datum/reagent/consumable/bbqsauce = 50)

/obj/item/reagent_containers/condiment/soysauce
	name = "soy sauce"
	desc = "Um sabor de soja salgada."
	icon_state = "soysauce"
	list_reagents = list(/datum/reagent/consumable/soysauce = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/mayonnaise
	name = "mayonnaise"
	desc = "Um crédito oleoso feito de gemas de ovo."
	icon_state = "mayonnaise"
	list_reagents = list(/datum/reagent/consumable/mayonnaise = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/vinegar
	name = "vinegar"
	desc = "Perfeito para batatas fritas, se está se sentindo britânico."
	icon_state = "vinegar"
	list_reagents = list(/datum/reagent/consumable/vinegar = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/vegetable_oil
	name = "cooking oil"
	desc = "Por todas as suas necessidades."
	icon_state = "cooking_oil"
	list_reagents = list(/datum/reagent/consumable/nutriment/fat/oil = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/olive_oil
	name = "quality oil"
	desc = "Para o chef chique dentro de todos."
	icon_state = "oliveoil"
	list_reagents = list(/datum/reagent/consumable/nutriment/fat/oil/olive = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/yoghurt
	name = "yoghurt carton"
	desc = "Creme e suave."
	icon_state = "yoghurt"
	list_reagents = list(/datum/reagent/consumable/yoghurt = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/peanut_butter
	name = "peanut butter"
	desc = "Saboroso, engordando alterações processadas em um frasco."
	icon_state = "peanutbutter"
	list_reagents = list(/datum/reagent/consumable/peanut_butter = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/cherryjelly
	name = "cherry jelly"
	desc = "Um pote de geléia de cereja super doce."
	icon_state = "cherryjelly"
	list_reagents = list(/datum/reagent/consumable/cherryjelly = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/honey
	name = "honey"
	desc = "Um pote de mel doce e visível."
	icon_state = "honey"
	list_reagents = list(/datum/reagent/consumable/honey = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/ketchup
	name = "ketchup"
	// At time of writing, "ketchup" mechanically, is just ground tomatoes,
	// rather than // tomatoes plus vinegar plus sugar.
	desc = "Uma pasta de tomate em uma garrafa de plástico alta. De alguma forma, ainda vagamente americano."
	icon_state = "ketchup"
	list_reagents = list(/datum/reagent/consumable/ketchup = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/mustard
	name = "mustard"
	desc = "Um molho picante e picante feito de mostarda. Ótimo em cachorro-quente!"
	icon_state = "mustard"
	list_reagents = list(/datum/reagent/consumable/mustard = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/worcestershire
	name = "worcestershire sauce"
	desc = "Um molho fermentado dapresta da velha Inglaterra. Torna quase tudo melhor."
	icon_state = "worcestershire"
	list_reagents = list(/datum/reagent/consumable/worcestershire = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/red_bay
	name = "\improper Red Bay seasoning"
	desc = "O temperamento favorito de Marte."
	icon_state = "red_bay"
	list_reagents = list(/datum/reagent/consumable/red_bay = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/curry_powder
	name = "curry powder"
	desc = "É essa magia amarela que faz curry ter gosto de curry."
	icon_state = "curry_powder"
	list_reagents = list(/datum/reagent/consumable/curry_powder = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/dashi_concentrate
	name = "dashi concentrate"
	desc = "Uma garrafa de concentrado da marca Amagi. Cozinhe com água em uma proporção de 1:8 para um caldo perfeito."
	icon_state = "dashi_concentrate"
	list_reagents = list(/datum/reagent/consumable/dashi_concentrate = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/coconut_milk
	name = "coconut milk"
	desc = "É leite de coco. Toasty!"
	icon_state = "coconut_milk"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/coconut_milk = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/grounding_solution
	name = "grounding solution"
	desc = "Uma solução iônica segura para neutralizar o enigmático\"eletricidade líquida\"Isso é comum à comida de Sprout, formando sal inofensivo em contato."
	icon_state = "grounding_solution"
	list_reagents = list(/datum/reagent/consumable/grounding_solution = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/protein
	name = "protein powder"
	desc = "Combustível para seu Hulk interior - porque você não pode soletrar 'swole' sem 'whey'!"
	icon_state = "protein"
	list_reagents = list(/datum/reagent/consumable/nutriment/protein = 40)
	fill_icon_thresholds = null

//technically condiment packs but they are non transparent

/obj/item/reagent_containers/condiment/creamer
	name = "coffee creamer pack"
	desc = "Melhor não pensar no que estão fazendo."
	icon_state = "condi_creamer"
	volume = 5
	list_reagents = list(/datum/reagent/consumable/creamer = 5)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/chocolate
	name = "chocolate sprinkle pack"
	desc= "A quantidade de açúcar que já não era suficiente para você?"
	icon_state = "condi_chocolate"
	list_reagents = list(/datum/reagent/consumable/choccyshake = 10)


/obj/item/reagent_containers/condiment/hotsauce
	name = "hotsauce bottle"
	desc= "Você pode quase provar as úlceras estomacais!"
	icon_state = "hotsauce"
	list_reagents = list(/datum/reagent/consumable/capsaicin = 50)

/obj/item/reagent_containers/condiment/coldsauce
	name = "coldsauce bottle"
	desc= "Deixa a língua dormente de sua passagem."
	icon_state = "coldsauce"
	list_reagents = list(/datum/reagent/consumable/frostoil = 50)

//Food packs. To easily apply deadly toxi... delicious sauces to your food!

/obj/item/reagent_containers/condiment/pack
	name = "condiment pack"
	desc = "Um pequeno pacote de plástico com condimentos para colocar em sua comida."
	icon_state = "condi_empty"
	initial_reagent_flags = parent_type::initial_reagent_flags | NO_SPLASH
	volume = 10
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(10)
	/**
	  * List of possible styles (list(<icon_state>, <name>, <desc>)) for condiment packs.
	  * Since all of them differs only in color should probably be replaced with usual reagentfillings instead
	  */
	var/list/possible_states = list(
		/datum/reagent/consumable/ketchup = list("condi_ketchup", "Ketchup", "You feel more American already."),
		/datum/reagent/consumable/capsaicin = list("condi_hotsauce", "Hotsauce", "You can almost TASTE the stomach ulcers now!"),
		/datum/reagent/consumable/soysauce = list("condi_soysauce", "Soy Sauce", "A salty soy-based flavoring"),
		/datum/reagent/consumable/frostoil = list("condi_frostoil", "Coldsauce", "Leaves the tongue numb in its passage"),
		/datum/reagent/consumable/salt = list("condi_salt", "Salt Shaker", "Salt. From space oceans, presumably"),
		/datum/reagent/consumable/blackpepper = list("condi_pepper", "Pepper Mill", "Often used to flavor food or make people sneeze"),
		/datum/reagent/consumable/nutriment/fat/oil = list("condi_cornoil", "Vegetable Oil", "A delicious oil used in cooking."),
		/datum/reagent/consumable/sugar = list("condi_sugar", "Sugar", "Tasty spacey sugar!"),
		/datum/reagent/consumable/astrotame = list("condi_astrotame", "Astrotame", "The sweetness of a thousand sugars but none of the calories."),
		/datum/reagent/consumable/bbqsauce = list("condi_bbq", "BBQ sauce", "Hand wipes not included."),
		/datum/reagent/consumable/peanut_butter = list("condi_peanutbutter", "Peanut Butter", "A creamy paste made from ground peanuts."),
		/datum/reagent/consumable/cherryjelly = list("condi_cherryjelly", "Cherry Jelly", "A jar of super-sweet cherry jelly."),
		/datum/reagent/consumable/mayonnaise = list("condi_mayo", "Mayonnaise", "Not an instrument."),
	)
	/// Can't use initial(name) for this. This stores the name set by condimasters.
	var/originalname = "condiment"

/obj/item/reagent_containers/condiment/pack/create_reagents(max_vol, flags)
	. = ..()
	RegisterSignal(reagents, COMSIG_REAGENTS_HOLDER_UPDATED, PROC_REF(on_reagent_update), TRUE)

/obj/item/reagent_containers/condiment/pack/update_icon()
	SHOULD_CALL_PARENT(FALSE)
	return

/obj/item/reagent_containers/condiment/pack/try_eat(atom/target, mob/living/user)
	return NONE

/obj/item/reagent_containers/condiment/pack/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	//You can tear the bag open above food to put the condiments on it, obviously.
	if(IS_EDIBLE(target))
		if(!reagents.total_volume)
			to_chat(user, span_warning("Você se abre [src], mas não há nada nele."))
			qdel(src)
			return ITEM_INTERACT_BLOCKING
		if(target.reagents.total_volume >= target.reagents.maximum_volume)
			to_chat(user, span_warning("Você se abre [src], mas [target] é empilhado tão alto que apenas pinga!") )
			qdel(src)
			return ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("Você se abre [src] Acima.[target] e os condimentos escorrem nela."))
		reagents.trans_to(target, amount_per_transfer_from_this, transferred_by = user)
		qdel(src)
		return ITEM_INTERACT_SUCCESS
	return ..()

/// Handles reagents getting added to the condiment pack.
/obj/item/reagent_containers/condiment/pack/proc/on_reagent_update(datum/reagents/reagents)
	SIGNAL_HANDLER

	if(!reagents.total_volume)
		icon_state = "condi_empty"
		desc = "Um pequeno pacote de condimentos. Está vazio."
		return
	var/datum/reagent/main_reagent = reagents.get_master_reagent()

	var/list/temp_list = possible_states[main_reagent.type]
	if(length(temp_list))
		icon_state = temp_list[1]
		desc = temp_list[3]
	else
		icon_state = "condi_mixed"
		desc = "Um pequeno pacote de condimentos. O rótulo diz que contém [originalname]"

//Ketchup
/obj/item/reagent_containers/condiment/pack/ketchup
	name = "ketchup pack"
	originalname = "ketchup"
	list_reagents = list(/datum/reagent/consumable/ketchup = 10)

//Hot sauce
/obj/item/reagent_containers/condiment/pack/hotsauce
	name = "hotsauce pack"
	originalname = "hotsauce"
	list_reagents = list(/datum/reagent/consumable/capsaicin = 10)

/obj/item/reagent_containers/condiment/pack/astrotame
	name = "astrotame pack"
	originalname = "astrotame"
	volume = 5
	list_reagents = list(/datum/reagent/consumable/astrotame = 5)

/obj/item/reagent_containers/condiment/pack/bbqsauce
	name = "bbq sauce pack"
	originalname = "bbq sauce"
	list_reagents = list(/datum/reagent/consumable/bbqsauce = 10)

/obj/item/reagent_containers/condiment/pack/creamer
	name = "creamer pack"
	originalname = "creamer"
	volume = 5
	list_reagents = list(/datum/reagent/consumable/cream = 5)

/obj/item/reagent_containers/condiment/pack/sugar
	name = "sugar pack"
	originalname = "sugar"
	volume = 5
	list_reagents = list(/datum/reagent/consumable/sugar = 5)

/obj/item/reagent_containers/condiment/pack/soysauce
	name = "soy sauce pack"
	originalname = "soy sauce"
	volume = 5
	list_reagents = list(/datum/reagent/consumable/soysauce = 5)

/obj/item/reagent_containers/condiment/pack/mayonnaise
	name = "mayonnaise pack"
	originalname = "mayonnaise"
	volume = 5
	list_reagents = list(/datum/reagent/consumable/mayonnaise = 5)
