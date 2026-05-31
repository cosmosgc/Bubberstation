/obj/item/skillchip/self_surgery
	name = "4U70-P3R4710N skillchip"
	desc = "Um chip de habilidade contendo velhos protocolos de treinamento médico de Nanotrasen, que se poderia usar para realizar cirurgias em si mesmos. Este não parece estar na melhor condição. Um pouco de podridão provavelmente tornou um pouco arriscado de usar."
	auto_traits = list(TRAIT_SELF_SURGERY)
	skill_name = "Self Surgery"
	skill_description = "Permite que você faça uma cirurgia em si mesmo."
	skill_icon = FA_ICON_USER_DOCTOR
	activate_message = span_notice("Sabe que não há nada que o impeça de fazer cirurgia em si mesmo.")
	deactivate_message = span_notice("De repente você sente que nunca deveria fazer cirurgia em si mesmo.")

/obj/item/skillchip/self_surgery/Initialize(mapload, is_removable)
	. = ..()
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)
