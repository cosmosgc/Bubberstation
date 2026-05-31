/datum/action/cooldown/spell/splattercasting
	name = "Marrabbio's Splattercasting"
	desc = "Um feitiço inventado por um mago banido, obcecado por alinhar as essências primárias da vida e da magia em uma só. Dramaticamente diminui o resfriamento em todos os feitiços, mas cada um custará sangue, assim como naturalmente drenando de você. Você pode reabastecê-lo de suas vítimas."
	button_icon_state = "splattercasting"

	school = SCHOOL_SANGUINE
	cooldown_time = 1 SECONDS

	invocation = "THE STARS ALIGN! THE COSMOS BLEEDS!"
	invocation_type = INVOCATION_SHOUT
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC|SPELL_REQUIRES_STATION|SPELL_REQUIRES_MIND
	antimagic_flags = MAGIC_RESISTANCE|MAGIC_RESISTANCE_HOLY
	spell_max_level = 1

/datum/action/cooldown/spell/splattercasting/cast(mob/living/cast_on)
	. = ..()

	to_chat(cast_on, span_green("Você concentra seu conhecimento arcano em sua força vital, seu sangue fervendo com novo potencial..."))
	if(!do_after(cast_on, 5 SECONDS))
		to_chat(cast_on, span_warning("Seu foco está quebrado, e o ferver desaparece lentamente."))
		return

	playsound(cast_on, 'sound/effects/pope_entry.ogg', 100)
	to_chat(cast_on, span_danger("Você sente sua ligação com sua magia! Uma dor apunhalada traz um tormento momentâneo inimaginável enquanto seu coração pára, e sua pele fica fria. Agora você é apenas um recipiente para o fluxo arcano. Logo, tudo o que resta não é dor, mas fome."))

	cast_on.set_species(/datum/species/human/vampire)
	cast_on.set_blood_volume(BLOOD_VOLUME_NORMAL) ///for predictable blood total amounts when the spell is first cast.

	cast_on.AddComponent(/datum/component/splattercasting)

	if(ishuman(cast_on))
		var/mob/living/carbon/human/human_cast_on = cast_on
		human_cast_on.dropItemToGround(human_cast_on.w_uniform)
		human_cast_on.dropItemToGround(human_cast_on.wear_suit)
		human_cast_on.dropItemToGround(human_cast_on.head)
		human_cast_on.equip_to_slot_or_del(new /obj/item/clothing/suit/wizrobe/red(human_cast_on), ITEM_SLOT_OCLOTHING)
		human_cast_on.equip_to_slot_or_del(new /obj/item/clothing/head/wizard/red(human_cast_on), ITEM_SLOT_HEAD)
		human_cast_on.equip_to_slot_or_del(new /obj/item/clothing/under/color/red(human_cast_on), ITEM_SLOT_ICLOTHING)

	qdel(src)
