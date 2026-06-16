/datum/action/cooldown/spell/pointed/manse_link
	name = "Manse Link"
	desc = "Este feitiço permite que vocês pisem através da realidade e conectem mentes entre si através do seu Mansus Link. Todas as mentes ligadas ao seu Mansus Link serão capazes de se comunicar discretamente através de grandes distâncias."
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	button_icon = 'icons/mob/actions/actions_ecult.dmi'
	button_icon_state = "mansus_link"
	ranged_mousepointer = 'icons/effects/mouse_pointers/throw_target.dmi'

	school = SCHOOL_FORBIDDEN
	cooldown_time = 20 SECONDS

	invocation = "PI'RC' TH' M'ND."
	invocation_type = INVOCATION_SHOUT
	spell_requirements = NONE
	antimagic_flags = MAGIC_RESISTANCE|MAGIC_RESISTANCE_MIND

	cast_range = 7

	/// The time it takes to link to a mob.
	var/link_time = 6 SECONDS

/datum/action/cooldown/spell/pointed/manse_link/New(Target)
	. = ..()
	if(!istype(Target, /datum/component/mind_linker))
		stack_trace("[name] ([type]) was instantiated on a non-mind_linker target, this doesn't work.")
		qdel(src)

/datum/action/cooldown/spell/pointed/manse_link/is_valid_target(atom/cast_on)
	. = ..()
	if(!.)
		return FALSE

	return isliving(cast_on)

/datum/action/cooldown/spell/pointed/manse_link/before_cast(mob/living/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return

	// If we fail to link, cancel the spell.
	if(!do_linking(cast_on))
		return . | SPELL_CANCEL_CAST

/**
 * The actual process of linking [linkee] to our network.
 */
/datum/action/cooldown/spell/pointed/manse_link/proc/do_linking(mob/living/linkee)
	var/datum/component/mind_linker/linker = target
	if(linkee.stat == DEAD)
		to_chat(owner, span_warning("Eles estão mortos!"))
		return FALSE

	to_chat(owner, span_notice("Você começa a ligar [linkee] A mente da sua..."))
	to_chat(linkee, span_warning("Você sente sua mente sendo puxada para algum lugar... conectado... entrelaçado com o próprio tecido da realidade..."))

	if(!do_after(owner, link_time, linkee, hidden = TRUE))
		to_chat(owner, span_warning("Você não consegue se conectar com [linkee] A mente."))
		to_chat(linkee, span_warning("A presença estrangeira deixa sua mente."))
		return FALSE

	if(QDELETED(src) || QDELETED(owner) || QDELETED(linkee))
		return FALSE

	if(!linker.link_mob(linkee))
		to_chat(owner, span_warning("Você não consegue se ligar a [linkee] A mente."))
		to_chat(linkee, span_warning("A presença estrangeira deixa sua mente."))
		return FALSE

	return TRUE
