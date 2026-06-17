/datum/mutation/geladikinesis
	name = "Geladikinesis"
	desc = "Permite ao usuário concentrar umidade e forças abaixo de zero na neve."
	quality = POSITIVE
	text_gain_indication = span_notice("Your hand feels cold.")
	instability = POSITIVE_INSTABILITY_MINOR
	difficulty = 10
	synchronizer_coeff = 1
	power_path = /datum/action/cooldown/spell/conjure_item/snow

/datum/action/cooldown/spell/conjure_item/snow
	name = "Create Snow"
	desc = "Concentra forças criocinéticas para criar neve, útil para a construção de neve."
	button_icon_state = "snow"

	cooldown_time = 5 SECONDS
	spell_requirements = NONE

	item_type = /obj/item/stack/sheet/mineral/snow
	delete_old = FALSE
	delete_on_failure = FALSE

/datum/mutation/cryokinesis
	name = "Cryokinesis"
	desc = "Tira energia negativa do vazio abaixo de zero para congelar as temperaturas ao redor à vontade do sujeito."
	quality = POSITIVE //upsides and downsides
	text_gain_indication = span_notice("Your hand feels cold.")
	instability = POSITIVE_INSTABILITY_MODERATE
	difficulty = 12
	synchronizer_coeff = 1
	energy_coeff = 1
	power_path = /datum/action/cooldown/spell/pointed/projectile/cryo

/datum/action/cooldown/spell/pointed/projectile/cryo
	name = "Cryobeam"
	desc = "Essa energia dispara um parafuso congelado em um alvo."
	button_icon_state = "icebeam"
	base_icon_state = "icebeam"
	active_overlay_icon_state = "bg_spell_border_active_blue"
	cast_range = 9
	cooldown_time = 16 SECONDS
	spell_requirements = NONE
	antimagic_flags = NONE

	active_msg = "You focus your cryokinesis!"
	deactive_msg = "You relax."
	projectile_type = /obj/projectile/temp/cryo
