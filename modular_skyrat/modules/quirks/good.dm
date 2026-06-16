// SKYRAT GOOD TRAITS

/datum/quirk/hard_soles
	name = "Hardened Soles"
	desc = "Você está acostumado a andar descalço, e não receberá os efeitos negativos de fazê-lo."
	value = 2
	mob_trait = TRAIT_HARD_SOLES
	gain_text = span_notice("O chão não parece mais tão duro com seus pés.")
	lose_text = span_danger("Você começa a sentir os cumes e imperfeições no chão.")
	medical_record_text = "Os pés do paciente são mais resistentes contra tração."
	icon = FA_ICON_SHAPES

/datum/quirk/linguist
	name = "Linguist"
	desc = "Você é um estudante de inúmeras línguas e vem com um ponto adicional de linguagem."
	value = 2
	mob_trait = TRAIT_LINGUIST
	gain_text = span_notice("Seu cérebro parece mais equipado para lidar com diferentes modos de conversa.")
	lose_text = span_danger("Sua compreensão dos pontos mais finos da linguagem dracônica desaparece.")
	medical_record_text = "O paciente demonstra uma alta plasticidade cerebral em relação ao aprendizado de línguas."
	icon = FA_ICON_BOOK_ATLAS

/datum/quirk/sharpclaws
	name = "Sharp Claws"
	desc = "Seja a biologia inerente de um caçador, ou sua recusa teimosa de cortar as unhas antes das aulas de Jiu-Jitsu, seus ataques desarmados são mais afiados e farão as pessoas sangrarem."
	value = 2
	gain_text = span_notice("Suas palmas fazem um pouco pela nitidez das Unhas.")
	lose_text = span_danger("Você sente um vazio distinto como suas unhas maçam, boa sorte coçando essa coceira.")
	medical_record_text = "O paciente acabou arranhando as almofadas da mesa de exame, recomendou que olhassem para cortar as garras."
	icon = FA_ICON_LINES_LEANING

/datum/quirk/sharpclaws/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	if(!istype(human_holder))
		return FALSE

	var/obj/item/bodypart/arm/left/left_arm = human_holder.get_bodypart(BODY_ZONE_L_ARM)
	if(left_arm)
		left_arm.unarmed_attack_verbs = list("slash")
		left_arm.unarmed_attack_effect = ATTACK_EFFECT_CLAW
		left_arm.unarmed_attack_sound = 'sound/items/weapons/slash.ogg'
		left_arm.unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'
		left_arm.unarmed_sharpness = SHARP_EDGED

	var/obj/item/bodypart/arm/right/right_arm = human_holder.get_bodypart(BODY_ZONE_R_ARM)
	if(right_arm)
		right_arm.unarmed_attack_verbs = list("slash")
		right_arm.unarmed_attack_effect = ATTACK_EFFECT_CLAW
		right_arm.unarmed_attack_sound = 'sound/items/weapons/slash.ogg'
		right_arm.unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'
		right_arm.unarmed_sharpness = SHARP_EDGED

/datum/quirk/sharpclaws/remove(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/bodypart/arm/left/left_arm = human_holder.get_bodypart(BODY_ZONE_L_ARM)
	if(left_arm)
		left_arm.unarmed_attack_verbs = initial(left_arm.unarmed_attack_verbs)
		left_arm.unarmed_attack_effect = initial(left_arm.unarmed_attack_effect)
		left_arm.unarmed_attack_sound = initial(left_arm.unarmed_attack_sound)
		left_arm.unarmed_miss_sound = initial(left_arm.unarmed_miss_sound)
		left_arm.unarmed_sharpness = initial(left_arm.unarmed_sharpness)

	var/obj/item/bodypart/arm/right/right_arm = human_holder.get_bodypart(BODY_ZONE_R_ARM)
	if(right_arm)
		right_arm.unarmed_attack_verbs = initial(right_arm.unarmed_attack_verbs)
		right_arm.unarmed_attack_effect = initial(right_arm.unarmed_attack_effect)
		right_arm.unarmed_attack_sound = initial(right_arm.unarmed_attack_sound)
		right_arm.unarmed_miss_sound = initial(right_arm.unarmed_miss_sound)
		right_arm.unarmed_sharpness = initial(right_arm.unarmed_sharpness)

/datum/quirk/water_breathing
	name = "Water breathing"
	desc = "Você consegue respirar debaixo d'água!"
	value = 2
	mob_trait = TRAIT_WATER_BREATHING
	gain_text = span_notice("Você se torna consciente da umidade em seus pulmões e no ar. É bom.")
	lose_text = span_danger("Você de repente percebe que a umidade em seus pulmões sente<i>Muito estranho.</i>E você quase se engasgou!")
	medical_record_text = "Paciente possui biologia compatível com respiração aquática."
	icon = FA_ICON_FISH

// AdditionalEmotes *turf quirks
/datum/quirk/water_aspect
	name = "Water aspect (Emotes)"
	desc = "Sociedades subterrâneas são o lar para você, espaço não é muito diferente. (Diga *turf para lançar)"
	value = 0
	mob_trait = TRAIT_WATER_ASPECT
	gain_text = span_notice("Você sente que pode controlar a água.")
	lose_text = span_danger("De alguma forma, você perdeu sua capacidade de controlar a água!")
	medical_record_text = "O paciente tem uma coleção de nanobots projetados para sintetizar H2O."
	icon = FA_ICON_WATER

/datum/quirk/webbing_aspect
	name = "Webbing aspect (Emotes)"
	desc = "As pessoas de insetos capazes de tecer não são desconhecidas por receber inveja daqueles que não possuem uma impressora 3D natural. (Diga *turf para lançar)"
	value = 0
	mob_trait = TRAIT_WEBBING_ASPECT
	gain_text = span_notice("Você poderia facilmente girar uma teia.")
	lose_text = span_danger("De alguma forma, você perdeu sua habilidade de tecer.")
	medical_record_text = "O paciente tem a habilidade de tecer teias com seda naturalmente sintetizada."
	icon = FA_ICON_STICKY_NOTE

/datum/quirk/floral_aspect
	name = "Floral aspect (Emotes)"
	desc = "A pesquisa de Kudzu não é inútil, a tecnologia de fotossíntese rápida está aqui! (Diga *turf para lançar)"
	value = 0
	mob_trait = TRAIT_FLORAL_ASPECT
	gain_text = span_notice("Você sente que pode cultivar videiras.")
	lose_text = span_danger("De alguma forma, você perdeu sua habilidade de fotografar rapidamente.")
	medical_record_text = "O paciente pode rapidamente fazer fotossíntese para cultivar videiras."
	icon = FA_ICON_PLANT_WILT

/datum/quirk/ash_aspect
	name = "Ash aspect (Emotes)"
	desc = "(Lizard innate) A habilidade de forjar cinzas e chamas, um poderoso poder, mas usado principalmente para teatro. (Diga *turf para lançar)"
	value = 0
	mob_trait = TRAIT_ASH_ASPECT
	gain_text = span_notice("Há uma forja queimando dentro de você.")
	lose_text = span_danger("De alguma forma, você perdeu sua habilidade de respirar fogo.")
	medical_record_text = "Pacientes possuem uma glândula de respiração de fogo comumente encontrada em lagartos."
	icon = FA_ICON_FIRE

/datum/quirk/sparkle_aspect
	name = "Sparkle aspect (Emotes)"
	desc = "Brilha como o pó da asa de uma mariposa, ou como um gancho de luz vermelha barato. (Diga *turf para lançar)"
	value = 0
	mob_trait = TRAIT_SPARKLE_ASPECT
	gain_text = span_notice("Você está coberto de poeira brilhante!")
	lose_text = span_danger("De alguma forma, você se limpou completamente de glitter.")
	medical_record_text = "O paciente parece estrela fabuloso."
	icon = FA_ICON_HAND_SPARKLES

/datum/quirk/no_appendix
	name = "Appendicitis Survivor"
	desc = "Você teve uma apendicite no passado e não tem mais um apêndice."
	icon = FA_ICON_NOTES_MEDICAL
	value = 2
	gain_text = span_notice("Você não tem mais um apêndice.")
	lose_text = span_danger("Seu apêndice tem magicamente... recreado?")
	medical_record_text = "O paciente teve apendicite no passado e teve seu apêndice removido cirurgicamente."
	/// The mob's original appendix
	var/obj/item/organ/appendix/old_appendix

/datum/quirk/no_appendix/post_add()
	var/mob/living/carbon/carbon_quirk_holder = quirk_holder
	old_appendix = carbon_quirk_holder.get_organ_slot(ORGAN_SLOT_APPENDIX)

	if(isnull(old_appendix))
		return

	old_appendix.Remove(carbon_quirk_holder, special = TRUE)
	old_appendix.moveToNullspace()

	STOP_PROCESSING(SSobj, old_appendix)

/datum/quirk/no_appendix/remove()
	var/mob/living/carbon/carbon_quirk_holder = quirk_holder

	if(isnull(old_appendix))
		return

	var/obj/item/organ/appendix/current_appendix = carbon_quirk_holder.get_organ_slot(ORGAN_SLOT_APPENDIX)

	// if we have not gained an appendix already, put the old one back
	if(isnull(current_appendix))
		old_appendix.Insert(carbon_quirk_holder, special = TRUE)
	else
		qdel(old_appendix)

	old_appendix = null
