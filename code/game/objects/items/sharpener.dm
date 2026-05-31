/**
* # Whetstone
*
* Items used for sharpening stuff
*
* Whetstones can be used to increase an item's force, throw_force and wound_bonus and it changes its sharpness to SHARP_EDGED. Whetstones do not work with energy weapons. Two-handed weapons will only get the throw_force bonus. A whetstone can only be used once.
*
*/
/obj/item/sharpener
	name = "whetstone"
	icon = 'icons/obj/service/kitchen.dmi'
	icon_state = "sharpener"
	desc = "Um bloco que deixa as coisas afiadas."
	force = 5
	///Amount of uses the whetstone has. Set to -1 for functionally infinite uses.
	var/uses = 1
	///How much force the whetstone can add to an item.
	var/increment = 4
	///Maximum force sharpening items with the whetstone can result in
	var/max = 30
	///The prefix a whetstone applies when an item is sharpened with it
	var/prefix = "sharpened"
	///If TRUE, the whetstone will only sharpen already sharp items
	var/requires_sharpness = TRUE

/obj/item/sharpener/attackby(obj/item/I, mob/user, list/modifiers, list/attack_modifiers)
	if(uses == 0)
		to_chat(user, span_warning("O bloco de afiação está muito usado para usar novamente!"))
		return
	if(I.force >= max || I.throwforce >= max) //So the whetstone never reduces force or throw_force
		to_chat(user, span_warning("[I]é muito poderoso para afiar mais!"))
		return
	if(requires_sharpness && !I.get_sharpness())
		to_chat(user, span_warning("Você só pode afiar itens que já estão afiados, como facas!"))
		return
	if(is_type_in_list(I, list(/obj/item/melee/energy, /obj/item/dualsaber))) //You can't sharpen the photons in energy meelee weapons
		to_chat(user, span_warning("Você não acha\the [I]Será a coisa que será modificada se você usá-lo em\the [src]!"))
		return

	//This block is used to check more things if the item has a relevant component.
	var/signal_out = SEND_SIGNAL(I, COMSIG_ITEM_SHARPEN_ACT, increment, max) //Stores the bitflags returned by SEND_SIGNAL
	if(signal_out & COMPONENT_BLOCK_SHARPEN_MAXED) //If the item's components enforce more limits on maximum power from sharpening,  we fail
		to_chat(user, span_warning("[I]é muito poderoso para afiar mais!"))
		return
	if(signal_out & COMPONENT_BLOCK_SHARPEN_BLOCKED)
		to_chat(user, span_warning("[I]Não pode ser aguçado agora!"))
		return
	if((signal_out & COMPONENT_BLOCK_SHARPEN_ALREADY) || (I.force > initial(I.force) && !signal_out)) //No sharpening stuff twice
		to_chat(user, span_warning("[I]Já foi refinado antes. Não pode ser aguçado mais!"))
		return
	if(!(signal_out & COMPONENT_BLOCK_SHARPEN_APPLIED)) //If the item has a relevant component and COMPONENT_BLOCK_SHARPEN_APPLIED is returned, the item only gets the throw force increase
		I.force = clamp(I.force + increment, 0, max)
		I.wound_bonus = I.wound_bonus + increment //wound_bonus has no cap
	user.visible_message(span_notice("[user]Aguçados[I]Com[src]!"), span_notice("Você afiou.[I]Muito mais mortal do que antes."))
	playsound(src, 'sound/items/unsheath.ogg', 25, TRUE)
	I.sharpness = SHARP_EDGED //When you whetstone something, it becomes an edged weapon, even if it was previously dull or pointy
	I.throwforce = clamp(I.throwforce + increment, 0, max)
	I.name = "[prefix] [I.name]" //This adds a prefix and a space to the item's name regardless of what the prefix is
	desc = "[desc]Pelo menos, estomava."
	uses-- //this doesn't cause issues because we check if uses == 0 earlier in this proc
	if(uses == 0)
		name = "worn out [name]" //whetstone becomes used whetstone
	update_appearance()

/obj/item/sharpener/update_name()
	name = "[!uses ? "worn out " : null][initial(name)]"
	return ..()

/**
* # Super whetstone
*
* Extremely powerful admin-only whetstone
*
* Whetstone that adds 200 damage to an item, with the maximum force and throw_force reachable with it being 200. As with normal whetstones, energy weapons cannot be sharpened with it and two-handed weapons will only get the throw_force bonus.
*
*/
/obj/item/sharpener/super
	name = "super whetstone"
	desc = "Um bloco que tornará sua arma mais afiada que Einstein em Adderall."
	increment = 200
	max = 200
	prefix = "super-sharpened"
	requires_sharpness = FALSE //Super whetstones can sharpen even tooboxes
