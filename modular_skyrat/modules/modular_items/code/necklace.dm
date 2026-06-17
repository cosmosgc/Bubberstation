//DEFAULT NECK ITEMS OVERRIDE//
/obj/item/clothing/neck
	w_class = WEIGHT_CLASS_SMALL

//ASHWALKER TRANSLATOR NECKLACE//
#define LANGUAGE_TRANSLATOR "translator"
/obj/item/clothing/neck/necklace/ashwalker
	name = "ashen necklace"
	desc = "Um colar feito de cinzas, conectado à necrópole através do núcleo de uma Legião. Isto imbui overwellers com uma compreensão não natural de Ashtongue, a língua nativa de Lavaland, enquanto usado."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "ashnecklace"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "ashnecklace"
	w_class = WEIGHT_CLASS_SMALL //allows this to fit inside of pockets.

/obj/item/clothing/neck/necklace/ashwalker/cursed
	name = "cursed ashen necklace"
	desc = "Um colar feito de cinzas, conectado à necrópole através do núcleo de uma Legião. Isto imbui overwellers com uma compreensão não natural de Ashtongue, a língua nativa de Lavaland, enquanto usado. Não pode ser removido!"

/obj/item/clothing/neck/necklace/ashwalker/cursed/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)

//uses code from the pirate hat.
/obj/item/clothing/neck/necklace/ashwalker/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	if(slot & ITEM_SLOT_NECK)
		user.grant_language(/datum/language/ashtongue/, source = LANGUAGE_TRANSLATOR)
		to_chat(user, span_boldnotice("Escorregando o colar, você sente a aberração insidiosa da necrópole entrar em seus ossos, e sua própria sombra. Você se encontra com um conhecimento antinatural de Ashtongue, mas os olhos do amuleto olham para você."))

/obj/item/clothing/neck/necklace/ashwalker/dropped(mob/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.get_item_by_slot(ITEM_SLOT_NECK) == src && !QDELETED(src)) //This can be called as a part of destroy
		user.remove_language(/datum/language/ashtongue/, source = LANGUAGE_TRANSLATOR)
		to_chat(user, span_boldnotice("Você sente a mente alienígena da Necrópole perder seu interesse em você enquanto você remove o colar. O olho fecha, e sua mente também, perdendo o controle de Ashtongue."))

//ASHWALKER TRANSLATOR NECKLACE END//

#undef LANGUAGE_TRANSLATOR
