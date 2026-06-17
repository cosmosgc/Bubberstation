/obj/structure/sign/eyechart
	icon_state = "eyechart"
	name = "eye chart"
	desc = "Um cartaz com uma série de barras coloridas e letras de tamanhos diferentes,\
Costumava testar visão colorida e cegueira, quero dizer, acuidade visual."
	is_editable = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/eyechart, 32)

/obj/structure/sign/eyechart/examine(mob/user)
	. = ..()
	if(isobserver(user))
		return

	if(!user.can_read(src, READING_CHECK_LITERACY, silent = TRUE) || !user.has_language(/datum/language/common, UNDERSTOOD_LANGUAGE))
		if(!user.is_blind())
			. += "<hr>You gaze at the wall of symbols, trying to make sense of them..."
			. += span_warning("Mas você não sabe o que nenhum deles significa.")
		return

	if(user.is_blind())
		. += "<hr>You feel the poster."
		. += span_notice("Sim, parece que...\"E, P, D...\"Ainda bem que este gráfico tem braille!")
		return

	if(!user.can_read(src, READING_CHECK_LIGHT, silent = TRUE))
		. += "<hr>You squint at the chart."
		. += span_warning("Mas está muito escuro para entender qualquer coisa.")
		return

	var/colorblind = HAS_TRAIT(user, TRAIT_COLORBLIND)
	var/obj/item/organ/eyes/eye = user.get_organ_slot(ORGAN_SLOT_EYES)
	// eye null checks here are for mobs without eyes.
	// humans missing eyes will be caught by the is_blind check above.
	var/eye_goodness = isnull(eye) ? 0 : eye.damage
	var/little_bad = isnull(eye) ? 20 : eye.low_threshold
	var/very_bad = isnull(eye) ? 30 : eye.high_threshold

	if(user.has_status_effect(/datum/status_effect/eye_blur))
		eye_goodness = max(eye_goodness, very_bad + 1)
	if(user.is_nearsighted_currently())
		eye_goodness = max(eye_goodness, little_bad + 1)
	eye_goodness += ((get_dist(user, src) - 2) * 5) // add a modifier based on distance, so closer = "better", further = "worse"

	. += "<hr>You read through the chart, for old time's sake."
	if(eye_goodness <= 0)
		. += span_notice("\"E, F, P...\" Yep, you can read down to the [colorblind ? "brown - wait, isn't it supposed to be red? -" : "red"] line.")
	else if(eye_goodness < little_bad)
		. += span_notice("\"E, F, P...\" You can make out most of the letters, but it gets a bit difficult past the [colorblind ? "grey - wait, isn't it supposed to be green? -" : "green"] line.")
	else if(eye_goodness < very_bad)
		. += span_warning("\"E, F, P.?\"Você pode ver as letras grandes, mas as menores são um pouco confusas.")
	else
		. += span_warning("\"E, P, D...?\"Você mal consegue entender as letras grandes, muito menos as menores.")
