/datum/antagonist/heartbreaker
	name = "\improper Heartbreaker"
	roundend_category = "valentines"
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = TRUE
	suicide_cry = "FOR LONELINESS!!"

/datum/antagonist/heartbreaker/forge_objectives()
	var/datum/objective/martyr/normiesgetout = new
	normiesgetout.owner = owner
	objectives += normiesgetout

/datum/antagonist/heartbreaker/on_gain()
	forge_objectives()
	. = ..()

/datum/antagonist/heartbreaker/greet()
	. = ..()
	to_chat(owner, span_boldwarning("Você não conseguiu um encontro! Estão todos se divertindo sem você! Mas você vai mostrar a eles..."))
	owner.announce_objectives()
