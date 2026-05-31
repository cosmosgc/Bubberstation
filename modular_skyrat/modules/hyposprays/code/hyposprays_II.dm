#define HYPO_INJECT 1
#define HYPO_SPRAY 0

#define WAIT_INJECT 2 SECONDS
#define WAIT_SPRAY 1.5 SECONDS
#define SELF_INJECT 1.5 SECONDS
#define SELF_SPRAY 1.5 SECONDS

#define DELUXE_WAIT_INJECT 0.5 SECONDS
#define DELUXE_WAIT_SPRAY 0
#define DELUXE_SELF_INJECT 1 SECONDS
#define DELUXE_SELF_SPRAY 1 SECONDS

#define COMBAT_WAIT_INJECT 0
#define COMBAT_WAIT_SPRAY 0
#define COMBAT_SELF_INJECT 0
#define COMBAT_SELF_SPRAY 0

/obj/item/hypospray/mkii
	name = "hypospray Mk.II"
	icon = 'modular_skyrat/modules/hyposprays/icons/hypokits.dmi'
	icon_state = "hypo2"
	greyscale_config = /datum/greyscale_config/hypospray_mkii
	desc = "Um novo desenvolvimento da DeForest Medical, esse hipospray leva frascos de 50 unidades como fonte de drogas para troca fácil."
	w_class = WEIGHT_CLASS_TINY
	var/list/allowed_containers = list(/obj/item/reagent_containers/cup/vial/small)
	/// Is the hypospray only able to use small vials. Relates to the loaded overlays
	var/small_only = TRUE
	/// The presently-inserted vial.
	var/obj/item/reagent_containers/cup/vial/vial
	/// If the Hypospray starts with a vial, which vial does it start with?
	var/obj/item/reagent_containers/cup/vial/start_vial

	/// Time taken to inject others
	var/inject_wait = WAIT_INJECT
	/// Time taken to spray others
	var/spray_wait = WAIT_SPRAY
	/// Time taken to inject self
	var/inject_self = SELF_INJECT
	/// Time taken to spray self
	var/spray_self = SELF_SPRAY

	/// Can you hotswap vials? - now all hyposprays can!
	var/quickload = TRUE
	/// Does it penetrate clothing?
	var/penetrates = null
	/// Used for GAGS-ified hypos.
	var/gags_bodystate = "hypo2_normal"
	/// The original icon file where our overlays reside.
	var/original_icon = 'modular_skyrat/modules/hyposprays/icons/hypokits.dmi'

/obj/item/hypospray/mkii/combat
	name = "hypospray Mk.II combat"
	allowed_containers = list(/obj/item/reagent_containers/cup/vial/small)
	icon_state = "combathypo2"
	gags_bodystate = "hypo2_combat"
	desc = "A variante de combate da série DeForest Hypospray Mk. II, capaz de perfurar a armadura grossa e rapidamente auto-injetar o usuário em cenários de combate."
	inject_wait = WAIT_INJECT
	spray_wait = WAIT_SPRAY
	spray_self = COMBAT_SELF_SPRAY
	inject_self = COMBAT_SELF_INJECT
	penetrates = INJECT_CHECK_PENETRATE_THICK

/obj/item/hypospray/mkii/piercing
	name = "hypospray Mk.II advanced"
	allowed_containers = list(/obj/item/reagent_containers/cup/vial/small)
	icon_state = "piercinghypo2"
	gags_bodystate = "hypo2_piercing"
	desc = "A variante avançada da série DeForest Hypospray Mk. II, capaz de perfurar a armadura grossa e rapidamente pulverizar ou injetar os químicos."
	spray_self = DELUXE_SELF_INJECT
	inject_self = DELUXE_SELF_SPRAY
	penetrates = INJECT_CHECK_PENETRATE_THICK

// Deluxe hypo upgrade Kit
/obj/item/device/custom_kit/deluxe_hypo2
	name = "hypospray Mk. II deluxe bodykit"
	desc = "Atualiza o DeForest Hypospray Mk. II para suportar frascos maiores."
	// don't tinker with a loaded (medi)gun. fool
	from_obj = /obj/item/hypospray/mkii
	to_obj = /obj/item/hypospray/mkii/deluxe

/obj/item/device/custom_kit/deluxe_hypo2/pre_convert_check(obj/target_obj, mob/user)
	var/obj/item/hypospray/mkii/our_hypo = target_obj
	if(our_hypo.type in subtypesof(/obj/item/hypospray/mkii/))
		balloon_alert(user, "Só funciona com MK básico. Eu hipos!")
		return FALSE
	if(our_hypo.vial != null)
		balloon_alert(user, "Descarregue o frasco primeiro!")
		return FALSE
	return TRUE

/obj/item/hypospray/mkii/deluxe
	name = "hypospray Mk.II deluxe"
	icon_state = "bighypo2"
	gags_bodystate = "hypo2_deluxe"
	desc = "A variante de luxo do Hypospray Mk. II, capaz de pegar frascos de 100u e 50u."
	allowed_containers = list(/obj/item/reagent_containers/cup/vial/small, /obj/item/reagent_containers/cup/vial/large)

/obj/item/hypospray/mkii/deluxe/cmo
	name = "hypospray Mk.II deluxe: CMO edition"
	icon_state = "cmo2"
	gags_bodystate = "hypo2_cmo"
	desc = "O prêmio da CMO Hypospray Mk. II Deluxe, capaz de pegar frascos de 100u e 50u, agindo mais rápido e capaz de fornecer mais reagentes por spray."
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	inject_wait = DELUXE_WAIT_INJECT
	spray_wait = DELUXE_WAIT_SPRAY
	spray_self = DELUXE_SELF_SPRAY
	inject_self = DELUXE_SELF_INJECT
	penetrates = INJECT_CHECK_PENETRATE_THICK

/obj/item/hypospray/mkii/deluxe/combat
	name = "hypospray Mk.II deluxe: combat edition"
	icon_state = "combat2"
	gags_bodystate = "hypo2_tactical"
	desc = "Uma variante do Hypospray Mk. II Deluxe, capaz de pegar frascos de 100u e 50u, com aplicadores sobrecarregados e uma ponta perfurante."
	// Made non-indestructible since this is typically an admin spawn.  still robust though!
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	inject_wait = COMBAT_WAIT_INJECT
	spray_wait = COMBAT_WAIT_SPRAY
	spray_self = COMBAT_SELF_INJECT
	inject_self = COMBAT_SELF_SPRAY
	penetrates = INJECT_CHECK_PENETRATE_THICK

/obj/item/hypospray/mkii/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	if(!isnull(start_vial))
		var/init_vial = new start_vial()
		vial = init_vial
		start_vial = null
		update_appearance()

/obj/item/hypospray/mkii/update_overlays()
	. = ..()
	if(!vial)
		return
	if(vial.reagents.total_volume)
		var/vial_spritetype = "chem-color"
		if(istype(vial, /obj/item/reagent_containers/cup/vial/large))
			vial_spritetype += "[vial.type_suffix]"
		else
			vial_spritetype += "-s"
		var/mutable_appearance/chem_loaded = mutable_appearance(original_icon, vial_spritetype)
		chem_loaded.color = vial.chem_color
		. += chem_loaded
	if(vial.greyscale_colors != null)
		var/mutable_appearance/vial_overlay = mutable_appearance(original_icon, "[vial.icon_state]-body")
		vial_overlay.color = vial.greyscale_colors
		. += vial_overlay
		var/mutable_appearance/vial_overlay_glass = mutable_appearance(original_icon, "[vial.icon_state]-glass")
		. += vial_overlay_glass
	else
		var/mutable_appearance/vial_overlay = mutable_appearance(original_icon, vial.icon_state)
		. += vial_overlay

/obj/item/hypospray/mkii/examine(mob/user)
	. = ..()
	if(vial)
		. += "[vial] has [vial.reagents.total_volume]u remaining."
	else
		. += "It has no vial loaded in."
	. += span_notice("Ctrl-Shift-Clique para mudar as cores ou redefini-las.")

/obj/item/hypospray/mkii/click_ctrl_shift(mob/user)
	var/choice = tgui_input_list(user, "GAGSify the hypo or reset to default?", "Fashion", list("GAGS", "Nope"))
	if(choice == "GAGS")
		icon_state = gags_bodystate
		//choices go here
		var/atom/fake_atom = src
		var/list/allowed_configs = list()
		var/config = initial(fake_atom.greyscale_config)
		allowed_configs += "[config]"
		if(greyscale_colors == null)
			greyscale_colors = "#00AAFF#FFAA00"

		var/datum/greyscale_modify_menu/menu = new(src, usr, allowed_configs)
		menu.ui_interact(usr)
	else
		icon_state = initial(icon_state)
		icon = original_icon
		greyscale_colors = null

/obj/item/hypospray/mkii/proc/unload_hypo(obj/item/hypo, mob/user)
	if((istype(hypo, /obj/item/reagent_containers/cup/vial)))
		var/obj/item/reagent_containers/cup/vial/container = hypo
		container.forceMove(user.loc)
		user.put_in_hands(container)
		to_chat(user, span_notice("Você tira.[vial]De[src]."))
		vial = null
		update_icon()
		playsound(loc, 'sound/items/weapons/empty.ogg', 50, 1)
	else
		to_chat(user, span_notice("A hipoglicemia não está carregada!"))
		return

/obj/item/hypospray/mkii/proc/insert_vial(obj/item/new_vial, mob/living/user)
	if(!is_type_in_list(new_vial, allowed_containers))
		to_chat(user, span_notice("[src]Não aceita esse tipo de frasco."))
		return FALSE
	var/atom/quickswap_loc = new_vial.loc
	if(!user.transferItemToLoc(new_vial, src))
		return FALSE
	if(!isnull(vial))
		if(quickswap_loc == user)
			user.put_in_hands(vial)
		else
			vial.forceMove(quickswap_loc)
	vial = new_vial
	user.visible_message(span_notice("[user]colocou um frasco em[src]."), span_notice("Você carregou.[vial]em[src]."))
	playsound(loc, 'sound/items/weapons/autoguninsert.ogg', 35, 1)
	update_appearance()

/obj/item/hypospray/mkii/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/reagent_containers/cup/vial))
		return NONE
	if(isnull(vial) || quickload)
		insert_vial(tool, user)
		return ITEM_INTERACT_SUCCESS
	to_chat(user, span_warning("[src]Não pode segurar mais de um frasco!"))
	return ITEM_INTERACT_BLOCKING

/obj/item/hypospray/mkii/attack_self(mob/user)
	. = ..()
	if(vial)
		vial.attack_self(user)
		return TRUE

/obj/item/hypospray/mkii/attack_self_secondary(mob/user)
	. = ..()
	if(vial)
		vial.attack_self_secondary(user)
		return TRUE

/obj/item/hypospray/mkii/emag_act(mob/user)
	. = ..()
	if(obj_flags & EMAGGED)
		to_chat(user, "[src]Acontece que já está sobrecarregado.")
		return FALSE
	//all these are 0
	inject_wait = COMBAT_WAIT_INJECT
	spray_wait = COMBAT_WAIT_SPRAY
	spray_self = COMBAT_SELF_INJECT
	inject_self = COMBAT_SELF_SPRAY
	penetrates = INJECT_CHECK_PENETRATE_THICK
	to_chat(user, "Você cobra demais.[src]O circuito de controle.")
	obj_flags |= EMAGGED
	return TRUE

/obj/item/hypospray/mkii/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(istype(interacting_with, /obj/item/reagent_containers/cup/vial))
		insert_vial(interacting_with, user)
		return ITEM_INTERACT_SUCCESS
	return do_inject(interacting_with, user, mode=HYPO_SPRAY)

/obj/item/hypospray/mkii/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	return do_inject(interacting_with, user, mode=HYPO_INJECT)

/obj/item/hypospray/mkii/proc/do_inject(mob/living/injectee, mob/living/user, mode)
	if(!isliving(injectee))
		return NONE

	if(!injectee.reagents || !injectee.can_inject(user, user.zone_selected, penetrates))
		return NONE

	if(iscarbon(injectee))
		var/obj/item/bodypart/affecting = injectee.get_bodypart(check_zone(user.zone_selected))
		if(!affecting)
			to_chat(user, span_warning("O membro está faltando!"))
			return ITEM_INTERACT_BLOCKING
	//Always log attemped injections for admins
	var/contained = vial.reagents.get_reagent_log_string()
	log_combat(user, injectee, "attemped to inject", src, addition="which had [contained]")

	if(!vial)
		to_chat(user, span_notice("[src]Não tem nenhum frasco instalado!"))
		return ITEM_INTERACT_BLOCKING
	if(!vial.reagents.total_volume)
		to_chat(user, span_notice("[src]O frasco está vazio!"))
		return ITEM_INTERACT_BLOCKING

	var/fp_verb = mode == HYPO_SPRAY ? "spray" : "inject"

	if(injectee != user)
		injectee.visible_message(span_danger("[user]está tentando[fp_verb] [injectee]com[src]!"), 						span_userdanger("[user]está tentando[fp_verb]Você com[src]!"))

	var/selected_wait_time
	if(injectee == user)
		selected_wait_time = (mode == HYPO_INJECT) ? inject_self : spray_self
	else
		selected_wait_time = (mode == HYPO_INJECT) ? inject_wait : spray_wait

	if(!do_after(user, selected_wait_time, injectee, extra_checks = CALLBACK(injectee, /mob/living/proc/can_inject, user, user.zone_selected, penetrates)))
		return ITEM_INTERACT_BLOCKING
	if(!vial || !vial.reagents.total_volume)
		return ITEM_INTERACT_BLOCKING
	log_attack("<font color='red'>[user.name] ([user.ckey]) applied [src] to [injectee.name] ([injectee.ckey]), which had [contained] (COMBAT MODE: [uppertext(user.combat_mode)]) (MODE: [mode])</font>")
	if(injectee != user)
		injectee.visible_message(span_danger("[user]usa o[src]Vamos.[injectee]!"), 						span_userdanger("[user]usa o[src]Em você!"))
	else
		injectee.log_message("<font color='orange'>applied [src] to themselves ([contained]).</font>", LOG_ATTACK)

	switch(mode)
		if(HYPO_INJECT)
			vial.reagents.trans_to(injectee, vial.amount_per_transfer_from_this, methods = INJECT)
		if(HYPO_SPRAY)
			vial.reagents.trans_to(injectee, vial.amount_per_transfer_from_this, methods = PATCH)

	var/long_sound = vial.amount_per_transfer_from_this >= 15
	playsound(loc, long_sound ? 'modular_skyrat/modules/hyposprays/sound/hypospray_long.ogg' : pick('modular_skyrat/modules/hyposprays/sound/hypospray.ogg','modular_skyrat/modules/hyposprays/sound/hypospray2.ogg'), 50, 1, -1)
	to_chat(user, span_notice("Você.[fp_verb] [vial.amount_per_transfer_from_this]Unidades da solução. O cartucho do hipospray agora contém[vial.reagents.total_volume]Unidades."))
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/item/hypospray/mkii/attack_hand(mob/living/user)
	if(user && loc == user && user.is_holding(src))
		if(user.incapacitated)
			return
		else if(!vial)
			. = ..()
			return
		else
			unload_hypo(vial,user)
	else
		. = ..()

/obj/item/hypospray/mkii/examine(mob/user)
	. = ..()
	. += span_notice("<b>Clique à esquerda.</b>em pacientes para pulverizar,<b>Click direito</b>para injetar.")

#undef HYPO_INJECT
#undef HYPO_SPRAY
#undef WAIT_INJECT
#undef WAIT_SPRAY
#undef SELF_INJECT
#undef SELF_SPRAY
#undef DELUXE_WAIT_INJECT
#undef DELUXE_WAIT_SPRAY
#undef DELUXE_SELF_INJECT
#undef DELUXE_SELF_SPRAY
#undef COMBAT_WAIT_INJECT
#undef COMBAT_WAIT_SPRAY
#undef COMBAT_SELF_INJECT
#undef COMBAT_SELF_SPRAY
