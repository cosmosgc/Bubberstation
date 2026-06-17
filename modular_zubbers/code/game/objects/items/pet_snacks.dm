/obj/item/pet_food
	name = "Generic pet treat"
	desc = "Muito brando para sua realidade. Você não deveria estar vendo isso."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "skeletonmeat"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/pet_food/attack(mob/living/basic/target_pet, mob/living/user)
	if(user.combat_mode)
		return
	if(!istype(target_pet, /mob/living/basic))
		to_chat(user, span_warning("Este deleite só pode ser alimentado com animais básicos!"))
		return
	if(target_pet.stat)
		to_chat(user, span_warning("O animal de estimação está morto!"))
		return



/obj/item/pet_food/pet_space_treat
	name = "Spaceproof Pet Treat"
	desc = "Um delicioso lanche para qualquer companheiro que os torne resistentes ao vazio do espaço! (Garantia nula se animal de estimação não pode, de fato, lidar com o vazio do espaço)"
	icon = 'modular_zubbers/icons/obj/pet_snacks.dmi'
	icon_state = "pet_space_treat"

/obj/item/pet_food/pet_space_treat/attack(mob/living/basic/target_pet, mob/user)
	..()
	if(HAS_TRAIT(target_pet, TRAIT_PET_SPACE_TREAT))
		to_chat(user, span_warning("Este animal de estimação já comeu um doce espacial!"))
		return
	if(!target_pet.unsuitable_atmos_damage || !target_pet.minimum_survivable_temperature || !target_pet.maximum_survivable_temperature)
		to_chat(user, span_warning("Este deleite é inadequado para este animal de estimação!"))
		return
	ADD_TRAIT(target_pet, TRAIT_PET_SPACE_TREAT, user)
	target_pet.RemoveElement(/datum/element/atmos_requirements, target_pet.habitable_atmos, target_pet.unsuitable_atmos_damage)
	target_pet.RemoveElement(/datum/element/body_temp_sensitive, target_pet.minimum_survivable_temperature, target_pet.maximum_survivable_temperature, target_pet.unsuitable_cold_damage, target_pet.unsuitable_heat_damage)
	target_pet.unsuitable_atmos_damage = 0
	target_pet.minimum_survivable_temperature = TCMB
	target_pet.maximum_survivable_temperature = T0C + 40
	target_pet.apply_atmos_requirements(TRUE)
	target_pet.apply_temperature_requirements(TRUE)
	target_pet.desc += span_notice("\n[target_pet.p_They()] seem[target_pet.p_s()] hardier against the void of space.")
	to_chat(user, span_notice("You feed the treat to the [target_pet], which they quickly gobble up."))
	qdel(src)
	return
