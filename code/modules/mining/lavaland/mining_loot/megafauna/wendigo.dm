// Wendigo blood

/obj/item/wendigo_blood
	name = "bottle of wendigo blood"
	desc = "Uma garrafa de líquido vermelho viscoso... Você não vai beber isso, vai?"
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "vial"

/obj/item/wendigo_blood/attack_self(mob/living/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human_user = user
	if(!human_user.mind)
		return
	to_chat(human_user, span_danger("O poder passa por você! Agora pode mudar sua forma à vontade."))
	var/datum/action/cooldown/spell/shapeshift/polar_bear/transformation_spell = new(user.mind || user)
	transformation_spell.Grant(user)
	playsound(human_user.loc, 'sound/items/drink.ogg', rand(10,50), TRUE)
	qdel(src)

// Wendigo skull

/obj/item/wendigo_skull
	name = "wendigo skull"
	desc = "Um crânio ensanguentado arrancado de uma besta assassina, as órbitas oculares sem alma parecem seguir constantemente seu movimento."
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "wendigo_skull"
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
