#define POSTER_MOOD_CAT "poster_mood"

/obj/item/poster/quirk
	name = "placeholder quirk poster"
	desc = "Uh oh! Você não deveria ter isso!"
	icon_state = "rolled_poster_legit"
	/// People from the selected department will gain a mood buff. If no department is specified applies to the entire crew.
	var/quirk_poster_department = NONE

/obj/item/poster/quirk/Initialize(mapload, obj/structure/sign/poster/new_poster_structure)
	. = ..()

	register_context()

	if(poster_structure)
		var/obj/structure/sign/poster/quirk/department_grab = poster_structure
		department_grab.quirk_poster_department = quirk_poster_department

/// You can use any spraypaint can on a quirk poster to turn it into a contraband poster from the traitor objective
/obj/item/poster/quirk/attackby(obj/item/postertool, mob/user, list/modifiers, list/attack_modifiers)
	if(!user.is_antag() || !HAS_TRAIT(user, TRAIT_POSTERBOY) || !istype(postertool, /obj/item/toy/crayon))
		return ..()
	balloon_alert(user, "Convertendo Cartaz...")
	if(!do_after(user, 5 SECONDS, user))
		balloon_alert(user, "Interrompido!")
		return
	var/obj/item/poster/traitor/quirkspawn = new(get_turf(src))
	user.put_in_hands(quirkspawn)
	to_chat(user, span_notice("Você converteu um de seus cartazes!"))
	qdel(src)

/// Screentip for the above

/obj/item/poster/quirk/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(!user.is_antag() || !HAS_TRAIT(user, TRAIT_POSTERBOY) || !istype(held_item, /obj/item/toy/crayon))
		return NONE
	context[SCREENTIP_CONTEXT_LMB] = "Turn into Demoralizing Poster"
	return CONTEXTUAL_SCREENTIP_SET

/obj/structure/sign/poster/quirk
	name = "quirk poster"
	desc = "Um grande pedaço de papel impresso caseiro resistente ao espaço."
	poster_item_name = "homemade poster"
	poster_item_desc = "Um cartaz feito com amor, algumas pessoas vão gostar de vê-lo."
	poster_item_icon_state = "rolled_legit"
	var/quirk_poster_department = NONE
	var/datum/proximity_monitor/advanced/quirk_posters/mood_buff

/obj/structure/sign/poster/quirk/on_placed_poster(mob/user)
	mood_buff = new(_host = src, range = 7, _ignore_if_not_on_turf = TRUE, department = quirk_poster_department)
	return ..()

/obj/structure/sign/poster/quirk/attackby(obj/item/I, mob/user, list/modifiers, list/attack_modifiers)
	if (I.tool_behaviour == TOOL_WIRECUTTER)
		QDEL_NULL(mood_buff)
	return ..()

/obj/structure/sign/poster/quirk/Destroy()
	QDEL_NULL(mood_buff)
	return ..()

/obj/structure/sign/poster/quirk/apply_holiday()
	var/obj/structure/sign/poster/traitor/holiday_data = /obj/structure/sign/poster/quirk/festive
	name = initial(holiday_data.name)
	desc = initial(holiday_data.desc)
	icon_state = initial(holiday_data.icon_state)

/*
 * Applies a department-based mood if you can see the parent.
 *
 * - Applies a mood buff to people who are in visible range of the item.
 */
/datum/proximity_monitor/advanced/quirk_posters
	/// Defines the specific department that the poster will apply its mood buff to, if the poster has a quirk_poster_department.
	var/department

/datum/proximity_monitor/advanced/quirk_posters/New(atom/_host, range, _ignore_if_not_on_turf = TRUE, department)
	. = ..()
	src.department = department
	RegisterSignal(host, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/proximity_monitor/advanced/quirk_posters/field_turf_crossed(atom/movable/crossed, turf/old_location, turf/new_location)
	if (!isliving(crossed) || !can_see(crossed, host, current_range))
		return
	on_seen(crossed)

/datum/proximity_monitor/advanced/quirk_posters/proc/on_examine(datum/source, mob/examiner)
	SIGNAL_HANDLER
	if (isliving(examiner))
		on_seen(examiner)

/datum/proximity_monitor/advanced/quirk_posters/proc/on_seen(mob/living/viewer)
	if (!viewer.mind || !viewer.mob_mood || (viewer.stat != CONSCIOUS) || viewer.is_blind())
		return
	if(!viewer.can_read(host, READING_CHECK_LIGHT, TRUE))
		return
	if (viewer.mob_mood.has_mood_of_category(POSTER_MOOD_CAT))
		return
	var/viewer_department = viewer.mind.assigned_role.paycheck_department
	if(department != NONE && viewer_department != department)
		return
	to_chat(viewer, span_notice("Uau, ótimo pôster!"))
	viewer.add_mood_event(POSTER_MOOD_CAT, /datum/mood_event/poster_mood)

/datum/mood_event/poster_mood
	description = "Esse cartaz está me motivando!"
	mood_change = 2

// random posters

/obj/item/poster/quirk/random
	poster_type = /obj/structure/sign/poster/quirk/random

/obj/structure/sign/poster/quirk/random
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster/quirk

/obj/item/poster/quirk/crew/random
	poster_type = /obj/structure/sign/poster/quirk/crew/random

/obj/structure/sign/poster/quirk/crew/random
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster/quirk/crew

// actual poster items

/obj/structure/sign/poster/quirk/festive
	name = "Together For The Holidays."
	desc = "Um pôster de mãos dadas e nos lembrando dos feriados que passamos juntos. Quando as pessoas lerem este pôster elas se sentirão melhor!"
	icon_state = "quirk_festive"
	never_random = TRUE

/obj/structure/sign/poster/quirk/crew
	poster_item_desc = "Um cartaz feito com amor, todos vão gostar de vê-lo."

/obj/structure/sign/poster/quirk/crew/hang
	name = "Hang In There"
	desc = "Um cartaz com um gato pendurado em um galho. Aguente firme. Quando as pessoas lerem este pôster elas se sentirão melhor!"
	icon_state = "hang_in_there"

/obj/structure/sign/poster/quirk/crew/renault
	name = "Captain's Pet"
	desc = "Um pôster retratando os capitães amados Renault. Ele está bem. Quando as pessoas lerem este pôster elas se sentirão melhor!"
	icon_state = "renault"

/obj/structure/sign/poster/quirk/crew/bike
	name = "Someday..."
	desc = "Um cartaz retratando uma bicicleta. Algum dia será seu! Quando as pessoas lerem este pôster elas se sentirão melhor!"
	icon_state = "bike"

// Departmental posters

/obj/item/poster/quirk/cargo_logo
	poster_type = /obj/structure/sign/poster/quirk/cargo_logo
	quirk_poster_department = ACCOUNT_CAR

/obj/structure/sign/poster/quirk/cargo_logo
	name = "Cargo logo"
	desc = "Um cartaz feito com amor retratando uma caixa, uma faixa para Cargonia. Quando os membros do departamento de carga lerem este cartaz, vão se sentir melhor!"
	icon_state = "cargo_logo"

/obj/item/poster/quirk/cargo_slogan
	poster_type = /obj/structure/sign/poster/quirk/cargo_slogan
	quirk_poster_department = ACCOUNT_CAR

/obj/structure/sign/poster/quirk/cargo_slogan
	name = "Cargo Strong"
	desc = "A carga é mais forte juntos! Os trabalhadores de carga se unem! Quando os membros do departamento de carga lerem este cartaz, vão se sentir melhor!"
	icon_state = "cargo_slogan"

/obj/item/poster/quirk/engineering_logo
	poster_type = /obj/structure/sign/poster/quirk/engineering_logo
	quirk_poster_department = ACCOUNT_ENG

/obj/structure/sign/poster/quirk/engineering_logo
	name = "Engineering logo"
	desc = "Um cartaz feito com amor retratando uma chave inglesa. Quando os membros do departamento de engenharia lerem este cartaz, vão se sentir melhor!"
	icon_state = "engineering_logo"

/obj/item/poster/quirk/engineering_slogan
	poster_type = /obj/structure/sign/poster/quirk/engineering_slogan
	quirk_poster_department = ACCOUNT_ENG

/obj/structure/sign/poster/quirk/engineering_slogan
	name = "No Delamination"
	desc = "O motor não vai deslaminar hoje! Quando os membros do departamento de engenharia lerem este cartaz, vão se sentir melhor!"
	icon_state = "engineering_slogan"

/obj/item/poster/quirk/medical_logo
	poster_type = /obj/structure/sign/poster/quirk/medical_logo
	quirk_poster_department = ACCOUNT_MED

/obj/structure/sign/poster/quirk/medical_logo
	name = "Blue Cross"
	desc = "Um pôster feito com amor retratando a Cruz Azul. Quando os membros do departamento médico lerem este pôster eles se sentirão melhor!"
	icon_state = "medical_logo"

/obj/item/poster/quirk/medical_slogan
	poster_type = /obj/structure/sign/poster/quirk/medical_slogan
	quirk_poster_department = ACCOUNT_MED

/obj/structure/sign/poster/quirk/medical_slogan
	name = "Heal and Mend"
	desc = "Cure todos que pedirem e conserte todos que precisarem. Quando os membros do departamento médico lerem este pôster eles se sentirão melhor!"
	icon_state = "medical_slogan"

/obj/item/poster/quirk/science_logo
	poster_type = /obj/structure/sign/poster/quirk/science_logo
	quirk_poster_department = ACCOUNT_SCI

/obj/structure/sign/poster/quirk/science_logo
	name = "Science logo"
	desc = "Um cartaz feito com amor retratando um átomo. Quando os membros do Departamento de Ciências lerem este cartaz, vão se sentir melhor!"
	icon_state = "science_logo"

/obj/item/poster/quirk/science_slogan
	poster_type = /obj/structure/sign/poster/quirk/science_slogan
	quirk_poster_department = ACCOUNT_SCI

/obj/structure/sign/poster/quirk/science_slogan
	name = "Research and Develop"
	desc = "Pesquise o desconhecido e desenvolva o impossível! Quando os membros do Departamento de Ciências lerem este cartaz, vão se sentir melhor!"
	icon_state = "science_slogan"

/obj/item/poster/quirk/security_logo
	poster_type = /obj/structure/sign/poster/quirk/security_logo
	quirk_poster_department = ACCOUNT_SEC

/obj/structure/sign/poster/quirk/security_logo
	name = "Security logo"
	desc = "Um cartaz feito com amor retratando um escudo. Quando os membros do Departamento de Segurança lerem este cartaz, vão se sentir melhor!"
	icon_state = "security_logo"

/obj/item/poster/quirk/security_logo
	poster_type = /obj/structure/sign/poster/quirk/security_slogan
	quirk_poster_department = ACCOUNT_SEC

/obj/structure/sign/poster/quirk/security_slogan
	name = "Protect and Serve"
	desc = "Para proteger a tripulação inocente e servir a justiça! Quando os membros do Departamento de Segurança lerem este cartaz, vão se sentir melhor!"
	icon_state = "security_slogan"

/obj/item/poster/quirk/service_logo
	poster_type = /obj/structure/sign/poster/quirk/service_logo
	quirk_poster_department = ACCOUNT_SRV

/obj/structure/sign/poster/quirk/service_logo
	name = "Service corgi"
	desc = "Um cartaz feito com amor retratando um certo corgi. Quando os membros do departamento de serviço lerem este cartaz, eles se sentirão melhor!"
	icon_state = "service_logo"

/obj/item/poster/quirk/service_slogan
	poster_type = /obj/structure/sign/poster/quirk/service_slogan
	quirk_poster_department = ACCOUNT_SRV

/obj/structure/sign/poster/quirk/service_slogan
	name = "Share Joy"
	desc = "Compartilhe alegria com cada ação. Trazer felicidade através da criação. Quando os membros do departamento de serviço lerem este cartaz, eles se sentirão melhor!"
	icon_state = "service_slogan"

#undef POSTER_MOOD_CAT
