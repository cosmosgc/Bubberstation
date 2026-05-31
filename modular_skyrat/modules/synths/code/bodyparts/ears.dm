/obj/item/organ/ears/synth
	name = "auditory sensors"
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "ears-ipc"
	desc = "Um par de microfones destinados a serem instalados em um IPC ou cabeça sintética, que concedem a capacidade de ouvir."
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EARS
	gender = PLURAL
	maxHealth = 1 * STANDARD_ORGAN_THRESHOLD
	organ_flags = ORGAN_ROBOTIC | ORGAN_SYNTHETIC_FROM_SPECIES
	overrides_sprite_datum_organ_type = TRUE
	bodypart_overlay = /datum/bodypart_overlay/mutant/ears

/obj/item/organ/ears/synth/emp_act(severity)
	. = ..()

	if(!owner || . & EMP_PROTECT_SELF)
		return

	if(COOLDOWN_FINISHED(src, severe_cooldown)) //So we cant just spam emp to kill people.
		COOLDOWN_START(src, severe_cooldown, 10 SECONDS)
		switch(severity)
			if(EMP_HEAVY)
				owner.sound_damage(SYNTH_ORGAN_HEAVY_EMP_DAMAGE, SYNTH_DEAF_STACKS * 2)
				to_chat(owner, span_warning("Retorno nulo dos sensores auditivos detectados, procure manutenção imediatamente. Código de erro: AS-105"))

			if(EMP_LIGHT)
				owner.sound_damage(SYNTH_ORGAN_LIGHT_EMP_DAMAGE, SYNTH_DEAF_STACKS * 2)
				to_chat(owner, span_warning("Reação anômala dos sensores auditivos detectados. Código de erro: AS-50"))

/datum/design/synth_ears
	name = "Auditory Sensors"
	desc = "Um par de microfones destinados a serem instalados em um IPC ou cabeça sintética, que concedem a capacidade de ouvir."
	id = "synth_ears"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/organ/ears/synth
	category = list(
		RND_SUBCATEGORY_MECHFAB_ANDROID + RND_SUBCATEGORY_MECHFAB_ANDROID_ORGANS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE
