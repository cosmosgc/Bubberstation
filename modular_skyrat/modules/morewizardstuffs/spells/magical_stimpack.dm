/datum/action/cooldown/spell/stimpack
	name = "Magic Stimpack"
	desc = "Este feitiço injeta magicamente estimulantes direto no seu sangue. Não funcionará em espécies sem reações reagentes!"
	school = "transmutation"
	cooldown_time = 10 SECONDS
	cooldown_reduction_per_rank = 1.25 SECONDS
	spell_requirements = NONE
	invocation = "STIMULUS CHEQ'US"
	invocation_type = INVOCATION_SHOUT

/datum/action/cooldown/spell/stimpack/cast(mob/living/cast_on)
	. = ..()
	cast_on.balloon_alert(cast_on, "acelerando.")
	cast_on.SetKnockdown(0)
	cast_on.set_stamina_loss(0)
	cast_on.set_resting(FALSE)
	cast_on.reagents.add_reagent(/datum/reagent/medicine/stimulants, 3) // Ideally this comes out to a bit less than 30 seconds with tidi taken into account.
	return TRUE
