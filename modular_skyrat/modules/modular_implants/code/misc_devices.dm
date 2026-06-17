///NIFSoft Remover. This is mostly here so that security and antags have a way to remove NIFSofts from someome
/obj/item/nifsoft_remover
	name = "Lopland 'Wrangler' NIF-Cutter"
	desc = "Um pequeno dispositivo que permite ao usuário remover NIFSofts de um usuário NIF"
	special_desc = "Dada a relativamente recente e súbita proliferação de NIFs, seu uso no crime tanto mesquinho quanto organizado disparou nos últimos anos.\
A existência de comunicações de explosão em tempo real baseadas em nanomáquinas que não podem ser monitoradas ou hackeadas efetivamente deu à maioria dos PMCs causa bastante preocupação\
para inventar seus próprios dispositivos. Este é um modelo \"Wrangler\" NIF-Cutter, usado para limpar programas diretamente do Framework de um usuário."
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/devices.dmi'
	icon_state = "nifsoft_remover"

	///Is a disk with the corresponding NIFSoft created when said NIFSoft is removed?
	var/create_disk = FALSE

/obj/item/nifsoft_remover/attack(mob/living/carbon/human/target_mob, mob/living/user)
	. = ..()
	var/obj/item/organ/cyberimp/brain/nif/target_nif = target_mob.get_organ_by_type(/obj/item/organ/cyberimp/brain/nif)

	if(!target_nif || !length(target_nif.loaded_nifsofts))
		balloon_alert(user, "[target_mob] has no NIFSofts!")
		return

	var/list/installed_nifsofts = target_nif.loaded_nifsofts
	var/datum/nifsoft/nifsoft_to_remove = tgui_input_list(user, "Chose a NIFSoft to remove.", "[src]", installed_nifsofts)

	if(!nifsoft_to_remove)
		return FALSE

	user.visible_message(span_warning("[user] starts to use [src] on [target_mob]"), span_notice("You start to use [src] on [target_mob]"))
	if(!do_after(user, 5 SECONDS, target_mob))
		balloon_alert(user, "Remoção cancelada!")
		return FALSE

	if(!target_nif.remove_nifsoft(nifsoft_to_remove))
		balloon_alert(user, "A remoção falhou!")
		return FALSE

	to_chat(user, span_notice("You successfully remove [nifsoft_to_remove]."))
	user.log_message("removed [nifsoft_to_remove] from [target_mob]" ,LOG_GAME)

	if(create_disk)
		var/obj/item/disk/nifsoft_uploader/new_disk = new
		new_disk.loaded_nifsoft = nifsoft_to_remove.type
		new_disk.name = "[nifsoft_to_remove] datadisk"

		user.put_in_hands(new_disk)

	qdel(nifsoft_to_remove)

	return TRUE

/obj/item/nifsoft_remover/syndie
	name = "Cybersun 'Scalpel' NIF-Cutter"
	desc = "Uma versão modificada de um removedor NIFSoft que permite ao usuário remover um NIFSoft e ter uma cópia em branco do NIFSoft removido salvo em um disco."
	special_desc = "Nos escalões superiores do mundo corporativo, Nanite Implant Frameworks estão em toda parte. Alvos valiosos quase sempre estarão em constante comunicação NIF com pelo menos um ou dois pontos de contato em caso de emergência. Para contornar este dilema infeliz, as Indústrias Cybersun inventaram o NIF-Cutter. Um dispositivo não maior que um PDA, este presente para o campo de roubo neurológico é capaz de extrair programas específicos de um alvo em cinco segundos ou menos. Além disso, a programação de alta qualidade permite que a ferramenta copie o 'soft' específico para um disco para uso próprio do empunhador."
	icon_state = "nifsoft_remover_syndie"
	create_disk = TRUE

///NIF Repair Kit.
/obj/item/nif_repair_kit
	name = "Cerulean NIF Regenerator"
	desc = "Um kit de reparo que permite que NIFs sejam reparados sem o uso de cirurgia."
	special_desc = "Os efeitos do capitalismo e da indústria são profundos, e eles funcionam dentro da indústria Nanite Implant Framework também.\
Frameworks, dispositivos complicados como eles são, normalmente estão bloqueados no nível de firmware para exigir marcas específicas 'aprovadas' de pasta de reparo ou docas de reparo.\
Este kit hackeado foi desenvolvido pelo Coven Altspace como uma alternativa de freeware, espalhado por todo o espaço extra-terreno para a qualidade de vida.\
para usuários localizados nas periferias da sociedade."
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/devices.dmi'
	icon_state = "repair_paste"
	w_class = WEIGHT_CLASS_SMALL
	///How much does this repair each time it is used?
	var/repair_amount = 20
	///How many times can this be used?
	var/uses = 5

/obj/item/nif_repair_kit/attack(mob/living/carbon/human/mob_to_repair, mob/living/user)
	. = ..()

	var/obj/item/organ/cyberimp/brain/nif/installed_nif = mob_to_repair.get_organ_by_type(/obj/item/organ/cyberimp/brain/nif)
	if(!installed_nif)
		balloon_alert(user, "[mob_to_repair] lacks a NIF")

	if(!do_after(user, 5 SECONDS, mob_to_repair))
		balloon_alert(user, "reparação cancelada")
		return FALSE

	if(!installed_nif.adjust_durability(repair_amount))
		balloon_alert(user, "O alvo NIF está em máxima duarbilidade.")
		return FALSE

	to_chat(user, span_notice("You successfully repair [mob_to_repair]'s NIF"))
	to_chat(mob_to_repair, span_notice("[user] successfully repairs your NIF"))

	uses -= 1
	if(!uses)
		qdel(src)

/obj/item/nif_hud_adapter
	name = "Scrying Lens Adapter"
	desc = "Um kit que modifica óculos selecionados para exibir HUDs para NIFs"
	icon = 'modular_skyrat/master_files/icons/donator/obj/kits.dmi'
	icon_state = "partskit"

	/// Can this item be used multiple times? If not, it will delete itself after being used.
	var/multiple_uses = FALSE
	/// List containing all of the glasses that we want to work with this.
	var/static/list/glasses_whitelist = list(
		/obj/item/clothing/glasses/trickblindfold,
		/obj/item/clothing/glasses/monocle,
		/obj/item/clothing/glasses/fake_sunglasses,
		/obj/item/clothing/glasses/regular,
		/obj/item/clothing/glasses/eyepatch,
		/obj/item/clothing/glasses/osi,
		/obj/item/clothing/glasses/phantom,
		/obj/item/clothing/glasses/salesman, // Now's your chance.
		/obj/item/clothing/glasses/nice_goggles,
		/obj/item/clothing/glasses/thin,
		/obj/item/clothing/glasses/biker,
		/obj/item/clothing/glasses/sunglasses/gar,
		/obj/item/clothing/glasses/hypno,
		/obj/item/clothing/glasses/heat,
		/obj/item/clothing/glasses/cold,
		/obj/item/clothing/glasses/orange,
		/obj/item/clothing/glasses/red,
		/obj/item/clothing/glasses/psych,
	)

/obj/item/nif_hud_adapter/examine(mob/user)
	. = ..()
	var/list/compatible_glasses_names = list()
	for(var/obj/item/glasses_type as anything in glasses_whitelist)
		var/glasses_name = initial(glasses_type.name)
		if(!glasses_name)
			continue

		compatible_glasses_names += glasses_name

	if(length(compatible_glasses_names))
		. += span_cyan("\n This item will work on the following glasses: [english_list(compatible_glasses_names)].")

	return .

/obj/item/nif_hud_adapter/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/obj/item/clothing/glasses/target_glasses = interacting_with
	if(!istype(target_glasses) || !is_type_in_list(target_glasses, glasses_whitelist))
		balloon_alert(user, "incompatível!")
		return NONE

	if(HAS_TRAIT(target_glasses, TRAIT_NIFSOFT_HUD_GRANTER))
		balloon_alert(user, "Já está atualizado!")
		return ITEM_INTERACT_BLOCKING

	user.visible_message(span_notice("[user] upgrades [target_glasses] with [src]."), span_notice("You upgrade [target_glasses] to be NIF HUD compatible."))
	target_glasses.name = "\improper HUD-upgraded " + target_glasses.name
	target_glasses.AddElement(/datum/element/nifsoft_hud)
	playsound(target_glasses.loc, 'sound/items/weapons/circsawhit.ogg', 50, vary = TRUE)

	if(!multiple_uses)
		qdel(src)
	return ITEM_INTERACT_SUCCESS

