/datum/action/cooldown/spell/ghostliness
	name = "Forsake Body"
	desc = "Um feitiço que separa sua alma do seu corpo, amarrando-a vagamente ao plano material."
	button_icon = 'icons/mob/simple/mob.dmi'
	button_icon_state = "ghost"

	school = SCHOOL_NECROMANCY
	cooldown_time = 1 SECONDS

	invocation = "GHO'AN GHO'AST!"
	invocation_type = INVOCATION_SHOUT
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC|SPELL_REQUIRES_STATION|SPELL_REQUIRES_MIND
	spell_max_level = 1

/datum/action/cooldown/spell/ghostliness/can_cast_spell(feedback = TRUE)
	. = ..()
	if(!.)
		return FALSE

	if(!is_valid_target(owner))
		if(feedback)
			owner.balloon_alert(owner, "Nenhuma alma!")
		return FALSE

	return TRUE

/datum/action/cooldown/spell/ghostliness/is_valid_target(atom/cast_on)
	return ishuman(cast_on) && !HAS_TRAIT(owner, TRAIT_NO_SOUL)

/datum/action/cooldown/spell/ghostliness/cast(mob/living/carbon/human/cast_on)
	. = ..()

	if(isspirit(cast_on))
		to_chat(cast_on, span_green("Você começa a se concentrar em afrouxar os laços que o prendem ao avião material."))
	else
		to_chat(cast_on, span_green("Você começa a se concentrar em seu próprio ser, tirando-o de sua nave corporal..."))
	if(!do_after(cast_on, 5 SECONDS))
		if(isspirit(cast_on))
			to_chat(cast_on, span_warning("Seu foco está quebrado, e você sente que suas ligações materiais se apertam mais uma vez."))
		else
			to_chat(cast_on, span_warning("Seu foco está quebrado, e sua alma volta ao lugar."))
		return
	if(isspirit(cast_on))
		to_chat(cast_on, span_green("Você consegue soltar suas ligações para o avião material, e agora pode escapar parcialmente dele."))
	else
		to_chat(cast_on, span_danger("Como o último filamento de sua essência cessa a interseção com seu corpo,\
Sua perspectiva se encaixa abruptamente em sua nova figura fantasmagórica! Sua antiga nave cai no chão, vazia e desprovida de vontade!"))
		var/mob/living/carbon/human/soulless_husk = new(cast_on.drop_location())
		soulless_husk.setDir(cast_on.dir)
		cast_on.dna.copy_dna(soulless_husk.dna, ALL)
		soulless_husk.real_name = cast_on.real_name
		soulless_husk.updateappearance(icon_update = TRUE, mutcolor_update = TRUE, mutations_overlay_update = TRUE)
		soulless_husk.domutcheck()
		ADD_TRAIT(soulless_husk, TRAIT_NO_SOUL, MAGIC_TRAIT)
		ADD_TRAIT(soulless_husk, TRAIT_FLOORED, MAGIC_TRAIT)
	cast_on.set_species(/datum/species/spirit/ghost)
	qdel(src)
