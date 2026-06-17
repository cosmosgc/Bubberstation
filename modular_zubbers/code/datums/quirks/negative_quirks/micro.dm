
/datum/quirk/micro
	name = "Small"
	desc = "Por alguma razão, você é um pouco menor que a maioria. Você é 20 menor que os outros,\
Com a desvantagem de ser facilmente esmagado!"
	icon = FA_ICON_MINIMIZE
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_HIDE_FROM_SCAN|QUIRK_CHANGES_APPEARANCE
	value = -4
	gain_text = span_danger("Você se sente um pouco menor.")
	lose_text = span_notice("Você se sente um pouco maior.")
	medical_record_text = "O paciente é pequeno e pequeno."
	hardcore_value = 0
	var/squash_damage_ = 8
	var/squash_chance_ = 25
	var/size_reduced = 0.8

/datum/quirk/micro/smaller
	name = "Microsized"
	desc = "Você é 30% menor que os outros...\
com a desvantagem de ser facilmente esmagado e ele dói!"
	icon = FA_ICON_LOCUST
	squash_damage_ = 15
	squash_chance_ = 40
	size_reduced = 0.7
	value = -5

/datum/quirk/micro/smallest
	name = "Microscopic"
	desc = "Você é 40% menor que os outros... As pessoas realmente apertam os olhos para te ver!\
Você também é esmagado como um inseto acidentalmente O tempo todo!"
	icon = FA_ICON_BACTERIUM
	squash_damage_ = 30
	squash_chance_ = 50
	size_reduced = 0.6
	value = -6

/datum/quirk/micro/post_add()
	var/mob/living/carbon/living_as_carbon = quirk_holder
	living_as_carbon.dna.features["body_size"] = size_reduced
	living_as_carbon.maptext_height = 32 * living_as_carbon.dna.features["body_size"]
	living_as_carbon.dna.update_body_size()
	living_as_carbon.AddComponent( \
		/datum/component/squashable, \
		squash_chance = squash_chance_, \
		squash_damage = squash_damage_, \
		squash_flags = SQUASHED_ALWAYS_IF_DEAD|SQUASHED_DONT_SQUASH_IN_CONTENTS|SQUASHED_SHOULD_BE_DOWN, \
	)

/datum/quirk/micro/remove()
	qdel(quirk_holder.GetComponent(/datum/component/squashable))



