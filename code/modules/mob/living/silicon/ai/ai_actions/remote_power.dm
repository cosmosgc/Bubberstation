/datum/ai_module/power_apc
	name = "Remote Power"
	description = "remotamente alimenta um APC à distância"
	one_purchase = TRUE
	power_type = /datum/action/innate/ai/ranged/power_apc
	unlock_text = span_notice("Sistemas de energia remotos APC online.")

/datum/action/innate/ai/ranged/power_apc
	name = "remotely power APC"
	desc = "Use para ligar remotamente um APC."
	button_icon = 'icons/obj/machines/wallmounts.dmi'
	button_icon_state = "apc0"
	ranged_mousepointer = 'icons/effects/mouse_pointers/supplypod_target.dmi'
	enable_text = span_notice("Prepare-se para alimentar qualquer APC que veja.")
	disable_text = span_notice("Pare de se concentrar em ligar APCs.")

/datum/action/innate/ai/ranged/power_apc/do_ability(mob/living/clicker, atom/clicked_on)

	if (!isAI(clicker))
		return FALSE
	var/mob/living/silicon/ai/ai_clicker = clicker

	if(clicker.incapacitated)
		unset_ranged_ability(clicker)
		return FALSE

	if(!isapc(clicked_on))
		clicked_on.balloon_alert(ai_clicker, "Não um APC!")
		return FALSE

	if(ai_clicker.battery - 50 <= 0)
		to_chat(ai_clicker, span_warning("Você não tem bateria para carregar um APC!"))
		return FALSE

	var/obj/machinery/power/apc/apc = clicked_on
	var/obj/item/stock_parts/power_store/cell = apc.get_cell()
	cell.give(STANDARD_BATTERY_CHARGE)
	ai_clicker.battery -= 50



