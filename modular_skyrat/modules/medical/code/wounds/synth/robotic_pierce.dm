// Pierce
// Slow to rise but high damage overall
// Hard-ish to fix
/datum/wound/electrical_damage/pierce
	heat_differential_healing_mult = 0.01
	simple_desc = "Conduítes elétricos foram perfurados, resultando em uma falha que<b>Devagar.</b>Intensifica, mas com<b>Extremo</b>Tensão máxima!"

/datum/wound_pregen_data/electrical_damage/pierce
	abstract = TRUE
	wound_series = WOUND_SERIES_WIRE_PIERCE_ELECTRICAL_DAMAGE
	required_wounding_type = WOUND_PIERCE

/datum/wound/burn/electrical_damage/pierce/get_limb_examine_description()
	return span_warning("O metal neste membro está perfurado.")

/datum/wound/electrical_damage/pierce/moderate
	name = "Punctured Capacitor"
	desc = "Um grande capacitor foi quebrado, causando danos elétricos lentos, mas notáveis."
	occur_text = "Lança um pequeno fluxo de faíscas"
	examine_desc = "Está tremendo suavemente, movimentos um pouco fracos"
	treat_text = "Substituindo a fiação danificada, embora reparos através de instrumentos de corte ou suturas possam ser suficientes, embora com eficiência limitada. Em caso de emergência, o sujeito pode ser submetido a altas temperaturas para permitir que a solda reinicie."
	treat_text_short = "Replace damaged wiring."

	sound_effect = 'modular_skyrat/modules/medical/sound/robotic_slash_T1.ogg'

	severity = WOUND_SEVERITY_MODERATE

	sound_volume = 30

	threshold_penalty = 30

	intensity = 10 SECONDS
	processing_full_shock_threshold = 7 MINUTES

	processing_shock_power_per_second_max = 1.2
	processing_shock_power_per_second_min = 1.1

	processing_shock_stun_chance = 0.5
	processing_shock_spark_chance = 35

	process_shock_spark_count_max = 1
	process_shock_spark_count_min = 1

	wirecut_repair_percent = 0.078
	wire_repair_percent = 0.036

	initial_sparks_amount = 1

	status_effect_type = /datum/status_effect/wound/electrical_damage/pierce/moderate

	a_or_from = "a"

	scar_keyword = "piercemoderate"

/datum/wound_pregen_data/electrical_damage/pierce/moderate
	abstract = FALSE
	wound_path_to_generate = /datum/wound/electrical_damage/pierce/moderate
	threshold_minimum = 40

/datum/wound/electrical_damage/pierce/severe
	name = "Penetrated Transformer"
	desc = "Um grande transformador foi perfurado, causando lentos processos, mas eventualmente intensos danos elétricos."
	occur_text = "Esvoaça e manca por um momento enquanto ejeta um fluxo de faíscas."
	examine_desc = "está estremecendo significativamente, seus servos brevemente cedem em um padrão rítmico"
	treat_text = "Contenção de fiação danificada via gaze, aplicação de fiação/suturas frescas, ou redefinição de fiação deslocada via grampeador/retrator."
	treat_text_short = "Apply gauze and replace wires."

	sound_effect = 'modular_skyrat/modules/medical/sound/robotic_slash_T2.ogg'

	severity = WOUND_SEVERITY_SEVERE

	sound_volume = 15

	threshold_penalty = 40

	intensity = 20 SECONDS
	processing_full_shock_threshold = 6.5 MINUTES

	processing_shock_power_per_second_max = 1.6
	processing_shock_power_per_second_min = 1.5

	processing_shock_stun_chance = 2.5
	processing_shock_spark_chance = 60

	process_shock_spark_count_max = 2
	process_shock_spark_count_min = 1

	wirecut_repair_percent = 0.046
	wire_repair_percent = 0.024

	initial_sparks_amount = 3

	status_effect_type = /datum/status_effect/wound/electrical_damage/pierce/severe

	a_or_from = "a"

	scar_keyword = "piercemoderate"

/datum/wound_pregen_data/electrical_damage/pierce/severe
	abstract = FALSE
	wound_path_to_generate = /datum/wound/electrical_damage/pierce/severe
	threshold_minimum = 60

/datum/wound/electrical_damage/pierce/critical
	name = "Ruptured PSU"
	desc = "O PSU local deste membro sofreu uma ruptura do núcleo, causando uma falha progressiva de energia que lentamente se intensificará em danos elétricos maciços."
	occur_text = "brilha com azul radiante, emitindo um ruído não diferente de uma Escada de Jacob"
	examine_desc = "O PSU é visível, com um grande buraco no centro."
	treat_text = "Segurança imediata via gaze, seguida por substituição de cabos de emergência e segurança via cortadores de arame ou hemostat. Se a falha se tornou incontrolável, terapia de calor extrema é recomendada."
	treat_text_short = "Apply gauze, replace wires, and use wirecutters or a hemostat."

	severity = WOUND_SEVERITY_CRITICAL
	wound_flags = (ACCEPTS_GAUZE|MANGLES_EXTERIOR|CAN_BE_GRASPED|SPLINT_OVERLAY)

	sound_effect = 'modular_skyrat/modules/medical/sound/robotic_slash_T3.ogg'

	sound_volume = 30

	threshold_penalty = 60

	intensity = 30 SECONDS
	processing_full_shock_threshold = 5.5 MINUTES

	processing_shock_power_per_second_max = 2.2
	processing_shock_power_per_second_min = 2.1

	processing_shock_stun_chance = 1
	processing_shock_spark_chance = 90

	process_shock_spark_count_max = 3
	process_shock_spark_count_min = 2

	wirecut_repair_percent = 0.032
	wire_repair_percent = 0.017

	initial_sparks_amount = 8

	status_effect_type = /datum/status_effect/wound/electrical_damage/pierce/critical

	a_or_from = "a"

	scar_keyword = "piercecritical"

/datum/wound_pregen_data/electrical_damage/pierce/critical
	abstract = FALSE
	wound_path_to_generate = /datum/wound/electrical_damage/pierce/critical
	threshold_minimum = 110
