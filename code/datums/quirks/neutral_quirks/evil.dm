/datum/quirk/evil
	name = "Fundamentally Evil"
	desc = "Onde você teria uma alma é apenas um vazio negro. Enquanto você está comprometido em manter sua posição social, qualquer um que olha muito tempo em seus olhos frios e indiferentes saberá a verdade. Você é realmente mau. Não há nada de errado com você. Você escolheu ser mau, comprometido com isso. Suas ambições vêm em primeiro lugar."
	icon = FA_ICON_HAND_MIDDLE_FINGER
	value = 0
	mob_trait = TRAIT_EVIL
	gain_text = span_notice("Você perde o pouco que resta da sua humanidade. Você tem trabalho a fazer.")
	lose_text = span_notice("De repente você se importa mais com os outros e suas necessidades.")
	medical_record_text = "O paciente passou em todos os testes de aptidão social, mas teve problemas nos testes de empatia."
	mail_goodies = list(/obj/item/food/grown/citrus/lemon)

/datum/quirk/evil/post_add()
	var/evil_policy = get_policy("[type]") || "Please note that while you may be [LOWER_TEXT(name)], this does NOT give you any additional right to attack people or cause chaos."
	// We shouldn't need this, but it prevents people using it as a dumb excuse in ahelps.
	to_chat(quirk_holder, span_big(span_info(evil_policy)))
