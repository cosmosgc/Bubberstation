/datum/mutation/telepathy
	power_path = /datum/action/cooldown/spell/pointed/telepathy

/datum/action/cooldown/spell/pointed/telepathy
	name = "Telepathic Communication"
	desc = "<b>Clique esquerdo</b>... apontar o alvo para projetar um pensamento para eles.<b>Clique em direito.</b>Projete para seu último alvo, se estiver ao alcance."
	button_icon = 'icons/mob/actions/actions_revenant.dmi'
	button_icon_state = "r_transmit"
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC
	antimagic_flags = MAGIC_RESISTANCE_MIND
	cooldown_time = 1 SECONDS
	cast_range = 7
	/// What's the last mob we point-targeted with this ability?
	var/datum/weakref/last_target_ref
	/// The message we send
	var/message
	/// Are we blocking casts?
	var/blocked = FALSE

/datum/action/cooldown/spell/pointed/telepathy/is_valid_target(atom/cast_on)
	. = ..()
	if (!.)
		return FALSE

	if (!isliving(cast_on))
		to_chat(owner, span_warning("Objetos inanimados não podem ouvir seus pensamentos."))
		owner.balloon_alert(owner, "Nada de pensamentos!")
		return FALSE

	var/mob/living/living_target = cast_on
	if (living_target.stat == DEAD)
		to_chat(owner, span_warning("O barulho disruptivo da ressonância que partiu inibe sua habilidade de se comunicar com os mortos."))
		owner.balloon_alert(owner, "Não pode transmitir para os mortos!")
		return FALSE

	if (get_dist(living_target, owner) > cast_range)
		owner.balloon_alert(owner, "Longe demais!")
		return FALSE

	return TRUE

/datum/action/cooldown/spell/pointed/telepathy/before_cast(atom/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST || blocked)
		return

	message = autopunct_bare(capitalize(tgui_input_text(owner, "What do you wish to whisper to [cast_on]? You can also use # in front of the message for subtler.", "[src]", max_length = MAX_MESSAGE_LEN)))
	if(QDELETED(src) || QDELETED(owner) || QDELETED(cast_on) || !can_cast_spell())
		return . | SPELL_CANCEL_CAST

	if(get_dist(cast_on, owner) > cast_range)
		owner.balloon_alert(owner, "Eles estão muito longe!")
		return . | SPELL_CANCEL_CAST

	if(!message || length(message) == 0)
		reset_spell_cooldown()
		return . | SPELL_CANCEL_CAST

/datum/action/cooldown/spell/pointed/telepathy/Trigger(trigger_flags, atom/target)
	if (trigger_flags & TRIGGER_SECONDARY_ACTION)
		var/mob/living/last_target = last_target_ref?.resolve()

		if(isnull(last_target))
			last_target_ref = null
			owner.balloon_alert(owner, "O último alvo não está disponível!")
			return
		else if(get_dist(last_target, owner) > cast_range)
			owner.balloon_alert(owner, "[last_target]É muito longe!")
			return

		blocked = TRUE

		message = autopunct_bare(capitalize(tgui_input_text(owner, "What do you wish to whisper to [last_target]?", "[src]", null, max_length = MAX_MESSAGE_LEN, multiline = TRUE)))
		if(QDELETED(src) || QDELETED(owner) || QDELETED(last_target) || !can_cast_spell())
			blocked = FALSE
			return
		send_thought(owner, last_target, message)
		src.StartCooldown()
		blocked = FALSE
		return

	return ..()

/datum/action/cooldown/spell/pointed/telepathy/cast(mob/living/cast_on)
	. = ..()
	owner.visible_message(
		span_warning("[owner]'s atenção trava em[cast_on]."),
		ignored_mobs = owner,
	)
	send_thought(owner, cast_on, message)

/datum/action/cooldown/spell/pointed/telepathy/proc/send_thought(mob/living/caster, mob/living/target, message)
	log_directed_talk(caster, target, message, LOG_SAY, tag = "telepathy")

	last_target_ref = WEAKREF(target)

	var/subtler = FALSE
	if (copytext(message, 1, 2) == "#")
		subtler = TRUE
		message = copytext(message, 2) // Strip the leading #
	to_chat(owner, span_boldnotice("Você alcança e transmite para[target]: \"[span_purple(message)]\""))
	// flub a runechat chat message, do something with the language later
	if(owner.client?.prefs.read_preference(/datum/preference/toggle/enable_runechat))
		owner.create_chat_message(owner, owner.get_selected_language(), message, list("italics"))
	if(!target.can_block_magic(antimagic_flags, charge_cost = 0) && target.client && !(HAS_TRAIT(target, TRAIT_PSIONIC_DAMPENER))) //make sure we've got a client before we bother sending anything
		//different messaging if the target has the telepathy mutation themselves themselves
		if (ishuman(caster))
			var/mob/living/carbon/human/human_caster = caster
			var/datum/mutation/telepathy/tele_mut = human_caster.dna.get_mutation(/datum/mutation/telepathy)

			if (tele_mut)
				to_chat(target, span_boldnotice("Uma presença psíquica ressoa em sua mente:\"[span_purple(message)]\""))
			else
				to_chat(target, span_boldnotice("[caster]A voz ecoa em sua cabeça:\"[span_purple(message)]\""))

		if(target.client?.prefs.read_preference(/datum/preference/toggle/enable_runechat))
			target.create_chat_message(target, target.get_selected_language(), message, list("italics")) // it appears over them since they hear it in their head
	else
		owner.balloon_alert(owner, "Algo bloqueia seus pensamentos!")
		to_chat(owner, span_warning("Sua mente encontra resistência intransitável: o pensamento foi bloqueado!"))
		return

	if (subtler)
		return // Don't show the telepathy to ghosts
	// send to ghosts as well i guess
	for(var/mob/dead/ghost as anything in GLOB.dead_mob_list)
		if(!isobserver(ghost))
			continue

		var/from_link = FOLLOW_LINK(ghost, owner)
		var/from_mob_name = span_boldnotice("[owner]")
		var/to_link = FOLLOW_LINK(ghost, target)
		var/to_mob_name = span_name("[target]")

		to_chat(ghost, "[from_link] " + span_purple("<b>\[Telepathy\]</b> [from_mob_name]transmitir,\"[message]\"") + "Para[to_mob_name] [to_link]")

/datum/quirk/telepathic
	name = "Telepathic"
	desc = "Você é capaz de transmitir seus pensamentos para outras criaturas vivas."
	gain_text = span_purple("Sua mente está cheia de energia psíquica.")
	lose_text = span_notice("A mundanidade entra em seus pensamentos mais uma vez.")
	medical_record_text = "O paciente tem uma área estranhamente ampliada de Broca visível em biologia cerebral, e parece ser capaz de se comunicar por meios extra-sensoriais."
	value = 3
	icon = FA_ICON_HEAD_SIDE_COUGH
	/// Ref used to easily retrieve the action used when removing the quirk from silicons
	var/datum/weakref/tele_action_ref

/datum/quirk/telepathic/add(client/client_source)
	var/datum/action/cooldown/spell/pointed/telepathy/tele_action = new

	tele_action.Grant(quirk_holder)
	tele_action_ref = WEAKREF(tele_action)

/datum/quirk/telepathic/remove()
	var/datum/action/cooldown/spell/pointed/telepathy/tele_action = tele_action_ref?.resolve()
	if (!isnull(tele_action))
		QDEL_NULL(tele_action)
	tele_action_ref = null

/datum/emote/living/telepathy_reply
	key = "treply"
	key_third_person = "treply"
	cooldown = 4 SECONDS

/datum/emote/living/telepathy_reply/run_emote(mob/living/user, params, type_override, intentional)
	if (ishuman(user) && intentional)
		var/mob/living/carbon/human/human_user = user
		var/datum/mutation/telepathy/mutation = human_user.dna.get_mutation(/datum/mutation/telepathy)
		if (mutation)
			var/datum/action/cooldown/spell/pointed/telepathy/tele_action = locate() in user.actions
			// just straight up call the right-click action as is
			if (tele_action)
				tele_action.Trigger(TRIGGER_SECONDARY_ACTION)
				tele_action.blocked = FALSE

	return ..()

/datum/quirk/psionic_dampener
	name = "Psionic Dampener"
	desc = "Sua mente é anormalmente resistente à invasão psiônica. A comunicação telepática não o alcança."
	gain_text = span_notice("Apenas seus próprios pensamentos ecoam dentro de sua mente, os sussurros dos outros desaparecem em silêncio.")
	lose_text = span_purple("O distante zumbido de pensamentos estranhos retorna, escovando suavemente contra o seu próprio.")
	medical_record_text = "O sujeito exibe um amortecimento persistente da ressonância cortical. O mapeamento neural sugere imunidade quase total ao contato telepático ou psiônico."
	mob_trait = TRAIT_PSIONIC_DAMPENER
	value = 0
	icon = FA_ICON_BELL_SLASH
