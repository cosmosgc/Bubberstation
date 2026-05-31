/obj/item/reagent_containers/hash
	name = "hash"
	desc = "Extrato de cannabis concentrado. Dá uma dose muito melhor quando usado em um cachimbo."
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "hash"
	volume = 20
	has_variable_transfer_amount = FALSE
	list_reagents = list(/datum/reagent/drug/thc = 15, /datum/reagent/toxin/lipolicide = 5)

/obj/item/reagent_containers/hash/dabs
	name = "dab"
	desc = "Extrato de óleo de plantas de cannabis. Só entrega um tipo diferente de sucesso."
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "dab"
	volume = 40
	has_variable_transfer_amount = FALSE
	list_reagents = list(/datum/reagent/drug/thc/concentrated = 40) //horrendously powerful

/obj/item/reagent_containers/hashbrick
	name = "hash brick"
	desc = "Um tijolo de haxixe. Bom para o transporte!"
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "hashbrick"
	volume = 80
	has_variable_transfer_amount = FALSE
	list_reagents = list(/datum/reagent/drug/thc = 60, /datum/reagent/toxin/lipolicide = 20)


/obj/item/reagent_containers/hashbrick/attack_self(mob/user)
	user.visible_message(span_notice("[user]começa a quebrar o[src]."))
	if(do_after(user,10))
		to_chat(user, span_notice("Você termina de quebrar o[src]."))
		for(var/i = 1 to 4)
			new /obj/item/reagent_containers/hash(user.loc)
		qdel(src)

/datum/crafting_recipe/hashbrick
	name = "Hash brick"
	result = /obj/item/reagent_containers/hashbrick
	reqs = list(/obj/item/reagent_containers/hash = 4)
	parts = list(/obj/item/reagent_containers/hash = 4)
	time = 20
	category = CAT_CHEMISTRY

//export values
/datum/export/hash
	cost = CARGO_CRATE_VALUE * 0.35
	unit_name = "hash"
	export_types = list(/obj/item/reagent_containers/hash)
	include_subtypes = FALSE

/datum/export/crack/hashbrick
	cost = CARGO_CRATE_VALUE * 2
	unit_name = "Tijolo de haxixe"
	export_types = list(/obj/item/reagent_containers/hashbrick)
	include_subtypes = FALSE

/datum/export/dab
	cost = CARGO_CRATE_VALUE * 0.4
	unit_name = "dab"
	export_types = list(/obj/item/reagent_containers/hash/dabs)
	include_subtypes = FALSE
