/obj/item/firing_pin
	name = "electronic firing pin"
	desc = "Um pequeno dispositivo de autenticação, para ser inserido em um receptor de armas para permitir a operação. NT regulamentos de segurança exigem todos os novos projetos para incorporar um."
	icon = 'icons/obj/devices/gunmod.dmi'
	icon_state = "firing_pin"
	inhand_icon_state = "pen"
	worn_icon_state = "pen"
	obj_flags = CONDUCTS_ELECTRICITY
	w_class = WEIGHT_CLASS_TINY
	attack_verb_continuous = list("pokes")
	attack_verb_simple = list("poke")
	var/fail_message = "invalid user!"
	/// Explode when user check is failed.
	var/selfdestruct = FALSE
	/// Can forcefully replace other pins.
	var/force_replace = FALSE
	/// Can be replaced by any pin.
	var/pin_hot_swappable = FALSE
	///Can be removed from the gun using tools or replaced by a pin with force_replace
	var/pin_removable = TRUE
	var/obj/item/gun/gun
	var/default_pin_auth = TRUE

/obj/item/firing_pin/Destroy()
	if(gun)
		gun_remove()
	return ..()

/obj/item/firing_pin/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isgun(interacting_with))
		return NONE

	var/obj/item/gun/targeted_gun = interacting_with
	var/obj/item/firing_pin/old_pin = targeted_gun.pin
	if(old_pin?.pin_removable && (force_replace || old_pin.pin_hot_swappable))
		if(Adjacent(user))
			user.put_in_hands(old_pin)
		else
			old_pin.forceMove(targeted_gun.drop_location())
		old_pin.gun_remove(user)

	if(!targeted_gun.pin)
		if(!user.temporarilyRemoveItemFromInventory(src))
			return .
		if(gun_insert(user, targeted_gun))
			if(old_pin)
				balloon_alert(user, "Trocou o pino de disparo.")
			else
				balloon_alert(user, "Pino de disparo inserido")
	else
		to_chat(user, span_notice("Esta arma já tem um pino de fogo instalado."))

	return ITEM_INTERACT_SUCCESS

/obj/item/firing_pin/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE
	obj_flags |= EMAGGED
	balloon_alert(user, "Verificações de autenticação anuladas")
	return TRUE

/obj/item/firing_pin/proc/gun_insert(mob/living/user, obj/item/gun/new_gun, starting = FALSE)
	gun = new_gun
	forceMove(gun)
	gun.pin = src
	SEND_SIGNAL(gun, COMSIG_GUN_PIN_INSERTED, src, user, starting)
	return TRUE

/obj/item/firing_pin/proc/gun_remove(mob/living/user)
	gun.pin = null
	SEND_SIGNAL(gun, COMSIG_GUN_PIN_REMOVED, src, user)
	gun = null
	return

/obj/item/firing_pin/proc/pin_auth(mob/living/user)
	var/result = SEND_SIGNAL(user, COMSIG_LIVING_FIRING_PIN_CHECK, src)
	if(result & ALLOW_FIRE)
		return TRUE
	if(result & BLOCK_FIRE)
		return FALSE
	return default_pin_auth

/obj/item/firing_pin/proc/auth_fail(mob/living/user)
	if(user)
		balloon_alert(user, fail_message)
	if(selfdestruct)
		if(user)
			user.show_message("[span_danger("SELF-DESTRUCTING...")]<br>", MSG_VISUAL)
			to_chat(user, span_userdanger("[gun] Explode!"))
		explosion(src, devastation_range = -1, light_impact_range = 2, flash_range = 3)
		if(gun)
			qdel(gun)


/obj/item/firing_pin/magic
	name = "magic crystal shard"
	desc = "Um pequeno caco encantado que permite armas mágicas disparar."


// Test pin, works only near firing range.
/obj/item/firing_pin/test_range
	name = "test-range firing pin"
	desc = "Este alfinete de segurança permite que as armas sejam disparadas perto de um campo de tiro."
	fail_message = "O teste falhou!"
	pin_hot_swappable = TRUE

/obj/item/firing_pin/test_range/pin_auth(mob/living/user)
	if(!istype(user))
		return FALSE
	if (istype(get_area(user), /area/station/security/range))
		return TRUE
	return FALSE


// Implant pin, checks for implant
/obj/item/firing_pin/implant
	name = "implant-keyed firing pin"
	desc = "Este é um alfinete de segurança que só autoriza usuários que são implantados com um determinado dispositivo."
	fail_message = "A verificação do implante falhou!"
	var/obj/item/implant/req_implant = null

/obj/item/firing_pin/implant/pin_auth(mob/living/user)
	if(user)
		for(var/obj/item/implant/I in user.implants)
			if(req_implant && I.type == req_implant)
				return TRUE
	return FALSE

/obj/item/firing_pin/implant/mindshield
	name = "mindshield firing pin"
	desc = "Este alfinete de segurança autoriza a arma para apenas usuários implantados em escudos mentais."
	icon_state = "firing_pin_loyalty"
	req_implant = /obj/item/implant/mindshield

/obj/item/firing_pin/implant/pindicate
	name = "syndicate firing pin"
	icon_state = "firing_pin_pindi"
	req_implant = /obj/item/implant/weapons_auth



// Honk pin, clown's joke item.
// Can replace other pins. Replace a pin in cap's laser for extra fun!
/obj/item/firing_pin/clown
	name = "hilarious firing pin"
	desc = "Palhaço avançado que pode converter qualquer arma em um objeto muito mais útil."
	color = COLOR_YELLOW
	fail_message = "Buzine!"
	force_replace = TRUE

/obj/item/firing_pin/clown/pin_auth(mob/living/user)
	playsound(src, 'sound/items/bikehorn.ogg', 50, TRUE)
	return FALSE

// Ultra-honk pin, clown's deadly joke item.
// A gun with ultra-honk pin is useful for clown and useless for everyone else.
/obj/item/firing_pin/clown/ultra
	name = "ultra hilarious firing pin"

/obj/item/firing_pin/clown/ultra/pin_auth(mob/living/user)
	playsound(src.loc, 'sound/items/bikehorn.ogg', 50, TRUE)
	if(QDELETED(user))  //how the hell...?
		stack_trace("/obj/item/firing_pin/clown/ultra/pin_auth called with a [isnull(user) ? "null" : "invalid"] user.")
		return TRUE
	if(HAS_TRAIT(user, TRAIT_CLUMSY)) //clumsy
		return TRUE
	if(user.mind)
		if(is_clown_job(user.mind.assigned_role)) //traitor clowns can use this, even though they're technically not clumsy
			return TRUE
		if(user.mind.has_antag_datum(/datum/antagonist/nukeop/clownop)) //clown ops aren't clumsy by default and technically don't have an assigned role of "Clown", but come on, they're basically clowns
			return TRUE
		if(user.mind.has_antag_datum(/datum/antagonist/nukeop/leader/clownop)) //Wanna hear a funny joke?
			return TRUE //The clown op leader antag datum isn't a subtype of the normal clown op antag datum.
	return FALSE

/obj/item/firing_pin/clown/ultra/gun_insert(mob/living/user, obj/item/gun/new_gun, starting = FALSE)
	..()
	new_gun.clumsy_check = FALSE

/obj/item/firing_pin/clown/ultra/gun_remove(mob/living/user)
	gun.clumsy_check = initial(gun.clumsy_check)
	..()

// Now two times deadlier!
/obj/item/firing_pin/clown/ultra/selfdestruct
	name = "super ultra hilarious firing pin"
	desc = "Palhaço avançado que pode converter qualquer arma em um objeto muito mais útil. Tem uma pequena carga de nitrobananium."
	selfdestruct = TRUE


// DNA-keyed pin.
// When you want to keep your toys for yourself.
/obj/item/firing_pin/dna
	name = "DNA-keyed firing pin"
	desc = "Este é um pino de disparo bloqueado pelo DNA que só autoriza um usuário. Tentativa de atirar uma vez para DNA-link."
	icon_state = "firing_pin_dna"
	fail_message = "O teste de DNA falhou!"
	var/unique_enzymes = null

/obj/item/firing_pin/dna/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(iscarbon(interacting_with))
		var/mob/living/carbon/M = interacting_with
		if(M.dna && M.dna.unique_enzymes)
			unique_enzymes = M.dna.unique_enzymes
			balloon_alert(user, "Bloqueio de DNA definido")
			return ITEM_INTERACT_SUCCESS
		return ITEM_INTERACT_BLOCKING
	return ..()

/obj/item/firing_pin/dna/pin_auth(mob/living/carbon/user)
	if(user && user.dna && user.dna.unique_enzymes)
		if(user.dna.unique_enzymes == unique_enzymes)
			return TRUE
	return FALSE

/obj/item/firing_pin/dna/auth_fail(mob/living/carbon/user)
	if(!unique_enzymes)
		if(user && user.dna && user.dna.unique_enzymes)
			unique_enzymes = user.dna.unique_enzymes
			balloon_alert(user, "Bloqueio de DNA definido")
	else
		..()

/obj/item/firing_pin/dna/dredd
	desc = "Este é um pino de disparo bloqueado pelo DNA que só autoriza um usuário. Tentativa de atirar uma vez para DNA-link. Tem uma pequena carga explosiva."
	selfdestruct = TRUE

// Paywall pin, brought to you by ARMA 3 DLC.
// Checks if the user has a valid bank account on an ID and if so attempts to extract a one-time payment to authorize use of the gun. Otherwise fails to shoot.
/obj/item/firing_pin/paywall
	name = "paywall firing pin"
	desc = "Um alfinete com um paywall configurável embutido."
	color = COLOR_GOLD
	fail_message = ""
	/// List of account IDs which have accepted the license prompt. If this is the multi-payment pin, then this means they accepted the waiver that each shot will cost them money
	var/list/gun_owners = list()
	/// How much gets paid out to license yourself to the gun
	var/payment_amount
	/// Owner of the gun
	var/datum/bank_account/pin_owner
	/// If true, user has to pay everytime they fire the gun
	var/multi_payment = FALSE
	/// Purchase prompt to prevent spamming it, set to the user who opens to prompt to prevent locking the gun up for other users.
	var/active_prompt_user

/obj/item/firing_pin/paywall/attack_self(mob/user)
	multi_payment = !multi_payment
	to_chat(user, span_notice("Você colocou o pino para[multi_payment ? "process payment for every shot" : "one-time license payment"]."))

/obj/item/firing_pin/paywall/examine(mob/user)
	. = ..()
	if(pin_owner)
		. += span_notice("Este pino de disparo está atualmente autorizado a pagar a conta de [pin_owner.account_holder].")

/obj/item/firing_pin/paywall/gun_insert(mob/living/user, obj/item/gun/new_gun, starting = FALSE)
	if(pin_owner || starting)
		. = ..()
		gun.desc += span_notice("Isto.[gun.name] tem um[multi_payment ? "per-shot" : "license permit"]custo de [payment_amount] [MONEY_NAME_AUTOPURAL(payment_amount)].")
		return

	if(isnull(user))
		forceMove(new_gun.drop_location())
	else
		to_chat(user, span_warning("Por favor, passe o cartão de identificação válido antes de instalar o pino de disparo!"))
		user.put_in_hands(src)
	return FALSE

/obj/item/firing_pin/paywall/gun_remove(mob/living/user)
	gun.desc = gun::desc
	. = ..()

/obj/item/firing_pin/paywall/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!isidcard(tool))
		return NONE
	var/obj/item/card/id/id = tool
	if(!id.registered_account)
		to_chat(user, span_warning("Cartão de identificação não tem conta bancária registrada!"))
		return ITEM_INTERACT_BLOCKING
	if(pin_owner && id.registered_account != pin_owner)
		to_chat(user, span_warning("ERRO: Este alfinete já foi autorizado!"))
		return ITEM_INTERACT_BLOCKING
	if(id.registered_account == pin_owner)
		to_chat(user, span_notice("Você desvincular o cartão do pino de disparo."))
		gun_owners -= user.get_bank_account()
		pin_owner = null
		return ITEM_INTERACT_SUCCESS
	var/transaction_amount = tgui_input_number(user, "Insert valid deposit amount for gun purchase", "Money Deposit")
	if(!transaction_amount || QDELETED(user) || QDELETED(src) || !user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return ITEM_INTERACT_BLOCKING
	pin_owner = id.registered_account
	payment_amount = transaction_amount
	gun_owners += user.get_bank_account()
	to_chat(user, span_notice("Você liga o cartão ao alfinete de disparo."))
	return ITEM_INTERACT_SUCCESS

/obj/item/firing_pin/paywall/pin_auth(mob/living/user)
	if(!istype(user))//nice try commie
		return FALSE
	var/datum/bank_account/credit_card_details = user.get_bank_account()
	if(credit_card_details in gun_owners)
		if(multi_payment && credit_card_details)
			if(!gun.can_shoot())
				return TRUE //So you don't get charged for attempting to fire an empty gun.
			if(credit_card_details.adjust_money(-payment_amount, "Firing Pin: Gun Rent"))
				if(pin_owner)
					pin_owner.adjust_money(payment_amount, "Firing Pin: Payout For Gun Rent")
				return TRUE
			to_chat(user, span_warning("ERRO: o equilíbrio do usuário é insuficente para transações bem sucedidas!"))
			return FALSE
		return TRUE
	if(!credit_card_details)
		to_chat(user, span_warning("Usuário não tem conta bancária válida para subtrair fundos necessários!"))
		return FALSE
	if(active_prompt_user == user)
		return FALSE
	active_prompt_user = user
	var/license_request = tgui_alert(user, "Do you wish to pay [payment_amount] [MONEY_NAME_AUTOPURAL(payment_amount)] for [( multi_payment ) ? "each shot of [gun.name]" : "usage license of [gun.name]"]?", "Weapon Purchase", list("Yes", "No"), 15 SECONDS)
	if(!user.can_perform_action(src))
		active_prompt_user = null
		return FALSE
	switch(license_request)
		if("Yes")
			if(multi_payment)
				gun_owners += credit_card_details
				to_chat(user, span_notice("Contratos de aluguel de armas concordaram, tenha um dia seguro!"))

			else if(credit_card_details.adjust_money(-payment_amount, "Firing Pin: Gun License"))
				if(pin_owner)
					pin_owner.adjust_money(payment_amount, "Firing Pin: Gun License Bought")
				gun_owners += credit_card_details
				to_chat(user, span_notice("Licença comprada, tenha um dia seguro!"))
			else
				to_chat(user, span_warning("ERRO: o equilíbrio do usuário é insuficente para transações bem sucedidas!"))

		if("No", null)
			to_chat(user, span_warning("Usuário recusou-se a comprar licença de arma!"))

	active_prompt_user = null
	return FALSE //we return false here so you don't click initially to fire, get the prompt, accept the prompt, and THEN the gun

// Explorer Firing Pin- Prevents use on station Z-Level, so it's justifiable to give Explorers guns that don't suck.
/obj/item/firing_pin/explorer
	name = "outback firing pin"
	desc = "Um alfinete de disparo usado pela força de defesa australiana, retrofit para evitar disparo de armas na estação."
	icon_state = "firing_pin_explorer"
	fail_message = "Não pode disparar na estação, companheiro!"

// This checks that the user isn't on the station Z-level.
/obj/item/firing_pin/explorer/pin_auth(mob/living/user)
	var/turf/station_check = get_turf(user)
	if(!station_check || is_station_level(station_check.z))
		return FALSE
	return TRUE

// Laser tag pins
/obj/item/firing_pin/tag
	name = "laser tag firing pin"
	desc = "Um alfinete de disparo recreativo, usado em unidades de laser para garantir que os usuários tenham seus coletes."
	fail_message = "A verificação do terno falhou!"
	default_pin_auth = FALSE
	var/tagcolor = LASERTAG_TEAM_NEUTRAL

/obj/item/firing_pin/tag/auth_fail(mob/living/user)
	. = ..()
	to_chat(user, span_warning("Você precisa estar usando [tagcolor] Armadura laser tag!"))

/obj/item/firing_pin/tag/red
	name = "red laser tag firing pin"
	icon_state = "firing_pin_red"
	tagcolor = LASERTAG_TEAM_RED

/obj/item/firing_pin/tag/blue
	name = "blue laser tag firing pin"
	icon_state = "firing_pin_blue"
	tagcolor = LASERTAG_TEAM_BLUE

/obj/item/firing_pin/monkey
	name = "monkeylock firing pin"
	desc = "Este alfinete impede os não-macacos de disparar uma arma."
	fail_message = "Não é um macaco!"

/obj/item/firing_pin/monkey/pin_auth(mob/living/user)
	if(!is_simian(user))
		playsound(src, SFX_SCREECH, 75, TRUE)
		return FALSE
	return TRUE
