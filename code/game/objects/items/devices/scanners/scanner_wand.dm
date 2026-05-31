/obj/item/scanner_wand
	name = "kiosk scanner wand"
	icon = 'icons/obj/devices/scanner.dmi'
	icon_state = "scanner_wand"
	inhand_icon_state = "healthanalyzer"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	desc = "Uma varinha que examina medicamente as pessoas. Inserir em um quiosque médico torna capaz de fazer um exame de saúde no paciente."
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_BULKY
	var/selected_target = null

/obj/item/scanner_wand/attack(mob/living/M, mob/living/carbon/human/user)
	flick("[icon_state]_active", src) //nice little visual flash when scanning someone else.

	if((HAS_TRAIT(user, TRAIT_CLUMSY) || HAS_TRAIT(user, TRAIT_DUMB)) && prob(25))
		user.visible_message(span_warning("[user]Alvos para ele mesmo escanear."), 		to_chat(user, span_info("Tente digitalizar.[M], antes de perceber que você está segurando o scanner para trás. Opa.")))
		selected_target = user
		return

	if(!ishuman(M))
		to_chat(user, span_info("Você só pode escanear seres humanos, não robóticos."))
		selected_target = null
		return

	user.visible_message(span_notice("[user]Alvos[M]para escanear."), 						span_notice("Seu alvo.[M]Sinais vitais."))
	selected_target = M
	return

/obj/item/scanner_wand/attack_self(mob/user)
	to_chat(user, span_info("Você limpa o alvo do scanner."))
	selected_target = null

/obj/item/scanner_wand/proc/return_patient()
	var/returned_target = selected_target
	return returned_target
