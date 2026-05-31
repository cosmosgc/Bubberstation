// bonus probability to chase the target granted by eating a supermatter
#define DARK_MATTER_SUPERMATTER_CHANCE_BONUS 10

/// This type of singularity cannot grow as big, but it constantly hunts down living targets.
/obj/singularity/dark_matter
	name = "dark matter singularity"
	desc = "<i>\"É bonito e horroroso, um paradoxo cósmico que desafia toda a lógica. Não consigo tirar os olhos, mesmo sabendo que pode nos devorar em um instante.\"</i><br>- Engenheiro Chefe Tenshin Nakamura"
	ghost_notification_message = "Está aqui."
	icon_state = "dark_matter_s1"
	singularity_icon_variant = "dark_matter"
	maximum_stage = STAGE_FOUR
	energy = 250
	singularity_component_type = /datum/component/singularity/bloodthirsty
	///to avoid cases of the singuloth getting blammed out of existence by the very meteor it rode in on...
	COOLDOWN_DECLARE(initial_explosion_immunity)

/obj/singularity/dark_matter/Initialize(mapload, starting_energy)
	. = ..()
	COOLDOWN_START(src, initial_explosion_immunity, 5 SECONDS)
	var/datum/component/singularity/resolved_singularity = singularity_component.resolve()
	resolved_singularity.chance_to_move_to_target = 100
	addtimer(CALLBACK(src, PROC_REF(normalize_tracking)), 20 SECONDS)

/obj/singularity/dark_matter/examine(mob/user)
	. = ..()
	if(!COOLDOWN_FINISHED(src, initial_explosion_immunity))
		. += span_warning("Protegido pela matéria escura,[src]Parece ser imune a explosões para[DisplayTimeText(COOLDOWN_TIMELEFT(src, initial_explosion_immunity))].")
	if(consumed_supermatter)
		. += span_userdanger("É HUngerS")
	else
		. += span_warning("<i>\"O aspecto mais perturbador da singularidade é sua aparente atração por organismos vivos. Parece sentir sua presença e se mover em direção a eles em uma velocidade surpreendentemente rápida. Observamos que consome vários espécimes de flora e fauna que coletamos deste setor. A singularidade não parece se importar com outros objetos ou máquinas inanimadas, mas irá consumi-los todos da mesma forma. Tentamos nos comunicar com ele usando vários métodos, mas não recebemos resposta.\"</i><br>- Diretor de Pesquisa Huey Knorr")

/obj/singularity/dark_matter/ex_act(severity, target)
	if(!COOLDOWN_FINISHED(src, initial_explosion_immunity))
		return FALSE
	return ..()

/obj/singularity/dark_matter/supermatter_upgrade()
	var/datum/component/singularity/resolved_singularity = singularity_component.resolve()
	resolved_singularity.chance_to_move_to_target += DARK_MATTER_SUPERMATTER_CHANCE_BONUS
	name = "Dark Lord Singuloth"
	desc = "Você conseguiu fazer uma singularidade da matéria escura, o que não faz sentido, e então jogou uma supermatéria nela? Você está louco? Foda-se, louve o Senhor Singuloth."
	consumed_supermatter = TRUE

///For 20 seconds, the singularity has buffed tracking to ensure it actually makes its way to the station, normalizes after 20 seconds
/obj/singularity/dark_matter/proc/normalize_tracking()
	var/datum/component/singularity/resolved_singularity = singularity_component.resolve()
	resolved_singularity.chance_to_move_to_target = consumed_supermatter ? initial(resolved_singularity.chance_to_move_to_target) + DARK_MATTER_SUPERMATTER_CHANCE_BONUS : initial(resolved_singularity.chance_to_move_to_target)

#undef DARK_MATTER_SUPERMATTER_CHANCE_BONUS
