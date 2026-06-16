/// Docks the target's pay
/datum/smite/dock_pay
	name = "Dock Pay"

/datum/smite/dock_pay/effect(client/user, mob/living/target)
	. = ..()
	if (!iscarbon(target))
		to_chat(user, span_warning("Isso deve ser usado em uma multidão de carbono."), confidential = TRUE)
		return
	var/mob/living/carbon/dude = target
	var/obj/item/card/id/card = dude.get_idcard(TRUE)
	if (!card)
		to_chat(user, span_warning("[dude] Não tem um cartão de identificação!"), confidential = TRUE)
		return
	if (!card.registered_account)
		to_chat(user, span_warning("[dude] Não tem um cartão de identidade com uma conta!"), confidential = TRUE)
		return
	if (card.registered_account.account_balance == 0)
		to_chat(user,  span_warning("Cartão de identificação não tem fundos. Sem pagamento para atracar."))
		return
	var/new_cost = input("Quanto estamos atracando? Negativo = dando dinheiro. Balanço atual:[card.registered_account.account_balance] [MONEY_NAME].", "CORTOS ORÇAMENTAIS") as num|null
	if (!new_cost)
		return
	if(new_cost < 0)
		card.registered_account.adjust_money(new_cost, "Central Command: Pay Bonus")
		card.registered_account.bank_card_talk("[new_cost] [MONEY_NAME] added to your account based on performance review by Central Command.", force = TRUE)
	else
		SSeconomy.add_audit_entry(card.registered_account, new_cost, "Central Command")
		card.registered_account.adjust_money(-new_cost, "Central Command: Pay Cut")
		card.registered_account.bank_card_talk("[new_cost] [MONEY_NAME] deducted from your account based on performance review by Central Command.", force = TRUE)
	SEND_SOUND(target, 'sound/machines/buzz/buzz-sigh.ogg')
