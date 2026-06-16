#define DEFAULT_MAX_CURSE_COUNT 5

/// Status effect that gives the target miscellanous debuffs while throwing a status alert and causing them to smoke from the damage they're incurring.
/// Purposebuilt for cursed slot machines.
/datum/status_effect/slot_machine_curse
	id = "cursed"
	alert_type = /atom/movable/screen/alert/status_effect/cursed
	remove_on_fullheal = TRUE
	heal_flag_necessary = HEAL_ADMIN
	/// The max number of curses a target can incur with this status effect.
	var/max_curse_count = DEFAULT_MAX_CURSE_COUNT
	/// The amount of times we have been "applied" to the target.
	var/curse_count = 0
	/// Raw probability we have to deal damage this tick.
	var/damage_chance = 10
	/// Are we currently in the process of sending a monologue?
	var/monologuing = FALSE
	/// The hand we are branded to.
	var/obj/item/bodypart/branded_hand = null
	/// The cached path of the particles we're using to smoke
	var/smoke_path = null

/datum/status_effect/slot_machine_curse/on_apply()
	RegisterSignal(owner, COMSIG_MOB_STATCHANGE, PROC_REF(on_stat_changed))
	RegisterSignal(owner, COMSIG_LIVING_DEATH, PROC_REF(on_death))
	RegisterSignal(owner, COMSIG_CURSED_SLOT_MACHINE_USE, PROC_REF(check_curses))
	RegisterSignal(owner, COMSIG_CURSED_SLOT_MACHINE_LOST, PROC_REF(update_curse_count))
	RegisterSignal(SSdcs, COMSIG_GLOB_CURSED_SLOT_MACHINE_WON, PROC_REF(clear_curses))
	return ..()

/datum/status_effect/slot_machine_curse/Destroy()
	UnregisterSignal(SSdcs, COMSIG_GLOB_CURSED_SLOT_MACHINE_WON)
	branded_hand = null
	if (smoke_path)
		owner.remove_shared_particles(smoke_path)
	return ..()

/// Checks the number of curses we have and returns information back to the slot machine. `max_curse_amount` is set by the slot machine itself.
/datum/status_effect/slot_machine_curse/proc/check_curses(mob/user, max_curse_amount)
	SIGNAL_HANDLER
	if(curse_count >= max_curse_amount)
		return SLOT_MACHINE_USE_CANCEL

	if(monologuing)
		to_chat(owner, span_warning("Seu braço está resistindo suas tentativas de puxar a alavanca!")) // listening to kitschy monologues to postpone your powergaming is the true curse here.
		return SLOT_MACHINE_USE_POSTPONE

/// Handles the debuffs of this status effect and incrementing the number of curses we have.
/datum/status_effect/slot_machine_curse/proc/update_curse_count()
	SIGNAL_HANDLER
	curse_count++

	linked_alert?.update_appearance() // we may have not initialized it yet

	addtimer(CALLBACK(src, PROC_REF(handle_after_effects), 1 SECONDS)) // give it a second to let the failure sink in before we exact our toll

/// Makes a nice lorey message about the curse level we're at. I think it's nice
/datum/status_effect/slot_machine_curse/proc/handle_after_effects()
	if(QDELETED(src))
		return

	monologuing = TRUE
	var/list/messages = list()
	switch(curse_count)
		if(1) // basically your first is a "freebie" that will still require urgent medical attention and will leave you smoking forever but could be worse tbh
			if(ishuman(owner))
				var/mob/living/carbon/human/human_owner = owner
				playsound(human_owner, SFX_SEAR, 50, TRUE)
				var/obj/item/bodypart/affecting = human_owner.get_active_hand()
				branded_hand = affecting
				affecting.force_wound_upwards(/datum/wound/burn/flesh/severe/cursed_brand, wound_source = "curse of the slot machine")

			messages += span_boldwarning("Sua mão queima, e você rapidamente solta a alavanca! Você se sente um pouco doente como os nervos amortecem em sua mão...")
			messages += span_boldwarning("Parece que tem fumaça saindo da sua mão agora, mas não é tão ruim...")
			messages += span_boldwarning("Maldita máquina estúpida.")

		if(2)
			messages += span_boldwarning("A máquina não queimou você desta vez, deve ser algum trabalho obscuro da marca reconhecendo uma fonte...")
			messages += span_boldwarning("Bolhas e furúnculos começam a aparecer sobre sua pele. Cada um assobiando vapor quente do seu próprio bolso...")
			messages += span_boldwarning("Você entende que a máquina tortura você com seu encanto simplista. Pode te matar a qualquer momento, mas tem uma satisfação doentia em te forçar a continuar.")
			messages += span_boldwarning("Se pudesse sair daqui, poderia viver com suprimentos médicos. É tarde demais para parar agora?")
			messages += span_boldwarning("Ao fechar os olhos para ficar neste enigma, a marca aumenta de dor. Você treme ao pensar o que pode acontecer se ficar inconsciente.")

		if(3)
			owner.emote("cough")
			messages += span_boldwarning("Sua garganta se torna como se estivesse lentamente caindo com areia e poeira. Você ejeta o conteúdo da parte de trás da garganta na manga.")
			messages += span_boldwarning("É areia. Vermelho carmesim. Você nunca sentiu tanta sede em sua vida, mas não confia em sua própria mão para carregar o copo para seus lábios.")
			messages += span_boldwarning("Você tem a sensação de que se outra pessoa ganhasse, poderia limpar sua maldição também. Salvar sua vida é uma causa nobre.")
			messages += span_boldwarning("Claro, você pode não ter que falar sobre a natureza desta máquina, no caso de eles fugirem para deixá-lo para morrer.")
			messages += span_boldwarning("Vale a pena condenar alguém a este destino para curar a manifestação de seus próprios impulsos hedonísticos? Você terá que decidir rápido.")

		if(4)
			messages += span_boldwarning("Uma enxaqueca incha sua cabeça enquanto seus pensamentos ficam confusos. Sua mão está desesperadamente mais perto da slot machine para uma última puxada...")
			messages += span_boldwarning("O teste final da mente sobre a matéria. Você pode se esforçar para evitar um destino terrível, mas sua vida já vale tão pouco agora.")
			messages += span_boldwarning("É isso que eles querem, não é? Para testemunhar seu fracasso contra si mesmo? A compulsão leva você para frente como uma sensação de medo enche seu estômago.")
			messages += span_boldwarning("Paradoxalmente, onde há desesperança, há euforia. Elogio pelo fato de que ainda há poder suficiente em você para mais uma atração.")
			messages += span_boldwarning("Suas pernas desesperadas desejam se livrar da idéia de fugir dessa máquina miserável, mas seu próprio braço permanece complacente ao pensar em ver rodas girando.")
			messages += span_userdanger("O pedágio já foi exigido. Não há mais morte em seus termos. Sua dignidade vale mais que sua vida?")

		if(5 to INFINITY)
			if(max_curse_count != DEFAULT_MAX_CURSE_COUNT) // this probably will only happen through admin schenanigans letting people stack up infinite curses or something
				to_chat(owner, span_boldwarning("Você quer?<i>Ainda.</i>Acha que está no controle?"))
				return

			to_chat(owner, span_userdanger("Por que não pude tentar mais uma vez?"))
			owner.investigate_log("has been gibbed by the cursed status effect after accumulating [curse_count] curses.", INVESTIGATE_DEATHS)
			owner.gib(DROP_ALL_REMAINS)
			qdel(src)
			return

	for(var/message in messages)
		to_chat(owner, message)
		sleep(1.5 SECONDS) // yes yes a bit fast but it can be a lot of text and i want the whole thing to send before the cooldown on the slot machine might expire
	monologuing = FALSE

/// Cleans ourselves up and removes our curses. Meant to be done in a "positive" way, when the curse is broken. Directly use qdel otherwise.
/datum/status_effect/slot_machine_curse/proc/clear_curses()
	SIGNAL_HANDLER

	if(!isnull(branded_hand))
		var/datum/wound/brand = branded_hand.get_wound_type(/datum/wound/burn/flesh/severe/cursed_brand)
		brand?.remove_wound()

	owner.visible_message(
		span_notice("A fumaça sai lentamente de [owner.name]..."),
		span_notice("Sua pele finalmente se acalma e sua garganta não parece mais seca... O desaparecimento da marca confirma que a maldição foi levantada."),
	)
	qdel(src)

/// If our owner's stat changes, rapidly surge the damage chance.
/datum/status_effect/slot_machine_curse/proc/on_stat_changed()
	SIGNAL_HANDLER
	if(owner.stat == CONSCIOUS || owner.stat == DEAD) // reset on these two states
		damage_chance = initial(damage_chance)
		return

	to_chat(owner, span_userdanger("Enquanto seu corpo se desfaz, você sente a maldição da máquina de fenda passar pelo seu corpo!"))
	damage_chance += 75 //ruh roh raggy

/// If our owner dies without getting gibbed (as in of other causes), stop smoking because we've "expended all the life energy".
/datum/status_effect/slot_machine_curse/proc/on_death(mob/living/source, gibbed)
	SIGNAL_HANDLER

	if(!gibbed && smoke_path)
		owner.remove_shared_particles(smoke_path)

/datum/status_effect/slot_machine_curse/update_particles()
	var/particle_path = /particles/smoke/steam/mild
	switch(curse_count)
		if(2 to 3)
			particle_path = /particles/smoke/steam
		if(4 to INFINITY)
			particle_path = /particles/smoke/steam/bad

	if(smoke_path == particle_path)
		return

	if (smoke_path)
		owner.remove_shared_particles(smoke_path)
	owner.add_shared_particles(particle_path)
	smoke_path = particle_path

/datum/status_effect/slot_machine_curse/tick(seconds_between_ticks)
	if(curse_count <= 1)
		return // you get one "freebie" (single damage) to nudge you into thinking this is a bad idea before the house begins to win.

	// the house won.
	var/ticked_coefficient = (rand(15, 40) / 100)
	var/effective_percentile_chance = ((curse_count == 2 ? 1 : curse_count) * damage_chance * ticked_coefficient)

	if(SPT_PROB(effective_percentile_chance, seconds_between_ticks))
		owner.apply_damages(
			brute = (curse_count * ticked_coefficient),
			burn = (curse_count * ticked_coefficient),
			oxy = (curse_count * ticked_coefficient),
		)

/atom/movable/screen/alert/status_effect/cursed
	name = "Cursed!"
	desc = "A marca na sua mão lembra sua ganância, mas parece estar bem de outra forma."
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "cursed_by_slots"

/atom/movable/screen/alert/status_effect/cursed/update_desc()
	. = ..()
	var/datum/status_effect/slot_machine_curse/linked_effect = attached_effect
	var/curses = linked_effect?.curse_count
	switch(curses)
		if(2)
			desc = "Sua ganância está te alcançando..."
		if(3)
			desc = "Você realmente não se sente bem agora... Mas por que parar agora?"
		if(4 to INFINITY)
			desc = "Ganhadores de verdade desistem antes de alcançarem o prêmio final."

#undef DEFAULT_MAX_CURSE_COUNT
