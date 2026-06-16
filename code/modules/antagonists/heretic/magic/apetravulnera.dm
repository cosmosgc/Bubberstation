/datum/action/cooldown/spell/pointed/apetra_vulnera
	name = "Apetra Vulnera"
	desc = "Causa hemorragia grave em cada membro de um alvo que tem mais de 15 danos brutos. Feri um membro aleatório se nenhum membro estiver suficientemente danificado."
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	button_icon = 'icons/mob/actions/actions_ecult.dmi'
	button_icon_state = "apetra_vulnera"

	school = SCHOOL_FORBIDDEN
	cooldown_time = 45 SECONDS

	invocation = "AP'TRA VULN'RA!"
	invocation_type = INVOCATION_WHISPER
	spell_requirements = NONE

	cast_range = 4
	/// What type of wound we apply
	var/wound_type = /datum/wound/slash/flesh/critical/cleave

/datum/action/cooldown/spell/pointed/apetra_vulnera/is_valid_target(atom/cast_on)
	return ..() && ishuman(cast_on)

/datum/action/cooldown/spell/pointed/apetra_vulnera/cast(mob/living/carbon/human/cast_on)
	. = ..()

	if(IS_HERETIC_OR_MONSTER(cast_on))
		return FALSE

	if(!CAN_HAVE_BLOOD(cast_on))
		return FALSE

	if(cast_on.can_block_magic(antimagic_flags))
		cast_on.visible_message(
			span_danger("[cast_on] Os hematomas brilham brevemente, mas repele o efeito!"),
			span_danger("Suas contusões ardem um pouco, mas você está protegido!")
		)
		return FALSE

	var/a_limb_got_damaged = FALSE
	for(var/obj/item/bodypart/bodypart in cast_on.get_bodyparts())
		if(bodypart.brute_dam < 15)
			continue
		a_limb_got_damaged = TRUE
		var/datum/wound/slash/crit_wound = new wound_type()
		crit_wound.apply_wound(bodypart)

	if(!a_limb_got_damaged)
		var/datum/wound/slash/crit_wound = new wound_type()
		crit_wound.apply_wound(pick(cast_on.get_bodyparts()))

	cast_on.visible_message(
		span_danger("[cast_on] Arranhões e hematomas são rasgados por uma força profana!"),
		span_danger("Seus arranhões e contusões são rasgados por uma horrível força profana!")
	)

	new /obj/effect/temp_visual/cleave(get_turf(cast_on))

	return TRUE
