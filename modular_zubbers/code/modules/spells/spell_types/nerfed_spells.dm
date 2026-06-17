
//Barnyard Curse. Clears the curse after 3 minutes.
/datum/spellbook_entry/barnyard
	name = "Lesser Barnyard Curse"
	desc = "Este feitiço condena uma alma azarada a possuir a fala e atributos faciais de um animal de celeiro. Dura 3 minutos."

/datum/action/cooldown/spell/pointed/barnyardcurse
	name = "Lesser Barnyard Curse"
	desc = "Este feitiço condena uma alma azarada a possuir a fala e atributos faciais de um animal de celeiro. Dura 3 minutos."

/obj/item/clothing/mask/animal/make_cursed()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(clear_curse)), 3 MINUTES, TIMER_UNIQUE | TIMER_DELETE_ME)



//Mind Transfer. Can no longer be used on targets with minds.
/datum/spellbook_entry/mindswap
	name = "Lesser Mind Swap"
	desc = "Permite que você troque de corpo com um<b>Sem alma</b>Alvo ao seu lado. Vocês dois dormirão quando isso acontecer, e será bem óbvio que você é o corpo do alvo se alguém assistir você fazer isso."

/datum/action/cooldown/spell/pointed/mind_transfer
	name = "Lesser Mind Swap"
	desc = "Este feitiço permite ao usuário trocar corpos com um alvo ao lado deles. Só funciona em\"Sem alma\"Alvos."
	target_requires_key = FALSE
	target_requires_mind = FALSE

/datum/action/cooldown/spell/pointed/mind_transfer/is_valid_target(atom/cast_on)
	. = ..()
	if(!.)
		return .
	var/mob/living/living_target = cast_on //We check if the target is living above.
	if(living_target.key)
		to_chat(owner, span_warning("[living_target.p_They()] [living_target.p_do()]n't appear to have a vacant mind to swap into!"))
		return FALSE

	return TRUE


//Smite. Can longer gib and just kills you and yeets you an insane distance.

/datum/spellbook_entry/disintegrate
	name = "Lesser Smite"
	desc = "Carrega sua mão com uma energia profana, fazendo com que uma vítima tocada morra instantaneamente e seu cadáver jogue uma grande distância."

/datum/action/cooldown/spell/touch/smite
	name = "Lesser Smite"
	desc = "Este feitiço carrega sua mão com uma energia profana, fazendo com que uma vítima tocada morra instantaneamente e seu cadáver jogue uma grande distância."
	invocation = "YA'YEET!!"
	button_icon = 'icons/mob/nonhuman-player/cult.dmi'
	button_icon_state = "shade_wizard"
	sound = 'sound/effects/emotes/assslap.ogg'

/datum/action/cooldown/spell/touch/smite/cast_on_hand_hit(obj/item/melee/touch_attack/hand, mob/living/victim, mob/living/carbon/caster)

	blind_everyone_nearby(victim, caster)

	victim.investigate_log("has been yeeted by the smite spell", INVESTIGATE_DEATHS)

	var/turf/target_turf = get_edge_target_turf(victim, get_dir(caster,victim))
	victim.throw_at(target_turf, 255, 4, caster, force = MOVE_FORCE_OVERPOWERING, callback = TYPE_PROC_REF(/mob/living/, tram_slam_land)) //Shamelessly copied from tram throw code.

	victim.death(FALSE)

	return TRUE

// Laughter Demon. They're basically hugboxed slaughter demons (hence the name), but are still really powerful.
// While you're basically put in gay baby jail until it's killed, it's not TOO bad, but it should still be limited to 1.
/datum/spellbook_entry/item/hugbottle
	cost = 2
	limit = 1

// Lichdom. Imbue an object and that object is basically your mobile respawn point.
// Funny mechanic, but it was INSANELY generous on what you could imbue, causing near immortality. Mechanical changes are in the non-modular file of lichdom.dm
/datum/spellbook_entry/lichdom
	name = "Bind Fiery Soul"
	desc = "Um pacto necrômano infernal que pode ligar sua alma a um item volumosos de sua escolha.\
Transformá-lo em um Lich imortal. Enquanto o item permanecer intacto, você reviverá da morte,\
Não importa as circunstâncias. Tenha cuidado - com cada reavivamento, seu corpo ficará mais fraco, e\
Será mais fácil para os outros acharem seu poder.\
Note que a natureza ardente do feitiço também requer que ele seja lançado em um item não à prova de fogo, já que a magia não pode penetrar assim."

/datum/action/cooldown/spell/lichdom
	desc = "Um feitiço ardente das profundezas do inferno que liga sua alma a um item em suas mãos.\
Amarrar sua alma a um item o transformará em um Lich imortal.\
Enquanto o item permanecer intacto, você reviverá da morte,\
Não importa as circunstâncias.\
Não pode ser usado em objetos menores que objetos volumosos ou à prova de fogo."


// High Frequency Spellblade. Holy fuck just looking at the code is nonsense holy fuck. Can slash through walls, and also gib people who are dead. Absolutely silly.
// Replaces it with a banhammer that can send you to the perma brig because that's funnier.
/datum/spellbook_entry/item/highfrequencyblade
	name = "REAL Banhammer"
	desc = "Um Banhammer completamente REAL que manda qualquer um para o vazio por um curto período de tempo. Ataques mais fortes enviam pessoas para o Permabrig da estação, se existir."
	item_path = /obj/item/banhammer/real
	category = "Offensive"
	cost = 2
