/obj/item/autosurgeon/bodypart
	name = "bodypart upgrade autosurgeon"
	desc = "Um dispositivo que substituirá sua parte corporal."

	var/bodypart_type = /obj/item/bodypart

	var/starting_bodypart //The bodypart we come with

	var/obj/item/bodypart/storedbodypart

/obj/item/autosurgeon/bodypart/Initialize(mapload)
	. = ..()
	if(starting_bodypart)
		insert_bodypart(new starting_bodypart(src))

/obj/item/autosurgeon/bodypart/proc/insert_bodypart(obj/item/I)
	storedbodypart = I
	I.forceMove(src)
	name = "[initial(name)] ([storedbodypart.name])"

/obj/item/autosurgeon/bodypart/attack_self(mob/user)//when the object it used...
	if(!uses)
		to_chat(user, span_alert("[src]Já foi usado. As ferramentas são chatas e não vão reativar."))
		return
	if(!storedbodypart)
		to_chat(user, span_alert("[src]Atualmente não tem nenhum implante armazenado."))
		return
	if(!ishuman(user))
		return

	var/mob/living/carbon/human/H = user

	var/obj/item/bodypart/oldBP = H.get_bodypart(storedbodypart.body_zone)

	if(oldBP)
		to_chat(H, span_warning("O[src]remove o seu[oldBP.name]!"))
		oldBP.dismember()

	user.visible_message(span_notice("[H]Aperte um botão.[src]E você ouve um pequeno ruído mecânico."), span_notice("Você sente uma picada afiada como[src]Mergulha em seu corpo."))

	if(!storedbodypart.try_attach_limb(H))
		to_chat(H, span_warning("O[src]falha em anexar[storedbodypart]!"))
		return

	playsound(get_turf(H), 'sound/items/weapons/circsawhit.ogg', 50, TRUE)
	storedbodypart = null
	name = initial(name)
	uses--
	if(!uses)
		desc = "[initial(desc)]Parece que foi usado."

/obj/item/autosurgeon/bodypart/attackby(obj/item/I, mob/user, params)
	if(istype(I, bodypart_type))
		if(storedbodypart)
			to_chat(user, span_alert("[src]Já tem um implante armazenado."))
			return
		else if(!uses)
			to_chat(user, span_alert("[src]Já foi usado."))
			return
		if(!user.transferItemToLoc(I, src))
			return
		storedbodypart = I
		to_chat(user, span_notice("Você insere o[I]em[src]."))
	else
		return ..()

/obj/item/autosurgeon/bodypart/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	if(!storedbodypart)
		to_chat(user, span_warning("Não há implante em[src]Para você se retirar!"))
	else
		var/atom/drop_loc = user.drop_location()
		for(var/J in src)
			var/atom/movable/AM = J
			AM.forceMove(drop_loc)

		to_chat(user, span_notice("Você remove o[storedbodypart]De[src]."))
		I.play_tool_sound(src)
		storedbodypart = null
		uses--
		if(!uses)
			desc = "[initial(desc)]Parece que foi usado."
	return TRUE
