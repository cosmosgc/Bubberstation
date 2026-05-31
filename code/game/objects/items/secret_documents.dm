/**
 * # secret documents
 *
 * Indestructible antag objective that can be photocopied.
 *
 * Photocopying this is handled in photocopier.dm.
 * Cannot be destroyed, but can be spaced.
 * Save for the inhand, this does not actually have anything in common with /obj/item/paper.
*/
/obj/item/documents
	name = "secret documents"
	desc = "\"Top Secret\"Documentos."
	icon = 'icons/obj/service/bureaucracy.dmi'
	icon_state = "docs_generic"
	inhand_icon_state = "paper"
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_range = 1
	throw_speed = 1
	layer = MOB_LAYER
	pressure_resistance = 2
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

///Nanotrasen documents
/obj/item/documents/nanotrasen
	desc = "\"Top Secret\"Documentos de Nanotrasen, cheios de diagramas complexos e listas de nomes, datas e coordenadas."
	icon_state = "docs_verified"

///Syndicate documents
/obj/item/documents/syndicate
	desc = "\"Top Secret\"Documentos detalhando informações operacionais confidenciais do Sindicato."

///Syndicate documents with a red seal
/obj/item/documents/syndicate/red
	name = "red secret documents"
	desc = "\"Top Secret\"Documentos detalhando informações operacionais confidenciais do Sindicato. Estes documentos são verificados com um selo de cera vermelha."
	icon_state = "docs_red"

///Syndicate documents with a blue seal
/obj/item/documents/syndicate/blue
	name = "blue secret documents"
	desc = "\"Top Secret\"Documentos detalhando informações operacionais confidenciais do Sindicato. Esses documentos são verificados com um selo de cera azul."
	icon_state = "docs_blue"

///Syndicate mining documents
/obj/item/documents/syndicate/mining
	desc = "\"Top Secret\"Documentos detalhando operações de mineração de plasma."

/**
 * # secret documents (photocopy)
 *
 * Outcome of photocopying documents. Can be copied, and can have a blue/red seal forged.
*/
/obj/item/documents/photocopy
	desc = "Uma cópia de alguns documentos secretos. Ninguém vai notar que não são os originais, certo?"
	///What seal was forged on the documents (color name string)
	var/forgedseal = 0
	///What was copied
	var/copy_type = null

/obj/item/documents/photocopy/Initialize(mapload, obj/item/documents/copy=null)
	. = ..()
	if(copy)
		copy_type = copy.type
		if(istype(copy, /obj/item/documents/photocopy)) // Copy Of A Copy Of A Copy
			var/obj/item/documents/photocopy/C = copy
			copy_type = C.copy_type

/obj/item/documents/photocopy/attackby(obj/item/O, mob/user, list/modifiers, list/attack_modifiers)
	if(istype(O, /obj/item/toy/crayon/red) || istype(O, /obj/item/toy/crayon/blue))
		if (forgedseal)
			to_chat(user, span_warning("Você já forjou um selo.[src]!"))
		else
			var/obj/item/toy/crayon/C = O
			name = "[C.crayon_color] secret documents"
			icon_state = "docs_[C.crayon_color]"
			forgedseal = C.crayon_color
			to_chat(user, span_notice("Você forja o selo oficial com um[C.crayon_color]Lâmina de cera. Ninguém vai notar... certo?"))
			update_appearance()
