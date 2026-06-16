///datum used by the Coupon Master PDA app to generate coupon items redeemed by a bank account.
/datum/coupon_code
	///The pack that'll receive the discount
	var/datum/supply_pack/discounted_pack
	///The discount of the pack, on a 0 to 1 range.
	var/discount
	/**
	 * If set, copies of the coupon code will delete itself after a while if not printed.
	 * The ones SSmodular_computer.discount_coupons stay intact.
	 */
	var/expires_in
	///Has the coupon been printed. Dictates in which section it's shown, and that it cannot be printed again.
	var/printed = FALSE
	///The timerid for deletion if expires_in is set.
	var/timerid
	///Reference to the associated bank account, since we need to clear refs on deletion.
	var/datum/bank_account/associated_account

/datum/coupon_code/New(discount, discounted_pack, expires_in)
	..()
	src.discounted_pack = discounted_pack
	src.discount = discount
	if(expires_in)
		src.expires_in = world.time + expires_in

/datum/coupon_code/Destroy()
	if(associated_account)
		associated_account.redeemed_coupons -= src
		associated_account = null
	return ..()

/datum/coupon_code/proc/copy(datum/bank_account/account)
	var/datum/coupon_code/copy = new(discount, discounted_pack, expires_in)
	copy.associated_account = account
	if(account)
		LAZYADD(account.redeemed_coupons, src)
	if(expires_in)
		copy.timerid = QDEL_IN_STOPPABLE(copy, expires_in - world.time)

/datum/coupon_code/proc/generate()
	var/obj/item/coupon/coupon = new()
	coupon.generate(discount, discounted_pack)
	printed = TRUE
	deltimer(timerid)
	timerid = null
	return coupon

/obj/item/coupon
	name = "coupon"
	desc = "Não importa se você não queria antes, o que importa agora é que você tem um cupom para isso!"
	icon_state = "data_1"
	icon = 'icons/obj/card.dmi'
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_TINY
	var/datum/supply_pack/discounted_pack
	var/discount_pct_off = 0.05
	var/obj/machinery/computer/cargo/inserted_console

/obj/item/coupon/Initialize(mapload)
	. = ..()

	if(discounted_pack)
		update_name()

/// Choose what our prize is :D
/obj/item/coupon/proc/generate(discount, datum/supply_pack/discounted_pack, mob/user)
	src.discounted_pack = discounted_pack || pick(GLOB.discountable_packs[pick_weight(GLOB.pack_discount_odds)])
	var/static/list/chances = list("0.10" = 4, "0.15" = 8, "0.20" = 10, "0.25" = 8, "0.50" = 4, COUPON_OMEN = 1)
	discount_pct_off = discount || pick_weight(chances)

	if(discount_pct_off != COUPON_OMEN)
		if(!discount) // the discount arg should be a number already, while the keys in the chances list cannot be numbers
			discount_pct_off = text2num(discount_pct_off)
			update_name()
		return

	name = "coupon - fuck you"
	desc = "O pequeno texto diz: 'Você será massacrado'... Isso não parece certo, não é?"

	var/mob/cursed = user || loc
	if(!ismob(cursed))
		return FALSE

	to_chat(cursed, span_warning("O cupom lê.<b>Foda-se.</b>Em texto grande e ousado... é um prêmio, ou?"))

	if(!cursed.GetComponent(/datum/component/omen))
		cursed.AddComponent(/datum/component/omen, src, 1)
		return TRUE
	if(HAS_TRAIT(cursed, TRAIT_CURSED))
		to_chat(cursed, span_warning("Que noite horrível... Ter uma maldição!"))
	addtimer(CALLBACK(src, PROC_REF(curse_heart), cursed), 5 SECONDS, TIMER_UNIQUE | TIMER_STOPPABLE)

/obj/item/coupon/update_name()
	name = "coupon - [round(discount_pct_off * 100)]% off [initial(discounted_pack.name)]"
	return ..()

/// Play stupid games, win stupid prizes
/obj/item/coupon/proc/curse_heart(mob/living/cursed)
	if(!iscarbon(cursed))
		cursed.gib(DROP_ALL_REMAINS)
		burn_evilly()
		return TRUE

	var/mob/living/carbon/player = cursed
	INVOKE_ASYNC(player, TYPE_PROC_REF(/mob, emote), "scream")
	to_chat(player, span_mind_control("O que esse copo pode significar?"))
	to_chat(player, span_userdanger("O suspense está te matando!"))
	player.set_heartattack(status = TRUE)
	burn_evilly()

/obj/item/coupon/proc/burn_evilly()
	visible_message(span_warning("[src] Queima em um sinistro flash, tomando uma energia maligna com ele..."))
	burn()

/obj/item/coupon/attack_atom(obj/attacked_obj, mob/living/user, list/modifiers, list/attack_modifiers)
	if(!istype(attacked_obj, /obj/machinery/computer/cargo))
		return ..()
	if(discount_pct_off == COUPON_OMEN)
		to_chat(user, span_warning("\The [attacked_obj] valida o cupom como autêntico, mas se recusa a aceitá-lo..."))
		attacked_obj.say("Coupon fulfillment already in progress...")
		return

	inserted_console = attacked_obj
	LAZYADD(inserted_console.loaded_coupons, src)
	inserted_console.say("Coupon for [initial(discounted_pack.name)] applied!")
	forceMove(inserted_console)

/obj/item/coupon/Destroy()
	if(inserted_console)
		LAZYREMOVE(inserted_console.loaded_coupons, src)
		inserted_console = null
	return ..()
