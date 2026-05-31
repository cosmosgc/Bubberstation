#define SPELLBOOK_CATEGORY_PERKS "Perks"

/datum/spellbook_entry/perks
	desc = "Nó principal de vantagens"
	category = SPELLBOOK_CATEGORY_PERKS
	refundable = FALSE // no refund
	requires_wizard_garb = FALSE
	/// Icon that will be shown on wizard hud when purchasing a perk.
	var/hud_icon

/datum/spellbook_entry/perks/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy)
	var/datum/antagonist/wizard/wizard_datum = user.mind.has_antag_datum(/datum/antagonist/wizard)
	if(wizard_datum)
		wizard_datum.perks += src
	RegisterSignal(user, COMSIG_MOB_HUD_CREATED, PROC_REF(on_hud_created))
	if (user.hud_used)
		on_hud_created()
	to_chat(user, span_notice("Você tem uma nova vantagem:[src.name]."))
	log_purchase(user.key)
	return TRUE

/datum/spellbook_entry/perks/proc/on_hud_created(mob/living/carbon/human/user, datum/antagonist/wizard/wizard_datum)
	SIGNAL_HANDLER

	var/datum/hud/user_hud = user.hud_used
	if(!user_hud.screen_objects[HUD_WIZARD_COMPACT_PERKS])
		user_hud.add_screen_object(/atom/movable/screen/perk/more, HUD_WIZARD_COMPACT_PERKS, HUD_GROUP_INFO, ui_loc = ui_perk_position(0), update_screen = TRUE)

	var/atom/movable/screen/perk/perk = user_hud.add_screen_object(/atom/movable/screen/perk, HUD_WIZARD_PERK(length(wizard_datum.perks)), HUD_GROUP_INFO, ui_loc = ui_perk_position(length(wizard_datum.perks)), update_screen = TRUE)
	perk.name = name
	perk.icon_state = hud_icon

/datum/spellbook_entry/perks/fourhands
	name = "Four Hands"
	desc = "Te dá ainda mais mãos para fazer magia."
	hud_icon = "fourhands"

/datum/spellbook_entry/perks/fourhands/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy)
	. = ..()
	user.change_number_of_hands(4)

/datum/spellbook_entry/perks/wormborn
	name = "Worm Born"
	desc = "Sua alma está infestada de vermes mana. Quando morrer, renascerá como um grande verme. Quando o verme morre, não tem tanta sorte. Infecção parasítica impede que você ligue sua alma a objetos."
	hud_icon = "wormborn"
	no_coexistence_typecache = list(/datum/action/cooldown/spell/lichdom)

/datum/spellbook_entry/perks/wormborn/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy)
	. = ..()
	user.AddComponent(/datum/component/wormborn)

/datum/spellbook_entry/perks/dejavu
	name = "Déjà vu"
	desc = "A cada 60 segundos você volta para o lugar onde estava 60 segundos atrás com a mesma quantidade de saúde que tinha 60 segundos atrás."
	hud_icon = "dejavu"

/datum/spellbook_entry/perks/dejavu/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy)
	. = ..()
	RegisterSignal(user, COMSIG_ENTER_AREA, PROC_REF(give_dejavu))

/datum/spellbook_entry/perks/dejavu/proc/give_dejavu(mob/living/carbon/human/wizard, area/new_area)
	SIGNAL_HANDLER

	if(istype(new_area, /area/centcom))
		return
	wizard.AddComponent(/datum/component/dejavu/wizard, 1, 60 SECONDS, TRUE)
	UnregisterSignal(wizard, COMSIG_ENTER_AREA)

/datum/spellbook_entry/perks/spell_lottery
	name = "Spells Lottery"
	desc = "Feitiços A loteria lhe dá a chance de conseguir algo do livro totalmente grátis, mas você não pode mais reembolsar nenhuma compra."
	hud_icon = "spellottery"

/datum/spellbook_entry/perks/spell_lottery/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy)
	. = ..()
	ADD_TRAIT(user, TRAIT_SPELLS_LOTTERY, REF(src))

/datum/spellbook_entry/perks/gamble
	name = "Gamble"
	desc = "Você ganha duas regalias aleatórias."
	hud_icon = "gamble"

/datum/spellbook_entry/perks/gamble/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy)
	. = ..()
	var/datum/antagonist/wizard/check_perks = user.mind.has_antag_datum(/datum/antagonist/wizard)
	var/perks_allocated = 0
	var/list/taking_perks = list()
	for(var/datum/spellbook_entry/perks/generate_perk in book.entries)
		if(istype(generate_perk, src))
			continue
		if(check_perks && is_type_in_list(generate_perk, check_perks.perks))
			continue
		taking_perks += generate_perk
		perks_allocated++
		if(perks_allocated >= 2)
			break
	if(taking_perks.len < 1)
		to_chat(user, span_warning("Gamble não pode dar duas regalias, então os pontos são devolvidos."))
		return FALSE
	taking_perks = shuffle(taking_perks)
	for(var/datum/spellbook_entry/perks/perks_ready in taking_perks)
		perks_ready.buy_spell(user, book, log_buy)

/datum/spellbook_entry/perks/heart_eater
	name = "Heart Eater"
	desc = "Dá-lhe a capacidade de obter a força da vida de uma pessoa comendo seu coração. Comer o coração de alguém pode aumentar sua resistência a danos ou ganhar mutação aleatória. O coração também dá uma forte cura."
	hud_icon = "hearteater"

/datum/spellbook_entry/perks/heart_eater/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy)
	. = ..()
	user.AddComponent(/datum/component/heart_eater)

/datum/spellbook_entry/perks/slime_friends
	name = "Slime Friends"
	desc = "Slimes são seus amigos. A cada 15 segundos você perde alguns nutrientes e convoca um lodo maligno aleatório para lutar do seu lado."
	hud_icon = "slimefriends"

/datum/spellbook_entry/perks/slime_friends/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy)
	. = ..()
	user.AddComponent(/datum/component/slime_friends)

/datum/spellbook_entry/perks/transparence
	name = "Transparence"
	desc = "Você se torna um pouco mais perto do mundo dos mortos. Projéteis passam por você, mas você perde 25% de sua saúde e você é caçado por uma terrível maldição que quer devolvê-lo à vida após a morte."
	hud_icon = "transparence"

/datum/spellbook_entry/perks/transparence/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy)
	. = ..()
	user.maxHealth *= 0.75
	user.alpha = 125
	ADD_TRAIT(user, TRAIT_UNHITTABLE_BY_PROJECTILES, REF(src))
	RegisterSignal(user, COMSIG_ENTER_AREA, PROC_REF(make_stalker))

/datum/spellbook_entry/perks/transparence/proc/make_stalker(mob/living/carbon/human/wizard, area/new_area)
	SIGNAL_HANDLER

	if(istype(new_area, /area/centcom/wizard_station))
		return
	wizard.gain_trauma(/datum/brain_trauma/magic/stalker, TRAUMA_RESILIENCE_ABSOLUTE)
	UnregisterSignal(wizard, COMSIG_ENTER_AREA)

/datum/spellbook_entry/perks/magnetism
	name = "Magnetism"
	desc = "Você tem uma pequena anomalia gravitacional que orbita ao seu redor. As coisas próximas serão atraídas por você."
	hud_icon = "magnetism"

/datum/spellbook_entry/perks/magnetism/buy_spell(mob/living/carbon/human/user, obj/item/spellbook/book, log_buy)
	. = ..()
	var/atom/movable/magnitizm = new /obj/effect/wizard_magnetism(get_turf(user))
	magnitizm.orbit(user, 20)

/obj/effect/wizard_magnetism
	name = "magnetic anomaly"
	icon = 'icons/effects/effects.dmi'
	icon_state = "shield2"
	/// We need to orbit around someone.
	var/datum/weakref/owner

/obj/effect/wizard_magnetism/New(loc, ...)
	. = ..()
	transform *= 0.4

/obj/effect/wizard_magnetism/orbit(atom/new_owner, radius, clockwise, rotation_speed, rotation_segments, pre_rotation)
	. = ..()
	if(!isliving(new_owner))
		return
	owner = WEAKREF(new_owner)
	RegisterSignal(new_owner, COMSIG_ENTER_AREA, PROC_REF(check_area))
	RegisterSignal(new_owner, COMSIG_LIVING_DEATH, PROC_REF(on_owner_death))

/obj/effect/wizard_magnetism/proc/check_area(mob/living/wizard, area/new_area)
	SIGNAL_HANDLER

	if(new_area == GLOB.areas_by_type[/area/centcom/wizard_station])
		return
	START_PROCESSING(SSprocessing, src)
	UnregisterSignal(wizard, COMSIG_ENTER_AREA)

/obj/effect/wizard_magnetism/proc/on_owner_death()
	SIGNAL_HANDLER

	stop_orbit()

/obj/effect/wizard_magnetism/process(seconds_per_tick)
	if(isnull(owner))
		stop_orbit()
		return
	var/mob/living/wizard = owner.resolve()
	var/list/things_in_range = orange(5, wizard) - orange(1, wizard)
	for(var/obj/take_object in things_in_range)
		if(!take_object.anchored)
			step_towards(take_object, wizard)
	for(var/mob/living/living_mov in things_in_range)
		if(wizard)
			if(living_mov == wizard)
				continue
		if(!living_mov.mob_negates_gravity())
			step_towards(living_mov, wizard)

/obj/effect/wizard_magnetism/stop_orbit(datum/component/orbiter/orbiter, refreshing = FALSE)
	if(refreshing)
		return ..()
	STOP_PROCESSING(SSprocessing, src)
	qdel(src)

#undef SPELLBOOK_CATEGORY_PERKS
