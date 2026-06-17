/datum/reagent/toxin/acid/bio_acid
	name = "adaptive bio-acid"
	description = "Uma substância ácida imensamente forte de origem aparentemente biológica. Está cheio de microscópicos.\
organismos que parecem alterar sua composição para dissolver o que quer que entre em contato."
	color = "#9455ff"
	creation_purity = 100
	toxpwr = 0
	acidpwr = 0
	ph = 0.0
	penetrates_skin = TOUCH

/datum/reagent/toxin/acid/bio_acid/expose_mob(mob/living/exposed_mob, methods = TOUCH, reac_volume, show_message = TRUE, touch_protection)
	if(IS_CHANGELING(exposed_mob))
		to_chat(exposed_mob, span_changeling("Excretamos um bio-agente para neutralizar o bio-ácido. É rotina e reflexivo fazer isso."))
		volume = min(0.1, volume)
		holder.update_total()
		return
	. = ..()
	exposed_mob.adjust_fire_loss(round(reac_volume * min(1 - touch_protection), 0.1) * 3, required_bodytype = BODYTYPE_ORGANIC) // full bio protection = 100% damage reduction
	exposed_mob.acid_act(10, 50)

/datum/reagent/toxin/acid/bio_acid/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(50, seconds_per_tick))
		affected_mob.emote(pick("screech", "cry"))
