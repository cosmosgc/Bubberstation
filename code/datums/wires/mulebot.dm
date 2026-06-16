#define FAST_MOTOR_SPEED 1
#define AVERAGE_MOTOR_SPEED 2
#define SLOW_MOTOR_SPEED 3

/datum/wires/mulebot
	holder_type = /mob/living/simple_animal/bot/mulebot
	proper_name = "Mulebot"
	randomize = TRUE

/datum/wires/mulebot/New(atom/holder)
	wires = list(
		WIRE_POWER1, WIRE_POWER2,
		WIRE_AVOIDANCE, WIRE_LOADCHECK,
		WIRE_MOTOR1, WIRE_MOTOR2,
		WIRE_RX, WIRE_TX, WIRE_BEACON
	)
	..()

/datum/wires/mulebot/interactable(mob/user)
	if(!..())
		return FALSE
	var/mob/living/simple_animal/bot/mulebot/mule = holder
	if(mule.bot_cover_flags & BOT_COVER_MAINTS_OPEN)
		return TRUE

/datum/wires/mulebot/on_cut(wire, mend, source)
	var/mob/living/simple_animal/bot/mulebot/mule = holder
	switch(wire)
		if(WIRE_MOTOR1, WIRE_MOTOR2)
			if(is_cut(WIRE_MOTOR1) && is_cut(WIRE_MOTOR2))
				ADD_TRAIT(mule, TRAIT_IMMOBILIZED, MOTOR_LACK_TRAIT)
				holder.audible_message(span_hear("Os motores de [mule] Vá em silêncio."), null,  1)
			else if(HAS_TRAIT_FROM(mule, TRAIT_IMMOBILIZED, MOTOR_LACK_TRAIT))
				REMOVE_TRAIT(mule, TRAIT_IMMOBILIZED, MOTOR_LACK_TRAIT)
				holder.audible_message(span_hear("Os motores de [mule] Viva a vida!"), null,  1)

			if(is_cut(WIRE_MOTOR1))
				mule.set_varspeed(FAST_MOTOR_SPEED)
				holder.audible_message(span_hear("Os motores de [mule] Rápido!"), null,  1)
			else if(is_cut(WIRE_MOTOR2))
				mule.set_varspeed(AVERAGE_MOTOR_SPEED)
				holder.audible_message(span_hear("Os motores de [mule] Whir."), null,  1)
			else
				mule.set_varspeed(SLOW_MOTOR_SPEED)
				holder.audible_message(span_hear("Os motores de [mule] Mexa-se suavemente."), null,  1)
		if(WIRE_AVOIDANCE)
			if (!isnull(source))
				log_combat(source, mule, "[is_cut(WIRE_AVOIDANCE) ? "cut" : "mended"] the MULE safety wire of")
				holder.audible_message(span_hear("Algo dentro [mule] Clicks sinistros!"), null,  1)

/datum/wires/mulebot/on_pulse(wire)
	var/mob/living/simple_animal/bot/mulebot/mule = holder
	if(!mule.has_power(TRUE))
		return //logically mulebots can't flash and beep if they don't have power.
	switch(wire)
		if(WIRE_POWER1, WIRE_POWER2)
			holder.visible_message(span_notice("[icon2html(mule, viewers(holder))] A luz de carga pisca."))
		if(WIRE_AVOIDANCE)
			holder.visible_message(span_notice("[icon2html(mule, viewers(holder))] As luzes externas piscam brevemente."))
			flick("[mule.base_icon]1", mule)
		if(WIRE_LOADCHECK)
			holder.visible_message(span_notice("[icon2html(mule, viewers(holder))] A plataforma de carga não funciona."))
		if(WIRE_MOTOR1, WIRE_MOTOR2)
			holder.visible_message(span_notice("[icon2html(mule, viewers(holder))] O motor de tração chora brevemente."))
		else
			holder.visible_message(span_notice("[icon2html(mule, viewers(holder))] Você ouve um barulho de rádio."))

#undef FAST_MOTOR_SPEED
#undef AVERAGE_MOTOR_SPEED
#undef SLOW_MOTOR_SPEED
