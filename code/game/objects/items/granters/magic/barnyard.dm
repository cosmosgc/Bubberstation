/obj/item/book/granter/action/spell/barnyard
	granted_action = /datum/action/cooldown/spell/pointed/barnyardcurse
	action_name = "barnyard"
	icon_state ="bookhorses"
	desc = "Este livro é mais cavalo do que sua mente tem espaço."
	remarks = list(
		"Moooooooo!",
		"Moo!",
		"Moooo!",
		"NEEIIGGGHHHH!",
		"NEEEIIIIGHH!",
		"NEIIIGGHH!",
		"HAAWWWWW!",
		"HAAAWWW!",
		"Oink!",
		"Squeeeeeeee!",
		"Oink Oink!",
		"Ree!!",
		"Reee!!",
		"REEE!!",
		"REEEEE!!",
	)

/obj/item/book/granter/action/spell/barnyard/recoil(mob/living/user)
	if(ishuman(user))
		to_chat(user, "<font size='15' color='red'><b>Horsie tem Risen</b></font>")
		var/obj/item/clothing/magic_mask = new /obj/item/clothing/mask/animal/horsehead/cursed(user.drop_location())
		var/mob/living/carbon/human/human_user = user
		if(!user.dropItemToGround(human_user.wear_mask))
			qdel(human_user.wear_mask)
		user.equip_to_slot_if_possible(magic_mask, ITEM_SLOT_MASK, TRUE, TRUE)
		qdel(src)
	else
		to_chat(user,span_notice("Eu digo que você relingh")) //It still lives here
