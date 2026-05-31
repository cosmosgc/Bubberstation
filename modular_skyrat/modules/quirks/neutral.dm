GLOBAL_VAR_INIT(DNR_trait_overlay, generate_DNR_trait_overlay())

/// Instantiates GLOB.DNR_trait_overlay by creating a new mutable_appearance instance of the overlay.
/proc/generate_DNR_trait_overlay()
	RETURN_TYPE(/mutable_appearance)

	var/mutable_appearance/DNR_trait_overlay = mutable_appearance('modular_skyrat/modules/indicators/icons/DNR_trait_overlay.dmi', "DNR", FLY_LAYER)
	DNR_trait_overlay.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART
	return DNR_trait_overlay


// SKYRAT NEUTRAL TRAITS
/datum/quirk/excitable
	name = "Excitable!"
	desc = "Bater na cabeça faz seu rabo balançar! Você é muito excitada! Wag Wag."
	gain_text = span_notice("Você anseia por umas pancadas na cabeça!")
	lose_text = span_notice("Você não gosta mais de headpats tanto assim.")
	medical_record_text = "O paciente parece se excitar facilmente."
	value = 0
	mob_trait = TRAIT_EXCITABLE
	icon = FA_ICON_LAUGH_BEAM

/datum/quirk/affectionaversion
	name = "Affection Aversion"
	desc = "Você se recusa a ser lambido por cyborgs quadrúpedes."
	gain_text = span_notice("Você foi adicionado aos registros Do Not Lick e No Nosing.")
	lose_text = span_notice("Você foi removido dos registros do Do Not Lick e No Nosing.")
	medical_record_text = "O paciente está nos registros do Do Not Lick e No Nosing."
	value = 0
	mob_trait = TRAIT_AFFECTION_AVERSION
	icon = FA_ICON_CIRCLE_EXCLAMATION

/datum/quirk/personalspace
	name = "Personal Space"
	desc = "Você prefere que as pessoas mantenham as mãos longe do seu traseiro."
	gain_text = span_notice("Você gostaria que as pessoas ficassem longe de você.")
	lose_text = span_notice("Você está menos preocupado com as pessoas tocando sua bunda.")
	medical_record_text = "O paciente demonstra reações negativas ao toque posterior."
	value = 0
	mob_trait = TRAIT_PERSONALSPACE
	icon = FA_ICON_HAND_PAPER

/datum/quirk/dnr
	name = "Do Not Revive"
	desc = "Por qualquer razão, você não pode ser revivido de forma alguma."
	gain_text = span_notice("Seu espírito fica muito marcado para aceitar reavivamento.")
	lose_text = span_notice("Você pode sentir sua alma curando novamente.")
	medical_record_text = "O paciente é um ONR, e não pode ser revivido."
	value = 0
	mob_trait = TRAIT_DNR
	icon = FA_ICON_SKULL_CROSSBONES

/datum/quirk/dnr/add(client/client_source)
	. = ..()

	quirk_holder.update_dnr_hud()

/datum/quirk/dnr/remove()
	var/mob/living/old_holder = quirk_holder

	. = ..()

	old_holder.update_dnr_hud()

/mob/living/prepare_data_huds()
	. = ..()

	update_dnr_hud()

/// Adds the DNR HUD element if src has TRAIT_DNR. Removes it otherwise.
/mob/living/proc/update_dnr_hud()
	var/image/dnr_holder = hud_list?[DNR_HUD]
	if(isnull(dnr_holder))
		return

	var/icon/temporary_icon = icon(icon, icon_state, dir)
	dnr_holder.pixel_y = temporary_icon.Height() - world.icon_size

	if(HAS_TRAIT(src, TRAIT_DNR))
		set_hud_image_active(DNR_HUD)
		dnr_holder.icon_state = "hud_dnr"
	else
		set_hud_image_inactive(DNR_HUD)

/mob/living/carbon/human/examine(mob/user)
	. = ..()

	if(stat != DEAD && HAS_TRAIT(src, TRAIT_DNR) && (HAS_TRAIT(user, TRAIT_SECURITY_HUD) || HAS_TRAIT(user, TRAIT_MEDICAL_HUD)))
		. += "\n[span_boldwarning("This individual is unable to be revived, and may be permanently dead if allowed to die!")]"

/datum/atom_hud/data/human/dnr
	hud_icons = list(DNR_HUD)

// uncontrollable laughter
/datum/quirk/item_quirk/joker
	name = "Pseudobulbar Affect"
	desc = "Em intervalos aleatórios, você sofre explosões incontroláveis de risadas."
	value = 0
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_PROCESSES
	medical_record_text = "O paciente sofre com uma súbita e incontrolável gargalhada."
	var/pcooldown = 0
	var/pcooldown_time = 60 SECONDS
	icon = FA_ICON_GRIN_TEARS

/datum/quirk/item_quirk/joker/add_unique(client/client_source)
	give_item_to_holder(/obj/item/paper/joker, list(LOCATION_BACKPACK, LOCATION_HANDS))

/datum/quirk/item_quirk/joker/process()
	if(pcooldown > world.time)
		return
	pcooldown = world.time + pcooldown_time
	var/mob/living/carbon/human/user = quirk_holder
	if(user && istype(user))
		if(user.stat == CONSCIOUS)
			if(prob(20))
				user.emote("laugh")
				addtimer(CALLBACK(user, /mob/proc/emote, "laugh"), 5 SECONDS)
				addtimer(CALLBACK(user, /mob/proc/emote, "laugh"), 10 SECONDS)

/obj/item/paper/joker
	name = "disability card"
	icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	icon_state = "joker"
	desc = "Sorria, embora seu coração esteja doendo."
	default_raw_text = "<i>			<div style='border-style:solid;text-align:center;border-width:5px;margin: 20px;margin-bottom:0px'>			<div style='margin-top:20px;margin-bottom:20px;font-size:150%;'>Perdoe a minha risada.<br>Eu tenho uma condição.</div>			</div>			</i>			<br>			<center>			<b>Mais atrás</b>			</center>"
	/// Whether or not the card is currently flipped.
	var/flipped = FALSE
	/// The flipped version of default_raw_text.
	var/flipside_default_raw_text = "<i>			<div style='border-style:solid;text-align:center;border-width:5px;margin: 20px;margin-bottom:0px'>			<div style='margin-top:20px;margin-bottom:20px;font-size:100%;'>			<b>			It's a medical condition causing sudden,<br>			frequent and uncontrollable laughter that<br>			doesn't match how you feel.<br>			It can happen in people with a brain injury<br>			or certain neurological conditions.<br>			</b>			</div>			</div>			</i>			<br>			<center>			<b>			KINDLY RETURN THIS CARD			</b>			</center>"
	/// Flipside version of raw_text_inputs.
	var/list/datum/paper_input/flipside_raw_text_inputs
	/// Flipside version of raw_stamp_data.
	var/list/datum/paper_stamp/flipside_raw_stamp_data
	/// Flipside version of raw_field_input_data.
	var/list/datum/paper_field/flipside_raw_field_input_data
	/// Flipside version of input_field_count
	var/flipside_input_field_count = 0


/obj/item/paper/joker/Initialize(mapload)
	. = ..()
	if(flipside_default_raw_text)
		add_flipside_raw_text(flipside_default_raw_text)


/**
 * This is an unironic copy-paste of add_raw_text(), meant to have the same functionalities, but for the flipside.
 *
 * This simple helper adds the supplied raw text to the flipside of the paper, appending to the end of any existing contents.
 *
 * This a God proc that does not care about paper max length and expects sanity checking beforehand if you want to respect it.
 *
 * The caller is expected to handle updating icons and appearance after adding text, to allow for more efficient batch adding loops.
 * * Arguments:
 * * text - The text to append to the paper.
 * * font - The font to use.
 * * color - The font color to use.
 * * bold - Whether this text should be rendered completely bold.
 */
/obj/item/paper/joker/proc/add_flipside_raw_text(text, font, color, bold)
	var/new_input_datum = new /datum/paper_input(
		text,
		font,
		color,
		bold,
	)

	flipside_input_field_count += get_input_field_count(text)

	LAZYADD(flipside_raw_text_inputs, new_input_datum)


/obj/item/paper/joker/update_icon()
	..()
	icon_state = "joker"

/obj/item/paper/joker/click_alt(mob/user)
	var/list/datum/paper_input/old_raw_text_inputs = raw_text_inputs
	var/list/datum/paper_stamp/old_raw_stamp_data = raw_stamp_data
	var/list/datum/paper_stamp/old_raw_field_input_data = raw_field_input_data
	var/old_input_field_count = input_field_count

	raw_text_inputs = flipside_raw_text_inputs
	raw_stamp_data = flipside_raw_stamp_data
	raw_field_input_data = flipside_raw_field_input_data
	input_field_count = flipside_input_field_count

	flipside_raw_text_inputs = old_raw_text_inputs
	flipside_raw_stamp_data = old_raw_stamp_data
	flipside_raw_field_input_data = old_raw_field_input_data
	flipside_input_field_count = old_input_field_count

	flipped = !flipped
	update_static_data()

	balloon_alert(user, "A carta virou.")
	return CLICK_ACTION_SUCCESS

/datum/quirk/felinid_aspect
	name = "Felinid Traits"
	desc = "Você age como um felinídeo, por alguma razão. Isso substituirá outras línguas."
	gain_text = span_notice("Nya poderia tomar uma bebida agora...")
	lose_text = span_notice("Você se sente menos atraído por lasers.")
	medical_record_text = "O paciente parece ter comportamento como um felinídeo."
	mob_trait = TRAIT_FELINID
	icon = FA_ICON_CAT

/datum/quirk/felinid_aspect/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/tongue/cat/new_tongue = new(get_turf(human_holder))

	new_tongue.copy_traits_from(human_holder.get_organ_slot(ORGAN_SLOT_TONGUE))
	new_tongue.Insert(human_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)

/datum/quirk/item_quirk/canine
	name = "Canidae Traits"
	desc = "Late. Você parece agir como um canino por qualquer razão. Isso substituirá a maioria das outras línguas."
	mob_trait = TRAIT_CANINE
	icon = FA_ICON_DOG
	value = 0
	medical_record_text = "O paciente foi visto cavando na lixeira. Fique de olho neles."

/datum/quirk/item_quirk/canine/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/tongue/dog/new_tongue = new(get_turf(human_holder))

	new_tongue.copy_traits_from(human_holder.get_organ_slot(ORGAN_SLOT_TONGUE))
	new_tongue.Insert(human_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)

/datum/quirk/item_quirk/avian
	name = "Avian Traits"
	desc = "Você é um cérebro de pássaro, ou você tem um cérebro de pássaro. Isso substituirá a maioria das outras línguas."
	mob_trait = TRAIT_AVIAN
	icon = FA_ICON_KIWI_BIRD
	value = 0
	medical_record_text = "Paciente exibe maneirismos adjacentes a aves."

/datum/quirk/item_quirk/avian/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/tongue/avian/new_tongue = new(get_turf(human_holder))

	new_tongue.copy_traits_from(human_holder.get_organ_slot(ORGAN_SLOT_TONGUE))
	new_tongue.Insert(human_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)

/datum/quirk/item_quirk/bovine
	name = "Bovine Traits"
	desc = "Moo. Você parece agir como um bovino por alguma razão. Isso substituirá a maioria das outras línguas."
	mob_trait = TRAIT_BOVINE
	icon = FA_ICON_COW
	value = 0
	medical_record_text = "Paciente exibe maneirismos adjacentes a bovinos."

/datum/quirk/item_quirk/bovine/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/tongue/bovine/new_tongue = new(get_turf(human_holder))

	new_tongue.copy_traits_from(human_holder.get_organ_slot(ORGAN_SLOT_TONGUE))
	new_tongue.Insert(human_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)

///Start of Mouse Traits
/datum/quirk/item_quirk/mouse
	name = "Muridae Traits"
	desc = "Você sempre achou essas piadas bregas. Isso substituirá a maioria das outras línguas."
	mob_trait = TRAIT_MURIDAE
	icon = FA_ICON_CHEESE
	value = 0
	medical_record_text = "O paciente tem um amor insaciável por laticínios e trocadilhos terríveis."
	var/datum/action/cooldown/spell/sniff/sniff_food

/datum/quirk/item_quirk/mouse/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/tongue/mouse/new_tongue = new(get_turf(human_holder))
	human_holder.add_faction(FACTION_RAT)
	human_holder.gain_trauma(new /datum/brain_trauma/mild/phobia/mousetraps, TRAUMA_RESILIENCE_ABSOLUTE)

	new_tongue.copy_traits_from(human_holder.get_organ_slot(ORGAN_SLOT_TONGUE))
	new_tongue.Insert(human_holder, special = TRUE, movement_flags = DELETE_IF_REPLACED)

/datum/quirk/item_quirk/mouse/add(client/client_source)
	. = ..()

	sniff_food = new()
	sniff_food.Grant(quirk_holder)

/datum/quirk/item_quirk/mouse/remove()
	. = ..()

	if(QDELETED(quirk_holder))
		return

	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.cure_trauma_type(/datum/brain_trauma/mild/phobia/mousetraps, TRAUMA_RESILIENCE_ABSOLUTE)
	QDEL_NULL(sniff_food)

/datum/action/cooldown/spell/sniff
	name = "Sniff Food"
	desc = "Qualquer um sabe cozinhar!"
	button_icon_state = "food_french"
	button_icon = 'icons/hud/screen_alert.dmi'
	cooldown_time = 10 SECONDS
	spell_requirements = NONE
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_INCAPACITATED

/datum/action/cooldown/spell/sniff/cast(mob/living/caster)
	. = ..()
	try_sniff_item(caster)

// tries to check if the obj is valid to sniff
/datum/action/cooldown/spell/sniff/proc/can_sniff(obj/item/food/potential_food, mob/living/caster)
	if(potential_food.food_flags & ABSTRACT)
		return FALSE
	return TRUE

// tries to sniff item in hand
/datum/action/cooldown/spell/sniff/proc/try_sniff_item(mob/living/caster)
	var/obj/item/food/potential_food = caster.get_active_held_item()
	if(!istype(potential_food))
		if(caster.get_inactive_held_item())
			to_chat(caster, span_warning("Você deve estar segurando comida!"))
		else
			to_chat(caster, span_warning("Você não está segurando nada que possa ser usado como ingrediente!"))
		return FALSE
	if(!can_sniff(potential_food, caster))
		return FALSE
	caster.balloon_alert_to_viewers("sniffing...")
	to_chat(caster, span_notice("Você começa a julgar[potential_food]por seu potencial culinário..."))
	if(!do_after(caster, 5 SECONDS, potential_food))
		to_chat(caster, span_notice("Você não sentiu um bom cheiro de[potential_food]."))
		return FALSE
	check_recipes(potential_food)
	return TRUE

// checks recipes related to held item
/datum/action/cooldown/spell/sniff/proc/check_recipes(obj/item/food/potential_food)
	var/list/type_recipe_list = list()
	var/food_type = potential_food.type
	for(var/datum/crafting_recipe/recipe as anything in GLOB.cooking_recipes)
		if(food_type in recipe.reqs)
			type_recipe_list += recipe.result
	if(length(type_recipe_list) == 0)
		to_chat(owner, span_notice("Nada mais pode ser feito disso."))
		return FALSE
	var/datum/crafting_recipe/chosen = pick(type_recipe_list)
	to_chat(owner, span_notice("[potential_food]Poderia ser usado para fazer[chosen::name]"))
///End of Mouse Traits

/datum/quirk/sensitivesnout
	name = "Sensitive Snout"
	desc = "Seu rosto sempre foi sensível, e dói muito quando alguém cutuca!"
	gain_text = span_notice("Seu rosto é muito sensível.")
	lose_text = span_notice("Seu rosto está dormente.")
	medical_record_text = "O nariz do paciente parece ter nervos na ponta, aconselharia contra contato direto."
	value = 0
	mob_trait = TRAIT_SENSITIVESNOUT
	icon = FA_ICON_FINGERPRINT

/datum/quirk/overweight
	name = "Overweight"
	desc = "Se você pesa mais do que uma pessoa normal do seu tamanho, já se acostumou."
	gain_text = span_notice("Seu corpo está pesado.")
	lose_text = span_notice("Você de repente se sente mais leve!")
	value = 0
	icon = FA_ICON_HAMBURGER // I'm very hungry. Give me the burger!
	medical_record_text = "O paciente pesa mais que a média."
	mob_trait = TRAIT_FAT

/datum/quirk/overweight/add(client/client_source)
	quirk_holder.add_movespeed_modifier(/datum/movespeed_modifier/overweight)

/datum/quirk/overweight/remove()
	quirk_holder.remove_movespeed_modifier(/datum/movespeed_modifier/overweight)

/datum/movespeed_modifier/overweight
	multiplicative_slowdown = 0.5 //Around that of a dufflebag, enough to be impactful but not debilitating.

/datum/mood_event/fat/can_effect_mob(datum/mood/home, mob/living/target, ...)
	. = ..()

	if(HAS_TRAIT_FROM(target, TRAIT_FAT, QUIRK_TRAIT))
		mood_change = 0 // They are probably used to it, no reason to be viscerally upset about it.
		description = "<b>Estou gordo.</b>"
	return TRUE
