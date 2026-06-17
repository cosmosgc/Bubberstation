/**
 * A skillchip that gives the user bigger arrows when pointing at things (like some id trims do).
 * As a bonus, they can costumize the color of the arrow/pointer too.
 */
/obj/item/skillchip/big_pointer
	name = "Kommand skillchip"
	desc = "Um biochip detalhando várias técnicas empregadas por líderes históricos para apontar coisas como um verdadeiro chefe."
	skill_name = "Enhanced pointing"
	skill_description = "Aprenda a apontar as coisas de uma forma mais perceptível."
	skill_icon = FA_ICON_ARROW_DOWN
	activate_message = span_notice("De\"O Compêndio Definitivo da Linguagem Corporal para o Líder aspirante\", página 164, parágrafo 3...")
	deactivate_message = span_notice("Então, como posso apontar para as coisas de novo?")

	actions_types = list(/datum/action/change_pointer_color)

/obj/item/skillchip/big_pointer/on_activate(mob/living/carbon/user, silent=FALSE)
	. = ..()
	RegisterSignal(user, COMSIG_MOVABLE_POINTED, PROC_REF(fancier_pointer))

/obj/item/skillchip/big_pointer/on_deactivate(mob/living/carbon/user, silent=FALSE)
	UnregisterSignal(user, COMSIG_MOVABLE_POINTED)
	var/datum/action/change_pointer_color/action = locate() in actions
	action?.arrow_color = null
	action?.arrow_overlay = null
	return ..()

/obj/item/skillchip/big_pointer/proc/fancier_pointer(mob/living/user, atom/pointed, obj/effect/temp_visual/point/point)
	SIGNAL_HANDLER
	if(HAS_TRAIT(user, TRAIT_UNKNOWN_APPEARANCE))
		return
	point.cut_overlays()
	var/datum/action/change_pointer_color/action = locate() in actions
	if(!action.arrow_color)
		point.icon_state = "arrow_large"
		return
	point.icon_state = "arrow_large_white"
	point.color = action.arrow_color
	var/mutable_appearance/highlight = mutable_appearance(point.icon, "arrow_large_white_highlights", appearance_flags = RESET_COLOR)
	point.add_overlay(highlight)

/datum/action/change_pointer_color
	name = "Change Pointer Color"
	desc = "Defina sua cor de ponteiro personalizada, ou restaure-a para o padrão."
	button_icon = /obj/effect/temp_visual/point::icon
	button_icon_state = "arrow_large_still"
	check_flags = AB_CHECK_CONSCIOUS
	///the color of our arrow
	var/arrow_color
	///the arrow overlay shown on the button
	var/mutable_appearance/arrow_overlay

/datum/action/change_pointer_color/Destroy()
	. = ..()
	arrow_overlay = null

/datum/action/change_pointer_color/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	var/mob/user = owner
	if(!arrow_color)
		pick_color(user)
		return
	var/choice = tgui_alert(owner, "Reiniciar ou atualizar a cor do ponteiro?","Pointer Color", list("Reset","Update"))
	if(user != owner || !choice || !IsAvailable(feedback = TRUE))
		return
	if(choice == "Update")
		pick_color(user)
	else
		arrow_color = null
		owner.balloon_alert(owner, "Ponto reset")
		build_all_button_icons(update_flags = UPDATE_BUTTON_ICON, force = TRUE)

/datum/action/change_pointer_color/proc/pick_color(mob/user)
	var/ncolor = tgui_color_picker(owner, "Pick new color", "Pointer Color", arrow_color)
	if(user != owner || !IsAvailable(feedback = TRUE))
		return
	arrow_color = ncolor
	owner.balloon_alert(owner, "ponteiro atualizado")
	build_all_button_icons(update_flags = UPDATE_BUTTON_ICON, force = TRUE)

/datum/action/change_pointer_color/apply_button_icon(atom/movable/screen/movable/action_button/current_button, force = FALSE)
	var/initial_icon = /obj/effect/temp_visual/point::icon
	current_button.cut_overlay(arrow_overlay)
	if(!arrow_color)
		current_button.icon = initial_icon
		current_button.icon_state = /obj/effect/temp_visual/point::icon_state
		return ..()

	current_button.icon = current_button.icon_state = null
	arrow_overlay = mutable_appearance(icon = initial_icon, icon_state = "arrow_large_white_still")
	arrow_overlay.color = arrow_color
	arrow_overlay.overlays += mutable_appearance(icon = initial_icon, icon_state = "arrow_large_white_still_highlights", appearance_flags = RESET_COLOR)
	current_button.add_overlay(arrow_overlay)
