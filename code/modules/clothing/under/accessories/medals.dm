/obj/item/clothing/accessory/medal
	name = "bronze medal"
	desc = "Uma medalha de bronze."
	icon_state = "bronze"
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT)
	resistance_flags = FIRE_PROOF
	/// Sprite used for medalbox
	var/medaltype = "medal"
	/// Has this been use for a commendation?
	var/commendation_message
	/// Who was first given this medal
	var/awarded_to
	/// Who gave out this medal
	var/awarder

/obj/item/clothing/accessory/medal/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/pinnable_accessory, on_pre_pin = CALLBACK(src, PROC_REF(provide_reason)))

/// Input a reason for the medal for the round end screen
/obj/item/clothing/accessory/medal/proc/provide_reason(mob/living/carbon/human/distinguished, mob/user)
	commendation_message = tgui_input_text(user, "Razão para este elogio? Será gravado por Nanotrasen.", "Commendation", max_length = 140)
	return !!commendation_message

/obj/item/clothing/accessory/medal/attach(obj/item/clothing/under/attach_to, mob/living/attacher)
	var/mob/living/distinguished = attach_to.loc
	if(isnull(attacher) || !istype(distinguished) || distinguished == attacher || awarded_to)
		// You can't be awarded by nothing, you can't award yourself, and you can't be awarded someone else's medal
		return ..()

	awarder = attacher.real_name
	awarded_to = distinguished.real_name

	update_appearance(UPDATE_DESC)
	add_memory_in_range(distinguished, 7, /datum/memory/received_medal, protagonist = distinguished, deuteragonist = attacher, medal_type = src, medal_text = commendation_message)
	distinguished.log_message("was given the following commendation by <b>[key_name(attacher)]</b>: [commendation_message]", LOG_GAME, color = "green")
	message_admins("<b>[key_name_admin(distinguished)]</b> was given the following commendation by <b>[key_name_admin(attacher)]</b>: [commendation_message]")
	GLOB.commendations += "[awarder] awarded <b>[awarded_to]</b> the <span class='medaltext'>[name]</span>! \n- [commendation_message]"
	SSblackbox.record_feedback("associative", "commendation", 1, list("commender" = "[awarder]", "commendee" = "[awarded_to]", "medal" = "[src]", "reason" = commendation_message))

	return ..()

/obj/item/clothing/accessory/medal/update_desc(updates)
	. = ..()
	if(commendation_message && awarded_to && awarder)
		desc += span_info("<br>A inscrição diz:[commendation_message]- Concedido para[awarded_to]Por que[awarder]")

/obj/item/clothing/accessory/medal/conduct
	name = "distinguished conduct medal"
	desc = "Uma medalha de bronze premiada por conduta distinta. Embora seja uma grande honra, este é o prêmio mais básico dado por Nanotrasen. É muitas vezes concedido por um capitão a um membro de sua tripulação."

/obj/item/clothing/accessory/medal/bronze_heart
	name = "bronze heart medal"
	desc = "Uma medalha em forma de coração de bronze premiada por sacrifício. É muitas vezes concedido postumamente ou por ferimentos graves no cumprimento do dever."
	icon_state = "bronze_heart"

/obj/item/clothing/accessory/medal/ribbon
	name = "ribbon"
	desc = "Uma fita."
	icon_state = "cargo"

/obj/item/clothing/accessory/medal/ribbon/cargo
	name = "\"cargo tech of the shift\" award"
	desc = "Um prêmio concedido apenas aos técnicos de carga que demonstraram devoção ao seu dever de acordo com as mais altas tradições da Cargonia."

/obj/item/clothing/accessory/medal/silver
	name = "silver medal"
	desc = "Uma medalha de prata."
	icon_state = "silver"
	medaltype = "medal-silver"
	custom_materials = list(/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/clothing/accessory/medal/silver/valor
	name = "medal of valor"
	desc = "Uma medalha de prata antecipada por atos de valor excedia."

/obj/item/clothing/accessory/medal/silver/security
	name = "robust security award"
	desc = "Um prêmio de combate e sacrifício em defesa dos interesses comerciais de Nanotrasen. Muitas vezes concedido ao pessoal de segurança."

/obj/item/clothing/accessory/medal/silver/excellence
	name = "\proper the head of personnel award for outstanding achievement in the field of excellence"
	desc = "O dicionário de Nanotrasen define excelência como\"a qualidade ou condição de ser excelente\"Isso é concedido aos tripulantes raros que se encaixam nessa definição."

/obj/item/clothing/accessory/medal/silver/bureaucracy
	name = "\improper Excellence in Bureaucracy Medal"
	desc = "Premiado por serviços gerenciais exemplares prestados sob contrato com Nanotrasen."

/obj/item/clothing/accessory/medal/gold
	name = "gold medal"
	desc = "Uma medalha de ouro de prestígio."
	icon_state = "gold"
	medaltype = "medal-gold"
	custom_materials = list(/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/clothing/accessory/medal/med_medal
	name = "exemplary performance medal"
	desc = "Uma medalha concedida àqueles que mostraram distinta conduta, desempenho e iniciativa dentro do departamento médico."
	icon_state = "med_medal"

/obj/item/clothing/accessory/medal/med_medal2
	name = "excellence in medicine medal"
	desc = "Uma medalha concedida àqueles que mostraram desempenho lendário, competência e iniciativa além de todas as expectativas dentro do departamento médico."
	icon_state = "med_medal2"

/obj/item/clothing/accessory/medal/gold/captain
	name = "medal of captaincy"
	desc = "Uma medalha de ouro concedida exclusivamente aos promovidos ao posto de capitão. Significa as responsabilidades codificadas de um capitão para Nanotrasen, e sua autoridade indiscutível sobre sua tripulação."
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/clothing/accessory/medal/gold/heroism
	name = "medal of exceptional heroism"
	desc = "Uma medalha de ouro extremamente rara concedida apenas pela CentCom. Receber tal medalha é a maior honra e, como tal, muito poucos existem. Esta medalha quase nunca é concedida a ninguém além de comandantes."

/obj/item/clothing/accessory/medal/plasma
	name = "plasma medal"
	desc = "Uma medalha excêntrica feita de plasma."
	icon_state = "plasma"
	medaltype = "medal-plasma"
	custom_materials = list(/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/clothing/accessory/medal/plasma/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/atmos_sensitive, mapload)

/obj/item/clothing/accessory/medal/plasma/should_atmos_process(datum/gas_mixture/air, exposed_temperature)
	return exposed_temperature > 300

/obj/item/clothing/accessory/medal/plasma/atmos_expose(datum/gas_mixture/air, exposed_temperature)
	atmos_spawn_air("[GAS_PLASMA]=20;[TURF_TEMPERATURE(exposed_temperature)]")
	visible_message(span_danger("\The [src]Explodir em Chamas!"), span_userdanger("Sua[src]Explodir em Chamas!"))
	qdel(src)

/obj/item/clothing/accessory/medal/plasma/nobel_science
	name = "nobel sciences award"
	desc = "Uma medalha de plasma que representa contribuições significativas para o campo da ciência ou engenharia."

/obj/item/clothing/accessory/medal/silver/emergency_services
	name = "emergency services award"
	desc = "Uma medalha de prata concedida aos excelentes trabalhadores de emergência de Nanotrasen, aqueles que trabalham incansavelmente juntos através da adversidade para manter sua tripulação segura e respirando nos ambientes severos do espaço sideral."
	icon_state = "emergencyservices"

	/// Flavor text that is appended to the description.
	var/insignia_desc = null

/obj/item/clothing/accessory/medal/silver/emergency_services/Initialize(mapload)
	. = ..()
	if(istext(insignia_desc))
		desc += " [insignia_desc]"

/obj/item/clothing/accessory/medal/silver/emergency_services/engineering
	icon_state = "emergencyservices_engi"
	insignia_desc = "A parte de trás da medalha tem uma chave laranja."

/obj/item/clothing/accessory/medal/silver/emergency_services/medical
	icon_state = "emergencyservices_med"
	insignia_desc = "A parte de trás da medalha tem uma cruz azul escura."

/obj/item/clothing/accessory/medal/silver/elder_atmosian
	name = "atmospheric mastery award"
	desc = "Muitas vezes referenciado como o o\"Velho Atmosian.\"Prêmio, esta medalha é concedida aos cientistas e técnicos exemplares que ultrapassam os limites e demonstram domínio da atmosfera."
	icon_state = "elderatmosian"
