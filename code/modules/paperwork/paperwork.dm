/**
 * # Paperwork
 *
 * Paperwork documents that can be stamped by their associated stamp to provide a bonus to cargo.
 *
 * Paperwork documents are a cargo item meant to provide the opportunity to make money.
 * Each piece of paperwork has its own associated stamp it needs to be stamped with. Selling a
 * properly stamped piece of paperwork will provide a cash bonus to the cargo budget. If a document is
 * not properly stamped it will instead drain a small stipend from the cargo budget.
 *
 */

/obj/item/paperwork
	name = "paperwork documents"
	desc = "Uma bagunça desorganizada de documentos, resultados de pesquisa e resultados de investigação."
	icon = 'icons/obj/service/bureaucracy.dmi'
	icon_state = "docs_part"
	inhand_icon_state = "paper"
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_range = 1
	throw_speed = 1
	layer = MOB_LAYER
	///The stamp overlay, used to show that the paperwork is complete without making a bunch of sprites
	var/mutable_appearance/stamp_overlay
	///The specific stamp icon to be overlaid on the paperwork
	var/stamp_icon = "paper_stamp-void"
	///The stamp needed to "complete" this form.
	var/stamp_requested = /obj/item/stamp/void
	///Has the paperwork been properly stamped
	var/stamped = FALSE
	///The path to the job of the associated paperwork form
	var/stamp_job
	///Used to store the bonus text that displays when the paperwork's associated role reads it
	var/detailed_desc

/obj/item/paperwork/Initialize(mapload)
	. = ..()

	detailed_desc = span_notice("<i>Quando você vasculha os jornais, você lentamente começa a juntar o que está lendo.</i>")

/obj/item/paperwork/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(.)
		return

	if(stamped || !istype(attacking_item, /obj/item/stamp))
		return

	if(istype(attacking_item, stamp_requested))
		add_stamp()
		to_chat(user, span_notice("Você vasculha os jornais até encontrar um campo de leitura 'STAMP AQUI', e completar a papelada."))
		return TRUE
	var/datum/action/item_action/chameleon/change/stamp/stamp_action = locate() in attacking_item.actions
	if(isnull(stamp_action))
		to_chat(user, span_warning("You hunt through the papers for somewhere to use [attacking_item], but can't find anything."))
		return TRUE

	to_chat(user, span_notice("[attacking_item] morphs into the appropriate stamp, which you use to complete the paperwork."))
	stamp_action.update_look(stamp_requested)
	add_stamp()
	return TRUE

/obj/item/paperwork/examine_more(mob/user)
	. = ..()

	if(ishuman(user))
		var/mob/living/carbon/human/viewer = user
		if(istype(viewer.mind?.assigned_role, stamp_job)) //Examining the paperwork as the proper job gets you some bonus details
			. += detailed_desc
		else
			if(stamped)
				. += span_info("Parece que esses documentos já foram carimbados. Agora eles podem ser devolvidos ao Comando Central.")
			else
				var/datum/job/stamp_title = stamp_job
				var/title = initial(stamp_title.title)
				. += span_info("Trying to read through it makes your head spin. Judging by the few words you can make out, this looks like a job for the [title].")

/obj/item/paperwork/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] begins insulting the inefficiency of paperwork and bureaucracy. It looks like [user.p_theyre()] trying to commit suicide!"))

	var/obj/item/paper/new_paper = new /obj/item/paper(get_turf(src))
	var/turf/turf_to_throw_at = get_ranged_target_turf(get_turf(src), pick(GLOB.alldirs))
	new_paper.throw_at(turf_to_throw_at, 2)

	var/obj/item/bodypart/BP = user.get_bodypart(pick(BODY_ZONE_HEAD))
	if(BP?.dismember())
		new_paper.visible_message(span_alert("The [src] launches a sheet of paper, instantly slicing off [user]'s head!"))
	else
		user.visible_message(span_suicide("[user] panics and starts choking to death!"))
		return OXYLOSS

	return MANUAL_SUICIDE

/**
 * Adds the stamp overlay and sets "stamped" to true
 *
 * Adds the stamp overlay to a piece of paperwork, and sets "stamped" to true.
 * Handled as a proc so that an object may be marked as "stamped" even when a stamp isn't present (like the photocopier)
 */
/obj/item/paperwork/proc/add_stamp()
	stamp_overlay = mutable_appearance('icons/obj/service/bureaucracy.dmi', stamp_icon)
	add_overlay(stamp_overlay)
	stamped = TRUE

/**
 * Copies the requested stamp, associated job, and associated icon of a given paperwork type
 *
 * Copies the stamp/job related info of a given paperwork type to the object
 * Used to mutate photocopied/ancient paperwork into behaving like their subtype counterparts without the extra details
 */
/obj/item/paperwork/proc/copy_stamp_info(obj/item/paperwork/paperwork_type)
	stamp_requested = initial(paperwork_type.stamp_requested)
	stamp_job = initial(paperwork_type.stamp_job)
	stamp_icon = initial(paperwork_type.stamp_icon)

//HEAD OF STAFF DOCUMENTS

/obj/item/paperwork/cargo
	stamp_requested = /obj/item/stamp/head/qm
	stamp_job = /datum/job/quartermaster
	stamp_icon = "paper_stamp-qm"

/obj/item/paperwork/cargo/Initialize(mapload)
	. = ..()

	detailed_desc += span_info("Os papéis são uma bagunça de ordem de envio. Não há razão para como esses documentos são resolvidos.")
	detailed_desc += span_info("Pelo que parece, não há nada fora do comum aqui além de um pedido de alta prioridade para um segundo motor.")
	detailed_desc += span_info("O campo 'prioridade pedido razão' é rabiscar, mas uma nota nas margens diz 'nós só queremos tentar dois motores, não se preocupe com isso'.")
	detailed_desc += span_info("Apesar da desorganização dos documentos, estão todos devidamente preenchidos. Deveria carimbar isso.")

/obj/item/paperwork/security
	stamp_requested = /obj/item/stamp/head/hos
	stamp_job = /datum/job/head_of_security
	stamp_icon = "paper_stamp-hos"

/obj/item/paperwork/security/Initialize(mapload)
	. = ..()

	detailed_desc += span_info("A pilha de documentos está relacionada com um caso civil sendo processado por uma instalação vizinha.")
	detailed_desc += span_info("O documento pede que reveja um relatório de conduta apresentado pelo advogado da delegacia.")
	detailed_desc += span_info("O caso detalha acusações contra o departamento de segurança da estação, incluindo má conduta, assédio, e...")
	detailed_desc += span_info("Que merda, a equipe de segurança estava fazendo o que tinha que fazer. Deveria carimbar isso.")

/obj/item/paperwork/service
	stamp_requested = /obj/item/stamp/head/hop
	stamp_job = /datum/job/head_of_personnel
	stamp_icon = "paper_stamp-hop"

/obj/item/paperwork/service/Initialize(mapload)
	. = ..()

	detailed_desc += span_info("Comece a analisar o documento. Este é um formulário padrão Nanotrasen NT-435Z3 usado para pedidos ao Comando Central.")
	detailed_desc += span_info("Parece que uma estação próxima enviou um pedido de prioridade máxima para carvão, em quantidades aparentemente ridículas.")
	detailed_desc += span_info("A razão listada para o pedido parece ser rapidamente preenchido - 'Procurando métodos alternativos para a energia da estação.'")
	detailed_desc += span_info("Um pedido de prioridade máxima como este não é nada para negar. Deveria carimbar isso.")

/obj/item/paperwork/medical
	stamp_requested = /obj/item/stamp/head/cmo
	stamp_job = /datum/job/chief_medical_officer
	stamp_icon = "paper_stamp-cmo"

/obj/item/paperwork/medical/Initialize(mapload)
	. = ..()

	detailed_desc += span_info("A pilha de documentos parece ser um relatório médico de uma estação próxima, detalhando a autópsia de uma xenofauna desconhecida.")
	detailed_desc += span_info("Saltando para o final do relatório revela que o espécime era o macaco de estimação do barman.")
	detailed_desc += span_info("O espécime foi exposto à radiação durante um \"incidente não relacionado com o motor\", levando à sua forma mutada.")
	detailed_desc += span_info("Apesar disso, os resultados da autópsia parecem ser úteis. Deveria carimbar isso.")


/obj/item/paperwork/engineering
	stamp_requested = /obj/item/stamp/head/ce
	stamp_job = /datum/job/chief_engineer
	stamp_icon = "paper_stamp-ce"

/obj/item/paperwork/engineering/Initialize(mapload)
	. = ..()

	detailed_desc += span_info("Estes papéis são um relatório de energia de uma estação vizinha. Ele detalha a potência e outros dados de engenharia sobre a estação durante uma mudança típica.")
	detailed_desc += span_info("Verificando os registros, nota-se o pico de energia e temperatura do motor dramaticamente, e logo depois, o departamento circundante parece ser despressurizado por uma força desconhecida.")
	detailed_desc += span_info("Claramente o departamento de engenharia da estação estava testando uma instalação experimental do motor, e teve que usar o ar nas salas próximas para ajudar a esfriar o motor. Totalmente.")
	detailed_desc += span_info("Droga, isso é impressionante. Deveria carimbar isso.")

/obj/item/paperwork/research
	stamp_requested = /obj/item/stamp/head/rd
	stamp_job = /datum/job/research_director
	stamp_icon = "paper_stamp-rd"

/obj/item/paperwork/research/Initialize(mapload)
	. = ..()

	detailed_desc += span_info("Os documentos detalham os resultados de um teste padrão de artilharia que ocorreu em uma estação próxima.")
	detailed_desc += span_info("Ao ler mais, percebe algo estranho com os resultados... O epicentro não parece estar correto.")
	detailed_desc += span_info("Se a sua matemática está correta, esta explosão não aconteceu no local de artilharia da estação, ocorreu na sala de máquinas da estação.")
	detailed_desc += span_info("Mesmo assim, ainda são resultados de testes perfeitamente utilizáveis. Deveria carimbar isso.")

/obj/item/paperwork/captain
	stamp_requested = /obj/item/stamp/head/captain
	stamp_job = /datum/job/captain
	stamp_icon = "paper_stamp-cap"

/obj/item/paperwork/captain/Initialize(mapload)
	. = ..()

	detailed_desc += span_info("Os documentos são uma correspondência não assinada da mesa do capitão de uma estação próxima.")
	detailed_desc += span_info("Parece ser uma mensagem padrão de check-in, informando que a estação está funcionando com eficiência ótima.")
	detailed_desc += span_info("A mensagem repetidamente afirma que o motor está funcionando 'perfeitamente bem' e está gerando 'cargas de bunda' de energia.")
	detailed_desc += span_info("Tudo confere. Deveria carimbar isso.")

//Photocopied paperwork. These are created when paperwork, whether stamped or otherwise, is printed. If it is stamped, it can be sold to cargo at the risk of the paperwork not being accepted (which takes a small fee from cargo).
//If it is unstamped it will lose you money like normal, unless it has been marked with a VOID stamp
/obj/item/paperwork/photocopy
	name = "photocopied paperwork documents"
	desc = "Uma bagunça ainda mais desorganizada de documentos e documentos copiados. Será que estes sequer copiam na ordem certa?"
	stamp_icon = "paper_stamp-pc"
	/// Has the photocopy been marked with a "void" stamp. Used to prevent documents from draining money if they somehow make their way to cargo.
	var/voided = FALSE

/obj/item/paperwork/photocopy/Initialize(mapload)
	. = ..()

	detailed_desc = span_notice("O trabalho de impressão nesta papelada o tornou quase totalmente ilegível.")

/obj/item/paperwork/photocopy/examine_more(mob/user)
	. = ..()

	if(stamped)
		if(voided)
			. += span_notice("Parece que foi marcado como \"VOID\" na frente. É improvável que alguém aceite isso agora.")
		else
			. += span_notice("O selo na frente parece estar manchado e desbotado. O Comando Central provavelmente ainda vai aceitar isso, certo?")
	else
		. += span_notice("Estes parecem ser apenas uma fotocópia dos documentos originais.")

/obj/item/paperwork/photocopy/attackby(obj/item/attacking_item, mob/user, list/modifiers, list/attack_modifiers)
	if(istype(attacking_item, /obj/item/stamp/void) && !stamped && !voided)
		to_chat(user, span_notice("You plant the [attacking_item] firmly onto the front of the documents."))
		stamp_overlay = mutable_appearance('icons/obj/service/bureaucracy.dmi', "paper_stamp-void")
		add_overlay(stamp_overlay)
		voided = TRUE
		stamped = TRUE //It won't get you any money, but it also can't LOSE you money now.
		return

	return ..()

//Ancient paperwork is a subtype of paperwork, meant to be used for any paperwork not spawned by the event.
//It doesn't have any of the flavor text that the event ones spawn with.

/obj/item/paperwork/ancient
	name = "ancient paperwork"
	desc = "Uma bagunça feia e empoeirada de pedaços de papel. Você não pode reconhecer um único nome, data ou tópico mencionado dentro. Quantos anos tem?"

/obj/item/paperwork/ancient/Initialize(mapload)
	. = ..()

	detailed_desc = span_notice("É impossível dizer a idade deles ou para que servem, mas o Comando Central pode apreciá-los.")

	var/static/list/paperwork_to_use //Make the ancient paperwork function like one of the main types
	if(!paperwork_to_use)
		paperwork_to_use = subtypesof(/obj/item/paperwork)
		paperwork_to_use -= (list(/obj/item/paperwork/ancient, /obj/item/paperwork/photocopy)) //Get rid of the uncopiable paperwork types

	var/obj/item/paperwork/paperwork_type = pick(paperwork_to_use)
	copy_stamp_info(paperwork_type)
