//This component makes the ckey be moved to a target body on death
/datum/component/return_on_death
	var/mob/sourcemob
	var/deleting

/datum/component/return_on_death/Initialize(mob/source)
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_LIVING_DEATH, PROC_REF(return_to_old_body))
	RegisterSignal(parent, COMSIG_QDELETING, PROC_REF(return_to_old_body))
	sourcemob = source

/datum/component/return_on_death/proc/return_to_old_body()
	SIGNAL_HANDLER
	var/mob/currentmob = parent
	if(currentmob && sourcemob && !(QDELETED(sourcemob)) && !(QDELETED(currentmob)))
		to_chat(currentmob, span_warning("Seu corpo atual não mais ancorando você, sua alma retorna ao seu corpo original."))
		sourcemob.ckey = currentmob.ckey
		if(HAS_TRAIT_FROM(sourcemob, TRAIT_SACRIFICED, "sacrificed"))
			REMOVE_TRAIT(sourcemob, TRAIT_SACRIFICED, "sacrificed")
	else
		to_chat(currentmob, span_warning("Você foi incapaz de retornar ao seu antigo corpo como ele foi destruído."))
	if(!QDELETED(src) && !deleting)
		qdel(src)
		deleting = TRUE


/datum/component/return_on_death/Destroy(force, silent)
	if(!deleting)
		deleting = TRUE
		return_to_old_body()
	sourcemob = null
	. = ..()


/datum/component/return_on_death/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING))
