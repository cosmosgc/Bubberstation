/obj/item/reagent_containers/vapecart
	name = "vape cart"
	desc = "Um carrinho cheio de nicotina."
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "vapecart"
	fill_icon_state = "vapecart"
	volume = 50
	has_variable_transfer_amount = FALSE
	list_reagents = list(/datum/reagent/drug/nicotine = 50)
	fill_icon_thresholds = list(0, 5, 20, 40)
	custom_price = PAYCHECK_CREW

/obj/item/reagent_containers/vapecart/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/obj/item/vape/target_vape = interacting_with
	if(!istype(target_vape))
		return NONE
	if(target_vape.screw == TRUE && !target_vape.reagents.total_volume)
		src.reagents.trans_to(target_vape, src.volume, transferred_by = user)
		to_chat(user, span_notice("Você liga o[src.name]para o Vape."))
		qdel(src)
	else if(!target_vape.screw)
		to_chat(user, span_warning("Você precisa abrir o boné para fazer isso!"))
	else
		to_chat(user, span_warning("[target_vape]Já está cheio!"))
	return ITEM_INTERACT_SUCCESS

/obj/item/reagent_containers/vapecart/empty
	name = "customizable vape cart"
	desc = "Preencha com qualquer mistura perigosa de produtos químicos que desejar!"
	list_reagents = list()
	initial_reagent_flags = OPENCONTAINER
	var/labelled = FALSE

/obj/item/reagent_containers/vapecart/empty/attack_self(mob/user)
	if(reagents.total_volume > 0)
		to_chat(user, span_notice("Você está vazio.[src]de todos os reagentes."))
		reagents.clear_reagents()

/obj/item/reagent_containers/vapecart/empty/attackby(obj/item/attacked_item, mob/user, params)
	if (istype(attacked_item, /obj/item/pen) || istype(attacked_item, /obj/item/toy/crayon))
		if(!user.is_literate())
			to_chat(user, span_notice("Você rabisca ilegivelmente no rótulo do carrinho de vape!"))
			return
		var/new_title = stripped_input(user, "O que gostaria de rotular o carrinho de vape?", name, null, 53)
		if(!user.can_perform_action(src))
			return
		if(user.get_active_held_item() != attacked_item)
			return
		if(new_title)
			labelled = TRUE
			name = "[new_title]"
		else
			labelled = FALSE
			update_name()
	else
		return ..()

/obj/item/reagent_containers/vapecart/empty/update_name(updates)
	. = ..()
	if(labelled)
		return
	name = "customizable vape cart"

//thc carts
/obj/item/reagent_containers/vapecart/bluekush
	name = "Dr. Breen's Blue Kush Reserve cart"
	desc = "Não fume os carrinhos... Eles colocaram algo nele... para fazer você esquecer! Nem lembro como cheguei aqui..."
	list_reagents = list(/datum/reagent/drug/thc = 20, /datum/reagent/consumable/berryjuice = 10)
	custom_price = PAYCHECK_LOWER

/obj/item/reagent_containers/vapecart/reddiesel
	name = "Resistance Red Diesel cart"
	desc = "Parece ser endossado por um verdadeiro cientista!"
	list_reagents = list(/datum/reagent/drug/thc = 20, /datum/reagent/consumable/dr_gibb = 10)
	custom_price = PAYCHECK_LOWER

/obj/item/reagent_containers/vapecart/pwrgame
	name = "Pwr Haze cart"
	desc = "Quando Pwr Game entrou no negócio de carrinhos?"
	list_reagents = list(/datum/reagent/drug/thc = 20, /datum/reagent/consumable/pwr_game = 10)
	custom_price = PAYCHECK_LOWER

/obj/item/reagent_containers/vapecart/cheese
	name = "Cheesie Honker OG Kush cart"
	desc = "Não contém queijo de verdade."
	list_reagents = list(/datum/reagent/drug/thc = 20, /datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 3)
	custom_price = PAYCHECK_LOWER

/obj/item/reagent_containers/vapecart/syndicate
	name = "Syndikush Green Crack cart"
	desc = "O crack verde é uma cepa de sativa, não de crack real."
	list_reagents = list(/datum/reagent/drug/thc = 20, /datum/reagent/medicine/stimulants = 10)
	custom_price = PAYCHECK_LOWER
